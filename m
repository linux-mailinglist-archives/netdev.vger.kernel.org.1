Return-Path: <netdev+bounces-111924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74955934271
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 20:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABE01F226A6
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 18:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D62F181324;
	Wed, 17 Jul 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H/cOgKjn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454E1111A8;
	Wed, 17 Jul 2024 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721242498; cv=fail; b=ekketxGna3m1gBG33xenaxw+7rnSb0qkW5lu48SYjiSOOql1fnipLX+Fx4R45moK8GyGuD7+z5TNJpaaWzmeGpENj/jOiP/T6hJwGQb/Fva7Z+PoeGTWFyVfANpE0mZizMggx3FMIhlzgpuh03f+kT3lZegNkpxn4hndqLandSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721242498; c=relaxed/simple;
	bh=2cw7JaBrVkEZM56fc809B1GVdDUpNN4AlE9FL6xj6bw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GjVdGnNfOFQRLvaY/4tJauGi8JuTw6FwJ1pFn4Oz1f6Ynntd5FHvqilHE4KezB9JUQOfrRUDyT8T2TPFvm+RZbxQf2W01GmvpbzBxjBZCOmRDhdGXFFdNBF65dKhsfmHhEPcll3nrueWvcdMPQoEDRaNeXNPFyeni0elKNTc9/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H/cOgKjn; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNj7sm+OddODfgy6qWHN+3N3Y8tm0ogBofze9AVzv1e5Axk28OgHZUE9c9Pa014pbjJhmQLI2NEOLoNZ/P4/6O3dKdFrD9D//pCcp0W9FPmHgUJpPui7hnz3d8wpHWtROlu+P3RGCe+icwI3X3tyWJYYHh6kjn+STO+IGI5V3wuhsZjgZWpZHo3yVvOFLUo/cwFVWE2rlSHRkrV0/FGPakKpbXeVp9t1RdjWdoC8FkaZhPXDpKdmJx0AJDKKGawRf0B5SBX0YQa15EkWgiNO8/hRY4V67RttIRLcEC/QlOhAyrezk6KLB9145z45c80iTfuZKfeRXg240jPAECUSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8lOpKpP9oLX5rssK653jUA2U5hXrMRXt1+17zJjuqU=;
 b=OQyIkoH6OwvfYzqz/aWsodd4GP85nMbv+Qyi07NMk8FyPOiEH8cPg9OoN1/S4d61Pqq9xxXgLmmJ+QcSyPBAHg3hOHnsT/D77raV8YiJtob60CXHdLtzAyRPV0Zrt/JQD0fKJQ5MsAciq8oJM5KmGczWhXVx5d4JSpTzFISLxbxJPu5giSlLeFI9e6c6dB6ZulP3MwiKVjzZX6r6GydG+X7/1MSDu8Nu1HhMRgpVXKelSTZlvuKA1z5F3ZCGe2qXvOOVqEkqPmRBRiHpT4eCy9BA2LYFkcMjQKNF30iueMhpDDEc1yWKrxRwlOIzw5hsBbPkuX0/Q121qQXMcaNnGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8lOpKpP9oLX5rssK653jUA2U5hXrMRXt1+17zJjuqU=;
 b=H/cOgKjnZnFI4ZqchJCTOyjcnVAT9rRT7LRfyMSfB6WN73+ugcGvPNAbux92fPJwqRR7BcFDDN5SsyfrCG3BZdfnLdylv8UlYfbZrMuizBhSf5gQ7xFPv4DAuTWfmfoW2UlrmI+eDiCPOWl5MuD4yGFEp7lcQy6dOZEJiMXpqiY=
Received: from BYAPR08CA0024.namprd08.prod.outlook.com (2603:10b6:a03:100::37)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 18:54:52 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::82) by BYAPR08CA0024.outlook.office365.com
 (2603:10b6:a03:100::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Wed, 17 Jul 2024 18:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 18:54:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 13:54:50 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 13:54:47 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Appana Durga Kedareswara Rao
	<appana.durga.rao@xilinx.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next] net: axienet: Fix coding style issues
Date: Thu, 18 Jul 2024 00:24:43 +0530
Message-ID: <1721242483-3121341-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab3ea50-9e7c-4621-fbc4-08dca691f0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1SCbwSUendh74kkJll0YLOuqRNLu+zLP9vtB64ajQJ5Ol+33Fm7+YcHrzMkg?=
 =?us-ascii?Q?zQzT8TdJshu+vX79LjBCezmp5xu9mucTNb/UqyAzRLjTPFb+fY1R9rMhFVku?=
 =?us-ascii?Q?Z483IsYWixU+YK0o+WWL7FMUMfNQpmPqbVs0mbVGxzp+2eO2ctO14ntM4uWk?=
 =?us-ascii?Q?Mt6Vad62CWtD+jZ/DpkRtfQurjgm3f/DHXTP4zif1T++4RjGJc6r/G45h/hH?=
 =?us-ascii?Q?4/NtcvHdQlmrRNSpsUNXl9/AAN6Ue73Ys5IS++kBc+MB2I2s7Wa479s5D6M8?=
 =?us-ascii?Q?Up0Z+2/7bbNyJGU5WrEyhO98S8zOSkqauAuWG2Sf3p8u5vYZCGgk+I6ICTjb?=
 =?us-ascii?Q?qEd+AftCjf7yPGfFjzXWAu6l8SNMQ2NB5OEzB+cW6riTH+aP/FRk68qM9Qz0?=
 =?us-ascii?Q?WXLsTts1gMybxxfmNv/sriSR33edAEpVAMkmzPhI/2OwXMHAHtq8Xx+TU2LM?=
 =?us-ascii?Q?W+THwfLizBqX9AN87FMIjUUKUiMWe1AdcFCCCKD4ph7CJSHqV3VlRwb8llwg?=
 =?us-ascii?Q?TDylyueZFI7hsyA+GR7B2JqKlTao2va4E8902pau9udgNtcd57Lj7u1extNP?=
 =?us-ascii?Q?raP+25ffWBFlEJ9Wk3hD6mXxsNe68AKi5G0aA0M3ZkHLaj1u6EljRf+8xTlv?=
 =?us-ascii?Q?xiguh9B41jgd69eGJ/23cnnYskFEvaJHJ822zZV1clh6pWuZhD7lbUsFvdhm?=
 =?us-ascii?Q?F4wAerfjXvE7iE2l0cCsGGbZ53H667m9d35lL3WbQVRlhhRYGnH8FDkr198T?=
 =?us-ascii?Q?bZkSnPXe74dU90D+9BxbLwkBqgXXlxgoY+8UYlvRhHG31k8jp/miqrtkMoWT?=
 =?us-ascii?Q?ZYUBHpL/odl7Yfy9Lukcs83uzgTqtdqzbWeekID2OD8iVIANKblSvsE7XldH?=
 =?us-ascii?Q?w02dgAMSoPK79C9b7jO9odIAgtVZjB+qzbHzWaGZkDxH3+t/8Ug8F3pTF53E?=
 =?us-ascii?Q?hxiysn86+4oFhKLFqIXO6FjBTg09+A8NBtSVaqqbOBejroar3A2ulNKzbUHU?=
 =?us-ascii?Q?uz+ucJkKCS+Pqp2Bhf1TmIQjhSPdbak3qugVeLoeaiGByM2EseQb009ELvCe?=
 =?us-ascii?Q?2llnOoeEUOoz/UDh5Zs0+zVbx0vGydGGlZK5I1SbJYSW7EMjC1GFw0PHNY0V?=
 =?us-ascii?Q?3ddc6qNh0LaQzdpBL1EPWEhCxGGDPKyjj4lOnDrWYeXNirGWMHoO1GrDjJKr?=
 =?us-ascii?Q?OJI7nU1RO6g/ysUSdwShOVb3Dc9kumbwq4d/GWA1WR9wIDhecKswEYqYIa1S?=
 =?us-ascii?Q?euJRNRsEk1C4s7A9avA7RWJKMmyP3bRzPcIYD+1kYmL0asOIFg8qK8zDOsHe?=
 =?us-ascii?Q?clUXhGxMbbcXwO5i5NudvIqq19gn7E6L3VGw6RQHPWfh3aU/8Di8D3cT9Ief?=
 =?us-ascii?Q?roDWjoTtuJV7/1sGvTj1X+gb0T20a3756qjoggeh7Y3Iy2tSbhmf4C8XstNx?=
 =?us-ascii?Q?HlI7M/HUOIxPuOTdoJJcmeFZcO82TI2e?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 18:54:51.8311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab3ea50-9e7c-4621-fbc4-08dca691f0c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793

From: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>

Replace all occurences of (1<<x) by BIT(x) to get rid of checkpatch.pl
"CHECK" output "Prefer using the BIT macro".

It also removes unnecessary ftrace-like logging, add missing blank line
after declaration and remove unnecessary parentheses around 'ndev->mtu
<= XAE_JUMBO_MTU' and 'ndev->mtu > XAE_MTU'.

Signed-off-by: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  | 28 +++++++++----------
 .../net/ethernet/xilinx/xilinx_axienet_main.c |  7 ++---
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index fa5500decc96..0d5b300107e0 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -29,26 +29,26 @@
 /* Configuration options */
 
 /* Accept all incoming packets. Default: disabled (cleared) */
-#define XAE_OPTION_PROMISC			(1 << 0)
+#define XAE_OPTION_PROMISC			BIT(0)
 
 /* Jumbo frame support for Tx & Rx. Default: disabled (cleared) */
-#define XAE_OPTION_JUMBO			(1 << 1)
+#define XAE_OPTION_JUMBO			BIT(1)
 
 /* VLAN Rx & Tx frame support. Default: disabled (cleared) */
-#define XAE_OPTION_VLAN				(1 << 2)
+#define XAE_OPTION_VLAN				BIT(2)
 
 /* Enable recognition of flow control frames on Rx. Default: enabled (set) */
-#define XAE_OPTION_FLOW_CONTROL			(1 << 4)
+#define XAE_OPTION_FLOW_CONTROL			BIT(4)
 
 /* Strip FCS and PAD from incoming frames. Note: PAD from VLAN frames is not
  * stripped. Default: disabled (set)
  */
-#define XAE_OPTION_FCS_STRIP			(1 << 5)
+#define XAE_OPTION_FCS_STRIP			BIT(5)
 
 /* Generate FCS field and add PAD automatically for outgoing frames.
  * Default: enabled (set)
  */
-#define XAE_OPTION_FCS_INSERT			(1 << 6)
+#define XAE_OPTION_FCS_INSERT			BIT(6)
 
 /* Enable Length/Type error checking for incoming frames. When this option is
  * set, the MAC will filter frames that have a mismatched type/length field
@@ -56,13 +56,13 @@
  * types of frames are encountered. When this option is cleared, the MAC will
  * allow these types of frames to be received. Default: enabled (set)
  */
-#define XAE_OPTION_LENTYPE_ERR			(1 << 7)
+#define XAE_OPTION_LENTYPE_ERR			BIT(7)
 
 /* Enable the transmitter. Default: enabled (set) */
-#define XAE_OPTION_TXEN				(1 << 11)
+#define XAE_OPTION_TXEN				BIT(11)
 
 /*  Enable the receiver. Default: enabled (set) */
-#define XAE_OPTION_RXEN				(1 << 12)
+#define XAE_OPTION_RXEN				BIT(12)
 
 /*  Default options set when device is initialized or reset */
 #define XAE_OPTION_DEFAULTS				   \
@@ -326,11 +326,11 @@
 #define XAE_MULTICAST_CAM_TABLE_NUM	4
 
 /* Axi Ethernet Synthesis features */
-#define XAE_FEATURE_PARTIAL_RX_CSUM	(1 << 0)
-#define XAE_FEATURE_PARTIAL_TX_CSUM	(1 << 1)
-#define XAE_FEATURE_FULL_RX_CSUM	(1 << 2)
-#define XAE_FEATURE_FULL_TX_CSUM	(1 << 3)
-#define XAE_FEATURE_DMA_64BIT		(1 << 4)
+#define XAE_FEATURE_PARTIAL_RX_CSUM	BIT(0)
+#define XAE_FEATURE_PARTIAL_TX_CSUM	BIT(1)
+#define XAE_FEATURE_FULL_RX_CSUM	BIT(2)
+#define XAE_FEATURE_FULL_TX_CSUM	BIT(3)
+#define XAE_FEATURE_DMA_64BIT		BIT(4)
 
 #define XAE_NO_CSUM_OFFLOAD		0
 
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index e342f387c3dd..8c6f5af55958 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -415,6 +415,7 @@ static void axienet_set_mac_address(struct net_device *ndev,
 static int netdev_set_mac_address(struct net_device *ndev, void *p)
 {
 	struct sockaddr *addr = p;
+
 	axienet_set_mac_address(ndev, addr->sa_data);
 	return 0;
 }
@@ -613,8 +614,7 @@ static int axienet_device_reset(struct net_device *ndev)
 	lp->options |= XAE_OPTION_VLAN;
 	lp->options &= (~XAE_OPTION_JUMBO);
 
-	if ((ndev->mtu > XAE_MTU) &&
-	    (ndev->mtu <= XAE_JUMBO_MTU)) {
+	if (ndev->mtu > XAE_MTU && ndev->mtu <= XAE_JUMBO_MTU) {
 		lp->max_frm_size = ndev->mtu + VLAN_ETH_HLEN +
 					XAE_TRL_SIZE;
 
@@ -1514,8 +1514,6 @@ static int axienet_open(struct net_device *ndev)
 	int ret;
 	struct axienet_local *lp = netdev_priv(ndev);
 
-	dev_dbg(&ndev->dev, "%s\n", __func__);
-
 	/* When we do an Axi Ethernet reset, it resets the complete core
 	 * including the MDIO. MDIO must be disabled before resetting.
 	 * Hold MDIO bus lock to avoid MDIO accesses during the reset.
@@ -1657,6 +1655,7 @@ static int axienet_change_mtu(struct net_device *ndev, int new_mtu)
 static void axienet_poll_controller(struct net_device *ndev)
 {
 	struct axienet_local *lp = netdev_priv(ndev);
+
 	disable_irq(lp->tx_irq);
 	disable_irq(lp->rx_irq);
 	axienet_rx_irq(lp->tx_irq, ndev);

base-commit: 51835949dda3783d4639cfa74ce13a3c9829de00
-- 
2.34.1


