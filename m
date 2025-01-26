Return-Path: <netdev+bounces-160973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D1BA1C79B
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E54997A2691
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6551662E9;
	Sun, 26 Jan 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cs4NChS5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C1156C74
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737892649; cv=fail; b=NwRxs5QxxrHfabAah2L2xLZv5Hy/MzfNtZaX3SVT5fyG3ASWDrfb1orXt2C7sNGvecrVHx5APqrmtKbCWRRQsWkSfDSqZ8X+Mk7tH5Y46o/LPVexGjOzdBNaMwiCZQQA+otkHFqzUvGbLc6mziVaYpyDhzqZGSUn+G/9PfM4aE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737892649; c=relaxed/simple;
	bh=+s27ckSxv5R4b5IXEyTeaLoK8A+EmA/6gnpXd08gpkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKbDJFRUk37S2lvj3r1V/l2v9XcC7r+a60iv+s7o8VlYPIBvnwF02oCfp9qYWiUqIc193m2Da+7UXSV6dn7RNeZNScBFmgpUv8xFGWK6G3C5WPkYCjF6PrVLm2MQ0GzT3oJtNQjGp8iMbl2qPxz66oZ2UL9TYEjS9ZD2lekuOcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cs4NChS5; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wB7OJVMjlcejBj/93NNyn7zyF2VTCjsl/FzaTHNECMHlHrDlccPA7B0PYpE3VNIRIgWf4jddk5bjrft2AS2vPCv8aEz71w+ku3B7ZhF6vSxbHcwpmAMKr3B0eM+ZgenvHe9OvSAczLgAkBi3hrJQrwalqtS80KmSskCArH34m9kgWC88r93GY7BnOVszVhwc9Nit04UbMGHR+JhNdf5q/SgSl5rn0Cuw8qIMb6jUkeaCApRW/lclOaBKknn1YaNZTL4C2IhDOBNoFEhOwSyrjlvvYR5wkXIxk2Pk+f8vfbZ6Y2L+JWlR295m2RyO5j/6sCkKQuFVG5GM47PDTrFYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKngEn9AaMNgYYCf05Vro7CLiYOiYY1CNnKdPACSSxc=;
 b=jx0RXnLEIMexnTRkmTuIhr1aKri/qcxmopwYM9/xn7oke9XwaRmpMLoahgoQ/rRr3TAoRHt8chkO98fkMy09/JRxTO9syZOEZb92x1rG43T0SQeIJ3eD8puwsN3iKabgGPfn145fUfjZ09TcdjDl+dP/0Dc0+8OBakUQ3UW2zXe0kFU1Onje+Q7NXOh+WOk0pzc4eiqFk2+WKBhc8PBN0d0RhOTHG8bX455A9vVIbnhOcLmdxna8AufZ4a4VVVAwGTn097QYjFh+hBxCMJ0WWL6Iz8WXxJgMjC/Ff+LPPyRtlUL9KalE7Lb+p9UjrJjFW5NG50jqYKt3FS62+ipi4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKngEn9AaMNgYYCf05Vro7CLiYOiYY1CNnKdPACSSxc=;
 b=Cs4NChS5VxxveS0ZPlGL/GKvP1ZE5wJ+cE6F89a9bUHX3JTpxpBxGxSHg5Z0A77voBDpQ+gal3cY1u5FP4nltHyk9su9MQj9/7/M15z/TT1S263oOS8I1s4D1aAe6DrD/5kBjN85D17DvOphVpnstY9ysEtnetzWzhzMlKuR0VcuEqp8wPR+ch5HBSQvNfs6HIVnRIHLL+PEvMXhRedIDWwNQFKzYGS860wfY/pJZE0tpn3AVu2TMC4jcKC1g1/QK1x2Im62Vmpe8S7LGgjfXFKJ8rZfpmPJlH0QCAe41TDBZKX0yqv/dsplhDoK4xcd+09jfQwP1Gcdf3FhKe0AOA==
Received: from PH7PR17CA0063.namprd17.prod.outlook.com (2603:10b6:510:325::27)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Sun, 26 Jan
 2025 11:57:24 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::c2) by PH7PR17CA0063.outlook.office365.com
 (2603:10b6:510:325::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Sun,
 26 Jan 2025 11:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 11:57:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 Jan
 2025 03:57:09 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 26 Jan 2025 03:57:07 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in CMIS modules
Date: Sun, 26 Jan 2025 13:56:29 +0200
Message-ID: <20250126115635.801935-9-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f6186b-44b7-4525-a833-08dd3e0098c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tc/3NNSBA4nXR8bxpZCQs1IxrQH91sOmw0dBbsf982FY8tZBBqFBtP9xjFfF?=
 =?us-ascii?Q?mIE1T20Fj8WAwJmKnQZygcDYMLwaskdiYCQT2cpJfM9OreMgFtO+8AWkt9oJ?=
 =?us-ascii?Q?y6eAUOjLK25M04MXazXfWTZJgPnPlSVZNOu4tEt9tMFBLhIC3e8i6F0K+NPX?=
 =?us-ascii?Q?eHIlxcVYTVRcIGDMkaydyJv7BKzUziqHza9m8yN2NIgAn/OZm6rDycA93C4d?=
 =?us-ascii?Q?fGQxw088hkGhaoeBg42NxQgqVHHcitSTcyVKIN3wcD62aiDkpLfmn88ulzKk?=
 =?us-ascii?Q?XeX0FCHeYTNz1wwauBlvBKwmJQfAi6fWNep67OTU6YB+Dkhfz8mE7TNAXrpB?=
 =?us-ascii?Q?09C+BnGkNGpxgFXobmalS2VZoMd1Wegszqvs1oBc0pyfFqTKWiiG1RYim3Bf?=
 =?us-ascii?Q?lZZofEmKyKDY6gKUeVCgpHWN2db4ZGFKqla/BZLkuLGtFFJYM6qB/Jb9v9cP?=
 =?us-ascii?Q?h5RTAPyOCIxzm69AzsULZ3UIjvl24jwJszSjAzM3s/EhUdh0vZFzJ7Z9QJsP?=
 =?us-ascii?Q?bLbd5HEIN6Y7K/u3yhExQr0hXSfC5GBCB3z1V9KYmgwyc+X5E3m8pffUCYnU?=
 =?us-ascii?Q?tWv6tMCpCBgxEaFvowvB+2Tv7Ih25srWoQHml3tqHUZtRgmqvxyz/3Fx/Su6?=
 =?us-ascii?Q?8U+3BZcdT/oTkw4L4zbSV6Qh8zabPp+36fGz5XVNTwz1IjFTp8OIuE5cImve?=
 =?us-ascii?Q?kfdZjB+QyNFY/TXa9MFY+GA1Kx0fc2Dvquaun0JaeD1cXiP4HC0qIQV9aRrf?=
 =?us-ascii?Q?gZ5xPqe0WuDB4NOkbOyo8Sn9vQaxbTN1n7DqY5mVpWIo8H5jjo3acXr9I4zN?=
 =?us-ascii?Q?esfp9ab0pv9GC4AY2AhWH6+O0ljFXv/llzhmM12Hd+gUowmTnjB+739kRzBM?=
 =?us-ascii?Q?g+FfYi3Km2rI4xFgEATR91f2Zy14rv5mbHk5oejj6wQpYahSPDwdRkGsChhq?=
 =?us-ascii?Q?aoxuZJABTurnbcYOSiSwzNuVVW7X79aSQ0FMBrBSpwHsJrrJ9fXd8NVS4XdA?=
 =?us-ascii?Q?LFQw1eM1anDvGvGoCnwtwSjV7yRJMDI/1N3L2u6QymLVQmEt4fMhVgN9G/dA?=
 =?us-ascii?Q?oDv2Nf3kfM9FkLuashn3kHYAZ2IxLOzbBrZjS9RY5kK2dW1E8OsdihQ/Rspv?=
 =?us-ascii?Q?UPasxc5gdaaGGk6Dl7D/tBuAWNwvwcjMr0tFtX1qBBtPm9OyJH3m5ffuP2vu?=
 =?us-ascii?Q?3fjGdr/IkewxafqadJ9qjwNYz/DIutxGS06aMUkpUqjVQDaD7RG3Luk9KXtB?=
 =?us-ascii?Q?N95mCUj3aopg9m6yxLOeIj56JwcQAtUtxP5kbWCIwtI/aGKxRPbAncHB53QX?=
 =?us-ascii?Q?e1EfxDH12jEjRmhVs0iuQskW3mbr6BdoWSWXGzCj3s60TEDdGLSSQEXayrJL?=
 =?us-ascii?Q?/S9/AgXVzVwwIQR/0vk0crnCFsXSICTRTbWBHChe39DWu9w7Dc1g07ibVN+Y?=
 =?us-ascii?Q?LQabdqtQ1Ymjh0nxWF9yCqO5YMCh0Oiyp8+HOKXiTp0vZww5eXlYdxmoSF9c?=
 =?us-ascii?Q?l7a+HGcN+5I7U70=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 11:57:23.8757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f6186b-44b7-4525-a833-08dd3e0098c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750

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
index 4901f57..f12548e 100644
--- a/cmis.c
+++ b/cmis.c
@@ -1129,10 +1129,16 @@ int cmis_show_all_nl(struct cmd_context *ctx)
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
index 225f3aa..2818206 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6044,6 +6044,7 @@ static const struct option args[] = {
 	},
 	{
 		.opts	= "-m|--dump-module-eeprom|--module-info",
+		.json	= true,
 		.func	= do_getmodule,
 		.nlfunc = nl_getmodule,
 		.help	= "Query/Decode Module EEPROM information and optical diagnostics if available",
-- 
2.47.0


