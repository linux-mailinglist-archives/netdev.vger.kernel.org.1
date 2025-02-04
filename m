Return-Path: <netdev+bounces-162550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CB9A27383
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26AE3A8785
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9F121638A;
	Tue,  4 Feb 2025 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z/mH5LZ8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E830216382
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676446; cv=fail; b=KHSIzFFC/2JujZVa4k6Tt3VppQZewEChpRiVxS5wQdiOKZLbN2tYtK97g66T1w6D3ZXmeYEdhcXpfODEZATRjO0aTJVbBsC6MsOvBdIqfaQCENzlj81mloY5ayQAMzNhpy2wT7Y1u4axPn4qkiE/wAVmBzzAoNT2NVVTDOHdtwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676446; c=relaxed/simple;
	bh=MzpXSbqC5UPxASFUn6KUT1qdkyquXbebv930ApObQMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UURotzd5Dr3W11B70yB9SyMsNGSvx+6xPZS932SR0G1m7bw5CHvSLzo357zLpuixv6gPibevutAVDvifg5+Nzr0O2fVfa+N4JIQOFQer4odhv0JctJwJ99r11Usb31SiIWSksomkG1b+WDcHgsw0vVuOd7JqjPGUSqyIpDubsFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z/mH5LZ8; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuRBJthcAIXi8KmEkAqR769L0eH+sQqdmgTzpYGtmSjpN7/C5WbDaV4VgYysKlIp+ajHdp3YgdzCN5Wcc8iFGtV1dGrDndzbMdpbstE5vEYZ29QlRatlhz+YDlv/ldnFgw5yZSAMwYOJnVt0HrlAtcotU0oExTG1JBzCA2HN/HYHeuf5VJ2fPuFO5u7Auz3POB9qNdbQVlbb76ofU7VGQURHqNhrqIOkOkhaCx9a9Vxq7+jqA52/KRVvftZbDQjgDNwIwv64/VAygVrh3scyu13irKB/vTn2jHfnKfBdzfHV+fdVmrkZ7fPJzlNZNtN9Jb4dKXBSz0zkxn2ReBtKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljX8gXziGoMsXZKu85LIjoaKbBevQTXUMj8edZJK+VY=;
 b=ut4DRczSyqRZEFihqM7YeaiQcQOwSg6BKe9Ke58Y+ILABpcRBlVLFMA+Fmum87IJZLr//JafHjjqJpx4QHCaja3jU4snUpYSdLaJeTV47ZkXWCRLQJ7bQLO+0i4BO4kCZ6IfZeJD4ZUSBVnppFf2M9RCNBS8BFln+O91EqyeYjNTyKzJrRvjv0tPjxUyO5kJOE2v/DEHFb9kN4StPqMpTxDtO1tUlCOmWxvBtZbG5YryIPfOc8+8lxn8rGduz+6M9Wi/AvGROJLGd9eaeQvabZi7OOWbxBCr/S3CLVjcxCP3lDa0w9CPwtSfO0dmFukLComgfw1wBkT6dwGWGLqgrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljX8gXziGoMsXZKu85LIjoaKbBevQTXUMj8edZJK+VY=;
 b=Z/mH5LZ81JKCqnqD4mPIAB2dNzEkpVYbMsxeDMw6xL2crwJ9jdMXXm5X1Cyr312gJoa44Ju8CysKyE9w4GgNzpr2T/EXS3zSLQiIkntphBC/1ZTYjf5qfSnRRYHcL9THIb9o249CaTMQdWGRRfZGi2wLpyvEpUZu/tTBBjo36yVv1KK7OZOyyWiRgQmQrFH1ei/wcNUGytu2GIwWaNkToqeutJernKQENqPV7HsNDRYf87qEU//rBBJdv1K3Uq3vwIRmeY8bxAtzhl2+GqGe8aUeJIoszOlmxZSCT60SltZPGIS/in2+/39Xrmq5V85jAnwmp551Jg9FebMPsrbAvg==
Received: from SA1PR04CA0001.namprd04.prod.outlook.com (2603:10b6:806:2ce::8)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 13:40:39 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::38) by SA1PR04CA0001.outlook.office365.com
 (2603:10b6:806:2ce::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 13:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 13:40:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 05:40:22 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 05:40:20 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 04/16] cmis: Change loop order in cmis_show_dom_chan_lvl_flags()
Date: Tue, 4 Feb 2025 15:39:45 +0200
Message-ID: <20250204133957.1140677-5-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250204133957.1140677-1-danieller@nvidia.com>
References: <20250204133957.1140677-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 625a326d-6c1f-4767-0118-08dd452182f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4htxfDIeJtJoP7GkvDuh7mRp3KFy3yCJrYXhpeSdI28HICfr/a9mtc7jFN+M?=
 =?us-ascii?Q?zP4uo4lxaYA7vsdK/lUJkplOkaGwOkjmnUl7Q3y2NTw8NY16pFkU3tfiSsaZ?=
 =?us-ascii?Q?Sh4WKHl0rcaZ/vwb0qL8uKuO/1CAGlmwDb+M4PF634B0mqJ0KiDmww04SfOf?=
 =?us-ascii?Q?asH8e+Gbg5CKpNZRBcNHsNPoiATwOo105Rm3tMbMN3Zh9xxYkWhiIv9RH+UX?=
 =?us-ascii?Q?ixLu0VPBM7QcnPBckJy/Xyz/hP3HGQXdGYLY9WJDE80EyUd+vSXt5MuDqueH?=
 =?us-ascii?Q?K49drRPe0CgpFZ21uwiCY8Flqg9ePJW1T/MHrNaNjvzHnL1/Ng/TYr0NrQeT?=
 =?us-ascii?Q?PrVS7F60Wi6wyy/kJ+mA39XIx6cBkBENn/cIeVNRH1Ny+J70Frzhrl6jBlSk?=
 =?us-ascii?Q?zz02lS+KChkFYE4GxozJK/JfhyWe5mKUywnMRAGPE0PeVCfeHzTGgTKscNc3?=
 =?us-ascii?Q?6KGAd9cVP2iUhCrU2q6OTCK+Di1tec7OvnJ//1pt20yZcJRO9E2JYSxaMjy0?=
 =?us-ascii?Q?m5beS6XBnfz0xXRMq6wVyfknJeqFZ6vWBqCQ6pVT3wT7cbfLORfeiVzrSWki?=
 =?us-ascii?Q?lwYRuiUOIytpBSllz8J+HoCfxvm5r/C1IZqHNn66bypcUiuDmxLhmikY56xZ?=
 =?us-ascii?Q?6WAQzgfe9RPgUudP4V23tGZnC1ePNzVrLNpj3eMjZQtB46h2T02xUHjN44JL?=
 =?us-ascii?Q?9mfaSkxO1GUqIifJli9PdGqNhmTRCpLRdbL+e2597vXqe/LulwZwqtJeNQda?=
 =?us-ascii?Q?RUcqoJ7cxDZYMCGtbiQ9qQPw98kwqVF2K3Ofh/V1x4C1e23lqyt6halCNfWe?=
 =?us-ascii?Q?vxLk3kotDJlbIfcP0E/h6A9dkTwX5vbKViLuFzfIUCHdUAK+LgJS2McSPQFT?=
 =?us-ascii?Q?bRPuKFob/gh823nvsgP/fKtvZY9GvkmgoMvcCdbX8s5y1gYev6/a2l/xbCWx?=
 =?us-ascii?Q?5Yd759Bz66ajZ2L9uFnoKeB3lZqNxzBNUi3jKvW3x5ZtxwJiHBXpNuOmBQbb?=
 =?us-ascii?Q?poljtxuS5LyVOBPb61uffYyTSvKGxi8WHQA9SrR37nWzy6XrtZK42LFKQLOc?=
 =?us-ascii?Q?AJ20w+wf5m67DImnaU3UD1bU/P2Opf7Ef07DJk7knLvYnBK3QODyiluW/SCq?=
 =?us-ascii?Q?RlhABEiuVkZzjzjSYADRcUTSKW69clSY7NqOHllvGjYycqPVK62TBl6rvT3G?=
 =?us-ascii?Q?Cf7wj4hf55FRpKNORlPUKvjObgndLu81k9D5Xbxb9jHhQMosoKaEUaqXYCuJ?=
 =?us-ascii?Q?jsfaZOjeewjbchLXcUr+q+boo6yqpk8rWR81yeE5U38iHFlreUiBpmM8Wkru?=
 =?us-ascii?Q?XjWoV8DyiCLZh20NzDTvdtjDvSQuWao0JTuZa1XGdujOW+T+xMRbZxj+O9FI?=
 =?us-ascii?Q?ArhG7UPWjXRziphc39/wKomrXa805SGDNG/D/9XpOQ/+d+Pj8wkb3IBGr3UR?=
 =?us-ascii?Q?1F6sn+RSwtBKLiZKIrKbfbyg2+vOnzZyYAJWTsBp1bxVuhww8w6fn40KVJzf?=
 =?us-ascii?Q?I/7KAWOWIJo2V3s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:40:38.8142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 625a326d-6c1f-4767-0118-08dd452182f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062

Currently, when printing channel-level flags in ethtool dump, we are
going over the banks, and for each bank, we are printing all the flags.

When JSON support will be added, in per-channel fields we would like to
have an array that each of its elements represents a channel.

Therefore, change the loop order so first we loop over the flags, and
for each one, we print all its channels.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---
 cmis.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/cmis.c b/cmis.c
index 5efafca..9cd2bb1 100644
--- a/cmis.c
+++ b/cmis.c
@@ -683,22 +683,19 @@ static void cmis_show_dom_mod_lvl_flags(const struct cmis_memory_map *map)
  * [1] CMIS Rev. 5, page 162, section 8.9.3, Table 8-77
  * [1] CMIS Rev. 5, page 164, section 8.9.3, Table 8-78
  */
-static void cmis_show_dom_chan_lvl_flags_chan(const struct cmis_memory_map *map,
-					      int bank, int chan)
+static void cmis_show_dom_chan_lvl_flag(const struct cmis_memory_map *map,
+					int bank, int flag)
 {
 	const __u8 *page_11h = map->upper_memory[bank][0x11];
 	int i;
 
-	for (i = 0; module_aw_chan_flags[i].fmt_str; i++) {
+	for (i = 0; i < CMIS_CHANNELS_PER_BANK; i++) {
+		int chan = bank * CMIS_CHANNELS_PER_BANK + i;
 		char str[80];
 
-		if (!(map->page_01h[module_aw_chan_flags[i].adver_offset] &
-		      module_aw_chan_flags[i].adver_value))
-			continue;
-
-		snprintf(str, 80, module_aw_chan_flags[i].fmt_str, chan + 1);
+		snprintf(str, 80, module_aw_chan_flags[flag].fmt_str, chan + 1);
 		printf("\t%-41s : %s\n", str,
-		       page_11h[module_aw_chan_flags[i].offset] & chan ?
+		       page_11h[module_aw_chan_flags[flag].offset] & chan ?
 		       "On" : "Off");
 	}
 }
@@ -708,15 +705,17 @@ cmis_show_dom_chan_lvl_flags_bank(const struct cmis_memory_map *map,
 				  int bank)
 {
 	const __u8 *page_11h = map->upper_memory[bank][0x11];
-	int i;
+	int flag;
 
 	if (!page_11h)
 		return;
 
-	for (i = 0; i < CMIS_CHANNELS_PER_BANK; i++) {
-		int chan = bank * CMIS_CHANNELS_PER_BANK + i;
+	for (flag = 0; module_aw_chan_flags[flag].fmt_str; flag++) {
+		if (!(map->page_01h[module_aw_chan_flags[flag].adver_offset] &
+		      module_aw_chan_flags[flag].adver_value))
+			continue;
 
-		cmis_show_dom_chan_lvl_flags_chan(map, bank, chan);
+		cmis_show_dom_chan_lvl_flag(map, bank, flag);
 	}
 }
 
-- 
2.47.0


