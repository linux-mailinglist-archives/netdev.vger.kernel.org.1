Return-Path: <netdev+bounces-278142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBTKI5Il3WkzaQkAu9opvQ
	(envelope-from <netdev+bounces-278142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:19:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 026E03F12A9
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F30E4302B212
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B04345CDC;
	Mon, 13 Apr 2026 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4QCUllL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A97F33EB0E
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100300; cv=none; b=YIeEtDZxoxQKNR9t9AqjFF67rcUtpECqhe5S7fXGVheRmSdNe/WJwFM+FAvwv0EPEt87fWRbzCUrc8dfw3hq7wD2dCZi/IJ0K0haMvpCxXbqwRBrskxACKxDTDVTjLkfGA+BBh00BAcbYa2lJRxaErxJiBtKdb+IEcimZGzVzT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100300; c=relaxed/simple;
	bh=sSXIbXa88EdE44MSuiKkZfiX3S45HUBEL+IWSQOuyl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBa+VHdxG2ROC+qwTMlPwWyzmL6B4XONHH7VkpVVQm+i1p9s0fXwRD60PevYh458lNjYI0BZa97eSSQAovikLuibbO192rkvKXjmxo2Yz3uMIWjKxHh/EB3h7igWcywtdV56SkpixgZ+ECK2FEHNPb1vzfBkhhvObG8YFVQ6pmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4QCUllL; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-4764484296eso2826308b6e.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100297; x=1776705097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUg+J54Bs2vlV2ZiEleumszkO1aC3W/NkpGAafqn2bI=;
        b=i4QCUllLv9inbTFybphZkfxt8c4Zou7PHxUSXFmDyOR1ZdBlEqTZOpGz78ceQbA8DN
         dSmNSTYVkftYWwvKesN5jK0Xe3oybIU9ceg38nmVubxaK0J8p/5SioB0iJsXvRmJsWHh
         kpt0S5VvNn1/d38008FmBps6KRmgVvGPLg2EbOly1DjGmQYazrYXfUltu0d/3fg1Uqja
         0qwiOWNlL8mry4K15Cq7YQHmblgPI0dWZiIBHeaNR11GRZKcF0i95efxTF5knQkSih1W
         WuJvLN2kwr2FUYMVDUMklM3pMfD+TOMHc5fvMn70p6ENyJVi6AGAWysXuXvx+3keRAEm
         rtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100297; x=1776705097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mUg+J54Bs2vlV2ZiEleumszkO1aC3W/NkpGAafqn2bI=;
        b=a7OAt5JHXH2bnUCRmnVecdRGCOVngsaAm3kDS+ojXNdrm7fCzfNPq+coJ7xxkKRzNE
         t4ziKMSXz9KSsvmc67FR86tD8eCb3+F5R4kYIv+lGX+6K+TrqTatWcysiEiOhqaO+bFc
         Zxgz+ln6RFSpx4wY63u+LTA2WT3JvEvc5Afvov9IAm/fPFyYlIAIbwUwW5lBa/5JTDAg
         yMQpUrUQOPQl4l7juW16nU3bRLpDgZUSbxn6qER9mn45RG1sUVpHlw3K5uTYyVTojfmv
         hYOqkm4JptM4vTMjoBNtArqlSbTE3R91H/fV3Dlc36LYHU5eXztv7l6ntmAy4BjTU2oJ
         0CKw==
X-Gm-Message-State: AOJu0YyXl2DPBZyZqlujq0kDkynXFKlFYwgeV1Qm4O7R6SaVQp04cCU2
	Fu2fieLLXDeyZ9jtYQa7bFCIodqA2V/oGLWnTE6G7erVHN+dCKED0xkXecC/I9uE
X-Gm-Gg: AeBDievaNKaJYyrX/pMGcQjQ8QLL2Eu0FRPRwGCAmscLk9KBLcU+/FkMgVcAZIFSzW9
	x9GuzMfb4peKkTfgRd9VPcdSVEYjBlmp/1/zYmn1UXxh+/PnX1rDBEW6xMcEDsCky82wXpcujdY
	3Wmm3+yF6DY5kz37W1FRr4cA0jW0mwcxxBnMF9Rh3ZTYbcZZUqqba27zDYdxMqmkXbk/Jf84dbL
	bsbvb5EW9iCeY2cqaoZGni20y/eq94SjJv3um9CRb3y/Um6RjAuYV5Px1C+vzS9OJGt+YCYUDQd
	u0xpZwqf4vC7Wz2/x6FhO3onCZsSFjiIyTSAytc0mEsuQ1t5nbF74jg7pklUwMRwNO36o72rcku
	Tawog60ym76pBQ2KH96+wjU8XmcBtxPf+TCWnfzjp5UsYDCZzME+8G5KHudkjl7utX2caWz63Dy
	bpXjDF7nLcE5qgDVe/hA==
X-Received: by 2002:a05:6808:181d:b0:44f:6a19:433e with SMTP id 5614622812f47-4789d14fff8mr7461210b6e.15.1776100297006;
        Mon, 13 Apr 2026 10:11:37 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb9c461sm9595689fac.16.2026.04.13.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:11:36 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v7 04/15] net: move promiscuity handling into netdev_rx_mode_work
Date: Mon, 13 Apr 2026 10:11:20 -0700
Message-ID: <20260413171131.550126-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171131.550126-1-sdf@fomichev.me>
References: <20260413171131.550126-1-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-278142-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 026E03F12A9
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
index e89b12d4f3a7..93e06e8d51a9 100644
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
index 8597ec56fd64..8a69aed56fca 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9600,7 +9600,7 @@ int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 	kuid_t uid;
 	kgid_t gid;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	promiscuity = dev->promiscuity + inc;
 	if (promiscuity == 0) {
@@ -9636,16 +9636,8 @@ int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 
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
 
@@ -9667,7 +9659,7 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	unsigned int old_flags = dev->flags, old_gflags = dev->gflags;
 	unsigned int allmulti, flags;
 
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	allmulti = dev->allmulti + inc;
 	if (allmulti == 0) {
@@ -9735,7 +9727,7 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
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


