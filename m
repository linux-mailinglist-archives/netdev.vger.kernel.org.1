Return-Path: <netdev+bounces-164617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8701BA2E7DB
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2433F3A7306
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F521C700E;
	Mon, 10 Feb 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J2Y+jeaF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04041C9B97
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180048; cv=fail; b=h/SWzrbB9V581b7ys7AWanzYqJ3fGYlcBn2phBbhHXPx6L9uKV1wjjgPqDObNSOM4TuWpLGJFAYVp7Eup/QnXG+JZ5AnrWMjGZzTtQQnwJRnZ2q6TnKnHYlMnE02UuJD4JcMlwBo/RkZmdhS0gLzsJBqLEZCerR3+qurzNLPpZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180048; c=relaxed/simple;
	bh=IKJnASiR6EFOoOeXq34rEOEYg+KteighKsOKyxXL5pE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNEnCLvQZ4xxZJlR/2jhqTibIp4Zjee7qa/Xu63F0fIyrjemSS7Tk4ttcJgr5/UF4Wf7PJ1u5Oof75bEKUGK+BZfiOhIXZ/7Rcmxv8941rIr717iozrZYiGg6wDMxHzivyOVqJQl7I/nWRevs0prUE6u1dggZ2kaPWvAt8vRWpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J2Y+jeaF; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4LP4V0cDMFBT2WuSoo0ipi303lT3TrRDOYzx9yqv8ybDyE9pyAxqVqtC4bBPJh8NrmK8tkG0ADhTj416D7dT3JY64dIbruqPk0vH1c6XrbntUmjwhT3oNpearY9u4dPl5kd7B+T+gkbGGzntapk4A5DlLHjxMfwgnEVR5jDyaPSuwi3W+NvcMBvDWerI9+0B5knYHuWTBxMI6U1cF4tPkIEkORr2gho9MYorLYdG8/Cl9QcPfd5K67OUtWoWNbTddlgYQXbk+bHFM8Ax7mPE96XIXwCtKSV7xB9Rg73b8wAJ74mGdqjPEFbwXCkI7FitNGE+yxJnbH99EpDRMoqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziDXgMVZ+DczLLmQ/ndG54bdTR4GfGuIL2zUB2kCe2s=;
 b=sWRdzvbaqIXOlU1xQfwSsUtoRV43aBw05EO5TGyhz1nuw1pEKtVFB28viQjCVTI+KMJlCsOg/B+bN54q8OLsJNfgDo0SlaHSOSRK7x/AqWOsIjx4LHxnrf9zslhljcDsZxCBt/THXOIbkZFc/xJdIhVWlLH7TZlukshkCnbhsXGgZLUQVz8vIuXd8YHg0/UQH666sWafVCqhPvcPFtzD2p0ipeBIpsAPDvdZ0qtWhvn4WtH/9KGcsIIvWkJ9Y6UGNpw9+a/LQeJJ7LH0UsjFL5A2ErhwTZj6sDb2YP7hc0/bNtysRb+fi3i0G/aTIrmN87NB0rgmgX50O2zjyhuMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziDXgMVZ+DczLLmQ/ndG54bdTR4GfGuIL2zUB2kCe2s=;
 b=J2Y+jeaFmxxvJDDxR34JgZh3mKjbAbP9RsrOb+jddtAmmjTJ24QkszBMXgeZ2rF8Ugwrj9yBxzeo9FiEEw+ZU7ceDEtN7TfhktHh3BGh1SOudlN2Oh+iX2HDC8Wi+W2Pvq5u3naXe8fNPwiigjddx07jLi6PqOa9H5PVOmX5mIUedBfQRe0xWuhmqGgsyq6VXTUfPC9ua++pxZb3g8cXkTOKyNG6dheQZyr16DYT15H36dSZZ1y9VDhGt/MXkX/gk8tg9N5Q380FBh6UNuvhiE3NUvH1hgEo/bDplsqb5MCXY6bicTIIpM4fEsVDvpfNahnafE4vyY9Y84LAJ4hPyw==
Received: from MW4PR03CA0196.namprd03.prod.outlook.com (2603:10b6:303:b8::21)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Mon, 10 Feb
 2025 09:34:00 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::10) by MW4PR03CA0196.outlook.office365.com
 (2603:10b6:303:b8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 09:33:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:33:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 01:33:45 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 01:33:43 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v5 06/16] qsfp: Refactor sff8636_show_dom() by moving code into separate functions
Date: Mon, 10 Feb 2025 11:33:06 +0200
Message-ID: <20250210093316.1580715-7-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210093316.1580715-1-danieller@nvidia.com>
References: <20250210093316.1580715-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 7192f31f-61ed-45b7-7d39-08dd49b60c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4NLxcbgwsWjNUfSS0MKM5KMx53LE+8Ocwpkfnhoq5Qaa7Hq8rM08nQ0ngHbf?=
 =?us-ascii?Q?EtIas4GPhcYVGESIGTzlUR0HAe1zYLTzQVcuTZ+ktbYT2QDMLyXf9ZAzYROD?=
 =?us-ascii?Q?eeh0DkUtr4dj0Rf4jUMUtaxYKqw+B/fOCEHeZPNElat+IJJb+8Uhz+pYpqIg?=
 =?us-ascii?Q?lXpH6vokKhpAuKxg8qFsx4CRR96NI1kUvb2Qi1tKVqHumRzv09qYJ641MLwR?=
 =?us-ascii?Q?TVz1BGZv9UbdFfCeyWygJnXxl+yzP80tnw9FpMyyuKz1elGf2jVv2g9+OTTQ?=
 =?us-ascii?Q?xiQ8dYqvWQyN9X1mJDZbkeE5wi0BXRlX2IzPWYqBdyaNTH+vgPdjH8gSG2Ps?=
 =?us-ascii?Q?6P5LK3NRRinx+ipA3V19/eKsuY3Obf+caf+F1TcYpkDslYcxy/fWU4eJeTwL?=
 =?us-ascii?Q?tOCiyLUr+n+Tt3ofJgMYTm0wG7DBUHUm1Mu6XzSIa6YtwlwJhNlXCjVnmmdj?=
 =?us-ascii?Q?ZDSU+vavBdORg1ZN+KWeqAEtsXDKGI0rAcsL7m6t7iqfRQUYW4V6DaQRkE3A?=
 =?us-ascii?Q?o/Qt54tU6NkDaZGG95Tvdxn3MdbatQr8rGMJs+t5FA7MBkfYOWn6diV4PqfF?=
 =?us-ascii?Q?Fj/ktCRX8WkrPYZZmZCHkSU+jlGVEhetizAnB/WqMwnJzVtrMsZTds8Gi8Sy?=
 =?us-ascii?Q?IGY9vBqqTiRgUfNCyBeDEUxzvvjcgPKHfmiw7NLo05YI/zUH4E/rLCt/v6FK?=
 =?us-ascii?Q?7pcWLYB58z216N21LW9j0T05AWi2PQuTbw1cK9hjJgNF1SmMFbjOhokU0Xx/?=
 =?us-ascii?Q?Y2vED2Vzhf55GpPvwgK9Di0pQtrk8UA0weEucadDt/xMAghGyrYhLp+jaoax?=
 =?us-ascii?Q?di4GrIMkqLn/ORHFkhkKlhVe+jPmDVEQHa5fzYKxYOdObSWBbH9GQoEmoOxp?=
 =?us-ascii?Q?jXLQV2evAaQPsSajo0m9zrOYkqn0M3qbUc3hS9cKQIjtpP/kUftY2X3Y+f/a?=
 =?us-ascii?Q?nj6Tme3dHc2/OG9HcB6wi4m2xtBrgtG6cZm19lMnlSAg3JhyyC4lAj1Xta08?=
 =?us-ascii?Q?jgNuFgQXwECez2gw6ZLvFoIpFA/KQIKC1GYbN2N/MRhYRwlbH0l7HNRlqtD/?=
 =?us-ascii?Q?PeN8+CjG9bWFRb3ixJNMIn9YLha1LCfCJFia2rJxsIRXtlNoSvnKzvn+tPvB?=
 =?us-ascii?Q?0B0yjlhhrQniXqifROk1DGVr34TpklGAyvEGqC5SUB46akKl34+6WeHsE5oa?=
 =?us-ascii?Q?gSlDX0tP+QdPdRBN9tQ/IRNEp2bjmz3Gz90+zL87LD03G9L/Q2a70LTbIp4a?=
 =?us-ascii?Q?36q2vzT1bIrpdGRA6dWPTySLIjt8qkaPR8vRjT9sjT8aZPrlq1Fkpr1Bv14a?=
 =?us-ascii?Q?CUhn8xQznr/CWntSWYFive7P+/j+3AcsfXdyN3noykAUOx5wBztRKP1974K8?=
 =?us-ascii?Q?5sprCiK5br0Jx7ksYmzamshIytjL2um1h97Ty/wjy7waFBQ0Zh1iWPwqxUr7?=
 =?us-ascii?Q?LCpfHFUyh86jt3KqnraWTjEOwvYZiAEgeU9o1RWLvAyAr7D82ujwV4a80H7s?=
 =?us-ascii?Q?EoGcEw6MtepNJSA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:33:59.7150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7192f31f-61ed-45b7-7d39-08dd49b60c67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393

The sff8636_show_dom() function is quite lengthy, and with the planned
addition of JSON support, it will become even longer and more complex.

To improve readability and maintainability, refactor the function by
moving portions of the code into separate functions, following the
approach used in the cmis.c module.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 qsfp.c | 126 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 80 insertions(+), 46 deletions(-)

diff --git a/qsfp.c b/qsfp.c
index c44f045..0af02f0 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -649,13 +649,85 @@ out:
 	}
 }
 
-static void sff8636_show_dom(const struct sff8636_memory_map *map)
+static void sff8636_show_dom_chan_lvl_tx_bias(const struct sff_diags *sd)
 {
-	struct sff_diags sd = {0};
-	char *rx_power_string = NULL;
 	char power_string[MAX_DESC_SIZE];
 	int i;
 
+	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
+		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
+			 "Laser tx bias current", i+1);
+		PRINT_BIAS(power_string, sd->scd[i].bias_cur);
+	}
+}
+
+static void sff8636_show_dom_chan_lvl_tx_power(const struct sff_diags *sd)
+{
+	char power_string[MAX_DESC_SIZE];
+	int i;
+
+	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
+		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
+			 "Transmit avg optical power", i+1);
+		PRINT_xX_PWR(power_string, sd->scd[i].tx_power);
+	}
+}
+
+static void sff8636_show_dom_chan_lvl_rx_power(const struct sff_diags *sd)
+{
+	char power_string[MAX_DESC_SIZE];
+	char *rx_power_string = NULL;
+	int i;
+
+	if (!sd->rx_power_type)
+		rx_power_string = "Receiver signal OMA";
+	else
+		rx_power_string = "Rcvr signal avg optical power";
+
+	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
+		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
+			 rx_power_string, i+1);
+		PRINT_xX_PWR(power_string, sd->scd[i].rx_power);
+	}
+}
+
+static void
+sff8636_show_dom_chan_lvl_flags(const struct sff8636_memory_map *map)
+{
+	bool value;
+	int i;
+
+	for (i = 0; module_aw_chan_flags[i].fmt_str; ++i) {
+		if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
+			continue;
+
+		value = map->lower_memory[module_aw_chan_flags[i].offset] &
+			module_aw_chan_flags[i].adver_value;
+		printf("\t%-41s (Chan %d) : %s\n",
+		       module_aw_chan_flags[i].fmt_str,
+		       (i % SFF8636_MAX_CHANNEL_NUM) + 1,
+		       value ? "On" : "Off");
+	}
+}
+
+static void
+sff8636_show_dom_mod_lvl_flags(const struct sff8636_memory_map *map)
+{
+	int i;
+
+	for (i = 0; module_aw_mod_flags[i].str; ++i) {
+		if (module_aw_mod_flags[i].type == MODULE_TYPE_SFF8636)
+			printf("\t%-41s : %s\n",
+			       module_aw_mod_flags[i].str,
+			       ONOFF(map->lower_memory[module_aw_mod_flags[i].offset]
+				     & module_aw_mod_flags[i].value));
+	}
+}
+
+static void sff8636_show_dom(const struct sff8636_memory_map *map)
+{
+	struct sff_diags sd = {0};
+
 	/*
 	 * There is no clear identifier to signify the existence of
 	 * optical diagnostics similar to SFF-8472. So checking existence
@@ -687,51 +759,13 @@ static void sff8636_show_dom(const struct sff8636_memory_map *map)
 	printf("\t%-41s : %s\n", "Alarm/warning flags implemented",
 		(sd.supports_alarms ? "Yes" : "No"));
 
-	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
-		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
-					"Laser tx bias current", i+1);
-		PRINT_BIAS(power_string, sd.scd[i].bias_cur);
-	}
-
-	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
-		snprintf(power_string, MAX_DESC_SIZE, "%s (Channel %d)",
-					"Transmit avg optical power", i+1);
-		PRINT_xX_PWR(power_string, sd.scd[i].tx_power);
-	}
-
-	if (!sd.rx_power_type)
-		rx_power_string = "Receiver signal OMA";
-	else
-		rx_power_string = "Rcvr signal avg optical power";
-
-	for (i = 0; i < SFF8636_MAX_CHANNEL_NUM; i++) {
-		snprintf(power_string, MAX_DESC_SIZE, "%s(Channel %d)",
-					rx_power_string, i+1);
-		PRINT_xX_PWR(power_string, sd.scd[i].rx_power);
-	}
+	sff8636_show_dom_chan_lvl_tx_bias(&sd);
+	sff8636_show_dom_chan_lvl_tx_power(&sd);
+	sff8636_show_dom_chan_lvl_rx_power(&sd);
 
 	if (sd.supports_alarms) {
-		bool value;
-
-		for (i = 0; module_aw_chan_flags[i].fmt_str; ++i) {
-			if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
-				continue;
-
-			value = map->lower_memory[module_aw_chan_flags[i].offset] &
-				module_aw_chan_flags[i].adver_value;
-			printf("\t%-41s (Chan %d) : %s\n",
-			       module_aw_chan_flags[i].fmt_str,
-			       (i % SFF8636_MAX_CHANNEL_NUM) + 1,
-			       value ? "On" : "Off");
-		}
-		for (i = 0; module_aw_mod_flags[i].str; ++i) {
-			if (module_aw_mod_flags[i].type == MODULE_TYPE_SFF8636)
-				printf("\t%-41s : %s\n",
-				       module_aw_mod_flags[i].str,
-				       (map->lower_memory[module_aw_mod_flags[i].offset]
-				       & module_aw_mod_flags[i].value) ?
-				       "On" : "Off");
-		}
+		sff8636_show_dom_chan_lvl_flags(map);
+		sff8636_show_dom_mod_lvl_flags(map);
 
 		sff_show_thresholds(sd);
 	}
-- 
2.47.0


