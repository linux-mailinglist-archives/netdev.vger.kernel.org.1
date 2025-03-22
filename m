Return-Path: <netdev+bounces-176921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5282FA6CB09
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACD71B820C0
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695362356CC;
	Sat, 22 Mar 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="rRDfb+1k"
X-Original-To: netdev@vger.kernel.org
Received: from forward206d.mail.yandex.net (forward206d.mail.yandex.net [178.154.239.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723522D4C5;
	Sat, 22 Mar 2025 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654793; cv=none; b=BoXen9bnVLjswYdBPluOtvRcRJW6njc1p2AZaFKPuFmBQ6Olwe516S4/kMwHF5RulB/YGJhxMGG2MIcKHLxX5b/KWOzo/x7WR4y4sS0+dLYCduYyPYMsebqh68kRpIXCnoPpwgG86y9soST4eoGu1gc8mFfts5XGM9b9daaOKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654793; c=relaxed/simple;
	bh=oQczuyRkM23/wfWiCiVKeC3id0UmMUw3rjFlMONo4YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfG5/HA0X7UcoMod/c2NJsvDZaWOrrvmTjzf3xUAC6XZap0ImhmNZc2Hgy3JIT3juAaQAANc4AhUtCAgaLtXLO9NYzPjKGfeOd0TuxPchjlxp2xviS/28yZeU9EEutFUMvyxRkLaBjAA2HCevqd450pvXjjuU5kiGUoGGCbh4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=rRDfb+1k; arc=none smtp.client-ip=178.154.239.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward206d.mail.yandex.net (Yandex) with ESMTPS id BC7AE666A9;
	Sat, 22 Mar 2025 17:41:11 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:f0e:0:640:9c82:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 7DF7760026;
	Sat, 22 Mar 2025 17:41:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 1fNMXlULfuQ0-rrRIYxOj;
	Sat, 22 Mar 2025 17:41:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654463; bh=RW6VGw0SWSwalTlbZvQve7tkiY34HdndWBfI4+yp0J4=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=rRDfb+1kOI8PanG594hgz4O6+su5gH20QqBudIanQPWGq+q5+uQzkspLNZ+iQudN9
	 XvZX35FTTcv9gQO62fKYTwHlqGLKR+v13dpt90bu8ec0g9D2PkRES/xNb0g1OrwGNn
	 8293gzIh41dbtdw08Y298mndo+Gy14Rt8AeFlXnI=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 25/51] wwan: Use __register_netdevice in .newlink
Date: Sat, 22 Mar 2025 17:41:01 +0300
Message-ID: <174265446129.356712.10468249471563047526.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The objective is to conform .newlink with its callers,
which already assign nd_lock (and matches master nd_lock
if there is one).

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/net/wwan/iosm/iosm_ipc_wwan.c |    2 +-
 drivers/net/wwan/mhi_wwan_mbim.c      |    2 +-
 drivers/net/wwan/t7xx/t7xx_netdev.c   |    2 +-
 drivers/net/wwan/wwan_core.c          |   13 +++++++++++--
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_wwan.c b/drivers/net/wwan/iosm/iosm_ipc_wwan.c
index ff747fc79aaf..f84f59df0747 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_wwan.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_wwan.c
@@ -180,7 +180,7 @@ static int ipc_wwan_newlink(void *ctxt, struct net_device *dev,
 	if (rcu_access_pointer(ipc_wwan->sub_netlist[if_id]))
 		return -EBUSY;
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err)
 		return err;
 
diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index d5a9360323d2..369ed68211dd 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -566,7 +566,7 @@ static int mhi_mbim_newlink(void *ctxt, struct net_device *ndev, u32 if_id,
 	/* Already protected by RTNL lock */
 	hlist_add_head_rcu(&link->hlnode, &mbim->link_list[LINK_HASH(if_id)]);
 
-	return register_netdevice(ndev);
+	return __register_netdevice(ndev);
 }
 
 static void mhi_mbim_dellink(void *ctxt, struct net_device *ndev,
diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
index 91fa082e9cab..3bde38147930 100644
--- a/drivers/net/wwan/t7xx/t7xx_netdev.c
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
@@ -304,7 +304,7 @@ static int t7xx_ccmni_wwan_newlink(void *ctxt, struct net_device *dev, u32 if_id
 	atomic_set(&ccmni->usage, 0);
 	ctlb->ccmni_inst[if_id] = ccmni;
 
-	ret = register_netdevice(dev);
+	ret = __register_netdevice(dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 17431f1b1a0c..c2878efcde59 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -982,7 +982,7 @@ static int wwan_rtnl_newlink(struct net *src_net, struct net_device *dev,
 		ret = wwandev->ops->newlink(wwandev->ops_ctxt, dev,
 					    link_id, extack);
 	else
-		ret = register_netdevice(dev);
+		ret = __register_netdevice(dev);
 
 out:
 	/* release the reference */
@@ -1053,9 +1053,11 @@ static void wwan_create_default_link(struct wwan_device *wwandev,
 {
 	struct nlattr *tb[IFLA_MAX + 1], *linkinfo[IFLA_INFO_MAX + 1];
 	struct nlattr *data[IFLA_WWAN_MAX + 1];
+	struct nd_lock *nd_lock;
 	struct net_device *dev;
 	struct nlmsghdr *nlh;
 	struct sk_buff *msg;
+	int ret;
 
 	/* Forge attributes required to create a WWAN netdev. We first
 	 * build a netlink message and then parse it. This looks
@@ -1097,7 +1099,14 @@ static void wwan_create_default_link(struct wwan_device *wwandev,
 	if (WARN_ON(IS_ERR(dev)))
 		goto unlock;
 
-	if (WARN_ON(wwan_rtnl_newlink(&init_net, dev, tb, data, NULL))) {
+	if (!attach_new_nd_lock(dev))
+		goto unlock;
+
+	lock_netdev(dev, &nd_lock);
+	ret = wwan_rtnl_newlink(&init_net, dev, tb, data, NULL);
+	unlock_netdev(nd_lock);
+
+	if (WARN_ON(ret)) {
 		free_netdev(dev);
 		goto unlock;
 	}


