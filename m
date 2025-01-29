Return-Path: <netdev+bounces-161506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E82FA21DC2
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF023A8391
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C62195980;
	Wed, 29 Jan 2025 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sn3P/zP3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB41F1420A8
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156618; cv=fail; b=QFE3lthBvSG8jRL2GQC4J5xZe2y5Y9F0flezB8K9ZFxqgXUJO39Ujm4rqI6BFdIwIYVCNaSg2Fv7xS6xDs2OZ6/uBy3p+MIqDUysgoCkMNm7x88N8ZsqL36koH2gRZbNuaWdVTu6pK33lk5NmiTHkeaKsjmvJ4GXns0qfvSPpu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156618; c=relaxed/simple;
	bh=q11DMrSGd/hJJaTTeF/w/W9Ty5YydG4uaO0HPqqOzE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwsvJb4/gr01pKE/EEADd6Oc+4H9cPyeoCrnQ0tTm3ij5tzNDg+G/1H87Uo/79FV/wJwE1PfYg9T4UGSyDM6EfwM2yd881cp+YmOHimCTOaEIygzrTxf8h23g7xHYhCZHxTjOTntZLMsvLVNRQ0Uy8HuVLDOCRKVND9XxGahx5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sn3P/zP3; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nP9uspX/RU2ZlrGf2e/J8u91NIt81F5lZcYXMK4RRExwpLU+weYnu1hXUfHc9pCkHOKZkuZNUJ8cEi4BS8yHcehtE+puU7/1Wda1Ofp5lD6lG1Mv5QEi6p1jncFgdDwJpu22xWO94UY+hWstmsz2OyLcCFJJRqCI8+7mC6F7MblvMr4dY3VwaW3o+XZ1Noigvvosp+zAQJbcUfIp+0KVhZzyHhDmaRjF7eOATQes6Sp5VoyThQ+xSJKuq6Fmvji5jio0xdOu4Xvo9S7BsEeC2VFvHvXCZWDWIvCNdVRJxkvQGENRp5MZ4vXhHxvxdwsxsUtRGu09dnExsLio5O3pXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6EmrP/pDRf4O3tp9g5In/xCwSa2WMMUIH7uiW04ius=;
 b=RaLO5+a3Sl4RXlUI5CfpI6mrIMFbn9O5GWQZWqpwR08Feg3zCwgfOQtoPELAq5csjcukYukr47xx1zYhSB5jTuAgdul5lJSBbE7XwtxO//lCA5HV/ZjeVxpqiePOZgaZu4dhGGElDxDT/Mq5EkTgXlnpeaxOrEIdOXqdO849z+tdIrxU7ACJMi6moS5Zk0lge/dlRgkQ/XeazoZQ1SWWB4aHakFMT2nqifm6JxmoXQsk7DtA39gGcF1mQllaqFwNZBgBnsdho/bCQwOObW0HDLGHXun0IQpPm4j7k5dXBDR9jmuiLHVQMZIdRKrOdY5z2zgO7Kub/EvnmmOMhGS6zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6EmrP/pDRf4O3tp9g5In/xCwSa2WMMUIH7uiW04ius=;
 b=sn3P/zP357w9k/3FScbpJMMT6uikqgD82Cg3JOYDxq4p/kfojqR9UC5XtFCE7q77WYs8ZlhMyZ5rICPc2JMfJArabbYmLtRBi7ZntjRLqAxtv6MdHhMTHrK7GVzYGvaNp8YRZ7OQkLMY1Qoyg5lFtZWkelNQDVdk3Z+NcyA0mADnpJ4M9/cfUMG9cNtsP5mdJ9RL5CM2e64JATo6p1yAPZIMHsH9bfIht9LUugsmXGCQiqxLHp+3TKOPw5oaSYP3UaB9Tb+ygSdWhwZaTnjEwQI6LwEBFqaw0ziQ0SoClTm3T62PlcOfIG0Rc+FQXMABqg7cA7u2wmGLUjmgdIivxQ==
Received: from CH0PR03CA0099.namprd03.prod.outlook.com (2603:10b6:610:cd::14)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 13:16:53 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::5b) by CH0PR03CA0099.outlook.office365.com
 (2603:10b6:610:cd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Wed,
 29 Jan 2025 13:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 13:16:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 05:16:34 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 29 Jan 2025 05:16:31 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 13/14] ethtool: Enable JSON output support for SFF8079 and SFF8472 modules
Date: Wed, 29 Jan 2025 15:15:46 +0200
Message-ID: <20250129131547.964711-14-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e7d3ca-3726-461b-e767-08dd406732a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hnSiTopwiGsC7KT3KZXuKOoAKI5v8TriUJtHjGWCwxebjuJy1qxCRah3UcW7?=
 =?us-ascii?Q?oOK+WslCI01KcvXVKpCvfLfLhezT2JbpWdemLw5r/7b3lpucUgcSn1n0aUt1?=
 =?us-ascii?Q?UNiHHrwRkWEHsEOpT6zK0a63ZZ2HzLmJO8AOAAlylwfV60B5yEC5f+9rh6Xn?=
 =?us-ascii?Q?k+JrSYh7//nf2vnzcv+ofNRV17Qu+2MSYquX+WHbLK0djqPxG+OVDq58elyh?=
 =?us-ascii?Q?qYrQ8t/d56VHKQ7AJyUDkFxwU6fCQM+9mdqE/HzARWaF02o0ea0pj3Vb5Xir?=
 =?us-ascii?Q?En2exr7L0W0FX6GZrLEPKjnOpmLOtdVQVku28xn1v5YZD8dF0rU8j7YT+i9E?=
 =?us-ascii?Q?FkpVvExH8SPmbNAVXQr0S8AX3+JsN36lIiaNRx0w+nmp7kd/NZxSFXUpdAne?=
 =?us-ascii?Q?NpZ/6/iPL6K0M3PqUCtCYUOhRf8rPNUET+a2dv50TeqO91RVwOAvh3IsKOck?=
 =?us-ascii?Q?GAOem3ZSVIPM3T4TxMnFM9HClXPINmpovDY02iSQXKyZc9+DvJ+wcdvp9zX/?=
 =?us-ascii?Q?TikglLrEAmK+B8ce5mX0r90x+9aOS8rx/+bmTYh6f/bjhdZ8dXyz1KHtwQdI?=
 =?us-ascii?Q?WyjjRz+DPy3OD+GreCo5B2mQU0QzhKwEj4RCNxMQ8vx5K4pWF89yGUuH+Ul1?=
 =?us-ascii?Q?yo2pZwOEc8RboWBzRryoN9eNBvGR2FJsdtTvBpqPMhdy1Hv+K2B/F3vT72f0?=
 =?us-ascii?Q?F2YV6txPQtq6G7lkXsYUpKT/lBng+KJPBa3tQxLywQcG/vQaV7qcEXpk/wHr?=
 =?us-ascii?Q?t8IbmtZNl4NbrU6mK2OGdF+gbN/ExybzhPMXXL5kVzpUUKwAPkW5OyoLvrea?=
 =?us-ascii?Q?NpkZxEqboA9cVnUy8dEQ7w42726js7AspgoxyttyZ81D5ur9DDdPm2MJWBZ2?=
 =?us-ascii?Q?afcgIn//mJ4L9Vh+0OSHtxotuvkFbxKRnAUcY3+IG/yXfO7IYVokIvUbLhtg?=
 =?us-ascii?Q?hywQGLrcSCa2ItzIiLEaMs8KIdH+q8KSHbZXo/7I0dl4yKEFYgZCmdVYrKPH?=
 =?us-ascii?Q?5yTIijpxepchQ2DA5NqfcIy7BBHFP2vTYA1/4U4trsvo/WashxI/8EEJDrJw?=
 =?us-ascii?Q?GjCMsq6uW/R0/rl/D/hplKwZpiNRxlrUK5WNPKLMClC9gYsLGtFdNZMSDTO+?=
 =?us-ascii?Q?CaZ6UW95cPtHc9ncZlOjVEvbec+dLzr+JvAp7XDvT1eg4I95raARxlw9WbvL?=
 =?us-ascii?Q?hf5Y3Ueuw/5vuMNbIADMKnCmKKl66wTKAGNQL6kux9yR/LDgnLfbezfJR3Qq?=
 =?us-ascii?Q?q9lpseGKI0kucvwOpdz8iMNR3qY9MPbtEzrhA/7r0qHY9ewioWaX7qwze6m2?=
 =?us-ascii?Q?BZFeHaK5PbH17Lr61/2U1Vg54YbMxB2PJMRl2OggMhQswEeZ9/BTPhLx5wpj?=
 =?us-ascii?Q?CUrdcPRK2SjzMHW9pn7boOeMefZdwDLqoTOOO3fKkPR8oAUxAPlZyICbAKLF?=
 =?us-ascii?Q?fwlX0feCnX5/WcQqKLWmpe7yCrJPpilo9HAsHKFezJJoYYgORfcZFr6xssfI?=
 =?us-ascii?Q?7U3/6yr0uRqtF/s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 13:16:52.9818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e7d3ca-3726-461b-e767-08dd406732a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529

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
 ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ethtool.c b/ethtool.c
index 0b876e8..8a81001 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5007,6 +5007,8 @@ static int do_getmodule(struct cmd_context *ctx)
 		    (eeprom->len != modinfo.eeprom_len)) {
 			geeprom_dump_hex = 1;
 		} else if (!geeprom_dump_hex) {
+			new_json_obj(ctx->json);
+			open_json_object(NULL);
 			switch (modinfo.type) {
 #ifdef ETHTOOL_ENABLE_PRETTY_DUMP
 			case ETH_MODULE_SFF_8079:
@@ -5026,6 +5028,8 @@ static int do_getmodule(struct cmd_context *ctx)
 				geeprom_dump_hex = 1;
 				break;
 			}
+			close_json_object();
+			delete_json_obj();
 		}
 		if (geeprom_dump_hex)
 			dump_hex(stdout, eeprom->data,
-- 
2.47.0


