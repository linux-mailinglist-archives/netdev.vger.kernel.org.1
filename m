Return-Path: <netdev+bounces-290901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLQ+A+SXEGpTaAYAu9opvQ
	(envelope-from <netdev+bounces-290901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:52:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6545B8941
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2500306AD32
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CC033ADA9;
	Fri, 22 May 2026 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd6PW8sm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D68026D4C3
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471732; cv=none; b=Q7K0bbtX9Vluej6onMLUuReCCXsTBoFQEqxglvYpF8YbWMJ+opqdpvTL6C8Kl8Kj3LygulPmodMvjIPV6eeC4W//1fyS3euulhE0WRA3ulMooNoMfnktCRNoLDqzb3491OAvZYRBuUXrdAETynbykFEnJYc1aYX1MH8ddGEbORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471732; c=relaxed/simple;
	bh=u6wtHNhFTRqLLr1t9S+Eiq5E9hnMWjG6K0GkuLdPLsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIQ4mx9Epk2iDzB7WvdUOgrL8NaDoIQmzqWXNHGAJgta9cclyHbMa651clY1TRMtihS2YucOUXNxyDvrITIHvdPrA6O5BONJP8zGAt/3Ze1C33fufh/ixd44A7gS3erq1Z5SW9kO9ez/8ozwdXmEAymVRa3fyg88lQuDseCmAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd6PW8sm; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-479ef2b7979so6147312b6e.3
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779471730; x=1780076530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeXxrM0kZa3YPA9Ohf3mdyVm4nVnxBbJRk8LRmf+jog=;
        b=dd6PW8smL5IjYtVs+lb9Cz3uI0KZCb3nHyBlecVt9agzssAkcAA83B0DVTBskHh/7t
         TEwqlbTGm7Hd4qFWt6mymafX83VBbqjGLpr+L+2+RDQaN/SBDwJMkEupgSyEX0KRoiFh
         oxoHfcf6ymyW4jmiV/S4eO5Xj1BgNOQ1xVZK3jXOjUIO3rrOhHClOjvKERXGclDPTasa
         YPmkvSmBiI29gxjOoc1oSr8GXudWW9FvnhUbBeQCBlVgTJQWHw7N7+hQQY0ys1wf1VDa
         OZYyQyoRxCQSYxdfV0hMqbYfg6LHaHg8rqhfUVeHOzFJEz6PD4gK/kJoEcoYcYUNqQzV
         otGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471730; x=1780076530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeXxrM0kZa3YPA9Ohf3mdyVm4nVnxBbJRk8LRmf+jog=;
        b=M+KqWqALMiaZcx4yUNQvW9v8wk03vK4X4MblKngo8uOttz3Md/qwsGXzEovxxwa7Xl
         4dJQ8R+dIBBTDsa/N2enJaDeamW/4hpZK8EBLaAwzH5iOkIK3VkHbvt2/XqJZsOrrJHk
         Mn5wiAbTfhQEjBiF6SmHiECtMC9IjoyzCCRL4Qs9mpAuMDQo0crCkvcqmtupC+nag/gW
         2/URavIjNq9LhIpugPuEvBsMMa+lG48LnrKYqHtfORNAlpJmhaquHezn9CmdLcdwWysV
         hXvPGv1XboBIE4b8rqkyjKVPB8utYhg6GjxHSSIH++BNuYtn9wIusjueLd5i4Kl4CJF/
         H8/Q==
X-Gm-Message-State: AOJu0YwfAxFdlcv9kS2o2+V2aLWyYU9WXFwW4HXxC8tMfluWuxRwEn1l
	2ekorN1eliViJB/VBAAEbOMDhDX4M/XW8ui8GBNTOmjuHzxZZ+c+t7nm/VEivvdM
X-Gm-Gg: Acq92OFfWO0X/iz4U4m+R8JPdvnvCSjd13gvsZYtKtqotLsCjK+b0Zw4Fexz4iNjj+J
	F5M7is8eHHDCOKonXDujJ8ugIZGjqm5ZYDGGUbCvTcPqawZFHrY70+asdR+dM6flSbCFkZlSuZF
	9nSuDiNgm1PIgA50UdseMH2NarwyNcoeAuyREDVWVBIr6BMhN6mglFKWDD4Lp32kdoTThKIzPjP
	56uI0YEv5NkSwUi5DshMa8XlfZyu6RJKgxu4dJYuWevWa56dyfOQ3IqBGk+mzREs1Vne+Be7aQf
	mhJ+A4MwIanB0KiamF9tito73hQEiPB69V5quyxbrka5l+qv/B/4fT/N+9RuVhXmw+U+R3Z9uve
	5blWPa3JoElObSSWCLE2oyVVN45TuMtUYrWh9rzAC098q1EbaIs/rg/z+K5ckIrvjaaeNgVictG
	6XarS454PlgqRyrVU=
X-Received: by 2002:a05:6808:158a:b0:485:467f:a324 with SMTP id 5614622812f47-4854a47ed15mr2619039b6e.34.1779471729811;
        Fri, 22 May 2026 10:42:09 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b635d26b5sm2287249fac.6.2026.05.22.10.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 10:42:09 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aconole@redhat.com,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v5 0/2] Add OVS packet family YNL spec and unicast notification support
Date: Sat, 23 May 2026 01:41:52 +0800
Message-ID: <20260522174154.720293-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290901-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7E6545B8941
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds a YAML netlink spec for the OVS_PACKET_FAMILY genetlink
family and a bind-only ntf_bind() helper for receiving unicast
notifications.

Changes in v5:
- rebase on net-next to resolve conflict with Ilya Maximets'
  ntf_listen_all_nsid() (requested by Jakub Kicinski)

Changes in v4:
- patch 2: rename ntf_listen() to ntf_bind(addr=(0, 0)); the name
  listen() was misleading since the operation is a bind(), and the
  address is now an explicit argument defaulting to (0, 0)
  (suggested by Jakub Kicinski)

Changes in v3:
- patch 1: add missing document start "---" after SPDX comment
  (yamllint warning in v2)

Changes in v2:
- patch 1: use YAML anchor (&event-attrs / *event-attrs) to avoid
  repeating the same attribute list for miss and action events
  (suggested by Donald Hunter)
- patch 1: fix enum-name from ovs-packet-attrs to ovs-packet-attr
  to match the kernel enum name ovs_packet_attr
- patch 2: add ntf_bind() to the YnlFamily docstring under the
  "Notification API" heading (suggested by Donald Hunter)

Minxi Hou (2):
  netlink: specs: add OVS packet family specification
  tools: ynl: add unicast notification receive support

 Documentation/netlink/specs/ovs_packet.yaml | 130 ++++++++++++++++++++
 tools/net/ynl/pyynl/lib/ynl.py              |   5 +
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/netlink/specs/ovs_packet.yaml

-- 
2.54.0


