Return-Path: <netdev+bounces-154900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F253A00453
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089141881957
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 06:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2483E1C3BF8;
	Fri,  3 Jan 2025 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YwGh/TgQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA36F1C3BE3;
	Fri,  3 Jan 2025 06:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735885439; cv=fail; b=gKmCk3SfZAala8nuBs8wO7QaSRNd8NIQCkBYLyUpN7JGrj3nBWkocX8zQ8t+9rfSaHgvmkhz+hwTbDVL5F+yVihSOyFRzweg4pMRWxpaMjaU8L824VOlB74wjcuMNp+yrunHLuSBkWNFj04wBuX59j4Icdv54wbTi48iovMiykg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735885439; c=relaxed/simple;
	bh=/epvdDZJBKzCJs7Uw0jrLS9xujnOkH2XJpHVnFAJZHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=by4MUJ6ZIu21/2Ex6BmCMwlBJQVvDl+7vO/6febTDYm665f7a6nVQxEL2faIrkzpAdtihBxYHOuv5xserZI1Nr2H95QAdKGEYOM4tTO9fGlJ0o8RXfobE6KuWOdQwyOiEd29zcSM7UXKt3CbFHC2hOkjt41/XUaA7p3yEnVGV/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YwGh/TgQ; arc=fail smtp.client-ip=40.107.105.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjrsUfQrGTbQvkbeAvpgmG62VYKol3rYuIxElNze/Bfr+QWDjcihRcrrkU7aNsb2ZzCFqsrS041Nc09r5h8DFUAVk+yA0xvtI7wUxpVD/O1l6BVGPj2aJVi9i1l1DA7KlgjvyPrqOWRsyfaACwaB6PZ+6N/tXAnQIj1rsAMs8GZhWTv8F0Gph+QJXibTi01Xik8+Ma5kWqCI3grzx7zUkdfdaYLnfkKzlu/2PTNd8KNZDaT4reYguOQbeTeVyS0cd7I21KkDruNtx59I/vXatK1YxL5YNg86yj90aKSB1hJie0+3ZvRijvS1Yu2BuLhYJ1lnFGdTCPGnZ4IkzHYH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+s06cyqpvZyiMaZkqGsEMJeuscE91SUhnNDLLyCPlM=;
 b=lo5d6r+3HKeMVmm+7benZwznZUfQAer8EGkXsUinuEgYjvt1ENudR/1J43Y/+hw1Py0ppJTlrtzkCbHe9BEF9CBaqhEr9VHJ6nTi8X084IsYkjlVyI0+Spbj3NsSelak7FrIQZkGjkTpGIKwdfx4GUlU0fBAqEztY3pgIWfh+/oB37qUQrvthDUiEuLTSek4qNDIjF2SP7p34NdJvGbKHEOz5/HwHtSkvQ6RP9GLb7qf8Aq3AuPndkyo6EjxeZJMwg/Qs97OjMT9qQs4WLm/kozbztJzOBvtBlSksofyCkJAxzJFdUNvI4vbd0k5B+bfj+58pavZNtGDr862Zybmsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+s06cyqpvZyiMaZkqGsEMJeuscE91SUhnNDLLyCPlM=;
 b=YwGh/TgQ7LVlw630lQPBj+WoNTDlYSWfpyq8uCfVJ1md//1FAdyKqd6zgG1QjoLpatvPqQHiJV5jc8/4FWYBzxQY0m/zbUTyxB3qNbKhfJHhJebqa0uEPTJ0uJKhfgtuSWeHRJhdtXDl52WHCMAaLiUnlcfdVd99Ab7tId7ndFc7jIHfUZfYtfNa2du+lMhHDNiYnt7lDKH1SXiOANtod8jFQWhpQWiIzLpR3I/EX5Ys5leWvFEcpg2IVonimtT+vaea/GQ20+c5DxTgw03hGA1EmT8QuLu45ShL36+vZqD2KSqkZnU3jEsZyjN1km257zBO4WihmSCneV6r/07Q4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9331.eurprd04.prod.outlook.com (2603:10a6:10:36d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 06:23:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 06:23:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	christophe.leroy@csgroup.eu
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 12/13] net: enetc: add loopback support for i.MX95 ENETC PF
Date: Fri,  3 Jan 2025 14:06:08 +0800
Message-Id: <20250103060610.2233908-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103060610.2233908-1-wei.fang@nxp.com>
References: <20250103060610.2233908-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b1bd02-191f-4837-34bf-08dd2bbf310c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kWRrV7bg7pZ1qXl3IgRcVnlZxIFTAlM39jO2nFraqHCC9siS7tt5zwI3ayEG?=
 =?us-ascii?Q?ItKCuaQijyhye8Bcx55ZXptNF49L0CrEQJ2oKC0umsmTjtl/ZDarV3SCbQz9?=
 =?us-ascii?Q?H0Uauh/T1XzFjT0mM6Jc5BN5se/g23lpwZMxDQVVmt3Y6lvuo2C3orP8pnXr?=
 =?us-ascii?Q?8wC7XJD5HGxE6YWp9+i7H1jSpPrMUgrnbygOmgN4P7AnBPeEE1wkd++bMr4Y?=
 =?us-ascii?Q?5v01WibtY+Y2134xuGqKLFIbfKh2hkOkGPWtveNVj+im/5fHXfuo43G+wlqC?=
 =?us-ascii?Q?hrfePflcXWW5PtujQZtLEp6SycIuq8oIEzN82FZLVm3YJOYYl6pCfuBG8IHW?=
 =?us-ascii?Q?Wf3w0DkTAoIACjUai8F21/3amurI2mX/00nyUFQTfQJMjRfngWtSfVAQe6gn?=
 =?us-ascii?Q?DyYQzaX7K1ufn+8hVG66fJtDTq0BilvzCuy5TbTeq6zwUd3Nni5HYgTy/R9+?=
 =?us-ascii?Q?WzBhxGtsScSaymbnsASY7KtUqQ9anVr8wY0QhJ362PZucKGpyM60vRSmh9PV?=
 =?us-ascii?Q?/bVdiObNhLJasvnaiNGLiYhNMNuLk2XqUOtTxr5tZ9wm/emvdS7wkhJJd+dy?=
 =?us-ascii?Q?D7SKMqO5BoI3gokYxNvp0EUUwwqbbTW+e6pIshzEdgYnAC/j6UhuCNx6i/dk?=
 =?us-ascii?Q?Gg+ysLfBiAvkYGAEZErGQatnZwp8Noj/iglFDPAlElWR/gm6pnEEg994NIkJ?=
 =?us-ascii?Q?lFb3pudsSB3R4Gb1gtq69a1tXkxyWHB4LAVb3lSiQSfZOYtgl4lDsOOtPQrb?=
 =?us-ascii?Q?cOje/57wvX5yNYlnGikfOw16cBUbj9k7XcELLEjy+0sYpqu2fp7Q085N+RN4?=
 =?us-ascii?Q?tHJUpBSVSXtT5X2eejXhwY3/ICrVBKm46YAeS6Q6lRxMqSGSVl/dFeI3JWZt?=
 =?us-ascii?Q?0/MWSbWDZZx1UF2kO38SuQj+jS8q89hO0uiSWLfj0Q/2eYEcXTC9xDemtuwk?=
 =?us-ascii?Q?c0KpqJQdlcK9sRZ2U45atxVQiP6sSQyj0fsvj9vf+bVy6GEgJeevZ7Ac/Kkv?=
 =?us-ascii?Q?GRjVerFPL+oZPEbhoy0xySRiUwGw01dBHdTif+2Naim9BMJupR/LcLNCWLo6?=
 =?us-ascii?Q?/271D7RkUS8ZrZcGm7twHvQTbf4G19TCzOGXcFmGJ8J6XMxwerbXMM4rEHVG?=
 =?us-ascii?Q?bqMDlNLY4eDlUtF5jEM3cOrbX+tDs5agIXW0s//ZnXwBPhJ1qvtSb4hTW85x?=
 =?us-ascii?Q?lp903YivVKiawABbKQhv57A2ff+PzCniH0Qaa12X2GujqF6CCPvOmfVjYxZR?=
 =?us-ascii?Q?cUoZe12oJnhikXhjh5Xd7W0VHi1ISDdsnr3wy9HBl3gIBaFOi1yZDKrZgogU?=
 =?us-ascii?Q?y2DeKGLZcTPQMLj2nkEgTi73bgTPr1Z+pjV3v3IdiVZ//tdixtgQdR8gS0pv?=
 =?us-ascii?Q?ySvrodzlgXviAY1BAYJxzWNsIzTiqeZfumEPfeFp0Q6yrqQfpOc3WcAH7WLv?=
 =?us-ascii?Q?OI5CcKt8CN0OmAgcG+LkedOG/VzfaGXG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ifR4kfuSOR48NEMwYz5/kRnKrETofJfnbztyfZgqLCySEDfT+WVnDEJwKq4q?=
 =?us-ascii?Q?vJakUetWEFfwbVvQAE2eZsyCDhUBllFW1LZP+GRXsC9d41ejt7eBBkep009y?=
 =?us-ascii?Q?4UjYxVGIaB1PhXEOuh/AywiBLMrCOhG3+ShlCj44+8WXVVCCjBdrIU7oA3TB?=
 =?us-ascii?Q?Ot2FlqzpAWdENzxNCNqZB1oJs+igai/TpDfc7H6wJ+r8ai7dl0Lfy7jPs+IR?=
 =?us-ascii?Q?GQlls1uq2NzMn/VjeDD8skOd+4UwLSR0KyWPjfkrOUZdfh5mIvlFLMdKNGSA?=
 =?us-ascii?Q?8qAODWy9ygI2uj38pO84/fJ6Oz9Ru+1V30BCgzWmAC54zoLgRY4JzpvcIe4n?=
 =?us-ascii?Q?oqu8O/+W5wcALIoxFpJ1YSM+2Q0naTBQr6Opu8QTOxEyYAUtfSxSmrNDvj6C?=
 =?us-ascii?Q?HLH/1lKX2qdl6AEHFDTEw56+RBXh6WfUnE8xkk/1hEIDYq1NtsxFGiCPVVSB?=
 =?us-ascii?Q?c3fAf9szDzhzrR0mi8/fx+IqA+ViNsx32F+FJgSLkFeKshdyAZk4JPtVZuJA?=
 =?us-ascii?Q?hJAfqa39gJftSMXLfWWw2hDHyZgNu0yoHDam/aseijFj1rURjqMXA2DDmuX7?=
 =?us-ascii?Q?B5CL5+XEonB98DFl1eY8yAsoLCAgeZw4nE1oh2T4YuSKt9EpNzzTSEm/Bxaf?=
 =?us-ascii?Q?L1dO3ydMoy/VD/6kn81mrHA1SbxPsKqQfLWTxl+1Zvrq6QryZ0fppSKkJQbm?=
 =?us-ascii?Q?glqbYNpoRv9G5KaMW98l5FRBp4P1vg4POukVaroZ6OBiVDz1BVV4mOhMTtv7?=
 =?us-ascii?Q?nWRZbWW880Ntut3oMGPSn/Oupy5h/RiHyMSmAApxm+dZphgkqV6/x4MXD+0L?=
 =?us-ascii?Q?3nLItgrQpROvmzrU64UpRhnel/5OMgQtaC3PyymJnPsvLKf2dHeKRd+DuCUa?=
 =?us-ascii?Q?69ktSiHO6hNzSHGkGcXr/nq9TLqAliE1bHp1kyJEJfgV/Bae+247IqTosKTR?=
 =?us-ascii?Q?YyNCMRzVNQ3GbrZHPamKivXgr3NUHEOQs5wfjTgwIFqFXyvDXuHp0mvpf028?=
 =?us-ascii?Q?dikE18ecvp666/O2Kt5BqX23CS/ChxwWHQMwl89WTKM7BFiHi+OiFw+zvTxL?=
 =?us-ascii?Q?5IvxxvlxWs9zv/fVBnqzf23XIp2gzSv+jALj8svn5hRmMTtBAZYk/3MKjdib?=
 =?us-ascii?Q?bfmDFhn1qxBNXX7oBv3p4dd2HVXzJ3vd86+kyu6EXfZJNqbwcQuC144k4XiF?=
 =?us-ascii?Q?HmBSoIou1o6nwiS4vDdBwHuqaVcMXQBTL/FpuNM7FgwtHO6n812cI3Q3YJl9?=
 =?us-ascii?Q?H9TnmkzzrGEJi/R4t8BY9zq6j0cYf9dQyVFaTRoDZxq+p/cZplM8P9KLBOhI?=
 =?us-ascii?Q?kkh58XtLDpFypmTM9FAZs84n+fDtr8x1DD/OodSNwywMw3j3eAgcQpT0f4IF?=
 =?us-ascii?Q?bTBQGnPKHmuPGCOvs2BBrTQvALAZgXE5Y9ZGvsgGPHDqSIzIkM4rzFb0vGYs?=
 =?us-ascii?Q?nAAfw2Dd2rCPB+SuW++rC/LmbgIJermFs/WH5tHST7poLBbEtOzqFZWFDsx3?=
 =?us-ascii?Q?GZvKAVGJv0dBiLjYrBhjPQePOcs9E3uzCTQzMqZXnzfVJjH8qQLkt7QpLvNh?=
 =?us-ascii?Q?2YIEvH10SMRl4TEUE6UntLnGmkDkqJ3Ua8e7fxj5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b1bd02-191f-4837-34bf-08dd2bbf310c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:23:52.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDIIF8zDfC2rsNfc4Iv8prbn3R+Hiky9G5NcpX7KUxUxeQowhf97wHMAkOl5MhNL3X7qRUT9g0TKqXhP/N5LFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9331

Add internal loopback support for i.MX95 ENETC PF, the default loopback
mode is MAC level loopback, the MAC Tx data is looped back onto the Rx.
The MAC interface runs at a fixed 1:8 ratio of NETC clock in MAC-level
loopback mode, with no dependency on Tx clock.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c   | 18 ++++++++++++++++++
 .../ethernet/freescale/enetc/enetc_pf_common.c |  4 +---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index e2eca28eec06..d460d75647f7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -709,6 +709,21 @@ static void enetc4_pf_set_rx_mode(struct net_device *ndev)
 	queue_work(si->workqueue, &si->rx_mode_task);
 }
 
+static void enetc4_pf_set_loopback(struct net_device *ndev, bool en)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
+	u32 val;
+
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val = u32_replace_bits(val, en ? 1 : 0, PM_CMD_CFG_LOOP_EN);
+	/* Default to select MAC level loopback mode if loopback is enabled. */
+	val = u32_replace_bits(val, en ? LPBCK_MODE_MAC_LEVEL : 0,
+			       PM_CMD_CFG_LPBK_MODE);
+
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+}
+
 static int enetc4_pf_set_features(struct net_device *ndev,
 				  netdev_features_t features)
 {
@@ -722,6 +737,9 @@ static int enetc4_pf_set_features(struct net_device *ndev,
 		enetc4_pf_set_si_vlan_promisc(hw, 0, promisc_en);
 	}
 
+	if (changed & NETIF_F_LOOPBACK)
+		enetc4_pf_set_loopback(ndev, !!(features & NETIF_F_LOOPBACK));
+
 	enetc_set_features(ndev, features);
 
 	return 0;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 3f7ccc482301..0a2b8769a175 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -134,10 +134,8 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	}
 
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
-	if (!is_enetc_rev1(si)) {
-		ndev->hw_features &= ~NETIF_F_LOOPBACK;
+	if (!is_enetc_rev1(si))
 		goto end;
-	}
 
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
-- 
2.34.1


