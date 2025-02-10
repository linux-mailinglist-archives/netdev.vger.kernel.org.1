Return-Path: <netdev+bounces-164623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80241A2E7E2
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2B53A77BD
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452E91D54FA;
	Mon, 10 Feb 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OIxuea5U"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD951C460A
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180060; cv=fail; b=nTupOHnWLi6DxG4bdlBifpwtl7efKrbNWLA/ZOXii2MQqxtJKtICe+9tLjcNBogvQrtsJo77PHx2Q3e4YdHoqg3HYYym5pQ3o55v/RdeEsNgGkXKyVF0Njbk7sNgHsppGNZo+jKgW3C9EwuvS0wWXOIOeetNN1FrmZHZPJzSpyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180060; c=relaxed/simple;
	bh=GQsyTgUCaC1efYdkTfTpb0F9TOOqpV4cICjltioZxSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOTfmY6GPfTGUlweXC83WBnkgjgDmi9XCHPAp0IIAq+WqDKEUFmjeq+8L1e5if9NC0iokBEt9Oy9twjlZhEGJSKlQFZPNykcJP/uvN4v8UzZmzY5aBb7usUt7RGfX+NiuZQmBAph1eGCzvxIrcVFPP6FZGsxkVoPJ0kZkLj3oJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OIxuea5U; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCmqMBJQCq96k0ViVnRslXYVBh5lTzANvJkzCMgjR2hcBnYbotngZOXtYOz2brUDZgL+3rwAyvTJht1Fs+69xmrtUCVLaQnJuWH8UhP2lHFtbwt+Xci5NPfWFdtx8HItkuOmYGjW1n98ilDW4qR725MKSayxxaBp1ZTpvxSgp47Tk3M/35+rDb5jlthYXbFaN/K2lwrrVwfnA+L2Ykj64BXTsTvfgdrWi08HOfwUnnsorFmEEDyei1q6XHlSbotoBT1K3EVVoPH8dbvmz1dAKJKM3wCJL2vR/zSNPptdFSxr2tR2p1R3Wx2uT7bKFfWrrYO5kJlEJZRelLj+yRR/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ba3kozit9uSL05TfSiGnpH7XibJcm4TS+ioUOZzei4=;
 b=mRaNQj6akTLceWhaz4OIIZD3E7FPF2bpmYprihieim3yyFBhs1wfx5UmrNHcaJuz9i3Q0AYjrWph3w+9h3xHC7x4g2bH+cYJ72erGogmmkdTgz9DXnt81BvLTPsZiAgfi2Ejn5yWRHY49qbxW1zEizeYmSbUWPc/FwP2osLFtCMM4xTUaYUvR+gF4dppbB05L346x4OQjAPTlOpyMVVBZ+YjFGC8Xn/kQ8twpnnGXWU3RVYpmBKGTy1vhH+R7jQn89dTrT2vCcvlgZ1NLMzdhc3PtInxWybXHSGq8WDW5QQcIrg/lzYw828kbof/YXomW8NEdAyZAgSq7Z5/KvJC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ba3kozit9uSL05TfSiGnpH7XibJcm4TS+ioUOZzei4=;
 b=OIxuea5UwLuWzsN5Fx42i56AjWiMFm6739aV8AtXS5U0LQ96ylqLe1HRYrOmjZ7jFJqIFrYqwR2PmvXO+zwEZWdH+BLf9Aho739vx7S/AiqovtvVatjHQjBHOn2Re1PXXeQc2RpT/HRaGe6XVUl3VzVq02UzpTdrKhjeMrMj8+ICBRamHt0ufKcogaGe7BY2JFqNMbKEAG4C6/0CnhTu0kZ2Oh6Gt/+6r9lLiZGKzktB9lgcRzRTyiGVEvnhWibDLIsTPpfzYSuuXKAx0ocZw272inHvb1MawKqrgDKx5YTl9RZUVynIGCTIWjl+uc3yultYQ1JOGwm1UHgldzuYqg==
Received: from CH0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:610:cc::6)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 09:34:11 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::65) by CH0PR03CA0061.outlook.office365.com
 (2603:10b6:610:cc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 09:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:34:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 01:33:59 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 01:33:57 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v5 12/16] sfpid: Add JSON output handling to --module-info in SFF8079 modules
Date: Mon, 10 Feb 2025 11:33:12 +0200
Message-ID: <20250210093316.1580715-13-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: ad426951-e30b-4a42-58b0-08dd49b6136d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qNqzBNxHfZ2yLS1lo16YIflQvm5UzaS8EKuhRxDHlTMS6nhoIXb04bgaTqA7?=
 =?us-ascii?Q?KJi82GraY8FifF5XApsZDwyQZUIo8TIKkhycwR/Zg6z2/zLcrzqZFPiPOoUv?=
 =?us-ascii?Q?D2KF0HOplhq2oIegYPT6CnF8cqWwsawPqRmflvyKZZ+6eK0ZsMBd/es12E4P?=
 =?us-ascii?Q?XdyepAApA+MsO1oif2QivpQHcSGsipPM5+dx2YYvslSs3Pla+mrFuf6Oqidn?=
 =?us-ascii?Q?Hl04IyzRH3CVXuy1jynShPybybOncOfAlCO7T+y9yJJQAprFFWVUyNlVWVJ8?=
 =?us-ascii?Q?JpR2FnM1Kbrawf7+/4SA0hsCV49bVpQS5R4+kBq/y1S9CQbgMYivAQKkepoW?=
 =?us-ascii?Q?dpnZBOmV70oQUAJ7GW4Q+hLnmH2qEsSAJEoC6CnuJ1fRTiRA/XI4rbjMSTYy?=
 =?us-ascii?Q?1Ak9LIBzkvZEWJb0Dy5SZy0BEwKZIPTr+4il9Dg+dIEPsV6iBxFwOy84jUsS?=
 =?us-ascii?Q?hDDkENcPi/Wtc9NlGYfIAD7/DJ44iACS6kAgm94Wl9vnYdcqVvKg6/bwk+HQ?=
 =?us-ascii?Q?w9FLVyjFQ976aGxHCLPNyDo0rXPczZ0B+hWpRMPwozsHcwDNjxAl7JhmAUnM?=
 =?us-ascii?Q?ds52/6uwna4Z/2gjZ5twpPKSVQT4QiYNvWUnEX9l9+Z+dZjiQuihm0OGG1mv?=
 =?us-ascii?Q?cdnXtC2cS8ce8A+eO2vU2o8bxmfAtXMvNTCU/HyydVWLxxLfU467iGseVRxF?=
 =?us-ascii?Q?lhh0Ohva7fCLmwzOuUZmFvd6m8MvTmlHruDd/hVCq0Mmo47kNzzjlzdXVdUg?=
 =?us-ascii?Q?LmZyo4U9RCh9ajrl2I4Ye0aafuH7boKiqhlYifk3+w4yJ8Qa7Unh7z+NC4sn?=
 =?us-ascii?Q?iSSqMhcm8aOMOFb4tkxYxx9xHJ5/GSNXjkFlJSttmBixAlvbYzgGowW40Ybc?=
 =?us-ascii?Q?9wdgBqT5d1FYIAjI/55UBNc5yVIGnh7f15PdOLptjRerDzSy5wfweYwAsqf/?=
 =?us-ascii?Q?kKU6d6mpIwNedDgEVz4hZRYVKB2LTvtjBKaF1TxXPCpE3dvJYZRgrMcqYLV6?=
 =?us-ascii?Q?+yNJsaCc6OJDRdM9d/CmsN9Nhi17gIZ27kWfK+kQOtyFqTw00bGx7NsZWbXF?=
 =?us-ascii?Q?MRL4aZ1rIHHOme9nbte1iCB9cATd79sohZ5tlltrzNC32qLVVhtxeLTO8Q/o?=
 =?us-ascii?Q?oveyr1/bVu6BI8g33R5OM2g3n+10EIkQ3xiz9V7oGVimyqw765Ml/SEuzCsC?=
 =?us-ascii?Q?24xyybBAvzHql0iqrGaLSyDmnf9LHxqWxTZvOXRxrXhkls0mikERPGmgB93a?=
 =?us-ascii?Q?6arOCsFNZ9NmUXCqmtTdOpuVmpyO5rqCEch9NmH3WvhnfBg5FuFRMOylfE7J?=
 =?us-ascii?Q?GKJlXlvkdNn2nHpw28UviNbwN8qZQNF+gf2Btm/lFvlTFDrOgPNkvDgQVq9e?=
 =?us-ascii?Q?7MZy7/YoP8/Xdgj7N712OLCeiW4R7lw4VYS/Eq28tgsRt0dqGtIhxYFdoA/K?=
 =?us-ascii?Q?li0FuGrKzqQxfj4RS/NceU21fV8haoBvsrQUy20V6w6150szHtsAMRLyLVYA?=
 =?us-ascii?Q?iAcNF07rBmCLej0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:34:11.3724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad426951-e30b-4a42-58b0-08dd49b6136d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460

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
Acked-by: Jakub Kicinski <kuba@kernel.org>
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


