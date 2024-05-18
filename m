Return-Path: <netdev+bounces-97099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AA48C9121
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE4EEB214A5
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A343678C98;
	Sat, 18 May 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jMB/r8r2"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B0C78C70;
	Sat, 18 May 2024 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036286; cv=none; b=U81eGauAy7tyaOrT7WtPorWYYkPMs17h4fZidPo2QtnvZg1dli1qFwNzTIT4oWXbIIHQQAsy7zg7UNLoJ9+3SZcM4uDFT0Zq90FsAbCC1i64+jlVj9dG/AXeE2hVU/pBBR5M/jL+exAYzSQdmZRKHKo1rEj2PL3G5ADgS3O9Z+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036286; c=relaxed/simple;
	bh=i5Rd3pPxPnww42sxf22pzP0ZZOno9q5S9lWTpp/rxM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1OSDdEpg2pEOgJCzZpD6vtraF1QsZIzL81tPsa7h1WMlDnwbr8glj0kpMRebjVBbDUAr3DX2wWcNOYzNj6rWOFuBh6B9ufZdOYmeSys0u0dOsf6mnr/+8ikKa5Y8It2lUx/VBLhedrv8riU4QqLtZO8+m99+hlwvkEW+qci0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jMB/r8r2; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICiTgX002883;
	Sat, 18 May 2024 07:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036269;
	bh=QVXXevX2p35Tc0MKEUXQO7615FHZ3IeMDwxKByj5l54=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jMB/r8r2dtWaVBFxKclXHnSN+aMzyXYmIohPK275YdeF5dMkBqKxpTQ+93MTFqr5w
	 SYJ6wUJyvtNr/53azwxvkvOEaBHhEtwpqhNMLWcrgFWN7aRC0q2FMd6YmfQo/CNFPG
	 6nOzjQnKwwlEVunXsNfMBFyyquDlihffub5KiDSI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICiTQH130389
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:44:29 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:44:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:44:29 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9e041511;
	Sat, 18 May 2024 07:44:25 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 24/28] net: ethernet: ti: cpsw-proxy-client: export coalescing support
Date: Sat, 18 May 2024 18:12:30 +0530
Message-ID: <20240518124234.2671651-25-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240518124234.2671651-1-s-vadapalli@ti.com>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Export coalescing support via ethtool ops.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 86 +++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 408c9f78c059..b42be0d389b8 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -1253,8 +1253,94 @@ static u32 vport_get_link(struct net_device *ndev)
 	return link_up;
 }
 
+static int vport_get_coal(struct net_device *ndev, struct ethtool_coalesce *coal,
+			  struct kernel_ethtool_coalesce *kernel_coal,
+			  struct netlink_ext_ack *extack)
+{
+	struct virtual_port *vport = vport_ndev_to_vport(ndev);
+
+	coal->tx_coalesce_usecs = vport->tx_chans[0].tx_pace_timeout / 1000;
+	coal->rx_coalesce_usecs = vport->rx_chans[0].rx_pace_timeout / 1000;
+	return 0;
+}
+
+static int vport_set_coal(struct net_device *ndev, struct ethtool_coalesce *coal,
+			  struct kernel_ethtool_coalesce *kernel_coal,
+			  struct netlink_ext_ack *extack)
+{
+	struct virtual_port *vport = vport_ndev_to_vport(ndev);
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	struct device *dev = proxy_priv->dev;
+	u32 i;
+
+	if (coal->tx_coalesce_usecs && coal->tx_coalesce_usecs < 20) {
+		dev_err(dev, "TX coalesce must be at least 20 usecs. Defaulting to 20 usecs\n");
+		coal->tx_coalesce_usecs = 20;
+	}
+
+	if (coal->rx_coalesce_usecs && coal->rx_coalesce_usecs < 20) {
+		dev_err(dev, "RX coalesce must be at least 20 usecs. Defaulting to 20 usecs\n");
+		coal->rx_coalesce_usecs = 20;
+	}
+
+	/* Since it is possible to set pacing values per TX and RX queue, if per queue value is
+	 * not specified, apply it to all available TX and RX queues.
+	 */
+
+	for (i = 0; i < vport->num_tx_chan; i++)
+		vport->tx_chans[i].tx_pace_timeout = coal->tx_coalesce_usecs * 1000;
+
+	for (i = 0; i < vport->num_rx_chan; i++)
+		vport->rx_chans[i].rx_pace_timeout = coal->rx_coalesce_usecs * 1000;
+
+	return 0;
+}
+
+static int vport_get_per_q_coal(struct net_device *ndev, u32 q,
+				struct ethtool_coalesce *coal)
+{
+	struct virtual_port *vport = vport_ndev_to_vport(ndev);
+
+	if (q >= vport->num_tx_chan || q >= vport->num_rx_chan)
+		return -EINVAL;
+
+	coal->tx_coalesce_usecs = vport->tx_chans[q].tx_pace_timeout / 1000;
+	coal->rx_coalesce_usecs = vport->rx_chans[q].rx_pace_timeout / 1000;
+
+	return 0;
+}
+
+static int vport_set_per_q_coal(struct net_device *ndev, u32 q,
+				struct ethtool_coalesce *coal)
+{	struct virtual_port *vport = vport_ndev_to_vport(ndev);
+	struct device *dev = vport->proxy_priv->dev;
+
+	if (q >= vport->num_tx_chan || q >= vport->num_rx_chan)
+		return -EINVAL;
+
+	if (coal->tx_coalesce_usecs && coal->tx_coalesce_usecs < 20) {
+		dev_err(dev, "TX coalesce must be at least 20 usecs. Defaulting to 20 usecs\n");
+		coal->tx_coalesce_usecs = 20;
+	}
+
+	if (coal->rx_coalesce_usecs && coal->rx_coalesce_usecs < 20) {
+		dev_err(dev, "RX coalesce must be at least 20 usecs. Defaulting to 20 usecs\n");
+		coal->rx_coalesce_usecs = 20;
+	}
+
+	vport->tx_chans[q].tx_pace_timeout = coal->tx_coalesce_usecs * 1000;
+	vport->rx_chans[q].rx_pace_timeout = coal->rx_coalesce_usecs * 1000;
+
+	return 0;
+}
+
 const struct ethtool_ops cpsw_proxy_client_ethtool_ops = {
 	.get_link		= vport_get_link,
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS,
+	.get_coalesce           = vport_get_coal,
+	.set_coalesce           = vport_set_coal,
+	.get_per_queue_coalesce = vport_get_per_q_coal,
+	.set_per_queue_coalesce = vport_set_per_q_coal,
 };
 
 static int register_mac(struct virtual_port *vport)
-- 
2.40.1


