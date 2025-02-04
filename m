Return-Path: <netdev+bounces-162561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C4FA2738D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A958F18888CA
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D4D217674;
	Tue,  4 Feb 2025 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T3MhvOvM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374CB217667
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676470; cv=fail; b=TdTeC9UuMKx0J/3JACWUHyvRIg1EC9H/4XElNWkuldEx8bHQINQ3ypHFhr5t6WFnzFyJvPWsZsMj3iTbSQTnBYENxjfHHL8FaSYwXMnjuDivav1EDKpzPMIdJ765unWE2C0UYYBzHc0U4evmbayB75jL+GGnEdpI8QN1CFDXUks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676470; c=relaxed/simple;
	bh=J5MQS9FG0LyZaiQQ36NZoRRcYPRmeFBovNAZcLMg+rM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRBdVXXYlaMKpEdPnr83rPjlUJYgiDuVstxusYQuKoLzrm1LGra2dFuvR9nNoJuXr9fMc+ltCBczJhFgsWqxm+8nYRfV5VG/trG6MQPiF6pZZXV/T3DT2L2ax0OyAkDr32RkOI+h8PC3extLnL8t/etvAdGf2Ow1cascWuMSM6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T3MhvOvM; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaMFZIMS+MxM+jIAV5FYWHyY3g9eSoktPljr51WyE8r6mbctHoEMQ8u6NDHpXOasPNKYkRMP00c2rLCv6fh34KNtp+wCJ6SOHIV2x6adFef8FZ1nQ2AQT9uVfbqZuJZ7wnA/Bxpfo0mcq7O6e6jvVIvZ3XWLgo70I7nKYAGgEePMcP5aWGdPUVRPYQKHmcDHL0XDhoF2cSosth1ezzPSBiOqki/4HBsYKZpNaQmVjqdGO09WtmJG3WGFp7WiCLbZjOF0kYBqYJ+Dw8r6RSGzMHspScQF8248Qis+AnVYRoELY4kGYmeoJJt48BcTJF6OOcWXi98ZMbvIkLR0wHoq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMH1Vn5Ltg7fD+iwoDdA7oOIvaoyd+lFrS16Nw1VzCM=;
 b=i+cGqxO9xibLBDWw16w+Pnl5cU+6sTZJq2RbKMDwPcYK0L9gQOaCWNzZI6oh1OjxZX7MBHx7VEB29vU8jjapYAChUW0zeZRJ9554BLPY/hjZUi+uHr47SnwDhVyHEsdS8tJaagZUX5BtM9bfchiQnKzLvOUYTon7tHkE/NUPI3nMf4oVy48EbsRCUy9B44m00+60O4Is8cxb9CVBaeQsAaTOY6046QaU2vsB7VlBgXvqMBLJDQevHKu61FlSyTdtHrOAPbCHPIGSJ0kRs8u0cenCJo8r9/G2V90bjYaAddyf4MvwHaHaqQTiw4azWw3i6ezkKosF2YDO9WVoCxwXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMH1Vn5Ltg7fD+iwoDdA7oOIvaoyd+lFrS16Nw1VzCM=;
 b=T3MhvOvMmnB2hzVRNvZ42ZOOMU+hLLXLdbiZym+BB/WjQ/mH0bM+DxVdsl6jFdJJOK9mLZRXRkZ2ZB2Fq5dHsioB6LbOt4jPuPX9cazGYC8AMvS0dmENNWOPCd1JBs54eD8/nVRh8x+tOhBdmcNEvSjW1tcjEzezy0LCtFl9lACR/FFBDjyyMzr/BpeTw8pAL94zj9Ul/FI/v+hFD8jxWmDefewFI8Tly+72FI8FcFzcNjFp3WoOM1aVxChuZpY5C5zzcdGmpqPV6KkAGrPcjLPCTjz5H5/zjuREcELtzKiFoWOZWjef325bFt/rSAQi6ux4flhCKSuTcjUcErPw1w==
Received: from SA1P222CA0194.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::19)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Tue, 4 Feb
 2025 13:41:00 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:3c4:cafe::70) by SA1P222CA0194.outlook.office365.com
 (2603:10b6:806:3c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Tue,
 4 Feb 2025 13:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 13:41:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 05:40:43 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 05:40:40 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 13/16] sfpdiag: Add JSON output handling to --module-info in SFF8472 modules
Date: Tue, 4 Feb 2025 15:39:54 +0200
Message-ID: <20250204133957.1140677-14-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: e06e9ea6-f896-4c09-bfc8-08dd45218fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xh3Un32Lm/OEB1S454p2/GYpxnQfaW0WcSAJ+AzEiJYmH7kFB3hl1iVFmgNs?=
 =?us-ascii?Q?OSdU2g2jKQUxpr4b/CW+DWvY9jUKneIGr8e0nF0rxBHcy/QSdY7X4EfikX7l?=
 =?us-ascii?Q?kb4Geah01KqQ6xm5L74ZtWmryU2KhIw4BnaJbGPPPANQ3aUIPjECxknuq/BC?=
 =?us-ascii?Q?TWXkXe2TpbGPpu2sCK7XahmimwKoM+KIb8HOAeWJzljd98Ctg6eDNC3Egi4j?=
 =?us-ascii?Q?MAaB5oMWYaM/rQaICbDBiSyhr3dgncRCkNrnP/BCLYdEPtTlSP1oeKDOMxB4?=
 =?us-ascii?Q?ARkEfO+ijOtbAebR7yylvIUGLJWvQ6wb2ICvQyn6k+e2Hd1/yZ8IlSpsfbvk?=
 =?us-ascii?Q?Q4c6rPv2BwRYy7Z9gAIdaVEIgmLje5N9wwwmzLbmJXCN3XttJCr2ESvGJlUQ?=
 =?us-ascii?Q?YfRKFsiAiQJ7mrmsgYnTYDU7es+W4N1CWl2upFmRbNM8/mJsypPlFlMQyiDK?=
 =?us-ascii?Q?R01ZNBgGc3yUZFy9M0DrAzk6zHj9VSRWnTiF8Y/mVkYlqWsPiF6stTYDVkr0?=
 =?us-ascii?Q?9CuCiqhA+qm9BW/ittVOaZk2nxu6XBFpSicVOxF6R5F5bdgJWslVIsHqq7Fr?=
 =?us-ascii?Q?/JW+qUvIlx0++2TpJrXSWzDz930paWsgUt0mk0YMtX3xPmV3EGYaXU7vUfHB?=
 =?us-ascii?Q?cbhpiBLNrYEogCOWIHeHNUuliYre9clYNGHZzXMraDS3xTq9MVU9fauaw+Lh?=
 =?us-ascii?Q?PbUSy8msPcqkgbEHv/1WMPl8YQjmUtoN3mbLrks9Mlll3pywWpeQ7oPS7ad6?=
 =?us-ascii?Q?NQJVYx335gixIZb7WH3xLzdGsDH/HhxNTN44rofFYlFQuzxj+Znv2wJ3NIPQ?=
 =?us-ascii?Q?92uGIiPesVSb/L8XnZrjtdI+Gsjs9fHhmN8Dd5P3T486KYUBvm7ZVMdRCMwq?=
 =?us-ascii?Q?cjKuf3b7PMtyq+wlw7DXI1S7Y/AW5FlkyfxaEiviriR/yvII+znqhF1EyTBb?=
 =?us-ascii?Q?ULiOOFjHotZ2pFRrHqZD8q3a9try+6ICFMBdXb6CgZ+qzsMGEMiYV7/KxEFf?=
 =?us-ascii?Q?utEr6xqFD9TjU0VeAacGF5fElATunChBSNu1a2qRrHJIvr9MTwrQMjc+/8/i?=
 =?us-ascii?Q?iIQ0XTliOfNK4zaRZC2Bfd3SfiDOutH6x0dBfGphpDgzswbzZchhRuHINHya?=
 =?us-ascii?Q?Esck/cIgGXvBFOgyjVKP9lhKxZ5UEjriu0Vmu7Z1R6L7K6QF7IBACFFfHuwY?=
 =?us-ascii?Q?XQ829nxqjDQhSXWvUROjfIzrN8x59GWte4omq1ABrFSjHqhhO48VuR5+zjVC?=
 =?us-ascii?Q?duRRfwWPe5q+xpcJ+fSXdSrYdFskxJbdHGv94lBjJSwW8IvrJKkvWHoVHSFs?=
 =?us-ascii?Q?t2ICUs80j1pkC45Ab+zMLXJKlkU2KZGLzrFuXWT4dTaddqj9E2azaKw+F/rK?=
 =?us-ascii?Q?aFvjXM/RVceeLBKNP8ohVC+g2LaMD0AJ5PGtuwymo9m1HCPc+Hv1Zpf6aEBH?=
 =?us-ascii?Q?TlhQ0qjtoZ6lQJj5cv7R5nTkQJ7HbEUUe9xFi+ExMy3KM43yLE5bb0X4rkot?=
 =?us-ascii?Q?Udgsn3HTt8YlKYA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:41:00.1248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e06e9ea6-f896-4c09-bfc8-08dd45218fa4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344

Add JSON output handling for 'ethtool -m' / --module-info, following
the guideline below:

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
    	* In rx_power JSON field, add a type field to let the user know
    	  what type is printed in "value".

 sfpdiag.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/sfpdiag.c b/sfpdiag.c
index bbca91e..a32f72c 100644
--- a/sfpdiag.c
+++ b/sfpdiag.c
@@ -241,40 +241,55 @@ static void sff8472_parse_eeprom(const __u8 *id, struct sff_diags *sd)
 
 void sff8472_show_all(const __u8 *id)
 {
+	char *rx_power_type_string = NULL;
 	struct sff_diags sd = {0};
-	char *rx_power_string = NULL;
 	int i;
 
 	sff8472_parse_eeprom(id, &sd);
 
-	if (!sd.supports_dom) {
-		printf("\t%-41s : No\n", "Optical diagnostics support");
+	module_print_any_bool("Optical diagnostics support",
+			      "optical_diagnostics_support",
+			      sd.supports_dom, YESNO(sd.supports_dom));
+
+	if (!sd.supports_dom)
 		return;
-	}
-	printf("\t%-41s : Yes\n", "Optical diagnostics support");
 
-	PRINT_BIAS("Laser bias current", sd.bias_cur[MCURR]);
-	PRINT_xX_PWR("Laser output power", sd.tx_power[MCURR]);
+	PRINT_BIAS_ALL("Laser bias current", "laser_bias_current",
+		       sd.bias_cur[MCURR]);
+	PRINT_xX_PWR_ALL("Laser output power", "laser_output_power",
+			 sd.tx_power[MCURR]);
 
 	if (!sd.rx_power_type)
-		rx_power_string = "Receiver signal OMA";
+		rx_power_type_string = "Receiver signal OMA";
 	else
-		rx_power_string = "Receiver signal average optical power";
+		rx_power_type_string = "Receiver signal average optical power";
 
-	PRINT_xX_PWR(rx_power_string, sd.rx_power[MCURR]);
+	open_json_object("rx_power");
+	PRINT_xX_PWR_ALL(rx_power_type_string, "value", sd.rx_power[MCURR]);
+	if (is_json_context())
+		module_print_any_string("type", rx_power_type_string);
+	close_json_object();
 
 	module_show_dom_mod_lvl_monitors(&sd);
 
-	printf("\t%-41s : %s\n", "Alarm/warning flags implemented",
-	       (sd.supports_alarms ? "Yes" : "No"));
+	module_print_any_bool("Alarm/warning flags implemented",
+			      "alarm/warning_flags_implemented",
+			      sd.supports_alarms, YESNO(sd.supports_alarms));
+
 	if (sd.supports_alarms) {
 
 		for (i = 0; sff8472_aw_flags[i].str; ++i) {
-			printf("\t%-41s : %s\n", sff8472_aw_flags[i].str,
-			       id[SFF_A2_BASE + sff8472_aw_flags[i].offset]
-			       & sff8472_aw_flags[i].value ? "On" : "Off");
+			bool value;
+
+			value = id[SFF_A2_BASE + sff8472_aw_flags[i].offset] &
+				sff8472_aw_flags[i].value;
+			module_print_any_bool(sff8472_aw_flags[i].str, NULL,
+					      value, ONOFF(value));
 		}
-		sff_show_thresholds(sd);
+		if (is_json_context())
+			sff_show_thresholds_json(sd);
+		else
+			sff_show_thresholds(sd);
 	}
 }
 
-- 
2.47.0


