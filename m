Return-Path: <netdev+bounces-162558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD36A273A9
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0796E7A4049
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA05216E3B;
	Tue,  4 Feb 2025 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s6RGp5Un"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961BC216E30
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676463; cv=fail; b=k+hrCsCQxl4PqoJtUTSxRUtVAA1lYeT9uDjBz+klKYZE5Q5g/bGU7AlXBVhMFoe1rL+fRq1vR4xfYbgQEjAgeGGHdOaqf6EaUOv6yM9AhUljhIh5oxYc/ogl6XmckbTLYlEA6ZjXiJN6BMYpoci3+Z83M+ieAdnvPV7W8JVJd4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676463; c=relaxed/simple;
	bh=Zx0/+K/rnzIf2jGc1c9koJptncvvP99PPezgWLthsjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sx/2EbxfFV3a5ya6AGxQxkkFkAi5IXXIN+013z4dpeApPcHVtg+MVKDocujX3IyuyIRlsE4fg1qmZ8X6By/GlqEmy2dY5Bj6JAg/Jck64ul94mhfeiUBj7R01JaiMqKeBQ7qlV3dl25BD/In+hOGZpKQLX2Xbgh7Ukam7TBTqBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s6RGp5Un; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yk3GWFroaupDEb66RNaQ5Hy7/PxCHfNbUwP8e9Yv64L63MALcpfPLbmDiLYST5NwCUzeP38OrgCHBVuHH4fQWL2GZ6iMSp6LqyDUbYu5nPWecS0JQ62kIkvIrK5dsnnMjPdWSVLCH5JpGZtf9QA0WbWq0AigEg1xPy7ad+Ltn7jVCU5QBdHjdku+PIrcAIGRBry3VHWWmi59Q9s6Ew7XpdDYN2Zhk1K0E+NcxnNXZA0CunZuz6A0zoP35EPj49FxeQ16FgIzC+gioHBVhxY/S+yoOKYL5mRHGO8SZmPdFGqbgOuikiDTi5/jwM4qfPqlW/NIh21uHhuSDySPGrNmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLfXyIeMS4xgv9gSt8ngINbyVm96MZJ6MFHEos6i8Zg=;
 b=kUzwK3wYd4ui+nHqFwnEAqC/7Gbfu38HYY4muGzj6hNnA3KNcLrRjOZbp8h4xPJs5aps1CHRxV3UWJKq54j6cPs25SwktVIpvQiN3U0i0BgczRUyjzUBG6Oc1ZDt/SVB4iBZjvTc6E0HijC4bG9Goya/Dm6SIhuxlra3Ajbe+y5HUMJgOHIO+3LFSJjgdjWA0noWntFMKSTP/Rv0/6yuiKrbOUw2V9Ql1dlxJRReZvVAbNtOyjivl3DQULH7Y6erjmCEDXDaB/vkKaAE2VN+fz7xRnMkfV2OgByCFOPbKQu4DgXUC6fKcyTrxXQ/8R+rCnKAo83+ASxCFzrKf8uwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLfXyIeMS4xgv9gSt8ngINbyVm96MZJ6MFHEos6i8Zg=;
 b=s6RGp5UnNptFHZ4fSNBmrRscYdcqYyPAWxJgMMbuAn8E3lJ48y/zYEWKPg1OD63EOqXsUilnFidgSUw9kEIqzws9Xsj3k5wFeVGpgJyKFhE0Yufh55LWQRgCx2oK+hEpxN2FxwQgjVmKBFKkQiQwbv25RWSnVPxCbXJkQEY1ABsLVjLWEo67+Fn7HyE5tOI3hWCTlx5nvkH5+xUjYFkUa4GQwezkOdwzlnyocOUi4gcVRoLA514PeXkCHLI6dakveErLO2/PZXTZlcMt5MklAFx6a28UAq8bFOzLXRr0YxI+drCdgy4gYLWpTaa+g6h3rAN2XbHPRMR5pcy6Q6Xbkg==
Received: from BN0PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:143::16)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 13:40:58 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::3d) by BN0PR10CA0002.outlook.office365.com
 (2603:10b6:408:143::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Tue,
 4 Feb 2025 13:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 13:40:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 05:40:34 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 05:40:31 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 09/16] cmis: Enable JSON output support in CMIS modules
Date: Tue, 4 Feb 2025 15:39:50 +0200
Message-ID: <20250204133957.1140677-10-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250204133957.1140677-1-danieller@nvidia.com>
References: <20250204133957.1140677-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: 35839707-43fa-43e9-1d94-08dd45218e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJIiMEVG9nKulMelK4x4ykMGXWPpJOUeOp8uvny66YQNOrYcm5NKCkns6V2V?=
 =?us-ascii?Q?0bVAVgQhZBs8L19UiBSWHzE1Pmgj2oAb0hDQy3mWGLEmVzp5XMfkkc3itm9U?=
 =?us-ascii?Q?XJA2fBM5LpzVtpBleTARgekF5thpBOs58Dv41+6lz23aotd1pIZ6+8MwhqbS?=
 =?us-ascii?Q?MHRyYOFUxze/nD/GpUpTOfAOe3qf8kroiUNEh43YOIfxdkRhE7L3f2DNYeZk?=
 =?us-ascii?Q?FnHCTBeD9se3Oi+gJ7HUhFn0CQHBRSt/VSWHCEQBeBV31EA2lzEf0BplJ12G?=
 =?us-ascii?Q?9egzpI7z+TPa3MKt7VwdD37SAxLbxQU74PNqO049UcxLlY5VINxldDoLe7Fl?=
 =?us-ascii?Q?GMhYlaFwjaCGA335xJZH+lkhtaqCFq4xBaqhCl7fFAE2+536jWeGA0ynY8ZF?=
 =?us-ascii?Q?nLfRSdyoMRJnM/03a+3Y3LOb7T8Ze5WRO4I6jgUi+D95RdQ8fSiOi97/gKqm?=
 =?us-ascii?Q?kFD2nymL7BHIEN6jKRND1jBDKxlkEpwi16+zr69smenoPzHSehfLkm4sQFwB?=
 =?us-ascii?Q?iuneGP27QKbg+uzWpS138DmK9P1WtlYlu3BOZTBa+/eUT2M216w16qacSc7C?=
 =?us-ascii?Q?2O0XCf8HFNoN2AfIsWil8raeMB+m/mMQqcVvt/UbDFsI+8J1aIxbcm4laIGf?=
 =?us-ascii?Q?jvgObhI3V07fwH/YMDRfywJ6fG+q8zTLk6Dinz4HOXdncDoodjGBtk7RPyFv?=
 =?us-ascii?Q?Rcrb1CqGCtlXtIjXVZm46RBIi6rLkKRrDmVyYInKqkGgSah8/cHyit3EGMZT?=
 =?us-ascii?Q?Lr8zWQZPum+KebiLEyICSZYNARNM5Hn00iIJh1M4+q46SMzc7fMOiBlVWKJO?=
 =?us-ascii?Q?ebgzEAymwaBk+wC7pS+Y8b2HlLtSDmF42i7PlVQtmQhwOotcMnZNZtdbZYRd?=
 =?us-ascii?Q?FTQOyM8fHnFsH58ivrFyXvx2MaLskvV7Do+5snESl/Ah5jggbhPx+CXrJEET?=
 =?us-ascii?Q?6AwlHi177wzwP79GbnvM6Pbf2p8IbrCO0990/wIRTGBBQ3dFV7OdJMaD5SPH?=
 =?us-ascii?Q?ew0fH75AC1U0vo8rrZUhiMutftrFiwi4e10+g+YXm/fx1KzBswWFE6TL18ZR?=
 =?us-ascii?Q?+5zXFshytLBBn3O5EImfhf0s4Gte1OXUG2e+4Ty1QYNd9U7yeACwow8B8jas?=
 =?us-ascii?Q?2dpKyy4IQfs7t7VnjaziuD41AZtE/MOHSv+pk+VjDVeTrP78Qv3t/7Tz2dsz?=
 =?us-ascii?Q?688HhpkAWL4xdW9FGpjSZGLVsVvxefm/Jxsdg2Pog2p4pYDh/2sRMN1HUAOX?=
 =?us-ascii?Q?2y0wgaMeMZMXWrkVm02PCkIg7L3V/FHyqixEA/jPxybdd2JTyYB5dfQ+WK6+?=
 =?us-ascii?Q?V8xL/aXmCz1It+hS7CeJM5erxyyCtpaLjiSnzCOqfCP4s7wNAhFlSK1Xh+8O?=
 =?us-ascii?Q?g5WL6MQ/iwJlibGrGIgZWNi6Z9RhzgrJ6PcWhFPlEUQ7JJsdfew8EKLh2MGh?=
 =?us-ascii?Q?hFh8IpAyo5MVi2BirMGWDvr/1sdCCjaYy0AKk44tAlVQ5HKxVhVtzrCdib9I?=
 =?us-ascii?Q?dj1K7XGmdJraYT4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:40:57.6046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35839707-43fa-43e9-1d94-08dd45218e30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795

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


