Return-Path: <netdev+bounces-154894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE498A00444
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA69163183
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 06:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BC01BFE05;
	Fri,  3 Jan 2025 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g2h7YMRc"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA41BEF7F;
	Fri,  3 Jan 2025 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735885415; cv=fail; b=dg9bx1ioSF7+3az5qJBrZOu6fGZE7ZIM6hlRy7VJ8xXtJPsipHIilSIdhdy4NxSpZfTmoh8UJqfEjdySiK9y8gBp/8IrlEfSjL28p1s2CpyLrxNs/J26VgE8x2UzQo2vIysp7/MXG/XHFzkRzg8EGDrcvMZBe4JYBXhzrGEjuA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735885415; c=relaxed/simple;
	bh=Wh1nROYi3GJCa4V69d/jYlVBAdaVKlkA3viWgnyu1SM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UJ66ripxjYCvC1FFybtQQ3QdyVvRKVglTZvBFVCIBvm5ntdtdj2WtEe+VNTWP4aZ1HprP8sd1uzxcp+PbR9qhyW5w6M+aAutG0uA865NqovgIvnepGJum/ZXEaA+V6uj9qSbADPme5NqzDWELDs6OujHE0EhUvV2yDrwZASzf5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g2h7YMRc; arc=fail smtp.client-ip=40.107.105.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPClOuCBTH0wo5ohAtKPfcaPJRt9AmYGg3m9mQPjqAnVPok+ZwyoLLZ6qmdyEaRSp/YU6JanqVye5NFajJd4v/rHRGPs6A97cPjfXSJPHhYJk0oOgrUfVPeXVUSJ7RB7aCRRz6GP3MgKxioIabgwKetNMOT0jltMPeJSH7WlEHm+/T6uwURdlIZ2KCYJjP3USxGB0hJYNny+NEC64mkJBKA0C22pKpqyZrdEMVbeMhVNe1wJtcguu2bfTq29QyOEMjdlbf+h48Es1JHOchi6FccpordrXcA5728eBA7iY/dGtgKS+q0ascN5QdcPF6uKS19i4dLY3DMiPWCdtjX+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL0zpCYuNsrm+dSQosKaPelH0k3flvNhybnHr5dmcQ0=;
 b=hi5c8DPBMiU6NMGRe2GpiaY687Gqg7CLrCYWM0LA7lI6Izgn3tBOEOf7ib4m7hD49qBW8C68a1YOqH0xdBgBNUcAQZ7VjFrodlvmRw3hegBM7U+kmd1ueEnAxNOXF/dktqBvV2PxmDtRv4Wx4HSIynPVjv4SClRTAIsH+YZdB4acnxwPd5SWcpWTmRBVcXzNzrXFDsNWQbLvq+TtnP5l5LPl/QcBat5mrUIHFOtljXIgXH8D+09Z5n68eTivZpJhyBDuTVAa0iHY7jWJaPbvc1l6i/+fCH+X++8r6CH37JBLYD3RWFfc/x0jSSIk0kUMU1WQEtYUjJx39tqKLe/03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL0zpCYuNsrm+dSQosKaPelH0k3flvNhybnHr5dmcQ0=;
 b=g2h7YMRcxseaFvWlHvq5x54d6POzxBSk9mPosbb3RuzMlXXDFwyxKFrqaFg6Ndc7ivOa7rEu80VOzszmcASNmcgKn9MVG1IVPzY4DG0E1eDn6daIatHkYXiQxswhKRjZXBmKH3ma7Gez3bFeWmvNJZlVyOkTmDH5AAXp+6gpMXFwJF/oewo7JGH6I4d2ybhtrcTtklBZujrektsiATzY0z2H6ljJJOzLUpA9jIIPDwVMyZa6DseC4/taJQc4sGmUN7bmpI6wRVsPfzHT7oxrz6wbtwwrR4INWWLdQPj63aYvy60iFTN3OC0CsEJojGTee+SjirDM7rbkONg3mAZuWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9331.eurprd04.prod.outlook.com (2603:10a6:10:36d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 06:23:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 06:23:25 +0000
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
Subject: [PATCH net-next 06/13] net: enetc: make enetc_set_rxfh() and enetc_get_rxfh() reusable
Date: Fri,  3 Jan 2025 14:06:02 +0800
Message-Id: <20250103060610.2233908-7-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1a2e6f1f-78a5-44e4-1694-08dd2bbf2165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A/MTYyiGK5DZHJL4E8jvq3aJUGkKj6Ue8GT3fDiwqL0A3tMMsk3/hPOJ1V/G?=
 =?us-ascii?Q?pWKkAvMJ/cDCPZq+yOwdbk04YDM+W0XrqXvSjFH2LEU+AvEgrkJLeVwg+jCZ?=
 =?us-ascii?Q?iGWMXq9lts6cxn2lXDYKR/xCIRwwYMQtmpFYtltKRoebvTfzFiichI7OPFck?=
 =?us-ascii?Q?LkC0geeyaOrXRqCy90e+/7MjSAEkSaG3pX+M2xqLyHXtYvynQSUNq7tG+zqM?=
 =?us-ascii?Q?j59r24b5IUZmYIdih4cBkcL4/5l5EkmvORDNa0y/29Lq87jRHsa136ogWP5P?=
 =?us-ascii?Q?VhGCkGI4mx9eDEnXlM8NbuQF2AsiQIsnkHRpEe8CuE+iHyYOgpHptkHBgre1?=
 =?us-ascii?Q?MYkwHfE2kwhq/vDYbAXMLwJqzS+EBwHNgPk9YYW2azjZidlPQYM/n6m8jrS8?=
 =?us-ascii?Q?7cnwi+oV66MW/gIIO07NQFY5WaVfnrmtWjMHooVVjjB4C1Z9/o6YjY8eQFZz?=
 =?us-ascii?Q?u5naygfA5m2m52/6Qub0nneq+IDGP4dD+bL4RNPmLQpX2fZsu1tyXPw2XtWI?=
 =?us-ascii?Q?XpuSNExhk+k/SezxaYri1goBJCyXbmepZxos8RnqBaEMlE8wGhFpYFX8kOf7?=
 =?us-ascii?Q?a3oJ9kVqO8LDD5kjPQdIgFrjYzJ3mqqjOWloWB/ROZtuEVPQmF+09sOZ9rAu?=
 =?us-ascii?Q?/vtkGxKsDZtnJI/IdDCLxtNPQb3rtIgOWAoU5wLllBVF2gcKtcqMLVUm/Z8Y?=
 =?us-ascii?Q?fcpyOgmGsgpOST7RVJNGnbCugYOC4R8/7RINm1VXxFZvJylU0Gkvh/la8NtY?=
 =?us-ascii?Q?4PuCBabwg01zvIIOzceO9ykHvZ5w5PMk9zJ4PSr2/VSmtdJABrYYB2VXLbMt?=
 =?us-ascii?Q?fQBWBYepxHbdDKPEVPxBOhbUSvWPdduu+eo1dOlR4tMStXmEXbIYeUZdQL2D?=
 =?us-ascii?Q?o4IcLq5zTXFBh0PDhaK1tclhH7ZjpCQbNzE+bqAHDdL5E4+9JjHYFD0IPeiz?=
 =?us-ascii?Q?yPg9S+GIBUQOi16JUKTrWylOG5rNcuzQqdB0CmpXSQEXicigq7/3PWtnFuWu?=
 =?us-ascii?Q?nsC7aDRMc3NZ6IxJmTXULOUN4z2R4CmGvKChW3fgQWwqsU3FJ8NUEItbnZb/?=
 =?us-ascii?Q?aRwjxojMepVuJX7cYVbgExkQjysKt66msADFx34Ix5r2pTAJhBkiGXrtnMMp?=
 =?us-ascii?Q?G21r56flOBJAFR0HyNbF/6fJ4pE914h85jHP8PEDADwjsM46tAe8XYc6M5HX?=
 =?us-ascii?Q?/f1uM++IRuBKChNhmf4NDeWDd9UylknzGwdwRyls5aCyBlC1CmFbo7I9pJti?=
 =?us-ascii?Q?hbfSpVMaPXX/jH23nEEMpc6rAn5B5dT96mu0dyJX1Ul7O+nzywz5C8H/8m+X?=
 =?us-ascii?Q?GCjY6NKf3gF3+0jgrS1eDgg/FgpE0CQvmxT9ghVe6fWUMVPlQXqNOapbnt8e?=
 =?us-ascii?Q?OVV8WoV78mxAUwOU6Cw+MU9LaNWeLmMNO+ylLLZWvDE6+0mJH8w0wEQr8Ny1?=
 =?us-ascii?Q?pz4sNgmOzZJMYu/A5NGSWO9qaeySk79+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PJaOp3S6om2GmWyjT5LXcBKebmWswdsfwSiszLY0SbsFVoby+P9OnvRWRPcY?=
 =?us-ascii?Q?OjZ9UW3iDSzItdqTxAIp10s91MxdeVETLmlejW9wFJc2fLa5Em3jc/+4tL4+?=
 =?us-ascii?Q?JnUxQAgvxPkRfhzuyp5rO6xQKoV/TJzTAsSKHXE1P937qDvPOuvuA8Ul1VK8?=
 =?us-ascii?Q?Pg1S80r0EPU+oqKx/dD9tgrD+MzGSHSC3QCpB4QUSrL4hwPtOV9p0QClcIIF?=
 =?us-ascii?Q?lzs+KzIo0fcoDwbk6zsfbT2k/QH7d3WWDDdB29eedNn2yTG/6aYt+RnPjcNq?=
 =?us-ascii?Q?0tZdkqVyaSVfUqMBavo+aS6sr5tLsPMC/Fs49fnmc74W6TEU13uxvjkhaNV9?=
 =?us-ascii?Q?Wy0en2L4K3uYlXb5TNPCjH9Tt7+RGTZ2WfCFFfQcTHLqMYvrFc03j89wj3xX?=
 =?us-ascii?Q?U8PCzsYZj15I7SUA9fsHIVg2bpcrXd+fq9MhIxWs7d+b3a3ObRM1+UJczbRk?=
 =?us-ascii?Q?qDeuzy205cvhCollRyh2QPK82B1qfZf9+uIMdKmlrXCz2CSgMwIpsRkx2p0B?=
 =?us-ascii?Q?7dyrzPxA0hdQ4eWpR4KUYiMpJXEwNz3GWF3lwKdgyo3pUK0SAclaIgMoc6VQ?=
 =?us-ascii?Q?gQ4IGsSsQrQ4Fff1+Abibrmq0wXKrn1y/p6d2TVB1aAfg6pJ80fuKU5M9yQ4?=
 =?us-ascii?Q?Isj4eVGECjuMtnLtsNew1pp1upyV8yg0sSzlBvjjmPYftJwXegxqMM0TJbW1?=
 =?us-ascii?Q?Y+gEQP4uSC1phWZzCEATTY/q4DQb5+3sfPD+0ZThrqV8vN430b2GdXq6V9JV?=
 =?us-ascii?Q?HJrJ9z2IMdG5TpYxvt53D8fd/2ovucoZOaDMPvAcwPxd9FnoShsibLc05yGC?=
 =?us-ascii?Q?U5SDpsXWbGH8zk8XtxuHzpzJIqQ9HjfXOHagWHPhlwpCNp9NMeFXSehL0viz?=
 =?us-ascii?Q?ngQyhiP1IVk0wNbvp6XxSYJF4Mkwj4TtrgVLZt94Mt8Epw8x0twdWl0y4D9V?=
 =?us-ascii?Q?iX5tzanIAhHSlOiUvFhBJLz3tQDtGFZ+4zHLC0nNKUzM9PCqawcHzN3q9iAd?=
 =?us-ascii?Q?+FXKeSPnRflrPHfgtvMY0SdBve7VstgL+LUAQtizvjultKgMZl9puQ6B5YBX?=
 =?us-ascii?Q?U0VFMk+gMySj03gbc7r5sJyPXFCyXDH2DGUwa2CaLNlxKrJgN4O9qPAOJYQt?=
 =?us-ascii?Q?+A77w0u5V8B33LeZL8PNhvU+fr0+HYy1710rG7lM1aRgE0v9KiS+xWevlYTw?=
 =?us-ascii?Q?lpiA7aNuTYU7f7EmKJq0NDsXOStET46Hr3dW+jdrGv9jd4x9YCWXojt3lpLL?=
 =?us-ascii?Q?LxSFJaceKdt9NwLQ3ktjeEV/Umg8/BfyA6yXKCxyRy9SXK+UX6DjdSXRdtAl?=
 =?us-ascii?Q?k5VNvI+WYCs67ZTht8rpgfBt1d0Cm0U7cSXEu5wIFWWk6wY8lGp9tult4J2l?=
 =?us-ascii?Q?uCJJl/CGxNQrttAarm8B1E8/l2UOLGSv37nN3PNVBJulclTHHq2JuXfLFRVv?=
 =?us-ascii?Q?Lt9xx+0zZYQUCr3VhR3Vkg3xmwo3izU7skw2cQ0IdxLrb2Iw2083HYfxuvnQ?=
 =?us-ascii?Q?aOk9CfqpzEhjnPq6BaDQGjP2G3du98H1NYoOJjBM3D8NU+mSYW/qp+KP3+vG?=
 =?us-ascii?Q?aYVpExmdd0UJIk9UqEjT6pYis0+9F8yDP20XY4nF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2e6f1f-78a5-44e4-1694-08dd2bbf2165
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:23:25.7751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUh+o968Yc0ZoE3+XjbbFiV5rVPMWB0/VDacj6Ow11aTtz/a8xTPVtI9sJVt16wE9JHSxy/hP/eh7Q5jjaxygQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9331

Both ENETC v1 and v4 support Receive Side Scaling (RSS), but the offset
of the RSS key registers is different. In order to make enetc_get_rxfh()
and enetc_set_rxfh() be reused by ENETC v4, the .set_rss_key() and
.get_rss_key() interfaces are added to enect_pf_ops.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  1 -
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 42 +++++++++----------
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 18 ++++++++
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  2 +
 4 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index ca1bc85c0ac9..fb53fb961364 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -537,7 +537,6 @@ int enetc_set_mac_flt_entry(struct enetc_si *si, int index,
 int enetc_clear_mac_flt_entry(struct enetc_si *si, int index);
 int enetc_set_fs_entry(struct enetc_si *si, struct enetc_cmd_rfse *rfse,
 		       int index);
-void enetc_set_rss_key(struct enetc_hw *hw, const u8 *bytes);
 int enetc_get_rss_table(struct enetc_si *si, u32 *table, int count);
 int enetc_set_rss_table(struct enetc_si *si, const u32 *table, int count);
 int enetc_send_cmd(struct enetc_si *si, struct enetc_cbd *cbd);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index bf34b5bb1e35..56ba82830279 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -4,7 +4,8 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/net_tstamp.h>
 #include <linux/module.h>
-#include "enetc.h"
+
+#include "enetc_pf.h"
 
 static const u32 enetc_si_regs[] = {
 	ENETC_SIMR, ENETC_SIPMAR0, ENETC_SIPMAR1, ENETC_SICBDRMR,
@@ -681,51 +682,46 @@ static int enetc_get_rxfh(struct net_device *ndev,
 			  struct ethtool_rxfh_param *rxfh)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
-	int err = 0, i;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
+	int err = 0;
 
 	/* return hash function */
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
 
 	/* return hash key */
-	if (rxfh->key && hw->port)
-		for (i = 0; i < ENETC_RSSHASH_KEY_SIZE / 4; i++)
-			((u32 *)rxfh->key)[i] = enetc_port_rd(hw,
-							      ENETC_PRSSK(i));
+	if (rxfh->key && enetc_si_is_pf(si)) {
+		struct enetc_pf *pf = enetc_si_priv(si);
+
+		pf->ops->get_rss_key(hw, rxfh->key);
+	}
 
 	/* return RSS table */
 	if (rxfh->indir)
-		err = enetc_get_rss_table(priv->si, rxfh->indir,
-					  priv->si->num_rss);
+		err = enetc_get_rss_table(si, rxfh->indir, si->num_rss);
 
 	return err;
 }
 
-void enetc_set_rss_key(struct enetc_hw *hw, const u8 *bytes)
-{
-	int i;
-
-	for (i = 0; i < ENETC_RSSHASH_KEY_SIZE / 4; i++)
-		enetc_port_wr(hw, ENETC_PRSSK(i), ((u32 *)bytes)[i]);
-}
-EXPORT_SYMBOL_GPL(enetc_set_rss_key);
-
 static int enetc_set_rxfh(struct net_device *ndev,
 			  struct ethtool_rxfh_param *rxfh,
 			  struct netlink_ext_ack *extack)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
 	int err = 0;
 
 	/* set hash key, if PF */
-	if (rxfh->key && hw->port)
-		enetc_set_rss_key(hw, rxfh->key);
+	if (rxfh->key && enetc_si_is_pf(si)) {
+		struct enetc_pf *pf = enetc_si_priv(si);
+
+		pf->ops->set_rss_key(hw, rxfh->key);
+	}
 
 	/* set RSS table */
 	if (rxfh->indir)
-		err = enetc_set_rss_table(priv->si, rxfh->indir,
-					  priv->si->num_rss);
+		err = enetc_set_rss_table(si, rxfh->indir, si->num_rss);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index cc3e52bd3096..f050cf039733 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -512,6 +512,22 @@ static void enetc_mac_enable(struct enetc_si *si, bool en)
 	enetc_port_mac_wr(si, ENETC_PM0_CMD_CFG, val);
 }
 
+static void enetc_set_rss_key(struct enetc_hw *hw, const u8 *key)
+{
+	int i;
+
+	for (i = 0; i < ENETC_RSSHASH_KEY_SIZE / 4; i++)
+		enetc_port_wr(hw, ENETC_PRSSK(i), ((u32 *)key)[i]);
+}
+
+static void enetc_get_rss_key(struct enetc_hw *hw, u8 *key)
+{
+	int i;
+
+	for (i = 0; i < ENETC_RSSHASH_KEY_SIZE / 4; i++)
+		((u32 *)key)[i] = enetc_port_rd(hw, ENETC_PRSSK(i));
+}
+
 static void enetc_configure_port(struct enetc_pf *pf)
 {
 	u8 hash_key[ENETC_RSSHASH_KEY_SIZE];
@@ -975,6 +991,8 @@ static const struct enetc_pf_ops enetc_pf_ops = {
 	.create_pcs = enetc_pf_create_pcs,
 	.destroy_pcs = enetc_pf_destroy_pcs,
 	.enable_psfp = enetc_psfp_enable,
+	.set_rss_key = enetc_set_rss_key,
+	.get_rss_key = enetc_get_rss_key,
 };
 
 static int enetc_pf_probe(struct pci_dev *pdev,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 3b0cb0d8bf48..916818d2fdb5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -39,6 +39,8 @@ struct enetc_pf_ops {
 	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus *bus);
 	void (*destroy_pcs)(struct phylink_pcs *pcs);
 	int (*enable_psfp)(struct enetc_ndev_priv *priv);
+	void (*set_rss_key)(struct enetc_hw *hw, const u8 *key);
+	void (*get_rss_key)(struct enetc_hw *hw, u8 *key);
 };
 
 struct enetc_pf {
-- 
2.34.1


