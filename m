Return-Path: <netdev+bounces-163113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D3CA29572
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9971A3A4678
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5C6193086;
	Wed,  5 Feb 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JsR1QhOg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9C01DAC92
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770951; cv=fail; b=EPeK8fBzdY7etKNZJQutaKB+dMgm+C82kAU7xQyQNVkwROml+Bdg/799NWqkH3aggEmE1s6zGPROX9tjb4CLQsGRl+SS4bRrgsb++fEPXTLeghC9lfqDhqj8LmbUz8Pgk3XUpjz9cPCq03nibv2Bv4gKuYKMP30ijNMGZ9qdeY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770951; c=relaxed/simple;
	bh=J5MQS9FG0LyZaiQQ36NZoRRcYPRmeFBovNAZcLMg+rM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6DueADjF5vpxFFiN8l2DrLZsS7D+qm6a1/SpD+oZFYVWuD2FQSIwS18toITTuwE5ha0HbclpCbnJPEiwu7OmrJmB7JybSA13ssIYkkmooNpYnfdt0bveFkahiJXx+bA9fHHUk1gApp63SKlFlnXsQntQXp01sdWX8b5PgjC5q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JsR1QhOg; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBrejGOXC1GZXgT4huqnjVR3f1/QWQpc9iSUzHhmkmyGPwOisM9bYAbglEbu85VTIpxvIaoMenPnjg5YsHqqM637xHbQ2oLu+npIz+kEsHPO5R4n2gA63d5bejTYUg01rqldXo4L4vVf84akrjC2Wn8sGsgfHBetVxGD6aMkJzAdAdr97AXih97yQPRe/2u1nYb8qVD2UUtCFO32Ye1798uGp7SBO5k2Yz7tcke/HRdiIqfYKQCuA+SKCoADt2YEOVaZaBNnqmmXPxXYYny9F979Vk10t+ia8DTP77OF/TVimjPKRF9fM6IaP8ribLVf+gPynaH8oYyG2IVfmobfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMH1Vn5Ltg7fD+iwoDdA7oOIvaoyd+lFrS16Nw1VzCM=;
 b=wf7X0Jzf4xp+nhFyI2Qzy2vF7KVnaLKv8eCu6Tf/f1SJxWCtGWkXVANYiN5IfkJrrAJGw4ZrTu1by5rnQfcj8u9LjcLSnWSKv1eQdcYABUbUsS+rJKI8ncKkkI/svthn/yZWGItsBqrY1OpmnN2vsuH7v2RhmWxAFQm9EW84ZEd0fZvYwBW5WdZJ/80aXC1A9fStaFpAWwKnhzjGuN7vbhNrZhzTlGR+l4hvaWN5vJRHDLVhB9aT9mQpOxczSqOWMeW6cz8Vy/DNtdZWtqrfGKbIz0bP0BlBysjOUtb4lHgP7sJmuOXjyT6TLVDMAq+mTfLLXCib6Y2KS7zSZcQLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMH1Vn5Ltg7fD+iwoDdA7oOIvaoyd+lFrS16Nw1VzCM=;
 b=JsR1QhOgGRHsMafyY4rhgr9B7p7x24pxPWIO05J2vbi81TYfdHq1nX9KQxl3FYDV5CuNh5qT0Ow0F6YfTFMGB7aDJLropxgf6H4j51ZBFGMzZlGTpgovlniFRTNOtoGJPSpWLkdo8nv+iDJWa2VK21Wf3L72qqI1d2sDekRdh+ZbUraVsZihfyyDRD2bH6eGg7kfK3HgozRgfnkTaEyTjcJ0NgRf6L07EE4T5Ziv850W9a+MgxqtXvqVovy6EoYxYxjCNHrBbSzqt7g+ciJhzb4CbL8K9g9+E8RCP9bPR6e4+sNSweqsm/K6B+e7+mwD+It9SKaL4fLqR9oi+YOs0w==
Received: from BL1P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::23)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 15:55:45 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::e7) by BL1P221CA0011.outlook.office365.com
 (2603:10b6:208:2c5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 15:55:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:55:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 07:55:26 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Feb 2025 07:55:24 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v4 13/16] sfpdiag: Add JSON output handling to --module-info in SFF8472 modules
Date: Wed, 5 Feb 2025 17:54:33 +0200
Message-ID: <20250205155436.1276904-14-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: 79327c2c-e54e-4ec9-3dfb-08dd45fd8d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5iNUGjPbeBWKLKuoljB9uW7eMEZlwK5Qw9Je050KdPk3Iylu2+xa4inkK6t5?=
 =?us-ascii?Q?v48Kp8WU3OXhmSAzEGo2nxWIwkjnnCNHM993jt/fl44vzZ+R5uY/t5K1qJrz?=
 =?us-ascii?Q?Q7ZYQcBjWOk8a6wsaMT2YVK+Yy2JGEfnCbNqTW/BdXWpwJnz3ySq+qSawWik?=
 =?us-ascii?Q?o0samBmfMG4n9OuGdJt+o+WAdwK4KI79mtdxeWUUBmHc5MdKD42DkUBszLVB?=
 =?us-ascii?Q?mic6dwKfcQAh1y1PvQMsUNAOIh8OkB/qoviu0oJjXYdyj4FSvsIuWeaoMIzx?=
 =?us-ascii?Q?5bLMXPSJtCt4Xz7sDXbBLpZGngLaA35HRrTc+wmSBAfmkMkaS8q9KlpdJyli?=
 =?us-ascii?Q?4USKV+XNem4lI3p6EENct3kEuX2cA1MfXOymr5q8kPE0vgy1bCHEwOuHY7je?=
 =?us-ascii?Q?YxV2VkobAM1daxb39AMSOxP+YxZXOeJe+Qfolny3UYKiHTNaAYvIcOBHD95r?=
 =?us-ascii?Q?qrdKVjqXU+xikAuvLnJLgqnN9fpTUWn2f/mmHVa8uW7x7ugf/a20LpuAvLXs?=
 =?us-ascii?Q?Wan8bHiHvghwgFfS63t2pFZFDPH01gqtfRjKtwBtQ68IPhzJrXWE98EnFNyV?=
 =?us-ascii?Q?lXuAE3KyWg/mvHWHxFO5yXw5pviMsifqZWtua81HXi2aR9+t5ORS7hL8E2sz?=
 =?us-ascii?Q?S/eAId16oKmahnppo3XAhXbGILLVeMzVPT1e331TTLPqGvHXfeWvxxk9hX0q?=
 =?us-ascii?Q?L+CUkZG8bygjSSC/aWL6mYJwgUE6o1nxCGKPXUnDDg7mtZ/OFsRO4dXNdSzI?=
 =?us-ascii?Q?46W6QeA2nobQR8c2YYAK1yoWPVVbzrUaYeYE9bManNKeuLiur8PLef4op/y6?=
 =?us-ascii?Q?BYVHaza2ZV55WggIXytw440IpuPl8CymMNz80dlwMQxDZJZwOYBPrOaNg0gb?=
 =?us-ascii?Q?FdfGNQxTgi2+P2ZnhXXs2LdcIUJyH5yrRVidX68twafYWC2sbClw0scbBMXQ?=
 =?us-ascii?Q?W03MRg7vjMHmg/4B0KebPcaUP9ZRl13mKGfB19KC7TmjPq3nZoTJPnSBf4ye?=
 =?us-ascii?Q?djbkzjdanQmxdTRoDThh681zocxj+bDOnBBhz/fYSK4xl033wDTBq5HJWDHG?=
 =?us-ascii?Q?7cdf6BxfPxd8ip+9ppBqOlTK+INpULNghoUbqviG8lCUNSiD1svL3xfZig04?=
 =?us-ascii?Q?DHAwYfo0RH0gb6cp7Mh8F0R6kaVW21cd6knZNWD8o/Y8GYBMmU0kKA5SGCN6?=
 =?us-ascii?Q?sfG6yKia389XEE+vuxGS4Kw3G9Ud89wAgnxGEAxKFuEOJs9b+d8mXjHIsbXk?=
 =?us-ascii?Q?sV/iDcRuS7ARNhucCprc47pborIhddUQoNdcwLznPLN8xbdnksYnp8VUCahI?=
 =?us-ascii?Q?3+VYwRGrx6cdWq2Y/ZFUupr3Y/zBaokI6yXUfg6anHqF8m3dWXjGbJMmwPFB?=
 =?us-ascii?Q?b4zyURnJjVo3LKRm8qMBecfkKV+IForpfZ7fdRVpraujiOF0MMGY6QzCuVLX?=
 =?us-ascii?Q?kripXaf6wpbm4pvJs2O6jLqPpkqzB7QQA2p/AFmFOicnQrsRgrQpMF/LlHvD?=
 =?us-ascii?Q?7RNDmgK5f4ajGzs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:55:45.0796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79327c2c-e54e-4ec9-3dfb-08dd45fd8d1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115

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


