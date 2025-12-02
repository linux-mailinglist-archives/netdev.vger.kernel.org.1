Return-Path: <netdev+bounces-243218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43056C9BBBE
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 15:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8344B3A8474
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18346322551;
	Tue,  2 Dec 2025 14:12:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CFF3242D0;
	Tue,  2 Dec 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764684749; cv=none; b=t19Bt69b5tH7i6nGDL+oXZNwkgnyl0qNvbgm6zLb0MSUgMHJ96wl5//3oL40R4esh7MoH8lCG/LA71ycJH8e26X+EpoDwE++d52PrybsSfgh8ttKRTNNjajAcgZWNSkQ2VBs9CUnssKJnufD7FPG1yoVkQtaE01rYsxFihe5c10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764684749; c=relaxed/simple;
	bh=Opau1lbwtXaKHB0UFeBhFz3Jn34wsDPxA+9RsH25iaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgKjvKzBx+YOD5mp3127oLV10ysxOumSlYAvM5CskdS5exCBeyP/XPRtPnPpJcuB61zQnuClrijreDkOowmsOMqXgsV9jqXKBk7+LSo03n+l/EAuorAqXzUNzdCQI+RvdgxoQEuxchm3ybKNuVN3C5ri4+RUZlUPIJ5SjcacMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dLN4z5XZVzJ46bZ;
	Tue,  2 Dec 2025 22:12:19 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id C2B8040565;
	Tue,  2 Dec 2025 22:12:24 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Dec 2025 17:12:24 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>, Xiao Liang <shaw.leon@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Etienne Champetier <champetier.etienne@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 2/2] ipvlan: Take addr_lock in ipvlan_open()
Date: Tue, 2 Dec 2025 17:11:49 +0300
Message-ID: <20251202141149.4144248-3-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251202141149.4144248-1-skorodumov.dmitry@huawei.com>
References: <20251202141149.4144248-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)

It was forgotten to lock addrs in ipvlan_open().

Seems that code was initially written in assumption
that any address change occurs under rtnl_lock(). But
it's not true for the ipv6 case. So, we have to
take addr_lock in ipvlan_open().

Also, take the addrs_lock in ipvlan_close()

Fixes: 8230819494b3 ("ipvlan: use per device spinlock to protect addrs list updates")
Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
CC: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index c390f4241621..53d311af2f44 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -182,18 +182,18 @@ static void ipvlan_uninit(struct net_device *dev)
 static int ipvlan_open(struct net_device *dev)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
+	struct ipvl_port *port = ipvlan->port;
 	struct ipvl_addr *addr;
 
-	if (ipvlan->port->mode == IPVLAN_MODE_L3 ||
-	    ipvlan->port->mode == IPVLAN_MODE_L3S)
+	if (port->mode == IPVLAN_MODE_L3 || port->mode == IPVLAN_MODE_L3S)
 		dev->flags |= IFF_NOARP;
 	else
 		dev->flags &= ~IFF_NOARP;
 
-	rcu_read_lock();
+	spin_lock_bh(&port->addrs_lock);
 	list_for_each_entry_rcu(addr, &ipvlan->addrs, anode)
 		ipvlan_ht_addr_add(ipvlan, addr);
-	rcu_read_unlock();
+	spin_unlock_bh(&port->addrs_lock);
 
 	return 0;
 }
@@ -207,10 +207,10 @@ static int ipvlan_stop(struct net_device *dev)
 	dev_uc_unsync(phy_dev, dev);
 	dev_mc_unsync(phy_dev, dev);
 
-	rcu_read_lock();
+	spin_lock_bh(&ipvlan->port->addrs_lock);
 	list_for_each_entry_rcu(addr, &ipvlan->addrs, anode)
 		ipvlan_ht_addr_del(addr);
-	rcu_read_unlock();
+	spin_unlock_bh(&ipvlan->port->addrs_lock);
 
 	return 0;
 }
@@ -817,6 +817,8 @@ static int ipvlan_add_addr(struct ipvl_dev *ipvlan, void *iaddr, bool is_v6)
 {
 	struct ipvl_addr *addr;
 
+	assert_spin_locked(&ipvlan->port->addrs_lock);
+
 	addr = kzalloc(sizeof(struct ipvl_addr), GFP_ATOMIC);
 	if (!addr)
 		return -ENOMEM;
-- 
2.25.1


