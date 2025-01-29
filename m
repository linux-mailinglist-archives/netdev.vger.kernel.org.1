Return-Path: <netdev+bounces-161501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA47A21DBC
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A453A1681DB
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA4E14A635;
	Wed, 29 Jan 2025 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YfWP4oTh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78942049
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156602; cv=fail; b=Vb7Ry2tlmYAfjBPH9NqMRJ0Sdwx5jzfpbG9Ic1tejYhNeiib8ndzH/WlXnN+0hIZ2BxJwQW8jw7COX7ppFCL/iHHMfmS5ozCqsval2YBesApQV79e0ZT/Ei42QMaYBXYTmacLFjGwxUYyZIHCLYQ+3QzlEHhPiMDg8D4bQwJmFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156602; c=relaxed/simple;
	bh=r8d396M0Er97tg3FcsFAHW3bgMzQ/Il6j4dWMHsFH/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WANQS71tVOrrGWE+9UWWajTU5I5Xr4XEdJv2FTzVq0xb6LykER3NXIwoQxBm4hRfdgzDI3P7fzZgMyNpFk4eV0Z/F/zYav7v6aNmOIV9AS4X8xNdXG99HzrvLR6Tn2k7ntluz8BOi/tPE4kWwwSbBt3xICv4qt6xBgjFMKLJcEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YfWP4oTh; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/6g0q8HIdUYgkycD7vXNsLASlGJghdOvrWsmZmniFd948iERKijo87/+MRm5eKbiWMvyL8UU60q5BV26xcbI+Z9TmTYgS3XJ6SNDkzqiNk4lRr7wzwd/H7d3ZJBz+kcmthXUVWKNvDrBidFEf7NMguRnsnbIXjgrhyDXMgL3RrDZ4Rou8WRMfZNc0gWHJrlXIX4c8vY9AtnmYm6RHQ46QMh4FV4sdB38iL8tpaR6/Yk6sFLl8RuqUkLuFnVKxDl/FDYi/jloWhgYUhUCyF7hEgI6xbvZdUQaX5/nxZTZ81tgGWnDlQylLBGYXxsZMSR3mlBFB9njpvPbXluhhFnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJsxR13joScnVsikdInW4EPx6RZoWKq0Jl+3mHC5nXw=;
 b=LrNrDcVxJsd5toIexb8x51LCIyjkL+3Ee2wB7SQt3KECefpr/NPXXAVLeOyb1gfwx91TD5q3BsHuiC8Z3SloPWl1d6Zz1qcKLdIoTiMJrJw/wpdzGWeBeudNN2JChsVZ+nSDLTWt3iKX7Qy9fkzCOi5FWQm+XHcXe5NFTMwEsLQhAYRaj5O60nm/gkSPBpnRqH4tN+Fucs3SGS2N5T9Qq75OExoBe710YWqUVD4Y3BrBn/VBYmZX/NNp1l953xmLqjBQrwClqzjaqYNqY7Owx3DNvv/3ImQlUPB6ospkulgR0a+KjuiZRO56uMG7JfU8Rg4AGUUSlf7s5e5sQycIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJsxR13joScnVsikdInW4EPx6RZoWKq0Jl+3mHC5nXw=;
 b=YfWP4oTh6VVFbxVTgqtOtBrtSrP7sLNfOfzA/T4591Rk9IqPNpWy7iAjQ6/xFcqvbDeDNDeEt5nHh8UMKeSl/e9/S1qW7q0iXMqTQqfw8RlXdnlme5SDAFTnzRf00xjUO51p4vTVgrJAQOG3CkfY6qrYJs68dHp3yelw6jL1ljc5fusIQdWCLe7h6yWOEnaGJjSrPUYBwrNO1g/+iHIfO0lzZ1j9ap6HvZKqEaPBfoBpFszMD/qNORgmNsgLA4jJZ53W3pJfH9unT4zazwrAJH2wjXNjfF4d1FBiV/AqAL3kvg6YrD9KhAuZjkbfdoVRkNGfcq8lmVVFbnaeWFP3/g==
Received: from SA0PR11CA0134.namprd11.prod.outlook.com (2603:10b6:806:131::19)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 13:16:35 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::34) by SA0PR11CA0134.outlook.office365.com
 (2603:10b6:806:131::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 13:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 13:16:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 05:16:22 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 29 Jan 2025 05:16:19 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 08/14] cmis: Enable JSON output support in CMIS modules
Date: Wed, 29 Jan 2025 15:15:41 +0200
Message-ID: <20250129131547.964711-9-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 90eff568-bf94-4b50-17ea-08dd406727fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w7RmKaq7EJckvqKkFx3eqX4XPndSG8nmjuvA3vaBRMcyTi0kAwqTl94BMg8N?=
 =?us-ascii?Q?xQ2ea85DXKyXL5Gps0YLSywJJiEIcRswj3JOEXpaclwaRqG4ofH3Dhnp1VbR?=
 =?us-ascii?Q?t4ht915gqURbXN4B47hELplXNsVfP9yKVg7iQt45YF+Ws6YhiNSdMqQqqHnv?=
 =?us-ascii?Q?9qMfmBeFncZ7Qjvifu5GMC+pprirG/BC8JSrX6aEG/4d3+i7IHYJBUAsq2BT?=
 =?us-ascii?Q?c+miWCRbTRJRdeeFyCOwr9Zm1lxmHOw1cnmoe0NRQXa0jO4cibfPrSYBFXSs?=
 =?us-ascii?Q?ih02ExuePFmFMyzigy5ZRTtQlpHEQdRmerit+SV6MeFDYryCsxAwmkudtTOK?=
 =?us-ascii?Q?Qcr320qm8FVGfirwBRZ8dtNXemfN2N/lrYAnrLZXTBuME/oyBbl+ugZ6EW7R?=
 =?us-ascii?Q?KqhJQoeMMlHtyngiyfUk80PkLN+K+ofKQ/s345LmXssIqgDMY84wwYoIc09s?=
 =?us-ascii?Q?N9iwbPBBdiFW4UGesBZHmj1SCpG5HIJiQE3l7Zd/O7js0xjCae9MqwxugZse?=
 =?us-ascii?Q?0CvHyw6ynuXK39YUfc12dIpxJdjQYY89Aw7arrfyxykUHyLqz2i6zQcET5bE?=
 =?us-ascii?Q?5ajPKOK/xUVtCko/suRpAhzqHaqwXOeDCMIqUCas6WSgGMwoeAOTYhKiLygv?=
 =?us-ascii?Q?L5B+eu78U9fvuQDK4h12xCyYHoE2K0QNODtIU+7YdIuZ6uOxb8RS/qK7bboN?=
 =?us-ascii?Q?pB1hxy21bgOXSV9EO7LXS//vatYxlhS6ZAWAuWIf3yozLruPCbe+Sfri4SIW?=
 =?us-ascii?Q?F5aVFKzGWFQYchjU4Ko8Awao9l/LwAwdDKCk0rG1mVTqfecwMQrpO9c0HKHQ?=
 =?us-ascii?Q?vZoxng+Zfhp7HATr4ZZz3xnoL4VTvcfi6Fa86Rj+921y17T2HMyRr+WGV+xk?=
 =?us-ascii?Q?bLg8125p31UwItFdE3QnXWPJ++HKjHcAVzvWv8L90C8MVnuGVQZF7GzB9893?=
 =?us-ascii?Q?q4FhqcDiR/9MZmvtC0elI7yr8GmTBM6tBkyvlteKQi9Y/Kci1rzEJIjooBcG?=
 =?us-ascii?Q?f2wmpRuZ8UcqPXxTazwmV9Wn6Gg4h959Hn2mjh4G7cE/kBK5Hk5hIFbwN9Yc?=
 =?us-ascii?Q?qqFCSBr2PzxTCtoKpYNGulJnjNxc8Qk+AQt+Vz7rlR9BpDvXxacx4scDrZJ4?=
 =?us-ascii?Q?+poUsaoegPYJxxN866j+/J0sUmAKO5gLExf3S3JVeqheNGXcCJvPCCGEQbUv?=
 =?us-ascii?Q?hDTfHc/L7u/2tafILDsZY4NjvE86o4/ozdaM9wusY0cnuIhu4MekFVJ3LYXl?=
 =?us-ascii?Q?9eqHYKxltnAqyDtnIvusVhRA6yKEFeSh3RMqAn9eGjYCqFVb1b5ErpjUrmwj?=
 =?us-ascii?Q?mliayfTwQhTo/oVFlwXtaIz6Gs8lfT6WMQDDIinSAqQeZnTFGQbwFXDE2QHK?=
 =?us-ascii?Q?pP7pIYYl2Vso++Y9oQnv1UHJo054fyiMmcnnifQ0+Y6YD/CazsXm69RE8PNK?=
 =?us-ascii?Q?x6gWcckg1cVoSf2XWwdilcw4JIDdeqWbb1yFNhLaKV3XcBhjjTIuadqcE74Y?=
 =?us-ascii?Q?4sl98sKLPAtwR4U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 13:16:35.1960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90eff568-bf94-4b50-17ea-08dd406727fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

A sample output:

$ ethtool --json -m swp23
[ {
        "identifier": 24,
        "identifier_description": "QSFP-DD Double Density 8X Pluggable
Transceiver (INF-8628)",
        "power_class": 5,
        "max_power": 10.0000,
        "max_power_units": "W",
        "connector": 40,
        "connector_description": "MPO 1x16",
        "cable_assembly_length": 0.0000,
        "cable_assembly_length_units": "m",
        "tx_cdr_bypass_control": false,
        "rx_cdr_bypass_control": false,
        "tx_cdr": true,
        "rx_cdr": true,
        "transmitter_technology": 0,
        "transmitter_technology_description": "850 nm VCSEL",
        "laser_wavelength": 850.0000,
        "laser_wavelength_units": "nm",
        "laser_wavelength_tolerance": 94.8000,
        "laser_wavelength_tolerance_units": "nm",
        "length_(smf)": 0.0000,
        "length_(smf)_units": "km",
        "length_(om5)": 0,
        "length_(om5)_units": "m",
        "length_(om4)": 100,
        "length_(om4)_units": "m",
        "length_(om3_50/125um)": 70,
        "length_(om3_50/125um)_units": "m",
        "length_(om2_50/125um)": 0,
        "length_(om2_50/125um)_units": "m",
        "vendor_name": "FINISAR CORP.",
        "vendor_oui": [ 0,144,101 ],
        "vendor_pn": "FTCD8613E1PCM",
        "vendor_rev": "A0",
        "vendor_sn": "X6LBE6H",
        "date_code": "211229__",
        "revision_compliance": {
            "major": 4,
            "minor": 0
        },
        "rx_loss_of_signal": [
"Yes","Yes","Yes","Yes","Yes","Yes","Yes","Yes" ],
        "tx_loss_of_signal": "None",
        "rx_loss_of_lock": "None",
        "tx_loss_of_lock": "None",
        "tx_fault": "None",
        "module_state": 3,
        "module_state_description": "ModuleReady",
        "low_pwr_allow_request_hw": false,
        "low_pwr_request_sw": false,
        "module_temperature": 36.8203,
        "module_temperature_units": "degrees C",
        "module_voltage": 3.3385,
        "module_voltage_units": "V",
        "laser_tx_bias_current": [
0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000 ],
        "laser_tx_bias_current_units": "mA",
        "transmit_avg_optical_power": [
0.0001,0.0001,0.0001,0.0001,0.0001,0.0001,0.0001,0.0001 ],
        "transmit_avg_optical_power_units": "mW",
        "rcvr_signal_avg_optical_power": [
0.0001,0.0001,0.0001,0.0001,0.0001,0.0001,0.0001,0.0001 ],
        "rcvr_signal_avg_optical_power_units": "mW",
        "module_temperature_high_alarm": false,
        "module_temperature_low_alarm": false,
        "module_temperature_high_warning": false,
        "module_temperature_low_warning": false,
        "module_voltage_high_alarm": false,
        "module_voltage_low_alarm": false,
        "module_voltage_high_warning": false,
        "module_voltage_low_warning": false,
        "laser_bias_current_high_alarm": [
false,false,false,false,false,false,false,false ],
        "laser_bias_current_low_alarm": [
false,false,false,false,false,false,false,false ],
        "laser_bias_current_high_warning": [
false,false,false,false,false,false,false,false ],
        "laser_bias_current_low_warning": [
false,false,false,false,false,false,false,false ],
        "laser_tx_power_high_alarm": [
false,false,false,false,false,false,false,false ],
        "laser_tx_power_low_alarm": [
false,false,false,false,false,false,false,false ],
        "laser_tx_power_high_warning": [
false,false,false,false,false,false,false,false ],
        "laser_tx_power_low_warning": [
false,false,false,false,false,false,false,false ],
        "laser_rx_power_high_alarm": [
false,false,false,false,false,false,false,false ],
        "laser_rx_power_low_alarm": [
false,false,false,false,false,false,false,false ],
        "laser_rx_power_high_warning": [
false,false,false,false,false,false,false,false ],
        "laser_rx_power_low_warning": [
false,false,false,false,false,false,false,false ],
        "laser_bias_current": {
            "high_alarm_threshold": 13.0000,
            "low_alarm_threshold": 3.0000,
            "high_warning_threshold": 11.0000,
            "low_warning_threshold": 5.0000,
            "units": "mA"
        },
        "laser_output_power": {
            "high_alarm_threshold": 3.1623,
            "low_alarm_threshold": 0.1000,
            "high_warning_threshold": 1.9953,
            "low_warning_threshold": 0.1585,
            "units": "mW"
        },
        "module_temperature": {
            "high_alarm_threshold": 75.0000,
            "low_alarm_threshold": -5.0000,
            "high_warning_threshold": 70.0000,
            "low_warning_threshold": 0.0000,
            "units": "degrees C"
        },
        "module_voltage": {
            "high_alarm_threshold": 3.4650,
            "low_alarm_threshold": 3.1350,
            "high_warning_threshold": 3.4500,
            "low_warning_threshold": 3.1500,
            "units": "V"
        },
        "laser_rx_power": {
            "high_alarm_threshold": 3.1623,
            "low_alarm_threshold": 0.0398,
            "high_warning_threshold": 2.5119,
            "low_warning_threshold": 0.0794,
            "units": "mW"
        },
        "active_firmware_version": {
            "major": 2,
            "minor": 7
        },
        "inactive_firmware_version": {
            "major": 2,
            "minor": 7
        },
        "cdb_instances": 1,
        "cdb_background_mode": "Supported",
        "cdb_epl_pages": 0,
        "cdb_maximum_epl_rw_length": 128,
        "cdb_maximum_lpl_rw_length": 128,
        "cdb_trigger_method": "Single write"
    } ]

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---
 cmis.c    | 6 ++++++
 ethtool.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/cmis.c b/cmis.c
index 4c759e8..d044743 100644
--- a/cmis.c
+++ b/cmis.c
@@ -1130,10 +1130,16 @@ int cmis_show_all_nl(struct cmd_context *ctx)
 	struct cmis_memory_map map = {};
 	int ret;
 
+	new_json_obj(ctx->json);
+	open_json_object(NULL);
+
 	ret = cmis_memory_map_init_pages(ctx, &map);
 	if (ret < 0)
 		return ret;
 	cmis_show_all_common(&map);
 
+	close_json_object();
+	delete_json_obj();
+
 	return 0;
 }
diff --git a/ethtool.c b/ethtool.c
index a1393bc..0b876e8 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6050,6 +6050,7 @@ static const struct option args[] = {
 	},
 	{
 		.opts	= "-m|--dump-module-eeprom|--module-info",
+		.json	= true,
 		.func	= do_getmodule,
 		.nlfunc = nl_getmodule,
 		.help	= "Query/Decode Module EEPROM information and optical diagnostics if available",
-- 
2.47.0


