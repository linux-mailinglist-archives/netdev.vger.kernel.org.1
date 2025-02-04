Return-Path: <netdev+bounces-162559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0A5A2738C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EF41888F13
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CB5217640;
	Tue,  4 Feb 2025 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XT3D5E5V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18103216615
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676463; cv=fail; b=sAo/fuXDcrepIjkr0NcbOX3Qelz0PCXegS8azGQLDoa8V42BC17g4agh2B+bkUQTd9Rx1hVXoSilMN2550G61KOOHxQDM7ND4om6IwQ9nYaCwTmanw/6DXkdNVlY89efvzpRIILE6G4yA/tQZHyXfx9okQ+UHX0xIKuAILY/KWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676463; c=relaxed/simple;
	bh=Y7C/3aAVzYJIGkM5UhE13O2kUmwGRJCDcjK6enqXQf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9o7FWoxUdhsyxnoi36t3Ywvr1HTWVbX/TTS4MnqCzc5aJOt6nRqncjJymKJMpcikG2YY4Sl57QR94SAYdCz9R11aWUxYYpRPMEpHtV3OJz3AG5YcVsQdzDYuLfoH2zl4wk2qVRKeVZLkq6B+SzyyDRq87k0Q3UdgZuJWdvGKQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XT3D5E5V; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8s7uD8k9hE9AdYbAWyeEh+nb/ZaJGRv4+dgrv8L4NuXvGBzP4+J6DB8SRTCS0TBqNFJeozlwXYpPipMbdM4aBaMjq6h42Kjr3P1w1qJRZud6xJySG+nsEnwIxTq7kriaSkRWSBHyM7008F8sLE8+jY8fVN35WfzPatB0TmC4ct3E1tg9CXHBDCRaYvF+FBxy3jHslkguNJgujJu9kpn8eEYt6+OriKb35gDuA32pT1Dj+Cmfb97jBBGVTRBuNTv9reddt4IANZoFBxD0bZnxZWBJntfu3G0yudA0f9GsqLTASuqA8+yY0nwlV+P5T75IMDHM1/ukor/d8wb0KVjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFI1RsS3cPAfgyhLNfXyVK/PF/pt75mHWHEaGIxUx2U=;
 b=BuCs5/lcOkWQlSc2m7dvhwi0jEFUyNON/5KBUvHaFykvJ3Hdadfc0E4e0tsCRXb44kaEs1vH3FhOaTWWhG56wrq4JkGejIHRhrAls+6PwaBDEQv50R8xofm+hh2MdNnB5CQpnkrFN1AWhXeU1IK57ANZ1L0yE9LQaIKGdqQjNV2rMfavDOlX4PxQBmoy+ptg4kyM8rdoqCQvKtM6DlVlTnSPTte/z8AKlqyrFdoEgTwKtIqQVI6zoUIqR98do2bZ1AUANIaYVESe+FJAMXgUgGvTj74J2hGzYZ1LniBALayBjKvf7q7nsfTg2RUQmwJS30ZCXiUKS/ChM26aSH9QvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFI1RsS3cPAfgyhLNfXyVK/PF/pt75mHWHEaGIxUx2U=;
 b=XT3D5E5V71dJPqZo6c3zbdofD0jw62M/VU5CHmnbmhP3wW6n39rYKp0iZ4ybFXJ4mVWkAn7NzbyvCZX160wSFIdCcINlpIvpq5MlOvSkf+pW8sS7n3jdn1XdzMzxQsnXgfdw8DxVXAmR/FaWclHniCQqF06SQos/yGR9Di3D40CIQ/Z6UW2DXvlzmhr4fvrOjB2vvR6T755DU/CO8C1HVo2SJK1pKpkxblYr9ERIucOaeKRdrb9HYmxzwc5EvBzlF3UP4dvyL+HMEz2cU7rb2M8A0nxc9LClAX6xIYmM2bde/wNm1thOJFW9W7eKPSuosltsYdpChknmU5T1EjVj9w==
Received: from SA9PR13CA0094.namprd13.prod.outlook.com (2603:10b6:806:24::9)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 13:40:57 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::43) by SA9PR13CA0094.outlook.office365.com
 (2603:10b6:806:24::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Tue,
 4 Feb 2025 13:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 13:40:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 05:40:41 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 05:40:38 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 12/16] sfpid: Add JSON output handling to --module-info in SFF8079 modules
Date: Tue, 4 Feb 2025 15:39:53 +0200
Message-ID: <20250204133957.1140677-13-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f239d4-1e8a-49e1-69c0-08dd45218de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2G89e3TsFVqITFpRnMsxiYRM1+UrNv6Yjk67m7yLIVK4ILDIOO/fFXA6t3nE?=
 =?us-ascii?Q?Q5G7ViqyCGlzLaEeZEgYFlzQ51WzHCIcQSj4EFZDgirl2X3+10kWNE365jAC?=
 =?us-ascii?Q?LRl3I2+4f1xBIxyzJyF45bkjq5jzfqiSbwI0uhA6HZxW1rwRse9DXpIHJJSA?=
 =?us-ascii?Q?RjjJD9m+jT+mRpJWOhSctrB9H31CYhZuLTFZHzKMiLAhQlTruOTtx2vhRbJX?=
 =?us-ascii?Q?TfNYulgxW763AK4L+J6kTc+Rq6xsFEA5spgtJBeweBqCauwauaA0M56GGkBQ?=
 =?us-ascii?Q?H6pCBkSFuIrfczEzT00vLAMBcSHEAdEv3qKuvWw1G5KyDEQa3CAI4P0U2l5D?=
 =?us-ascii?Q?PXEQwn1OKBf+4XJs7ycSFI2yfLhXPB6j0mxq6K8tH1bOKj55xAZO7Ozp8Hch?=
 =?us-ascii?Q?yUYlrViIXxwlexkL9HHNZXNzNeuCD2l8OrYdAs1w/tu4YOzm03QFrjXRpaS6?=
 =?us-ascii?Q?rR5Qq2mpU0Z1TKNDx3DtkmQRUhYLJ75jeP0imnXEGUJ70tmAAODSc0HcJg69?=
 =?us-ascii?Q?9ZgIEj22mT1l7IKAe+QbIyIxSv0ckzoXhMtmlqct8kRR1i69W9Yrbzo4tb0E?=
 =?us-ascii?Q?fjRsANVeIHQhBd7KGkjw92pAy1cC+SJglcqMJXYf9utc9C7R25vJxQYm2d+A?=
 =?us-ascii?Q?0LlIZ9Ov/xqC0TbF2gfFcbRr9hm43oDMtiwAngwSPGXJcoi50PhzzZQaYeZR?=
 =?us-ascii?Q?RL4AwUCv9oLj/WXlbP82urNaBuZpBoB7m7uFzvCElXw7YTzE8L4sq/LKY/wp?=
 =?us-ascii?Q?r4InPtnh0U2C1jh+ATNzLUmKokP7njqnMvEkX5cpvPDr0Cbo9hQgOPeEy7yT?=
 =?us-ascii?Q?ZRk0bx0Sx4TW/G68aVw7zli2xvB2Rf0hCG4rT3cDElfNetDlzGfRVBQnlY79?=
 =?us-ascii?Q?ObGUQ0wMFkDjt7tjaC/lSLWRdCv2rAuiSS+ELbViItKiQpYGegI+oh5sIHnL?=
 =?us-ascii?Q?nrVvYPGFmgxVPIDoqrV+kVVA3Xr1j7iPBYE7b+1xHsJyZJ7WGantfDCcAnc4?=
 =?us-ascii?Q?1P2oiXH+W51QDbTz9u4zz5DKfYU957DUa9ujBYw8qIEAe9ZsuDCYWYqa6vjj?=
 =?us-ascii?Q?HFmkyKcKZIQ2iI4xlhP/PYpupgvSo1cuXA0uDROW9D7wZtbLLp1+lPW04J4J?=
 =?us-ascii?Q?uvGoU7vKh9gyN9yzJst5e1MXrGvw/tp8hams+huTqPXhxV2y8pvIW0qTeBWJ?=
 =?us-ascii?Q?JP6P1cMkLc4cFHy6d6BdzFqoFGk9RB8tzz4iDpUc9Ym8320TST8PdhV8l02g?=
 =?us-ascii?Q?CoSeLy5Z630vq4Uj6oSQv64+IaKO+zmoyZoFbTdM0HKE3N8xFVOdjtkXDefF?=
 =?us-ascii?Q?s4kqUVYcqxsG9ZdIoAMgtERSVBXPqxhiU16qgCBNlzeo7n6vXhOXQY0dHLYt?=
 =?us-ascii?Q?8GUZyvl3pF/SLgCOW+vk6VD729RQGUODE6/Q1Sk4YU29zzaA2rovMVdym9wD?=
 =?us-ascii?Q?+bLAhQiVm+Bdt4Cf9ROOa41pcWe/qNDL3HjQgpMiVmWEvg3q99uJ8KZto26l?=
 =?us-ascii?Q?QItj7Im3W5lhG2w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:40:57.1735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f239d4-1e8a-49e1-69c0-08dd45218de2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793

Add JSON output handling for 'ethtool -m' / --module-info, following the
guideline below:

1. Fields with description, will have a separate description field.
2. Units will be documented in a separate module-info.json file.
3. ASCII fields will be presented as strings.
4. On/Off is rendered as true/false.
5. Yes/no is rendered as true/false.
6. Per-channel fields will be presented as array, when each element
   represents a channel.
7. Fields that hold version, will be split to major and minor sub fields.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v3:
    	* Remove unit fields.
    	* Reword commit message.
    	* Remove printings from fields that might be empty strings.
    
    v2:
    	* Use uint instead of hexa fields in JSON context.

 sfpid.c | 381 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 222 insertions(+), 159 deletions(-)

diff --git a/sfpid.c b/sfpid.c
index d128f48..0ccf9ad 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -24,15 +24,22 @@ static void sff8079_show_identifier(const __u8 *id)
 
 static void sff8079_show_ext_identifier(const __u8 *id)
 {
-	printf("\t%-41s : 0x%02x", "Extended identifier", id[1]);
+	char description[SFF_MAX_DESC_LEN];
+
 	if (id[1] == 0x00)
-		printf(" (GBIC not specified / not MOD_DEF compliant)\n");
+		sprintf(description, "%s",
+			"GBIC not specified / not MOD_DEF compliant");
 	else if (id[1] == 0x04)
-		printf(" (GBIC/SFP defined by 2-wire interface ID)\n");
+		sprintf(description, "%s",
+			"GBIC/SFP defined by 2-wire interface ID");
 	else if (id[1] <= 0x07)
-		printf(" (GBIC compliant with MOD_DEF %u)\n", id[1]);
+		sprintf(description, "%s %u", "GBIC compliant with MOD_DEF",
+			id[1]);
 	else
-		printf(" (unknown)\n");
+		sprintf(description, "%s", "unknown");
+
+	sff_print_any_hex_field("Extended identifier", "extended_identifier",
+				id[1], description);
 }
 
 static void sff8079_show_connector(const __u8 *id)
@@ -42,231 +49,259 @@ static void sff8079_show_connector(const __u8 *id)
 
 static void sff8079_show_transceiver(const __u8 *id)
 {
-	static const char *pfx =
-		"\tTransceiver type                          :";
-
-	printf("\t%-41s : 0x%02x 0x%02x 0x%02x " \
-	       "0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
-		   "Transceiver codes",
-	       id[3], id[4], id[5], id[6],
-	       id[7], id[8], id[9], id[10], id[36]);
+	static const char *pfx = "Transceiver type";
+	char value[140] = "";
+
+	if (is_json_context()) {
+		open_json_array("transceiver_codes", "");
+		print_uint(PRINT_JSON, NULL, "%u", id[3]);
+		print_uint(PRINT_JSON, NULL, "%u", id[4]);
+		print_uint(PRINT_JSON, NULL, "%u", id[5]);
+		print_uint(PRINT_JSON, NULL, "%u", id[6]);
+		print_uint(PRINT_JSON, NULL, "%u", id[7]);
+		print_uint(PRINT_JSON, NULL, "%u", id[8]);
+		print_uint(PRINT_JSON, NULL, "%u", id[9]);
+		print_uint(PRINT_JSON, NULL, "%u", id[10]);
+		print_uint(PRINT_JSON, NULL, "%u", id[36]);
+		close_json_array("");
+	} else {
+		printf("\t%-41s : 0x%02x 0x%02x 0x%02x " \
+		       "0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
+		       "Transceiver codes", id[3], id[4], id[5], id[6],
+		       id[7], id[8], id[9], id[10], id[36]);
+	}
 	/* 10G Ethernet Compliance Codes */
 	if (id[3] & (1 << 7))
-		printf("%s 10G Ethernet: 10G Base-ER" \
-		       " [SFF-8472 rev10.4 onwards]\n", pfx);
+		sprintf(value, "%s",
+			"10G Ethernet: 10G Base-LRM [SFF-8472 rev10.4 onwards]");
 	if (id[3] & (1 << 6))
-		printf("%s 10G Ethernet: 10G Base-LRM\n", pfx);
+		sprintf(value, "%s", "10G Ethernet: 10G Base-LRM");
 	if (id[3] & (1 << 5))
-		printf("%s 10G Ethernet: 10G Base-LR\n", pfx);
+		sprintf(value, "%s", "10G Ethernet: 10G Base-LR");
 	if (id[3] & (1 << 4))
-		printf("%s 10G Ethernet: 10G Base-SR\n", pfx);
+		sprintf(value, "%s", "10G Ethernet: 10G Base-SR");
 	/* Infiniband Compliance Codes */
 	if (id[3] & (1 << 3))
-		printf("%s Infiniband: 1X SX\n", pfx);
+		sprintf(value, "%s", "Infiniband: 1X SX");
 	if (id[3] & (1 << 2))
-		printf("%s Infiniband: 1X LX\n", pfx);
+		sprintf(value, "%s", "Infiniband: 1X LX");
 	if (id[3] & (1 << 1))
-		printf("%s Infiniband: 1X Copper Active\n", pfx);
+		sprintf(value, "%s", "Infiniband: 1X Copper Active");
 	if (id[3] & (1 << 0))
-		printf("%s Infiniband: 1X Copper Passive\n", pfx);
+		sprintf(value, "%s", "Infiniband: 1X Copper Passive");
 	/* ESCON Compliance Codes */
 	if (id[4] & (1 << 7))
-		printf("%s ESCON: ESCON MMF, 1310nm LED\n", pfx);
+		sprintf(value, "%s", "ESCON: ESCON MMF, 1310nm LED");
 	if (id[4] & (1 << 6))
-		printf("%s ESCON: ESCON SMF, 1310nm Laser\n", pfx);
+		sprintf(value, "%s", "ESCON: ESCON SMF, 1310nm Laser");
 	/* SONET Compliance Codes */
 	if (id[4] & (1 << 5))
-		printf("%s SONET: OC-192, short reach\n", pfx);
+		sprintf(value, "%s", "SONET: OC-192, short reach");
 	if (id[4] & (1 << 4))
-		printf("%s SONET: SONET reach specifier bit 1\n", pfx);
+		sprintf(value, "%s", "SONET: SONET reach specifier bit 1");
 	if (id[4] & (1 << 3))
-		printf("%s SONET: SONET reach specifier bit 2\n", pfx);
+		sprintf(value, "%s", "SONET: SONET reach specifier bit 2");
 	if (id[4] & (1 << 2))
-		printf("%s SONET: OC-48, long reach\n", pfx);
+		sprintf(value, "%s", "SONET: OC-48, long reach");
 	if (id[4] & (1 << 1))
-		printf("%s SONET: OC-48, intermediate reach\n", pfx);
+		sprintf(value, "%s", "SONET: OC-48, intermediate reach");
 	if (id[4] & (1 << 0))
-		printf("%s SONET: OC-48, short reach\n", pfx);
+		sprintf(value, "%s", "SONET: OC-48, short reach");
 	if (id[5] & (1 << 6))
-		printf("%s SONET: OC-12, single mode, long reach\n", pfx);
+		sprintf(value, "%s", "SONET: OC-12, single mode, long reach");
 	if (id[5] & (1 << 5))
-		printf("%s SONET: OC-12, single mode, inter. reach\n", pfx);
+		sprintf(value, "%s", "SONET: OC-12, single mode, inter. reach");
 	if (id[5] & (1 << 4))
-		printf("%s SONET: OC-12, short reach\n", pfx);
+		sprintf(value, "%s", "SONET: OC-12, short reach");
 	if (id[5] & (1 << 2))
-		printf("%s SONET: OC-3, single mode, long reach\n", pfx);
+		sprintf(value, "%s", "SONET: OC-3, single mode, long reach");
 	if (id[5] & (1 << 1))
-		printf("%s SONET: OC-3, single mode, inter. reach\n", pfx);
+		sprintf(value, "%s", "SONET: OC-3, single mode, inter. reach");
 	if (id[5] & (1 << 0))
-		printf("%s SONET: OC-3, short reach\n", pfx);
+		sprintf(value, "%s", "SONET: OC-3, short reach");
 	/* Ethernet Compliance Codes */
 	if (id[6] & (1 << 7))
-		printf("%s Ethernet: BASE-PX\n", pfx);
+		sprintf(value, "%s", "Ethernet: BASE-PX");
 	if (id[6] & (1 << 6))
-		printf("%s Ethernet: BASE-BX10\n", pfx);
+		sprintf(value, "%s", "Ethernet: BASE-BX10");
 	if (id[6] & (1 << 5))
-		printf("%s Ethernet: 100BASE-FX\n", pfx);
+		sprintf(value, "%s", "Ethernet: 100BASE-FX");
 	if (id[6] & (1 << 4))
-		printf("%s Ethernet: 100BASE-LX/LX10\n", pfx);
+		sprintf(value, "%s", "Ethernet: 100BASE-LX/LX10");
 	if (id[6] & (1 << 3))
-		printf("%s Ethernet: 1000BASE-T\n", pfx);
+		sprintf(value, "%s", "Ethernet: 1000BASE-T");
 	if (id[6] & (1 << 2))
-		printf("%s Ethernet: 1000BASE-CX\n", pfx);
+		sprintf(value, "%s", "Ethernet: 1000BASE-CX");
 	if (id[6] & (1 << 1))
-		printf("%s Ethernet: 1000BASE-LX\n", pfx);
+		sprintf(value, "%s", "Ethernet: 1000BASE-LX");
 	if (id[6] & (1 << 0))
-		printf("%s Ethernet: 1000BASE-SX\n", pfx);
+		sprintf(value, "%s", "Ethernet: 1000BASE-SX");
 	/* Fibre Channel link length */
 	if (id[7] & (1 << 7))
-		printf("%s FC: very long distance (V)\n", pfx);
+		sprintf(value, "%s", "FC: very long distance (V)");
 	if (id[7] & (1 << 6))
-		printf("%s FC: short distance (S)\n", pfx);
+		sprintf(value, "%s", "FC: short distance (S)");
 	if (id[7] & (1 << 5))
-		printf("%s FC: intermediate distance (I)\n", pfx);
+		sprintf(value, "%s", "FC: intermediate distance (I)");
 	if (id[7] & (1 << 4))
-		printf("%s FC: long distance (L)\n", pfx);
+		sprintf(value, "%s", "FC: long distance (L)");
 	if (id[7] & (1 << 3))
-		printf("%s FC: medium distance (M)\n", pfx);
+		sprintf(value, "%s", "FC: medium distance (M)");
 	/* Fibre Channel transmitter technology */
 	if (id[7] & (1 << 2))
-		printf("%s FC: Shortwave laser, linear Rx (SA)\n", pfx);
+		sprintf(value, "%s", "FC: Shortwave laser, linear Rx (SA)");
 	if (id[7] & (1 << 1))
-		printf("%s FC: Longwave laser (LC)\n", pfx);
+		sprintf(value, "%s", "FC: Longwave laser (LC)");
 	if (id[7] & (1 << 0))
-		printf("%s FC: Electrical inter-enclosure (EL)\n", pfx);
+		sprintf(value, "%s", "FC: Electrical inter-enclosure (EL)");
 	if (id[8] & (1 << 7))
-		printf("%s FC: Electrical intra-enclosure (EL)\n", pfx);
+		sprintf(value, "%s", "FC: Electrical intra-enclosure (EL)");
 	if (id[8] & (1 << 6))
-		printf("%s FC: Shortwave laser w/o OFC (SN)\n", pfx);
+		sprintf(value, "%s", "FC: Shortwave laser w/o OFC (SN)");
 	if (id[8] & (1 << 5))
-		printf("%s FC: Shortwave laser with OFC (SL)\n", pfx);
+		sprintf(value, "%s", "FC: Shortwave laser with OFC (SL)");
 	if (id[8] & (1 << 4))
-		printf("%s FC: Longwave laser (LL)\n", pfx);
+		sprintf(value, "%s", "FC: Longwave laser (LL)");
 	if (id[8] & (1 << 3))
-		printf("%s Active Cable\n", pfx);
+		sprintf(value, "%s", "Active Cable");
 	if (id[8] & (1 << 2))
-		printf("%s Passive Cable\n", pfx);
+		sprintf(value, "%s", "Passive Cable");
 	if (id[8] & (1 << 1))
-		printf("%s FC: Copper FC-BaseT\n", pfx);
+		sprintf(value, "%s", "FC: Copper FC-BaseT");
 	/* Fibre Channel transmission media */
 	if (id[9] & (1 << 7))
-		printf("%s FC: Twin Axial Pair (TW)\n", pfx);
+		sprintf(value, "%s", "FC: Twin Axial Pair (TW)");
 	if (id[9] & (1 << 6))
-		printf("%s FC: Twisted Pair (TP)\n", pfx);
+		sprintf(value, "%s", "FC: Twisted Pair (TP)");
 	if (id[9] & (1 << 5))
-		printf("%s FC: Miniature Coax (MI)\n", pfx);
+		sprintf(value, "%s", "FC: Miniature Coax (MI)");
 	if (id[9] & (1 << 4))
-		printf("%s FC: Video Coax (TV)\n", pfx);
+		sprintf(value, "%s", "FC: Video Coax (TV)");
 	if (id[9] & (1 << 3))
-		printf("%s FC: Multimode, 62.5um (M6)\n", pfx);
+		sprintf(value, "%s", "FC: Multimode, 62.5um (M6)");
 	if (id[9] & (1 << 2))
-		printf("%s FC: Multimode, 50um (M5)\n", pfx);
+		sprintf(value, "%s", "FC: Multimode, 50um (M5)");
 	if (id[9] & (1 << 0))
-		printf("%s FC: Single Mode (SM)\n", pfx);
+		sprintf(value, "%s", "FC: Single Mode (SM)");
 	/* Fibre Channel speed */
 	if (id[10] & (1 << 7))
-		printf("%s FC: 1200 MBytes/sec\n", pfx);
+		sprintf(value, "%s", "FC: 1200 MBytes/sec");
 	if (id[10] & (1 << 6))
-		printf("%s FC: 800 MBytes/sec\n", pfx);
+		sprintf(value, "%s", "FC: 800 MBytes/sec");
 	if (id[10] & (1 << 4))
-		printf("%s FC: 400 MBytes/sec\n", pfx);
+		sprintf(value, "%s", "FC: 400 MBytes/sec");
 	if (id[10] & (1 << 2))
-		printf("%s FC: 200 MBytes/sec\n", pfx);
+		sprintf(value, "%s", "FC: 200 MBytes/sec");
 	if (id[10] & (1 << 0))
-		printf("%s FC: 100 MBytes/sec\n", pfx);
+		sprintf(value, "%s", "FC: 100 MBytes/sec");
 	/* Extended Specification Compliance Codes from SFF-8024 */
 	if (id[36] == 0x1)
-		printf("%s Extended: 100G AOC or 25GAUI C2M AOC with worst BER of 5x10^(-5)\n", pfx);
+		sprintf(value, "%s",
+			"Extended: 100G AOC or 25GAUI C2M AOC with worst BER of 5x10^(-5)");
 	if (id[36] == 0x2)
-		printf("%s Extended: 100G Base-SR4 or 25GBase-SR\n", pfx);
+		sprintf(value, "%s", "Extended: 100G Base-SR4 or 25GBase-SR");
 	if (id[36] == 0x3)
-		printf("%s Extended: 100G Base-LR4 or 25GBase-LR\n", pfx);
+		sprintf(value, "%s", "Extended: 100G Base-LR4 or 25GBase-LR");
 	if (id[36] == 0x4)
-		printf("%s Extended: 100G Base-ER4 or 25GBase-ER\n", pfx);
+		sprintf(value, "%s", "Extended: 100G Base-ER4 or 25GBase-ER");
 	if (id[36] == 0x8)
-		printf("%s Extended: 100G ACC or 25GAUI C2M ACC with worst BER of 5x10^(-5)\n", pfx);
+		sprintf(value, "%s",
+			"Extended: 100G ACC or 25GAUI C2M ACC with worst BER of 5x10^(-5)");
 	if (id[36] == 0xb)
-		printf("%s Extended: 100G Base-CR4 or 25G Base-CR CA-L\n", pfx);
+		sprintf(value, "%s",
+			"Extended: 100G Base-CR4 or 25G Base-CR CA-L");
 	if (id[36] == 0xc)
-		printf("%s Extended: 25G Base-CR CA-S\n", pfx);
+		sprintf(value, "%s", "Extended: 25G Base-CR CA-S");
 	if (id[36] == 0xd)
-		printf("%s Extended: 25G Base-CR CA-N\n", pfx);
+		sprintf(value, "%s", "Extended: 25G Base-CR CA-N");
 	if (id[36] == 0x16)
-		printf("%s Extended: 10Gbase-T with SFI electrical interface\n", pfx);
+		sprintf(value, "%s",
+			"Extended: 10Gbase-T with SFI electrical interface");
 	if (id[36] == 0x18)
-		printf("%s Extended: 100G AOC or 25GAUI C2M AOC with worst BER of 10^(-12)\n", pfx);
+		sprintf(value, "%s",
+			"Extended: 100G AOC or 25GAUI C2M AOC with worst BER of 10^(-12)");
 	if (id[36] == 0x19)
-		printf("%s Extended: 100G ACC or 25GAUI C2M ACC with worst BER of 10^(-12)\n", pfx);
+		sprintf(value, "%s",
+			"Extended: 100G ACC or 25GAUI C2M ACC with worst BER of 10^(-12)");
 	if (id[36] == 0x1a)
-		printf("%s Extended: 100GE-DWDM2 (DWDM transceiver using 2 wavelengths on a 1550 nm DWDM grid with a reach up to 80 km)\n",
-		       pfx);
+		sprintf(value, "%s",
+			"Extended: 100GE-DWDM2 (DWDM transceiver using 2 wavelengths on a 1550 nm DWDM grid with a reach up to 80 km)");
 	if (id[36] == 0x1b)
-		printf("%s Extended: 100G 1550nm WDM (4 wavelengths)\n", pfx);
+		sprintf(value, "%s",
+			"Extended: 100G 1550nm WDM (4 wavelengths)");
 	if (id[36] == 0x1c)
-		printf("%s Extended: 10Gbase-T Short Reach\n", pfx);
+		sprintf(value, "%s", "Extended: 10Gbase-T Short Reach");
 	if (id[36] == 0x1d)
-		printf("%s Extended: 5GBASE-T\n", pfx);
+		sprintf(value, "%s", "Extended: 5GBASE-T");
 	if (id[36] == 0x1e)
-		printf("%s Extended: 2.5GBASE-T\n", pfx);
+		sprintf(value, "%s", "Extended: 2.5GBASE-T");
 	if (id[36] == 0x1f)
-		printf("%s Extended: 40G SWDM4\n", pfx);
+		sprintf(value, "%s", "Extended: 40G SWDM4");
 	if (id[36] == 0x20)
-		printf("%s Extended: 100G SWDM4\n", pfx);
+		sprintf(value, "%s", "Extended: 100G SWDM4");
 	if (id[36] == 0x21)
-		printf("%s Extended: 100G PAM4 BiDi\n", pfx);
+		sprintf(value, "%s", "Extended: 100G PAM4 BiDi");
 	if (id[36] == 0x22)
-		printf("%s Extended: 4WDM-10 MSA (10km version of 100G CWDM4 with same RS(528,514) FEC in host system)\n",
-		       pfx);
+		sprintf(value, "%s",
+			"Extended: 4WDM-10 MSA (10km version of 100G CWDM4 with same RS(528,514) FEC in host system)");
 	if (id[36] == 0x23)
-		printf("%s Extended: 4WDM-20 MSA (20km version of 100GBASE-LR4 with RS(528,514) FEC in host system)\n",
-		       pfx);
+		sprintf(value, "%s",
+			"Extended: 4WDM-20 MSA (20km version of 100GBASE-LR4 with RS(528,514) FEC in host system)");
 	if (id[36] == 0x24)
-		printf("%s Extended: 4WDM-40 MSA (40km reach with APD receiver and RS(528,514) FEC in host system)\n",
-		       pfx);
+		sprintf(value, "%s",
+			"Extended: 4WDM-40 MSA (40km reach with APD receiver and RS(528,514) FEC in host system)");
 	if (id[36] == 0x25)
-		printf("%s Extended: 100GBASE-DR (clause 140), CAUI-4 (no FEC)\n", pfx);
+		sprintf(value, "%s",
+			"Extended: 100GBASE-DR (clause 140), CAUI-4 (no FEC)");
 	if (id[36] == 0x26)
-		printf("%s Extended: 100G-FR or 100GBASE-FR1 (clause 140), CAUI-4 (no FEC)\n", pfx);
+		sprintf(value, "%s",
+			"Extended: 100G-FR or 100GBASE-FR1 (clause 140), CAUI-4 (no FEC)");
 	if (id[36] == 0x27)
-		printf("%s Extended: 100G-LR or 100GBASE-LR1 (clause 140), CAUI-4 (no FEC)\n", pfx);
+		sprintf(value, "%s",
+			"Extended: 100G-LR or 100GBASE-LR1 (clause 140), CAUI-4 (no FEC)");
 	if (id[36] == 0x30)
-		printf("%s Extended: Active Copper Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 10-6 or below\n",
-		       pfx);
+		sprintf(value, "%s",
+			"Extended: Active Copper Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 10-6 or below");
 	if (id[36] == 0x31)
-		printf("%s Extended: Active Optical Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 10-6 or below\n",
-		       pfx);
+		sprintf(value, "%s",
+			"Extended: Active Optical Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 10-6 or below");
 	if (id[36] == 0x32)
-		printf("%s Extended: Active Copper Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 2.6x10-4 for ACC, 10-5 for AUI, or below\n",
-		       pfx);
+		sprintf(value, "%s",
+			"Extended: Active Copper Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 2.6x10-4 for ACC, 10-5 for AUI, or below");
 	if (id[36] == 0x33)
-		printf("%s Extended: Active Optical Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 2.6x10-4 for ACC, 10-5 for AUI, or below\n",
-		       pfx);
+		sprintf(value, "%s",
+			"Extended: Active Optical Cable with 50GAUI, 100GAUI-2 or 200GAUI-4 C2M. Providing a worst BER of 2.6x10-4 for ACC, 10-5 for AUI, or below");
 	if (id[36] == 0x40)
-		printf("%s Extended: 50GBASE-CR, 100GBASE-CR2, or 200GBASE-CR4\n", pfx);
+		sprintf(value, "%s",
+			"Extended: 50GBASE-CR, 100GBASE-CR2, or 200GBASE-CR4");
 	if (id[36] == 0x41)
-		printf("%s Extended: 50GBASE-SR, 100GBASE-SR2, or 200GBASE-SR4\n", pfx);
+		sprintf(value, "%s",
+			"Extended: 50GBASE-SR, 100GBASE-SR2, or 200GBASE-SR4");
 	if (id[36] == 0x42)
-		printf("%s Extended: 50GBASE-FR or 200GBASE-DR4\n", pfx);
+		sprintf(value, "%s", "Extended: 50GBASE-FR or 200GBASE-DR4");
 	if (id[36] == 0x43)
-		printf("%s Extended: 200GBASE-FR4\n", pfx);
+		sprintf(value, "%s", "Extended: 200GBASE-FR4");
 	if (id[36] == 0x44)
-		printf("%s Extended: 200G 1550 nm PSM4\n", pfx);
+		sprintf(value, "%s", "Extended: 200G 1550 nm PSM4");
 	if (id[36] == 0x45)
-		printf("%s Extended: 50GBASE-LR\n", pfx);
+		sprintf(value, "%s", "Extended: 50GBASE-LR");
 	if (id[36] == 0x46)
-		printf("%s Extended: 200GBASE-LR4\n", pfx);
+		sprintf(value, "%s", "Extended: 200GBASE-LR4");
 	if (id[36] == 0x50)
-		printf("%s Extended: 64GFC EA\n", pfx);
+		sprintf(value, "%s", "Extended: 64GFC EA");
 	if (id[36] == 0x51)
-		printf("%s Extended: 64GFC SW\n", pfx);
+		sprintf(value, "%s", "Extended: 64GFC SW");
 	if (id[36] == 0x52)
-		printf("%s Extended: 64GFC LW\n", pfx);
+		sprintf(value, "%s", "Extended: 64GFC LW");
 	if (id[36] == 0x53)
-		printf("%s Extended: 128GFC EA\n", pfx);
+		sprintf(value, "%s", "Extended: 128GFC EA");
 	if (id[36] == 0x54)
-		printf("%s Extended: 128GFC SW\n", pfx);
+		sprintf(value, "%s", "Extended: 128GFC SW");
 	if (id[36] == 0x55)
-		printf("%s Extended: 128GFC LW\n", pfx);
+		sprintf(value, "%s", "Extended: 128GFC LW");
+
+	if (value[0] != '\0')
+		module_print_any_string(pfx, value);
 }
 
 static void sff8079_show_encoding(const __u8 *id)
@@ -276,100 +311,128 @@ static void sff8079_show_encoding(const __u8 *id)
 
 static void sff8079_show_rate_identifier(const __u8 *id)
 {
-	printf("\t%-41s : 0x%02x", "Rate identifier", id[13]);
+	char description[SFF_MAX_DESC_LEN];
+
 	switch (id[13]) {
 	case 0x00:
-		printf(" (unspecified)\n");
+		sprintf(description, "%s", "unspecified");
 		break;
 	case 0x01:
-		printf(" (4/2/1G Rate_Select & AS0/AS1)\n");
+		sprintf(description, "%s", "4/2/1G Rate_Select & AS0/AS1");
 		break;
 	case 0x02:
-		printf(" (8/4/2G Rx Rate_Select only)\n");
+		sprintf(description, "%s", "8/4/2G Rx Rate_Select only");
 		break;
 	case 0x03:
-		printf(" (8/4/2G Independent Rx & Tx Rate_Select)\n");
+		sprintf(description, "%s",
+			"8/4/2G Independent Rx & Tx Rate_Select");
 		break;
 	case 0x04:
-		printf(" (8/4/2G Tx Rate_Select only)\n");
+		sprintf(description, "%s", "8/4/2G Tx Rate_Select only");
 		break;
 	default:
-		printf(" (reserved or unknown)\n");
+		sprintf(description, "%s", "reserved or unknown");
 		break;
 	}
+
+	sff_print_any_hex_field("Rate identifier", "rate_identifier", id[13],
+				description);
 }
 
 static void sff8079_show_wavelength_or_copper_compliance(const __u8 *id)
 {
+	char description[SFF_MAX_DESC_LEN];
+
 	if (id[8] & (1 << 2)) {
-		printf("\t%-41s : 0x%02x", "Passive Cu cmplnce.", id[60]);
 		switch (id[60]) {
 		case 0x00:
-			printf(" (unspecified)");
+			strncpy(description, "unspecified",
+				SFF_MAX_DESC_LEN);
 			break;
 		case 0x01:
-			printf(" (SFF-8431 appendix E)");
+			strncpy(description, "SFF-8431 appendix E",
+				SFF_MAX_DESC_LEN);
 			break;
 		default:
-			printf(" (unknown)");
+			strncpy(description, "unknown", SFF_MAX_DESC_LEN);
 			break;
 		}
-		printf(" [SFF-8472 rev10.4 only]\n");
+		strcat(description, " [SFF-8472 rev10.4 only]");
+		sff_print_any_hex_field("Passive Cu cmplnce.",
+					"passive_cu_cmplnce.",
+					id[60], description);
 	} else if (id[8] & (1 << 3)) {
 		printf("\t%-41s : 0x%02x", "Active Cu cmplnce.", id[60]);
 		switch (id[60]) {
 		case 0x00:
-			printf(" (unspecified)");
+			strncpy(description, "unspecified",
+				SFF_MAX_DESC_LEN);
 			break;
 		case 0x01:
-			printf(" (SFF-8431 appendix E)");
+			strncpy(description, "SFF-8431 appendix E",
+				SFF_MAX_DESC_LEN);
 			break;
 		case 0x04:
-			printf(" (SFF-8431 limiting)");
+			strncpy(description, "SFF-8431 limiting",
+				SFF_MAX_DESC_LEN);
 			break;
 		default:
-			printf(" (unknown)");
+			strncpy(description, "unknown", SFF_MAX_DESC_LEN);
 			break;
 		}
-		printf(" [SFF-8472 rev10.4 only]\n");
+		strcat(description, " [SFF-8472 rev10.4 only]");
+		sff_print_any_hex_field("Active Cu cmplnce.",
+					"active_cu_cmplnce.",
+					id[60], description);
 	} else {
-		printf("\t%-41s : %unm\n", "Laser wavelength",
-		       (id[60] << 8) | id[61]);
+		module_print_any_uint("Laser wavelength",
+				      (id[60] << 8) | id[61], "nm");
 	}
 }
 
 static void sff8079_show_options(const __u8 *id)
 {
-	static const char *pfx =
-		"\tOption                                    :";
+	static const char *pfx = "Option";
+	char value[64] = "";
 
-	printf("\t%-41s : 0x%02x 0x%02x\n", "Option values", id[64], id[65]);
+	if (is_json_context()) {
+		open_json_array("option_values", "");
+		print_uint(PRINT_JSON, NULL, "%u", id[64]);
+		print_uint(PRINT_JSON, NULL, "%u", id[65]);
+		close_json_array("");
+	} else {
+		printf("\t%-41s : 0x%02x 0x%02x\n", "Option values", id[64],
+		       id[65]);
+	}
 	if (id[65] & (1 << 1))
-		printf("%s RX_LOS implemented\n", pfx);
+		sprintf(value, "%s", "RX_LOS implemented");
 	if (id[65] & (1 << 2))
-		printf("%s RX_LOS implemented, inverted\n", pfx);
+		sprintf(value, "%s", "RX_LOS implemented, inverted");
 	if (id[65] & (1 << 3))
-		printf("%s TX_FAULT implemented\n", pfx);
+		sprintf(value, "%s", "TX_FAULT implemented");
 	if (id[65] & (1 << 4))
-		printf("%s TX_DISABLE implemented\n", pfx);
+		sprintf(value, "%s", "TX_DISABLE implemented");
 	if (id[65] & (1 << 5))
-		printf("%s RATE_SELECT implemented\n", pfx);
+		sprintf(value, "%s", "RATE_SELECT implemented");
 	if (id[65] & (1 << 6))
-		printf("%s Tunable transmitter technology\n", pfx);
+		sprintf(value, "%s", "Tunable transmitter technology");
 	if (id[65] & (1 << 7))
-		printf("%s Receiver decision threshold implemented\n", pfx);
+		sprintf(value, "%s", "Receiver decision threshold implemented");
 	if (id[64] & (1 << 0))
-		printf("%s Linear receiver output implemented\n", pfx);
+		sprintf(value, "%s", "Linear receiver output implemented");
 	if (id[64] & (1 << 1))
-		printf("%s Power level 2 requirement\n", pfx);
+		sprintf(value, "%s", "Power level 2 requirement");
 	if (id[64] & (1 << 2))
-		printf("%s Cooled transceiver implemented\n", pfx);
+		sprintf(value, "%s", "Cooled transceiver implemented");
 	if (id[64] & (1 << 3))
-		printf("%s Retimer or CDR implemented\n", pfx);
+		sprintf(value, "%s", "Retimer or CDR implemented");
 	if (id[64] & (1 << 4))
-		printf("%s Paging implemented\n", pfx);
+		sprintf(value, "%s", "Paging implemented");
 	if (id[64] & (1 << 5))
-		printf("%s Power level 3 requirement\n", pfx);
+		sprintf(value, "%s", "Power level 3 requirement");
+
+	if (value[0] != '\0')
+		module_print_any_string(pfx, value);
 }
 
 static void sff8079_show_all_common(const __u8 *id)
@@ -393,7 +456,7 @@ static void sff8079_show_all_common(const __u8 *id)
 		sff8079_show_connector(id);
 		sff8079_show_transceiver(id);
 		sff8079_show_encoding(id);
-		printf("\t%-41s : %u%s\n", "BR, Nominal", br_nom, "MBd");
+		module_print_any_uint("BR Nominal", br_nom, "MBd");
 		sff8079_show_rate_identifier(id);
 		module_show_value_with_unit(id, 14, "Length (SMF)", 1, "km");
 		module_show_value_with_unit(id, 16, "Length (OM2)", 10, "m");
@@ -408,8 +471,8 @@ static void sff8079_show_all_common(const __u8 *id)
 		module_show_ascii(id, 40, 55, "Vendor PN");
 		module_show_ascii(id, 56, 59, "Vendor rev");
 		sff8079_show_options(id);
-		printf("\t%-41s : %u%s\n", "BR margin, max", br_max, "%");
-		printf("\t%-41s : %u%s\n", "BR margin, min", br_min, "%");
+		module_print_any_uint("BR margin max", br_max, "%");
+		module_print_any_uint("BR margin min", br_min, "%");
 		module_show_ascii(id, 68, 83, "Vendor SN");
 		module_show_ascii(id, 84, 91, "Date code");
 	}
-- 
2.47.0


