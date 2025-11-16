Return-Path: <netdev+bounces-238913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 666E1C60F18
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 03:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A928354FA2
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 02:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25855222582;
	Sun, 16 Nov 2025 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LukTxrXT"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC061A9B58;
	Sun, 16 Nov 2025 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763260668; cv=fail; b=gpa8WGv0ofM7gMzVasvpo6EJwyBOHeo0JVMQzTCZZVnkT3b1CFGfOegoHmA3choFbHqhWNTc7iwpTpC5QHbxAGDED+JX718dmDyYn0hk9CJWZ+E30spkb0zSalt9iDhGd+dz8cW85tvLsRcAZ/OVkygdujSX4B9gYcQXI+l3LbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763260668; c=relaxed/simple;
	bh=Ea6iLV6/n43QWu4lX8VdMRqmAZpnO1RhSqXXn0+c9Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JMR3GvByiTm9gLgIA/LuenehgjVfAOqL+YqrrbDPjhXyM0IE7vM7Vx3rWdyhFcdfKoJqDeTFiviStjZZifEhj1F6VmNNtySTQvfvSskXi2bCRcjHpmTkuZuxiv18AiK5defj9zDSJyKFlNOurK94dwkJXXJuArKEZZEvNmj3Yg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LukTxrXT; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1bX4muoOKNLTiDJO+wNNd/yfPMo3wo3FZwVrL/nEWXW4sbR7Ol2GcV8ANWumwZZ9lSUmqE1L36x6wdrk4KdkvuAs/cllgKi717ocpThNOQv/iERF/BwOaEAeWB9dGtWNkSCAcJj+kSJZ6q8GMt9kFlmGhdut2U3sRRD3ueWe4zelDSAZHvBUxOLfHmcHMhy/h4kKekNjR0ZgnABI5Rdps5KzusWHwUhltEen14ENW1NKb5NM/RTmDiBGMXqUFNDKEpUYwSa8yOI4JPey4TIe5Vlu9trfuJzvhjzLXtx2IEXKxhvaAmbHGk+Y2JQULayH7Mo+V3RFZddm+z8v1Dndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LOBiruQAxHuI9TZRPoXvf8jSMepXaisVdzDL9YAR/I=;
 b=fv0aFQf1CnCaK0wWCmxhEJBaS2eqeG7ZxN3oM3rHmOyauP31waoN6oXOQtsLC95bt8d2fyGQg8O9LdChzdVhvMDxY1sjeNCN23VejFThybst4+JtdL8RMjOn2Xwo7MBmc0Wibr26aHuilxx9rI0/sCyo+KVJG+X+9XycqtdK0rZ/mAtQpth3OQn/CHKUwSxWLkq8qYe9zl9weO+tY/+R8JyWrG57IfiBMsqtrcMi0wIhbDMX3TtAyYdWpGJvXIiY1AP26TC8qnCXr+tbllv6kX15Y0OLXFCQwZfy543WZOP80wXN0Ie0aBpwm2CCDll3ATzbvwgA1uiIH1IVJQMw2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LOBiruQAxHuI9TZRPoXvf8jSMepXaisVdzDL9YAR/I=;
 b=LukTxrXTKvkxdy7FAdoXbnUNQUcvDC4BcipBOW3taMRB52WI1aJjw0ML3wNLjaeg3CXCkGfsvsmKrsLbb3U22bGbllpouG93zPSTE5ckF3vL1MhRGY9Fv17lF2NuxEasFP6bWoAGOLFHe54hfCg6qr5xLPMYH6Xjt7s+mfAU+cyMOKmWBbY0IuQK8LFg8k8RIOrFr3yW726JWp7jinWbJHY12rWzYlhqEgTZ2oxfqyWYteR78IEkn1h8f9WCHFQqljsPFNpvhRHrnrzbjdG/c1EY9d5jOD0GtpVBPMn8ClNZQ9mVqAVPBTyaegMVxF59vxTSE3OnfixFCNSEXoaK0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Sun, 16 Nov
 2025 02:37:43 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.018; Sun, 16 Nov 2025
 02:37:43 +0000
From: Wei Fang <wei.fang@nxp.com>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: phylink: add missing supported link modes for the fixed-link
Date: Sun, 16 Nov 2025 10:38:23 +0800
Message-Id: <20251116023823.1445099-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ae7313-dc82-4d67-ddd1-08de24b91e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gcSIItwDkP4rRmVLvXcNArT1VrSSMDsvse7u+zjlpNA8L/h3pbDTCHJNaL8E?=
 =?us-ascii?Q?w3OonBenUp/v05e8q8QedKVLtRX4zN/KsIojT6RxMShFaRxytxX3k1EOKg7r?=
 =?us-ascii?Q?uHhS5cmyRUyU2HjjrrFXdjcEqXuI0kaJ4zZKRfK7JDPhSuZwEkdTg94EOQH3?=
 =?us-ascii?Q?qs44chMnDZh6y/ixNhiluT/A/ByJvZWXSBD7cHgIrfj4Hs4D7PGXP9emHmzV?=
 =?us-ascii?Q?AAHrddNo7HZo1CXGY4V5zYARJJPgyb6ablGflNJz9pAiVFknEbn5aj683eOB?=
 =?us-ascii?Q?Tx600MajnDsowYazAmchtAoHW2FtIkOTir1Y3U2vgRsk3pl1jlCepxWojxQB?=
 =?us-ascii?Q?jLXaYs/r253MNVyj5cuUoBLdRrVpeOsd4G+bP7odCWbdE5UljZHcfE+orUnv?=
 =?us-ascii?Q?7LI02OFBDxYcYC90W+nTEuIZe9NV25vvPEtsQ6jjNq4hCRWD0kOcS/JZx3Pr?=
 =?us-ascii?Q?SUjgifBa06GxApykizHhZdWQYWQJccNO+w+b2904/3qLbqB8zEr1x2l0L558?=
 =?us-ascii?Q?3SJGXF6FsYg76MmPA+bPP6zK3d2JjOMnESC7isR85N6s/5ie/WvVVbaZgMor?=
 =?us-ascii?Q?zSyew3OvjA61BeXy8VT9Q8D/hveQ0kB0VIMiztruD/xjRVaD3VET5sdkZP3/?=
 =?us-ascii?Q?0RESNphKGqwy8gkcTCWYvL2tLXP2sy4OgzIZiqRmbdXILSla4jPjukLx2SBo?=
 =?us-ascii?Q?K2YKH63pB8zg03l6O2KrTj6R2+OhYrR6bqG3i8RqOC7Uj0fVc+s1znqZon0u?=
 =?us-ascii?Q?jpplF9drWpLfDzVdZdplmSwm5/b9iursZ4TbFoclDaLtP+YeBtRJaO9C4OSO?=
 =?us-ascii?Q?4IN9p25MNQ/b/jSfC2AL+ZbwH66p3nI4ALt4EsV8pCbTRO3ydbDTa0B/1xrT?=
 =?us-ascii?Q?gpgM3KPWKQDbgN9a4dX080v1BvziH9hLHyuvLlBWBdhgWKjrHU/xSL7bqcT+?=
 =?us-ascii?Q?RT4tyJOV8sptd+QMktHEqod0wrnFjTSE2yYQb9Ufo0icWDqwNoJFHdVqiS+Z?=
 =?us-ascii?Q?58DRBeX0P9E6poujIySTZh9486m2g4XSGluk3Gu7kfCvZvueTugPbuedzNTD?=
 =?us-ascii?Q?KFDaZL98mGpe5tBdhL+7xLhX+3eqhQUjbEC18143VepjZwC6j7GwWS4dFeA3?=
 =?us-ascii?Q?8L6bcIRlBwzXp3gkQJ7r58y7b0WKoLLmPaOydVvU3ZkE2dBf/cO3npbUzfL8?=
 =?us-ascii?Q?AydKC1mM8WFa4+sRP2Yb9FhVj8Efj9WPgAitA5kSuXfvoip4bBfsBNMUh/aV?=
 =?us-ascii?Q?CUJMddB45BfAPD21g5Umuj9S29sF8tIwGhykIDevmwr7hXFhJX3oitfB1lAa?=
 =?us-ascii?Q?/zznpZeOL22hc6V6layulR71WccHWCzxPS97m6WcQg35wNyU+yuWn8JO9T5D?=
 =?us-ascii?Q?+6AY7fQnRI1Qob7ALzZOkJYpygLnabJcPsf3L15afXBe71cuxB6+8tKr8uMc?=
 =?us-ascii?Q?oK5FtXdAMMq4iV4597pRx1wX/XSarq2crmGREVc8vpAQFgvIc8l6eS60y3jP?=
 =?us-ascii?Q?n8AYz+Giyk5ak0YZeDM7D2d9cai/X2NyVD3B5T/6ttM3jjGQa2RLnUEmQA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+6F0cWRBQ2Q37rWClzbTNk1GbdnZ4JOUlkeGPn4GWqpoVTBf5ndaJi3tCUT?=
 =?us-ascii?Q?6BNJFdtZ+EDkIGDQmdVj2TgtAhEQDtxUEHNxCZX8V9rDUWVcids08qmXkCAZ?=
 =?us-ascii?Q?1o10aoL41g7CFyoNJh8ryeiQGwzY3ZTUV+mHbY5ELVh6koJOz1FYGXJ7hfDi?=
 =?us-ascii?Q?FRXPj5CxrOIvBv6H2QWaV15KetBFFPs8OxeXrfgWYPN5lv5e/dh0EoSDv4Db?=
 =?us-ascii?Q?Ss70m1K+dorc4f4F1qbPx0ho+BnoOFE4/AzQcMG6CsOZFoMIU3pzeNmQ2XdJ?=
 =?us-ascii?Q?pmlG3bWoIujbL0RnKUJAxy3tQBw7tcYrHGo3Tl2XDw5NzAbW40ZH/wkLuPCS?=
 =?us-ascii?Q?Wx8NiZR4CtJYESzahRy1Xj5sz7/DypwFjI+Gq7wOC1VweI8aoU/68mNY5k7N?=
 =?us-ascii?Q?2MwiBrRcHKbNYNw+VbT/Leei3aiongZMI6OIPS9sDfWsn8chFEooaZCyWCNh?=
 =?us-ascii?Q?CvTAd6J5iayINp2hP/1ptq4dFwCnqVs0sLTlyBn0zdytelKOuGd6m/6RvUN/?=
 =?us-ascii?Q?eCqGyOh2AhzabIXjRMrd0OEWvzWODMvtmZbKj0tjQHpdwxIIbGxKUta76IAz?=
 =?us-ascii?Q?sTecVGLIySBq9El0a8ud76c6VIhQo9o+uw4tpgME2sqFtzATKdjbw7EPJr59?=
 =?us-ascii?Q?c8xmt549v3VevIZUlPcybDenwocKu0tAJK1CNbqQ/zjAv/YFq7tM9Hr0EBxX?=
 =?us-ascii?Q?WdjpIoCUFsSf765KHed2uYtOdjj7fISkX1epxVl6AVSTTaQkeo7j9Q6Ew8ss?=
 =?us-ascii?Q?BjuD6EDyBJxvazlu5/FqR/1L3dAtgxn/3jMYrc8tuP1MBkZ1bszUcVI8ziBF?=
 =?us-ascii?Q?sTHF8Iu9IPemx72GILoE2yMjK943m99KEl175DYRSYD4TxFFiOplvr0vc6D5?=
 =?us-ascii?Q?OnxUDQ1F8+9Fzlkj6gDd59JfTHnufJ+Ize6ott9RHBwuuadznuI2X/WWXAZl?=
 =?us-ascii?Q?xK7DWFP6pRWmNAstIT7vO1ivo3tjwZUWrIhfSKF6eOJr1N5BcDnMr0nhHmss?=
 =?us-ascii?Q?JwwXSyptbUryoy2Pivbo1uxbJrPIcPvSD2c9G2wgz+/NuHZ8jV/xkaI9NMpk?=
 =?us-ascii?Q?xZ1vdgp6AT/CZYUUtnN0TCJNs46qLBkGXlJPY6DVoFHla66obA6E9d1b4erf?=
 =?us-ascii?Q?3BCDr+WpHFyz3jmXGelaSBa71OXl8BN7dprO7O7POTfSPIeVXNybneBFAp/S?=
 =?us-ascii?Q?k3AJBw9iyplvclnLCvO5JtTRNxNguXVte7LtR866mKHOJAaduj8XkXiDkPL8?=
 =?us-ascii?Q?kV4JSpoOGD3AdRCnxC7gHK42mSEBZCJxhkmD9/MLAPxrz+YIN8kDHwLptFwd?=
 =?us-ascii?Q?NS2v3mIYw4qqshSsmjewUNip/Vd8iy8Q/fjVvmf6+Tt6txYeoieUVOOzKrHn?=
 =?us-ascii?Q?IItsjlnDARpZu8KCLq6nEzvDdx8lc4Egsz40HBFYxS0ZavTfsTjJOhuYGEEt?=
 =?us-ascii?Q?nw7wICRM/fO2v8z3eGky5pNf+xj+JQXtsVO+rrGvKr50V8MPCe/WjyWTdXWj?=
 =?us-ascii?Q?eJdqkzR6FlEuCDlALwnJ1u+zUNm7d5oOQlkfXsmfzIXzTpDWWVquTRF2hf7+?=
 =?us-ascii?Q?Og0jC99G1nVKuCgwCLX+Dpxtb/qlqPs+hHcazKnE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ae7313-dc82-4d67-ddd1-08de24b91e72
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 02:37:43.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvN0YhroR7ooyLdeML6569rM+QLU4ZTf4ZtowCn45oLPCdp9T8MPRE0BsctGBi+R2S75HRE9nHni7LlQd/HFgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569

Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
initialized, so these link modes will not work for the fixed-link. This
leads to a TCP performance degradation issue observed on the i.MX943
platform.

The switch CPU port of i.MX943 is connected to an ENETC MAC, this link
is a fixed link and the link speed is 2.5Gbps. And one of the switch
user ports is the RGMII interface, and its link speed is 1Gbps. If the
flow-control of the fixed link is not enabled, we can easily observe
the iperf performance of TCP packets is very low. Because the inbound
rate on the CPU port is greater than the outbound rate on the user port,
the switch is prone to congestion, leading to the loss of some TCP
packets and requiring multiple retransmissions.

Solving this problem should be as simple as setting the Asym_Pause and
Pause bits. The reason why the Autoneg bit needs to be set is because
it was already set before the blame commit. Moreover, Russell provides
a very good explanation of why it needs to be set in the thread [1].

[1] https://lore.kernel.org/all/aRjqLN8eQDIQfBjS@shell.armlinux.org.uk/

Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link configuration")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
v2 changes:
1. Improve the commit message
2. Collect the Reviewed-by tag
v1: https://lore.kernel.org/imx/20251114052808.1129942-1-wei.fang@nxp.com/
---
 drivers/net/phy/phylink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 9d7799ea1c17..918244308215 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -637,6 +637,9 @@ static int phylink_validate(struct phylink *pl, unsigned long *supported,
 
 static void phylink_fill_fixedlink_supported(unsigned long *supported)
 {
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
-- 
2.34.1


