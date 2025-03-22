Return-Path: <netdev+bounces-176892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CAEA6CAD1
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A274B885B47
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132F22FF2B;
	Sat, 22 Mar 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="Zs6NuusP"
X-Original-To: netdev@vger.kernel.org
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795422E3F1;
	Sat, 22 Mar 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654488; cv=none; b=CJI6X7FUUbPW9Db3ttQetZEtu4NycNxxgFZyoio/ZnEeXq3Qaloyq+fEDfl6V/I5lq0wIIAoC7nA0ksRk2Udx+Y5qAHnOTtsGT4oiXwsRc+4skbS7/T1Kl0z5NRXqQ7Hk027+riT1NmWxwyoFtTSESxoD7iSOpdTABVngt90UqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654488; c=relaxed/simple;
	bh=4oqRBsh8PAS/72J5Xb8EK5WJXYuynRrsDY2X1QRTxWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6Hnx1ZlNDypbruGHBoRi6jFT5Nl2S3onKUSFjs/Wy2g+n7z/S4nUh1MoCLG1qz9F/aLcTqAI3FxO4qvrQNR/12lW147oR6RTlHw5bjNiYR+t/i28lQl89TXA7s3GH07DEpwGFFnNnmlOpw/o0UwinPp7nhvtXmn7NggN5iphho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=Zs6NuusP; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:1984:0:640:94c0:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id EF36160901;
	Sat, 22 Mar 2025 17:41:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id MfNQQmXLbqM0-d0Bncm3D;
	Sat, 22 Mar 2025 17:41:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654484; bh=9gZzFKDCFYzS9NYBBHssUj1R3BkShyNd5B0H8PIPmuk=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=Zs6NuusP1ZczUi+BdQmblcR0P99yHsUrumUFNaQbtwfIql2CyM52pb+c5UrKmX8on
	 2f/feE1sz5BJuebCtOkj6htVeK13BtefquTA4ZR/YSXynsyXo07cT79clH5/ZH0fg1
	 UgHvLIe4cAiU6Ai7fiuQBs7V6LqylmcObCaWRAsU=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 28/51] dsa: Use __register_netdevice()
Date: Sat, 22 Mar 2025 17:41:22 +0300
Message-ID: <174265448285.356712.5884355786188119373.stgit@pro.pro>
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

Inherit nd_lock from conduit during registration
of a new device.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/dsa/user.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index f5adfa1d978a..cc3e0006f953 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2686,6 +2686,7 @@ int dsa_user_create(struct dsa_port *port)
 	struct net_device *conduit = dsa_port_to_conduit(port);
 	struct dsa_switch *ds = port->ds;
 	struct net_device *user_dev;
+	struct nd_lock *nd_lock;
 	struct dsa_user_priv *p;
 	const char *name;
 	int assign_type;
@@ -2759,38 +2760,42 @@ int dsa_user_create(struct dsa_port *port)
 		dev_warn(ds->dev, "nonfatal error %d setting MTU to %d on port %d\n",
 			 ret, ETH_DATA_LEN, port->index);
 
-	ret = register_netdevice(user_dev);
+	lock_netdev(conduit, &nd_lock);
+	attach_nd_lock(user_dev, nd_lock);
+	ret = __register_netdevice(user_dev);
 	if (ret) {
 		netdev_err(conduit, "error %d registering interface %s\n",
 			   ret, user_dev->name);
-		rtnl_unlock();
+		detach_nd_lock(user_dev);
+		unlock_netdev(nd_lock);
 		goto out_phy;
 	}
 
+	ret = netdev_upper_dev_link(conduit, user_dev, NULL);
+	unlock_netdev(nd_lock);
+
+	if (ret)
+		goto out_unregister;
+
 	if (IS_ENABLED(CONFIG_DCB)) {
 		ret = dsa_user_dcbnl_init(user_dev);
 		if (ret) {
 			netdev_err(user_dev,
 				   "failed to initialize DCB: %pe\n",
 				   ERR_PTR(ret));
-			rtnl_unlock();
 			goto out_unregister;
 		}
 	}
 
-	ret = netdev_upper_dev_link(conduit, user_dev, NULL);
-
 	rtnl_unlock();
 
-	if (ret)
-		goto out_unregister;
-
 	return 0;
 
 out_unregister:
-	unregister_netdev(user_dev);
+	lock_netdev(user_dev, &nd_lock);
+	__unregister_netdevice(user_dev);
+	unlock_netdev(nd_lock);
 out_phy:
-	rtnl_lock();
 	phylink_disconnect_phy(p->dp->pl);
 	rtnl_unlock();
 	dsa_port_phylink_destroy(p->dp);


