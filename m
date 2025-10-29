Return-Path: <netdev+bounces-234131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD1DC1CE02
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 647464E0526
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D7B3358D0;
	Wed, 29 Oct 2025 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ATB3aSa2"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9159B2F692B
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764579; cv=fail; b=usI20iZqbXjdNKtas+WdFE6a4vvyntwCLaajbBpSX0G7kOjezidcsr5VGBU+nztRgWirRO7kyLUqOeA5kh0d4Kb6QvngRAxbl2uKP3xpJu6SVcLa7spN1o8TA4XkF3ZRcfXOfSav+pm66fXZbqIjZglZx3o1hr3Uk1bfGGUok4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764579; c=relaxed/simple;
	bh=NBnWS6IYo7GwqQaErMOwQdC+hWev7UT/1pV0Cr8aiXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gO7Z4bsIuKhnRFyr9VUmpjXLnvQS2LR5akMG5hfQ9/Dv39EjoKDi6dMXqel8vC3mjWA6r8kRsVVMqTIjwpSiaLysV8SAPhmMMpvZv689Y9kQVR6+mjCrb33eIosGMsajOgYILbuInfjOyYaNe7nryHfcrF+NXlXXtyZQ2aU5wO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ATB3aSa2; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bK3htHIg+vhYwMSXdPpFg8cZMSrRU6EnoGFPpI1l0zW5u3CBV3OVt45dt+9JEwpjfAEbReuK6ahS1Qq0O+/JMkQhgdnRpjM99EHOSwhYAsbPNK82NBjLpd69rqOHL/ZRJh/2AogQ0AZGwvZeTi9x7t7QYvZTb7Al0zjYAEjG84SnEGvWPXfqVIBwQFfmx6dp77o2DKkyrTJRA8MyeFfl67Drk0cW5FDSeFK3Bkkjl8FyxG+0Hlq8UqZHY355Qv2XWxduLZWGKBRdu5nv3JJXoApfF2jxPlL8lFAKWlrxTAUZJeqPIwXGy38zDRVGnWBQg8w8KwAfdBKaHoNnIxZanA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZPbM4fDlhOHjpTf7XbnJlfHv590ZykIVSyDkFYUaJI=;
 b=QbxTGcBDMETQc5HqKbquhGSAi602BTqltR3lZakkM2p74CaVv1q8cus2ie5cLGFvGVE8Q9GZiqMWWHiaVRu9t4fqCuGMlHsHmld6paQ0ZqzTvRRFpgEpyR/fm3gJsPrJB7QEKWPpAatg4emPzsGExewRM/wBp9OdzZLyhuZLHP2c3Lei7m/aPmua8XNI+ZCxb3+wa57duJUtY3R5OiPfOgHe53V+rTvGXHGRkShXP6IMJ+a8F0mqsvHmmotwDC76MNM7QoiT9erns1I+apO6zhyzeDN6TTjqPf5sLvvuJ/fnIXPWhvaZG9ZHODOoGUWOfkrjCSLUGr4Xi/wv3Zv48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZPbM4fDlhOHjpTf7XbnJlfHv590ZykIVSyDkFYUaJI=;
 b=ATB3aSa2F77zebZy8i7U4Z2mv9zVTyVJWM3xGpc/gZ6pRi+Zz/B32TImAZWJ9pWLvSlc5PPNNPGQExhklENHBLvSVJyv2zKgzm64G4rB4GPgu8uXiS1D1mp0uzgh/foHPMX+Vr119f5uoh8IRVoHvGHlo//gtUuYn8Qr1VQTr6M=
Received: from CH5PR02CA0008.namprd02.prod.outlook.com (2603:10b6:610:1ed::15)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:02:51 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::b6) by CH5PR02CA0008.outlook.office365.com
 (2603:10b6:610:1ed::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 19:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 19:02:51 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 12:02:48 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v5 4/5] amd-xgbe: add ethtool split header selftest
Date: Thu, 30 Oct 2025 00:31:16 +0530
Message-ID: <20251029190116.3220985-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029190116.3220985-1-Raju.Rangoju@amd.com>
References: <20251029190116.3220985-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd4295e-1b45-464e-cd73-08de171dc223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lLGseO9yPERrtUYy/GlvMBNUkQvmVu/TXEv+/X6l7hrtXsUaY5Mf8i09iSg1?=
 =?us-ascii?Q?p+nV2IgCphjKnoV5lIODIjoxUF4bvBqDy+tTz9Y9CPy9iDtDR71afudRzB9C?=
 =?us-ascii?Q?/vs8N5BTB34/sm0GImYepLLZwEkh3gN++LaRuzhNjTMdgHUORcqeZ9Sh3x2F?=
 =?us-ascii?Q?jOKqXqi6GbeRNhIDow08f3gs09PlEjTcXYwzLrb5LxaQEpLQvniQhBeRWwQt?=
 =?us-ascii?Q?Ntk0Wgv4M0uYj5qVZrTdnthJ9PzuXR6kV1MGyDlCvVOj8z+HLCyNCYg7al8/?=
 =?us-ascii?Q?xrw/wGLZ6YoXDCkvnhSHoXkDlJk4Fxi5gwHThRQ6M8bkB78YToa6IJaiZ/UV?=
 =?us-ascii?Q?U2vTFYhpRXUF7rRguiglQIiBSzjqTF1yK2aVYc2RAhrHhU4PbUi3oRWsB51r?=
 =?us-ascii?Q?cjDmPSysCvLxhVJPtZX/qw7zmig7KegoPYS1knRtIGvMLwywmL4EQF6sXPtl?=
 =?us-ascii?Q?Og6xkGSCxidTuUxc01zlUC3Z0/SL7sDD+aO8XAo7x2rrfe9KA222VBuFE91g?=
 =?us-ascii?Q?W3rPnx+Nja6yyhBhgPoMFMZNq6Oevi6gPgNWdJAqZV6Xj6M68t8Vkov7tHhx?=
 =?us-ascii?Q?0/cDyy20naaXBonSeF31AT6OkhXwc3EBGAQi7pRMQmS2n6raNq0ViTnSb0yx?=
 =?us-ascii?Q?NurjtcEiKX+ICnFS2/ctAIyEt2HLo+JVYLMF6rXS5MYkQ8tcHlBsx1C6dmF+?=
 =?us-ascii?Q?JIgtQP9kWXTVJSeaPPYYoQzUvoeyk1Gsr6h9YONYhIxTQLnUuxFEp3lsv/yk?=
 =?us-ascii?Q?Orf6eqy/BqG1/gDFZDf1ybcnc39+pP9A7Z1xBdv4m1nxMgvjyia+5o6QaVey?=
 =?us-ascii?Q?jtBrnyUZ1IiPmfZPonX5k3pfiqCiWbVyZ275AcE/sJum2E3FpjY1JxcXksCm?=
 =?us-ascii?Q?uVX9fC8/aMV5R6W8TMzNn8pY/il/7o3SiZptAjD6QGN7cQIQ9eXv88D4Q71u?=
 =?us-ascii?Q?os8QI0Z1W4RaWL+UpS4r973vS60k76QhaFonkxT3MeL/8WU5rNFrnqA/sbjo?=
 =?us-ascii?Q?3I5w4Ur9+SFIp0UXtmanWaVVL/JYnMfgSewiFZsNwUH5TI12U2F/WO6RKT78?=
 =?us-ascii?Q?o/kEHJCsFxREdiIfcjIDHlJ4CTw6WvLHq6bGDUm7y7b9RQAOPpwVyLu9WAyH?=
 =?us-ascii?Q?5wZoWExTfO45E1YQ8yuHm3WaL8g6z8fBI94VAwU/1NCX1l/y2FDwfyHIUFsN?=
 =?us-ascii?Q?wUrQEr+Q5Fd4Ag9HVedzdCS5Kb41LHRoXtwfrl5MHEhajHGZqWB63Y9L6ti0?=
 =?us-ascii?Q?5DCz0MJRPt9HlyO3ZeG3sqzNjB6L7DbjMz3zrVRTcCjNhY6fO5VfQlkS7kdY?=
 =?us-ascii?Q?+swEPcQYTnbKGrrHGwJLrdOxx//iyq44fsnkEARGKeKOcLqAB/lHouHQcT2e?=
 =?us-ascii?Q?pS3PcomsdxTQmWNy5w46kxk85ZfeuhyJxSdiuHAr2EykA1REhUCEneMtWGvH?=
 =?us-ascii?Q?6jGShM83nOrpkhHOH0RNNUBXxA3duq7tGQRYi3KVOAtZpgJ7d5nTrbQlLTPI?=
 =?us-ascii?Q?UES3ivyiAOuwLBzsiLoIcZZRirNonSYhAnm4Qg4HzXjOCrSrIY63MMW04ONx?=
 =?us-ascii?Q?eNy/IDRgNNdApoN+LRg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:02:51.1070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd4295e-1b45-464e-cd73-08de171dc223
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776

Adds support for ethtool split header selftest. Performs
UDP and TCP check to ensure split header selft test works
for both packet types.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 46 +++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index dd397790ec0a..1a86375201cd 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -173,6 +173,48 @@ static int xgbe_test_phy_loopback(struct xgbe_prv_data *pdata)
 	return ret;
 }
 
+static int xgbe_test_sph(struct xgbe_prv_data *pdata)
+{
+	struct net_packet_attrs attr = {};
+	unsigned long cnt_end, cnt_start;
+	int ret;
+
+	cnt_start = pdata->ext_stats.rx_split_header_packets;
+
+	if (!pdata->sph) {
+		netdev_err(pdata->netdev, "Split Header not enabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* UDP test */
+	attr.dst = pdata->netdev->dev_addr;
+	attr.tcp = false;
+
+	ret = __xgbe_test_loopback(pdata, &attr);
+	if (ret)
+		return ret;
+
+	cnt_end = pdata->ext_stats.rx_split_header_packets;
+	if (cnt_end <= cnt_start)
+		return -EINVAL;
+
+	/* TCP test */
+	cnt_start = cnt_end;
+
+	attr.dst = pdata->netdev->dev_addr;
+	attr.tcp = true;
+
+	ret = __xgbe_test_loopback(pdata, &attr);
+	if (ret)
+		return ret;
+
+	cnt_end = pdata->ext_stats.rx_split_header_packets;
+	if (cnt_end <= cnt_start)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct xgbe_test xgbe_selftests[] = {
 	{
 		.name = "MAC Loopback   ",
@@ -182,6 +224,10 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "PHY Loopback   ",
 		.lb = XGBE_LOOPBACK_NONE,
 		.fn = xgbe_test_phy_loopback,
+	}, {
+		.name = "Split Header   ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_sph,
 	},
 };
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index dc03082c59aa..03ef0f548483 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1246,6 +1246,7 @@ struct xgbe_prv_data {
 	int rx_adapt_retries;
 	bool rx_adapt_done;
 	bool mode_set;
+	bool sph;
 };
 
 /* Function prototypes*/
-- 
2.34.1


