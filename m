Return-Path: <netdev+bounces-164619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C97C5A2E7DD
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637DE162A26
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B41CB31D;
	Mon, 10 Feb 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QjiKms0r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038481CAA64
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180050; cv=fail; b=DILHxMvZmc/MPiyfIQYX1gd0g2vr6/13X0diOy6b5sz2jxLoyr5VoXvYkwOPkRWuSAUYvBLlCt30jt9oPALtGf/bd9D6WNKyZl5gfzjLt/WciWaWCfQP57sLHBQWphUtBNkJGok9gxq04w/hlJTaq8ug6jCQX3W15MCRirytmsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180050; c=relaxed/simple;
	bh=5eQFFAq4Yc5BjwNQmFXutQwaGOSL7y2SQyNtC0iiZbc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdTflDwFm8Bp+c7mt5O1HlqcHm5MGzQcWIsIOoPJGAW2ka52nDbD6M9zKRdR63NCHf/Eh9FVaXoB5vH+pO0G0zmjNqas/7o7BoI3Djw+yHHgwgWRUq70uNpQAtfLZEkTTT+bvgLyZiya2hCUtlRDxKYy+Rd0IwU0meiHCjtlynY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QjiKms0r; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuwWiQFqyae4rarApslDMUsRaLxxE1Gfv/XmVtA6iwJYgE61rIpSi2YBad+Rdj1KJ5USG1qMLVZ7pHuLW77d6cIvnjkFs97TT8zCdsFJf6vocZdhBeucw5LeYzljJnYvnQfWVhpbocLMdQo5HzwR60NFze46MVjY6KYO87aFv8018OzxFzlJ29uGV2rtwP6Sk30EZcWWi5vFh3scZEqrXM6Weg0XYx3WIYBfoXXzXbPiJNL+TyJ/LtXoX6/IxQpLssNoVwZdpOSqMmjHAporaOWEy1XSLQ7rJnmCY/jqIMInFHjl42WhFhRAQrXYjdybcIzGQuUhx7V2+wPwHWpNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=848/VcPOCSoHL4gnuV+vhiqfefNyaHtL/mNcIRVeF5s=;
 b=k7NnuP5B679414nWO1O/yd5yu2bVNRU5bh8j2xgWPyyBfCAGyvq9oR695IeRqvbi0wzFuRyNeI6EzStvSufCraat59v0NXjRnggieurTzLJdRxgI/yX3RL0w5mDX0KZuYB8VIiqPmkQkO2pXzQE2q6wp9USMe1UF37TK9bHCB1JlUpvlR+UJu3ryv+k3wr9FeIedYKG3VeUZQfeU2H8fJY+oVbC3foiXx9HFhmUz8uhBUONtjEvRx1Z++XlFtJLYzygE2CiBRw9PzW8NdgBCJgV41XBHoR/8V0cLL0zqTWCW8feN7Y3T2w98MvxhbPeIbJvpG60vzHr1xstXADVESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=848/VcPOCSoHL4gnuV+vhiqfefNyaHtL/mNcIRVeF5s=;
 b=QjiKms0rk/E3Pnn3Oh2Oy8bm0C4XvLA/4TgOex4yfYxSGn5M7Z3K8xQzn79eDwM+lf8SbM4n8kzcVJSilDS85KOTE70f1jl+0BkPoeQupZeb/PEXPKsFInu+9sFrp96maj7tRuTU6CFYO86lR+Y07/FwDVlNXl50o4QlkP33R8R+k91lWKkwxvdg82+yhYk461xL1T8Z2k6Y77VwaZrpv8+ydw9KkO+yWeooHFSHtCngpM60cerqoigoxqva/tV32AszKGSug9cGw6KLbMsQEhfZLWqBUptVgWFSoNBLWWK5piVaoJwi5i8PkIUEeonnQ+iBS6J2w/CovL4RRMkHTQ==
Received: from CH5PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:1f4::13)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 09:34:04 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::ef) by CH5PR04CA0013.outlook.office365.com
 (2603:10b6:610:1f4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 09:34:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:34:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 01:33:52 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 01:33:50 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v5 09/16] cmis: Enable JSON output support in CMIS modules
Date: Mon, 10 Feb 2025 11:33:09 +0200
Message-ID: <20250210093316.1580715-10-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210093316.1580715-1-danieller@nvidia.com>
References: <20250210093316.1580715-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0356b5-699d-4955-7fa8-08dd49b60f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5yRbyy/eRwusevlsFngDe79bSohN6PK1cImzYIjzyvGHxPPXyBb0DF4CPff8?=
 =?us-ascii?Q?2PVOY7koCxKAW/kzawVCYq5Yw65+d/3q0HlpnIrDI2aqAYCehRvLaRgSwK0q?=
 =?us-ascii?Q?8vufTg5ivbCrER9v6mVp5/IvTfv3wfqhThC8/5kWzBtA1KWe7MROH2OPqHqZ?=
 =?us-ascii?Q?p62Rre5sZ3K9fimqohwV7BU/LqMXAlcOZPhSgGXXKPIZB2Cpf6e6A1e6dbQw?=
 =?us-ascii?Q?UIaB5wuIiyUC8TzkOjZfzkYi8s+AKRc0nWORe01DCN65RbE+kd/uPXDikJlF?=
 =?us-ascii?Q?FuOoxDXmZrB7lGr2BiZAwPsfoS8GDNBsBQNGELsfbG+ttYUO2KclspCaApiV?=
 =?us-ascii?Q?jJUDuMgxgKlHhFG/pn6l/Svv9DAUmx8ghlxrjBb5ApqYsBCHk2EL9wPRWHEB?=
 =?us-ascii?Q?ELqkLhC+dTp4ScyZ+q6hNXo8ELnhKbLOhgPPsvNmGTuTH98HuTVRsiKqGF8B?=
 =?us-ascii?Q?B/5M+n+58iZQJl8jF+Bn0JZBPUpl8wxzdALnhm+GntfSPEe5m7yPMFaQgKM0?=
 =?us-ascii?Q?o8tDQKI+cKc2lYDlRnrZ47NOH3guHfFD5UBHM5yxS1ztEarV9cCZ8bXawuvl?=
 =?us-ascii?Q?Da+awQFHA9EeUYLhhBag/475jNO76aQN45p3lOGxRT+5JTslkuBWZo+PaMb8?=
 =?us-ascii?Q?8IY/NL4QrvMcc0EaewiMZv+8IXa2GbwUuKSsnJHEURFz1sDhCH7AOSwKNzFr?=
 =?us-ascii?Q?eyZ39Yo4j4wyRuArNMD3gbx8QoRdfILpM2oKIQZJ28kr39Tv1+JCUB9H6z6R?=
 =?us-ascii?Q?pLvJ5HU/xMfzxy0sZ8rwlw0IuxDUwp3bUEiLcdmx5jAK0pkSfdtVekbRRMEQ?=
 =?us-ascii?Q?3Ikbp4UzWEZPTaZDPvWIcJCsZYVHj/u+OpFb2tZT1MJrDmZ9+9XSGHKgK18O?=
 =?us-ascii?Q?hHRjlZisdregh2DN0WS2Zd0JOR5Jl2s4NRwx3PDba+Wt8LLE8JCg+ACHQi0r?=
 =?us-ascii?Q?5kFuo7alXEkUDcMOEm2Qp57c9F4rw9nv8P9u9UXXKieyWKTOFNxqUPaeNYS2?=
 =?us-ascii?Q?iMA+24igbB4diFP9GhlGZLTM8jrMkQOH2PHfR7dAiF/gW6SZebd1FFjHV/GN?=
 =?us-ascii?Q?KxfQ9ahVdQGHoWt3Pgrnc8xZqtV2Ms0RdW1MOyaiMDYNv45D9lO4daRaHJPk?=
 =?us-ascii?Q?o5Ctj5A0zeDAnPBtdCMveVn2T4JooS6juaD+xDzATgAmoFbLZi04T0EJsnuQ?=
 =?us-ascii?Q?2Fbg0dDG0GCDMo7nglDq+7yhVFK1RQM1ywvZZ7ROjEU5GB+dr7wt1+/+HfEB?=
 =?us-ascii?Q?u0RRYoJiFjVm+TYc4MeZvFwHYCcUuR0L9jcOJu2bA3otuAqr9x5fBVuXGvHr?=
 =?us-ascii?Q?o2qwXVPwTq2NkQ8xJu7yPKhuSFHOcsiCFReCrqorfoWjNeGiCi4jOd9AKMsj?=
 =?us-ascii?Q?AHVLpGEQDtDaDx+jg1/Mg5JWhM1RrJFJuheuxiPCGwPRzqI25PvS+a/YuqIj?=
 =?us-ascii?Q?JiSlGhmWLPtSB1gqELBwFR5zbT8Zo7N34KK3ujKUvTlSzDYOI1Qynn5Vb6yv?=
 =?us-ascii?Q?o3lPX/TykHRfXGM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:34:04.5315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0356b5-699d-4955-7fa8-08dd49b60f59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

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
Acked-by: Jakub Kicinski <kuba@kernel.org>
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


