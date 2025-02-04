Return-Path: <netdev+bounces-162557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E04FA273A8
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DCB87A1F30
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3B9216E33;
	Tue,  4 Feb 2025 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XZkh+qmw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D944216E2C
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676463; cv=fail; b=ZL5llvoq0G25NclHZjbpAKd/3sDV8zu/OITcQyV0NKo3LpjHTwxsK9czbFWfWjsjXRUerNp3bocg4pKuZlgkwufo/CmWtfQZdFn8NW7FTIirGR5KDFiYrl7r0PZxgOUap+1NXGeZQGSNexbaFGMyfjI78hsYtliz+Ul6/mJjcdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676463; c=relaxed/simple;
	bh=e9m6BNPmmRztnDMNEsnNW0+mQJupAn6Mmu3cQkBG7nc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLlMkpCWxPDyGSDvUqbEs1rJFL9P81FATfEr4n+Dtg6Yx5ULp0ZFv+fat2SvduZrjWyheM3VkWC7u+LMCxN5dwJYWGS95pIMoJNse2A0qqlE1r/vuT6tpcMmMHYyhXR8Y0v4cqByWZJIzyTBYyduVq9zIdCk+HgH6V9TOPqG9co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XZkh+qmw; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrdDwGi42/fYGiYY3vbeXsJjG/NLO7VLNoryVduCL8RyO6Ct4vhdFr1PKI+2XhmYnHKf0Xmptg92Gd0pv4xweeTWZArWdYRsR5UbgszRWItguW4so8phEVEqbLFWkLn4aW8EZZmg3lrGI1BQp49yy+GNP7rvML8mRufe/qZAqp6jaXZGZkQf++YDvRZ2SqRZTsXVeF/u5M/ogt3bXkQ0Lk4DRcxVwOoeb2aJQpDmzsm11JoldF8EgkMdVwFOHGTN4uEABMAtaW+u7jvoX8r41PHjbHxOTGZ6Ow4xmD6hEmw4tREMZWauIaQOHNnr+DSlj9B+tjGD7YFSkxAteJGZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzibSuJlm61xq+P8NEB/aSrwul22Sf3i3RVOztrmbmY=;
 b=LfRxkYQx6UHxDA9QT3I2v62drO+lpAI1irjpaewKVWt8WsREoj2R89/eGLVdfKvGba59LVeYEineaj+CxHM8kizeQFfozEIpgC4qIepVemmemm00muHY1ZsaNEDmuOf5PpORIzJWYucV52PsI5Ey4MFOyoZTWzBIq54xZrkVdnk27WCuqkoSaETk3JSbgKDlP9/v767GdKiubHU8cLPB8gLuG13/5omRhCyslN1DP56Fr/aT+Xt6BIabhwy/9LJbe4+SZkkBsCMh9RxZTkWk1wIMgcQKeZNDRTb43FiznGBZKuCAgsdm10FVOC9vP7yRTTLVj7fE8Yq8MM/oXtd+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzibSuJlm61xq+P8NEB/aSrwul22Sf3i3RVOztrmbmY=;
 b=XZkh+qmwAb/4Dalp9/LS/cn44dmN+MVWFHWbY8mDMXNEY62BugAaku8bLzX3qW5Zr9SAxemYq1Qq32pFbCiLNORCINireybpAMBXVG2rt1EhD8gFO4dooGw8UZSFkb/nCJhIiHBdO4LbXPAyqu/6mrxKNkwApKwUuWTZyNuiAv7fsF+VN57UyCllKcKHG7zsrQlDYbxEEPIUssU8Ua+G++GkfM2EtoIvQdJX0N/uqRDTGZEU3ZuhfzYT6csSE3k2B4yQvApMCjUyvZ7SJJdpTx3OmUlKSefYMjvutJeZr+eMHuO3AoUhMLpr4oYKfmfAaZM5oXq2xqzgFoOnhbdq8Q==
Received: from SA1P222CA0057.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::6)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 13:40:55 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::6) by SA1P222CA0057.outlook.office365.com
 (2603:10b6:806:2c1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Tue,
 4 Feb 2025 13:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 13:40:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 05:40:38 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 05:40:36 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 11/16] qsfp: Enable JSON output support for SFF8636 modules
Date: Tue, 4 Feb 2025 15:39:52 +0200
Message-ID: <20250204133957.1140677-12-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 488d01da-31ea-4286-c12a-08dd45218be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i7ZGMKpAcLkWXxuGujQ8Zisq5FYFAFmdc3Jegf3/VezMnIUxDFuui6LnvSE9?=
 =?us-ascii?Q?/V/lukhZWRam51y9K/tiL/Lcaa0p4g50jkia9jXWvb4HvcGpmFT2GUqFQCvO?=
 =?us-ascii?Q?3bYAfbpWj+NxsQ+G3MnmoGwhl7zpk+g6PVSbxV6MWMbwOZbsM62p+xWhcjBM?=
 =?us-ascii?Q?4iU8JGS9uvsQ+eXfwzYfi/5OnDZVUw+DqmvlgGvIVac9UG7Dso59tJp7/a8B?=
 =?us-ascii?Q?0heCMzl0s4/8pMFOYW8fs8BeR9WzRoa1Y8tw9/ZOWAw7ZUETmtbGvjt5MEe/?=
 =?us-ascii?Q?ez2YjtT6G0AC/cqVGYOC7CQ3Inp+pg7Tijn6YADHfFb7xS1T5zOrRXXcp9mC?=
 =?us-ascii?Q?vMyGBUNWzpO572ADi5OGBUmzb01fG0mk2mSgbqddzUcqmdnxy5bDTXa32WWE?=
 =?us-ascii?Q?OaK13Y+sZS4Y1Q5PjnYRA83/DEMuBsYItyZKsSvZlXJ35FdkcDigCQkquH+I?=
 =?us-ascii?Q?lK8l1n9UdrvDBFRKjuoX3GRCI0q/WkixKMiK3tJG0puYyrn1S0fMrVX/dcuX?=
 =?us-ascii?Q?aCrHm/f3v48sOuPzwNffupPi3jxWuUKU/7Pm6HaiQ4hh6Oymk7jSyEQzs7YH?=
 =?us-ascii?Q?xNBUebSIWBf4bwWK9mgx0yj7BidagWkWiBh4TX/9N0QSry35boq8XaOqUV+A?=
 =?us-ascii?Q?xIZB3AK1Xf4VqpiTmJWBfo+nVr5HKIP6305WpeIB1MqyGrjXf4BPRUzhAQkz?=
 =?us-ascii?Q?YGxerq/Iw7EBaBSmGW4Rr/nGhEwYo+6rGvnOnkphIFeTQH+7ZbkxqaDPn/kA?=
 =?us-ascii?Q?AQZs6f/NgbJxx1jxZgB6B/vWMfYeDNWbeqRvW0eJOrtJfW3NQLXM8p+JoHcQ?=
 =?us-ascii?Q?bqiur0Jfw5PwV0Jn2AcJSQaBKccQXlZJeuogtgGuhYwdCHgb6sYa8wwJi5gy?=
 =?us-ascii?Q?10b+5SS6ynhDVaxf1nVK/zr4gq3XmXWlywVe9zfQ/FcfkV83rudP892OPgAM?=
 =?us-ascii?Q?P2GOe8USKt3mPeaB5iZFUVwXy6HDzACcWi/gbu8IYUfTc0vCajkl+N7rp1z6?=
 =?us-ascii?Q?RAZTTCNvqbqIImOYYwobSh04nveIpZn/bSHzf/qsdfN2XhhdRFxzh4DNOSD4?=
 =?us-ascii?Q?gqRVdDD/8gvYojYTGGJ9EyBLpgYUtLwQCyx0giV8qMAqy1Lg3k+goBly/DIp?=
 =?us-ascii?Q?HOX1mnBO9ri9HAs105ryYzqGSw9urne5Ro1lLr7l+BB5eHoZxbLkBiZowl/O?=
 =?us-ascii?Q?XUjLGXd00sfNQ9eSF2Ozks2H4Ual7rRgW7S6AXH2vkDXoM8ZCZrruvcsUpkD?=
 =?us-ascii?Q?W/0yiiuO5+Qs+Ke7GZFVWNgSyNmCnCnDmvh08P+BvKKjN4OZ2YEHLTSuvsb0?=
 =?us-ascii?Q?U8OsWgSb1hYOvoiVGH6AGiDRfuh1lZuVQ8nPWZ8hzFYEeGI0dcOMUQ+y7T+u?=
 =?us-ascii?Q?1CcFA0KJmvlZUtu/iClMY0ScmfhnhzT3GkyDISL+3hdnCi/bwkT2vNpxJYkj?=
 =?us-ascii?Q?8lPF/RIGoNsay3Vw2Co6DF+y1PdxPl1QVw/gUFzToUzeWHc4DTHmyDqrjg4+?=
 =?us-ascii?Q?5gcJA5rLYwfFJWY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:40:53.8752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 488d01da-31ea-4286-c12a-08dd45218be8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083

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
---

Notes:
    v3:
    	* Reword commit message.

 qsfp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qsfp.c b/qsfp.c
index 43a26cc..66f59bb 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -1081,10 +1081,16 @@ int sff8636_show_all_nl(struct cmd_context *ctx)
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


