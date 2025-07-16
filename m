Return-Path: <netdev+bounces-207387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 096BEB06F68
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4724A1A60551
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A1028DF25;
	Wed, 16 Jul 2025 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oOnNnb8p"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68682673A9;
	Wed, 16 Jul 2025 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652270; cv=fail; b=lifIE3+M2Uq0o08o5dXO16Ro5xb9kzlcW2P/lxijJRjPZLrLHCKKgN0qGQKFHtfz+q0BogHdbTKe/WcfeIuFdWl7nF8xf3mqcuAlv+kvfukBG/IAEnf3lKl2za0GkUY4GuACYnIpSm3zeC0tQWB6GHSqKhJxXKtid5yC/DVjYZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652270; c=relaxed/simple;
	bh=nTBpsiwsADUbs3e/5X2ebHNTgJUNiMCxHz3DivNJz+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QpVbuipIbNiA3DKmpVPnYqzdi8OceM8nSEYbX9NyZJ6ohi3g/nG/6ycgrKQvpw6hgZASS84mnGRs2RaP4sLYzhl1pEd7fZ4E7TTgVe89/9NUSszoX6K6ZT66k9NbxDPj9eawucedmqlRsUGweSlOGHjrNgoZ0LocJthCjxl+7+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oOnNnb8p; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3skH0mxNMxfgXxGcxMiEVX61b/+jjKx+BvirUCnm1af+ejQauv0fPau3upcOV/oKi9wv6YKPOJxYm4quEj+RbKvaWUVC4J+a5E+SdzYr8ssVGq+SjLK975+VpKcWFhnYs1nhyA5CJ8SggD58nwuqYdv101b8fLOr594tFQv4zbIl20dQUH5QVveR834sOD0deaZ33SgoGJb9MKLqwheAh+s8gAYMuGkqGipuA0f3ROnq4h/tqTPQU5HkEufN8YQT2ygAk6bNyZxw26gQ8t1yM+lOCbLXaLrSFaL5EC+XfztUTk3uU0hNBqlRXHBV3lY1QQBP45fSEXFVuiBe0N0Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2bR/Rvifn7J99LNhOoRUVuQdWthZ4qOJmG1URNpUj4=;
 b=LXdl0OuFczCEE+x6olbHvkAUtq8GfJh6d0xhplNx2ExsLwOKXOkH0+qYyp1Vfsuznk4ZDEjEw+G3PvPS2DkF74SVUj3VE281/mBI7yXHPI92zPFXwlv6XzSLnyjVSO6agsnNq80f0zo3orYnJz4qRIFHTaCPkkSOE0WLc2pXUPwE12EwqfbqUcGaxKbAl50bPU4sUlzN84w4eAyaN1lYQDSWmONNmMxyYq21n5k2uwYrrEGjyighda3SE6tOOLqzfz9B4POvPPwTaU/gCVU7LQODu/vazQ5OPddmXmef/yzprn33KEiEISgz5K7pXxYBNu6SLwxxsY5nVmy5Pjl1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2bR/Rvifn7J99LNhOoRUVuQdWthZ4qOJmG1URNpUj4=;
 b=oOnNnb8phUGbhMmUusZtF6jw5NacCbyFTDOi2pPPq7JMqC6mw1rwJUca4CfczKkQChKuBIrYx4AL2O4ps7OusrAjbtnR4jFfMtU5OJHhYQEAtwhw0USq608o5xG05AEV+/rzjVwV8Mh8HBzcRZi+N/fZfaISQvbZsAzA3z1CYoyHdx3sITcIHwYROXzI9RvXvTDMmqY7UkUNF3iFxjdKczs35hOIRgdROxUVbP093mrD3MUsvWU1Nv8mb2m1TaDz1lLOLInmxWI+ZcjdM+FYz003GbWMpcXiDF2+tDEIaljRNO/LSHxqXnM3O7pSTN32RE3kJwlhlqEs9o4yKDXqKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10358.eurprd04.prod.outlook.com (2603:10a6:102:453::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:05 +0000
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
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v2 net-next 01/14] dt-bindings: ptp: add NETC Timer PTP clock
Date: Wed, 16 Jul 2025 15:30:58 +0800
Message-Id: <20250716073111.367382-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073111.367382-1-wei.fang@nxp.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10358:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bd3d83-12c4-42a3-9e89-08ddc43d844b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6GJdZtnNN24750zZ7tioVP+Hs0AUkO8e7CVDR1Jleb1H/TwV5LtKn0A0YnAl?=
 =?us-ascii?Q?/Q1O3YMhkYBWMn7YumYNp3JajMXuHQkoGVG9Xg6EawE0hS7IyLRwGhBAOYJy?=
 =?us-ascii?Q?0gyA9hM26FrTTl27rlUbLW1avGohM4Lf70U7svgDJbnSRY0L4i6joQ74jleR?=
 =?us-ascii?Q?JIvm6hCaiWSHaMdGEtEyi47qgxJmzK5SC+KN1QMkxb/FBZai78QseRO+mhSK?=
 =?us-ascii?Q?WlAc3+E//RcwArfGrcJGRaQ0yMkK7g9QsPvuo6WUHm35Yb4Of2ER9LNbfFpw?=
 =?us-ascii?Q?G9qcZP4CQfAXoLzvO2zz/7/qZoZo+Kpy6dh4DlWPIqPcgI2KqQ2Vd0ePmrLc?=
 =?us-ascii?Q?PfGD9lhvgbrJxJ9TD1wqfVmQ2uRfhTNh2LR3Q/URBrW49RgmnE00vFWG6bDE?=
 =?us-ascii?Q?oriyRkp9a4uH4kJzejCTCz6a9NT0y1MOrKiyeWWVk9w7olZWteGz51+aDZDL?=
 =?us-ascii?Q?MYbZf/RzNH7GTix4Wh2tgdxOXnmmtva2EfEmVlwXHmP2RrJ7BmQkANRGoCtu?=
 =?us-ascii?Q?folfFuhPDtp5HejAUBx3/+o+2Nyvq6L82zXnpFoZA3njZr5o3pCnR3xH+i1X?=
 =?us-ascii?Q?JOz29aQb92cdB5wgyR/qrCEqs6p+5jftabVFNm7HeEMWiikbikd4YuJ0o866?=
 =?us-ascii?Q?UgVYyt7LkFpTA9koOC3/oWkVa85nkINgK0kjRHEd6APYjRx4DVBtetDh9NK5?=
 =?us-ascii?Q?150G03esxspFgSsyNo99Q1Qxmf5fvWmo0D+58anHfWQAy9Gy0xgs/KgZdRQD?=
 =?us-ascii?Q?WXWD5ZMxrMSCcjS8mOyeZmq2oedJCBT5fuXOYi2AAIu+dgaNZkk8ua+PzY6S?=
 =?us-ascii?Q?brd4qS6H62Nky8w78NJ7/F4/puQf8pdk64PsUvpgV5OA+jqss7UhQW6nKc2g?=
 =?us-ascii?Q?uwmmCHp1070lXqB7o/dLnmUJVgF+PLOCCIwMKoW+tpa1bOo6vpNQQ2zfDlkW?=
 =?us-ascii?Q?+LfduvwD3hkzUvoX35KdEG8zwp9qEfd16xGaNP4qMqGJMLyGco8Qjk9u/mB9?=
 =?us-ascii?Q?Jp51P6tRpI9gCiNfW402L3mORO+LQ0GCK5+Hi+FgPQJ5Hp4GQ0yVYk5HTiXo?=
 =?us-ascii?Q?QGKpeO7dYdW75ToZazMMGSuq+yUT5y+TtL5V/IBXaYNZ/GoK4gHYKHQv6EH2?=
 =?us-ascii?Q?rIO5Ot5iiwfXM17yJhvbaycpyUGDm645buP4VgRrwcbntqxE8QHVqWLMuPqp?=
 =?us-ascii?Q?b8sjxyvQMKjHsBjssp78PBrns/j8sIKScpLCyYdN6flnwcInXcnFrmlFvuuh?=
 =?us-ascii?Q?dfvuPX3xR3Lowq81oli3idnUcEkiO1aJkHmNzi+B04BjsRUPmlXFebobeshD?=
 =?us-ascii?Q?rGJq3WA6UWSU++/KNbzjlxih95ozmcWwBKjZ9xX8EeASunPUm12wCjTOwmFU?=
 =?us-ascii?Q?A2lxV6UHtd03yvqJ8rNwZrmEQsAXhYzyDorrce4yB8qRq8y4vEeBooKZWUnU?=
 =?us-ascii?Q?6mD7CDyLrWKSYUkOyYy4vLukZyEasEym?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iv5niHeSF4xqjjGYyOaj2Z/yqmiZYfU5BiVRDqPw7XJSyMJ6GBfwqoS0fWFY?=
 =?us-ascii?Q?Wx/+Apc5F6Mc/bMt+1+un3mALfZmKezt9GXOz65AyLuY7ynKryZmqhjsDzDt?=
 =?us-ascii?Q?CmvpUG4dkdtyjz7VYhl+i2pOFQ42OlZFnFuRe75WHdi5fszLwITMLruUl7kZ?=
 =?us-ascii?Q?GYcT8F4ee3qw1XcCQOlx16sJkUiX3nT99VleKx3E0IcRAPPBn9eyzq3OgcGQ?=
 =?us-ascii?Q?woHcn0AOuqvpUCBXYpFXhLtyRWT/RSJYXrm7qZskaq9RaZx8voM3AKKEwTRf?=
 =?us-ascii?Q?dIyLyzQf1XxEdMfM9/Ww8smxTF6bkAYWHFIt+LBmum1sn14cI5lv2sm8+vpl?=
 =?us-ascii?Q?+vDa1CBjMmPZd34dXXaotooA85HX9IO5WKdN8cJ1i5kGUNoThXMdLbAsEK/j?=
 =?us-ascii?Q?G7KqUEaKzvJ9RlcCw5jk3VH8bTU6gG4qn1uaP+OKlgnbQsTD+bHxXOtaOmFD?=
 =?us-ascii?Q?uQeQoliLQO/S5L0mGb+pES+BAh2+w2c54TAzi+uCzWmodmTFULnbfL6UFIgc?=
 =?us-ascii?Q?eh16iiKdvyVP2YWnoDGJ0Z0fZBYPjuyedzKi5NmebFozxB0Y3aMW0ADlYyeY?=
 =?us-ascii?Q?y+gFdrT0I8BXY7Qu8UCDpyHzzgL873Ao+6R4K/apNt549lTaOzz5GqqwggL0?=
 =?us-ascii?Q?tvfJVRmYlDtzgEVlEDd3DYXJP1X6DJJVcZv/3TdaPVNq+CDEo0u3QFwi8rVR?=
 =?us-ascii?Q?GqaRbktgKbsW0FEJCzw5L0DLxLJuWS8tX381ftj5SOuAdtUHErcQYhXmBNDv?=
 =?us-ascii?Q?5ZCNzSXDam1CgPlaaw9oZ9ueeIDzqYkUtczKxNb8XE6i26wiJOL4bw+Ill0X?=
 =?us-ascii?Q?iHCPXdJn7FH0C1AltZBquUUgB2ojvdhZQ2Kzf/if78e6eRxaEEclUHIzUVna?=
 =?us-ascii?Q?DpyDcL1Xr6RKbbMiUxZv9f4fDPySkvsj3LOn7r4yP6WNNrmN9CS4otrJxGfd?=
 =?us-ascii?Q?43huHrq1cZx/ij9KZCTjvv5JSii1YPe5rYzrJzoOiyPwpnrM8IsGhPmId1xG?=
 =?us-ascii?Q?Baqt9XM5WtPyKLe7N9iWHyFLltFHPdeGbrlPtXbjWqJBS9NXjSE3MjS9d4SY?=
 =?us-ascii?Q?K0GYH9A2mOF84Yxv/aeaNDGC9PlOV7WJJ4PYfxpWby39YOoiL/qs5AHDqEGQ?=
 =?us-ascii?Q?BpmIgS8F3XbSB9N5BbZ/CVean39YzZ0uc1e9Y3PrdGs0QFczii+v/xQgLwH/?=
 =?us-ascii?Q?0BNy8GehlqWpAL5A4ktFgK8wYI/2T0miJFg1kpw/rIYiwOcG2gFb9h8mOGy/?=
 =?us-ascii?Q?R9GxfrZp42/WO0wM2Q+L5qRPbiLNmEp39esVQTQTwC6kv6bwojqVYORPAcf0?=
 =?us-ascii?Q?Lr24I8REZ2rIiZn5t7yYhCDQ2wDgv2SY9SUXjAHpbxFeUQsSiaZUIknfPOhe?=
 =?us-ascii?Q?KphGbyKx3j0Yg4kwTiW61DyWqmD1aCK2ouh1V05KXRmw2TVJY0sgnzlh2h8i?=
 =?us-ascii?Q?4oBPNR/gnpildmTaX51qEPl9ZLPuA9eU8D02k2HXDziKGhSfz3eGa5hWIUs3?=
 =?us-ascii?Q?RG7Bv/8+4TKQlXQOtK3medqyLJ5YROd/I3r93DDRI1gwgDL1vyLdl4UB8a7P?=
 =?us-ascii?Q?RkOh6nl7xkTC2RAKt5eymhflt2jRLPYHmTU0Je5g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bd3d83-12c4-42a3-9e89-08ddc43d844b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:05.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJbJiPIDkg8CLNzU01p+RlbsZ2RJRJmt1S+cCi0hQi6x8ixChIHrc7C3X6RK5nybPQE2eAUj5vumtlVKqma66g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10358

NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
Integrated Endpoint (RCiEP), the Timer is one of its functions which
provides current time with nanosecond resolution, precise periodic
pulse, pulse on timeout (alarm), and time capture on external pulse
support. And also supports time synchronization as required for IEEE
1588 and IEEE 802.1AS-2020. So add device tree binding doc for the
PTP clock based on NETC Timer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Refine the subject and the commit message
2. Remove "nxp,pps-channel"
3. Add description to "clocks" and "clock-names"
---
 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml

diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
new file mode 100644
index 000000000000..6af1899d904f
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
+    description:
+      The reference clock of NETC Timer, if not present, indicates that
+      the system clock of NETC IP is selected as the reference clock.
+
+  clock-names:
+    description:
+      NETC Timer has three reference clock sources, set TMR_CTRL[CK_SEL]
+      by parsing clock name to select one of them as the reference clock.
+      The "system" means that the system clock of NETC IP is used as the
+      reference clock.
+      The "ccm_timer" means another clock from CCM as the reference clock.
+      The "ext_1588" means the reference clock comes from external IO pins.
+    enum:
+      - system
+      - ccm_timer
+      - ext_1588
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
+        };
+    };
-- 
2.34.1


