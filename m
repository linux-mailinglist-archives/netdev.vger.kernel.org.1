Return-Path: <netdev+bounces-279119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJhYMkcx4WlGqQAAu9opvQ
	(envelope-from <netdev+bounces-279119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:58:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D88AA413EB6
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1877130ACFFC
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E387234A76E;
	Thu, 16 Apr 2026 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Di7WmPyR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7934B192
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365840; cv=none; b=S8j1OJy1ulqBGy/Nucx6B+BFDnJgWb0WJiDmkrqNrw2COsYQAGq9brEtHWUSf2rMt47LPL+XeT6soht1yXosB7ybt4E09dCrwp9sBSPciwSjoZtuVnzmXl1wCSRfFgQ6ogDxXQmt9CIGfYyXf6QdL1OpWDE6UnXUQX4CYCKNHEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365840; c=relaxed/simple;
	bh=KdHloYR4eRGmi1dvUuKF4TmQcGEeBmvTKUsyBjCq3Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJMTo8hT+U37GDTNcjapM64Ids7LbGbtm9Y58P3gkccJITsRWF4jArlpsUU1dDp+Q5Y8xniiyQJNyY+TSOPmnOIt2w7s9Cyk7+VNj+G7FHJkbYdvURi2+KIsco207k5sp8hrBGruXHp5YwvXLcGF34SJ6DemFBIQcm3wry4vu2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Di7WmPyR; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-40423dbe98bso3433749fac.2
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365838; x=1776970638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdxDXPgNTJm3kL55OpLfGyOuf82UbkKH+OCxstdj6FI=;
        b=Di7WmPyRduEcZEtAnQAPtJ+O/bCcaiqHqyfCTB+yYrKete8wXuQicK+e2R4x4lMiG/
         j4J/5ugEtYj6z80ZPvAUZQMi+VI9/bMc7oV9AWDZYmXdmFDWoI1IaOUSqvrxp9YsyG8f
         ALktqN/WOCIpAyN9jQy+85y5UxLz3A/aD4ntZBHd9yesD6RdH27COJr9ZCV3flFtUgrd
         52wmZT87YZfmZyZoXybRlq90mrKRIlFnmp5GA9E2WLkJHoBUk++rA1lS+dZlIOWqR/qC
         MlmXdWxPXsS1xlBqsKd0Y06hnCbw1N6leXUsL4ZMntpfYp6c62/xzJiY+pAlggyF2p4W
         zc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365838; x=1776970638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QdxDXPgNTJm3kL55OpLfGyOuf82UbkKH+OCxstdj6FI=;
        b=ecLIYa5fGheB4XTEsvV9Xx9EXc9xSCKTlS4SwWBZtZbWPpz2NiaTX5myCWXyfC3UPP
         dAlPTBOiXE8bfqB9+t6FZK7re/4LjsDUDqNIb4beAjK9jZTrknc5/JPti8bIgOSFouiP
         Eh9t0eFmOrSglTzbRa0tdyBa7/4cLB/qcceq+/6A7SvwDi7Q2YkSXIDHZ4AI8344Fprn
         pHCzCmEpzbUar25oqgVZUR+3cyuZu4WoEBOvfd1E/dJWvBgA5oWLAg2wgMTEI4lvvVNq
         jMdxMMKgwDKnedUjJX1tALnuNzHgL4ymv1jnxIrwDfSKUgOkTkwAY4m1jHttJL8JaAwH
         mjvw==
X-Gm-Message-State: AOJu0YwOdItjmf60zF1laWbSes/5VCpk9bRKpv45cYJCP5q1xi3dW8hb
	ziQRrrsHseknW+rCEDA183iI27Rvfti5oB45M/w+3qjtW/yXpqDl5WEIIJ/NTg+N
X-Gm-Gg: AeBDiesErDB4/PcDs9tyvTobaih7QruH8FamRVxh+cLPakFFJ58rwmOtJ8jnd3UZ0Mg
	I54cVRhL8dTCIIZZcWR8b1tHYheGOGl+Sk/hecFl3iJZmJLt4fwbD5198niwXjA/D3W/R4S3Qia
	lUIVt0kwh8CsIFMlwOsmT0ApF8D7AgqVdm575DbisS/lT43K2lkSjGEHjkb2abOmJscMxsropcf
	IjN29K2XBepwmwezwGRXK0DoiOwLTJfTjIABpBH5Ewex5bmed20xAZCMXmAiT3uxx8GcMF+knbG
	7jPN4b6UtwTI5yUarVXdsAVZfvVe79qrEQ13cKoIoz7NX0rmQ8kYdp6G65U7RSxJlzh0D+T/mHq
	ZCo40s59SaNSQX2ggYEqp5rkVEnAZuN4Jx2bNoIDYGt6SU0Z3p+1nlmUbRckVKYCLxx9myz2ZlC
	fbXhGmRyXT2+ThuNp8Cm5jODTvO+Y=
X-Received: by 2002:a05:6870:7d15:b0:423:28ff:fb8e with SMTP id 586e51a60fabf-428915d287emr368709fac.32.1776365837960;
        Thu, 16 Apr 2026 11:57:17 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:7::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4264469bafbsm5019836fac.0.2026.04.16.11.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:57:17 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v8 04/15] net: move promiscuity handling into netdev_rx_mode_work
Date: Thu, 16 Apr 2026 11:57:01 -0700
Message-ID: <20260416185712.2155425-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416185712.2155425-1-sdf@fomichev.me>
References: <20260416185712.2155425-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-279119-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.544];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:mid,fomichev.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: D88AA413EB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move unicast promiscuity tracking into netdev_rx_mode_work so it runs
under netdev_ops_lock instead of under the addr_lock spinlock. This
is required because __dev_set_promiscuity calls dev_change_rx_flags
and __dev_notify_flags, both of which may need to sleep.

Change ASSERT_RTNL() to netdev_ops_assert_locked() in
__dev_set_promiscuity, netif_set_allmulti and __dev_change_flags
since these are now called from the work queue under the ops lock.

Link: https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
Fixes: 78cd408356fe ("net: add missing instance lock to dev_set_promiscuity")
Reported-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
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
index 7bab2ed0f625..4c9e8a69493f 100644
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
@@ -1320,6 +1361,7 @@ static void netif_rx_mode_queue(struct net_device *dev)
 void __dev_set_rx_mode(struct net_device *dev)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int promisc_inc;
 
 	/* dev_open will call this function so the list will stay sane. */
 	if (!(dev->flags & IFF_UP))
@@ -1328,20 +1370,16 @@ void __dev_set_rx_mode(struct net_device *dev)
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


