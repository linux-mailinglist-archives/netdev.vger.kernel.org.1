Return-Path: <netdev+bounces-160975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDFCA1C79C
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671171886127
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDD0156C74;
	Sun, 26 Jan 2025 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q5eQovSU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B220715854A
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737892654; cv=fail; b=KOozVsQU45Di5yIkmWEtPaFLDAhySzUn35+T4Prj5aNHEWJPeAVourY8KtgnYNNbUqbx/sZDs5f9t++33lYO8UrbZgzHrQ2JgYuUixu8Hu/ta1CvtqZk7qfrb1EKMscRIiAJSzBGLukls9UMXzL224rSwLXycjfnIo92BTxGoTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737892654; c=relaxed/simple;
	bh=VU9yMe2SnOtyfKDzjUpoUHdPcRi9ou7SAgi5WbPAuXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwifrxt20XnOS9/BN+Dji3AqoPJP4+hXmcUVgaMtpxkQYbgQD12CAFOTiVHQ0NtBMFabmXI43CTdLRsw1rG5badDuqv+cFwZ5YSUebDPoMlNcFND9QYhD8gK8JYSPW61/eCxXmOe++UpDhFyoOUWUJLskoLbB9pdLSxUGm7UBuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q5eQovSU; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuyt7CNWawHy8Sds/5E2ZA5mWi2cHztB7GnZgutid//Pt5FIBShNIOZUHLvHpGGIBAsfWKi6M+0cl5Kxa1t/9RjLtWHukKlLGKvYXi/OS65KPHIwtW7XNkHIPgq1aclqLWSK7q15lurYQBkM7cq422CTto/xk6zeOgh//E9Ne6NPzMzmxpTqIlM8tlL+3AM3wbfcXa8TE6uR7Vsj0X2YafZL4+xpOVETTczU4S8InX2Sx9ugEf3Sg8h92/qTS1T1hrIzH7hbu7flMoa+DKQ6dPDkaFQhgH/A86SCzU8YUDmSi13fIDwBn6osB8MItcZ6LMexzfOPOATwAIDU2mbHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdAlAIaAPYjH/FT30sZFnC9O3BIcem9L2U78exkc1XI=;
 b=i62tU+gLOu3AIt0OJhQdbGnAjCyhdSDe6e3NWM9X+Q0yMOsk46uxoYgKX1fQOBJPzomNXBbKyQvtCJ4T+OH9ZFQB6baw1cU3NFONefN4+4yn2R0JU+q9k8EohZzWfNt1VZLvcG1GFGpi/uYn3d6/Uv3dXaD9Ed7haeWe6NXxNETsYOgUUq2FW76oXUeAm8dGMrmUBKtueplhA3kBGahHXGA6MjDkivARChes++6w1dixdaqJUa37lw1lkT3skmEnucmY2imi35Tjv5JGiy158c7dkl3Ec4mAr3qcD5QA634/xnw0/xOB9K6nFeWnvnBO3AC/N4zJDRzoYK0NcL+lmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdAlAIaAPYjH/FT30sZFnC9O3BIcem9L2U78exkc1XI=;
 b=Q5eQovSUOr/1/SFMS8bQpPW6S0oBKyNw+zLgoSuY9eF5wjb2No9FA+0AcbK7CBxpDoeMTvDdvyaQwYMEPXkgSUOy29ew7t+4sbLbyIjaX+P9AvpNK9WkNTdlcejVb9jajc305nJ7iOZDAwTY1x945v8kSZE6pvKiS/2ng5C8XR2WAsS41/CA5b94tIM6FFX8w16UiIgGO4ahdLu193k8X84xuYl8kOpCdioSDsxEvKsutqBWj74gGbPMN7aEDk0RkiaYMYRQnzOpAfbKM/HpL/6Zv7VXV0j8/ylWQkgN3vWkDt+8qiLDrcDXp//fQCHqYx4KLBrTeGsjtIdBwj7t4g==
Received: from CY5PR15CA0121.namprd15.prod.outlook.com (2603:10b6:930:68::12)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sun, 26 Jan
 2025 11:57:27 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::ec) by CY5PR15CA0121.outlook.office365.com
 (2603:10b6:930:68::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Sun,
 26 Jan 2025 11:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 11:57:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 Jan
 2025 03:57:14 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 26 Jan 2025 03:57:12 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 10/14] qsfp: Enable JSON output support for SFF8636 modules
Date: Sun, 26 Jan 2025 13:56:31 +0200
Message-ID: <20250126115635.801935-11-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfe1a12-656f-402b-1d13-08dd3e009af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b10TZUcNhTcoDZjBqe4f+fhEEysKciA56duOyn8MBgs8IFEZ9nuYnfyWt0Ox?=
 =?us-ascii?Q?wnUFVqNJDQkqGro4ZSj7hAJxvz/GHWvOMZ+zu7eI7MRlMWHEwrob67xyTLjn?=
 =?us-ascii?Q?JVqsZbcbAwlFGkHmdjWXJo5WLUd82KCqydkXloOsXbaX62jR42MjPFb5tsLD?=
 =?us-ascii?Q?CWKW/X77pt1xtpQ6WstpqwXeXUSHXmqBcbPo3sPx7D8tQWtZIgzyZ8eKfWfZ?=
 =?us-ascii?Q?X0I84XDCF7Ge4nUMa8La9AAy+RqgKsDeppWIKb4Ie98Z95hMtd+Ln9acDtzC?=
 =?us-ascii?Q?xwIV9qRzT429tGV6tvid7YkWED5pXaOrT1dpWZFxAq+yOJObokhpYMRYEWLd?=
 =?us-ascii?Q?e9v4FnAsqibgImJPqNKayyuWU/wYsDQ3Xg12xWK6pvRviCuxmissk2WDEckO?=
 =?us-ascii?Q?sYvUrqKoNcfp0oKVFKlw0qko9wk+wmW9m0Qs/Q7g0MPCIdgdIPFs9ZqQw50P?=
 =?us-ascii?Q?zu6+3qw53pWf4zXzL9WwORDqrmxS3ev1i3pfZSd2WGPWdNL+eXJlHW5gLpyg?=
 =?us-ascii?Q?KVzxLtce9KoxRmSf+riY2m0bZcwPYForViOtHkYqG2MwJi5qidV+Wsor1ZnF?=
 =?us-ascii?Q?sHo4csPuTR94yworJaPFubuDKvrYlyaxXX4Mn3flU+dkZau+b22TnZaeGl62?=
 =?us-ascii?Q?X5qBzt2s/tw16LtPbG3I5oNMU7q+GRQ1ubqzoIO1Vor8e9IdsSvX7/iEUHpu?=
 =?us-ascii?Q?D8xdnFf4afFju0UsnqN6QmpqmPlf1zwtJtgGvD0deGPKLbC+c+XEZsYR2poF?=
 =?us-ascii?Q?y+sjqtUM2WnE0jhh04MSQ1mElBGDplgWoS4G2Kwy1dGjHOHOWli5fV3N8cQN?=
 =?us-ascii?Q?EypFiAW8czbe4ULCq7E0J3PUpI9TuHlXj+TP5kRYFdcDlrUy3cnd9+L1jC3W?=
 =?us-ascii?Q?P07ejqgGVqHsfwG+AN/TNudG0iuHKEL6g3r7QvxgqOlr/JV14UydaxTN3D/o?=
 =?us-ascii?Q?NObTfgyLwkpbH9aSwIswfOnLhbAy2+Lg1KALB2aPv7IUKe0a+rvK12NhEIw3?=
 =?us-ascii?Q?aLASXY3einv8pg6arWzCglsa0ke2TNRDmK6F1efZhUTbpVsYCw3QfgtJ/C3B?=
 =?us-ascii?Q?F1XMCtsq42Uag9qg6ptWYsrvYzNmYa7UsBUpt69yl3qelxH5co1jhRZ5JPk3?=
 =?us-ascii?Q?47ycFJ/JVuujjxmpHntvO5PrJbn+zOaRJQD3i6q3Ev6vKwvH2Ss3WAsjl3iG?=
 =?us-ascii?Q?C+U0WZR9atZSxc7phQWUHzYgjShI8Qqwbp+pg6u3Ld4lQfusIaX1VzCHeAnx?=
 =?us-ascii?Q?MynawqAnZWlxenCbF9AxcVCjJjKN1ILdmPKrZLXHLYTjSyatNrbQGGZz/B0b?=
 =?us-ascii?Q?1IEpGi+8GFOAADCQYTM6D25PCYybWN2WjbBQMnI+gXVPJ6fOXoLc03bYcUVG?=
 =?us-ascii?Q?8kE74pXyqFx2D4+UnCxBuNyTwVrvVIUYELnO56njlMH87Bq1bcH09Q0K1788?=
 =?us-ascii?Q?pK9q7sONdRO3z61QAqPjTL76ZK8ZVwJmoqt5YjLdbMeLJAUvJdYVHMeEsU9k?=
 =?us-ascii?Q?rLSNfZkwmrNGmDM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 11:57:27.5421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfe1a12-656f-402b-1d13-08dd3e009af0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574

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
index d835067..6f95377 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -1096,10 +1096,16 @@ int sff8636_show_all_nl(struct cmd_context *ctx)
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


