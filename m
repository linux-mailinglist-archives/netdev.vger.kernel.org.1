Return-Path: <netdev+bounces-235855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E6EC36A16
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D38648409
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7703376A2;
	Wed,  5 Nov 2025 16:08:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5B4334697;
	Wed,  5 Nov 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358886; cv=none; b=p2ZVQHzUjSdMRVedi5ry0V/WV8i4ltseRlUNl/7HHtRK8r+fSj6GATz5p9jDqHC9qiteL9oJJOt44cH2NWvAp6VvSgFWw3aFM/jvdtIFDcrR/3gZjkHx8ff0obuClxGJMBcjUBAKSOkPZZKAyJKeM6FYg7bOiCxKyBdRHJkGVy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358886; c=relaxed/simple;
	bh=9iCmoKz8VS8ZHBtPbf6AzTQdl2DWKpsH8jx3V3QuU1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sY8h+Y6+4sUp/vHDlbEyeT//q998dHkptMaGRQwwaOzdXxxbmF+3mBZiG4naQ+QgHpMIIGkqxmjBS96K1C1pb1ncs1TjqVFyUROpeqhfYZSk7iqndzmVExT/T9BIyZP8PdRzrzi77vvtlCkjZk3ry1p5tVOqgiPm58cPJCq6BH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1qwY2yYzzJ46F8;
	Thu,  6 Nov 2025 00:07:41 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id BC1411400DB;
	Thu,  6 Nov 2025 00:08:02 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 19:08:02 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 09/14] ipvlan: Take addr_lock in ipvlan_open()
Date: Wed, 5 Nov 2025 19:07:13 +0300
Message-ID: <20251105160713.1727206-10-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105160713.1727206-1-skorodumov.dmitry@huawei.com>
References: <20251105160713.1727206-1-skorodumov.dmitry@huawei.com>
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

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 56f65ac8ecef..b888c2ef77ca 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -286,20 +286,20 @@ static void ipvlan_uninit(struct net_device *dev)
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


