Return-Path: <netdev+bounces-160968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEABAA1C796
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC81318860EC
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36087155743;
	Sun, 26 Jan 2025 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="twaIjk4Y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A186358
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737892635; cv=fail; b=g/sYlYz+VNxV09+OV9NBqSNCEKfC5hc75bamB5fI7C9kmxpTm7aql5qaSXCWs2lOaxPS6TAGOPekYrnN8k5g4R1zsm+ORkG50NDk0bIdyHl5wTRdGgbP3WkF/DuZ7aQD+DOCNlRTjCeZNkcYHWTBKmbQtUZ1ncqI5r4dkZ4yd6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737892635; c=relaxed/simple;
	bh=lVS4SeviKbJm0VG/e+Kog3uSiZci4PeEb6vgfDuxC4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBWm+yOEAYu8Se3eWPmHDMQjtjg02NwC02JQPQbJuEkHQUALj+S74AVrfT6CBmWJZOQptbP1o7Awd+0MJQ0MnYjjUnWSVBfiB31JtCqZx9gu1iGMUA61CIDo3qiYApib8osPf+NfKWU0+aW1/NckWr/11Wi7Tr9M4a+7Rxj93lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=twaIjk4Y; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eegdacFnEF23flFu5qCEFsKxXBccASURGfuepTl9Tt7j92VMVGbPU2rQaYoAKuHtJYeqhXq0leqoudBag/MHlSG8zJGYUFDGD1S52BlxOi4fj/V4qlt8005x6fl3Ooqs5cD/88vEYET58cLKiNQXDty9DqoAK6Yak7mx7w0z9+A2Ubmy5qFKw1YCXScN7YNK/eUZvu0YYoJMgcatamA8PEROEwt+sWGxSC2wBd+CGe7APwT5gCuwWQvhRE9URcxumwTPT2b7jvW1xtrEDezSmHoGydB2zmAw0uY2cepruNTx3ltdt61zU3P1Wm4rySySXh/X9Kpx15CIsAXr3Jx4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OApf7K1DXNYI+jI9X2cxb1NdTwYn2HDIBypGCKm0BY=;
 b=ohfgPOOItcpV9T2MyNt6I2/5h2gD96fCT+jqyWKRGz4GMqYDUo9+X5DiYarjCWfcBKGLR/ubbJ9F2GUv00B8SrjFlNeIEmgBLojq3x2om8LtGVgSqeWzGUtm1QmrZplOcffUa3HP0KPLYrtAIljqYOK8en+WYyN2FQq4rsfXS4oDzBCCj6WDt4jWWPwbAluegYXe6xl8LAuTn85bmvVQ6Fg/mFKs++k4DBsM6B1/ttmNsRqc4Zm556w2LhbZUKBKpKmkJvR46rMWdhvmrFP38vk0FXxKfmn9MYzZzLn1YN8D0xLZjuzffY04xF0LAjMhh6p2gGP8I6VCjbNcN/gzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OApf7K1DXNYI+jI9X2cxb1NdTwYn2HDIBypGCKm0BY=;
 b=twaIjk4Yz7s5BHdat0kJaJ4xuJOI6eOuIQiBXxlOMdEYwTyxzD/RkNnorHRcZtd4HosNFotSwR9poON3zTmt+6wYA2WBvVscFVfgXxeW5aL/NFKpulHCJS1EzQQwK5ES20SxGoipTdbz00u/v/jmKAuGblLZUj/f1aIIdKYjik2OqxP/RgLMU/EZ86Xyn+24mszEpQjcSoXmbhsfH6lpSWhkbPR5D9IpUJ1oyOnTpzW8Mc8B72ZzTOwlsQ7vDEE36rdijnF3keXoR48W15TSeUwrUW1AiAUHo6j+35zEyqzVuHbh7lbMFjv8drppEWzRSbL4a5vptKQGpMNmG9LP/Q==
Received: from DM6PR14CA0038.namprd14.prod.outlook.com (2603:10b6:5:18f::15)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 11:57:09 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::4e) by DM6PR14CA0038.outlook.office365.com
 (2603:10b6:5:18f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.21 via Frontend Transport; Sun,
 26 Jan 2025 11:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 11:57:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 Jan
 2025 03:56:58 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 26 Jan 2025 03:56:55 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 03/14] cmis: Change loop order in cmis_show_dom_chan_lvl_flags()
Date: Sun, 26 Jan 2025 13:56:24 +0200
Message-ID: <20250126115635.801935-4-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250126115635.801935-1-danieller@nvidia.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3bf699-7721-4de5-c0be-08dd3e008fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZWZhQEnXaLHpevg1sdEX2st7mlWPrRQpyGtKFnYuwni3RXbV1v5qszJQI8mM?=
 =?us-ascii?Q?y24fkvyXuGKcuwMNSgsnPmyfB5dMGGA0Hleanbi4C7TDOqjXblQZVRRbPqjS?=
 =?us-ascii?Q?inYYkk6YBeVS4mXwEbwOB4C8cDwiu4SKh2gUe2Md9SN8Xm+CCpjGdvFedH2f?=
 =?us-ascii?Q?CS54ZQpESTKLr1hcxoJAdU0jxo5VkfYhSMoej79PvI5+OYytifMEFQrOapQx?=
 =?us-ascii?Q?o0DrN91LibHrjzauWAUXhL4f3B/6XMSV45H0WMoDZ/cFH3ihwkKvaFhhVOoC?=
 =?us-ascii?Q?kmUutn6+FehuKWqx9VB0UgBuZ5XW46L6suj5zTz4NqYfj4IxU9ig2h2UKIUR?=
 =?us-ascii?Q?zpzsRMZNujXUkoUF1fDklcNuWPTUqDvIYHE8zPiZ/ydO/Rdf2XufHw0s02fS?=
 =?us-ascii?Q?H3o2ZsSx91DHSgp18K5abUo4SyJ3+6wXHfbsjhYEJZFtDAF94CRUEVF9Ul1+?=
 =?us-ascii?Q?WwD3ve5L8tLf6933pOd3o49/SpKoRy5PHZmWdxlu4JLk4mL+URzUQ7ZICAGQ?=
 =?us-ascii?Q?bcVvO3WIgVsLye9j9N8J2Qx8tFW7ih8mKANC3V5zpGj7VLGYuYthmHW/ndTo?=
 =?us-ascii?Q?ecwbeBBg+bhEh2KCyhbvU+2aIzax91mAW8HWMia6/pvwJv/EUVVM/ImciebM?=
 =?us-ascii?Q?fpDvwQYlq8/KDCy8mIVOqel70ZIRSPyIRyPrCXLabQ59iqpoqT2fL1iPpKO7?=
 =?us-ascii?Q?lVOcTYpWmhKdXiAuvVoYOde7eJ/p1hYrrDOddVfF0YysHyIbJBIumPoHrhol?=
 =?us-ascii?Q?FxLjg1WCULZua9Scb2aMWx8OGstiTmMmL45UIr8ZQKszpvP/ZlAKA2Fpe9FW?=
 =?us-ascii?Q?fz3dpaKhcW5Tym9jFIlKp9qPJSYORfMf6dA0rt0bNf5DfcEP6W+Qj1YnrsIJ?=
 =?us-ascii?Q?A6E0mJIt9yghHnKSaCj8Rv7+utCQPhXfYYryzA84plr1XJssyOAMuUT8IZYl?=
 =?us-ascii?Q?KQNcyczd1UiX82c+qWtOv+uWIfB8SKtAlpICTO93mOOzr4miLKIykpxHLspp?=
 =?us-ascii?Q?kKrRSZv6otUPUhQg7s5G0IZdChsQRRQpjsrqARsO5vCy4gWZYbQytL6sH3kl?=
 =?us-ascii?Q?E3n8dWatCTZk0BbESV/v/2/l/Disct6ftav2YYuwy8ldHIRN8a2/7hd3DPY/?=
 =?us-ascii?Q?083UI99tAFrWQUIZLMEy/6L+mszhS8DoFKow7iu6a6000xZG55rQocf2BKKs?=
 =?us-ascii?Q?JNBrlH/T6O+sYj6LK1z0UmEUVJNe70L0q72hDoA9gd1YX9NcwcFlW7U6JbP5?=
 =?us-ascii?Q?nutSFAata/KXQMe+UUsjzpgtXkXfwgi0pFeXhIfhCEhLpsEkzmQvkNaZw48F?=
 =?us-ascii?Q?IGiDqGWzxCsvJbVjfH+vBFZy8HJptTlL+Cv9xiqWo1I1+i1pLvyFmNEjA1zQ?=
 =?us-ascii?Q?PcuJ1O+PfpdB8S9z7gDV8RjPcwRPvJxP42L4/o++rYhbrT1bECiqRxOWQpUD?=
 =?us-ascii?Q?GaN11bV+7NzTsTPbpGM+1Mx8z5I1KEn9sIhCsb/ETFjBJyVMhZ5URLaHFwcj?=
 =?us-ascii?Q?btbk8AU3vh2PaLI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 11:57:08.5802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3bf699-7721-4de5-c0be-08dd3e008fa2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012

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
index 71f0745..9d89a5e 100644
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


