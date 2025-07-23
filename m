Return-Path: <netdev+bounces-209312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D138B0F002
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A571AA7EAD
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865712D8383;
	Wed, 23 Jul 2025 10:37:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C1F28C016;
	Wed, 23 Jul 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267034; cv=none; b=EDP03KKq/O6Q/1MktWgI9htG6x3obuYJv8JLivsw5vbjUF7wISsHrg1S7fR6CHGI2FLO+gWX9OyxaAhQstmq4BX0lQ0vrAFhFssr4C+mwiVQZaH0e5Ki/9QBSWUQ5xHOBgiBFjFABC6EEVNP98Bxq2nCfJN6qbtCsfud/fzFHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267034; c=relaxed/simple;
	bh=uMba/ezhAC8r5pyu8vjGDcLH/UWyJZSzahC5FZcfZPY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qh8b6HXrH9iFNJLcYEgSN538zNKBU5Bpbqv4rc6V8H5cfPm3+Lci7e0DHxuysD8OLK6PtUFcLoR539d4XpNqJRChIWjTHiXkyrrLRu3434LRXVGwY54+WT1auzqcAhQkzfA9L0cHKaDx+K8diiyrmDMoPb4qYkvaR6n6F91f3sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E96C41A167A;
	Wed, 23 Jul 2025 12:37:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AC5F11A167C;
	Wed, 23 Jul 2025 12:37:10 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8BEEC1800079;
	Wed, 23 Jul 2025 18:37:08 +0800 (+08)
From: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
To: davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kuba@kernel.org,
	n.zhandarovich@fintech.ru,
	edumazet@google.com,
	pabeni@redhat.com,
	wojciech.drewek@intel.com,
	Arvid.Brodin@xdin.com,
	horms@kernel.org,
	lukma@denx.de,
	m-karicheri2@ti.com,
	xiaoliang.yang_1@nxp.com,
	vladimir.oltean@nxp.com
Subject: [RFC PATCH net-next] net: hsr: create an API to get hsr port type
Date: Wed, 23 Jul 2025 18:47:54 +0800
Message-Id: <20250723104754.29926-1-xiaoliang.yang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

If a switch device has HSR hardware ability and HSR configuration
offload to hardware. The device driver needs to get the HSR port type
when joining the port to HSR. Different port types require different
settings for the hardware, like HSR_PT_SLAVE_A, HSR_PT_SLAVE_B, and
HSR_PT_INTERLINK. Create the API hsr_get_port_type() and export it.

When the hsr_get_port_type() is called in the device driver, if the port
can be found in the HSR port list, the HSR port type can be obtained.
Therefore, before calling the device driver, we need to first add the
hsr_port to the HSR port list.

Signed-off-by: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
---
 include/linux/if_hsr.h |  8 ++++++++
 net/hsr/hsr_device.c   | 20 ++++++++++++++++++++
 net/hsr/hsr_slave.c    |  7 ++++---
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index d7941fd88032..4d6452ca2ac8 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -43,6 +43,8 @@ extern bool is_hsr_master(struct net_device *dev);
 extern int hsr_get_version(struct net_device *dev, enum hsr_version *ver);
 struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 				     enum hsr_port_type pt);
+extern int hsr_get_port_type(struct net_device *hsr_dev, struct net_device *dev,
+			     enum hsr_port_type *type);
 #else
 static inline bool is_hsr_master(struct net_device *dev)
 {
@@ -59,6 +61,12 @@ static inline struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static inline int hsr_get_port_type(struct net_device *hsr_dev, struct net_device *dev,
+				    enum hsr_port_type *type)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_HSR */
 
 #endif /*_LINUX_IF_HSR_H_*/
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 88657255fec1..d4bea847527c 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -679,6 +679,26 @@ struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 }
 EXPORT_SYMBOL(hsr_get_port_ndev);
 
+/* Get hsr port type, return -EINVAL if not get.
+ */
+int hsr_get_port_type(struct net_device *hsr_dev, struct net_device *dev, enum hsr_port_type *type)
+{
+	struct hsr_priv *hsr;
+	struct hsr_port *port;
+
+	hsr = netdev_priv(hsr_dev);
+
+	hsr_for_each_port(hsr, port) {
+		if (port->dev == dev) {
+			*type = port->type;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hsr_get_port_type);
+
 /* Default multicast address for HSR Supervision frames */
 static const unsigned char def_multicast_addr[ETH_ALEN] __aligned(2) = {
 	0x01, 0x15, 0x4e, 0x00, 0x01, 0x00
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index b87b6a6fe070..e11ab1ed3320 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -198,14 +198,14 @@ int hsr_add_port(struct hsr_priv *hsr, struct net_device *dev,
 	port->type = type;
 	ether_addr_copy(port->original_macaddress, dev->dev_addr);
 
+	list_add_tail_rcu(&port->port_list, &hsr->ports);
+
 	if (type != HSR_PT_MASTER) {
 		res = hsr_portdev_setup(hsr, dev, port, extack);
 		if (res)
 			goto fail_dev_setup;
 	}
 
-	list_add_tail_rcu(&port->port_list, &hsr->ports);
-
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	netdev_update_features(master->dev);
 	dev_set_mtu(master->dev, hsr_get_max_mtu(hsr));
@@ -213,7 +213,8 @@ int hsr_add_port(struct hsr_priv *hsr, struct net_device *dev,
 	return 0;
 
 fail_dev_setup:
-	kfree(port);
+	list_del_rcu(&port->port_list);
+	kfree_rcu(port, rcu);
 	return res;
 }
 
-- 
2.17.1


