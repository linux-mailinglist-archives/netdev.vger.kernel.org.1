Return-Path: <netdev+bounces-252890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC8DBjKqc2nOxwAAu9opvQ
	(envelope-from <netdev+bounces-252890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:04:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D54778C3D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27BBF301726F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C59274B23;
	Fri, 23 Jan 2026 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3dgXMv7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D28B2C15B0
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187868; cv=none; b=retG+lcuOA3OyBWV1MLVehFZ1K2MrYzdeQGX7LwDJZmO6/SBQ/g/QV9BNBlGjA3BL3/Fxz4rLeoEbwLQqBOvXQeZv9wVHthg04Au9/QuAznfJe1Xgq1Sx6pddVNFQCSiAtlvwgAk5++ZIqOU1FMaCVP5cloQ+Re7hWzpnfs9Klk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187868; c=relaxed/simple;
	bh=UfhKSDPfjpBklY1VmW6pD7RZp7on50tJar2pyItjx/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPGt9re7eRJHjVYG8DFCBthgo5O2pjZ/Vi11uKC4oXk4LZlquXbttc0cuS8zW2pwXyR3TuNhxM8vPjGSgu/VmpvDSpNsXc3e0yKcKcpcRN3X0dELD8EIjO7eXXLEZIHfD2DtM8KRVUSDRqMGrpOXhIKsoYWcw3SfETHI0kNJtOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3dgXMv7; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-385cfc572f1so21042921fa.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769187863; x=1769792663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fNtDYP15kC1FsZVrax4aaAdb4lBk2QYvOz6fPD9widw=;
        b=M3dgXMv7CTMTGn2PH+ENDhmcWtIrGZimY0NpuqHlqbpkD9tmE5n8o0fpGPgcncEugc
         J7xlhJGbyif/tW9hvi7P+Vyv0UwhGBlRmsBQ1paPVVUyvoEgsglNxRw9pbPg3o8FNqua
         dWqs78WFVjDdB9erNqDlug9W8vNoECyW5FeWLR+9gM0BzBic9VPQezcHv8k7bH5GnnOn
         ZajBtjJaC7jzzORXDe7cgrVvO1Dr52P6UWJq6LZUlFP2IRuUWKyOfzw6B/zo+yDsG8NP
         WEy5gkkL+Ye3psCGXA4BDRXdPXSVT9p57PLg+uNggtwF3qiw44dYiuSw9/bhQYdBG5ym
         jVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187863; x=1769792663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNtDYP15kC1FsZVrax4aaAdb4lBk2QYvOz6fPD9widw=;
        b=Oiz3lRBFj8zGojmk3HARmnDVS9/r1ejmDiq/kk0GxJ+PWGv8sfdl/x7zAXGF5PkDFz
         qk28UEYuejFr646jxGQznm7dZU4Fk2qy4+IFajdBYxP6pMPlASYvVZAr4oLTWTYZDQXV
         CxDtZiVe9VIjgMQ5KSZHkVbFAjsxvsgw6Lx2ZcMx/EB1oofyzjdom9HppRi4ofkdtSYp
         segYeVctw/XR2hywC5jZSpThT15dGXeOaynz2Jl9OFV3TKzBswglZLSs3UFuBlMKIO7R
         D6ODjG9fua6QTJvgRQnZFeMGhkJZi9rTtPtLJph937UCWPmOguQddVv+VA3b/FnGPOVR
         PLEg==
X-Gm-Message-State: AOJu0YzimVa53m8VMGIyTcuNOlm8DWA7sR9NZypq+N4EZHWfjpaukyG8
	etCrtOHUx622Wi1dJNZJwcy9FmXoDwc5M3JAIdLDhfbztbCUgcXCd0OQZZ8G/U6mpAM=
X-Gm-Gg: AZuq6aJX6xC8IrLRJvYRIWPYuxx71taqOosvekBEDnqf7L6622Cf2+L4830upGxMoM7
	ojYnBRlLu9GUX0CkbuPowb42N21gh6tIiT2xqVVHQ6/j5N2mhWslN9AicR6xU10j0OmKksbnJLi
	Xtq+B8T5z8SMT9Bx6mK4rQdmm3y3GrAtVhPM2KcLdCsPtnTGAYXPaMwk0RrI7YDRl+1iBtpUbvs
	+hY2IAfVVnm2mKWp0eCm2YRs+uQSYiZlScjURrSVk9zZ9W7f+2Vipr3GxQxjp6Fh1Tsbt47Bpf8
	/hIONrZj7MTkReXJktpybNZ/5KRN0S4LDxnf3dqDMmcq0SG6ewYda6vgjrTHn2JRP9nP6rI4xvE
	+3buZEkki1YzqIqX8T2dwc9T0Umoa/pUyjwL0NyA8kH/5GzQWjmQQ2Ym+adb/25sAqMlpT3NJ0Q
	O/pAZB+xsY0XY6NQ9r1+lX56mTgCOYvJUScJJaoZGSRc8gCMXbpq2XsUw1
X-Received: by 2002:a05:6512:3e0b:b0:59d:d799:b7a0 with SMTP id 2adb3069b0e04-59de4a23d68mr1186940e87.36.1769187863217;
        Fri, 23 Jan 2026 09:04:23 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.23])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48e5fd3sm801772e87.33.2026.01.23.09.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:04:22 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org
Cc: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Subject: [PATCH v2 net-next 0/3] ipvlan: Deduplicate ipv4/ipv6 addr_validator_event code
Date: Fri, 23 Jan 2026 20:03:53 +0300
Message-ID: <20260123170412.906280-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252890-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dskr99@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D54778C3D
X-Rspamd-Action: no action

This is a bit stylish patches: The code to handle ipv4 and ipv6
address change are exactly the same. We don't need separate
functions for them. Just look whether we are called
with ipvlan_addr4_notifier_block or with ipvlan_addr6_notifier_block

The changed functionality is already covered
with existing selftests/net/ipvtap_test.sh

v2:
- Fixed warning about unused vars by specifying __maybe_unused
  for ipv6-related notifier_blocks

Dmitry Skorodumov (3):
  ipvlan: const-specifier for functions that use iaddr
  ipvlan: Common code from v6/v4 validator_event
  ipvlan: common code to handle ipv6/ipv4 address events

 drivers/net/ipvlan/ipvlan.h      |   2 +-
 drivers/net/ipvlan/ipvlan_core.c |   2 +-
 drivers/net/ipvlan/ipvlan_main.c | 188 +++++++++++++------------------
 3 files changed, 83 insertions(+), 109 deletions(-)

-- 
2.43.0


