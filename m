Return-Path: <netdev+bounces-176903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75B0A6CAEF
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512B68A3660
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A846F235BE1;
	Sat, 22 Mar 2025 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="srrIN8p4"
X-Original-To: netdev@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9233233D72;
	Sat, 22 Mar 2025 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654568; cv=none; b=enHHJePBdJBJeIw9xUwym9g0P7eSAz0YarZo7B2+R3oSbb246FwyJctUaYVhhiUlA07AXyVnWBVQ8kRmyYBntLhjVABK9cSBFKKZEmN2u34izxyAf1SkTeNbebOj5yRDdVfN7Q+9a0Uwt1CZp4Px/g7MazM76X2ZHedS5qeCU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654568; c=relaxed/simple;
	bh=iTRy2VIM8p47pAEvF3DWtaBqQRveDxM9BrRpvAt//4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSHs8Ca0oaOpPHk5vJ1ojVOSGNQYodO2/QWU4xczyiyEIXST3eREt68nuX+jtF70EBkfiCD0Q2XzJlwkDiNF9gKPF5kBMM6pEyHPCoRqwH2pRIsus+AhhIdlW3RMmYgTRrbaFF4MliLRT/gA8pwolEHTHWq9lrozR9L0LDcfo20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=srrIN8p4; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:5b1c:0:640:ee42:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 1703360C65;
	Sat, 22 Mar 2025 17:42:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id hgNms1XLleA0-zYT0AMYA;
	Sat, 22 Mar 2025 17:42:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654564; bh=ThZwuO4/tMm9BfSylT+D6LsLzq0a9vwtjJg59coZ8qI=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=srrIN8p4SitDxaaKNtUQbDlr89ITE/c8i/wzAc81AP6KCd4kYa2bzk0zPzL/Ui/WX
	 7MoQDU4A4L8UttqyC/PG9IIo4AXHoLA/eevBJeztNiBg4RG9vbyDnHWJzOTBATfIre
	 mC00HW6IDDNVc25Il6c7gT0G/v6EI0nRwRZEhRWY=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 39/51] netvsc: Make joined device to share master's nd_lock
Date: Sat, 22 Mar 2025 17:42:43 +0300
Message-ID: <174265456307.356712.11381775975226010571.stgit@pro.pro>
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

We don't want to do that from netvsc_netdev_event() since
we want to make netdevice notifiers be called under nd_lock
in future.

Also see comments in patch introducing schedule_delayed_event()

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/net/hyperv/netvsc_drv.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 44142245343d..be8038e6393f 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2192,6 +2192,7 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 			  struct net_device *ndev, int context)
 {
 	struct net_device_context *ndev_ctx = netdev_priv(ndev);
+	struct nd_lock *nd_lock, *nd_lock2;
 	int ret;
 
 	ret = netdev_rx_handler_register(vf_netdev,
@@ -2203,8 +2204,12 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto rx_handler_failed;
 	}
 
+	double_lock_netdev(ndev, &nd_lock, vf_netdev, &nd_lock2);
+	nd_lock_transfer_devices(&nd_lock, &nd_lock2);
+
 	ret = netdev_master_upper_dev_link(vf_netdev, ndev,
 					   NULL, NULL, NULL);
+	double_unlock_netdev(nd_lock, nd_lock2);
 	if (ret != 0) {
 		netdev_err(vf_netdev,
 			   "can not set master device %s (err = %d)\n",
@@ -2797,6 +2802,20 @@ static struct  hv_driver netvsc_drv = {
 	},
 };
 
+static void call_netvsc_register(struct net_device *dev)
+{
+	unsigned long event;
+
+	rtnl_lock();
+	netvsc_prepare_bonding(dev);
+	netvsc_register_vf(dev, VF_REG_IN_NOTIFIER);
+	event = NETDEV_GOING_DOWN;
+	if (netif_running(dev))
+		event = NETDEV_CHANGE;
+	netvsc_vf_changed(dev, event);
+	rtnl_unlock();
+}
+
 /*
  * On Hyper-V, every VF interface is matched with a corresponding
  * synthetic interface. The synthetic interface is presented first
@@ -2814,10 +2833,10 @@ static int netvsc_netdev_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	switch (event) {
-	case NETDEV_POST_INIT:
-		return netvsc_prepare_bonding(event_dev);
 	case NETDEV_REGISTER:
-		return netvsc_register_vf(event_dev, VF_REG_IN_NOTIFIER);
+		return schedule_delayed_event(event_dev,
+					      call_netvsc_register);
+		return NOTIFY_DONE;
 	case NETDEV_UNREGISTER:
 		return netvsc_unregister_vf(event_dev);
 	case NETDEV_UP:


