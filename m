Return-Path: <netdev+bounces-110742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0D492E193
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39F81F21289
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 08:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E4514F9F3;
	Thu, 11 Jul 2024 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HzwNrDQ5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387C14F9EA;
	Thu, 11 Jul 2024 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685416; cv=fail; b=DQ5/R7+IYgUUW98TEr66rJQ/fTlQsC6DV52Ni75uECjOE/0vmlW0oAIoN1MhXCv6oipzTOdwRe9Zqw6lXAyZgLMt82MVAiaqli48PxTdLb5QKd2k2nIJYxLTfJINckRnii8/JArY4PjFO8VC4stc5u57qfQCfs+j6q5/nywkRI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685416; c=relaxed/simple;
	bh=9ok1fGe4YrslONO4j7OGTdb2d3lpoIBo4K6JS0pWL/M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q+OtNO/D2RvEQlZc//6N4T1pyNqLf5hKZAnVVT6EWVOPyqPRgHHWPxZHwqUM/obQeMlhRHgDog96S30to184/j0gIRzXg0s2YpJcN3A8CFW78q5Jfj1d4Fxs0f2KSZO1uf61XkPRbE3U2z9s6UkRwHxQtlayneyLs/1fckiLdto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HzwNrDQ5; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmR5OS30MaDLd4xViAKaRLqL0KUzpKj58oQgOLc0Mi5SnAcvs4uUL0cLzlcRD/TqIrWoDyZdpYrWEOkCYgxY3VDfCRrvmZl3I730CHXFHAQMlysR5vHrXq86COdD6R6d5301pY2ERRs30jBdb3HUgHbkS1xm2vjr7GUmetykKxgcg7x0rrLSIq+B0uwY9r1daiHXEvcH+pphTQUjoU6tMQ4ei1TWBZVoX0fuWyCQGIKdqmuoBflaB/H5K5zE4KenHfDS09qzFRGi5LQ9OL2GAjyvVW0+0uIz9/8Q8w5W0wEyWiVvZVgqCfVFhR68TgQaU5aPY37eUEg0xhnR7Pt8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgWnxfk9XOoXHLuNrXBQVrD1UfG8M3T+VYFVZfr0Qx8=;
 b=pYnvC6Xgo3mj7FnpcyGkPeqpNocOY2KCXXHg47SYtlR1dgLRk+ZE0MMuKbt1+U4WmnDPLheieSdPDxfvuCf5I8yERm/EPFx5SyASV1wZnlQD7KyoImEZ7bkLEhSolsjGlTfVobNbndUEVMB21ErrHWJx7jfg/ocPb+p30OJ3WwNAQneGcKNb4wTKjmW2CmGxkei2lG6sYqrQB9U9YL8S7MhHNMYTXlpcoAEeVOlmi8znZdP5osmSRTCUlLDWD3+m1e9h18NFMk9ZL2PpjFogTRzjPBKnCHgNj3HysdJKH0w6A5cJJhQ72rXlsRIVXmHFt8VTAU5PjsVPYNpWXauDgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgWnxfk9XOoXHLuNrXBQVrD1UfG8M3T+VYFVZfr0Qx8=;
 b=HzwNrDQ55XRrvBdFHFq6lpg8VP38q4HqW1+3aHS1/DVRCsF7zNAFhKeXCVwrfjQgeAE0VBqSZv2KLrrDI1z5XVn9yQwAD7lgdrEtXYFIbLP2vfIeMBmf8/ck9buIdLjz0Jp/BdqqXYntj1spyBKdgIO7X/aKvjSZ2gyuhlD2PgJDVN1WluypANKKRl6Uvt0m8vlBQq/dcs2guj/Y0Oi1QTcFFSlzuuhroVxmS9lt8CubrdJTSYj7udHFLD1PIHJQlV6diSD4jBtqPg7uk4cB3+lpdDEFLLCJ01wpFpkBvFLlnCLB/TgcD4Cz5InrGl44nUJmMJFKp1S2BmqlFXMrMw==
Received: from MN2PR11CA0013.namprd11.prod.outlook.com (2603:10b6:208:23b::18)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 08:10:11 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::cb) by MN2PR11CA0013.outlook.office365.com
 (2603:10b6:208:23b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Thu, 11 Jul 2024 08:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 08:10:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Jul
 2024 01:09:55 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Jul 2024 01:09:51 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <idosch@nvidia.com>, <petrm@nvidia.com>,
	<ecree.xilinx@gmail.com>, <linux-kernel@vger.kernel.org>,
	<danieller@nvidia.com>
Subject: [PATCH net-next] net: ethtool: Monotonically increase the message sequence number
Date: Thu, 11 Jul 2024 11:09:34 +0300
Message-ID: <20240711080934.2071869-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|MW6PR12MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 930ea6c7-0353-45ad-054a-08dca180e2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xS3O3t++2lEoy9zBjSg2OviVn8OO+kUXsysHyygjd/7Q7beQuBgujaDQEQK7?=
 =?us-ascii?Q?OZPsWYla3gejZ8z4tznykdk5AyQM+s5rjQOafQqVOhrCkTlAX34KDTKeJjkC?=
 =?us-ascii?Q?d1n/NJwcu4m5SYH4fvaNQoeyStrpcguM4Id0AhFZVJMHQCehr+D5MzrggOxv?=
 =?us-ascii?Q?4Bn2G6Pb+DtB8lIc5CY6KqyUCT6OfyYTGt0KAjjra0Ug2NGFc0OhoKRNAq0T?=
 =?us-ascii?Q?Q1inPVaBYeiQDEmOUVGpzlRS26cjI42ZaYB9kWIYDWGUSJlIT0QPmQeBjhOS?=
 =?us-ascii?Q?OH3v9O9EEh21oXIAjcJ7glK+fjGXD7JFAc+tiuhdS3iN21MAdSaZ3IAuk33M?=
 =?us-ascii?Q?UxtkdIZwUJpBw8kQh8uk3NtdV84gt2rtOMaakK/vbNdtarCXelr2xyQ0ymxC?=
 =?us-ascii?Q?FbjZutvYRNT9/1XSxzyqhOS2moOhrD3kF1Lz5QN90RZZ6+MCGtkCVy7a8oNR?=
 =?us-ascii?Q?cEGmcdgNndbUaBMc2nQK1tgm1MDvvVXyAG8h6fHMnlR4ESujKE7p5VaHlbUy?=
 =?us-ascii?Q?M5YgNpc/P9SDGZdhICqP1Cf2i8T9fQFWJkWZ6bxfRI7n4iV4AUQ0VCW80liu?=
 =?us-ascii?Q?hKkXPMuoPKAyWisgGZ3i6/oBV6v3IpoXUi3TRKMfq+szLI44+IVxTAMAUNg1?=
 =?us-ascii?Q?uuZS2+NidPINdJsyNQmeCRW7OqLK1JSMymrxyqBmLK8YY6QxbLejJRRioTjE?=
 =?us-ascii?Q?VrE6XS31gSLD8wwYSPw3a5IyVjE0qyaXO340D7ptytONZRJlXAm8aaKsGkb7?=
 =?us-ascii?Q?xwkAurep+FAvnFbePS9PHhY3FQO5gvS30EZokd2mIfRnkp5Fwr27/ESxoekZ?=
 =?us-ascii?Q?kC6oJa6z0G7Stk2Vp1u9AvHK9iMAU1EzuZqXWlprIsXhKYWN2WlOaoxtnX39?=
 =?us-ascii?Q?Vyb7gjXUc7FJ/bS9+ISzxdJkkP+yi8z0AwwJUJvCF7wfdox3P6X3oW5Nfg+4?=
 =?us-ascii?Q?IYLF61zLURNILpmctPZFFllpCH3bKTwMcnrt/czbAztxdR2QDJMGZxTrY5Yl?=
 =?us-ascii?Q?yWrYFDeW2jkWJyoymFYcy0qMgC2ARkzvM+eO+Bth32usEjmdPjYY6rInu6ha?=
 =?us-ascii?Q?GyQ/w5Zzjn31SUMCL44/Gzbpzo9JTqWGIXCSuKF0X7pqVwG9CUcFyu+ytNRE?=
 =?us-ascii?Q?kjPDUjdzAv7ReuedPmyq/hrIlFuCTN303uBthAlWCAx9/NkTGV5py1FcJRvK?=
 =?us-ascii?Q?8qlJjP10yPoGxoKC3BiYIrLsmG1VHyQkzI4T9AhAEZspuukEvtHpVpLsmoft?=
 =?us-ascii?Q?BzMpi56nppZSNhkHIZyXodSLh885jQ7JjaHVvLvDdcohOdd9IeqLMqgKXEXW?=
 =?us-ascii?Q?4pJogoZZFjx/8TfEnB6m8qHOQgwjHQcjeM4OGJ33o20cBRNmvUkmMLJyTtyz?=
 =?us-ascii?Q?iXASwsSS+0yam8K3fbnRUie7yGa638iTQ1OIrGtDIvevwExsETS6EacOaYFE?=
 =?us-ascii?Q?xxhliL+kKAqAiIPnAGnBABSRjoV2HoXQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:10:10.8087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 930ea6c7-0353-45ad-054a-08dca180e2a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707

Currently, during the module firmware flashing process, unicast
notifications are sent from the kernel using the same sequence number,
making it impossible for user space to track missed notifications.

Monotonically increase the message sequence number, so the order of
notifications could be tracked effectively.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ethtool/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index aba78436d350..6988e07bdcd6 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -488,7 +488,7 @@ ethnl_module_fw_flash_ntf(struct net_device *dev,
 	if (!skb)
 		return;
 
-	hdr = ethnl_unicast_put(skb, ntf_params->portid, ntf_params->seq,
+	hdr = ethnl_unicast_put(skb, ntf_params->portid, ++ntf_params->seq,
 				ETHTOOL_MSG_MODULE_FW_FLASH_NTF);
 	if (!hdr)
 		goto err_skb;
-- 
2.45.0


