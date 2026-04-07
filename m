Return-Path: <netdev+bounces-276049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGmSCKwk1WnK1AcAu9opvQ
	(envelope-from <netdev+bounces-276049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:37:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A99573B121B
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04733308D988
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558CC39E167;
	Tue,  7 Apr 2026 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGwvvNYB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCED3BD62C
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575882; cv=none; b=FiHvuSqukl8fz2bDUSzNIAqWxPiabrD6KbRwdxFa65Ydeze75ArL5PcMTVGnmWMW6j5r1MmvSsuz51UviaAICPE7Q8rkMnQkaJ01RI42M/KFcGX7rJnC9i+UpUWRMsjIi70yGatxNB2dAij1mq/wXDc8QCSCZkz4mX8UjJiTWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575882; c=relaxed/simple;
	bh=9asW6lWDXYVO+yKD6Y5kSOTC2TdZhccfYhuzT9k0VI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4oA+hrJm7+WfqUZYH2UxKhVJIw4/Zw7ApDh4hZ4NtLByhMxrnuMypmAAXbwBOiuzubzuppZa3+ue0tf+TQdgYxjbnzNwWcnjQnnzq63CaXutWNRogZeiLw+fXP1/ksGRKmm6b2+D99rcjA01ftMHgfbunqvODVQ5gj/hUYqRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGwvvNYB; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-679f6ee3fb0so1878998eaf.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775575868; x=1776180668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bw+C8Lqtm6x6bdazH6cf5vOWDt3FTihCUmPzG3owqJ4=;
        b=OGwvvNYBE05fPHw52yNXzYHZG11tgIG66ZeEnitAjo3kITuZZqkOR1BIv+uCi+X2lv
         E3SLJUERG0ZfDCwOiVZBONmaK5hVb2i/X/9m7HXBcVRH26fS6Ag0r2MZjeV3YjucwhLs
         pLnne6jrs87NzVX0AuW+JBNWjpGP9QPIsGHZ/1nSs8z79b5t5zMzF1k2Ie+oM1eoxunt
         rtuJo9B93ifqlfe+uRFLrpB01/FsywEmdQFUG3vDywcAnmaD8PzYaIB9vgtCsEgTSZE9
         L5DUm1tejc9S6Ywe4QaRTQBu53WMHCI70f9/aFRTeE6Di203eBiAztImWYPe1H3Bdpji
         OwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575868; x=1776180668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bw+C8Lqtm6x6bdazH6cf5vOWDt3FTihCUmPzG3owqJ4=;
        b=H+aUqQATysbMIwWp8bUYyMFvwXVonYmdkDP3kFp7iLenQ2cqnn+e/U8br6nBS1f2MS
         3mYaurxUxjkUig5BW7PpOerItnOiLWnB/Uz4jsNP/CawBCgZqM75HwB9E1yJlfnyjRM9
         38GN0xSymIjKbBZCx6Kd3Ff5vPm/0NyzAsXGYWguweWv6MYAw8EVJ3SIaOKnaZsDxBBF
         qwKkNxmoPRGVuypSR4/PldNxV9xnHP9KY+0ueQGQxUBIwOxAFoOJqhEpqF7ku8Mmsn+2
         tjgSV89GdHYrFhl5xmBdctg6ZLv01W8Hvhg2Qpm8iJM0gZUw2iMIagPTGwDxu2yysS3d
         bvVQ==
X-Gm-Message-State: AOJu0Yxcs/cof2wbK4cYTgW6pH+1GjAtQ3bdF1maZxe6/hJRFY/i5pJy
	d4xR8yMrdzmjQPk8QuyN72Mpktm4/riRpizBZFelkFCVO3KwxgPDuSGJCJevJam9Ia0=
X-Gm-Gg: AeBDietpsxd3A/rAQy+bJbhIU0+CiehYcuanO+1G0NdQqszEUdXYERA0vytATFDAjW1
	Zoj8vsh8IUIJyrlbbUVnUA21M804TQ+AsZxciRl1yKdit6Dlt//UeHERekOKRiPoC2FvrYjfXlr
	5cFw83cl/+RjIfk6JqR9PYsdj6ob6qFvT5ItPapqNjm52h0t4umPBf2dxWWSiG5s7wmTDSi5mL3
	DhLQ+gfyXDdHUglmJh/SL4eOZxY4Kx6//vMVwJsEM3NaoXyJ/EuQGJT//odIcFL28UMrwXkPwRz
	vY3eVS8kp7FVQ8xfgclD+bYI0nxOxAoYUFnfcN8tHQsIUulxIlW+ZoROiegXEYjeCrjt3XZqjKT
	I79+M59yAhAxbLSEKFEpVA2UnQ83p/FVLWxDAAX5Ara2rt1DXMhPh4U8U4wIQ4fgIRhxRC2AuBH
	FCOVfXyn/J1bWbptrLXw==
X-Received: by 2002:a05:6820:1b1a:b0:685:7d77:27 with SMTP id 006d021491bc7-6857d770318mr5013104eaf.33.1775575867496;
        Tue, 07 Apr 2026 08:31:07 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:55::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68791a61c56sm1584639eaf.2.2026.04.07.08.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:31:06 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v6 04/14] net: move promiscuity handling into netdev_rx_mode_work
Date: Tue,  7 Apr 2026 08:30:51 -0700
Message-ID: <20260407153101.3694714-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407153101.3694714-1-sdf@fomichev.me>
References: <20260407153101.3694714-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276049-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A99573B121B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move unicast promiscuity tracking into netdev_rx_mode_work so it runs
under netdev_ops_lock instead of under the addr_lock spinlock. This
is required because __dev_set_promiscuity calls dev_change_rx_flags
and __dev_notify_flags, both of which may need to sleep.

Change ASSERT_RTNL() to netdev_ops_assert_locked() in
__dev_set_promiscuity, netif_set_allmulti and __dev_change_flags
since these are now called from the work queue under the ops lock.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst |  4 ++
 net/core/dev.c                          | 16 ++---
 net/core/dev_addr_lists.c               | 82 ++++++++++++++++++-------
 3 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 8a488c21fd7c..390537323457 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -299,6 +299,10 @@ struct net_device synchronization rules
 	Notes: Async version of ndo_set_rx_mode which runs in process
 	context. Receives snapshots of the unicast and multicast address lists.
 
+ndo_change_rx_flags:
+	Synchronization: rtnl_lock() semaphore. In addition, netdev instance
+	lock if the driver implements queue management or shaper API.
+
 ndo_setup_tc:
 	``TC_SETUP_BLOCK`` and ``TC_SETUP_FT`` are running under NFT locks
 	(i.e. no ``rtnl_lock`` and no device instance lock). The rest of
diff --git a/net/core/dev.c b/net/core/dev.c
index 23a832c9facc..d2e72fdf3dfe 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9586,7 +9586,7 @@ int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 	kuid_t uid;
 	kgid_t gid;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	promiscuity = dev->promiscuity + inc;
 	if (promiscuity == 0) {
@@ -9622,16 +9622,8 @@ int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 
 		dev_change_rx_flags(dev, IFF_PROMISC);
 	}
-	if (notify) {
-		/* The ops lock is only required to ensure consistent locking
-		 * for `NETDEV_CHANGE` notifiers. This function is sometimes
-		 * called without the lock, even for devices that are ops
-		 * locked, such as in `dev_uc_sync_multiple` when using
-		 * bonding or teaming.
-		 */
-		netdev_ops_assert_locked(dev);
+	if (notify)
 		__dev_notify_flags(dev, old_flags, IFF_PROMISC, 0, NULL);
-	}
 	return 0;
 }
 
@@ -9653,7 +9645,7 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	unsigned int old_flags = dev->flags, old_gflags = dev->gflags;
 	unsigned int allmulti, flags;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	allmulti = dev->allmulti + inc;
 	if (allmulti == 0) {
@@ -9721,7 +9713,7 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
 	unsigned int old_flags = dev->flags;
 	int ret;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	/*
 	 *	Set the flags on our device.
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 88e995db15dd..49346d0cbc8a 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -1229,10 +1229,34 @@ static void netif_addr_lists_reconcile(struct net_device *dev,
 				 &dev->rx_mode_addr_cache);
 }
 
+/**
+ * netif_uc_promisc_update() - evaluate whether uc_promisc should be toggled.
+ * @dev: device
+ *
+ * Must be called under netif_addr_lock_bh.
+ * Return: +1 to enter promisc, -1 to leave, 0 for no change.
+ */
+static int netif_uc_promisc_update(struct net_device *dev)
+{
+	if (dev->priv_flags & IFF_UNICAST_FLT)
+		return 0;
+
+	if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
+		dev->uc_promisc = true;
+		return 1;
+	}
+	if (netdev_uc_empty(dev) && dev->uc_promisc) {
+		dev->uc_promisc = false;
+		return -1;
+	}
+	return 0;
+}
+
 static void netif_rx_mode_run(struct net_device *dev)
 {
 	struct netdev_hw_addr_list uc_snap, mc_snap, uc_ref, mc_ref;
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int promisc_inc;
 	int err;
 
 	might_sleep();
@@ -1246,22 +1270,39 @@ static void netif_rx_mode_run(struct net_device *dev)
 	if (!(dev->flags & IFF_UP) || !netif_device_present(dev))
 		return;
 
-	netif_addr_lock_bh(dev);
-	err = netif_addr_lists_snapshot(dev, &uc_snap, &mc_snap,
-					&uc_ref, &mc_ref);
-	if (err) {
-		netdev_WARN(dev, "failed to sync uc/mc addresses\n");
+	if (ops->ndo_set_rx_mode_async) {
+		netif_addr_lock_bh(dev);
+		err = netif_addr_lists_snapshot(dev, &uc_snap, &mc_snap,
+						&uc_ref, &mc_ref);
+		if (err) {
+			netdev_WARN(dev, "failed to sync uc/mc addresses\n");
+			netif_addr_unlock_bh(dev);
+			return;
+		}
+
+		promisc_inc = netif_uc_promisc_update(dev);
+		netif_addr_unlock_bh(dev);
+	} else {
+		netif_addr_lock_bh(dev);
+		promisc_inc = netif_uc_promisc_update(dev);
 		netif_addr_unlock_bh(dev);
-		return;
 	}
-	netif_addr_unlock_bh(dev);
 
-	ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
+	if (promisc_inc)
+		__dev_set_promiscuity(dev, promisc_inc, false);
 
-	netif_addr_lock_bh(dev);
-	netif_addr_lists_reconcile(dev, &uc_snap, &mc_snap,
-				   &uc_ref, &mc_ref);
-	netif_addr_unlock_bh(dev);
+	if (ops->ndo_set_rx_mode_async) {
+		ops->ndo_set_rx_mode_async(dev, &uc_snap, &mc_snap);
+
+		netif_addr_lock_bh(dev);
+		netif_addr_lists_reconcile(dev, &uc_snap, &mc_snap,
+					   &uc_ref, &mc_ref);
+		netif_addr_unlock_bh(dev);
+	} else if (ops->ndo_set_rx_mode) {
+		netif_addr_lock_bh(dev);
+		ops->ndo_set_rx_mode(dev);
+		netif_addr_unlock_bh(dev);
+	}
 }
 
 static void netdev_rx_mode_work(struct work_struct *work)
@@ -1312,6 +1353,7 @@ static void netif_rx_mode_queue(struct net_device *dev)
 void __dev_set_rx_mode(struct net_device *dev)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int promisc_inc;
 
 	/* dev_open will call this function so the list will stay sane. */
 	if (!(dev->flags & IFF_UP))
@@ -1320,20 +1362,16 @@ void __dev_set_rx_mode(struct net_device *dev)
 	if (!netif_device_present(dev))
 		return;
 
-	if (ops->ndo_set_rx_mode_async) {
+	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags) {
 		netif_rx_mode_queue(dev);
 		return;
 	}
 
-	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
-		if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
-			__dev_set_promiscuity(dev, 1, false);
-			dev->uc_promisc = true;
-		} else if (netdev_uc_empty(dev) && dev->uc_promisc) {
-			__dev_set_promiscuity(dev, -1, false);
-			dev->uc_promisc = false;
-		}
-	}
+	/* Legacy path for non-ops-locked HW devices. */
+
+	promisc_inc = netif_uc_promisc_update(dev);
+	if (promisc_inc)
+		__dev_set_promiscuity(dev, promisc_inc, false);
 
 	if (ops->ndo_set_rx_mode)
 		ops->ndo_set_rx_mode(dev);
-- 
2.52.0


