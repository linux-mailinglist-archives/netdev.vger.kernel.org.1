Return-Path: <netdev+bounces-239802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FA0C6C77C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7A814F3CE5
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA32E972B;
	Wed, 19 Nov 2025 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HkGy027+"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65CD2E92B3;
	Wed, 19 Nov 2025 02:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520691; cv=fail; b=AYvm2xhmHDXvCupcQF4wh6fD5JHsHo6rTGw6xGFdcraxngxWoxzAdd+pbTzeIRkGLNAlWlBrazDdno9qqgvEOPpdp6QFKsRFwplYCjEhYaQ+Td1tgxz/sz96i/ZKo0c69FxjUX4HYpP1qesJflmsp0GalG9L5SV8r+6ltFqoStk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520691; c=relaxed/simple;
	bh=2TaOIx0isLSzPsr3AgKeS1qkiKMLXV4YK3yxquxbdfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TsYSP3pT8QtvRZHCsgTntd4zsrcqT8hVH8Gx545QiHSSnq/2KA+JOFUAGI0KlojdqTMcaus5DmdeKjy1mB3jEtMGNCAdDtQyrcVj1JHGM7LiSSQTpacKc5jitdA+G6UgDZk7jxGFtaNTek2GIk4+yEERvhndgXntmsok2fNEMU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HkGy027+; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTqA5KJjtJh2/+e1frcrPEnfPBNX4cyZbGKKUYlFdBZ1HKxddcimfgPylmEmnp5EOgf/FWrsMZNzZCuQIZFqo7Q8p/9uPTTV/D+rnLmx9byfeJW6kVm31SYkH6ktOt7qic8j+fCE45QS68gFZefWlt3GWKPp0mOTzTah07AyB51GbdB+Sk6TyopGb8mznnkQWKuWD02vSC3zCiLXa6/DKo9EHCx1hzPy5ddbfdZVK0ZH569rNxhk7DdNXV9LWrnJ7WdYuIMF5unNVLn41OduppXuBY34WUYLBYM9RJFtTxaRPIqAw2P1VUGVUfvLluwMeaw04MsPmmd4dm9anj1sSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdOxRiNhXu9KPbgGJkZQhjFW0k6VUvginV88qo99rr4=;
 b=r6/8ipmJDoN0wFrmjjkeXb733R2LIW+0RZSdS6P5oVR04joMawPzpeblAKUYbzyxGcl+ahnYJgTVkYH1lnNShXnLnAi/32NPgJE46owk6+bPZdtEgmNb1nrDwqyulyvRW+cCkewZYuxll7MHARQ9ue9jdNfWMKXKHWj9cq/WXGONBp/VmFBXaHDKESjZ13ytEL5COBzHFR/xRJveSpCSR2AOKHAdK8R6u/kFWwuBnkTaovtE6VJ8A6S80bUuRSt7lbQzzBSn5tiMagmw/NiRlbumMtCQK7yYFF6qxCPnF4vXEfgJ3+u6GCCfeFczebkCYycGcRODU1WYOKhYkED9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdOxRiNhXu9KPbgGJkZQhjFW0k6VUvginV88qo99rr4=;
 b=HkGy027+TMQAYSwCFcgZkOl39jIa4bYTkHhnI3lUdjF3VxDi5Y725lpsZz1NCYbX8k8uld6rX1EI9ZTGX5gZViMCFzD6i7mpnv5r4L1GFQQTaZtVp16zsNfs/OjlvDD6T9qo5wtanVCye01MQDzRS0OHTJf5MCiiEto3QLL3qrXEKAAJ+TamhRCSb5UuXA9PfoFeNfkGrsRiHq0j2sIx2NuEJU2UirP5POl3sSEgX2ye78EhPP/4GoxdZ9RRJ/sDDNeDStb+Kraujbq7Otgmw7ua5n1FusjjdCBd57iUhcRfErLPx/uzqrzCx5j9ZEiHYMUqQrC7UwkrVqyFCP3YtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by OSKPR04MB11439.eurprd04.prod.outlook.com (2603:10a6:e10:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 19 Nov
 2025 02:51:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 02:51:25 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 5/5] net: fec: remove duplicate macros of the BD status
Date: Wed, 19 Nov 2025 10:51:48 +0800
Message-Id: <20251119025148.2817602-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119025148.2817602-1-wei.fang@nxp.com>
References: <20251119025148.2817602-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|OSKPR04MB11439:EE_
X-MS-Office365-Filtering-Correlation-Id: 47656d08-7e19-4dc8-7fd4-08de271687af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZvqjVXjkZ0yeWVMYXWadSWImhKT4RDszlcv0+11o179TRI79eLSKu7FauMzh?=
 =?us-ascii?Q?IPslX66WXTIZwX9RI1DrwdTd7ZMaUN2qToAZP3N7JXM+Ys4mOPkmHZTmfBFY?=
 =?us-ascii?Q?ze24EfbPTiY2JewjXBq4uRMiP+8YPFuVopEAaLO4VKX2fPmRo1EG5Wew776i?=
 =?us-ascii?Q?g3D3pyXJXW88zdSPVTIkoagR7lbfYAGfF1CQYc76A74hA6z1CbxqPudXGDzv?=
 =?us-ascii?Q?B6NhhSTXr0SxLsxe78/2SCWGys+2qqOtAZuwXIFjYtMyQ82junBI6lFQREf0?=
 =?us-ascii?Q?w9ZDJl3WDviuY412qrLTRxMYtnVdiP1RAUM4UQ4OPXADSINrH+0uKCW6i2uo?=
 =?us-ascii?Q?XDWRH2Mjb/0fgnbCf9VceEUIVPK0V16OtVA+jtx0DFW5dPL/U3WF+BF4cJkX?=
 =?us-ascii?Q?7wX4dXnOH6HVsISyL8pyVValhmhndF3DgVosMzPpPxrMQ3VXDHKrV10F/w3T?=
 =?us-ascii?Q?4E3wR+I3PJaaYH8nNCCAerrTPJV6COvzeUzm0JCctoCfdaixxLZhMbdsuvL9?=
 =?us-ascii?Q?EAbAg5c2nuVVyAkrcUXEyvLwBq7G4RVyFg0wUbrt//cj5hC0luHKA/snmkdP?=
 =?us-ascii?Q?WA/R3CNsE9cAIaAH1nfBfWZcTjhQX1Z8E8PtQhLuXj6yqUY4WTJkczLufIEe?=
 =?us-ascii?Q?SSyym0T/OiJFlUI8bDtBnX4wSRoMsYqCwnrCE5mydQFjlhXgIaX7uZrYYLHQ?=
 =?us-ascii?Q?vvYmPC3xrAutXgvI1ktMSP55Wdrfe7SGCRqjYk0uU61dfNP4ul7TA8xh3jkX?=
 =?us-ascii?Q?JdzCv0xna+sNP1wpLcRQca5X3xSc1thTTp1PdZ5XeuTNfy58sITmPkwV0EGA?=
 =?us-ascii?Q?xhMjRt385lXGYR6A1w6RvL5CfP98aerNpLLqaJpn/YNO8xSo+VggZfs2EC5V?=
 =?us-ascii?Q?/A17Y1alEuiG8LtA95hmYEgjqZm4mV9wLKkcRGdiD2plCy5dWgfj9gdCsSxM?=
 =?us-ascii?Q?EvxlevHFKDmJ9VD8jSG1NApLKyBcecV1/dlj1Wj9CSNG2KN78kV6/55VvTpS?=
 =?us-ascii?Q?NA2vlzaRagD+fJFO+MEdJgEC3FYXqeqDHn3/VKhJ3wvNALVZMPcSofdgbGIi?=
 =?us-ascii?Q?3JjTW3jnu0Wfq8ZmNzPPWMrJN5U+RFjT+HSS8Sw3d3MamSPy0MpCiJ1UWwRV?=
 =?us-ascii?Q?+H180C9Kii4qYzsUrknlYBwlPqvAIcIou4iLtVL8zxv+/8lZySMaclbI4sqJ?=
 =?us-ascii?Q?tINF8VGSgQjT0iSvHw9WC9HG220TTDVnHrDoF/dUu2Z/tl0KhJLW4e+xWoPH?=
 =?us-ascii?Q?oq1P68gAFE6BWlEeDJNX3aA4+dzaNdogzAt4VpcrkX6R0Nh513ZaP2L293bc?=
 =?us-ascii?Q?fkmwMLfvLwVXjq+9RyI0Dlkhy6bESIc2s9BQWI4FMLVJXjOXjxn6kv+JoJKO?=
 =?us-ascii?Q?zVse3VxAsN2HH3rfqwY1vs4XC+o+kMUcEiiK6lPy27YX9VkQMxm9nV7VdBJo?=
 =?us-ascii?Q?WYWbi5Knlt/066aMNpc8EX5JN+AxRL3pq2CCCdepaUQQyuzJkBGk/yLTkKmi?=
 =?us-ascii?Q?cWWgPlGFTP2dDFRQC5YMLO4k3rLRkq1pRlZm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7bymHqTOcu/Mb0ij0xZCSGLWuQDIvGpWLIsbehpxb9zCkaUhdpDMbipBgBeT?=
 =?us-ascii?Q?r959DAcZ8tM24PR0jK8555ksAgA+sDKOdbWzxiHzVrs5CzCcJSAZRx5ai8k0?=
 =?us-ascii?Q?KomFNxX9HdiiOl0j36sR1h/2Ozx/+Dzy3msw4bRPDsX7VjIHmQ+4PZGKgD63?=
 =?us-ascii?Q?986AcLI6TQvJIkQS1/4jY2kzM/oSAPhatxXWB/RSpjXBuT8o01j1Qjvu28hY?=
 =?us-ascii?Q?lgZUWlrrTheegiKkhvpkIO+JTUwcqJ/0GmpZt5zK/tV6KYdqW/lw/cvOjk1o?=
 =?us-ascii?Q?QnGhMCcRg3V8fZmTW932IZeEnd8oIUmLkbz0MKM6OAqQ1OgfH0BQJFX5YEg+?=
 =?us-ascii?Q?xNH5HCqLxhbqH1BnzZ/N9n7RVivFnjnkAdQwbgnlBI8ZhUL0DmuVqMR4G1nt?=
 =?us-ascii?Q?82WoNkYzZ0tw0jgjLFhqwPXMgySsGofBfVDZTqxqTaax/sAC5T4eMGsQMCZb?=
 =?us-ascii?Q?XUKVD1j0JwWY+7tqyzTAbX5SrNYX7MoMXpMUbArz15TImHl97YOEHgJkwIB9?=
 =?us-ascii?Q?EKQG2DSpnphA/HGmlGS2fLHkGX6oggin+DI+ESqez5avEcLETyL8TrD7fjEr?=
 =?us-ascii?Q?TPrTLUzowWQKh2/2qXGluMv98O0ZDSLLN+XOHEoBWAl8m9AcYUKB3MUcmuOr?=
 =?us-ascii?Q?UZtSwW6upVfdqHMP1FBJi6MjlEh7GtXu5D0Tj0nPzeaq2yK8uXZtQrWFA/Pq?=
 =?us-ascii?Q?BcZQ7BDCd2muLMqsF/nkpk2+6/kFEC8OcT6pqLyzZPeMHgPzFVIxkTG2d1HK?=
 =?us-ascii?Q?+Zq3+6S6hFwxzkCON6oriOyyomUqYK90UD/ihrl9Y2aP8AF4TlCNjCEIQxzF?=
 =?us-ascii?Q?9Lnb4QmEdC0F3meVrQc1c9KrAuzeG2KLFZzaOecNpUplcVikk+M6Gb+oz5qU?=
 =?us-ascii?Q?lWpWn2mbDgEs3wM6Tt82gj4mWwZclE9BmjvQ+KRSi21zhOjLkowDHwf0WTJ8?=
 =?us-ascii?Q?57yoLAwmU4LLZ1eqnTekrz+eYbOH0mZVmvn24XRawQGO75V7Omtc8ucVM+qd?=
 =?us-ascii?Q?TbqnW+VSqQiTpFshqGu06uKtQ2x6qkYS3aLH1d+j71tDiwP8uBVxG83HzSTA?=
 =?us-ascii?Q?TvOEINx9FkgpTQYJXhSpAsJ7C1lYeV0FMzs9uiMJaRUaOQjvFNsztTjiWvOe?=
 =?us-ascii?Q?Cm0T3u2Qz6JBOcUBqJoBCI8ixdGDTizVgJ12Nm94orTfkgYo46Cbl1CqF1dy?=
 =?us-ascii?Q?fo1XrTgnb8vyjW6aFDIIvqqEhEaqggBGPKDnJjljaxj1gOhbxjlxeNG//NvT?=
 =?us-ascii?Q?6HVPSWbswn+slGP6jVZKPKBcYiRVzCO6eQd0LQ+XG2eoKz1qSb3xpyINo5ez?=
 =?us-ascii?Q?dPGl7V3w93MpiDNFnkVOP3mG++jcjoRE89moVhYMNotnxZ3QFYFq2FrgAnHi?=
 =?us-ascii?Q?aHIaKN2b3zoBxiS2d29HXbTz2PJ8c42IkJpaKUPmVTD1DffZPHq7D5CXxNlx?=
 =?us-ascii?Q?rEys6qlp9sB4SPPnLW0IcrLaylVq435T83lt2e1xZuQbvi4IvpBAFVT+okIz?=
 =?us-ascii?Q?mP78JqimcZMKasrGs6dG+5T9EHOmNsAySxmjc6o5XZmGr1jLaqZaWqBIvD9f?=
 =?us-ascii?Q?s0LJMEbkuNhESsHektSZ9wz0z8icNuOOBf99fGc0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47656d08-7e19-4dc8-7fd4-08de271687af
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 02:51:25.4859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTQjfcYV/CShuQlQmKMNMfhsO0zHwTBs2hIW8V/Qyr6r8Bc0ciIqzrMPx/OllTMvzIpI9boGneNbMz4USsi+Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11439

There are two sets of macros used to define the status bits of TX and RX
BDs, one is the BD_SC_xx macros, the other one is the BD_ENET_xx macros.
For the BD_SC_xx macros, only BD_SC_WRAP is used in the driver. But the
BD_ENET_xx macros are more widely used in the driver, and they define
more bits of the BD status. Therefore, remove the BD_SC_xx macros from
now on.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 17 -----------------
 drivers/net/ethernet/freescale/fec_main.c |  8 ++++----
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index a25dca9c7d71..7b4d1fc8e7eb 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -240,23 +240,6 @@ struct bufdesc_ex {
 	__fec16 res0[4];
 };
 
-/*
- *	The following definitions courtesy of commproc.h, which where
- *	Copyright (c) 1997 Dan Malek (dmalek@jlc.net).
- */
-#define BD_SC_EMPTY	((ushort)0x8000)	/* Receive is empty */
-#define BD_SC_READY	((ushort)0x8000)	/* Transmit is ready */
-#define BD_SC_WRAP	((ushort)0x2000)	/* Last buffer descriptor */
-#define BD_SC_INTRPT	((ushort)0x1000)	/* Interrupt on change */
-#define BD_SC_CM	((ushort)0x0200)	/* Continuous mode */
-#define BD_SC_ID	((ushort)0x0100)	/* Rec'd too many idles */
-#define BD_SC_P		((ushort)0x0100)	/* xmt preamble */
-#define BD_SC_BR	((ushort)0x0020)	/* Break received */
-#define BD_SC_FR	((ushort)0x0010)	/* Framing error */
-#define BD_SC_PR	((ushort)0x0008)	/* Parity error */
-#define BD_SC_OV	((ushort)0x0002)	/* Overrun */
-#define BD_SC_CD	((ushort)0x0001)	/* ?? */
-
 /* Buffer descriptor control/status used by Ethernet receive.
  */
 #define BD_ENET_RX_EMPTY	((ushort)0x8000)
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c82be43b19ab..c685a5c0cc51 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1010,7 +1010,7 @@ static void fec_enet_bd_init(struct net_device *dev)
 
 		/* Set the last buffer to wrap */
 		bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
-		bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+		bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
 
 		rxq->bd.cur = rxq->bd.base;
 	}
@@ -1060,7 +1060,7 @@ static void fec_enet_bd_init(struct net_device *dev)
 
 		/* Set the last buffer to wrap */
 		bdp = fec_enet_get_prevdesc(bdp, &txq->bd);
-		bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+		bdp->cbd_sc |= cpu_to_fec16(BD_ENET_TX_WRAP);
 		txq->dirty_tx = bdp;
 	}
 }
@@ -3472,7 +3472,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 
 	/* Set the last buffer to wrap. */
 	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
-	bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
 	return 0;
 
  err_alloc:
@@ -3508,7 +3508,7 @@ fec_enet_alloc_txq_buffers(struct net_device *ndev, unsigned int queue)
 
 	/* Set the last buffer to wrap. */
 	bdp = fec_enet_get_prevdesc(bdp, &txq->bd);
-	bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
+	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_TX_WRAP);
 
 	return 0;
 
-- 
2.34.1


