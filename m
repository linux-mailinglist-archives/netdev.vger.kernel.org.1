Return-Path: <netdev+bounces-234625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A6435C24BF8
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 29F6C350CC5
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94455345CA3;
	Fri, 31 Oct 2025 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NXiZlOvM"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188CE3451CD
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909460; cv=fail; b=EAS4q1oEPd3L9EKVTlMpj7xfeopIjZSqjtJXwVU1Ym7c1fQRkK7aGigTm6IeOH69MoNPr2naAvsay2uEknSyXYtbU/s9+OKwcR4oweuBrNSLOzkVKM6TLxFGAQwNfjw6vBMVCIwHDyeo/n+jchtAowFzPgxQc7IqO9O2exmQlDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909460; c=relaxed/simple;
	bh=V22JsLLhMoZMpblHzDLktyDkMVSJCiYns/rNTGtInEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFgV+Kzr2XXz9RG/V/sPUF6bYn01t11F/AtXiNN+Ursw7GtZryordSwELdWGKL4cm59WjZq2I+Kky/KDhnsiKxe1spikofNrDp+8O/XCdnuT2EPalHT8gnAa3wSITw5nJTvTsjUc/sxlDciKmIyI7jqiwgrUnnnDdFCKsIgveF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NXiZlOvM; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcMYbpslV0bZ93K5f8tBAIB/1Q+vImJkjyFNw24cp+RdTfkdi7Kon59EjJKcYIee5LKQX65S2m11XK37JfWzVAHDcWtWD5jstXYAFtINV2hD6wBK/nkNLCJcyO/c6jQpVkYxrg80DQ1ScLZVwTkSMr7HaECWOU55UWD7hGBiR8aFX84UTA3SYJeekfbPH5ciN06MXj4MIXGqRU/klBAcwlIeoXNy2O53p8Caf6O8DuP3uMjI1eXvC/S0ujLPMctorT0VzxlBFv/fxrVwdQO53/5O5+Qmc/a1TWb3O7bJ0NUuPCaa728+Wezx07jovL4tnMg+xnZS2plgFHFkXCoYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfiTk1xWCwE6ADPXurePF3ZGUh3FOZR0S7JOFPGr1yU=;
 b=YaCptKkK7Cc8Tzt0WhW7SZDBVYRYd9mqRwVxazHVvBdy/JRPjYY4oLVa1Y7BbD+X+1KWTLx3t3mFF4CWX33I910ijJo/4Kb29ga6Q1YjW5A1W6Lwl3Fb8espxGNk7zvrYlwq3d3za7Ey8mwG+6kHyyOxzRRip7hpkzIDftE/K9csIYo3ZkDdHsgsKIMhu31lHOS/r5+FudJzQwQN1lpVsKAj7vB29r+sGbdtFiEIYJk/Jkdf1WbWeUc30+ncnaeCM0mLtE717e2mdYSkuI+edXN4VIJg0Rr/AejrFHWljD6pwm2NOcUG1CdMRkAXWQ29wpyLleZfOS7nmHDMdqsU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfiTk1xWCwE6ADPXurePF3ZGUh3FOZR0S7JOFPGr1yU=;
 b=NXiZlOvMravDmW4GSmF132OfZd2d4EiY0JJNWXaAL/bQ6GToifk3Iy82BbJdgjPyaLN9ma3S4lDa6JUJwGgT1obGcbMKijMERasw4yY6uC+2j921K6By0od0tjektD6e1nd0ZEXD8HYZr6Bf2zsN2Ein3Q7tB1X5CFgmVgpNegc=
Received: from BN9PR03CA0080.namprd03.prod.outlook.com (2603:10b6:408:fc::25)
 by CH1PPF711010B62.namprd12.prod.outlook.com (2603:10b6:61f:fc00::614) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 11:17:33 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::9c) by BN9PR03CA0080.outlook.office365.com
 (2603:10b6:408:fc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Fri,
 31 Oct 2025 11:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 11:17:33 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 31 Oct
 2025 04:17:30 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v6 5/5] amd-xgbe: add ethtool jumbo frame selftest
Date: Fri, 31 Oct 2025 16:45:59 +0530
Message-ID: <20251031111555.774425-5-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031111555.774425-1-Raju.Rangoju@amd.com>
References: <20251031111555.774425-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|CH1PPF711010B62:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6fa911-99f9-4590-7187-08de186f16a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UeUoJAvJt3zc/S8nHEesixS9Nhv0tNcKlPmYud+1b+llMzofcoDITwV8qxjr?=
 =?us-ascii?Q?yvSDUJcEV90SuwaV2J24fBx0Kd3CAwhCIx6oKDjPHeRFwmFcrKHiqYJWihS+?=
 =?us-ascii?Q?Be23sWGPgk9xGLSig7Djdrda/qKkI/BZshi0CKcSALFRL1NOFXRo74k5TMOM?=
 =?us-ascii?Q?hYv0AMpAEX0oGlQiQlQjLet5CDlx11yarB8vh7IPNumv+RnfYzGGXr+u8xrq?=
 =?us-ascii?Q?MPeLHfzSy6p4B3V3CPqfKDlGDT33/STlsT5TN2ZITC4m5OdXG4T3u3t+A+hT?=
 =?us-ascii?Q?7/qxyFEDAvaSmJ1r9vkYJmjs+YFiu+utr1RMC/6We9RGhIkno/Sy+ltGcLNg?=
 =?us-ascii?Q?JTS4nKECmSaeFDcn8jLtfi+SoF02n5tBgkMrz9K7BqLR/zO78cXppYCENCzW?=
 =?us-ascii?Q?ZmYUPHa1cwtc9T//3umWLPuVNY+fTUuTL2rM0BF/LaV+nszDOTBGrDapo03B?=
 =?us-ascii?Q?Tu7RgWVVGQqe4x9BFgAx5uX1sjrt7cjNvcLqByZYQ0Iqbf3pl4HjREpU5Hob?=
 =?us-ascii?Q?bmGZVjqRIOfWtkXY+j+kKc8XhgJrg7j2LbG4OhDVHSyxyRjU4aWyIrfhGPOc?=
 =?us-ascii?Q?LqoQHL5SfSCniqaYy88HXGmKJw+ygCWe8LQf4Fa3zPIaplv2d6/0fbORwWFL?=
 =?us-ascii?Q?v9anOjFMkug7+BrJAU+u6c6+PBVj7fInWhldNtNOZLGByTEVU+QmyNzVN2sc?=
 =?us-ascii?Q?Xc/LdVoIaSf3qOY8LnZpT+Mvw+X/P9JSfydRynmBey/nNnQCdLvml7IoRrQm?=
 =?us-ascii?Q?v1fuJnTcnKaF3jJWK2TJoJ1d1Bk6vkcp25vmBXNErxo3if9195pQ+kg2rb7D?=
 =?us-ascii?Q?nWv/Ybhf1lahvJDn0PD2Ma6ESrExYurXkJNZ+wSrzxVYwXk5SlAoz60t9Iib?=
 =?us-ascii?Q?5es2aNvnmAbhdftvQyrNvgbXmZivRUQbqWwON+CxscjjZLXY3oxztum32FUP?=
 =?us-ascii?Q?r8859sxPe22ma0l7pCNdbyMT01DSVqTrMMMBB7KsmTm3/NOL72t1SBsJOrqg?=
 =?us-ascii?Q?mdZFuxkN+Is2gUzIYcB3QnX9puv9QsY9xK2t1hsedM7Fq1PloCSQpfM6leDL?=
 =?us-ascii?Q?Z67kAR+8fQ9xQInlQJ55JI5mqHVYeiXwoNg6b6dEhj2h+WVWShQeVEro20m3?=
 =?us-ascii?Q?0RQDs1KuIk3gjq3YvrafexRExXWNnHPJyK9yq95uqM3fIG4nsBreyFIZL4Vh?=
 =?us-ascii?Q?SIUXI3RZA6UMMgEu3C7PK+5gEOv2Hx8yj1iqf8lqbVWAqu5zN6qIXCfkwWcK?=
 =?us-ascii?Q?9sHnZytCOCW/lVUzD/CxAum19vyDk69PXCyJRPab9PTFry0B36A6+abzlnGc?=
 =?us-ascii?Q?QOFsAv0gJ9L9jtkV1oLEVIKrl8WZDOMcNnt+Gc0hm0Lh+ttu6j99E54++s16?=
 =?us-ascii?Q?pWgxPtX9Qk3hXgVEtNC2Vs8Qnb7m2KEl5C/L321V4a4bPgLZvpNUGvYLr4tu?=
 =?us-ascii?Q?mMVCIr2fqBMMYfVwyTAhh20QvwLTsDim4bGChockKvkl2fpiVPA4QBg/Q0vJ?=
 =?us-ascii?Q?yGqt5WKVZYE7xu+8kee7rYRWEvHBltLmJlzVj23zD8r0WX6w45QEJMJSsbdV?=
 =?us-ascii?Q?GmHBM11zh1xlUobDSKI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 11:17:33.3070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6fa911-99f9-4590-7187-08de186f16a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF711010B62

Adds support for jumbo frame selftest. Works only for
mtu size greater than 1500.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v4:
 - remove double semicolon

 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 15c51e96bcdf..55e5e467facd 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -42,11 +42,19 @@ static int xgbe_test_loopback_validate(struct sk_buff *skb,
 	struct tcphdr *th;
 	struct udphdr *uh;
 	struct iphdr *ih;
+	int eat;
 
 	skb = skb_unshare(skb, GFP_ATOMIC);
 	if (!skb)
 		goto out;
 
+	eat = (skb->tail + skb->data_len) - skb->end;
+	if (eat > 0 && skb_shared(skb)) {
+		skb = skb_share_check(skb, GFP_ATOMIC);
+		if (!skb)
+			goto out;
+	}
+
 	if (skb_linearize(skb))
 		goto out;
 
@@ -215,6 +223,17 @@ static int xgbe_test_sph(struct xgbe_prv_data *pdata)
 	return 0;
 }
 
+static int xgbe_test_jumbo(struct xgbe_prv_data *pdata)
+{
+	struct net_packet_attrs attr = {};
+	int size = pdata->rx_buf_size;
+
+	attr.dst = pdata->netdev->dev_addr;
+	attr.max_size = size - ETH_FCS_LEN;
+
+	return __xgbe_test_loopback(pdata, &attr);
+}
+
 static const struct xgbe_test xgbe_selftests[] = {
 	{
 		.name = "MAC Loopback   ",
@@ -228,6 +247,10 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "Split Header   ",
 		.lb = XGBE_LOOPBACK_PHY,
 		.fn = xgbe_test_sph,
+	}, {
+		.name = "Jumbo Frame    ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_jumbo,
 	},
 };
 
-- 
2.34.1


