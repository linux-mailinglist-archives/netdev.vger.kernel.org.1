Return-Path: <netdev+bounces-176915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C2CA6CAFF
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0529F8A6B1D
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC32343C0;
	Sat, 22 Mar 2025 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="NMWfN5wx"
X-Original-To: netdev@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3C22F3B8;
	Sat, 22 Mar 2025 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654659; cv=none; b=ZnpYQfNokDEU3ady7TsTWHV7cJrotm0nkygYMiUShw/otq2sE31Bzz9i6P6fwLPtHtoISvEO39DdMlk/gwpXd6aBYKs6mwl87kya/AxDysEanHfqO262te0hyb95X7z2B724AL39ejB9maAsDcPQpSPbt5DHeEaUue/7ioUb5y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654659; c=relaxed/simple;
	bh=SnU5Ht9TsLiDzaviTtqRFW16I2tMZ1pZKcgZJ195PaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZa2TavGokKOebMOPDuA9d1IF87JIsOvxCNdhsEB0PRKRrT696tskDnI7ATRaEfm61tDtMY34svI23oejV01pjwa/hnhgiCilp/Wvpx4kmTKT3LnDbpntgBSxIDk6Jm4qyyxDrHbfZgEcBKhrsTOZWqneuYMH1n3hlerj+iVACY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=NMWfN5wx; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:623d:0:640:ecee:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 06D1D472C1;
	Sat, 22 Mar 2025 17:44:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id BiN04tWLi8c0-bkYjLC7N;
	Sat, 22 Mar 2025 17:44:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654653; bh=fH/fdCxwL/fmSMccWa3vtCF1GXTjB4QRxvAlU5cdXe0=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=NMWfN5wxs6aNEvxxqfou5wys+o/wPm3O/g6UZScMHPcsbv+tJvbFPePO2NgMLCBDm
	 CeX371qJXzCCPqI1RmorHJGPfvaHe/7x5TueEVcLYAFWbOgumYF8tKPw5ly+Z/lCgj
	 xJ0Oge6tZn/Cg70M/ExBNwDelSuKwv/vORf9GewQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 51/51] net: Make all NETDEV_REGISTER events to be called under nd_lock
Date: Sat, 22 Mar 2025 17:44:11 +0300
Message-ID: <174265465165.356712.15647624986706115219.stgit@pro.pro>
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

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/core/dev.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c477b39d08b9..03c1bfa35309 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1737,13 +1737,19 @@ static void call_netdevice_unregister_notifiers(struct notifier_block *nb,
 }
 
 static int call_netdevice_register_net_notifiers(struct notifier_block *nb,
-						 struct net *net)
+						 struct net *net,
+						 bool locked)
 {
+	struct nd_lock *nd_lock;
 	struct net_device *dev;
 	int err;
 
 	for_each_netdev(net, dev) {
+		if (!locked)
+			lock_netdev(dev, &nd_lock);
 		err = call_netdevice_register_notifiers(nb, dev);
+		if (!locked)
+			unlock_netdev(nd_lock);
 		if (err)
 			goto rollback;
 	}
@@ -1794,7 +1800,7 @@ int register_netdevice_notifier(struct notifier_block *nb)
 	if (dev_boot_phase)
 		goto unlock;
 	for_each_net(net) {
-		err = call_netdevice_register_net_notifiers(nb, net);
+		err = call_netdevice_register_net_notifiers(nb, net, false);
 		if (err)
 			goto rollback;
 	}
@@ -1851,7 +1857,8 @@ EXPORT_SYMBOL(unregister_netdevice_notifier);
 
 static int __register_netdevice_notifier_net(struct net *net,
 					     struct notifier_block *nb,
-					     bool ignore_call_fail)
+					     bool ignore_call_fail,
+					     bool locked)
 {
 	int err;
 
@@ -1861,7 +1868,7 @@ static int __register_netdevice_notifier_net(struct net *net,
 	if (dev_boot_phase)
 		return 0;
 
-	err = call_netdevice_register_net_notifiers(nb, net);
+	err = call_netdevice_register_net_notifiers(nb, net, locked);
 	if (err && !ignore_call_fail)
 		goto chain_unregister;
 
@@ -1905,7 +1912,7 @@ int register_netdevice_notifier_net(struct net *net, struct notifier_block *nb)
 	int err;
 
 	rtnl_lock();
-	err = __register_netdevice_notifier_net(net, nb, false);
+	err = __register_netdevice_notifier_net(net, nb, false, false);
 	rtnl_unlock();
 	return err;
 }
@@ -1944,17 +1951,20 @@ static void __move_netdevice_notifier_net(struct net *src_net,
 					  struct notifier_block *nb)
 {
 	__unregister_netdevice_notifier_net(src_net, nb);
-	__register_netdevice_notifier_net(dst_net, nb, true);
+	__register_netdevice_notifier_net(dst_net, nb, true, true);
 }
 
 int register_netdevice_notifier_dev_net(struct net_device *dev,
 					struct notifier_block *nb,
 					struct netdev_net_notifier *nn)
 {
+	struct nd_lock *nd_lock;
 	int err;
 
 	rtnl_lock();
-	err = __register_netdevice_notifier_net(dev_net(dev), nb, false);
+	lock_netdev(dev, &nd_lock);
+	err = __register_netdevice_notifier_net(dev_net(dev), nb, false, true);
+	unlock_netdev(nd_lock);
 	if (!err) {
 		nn->nb = nb;
 		list_add(&nn->list, &dev->net_notifier_list);


