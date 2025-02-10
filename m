Return-Path: <netdev+bounces-164626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B316BA2E7E4
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC703A83AD
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDED1C54BE;
	Mon, 10 Feb 2025 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n0GgOGbh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF11C54B3
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180066; cv=fail; b=kyJB8HzW0n3a2Qckq2Ha7F+7lbd8Tp2e9kPe/44VXExGp3LyuRZomGhVslpWbRWRnJlfXKQMpEHFzE5KWt2PO7cOw6u9lTgLyjKqaKaZCBiyCNxSeOjx6dAEIubITcSDZ68npF8vUggn2MODgsPy7jksDB87LcYDNMqB2UZXacI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180066; c=relaxed/simple;
	bh=AkH6TmJ3emSw6jyowffGixzyn+bMAYITS6kmKnzHZPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxiHm+NTHW+We4rCx51XqNOrqbBCBMcJWG81SUyaA5i0nzUGqMshzrQRq12krw/xK42FSMPUliRYZrzZZNINRkgPYSiwbnC7c7DaAPdTtXii6tdXPAwyGgwOmL11/OwEfs1+FN6LyaVcsoz+bwZWtUDUCeSyv0j5N5BYjg6C/Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n0GgOGbh; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvhlpJbeQTgKVDpkeNtmj9F3Dp4+XC7lgWbT7JmecQ5nv3tuFMWci9GxgjRO9iRJW74yvRL/ADo/lATxPVe2Inp6OLznK0YAQjqj+HnCf/fNRjZwWMObLbrlJDVyud4gUlUJ/LlN4oEdOnmN6saieC0T2Go0HX1asAxrtycHcefUON9my2DHn3/QH7Q5irAANHxk19Wt5VCZjBau47I+hF5gPneK6HS0HHorvuYIuygerVWOmpJeh+7tIg6dWrJr8gEHCdS2VYKgL3l4iEPSC8GUAiJ9bTv+j2qlMICs6Band86kwmpSGKxX2PHPaywg9La+/tPugg+FCUItXLkWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL64CTZCDrsDnY5z6g6d/4EEHxpSa6JrmiHblBn4W2M=;
 b=tVNNY5Pw2kx9zyVUnEd7gCxGwdmrueJuj7mkenemANTijgHi1znZVb13CDYCiZNaJ9O+8EQNFOANuGTWNXGjElza/ey0BopjxnHoQ9+KyboLQsIcW5qLawOBaxDwXD/sGNB6gm87BUAcvwGU+S9zVICykWCrhn05rmkeLtAaDUNilWM/gxvj91APWxqK+PVSbt7n+zQ6FuJaGknRyLht+OG6X8fbYitvOf0Ik0LgiggHpqDHEQxpnNKqUpoX8Xuas653h6CrYOjy6OGxdoyQyDkSTTOhOGdaJ6rjr1Z+JIA6W759OT5gWOBCYCaDFfaTJzuvHAO40AFg9A+C9mYcsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL64CTZCDrsDnY5z6g6d/4EEHxpSa6JrmiHblBn4W2M=;
 b=n0GgOGbhQlRRBCp2J9FRLp9vm3vVO96cbgKg2UerGjOJk+Q5Oym88LcwvxDdt8zkbuDOImAbIb8rwNS+XUyis8wWu0hk/npZFgG3TWSmWC8RDQJN8XHYizVMZgjD88iVM7OhyTX39ssleOz/1aOxjHCjf+XM+KHFvaIvBglUMs94Bx3Jvs1D8+xW0ZauV/WC4Gkb4XIvrbB9yuyE3OxJlBHQoqqtFIVD75Zx0jR2dE8uNCQBzrndMOVFioajoYyAvod+objWY5lN+zD0K66yvvqJnKwFfhSScoYQN6UaisxR2t1EMrcHBPNFDja5q+iv8sa7IxRTKKt+JMmXaU50Zg==
Received: from CH0PR03CA0083.namprd03.prod.outlook.com (2603:10b6:610:cc::28)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 09:34:20 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::a5) by CH0PR03CA0083.outlook.office365.com
 (2603:10b6:610:cc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 09:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:34:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 01:34:06 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 01:34:04 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v5 15/16] module_info: Add a new JSON file for units documentation
Date: Mon, 10 Feb 2025 11:33:15 +0200
Message-ID: <20250210093316.1580715-16-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b5aa07-5453-4b9a-80c5-08dd49b61847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oz9MFWvCTmLjuXZmCRFohsVGdDRtpyyehlBjgCsYkA1DT2+5yMa0aW1nmgZ6?=
 =?us-ascii?Q?HYEZ5zyWUwRpB5C306T+dn5uAXIzkfsVKXvAMUYWiPNrwhvK5T0L9uOB32nz?=
 =?us-ascii?Q?/yst8eYosZrQt7ozFTxeswTI08NPUAfobCvERHf5Q/qmqGh0RYnZ2E/ikl83?=
 =?us-ascii?Q?z9SJz2wMrAKCpDV2gMpdULX/bugf+ssY+MAj+1Y+7BXIKvLszWSjIwb4gF/2?=
 =?us-ascii?Q?FUpUz5JoPOManLF7YHIpV6Q5MR85ddf/ZlPimfz9aQ0hczEr2/aZ89KXi1x1?=
 =?us-ascii?Q?KiJ+7dErMUaNMHZ2LfJSZrGNgb8fXDg8mhzse+4malJFLpuinMbLxhBOxh4R?=
 =?us-ascii?Q?cPlJYxDfa3xg+uKNfSN7xWZGIPE/bcErVHb2XXluLMW0V1FT60EUXduU77R0?=
 =?us-ascii?Q?zEawBH+zcQrur2iV9QLcC/gPdC0KWJk8J+hkQeToXlhvNDGpPCBLBOjFWbtv?=
 =?us-ascii?Q?5enGAORslhYrb/GOWrNziDT59fexQPcEK8swmYGCtaklDICkkH85Kyj+nqI9?=
 =?us-ascii?Q?IWrzqoFUGg7MFgJ8YE9Y9bTVM6VP3Iilad3z4K8zxaLFQEdEMUxGhcvm9YnB?=
 =?us-ascii?Q?mmoKSDPGW/+W3Rxm+WekICfnqGSfDUIJoZNcY52aKf9mo8UEv2ibo0LzuOFk?=
 =?us-ascii?Q?t3xbxkTqZe11QMz1OqKjEHgkaGmibKkl2twhVnfGldEp/cZNGHpTb1/j4bzC?=
 =?us-ascii?Q?DSIfxAbqcG5yuVvRQuMnQzVN75GqdKzwekGJGFz5C7VXTWWeQZE8IbDoDxju?=
 =?us-ascii?Q?dCy7YK/VhU/R3VBVry9/Hc4VuLTEoKVuLLC5Tbsfrz5rveeZ/ydMiiE3i0uw?=
 =?us-ascii?Q?UOJYytAnl2wxqjsUIjgfBSSjzdqbCf1RRDv724R+WhH6nUW3y0Ol8G36dQP1?=
 =?us-ascii?Q?6QgO1A+NW6XusHB5ki8KN0UhHfLwegSbHrSEgQTC5ewJu8necHqpI48bSIDN?=
 =?us-ascii?Q?MGgk5WdQRALwcxAAxxwyDwgSygT9gOUWtc6M13XPXtd5VgzAv9r4DonMN1nv?=
 =?us-ascii?Q?WB9R2nqQLyXtJ/MfUG1X07YNIUPY0cxM8LuXb8mrlh2KrBrsceB9vLhaAEKh?=
 =?us-ascii?Q?135AwqmcyGb50aIROuavHW8NLWQ75uYfLKjHC9kuXYRZL+l91Qa0vJDPPF2p?=
 =?us-ascii?Q?XqelqaifEE4ffLD8t3f7/JcZ7PudHyv13+kMUiyyeMcs33Zr3VdhTmZJOoeq?=
 =?us-ascii?Q?pU1PC/9GjeIAX6vWFu6KZsC9iUvWk/1uRkFOOyjx4UDO4GKEGzaef+4vzNnQ?=
 =?us-ascii?Q?PZtmvByhrrUE1kPlkZ2x/FsLsEZZUnOFeCYouoH+frFB6M7JRnVxoX3DM5so?=
 =?us-ascii?Q?01S9wvx1855U7Jjtv8PYIfn8crW9fraYwSOtCQbcHFjOb0v2t2pJrH5FIU5/?=
 =?us-ascii?Q?Y3ztnaHMGwUnz7CWqdcdfZk/NVsa3RZC9hYGVEqscjCO0FC8JOPNUjS/kIQS?=
 =?us-ascii?Q?VJ5cJCDpFHVe+k6Wdxm1uhFHZK9AfCECWvCOffTCO2tbUYk4PyFnQLMDqiKd?=
 =?us-ascii?Q?quLllhlw9bSHNeM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:34:19.5286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b5aa07-5453-4b9a-80c5-08dd49b61847
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629

The JSON output dump will not contain explicit unit indicators in the
output fields.

Instead, document those units in a separate schema JSON file so a JSON consumer
will be able to track this information.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
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


