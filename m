Return-Path: <netdev+bounces-163111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC3BA29574
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06BD167B5E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19B1946B1;
	Wed,  5 Feb 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iLs8zcU7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45614194094
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770949; cv=fail; b=nwH3mbi9SBWOufTk5eeWqKRmUgi9Ep0GNg41FgXRqT4iJzOw/TU799GySRIbL5+tKZXVH7w1kV6KSeBBevxAilOMWUOdu3UGChDoWIYb04UcvGp/g8sTqUPdVvh050hqPgi1Uhx6CTiRS2slPSsriUI1tr4CLOf2xRRIAWAfFiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770949; c=relaxed/simple;
	bh=J4ngBZP4NjASmPOhip7fJesT28XHEPcp7OjwFyiYr/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggcK+9D9LjiL2LI23THPMlVJ2zFagujcmju7RY5xtvVYNbNCz6jePFuj+oWl4PpHe8olwyUNzVRdY8vo9ppkyLlINrBxSZFGHC4iamlJchBlpFhmpdERO+OH+i+ArCzOGgypwmAQ8dT+h+540Ah+grRfZshGDucFCrw6HFAGkDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iLs8zcU7; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dStzH/AS1ymNmyPRE2oJWE3kAUdjBl3UgHWMZ3rB81Wo7ykBure+UC7zkRoVl1/FnvmFfa6chUb+oZeRWI7NOhwJKrmtAOjhROLLy23a2DWxYAYX58CNjqtcQjbiP0QInF9QmP8ZJX3Y80ysgO/5WzE+eeG8PjWxMGK8CqPDAmmr1xgBokDGzb0NDi6gz8dK1eM3tH5ezva/7vBqZPLqks2uusa+LYrpOk78LQjwclDVG5Sb4HMBs+xLIP9E4F6alQkOdS6gcMu0mhcsPlo47q5GnTQWht2fWPXbEfTmVryGIZLyvHSAhICtOSdtK1UK4DKZHQqqTAxMXNzyTSPN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rb4jxUZE6SfJUMs5XvlFi4ynpEse5YcrBc/JmcY2NiU=;
 b=umpq/FaqjoAtQrpuQBUYsUNuj6jIgd1cgdZqhgixBwwEeb1dJIGjsPuf0YJnXjZuhTll8a1TNaRU6PY7/P0hbwFOAl6QGlrPo4/ZxgOmx3f8YOOHSKgJM13wTZyw7Mv5Ec7aBatCriKjeWd7+2QPi3s/MpJjjUjyGfHx5rfiplJ1ykLAFvwY0Uuu+StbgioFpJDWX0MjcSOBu/l5vXHIpkOzdcPW9OMjPuFml1D3pV5FQw2YvjWkz4aAuX1jxKNs4QyrMsh0BV+HaO0i4qKIMzGTxboUmTLQhIR6xiIieKS8++L66CRKBSPqTfaYlhF3mVhxoKRQ8NUjZLziaQolhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb4jxUZE6SfJUMs5XvlFi4ynpEse5YcrBc/JmcY2NiU=;
 b=iLs8zcU7tZq0wPVfeFZeg1kLs4MHOLaVGTke86eTmLmqhQmY7cMTWog0XSg+JM7cy+/5Re+R/md93QRQ464rAfMjloMm2rbnW+WBhJ40jEAiywWjA0DHaT3RyKkY0gLJvv7f3cGUTFgMJVjoaAhoCYBvT4yAAKbgIHOPW/WMJxOCr9BgX5YVcS/LvDE1cAJ6PPvTyDBJEhasz9ktsPft7ttwaFr0ZXLfldH9lf7DgAa6Oi5kdRVCNn37K7BbiUF4rha8chRUHr6vDER7tp9qp5cWrEg/JsCUyi9uDngiRVThj/1s4opvk3ARwvEzL/fZXciSsZpW5CSqUz9plVN+8w==
Received: from MN0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:52c::23)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 15:55:42 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:52c:cafe::b0) by MN0PR05CA0029.outlook.office365.com
 (2603:10b6:208:52c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 15:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.0 via Frontend Transport; Wed, 5 Feb 2025 15:55:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 07:55:22 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Feb 2025 07:55:19 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v4 11/16] qsfp: Enable JSON output support for SFF8636 modules
Date: Wed, 5 Feb 2025 17:54:31 +0200
Message-ID: <20250205155436.1276904-12-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: 90aff584-dc31-45d0-7245-08dd45fd8b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bVhJZu+qzkHzo4uAql9P1m7PYiOHKFohdGv/D28WMqIyzt0psqtfWTz1xU+b?=
 =?us-ascii?Q?3ifnRYEJwTMAhD2Y+S8Y2gG3ecCkH3x1IvfelXZgmA6Mso/Da+BYCIhI6nx0?=
 =?us-ascii?Q?jet88I6XBrBhvy4O2T+rsN4HYuqV1pNGw/Os3mNB1FBVLD3SLvGjsYw8z2C0?=
 =?us-ascii?Q?laqCCX0ORxyeGbfkm2dO9czxgD7i2+knO6ERD3Rf6apCq0kYV430utK+I5GO?=
 =?us-ascii?Q?BMw0+OdDrGHjFPjBDy+VIj/wFM9Btk7w2dYZZmfRwz08wE0Tvodg2q0BJR/Q?=
 =?us-ascii?Q?rmk8RN/NOs9fexbFSFk/6RJsqle4XUVyPwvjdJBQmr85ap5HYYBsMKCqBUxH?=
 =?us-ascii?Q?hDo7Hi4FUdvIQcRLEQ1+xK8zR6Yo573lBwtJYaITN6iCyygozwimO3v5Xcj/?=
 =?us-ascii?Q?Dc1FH50H2tscOTT2PLKwTTdPcASBTIF3bCDJiDikB5ug5Hqz9xrzQHEN5rO7?=
 =?us-ascii?Q?P1Cz0b9+e1YepNVCg6UH6HCptK+3xTCTh1A87l+7f0x059XHvlbDkfIrZPmU?=
 =?us-ascii?Q?5sAXxKR9UZiq97ckvXln9oxHeiAf6qW6uBHKnsIcucA1NdSmRl+ENvS2xQoK?=
 =?us-ascii?Q?ngcjhzAWmjljJyk24OLVPcJaPo2Vo/R/KgIV0ev0s0cmBgNJ5YWsO0Vrc3JK?=
 =?us-ascii?Q?mSAN+S5smqnk/vy1GUaj7UhVST9OulK5ISlbl7ewGtfYuEL6SxaQj1IW8x1L?=
 =?us-ascii?Q?unAPAfdmiqqYTbzS3SHCpAcU33p8zJz95ek+hYGu4X1kd5Ja1E0SKbxDZYEk?=
 =?us-ascii?Q?D8ulm+ZefSaRRl+2NgbuBqe5ctRoOP+SANwur90mNOxZI/YjgbaQiSomprfe?=
 =?us-ascii?Q?BWZTCppK060qD8RTDZtLmPNsq8shFrhSSKYq5t4ah41CXVFATFCOO665pTg+?=
 =?us-ascii?Q?7B/WbPtXyxXxd5ENYnkLSKU3Gt3SFN8oMIBoNcRKr0YLpBW5wBoq3eM6aTi3?=
 =?us-ascii?Q?1lBkt5FLPe8/LgOhNimIJ8SLhkEpYU7lfF9Y0mCO09sq/ip6bpa2gjbvVhyX?=
 =?us-ascii?Q?uBgiZMI9MTfvQjjk3jA2JR4ieVy4wi9zpg+7LQ0iO2+gVDXu6cqaa1GYuGbT?=
 =?us-ascii?Q?sO4HtA9IiuH467YAZlmgXO70zM3VgJlwSXMsNiHEdBE4JOSmBK+oZVAPLzFx?=
 =?us-ascii?Q?FnF7fMD9O16f4Uzte2nu0oqY683LFntqX8P8tWIUtQkNwN4A0DrJJfzWfPox?=
 =?us-ascii?Q?VcyDfVlgegVu1glUWupA8lp88yrnSVNF552FHYn2fTRgAlRFlHuBBhLK+WTc?=
 =?us-ascii?Q?Cqbe7Kyqb5wwYVgYWnNAgsvLiReuCd8GrX0TEKby3ChYi7WranTo4aky8Np6?=
 =?us-ascii?Q?U14+R0Ckskov9/T89zmvGacEtH2u09Y4rPwDIS/0SZmiGU0Gii7yxjVLwQZD?=
 =?us-ascii?Q?3C2Gf/TqKWeItvX/qPoQAn1gF4ThWV0DHSnVArbykZn3dcNc+Ofy6rQf1vRe?=
 =?us-ascii?Q?rBKrETQn14MrcWgJe4W9W1hhMygRPIMZ9cJRPWTdyBHy9Q6rDzyRfH36l+gq?=
 =?us-ascii?Q?Gi1194HqerEL0gI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:55:42.4979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90aff584-dc31-45d0-7245-08dd45fd8b8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147

A sample output:

$ ethtool --json -m swp13
[ {
        "identifier": 17,
        "identifier_description": "QSFP28",
        "extended_identifier": {
            "value": 207,
            "description": "3.5W max. Power consumption",
            "description": "CDR present in TX, CDR present in RX",
            "description": "5.0W max. Power consumption, High Power
Class (> 3.5 W) enabled"
        },
        "power_set": false,
        "power_override": true,
        "connector": 35,
        "connector_description": "No separable connector",
        "transceiver_codes": [ 128,0,0,0,0,0,0,0 ],
        "transceiver_type": "Active Optical Cable with 50GAUI, 100GAUI-2
or 200GAUI-4 C2M. Providing a worst BER of 10-6 or below",
        "encoding": 8,
        "encoding_description": "PAM4",
        "br_nominal": 25500,
        "rate_identifier": 2,
        "length_(smf)": 0,
        "length_(om3)": 0,
        "length_(om2)": 0,
        "length_(om1)": 0,
        "length_(copper_or_active_cable)": 3,
        "transmitter_technology": 0,
        "transmitter_technology_description": "850 nm VCSEL",
        "laser_wavelength": 850,
        "laser_wavelength_tolerance": 150,
        "vendor_name": "Mellanox",
        "vendor_oui": [ 0,2,201 ],
        "vendor_pn": "MFS1S00-V003E",
        "vendor_rev": "A6",
        "vendor_sn": "MT1915FT03913",
        "date_code": "190412",
        "revision_compliance": "Unallocated",
        "rx_loss_of_signal": [ "Yes","Yes","Yes","Yes" ],
        "tx_loss_of_signal": false,
        "rx_loss_of_lock": [ "Yes","Yes","Yes","Yes" ],
        "tx_loss_of_lock": false,
        "tx_adaptive_eq_fault": false,
        "module_temperature": 56.9805,
        "module_voltage": 3.259,
        "alarm/warning_flags_implemented": true,
        "laser_tx_bias_current": [ 0,0,0,0 ],
        "transmit_avg_optical_power": [ 0,0,0,0 ],
        "rx_power": {
            "values": [ 0.0449,0.0475,0.042,0.0394 ],
            "type": "Rcvr signal avg optical power"
        },
        "laser_bias_current_high_alarm": [ false,false,false,false ],
        "laser_bias_current_low_alarm": [ false,false,false,false ],
        "laser_bias_current_high_warning": [ false,false,false,false ],
        "laser_bias_current_low_warning": [ false,false,false,false ],
        "laser_tx_power_high_alarm": [ false,false,false,false ],
        "laser_tx_power_low_alarm": [ false,false,false,false ],
        "laser_tx_power_high_warning": [ false,false,false,false ],
        "laser_tx_power_low_warning": [ false,false,false,false ],
        "laser_rx_power_high_alarm": [ false,false,false,false ],
        "laser_rx_power_low_alarm": [ true,true,true,true ],
        "laser_rx_power_high_warning": [ false,false,false,false ],
        "laser_rx_power_low_warning": [ true,true,true,true ],
        "module_temperature_high_alarm": false,
        "module_temperature_low_alarm": false,
        "module_temperature_high_warning": false,
        "module_temperature_low_warning": false,
        "module_voltage_high_alarm": false,
        "module_voltage_low_alarm": false,
        "module_voltage_high_warning": false,
        "module_voltage_low_warning": false,
        "laser_bias_current": {
            "high_alarm_threshold": 8.5,
            "low_alarm_threshold": 5.492,
            "high_warning_threshold": 8,
            "low_warning_threshold": 6
        },
        "laser_output_power": {
            "high_alarm_threshold": 3.4673,
            "low_alarm_threshold": 0.0724,
            "high_warning_threshold": 1.7378,
            "low_warning_threshold": 0.1445
        },
        "module_temperature": {
            "high_alarm_threshold": 80,
            "low_alarm_threshold": -10,
            "high_warning_threshold": 70,
            "low_warning_threshold": 0
        },
        "module_voltage": {
            "high_alarm_threshold": 3.5,
            "low_alarm_threshold": 3.1,
            "high_warning_threshold": 3.465,
            "low_warning_threshold": 3.135
        },
        "laser_rx_power": {
            "high_alarm_threshold": 3.4673,
            "low_alarm_threshold": 0.0467,
            "high_warning_threshold": 1.7378,
            "low_warning_threshold": 0.0933
        }
    } ]

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v3:
    	* Reword commit message.

 qsfp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qsfp.c b/qsfp.c
index 1076685..09d9ace 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -1083,10 +1083,16 @@ int sff8636_show_all_nl(struct cmd_context *ctx)
 	struct sff8636_memory_map map = {};
 	int ret;
 
+	new_json_obj(ctx->json);
+	open_json_object(NULL);
+
 	ret = sff8636_memory_map_init_pages(ctx, &map);
 	if (ret < 0)
 		return ret;
 	sff8636_show_all_common(&map);
 
+	close_json_object();
+	delete_json_obj();
+
 	return 0;
 }
-- 
2.47.0


