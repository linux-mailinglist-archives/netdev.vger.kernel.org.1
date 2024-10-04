Return-Path: <netdev+bounces-131890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B4098FE08
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59D4281A77
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 07:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA313D50C;
	Fri,  4 Oct 2024 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dOSBo2JO"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5D13C67E;
	Fri,  4 Oct 2024 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028062; cv=none; b=rCXH2vu4gmD27UqQUO/GH2vWktME9msW1Z5LIFmmmMJ7dcC6XOmYJ5kS0LkopPVwhmOYMG/yAhs87wrcUKrOqAvoZXwKPvIZ9M+NZ85AHmaD6ejqCOw0eiv+hLKunp2zQWrjkgKweCDtgJ7jllzAovdSWUyfpCgZ74P50nvHQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028062; c=relaxed/simple;
	bh=ogfnyn8aVbdggxX75dDOrXpLj11g/IYarkUdcl1wQhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8lW6H6AqRFG8GGzZQXM0L0xNUpMBSZVQtv0ww+WBr4W29oboDtE0gkXCM3VnyKGipchb56kNOT6o74kCtv0+x8LVMe7o0PFQtxw++rkH+3wWf76IcjzzaKmqPXAbh8q5L7rRRM0ZL1vkKjdlygCQL2AWBCScPm/jznI7uFOSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dOSBo2JO; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4947lNMB029268;
	Fri, 4 Oct 2024 02:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728028043;
	bh=woTUeDDLgwnt6UPisVy+wckTDC3lNRN7L3Z6YUqS/fI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dOSBo2JOWMiDNbEnPuzEsSXqSiXIoTYjc/A3Pw9MTNNhi+CQLPK9d/A/CRq5xMRFd
	 Uqbtl5esZAmU4/yI29mza00AFbhr65JV6cJX0oxfRjnJPc1HVctaR9l1GJT16RjfH2
	 wXN0KfR3aah7oKgfEG7sbJ+olvr0N7fut0CTE3Ow=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4947lNUI005545
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Oct 2024 02:47:23 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 02:47:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 02:47:23 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4947lN77010961;
	Fri, 4 Oct 2024 02:47:23 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4947lMIC025148;
	Fri, 4 Oct 2024 02:47:22 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <jiri@resnulli.us>, <aleksander.lobakin@intel.com>, <lukma@denx.de>,
        <horms@kernel.org>, <robh@kernel.org>, <jan.kiszka@siemens.com>,
        <dan.carpenter@linaro.org>, <diogo.ivo@siemens.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next 3/3] net: ti: icssg-prueth: Add VLAN support for HSR mode
Date: Fri, 4 Oct 2024 13:17:15 +0530
Message-ID: <20241004074715.791191-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004074715.791191-1-danishanwar@ti.com>
References: <20241004074715.791191-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Ravi Gunasekaran <r-gunasekaran@ti.com>

Add support for VLAN addition/deletion in HSR mode.
In HSR mode, even if the host port is not a member of
the VLAN domain, the slave ports should simply forward the
frames. So allow forwarding of all VLAN frames in HSR mode.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 45 +++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 5fd9902ab181..a740ce084e21 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -808,6 +808,47 @@ static netdev_features_t emac_ndo_fix_features(struct net_device *ndev,
 	return features;
 }
 
+static int emac_ndo_vlan_rx_add_vid(struct net_device *ndev,
+				    __be16 proto, u16 vid)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	int untag_mask = 0;
+	int port_mask;
+
+	if (prueth->is_hsr_offload_mode) {
+		port_mask = BIT(PRUETH_PORT_HOST) | BIT(emac->port_id);
+		untag_mask = 0;
+
+		netdev_dbg(emac->ndev, "VID add vid:%u port_mask:%X untag_mask %X\n",
+			   vid, port_mask, untag_mask);
+
+		icssg_vtbl_modify(emac, vid, port_mask, untag_mask, true);
+		icssg_set_pvid(emac->prueth, vid, emac->port_id);
+	}
+	return 0;
+}
+
+static int emac_ndo_vlan_rx_del_vid(struct net_device *ndev,
+				    __be16 proto, u16 vid)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	int untag_mask = 0;
+	int port_mask;
+
+	if (prueth->is_hsr_offload_mode) {
+		port_mask = BIT(PRUETH_PORT_HOST);
+		untag_mask = 0;
+
+		netdev_dbg(emac->ndev, "VID del vid:%u port_mask:%X untag_mask  %X\n",
+			   vid, port_mask, untag_mask);
+
+		icssg_vtbl_modify(emac, vid, port_mask, untag_mask, false);
+	}
+	return 0;
+}
+
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open = emac_ndo_open,
 	.ndo_stop = emac_ndo_stop,
@@ -820,6 +861,8 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_get_stats64 = icssg_ndo_get_stats64,
 	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
 	.ndo_fix_features = emac_ndo_fix_features,
+	.ndo_vlan_rx_add_vid = emac_ndo_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = emac_ndo_vlan_rx_del_vid,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -947,7 +990,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->netdev_ops = &emac_netdev_ops;
 	ndev->ethtool_ops = &icssg_ethtool_ops;
 	ndev->hw_features = NETIF_F_SG;
-	ndev->features = ndev->hw_features;
+	ndev->features = ndev->hw_features | NETIF_F_HW_VLAN_CTAG_FILTER;
 	ndev->hw_features |= NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
 
 	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
-- 
2.34.1


