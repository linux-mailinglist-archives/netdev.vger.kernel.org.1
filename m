Return-Path: <netdev+bounces-239074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33176C637DC
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id EA27B24308
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31A7328636;
	Mon, 17 Nov 2025 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ITm9Mbgm"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C87260580;
	Mon, 17 Nov 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374735; cv=fail; b=BehRMFxJEgsL6Tc5zgaMYTaWEu1Yb5qdoEpZl2fYHUI9Bv0GIarstVlbfzf0BcEualEfDnHMJlxRSLHsj1M/rYr3OK8d2kIL4VXUxmBwM1VMOL5U8J0uzwtuVzY7HTWnsknsT/ExRMWF/3w4yemhEPwEMkqMIux/v83aknbkwxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374735; c=relaxed/simple;
	bh=mXigoO+K5PwaPb29KPwBtDIe2wuMQ7Nw7eOmD6/Oryw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kWwanXGzi5d2JP91K9yDSwT8smDvVLWb4DB7UuPyl2pXPQJ1sJDmdzhpLf/98O9uZqsw46gZOE1QPBI4aQPcLl14fNonyYMCssNLZEe82eM2TUwa3c/rI85fT93/Oid6ZUdXl+zf2l886RxfPG3Cce5b9v25klE1v1+51RFEqEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ITm9Mbgm; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4KtqScYI6FkK+yq8ew6FT4FrwvQLp1IhBgxuwQQv0gmHxCzOdAvOk+LaFt0MCcsahWLTxvSsdO3Yn/vdswP9VyBiGWJ1nsmznQXvd6QyFWkDY0ZCEc0yOqzXFwp2XwTsFtgQT9aGovRaJZC1c7HvmCL623i0W7EnB0BGSpmsnkFK7YShMR0aYwIFp2fBbpWOf5ENkySJkHaXGkGojQN+AiCNjByDy+FkLM8vXfxh+mWPiQf/bXmrQI9pK/mL2cwOVfVfBp9S+DVnQK9jx/fyM9mALjmUtIAKW/NPbxpOtDA1l52juYcxvGaurDVTC7hewWpK5w0WC8TRT1+cjEmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7pisc+G7iBXbrK8qCjIj08S42jfyQOfljJ5Qzf7Yqw=;
 b=ZqCj+aS+U5HBQ5G2Kj1MgBj/cEZOwVQvywm27UsvudHz7Q/Tq68ztOyPKG5fm1OfNJdalOcBsUCMvYcGAXGp5G2cD3RV/zbPvF0fDm7LVZ731Ns//FW+Bd0F//on0OiZRl2zSQ+bu7ZQDXSDBAOLcXykqp7TLEyz2hWq9N/biXuju1m7k0BgsoJ2v+NTmVhu+osaL0r6pi/6kxv2xYUxoCLpOmwnIGq+uHalyotgbgcCoMM1AwIxLWsqefv87EMBLS1wTHH7Jhqqv3QHsr9cNib3Tuu4thln0Nbk9mqeXBByO303+zlXHmVfOM8nMDJYZC/gKR1ERVpglLJjF6y1Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7pisc+G7iBXbrK8qCjIj08S42jfyQOfljJ5Qzf7Yqw=;
 b=ITm9MbgmBBQkqNStxMuejH6lwzfpXqFRRYlXqej/OGz9hBEseE4BZ3WP7gNa95bT1BVEZZD0HUOcv5vvfx/iulCWU5UvEXdiOLAYhqE1eH1vvz0vFMHTQI2+3waoZaXddW2p9SdyY4Gy+Suozlo5NPFffKWOG/5LDIvJp3QpLE7/Yun54h9mptulZSzASlgd9H+tOnczKxLS5x0rhmrE5FY3igWRWfBzgD6wWsh9ORqIcuSWUdE1JYakfwNHmq1WEHkWpHbFYRMLzHT1GHpFgbpnbadKuNwdvM/3kn0eVRyPcSx36IWkBODHINkaPQcD/zP5SNWQqVswI2Lb8ib0Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8311.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Mon, 17 Nov
 2025 10:18:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 10:18:50 +0000
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
Subject: [PATCH v2 net-next 2/5] net: fec: simplify the conditional preprocessor directives
Date: Mon, 17 Nov 2025 18:19:18 +0800
Message-Id: <20251117101921.1862427-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117101921.1862427-1-wei.fang@nxp.com>
References: <20251117101921.1862427-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5896d4-371c-46a1-3edc-08de25c2b392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h63QZvmi3fILun21UJT+IhxuAsCeDGkj9U0+ztP2pm75YvJ5hI1agKaxwYUc?=
 =?us-ascii?Q?gUD2QJ5EKJdekQicdWdmWKuaCGPvWMgSPSjlWBPoAOy4SVHxBwN5orl6tTJA?=
 =?us-ascii?Q?dsmJ8EZfRNKy0H7Z3FFq0EcmT0twjTVXcSaDdPct3s5Cj7TWHh4m2KKEcqM1?=
 =?us-ascii?Q?i3bbBt89pRqJRrWpd3MphQsvEajMMiTMbOerwok2SO4WXrjv5lodKYTTYqbi?=
 =?us-ascii?Q?JD46nmLeXCOPCcqsMrsSYH/dc+MFD3pPh8C+uhSFTco683+9+ySYqHaWMdvi?=
 =?us-ascii?Q?5tabhtm4G6tBoyeAPaju56U9baMIc+eKADSyradIw1uyRyQU/mCBrxXgWo5i?=
 =?us-ascii?Q?MKxLYdg4riVrL0GXVmqxsUB7FVt157aJ1+CaGPaYn3F9KfUp222RZaIZX0Mv?=
 =?us-ascii?Q?YeInaGBUGAtb9/1tiKhTFEXUTb/2L0LKYkWwcf8ng/DqcV6x2Cdd5kOwK+jg?=
 =?us-ascii?Q?obh1QBnTYQmshUW/ZuHTXfIGpKKI+TaRrdfMvvvUqB/aWCfLVx+vlm84OJvY?=
 =?us-ascii?Q?AFYvIDTaYg3NUxE+6lG0kILruYdtuTtubT01e4p1+bY+n2PgXmZjrI1Gzdcu?=
 =?us-ascii?Q?SGddpBXy1GGj+sT/afsPobW+4ptcKBIIurUv26AwkNiCpRButYUv3BiQeAZU?=
 =?us-ascii?Q?xk9dgJsqNRuS4GqZmTjnKKA0LKnbKpIc/qh4p2oaWFmU/xp8OrLUBNYFvjTz?=
 =?us-ascii?Q?lT2ihZzxWkLnvjuMeIyM6sn2lBcHBy/8Sd/6AdXnFObfCszoieu7StflaoBB?=
 =?us-ascii?Q?d7Os6kRchFQdFZanaUkeoTGX49Q/ps6Xm3hnIYMlZEKMpPt7c7TMEVUdatVG?=
 =?us-ascii?Q?FA3Xl3Y/zQ5uNZ3VONZU/NYKeIRWsiypdbHbO/8x/baJ620VrZYeP/zv2ZU0?=
 =?us-ascii?Q?T7Dj5wK91JJSWVpllqe4WCtNOF7pqKu7lM8G2bXg3xi7oRzGq+aRaBwyAZlJ?=
 =?us-ascii?Q?O+j/C8CzQwR69a1udhNdDXuCUA+vIRBO4Lod9WY8bsDLOMgw4Fr6QtzdgDr7?=
 =?us-ascii?Q?4WLNvkt8ihm7HVjlMZJFY+uQbo0dAHlpwxeZpRAfX0Ro5vWGvPxx2WVcevhj?=
 =?us-ascii?Q?z3+AaCOwizgePD2UBUkJxQzRgFHneQiuAFKaNN+gS9mvBolmr9oJhVVk+zaz?=
 =?us-ascii?Q?/xG8CkXOndcoCJR8cQWdH+J6iWElyWfYGGfoTmSF7axLYIq0UgPCfPePh74g?=
 =?us-ascii?Q?OKHtsXelj8PKlFDiPXJUB8lUUSDbPBxsYSOrXWuT4LNcvK2vMEakubsQfPr3?=
 =?us-ascii?Q?maSX/fGeUfXMFD95FdksQlgtiJ7EcgmAvWjrI2JQRefSd0Tdq05VLMyzoo7F?=
 =?us-ascii?Q?uyP74J0ZEYTAc1ZjsBDXZEy+q2HNmcPjd1Ts6QuKGT3VHZ7AqsBaxzkU21vN?=
 =?us-ascii?Q?41547qtybyYfZQYLEHRfILhE5+tL9CQEkVYLSBUpGuiKxlspNLGl/qov3aCj?=
 =?us-ascii?Q?b1zJm2Y6FtLtByzjX3ag4AOqLtFnTwokQ4pXCOQe6EIvZ2CCqwovS0t9vjqc?=
 =?us-ascii?Q?3TbN8CFd+aDHmMcy6/zDSmQu9JVuPIGBdPuc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?012ErIdXvQBFm+F0a+ZK+yZXwPLxCjuYabPra7PrpIoOmCoQX0tYFmhmVM+J?=
 =?us-ascii?Q?c0Qjbt07veq+nGWAN0qfSki814CSMQBJn+RirQ4bYce9YVXPmBv4Hfuhs68f?=
 =?us-ascii?Q?jVrCRDAWMBj1vdWCFbNc8XgUZrEmejBUDNZvTJJlLqKG91cKAlzbSzf7ya57?=
 =?us-ascii?Q?529JUy2bbG4+H55h4peg+lbA/bixv9/IaD25BSE3k2LttNrOcbKXL03P6HNT?=
 =?us-ascii?Q?iXNiFJgBW1Mr6zZs12fcguY8DjHlAmqFl1LvgPGzkDEgv1rPvT6F9Tz1f7Mx?=
 =?us-ascii?Q?hQXtCSdkKqXmXQSIN8V0iLNQDWeFtiulHe097I2cuZZsn5syrwpyvFkcCHq+?=
 =?us-ascii?Q?4mQBVa1fO5/26owrd/1z+WqYRja7LmZvxEdFdjXxrj9aMYPTyc3S0y4kaiNV?=
 =?us-ascii?Q?ESMPKitGRv59JQtk5H1NpFsXtGXLIDGHTezNVFv/U6Z+w8O3/7wsNdeA7XMf?=
 =?us-ascii?Q?tgC2O02SpTK5gAWm/QzeiYlMo+Qyge1xl3RTyXr9V5B+RIbecvSO5YHSpwqN?=
 =?us-ascii?Q?lqarT8/Pdr7ZKZ2GGfcXb8AjJ0MvQ3P3+R6HF1PImvPY50iCIFZhn1oMyna5?=
 =?us-ascii?Q?RxtSuuzXNLrBmfnGtYrJ3mKuIJRjdfozdpJzt9/zEqeku9Y/8k/R0nJWZYqp?=
 =?us-ascii?Q?yvAK2K5U0KOMpWLrtbtHV/gIgRuVZAOthuuQ9j+FOJ059I2GxF24Q9WFgxl7?=
 =?us-ascii?Q?8AZ3Vj6qdEisQRpf7NB/L2B+lKHaOQVKFrRhy7+5vXwx0+upXvK3RVWhm3XX?=
 =?us-ascii?Q?Ry2pS08PaZQZ01ZJT9/KbqGb+EkKLmcEwVHtu26mW28lC7pQQQomtJydYWbc?=
 =?us-ascii?Q?LzFL8e3wHHTBGRaOQXz/P4Q0EKRSm0SFL5W/jHCotX7b+/uZq9qpUtH5KnGa?=
 =?us-ascii?Q?c2CBfk7JuqBmgGP/lZ9lR6MIxeGlEKMHgIt2fcKXKwSluJwP7F74X8sK/YKi?=
 =?us-ascii?Q?uYPdSF/CrM9DgWliDmgBuzxbKvj3D77d4wuNiAshQ6Y3w/XBICsRX2lEwlGb?=
 =?us-ascii?Q?w47SaGCnMxdGTorRcTzLDovyOMkPuOYY9jvyeaMk7kXkoCEAiPwDiWBxw5Vb?=
 =?us-ascii?Q?GiTXH8FDoxpufcQFEWkAJ+5cTFH5Kpr1goUEpRzLnMCfQtf6oiWLIu9tUoku?=
 =?us-ascii?Q?NPM243z/1huN/qShQYyhbWlsqSQHzwNqxEhjYHMZPMHm4mEK8obuxTLVGeve?=
 =?us-ascii?Q?TqfFjePepVOZbnG31SOn7l5RLB75T9ym987HwFYup6slFv2CjWoSlCk/3Bh/?=
 =?us-ascii?Q?C4xnrJgIQr3Y4/BtHyjE3lQSNitc2i3yb7RbPKvxxRd2SAHq/+jkwnGK5+lH?=
 =?us-ascii?Q?zHS7c/mdTA0x6JlJJIGL4na3a3fcUB/aBuH01sXN9dtLyrYJgzby1ydmmgk3?=
 =?us-ascii?Q?1x2GBigJGxgNz1Sl528dVJJLbPCdAZ9RYKhJ3KHbuvtvUkpt0a9Z1OFpZmCG?=
 =?us-ascii?Q?ID0L2jmY0qZf8nUwZmwXeU9FxtroYUBFc6qty21QWNLoOFVYdjrvOq7yziis?=
 =?us-ascii?Q?e6KdQKxqIxo7s4U1k/GbRgRLG7tBprDtjM6VFJdcn6P9Iv+bWHaqfcS9CM4I?=
 =?us-ascii?Q?0D8zIzshPcgHmw/IGUQeltSKqO8xXGqI8bb40eRf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5896d4-371c-46a1-3edc-08de25c2b392
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 10:18:50.1583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N++XZ7jPvlyDfXQKbFoyhTUlVh63IjeEa5AhGLpll27A7/WfEKsYT4Lf1KNpN/jz1Je3KGQ3rOcHRO5z11jCzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8311

From the Kconfig file, we can see CONFIG_FEC depends on the following
platform-related options.

ColdFire: M523x, M527x, M5272, M528x, M520x and M532x
S32: ARCH_S32 (ARM64)
i.MX: SOC_IMX28 and ARCH_MXC (ARM and ARM64)

Based on the code of fec driver, only some macro definitions on the
M5272 platform are different from those on other platforms. Therefore,
we can simplify the following complex preprocessor directives to
"if !defined(CONFIG_M5272)".

"#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || \
     defined(CONFIG_M528x) || defined(CONFIG_M520x) || \
     defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
     defined(CONFIG_ARM64)"

In addition, remove the "#ifdef" guard for fec_enet_register_offset_6ul,
so that we can safely remove the preprocessor directive from
fec_enet_get_regs().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  4 +-
 drivers/net/ethernet/freescale/fec_main.c | 57 +++++++++--------------
 2 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 41e0d85d15da..8e438f6e7ec4 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -24,9 +24,7 @@
 #include <linux/timecounter.h>
 #include <net/xdp.h>
 
-#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
-    defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
+#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
 /*
  *	Just figures, Motorola would have to change the offsets for
  *	registers in the same peripheral device on different models
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e0e84f2979c8..9cf579a8ac0f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -253,9 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
  * size bits. Other FEC hardware does not, so we need to take that into
  * account when setting it.
  */
-#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
-    defined(CONFIG_ARM64)
+#ifndef CONFIG_M5272
 #define	OPT_ARCH_HAS_MAX_FL	1
 #else
 #define	OPT_ARCH_HAS_MAX_FL	0
@@ -2704,9 +2702,7 @@ static int fec_enet_get_regs_len(struct net_device *ndev)
 }
 
 /* List of registers that can be safety be read to dump them with ethtool */
-#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-	defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
-	defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
+#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
 static __u32 fec_enet_register_version = 2;
 static u32 fec_enet_register_offset[] = {
 	FEC_IEVENT, FEC_IMASK, FEC_R_DES_ACTIVE_0, FEC_X_DES_ACTIVE_0,
@@ -2737,6 +2733,21 @@ static u32 fec_enet_register_offset[] = {
 	IEEE_R_DROP, IEEE_R_FRAME_OK, IEEE_R_CRC, IEEE_R_ALIGN, IEEE_R_MACERR,
 	IEEE_R_FDXFC, IEEE_R_OCTETS_OK
 };
+#else
+static __u32 fec_enet_register_version = 1;
+static u32 fec_enet_register_offset[] = {
+	FEC_ECNTRL, FEC_IEVENT, FEC_IMASK, FEC_IVEC, FEC_R_DES_ACTIVE_0,
+	FEC_R_DES_ACTIVE_1, FEC_R_DES_ACTIVE_2, FEC_X_DES_ACTIVE_0,
+	FEC_X_DES_ACTIVE_1, FEC_X_DES_ACTIVE_2, FEC_MII_DATA, FEC_MII_SPEED,
+	FEC_R_BOUND, FEC_R_FSTART, FEC_X_WMRK, FEC_X_FSTART, FEC_R_CNTRL,
+	FEC_MAX_FRM_LEN, FEC_X_CNTRL, FEC_ADDR_LOW, FEC_ADDR_HIGH,
+	FEC_GRP_HASH_TABLE_HIGH, FEC_GRP_HASH_TABLE_LOW, FEC_R_DES_START_0,
+	FEC_R_DES_START_1, FEC_R_DES_START_2, FEC_X_DES_START_0,
+	FEC_X_DES_START_1, FEC_X_DES_START_2, FEC_R_BUFF_SIZE_0,
+	FEC_R_BUFF_SIZE_1, FEC_R_BUFF_SIZE_2
+};
+#endif
+
 /* for i.MX6ul */
 static u32 fec_enet_register_offset_6ul[] = {
 	FEC_IEVENT, FEC_IMASK, FEC_R_DES_ACTIVE_0, FEC_X_DES_ACTIVE_0,
@@ -2762,48 +2773,24 @@ static u32 fec_enet_register_offset_6ul[] = {
 	IEEE_R_DROP, IEEE_R_FRAME_OK, IEEE_R_CRC, IEEE_R_ALIGN, IEEE_R_MACERR,
 	IEEE_R_FDXFC, IEEE_R_OCTETS_OK
 };
-#else
-static __u32 fec_enet_register_version = 1;
-static u32 fec_enet_register_offset[] = {
-	FEC_ECNTRL, FEC_IEVENT, FEC_IMASK, FEC_IVEC, FEC_R_DES_ACTIVE_0,
-	FEC_R_DES_ACTIVE_1, FEC_R_DES_ACTIVE_2, FEC_X_DES_ACTIVE_0,
-	FEC_X_DES_ACTIVE_1, FEC_X_DES_ACTIVE_2, FEC_MII_DATA, FEC_MII_SPEED,
-	FEC_R_BOUND, FEC_R_FSTART, FEC_X_WMRK, FEC_X_FSTART, FEC_R_CNTRL,
-	FEC_MAX_FRM_LEN, FEC_X_CNTRL, FEC_ADDR_LOW, FEC_ADDR_HIGH,
-	FEC_GRP_HASH_TABLE_HIGH, FEC_GRP_HASH_TABLE_LOW, FEC_R_DES_START_0,
-	FEC_R_DES_START_1, FEC_R_DES_START_2, FEC_X_DES_START_0,
-	FEC_X_DES_START_1, FEC_X_DES_START_2, FEC_R_BUFF_SIZE_0,
-	FEC_R_BUFF_SIZE_1, FEC_R_BUFF_SIZE_2
-};
-#endif
 
 static void fec_enet_get_regs(struct net_device *ndev,
 			      struct ethtool_regs *regs, void *regbuf)
 {
+	u32 reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	u32 __iomem *theregs = (u32 __iomem *)fep->hwp;
+	u32 *reg_list = fec_enet_register_offset;
 	struct device *dev = &fep->pdev->dev;
 	u32 *buf = (u32 *)regbuf;
 	u32 i, off;
 	int ret;
-#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
-	defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
-	defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
-	u32 *reg_list;
-	u32 reg_cnt;
-
-	if (!of_machine_is_compatible("fsl,imx6ul")) {
-		reg_list = fec_enet_register_offset;
-		reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
-	} else {
+
+	if (of_machine_is_compatible("fsl,imx6ul")) {
 		reg_list = fec_enet_register_offset_6ul;
 		reg_cnt = ARRAY_SIZE(fec_enet_register_offset_6ul);
 	}
-#else
-	/* coldfire */
-	static u32 *reg_list = fec_enet_register_offset;
-	static const u32 reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
-#endif
+
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return;
-- 
2.34.1


