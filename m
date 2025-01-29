Return-Path: <netdev+bounces-161505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E06BA21DC0
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB483A7988
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41F812EBE7;
	Wed, 29 Jan 2025 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dKVY0WDn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC91CD2C
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156616; cv=fail; b=ZzXRYahQD8twf1B9M7dq5kdacGx3SzVA5m80CZl2b2XyCosV8X1mwmDXky/wlsQHvZ3kFFptFrGRz93V/5CxlWrbBDQH30fWxf228esQU1JVwuJX5KOEtXV6iuWs0fGGRENzFkR33xAVi+zpQzr/sRRbE5GTy8UVP//ZH/JNRf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156616; c=relaxed/simple;
	bh=PQeL5CiTe+ysDlDXekZ4padlKuwg1i+q78i+3i5WQog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKXez7ft0UuCqSHZx2dcC3rDcdnLLw2llRHoIA/s78GAUE4tXwOozR3QDFjgqYIPDJF1q/DyVCk7R9pXijQR0bAWSY336SrZ7gKpPomL/Xb3facs0mn3X1n9KoFnt+y/d0qpRYmTcWvPSPSeKVbdZfphdCoHqyg5hhURqyU8Af4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dKVY0WDn; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8M+m/nwNvOLr3uyg6aq6lqqsdSPLhkaw8XQ8IK0yvNbgpF83YNX+RO9HAJ54z4wv0X2arebTwXgjCDhZEG5HdI6dlZvewqPwrfdHe2EP8jqIIMiFyaUUro9KYGgL0hm4ESvAFMPn54eG0m7lvPMxnSsWF4W08BiKaCZ9gzNQEs+RS3Mgbm+w09+Qz0nrktkJvVEPdSKv8i0U+gfDoDMJLSw9lBXsm0J4E4O7D4g6ZTE/3zCas4L5QYTkgALCoR/eXNFzZOWV/nxQDMnWfvzoYbkfb6naPRBjaawmiO9JGAoHWPo0iAyDzc3pD71I3sFCpsAHdZo2Wr610RHep4DKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8f2tJ7pa/V1jcxDA9v9BJzSb1MkZGk+9gu+oktY+Uw=;
 b=Ot9x1q3ot8Gl/Fqra8yRd+UKdUxkZJWdgKtwCwHi4ZU60DI4NgbPKS3os5dyzXg4OZ1Ce+kKqs2voUyB56MHcemdHZ/XjBssELJjql/oG1eIEvWRx7PNEQ/kz8wvguQK6XubSp0ExGWw0yUnCI1aa5noPTlVOVNppvGdCd7y//ZvSFaomU5ilNrR5Z7cpnZk0VPqHwF9xozcg83pr+NaCvE6P+69oFoAJHn+kB5ZAO9pjaSEWxYhPE0uI1wSCq7NoBXGXL+QUGSzxHG0mtO+coSBR1dG53B9HHjacChNTZq1Y21TCR52hxO1CcYxZ30R595FMeTV0RCzwpoegZB4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8f2tJ7pa/V1jcxDA9v9BJzSb1MkZGk+9gu+oktY+Uw=;
 b=dKVY0WDnAjYTBh2nKpmxNDB1/4uZF0muSoVHtkDS8zzYD7ZpO/BKX6oQXwKexdp/+/riR18w5aBv3H8rU9A+RGU/j0BscQ3zLwECzTJQAFmzpFPTu6i2gt+1nCvz2PrMYm2LKbyarqGV4KcmI/5JdJMhPHChaqMTIwEM5lXhoIkQFKutwI2VQD6JhsTTbcJMN0+RhrqqUwmlJrrGrQLfeKmZcySID7/ixWOR0qHUDbxDXAuRIe16aJdvyk4n2hEjMD6zNtIs/fgA70ylw7ygkIdMjw4zUUxDBd87+iBpmXl736BgoaXPG0TcqPUJUKNxfYQaxdeTrCvEF7692dtW+Q==
Received: from CH0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:610:e6::9)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 13:16:51 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::7e) by CH0PR03CA0274.outlook.office365.com
 (2603:10b6:610:e6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 13:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 13:16:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 05:16:31 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 29 Jan 2025 05:16:29 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 12/14] sfpdiag: Add JSON output handling to --module-info in SFF8472 modules
Date: Wed, 29 Jan 2025 15:15:45 +0200
Message-ID: <20250129131547.964711-13-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: b13e1356-74de-4da0-cac3-08dd4067314f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mS7MqPeqyerOAH0IdVzN5K3qSdtgMx3TFRt+A+uooN4rF/p88r4o6VMuaCc2?=
 =?us-ascii?Q?itMjRcbXUxVhxDpMsYrhT2gkOKA42nfJnDINp4WYPCOHjQmhYFf7TVEDf77r?=
 =?us-ascii?Q?V9Vmgovp6R4EE6sq+rWPvVicjp8SmSqMm4IvbWCyGBm90uf6CmHgOk0+8+zE?=
 =?us-ascii?Q?gntvsgGM2dc0Nx5LxttLUyGAOVSqa4UQlwjJAD80ngh6y9tF/iO7q7q+lU2U?=
 =?us-ascii?Q?RJPnRjoMY1iSUhCtPiysCP90Wbz7s82Jyge6lFOu4rE8sQ0Z5SIMJtHqNrrh?=
 =?us-ascii?Q?qePZ7f1vVKfzqA7nilLl9ofLmiyGliT9GSODqBqC46eh9IuoPwc+LYAJ7r0P?=
 =?us-ascii?Q?tIPzIOghv7oTqsqj+fjshSuxDPyLWZmBJ67PYD5VnM4r1HvUJ0WFH90fqZ3w?=
 =?us-ascii?Q?Ijmd9hDggAEJUoo4g6CJKa1HaAA7X1pn6g5xhbmb6i7T+xzT2AcHbiDqfD8t?=
 =?us-ascii?Q?WZTEE/k14PR+gbSeG5PuyPuiIijkVWL+oMf7WklA1Vg38chanl3SEuEn/K+S?=
 =?us-ascii?Q?tEnZp53EK+znDkBZig++HyNnDd3g1SPYAF/aiwhAkcJ7xYD7FCijA6IVS0lX?=
 =?us-ascii?Q?Hf1JKm3hhso3Qw6NB2khz0ez1PuHEDRNkHpi3f0SOnNzHL1J0zg6HpfzmCrw?=
 =?us-ascii?Q?UDVMKxZQ6dcXxaAdqqBYT+lCrlsSeXYnd4iYH7s7D2K3DXxFKdXwF9w9zNch?=
 =?us-ascii?Q?7WN+jgRzFAl0GFIqAZP2phGYmVe82LGcCglKmBWiU8UQ6Gj6JlkGyFo2Ut7f?=
 =?us-ascii?Q?7DbBz0kaNGTX+1kCYbsLf8yYWeCINR2Z8c6FV0Y++pSPrs6nf+/Na6BtnrtC?=
 =?us-ascii?Q?1utv835mxYuHOB2OOIsSNGvfa28kAO5aokS28OSoylCOCzKjMxEKwIqlGTEZ?=
 =?us-ascii?Q?W/b/9/G0CYhnjyhmkFmKBDXt31LsmPdAa8zyVfDrT123x1ygQo0d8DTTIcFT?=
 =?us-ascii?Q?NDAi+UHXSwpNUsmkQQJN1REi68rf7TAXLdwz23pudKSLLH6f+7kQ7jGxsJWd?=
 =?us-ascii?Q?DjvmVNax5XQy9ARxJ3c4Lrhf8WGPYbI+9+2oYdJAThNbvGZjw6SyGpJwqSf7?=
 =?us-ascii?Q?EFbqkbvb4Bz7CwR8w4m4rzfjuV7ZUGlsI0qKdN2HKxD+kDwwKCyqa3cXN70e?=
 =?us-ascii?Q?piovwpksjFNqmGeYK+oK4p8i8u0NF4A4inrwJNsS+jbx32GS4q1eex8V2pQc?=
 =?us-ascii?Q?HeOHxhBl3nBzt071REWYvHS15KbSfQjWLgGBsIsY0fZNRWoxSIV9QwC+LTUN?=
 =?us-ascii?Q?wvpc0n/hNeKZR9SepCxK0BObCJOH+7szhVcyVSWUKrl4Ftb2lcibyFeUEP0Q?=
 =?us-ascii?Q?WDA0QCLpJN44pPqzgsmb6+LGLC/R7CigbJCxw3IYwdogRYSKbGNUd4zKlcKN?=
 =?us-ascii?Q?Yyn5/6Al8SmGC3yuwT7mxLmJCvGsYl8CirYkpQe3Ez8nQQNwqjglwiw0Ylnt?=
 =?us-ascii?Q?FV3iYQGLXWDQBhARzCIeH5KuzpQ2YjYSSL+wdf5LWOmUvoK6TC6PAVIwmJEP?=
 =?us-ascii?Q?kBbLaPLLdN9g03s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 13:16:50.8037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b13e1356-74de-4da0-cac3-08dd4067314f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127

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

Notes:
    v2:
    	* In rx_power JSON field, add a type field to let the user know
    	  what type is printed in "value".

 sfpdiag.c | 49 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/sfpdiag.c b/sfpdiag.c
index bbca91e..58023c9 100644
--- a/sfpdiag.c
+++ b/sfpdiag.c
@@ -241,40 +241,57 @@ static void sff8472_parse_eeprom(const __u8 *id, struct sff_diags *sd)
 
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
+	if (is_json_context()) {
+		print_string(PRINT_JSON, "units", "%s", "mW");
+		module_print_any_string("type", rx_power_type_string);
+	}
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


