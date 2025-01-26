Return-Path: <netdev+bounces-160977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC42BA1C79F
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A11618862CF
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4EB158558;
	Sun, 26 Jan 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IBXtIl0V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C41185B76
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737892658; cv=fail; b=YQAyI4X+7TMXzZuuouyRc+rS54NpbUfaUl568oZQzbGAP+qouL+DfYYUEbnWcJjGwOquQVP0Sl5zcUe9cEz59xObdcb5wxy65yzivmiryqZBuvD6Nxg+/XzDqveM1QBuS4GLNzpXDkL0DrqFWiMNzMYgnC9AUv0/QOIKFfVqHQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737892658; c=relaxed/simple;
	bh=9LmqxUqUzEtUZHfdwOW3B6AP3N/CK5Ym86SpM3rNlnU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQUnGWuZfancvf03TWbWh+nCi9r0AnEW4KjOJ+bF2ve+uIS2uY9LJWuwF6Z98ycPCCw72sIt0Ow8zv535lNERrsXZeytlswD6Ac7wnhUknd5KlzXtEeLwVrLAqzQQdKcRil7Vw2DblN57U/G28Ovx8sxAbSoso1JYyGxNp2HgM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IBXtIl0V; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LscndD7t68MWMwyl9yXxTp9sbBgIYq86/lm1c2dQfnxbScMw7k4t/ofLkcYPqsqA1W0hMSeCvFLqQhPg4b5MOK69IIsTQtkJIBTuWrjYtfUd9Wv/9ZiEUX4bv35YigGV8qbXtpgIq0KfTCj9VH6grRF6lkaBrws0MA6kfc3ztMPMxM9cSvhgv6c1QK44oD6CTwzWw2+SeeF0EJkwN0cwPzVkGTmZ/Pw91eFUyFTJEpDdzka/o+V5d9cO/KgzsWmgRhJl3pTj9q0hGA0BlIkZfIAJt4rnm1whDtAEX/SRtV8dwApi3Sn948uDggknVR9fj6opP7tF0FXXtIMt/b2ROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tz+ovAn3jXR4UyhHy5F7C54yl0rxnjvog6d23DT4lDk=;
 b=Su+MSCsf9Yw/7/E7p4A/8mLpsoX7hHLCrpo5JkS8FOoFNVizbVojbMrUBZOrkSyDldVPpHF9SNiEmbPO5QPq64YIDe2XKXjohWM5P5qIz4hNqzTiEa0RQzMH41u2HsHTd/mV6qf5fyOLSU1gDHwgIXdkWecjYl1OX2fOl74eWcR8KAvuNURsDWxWaeJmeDu5iYjoDv1/M6dT/PRKRDqgXDcmuj2FIQZqVNNNaxtCM+hoN82nzPr3VxZ6cV+goLCYeDOwPOvI+ekgsNVP204btbyBh3JSMHWHmr84tEOo4wMdfFmgYrv4haqn2VlWXHN7qA74fB3X0KJwy7QmB1dsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz+ovAn3jXR4UyhHy5F7C54yl0rxnjvog6d23DT4lDk=;
 b=IBXtIl0VZdMS9gXlroSujZMbdKer+xB+lyijOibB2lTOx+IUwCrhPfpckO6yOKYxq2u2KClVhdlUG1ANWrqvJGyx3DlHRk5tBLptFkjRp/+GD4vnKtzJxA9gvT4Do7NC/fnhK36EwcaLq9pPCyo4pVV2ftPIdW6MsiJfL6StgvNUPH15utXPMWZ+3Fxm0i4efsWfL0HYNfqxyDu6/F/2wLbFNElLgkkubtWfU4so9qt74apEScr3ocmFs76QTljXPvb4vJdYS1lkGdTvkgquvWlcSmkcN1X+aRAU0BF76/8eA2DIskHnlSZnsIhOR9jVewzXR+inQXy2TRcIL808nQ==
Received: from PH8PR07CA0012.namprd07.prod.outlook.com (2603:10b6:510:2cd::6)
 by IA1PR12MB9467.namprd12.prod.outlook.com (2603:10b6:208:594::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 11:57:33 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::84) by PH8PR07CA0012.outlook.office365.com
 (2603:10b6:510:2cd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.21 via Frontend Transport; Sun,
 26 Jan 2025 11:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 11:57:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 Jan
 2025 03:57:19 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 26 Jan 2025 03:57:17 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 12/14] sfpdiag: Add JSON output handling to --module-info in SFF8472 modules
Date: Sun, 26 Jan 2025 13:56:33 +0200
Message-ID: <20250126115635.801935-13-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|IA1PR12MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 018de756-32ce-4e0a-218f-08dd3e009e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pb85p9EBFQ5EyKyZ5inTB2/G6ol0PXMeTYTfs7LSenZP5UUifKXGhMcjcPyS?=
 =?us-ascii?Q?sRXIfGUs7CUpyLs8O/QfIIT47Ea6uZm6zCB+BjAvx0BtbGCEY+PhXXpaGp+w?=
 =?us-ascii?Q?i2Dfx3+cMOhHbAtwjo9BYFcyLPKJDcxMOMsk2Uoho6hg6KbhJgkvcqjJjgne?=
 =?us-ascii?Q?zRrFBEcnhNRbhzMRdatl3C7P3zHX66XTaM22uPMTtb6gj43lBKKzhaHWRL/L?=
 =?us-ascii?Q?UBN3yLHTLIyDi3dpgPRGSzGIN+UBKkW31suey3MpZmbI2jZBew5byj7/vio+?=
 =?us-ascii?Q?q1eRBT89U580k8EI3NjMsndVhZQKG4QS8oaNQs0IomKGzGCm8Cb4skvlDUQf?=
 =?us-ascii?Q?iVEp/AjEKEmeMf4hJz6JMLd165Q1tgZ9pjaUtbgi5lKUjrU8OF/k5HtG3ROW?=
 =?us-ascii?Q?/th0KYBmrKB/fVg3VKe7f0gNIm21X65m2NEvcJkGePGaFfOFjReqKIfGm+PV?=
 =?us-ascii?Q?bffCh8H1fWoreMC6Yqh/7Mny4BtJk2hEfliZzcyAQTT2tPD11W1nIftjqe+N?=
 =?us-ascii?Q?KtokZwI589HlTtwGV1sjFVSxs6YRazp3vkun9gV1/Qnte50ckdl5qoJWycUw?=
 =?us-ascii?Q?a5QrtXzcrG7KsE0SbblDzEOZqR2tQH4WEdm/YxfarZRCS6YaS89KHhtHx9jg?=
 =?us-ascii?Q?zuSSFoTXjEk+vUB0JSVEjp6jyZ0QWqTETxe83kEAEwvLLbYUOuRZ6Zq5710Q?=
 =?us-ascii?Q?SCpLsl5yRP1qBzYR+n1fBMho2Ug/IWb/c6yflxi9IiCt+tRG82yYcKN3/M7E?=
 =?us-ascii?Q?Fmyps5dHZceoOUdmXO3RCREt8L6WRzxTL+1P5xZTGyZCriC+ypLVQKQQpFYC?=
 =?us-ascii?Q?zdQVQePwdMlDBc2g61sMHBDTKITPSqxHW2d895pFAsdq+3S51Dt2rgnyLJRM?=
 =?us-ascii?Q?SzrEhgIEgClqJfOnw4RWljHwOFMYm/v+vUsBvB48dFdgWyQYMuvKUnNSBuC1?=
 =?us-ascii?Q?Vyu5DZkaOYGdpSMYqt42o78vETSKGepsbAQkWvjLMF39xbfTC7WCPE0oxjKI?=
 =?us-ascii?Q?ppFHJfKxXznqeY+yrCsX8xlp2HIS7+adTo7aErosGnykiu8SJfuPZiMM8WDz?=
 =?us-ascii?Q?kYtAkUU1kwcJrZlmhMcGr/LOe2JMSoicgIEWC9VPICbIGTg/EHFT6QenxGqI?=
 =?us-ascii?Q?BbLN0dTF8jdwpxaZCWFuwx8ypYMfWhHVN0rKNAnI+qq+RxGxBculiXVyfIit?=
 =?us-ascii?Q?bbUDIr4r3DEVrAqg+T9clj8GLidPv7eQ9hMN1NAvYbHIDihBbEXrymKUWbbY?=
 =?us-ascii?Q?DDt+2sBqsNcNxvB9DUDgEDe9AGj0VbyoTqIojKo0JanRoOtTmcM6voqJTb1e?=
 =?us-ascii?Q?P7VEZksysHGgzIPn5HjveglIXVQ3jubEy49+g3QBNNOR+GdiafpKT+rETVzi?=
 =?us-ascii?Q?gmtyUpj0yjkeoky6dfBxCqdQPD//LSjfdrlpQgpdCtIkSVbUFOIIGIeFstLS?=
 =?us-ascii?Q?N4V5vKK1BqIt7vtVxpV5zkODlzuzvHauVReanv35ckx63PTmC1J9xgUXpPNb?=
 =?us-ascii?Q?i6harRhys5Vuo1M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 11:57:32.7261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 018de756-32ce-4e0a-218f-08dd3e009e07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9467

Add JSON output handling for 'ethtool -m' / --module-info, following
the guideline below:

1. Fields with description, will have a separate description field.
2. Fields with units, will have a separate unit field.
3. ASCII fields will be presented as strings.
4. On/Off is rendered as true/false.
5. Yes/no is rendered as true/false.
6. Per-channel fields will be presented as array, when each element
   represents a channel.
7. Fields that hold version, will be split to major and minor sub fields.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 sfpdiag.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/sfpdiag.c b/sfpdiag.c
index bbca91e..4b40bc8 100644
--- a/sfpdiag.c
+++ b/sfpdiag.c
@@ -247,34 +247,50 @@ void sff8472_show_all(const __u8 *id)
 
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
 		rx_power_string = "Receiver signal OMA";
 	else
 		rx_power_string = "Receiver signal average optical power";
 
-	PRINT_xX_PWR(rx_power_string, sd.rx_power[MCURR]);
+	char rx_power_json_str[strlen(rx_power_string)];
+
+	convert_json_field_name(rx_power_string, rx_power_json_str);
+
+	PRINT_xX_PWR_ALL(rx_power_string, rx_power_json_str,
+			 sd.rx_power[MCURR]);
 
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


