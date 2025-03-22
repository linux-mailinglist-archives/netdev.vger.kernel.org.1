Return-Path: <netdev+bounces-176924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7529A6CB0D
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3384A3283
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB3C231A24;
	Sat, 22 Mar 2025 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="RrF8tCT2"
X-Original-To: netdev@vger.kernel.org
Received: from forward205a.mail.yandex.net (forward205a.mail.yandex.net [178.154.239.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E623230BFE;
	Sat, 22 Mar 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654899; cv=none; b=HLY6MXVjJKKSFzCS0rdmsx5vVNi1NYmej0LnKmRYhc0vxowaGQ7LoQPSvb678RGxibXNeMp1ky6hDo0t3DiPznC7N00qtfWGH3Mq7u6v+GpUSlGWmTIVe8ocJI4Y8JWGJT5k6kdQLCuJxiqBOfV5auTmRireLXzZz6Ypf5qXELA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654899; c=relaxed/simple;
	bh=BZ6b5ix0yW4k4uUo1bfPj64RMujkEgkmbMn8X2sy9oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOzy5mjLjHwrw5YDwJhmwlrdbjTw38d12nZj+9VqKBvvNufeK+yigmErKrzTG2WcYCMxmq9xJP5QC9usauFnKZhWo5Qmo5HILoEs3ZjlWH8NZygvviq8n+69HoQPyKasW7rChOstQYsXN71++z06bvCsg0XLrZhmztNiwQAGB+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=RrF8tCT2; arc=none smtp.client-ip=178.154.239.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward205a.mail.yandex.net (Yandex) with ESMTPS id E444266699;
	Sat, 22 Mar 2025 17:40:19 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:12a5:0:640:7a62:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 41D2647275;
	Sat, 22 Mar 2025 17:40:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id AeNPUSKLcW20-IxkrtWBG;
	Sat, 22 Mar 2025 17:40:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654411; bh=ihOqdVJ7xLtJJSTxOo94QY2KJsfJPmwm6+SFx40nNuY=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=RrF8tCT2geWojla1qGohD8ENjoyqLiZDZHQkZs850lCK4R31RioyjjXAek+jYlGLN
	 xGuuzvExKKrm2pErzjmtfO2n6Ky0h5erBl/Bamt0W7DP9D7ivZ5manoRCwgUHn+j1I
	 OyIDg2VAW5xBN8M0Q+FqVFQTm7QIUKo+Na9twCwU=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 18/51] qmi_wwan: Use __register_netdevice in .newlink
Date: Sat, 22 Mar 2025 17:40:10 +0300
Message-ID: <174265441009.356712.14099994401904581590.stgit@pro.pro>
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
 drivers/net/usb/qmi_wwan.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 4823dbdf5465..beec69580978 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -246,6 +246,7 @@ static int qmimux_register_device(struct net_device *real_dev, u8 mux_id)
 {
 	struct net_device *new_dev;
 	struct qmimux_priv *priv;
+	struct nd_lock *nd_lock;
 	int err;
 
 	new_dev = alloc_netdev(sizeof(struct qmimux_priv),
@@ -260,14 +261,23 @@ static int qmimux_register_device(struct net_device *real_dev, u8 mux_id)
 
 	new_dev->sysfs_groups[0] = &qmi_wwan_sysfs_qmimux_attr_group;
 
-	err = register_netdevice(new_dev);
-	if (err < 0)
+	err = -ENOMEM;
+
+	lock_netdev(real_dev, &nd_lock);
+	attach_nd_lock(new_dev, nd_lock);
+	err = __register_netdevice(new_dev);
+	if (err < 0) {
+		detach_nd_lock(new_dev);
+		unlock_netdev(nd_lock);
 		goto out_free_newdev;
+	}
 
 	/* Account for reference in struct qmimux_priv_priv */
 	dev_hold(real_dev);
 
 	err = netdev_upper_dev_link(real_dev, new_dev, NULL);
+	unlock_netdev(nd_lock);
+
 	if (err)
 		goto out_unregister_netdev;
 


