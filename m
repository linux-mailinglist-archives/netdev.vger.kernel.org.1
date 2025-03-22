Return-Path: <netdev+bounces-176881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8E3A6CAB5
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A3E189A02E
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CA422FE1F;
	Sat, 22 Mar 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="sCm4Uf1T"
X-Original-To: netdev@vger.kernel.org
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E844233721;
	Sat, 22 Mar 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654379; cv=none; b=kfraFoS3Kv8Ho2ObFVvdC+a7Zg6p33TDlmegSR5kVQYw3+lhpXCmamrKrgRjWtXrHixXw7ujM2YpWZMLVXc/wWCmnxHv7uq5aPlB5iB6hXITJSQFkABQmGs3D0VKtByxvfxG75ZvnNBb0rpN+7XTbhjca+k69yWq5LYj+fCz9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654379; c=relaxed/simple;
	bh=YKZwirzX/AY0UnJJuErqBWyCfBFtJRWwmJp9RDpm5Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJ4apM4YLGN+QxZ9mADpB9iUdRze+trAfnBlvidSAZPUG7Av0r0+PtHujOUBE2+QGU7HcntRXSIf6S91m9ed+kDYfiSn89AYoOX5uLAmdsll6CeDt4Ry082N+xGw9MVj4xjEvkVfp+n5wWuas4CsJPZ00blOch1g5GVH4/w03+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=sCm4Uf1T; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:c94:0:640:bcb2:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 082B160AF5;
	Sat, 22 Mar 2025 17:39:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id XdNRrxULdGk0-RrIQiP1N;
	Sat, 22 Mar 2025 17:39:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654374; bh=ZUue14NmZ4zlWhZZTtYPYVZWhfRy6d5KPPbGlX2Ba54=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=sCm4Uf1T9trxhAK8KqY4pjXkyF8UVcQ9msFzBiNkA0hkeO5R1kAAPI2i+VvzEEk8h
	 sfCX/a6zsku00nUeqX1/IqGfIGpEsTwdQb1I/u5jpoCw9jyTCvpfxhoUrZDAU09P1/
	 VaDjqJj4bOYkrljqd4nSbfj8EShaYDdOvWxLFzj4=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 13/51] infiniband_ipoib: Use __register_netdevice in .newlink
Date: Sat, 22 Mar 2025 17:39:32 +0300
Message-ID: <174265437292.356712.256272850273766538.stgit@pro.pro>
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

Here are two path to __register_netdevice().
One is from .newlink, other is from store method.

Also, use __unregister_netdevice() since we know
there is held lock in that path.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c |    2 +-
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c    |   12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
index 2dd3231df36c..b8add59c6c69 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_netlink.c
@@ -140,7 +140,7 @@ static int ipoib_new_child_link(struct net *src_net, struct net_device *dev,
 	if (data) {
 		err = ipoib_changelink(dev, tb, data, extack);
 		if (err) {
-			unregister_netdevice(dev);
+			__unregister_netdevice(dev);
 			return err;
 		}
 	}
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 562df2b3ef18..970f344260df 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -128,7 +128,7 @@ int __ipoib_vlan_add(struct ipoib_dev_priv *ppriv, struct ipoib_dev_priv *priv,
 		goto out_early;
 	}
 
-	result = register_netdevice(ndev);
+	result = __register_netdevice(ndev);
 	if (result) {
 		ipoib_warn(priv, "failed to initialize; error %i", result);
 
@@ -155,7 +155,7 @@ int __ipoib_vlan_add(struct ipoib_dev_priv *ppriv, struct ipoib_dev_priv *priv,
 	return 0;
 
 sysfs_failed:
-	unregister_netdevice(priv->dev);
+	__unregister_netdevice(priv->dev);
 	return -ENOMEM;
 
 out_early:
@@ -169,6 +169,7 @@ int ipoib_vlan_add(struct net_device *pdev, unsigned short pkey)
 	struct ipoib_dev_priv *ppriv, *priv;
 	char intf_name[IFNAMSIZ];
 	struct net_device *ndev;
+	struct nd_lock *nd_lock;
 	int result;
 
 	if (!capable(CAP_NET_ADMIN))
@@ -200,8 +201,15 @@ int ipoib_vlan_add(struct net_device *pdev, unsigned short pkey)
 
 	ndev->rtnl_link_ops = ipoib_get_link_ops();
 
+	lock_netdev(pdev, &nd_lock);
+	attach_nd_lock(ndev, nd_lock);
+
 	result = __ipoib_vlan_add(ppriv, priv, pkey, IPOIB_LEGACY_CHILD);
 
+	if (result)
+		detach_nd_lock(ndev);
+	unlock_netdev(nd_lock);
+
 	if (result && ndev->reg_state == NETREG_UNINITIALIZED)
 		free_netdev(ndev);
 


