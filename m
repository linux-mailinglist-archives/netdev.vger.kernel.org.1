Return-Path: <netdev+bounces-163109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CFAA29571
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63DD1687D1
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECA2193436;
	Wed,  5 Feb 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AX+ejhFG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694DB18FDDE
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770947; cv=fail; b=T6J/jB4R1mHL19fXzuu4QD9BWPgmq36APeUvsor5+bYRJ/ryCegW5Bmye4pCVkF+BgPPQo+QJxPZ34nwvOWMQvELl7+VDSat6SUOjt2mlSLk9cuOJHQhX85lVAFR1DHgQBvb1SFpyzaWKcy8ZK8oxUFvNSfN6YxzxzJ8+ZMEnBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770947; c=relaxed/simple;
	bh=Zx0/+K/rnzIf2jGc1c9koJptncvvP99PPezgWLthsjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FI9R5FkkPc6Gshn9xpSdU0DtFGncOk0kt1x4qHyCZfoY2IHgY+wZTtH/41hmztIoqFVTnR7cGBOFY9THB0kRTSvgMlD5XLhxnvbTBL6W1r2OQdbWjuIdTRxQc3UX+KVLr2hxDlkrGiDZ1BHEfKbcUIFYo4lstgkT6od6/XhBuMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AX+ejhFG; arc=fail smtp.client-ip=40.107.95.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXNVB9jjFm/VBL/PuavlA1GSG1oUVNWB06VKrCu1PcmINkcrW1+0BmrgaMKFQBzqWYkrd5eQw8P1bZ2NgDxpr4rbpBv/yNtlvVF06UN/mXSd+3Zyw7hyjB2EtRqOcgZ5nH6w8Xi/Ta8oVV22x16SeUCDlXXh4l2s+YdjyWEpMcs4VrLH0DA92oo8Zwvghec/kmokJpCcEJcJT99E6T3JuoxBAf+muiFg1ZPCOf1txHQL4fxCk2O/8HsiDZiKI0O6lSB/vBvNQDgWrJSHdF9Kju4HeYMKuguzZiPz9q2cA2gdSRYOtuKrICAEKtl4EXfg8vNNJSoVGTbDP62xXf6MHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLfXyIeMS4xgv9gSt8ngINbyVm96MZJ6MFHEos6i8Zg=;
 b=s+2u0jYLic2AQrvVMNQwVtt1ZOwg2PL4HLHnmBQxXtbu+aOY4zC/gAVCMDh3bbkS3jtec2HIIMmWX2+YFDLo+doO8Nmye317u/leQ8jEd3WbqxD23UkRcnXehFH5VWVT2SDt+2hgVyqHorGiAdYSJIiq1928NslwJBWdfNSC4C5FNKHNlxIN2nKmjwoIOyxOoFqwpZoug12mnEH0IFUpGWmiBoHxhMxOXjwpJUrRQc84uoaH3RMCHA+dcc0ziVogpnEAg+KnNrtb0FxjBa1h0zajXXEUqFVKKL/4v1xazSJgEhmJBlqK78PUAs3sOYJ8OiMpQ//xM7eg/xVO6WpgVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLfXyIeMS4xgv9gSt8ngINbyVm96MZJ6MFHEos6i8Zg=;
 b=AX+ejhFGBXy/eD7oR+e4UJUC9nSk14B6wGgjLMDTghHQGDQazwacq1zbIENh9RXHia/3xOpseM1+4BYWlJLa1RoQBSVnyeEDNpDGHMIC9+uUELk59y87j0Jlj0sJzvK6jAACldE6X3P7qLCDI/TVYfG1n58u2XDwBBCjAGnQM6s/BSOCdGI85CLjHfh3HgIy9yh4/FgxiVTvIhH5yDfRF28rQihyYa/sglZWi5MYGL0Ci0u5StLAQ2esAZi2eTJrwN+1HxponC7VBzzzKD9vLWX0YqgP/DeCm883kssbsY0uSUKOAMMBFszKmWGOFYpkCHdOf+NBoVdid9QZZZ2twg==
Received: from BL6PEPF00013E0D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:11) by DS7PR12MB6189.namprd12.prod.outlook.com
 (2603:10b6:8:9a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 15:55:39 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2a01:111:f403:c803::8) by BL6PEPF00013E0D.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Wed,
 5 Feb 2025 15:55:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.0 via Frontend Transport; Wed, 5 Feb 2025 15:55:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 07:55:17 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Feb 2025 07:55:15 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v4 09/16] cmis: Enable JSON output support in CMIS modules
Date: Wed, 5 Feb 2025 17:54:29 +0200
Message-ID: <20250205155436.1276904-10-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 071f4ffe-7d3a-4fa0-a171-08dd45fd89a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nv1Te9EqOHMjfyUpw05EVE1iYg2Eujd/Su+e3fQVDXjuRCN1cxD+cXNiTI0U?=
 =?us-ascii?Q?j5a319rXVJQlnQG7uJaEEGSbRGj7N2d3ihctSOPu/sX2NjycHncj5IKid8If?=
 =?us-ascii?Q?ft+ddp8Nxxci7gXjjEZIIoTeMxQnw8x2qCN4GoueHVrPaq1oKZcJLOV9acXc?=
 =?us-ascii?Q?NF7imFb2o+VKRUdf1WdZgJuWjzZ6c+cjKMYNkxRIedi4j79i2X4QBWI8+TS2?=
 =?us-ascii?Q?Xp0Vs2XYHFmWHW05CC0xLaBbSftgL+oUSY4SSp90HY7p232YlOiFl2TGA0Yd?=
 =?us-ascii?Q?pAzK1Iwyljv0sYiZBcbL5u826NEOVxZZmEijlCHZLhdOwLb2ZHd3m+sQpEc/?=
 =?us-ascii?Q?agGSkBIPqefco43BxhpfiIeBlQ1MqrL6rmNbZ190NhAphZOXJfZnWKYLewjX?=
 =?us-ascii?Q?sSBlMGbW7muRzpTBit0tJ666NulvOI1Ovd4W6Bz415zg7KgIt0N2RKnQX9LM?=
 =?us-ascii?Q?X6mgV5hbuNbHJcSSNj3146k6p9o9G1zGeIcWCvqayGK5q3qIpezKSgzm8ahm?=
 =?us-ascii?Q?dGEa1IqzNquWF5TYGuKGzLDUyy7hhdozHR8gJbz35Hw9war5ghI7n0hd01n9?=
 =?us-ascii?Q?obiW0uGe1AilISMC3tOqij96H7leFP8IacDEvy2kK5g2Fq1+CsejZn2NMj05?=
 =?us-ascii?Q?krTUEToBm3OkcYFgCVWvmaUzYserQrlf8/E8nPLQr4Ihqh+/3HLhCAECWLT2?=
 =?us-ascii?Q?8WbzNE5qV9AGohs3A8pdO3r8kmz6UwZ2HZu9bMTjNi/fFhSgBcsldGQ+eJuH?=
 =?us-ascii?Q?RXu07/z2m1eHyMLr4mu+LR4FFdc72S9xjs3hwTLySMdsk9/DnWowXvsjfC1b?=
 =?us-ascii?Q?mCg3rh+aA0rS9HJ+mRf1bs3R/JGnLH+goMXKYvWkem+FYjqkKZi+R4SJfOsw?=
 =?us-ascii?Q?16O8jIetJVfx8dOs7OB1+Ij2h1DFGSBgH4Pagb/fPNgBRCE89vTplXvAI7kt?=
 =?us-ascii?Q?UJU8CVukzSCq3SvEpgJW+zVas20YhmohodKY8fLJaWtRur/11FPgEy21O5/A?=
 =?us-ascii?Q?fnLOhTc7MhCvzhMbsvjoCKbUoHJTLUsw84cHHQ4ULug9Xa/ruNWJUjMFonDD?=
 =?us-ascii?Q?amjvv7o3ULJUhtiDuw696121hKN0n7v9Edk1hsG4QIW2kkb8+U0U8p1d/YxJ?=
 =?us-ascii?Q?uT0zVJNwcJb8pFpeRg5H8gbSkciP4WMuqS4iT0dSSUW64Js2qtebCofSs+0X?=
 =?us-ascii?Q?j9Kfrwh/cH4wW9Nhx/09ZCoiLQ5ybhJToq95g8EUCmt1CLHqi91aIbMI3axs?=
 =?us-ascii?Q?ZOEq319Yegg3bKZ7KaAoQpM0k/u6nrt5dyRbQwgg8CZCu594b3m6WWZrk7ei?=
 =?us-ascii?Q?gxntxSn80pPnZBYJzlNQMxnp31C+fzSxaXuu3aRCZuE3y6LqXSZ8wDkaaOav?=
 =?us-ascii?Q?I4b7OfNncOEp+IzerSMyvxrN547FRppv/Ivq5OsgZVl9sCCdqHUq5fNrvQ49?=
 =?us-ascii?Q?yFL/YOgq7BuUKBgNViX7bxeo/Vy7K3fJiCtlF63WVVw0O7bSwi5tIXEQMTTe?=
 =?us-ascii?Q?cQB+vP4NHt3JLbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:55:39.2732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 071f4ffe-7d3a-4fa0-a171-08dd45fd89a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189

A sample output:

$ ethtool --json -m swp23
[ {
        "identifier": 24,
        "identifier_description": "QSFP-DD Double Density 8X Pluggable
Transceiver (INF-8628)",
        "power_class": 5,
        "max_power": 10,
        "connector": 40,
        "connector_description": "MPO 1x16",
        "cable_assembly_length": 0,
        "tx_cdr_bypass_control": false,
        "rx_cdr_bypass_control": false,
        "tx_cdr": true,
        "rx_cdr": true,
        "transmitter_technology": 0,
        "transmitter_technology_description": "850 nm VCSEL",
        "laser_wavelength": 850,
        "laser_wavelength_tolerance": 94.8,
        "length_(smf)": 0,
        "length_(om5)": 0,
        "length_(om4)": 100,
        "length_(om3)": 70,
        "length_(om2)": 0,
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
        "tx_loss_of_signal": false,
        "rx_loss_of_lock": false,
        "tx_loss_of_lock": false,
        "tx_fault": false,
        "module_state": 3,
        "module_state_description": "ModuleReady",
        "low_pwr_allow_request_hw": false,
        "low_pwr_request_sw": false,
        "module_temperature": 37.5273,
        "module_voltage": 3.3358,
        "laser_tx_bias_current": [ 0,0,0,0,0,0,0,0 ],
        "transmit_avg_optical_power": [
0.0001,0.0001,0.0001,0.0001,0.0001,0.0001,0.0001,0.0001 ],
        "rx_power": {
            "values": [
0.0001,0.0001,0.0001,0.0001,0.0001,0.0001,0.0001,0.0001 ],
            "type": "Rcvr signal avg optical power"
        },
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
            "high_alarm_threshold": 13,
            "low_alarm_threshold": 3,
            "high_warning_threshold": 11,
            "low_warning_threshold": 5
        },
        "laser_output_power": {
            "high_alarm_threshold": 3.1623,
            "low_alarm_threshold": 0.1,
            "high_warning_threshold": 1.9953,
            "low_warning_threshold": 0.1585
        },
        "module_temperature": {
            "high_alarm_threshold": 75,
            "low_alarm_threshold": -5,
            "high_warning_threshold": 70,
            "low_warning_threshold": 0
        },
        "module_voltage": {
            "high_alarm_threshold": 3.465,
            "low_alarm_threshold": 3.135,
            "high_warning_threshold": 3.45,
            "low_warning_threshold": 3.15
        },
        "laser_rx_power": {
            "high_alarm_threshold": 3.1623,
            "low_alarm_threshold": 0.0398,
            "high_warning_threshold": 2.5119,
            "low_warning_threshold": 0.0794
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

Notes:
    v3:
    	* Reword commit message.

 cmis.c    | 6 ++++++
 ethtool.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/cmis.c b/cmis.c
index 267d088..305814c 100644
--- a/cmis.c
+++ b/cmis.c
@@ -1122,10 +1122,16 @@ int cmis_show_all_nl(struct cmd_context *ctx)
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


