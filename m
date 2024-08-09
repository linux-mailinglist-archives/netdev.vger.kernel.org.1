Return-Path: <netdev+bounces-117248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A0894D4CE
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 18:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 532E8B232EA
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA102942A;
	Fri,  9 Aug 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ILf5RWwl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9E41C28E;
	Fri,  9 Aug 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723221399; cv=fail; b=INBOB03hv1+xDMTzUSq805iWZLBsRpTtWB5uVwUhyJR0wRLtMfWA1WTCTr+e5wC3uDpebyOFshxYFNu0NxgzOkwpIe7/JeKNDLOIYUvpWOzbLu0aJZbJnR6u8OVQBUC9lThmDT4B+uJvMQVPRcjFD6shZ7HcF2hNhiefi7if1uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723221399; c=relaxed/simple;
	bh=6R26f2Y37xADlWg8J+9H3qO+MOcaVS7T/rLb5fZyU3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tNEuaTV+4sdOIb1OMPN+fTjQpQOEQiiiRn87jyDBUSEAOWEDI24SMscMtX3+rjSxh4ovXTwPnV+wR5HbHzKbAka6Vq1FrVs4H8hcbfYuJunnCPbIcn/v/9dGQ96U6Gx6Nb2SR7BmzHM0NB0QZ1Iacky0ck3b4hB5XSFPfGWJJno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ILf5RWwl; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idma1l7RFWujq62BaE7qK3RLZjZmq+h6lpcUPIConsVjQzNjSQ8gubsg2n9UJj8AylyzomDiye4hFTJEFrdXiCOhNQUXqff5Z5IAAI2d7UHR1XRaMiCiomQRolBqKarxLACt5n9Bh0Jn6KKK/9/uInKIYKdaD6A5YDE5RdsJhVeNHbrXwO92NyW2aXr8F7Kv7LXEPgp6pzwa99CUyaosIIukTqEiwkTzd4W22P2JOUxTJ6DzPTuanKR3qN1pTzE+V8QN9rWgWVU+oR12Vx5lKk9+8lwsdsmTB2hlHguSz7C7lH7crVaUekq5fiNtQ/PiZ5hy2ZEdHtmzAC3XWit7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THUavuF80f5ilmwjf+Ubi+AkdDLr64VnbylAgAZSlLc=;
 b=T6BnDkCrhCZ45hpbec+zPgbniOPPDvTTfNpUJHUZBGU+k6cgg1KpVMcDfFykQveAFWnqTDxdjwKEGgkvIx+CrnZeTjqqZ9mdFDCeNfJ1OSEmXunG+t8+MpXCdzXqCz1nuSnorRL1U3cfQxJfR+9p3Fzw+ubaznvOiuRWWg+3+UaI5sn7YGE/FhvKW5Xjj3V0NLkyUpRIWybuDHZJjDzYSKXaflGcHcLSD7f4PBSrjZUwUM/YzNj59ZVlyBMmI9mIzSoOS8ttD06nruL0NnS87znPnwFP0lYDC4zkaZV14hl4JEx2BRu3H2tTMfXVgHlYaVuDD4sNJkL3+n3Hhj7wKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THUavuF80f5ilmwjf+Ubi+AkdDLr64VnbylAgAZSlLc=;
 b=ILf5RWwlaB2eJ/Vpj/QZdfiGz6vsGvsO0usaIvq9X+1ZtqQZQZTG/uRWdU2tsdPFI0gnF35Od7Ak156ZE6oHAN+1BTBgxErCe2+M//eZKrPuikRBLeVMmaCIuhL8xq9iqkM1tkOZFCURC66QfTASBRf9FK9OeFwi922lXwjdWauONpoFbwGiSjwnQVxXyju1hnKLDzz5YV7jmSqPA6m0i97+T0d48+8ltEQM5mehC/ORKHt5Q9yar/2HFF0WSa/sjQl2a0XCq7b778zJZlks94mhpHzE7s51ewQCxIRw+cUVzEUNCA4VxZtm2EiyQg/oydMF6GPvqfbTTCX8Gg4igQ==
Received: from CH2PR03CA0019.namprd03.prod.outlook.com (2603:10b6:610:59::29)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Fri, 9 Aug
 2024 16:36:34 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::c0) by CH2PR03CA0019.outlook.office365.com
 (2603:10b6:610:59::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31 via Frontend
 Transport; Fri, 9 Aug 2024 16:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 16:36:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 09:36:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 09:36:18 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 9 Aug
 2024 09:36:16 -0700
From: David Thompson <davthompson@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <leon@kernel.org>, <yuehaibing@huawei.com>,
	<andriy.shevchenko@linux.intel.com>, <u.kleine-koenig@pengutronix.de>
CC: <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH net v1] mlxbf_gige: disable RX filters until RX path initialized
Date: Fri, 9 Aug 2024 12:36:12 -0400
Message-ID: <20240809163612.12852-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbb5177-9657-4a19-1ba1-08dcb8916e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hmrlHXYte/9G7EaXL0rJbHamrkD0xDJIIsbK8GND4msbKEuhJdFA31B/4N1l?=
 =?us-ascii?Q?x0lUE4CSIdegqDsRnK1mRx/jQfa3M93oTCqDKyudEh+EcwZAvnD+DNv1f3wD?=
 =?us-ascii?Q?jLuuw/hx1bkn5Qzqf7U5hhUP3hQ5I8A/25ujPDUduxyoALSztyO6kImc0S4A?=
 =?us-ascii?Q?A6kADLOgEc0d6TL8vohDjmtXzayhmaiYq+qRLlMeEZopOIc5Bnf+o3ovVuFX?=
 =?us-ascii?Q?NF7IH/wbGGgk184Jyj08yasC2Np2jxHEezFAj9R5SUglTAWswYW2joDMo+Xj?=
 =?us-ascii?Q?8bfcIAxyG3W/1eRbLSkA5lgCWDQ8/dBYeOrZJPoz6b9oYinaJGJtoedIdJwa?=
 =?us-ascii?Q?8FH8lL+UFFiPkV8O/ZRElHlkXmW8tMfbxPJA6kLWuAuu+XL0tReCf3A+PB2i?=
 =?us-ascii?Q?fFvkhhTV8J/ixl+04hXugUEa6ezuoMVBQ1J+AikmMpbi+JIjnp/XkMu4P5iE?=
 =?us-ascii?Q?z09nHnl88GSjNPUDQBBgdX0IMxxi0GOtUinJekmstnwhnda0xznP5CJlo+xw?=
 =?us-ascii?Q?neW5Ve4gowtCw21gm2lSIGZIwtT/fTr9F6zVUp7o6b+RMC8NeRp+r41WwWyz?=
 =?us-ascii?Q?LV9eTL3pEAiUel6pFTbE0hj2pvcYPSxYmVCoOObLB2eOD0ooIYWx/zsViOjG?=
 =?us-ascii?Q?dG+nkrirIcC14HZrO+7tMMHpG33rS9XKhbtuFgCtArfOa0ADd6O5+GDw3OJ/?=
 =?us-ascii?Q?sluibfCyQ16CNxtLDZ6BLcih7pDfGAnHIEMMtQnsShvhCt8n3uSwOQAOIHUS?=
 =?us-ascii?Q?1D+gWoeQf+Mr5A6YkLpLL3Wc10V3MRRTNsWwDE8BxMcmjNeN5xdCsq5bxs+x?=
 =?us-ascii?Q?1SbXqyMCZuSU+JkiP+EHkLtQu28aQqPq8NuurMjVVHVvxoH1RFkdLIk9e3Pl?=
 =?us-ascii?Q?wH2tCCZ2RyDP95lHbKSb0goafVtyp4LY9zCCIMdw4c5GvLZT/Eu3iwiyvcIo?=
 =?us-ascii?Q?rm8VRdP1sf8/1YHgKqNtkfdxgJwtXgMjojtsOUYul1dGRQ979s3R7R2grDmZ?=
 =?us-ascii?Q?pq31nJQXwMvxd20KIgmwd6dm4Qw7Y52S2h9wPnnfyKF2oBgfRG8ilWY2gpGm?=
 =?us-ascii?Q?qk3AO79VQMFDMQlOyfv9fefVMsJv+4jx/QpIAJu9EwR5BOoFgdOrnS1zZpVl?=
 =?us-ascii?Q?dUH4huFQ5+YfVTITrDhmnX0dbErRMmDmatKJaURBCLisqSatBtxu0uug4nGD?=
 =?us-ascii?Q?5EWAjxMAher8ZpfkNr3ccuEkZz/vdrBm7Fa425dzCLCfb8bq82ktwdIGnySG?=
 =?us-ascii?Q?2eHYgoO8QN1/mdGyV+Rlhde6YSQIhHWAo+OqF8d/YG0ViOJgMcL4qIBptpR2?=
 =?us-ascii?Q?D1RnDmcKUKoIyvZbm4bQvoCuh1d3lsth8cChda7RXoTd5oPBdT1mBhOnIkjq?=
 =?us-ascii?Q?NAebr5KC27rLK4/SW2sC5IkFGb2C5JXRNf42ODp0la7Y+jytwr8m7djpOHtH?=
 =?us-ascii?Q?3H0hhzPlaeq4cja+j7CvqZzHtr9uikPj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 16:36:33.6776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbb5177-9657-4a19-1ba1-08dcb8916e30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181

A recent change to the driver exposed a bug where the MAC RX
filters (unicast MAC, broadcast MAC, and multicast MAC) are
configured and enabled before the RX path is fully initialized.
The result of this bug is that after the PHY is started packets
that match these MAC RX filters start to flow into the RX FIFO.
And then, after rx_init() is completed, these packets will go
into the driver RX ring as well. If enough packets are received
to fill the RX ring (default size is 128 packets) before the call
to request_irq() completes, the driver RX function becomes stuck.

This bug is intermittent but is most likely to be seen where the
oob_net0 interface is connected to a busy network with lots of
broadcast and multicast traffic.

All the MAC RX filters must be disabled until the RX path is ready,
i.e. all initialization is done and all the IRQs are installed.

Fixes: f7442a634ac0 ("mlxbf_gige: call request_irq() after NAPI initialized")
Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige.h |  8 +++
 .../mellanox/mlxbf_gige/mlxbf_gige_main.c     | 10 ++++
 .../mellanox/mlxbf_gige/mlxbf_gige_regs.h     |  2 +
 .../mellanox/mlxbf_gige/mlxbf_gige_rx.c       | 50 ++++++++++++++++---
 4 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h
index bc94e75a7aeb..e7777700ee18 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h
@@ -40,6 +40,7 @@
  */
 #define MLXBF_GIGE_BCAST_MAC_FILTER_IDX 0
 #define MLXBF_GIGE_LOCAL_MAC_FILTER_IDX 1
+#define MLXBF_GIGE_MAX_FILTER_IDX       3
 
 /* Define for broadcast MAC literal */
 #define BCAST_MAC_ADDR 0xFFFFFFFFFFFF
@@ -175,6 +176,13 @@ enum mlxbf_gige_res {
 int mlxbf_gige_mdio_probe(struct platform_device *pdev,
 			  struct mlxbf_gige *priv);
 void mlxbf_gige_mdio_remove(struct mlxbf_gige *priv);
+
+void mlxbf_gige_enable_multicast_rx(struct mlxbf_gige *priv);
+void mlxbf_gige_disable_multicast_rx(struct mlxbf_gige *priv);
+void mlxbf_gige_enable_mac_rx_filter(struct mlxbf_gige *priv,
+				     unsigned int index);
+void mlxbf_gige_disable_mac_rx_filter(struct mlxbf_gige *priv,
+				      unsigned int index);
 void mlxbf_gige_set_mac_rx_filter(struct mlxbf_gige *priv,
 				  unsigned int index, u64 dmac);
 void mlxbf_gige_get_mac_rx_filter(struct mlxbf_gige *priv,
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index b157f0f1c5a8..385a56ac7348 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -168,6 +168,10 @@ static int mlxbf_gige_open(struct net_device *netdev)
 	if (err)
 		goto napi_deinit;
 
+	mlxbf_gige_enable_mac_rx_filter(priv, MLXBF_GIGE_BCAST_MAC_FILTER_IDX);
+	mlxbf_gige_enable_mac_rx_filter(priv, MLXBF_GIGE_LOCAL_MAC_FILTER_IDX);
+	mlxbf_gige_enable_multicast_rx(priv);
+
 	/* Set bits in INT_EN that we care about */
 	int_en = MLXBF_GIGE_INT_EN_HW_ACCESS_ERROR |
 		 MLXBF_GIGE_INT_EN_TX_CHECKSUM_INPUTS |
@@ -379,6 +383,7 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	void __iomem *plu_base;
 	void __iomem *base;
 	int addr, phy_irq;
+	unsigned int i;
 	int err;
 
 	base = devm_platform_ioremap_resource(pdev, MLXBF_GIGE_RES_MAC);
@@ -423,6 +428,11 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	priv->rx_q_entries = MLXBF_GIGE_DEFAULT_RXQ_SZ;
 	priv->tx_q_entries = MLXBF_GIGE_DEFAULT_TXQ_SZ;
 
+	for (i = 0; i <= MLXBF_GIGE_MAX_FILTER_IDX; i++)
+		mlxbf_gige_disable_mac_rx_filter(priv, i);
+	mlxbf_gige_disable_multicast_rx(priv);
+	mlxbf_gige_disable_promisc(priv);
+
 	/* Write initial MAC address to hardware */
 	mlxbf_gige_initial_mac(priv);
 
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h
index 98a8681c21b9..4d14cb13fd64 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h
@@ -62,6 +62,8 @@
 #define MLXBF_GIGE_TX_STATUS_DATA_FIFO_FULL           BIT(1)
 #define MLXBF_GIGE_RX_MAC_FILTER_DMAC_RANGE_START     0x0520
 #define MLXBF_GIGE_RX_MAC_FILTER_DMAC_RANGE_END       0x0528
+#define MLXBF_GIGE_RX_MAC_FILTER_GENERAL              0x0530
+#define MLXBF_GIGE_RX_MAC_FILTER_EN_MULTICAST         BIT(1)
 #define MLXBF_GIGE_RX_MAC_FILTER_COUNT_DISC           0x0540
 #define MLXBF_GIGE_RX_MAC_FILTER_COUNT_DISC_EN        BIT(0)
 #define MLXBF_GIGE_RX_MAC_FILTER_COUNT_PASS           0x0548
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
index 699984358493..eb62620b63c7 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
@@ -11,15 +11,31 @@
 #include "mlxbf_gige.h"
 #include "mlxbf_gige_regs.h"
 
-void mlxbf_gige_set_mac_rx_filter(struct mlxbf_gige *priv,
-				  unsigned int index, u64 dmac)
+void mlxbf_gige_enable_multicast_rx(struct mlxbf_gige *priv)
 {
 	void __iomem *base = priv->base;
-	u64 control;
+	u64 data;
 
-	/* Write destination MAC to specified MAC RX filter */
-	writeq(dmac, base + MLXBF_GIGE_RX_MAC_FILTER +
-	       (index * MLXBF_GIGE_RX_MAC_FILTER_STRIDE));
+	data = readq(base + MLXBF_GIGE_RX_MAC_FILTER_GENERAL);
+	data |= MLXBF_GIGE_RX_MAC_FILTER_EN_MULTICAST;
+	writeq(data, base + MLXBF_GIGE_RX_MAC_FILTER_GENERAL);
+}
+
+void mlxbf_gige_disable_multicast_rx(struct mlxbf_gige *priv)
+{
+	void __iomem *base = priv->base;
+	u64 data;
+
+	data = readq(base + MLXBF_GIGE_RX_MAC_FILTER_GENERAL);
+	data &= ~MLXBF_GIGE_RX_MAC_FILTER_EN_MULTICAST;
+	writeq(data, base + MLXBF_GIGE_RX_MAC_FILTER_GENERAL);
+}
+
+void mlxbf_gige_enable_mac_rx_filter(struct mlxbf_gige *priv,
+				     unsigned int index)
+{
+	void __iomem *base = priv->base;
+	u64 control;
 
 	/* Enable MAC receive filter mask for specified index */
 	control = readq(base + MLXBF_GIGE_CONTROL);
@@ -27,6 +43,28 @@ void mlxbf_gige_set_mac_rx_filter(struct mlxbf_gige *priv,
 	writeq(control, base + MLXBF_GIGE_CONTROL);
 }
 
+void mlxbf_gige_disable_mac_rx_filter(struct mlxbf_gige *priv,
+				      unsigned int index)
+{
+	void __iomem *base = priv->base;
+	u64 control;
+
+	/* Disable MAC receive filter mask for specified index */
+	control = readq(base + MLXBF_GIGE_CONTROL);
+	control &= ~(MLXBF_GIGE_CONTROL_EN_SPECIFIC_MAC << index);
+	writeq(control, base + MLXBF_GIGE_CONTROL);
+}
+
+void mlxbf_gige_set_mac_rx_filter(struct mlxbf_gige *priv,
+				  unsigned int index, u64 dmac)
+{
+	void __iomem *base = priv->base;
+
+	/* Write destination MAC to specified MAC RX filter */
+	writeq(dmac, base + MLXBF_GIGE_RX_MAC_FILTER +
+	       (index * MLXBF_GIGE_RX_MAC_FILTER_STRIDE));
+}
+
 void mlxbf_gige_get_mac_rx_filter(struct mlxbf_gige *priv,
 				  unsigned int index, u64 *dmac)
 {
-- 
2.30.1


