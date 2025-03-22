Return-Path: <netdev+bounces-176887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FEFA6CABF
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6713A188C936
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7885C22F3BD;
	Sat, 22 Mar 2025 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="OT7Ceuma"
X-Original-To: netdev@vger.kernel.org
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FE233716;
	Sat, 22 Mar 2025 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654445; cv=none; b=trfQPDb21GqdXiTz6wDtAucn0r9OgiIVfBzV+TB6SivIKCsT8/CmvTg7YCODufTtdRzu6hAQXcJ/4P6V2TK2P5kt/Q+h/v5Jv8WqSYXj7Az/9n8C2S2skrl+1qhg/tMi1JbD+m4W2Qg/F8HMeZaivWGLxATT/B7fbAzUj82a/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654445; c=relaxed/simple;
	bh=n3nw6y3jd4EC1ONLmfDDyrYL3H002XI/IGhaFMDDWyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qW6PTon/llDIGzHz6V9sE5hLbGKIfCz2xj7KixHUPjzDCx+QHsnmBRO7IfMFtnpiIg5SN2zGmweiRq5z1QsjhUUDHlhdscTie5YUTlA1/8SvJKW1IfEPJkDTmjvwlYmkHpITlRTKtIiatTKY2V9/9xfkZdsZSuhEJ9qMkutRKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=OT7Ceuma; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:c14:0:640:86a6:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id B63E36005A;
	Sat, 22 Mar 2025 17:40:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id deNsNoULfKo0-9LMVm9yK;
	Sat, 22 Mar 2025 17:40:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654441; bh=ADx6FD1fjJQbRt3TIQRIVkg0GLSu2rrgGxf4Ud1Wy2Y=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=OT7CeumaxJhhhnPfXfNSk30lAq0aMYCx3A6laBYYvjtvYEgscJ6PdYUkWokUkimQ1
	 hz8YhXLHoL+tG077n9Xr/a09R+g2KEXPuYU1pw3epY6rGdLSsCn5A5+44a1IXh7n4e
	 HGtwGtjxEMCClZ3i6CK8XXWi7YNnqo9e1MXzwikY=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 22/51] vxlan: Use __register_netdevice in .newlink
Date: Sat, 22 Mar 2025 17:40:39 +0300
Message-ID: <174265443958.356712.14220813717462792006.stgit@pro.pro>
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

Also, use __unregister_netdevice() since we know
there is held lock in that path.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/net/vxlan/vxlan_core.c |   36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b041ddc2ab34..369f7b667424 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3950,7 +3950,7 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 			return err;
 	}
 
-	err = register_netdevice(dev);
+	err = __register_netdevice(dev);
 	if (err)
 		goto errout;
 	unregister = true;
@@ -4001,7 +4001,7 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 		__vxlan_fdb_free(f);
 unregister:
 	if (unregister)
-		unregister_netdevice(dev);
+		__unregister_netdevice(dev);
 	return err;
 }
 
@@ -4604,22 +4604,37 @@ struct net_device *vxlan_dev_create(struct net *net, const char *name,
 				    u8 name_assign_type,
 				    struct vxlan_config *conf)
 {
+	struct net_device *dev, *lowerdev = NULL;
 	struct nlattr *tb[IFLA_MAX + 1];
-	struct net_device *dev;
+	struct nd_lock *nd_lock;
 	int err;
 
 	memset(&tb, 0, sizeof(tb));
 
+	if (conf->remote_ifindex) {
+		lowerdev = __dev_get_by_index(net, conf->remote_ifindex);
+		if (!lowerdev)
+			return ERR_PTR(-ENODEV);
+	}
+
 	dev = rtnl_create_link(net, name, name_assign_type,
 			       &vxlan_link_ops, tb, NULL);
 	if (IS_ERR(dev))
 		return dev;
 
-	err = __vxlan_dev_create(net, dev, conf, NULL);
-	if (err < 0) {
-		free_netdev(dev);
-		return ERR_PTR(err);
+	if (lowerdev) {
+		lock_netdev(lowerdev, &nd_lock);
+		attach_nd_lock(dev, nd_lock);
+	} else {
+		err = -ENOMEM;
+		if (!attach_new_nd_lock(dev))
+			goto err_free;
+		lock_netdev(dev, &nd_lock);
 	}
+	err = __vxlan_dev_create(net, dev, conf, NULL);
+	if (err < 0)
+		goto err_detach;
+	unlock_netdev(nd_lock);
 
 	err = rtnl_configure_link(dev, NULL, 0, NULL);
 	if (err < 0) {
@@ -4631,6 +4646,13 @@ struct net_device *vxlan_dev_create(struct net *net, const char *name,
 	}
 
 	return dev;
+
+err_detach:
+	detach_nd_lock(dev);
+	unlock_netdev(nd_lock);
+err_free:
+	free_netdev(dev);
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(vxlan_dev_create);
 


