Return-Path: <netdev+bounces-207386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF39DB06F65
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF5F1A6046D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B8228DEF0;
	Wed, 16 Jul 2025 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LGTsYc3H"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013019.outbound.protection.outlook.com [40.107.162.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE066273FD;
	Wed, 16 Jul 2025 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652263; cv=fail; b=svUoVGwAVI0yWKGk8pIczMyMtfUTlVi8ZOEjjaJcv0aIBpuLES8BMG6pLejJke2Xo/kFbnslUngHncnKPRrS06HFL/zoh0RhchFBULOy8OKqSjxryBsokpHd2JXF14gB5++vSuFXsg6/Yjn2VzS0egFlXNIKQFKe3j+DoiTMqN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652263; c=relaxed/simple;
	bh=dC8MR3VeUHqHHk8XDjJkoMaG5X3ywzi3vFrkAW/xUt4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PkIWP0jRp+T6YZmzUMWMJ3+/xVgiCXOD+vto4nn4JTtEjhLxM9VIj7pE191hAC2E9QE8Ub4sapFOzDp+70TDv7voRNQKyhLfwPaYbZAsRilTDeCilK8rtrcRWvGtW3E7y0TsQ4qBJgldpWVBKzKgQz8TJmVf3B/Pa6La7JR+V6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LGTsYc3H; arc=fail smtp.client-ip=40.107.162.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bc437x5BgVmepBsYoyXsCmtaXAcZlUDS9rTMdWXKFfwWooagFBi7iQameXZzKfCdVNidqgslAEtrySUlsWBae0IQg6TGWIE7wW4CcjAq1aQGhm4cy4QIPb1h3YGW7NtNhylJOXBfk7GeAWqrpb8b+X5sCdpCFp2b37xxHWWy/+VJJ9U2V9HR3TlOWZTFy+tbV5iVDTGhgpgWF14DEkmCoA1OH9Ddhb9A5qOB7WzFv7SQmzw/GfsqiEUejI/EB4qyzsiLWZvKRvSBq3WKsiFipGVkPDbMhbDB2Ztug8yhYbmooEvEas8SJ4ozxz4Cgoyn0d4unuo8iAJeiLKwpeuKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31mKZHTk1k0FTlQQ2Gtp0qLtjF0Q/uhZSTFWj5JKkx0=;
 b=Yze7SRZcpJMiDqlFrUhlXqi+Equ739pjOtP8LSDRGrdN7v/01o3RuONx+SKV19YUf8lhXUh/3zVdFxIEwI/P9jDnKr+xq3eg3w55XjtGM7Ocx3XLJw6SQk17kTpFZNkcOG4ELOPUmPEu+QqQu+7F0CHgwcXJOBZHkjFHAN7S95tQf4YSvn+jMdQFKQW3yvtWwLlvSa3sUJq8mstbdnpCuTxlbXYPwbVvUp0PmoDPbROoVjJ7vSOeEInfbR4DxUBI7DpWHdhyf5JRPYsGPjSNA/tMoGPsH/SZwpAW4+I04xRTn4HKgIqrcQNkeJ5HlkTLeABRAqAbLlg7IVe0P0PeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31mKZHTk1k0FTlQQ2Gtp0qLtjF0Q/uhZSTFWj5JKkx0=;
 b=LGTsYc3HsoVTBWLcViPF4XWlsdYVIiaTnaVEJkxvUfyW00LBjk6sxOv/qIbRQjMbHGdkE6gL1ffJtg+f0f9iXwZqwpf00KIkdil0FwUwq8XG9FLKHVs7qhHm1lXwqgxCOYNsGHqOlTbO1GZUvzvDjP55WXqjZZaCwjx+VEsLNeD7VGcPSv7q0k9j0+FkKDQHda5++9V6jiCGeyVJjs8AwshGrvFN5HPAqaRMT/3Gr0O0AoGuk+dbuFe3p6DYoLZr23cD2yBjcCRmz0XTA+KPUGdWQ6l7MB0bH4+1zDXo5RfLzXS9nhx+ATxBqbIofh43UB1vaDSe0QVvIIIdtbiNVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:50:58 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:50:57 +0000
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
Subject: [PATCH v2 net-next 00/14] Add NETC Timer PTP driver and add PTP support for i.MX95
Date: Wed, 16 Jul 2025 15:30:57 +0800
Message-Id: <20250716073111.367382-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb0bc22-99e2-4912-93fd-08ddc43d7ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BEoQdkN5wa43ZrEuwW0Q3m9oiUhmfKhPN7/AxVtGSCACzxluRwn3Kj5wBKsm?=
 =?us-ascii?Q?saTrg+1WII19LOC+UWnSlWwI+HhxZabOCmCx8x8f8YePw5xo9myOBbcymIMJ?=
 =?us-ascii?Q?IUNhqzCwEyvtiJ4BdobfbE/gPOUJkVkFJ4CsD8poH61y7EgQH5agPJK44D0m?=
 =?us-ascii?Q?YA/S6DmC9dJ1OckgHirizr2hHqZkbmmvA0qZxT/xkjfH7UbsBB8raoH+gv3x?=
 =?us-ascii?Q?5H2helgPGKH/IAWCeLRbyEwiUByDTd/76uJT9xGkNrT2YK3Gjmh/eMw3r2nz?=
 =?us-ascii?Q?k/+2aWPFR3U3YgBK53hXXEVE0Zo1gc8OqWBqH0O2Mj2JxDBqy1Cqr1IhYGZ5?=
 =?us-ascii?Q?YKzBKh1J2pJA/6wSQnskJpn7H5QVp9rh9XzfdpAE07Q1S4SoB8D3tGSUOqUY?=
 =?us-ascii?Q?OAOXNqSWBVxx99k8OIe47AkNBXOfv/hSBJTnz2MsZB0eNgDQrONGTHJPVxBU?=
 =?us-ascii?Q?eKPNHG0i/tBEh1BLiyImoj4OQETD3pHsy8RcC3Dk0sYwG9KgEY1ugqXZPxgr?=
 =?us-ascii?Q?QTNjcC2ypljO/9UQc1OkzbpuELX+O1PeFI3WvVr0Z5Ff+mfnIpsVk2AT63t5?=
 =?us-ascii?Q?4bDDIkpGcmwQEhjWQ8hXSt33N/jy5MybrmbrsI2UU9ue0Mr4HuoUOC1vioD6?=
 =?us-ascii?Q?KQlxF+bFbqxDg/j1nuezZ0o1LapobSBzB6iqMXK9J/MYHD+oSUsVz70Zvzhb?=
 =?us-ascii?Q?TnRQ0SGkzly2feAQF/kpi/Mb13IgPn60+Fql1ltBF30OO2wIn7+mx5vgwa32?=
 =?us-ascii?Q?DUJkna0WRO9jVfVZ+NAcOJF18B+0qtNlIy0LfKrpuWy4fb6XFZ1Z3JZdf+Up?=
 =?us-ascii?Q?YROBPuiDLs01wr3JyN0n/QE4JgFe3eyLW4r4QRUDFb8urlefk3E/AHHdcre6?=
 =?us-ascii?Q?nrMlAaAVvn5HksQPP3Vw1HT07usUX6j5OhUX4tBDH9sr0vo98Wxsz1IuEe7X?=
 =?us-ascii?Q?AHUHKsOw5EUzbEop/QhGRuw30TWisVEyXJ1XYxLKmDigIRJwix4Cl9I8Oo+I?=
 =?us-ascii?Q?Q6E+Oj6SzyGFTqFVesJwAk6rw1R6OR1/hL8LiK1fGESzhtlJLB6yc8CpLn5I?=
 =?us-ascii?Q?b9IelZfWLnwSnsQanzkzogp8ojdNYpDwcVYNPH+80tJUfSgOksaCpGQ3wrs2?=
 =?us-ascii?Q?dXOM/kByvMmb+Vl4NzqaSa2gIJ4CEDbksjPoJkL/1T5JFn25dsbC28ZknL68?=
 =?us-ascii?Q?g/6evcWFn3qtIbGHRtmGuNQgowS2VVsJMMJDHSLq7iIU2+nsB5fw5Co+559X?=
 =?us-ascii?Q?104kg7qVngvAHtmSFsnNaBVXpiVBnYrr8IUQn2Ghfr7hvZNZctUBhnveNqsd?=
 =?us-ascii?Q?g7bp4I7nSzzUUykHUXey9VkgKhf/XHdKtGhliQ+Ark/My6ollI+6xbtRx/cV?=
 =?us-ascii?Q?jAHTEb48wcWSoQ4/fHdfrikSpHKmFgUFCG2KqQVOPXVfgwlNe7fCPQy6LNlW?=
 =?us-ascii?Q?0g3rtc9ohTz4Umz9tWClZgJcfPvj75V8c+4RJF+ncudiIJqSldpX97pYXz9X?=
 =?us-ascii?Q?twbYBVCnVFFmIXM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RxOTKHdj7ErUGXinhV3ngwozmNKywVJBAmmBoByn4DsyOzz5cYyax1PFFrlP?=
 =?us-ascii?Q?ofNX2bP1cSqG5b8qy6oKZoDR+PkIlOMLge5prQyk8zMU9373E+U9yWlz8EyD?=
 =?us-ascii?Q?+CXMmFQd70yiIcnHj76oOmOCVfMjSCa6BCRdh+IwXo1U/yS8dkP4F76yrH42?=
 =?us-ascii?Q?oVSUvtcbxQA6Fj3NGe/6MxifkZOJsO9eTukK3z0DZpD8L9C3s7wBLzDxtZyi?=
 =?us-ascii?Q?70Zvi/fnbJJCGo2sQAXeat6Kmf5GYzuoMtK3HFbgTDmR+Xmbesid1qOh2M8b?=
 =?us-ascii?Q?GPwZMHDreQ7erPNg9idI9o8/riAO3OZrI/99ziRq/eaUsLd7NGq3YdzdlXVy?=
 =?us-ascii?Q?u2GpKJigFxDiO6Xez5SVwpNLr+czRtOZX3KAC1afDo+G5KGV0sfdTuQs5Ixd?=
 =?us-ascii?Q?6vd78UjixCyCNUwGJ7gnFYvhrmeNPSmGsu769X+XX2Huedg7u7INuyISPEpq?=
 =?us-ascii?Q?BVTtyi8Xb/wa9q5w5kGGYIfvzI/txV3XOLQKOA25ad/KoM38t7nHhgrV6eMA?=
 =?us-ascii?Q?2sfEkSoeuPduji7I4DK5bQ7N6whJXdAOUhZ6cRliLsGMT5HGUH8KC+suZWqL?=
 =?us-ascii?Q?+UwMsrTSYkoRmnJtsUm2K/iQXEEom/QnzOB8qU22ZL8XYWdg281wJrNRQdMV?=
 =?us-ascii?Q?VTfXiAhqdHK1Yfee4wyk2uQSg6ZFJ6rh/p1PNI5L18QF3UYPkTNCP7RnzfRz?=
 =?us-ascii?Q?DMEchlfAuKoQ3RYv+eDjSaAN+ZSX1cIaVrCtmxciqPVMULZ1UrTjy3NV6TaB?=
 =?us-ascii?Q?0ZU46fAy4o1I1Eyu9hCTIoe8L/p0SyJmmCA9dg/IKfBbzjeh5ZCjkNUctOqo?=
 =?us-ascii?Q?gMOu5oyFbcwKCSSAXRgsoe44NdwHq89HhIJeVxJUAjqyan9/nMNxyBFXrjLm?=
 =?us-ascii?Q?XxcPjbV943bgKg2YGqDyQy8T1V67onxyUtflUKCkTT1SwRgdYLfbblNNtGfS?=
 =?us-ascii?Q?cSrAIePfPPsob1MK3gTDv1NAHh03Myp5e7QusWVndBF5Ws1CQXDxsTja436T?=
 =?us-ascii?Q?1kX5jWqmd0524WfnkesV/UlPp0LiFrsIIWrElLShZrKIwnSDIdPlsbyD1FXr?=
 =?us-ascii?Q?RzdwRRXI1L5XWfaLDo9dfD62wwJ8WRbib8cuoLW5+8oCAHlhr50e3/i90Z0v?=
 =?us-ascii?Q?bSb/8l/3bVnadqRR3CzuuQBB4fD1z0+ZDQGfCqz5Bgd/SWI+nEa4bFd5zbQF?=
 =?us-ascii?Q?+K2+rNwC2Gla7+uXj1jD+kkfdg9zshV51i0IOLnxDkoV67/YOceCM2qnOWgR?=
 =?us-ascii?Q?t8QYdFxegKn1Snigm+RbUhMDFEtlxSUSSiXTIa3uRjgP568I0kDNl0hoZVW8?=
 =?us-ascii?Q?xl5tpVLQghpTy25zvZNWHkMZl26lrebUUahBNoiroAG0VmbmtO8T+kmd06xM?=
 =?us-ascii?Q?wfTAs2GvqELInmGwCeVk252Te5FLx8c/SNUPXCoBw/qthAMX4wx5teBHbkLH?=
 =?us-ascii?Q?dLdzisyRPN4X37/SQ8rmWn6adgYRWfPY+kHrKQoyQRJpyHpJGp7A0V/ih8ol?=
 =?us-ascii?Q?eSenFPVWWkptz0wT6CYk+joCPKKMbac3a6IHnEqYYZUkFoSvLgPUfttUb6po?=
 =?us-ascii?Q?ifCzz0V+5MUotCWI7QgWtxFzT4LWJOu+kTEeokei?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb0bc22-99e2-4912-93fd-08ddc43d7ff2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:50:57.8276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CyM93RP6tFHGg+tIkidUeGozeEH8hZ9rc/zn1rwk5LHUuQpd2K3DIVFmrYyX5wQifzA8Gc60VhEc60KNcW0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708

This series adds NETC Timer PTP clock driver, which supports precise
periodic pulse, time capture on external pulse and PTP synchronization.
It also adds PTP support to the enetc v4 driver for i.MX95 and optimizes
the PTP-related code in the enetc driver.

---
v1 link: https://lore.kernel.org/imx/20250711065748.250159-1-wei.fang@nxp.com/
---

F.S. Peng (1):
  ptp: netc: add external trigger stamp support

Wei Fang (13):
  dt-bindings: ptp: add NETC Timer PTP clock
  dt-bindings: net: add nxp,netc-timer property
  ptp: netc: add NETC Timer PTP driver support
  ptp: netc: add PTP_CLK_REQ_PPS support
  ptp: netc: add periodic pulse output support
  ptp: netc: add debugfs support to loop back pulse signal
  MAINTAINERS: add NETC Timer PTP clock driver section
  net: enetc: save the parsed information of PTP packet to skb->cb
  net: enetc: Add enetc_update_ptp_sync_msg() to process PTP sync packet
  net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
  net: enetc: add PTP synchronization support for ENETC v4
  net: enetc: don't update sync packet checksum if checksum offload is
    used
  arm64: dts: imx95: Add NETC Timer support

 .../devicetree/bindings/net/fsl,enetc.yaml    |   23 +
 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml |   67 +
 MAINTAINERS                                   |    9 +
 .../boot/dts/freescale/imx95-19x19-evk.dts    |    4 +
 arch/arm64/boot/dts/freescale/imx95.dtsi      |    1 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  209 +--
 drivers/net/ethernet/freescale/enetc/enetc.h  |   21 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |    6 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |    3 +
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   92 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |    1 +
 drivers/ptp/Kconfig                           |   11 +
 drivers/ptp/Makefile                          |    1 +
 drivers/ptp/ptp_netc.c                        | 1193 +++++++++++++++++
 include/linux/fsl/netc_global.h               |   12 +-
 15 files changed, 1551 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
 create mode 100644 drivers/ptp/ptp_netc.c

-- 
2.34.1


