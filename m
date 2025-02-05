Return-Path: <netdev+bounces-163297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5019EA29DB8
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 00:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47093A62DE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96EB21D5BA;
	Wed,  5 Feb 2025 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="PZhpR7SB"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6C621CFF7
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738799743; cv=none; b=P8xj4jLusbcJeMVcpqbT6QfgMaSjBNW+ZszQjm9+8q/0aSZ3EzzJAp38xgRQsLq9NDTD2l5TC9WR9a7XXiO42TPnN/DhblB5n3HhAh3eEkhseeIFd5S3yd25DItsLfxMoaCpW6iY9fmvAZsM8F9JLQZMc+epu8VMxwiqnX5V9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738799743; c=relaxed/simple;
	bh=L08TZ9RpNmi+x/IdUXb8eidlEjv5+L8tUZcf5BJpD8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AH0Y4lnpheLkgf69g6Qys5bQ5bkTeA3XAxuj/FZy2hModeWxFv1bfSos4M40WRR6BeTnN9He5GY7ahqW6pjAC+tgRvzEkwLs91pKIQIQ6qpgZBoj1Z7D+mXd1WLBm8wRbmVmv6KrUAbFjLBfbq3rBETuIEgPbjJIYdHyyFGjw/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=PZhpR7SB; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3683; q=dns/txt; s=iport;
  t=1738799742; x=1740009342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hvqnlDFlUi3xw4a2mfiWeT8OZXsi00Zent/nqydLOWY=;
  b=PZhpR7SB0aaSdGnIXsb/NRPDNzDsdYYbrBQjLBTSMes5iF2i7WL65iGz
   Cyke4wTowkKPr8HPGyzDqBWk+HBZ+ysh0VOtwZpx+a5YC/lJdgty4UDLN
   mESX3n0p+uR13ZHEq00J4BAzc16Z4Kw+Exd4l2Su4RHCJzaSRqOQt5aqT
   I=;
X-CSE-ConnectionGUID: 90RPj8JvSaKkFCYrQP1nNg==
X-CSE-MsgGUID: NkwwAwdqTnCwWvghFa+uEw==
X-IPAS-Result: =?us-ascii?q?A0A8AABv+aNn/4z/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYICAwEBAQsBgkqBT0NIjVGoMANWDwEBAQ9EBAEBhQcCiwACJjcGDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThgiGWwIBAycLAUYQU?=
 =?us-ascii?q?SsrBxKDAoJlA7BRgXkzgQHeNIFugUgBhWuHX3CEdycbgUlEhH2LBwSDb4Nvg?=
 =?us-ascii?q?WyKbh0vgimTJUiBIQNZLAFVEw0KCwcFgTk4AyAKCwwLFBwVAhQdDwYQBGpEN?=
 =?us-ascii?q?4JHaUk6Ag0CNYIeJFiCK4RahEOETYJDVIJEghJ0gRqIPEADCxgNSBEsNwYOG?=
 =?us-ascii?q?wY+bgedTTyEEAeBD4Iok2mSIaEEhCWBY59jGjOqU5h8IqQmhGaBfSaBWTMaC?=
 =?us-ascii?q?BsVgyJSGQ+OLRbMJiUyPAIHCwEBAwmRfAEB?=
IronPort-Data: A9a23:aNDo36DkMQF+ExVW/wviw5YqxClBgxIJ4kV8jS/XYbTApG93g2ADz
 GcdXmmHOa7ZZmvyfIgjaNyxoB4C65/UmNVhOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZsCCeB/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gWGthh
 fuo+5eCYAX9hmYuWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEkq1UNENmH5Mj88V0L0p/7
 8UgcTYrYUXW7w626OrTpuhEnM8vKozveYgYoHwllWqfBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGY3BPjDS0Un1lM/CpU+muuhgnTXeDxDo1XTrq0yi4TW5FcojOezbYGMI7RmQ+1znVmHj
 33K5lj/KQ4lKtOf5zPG71+z07qncSTTHdh6+KeD3vJjnlCW7mAaFhATUVy1vb+/h1LWc99TN
 kkd6Ccyhac180OvQ5/2WBjQiH2ZtBc0WNdKFeA+rgaXxcL86gCVHGUbDThMdNArqucyWDosk
 FSJ9/vxDDZitry9U3+R9r6I6zi1PEA9K2IeaSIaZRUK7sOlo4wpiB/LCNF5H8aIYsbdAzr8x
 XWO6SM5nbhW1ZVN3KSg9leBiDWpznTUcjMICszsdjrNxmtEiESNPuRENXCzAS58Ebuk
IronPort-HdrOrdr: A9a23:vW11dahG11FqlwzYnikSRmKcMXBQXt0ji2hC6mlwRA09TyVXra
 +TdZMgpHjJYVkqOU3I9ersBEDEewK/yXcX2/h0AV7dZmnbUQKTRekIh7cKgQeQfhEWndQy6U
 4PScRD4aXLfDtHZQKQ2njALz7mq+P3lpyVuQ==
X-Talos-CUID: =?us-ascii?q?9a23=3Au78mMWmek0mA/NEpt0KMCOx7V6vXOSyF9k/Sc22?=
 =?us-ascii?q?mMm9KS5O+eEWpwPpitcU7zg=3D=3D?=
X-Talos-MUID: 9a23:AJsD/QSyylJJyVkbRXTKhy59Hdhk+pioI18yj5oGlcDHKAFvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,262,1732579200"; 
   d="scan'208";a="314765311"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 Feb 2025 23:54:33 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTP id 91418180001FB;
	Wed,  5 Feb 2025 23:54:33 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 65D1B20F2003; Wed,  5 Feb 2025 15:54:33 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v8 4/4] enic: remove copybreak tunable
Date: Wed,  5 Feb 2025 15:54:16 -0800
Message-Id: <20250205235416.25410-5-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250205235416.25410-1-johndale@cisco.com>
References: <20250205235416.25410-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-03.cisco.com

With the move to using the Page Pool API for RX, rx copybreak was not
showing any improvement in host CPU overhead, latency or bandwidth so
the driver no longer makes use of the rx_copybreak setting. This patch
removes the ethtool tuneable hooks to set and get the rx copybreak since
they and now no-ops. Rx copybreak was the only tunable supported, so
remove the set and get tunable callbacks all together.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h        |  1 -
 .../net/ethernet/cisco/enic/enic_ethtool.c    | 39 -------------------
 drivers/net/ethernet/cisco/enic/enic_main.c   |  3 --
 3 files changed, 43 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 2ccf2d2a77db..305ed12aa031 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -226,7 +226,6 @@ struct enic {
 	unsigned int cq_avail;
 	unsigned int cq_count;
 	struct enic_rfs_flw_tbl rfs_h;
-	u32 rx_copybreak;
 	u8 rss_key[ENIC_RSS_LEN];
 	struct vnic_gen_stats gen_stats;
 };
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index d607b4f0542c..18b929fc2879 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -608,43 +608,6 @@ static int enic_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	return ret;
 }
 
-static int enic_get_tunable(struct net_device *dev,
-			    const struct ethtool_tunable *tuna, void *data)
-{
-	struct enic *enic = netdev_priv(dev);
-	int ret = 0;
-
-	switch (tuna->id) {
-	case ETHTOOL_RX_COPYBREAK:
-		*(u32 *)data = enic->rx_copybreak;
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static int enic_set_tunable(struct net_device *dev,
-			    const struct ethtool_tunable *tuna,
-			    const void *data)
-{
-	struct enic *enic = netdev_priv(dev);
-	int ret = 0;
-
-	switch (tuna->id) {
-	case ETHTOOL_RX_COPYBREAK:
-		enic->rx_copybreak = *(u32 *)data;
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
 static u32 enic_get_rxfh_key_size(struct net_device *netdev)
 {
 	return ENIC_RSS_LEN;
@@ -727,8 +690,6 @@ static const struct ethtool_ops enic_ethtool_ops = {
 	.get_coalesce = enic_get_coalesce,
 	.set_coalesce = enic_set_coalesce,
 	.get_rxnfc = enic_get_rxnfc,
-	.get_tunable = enic_get_tunable,
-	.set_tunable = enic_set_tunable,
 	.get_rxfh_key_size = enic_get_rxfh_key_size,
 	.get_rxfh = enic_get_rxfh,
 	.set_rxfh = enic_set_rxfh,
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 447c54dcd89b..f24fd29ea207 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -69,8 +69,6 @@
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_DYN     0x0044  /* enet dynamic vnic */
 #define PCI_DEVICE_ID_CISCO_VIC_ENET_VF      0x0071  /* enet SRIOV VF */
 
-#define RX_COPYBREAK_DEFAULT		256
-
 /* Supported devices */
 static const struct pci_device_id enic_id_table[] = {
 	{ PCI_VDEVICE(CISCO, PCI_DEVICE_ID_CISCO_VIC_ENET) },
@@ -2972,7 +2970,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_err(dev, "Cannot register net device, aborting\n");
 		goto err_out_dev_deinit;
 	}
-	enic->rx_copybreak = RX_COPYBREAK_DEFAULT;
 
 	return 0;
 
-- 
2.44.0


