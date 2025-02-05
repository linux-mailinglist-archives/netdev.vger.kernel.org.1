Return-Path: <netdev+bounces-163104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5020A2956E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3405E167D11
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B4718FDDE;
	Wed,  5 Feb 2025 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aYkia5fH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC45192D9D
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770935; cv=fail; b=KBfgE97xPJmmkcN1NBCxfs/vjXDY3V5ZcZvaLIO6c/QWQ4y8iH76fA5qtlYhpUH8DXf4p05h44Efi+ta70FcpKM/Ct9A3dUxv3xIFh/osY1o3FwWXQcCtszSQZ4NBZppt+sw4SpdwfrdmOvkKG23jxSPmdUXspa5pBgw8vlT6iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770935; c=relaxed/simple;
	bh=MzpXSbqC5UPxASFUn6KUT1qdkyquXbebv930ApObQMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUD2FGssTuGyi7Ij3HlkDwK3I3JtyU2FZiYVUd4zBWfDf40XwOblKbmN4+8p1AyDp0tDWDvdyHTwHChhT1MyzQLHobaWxERItH1YamZVyfNqVCmduAiGK3fzWqa2s7zpWIniaTikpo/RnNbpHlk3V0+0GIqJ1ZFb1ZcYPJaT9uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aYkia5fH; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqTFlcqC7ePHW/+oNxHznOt5wghp5hMG/9M2xRIWEc7mIKbtlpnw2HCgKtRBKF6wbxkNSAV1DvL7prSxV+pJTqTNqJjJ0yZbNvFBochnH741lEiSQfEiB9uZ5Qc9G6xOJAjgrwP93cCHzlE024SAyFVr0DlVwqJh1x9a4t2mlXV1MqRH+iC8Uxm6alSYw3U3wor992d4YVsr5ach6QeoHvH7TsVhnDjiV0x/THUJ2pWnjcgkk3QJoYnpwWVx5xG1ITGpTUXom7GS3oMPfbqRN538mcJFmhKPAOQ//wmkjtASbmXJNQZpqfudF5rrd5pJzh1rsOwOE3tr0Aik3WObjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljX8gXziGoMsXZKu85LIjoaKbBevQTXUMj8edZJK+VY=;
 b=FUWZbMERR3dwEdzq8esdD9tfelL4WsiijfOpe5xtli/unULe33C+5Cr9t0OQspe9WsEPqXnOMapp6bQUAiEVcxCnOCpIu19WmBEigzjcA6zurI5h9OYWpvlNLTcpzcxQTfiEF/BBzkRKwVCoiHmDY61goj0SciskrVBMPOKo2f7uOMAy0xa+cOG8Z2m07bDXCHbDYvRj+TUcwPIp0atDjVWIdFZqZIUYcM4fAB+64RIQ1GYRp5/M3t8dJ78WncKi7axADU6cuS8acJfyQWoOxiAhIIcIpKVZmMR3M7jrtwlb70CZG44bpL7XWQFYGv3lirq7/QY0NpSlERPg+kcRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljX8gXziGoMsXZKu85LIjoaKbBevQTXUMj8edZJK+VY=;
 b=aYkia5fHHwCXUsMNGxiGDIk4wlKFZ+WgqnOgnR9MbXjO16V++zKuT2hL7phKeqcVGG5rLvDNRc8tvZGP0mfRRIaTAH9NJc037hKV5dTF++6PyG+Yi+L+ni4KpP8u7rW7CySVMMZ46flr2RknuORuD8+Gqrwm1Cp7EvUEvD8FMRkhvxOGJM2gVBZnNy3XXUqjv8lG9iB+CuqvmPJfdPIxZ0DQH+9DlypWV/zpmJIAIhvHx9YDTbdQdJwMZk+IlEVgcrov90WlhmwgLVPAxo/5BP8OAbS9BWgj+LKms8sxlwhYe1jLLDQ0S4ezE5yMHVYfDV9amUYo8IPGrXjBkhnEOA==
Received: from BN1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:408:e2::11)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 15:55:28 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::6) by BN1PR13CA0006.outlook.office365.com
 (2603:10b6:408:e2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Wed, 5
 Feb 2025 15:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.0 via Frontend Transport; Wed, 5 Feb 2025 15:55:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 07:55:06 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Feb 2025 07:55:03 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v4 04/16] cmis: Change loop order in cmis_show_dom_chan_lvl_flags()
Date: Wed, 5 Feb 2025 17:54:24 +0200
Message-ID: <20250205155436.1276904-5-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250205155436.1276904-1-danieller@nvidia.com>
References: <20250205155436.1276904-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: f84ac9cf-0ef5-441c-a6a8-08dd45fd8316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ALGm9UVgJC3/rMjPlrA47MdKw9EN8llZn/2aVYxa3u05+7Zvt1EW2aKzLDGt?=
 =?us-ascii?Q?V59L9hSHJDs8MOoa4HWGPPT4bJn4zeo2lcQ5X0SxN2CzXN2b6079ZAc1IX9H?=
 =?us-ascii?Q?f+VWzFHAqmMbtq3uiqdnQjZ7RBgmt5/GYK+5A8mMX9ujPiFScgK9NfLrUn6m?=
 =?us-ascii?Q?VpCUiFEfuFQLKAGUyH5HH9wjGzep6dXcQrTeK1w/C5Md5dW5klsSvTAfkbV9?=
 =?us-ascii?Q?2nQzwPUyfMyVMwCE9UScaJG5HmsBCyoFedx/Oc3h5MocL9GElpLXBrIHD5ow?=
 =?us-ascii?Q?XB6WkCSD+xP1wJRt+SFmrVRBBOZMTRCl/aq0SgCETJj1r9TsQOCIJUtxRGUG?=
 =?us-ascii?Q?GKVLG+QaKUnJnjTpKWyEFsywnmVho/x/SUhv0f43nLZEeuCh6hc3mbdTPHmy?=
 =?us-ascii?Q?jSdBbbIyx5lbJ0bKZCOOudGm7zls/zqgg25qwAtnjzzdktJI62oDXrAy+pgC?=
 =?us-ascii?Q?V2I+FA/kDexTlQiXRT0GGFrgkUs1q1GYyskfI7AjGsUSrOIOpCD6qUW+NNX2?=
 =?us-ascii?Q?P3xNfpvnVaQK9hLVLaI65LWtDZeMc1dIf07xt66FRhYt84jQrTzdJCOwxuCm?=
 =?us-ascii?Q?XRMgSuItkvESTFujd9QIKoEYEYN3MiEfRsgtKrEwq5946XWOEivdcbQD549F?=
 =?us-ascii?Q?ZhlT3BQ6YK0noDziywL/ivxGO2VaeAPmQP1gnGSHtj6LrQXc9E7eA4NnV8pp?=
 =?us-ascii?Q?sd518xabZZdLDoIdgO0bglWWVwqurr1lEx1hi99XwU/o+jieO1Ma5Cov2fxb?=
 =?us-ascii?Q?Tdrbdz9kQmqJtWZpSmWSXrEQIFLts8KJb9WXYOJJxj8Cj20CKeTcw0Q0GV+G?=
 =?us-ascii?Q?bcW4c5R1r6UuDswChBzxfyvYnKQXf/I0PLv0h6fmO53TBYeb2QhJkqQtLp8x?=
 =?us-ascii?Q?sThNgnwqoXwZjMn3It/UDyuM/thzQfgt0oWxtdpaeRBg9WhyxrL1uX5rPkmQ?=
 =?us-ascii?Q?Dvk3HmOnu7QEowdMu+lhdKr5c/rK5e5KDXCXXfdpbZ4cBSah/q9IP+diJaWh?=
 =?us-ascii?Q?lArMAaMMu+QazuZgaYYh91PTe7F0AF2oasd2fsQGZEc9IyyjDs1g06k7fhhc?=
 =?us-ascii?Q?xwAapoLtq1iATXxPR0KWm4qTbUorI9GeqAbI3kfxUYVRtD/ixDfe9Jqj7m0W?=
 =?us-ascii?Q?c5tafpS8J/+TWBEyeAerdrGr9QJi6RW7rbxeitpNh4ixR4+v/hK/txdBMgZu?=
 =?us-ascii?Q?ebGvHA6QiS+KpzwY9yMwxRqTOMpy+VhAqVRD67sLyL7RAtodU1Vv4bV0Txsn?=
 =?us-ascii?Q?11hBr+E/1uSv11LZPYSPTbBSjByES/2aaC5Auf+g7Klhi9HiFpkqretK2Eml?=
 =?us-ascii?Q?Mj/Fn1cS0kS1uLesZRCfqs7SevfTeHzkMEkjUPHzG8LkkS1q1XijuS32gs2r?=
 =?us-ascii?Q?jUkwSPjwinc2TLUselKNmSmL6suPj/Sj1NShKPJ+H5qkNH2JITzDDj+LQxUy?=
 =?us-ascii?Q?s7SfdNPjb4BARYxk2TyZoa9W8klF2Ucaeh+79DDuxislAzu9XmocVCPjEmr0?=
 =?us-ascii?Q?Wosa7VN0GUVmdww=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:55:28.2789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f84ac9cf-0ef5-441c-a6a8-08dd45fd8316
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870

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


