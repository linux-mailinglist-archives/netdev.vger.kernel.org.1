Return-Path: <netdev+bounces-161503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A64A21DBD
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0651686AE
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA4833981;
	Wed, 29 Jan 2025 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jXkBj8yg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997CB661
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156609; cv=fail; b=ZWo70vngyyyohbIHhrsiStsKhVsbAJRuSSy1BHu1RampNpausjAVKqMJq9L/KdMiffFqfZHHzylaVbhPmj7fDQDoADTD5k/Z+VVQRIU8CfL0fVFkz93XALAR9EeD6fUcc1GLcwhHdwgkZT1y+NAnoDRheWdVfVAKntoX1iqTD7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156609; c=relaxed/simple;
	bh=dQysKmMbbf8BO8KsbQd5AZ8gQbXjNw5otHg7ETDIOoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbFdkZYvvyrPwvZ//tR/Hqzo6oix7qfRIYnut/KCzpTX4+rPIRPS/CSKhn5GpsgtKsII92tlqIIesA3ZS1ndea/QFF89qMbQ9Jk/U3JZRLodjn8otSmi4xErgvEsPoYjr5UXsK1LXEzL/14d1FuzkCcjMFfquu5UR+uuJdTiiqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jXkBj8yg; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQxDBIdAHzFJAe8I0DfeIjenUX6T2BPkzFFWrUrRCVUb9H4NpY8wiGp/GR+nWeKn1nEXk98D0VoKfgaxAFQ0ht0pvdFqo6i3OLcRmnpqmK2qjQ26LxGH+bDSPp7wg2dJnUY4qjEZx4Z7F+9JqvuvpjH6X/1PlbE8SI8lvzCYH0WhQg0Iuvvq8L5Sx1A+linhOez3GaMHvp9BZZN7CLG8oZCe6yK9+vngfWaRtXY2lOc5728r4hCH1G1H0gm4uRiboSGUgDbo6jBz/Dl0cpX05Sj1MIuS5MiQ3ZAgRViKnMFUjTi+v8CVFUhUHjNqwRbeUaGvrA5K6yyTlmppi4tbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5+gDgAlF6kPq23BxSztpx9y2mxU6w1//ip2DUm8kqc=;
 b=xWLG7FExj5Bmo+vnhfcy//hIANdgXpz3n3LfJmNgZCXEnt9meULt13LVME27HJCbYzIBCo0uep7+0I3w+ZlJl+AqHnsKI2HvvyVQyYf3FHzR0wSMWdIN3faVVKMyQNkbrakrlSa9gw3G07uGfaCEdcAa7YdbT9gAPYV0CbFjEAaAt+Lp97dZnCwIwOpFaxUZ+m+kPfpWalIM5iCBS4eUaYmk6Ke5yfOArjaK3HfSL7dSLTmd9nWVKXnUDoLMvCRgnfVxc8BjZaDS/uWYwpHcYWyUvAn9FAB+W72MoSQx+fzpIWk1nkmMGnsC7sSSPz2wb0PAoqx+HEDeO0I2kKCGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5+gDgAlF6kPq23BxSztpx9y2mxU6w1//ip2DUm8kqc=;
 b=jXkBj8yg8TAyV7vXS7xtoX7v+eJi/xjodzGyxiOj4G433wcvPjOMW8AHnIk2D5Dm3EoQ4QsZ6ZAq9t8cXVu+BqQ3i4eW6Vu8JZHMu+rc+fkz6DDy8dQpdLXvZoZKJ0E8ivQtSPRffKzet7sS3Qc914qTRhkpsxZ33pHMmY6lnlvlnS38CbqpyBg3HzYm6ouiHwMIf1gu9vR/S/iKuEtJB3FlDKpI+wNvXg9bBK238FoxHPcet7j3XQckdf5x4HI68lP4U4DFxPGgrn0lUVvtrcOhijRfN2T5yf5pcyPZXJz4freQb+0Zs0BBGJINvk7YrGtXipfOUbqClz2KtIz3Bg==
Received: from CH0PR03CA0280.namprd03.prod.outlook.com (2603:10b6:610:e6::15)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Wed, 29 Jan 2025 13:16:43 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::d7) by CH0PR03CA0280.outlook.office365.com
 (2603:10b6:610:e6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 13:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 13:16:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 05:16:27 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 29 Jan 2025 05:16:24 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 10/14] qsfp: Enable JSON output support for SFF8636 modules
Date: Wed, 29 Jan 2025 15:15:43 +0200
Message-ID: <20250129131547.964711-11-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: f4daa17b-8ce0-43fa-b1a9-08dd40672c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+wbKoPlubBgsDM2rHb/2EfHq0lqx5CF+va0E6rfYKoXhENVKhjShLnvhigtz?=
 =?us-ascii?Q?UP8uBKIoghIaVWxvt7CCq368F76cetI9riuF3E3VKE9zFge0Uwm2QO++5Eh/?=
 =?us-ascii?Q?4+SMlmjtHtW+LjXxykURgA4ezHcF/OScwDF3uDWdDrDJHOG+6/H2VE4ogBZj?=
 =?us-ascii?Q?X7/koacn8hXNA5syPPgC19cXdIS/RlWlKl/U7t/j9xZMucJgSCVwAY7W67BA?=
 =?us-ascii?Q?zvVl5pKSvNxiEN5WkLchVxhA+VtaUwbCc7du1HozHdg/0BsijqLtmPhljtFX?=
 =?us-ascii?Q?whyecWSzQVkdFEcOHToVjjxw0CiQakOjDVSEQTFvlSSvSqlCo/dUvZUIN8QX?=
 =?us-ascii?Q?R27RiZP32eXAQvm3BL6n6xQuuv9s4ByAGWGxy38nilG3TkecJ5/kNfknp88X?=
 =?us-ascii?Q?vf7I/8/cHTwexNyztiT06Hzvm4h7BxMvQbriJVrsbJi9MfmwlafC4gQA1T6g?=
 =?us-ascii?Q?tc/K44W8yh4qQO+R8E3WQABwPiZya+RHR5mAplSHIob8Ef3iBVpL80yoF7B3?=
 =?us-ascii?Q?Qf3S3RKmZm8btPlocIC1OfF9yT/2HprLpbhZUYj5Bvb45ipBEHj2jWaafb0v?=
 =?us-ascii?Q?Dkt6eZ2DOo1tyOLh34omwtpL7qxmeK044sTajRTsmwcNjT5U6IyeII4JcMsf?=
 =?us-ascii?Q?NhdIjyRrWDael3BcKGGFVA+fdGR7hRnc2sbWKk21i9/GQRMIgweppqLo0Jr9?=
 =?us-ascii?Q?4LkgTb0Pnf7n10n2wj56yaUC2NM8AbIcNwWpdpE1tB6sVzjPobQO9zDPDbPN?=
 =?us-ascii?Q?XI2o61w7ZlcQEqTOubVIs8e0WoQEAboh93/tuHAizP40Qwk8O8gmupewACO0?=
 =?us-ascii?Q?OqCN9uK3tqXgeatNHqtX1wM9+T7c7onSTMbwfWIjgLGSwCKlMIfkfeB5nViO?=
 =?us-ascii?Q?o/S8qFF4WPtVOdXfbMy5Fh4v0AVnwfZnzBjpt+57vW48I0slAAzaI5PgSx3J?=
 =?us-ascii?Q?LkGhr9UV23Ziui2/ArbG/C8oLx8F4wUnwPIo0Ou2JiBjpjgLXRFSzNAB0t8E?=
 =?us-ascii?Q?zWeerv208HCUayDhK/JoKR7jy56Oxdep+jW4wXCqT3MxBUAXBepfQzky/Wbg?=
 =?us-ascii?Q?2O5egTj+PSrbC0P46xhqjU7hRkS5xjo/P67hcRrD4GR/vmfkLavN9kTfs753?=
 =?us-ascii?Q?6qg3fakKFPnsNvqhy3h9WeVrA0ydP2rFlDH/hW1FabYgg+lWrd1mTnZaqhVR?=
 =?us-ascii?Q?MYl2H8QngAfmoN2ab5epI69J7Z44ZMsITjSFU99P8pyX07gru5aHe3sPVqoY?=
 =?us-ascii?Q?UsWP666coaTgJgEjBu2tZRB/9pl5APMciKI8x/1ypMVTFDabufVp1GAEBOoi?=
 =?us-ascii?Q?9tHJ2UISngunqQNFcy9Cs1les+e69Ie9lbi5/NKFVwToiQYnZ0Gf01vWYj8k?=
 =?us-ascii?Q?KJT2P0bedr/RPiwIjAY+JnKImt7VSmRjVeK0K2jSddEGhMPk1ebiaaXrPVC5?=
 =?us-ascii?Q?NwKLSqeN+zYGaBGnV8sAqOyydWAQ7j1J0SAmHyG55WYIrAdkBtg4HQu3V9im?=
 =?us-ascii?Q?yDKKAbsj6kPt6dE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 13:16:42.7724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4daa17b-8ce0-43fa-b1a9-08dd40672c88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296

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
        "br_nominal_units": "Mbps",
        "rate_identifier": 2,
        "length_(smf,km)": 0,
        "length_(smf,km)_units": "km",
        "length_(om3_50um)": 0,
        "length_(om3_50um)_units": "m",
        "length_(om2_50um)": 0,
        "length_(om2_50um)_units": "m",
        "length_(om1_62.5um)": 0,
        "length_(om1_62.5um)_units": "m",
        "length_(copper_or_active_cable)": 3,
        "length_(copper_or_active_cable)_units": "m",
        "transmitter_technology": 0,
        "transmitter_technology_description": "850 nm VCSEL",
        "laser_wavelength": 850,
        "laser_wavelength_units": "nm",
        "laser_wavelength_tolerance": 150,
        "laser_wavelength_tolerance_units": "nm",
        "vendor_name": "Mellanox",
        "vendor_oui": [ 0,2,201 ],
        "vendor_pn": "MFS1S00-V003E",
        "vendor_rev": "A6",
        "vendor_sn": "MT1915FT03913",
        "date_code": "190412",
        "revision_compliance": "Unallocated",
        "rx_loss_of_signal": [ "Yes","Yes","Yes","Yes" ],
        "tx_loss_of_signal": "None",
        "rx_loss_of_lock": [ "Yes","Yes","Yes","Yes" ],
        "tx_loss_of_lock": "None",
        "tx_adaptive_eq_fault": "None",
        "module_temperature": 56.75,
        "module_temperature_units": "degrees C",
        "module_voltage": 3.261,
        "module_voltage_units": "V",
        "alarm/warning_flags_implemented": true,
        "laser_tx_bias_current": [ 0,0,0,0 ],
        "laser_tx_bias_current_units": "mA",
        "transmit_avg_optical_power": [ 0,0,0,0 ],
        "transmit_avg_optical_power_units": "mW",
        "rcvr_signal_avg_optical_power": [ 0.0388,0.041,0.0417,0.0392 ],
        "rcvr_signal_avg_optical_power_units": "mW",
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
        "Module temperature high alarm": false,
        "Module temperature low alarm": false,
        "Module temperature high warning": false,
        "Module temperature low warning": false,
        "Module voltage high alarm": false,
        "Module voltage low alarm": false,
        "Module voltage high warning": false,
        "Module voltage low warning": false,
        "laser_bias_current": {
            "high_alarm_threshold": 8.5,
            "low_alarm_threshold": 5.492,
            "high_warning_threshold": 8,
            "low_warning_threshold": 6,
            "units": "mA"
        },
        "laser_output_power": {
            "high_alarm_threshold": 3.4673,
            "low_alarm_threshold": 0.0724,
            "high_warning_threshold": 1.7378,
            "low_warning_threshold": 0.1445,
            "units": "mW"
        },
        "module_temperature": {
            "high_alarm_threshold": 80,
            "low_alarm_threshold": -10,
            "high_warning_threshold": 70,
            "low_warning_threshold": 0,
            "units": "degrees C"
        },
        "module_voltage": {
            "high_alarm_threshold": 3.5,
            "low_alarm_threshold": 3.1,
            "high_warning_threshold": 3.465,
            "low_warning_threshold": 3.135,
            "units": "V"
        },
        "laser_rx_power": {
            "high_alarm_threshold": 3.4673,
            "low_alarm_threshold": 0.0467,
            "high_warning_threshold": 1.7378,
            "low_warning_threshold": 0.0933,
            "units": "mW"
        }
    } ]

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 qsfp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qsfp.c b/qsfp.c
index bee4f5b..8e3c318 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -1098,10 +1098,16 @@ int sff8636_show_all_nl(struct cmd_context *ctx)
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


