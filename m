Return-Path: <netdev+bounces-303327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oFDGL80JRGpRngoAu9opvQ
	(envelope-from <netdev+bounces-303327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:24:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C03326E72D0
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:24:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="jsPocvh/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303327-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303327-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8066730237BA
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D267A3E1D16;
	Tue, 30 Jun 2026 18:21:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011B46AF3D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:21:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843699; cv=none; b=LRsX1uXe4LfrKTDvwSDtdIboEFuTuYGJNDzvEMfXvy5wUgQjLeudDSm0Pf4nEezWsjTfkDK4pDPdDUjeWl4msEq/p1PhQoUEWXfN2OaWCHGayzLjaC5tD+aiow0Qaf5EFhSGgrubVBk4xIXWBKMbt2MmEsawVvf28wv53KkXL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843699; c=relaxed/simple;
	bh=gVRvszlKjC051AeWdIy0Pxn+2sjC6Uwq/oT9l7DyrWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmw7ZJrOyCR78eOKuBEFRGz//FjhbogTKrUCqDKVY11dnMraH3j5tCReXw84Q66UDncOs1Dhqj604lAPzDjRy17TsPm6Mzv5oUbNnoniiyBbi1piyPpcxF+rIEoOfOosb9gxUuKC6PBCXGCDMmymR3IlivevvHtxGzzC6AORN+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsPocvh/; arc=none smtp.client-ip=209.85.210.194
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-845c92bc464so2908450b3a.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843698; x=1783448498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZkbORPm7iZJ0a/v7NZ/ujLdsQdGoEPvg/+GU5QgGmcU=;
        b=jsPocvh/gZS0sO4H4z5UfeuLUXsG64pbxpbc6OYRRD5SVWfoNOt65F+Og32KXAnQkc
         pxzAqKctSpy0OcAxOAXQ3zeufmefjf6Z0MyV+oChr5r0A4u9DO3qGAa3i4K5CtD7xoUV
         okAp5nHKC+XZsF31kdhveYTjfU4cSHhiwBRXePzw4VyHuX1yuYho7OjvWOw+QtsRE7yw
         Q13EZ/5MYQEHxxeypk0JJdUdJ7xeQOSfbSMwUUyzLBP6akchoFMhW435CGB7VvENfx7j
         21Z4DKoimtjD/C30hwdRYqbLV1P6T59ljCFjQDXZ/oNI6+FEVRBnuiUZOsKgY8cn/PvB
         OfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843698; x=1783448498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZkbORPm7iZJ0a/v7NZ/ujLdsQdGoEPvg/+GU5QgGmcU=;
        b=npWW8GaRlk5gslLhtcuMWJ1fbI5BAVpNc0uj0ZuGIBAl3AqH+Yi49zvZtfU+753lPd
         6EezCqKbSPoe71xGy+dZ+rbIPnp5ye3r2gwW5cQFab27X7RvmkQTB543B7at02IjB/UB
         K0CUUcpk92hahPGjFx8fnFnr1h2Qgz6IdYZ9agTaK7QdDoIT2c6qWDdIp8IAC7uQD4RA
         nZY3vb/PqMwzjJ2iBapUNX8syW3uWTmfIFTuYC7LL9/5kI8sJfe2Mchq1ssT8Na10htq
         fUEFiSmpBNA8FUxH3BUNEkRFWD+lk1GCvHleF1NeggA2CAl4brOzmODoJn+r0h0rmjSX
         qvVg==
X-Gm-Message-State: AOJu0Yw1XaaWeKYh/0WZxjDhEIzQHEn5Hc7998uZcGoh77KEUyrJeLo0
	2JbBFojOdX+17XC06hEW1FOulQs8cCcv4AJksIv3F59BgP7GHVFNGHYvSKBDE0H0
X-Gm-Gg: AfdE7cnOYsD5iYBM+/eLNakzy055TSwLKOcTIOc7wTnKHCFdZc7cmMHL0VgV/VhsFuv
	YzHoE5javcLYRWaSg4AgFZrm5SL6LPt4nChILQYeh/z7+KNJuji3Uk03VyvifgTqlGHC7uotRms
	yd6s6enDOvVgzNberBaHuTrwRyuEQagoGQ0WGW2MfTs4b5E4SVelILg2RU/Ph6mS+Zzqt+ucJbl
	t2UVHbIXN6+qhFMNZ+q0Ga9yE6+GwJVJhvxKzTmU3uVkgLWqEor2eMqCHkG/bq2FDoyI3/m7+W8
	CZUFoXVkkm48xnjotZvLu41TEBU9ja4lmGLuVwgAmaqk1jMzuyk6sks59muLHf5819lQumVJfwK
	7OlTDH6bHGogcSBdV7hmyCAdt1IFdA3a+FoXgmcwomMHdqjJhmB2nOH/sf6zsTdvr+1Z9AO1ILO
	I933RNlQ==
X-Received: by 2002:a05:6a00:2e19:b0:845:c373:652d with SMTP id d2e1a72fcca58-8479f233acamr4180652b3a.32.1782843697852;
        Tue, 30 Jun 2026 11:21:37 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a03cb50esm2677072b3a.60.2026.06.30.11.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:21:37 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 5/6] net: require instance lock for NETDEV_DOWN/GOING_DOWN notifiers
Date: Tue, 30 Jun 2026 11:21:28 -0700
Message-ID: <20260630182129.1601784-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630182129.1601784-1-sdf@fomichev.me>
References: <20260630182129.1601784-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-303327-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:mid,fomichev.me:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C03326E72D0

Sprinkle a few asserts about ops lock: netif_close_many and __dev_notify_flags
should now consistently run under the lock

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst | 2 ++
 net/core/dev.c                          | 3 +++
 net/core/lock_debug.c                   | 4 ++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index d2a238f8cc8b..1bb68a73bb67 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -421,6 +421,8 @@ For devices with locked ops, currently only the following notifiers are
 * ``NETDEV_CHANGENAME``
 * ``NETDEV_REGISTER``
 * ``NETDEV_UP``
+* ``NETDEV_DOWN``
+* ``NETDEV_GOING_DOWN``
 
 The following notifiers are running without the lock:
 * ``NETDEV_UNREGISTER``
diff --git a/net/core/dev.c b/net/core/dev.c
index 9d49493f4fb5..714d05283500 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1802,6 +1802,7 @@ void netif_close_many(struct list_head *head, bool unlink)
 	__dev_close_many(head);
 
 	list_for_each_entry_safe(dev, tmp, head, close_list) {
+		netdev_assert_locked_ops_compat(dev);
 		rtmsg_ifinfo(RTM_NEWLINK, dev, IFF_UP | IFF_RUNNING, GFP_KERNEL, 0, NULL);
 		call_netdevice_notifiers(NETDEV_DOWN, dev);
 		if (unlink)
@@ -9787,6 +9788,8 @@ void __dev_notify_flags(struct net_device *dev, unsigned int old_flags,
 {
 	unsigned int changes = dev->flags ^ old_flags;
 
+	netdev_assert_locked_ops_compat(dev);
+
 	if (gchanges)
 		rtmsg_ifinfo(RTM_NEWLINK, dev, gchanges, GFP_ATOMIC, portid, nlh);
 
diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
index 8a81c5430705..abc4c00728b1 100644
--- a/net/core/lock_debug.c
+++ b/net/core/lock_debug.c
@@ -24,15 +24,15 @@ int netdev_debug_event(struct notifier_block *nb, unsigned long event,
 	case NETDEV_CHANGE:
 	case NETDEV_REGISTER:
 	case NETDEV_UP:
+	case NETDEV_DOWN:
+	case NETDEV_GOING_DOWN:
 		netdev_assert_locked_ops_compat(dev);
 		fallthrough;
-	case NETDEV_DOWN:
 	case NETDEV_REBOOT:
 	case NETDEV_UNREGISTER:
 	case NETDEV_CHANGEMTU:
 	case NETDEV_CHANGEADDR:
 	case NETDEV_PRE_CHANGEADDR:
-	case NETDEV_GOING_DOWN:
 	case NETDEV_FEAT_CHANGE:
 	case NETDEV_BONDING_FAILOVER:
 	case NETDEV_PRE_UP:
-- 
2.53.0-Meta


