Return-Path: <netdev+bounces-214957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C085B2C497
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96137A019FB
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF042343203;
	Tue, 19 Aug 2025 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KjbQ+ILD"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E643431E7;
	Tue, 19 Aug 2025 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608361; cv=fail; b=SjyTM1BIZwFHcKVJaAty/JE9dN+VwLCJypa5jfezH2tXy/WrjhqBP+bqBOmmEP+lw/P1jloN45J9DI02FsQ6/9TkPvy9gqwM2ObvgKd64ktOfONgIfXh8NBpR2NSCSSzFOZ4td8czcmDINSj9praHKMtM+c0VoYVGMZUphiL514=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608361; c=relaxed/simple;
	bh=rpovMsqhc8fb1+G3XzblrNPPmuktOC5I+MCsG7WYO6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DiPsVfBcQOQI+r2k7zp4ZG3xDo2nY17BUtysTQmgLBRZG6JxtZgwuAWfeTaz5HC71Z9ZII4FiLaOIT/W0ocu6L/sCajtwcMI/jcvLX/ZgignfazsIPs2ChObPMdROpJOSqbSok5daqWQVDX9GPwkbBmHmhhPSamROFdn668+3N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KjbQ+ILD; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcXE2Kd3lGt/rV8q0e4xc4sLvCTCP8o+WUmev82gHFYUP1pI6/Si7LoQObVfPPvNUUulif8b1v2h0ZA6zYPfOE6UdrXnuvmTHWmRPNhnP5CeV+mll9Nn41Jxoj8h7lYvIm08hOk8zI6T/3ooPwbfqCaPZW7+FL4eQELSjd9W/lk4SifwFqgQf8lle9hcR8pm5mAgJEcDRkgDAjZAigYXzPy+dD1G9W8UsMH7rAZGwPkNHSSbPgZAgtpaK3luzY7zI9eLIWZBZqtMG3TjyBRZSC7aNLHfitvw7t/2deb9ET+bKPlAJ+lb+QF60Bx+xryP8w8VmhDXCS8ce68aPiq+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b54Tjp1PPMnlGycC71GgOy2ejiXijwXn342M9CxBBQI=;
 b=PS8IXEOhHuflj4uTIZq5WBzfPcWNXuA9t4mCX1Dg4HCXihuJoyns43wQ/8dd8/D87YginewnDWfV6Weekw/mwj2O2zdYbrD4uuiyGeW+YcSo5Znz1HbvuRXfMdm8c+s8ATlX5bMb9DxYVRqM6ZgTjBQEzmKWr+0JHOHxo/b1z7Be8nTm9n859kqizQ4BuA8t1A58/AwcyxUn2setBoSMfGcXZxjUB1yVCC2+/G4nufl6/qHwaPUc8+wUUA0+cq9/8UCGgCv8uuqVmOX/0aL2V+E8tMx96tjdf6agY8+1o4rMScNHLwsfXNUWnPRKrAIAGzbOlF2mhf/5V5BadXQTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b54Tjp1PPMnlGycC71GgOy2ejiXijwXn342M9CxBBQI=;
 b=KjbQ+ILDbbmod2tDdIY0KbIll3E8Gb54B/vfKA9YcLqt29qqal8g+RewoeewFHSat6PhUnBJzzG/f5s7R0+MPjI2CI6gBQFPC7QKnSMDK0NYG2rslyLNXv+/dXfObyJaRCaBKPEWFj2Q/9N+KTZHe84A0WAjG5FKVMPPIV/fytdxWgkLTALPtBfHoudIHtEt8cnhOzWSaI1VW/I2gOXEZoF7hMbgZRbIvpVztTxDTIRXwDqxVFBFgcVkARY9QjFKYGLriLBwGuIzvvvS7PkfY7dmxVkmud1fjy1Oy9U/DKZt9BvE47czEbFXtCUXqzjjDAZDof8AhGXQE5ixi5Psxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 12:59:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:59:16 +0000
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
Subject: [PATCH v4 net-next 09/15] MAINTAINERS: add NETC Timer PTP clock driver section
Date: Tue, 19 Aug 2025 20:36:14 +0800
Message-Id: <20250819123620.916637-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819123620.916637-1-wei.fang@nxp.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e43dbfc-ca90-4b73-5996-08dddf2033f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uGC8lQ3QLgH8IsC9UxWFZvHroBLEgfIWwSgOACkCo1FqPi1nrXoxcpRnd0xX?=
 =?us-ascii?Q?TkIWpE6wQkbh8fqTxkeIuyy8IF5diUzAGDDbayQI+ibjOpWMPpb7aN88bAwp?=
 =?us-ascii?Q?+sH4YdXWfo1XknQuF5X1wLMkEX7opEDZOjt/IMtvEx9aiusZuFPW7p99QTuf?=
 =?us-ascii?Q?UqVIy/ux6ekz0sbYWbRrXY5USswkJJRqBuV4hXF4s2873EXa33iKFEajeJKz?=
 =?us-ascii?Q?xh6gHV6AZJGmhHbT3pVJxawl03IcpKG3KqOUvKEdpbMSEwNCakOcs2hzc/ey?=
 =?us-ascii?Q?VgK3foxlGir5s40mH4UTBNsuXKxnEo66eFBf/H3sAwJ+oFPkVGCDT/8Kjo9C?=
 =?us-ascii?Q?9VotIh9oefOg/w1pq+vcUi+WGphX9e18ry1U7YXRI6Hpodj8q9lSd9B137gh?=
 =?us-ascii?Q?RLD9/Bo49Fi0sD8qR3QNgqMcGQbZwMBukD/oWvgaO0hI0/hAJd1xvtt39sZO?=
 =?us-ascii?Q?J2V28mD+lpeXAREaNgJcaICBznCr78ZFiYV3KhZ6GTgZT8TK4TO30pgQsiEc?=
 =?us-ascii?Q?ZsfNe3v6PjNZXB42xAHIg6FPsx/oSN2IDdmik1ERffRNQZNs2eEB9YF0PMRB?=
 =?us-ascii?Q?S+MKlvaLpFTpWJG1GUFCzSDcPs7WZOdBQOJIm+7MHa6H98zBgTLH90nZCFpf?=
 =?us-ascii?Q?fkKK8wqX9dAvLnWtEQhlEqIMCZLkV+zMU9QWZfVR7OOvELbqjIJwpV/HCdpg?=
 =?us-ascii?Q?gWgYZHjVj9LEIoYE53TlUzVtBfshSQoukIR1VbeZDDWfeR/m8deATuvNVcs5?=
 =?us-ascii?Q?UcCjY4U7ANu58sg4QZR9+FZk2Yk632lp2ujnQmk4ewqc8U0rLTZY1L1qwGcE?=
 =?us-ascii?Q?p4SZ1gND5lOabrJdx1jnAWJFA0OjfGanFNwjMv8SMxLflKbKFto60YzkQatA?=
 =?us-ascii?Q?xnbNA8qBuBirJCzu2qhLdziKwj+VTGrC5XO5Qw3zBgL8fXA8iC+ztNTTFS2x?=
 =?us-ascii?Q?3OH4zbyDB+HdGZoXtgoVkOgL53Aba11nhYdrbA16Bqvd3hKq5CsedkVBu35y?=
 =?us-ascii?Q?8a2LKI9UVEbIYn748gwLmVzFLJ+b6tPmiZ0gkWrwg91wIG2rkZZbKwB1mBb7?=
 =?us-ascii?Q?iEu+3RKJfPzBtRcGzlHx1IcVgRyr9HSBhYzK3ig4uluptbtlhYKyz3e8Ky6u?=
 =?us-ascii?Q?pzyVhPWP1dSVFQkoJxHVOrGVLCdPfHY6GVL4u7EIyyZzLnqdGwHoRzT9cJhf?=
 =?us-ascii?Q?QXamJMFj0EcPQdKYe7vkfP9/dFxxNoTYfC7YWX9kYu3CrdvCCDEoc/CvdjeT?=
 =?us-ascii?Q?zT9OTZ62VXwoSaVnMieN7lnn6DHwTeRb8m1UFBsiNstDF7HZGbYl1vs0axiF?=
 =?us-ascii?Q?yePBMts51WRBTmktp4VsN/OQHWRNfDBx4YO5tXxKaFizPF8xtlb9tepGRFr+?=
 =?us-ascii?Q?ub1WcvAtHjhsexkFVq3sBwiTbqGjU48pbH0XCPvA/hzVlzK0z47BbM482O+W?=
 =?us-ascii?Q?PeopeWv9K1Bq9J+mtvg381JtHsOtz3JpEM/keoYCVN5JZS6o7w1o5oJa6t+4?=
 =?us-ascii?Q?iy2gjMfBMw85ZOI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zEz98kAW/0XtDxwqkmAOGgtYLWr1AAZCxFibJq+Dd+RDNJGTN3BgzphMtyT3?=
 =?us-ascii?Q?Dfz4ijqppR6+z/p11RQvfRIWmtglIgnt6JTdBFm7ikLxCQWu7iq2tpQ3bP+G?=
 =?us-ascii?Q?eYzWbCJNAmjzvN/gRgYF+B1us2jzGWMGx5zrD8Ybd8OJ70S5Qnd1yF0FS+uz?=
 =?us-ascii?Q?/Sra+Rn+obCjRucx65y65SF1p7RJO3zbf8PXfYcBtPb5q9DCPs3GEaWlzF8n?=
 =?us-ascii?Q?MTa8yi5HOlDDlhIp/Axu5rwLTxwjEJtLiCKv6S09gu2hgbJpvjk8dMImz+KF?=
 =?us-ascii?Q?sHv7ec6uaCaxles3gZzz0/tjZMXsOARqC7uAisBylpNNvYPoRKlRZekmoFIg?=
 =?us-ascii?Q?4bWlDZqFuZ3NUxx9FJQE/O1ak6jVGKc04RbTO6DDyqvjma+pTjepiPGAWopX?=
 =?us-ascii?Q?6B3ly55gx5aX2T+Fd0lib2sgOAL89Ryoik0amwdt23sWEPJ2Tuey5gyDdyXo?=
 =?us-ascii?Q?mahVWi7u/t7Uerly3+4aH9RdEQrAaXS1xwTRpTdn6F7OolthX051ICiSNJ/B?=
 =?us-ascii?Q?5j61CZfoNjM82VyclzHHDGbahGFkxhqySpBaBgnefPKuvuUSyi/z2Q7jappr?=
 =?us-ascii?Q?8KzWFfPJU9y6beH8TBRizhFNu3UumbVJP1BLFtehV0OKXof4xmJxZ/UXEgeg?=
 =?us-ascii?Q?d/dZyQnfQG6I+KDpEMLXYZCz6CcUks+iv75jDl5bADB84n0nPBuZc2259FVd?=
 =?us-ascii?Q?Fba4vbz64Xmwo29m4G889i3Ir0UuxYCeoyuUgJIIcBCHtcSkIWZhfMkjZgWi?=
 =?us-ascii?Q?LBG5Z+SABDqOjm1TqZZ1o3T8U6kNEtOIiWTOFkmmM4nQbs6oxOX0t+Maijam?=
 =?us-ascii?Q?gM4COYUPLozzUacofFkENJgVLkfdhQjL0/PQ0/YPtajSfzvff5PNqnQoijNJ?=
 =?us-ascii?Q?kGeaRzxQGD/5exNqGMALXbXY54508g/Bo5yNQKh1pldBPJo2NOglzQLrzrUY?=
 =?us-ascii?Q?uRSjw3kIGJw4ukqT8UPdxHiFDqISsLCiJJzgXJHmGCmOdronGV+ihAKLCdst?=
 =?us-ascii?Q?PRopvAx5dskKOisu1NALLW44AQnz1XgTjTEEhuJUQzNtmzr67T2aqiBXB7eK?=
 =?us-ascii?Q?GqBl6jxQFqGAmEhplOzLx2rSnSBeziC9PeJfaJCqdD1A6W0MFnwi9EQPYfOI?=
 =?us-ascii?Q?/mMA0gItPGcLsLJBAlJ20wv0aAu9a6FyfG9GNbRwJpr62I83OpYBbuYzYzed?=
 =?us-ascii?Q?WT7SQCgawF3KlGgV3NOZO49T5Rq3HK4GtunQy+0ZPWaH3wZm3wFNqXMNU0jC?=
 =?us-ascii?Q?u567TAWiwNara0cm0E7OoVJ9+v65kG54v3gFlhsRbDvBb2Yr7PaMvjN0oubq?=
 =?us-ascii?Q?1U2DQgkMQwdB6z40ah3RflPWBqtSinvzxSDjK2gOdpedfo4SiweHEPwiaFDX?=
 =?us-ascii?Q?QqpNkihYoEbXYfPMyJIRo6dEwLDc0xjzxuE/dRo2tRJG6bIt8S90vT1p3ZAg?=
 =?us-ascii?Q?W/QcDfC7Ej4FORyzmI8HxZIZ1LYid9VZkaHbPmycAIZW2GLrVctHW8pO++2a?=
 =?us-ascii?Q?x4zmDFn8CYbydqE2rs1hkXe+1q3XCq3fOgJwFmu4qif5W6+iqoYhpRAd0SEz?=
 =?us-ascii?Q?cJQkjXCGMzs4obk7XHgZ0757rI9DTen2118l35Lv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e43dbfc-ca90-4b73-5996-08dddf2033f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:59:16.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDa1VBYypweOBp5Z5/itjVUyGlQSYgYI8exCHml+zNiOcApsHndhT7eXm3t5gGvFu6MUgGgb84z/RTs+EfcJYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

Add a section entry for NXP NETC Timer PTP clock driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v2,v3: no changes, just collect Reviewed-by tag
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4dcce7a5894b..336043ee3ebc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18263,6 +18263,15 @@ F:	Documentation/devicetree/bindings/clock/*imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/*imx*
 
+NXP NETC TIMER PTP CLOCK DRIVER
+M:	Wei Fang <wei.fang@nxp.com>
+M:	Clark Wang <xiaoning.wang@nxp.com>
+L:	imx@lists.linux.dev
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
+F:	drivers/ptp/ptp_netc.c
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.34.1


