Return-Path: <netdev+bounces-206074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4870BB0143C
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4404855E5
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBF61EE035;
	Fri, 11 Jul 2025 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nw/pj5ac"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD31E7C2E;
	Fri, 11 Jul 2025 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218245; cv=fail; b=C2Er5ZZIK3AnfHfVy4qMyZNeoewZlF3kt8xq9MyGCLW/TNyWRSLuAwzoZsLJgd72p0TxvFsZ0gGpQGU5JvoR+jBkoJfMoC1y/rMIQUM98rzlsxQSZz63OnxDHlaottMZApTT2mgzXKr4Cxl3YZH3kFZWT0PYB7m7n4ybCKl77rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218245; c=relaxed/simple;
	bh=HU1mGodxS7FMZUyqEOmFsYCPWWaGVQUKWxArqq804To=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MUUq0wxSOJGJ7c1+41avM6seE5G6PVrKF7dOFmUkTBxN+qmlfLY5bKrFG5UThoH1FDdaenEnHqqdiYOCUkc2kCUp0P3lEob/NMfLf6NeT8WO0xH9Fz+Pw9U7pKNiVrt0OAETQQBWFWUjn3PSYehev4N3D5aANmtR7+azU49vPVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nw/pj5ac; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzN0FOoEyN3YeHhz1ZTh4K918COZORdWYiteBH/ji/cCgJ0bVXPCDbAax25MmDK3/RsYcLRYxR3Dx3OPOy3k/CmDAJoQrZDHWMBVgQPX+GddNfGPAP+AA0rmWROKUJFTIubgx7BvVEogBw7IjrhoAztzIwykKhQHYd0HuHal6eJfxAWktTxVD6iGtPzaf59W9m1l/wYaHYFxxat6C8ZxUJ+nD30g3NLx6+vsbvHcR2iZzJ7Y/7cATkj33iJiX2scAxCZMRnj9HEbqwKdx/Sr5YdKH48TtOiwqAyv/tnOgOlkkNhlPnQpz1PGhLK+9ZQoJCh1YlRzzWQtH8VvuJ5DYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eSYSszg2lub7okvNs19KKj3YM71Aq8R4q09GGOAzaM=;
 b=MnsxCP+EhByL0ahZr8Rcyb70kZB5uU70dt0CloGgLwCozFq4SsoypU6MqEGA9m5+TWZQUZlXE+22Q/eA0jE92y/uyZfKR6cKM6clJoPQjk6UYkbprGxA0dkohV4sQWmCI6042sLjCudMSsXekwZOKt/i4t6qXXxK9VEQ0Pt3xsg3OJx6AJQjeM9YTDFgamu++8y60x4f8TCVIpIy1vc2U1vL4H8/DoBmGp4cQNPjVMkFLFv2UfnQdCy7ewntzrWbR+ZZVeOb7S7IEVdXyRG3PPMPdTcd0YAv4OzlpbE+FEfql74S2aNw03+OR9PkHWEREkkRbnvPEPoGDgFrtwO+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eSYSszg2lub7okvNs19KKj3YM71Aq8R4q09GGOAzaM=;
 b=Nw/pj5acm/ZhlFlnL/drBHxKk2QSSepCtciRG6fwgxhavJuHJI9KcKtfVPXO1n76sCZjhG4N06kjQNVhXDxYn7hgHl2qkGEiJfqNAB3w6KxwUB4uGEWzs9PKXamMR4ufRCdEk6XdS7rpEOWEQ4mzLxpDJ339T6KJ0OP1igjNMFyUUv+WlwqPlJXAJYAnTbeqRBFrPV6+tdLV0sp/WAuW6nyGl2GdAMEkzf/fRCHbllgt+4lK2VHkofoC05oIiKU/KT4KSYYIa5coYD1nGKeNIkuOVfWeha3Z4429E2+RwDZwxR17C6jSJ/YJ6b8YteAYrotdEyt72u7RNgyGMdROdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8451.eurprd04.prod.outlook.com (2603:10a6:20b:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 07:17:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 07:17:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC Timer
Date: Fri, 11 Jul 2025 14:57:37 +0800
Message-Id: <20250711065748.250159-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711065748.250159-1-wei.fang@nxp.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcb4763-a5ba-4e10-816a-08ddc04af8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ToQqmvXYGjP5M5ub4LZmF/GahoC4GUWK2FgVMUpFYty8CUu7xHjOMvalTcBE?=
 =?us-ascii?Q?OqEx+ym8lRO+9eMz5lO03xZ5BYpLBJcrUW8wK3AvG0DBCt2QILP+GXEqXquR?=
 =?us-ascii?Q?LqIAQobK39R99x2bCl/m3nFlndTFOTeyjBhq9G8j7LoAgutQDfHGQfCElZYk?=
 =?us-ascii?Q?w1jlmFbPhYrzSn8eb1V2neZ5TFQXrYQWEUJ0xHeR2W4yNxbN+vdyGVnfjy0o?=
 =?us-ascii?Q?oCOAdpSs8oU87Q5PqcOZ8fLsjl33nuomy+99KjxAV6OuvDMKW5aSlEd/GHLs?=
 =?us-ascii?Q?oun2XxPrb5wsqmMMjeNPxstauGx/5mDTYwhVj6/MGPtzXqVpaFDy4Cso4tKh?=
 =?us-ascii?Q?P4BgXkmwLLmC4yC9ox8aT7OwOi0mlWSMapLQYWp7rGqB/z6EZR+Jc8aZuwjl?=
 =?us-ascii?Q?9wc6T88aLUnhqq4C8NBZcufj+/bqqy8rcgLFT9OYzs0zv0T1sDqLIG6xits1?=
 =?us-ascii?Q?bgKuYFP3Dji+PfD3n+wfx8u2GNiKO+uBjgix5sC5f73ktKjWaBuVxMj5q+pZ?=
 =?us-ascii?Q?VzH5BuloYaPDvkano/QRiYpM2vAo988U1BT3wNX2utvAjduaboHYUhtcak/X?=
 =?us-ascii?Q?8VXT77LO1Fi0fVROABDfTr+4OQEmImYhbw4Ad4hBtgPDn1A4QOGXyBi4rVXL?=
 =?us-ascii?Q?LxKqlEAtQs0UXYyxgKdSBcdgzwDwAuPUbCjmpCuTcvIOPDQm3CT/hQKlTL1d?=
 =?us-ascii?Q?ZXrZef0mKV/iZP2+kchb8l6EikNLvVD5A9UOcAzWOi3BN/zRvg7yWOPmuJLj?=
 =?us-ascii?Q?RyKb0G4NcZOY3RRWoI/MRb5foVSGZBPStmsrOLtZUHofQbg8pjy+Ku6z5tMP?=
 =?us-ascii?Q?+4VoDfxZfLTYjvaXLc3+qLCvDxRjQvv8N7WJ7Nan3qciSLHJ7pW7BA14CZiP?=
 =?us-ascii?Q?Ne+Xkp8eZTt5/nHr/e9W95W5VYJ/SA55LX5sUJtt5Enm09RJRcmjVN9LMZjC?=
 =?us-ascii?Q?cr7rUyuuKXcjxuGZ1jbEjUcgendW2kOyiLdVwOcil891mF7lpLsSTuelLSfP?=
 =?us-ascii?Q?kf7/Krxr/JYEGlq7fKFqVayoYLo+K7rMouSjHPYheHfR4kb6bOObPnfFkvHW?=
 =?us-ascii?Q?xHMhQCmVjpme1QXXVDUZQ0QVxw5u5cl1wxMJrNj9cS/i45nQOGFU22XtJUER?=
 =?us-ascii?Q?F81nyNiI3sP2r+E0rdu66W+GkOoh+XoXV1/gz6xrZCLebrrbAhCIYdVGi5pk?=
 =?us-ascii?Q?dhUdLQLk/7c4ifpL3ja6/FTWSZe/dePOvF4QS85BYGpz8gDbA8a3E4gDE5At?=
 =?us-ascii?Q?Ou0i5Dw23qCFc+4StLA0ZwAQjYYUDmRsT1yuFEPLn3JsvLXPAVv/tg8aeYYV?=
 =?us-ascii?Q?n1KnxvH1r+5nt4PYvQiLiM2pcIVIpIVXCoz1bCAYJcdbUQAud1bc341pFigX?=
 =?us-ascii?Q?h1/ckhIYqmA9JzbS5WbKB4O2Vj+5eosHa7EUN6KH/70CqGGZkzdOcMu+g6C3?=
 =?us-ascii?Q?mfoGFXysyqpaRlKwaP8IjGq7xaqQDT0jbSFOgsnBCqATJsZL5xQziQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B0mihizoEkJDpcDi6t1MHzYmE4Gb+g71jlsw/b0SSNMWqjE+W1o/e8wVG2JI?=
 =?us-ascii?Q?+IbDCqm5L57EOlertoMXqtmLi9RmKK0SyvRUYPPhbQFNQuOI6AFs3PaOu+0I?=
 =?us-ascii?Q?/YAhAkyGimkcNJlW9tKA3yYpg8phtb5L14LuX2Wi7cjZDa7ouOAiYJDEE9B3?=
 =?us-ascii?Q?0SBJK6O2WRAGVpcnbzW8PI2BoI4tMPQYjBZt2/diWF0s5mV8KpILQbdhuZZ6?=
 =?us-ascii?Q?OYVmzxlNcN4HlYunwccrqAS70SJokHPBFUw18BKD6YkZmL+xIJBqJVdDU7K2?=
 =?us-ascii?Q?4hqRnw7e/ake0DixahODEWhMwVIcaN84lZPoPnQ4lZ0b53lLPyHTkpxsI849?=
 =?us-ascii?Q?DdfNo5Fz7m5YY74fU23t1ouCHdHVTGCqukF2512ZUpvwPe06kicJof63rkP/?=
 =?us-ascii?Q?2DCIOzPc67ehXhRnbvDHvLpi4n5JPv59MghyxlIpKWvu7V4rmkYAVDDy/Rc2?=
 =?us-ascii?Q?v6LAuXfaEukI42kxIyI74sn8JVjhuQZ66O0mmQGPZ9E1rxupSHSh0NGs9Wen?=
 =?us-ascii?Q?mjqvxBNKObr255bg57Njt2ECuKb7iITq4dg5bEALopAhwCZgtOCPc+CitTKX?=
 =?us-ascii?Q?1odJXEHGWrjdQaCaJszmZx+6kgRwyXcYNOW2YYzYmsHSyAFOTqcsXrQXDTdD?=
 =?us-ascii?Q?h8Q4WyKg0gbdOwoDwmNRa+nT1Z6wz3KiiZR1ZWpnlA+YcsDmw7iNRT9MLyDj?=
 =?us-ascii?Q?tAbiZlz+2qhfgR/p/g851h1EUgIxHogB/EsxXF6/9UoKI7dSCH9wlinG1zbU?=
 =?us-ascii?Q?GsU3EKOjnp9WwSNmzcsJ+V6YCEZnCHjOMVuucLdNCq30e1S1dWgUcXD3Mrzz?=
 =?us-ascii?Q?wWohMT47sCay0TrUNJNwRpJfUVpHL/QIf+GUtHYbKWOhWy0XCzNerD8d5HlY?=
 =?us-ascii?Q?6qvIMPAy4CN3IhweDuYWVrjyIpaIlb3kPMU1pJyRWCgdZowGy4IKYwcjEJqQ?=
 =?us-ascii?Q?GWqx619KHFsR1KLzU4iTT187qOorFFb4Qc/aI52yfpSmhHYpawOhYwl0ivao?=
 =?us-ascii?Q?lHTJ8hGPLy3T+aFxI/RbuVpV+nDfQar5UHrzanH1QiTpRuPNg1hNQ2OLRD2L?=
 =?us-ascii?Q?4FLtJImBBh/toKRYkC+TmPQMc1t0NmjNIY6gOBm9/QU3RrjlgNuwJ8lhojQP?=
 =?us-ascii?Q?2n5bwP8YNp79YdVn+BGAhxEm9wuOKwY8vh3EiyCToWNDgKC0D3YtQNRUghLV?=
 =?us-ascii?Q?4cfjHO90E+qzurs4Nb12DK7p1CXgZM3+ZXNP539n8jAnpuV/zL0q8f99pJva?=
 =?us-ascii?Q?+tYoECkzHpvkOxRvqDYdRR8+33sVyW44CaAgYe2w6NmSfKNJCgxiT2Kb7jXT?=
 =?us-ascii?Q?1bkHYmGTbBqmW6S6JePWoT15RRkZcYMT9Ld4oGCKsAQwwPEmPLiSTS3Nzd1i?=
 =?us-ascii?Q?kyr21pktvQTNdR0bMTlzf0XHHS1AjRgBIs1Gbc089U+xWyjEfEbO+cRnLqlY?=
 =?us-ascii?Q?PKBsPUlGLv19vL89niJwUnK1IOzaZRgwEjQcieR5fI5F/aL8kWRVqw13TI1b?=
 =?us-ascii?Q?G4mqgxn/cj3abAqzjSYA5O1izB+qbLk6zPs7vXVtqEfU9hS0fzZJJeQsMFNK?=
 =?us-ascii?Q?eLj4WzLEf2tNsf02MFb8ylzQTqdssbD5qkMrjjii?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcb4763-a5ba-4e10-816a-08ddc04af8d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:17:19.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85u9jWMkYT9V9D3CvLNLlHX+h8YuPNlqVsd7fhomm0Is91yI6WZH4AQJDKKptlGxxEoAQUmNeZei4ap6r+croQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8451

Add device tree binding doc for the PTP clock based on NETC Timer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml

diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
new file mode 100644
index 000000000000..b6b2e881a3c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ptp/nxp,ptp-netc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP NETC Timer PTP clock
+
+description:
+  NETC Timer provides current time with nanosecond resolution, precise
+  periodic pulse, pulse on timeout (alarm), and time capture on external
+  pulse support. And it supports time synchronization as required for
+  IEEE 1588 and IEEE 802.1AS-2020.
+
+maintainers:
+  - Wei Fang <wei.fang@nxp.com>
+  - Clark Wang <xiaoning.wang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - pci1131,ee02
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    oneOf:
+      - enum:
+          - system
+          - ccm_timer
+          - ext_1588
+
+  nxp,pps-channel:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    default: 0
+    description:
+      Specifies to which fixed interval period pulse generator is
+      used to generate PPS signal.
+    enum: [0, 1, 2]
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/pci/pci-device.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        ethernet@18,0 {
+            compatible = "pci1131,ee02";
+            reg = <0x00c000 0 0 0 0>;
+            clocks = <&scmi_clk 18>;
+            clock-names = "ccm_timer";
+            nxp,pps-channel =  /bits/ 8 <1>;
+        };
+    };
-- 
2.34.1


