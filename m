Return-Path: <netdev+bounces-293755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM2JM/+AHWpZbQkAu9opvQ
	(envelope-from <netdev+bounces-293755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:54:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ACD61F9E8
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 14:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 791D0301D6B4
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267D0376BD9;
	Mon,  1 Jun 2026 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cfu5kHWC"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB51637C902;
	Mon,  1 Jun 2026 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317913; cv=fail; b=o6AJ6IzjS5yRgonZSuArG41ySqzEdWn4wIT/CXoXw1V90DCxyiWdlH2KSC1CoWimSj2axAknk6SRSj3hI2X4hTaYeOKlHn/v9R4mc1PjW8mGxiRiHC73NHCF4Y7OG45csYt0LEfi/poL/W1eoOxp6kW43Ryxypzik3Oi/Iv9HuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317913; c=relaxed/simple;
	bh=ymmZmB1i6P37jXg36cxJuDK2UFDo0BcD6riHFDtBGCY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n+MoEp85QnXfaxjkrqo+iwrMXB/Tc/lWmVlKCFurUizvRCeHVg2AZxFExlh3JfFX/svJuUlT0IU7iFjb4F+7oJ7tijjg74dorZ2QPX1WvDX2plGtYceYCm2Ad49fXI0lAKzMWhCzeCaS7D+vEFXsG6sezho/b1qmoFxuYTydBr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cfu5kHWC; arc=fail smtp.client-ip=40.93.198.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIptba2QeIaUFu4t2/2kmDlQRWUYoZ2GrYMDHyh8L1Mjtxllc7MFK276Am/09TJhcIirV7CVUh8TbPHX/0chdmxTM/KyoMRQlHQT5uaQV/iRxDYBW63seI/iIchNiCjERhVaL7OuAT+w2MCcUmhpZEUGfj50Sp/0VqhZwYqegHkhSywgQHBuG1/ZDEB2TsM7Sf7RHDApfhMYrF68YAS/kuvN5x24TQVWtJLnpJYnHZaa6Qq4DiJoVuflpe4F+k98woan+iTYALSzqrp+wWc1/LhZSnqrKcMWMPKMqVJOPfV7nY4Epd38/F1Lkzg8QJzPNb5dUA/83pRSiFd8kf/RsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAiPV9s09eZQCK9pbDecU0PJOarr3yujb/6PZToOKFM=;
 b=VRUHyqpDEt2stSRrPvFSdU4z6/eMkGQdQCCKvzM/sefNDZ6qJQqiJu/DCPoZ2szA3WvqSBaC381lvKtTmbkX0ogl94petCBjYXdrUnTjoTyiEMAhl5BqeHOST8WBX0thQdoglVrSCg7IOVyXzYE0IGY5mWk2Jq3uIVFPpMno0P9gDQ9aHzFzhWH7Qy9sLY4BllGZDB1WpBsAy0Hm0uyEHuyR06603wEHDB1lwG0gezF2sJpAdHPF9g15xQxWp6qCkfqjJ8hLsDfydcL8n3YnpmO5vmRBO8WyVucR9HH/kkXDzp4yxXLU+2IRb8SJBA/WTiitcT8WtuYC7MaL29cpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAiPV9s09eZQCK9pbDecU0PJOarr3yujb/6PZToOKFM=;
 b=cfu5kHWC4gd8MLPlgUBgaER4unZqHBilFgEmFic92HNCi8CDGk8Rt1lIWbrjEYrhEQ3cGxq8uz+igSxc5bdG6tlkokO1hnIS3o5KA3FsbpBi36Vi0z4o8B3jY4Uhz43TGGqcyb8CfRpITW2G4I2Sd1aScQbPCYf3gzO2u8NB8z0=
Received: from SN6PR08CA0031.namprd08.prod.outlook.com (2603:10b6:805:66::44)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Mon, 1 Jun 2026
 12:45:05 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:805:66:cafe::33) by SN6PR08CA0031.outlook.office365.com
 (2603:10b6:805:66::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Mon, 1
 Jun 2026 12:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 12:45:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 07:45:03 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 07:45:00 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: [PATCH net next] net: axienet: Use dedicated ethtool_ops for the dmaengine path
Date: Mon, 1 Jun 2026 18:14:54 +0530
Message-ID: <20260601124454.3384601-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 50764a5f-882f-454d-a099-08debfdb9ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|7416014|1800799024|11063799006|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SR28xbgH31eiL2hxxZlOTvP5sibq7K4Cr4xKd3tadabV8f5r6entSl1G/XoIt7IyOyfIXHPcOU00acCktYJ0pXg9p0xyh7TTwP5TALydVc/9/R+D2MyMr4CqWOV6B7N/nX56fPIipXOQOW+DMTfv5hLWY1BNEtvZ9UK/IVYU7wc5DcFrO9zcbglfV/F7DlIliT7h3jZq66J7/eAJTVeALKgfKMl86ElgcfA6xuZzSfE4/TxVFgIYL4m0tb1Q70oX0duCk/nbsi+UF1thcB/QTUJ7XbJnKLcgf6KqDka2HUkVTMhn5Qgo1QLUfRo0Q5WMdWEk4hWHRp6SNbovOC2uFQ2FGw4AFnWcfcRr8JOvZUQBc8OlsfMA7XSsFVtd+oPfyXvCLIUG11NUiuNqvnMn4IGGkc+Tjvs/TtfRdySO2nhwyhFtNDugwcCd+4P4ZvP/iRymdIvpS2+fpqIZTkAAYB6MtItMbseRVmuug/waeNCpzRXE5qJxaHIzqUtMvgzey9YXL3bmifW57VOXRLTTadCLCS0S+vuuGDnfN1VIV8MhAIAGDGmuJ6Hoe0sKiIOM3fWoqQsN04fDtk1YP7tU/K7xcAY61WaWwzTJWwspkZZNNbdVKRQWdGmeT6aCWNjA/sndtlQAAKfVIxo6YBixHOBfiCUa2KNJwUCmUp3+T7wcrW8zzhFNxInuvoF3qRPhWUtr63oEapXlDeauhBPz99Kh75ab262f3JTTMR/XZ9Y=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(7416014)(1800799024)(11063799006)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E4e0IxxnvZzJeDyvYrrYEmE66NxnSgpXDifgDhOoth/PtjEIv5ncIDCIcNCxRpwLtQIxAewFIxRMVpAfS80ghftvxsezw5AZYWKwWpNPjWfOhcfKPyR2PAsDaNI4uMis6z0dvYUwrN0k/IpIbdGLRD9x2FfGB1cE7ick2WAIjbfVWGu8z9Jycg/eMAegLD5DNxWmlRLZDJd8Juke0N1rbpZNAvErvsAwDiilqB+VRB42HhN548rQM5KHI30hjBRVoGZpQzZbW6Q3V1+oPPnfjcpN1KdBXLyjovfl9KvD7zA3YQu9om316onfJ4SNceiFpsI1ntEMT6RJ+lr4mDLjyr4GrD9YOb9+Ve/Z3DnhPdboleA1XVVghi/t7kVZnDKfrfUtcU9xk0+wkzTCeQ8Qr42Pe5W/Hu2IFoTbMR95NuH1MyRTb47vNRuHjXupFiH8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 12:45:04.8703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50764a5f-882f-454d-a099-08debfdb9ad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293755-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 47ACD61F9E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The dmaengine path shares ethtool_ops with the legacy AXI DMA path,
including .get_coalesce/.set_coalesce that poke XAXIDMA_*_CR_OFFSET
directly. In dmaengine mode lp->dma_regs is not mapped by axienet, so
those ethtool calls touch unmapped/unrelated memory and report values
unrelated to the channel actually in use.

.get_ringparam/.set_ringparam only touch lp->rx_bd_num/lp->tx_bd_num,
fields used only by the legacy path for BD ring sizing. In dmaengine
mode the descriptor ring is owned by the dmaengine provider and these
fields are not consulted, so reporting them is misleading.

No dmaengine API exists today to query or program either coalescing
or ring size on behalf of the client, so neither can be exposed
meaningfully in dmaengine mode.

Add axienet_ethtool_dmaengine_ops without the coalesce and ringparam
hooks. Also move the ethtool_ops assignment from early probe into the
if/else alongside netdev_ops, so the legacy and dmaengine paths pick
their respective ops in one place. No functional change for the
legacy DMA path.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 263c4b67fd5a..fcf517069d16 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2536,6 +2536,25 @@ static const struct ethtool_ops axienet_ethtool_ops = {
 	.get_rmon_stats = axienet_ethtool_get_rmon_stats,
 };
 
+static const struct ethtool_ops axienet_ethtool_dmaengine_ops = {
+	.get_drvinfo    = axienet_ethtools_get_drvinfo,
+	.get_regs_len   = axienet_ethtools_get_regs_len,
+	.get_regs       = axienet_ethtools_get_regs,
+	.get_link       = ethtool_op_get_link,
+	.get_pauseparam = axienet_ethtools_get_pauseparam,
+	.set_pauseparam = axienet_ethtools_set_pauseparam,
+	.get_link_ksettings = axienet_ethtools_get_link_ksettings,
+	.set_link_ksettings = axienet_ethtools_set_link_ksettings,
+	.nway_reset	= axienet_ethtools_nway_reset,
+	.get_ethtool_stats = axienet_ethtools_get_ethtool_stats,
+	.get_strings    = axienet_ethtools_get_strings,
+	.get_sset_count = axienet_ethtools_get_sset_count,
+	.get_pause_stats = axienet_ethtools_get_pause_stats,
+	.get_eth_mac_stats = axienet_ethtool_get_eth_mac_stats,
+	.get_eth_ctrl_stats = axienet_ethtool_get_eth_ctrl_stats,
+	.get_rmon_stats = axienet_ethtool_get_rmon_stats,
+};
+
 static struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pcs)
 {
 	return container_of(pcs, struct axienet_local, pcs);
@@ -2792,7 +2811,6 @@ static int axienet_probe(struct platform_device *pdev)
 
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 	ndev->features = NETIF_F_SG;
-	ndev->ethtool_ops = &axienet_ethtool_ops;
 
 	/* MTU range: 64 - 9000 */
 	ndev->min_mtu = 64;
@@ -3021,10 +3039,13 @@ static int axienet_probe(struct platform_device *pdev)
 		lp->use_dmaengine = 1;
 	}
 
-	if (lp->use_dmaengine)
+	if (lp->use_dmaengine) {
 		ndev->netdev_ops = &axienet_netdev_dmaengine_ops;
-	else
+		ndev->ethtool_ops = &axienet_ethtool_dmaengine_ops;
+	} else {
 		ndev->netdev_ops = &axienet_netdev_ops;
+		ndev->ethtool_ops = &axienet_ethtool_ops;
+	}
 	/* Check for Ethernet core IRQ (optional) */
 	if (lp->eth_irq <= 0)
 		dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");
-- 
2.25.1


