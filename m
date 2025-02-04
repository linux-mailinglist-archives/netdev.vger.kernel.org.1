Return-Path: <netdev+bounces-162555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3C1A27386
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E32161825
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9FE216E02;
	Tue,  4 Feb 2025 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GQ0iFGHs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450AD2165E8
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676457; cv=fail; b=j56z7XI0ZgSHyrk05HYfEjvSAV3dyJbdIAJNv9S2gaJBrj1g1bLZlmlZUxvRjo44k23X6otYDTHB9sRTogYZct65UM9fvAX3MipSMsvKjvY2QJc9Db7KNSokZ31nhu6WD4Kht40NE970kBTm81xU4oRCg9dBh9JxDU+iEe8/MJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676457; c=relaxed/simple;
	bh=S2JwiOrt66fKCNnZ6dL7fm/xmKR+IcBLqvIAtA8H3+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPI6glqM6FX+/+Y3wo3c5GabpDHjDJxeOezytzjT/AGGR9ZUwm0gPpxMWgxmngvnFS9NC0QcpmJtQTuI/R58AdtcM3GW3R/3WaOwPNEDGJSJyGLz2kSOzKvndMwuyVS99DMZH30zmlMB35eqpUXZOucrJTrohOBar6XLzxq8xFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GQ0iFGHs; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yecgsxab/9cPAibsaNBpVXHBiPNR3r2Ir7Lz9RKXWTMrKItwBvx6TRFbVn3sfDaPop/HmCbVBBvXhlX5DMqMs9DuWqhdlqoaTnAbkhMQ/yf31kOPL5MGaTt71RbMmF5VCP2uVv5fal2bmBUz7um7qm3An8l9G2lX9gM14+NEX/Tqc+2Q7EXiZTo77Q0Z+OulZrlv4H+H7r2U/qvYf6FYkl6aT1N8FZSsYYx0Tc7za+b6X6DDPjFXcQP+njfXw1M+1aeetmXtMJjGAt/MC/i39wpSnG9K0ypxdvvlLPMFdAu4Qp3XOu8CufVqgUt4D7B2G/ldcKU6t/NK1IMr0kQnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA5L+WEu9AW09Wv8n5O6UMki6gpxovYw9bjlEL00Zxw=;
 b=Md2ikc6wga5+2vfkC7Lh+kR+l+/Ys5ZpalksxzaSQM3Dqyomi7WN5UDTx2ByHphwzdoyQzx+PrIPM/ZgpMo72IXuu1Vs7AD3iivfRwozIizmjNHICPyRj/xH9hXlpGHFxgLi91f3K5NKDPhanFyd0VqQtrjYHArHfA6zs79BrwHz0+rzVEqd/nN6V0PputPTqorkxrj5fwDF6KZRhzojMqWYnCs8FsBJ7Hy/j+I3Fzg/zSovC+nATcb9EtsQp2T6VvUfbi2ky4urzmNc20vZyeRgOmjsY2cnzp5ivko+dqzAlpnSOTTM80OanhFroL1uA8PojiUZOLh7RHU45RERPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA5L+WEu9AW09Wv8n5O6UMki6gpxovYw9bjlEL00Zxw=;
 b=GQ0iFGHsP40uxP2Ny4rySgTADawl6KYOenfqqEpPuwrlDLlDs+V6oYi2UMvRwJ/4CjT4xaCXcnuRW4khddWCsrFy+5sX2lilGc3beo+NsBpaw6F4ExgIRzdCzIKejJgQaENPYTKNfX+1OJmNmnKZdcvItMfo3CsH33B/qAZXKLhtQu2FnM0lrAC2O5nivueZ19jPRaBL5MlSNQ6SECWuSEtlcKy+I8z+k7yqpu+IUbxU1ds0zLEZcFP8i7rtXiKY1bL67HmBGnWh1Fn0kkK9/0ngaRYccPqNgC4RO++Hj9YtqK29vmRupiNoYtmyMzQ8mZUmcepegmFA4wDujqNVAw==
Received: from SA1P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::16)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Tue, 4 Feb
 2025 13:40:47 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::36) by SA1P222CA0012.outlook.office365.com
 (2603:10b6:806:22c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Tue,
 4 Feb 2025 13:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 13:40:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 05:40:31 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 05:40:29 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 08/16] cmis: Add JSON output handling to --module-info in CMIS modules
Date: Tue, 4 Feb 2025 15:39:49 +0200
Message-ID: <20250204133957.1140677-9-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: e102bfe7-c596-4c0c-2465-08dd452187e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cF9o0JdfuxL7lgTn+CaXs4twKUOzAXWQ6vk9XfmFPDTHSqTY1Kr2pIyPg1Ju?=
 =?us-ascii?Q?v6OH7uOVqozqTIbf6DhMJ9pIFQCOyiNL6CCZ9KqwCTb3tgbhK+oaBWnMlG7Q?=
 =?us-ascii?Q?eX60/b5p7j09NnKlj1XHikAWMp5kcQo4+k5bzLrdhvYugtUfFBsLCFRy3bl/?=
 =?us-ascii?Q?whP+qEV5ESY9+VXzdMObvuBoIryWF2QD4YguWR42Z0Xf+k7x1pW2OV3nmvmG?=
 =?us-ascii?Q?F5wQizhDohEJ3oHNkBNsUF0/AesQAmFM0MzxQepsFpGeJGZGrO/zLnG+9AoK?=
 =?us-ascii?Q?jj0fHq6RtjpsOo9Dan48X3Mojn1CXaKylQo6loO+20CH4CCCD+LYvLZqwdto?=
 =?us-ascii?Q?0Bz3uBWW9RdZirxD/NppvTd5lmJcfCiespGMh4n1zxYY8blZwr/siHvR9OL/?=
 =?us-ascii?Q?kukfJjvawwz3wgIxXOiu5Q+SJrwCajI612VCiAS0iDWWJDycFdVrrirHP4qj?=
 =?us-ascii?Q?X/F9gSvYzQ2kdxN4sEYO/ME/uuOgS6Pu5Foc99rdyNX7NB1twdqwWeNuPHLJ?=
 =?us-ascii?Q?KTeqby7FJQqmzUfwrkve1QCDVAg3DSiSGivwZLQjtsDxXt+gJlTUFQN2xj57?=
 =?us-ascii?Q?sRjPZsbKJYUTsI5z2VxQJoeoRmU5d70/ukcbtEkQQVFCr7JqdP6y9dUrbT/W?=
 =?us-ascii?Q?S+hzt+MCVG6rnr7wf+PyjMLALdGBj8LrwG5GLVy2ji5hAQD+R5hG+U4Wcv9R?=
 =?us-ascii?Q?P+4gWSGrNfuzpeGtYNyl6ro0fU686lLJMaYCwRculuj+JzAMsdJW9g7/YDFs?=
 =?us-ascii?Q?n5HYTQ1dG4MxyBT1CteBmn3mXDwkXBqkLa8G6T0K6M6nT4Rj0dZ8Aa7eV1sA?=
 =?us-ascii?Q?3ScMaWS4iEu84+qIcBF7JbOerkc/kc8hFWkDvtnubMXGN9Gluqt8ygW6haWX?=
 =?us-ascii?Q?JRxOU/sNYvyrmWQ4l8x2nnX5rUBwnJzhs4j5oOCbzqdUcXSS6rolbzjKhg/2?=
 =?us-ascii?Q?DaT3FjhdwDThIjvsak+ZCEhQ1XvKvfKJyh2/mu3STG43sK9ATgNhQIM/hksU?=
 =?us-ascii?Q?l+W0p4AHDm29n6ZAkAueMayRGNr6o+GNetI0jrBG+ey8wxuQ4fB5SPA9HPjQ?=
 =?us-ascii?Q?mpAPiil3Hn6Snso4vDiTrXHFOAwd/w3bEeXhKZR/ZNVTyIja4EDKWqSwEk3e?=
 =?us-ascii?Q?l0szTqedPmZ6ykGn6+dWjQGkElvvZDL0dRpiTkBkv9Dn/1+BHg8saTTZqM3u?=
 =?us-ascii?Q?3I30qMiALBrxSd1ofHFTIu1AUL3pdmfKSE/hQwleBoxlKiI6Z6UDKh3q8EnP?=
 =?us-ascii?Q?Ll4L+pMIV0mCrXgsYqvYFIh5E0qeLi81uSJUQK0XmKAxvpmpcyQOc+qPsj5n?=
 =?us-ascii?Q?MwauX9PLm1xyiXVXty9kCy4WnSv1uA7M5gu+EfngCatxeD/eUF3QeECtLOS0?=
 =?us-ascii?Q?CR/K4VCrJI9VOpjRcGCxUumfXcQN341FW1tI1/+mxfhGoLDE8eVbOJuOlt2A?=
 =?us-ascii?Q?khZZ1D7ZyQqyZQCPJuzz8tdd6590O0S/Jt/P46S9/ENwhuNRhAIRZZ7OcY4d?=
 =?us-ascii?Q?oMA9w6AkQdM2lSY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:40:47.0378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e102bfe7-c596-4c0c-2465-08dd452187e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

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
    
    v2:
    	* Use uint instead of hexa fields in JSON context.
    	* In rx_power JSON field, add a type field to let the user know
    	  what type is printed in "value".

 cmis.c | 278 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 189 insertions(+), 89 deletions(-)

diff --git a/cmis.c b/cmis.c
index 9cd2bb1..267d088 100644
--- a/cmis.c
+++ b/cmis.c
@@ -62,7 +62,15 @@ static void cmis_show_rev_compliance(const struct cmis_memory_map *map)
 	int major = (rev >> 4) & 0x0F;
 	int minor = rev & 0x0F;
 
-	printf("\t%-41s : Rev. %d.%d\n", "Revision compliance", major, minor);
+	if (is_json_context()) {
+		open_json_object("revision_compliance");
+		print_uint(PRINT_JSON, "major", "%u", major);
+		print_uint(PRINT_JSON, "minor", "%u", minor);
+		close_json_object();
+	} else {
+		printf("\t%-41s : Rev. %d.%d\n", "Revision compliance", major,
+		       minor);
+	}
 }
 
 static void
@@ -123,8 +131,8 @@ static void cmis_show_power_info(const struct cmis_memory_map *map)
 	base_power = map->page_00h[CMIS_PWR_MAX_POWER_OFFSET];
 	max_power = base_power * 0.25f;
 
-	printf("\t%-41s : %d\n", "Power class", power_class + 1);
-	printf("\t%-41s : %.02fW\n", "Max power", max_power);
+	module_print_any_uint("Power class", power_class + 1, NULL);
+	module_print_any_float("Max power", max_power, "W");
 }
 
 /**
@@ -143,7 +151,7 @@ static void cmis_show_cbl_asm_len(const struct cmis_memory_map *map)
 
 	/* Check if max length */
 	if (map->page_00h[CMIS_CBL_ASM_LEN_OFFSET] == CMIS_6300M_MAX_LEN) {
-		printf("\t%-41s : > 6.3km\n", fn);
+		module_print_any_string(fn, "> 6.3km");
 		return;
 	}
 
@@ -168,7 +176,7 @@ static void cmis_show_cbl_asm_len(const struct cmis_memory_map *map)
 	/* Get base value from first 6 bits and multiply by mul */
 	val = (map->page_00h[CMIS_CBL_ASM_LEN_OFFSET] & CMIS_LEN_VAL_MASK);
 	val = (float)val * mul;
-	printf("\t%-41s : %0.2fm\n", fn, val);
+	module_print_any_float(fn, val, "m");
 }
 
 /**
@@ -202,7 +210,7 @@ static void cmis_print_smf_cbl_len(const struct cmis_memory_map *map)
 	/* Get base value from first 6 bits and multiply by mul */
 	val = (map->page_01h[CMIS_SMF_LEN_OFFSET] & CMIS_LEN_VAL_MASK);
 	val = (float)val * mul;
-	printf("\t%-41s : %0.2fkm\n", fn, val);
+	module_print_any_float(fn, val, "km");
 }
 
 /**
@@ -212,22 +220,26 @@ static void cmis_print_smf_cbl_len(const struct cmis_memory_map *map)
  */
 static void cmis_show_sig_integrity(const struct cmis_memory_map *map)
 {
+	bool value;
+
 	if (!map->page_01h)
 		return;
 
 	/* CDR Bypass control: 2nd bit from each byte */
-	printf("\t%-41s : ", "Tx CDR bypass control");
-	printf("%s\n", YESNO(map->page_01h[CMIS_SIG_INTEG_TX_OFFSET] & 0x02));
+	value = map->page_01h[CMIS_SIG_INTEG_TX_OFFSET] & 0x02;
+	module_print_any_bool("Tx CDR bypass control", NULL, value,
+			      YESNO(value));
 
-	printf("\t%-41s : ", "Rx CDR bypass control");
-	printf("%s\n", YESNO(map->page_01h[CMIS_SIG_INTEG_RX_OFFSET] & 0x02));
+	value = map->page_01h[CMIS_SIG_INTEG_RX_OFFSET] & 0x02;
+	module_print_any_bool("Rx CDR bypass control", NULL, value,
+			      YESNO(value));
 
 	/* CDR Implementation: 1st bit from each byte */
-	printf("\t%-41s : ", "Tx CDR");
-	printf("%s\n", YESNO(map->page_01h[CMIS_SIG_INTEG_TX_OFFSET] & 0x01));
+	value = map->page_01h[CMIS_SIG_INTEG_TX_OFFSET] & 0x01;
+	module_print_any_bool("Tx CDR", NULL, value, YESNO(value));
 
-	printf("\t%-41s : ", "Rx CDR");
-	printf("%s\n", YESNO(map->page_01h[CMIS_SIG_INTEG_RX_OFFSET] & 0x01));
+	value = map->page_01h[CMIS_SIG_INTEG_RX_OFFSET] & 0x01;
+	module_print_any_bool("Rx CDR", NULL, value, YESNO(value));
 }
 
 /**
@@ -247,21 +259,25 @@ static void cmis_show_mit_compliance(const struct cmis_memory_map *map)
 	module_show_mit_compliance(value);
 
 	if (value >= CMIS_COPPER_UNEQUAL) {
-		printf("\t%-41s : %udb\n", "Attenuation at 5GHz",
-		       map->page_00h[CMIS_COPPER_ATT_5GHZ]);
-		printf("\t%-41s : %udb\n", "Attenuation at 7GHz",
-		       map->page_00h[CMIS_COPPER_ATT_7GHZ]);
-		printf("\t%-41s : %udb\n", "Attenuation at 12.9GHz",
-		       map->page_00h[CMIS_COPPER_ATT_12P9GHZ]);
-		printf("\t%-41s : %udb\n", "Attenuation at 25.8GHz",
-		       map->page_00h[CMIS_COPPER_ATT_25P8GHZ]);
+		module_print_any_uint("Attenuation at 5GHz",
+				      map->page_00h[CMIS_COPPER_ATT_5GHZ], "db");
+		module_print_any_uint("Attenuation at 7GHz",
+				      map->page_00h[CMIS_COPPER_ATT_7GHZ], "db");
+		module_print_any_uint("Attenuation at 12.9GHz",
+				      map->page_00h[CMIS_COPPER_ATT_12P9GHZ],
+				      "db");
+		module_print_any_uint("Attenuation at 25.8GHz",
+				      map->page_00h[CMIS_COPPER_ATT_25P8GHZ],
+				      "db");
 	} else if (map->page_01h) {
-		printf("\t%-41s : %.3lfnm\n", "Laser wavelength",
-		       (((map->page_01h[CMIS_NOM_WAVELENGTH_MSB] << 8) |
-			  map->page_01h[CMIS_NOM_WAVELENGTH_LSB]) * 0.05));
-		printf("\t%-41s : %.3lfnm\n", "Laser wavelength tolerance",
-		       (((map->page_01h[CMIS_WAVELENGTH_TOL_MSB] << 8) |
-			  map->page_01h[CMIS_WAVELENGTH_TOL_LSB]) * 0.005));
+		module_print_any_float("Laser wavelength",
+				       (((map->page_01h[CMIS_NOM_WAVELENGTH_MSB] << 8) |
+				        map->page_01h[CMIS_NOM_WAVELENGTH_LSB]) * 0.05),
+				       "nm");
+		module_print_any_float("Laser wavelength tolerance",
+				       (((map->page_01h[CMIS_WAVELENGTH_TOL_MSB] << 8) |
+				        map->page_01h[CMIS_NOM_WAVELENGTH_LSB]) * 0.05),
+				       "nm");
 	}
 }
 
@@ -314,6 +330,8 @@ static void cmis_show_vendor_info(const struct cmis_memory_map *map)
 				  CMIS_CLEI_END_OFFSET, "CLEI code");
 }
 
+#define CMIS_MAX_DESC_LEN	64
+
 /* Print the current Module State. Relevant documents:
  * [1] CMIS Rev. 5, pag. 57, section 6.3.2.2, Figure 6-3
  * [2] CMIS Rev. 5, pag. 60, section 6.3.2.3, Figure 6-4
@@ -321,31 +339,40 @@ static void cmis_show_vendor_info(const struct cmis_memory_map *map)
  */
 static void cmis_show_mod_state(const struct cmis_memory_map *map)
 {
+	char mod_state_description[CMIS_MAX_DESC_LEN];
 	__u8 mod_state;
 
 	mod_state = (map->lower_memory[CMIS_MODULE_STATE_OFFSET] &
 		     CMIS_MODULE_STATE_MASK) >> 1;
-	printf("\t%-41s : 0x%02x", "Module State", mod_state);
 	switch (mod_state) {
 	case CMIS_MODULE_STATE_MODULE_LOW_PWR:
-		printf(" (ModuleLowPwr)\n");
+		strncpy(mod_state_description, "ModuleLowPwr",
+			CMIS_MAX_DESC_LEN);
 		break;
 	case CMIS_MODULE_STATE_MODULE_PWR_UP:
-		printf(" (ModulePwrUp)\n");
+		strncpy(mod_state_description, "ModulePwrUp",
+			CMIS_MAX_DESC_LEN);
 		break;
 	case CMIS_MODULE_STATE_MODULE_READY:
-		printf(" (ModuleReady)\n");
+		strncpy(mod_state_description, "ModuleReady",
+			CMIS_MAX_DESC_LEN);
 		break;
 	case CMIS_MODULE_STATE_MODULE_PWR_DN:
-		printf(" (ModulePwrDn)\n");
+		strncpy(mod_state_description, "ModulePwrDn",
+			CMIS_MAX_DESC_LEN);
 		break;
 	case CMIS_MODULE_STATE_MODULE_FAULT:
-		printf(" (ModuleFault)\n");
+		strncpy(mod_state_description, "ModuleFault",
+			CMIS_MAX_DESC_LEN);
 		break;
 	default:
-		printf(" (reserved or unknown)\n");
+		strncpy(mod_state_description, "reserved or unknown",
+			CMIS_MAX_DESC_LEN);
 		break;
 	}
+
+	sff_print_any_hex_field("Module state", "module_state",
+				mod_state, mod_state_description);
 }
 
 /* Print the Module Fault Information. Relevant documents:
@@ -354,6 +381,7 @@ static void cmis_show_mod_state(const struct cmis_memory_map *map)
  */
 static void cmis_show_mod_fault_cause(const struct cmis_memory_map *map)
 {
+	char fault_cause_description[CMIS_MAX_DESC_LEN];
 	__u8 mod_state, fault_cause;
 
 	mod_state = (map->lower_memory[CMIS_MODULE_STATE_OFFSET] &
@@ -362,24 +390,31 @@ static void cmis_show_mod_fault_cause(const struct cmis_memory_map *map)
 		return;
 
 	fault_cause = map->lower_memory[CMIS_MODULE_FAULT_OFFSET];
-	printf("\t%-41s : 0x%02x", "Module Fault Cause", fault_cause);
 	switch (fault_cause) {
 	case CMIS_MODULE_FAULT_NO_FAULT:
-		printf(" (No fault detected / not supported)\n");
+		strncpy(fault_cause_description,
+			"No fault detected / not supported", CMIS_MAX_DESC_LEN);
 		break;
 	case CMIS_MODULE_FAULT_TEC_RUNAWAY:
-		printf(" (TEC runaway)\n");
+		strncpy(fault_cause_description, "TEC runaway",
+			CMIS_MAX_DESC_LEN);
 		break;
 	case CMIS_MODULE_FAULT_DATA_MEM_CORRUPTED:
-		printf(" (Data memory corrupted)\n");
+		strncpy(fault_cause_description, "Data memory corrupted",
+			CMIS_MAX_DESC_LEN);
 		break;
 	case CMIS_MODULE_FAULT_PROG_MEM_CORRUPTED:
-		printf(" (Program memory corrupted)\n");
+		strncpy(fault_cause_description, "Program memory corrupted",
+			CMIS_MAX_DESC_LEN);
 		break;
 	default:
-		printf(" (reserved or unknown)\n");
+		strncpy(fault_cause_description, "reserved or unknown",
+			CMIS_MAX_DESC_LEN);
 		break;
 	}
+
+	sff_print_any_hex_field("Module Fault Cause", "module_fault_cause",
+				fault_cause, fault_cause_description);
 }
 
 /* Print the current Module-Level Controls. Relevant documents:
@@ -388,12 +423,17 @@ static void cmis_show_mod_fault_cause(const struct cmis_memory_map *map)
  */
 static void cmis_show_mod_lvl_controls(const struct cmis_memory_map *map)
 {
-	printf("\t%-41s : ", "LowPwrAllowRequestHW");
-	printf("%s\n", ONOFF(map->lower_memory[CMIS_MODULE_CONTROL_OFFSET] &
-			     CMIS_LOW_PWR_ALLOW_REQUEST_HW_MASK));
-	printf("\t%-41s : ", "LowPwrRequestSW");
-	printf("%s\n", ONOFF(map->lower_memory[CMIS_MODULE_CONTROL_OFFSET] &
-			     CMIS_LOW_PWR_REQUEST_SW_MASK));
+	bool value;
+
+	value = map->lower_memory[CMIS_MODULE_CONTROL_OFFSET] &
+		CMIS_LOW_PWR_ALLOW_REQUEST_HW_MASK;
+	module_print_any_bool("LowPwrAllowRequestHW", "low_pwr_allow_request_hw",
+			      value, ONOFF(value));
+
+	value = map->lower_memory[CMIS_MODULE_CONTROL_OFFSET] &
+		CMIS_LOW_PWR_REQUEST_SW_MASK;
+	module_print_any_bool("LowPwrRequestSW", "low_pwr_request_sw", value,
+			      ONOFF(value));
 }
 
 static void cmis_parse_dom_power_type(const struct cmis_memory_map *map,
@@ -557,14 +597,22 @@ cmis_show_dom_chan_lvl_tx_bias_bank(const struct cmis_memory_map *map,
 	if (!page_11h)
 		return;
 
+	open_json_array("laser_tx_bias_current", "");
+
 	for (i = 0; i < CMIS_CHANNELS_PER_BANK; i++) {
 		int chan = bank * CMIS_CHANNELS_PER_BANK + i;
 		char fmt_str[80];
 
-		snprintf(fmt_str, 80, "%s (Channel %d)",
-			 "Laser tx bias current", chan + 1);
-		PRINT_BIAS(fmt_str, sd->scd[chan].bias_cur);
+		if (is_json_context()) {
+			print_float(PRINT_JSON, NULL, "%.3f",
+				    (double)sd->scd[chan].bias_cur / 500.);
+		} else {
+			snprintf(fmt_str, 80, "%s (Channel %d)",
+				 "Laser tx bias current", chan + 1);
+			PRINT_BIAS(fmt_str, sd->scd[chan].bias_cur);
+		}
 	}
+	close_json_array("");
 }
 
 static void cmis_show_dom_chan_lvl_tx_bias(const struct cmis_memory_map *map,
@@ -593,14 +641,22 @@ cmis_show_dom_chan_lvl_tx_power_bank(const struct cmis_memory_map *map,
 	if (!page_11h)
 		return;
 
+	open_json_array("transmit_avg_optical_power", "");
+
 	for (i = 0; i < CMIS_CHANNELS_PER_BANK; i++) {
 		int chan = bank * CMIS_CHANNELS_PER_BANK + i;
 		char fmt_str[80];
 
-		snprintf(fmt_str, 80, "%s (Channel %d)",
-			 "Transmit avg optical power", chan + 1);
-		PRINT_xX_PWR(fmt_str, sd->scd[chan].tx_power);
+		if (is_json_context()) {
+			print_float(PRINT_JSON, NULL, "%.4f",
+				    (double)sd->scd[chan].tx_power / 10000.);
+		} else {
+			snprintf(fmt_str, 80, "%s (Channel %d)",
+				 "Transmit avg optical power", chan + 1);
+			PRINT_xX_PWR(fmt_str, sd->scd[chan].tx_power);
+		}
 	}
+	close_json_array("");
 }
 
 static void cmis_show_dom_chan_lvl_tx_power(const struct cmis_memory_map *map,
@@ -623,25 +679,38 @@ cmis_show_dom_chan_lvl_rx_power_bank(const struct cmis_memory_map *map,
 				     const struct sff_diags *sd, int bank)
 {
 	const __u8 *page_11h = map->upper_memory[bank][0x11];
+	char *rx_power_type_str;
 	int i;
 
 	if (!page_11h)
 		return;
 
+	if (!sd->rx_power_type)
+		rx_power_type_str = "Receiver signal OMA";
+	else
+		rx_power_type_str = "Rcvr signal avg optical power";
+
+	open_json_object("rx_power");
+
+	open_json_array("values", "");
 	for (i = 0; i < CMIS_CHANNELS_PER_BANK; i++) {
 		int chan = bank * CMIS_CHANNELS_PER_BANK + i;
-		char *rx_power_str;
 		char fmt_str[80];
 
-		if (!sd->rx_power_type)
-			rx_power_str = "Receiver signal OMA";
-		else
-			rx_power_str = "Rcvr signal avg optical power";
-
-		snprintf(fmt_str, 80, "%s (Channel %d)", rx_power_str,
-			 chan + 1);
-		PRINT_xX_PWR(fmt_str, sd->scd[chan].rx_power);
+		if (is_json_context()) {
+			print_float(PRINT_JSON, NULL, "%.4f",
+				    (double)sd->scd[chan].rx_power / 10000.);
+		} else {
+			snprintf(fmt_str, 80, "%s (Channel %d)",
+				 rx_power_type_str, chan + 1);
+			PRINT_xX_PWR(fmt_str, sd->scd[chan].rx_power);
+		}
 	}
+	close_json_array("");
+
+	if (is_json_context())
+		module_print_any_string("type", rx_power_type_str);
+	close_json_object();
 }
 
 static void cmis_show_dom_chan_lvl_rx_power(const struct cmis_memory_map *map,
@@ -672,10 +741,13 @@ static void cmis_show_dom_mod_lvl_flags(const struct cmis_memory_map *map)
 	int i;
 
 	for (i = 0; module_aw_mod_flags[i].str; i++) {
-		if (module_aw_mod_flags[i].type == MODULE_TYPE_CMIS)
-			printf("\t%-41s : %s\n", module_aw_mod_flags[i].str,
-			       map->lower_memory[module_aw_mod_flags[i].offset] &
-			       module_aw_mod_flags[i].value ? "On" : "Off");
+		if (module_aw_mod_flags[i].type == MODULE_TYPE_CMIS) {
+			bool value = map->lower_memory[module_aw_mod_flags[i].offset] &
+					module_aw_mod_flags[i].value;
+
+			module_print_any_bool(module_aw_mod_flags[i].str, NULL,
+					      value, ONOFF(value));
+		}
 	}
 }
 
@@ -692,11 +764,16 @@ static void cmis_show_dom_chan_lvl_flag(const struct cmis_memory_map *map,
 	for (i = 0; i < CMIS_CHANNELS_PER_BANK; i++) {
 		int chan = bank * CMIS_CHANNELS_PER_BANK + i;
 		char str[80];
-
-		snprintf(str, 80, module_aw_chan_flags[flag].fmt_str, chan + 1);
-		printf("\t%-41s : %s\n", str,
-		       page_11h[module_aw_chan_flags[flag].offset] & chan ?
-		       "On" : "Off");
+		bool value;
+
+		value = page_11h[module_aw_chan_flags[flag].offset] & chan;
+		if (is_json_context()) {
+			print_bool(PRINT_JSON, NULL, NULL, value);
+		} else {
+			snprintf(str, 80, "%s (Chan %d)",
+				 module_aw_chan_flags[flag].fmt_str, chan + 1);
+			printf("\t%-41s : %s\n", str, ONOFF(value));
+		}
 	}
 }
 
@@ -711,11 +788,19 @@ cmis_show_dom_chan_lvl_flags_bank(const struct cmis_memory_map *map,
 		return;
 
 	for (flag = 0; module_aw_chan_flags[flag].fmt_str; flag++) {
-		if (!(map->page_01h[module_aw_chan_flags[flag].adver_offset] &
-		      module_aw_chan_flags[flag].adver_value))
-			continue;
-
-		cmis_show_dom_chan_lvl_flag(map, bank, flag);
+		char json_str[80] = {};
+
+		if (module_aw_chan_flags[flag].type == MODULE_TYPE_CMIS) {
+			if (!(map->page_01h[module_aw_chan_flags[flag].adver_offset] &
+			   module_aw_chan_flags[flag].adver_value))
+				continue;
+
+			convert_json_field_name(module_aw_chan_flags[flag].fmt_str,
+						json_str);
+			open_json_array(json_str, "");
+			cmis_show_dom_chan_lvl_flag(map, bank, flag);
+			close_json_array("");
+		}
 	}
 }
 
@@ -745,8 +830,12 @@ static void cmis_show_dom(const struct cmis_memory_map *map)
 	cmis_show_dom_chan_lvl_monitors(map, &sd);
 	cmis_show_dom_mod_lvl_flags(map);
 	cmis_show_dom_chan_lvl_flags(map);
-	if (sd.supports_alarms)
-		sff_show_thresholds(sd);
+	if (sd.supports_alarms) {
+		if (is_json_context())
+			sff_show_thresholds_json(sd);
+		else
+			sff_show_thresholds(sd);
+	}
 }
 
 /* Print active and inactive firmware versions. Relevant documents:
@@ -756,14 +845,24 @@ static void cmis_show_dom(const struct cmis_memory_map *map)
 static void cmis_show_fw_version_common(const char *name, __u8 major,
 					__u8 minor)
 {
+	char json_fn[32] = "";
+
 	if (major == 0 && minor == 0) {
 		return;
 	} else if (major == 0xFF && minor == 0xFF) {
-		printf("\t%-41s : Invalid\n", name);
+		module_print_any_string(name, "Invalid");
 		return;
 	}
 
-	printf("\t%-41s : %d.%d\n", name, major, minor);
+	if (is_json_context()) {
+		convert_json_field_name(name, json_fn);
+		open_json_object(json_fn);
+		print_uint(PRINT_JSON, "major", "%u", major);
+		print_uint(PRINT_JSON, "minor", "%u", minor);
+		close_json_object();
+	} else {
+		printf("\t%-41s : %d.%d\n", name, major, minor);
+	}
 }
 
 static void cmis_show_fw_active_version(const struct cmis_memory_map *map)
@@ -811,7 +910,7 @@ static void cmis_show_cdb_instances(const struct cmis_memory_map *map)
 {
 	__u8 cdb_instances = cmis_cdb_instances_get(map);
 
-	printf("\t%-41s : %u\n", "CDB instances", cdb_instances);
+	module_print_any_uint("CDB instances", cdb_instances, NULL);
 }
 
 static void cmis_show_cdb_mode(const struct cmis_memory_map *map)
@@ -819,8 +918,8 @@ static void cmis_show_cdb_mode(const struct cmis_memory_map *map)
 	__u8 mode = map->page_01h[CMIS_CDB_ADVER_OFFSET] &
 		    CMIS_CDB_ADVER_MODE_MASK;
 
-	printf("\t%-41s : %s\n", "CDB background mode",
-	       mode ? "Supported" : "Not supported");
+	module_print_any_string("CDB background mode",
+			        mode ? "Supported" : "Not supported");
 }
 
 static void cmis_show_cdb_epl_pages(const struct cmis_memory_map *map)
@@ -828,7 +927,7 @@ static void cmis_show_cdb_epl_pages(const struct cmis_memory_map *map)
 	__u8 epl_pages = map->page_01h[CMIS_CDB_ADVER_OFFSET] &
 			 CMIS_CDB_ADVER_EPL_MASK;
 
-	printf("\t%-41s : %u\n", "CDB EPL pages", epl_pages);
+	module_print_any_uint("CDB EPL pages", epl_pages, NULL);
 }
 
 static void cmis_show_cdb_rw_len(const struct cmis_memory_map *map)
@@ -839,9 +938,10 @@ static void cmis_show_cdb_rw_len(const struct cmis_memory_map *map)
 	 * units of 8 bytes, in addition to the minimum 8 bytes.
 	 */
 	rw_len = (rw_len + 1) * 8;
-	printf("\t%-41s : %u\n", "CDB Maximum EPL RW length", rw_len);
-	printf("\t%-41s : %u\n", "CDB Maximum LPL RW length",
-	       rw_len > CMIS_PAGE_SIZE ? CMIS_PAGE_SIZE : rw_len);
+	module_print_any_uint("CDB Maximum EPL RW length", rw_len, NULL);
+	module_print_any_uint("CDB Maximum LPL RW length",
+			      rw_len > CMIS_PAGE_SIZE ? CMIS_PAGE_SIZE : rw_len,
+			      NULL);
 }
 
 static void cmis_show_cdb_trigger(const struct cmis_memory_map *map)
@@ -853,8 +953,8 @@ static void cmis_show_cdb_trigger(const struct cmis_memory_map *map)
 	 * page, or by multiple writes ending with the writing of the CDB
 	 * Command Code (CMDID).
 	 */
-	printf("\t%-41s : %s\n", "CDB trigger method",
-	       trigger ? "Single write" : "Multiple writes");
+	module_print_any_string("CDB trigger method",
+				trigger ? "Single write" : "Multiple writes");
 }
 
 /* Print CDB messaging support advertisement. Relevant documents:
-- 
2.47.0


