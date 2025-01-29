Return-Path: <netdev+bounces-161495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5A5A21DB4
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DF3167B87
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32DAB661;
	Wed, 29 Jan 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gn69jvE2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA6732C8B
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156588; cv=fail; b=A8mtLWFZTcpPz/uO+tX7ipf9Ko2/KfSRtVFTuAyQxQkon1MgZrXHBslHKVrrYGGbqYeXcrkuVE2n6nAeHwy1zXWrOSQhlcIU+KjXI4iZ5Y6Ipp2VMeBKkxn8BIGrbW30dIxH0gxbmseXuDNSIJ3Qm6yPqZ8jlchOizuWWYyftw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156588; c=relaxed/simple;
	bh=lVS4SeviKbJm0VG/e+Kog3uSiZci4PeEb6vgfDuxC4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPyQ67FwSdDyHea9hCuSk1vYHbGPoB+uutEMrgvnfh+vqDFRrDWl7w9iK1UVxxylDq2gfTVh/9gnNn6EsJRKcGA9bou0/0Lk1EiduzqVQS3DP9zl3FVYb+9/AbuYu/M2dgleS1CZ8dXp3nKcYhfqJIQ2v+dZo44rn1Y/8YZcj/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gn69jvE2; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eX3i5f66cD3Os1VxzSF6NYP4upYBcPhSNhkJZxK7fy5tU1ycLtACz7rSryq4tRf+RElvFfvQmqdWp39Yj4vjLp3zDKtC8qHm5+oWS62Wgra+njCXwrYKVJQwdTJD3WsyFjVv8Iu5ugmaJLYSrQ3zd2PsIhQxL9acn3+F3eItSkD2rSEIhbZCXaHBliqq4HuikJhn61ugWoYrELx0Iy3MOxXsXUk7sby8ifPsKwCqf1SJwIiMfugsP9uUxeyQhyxxM9j+psHW5P2hG4xmL9LDsW5/LdoKqJi+V/ubUjNI3/c8igcYo82+4Rgu/wBm2oXPhmXak7mOF3z/OJG4pqgGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OApf7K1DXNYI+jI9X2cxb1NdTwYn2HDIBypGCKm0BY=;
 b=R6bwkASikrfpDfxxqkWd1kVuU0jIAgQNir6U3gWjhUo8tfaU59apy8Y3ifUsAtPtyGsZvXzo1pp2BUi4SukOzKPveqGOegNcxRxdx0VhmyFj4+ofB8ILoJOyKnRdp5+MFc9npGtxQdzlpVNPW/kOsbmM1LPGNBuIKBvcREpBXmXB6V/5qHCWATilHNngI5GHNVfrz12Rds56xMGIlYfLtm3Nq1Xsqj4blhxbCsZsL71jafjjo0wgBKoFbGBbrNILEEMAQjl40syw2tKWbNLXbTBQ144Snw4ix8dOXT/V7Kzu3s/DLyZYNvzW2VI/10mPCy4rgtNy6sRMsykh/RRDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OApf7K1DXNYI+jI9X2cxb1NdTwYn2HDIBypGCKm0BY=;
 b=gn69jvE2sRmA+CxVqC7yRk+BbEf0mWtnjW2Zg30ocBCHbHg7mkJwPqw7hi7YbgugLROYSuPhUlUBWiM6f67dY9ZBd8TwmITJt8wmY0R6jLVGtPVb/rE+/dUnBjgbFDUkJL9c0gmQn0Z6f9Op4rlfyPtEzku7yLFawGLcsM9C0UDb/gH7Uc1f0emB7XEt45dS9BtbJeenweB+2Y4bDhTTc84sQfDgtIJaKPKJu7XjFIA8873K6ROiucKJs7uil9kfuqU7vSpBO6bnaFa0FoDxcmUPfz8aGLca+9AfRH21T/pL8z0a+VacK255NfZsmT4rC3W4x4sFdT78TPJbj4d9SA==
Received: from CH0PR03CA0118.namprd03.prod.outlook.com (2603:10b6:610:cd::33)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 13:16:23 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::f7) by CH0PR03CA0118.outlook.office365.com
 (2603:10b6:610:cd::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.24 via Frontend Transport; Wed,
 29 Jan 2025 13:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 13:16:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 05:16:10 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 29 Jan 2025 05:16:07 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 03/14] cmis: Change loop order in cmis_show_dom_chan_lvl_flags()
Date: Wed, 29 Jan 2025 15:15:36 +0200
Message-ID: <20250129131547.964711-4-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250129131547.964711-1-danieller@nvidia.com>
References: <20250129131547.964711-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: c41e3055-9a71-4114-92ec-08dd4067208f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Zd0+LDzB+tmp/Gekv58ewPNTy8G6gheyl52AJ3WS11VzZLVCn6qxjNMZtG1?=
 =?us-ascii?Q?98X8Res+iV+INCEpRWAw6Penq2Z0INasWwdS556R831GcdNql8wATgCFbyTD?=
 =?us-ascii?Q?rR9eAURAaw0AxYCNld3aViE608eGasVVr07eENDJv1hczd38leXuYdBV5Hy9?=
 =?us-ascii?Q?4BXAh9xoO2lrFylPSJK1GVlJJ1kw1XpnFY3EdIrlUUuKKi3silWbpmPkg1+/?=
 =?us-ascii?Q?jUzh2NzLbZBmGTvJpcVgV6/taXqaV9GCqfTQC4TKRuIh54n92SXtzfBPJ1kB?=
 =?us-ascii?Q?uRar8DKWV5ru9ZOp2S+oLeCWmtvwuV/RaP/e225Kd1Zbb9CTlRbtgFnAuMiA?=
 =?us-ascii?Q?+hJTHVlOZRtWOc+e9dMbDtGoTVSIUqP9vO3Ee++FvlmG0WxEg8ARL1MBbROX?=
 =?us-ascii?Q?aIqGoeIWgx+L4mdC54bvDEMBLrpUSMvkHgnB0HOpGKRDBMDpAet10q4nOlBP?=
 =?us-ascii?Q?HoTUOTjITZ09yLFEE7kTHnqcXThAVvbC+C2nHJKRer1ON5cZFBC9K1msqBHQ?=
 =?us-ascii?Q?pKzFjOEbSruxU4m8SI5JJFyQd3BW/vppn1nfmbLUY+BMuEqTM/73IBrpbjnB?=
 =?us-ascii?Q?nJjygxffqqbO3pDfkiSaHtSO+ZDu4asKq2a/pD4LhsGPaPPxpy2kkc2YGJo4?=
 =?us-ascii?Q?1Dm0tNhu8Yszaa63IQSZZ5rjIINJE+yf9W6muNvb7CLztPBVC28KyOyi18xB?=
 =?us-ascii?Q?MOFvnhfrP/t2KeBhKBuWC6PMf3YeU4fm/mHiY56CyjX036cytVZYinY1xMsw?=
 =?us-ascii?Q?FcCu4gdr+/bWrJQWYA/soRXbIiin8jjE1KrSf4cm+Qh6ZfuSOJs6B+IiNjJG?=
 =?us-ascii?Q?dhOx/mvqm0r/RPo3jzMKiG7i9J97rAdsp/9eWLj4R2zhaByoI74Wa8BECO4+?=
 =?us-ascii?Q?sZV55KpznTBnFO0kSXBtMjdRZvx0lEFQOn7uBWvn+1FlteQLN2BfTc/9bd9n?=
 =?us-ascii?Q?0Aj78ZIHFALjWN6f83tcm+Ho+ieiRo5W0izGKvdj2Z0bdd6qJh/yzz5BcRgQ?=
 =?us-ascii?Q?uF6baIl1J7ezdfI+ohrIFpNpT1F2r4++hQephKC1QSxheIqxG3kvLZdDaDpT?=
 =?us-ascii?Q?RVWor1oxrPJjU64Mg+tcErJUbrQC85r2iDLg3hHDVVJuap1rAp1ZzZ4joiVr?=
 =?us-ascii?Q?m3YZLYEXHpU+unnK+M01LlXuHwPE4CywrVqVZHqmavz5z6yahkcgZMzZAqNj?=
 =?us-ascii?Q?AtKEVdg+tmZdGFEQqunBakbClMi0SYfB2tNVhgSufkB8ADEC+Wi1CykrEUSQ?=
 =?us-ascii?Q?ZoaALg7cbrR7Q1sJUFnnSe+QXYzXGTkiZx7GGhmjUAziac9Y5K688sKLL4cl?=
 =?us-ascii?Q?d/z8jhnfzD2dDSgjcAN9xxoZwc4FfekzdbRaUeOnU3zWWGY628JNefiycHdR?=
 =?us-ascii?Q?HCXrr/LObM9sLEw43UaQzprOakTnAtt9lZp7+hcI+hH3ktUvAzgm28zRniqK?=
 =?us-ascii?Q?Br5vZvQHg95Q2IReSJZZyipHe2OR/C0mN5giTH8Y7qKRyCoDMnxDDJTNTfN5?=
 =?us-ascii?Q?8JOQJ1SmeDRrWgo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 13:16:22.7005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c41e3055-9a71-4114-92ec-08dd4067208f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340

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


