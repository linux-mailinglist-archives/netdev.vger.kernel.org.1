Return-Path: <netdev+bounces-304287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GDmGBlPqRmrefQsAu9opvQ
	(envelope-from <netdev+bounces-304287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:46:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FA56FD49C
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:46:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=je7Am6hs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304287-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304287-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B2EA3078F8C
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 22:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047FC3D4105;
	Thu,  2 Jul 2026 22:42:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CEC3CFF68
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 22:41:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032120; cv=none; b=FcItpRCN/lXI6wLUfk3dSKpBEf9/EebKrKdocvalC8tL2zhsu9IbC4xISD5EzgrQUCk+gvPMZllHUuOx8jdRXjvM8eflZej3XqRiYCJn0xwUN19m4cCBofVZl5/cPiGJgxnIteP8Jn//VfQsiowWEZQ7/E0r+v80H0X6MJJlDrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032120; c=relaxed/simple;
	bh=gVRvszlKjC051AeWdIy0Pxn+2sjC6Uwq/oT9l7DyrWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qgrj+fTDGiqY/JqraRBCfA26Bq1IlpKYXSgDkNITUNJGTSqf8rmxCPj+wycGJc4CE9OehZJ28vd+PjJvh3w/6IUse4oYimEfSdkD1gQx38MEOmYsJQWw/XQWly5VNhbkHQbtlRAveZWL0UdEDIRaVLvmnOJmkTR2EkG6DnDIpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je7Am6hs; arc=none smtp.client-ip=74.125.227.129
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cac634f921so2147695ad.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 15:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783032116; x=1783636916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkbORPm7iZJ0a/v7NZ/ujLdsQdGoEPvg/+GU5QgGmcU=;
        b=je7Am6hs3ZDNF69y2jD62IIWyAvHDms/02p3OznNrFr69cxz1uZ+romB/l0KZBvT2X
         qzst3tx5PUOc/fqObjdx/QyZxMq8c0IcJZKGTVwLUKyMHwSsS3S+NL1rn7K3CGUz/Jgq
         LrtgYVGcx7GQPil07g792+F8DDPadtQR9mLxJP3mriH+nMVl8W6FZ8a4CsqNyZhWZDZU
         aEQ2bL4j8ZGfjxmMKIUS/h+IAXRFuekd7DPXEOoMuoJp20K9JRRLYY2fzOkq/Asd9b+E
         ElzIAZbI6ujyoICLKEib7UNHwxS3TaLXYTDCeCNSJoNM9wxmEB9KwTVE/D+7WEqOnr9s
         rCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783032116; x=1783636916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZkbORPm7iZJ0a/v7NZ/ujLdsQdGoEPvg/+GU5QgGmcU=;
        b=DaGYzxvL86F5L/HvE890GIhX/Pns/j2otVFrMbgTlGfI4Jjq5v4w0k8fnm4IgwFfT6
         qE380hAeGINQlo5pzOMNhzxMbZlx/QgKYzKfIYh0DjdPyNHXQnw8i1e1WbbXgdHZtWzD
         lgykjYhg7XB8Zqlcgs82irZUtXx3SA65mcSp16nzF6GvYF6Cx9LUT9eUp0ITwJJRss0/
         QIqfi2WhA1hAZ2brxyqsSqCNngjbR/cQX9iWFxb3qbsG243AJDMz2P6tJuoJ2FMCaGJ1
         ciyP4CIV5Ncs7SzdzgdSLo36L6ekrSeCqOqfHiXr/wYHQrRnlrxZXqWQf/nWeS0/nrdY
         Skzw==
X-Gm-Message-State: AOJu0Yxk+Uu1XPGY2k27Cl7Nc7pVvgBh30Ww/iftWxYQh7hDOYwseKtR
	BLAsRfYra/l3mOe46UUViMD+jvcs4Y2swG4KRMTuJNwSb0e845OWjklCkRm4BDCo
X-Gm-Gg: AfdE7cknxF7bu8r5hsk79wILT4yo1/q+hahJEou67vh6CG7JumPF5jo1u9gdk/1aOBd
	ZuaEFs+eTgLsQNwJYMcLlfq9v6ii1ko0mILd9t5NmALN071cMBVW9n4GgGm/0YsoQkeOO4m1jzX
	MrnXgwHSr6JA3DHT0KMMaTDCuSsEUnwo5OYaSo9sV2rGmV8CU6GoLBZhoHk4kUfrhfI62A/AT21
	VWmDWvoIYhjBeYUZCrOMHuuLmcarFTVDvuZJ+xm8cPbKMJp91c/f6yGjDNAIszsiP/OAIltB9Db
	Ww2GzvmQNFzTN80mmaiChS80CVer6BdCrzq2jt9wtJvLrJlNc02/GRW2Yhwdt8bAznfgomkSPGT
	4LbnSNCeaBo4K0KDYz0B8io0Bq0xP67fv78QjtN1MhW4XDQxFDPCvqSPOghVjxVLzSJRgYt3ZsW
	ugqhZMFA==
X-Received: by 2002:a05:6a20:94cf:b0:3b3:1c7b:ff7 with SMTP id adf61e73a8af0-3bfed47e012mr9186089637.46.1783032116021;
        Thu, 02 Jul 2026 15:41:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:59::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e926a4294sm1831204a12.26.2026.07.02.15.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:41:55 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v2 5/6] net: require instance lock for NETDEV_DOWN/GOING_DOWN notifiers
Date: Thu,  2 Jul 2026 15:41:49 -0700
Message-ID: <20260702224150.3730033-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702224150.3730033-1-sdf@fomichev.me>
References: <20260702224150.3730033-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-304287-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fomichev.me:mid,fomichev.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5FA56FD49C

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


