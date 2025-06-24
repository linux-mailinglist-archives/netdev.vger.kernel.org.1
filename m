Return-Path: <netdev+bounces-200570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CA6AE61E0
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDF0401476
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B258281510;
	Tue, 24 Jun 2025 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UOPoHRf4"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30504281370;
	Tue, 24 Jun 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760020; cv=fail; b=WchvEmZx19XING1siP8LyHYVhfLypRMDFdstrnFjprBCj5C4W0KVDhgJGrlayXHMxNxj6x3DcZr+X28y+/AXBtxwF+kdgJc+E9wApnyuaG1iGVk6aZglWzEZ1eb5hdnvHs1FVpIO48zlRyLNm2bI4tMH4NTnVd0g0pGZ/YcW5A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760020; c=relaxed/simple;
	bh=6i9u3vtIHgRFo+YVNUlXNCIaZL4p4lK1GC/5gof3HyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b+8IUPhdZxft/mZfdEr0UUKgS9oVh0xElP/pfDhdXNW1ye5WiR8G0CRFzxvadhm07yaHgt8cdF5+VZCZvhjCXx9KvpcgPAzBn3t4cfPLaBjVo5B1ruLjIY1ri3rI9XWZGMfQ8PixvhOTfDht7CTitf/BK+KY78ZNqpGHyPIwcSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UOPoHRf4; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oi3IcliqZLgr/MMjpjG1Wu1JVuC/mNSyxUECaoT2BHETM6GsY8T0qG0UyBO5VkwPzno2tAVMM3ApXMmb3x+iGVGEJiGZjZcKrCnnxzIC5Xcyu9wBCSuDdN9CnU3Q21ZPuc4Qo+0jJE97F5EjUlIGSAGvn8xT+f/2XSqUAefqh7IZHlN/Yp3J1AKZFP7SZNKByfSHlv7rd5OhUYgZqj1P+/76q6zc7CM6mPis2gRPu0RcJrSTtmtVdlXwBmYRyQ2ZNSTsvnlCJbtpkYu7Y4pUCeDsXpEPfcJRQXTlk34VpigA10aAINYB8ae9J3dwFFEgJ1rPG7CuUklntdwAyXPnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UY5K6LoxnPY/kjt+a0+v/t+dqv728OtL3VGVTbiAakA=;
 b=TOFkD6NVjcKXOx6gjVpqXgH8PgPs66SHLd8wQoL/igShaxm0Ny6ub9l1e6w6A4b2YJzel8QQITT7GhN1n3JYUjiA7KzpDp8wC9cK8QyquwfUPOEU4y2U28RVFk4t1uQ6dZ/Y9R7q1WdK6resbNkDNCWmr/EGt/VeFuV3cPhSO5yEZy6BsM35SD+4hgtJE2u/STn0e+WtoCQyoUqrCsfYpxs/l8Wq8D1l1bg/ppSLYrqf/y97Usdt20G1vX/JtiBc1DgzWCm/vgF9vi1Dlc4XswGuJ4MJB+Av4SIwGGJS9kwCRPAZSHZkMqWru020dhy6vycVkpQJx79cfi1GPquQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY5K6LoxnPY/kjt+a0+v/t+dqv728OtL3VGVTbiAakA=;
 b=UOPoHRf4Iu/w5F7WVj40hyXN+ILDaecKrLok/+2PqftTWRHYGDEOM2lnpqa6toNHT41wJbxHbXnkYI22itowntAqxHiSEpmmYrUHJXXonQfpdIk72xDXOFA08FQCA7vy4PCGLBx3v0udLqa6TaidnpM9Brrm6mgmRYvpGJrhGx4bHUkj167suihF8UDh4VIDdGjfzKipMCLdVnfbTmqypvXtVeZm6CIZh4c7IElpLbWMmxWjyDWxzoRwVVJG1TX2Q0/ewuXPdV1qTI/PxGuPRfO3+XzuBHo5XhfNDbsLm4EXYu29CCTaKAAR1DBfQO7HbjvODisGukkK5rR05epIQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8636.eurprd04.prod.outlook.com (2603:10a6:20b:43f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 10:13:33 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 10:13:33 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 2/3] net: enetc: separate 64-bit counters from enetc_port_counters
Date: Tue, 24 Jun 2025 18:15:47 +0800
Message-Id: <20250624101548.2669522-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624101548.2669522-1-wei.fang@nxp.com>
References: <20250624101548.2669522-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8636:EE_
X-MS-Office365-Filtering-Correlation-Id: 45716466-747d-4163-2cef-08ddb307c61d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3MmjewKY0BGTAV1oxHOkt6Y1SBaQd5yj1T+s6d7KW1BChcpPJDRBGH7n1+uU?=
 =?us-ascii?Q?1vlRWuSc+iUGkbOGaxpC5yqgt/vqySqT+im6U+fnCKuiehoNQRAI3tn5DzsV?=
 =?us-ascii?Q?4rgN+UkJ0uSwfQGcKIzLgYfw0EOJsokny0IKfUq3gHPEVEfvdtIoNP3hSQzf?=
 =?us-ascii?Q?9PiUTZjcXw9ZoVdRcifc72f7mJUQMNX79JQv+TKL5ocYbyYvXAXTHd6wapL2?=
 =?us-ascii?Q?UhNHl6QaVVpb/YBtQoyDNIYAmNiTdzJNsYu8LBe0Bpy1+dwQNGlwQWauEAb0?=
 =?us-ascii?Q?fGMa7FXEg0DYkD/P6RRs2Bbi3Lfa0rY2ZMB8hG548FtXGSFKQf2DZviKGf7D?=
 =?us-ascii?Q?4waxIMyAw0hX6yDeVJ9AIwl/aldj9weeNeUKK/0dhcNJ7kHvmrlK8g0WVx+G?=
 =?us-ascii?Q?6LF6vO5vyx0nG07fyyM7eNZ7yBUb+4Qw/T53lL1lhWTY3Sm05FIQyIT/VsjB?=
 =?us-ascii?Q?J31jpne08joOsnqr14f41FeI9hldfjitK5l0p1CVsHpImW3IoxgH218GK/yI?=
 =?us-ascii?Q?ZvMCKosZOxQ/1cL8c0nmhLcFQxspgDd3eoeg2friR4N1EoI59L1khnprSKA6?=
 =?us-ascii?Q?NujIBV5B0XJxa/K6YoBSCB8wxqXCJ/BuBCOftK9Go8665pNVKt1fxAA3SPTo?=
 =?us-ascii?Q?hS17+zq72aT1Y7uQFlzCTPL2KbQJyDv/+2ode4FntJiQKtrofa/o/eP7CKh3?=
 =?us-ascii?Q?8yVuKbTFg8SofTH+wi+llRQ90/bqIVBcMYvXfnRnS2YOldOqofJodk0tqA5M?=
 =?us-ascii?Q?wwp3ukQQKoaiRnBgQzUnNubgZgFVXGNEJ+kUxy2/rkn/fpYloc8pxKdsvplJ?=
 =?us-ascii?Q?NdfLLNv+WPnctWS4WPy+6xzfDkcy+enjVti/BRwOGlYubg8D8UwK7HrvlzOp?=
 =?us-ascii?Q?IIh8zeFf+v++Mybe8YbEnLW+uwnZJlck0qjYHGzIXnbIp4m1C5lzSFc6EHOd?=
 =?us-ascii?Q?WY4WWUJ4l1wKff9RMQwIBnEVQxkvTmkY0Evxzuj1Kav0nqypnm4w6K1qwcWP?=
 =?us-ascii?Q?b+s5mtZjCRhnC48fs2rmzOjYnW1PB+5wYRVZ4W95Sa/bCxz7BiLlKc94kq1K?=
 =?us-ascii?Q?TEd/rQIFpe68Orh+mH9kluSZ/mYJC/wH8zpa5UXThxRWjyrFCaCkxGmn/bJx?=
 =?us-ascii?Q?uNowUaDdrkrl+sfAzw30dMMQIjBO+zEYdfz9Siv8/MkGmg9hfou55xqxQn28?=
 =?us-ascii?Q?shhMWKNW2rkRfksETRXt+BX808LGTWimwZhpAH+qxzCe9wOC3U5VbiLpGZI3?=
 =?us-ascii?Q?W5e0JkzdmRx++/DB8r+ctNFuYf1nMBZiHfGbzEnWp+3SD8gX4/cBtu4fyokm?=
 =?us-ascii?Q?88Ew4eZl95BkscUq3esC254mYQoJaxK5JvvcdOeD6denEYcFw2qzANksd3f1?=
 =?us-ascii?Q?ETaGgszN/+r2hjC3SYHD///FeN8c7lKQ4HWwPSGA5MbWU0ygWzYn+PRv4dbw?=
 =?us-ascii?Q?poENvNPZo963XL0uWAObm946h0ivkWBX5o2z3EeEY5RLCi/euPof+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+7Q8xI6xxaOlq1lwq9fCevBdm7oXUkOGrDkfAwE0Vu5W9uZOo4fcC+382Lwu?=
 =?us-ascii?Q?9PyiCIVxDTDw6DgFPSWp2SeEQxexaao8OCqdOoAFQI9k5e1ApEpgMbX5njZO?=
 =?us-ascii?Q?UJPNOwTmadYdf82ub9SHDI+939xARSDxUZkdq1Guyj7mgkc1tNceTACx0RzL?=
 =?us-ascii?Q?SFuGt3Ey5y4Eq7c45m4CsN2SzbuE45ooY+zN8PLDnmfpEWH9/kAuSuF87HdW?=
 =?us-ascii?Q?zOpfz+AW4Aq4pGE7/nIzr8EmhsgUbe+yXA7Cys01YBz/CUnaBaNtW9qxVxJX?=
 =?us-ascii?Q?8Pn9D5z1JP1I1UmtJdSz1hHjVU/FR8tiUFwba9bSgX7GW6LqNKColqXhR1Py?=
 =?us-ascii?Q?0Uu7nMDDaLR9YQMwkVeBSSvrM/2Ey1Iz6bBck61OdZw+0ORdvAZM3nEOkPMY?=
 =?us-ascii?Q?OvldCVmDmiE2OMv9MmG+WgTIIDsSRgaF7DWf2WqbwT+2C9NWAvVqNFO6PO+D?=
 =?us-ascii?Q?ohgyp51VjDgDiv6YuyGxaH0aTBUdyMHfcQj/cB97GeVoqIc5aT0QDToWd6Wm?=
 =?us-ascii?Q?UbCWh9t8ZW5goOZGLKoJfjKfEYi9NScIL4lFiF+Z+xtXNkYha3W6PtaCSPoz?=
 =?us-ascii?Q?sp0Fj7IAM+UHbGIact025zdgo73K3JNlgcEMhtPLwvkm7bq4oWalAAIMxHQO?=
 =?us-ascii?Q?LAY+O7pX25nhH4E5JQehs3dLChnM9WgIQV/mkw+RbPaIvKixFmkzqB6qrUNY?=
 =?us-ascii?Q?qBxAnEXzicmXLjdtuYyQhDstzdzetoHZH4aTrkrxbaQGCpi+mQYMmMVY3U3X?=
 =?us-ascii?Q?wK9mfN8KcSFLjWHqD862ako8K5ggv4jt4KIzdiqjzGCxf9a0EE0DaJyffxaT?=
 =?us-ascii?Q?dfS4rCTlzvVn7lQNfvid2jCjFPpL5K01HIYnrKvFFjYA2Tb/k/kao0GoBnBs?=
 =?us-ascii?Q?VEn2gffPb80+7Ml84Px+o2MyIcKA6Q4R4Uk/pzJHs9k8lKFCR7bb0kyv0e2r?=
 =?us-ascii?Q?a9WhoKjLxqzT7It7UlWOZ0SzfelcwRlZ4fOVk455VqlJITG3gkhixabf38SB?=
 =?us-ascii?Q?dqUtB6p1z0Absa6JUPiVwPElKgH0vgDzuPuF1ZRnBzXuAOfz4/WE5F+ZYhXe?=
 =?us-ascii?Q?TFxCSSiWfMHLG/Ks+I5OZ927z1+N923Z2IJnTRYlK/81Orv2Z/pffVdAtTlA?=
 =?us-ascii?Q?8eB9mrC0votFx3p4dyBEzy4Rbuuvq4wNdvdzQXGU15n7Z4ETnCAQ+rQIRmYc?=
 =?us-ascii?Q?dWvwKFt6bTMFIUYIz6eiqas5K1CqRAJpY8I5Xs4ZQIjvZdZy4dT6QuZ8rnC9?=
 =?us-ascii?Q?4EQZwQMrz/nJ1hz8m1MCXKwbvd5M9j+On1grRuip9vVoT8z5q+kSggyoGqaO?=
 =?us-ascii?Q?dJLZLWGzHL7Ys8mWGXgAUY5mr5bKsULMpffjvcc/YXxF1GL7rGpKGGAOXRrV?=
 =?us-ascii?Q?LqAlU32a31+IrNg/YKblnWkrqjtBQ9Qq0uD1n9qcuclHkJ4Kz7B3Nqqx+l7d?=
 =?us-ascii?Q?ZsvDiKNmEVqZtfAfk1Nsz9ufLmxudYpvmPBCAsIvkfWcZB2I6TrecIIY7Jls?=
 =?us-ascii?Q?SCEiaIU/Sx2ie+T5gXmdFMIhZn06PvXn33yo+GXz3RSttk8k1N/kQkkX8b22?=
 =?us-ascii?Q?le+ukIK5f6Z1LQPAvRzVoY97t+hFaXhsWWs+YAXJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45716466-747d-4163-2cef-08ddb307c61d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 10:13:33.5632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/yXtlxpDF7Dc1rdkVNJ6vyGNkdzPSGlK+kGELwEtKcKaXKVHTlXCkD28u53ocAFcmBhudHqDLx+oX+j2UhCDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8636

Some counters in enetc_port_counters are 32-bit registers, and some are
64-bit registers. But in the current driver, they are all read through
enetc_port_rd(), which can only read a 32-bit value. Therefore, separate
64-bit counters (enetc_pm_counters) from enetc_port_counters and use
enetc_port_rd64() to read the 64-bit statistics.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_ethtool.c  | 15 ++++++++++++++-
 drivers/net/ethernet/freescale/enetc/enetc_hw.h   |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 2e5cef646741..2c9aa94c8e3d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -142,7 +142,7 @@ static const struct {
 static const struct {
 	int reg;
 	char name[ETH_GSTRING_LEN] __nonstring;
-} enetc_port_counters[] = {
+} enetc_pm_counters[] = {
 	{ ENETC_PM_REOCT(0),	"MAC rx ethernet octets" },
 	{ ENETC_PM_RALN(0),	"MAC rx alignment errors" },
 	{ ENETC_PM_RXPF(0),	"MAC rx valid pause frames" },
@@ -194,6 +194,12 @@ static const struct {
 	{ ENETC_PM_TSCOL(0),	"MAC tx single collisions" },
 	{ ENETC_PM_TLCOL(0),	"MAC tx late collisions" },
 	{ ENETC_PM_TECOL(0),	"MAC tx excessive collisions" },
+};
+
+static const struct {
+	int reg;
+	char name[ETH_GSTRING_LEN] __nonstring;
+} enetc_port_counters[] = {
 	{ ENETC_UFDMF,		"SI MAC nomatch u-cast discards" },
 	{ ENETC_MFDMF,		"SI MAC nomatch m-cast discards" },
 	{ ENETC_PBFDSIR,	"SI MAC nomatch b-cast discards" },
@@ -240,6 +246,7 @@ static int enetc_get_sset_count(struct net_device *ndev, int sset)
 		return len;
 
 	len += ARRAY_SIZE(enetc_port_counters);
+	len += ARRAY_SIZE(enetc_pm_counters);
 
 	return len;
 }
@@ -266,6 +273,9 @@ static void enetc_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 		for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
 			ethtool_cpy(&data, enetc_port_counters[i].name);
 
+		for (i = 0; i < ARRAY_SIZE(enetc_pm_counters); i++)
+			ethtool_cpy(&data, enetc_pm_counters[i].name);
+
 		break;
 	}
 }
@@ -302,6 +312,9 @@ static void enetc_get_ethtool_stats(struct net_device *ndev,
 
 	for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
 		data[o++] = enetc_port_rd(hw, enetc_port_counters[i].reg);
+
+	for (i = 0; i < ARRAY_SIZE(enetc_pm_counters); i++)
+		data[o++] = enetc_port_rd64(hw, enetc_pm_counters[i].reg);
 }
 
 static void enetc_pause_stats(struct enetc_hw *hw, int mac,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index cb26f185f52f..d4bbb07199c5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -536,6 +536,7 @@ static inline u64 _enetc_rd_reg64_wa(void __iomem *reg)
 /* port register accessors - PF only */
 #define enetc_port_rd(hw, off)		enetc_rd_reg((hw)->port + (off))
 #define enetc_port_wr(hw, off, val)	enetc_wr_reg((hw)->port + (off), val)
+#define enetc_port_rd64(hw, off)	_enetc_rd_reg64_wa((hw)->port + (off))
 #define enetc_port_rd_mdio(hw, off)	_enetc_rd_mdio_reg_wa((hw)->port + (off))
 #define enetc_port_wr_mdio(hw, off, val)	_enetc_wr_mdio_reg_wa(\
 							(hw)->port + (off), val)
-- 
2.34.1


