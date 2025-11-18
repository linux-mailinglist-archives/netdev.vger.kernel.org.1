Return-Path: <netdev+bounces-239482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C69B5C68B10
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D68492AAE2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0A8330B2E;
	Tue, 18 Nov 2025 10:01:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505232692B;
	Tue, 18 Nov 2025 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460063; cv=none; b=s4t83V6eiVfJYy58AI1zG2F+Rlghs8L0pusHDCtx2sZzFKrQrnKwcQYlpxUBgmXJ6fXEzcQwIlSDO8l1rg6ZdHrb+7YfXL6yKFiB0u6eopjXM1bb3sXCwK3BmnVB1nUVMeX8eeYxgg2TCCWmVUIb8PsaiDzYfSPMWBDHVf+PV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460063; c=relaxed/simple;
	bh=pvvHMJpaZfgOBPvxkdzAShg0wZgnVhNqJcNVKBNDA3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/udKjqltf91pnPxKjO5zL7YusMFpJ2QiXjVFkKCxVbjFsctY2ibw3WbwjQiwbdCk86hgp82mGQ0ogfRvOCxtivXh+CYCoMPDo52WOvHepiWG3redntUV0raBCkms9PphUJ3zL9+1+t/omLsafvnapLxgiRq6NDV/thrhwJI6wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d9g8s45sDzHnHCX;
	Tue, 18 Nov 2025 18:00:29 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D2CD140446;
	Tue, 18 Nov 2025 18:01:00 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 13:00:59 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, <edumazet@google.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 07/13] ipvlan: Take addr_lock in ipvlan_open()
Date: Tue, 18 Nov 2025 13:00:39 +0300
Message-ID: <20251118100046.2944392-8-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
References: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500004.china.huawei.com (7.188.26.250)

It was forgotten to lock addrs in ipvlan_open().

Seems that code was initially written in assumption
that any address change occurs under rtnl_lock(). But
it's not true for the ipv6 case. So, we have to
take addr_lock in ipvlan_open().

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index c1df97a88a40..27d289aadef1 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -262,20 +262,20 @@ static void ipvlan_uninit(struct net_device *dev)
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
 
 	/* for learnable, addresses will be obtained from tx-packets. */
-	if (!ipvlan_is_macnat(ipvlan->port)) {
-		rcu_read_lock();
+	if (!ipvlan_is_macnat(port)) {
+		spin_lock_bh(&port->addrs_lock);
 		list_for_each_entry_rcu(addr, &ipvlan->addrs, anode)
 			ipvlan_ht_addr_add(ipvlan, addr);
-		rcu_read_unlock();
+		spin_unlock_bh(&port->addrs_lock);
 	}
 
 	return 0;
-- 
2.25.1


