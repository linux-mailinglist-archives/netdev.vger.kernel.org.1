Return-Path: <netdev+bounces-162563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49767A27391
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635581888C06
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0E421770A;
	Tue,  4 Feb 2025 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QRthne5M"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A911217678
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676477; cv=fail; b=HUwLv2j+lVAiI8S2PDqH6ghI5kpYzR5wM7v47Rpo4N5KYis8AwxeRTFBLDF/4V2wZMuUDEcCeqYZ5TRkVYhB8Dqgfe0GK4L+tQy6bpbjdIELUXWPdgOo2r/kxJTxCr3k4jLBHF7z9CjfOIacaIqS/eCplYb5M4tXKSg+hF1y0IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676477; c=relaxed/simple;
	bh=39aB2TOQKfY7Rx/mxsvpVXnx/inCi9Xz/0jWK81uqc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkihVK9lPbeuAfYnLsI+OszsPfqBS9OHe7COrLvvDvG8yX8tyFlatgjPjmcFB5L/YZ0ySq19tPt3njAF+jctj4YhwxPrrP7mQuiG5Zqjs8x0G9QVXZ9BTXb0aPBSfKfsR2BP7QA87+Vz+1IRNNx4gaV5figfhV6NYKM1hA1733U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QRthne5M; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RysrdluBDlZDja6GXTIgLDonj7GV+31IzllRyVxC5PQK6g8ZvFJjnDQTJB7zD7/vKN9QpL9bng2PLQaHex6BG5DeDUNgjOtqaeCl9Wz1tm2ZEV37f30o0pEDF04d8sP+FNPyPfzekJ7IYI6b+yx8maQ98Ni5+xr0CStRyGABc4y7pAOqLW8PGsVaoU6Q8mEbUSVS7VcuHcHqmZAakRufPzVs7cw01odJEyallQXFqu1Kh7xKqvfRFyoa9RiV4+dE/7tHqyH29iyOSmdYxVCuqWQRaHWmtwrXzE4DpdnQHF4hwq6GEHtq4gmPzVVWOCLtcfKaddO4hX5tnO31k4qC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmI623Fq+zNnzpiWLb/3AhLk9N0T+63PY+4AlO9w/kc=;
 b=gqFSOvfylEvJD1T+/CAvuujpQwVZt1vUO42DhSLRw7tD9L2W/J9XP9oOGDM3YMBwENggO++/2m+rB56+k7h9jHO3WEPfweGktFS3F7+oEeAZmDuaCcfaw2S5Hujzj9MDGN9gQ6H8Sk4MCbONJPZQfpYNplu55Npi005TL2JBQuD1wPJ1miOR0z8QnCCxiXqFxkCuJAYHi5tVmlD5scoD43Ew8GXQBnkeyZshOPJih9esBR5FlhdqADevMCbFj+gWWmJCGUkdlvtKOfzCckZs03nfLBr/YoNFoiydm7JvIyM+eIfOvK+bOu0aa+G6xOmN7lLIW3xNrpnDVmqUwdvDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmI623Fq+zNnzpiWLb/3AhLk9N0T+63PY+4AlO9w/kc=;
 b=QRthne5MULQeijbCSaYQ1m0r4IDM3uTWVo+FS/7JRJux9EngVvEW40ByfX9jL9wS2fULDusx3nYJNmQJQsjrWP791Zc98DQSpHWDPdoVHxoU5xhEzGtZ5/A/5vcjCzWy/GYpleHmulKpNMKLz7WYTIEWWEu0RUt9vYFRRupgxolndLw/D6poKBN4fcO/T8bYjVXAKPUOdmqHV5kt3JK1pGSvAcJmvhK+jaKJZuwVKmsYHCorNmD4nnhE/GU+0sz8B/AFF3sGoXYAP0xrKnDYaMTLY49upE1e/U4QrROULs5wMZnrzcGkk5N1omOwD7/8PyJtMN5hkFOPj0BFXyd5pg==
Received: from BN9PR03CA0681.namprd03.prod.outlook.com (2603:10b6:408:10e::26)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 13:41:11 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::64) by BN9PR03CA0681.outlook.office365.com
 (2603:10b6:408:10e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Tue,
 4 Feb 2025 13:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 13:41:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 05:40:47 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 05:40:45 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 15/16] module_info: Add a new JSON file for units documentation
Date: Tue, 4 Feb 2025 15:39:56 +0200
Message-ID: <20250204133957.1140677-16-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: f210b623-c02f-420b-f8da-08dd45219683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lB21FFdmFekmpyIb7Vl86slo7JmcXVAb7k1pasV4qOyIDTp3/bhTjfLG2pIj?=
 =?us-ascii?Q?6JHVGXfrvC72l3CCwVHDiYP9ZQFnJkZCoGcJD9JLXwUDV62TwBc93G+21MA8?=
 =?us-ascii?Q?fN/84/HTY5wJDHmBK4PjT6Y08gF0ij2w2uYNgEryeVhpjhNoTG+FRZeWmOTD?=
 =?us-ascii?Q?AYyGtAmRxeYY4a6wKLEJRUu1qCKKl3xWQFxn9HfqkbWU7ylOoH+LB9/zmCaI?=
 =?us-ascii?Q?tnWw7te1Bj7PFovvfnkM/HOcoWbCoV0ZwJ+UrdQIqCEuDVID3kJJV5OQrVVC?=
 =?us-ascii?Q?Rhi5k3x8AGAQkxSMG+lI95kkKxa3REFcY2w2+6umnVTzuUzN78ymMTBQWTuQ?=
 =?us-ascii?Q?t9yV4SV/aoj413PBPlohIklj0z+0fY4HLk7OztPiQZi8yl/1i2gef/KVs05s?=
 =?us-ascii?Q?82KNB0jgd0xcXsilb7pwMGjsDhy/Alnha9KTB8BpkI14hggmMB9T2ZrO8SrD?=
 =?us-ascii?Q?fBcT/STcuGYtuT0qAnOLgWmwGN1vViLJ5uUYib+QpB4Ch1j02MkGImTZ9lBf?=
 =?us-ascii?Q?oXa/7ibY68AnWQIirwFPvKlXekJ95cGzAEWCX6ALqSFz3tUrrJHPn5+pX2xb?=
 =?us-ascii?Q?Iz+rL32JbqDxiRQD6M5y+8cEksT3S0Gchu/ut/5t69ZBt71ccSTzFty+v+X5?=
 =?us-ascii?Q?Ka1t1ogtCeDEMj/9QYvsPUnldIp3bjlx3Ey7kVpAmiuQ95KcyvbE0rV1Ql68?=
 =?us-ascii?Q?i8TVmg1mihKP//++ooxpkGH30BvmAOu8Sl5MzxuDIQ2XvqnJDF33FtApl02E?=
 =?us-ascii?Q?97NnZTa8zSZ4H3350kKXKJnIgUs9uJzmTJiY8SCfeh2Q3pTSvBnqZ3Uc6oUT?=
 =?us-ascii?Q?dHRn+DcuNaG5rWIpj73BauF5iJE0oE8B68kbOyz7abUIx1EUzcIZ97IRfS4V?=
 =?us-ascii?Q?X5/bV4x8oVy0s77VpqTuU6qMmW7sAq8TVOsXfSJLnjSbaefSwDH/PzRXDjR9?=
 =?us-ascii?Q?fMiT78v3mE1fUc9cBvrg2skDOWUHLguf/9CCBqmWQnjhlN+W3lcjKvWOr7Vm?=
 =?us-ascii?Q?Z2cFKX8+QDYQYgNArodB9Qr3fsrcQ6moXdb9DAEbiz0xP3gTeZzavp027qhY?=
 =?us-ascii?Q?lRVZk8uNhd5TyggTQwHPgAraLpTdyAZyxLr6F2bHK5INPVvjdOC+IZILak0L?=
 =?us-ascii?Q?s03i1nSiL4URsecvvkATtbKVdi9pya+gCSb04gZwoQnPJ/jZ/6UaG5zBxEre?=
 =?us-ascii?Q?KPjrt/RPwSt+Z1KSwLtXsd4LBkQxMsjaGhK91BF2grDrYXXoojtcH3RSTIdx?=
 =?us-ascii?Q?9QAd+2L1RTuCfT5K8HmYjzDhb7R3zUM7iYFe/dYi6rL24TjxVX0buORlNWhY?=
 =?us-ascii?Q?KMxVyOj66o3meMt5AxV42acaSvkeMuh9b9ynRuyOWXnPCY3lpRBKVcqQKfKj?=
 =?us-ascii?Q?FQIl2kO04apN4AZZF4/kKVUvekXd9uuIlMUOBeXKuhvrdjTGAIvSG9YBTCyU?=
 =?us-ascii?Q?8UjyZg/B04/k+H/Bz/yJMvsQgOf0torBvZ+ssU/yi++GiHVbtfx5Zf6JdNws?=
 =?us-ascii?Q?6gCQEHKsplw5Sn0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:41:11.5915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f210b623-c02f-420b-f8da-08dd45219683
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234

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


