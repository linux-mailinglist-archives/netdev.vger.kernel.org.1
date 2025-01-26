Return-Path: <netdev+bounces-160978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35408A1C7A0
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E33E18860EA
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96725188713;
	Sun, 26 Jan 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tje5dAON"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0D86358
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737892660; cv=fail; b=ed6rP75yDF9u5bAzftSI+t5YqHBzj177uJ1Z7msMt0qwo+q3eSOdSRDLnI3X1NzlugVpY4pPrklT6fqOBWoAqOzYqf7bYR+6mLqr3iVwzUbKjYCPATZvxmz8qiTUHUTSwN+7h470sLaKRjxjIMsw4z8wSiI2Jk1YLfdWqs8m+S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737892660; c=relaxed/simple;
	bh=8lBHbJoR8YjaQmqDIZBmLL2tvr0Et/Cl9MMjgM9+LvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIRZJthmWtdNNCLM4Wj7JZ2MDjoYTEEy+zFjv9eGdIwl4Sno+7LQ27UJq4J7cCOZmITOaoLTD+81VMzUX2Mltg38rRxqi4mtQFGp+gP/XzS1qQd/2GLrtEDaohMGJMqq1Em3qfn9B7YRRK1MbUNCbiZxgHMln0vURaA0XjOCLpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tje5dAON; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCGSxQkIdD1qM7NnX16/TWV9p7U+ru1EnfxfsMi4AeR3jUfGwa9ZFQ0930dkJmx0aqgu/m47aW/vx0RjBg1qvcU4H0d1CSv3VcnSaUgqD43SJX0Nn87k10qO/6r2dx2rusyAJ7fy9TNOrKNOX2pkNh6OQ4z89Bm+vErLdPaFNpHrlErE7zC0ygYhxF05XCIorLnrmMevLOD4f8aZfOi7raNF+MYs4bTBHfNjPNVt9hj7LXE+CgudM6b+NnaLudXS+FLNO1er57+rcEMLgY7WISpSNswoK+LfaQGxHJNSnSWoL6lQWR8NkRnXoSv3khGtlncv/cDa3/4WwflF9iEOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aObE+Mhe3cyUDQtIR0MeA5LF/jkMmYK1+zK0ENU5tI=;
 b=TO+S//GKxNyYo9faRivdyOF4dnDnh4tQ26x+AkUxez5EOqEMSX/9LU+dyLejtMBk8m0WErphIaxmOMvPdXwypSRSVomcfVNJjQlHb0taMOkHUMeco58X1P1lebF6fpkLbTId8SbLQv6MPJeoqCnnFqhJBeJA4OqAlLFkMopbVomYJ4EBySZYgXfLFu/MNexYc47qo0+xbVCf8/+5p5LYW0s208UjEHn4U6SdRkM/NxZO1NrCEXKwMkD4kqeiAXvyyHuuKoZEmD40MYJbxi2T0OtiFl0E6Wp+kzL6BtJTiiN7Orzcko7MJu4auNh8xYFbWirz+F1JesVJ0p+oOr077A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aObE+Mhe3cyUDQtIR0MeA5LF/jkMmYK1+zK0ENU5tI=;
 b=Tje5dAONrmYUNbQlZE5vEzVeQh3Hu3DwhyQEVxLeGhBQ+njR25BXzFKYSNxfMvJlkPWXZ/MCRAdXf+s9txHVmCvX9VM9zMF+Fj3uKzPR13SNu3F9e57PrMbykSMaV1zANq6/DJZT/OKM7b4gKR+G3JA09PhFiButEStSakZnOrWN1k2R3yg8JjfVA1z3XumGaNgxcByl+ydwyB+BNB7+QtMtrQNawGcYQiIu14mpCZR5M+7j5eiWPp8+QT25TUUneb8Zv7ZmA5XrjdvA2fDzQIqQTkva7vdYdK07aJapagkLNndjYK/sHT2jx5a0ZdZQsbOBSUZEgeHr8YAGvsgt0g==
Received: from CY5PR15CA0138.namprd15.prod.outlook.com (2603:10b6:930:68::20)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 11:57:35 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::bc) by CY5PR15CA0138.outlook.office365.com
 (2603:10b6:930:68::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Sun,
 26 Jan 2025 11:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 11:57:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 Jan
 2025 03:57:21 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 26 Jan 2025 03:57:19 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 13/14] ethtool: Enable JSON output support for SFF8079 and SFF8472 modules
Date: Sun, 26 Jan 2025 13:56:34 +0200
Message-ID: <20250126115635.801935-14-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2b5503-b54c-4183-0292-08dd3e009f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WP0/Ojtt2anAo35XKbsEp63bdjSBDMAengdb6VARgJGQC88Kap8vTJhg8uB8?=
 =?us-ascii?Q?dFcNZlwj5tbf34oOPuJt0dR7Y3iTXcE160rUe8oz2XQ/hVcGrywcgMRup132?=
 =?us-ascii?Q?dWSrdbgTuTDAdAFPyMO9Uaf4ISQPM59AHYqjoA3y/51CpQDO5qJtnT6A+TAq?=
 =?us-ascii?Q?zVyHZ81jRWLTNnxZUiQmdnyQsjRbsHOEC0BzpTcOLvXprZ0a4j1R5qivdGQl?=
 =?us-ascii?Q?aijBzIiYAh4ueqKXewDZUQvIQHIR0R/AQtcQkPf2TbelUfayknhRO3Xpdst/?=
 =?us-ascii?Q?ObgZt6AgI0vKeeOAUYdhMqCnA5BHrPCQocIvK4SMrfiHJtGfbsXGV1a6DGnc?=
 =?us-ascii?Q?px0okAJKx7t6n83CnLkACpWAIqymuNj9DssSe40Bgk3ZCFOdnyLMn3ToxiSV?=
 =?us-ascii?Q?UgssMUCoePcQTnkc5d+Ea8w4BgnhOjrPvkFAN9CQ/e9jkYPbzVAhK4hnP7c1?=
 =?us-ascii?Q?jeQMEz1CqaugWzpIqPfv9PJ1lOvpgJx4n8FFmfgVAyyOzvwYjrc+ACRHYzTL?=
 =?us-ascii?Q?6B39Uk17DMiexMFs/CI18ep4OiL8Z5Bz/Z5dF7Pq+dxv1j3ydVfdoE/YTef0?=
 =?us-ascii?Q?m8eE2QwSFN8O+WmwYFaTZbHW4g+BxHbID/dd7/4ox/lLFL6O1qlxj5NldGll?=
 =?us-ascii?Q?CAqS7dNYVEJqi+HDFfyEwcXL6hkm4xQeQ0dWhx2KxcIk3RtjifDLt8xuTX2C?=
 =?us-ascii?Q?3GMHblKgCRNEhvI8MrnrSGe+ebHkKTD1I6wM07U64H7ewl0v7soklu8iqdI2?=
 =?us-ascii?Q?LzsonQucgQMCwzuI2g6imtCXVCmCahyu0E/lAtIzWh6yCg1QxcOY5yiT1YBb?=
 =?us-ascii?Q?+AtbUpGXo0rPRJvzzAradFpATS9KJtQuxK5q7oueVIWiNrKZ09HFgVlRdywN?=
 =?us-ascii?Q?VZT95RD1009dw95aRuM2UMiq2Hc9B6Bi7jky8LmGsvkl4yT7Q5QmCjJxXHS2?=
 =?us-ascii?Q?XBeTYfoyoBCvh1h8ZWVw06R8hWo2xl7befIvUNYTGd2P6NrqP36cweaggns/?=
 =?us-ascii?Q?6LYeJRRMXFxNB/RTX0Jg5hYDAHqkNQK3xn2qVdnmpQeEduEp9SKHbk7vmH4y?=
 =?us-ascii?Q?7zbecW2YqDjpuQV4M/rhkir/2237azfRmhgS5QK0kLJ1evYLK1FrIcGgmrnc?=
 =?us-ascii?Q?XovIKXtnz/ONhyBuzIr70O5zLeT7k0wtUYGFXaHKzAjs9wfECFaziCEmYkuZ?=
 =?us-ascii?Q?ziz3VEWy3v1fW14+Odq6cKacmr6nlJ9YsXfGtxnIDcbCpsJftp0ZZKX/7xXJ?=
 =?us-ascii?Q?obG0m8Y1UKfbtRuX0evahAWqZ4NlIA+Apln0xdxGOU0LdySp0/7OpMHlqnqa?=
 =?us-ascii?Q?XgQFlNtg3nNQ5N0KMtcGQ2I1dUdkCcABgDKgAu3Wd0KxVdjmeaRGtqmWFCrB?=
 =?us-ascii?Q?pU1+rA17xp+SWnWc/IHKD6ZXi5yoYudYuuByye66d1wLawCY2vf9K1NYYC39?=
 =?us-ascii?Q?qF5jTAFsUAqHtkPckoXPWB/QmyYliKsIT7e3iISUYpom1eOSqq6XfFANrZLM?=
 =?us-ascii?Q?9kmac6aG8XQktD4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 11:57:34.5734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2b5503-b54c-4183-0292-08dd3e009f21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

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
index 2818206..51c9a46 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5002,6 +5002,8 @@ static int do_getmodule(struct cmd_context *ctx)
 		    (eeprom->len != modinfo.eeprom_len)) {
 			geeprom_dump_hex = 1;
 		} else if (!geeprom_dump_hex) {
+			new_json_obj(ctx->json);
+			open_json_object(NULL);
 			switch (modinfo.type) {
 #ifdef ETHTOOL_ENABLE_PRETTY_DUMP
 			case ETH_MODULE_SFF_8079:
@@ -5021,6 +5023,8 @@ static int do_getmodule(struct cmd_context *ctx)
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


