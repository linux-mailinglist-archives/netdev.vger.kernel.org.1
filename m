Return-Path: <netdev+bounces-164622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85D7A2E7E3
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDD717A3135
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F791CAA97;
	Mon, 10 Feb 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EbxKAWWD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65215B543
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180058; cv=fail; b=OKLP8kVyDq1wvrtUEDpWrqNCUx1N5Qu03F+iqHb5jmM2d+vNGF1NxK7QUPRAeBR9ir7Fwux/S/aAY3cdM+gBE1awehm44fb8a7RQRcRH/4PlUuyjw+38TkCJSWmBeKUDvO7M6dwZuo2+dIAJO6owdIhyjCTVMLxnYx37mRmI1fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180058; c=relaxed/simple;
	bh=GGl7OIbZRVSm7AbqUkwDceXX6Dr1Yc7uEywiJv+bbsM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ad5D05FE4Q6a3QJ5UDwqwpZrN3qxlNq1fqNv3dZ4o6qexzqjLTchRVo5knNHRdk0wKZTxu2VzJ03V3bqiQ+B55NT7NydJJbRSP2hHGo5PepHNnv7boUiiVwV7wDrWwXDUnlniAwToM0G7UeoIGN/dbftdPPseslp+AvjFiHyxyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EbxKAWWD; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbNBsAbTXF3Tg7eBEUMWO4xwgaEjfoDbHh1lO7QeZhV1sxVmwmcK6+l3VFcisLt7F9/jQ/N+mwVYn3l54wLRsp3QkI4QU49atgKpPgTzdzeW+ulbZ0+6hc1aiDRGAX3UYxDV50YTarrlLgOOF4oceQBsKsF+3j18O3vrWJxrge8L4dFQWeqpLDWfbFYNWAJjUrCpA8wDdFWgucNU2NKGIBY+oUe/qBBYrkh42M0MU2J9Hvo6Q/LRnzf8dnY5XBIKz6JgG5+Ub7NimFimRVBFBKMxCwQG81qFkNJjm41IqpN5mrjWs2XOmd8bbdC1kHqi9dX6aSUp4gFl2HEMdoG7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fcd6iJcpmmr7MgufZaHrBvNLvLA+xSzL8zxmx/YgafE=;
 b=hywZwnby/g2MjMJ8b5crnnq5flVhr1I7VQdxgjFr5KPdO4nwF4G63IdbZxSYQfSTM4+AJCOcCt+xazvOR790HlsprCyaD1Ash40u5kcwelKSOcKyl5opMP2wbTvpsnU0INBpAm65ykNaxUj8OVmwOCr75a8fvPuwaUUmzHZ4Gw9C+sw1wkdGTf4WWHch6d2zhnWu6Rx2ypqFjBF+mFYn5v1dfh767Sdu0NnXKH6ryWV3iulDbEXszUHPGnTTlNmwV7rCQqz5npcWXznG2oNQ4+Agpr9Tg7oQo4Cnjs/8PuXjozXwCaRqimXYYDUSYGwTnwiS67TkjFsxzLKHGxmWjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fcd6iJcpmmr7MgufZaHrBvNLvLA+xSzL8zxmx/YgafE=;
 b=EbxKAWWDtdjLn6Awr72Tlf6G5wtSRajuBShGCSDXhcBgC5xw2ocNCt9rYigXoBtGPMkMS2u9NL4vvsjRxcTrrTS0zhkWvouNcRKyjhdwqaI+6SNme2puzPCPHeVnP73+NUV/eiH6nvQeXw74xPcS4vhq8NLvsoaTWJEnzoo/pavplNxpF75FXrZWGjkQYBqzY+gEPuttAfCSEfFuiWrlCYRvfRl/A+l6cNG1OliXzjOiRznuuBpmFW1qEdiacnvw3VQbtBiB9HOfPfZWBq3adzy+01QIK/jIVZuyiYGZ2FtPromQoOAi1lzZaoZvD3OXJ8jFfvWCne1I3VmN2a+IoA==
Received: from SJ0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:a03:333::22)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.17; Mon, 10 Feb
 2025 09:34:11 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::9) by SJ0PR03CA0107.outlook.office365.com
 (2603:10b6:a03:333::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 09:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:34:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 01:33:57 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 01:33:54 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v5 11/16] qsfp: Enable JSON output support for SFF8636 modules
Date: Mon, 10 Feb 2025 11:33:11 +0200
Message-ID: <20250210093316.1580715-12-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6d4b04-a908-480b-b76e-08dd49b61327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GzKSpzKVe4/9tKDwEhtVX4cZbLL94UvQ+77kl7frq3zPaaCwL4mJ3FGx2H0k?=
 =?us-ascii?Q?OKa5dt/XbYdJJo/S1G3dpTvYUqXmtxfm0pZqC/E+HlvoHJGiVToKrfKU6TAD?=
 =?us-ascii?Q?St//KZiPS31BTuJRlllpRQNdSEQLsInb2yBG854eR01PFJgDTjGbAirQboeD?=
 =?us-ascii?Q?y7J6JL8Dj+imYi+/Krf9MwKZTZgcex9a98mic3YumqOL8EbFTWH+oZicGSlQ?=
 =?us-ascii?Q?yNUFz48mBGD9Q4b6+Z4sqJGW7BsVIN5eAe3sGZjjvWZ0xCDc+HSLUTzZamzB?=
 =?us-ascii?Q?rYeKnGWKud2eltmqAEsDe3XOSjjEr85CzGJqyuWD/f67j9bS/6Nexd5VNWr8?=
 =?us-ascii?Q?n4zRuqpp9NtK0J9mL+4YJFd+vkBpJxaGI+pNoI1AeFNEGjaAIewUTb7Z6apW?=
 =?us-ascii?Q?jYf3oWz8NVcSu31kvF14vSgR2cf5oCHJcVsShj3dRQqRSYam0D68Np9XafsW?=
 =?us-ascii?Q?X6N+6sM6a8+/WcFbdkA/WgUpU0tNvXiEajG4+pQBmNNYcMSSUmp1BWkN8XV/?=
 =?us-ascii?Q?xW35PHwRjRvrvkejzerpjeolRU530YC+xyy9vPD+Uj99DePLoNl2L3i8di0X?=
 =?us-ascii?Q?Q57eYnVSwtJO/ToeFIgzzUMX0k8vwlcMU/OBFr3oTumkKOw2J8U3uZtJcPcP?=
 =?us-ascii?Q?Kyg6LslB7MMxPAuy2W4wavV3Z5KS8GUqLhU83eDBaakj86YSo5pZK+2pJokp?=
 =?us-ascii?Q?joZJh4jy9vxOLeUu6afyQIMbCaN5VEOfxMWlHN2KoWjh80S0yYGFlzzRqC8t?=
 =?us-ascii?Q?Hn1HMQBYVE5ptUElML/413kodkD4We+O9KfuPx2ukLbl8lnpco49xEAoVKA8?=
 =?us-ascii?Q?qHxKwzLq7qhPsdCY4FaNUXVATRr3UPWFPUNwYCdGSsDeRda6CtvmPu52I8T8?=
 =?us-ascii?Q?iHTmH6cxNif0OdcViRzTM9yhfkfcaP5SF3y8qP9kuLScfYKal36qWdObVLOr?=
 =?us-ascii?Q?hzmUzFx8zmIyQaQCYR4TN043esnP+qySgHcjYkhjZnkJXgb4W8r2xYOQ6mHk?=
 =?us-ascii?Q?SXQrxlKPfXMYBBTNhUDsu10d2P9LDQC+PkwQ527GjxRFF7cU4sLWx4WFPNVj?=
 =?us-ascii?Q?vRiH1qj9L2b5mNXTcK5jzIeofO/DQG6WNomzj4gOOfkOGKiqIMgvKXCXCvtD?=
 =?us-ascii?Q?rr1afqTQzktvwZu7HagEhTu+DmzgG4qDBo9gySNRsAkKNgs847nrnX5qBPWo?=
 =?us-ascii?Q?vfa4lN5ovYV/h5zNK8YiHlxMzVrUqKJKhSYkJWc55ZVRJYED4WbqunA+Vlbg?=
 =?us-ascii?Q?JiwejH8LyalvXZWyLmzRhA0o0vGQNw23DQDICqK2iNzB3IICAOASCNOyD6e9?=
 =?us-ascii?Q?jNJHEAO6vkSEnCExHqXiUrU7BwvbLXUwDKYDWCsGjRTAmPaVO3glkESTIVAG?=
 =?us-ascii?Q?uJQS7jy/hVDkJI53N3lak29CiP04DxaZRj6ADXNvV4jizn0el58VjGbOF1bU?=
 =?us-ascii?Q?CZgYKrFFPil/Qu4J9aiMAktK3vzdgdSHEXiCB0RmSPw+Ar0fIvPHQJOwqZM3?=
 =?us-ascii?Q?TBn5awwETx2aVOM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:34:11.0411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6d4b04-a908-480b-b76e-08dd49b61327
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101

A sample output:

$ ethtool --json -m swp13
[ {
        "identifier": 17,
        "identifier_description": "QSFP28",
        "extended_identifier": {
            "value": 207,
            "description": [ "3.5W max. Power consumption","CDR present
in TX, CDR present in RX","5.0W max. Power consumption, High Power Class
(> 3.5 W) enabled" ]
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
Acked-by: Jakub Kicinski <kuba@kernel.org>
---

Notes:
    v5:
    	* Edit commit message.
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


