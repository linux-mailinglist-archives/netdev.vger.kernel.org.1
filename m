Return-Path: <netdev+bounces-163116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF730A29576
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638EA1887E8F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC3319884C;
	Wed,  5 Feb 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X23PqSh4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCAC1DCB0E
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770958; cv=fail; b=Fiss7L9H839d7TN6QenzVnNEpA+tk1YRC9IILIBN5AcRyJBnOFsDnrZHB4zlYSJkuh+NdEpGm66woISy3zAguKiqS06ceqEygVIXrymrRxq8+nQbuXehBnOOzrg4HEimBh1rUBrt0VkU/6E0bN9uajQZrR4T3IYvfUXLJuklgEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770958; c=relaxed/simple;
	bh=39aB2TOQKfY7Rx/mxsvpVXnx/inCi9Xz/0jWK81uqc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tM8UZEQr0eLx9sWIx9uY3hScj6bfOhSB9wcTgDCpCEQy4IHiT2fl/BaY/3yGOBXyvzIM0VKoNd2mUVypRKBVVxqQ2MSH3m9OctrwkcmiHPNR1kvGNvCYUFCzGfWkWG3PAhmVj00utcdNWlBB3J4Edd8SWbA4Pl1J2ZszKiCFvHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X23PqSh4; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YA67dq4e7SFMJdfpRJ3gQYwxTKxu+AFX+YZoFR+hW4oLBc+ouz3G8VOsmf0L8i5QCOfUDz9FDRm3AjjaiEFXkX2yzrYU/lmQmqLgQQLJCx2RjKiHobXlvK2cRyGNbE2Vc5VNlgw7PF4JHoFfmvLvfPZpbEpGuPFVOSwfBnx5oUzAJniP8733uOudE8UJYcWjbaN4rBZZ754qjLEXUcPotzwHfLSXH3ghEHNElWD9HsgtZahPToQWtm0BH4sDwmlVfCfGvNJALYUkTxSabZdtpwwD39AEtMZdu36n4pO/QOFBeoFWosaxYv4TAWtbwLNKnlA5vCOt1dVpxSN77KGRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmI623Fq+zNnzpiWLb/3AhLk9N0T+63PY+4AlO9w/kc=;
 b=OiBLAz995mf6argX1ySnQyB7GZNidMBVoc16YhzuxwMK13d99tLtgkxXQn/cRgzky5jR2Ns4eerblJNv7+gLI/uxqFfftExV1XDPjoKcZ1J1keKPRVdcLgrain+fttdoG4VEIuQQPQ+q53hBZVXmLFEo5+WnFUdCs5nKFFfSnHdETZtanh2AkzqqF0Oz2EslCgIZHpWUNOuUxucRmqyWbfNDt4M17rV9AjVlv2o+MdnH7lXgS3+Mv1IeFAMN69ZmoQAl+pr9V3JtXzZuGMKtokkzVf6Pf2CY2eR7xeKYYq6Dq73be66iQa5y6DNp/0Xn/veXeYkF2CpkE8zsKTZJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmI623Fq+zNnzpiWLb/3AhLk9N0T+63PY+4AlO9w/kc=;
 b=X23PqSh4v9nmEkS2gg9IjAoNPcV4VGM+v/IDay0Vs5sEz3BX5WDzXYem3VMEIXkm1o5Gm8VhOUQzSN1hD8uV4aHIIldaqySypi5GTaNZAV5lcdSdq5/5MA4eLZ90DmftPWT/aEEZLcdmno81ZP/+8d77/BlJXkkvbuv2lZtz3nA6bfsEsKYjaLnsIGyo22U2s1dSCcGvT2GwbpMA8nH1QVr734y2MisW6hBUZuFQLeZHXarZ0QkA3BfT30yS7/YsA0O/FI+JoziQyReNXsqBR4lTMK1hRUpCW6nHufiPDN8+cvmZAbASNn2NoxIYiyXZ0PUbtN7MlVzMSl3GkKNkZA==
Received: from BN9PR03CA0895.namprd03.prod.outlook.com (2603:10b6:408:13c::30)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Wed, 5 Feb
 2025 15:55:52 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::68) by BN9PR03CA0895.outlook.office365.com
 (2603:10b6:408:13c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Wed,
 5 Feb 2025 15:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:55:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 07:55:31 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Feb 2025 07:55:28 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v4 15/16] module_info: Add a new JSON file for units documentation
Date: Wed, 5 Feb 2025 17:54:35 +0200
Message-ID: <20250205155436.1276904-16-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: f71d25c5-ac4b-4901-2061-08dd45fd911c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pk8xGWAg6bt2XL5uuDMfKsASjFC5/taMfCB55HBMvDHKosMA+iRsVSQk3puS?=
 =?us-ascii?Q?XXm2i8yVfRB+jjybW08/aFf65CM5JW3pumjyY3nbDOR3HgPn5oNYesE+/Jpi?=
 =?us-ascii?Q?3ZXVGF4hJKDDex6iWD0PTg5SuWULJf533aWLVqyxpitMZ4HjeH5Al2gnuZBh?=
 =?us-ascii?Q?M0IMRqXSWrxLl7VqLGqhFUXsmu/9Y8MWEfGGb7GfgzGFld3QoMzAQFFweykX?=
 =?us-ascii?Q?/Jtfh/ciGe7B7KZJ0E34m1IR9AsTlt2yhE90NoKR83DN0l2/g9326/F72ZRd?=
 =?us-ascii?Q?CRP2AoC1gHFIDYqUxqIDeh4rP6+cRvbx/thOcIioP7ks2kWTMyF08fFRyLM/?=
 =?us-ascii?Q?waPgJDu5YafUIEZA3BPjO1nhHOmUrS85aaCG9if8U/V/hh5RSwAtIx0uXRgY?=
 =?us-ascii?Q?FiVhDtirGQw1Gaat1cc9VUsEbJsV69+blVwVaI1l44dtDzBR7h/+nfyD/+r5?=
 =?us-ascii?Q?EWJvMKq6igfqofxHLFZDgUoEo/NwXC9zH2SseJKj4ApOjxUO5712tWYoAvqQ?=
 =?us-ascii?Q?F1q7M7yH7mMYNXDr/nTosrZKZBpfvKQyF1FOyORE5FmvOYaVzGY2BH9l4CiV?=
 =?us-ascii?Q?sMWyKqCi/kICiTag/sPaMZULHZcRRR26UVVe7PT3h7gvU/mwMSG3DBgrM0MS?=
 =?us-ascii?Q?O0z0+ZFOk9EtCfnQcCiQ150ZySEzUuYLdDtpMKMntBVrDZ8yK0xWw9o/2zpR?=
 =?us-ascii?Q?Qf/qeqkvSeV+6LbONuo0N/vHs92QmlbobPYw5RQutJCda/Ta15lcs/d1pglG?=
 =?us-ascii?Q?8HtudW2yp3TpvD8rS37f95xBRUD3GioIGyBWTTQdDgijVKqENaPKOu1QijpC?=
 =?us-ascii?Q?aFOL+dnWwixUjVXebzFQPKiAYXrGiseERIRsJzDlU/m6+f8L/HGSILAq4LsE?=
 =?us-ascii?Q?jO4Ibc4hhKa/7yL+A+6EnJh6T5vvDIKr5I4u0TT+SK3JafeYGG+rOkLS1YJ2?=
 =?us-ascii?Q?dZCMA+RKVIZYJr5lp40iylKKjlme8TdEZQpLcUqTmiyhyp4W9d/BQF7a5nNl?=
 =?us-ascii?Q?Gi2tcqir7uijm5tFlKObsAJj55FBZxBfklHQQE+dP1vANcyHXvthLa2rFsqK?=
 =?us-ascii?Q?oUnwN21WKACLDg33MUWw7KccuxoqQVg2TGhV9v4VDoVx25l5NZftOYIp0Ser?=
 =?us-ascii?Q?Cu/3qZIRaOzlyS07LJJHagO4VFgItSZhZdxMKq71PN2bWsk9h62rqjta0Kss?=
 =?us-ascii?Q?FtweL6ZMhXODUoY3gA2C46YA+/8fNWGYueJtfjmEouN0HGrQ61HrAIjzGvUi?=
 =?us-ascii?Q?3BdjzmlUWTkT2kNGhtqiLjPVqyvLPVx1/Ddigkfq9DNUjS9s9y7Fpl/4THEQ?=
 =?us-ascii?Q?uqygxRNZiniGm40cgECpb9QrgVTRKFrpcrm/XMtghPQ59v6mS8nlioQEqceA?=
 =?us-ascii?Q?0GBRjv/Vcj6PlH8BS6KclKTmTHLQbn8gB9xvQHWaXxtiNALMdm09g8Jcr9I+?=
 =?us-ascii?Q?qEuIRg4oEOxReObfg3WrrwbbzKomjMrW6Bs9qi7XPQ/PWI4AYTLtVR0jTSz1?=
 =?us-ascii?Q?uzoZmZqiq3mmEU8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:55:51.7560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f71d25c5-ac4b-4901-2061-08dd45fd911c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181

The JSON output dump will not contain explicit unit indicators in the
output fields.

Instead, document those units in a separate schema JSON file so a JSON consumer
will be able to track this information.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v3:
    	* New patch.

 module_info.json | 191 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 191 insertions(+)
 create mode 100644 module_info.json

diff --git a/module_info.json b/module_info.json
new file mode 100644
index 0000000..1ef214b
--- /dev/null
+++ b/module_info.json
@@ -0,0 +1,191 @@
+{
+	"$schema": "https://json-schema.org/draft/2020-12/schema",
+	"title": "Ethtool module-info JSON Output",
+	"description": "Units documentation for various fields in the output.",
+	"type": "array",
+	"items": {
+		"type": "object",
+		"properties": {
+			"br_nominal": {
+				"type": "integer",
+				"description": "Unit: Mbps"
+			},
+			"length_(smf)": {
+				"type": "integer",
+				"description": "Unit: km"
+			},
+			"length_(om5)": {
+				"type": "integer",
+				"description": "Unit: m"
+			},
+			"length_(om4)": {
+				"type": "integer",
+				"description": "Unit: m"
+			},
+			"length_(om3)": {
+				"type": "integer",
+				"description": "Unit: m"
+			},
+			"length_(om2)": {
+				"type": "integer",
+				"description": "Unit: m"
+			},
+			"length_(om1)": {
+				"type": "integer",
+				"description": "Unit: m"
+			},
+			"length_(copper_or_active_cable)":
+			{
+				"type": "integer",
+				"description": "Unit: m"
+			},
+			"laser_wavelength": {
+				"type": "integer",
+				"description": "Unit: nm"
+			},
+			"laser_wavelength_tolerance": {
+				"type": "integer",
+				"description": "Unit: nm"
+			},
+			"module_temperature": {
+				"type": "number",
+				"description": "Unit: degrees C"
+			},
+			"module_voltage": {
+				"type": "number",
+				"description": "Unit: V"
+			},
+			"laser_tx_bias_current": {
+				"type": "array",
+				"items": {
+					"type": "number"
+				},
+				"description": "Unit: mA"
+			},
+			"transmit_avg_optical_power": {
+				"type": "array",
+				"items": {
+					"type": "number"
+				},
+				"description": "Unit: mW"
+			},
+			"rx_power": {
+				"type": "object",
+				"properties": {
+					"values": {
+						"type": "array",
+						"items": {
+							"type": "number"
+						},
+						"description": "Unit: mW"
+					}
+				}
+			},
+			"laser_bias_current": {
+				"type": "object",
+				"properties": {
+					"high_alarm_threshold": {
+						"type": "number",
+						"description": "Unit: mA"
+					},
+					"low_alarm_threshold": {
+						"type": "number",
+						"description": "Unit: mA"
+					},
+					"high_warning_threshold": {
+						"type": "number",
+						"description": "Unit: mA"
+					},
+					"low_warning_threshold": {
+						"type": "number",
+						"description": "Unit: mA"
+					}
+				}
+			},
+			"laser_output_power": {
+				"type": "object",
+				"properties": {
+					"high_alarm_threshold": {
+						"type": "number",
+						"description": "Unit: mW"
+					},
+					"low_alarm_threshold": {
+						"type": "number",
+						"description": "Unit: mW"
+					},
+					"high_warning_threshold": {
+						"type": "number",
+						"description": "Unit: mW"
+					},
+					"low_warning_threshold": {
+						"type": "number",
+						"description": "Unit: mW"
+					}
+				}
+			},
+			"module_temperature": {
+				"type": "object",
+				"properties": {
+					"high_alarm_threshold": {
+						"type": "number",
+						"description": "Unit: degrees C"
+					},
+					"low_alarm_threshold": {
+						"type": "number",
+						"description": "Unit: degrees C"
+					},
+					"high_warning_threshold": {
+						"type": "number",
+						"description": "Unit: degrees C"
+					},
+					"low_warning_threshold": {
+						"type": "number",
+						"description": "Unit: degrees C"
+					}
+				}
+			},
+			"module_voltage": {
+				"type": "object",
+				"properties": {
+					"high_alarm_threshold": {
+						"type": "number",
+						"description": "Unit: V"
+					},
+					"low_alarm_threshold": {
+						"type": "number",
+						"description": "Unit: V"
+					},
+					"high_warning_threshold": {
+						"type": "number",
+						"description": "Unit: V"
+					},
+					"low_warning_threshold": {
+						"type": "number",
+						"description": "Unit: V"
+					}
+				}
+			},
+			"laser_rx_power": {
+				"type": "object",
+				"properties": {
+					"high_alarm_threshold": {
+						"type": "number",
+						"description": "Unit: mW"
+					},
+					"low_alarm_threshold": {
+						"type": "number",
+						"description": "Unit: mW"
+					},
+					"high_warning_threshold": {
+						"type": "number",
+						"description": "Unit: mW"
+					},
+					"low_warning_threshold": {
+						"type": "number",
+						"description": "Unit: mW"
+					}
+				}
+			}
+		}
+	}
+}
-- 
2.47.0


