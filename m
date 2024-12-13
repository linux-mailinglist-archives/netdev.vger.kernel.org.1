Return-Path: <netdev+bounces-151591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835619F02AA
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0DE1883136
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 02:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7C3502B1;
	Fri, 13 Dec 2024 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DWZr2evu"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789AD846F;
	Fri, 13 Dec 2024 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057214; cv=fail; b=TkoNb7sPa2jDSx3/f+kOFbcTvaae8cEVro8LFLksmeyE5GA/t1ojE2yRGU9kZP/5G9Hd12WzMPeVJKIRvCHrsInVkK+esnjTcR6GPnK6TfJzuAw+30gJL+XgLy/6iwPsVvBkGi8eqwqAaPRbucEtcEkbzFfK4p8UP+jJZPIJq88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057214; c=relaxed/simple;
	bh=M2sgLrpjgD+0e4nakcRqntqvgUEUaARxmkqeQgI4NHs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QJfvuLaeqhofGZSJGJnwsff6+VE3UnBSoNghiJ8RdRwHCL3rCA0eRgU6mPh5AGnddyw9HjXPz5fPcvjctsg/75YZDGTlAngtHDhpKTV7UxYzxDX8XodIrgoiEKWcwDQlDrlRfOgf3yh285JqnYTLyRuOp4Tlpry0WGA9cMk4Mbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DWZr2evu; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8WVXEP5OVGcEWECwitVcf1jgcnI2WEGfJEnJq+0mYOiDONIuQZzIwVR2yuqgP7HaUM97xncl9u5rvIe3Uj5k9bXAFgAK4ZDRKjVdz0B2j8nym0V0GGQdZrhAY8nZ2XdKKnx9x1+xCzRfiHkWrue+dr5902T/PeU7rGFTUJ/MGnYYe/TTPMF6qTTEcb/Lc8i6uZty7VE+gajEjPJPoNLRPgJU6RZrjvIlhpMk7qsx6RKpQbczIVMJsVBLTJugkuQp/w81A0gVFxSDNxM1QBUncGqkkhsQFQSVT17JdA3KIrEh1QrsDKiFHcRMTwrqkmXfjLAAGVmLcIS7fw+4i1EIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9z4PUByHRT8n9m8op5Qr86tgm08pfAXrPx5SBvujrQ=;
 b=A67TfOhsjmJF5X5yFLGIsODg0tQ4LhsYTHW2wmycu/2Ts/VHrcR1jZfyIWFlV+2P7UpEh8wtaIQFJYwY/uEYLiUlbtT8WNtu4pquTCpBWMcI/5Hh3myt+zqAP4ccR9Av6/mY4n7MZ1aSfJxlyQ9dPjp4nU++5H+zFSPdlXSdW/D+ucU2Zy6mSp/qfA6fQXcf2fOZ5UKWDjdTZr5NKzp/Cxb7tmcbnGkk4lYDhF2uVE5s8UJlUMEFFKSxnZcg9yv69ecjULYE81t4tO6lvCO1vQmCCr385FB8ftqPPG4tY223lY9cZ4kgVDndmlDEEfL7CTnOyn2tnKpUCb97smhOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9z4PUByHRT8n9m8op5Qr86tgm08pfAXrPx5SBvujrQ=;
 b=DWZr2evuvxg4JQl5RqLHDfpd72apKx1FaUe4fGh/R+heJWanhh93MuLJKnYvic5Gff58tTxH8+GeMWbnQV8Zj0tkOWFAtbK2mOo6/wy1dizpW4fUONjqx3rE7w8+FopElc2FkI3d2S8aLEMYHoG+QKhdtAkt+7W3mVbMLCpfhVzb6q9rit2/frsf1Bb6Cg4iiJOtSXe4vMM1GBSqxBFrP7KtXY/dFFliEVivd2rkFeKgcHkSyiIB5CVl/p75LHBn2cRySrS0zzxzamY+CH2kVeUpO5ErxzBYAwx5mHbjida0hWulmj5hrEBmkkXFcvr95ySlt4202H/pcBNYVLT/IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB7114.eurprd04.prod.outlook.com (2603:10a6:10:fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 02:33:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 02:33:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com,
	horms@kernel.org,
	idosch@idosch.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v8 net-next 0/4] Add more feautues for ENETC v4 - round 1
Date: Fri, 13 Dec 2024 10:17:27 +0800
Message-Id: <20241213021731.1157535-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 392c2b2e-4854-4e2a-01aa-08dd1b1e8663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A/eku28bygeR2TkDFqzvOBF3EX6xgqzA+zJw8XDUPBOo1VKo4ExY7vx9BTru?=
 =?us-ascii?Q?wDzfFsD4/JQlQ2XMqGqTvwYT4yXQG5EhpAfRT9qgq0hYHIuWiZOFwUQ4PCLk?=
 =?us-ascii?Q?CdMsvGP15HGfvGs1KoF+O1LgkhdUyKquFpLoJRBCrpI5rfAnqVVzi9Hl18zv?=
 =?us-ascii?Q?gL1Tadsiai88YiZBlKA0j5v5IB08uDw90Qqmql64uAxG5LTLTgc/YhpB2AFt?=
 =?us-ascii?Q?F+5QROV7o6Dj82hfj5eqOeLy4dCMF3KvOJ9HCgvZGldgvfk7KH51sXXmUZZg?=
 =?us-ascii?Q?anzz14jtUAdPmZdPGma2Zu7ZiTqLqISBwkoDfrfRLJDnifb+/2W5uTIpcwP1?=
 =?us-ascii?Q?q+7CgfwvSHgD0f2vfK6mQddQCW2HpZhwiPTtAfUtnZ9w1btwhUmRX7QukVVu?=
 =?us-ascii?Q?i3f7mWNN8mULaut9RRQ7nvZ2uSzLj9MoigR37E3AU3XrKV6ymvTXUgLOuqGy?=
 =?us-ascii?Q?vK6DSWVWoHwUrCiU0oIZGZd9dfIry8o+z51zAkQTJCwIhL+gEPSo9VrpuTx5?=
 =?us-ascii?Q?sYq9lTKMeOvEAe4SNXlUDu8+Tq85QzfYZGSsC5OVqqfH8KQKVdU6sWGGBp/n?=
 =?us-ascii?Q?X2ralVGhABuO1y2bF1M3Lw+WmelruH+AfX806qcyMkEgipkptJSd0utrUyvb?=
 =?us-ascii?Q?TH0reu9m5FwinSQm4e6GTtUaawIMY3uqktWcOKtMSqNAYpPno3ml4sPBZHCz?=
 =?us-ascii?Q?1s06u4+sJmlm9EvVOoWkdMv0Bb6Ez1j2VhXFJZ3rg5dNVr88du3RtRSdxRgO?=
 =?us-ascii?Q?aOxfMGThYURcDIzI5oZGUDgv6tmRQ/Wux+vuJ2hBQ77gF8j1tr/lJyh3YV58?=
 =?us-ascii?Q?ivV+1S6n5gx9p3bJpo9vW4wc70nx91PXvdSxVbEy5PZwVR3mt33YVYqMfsFN?=
 =?us-ascii?Q?OIV5r+29zhFN5etKj3f0O0awhLkrBr9vh/XwHD70sbmcbUiMdhTt8KKdD/el?=
 =?us-ascii?Q?LvPZEaeUiGG13MWFDz/r1jrLIS6gdJr7el4+DG9BzHFJwxfhlHdx1wdd6yYR?=
 =?us-ascii?Q?Rxu01duE+xKgNDj4Zl/O6VIvRJRFa3zszIhSLEpJiUHO538Xdza2GEZtpN5l?=
 =?us-ascii?Q?pPgWdrl+mzgbYi+oExrg26lbZR4amJypVeTsEOtc6cQeHU2P6rH2TGp/sagI?=
 =?us-ascii?Q?ZKLEZfY/KD4NmNlxztyCHrRz/VNZ1wLYSmjqLB47T3q1fsIcY0MKEkSmTezg?=
 =?us-ascii?Q?AVgZ4MyVBISA2LNhPuEIjmbXO1EfLQRUx6/m5bA0vEG3rUv2eLpV2z4n911K?=
 =?us-ascii?Q?IHdEbcPlv4l+k9uetk4oimHZx47FJgQhIYwMwVFakG7badrB1t8Y6C8pUL74?=
 =?us-ascii?Q?zzi564fukSK0rhGmfjPN8IUtx75U+XyzSXQhKn7fwWA93VLf2sYEW9PE1BSV?=
 =?us-ascii?Q?5RPP/2k3atIqFlTODmscERH8nIXsjfQT422+k0BlIAn7tLE+la1a0XStoVTv?=
 =?us-ascii?Q?2pmk/EK7dKs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OUrYrYyHVEQ9vZg7gr9ci0aaZrmSCWgSYg0LycVmPiGGd2U16fx4KS+NY/YT?=
 =?us-ascii?Q?5uFXoCvGfOt/ol+EqUaWdpXM5SxaDlFg05etGzvHxE9OUlQDeOWyB5yC8VAe?=
 =?us-ascii?Q?wYS61H0yz5jlnFfcWSudiOKa2jyAVWdiPGIySa/eLf1qxLdz7SYCYz4VI6mY?=
 =?us-ascii?Q?DzpDkwjc38leQMPBICHqhrDjCV3W+GMdHRCgLIBFd4vUerTXPsRWsz9cjHcd?=
 =?us-ascii?Q?iXnvdkMfwDiiEu7saNjZv3g+wTG3opAXt4CsnEy2euJ/q5D7DNHfO79R6xZK?=
 =?us-ascii?Q?WY5Njx1gpQ+WplP3eH+5zkzxgxuWmjsWkId0Pu2xVbguhSIbK1WW5uta/X+3?=
 =?us-ascii?Q?g9MWI/Bb0rG84ifh2bp1PQfFYkO9zqNxz/0lv5QED6nUZ8UGXEYHtRl3yJVa?=
 =?us-ascii?Q?Tbnzn74SAFe941WCdn0JT+J+g/kRsBWkLl2797zA15oxYlqiCkRj6u/LwXDm?=
 =?us-ascii?Q?GQsF9G7wLkTot1N/CnLMJlffnKkpIAt5PbigAh66vjxz3PCiCsKryE/GQc1i?=
 =?us-ascii?Q?ckO7G9Um5f8g6HK0wmB6cFnzwaP8eZVPHWEYB37LkN4hPxDzgUUOFxFxkpkX?=
 =?us-ascii?Q?8QkImNxl3GPKNy7b/UkoQTznnL9dkB0hVs3PQUO04KgyERth5pquuJr+btNT?=
 =?us-ascii?Q?uIbGqeXQBOKp7KZBj6M2GlsY0PEeRtfgicGsMFfYZltQbu6ASLsUO0VJZ/xe?=
 =?us-ascii?Q?28qk8K9wHpCUKCCAl6HZlPqjG2rtZQRs0RyQ5Ap8+/XwB+LKZIOWWs/cn34a?=
 =?us-ascii?Q?JqA/KCd05gPj8nXRR7+quuGRkMPG11fst7RmbV+bKwhR1g3piSwAVqBE9VjP?=
 =?us-ascii?Q?zzUusM1S3yKs6Ek4/ZdEKaEIIJdkFJbTHIZTe8U6Esg5ABGu3RfUVJUN9mnY?=
 =?us-ascii?Q?kNlmCicvAtTTcci1CeP2b8xIrRbktN3vQ//E0hiySZBn7RDcADfVHc4jRFIq?=
 =?us-ascii?Q?wfYVMBKQdaPC0DRuxOU07U/KglxUhGdkDs1TmXJnq9k7YR/X4I/3ihGXz68M?=
 =?us-ascii?Q?Q2utjxx22Nn+AYnVAESJBbczmxv8tYB0RtbyOZODrqd2KBp1RFv9RlUMoZpI?=
 =?us-ascii?Q?Sadd5VayeQHJ+PEkbataTtkvVBFS+5m2tiBdJUQ/asr0hPzrlG5rKT5As0Ap?=
 =?us-ascii?Q?wujg83umECoE6ztiWwqO3CA0MMOEAE5fXEZM8rroj2b79sY0shfqcfIbC2cy?=
 =?us-ascii?Q?8g8KtwZNkEtIcTyy/wX/dj2eH3fas9VFpYX1WzlUqs6SRQ6A2M3drah5Zup5?=
 =?us-ascii?Q?DJ1Sth7BjP5OE5t+9AsHqoj0Vzf+1/I2DArRAXEv9Cep274fKkPmXn2uaTXE?=
 =?us-ascii?Q?udyHQmpjs/qUttUwyZq2KyMV9kWIut0O5ngHcX9VT6XQ6Nn68fIEMlqPDwoQ?=
 =?us-ascii?Q?A751h1cPTYqVcd0go4X0FjfWhnjASbLefqlNLVfWtToiVjKqMOq68HvolLEB?=
 =?us-ascii?Q?SkkSExShwDWXeT5qQpU0YcE4teGVxXk5WxdB/K6vcWNCW+l3jZ2D9VdT49Kv?=
 =?us-ascii?Q?fRYMp7mQuStoj/QKn5Fe1cjNP7jBL8xWX65RaS3gvthDL8YVXhPbzB91uyyK?=
 =?us-ascii?Q?aS9kzNs7QDOYpsuwDw0box99INub0YnA9bEkf5y4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392c2b2e-4854-4e2a-01aa-08dd1b1e8663
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 02:33:27.7030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUujxp+T1snr9QVtk4XGqfuFOfmzdPen3bm/S9TtKgQsDJxdhec++d3U54D8xAmIkHMHooELpFAlBgMNHeub2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7114

Compared to ENETC v1 (LS1028A), ENETC v4 (i.MX95) adds more features, and
some features are configured completely differently from v1. In order to
more fully support ENETC v4, these features will be added through several
rounds of patch sets. This round adds these features, such as Tx and Rx
checksum offload, increase maximum chained Tx BD number and Large send
offload (LSO).

---
v1 Link: https://lore.kernel.org/imx/20241107033817.1654163-1-wei.fang@nxp.com/
v2 Link: https://lore.kernel.org/imx/20241111015216.1804534-1-wei.fang@nxp.com/
v3 Link: https://lore.kernel.org/imx/20241112091447.1850899-1-wei.fang@nxp.com/
v4 Link: https://lore.kernel.org/imx/20241115024744.1903377-1-wei.fang@nxp.com/
v5 Link: https://lore.kernel.org/imx/20241118060630.1956134-1-wei.fang@nxp.com/
v6 Link: https://lore.kernel.org/imx/20241119082344.2022830-1-wei.fang@nxp.com/
v6 RESEND Link: https://lore.kernel.org/imx/20241204052932.112446-1-wei.fang@nxp.com/
v7 Link: https://lore.kernel.org/imx/20241211063752.744975-1-wei.fang@nxp.com/
---

Wei Fang (4):
  net: enetc: add Tx checksum offload for i.MX95 ENETC
  net: enetc: update max chained Tx BD number for i.MX95 ENETC
  net: enetc: add LSO support for i.MX95 ENETC PF
  net: enetc: add UDP segmentation offload support

 drivers/net/ethernet/freescale/enetc/enetc.c  | 324 +++++++++++++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  30 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  29 +-
 .../freescale/enetc/enetc_pf_common.c         |  13 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   7 +-
 6 files changed, 395 insertions(+), 30 deletions(-)

-- 
2.34.1


