Return-Path: <netdev+bounces-251537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFuTN56yb2nHMAAAu9opvQ
	(envelope-from <netdev+bounces-251537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:51:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B8A47FB5
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E34F284BE4D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ADA410D3B;
	Tue, 20 Jan 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfLD+gN2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F696324B1D
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925946; cv=none; b=qYegIDfQoiWjJocn/pFpBHCtno1e8tnLxvEfq+6DRw9BllHrVByxBHCFZRvLgSsWSHarMi08G/hCOCFAgsV62ucQ6Lwt8V2TBuspcHvMeoxw3QpTvyuFB7RpjQHI55+JnnbGtcUSujWZBz39APuzShCpgvZ+cVJ/nxTdvlk21m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925946; c=relaxed/simple;
	bh=i3AS3XFt/Sr4J1+lIdtOfvf95xuYKpL21JsZ5ylj76w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OEwkUtlrejePbTRaKA0BuUpwU7lZdTL4HKJtUv0/dI/BU67PYz0/8wvx4tmATo//RibWnvmLGxiHOwWNob4Zm8JMvVhJ2T3Wmjj6zr5lHF8c3Vt9Yj2Ac6eXag6gpRh+hnwdD5PcAUxW23o9s3gAXaVWIkoFhzc7GHsm67iuRNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfLD+gN2; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-382f9930e54so51272461fa.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768925943; x=1769530743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5yr5X0nrRei570DaZtZdU7iwu6O5gxcfI5XJskshP+M=;
        b=LfLD+gN2Pv4pze3+TqOVdQ4x3i05pFwp5BpbJFGAfK4eqRW/mEyj2LB7rZlyNdOE9K
         UmJucnZmgli/b4wipTAgVIcbU8gbG0S7ui6CaBpAG/A+BkUngp3VLLbBI9jQsyhwC+Yy
         EKAeFzySj698hWXSWo0YZQKEd2b45YyDomjE+91cu1owKL0x1F4kWRhpAbk6zTYSnM1M
         yGCBScNko7fV4VW2UJATYHGb/tTMjGHnPkyzLF9DUWQQUWGfT1YzHTD6TDmVIwbvtxEG
         hwAWrZz6nr06/yZtZIlMWZsA8yEXO6AcPklvEjGaYkgWmSm0JjhLKboXqtKTsLSBOXuq
         Huwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768925943; x=1769530743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yr5X0nrRei570DaZtZdU7iwu6O5gxcfI5XJskshP+M=;
        b=o0UBaqiQJIUF7nYsFQvTsUwuMYAT2yAuoXtmWyICNGT5R5/eBZ3e2GxxSfyt3iZWGe
         gE8aLGAXyTv7Y1TrJCedcoFsCOd9WAVTkFKBkn4goltpWgG9Gou1AYYwP0Vz+TUWp4Qp
         1ch8g0Nb7O1GbP46UmwElxLqKfYoOn1VMQ2TO41CJY5NHDmLDFCrSQfgCiQaKqtz+9dL
         0XwLeylodil2HzU0aiNU8W25Tn9s/cBM2xKKc13nMVLcy63mM7aiCXJvnCq5ruWJvZfp
         SWf+ODATj/llkiuNLJvGjM6IXseTPXVjt9E1JuK7S+99igNZcD71Kid519/LAram933R
         Pmsg==
X-Gm-Message-State: AOJu0YwHndwOf5rOziWMKiyiJsyLHd+tEN+6UCUYXxU88ivye+/HcoA9
	Hv2JhW8r0gF7Yxvyl61/8itv6j6FZEByC4SgLhsRiSA8l3TAfWuddTQmqFDFgmko
X-Gm-Gg: AZuq6aI2EwSfonZt12nl3MV36V7fXfTtu2/+02qFMLyLC/LNNTF3mmC0othomh484Dp
	J4vu4QsCjsfJnz2mR/Zc1Zr+kFsyszOyQ4r2h8gUMwEsuhZOO4Wh3ZBRbHJDuKD67iwWm0gug6r
	Jt4PrTYQDO13CT8ZHucFEU8vQiW4xkmh4ciLMK8VISAbsqjNsDnEbCr8KtUbkGZLc8lVM+bfOKr
	d+hzlE6KMfADq8s2pdxcNjqeO4gJH8n8AkRKS1a/Sm1nNaz+ubYQWUB+0nNZt0tjbiAjT3SmsrI
	m+0+a7dAha+eQ9ttVqBpNhv9rxiatYlv4brz8I0BkWzjhIDfeED0gFSHbRFPZ59kIb549vlAHk6
	RuwV+XgXjB673Qgia2wyxbNTEpyMlq1v763C+W17U1slyQwSGyxGZy58v7y1pqh1kssmWd+08VJ
	YJtnKJrZIfLfZOK/dS7p6ssW97GxDdhxDQC+JbiJA3kTV19w==
X-Received: by 2002:a2e:8507:0:b0:37f:d634:ba27 with SMTP id 38308e7fff4ca-3836efbe978mr49149291fa.9.1768925942690;
        Tue, 20 Jan 2026 08:19:02 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.23])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790d7sm40561531fa.24.2026.01.20.08.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:19:02 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org
Cc: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Subject: [PATCH net 0/3] ipvlan: Deduplicate ipv4/ipv6 addr_validator_event code
Date: Tue, 20 Jan 2026 19:18:33 +0300
Message-ID: <20260120161852.639238-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-251537-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dskr99@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,huawei.com:mid]
X-Rspamd-Queue-Id: 87B8A47FB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a bit stylish patches: The code to handle ipv4 and ipv6
address change are exactly the same. We don't need separate
functions for them. Just look whether we are called
with ipvlan_addr4_notifier_block or with ipvlan_addr6_notifier_block

The changed functionality is already covered
with existing selftests/net/ipvtap_test.sh

Dmitry Skorodumov (3):
  ipvlan: const-specifier for functions that use iaddr
  ipvlan: Common code from v6/v4 validator_event
  ipvlan: common code to handle ipv6/ipv4 address events

 drivers/net/ipvlan/ipvlan.h      |   2 +-
 drivers/net/ipvlan/ipvlan_core.c |   2 +-
 drivers/net/ipvlan/ipvlan_main.c | 182 +++++++++++++------------------
 3 files changed, 79 insertions(+), 107 deletions(-)

-- 
2.43.0


