Return-Path: <netdev+bounces-234320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DEEC1F56F
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19CBF4EA022
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAF2347BB1;
	Thu, 30 Oct 2025 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RfV63aZ9"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8875C346E42;
	Thu, 30 Oct 2025 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817082; cv=fail; b=OHcHGCzPOmvZ4aQ6jbw/NrD7v8UNYx81Md/jj3MeljJ30Xw9QhlJfvMkiKr4JMezkpciwFVIazCC9AzbDWmBttUZx6N8dY+7WsaPPGTK5JR+bwIy85i2FOMd/HKr58frFcy1hxbSTZicv4KCpxvaAlXSovrNZzJ226IBULtycQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817082; c=relaxed/simple;
	bh=sWt86e1ST4/2vw+V3UGZTwzz9X6Uj6EY+dkiZelR08I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V+hhEj7+tMa7Sm4Tv1AeWetDedIsm0ZFK3FZZLnyLmnuivL8g/QHnURX7OLymX1C2x5Me21ZVGs+Z5L4l5+3+QYjoEUomgzrdLhy3o7KfcyoofF5o0n2XtgalzyvTOsGsoae5T11aILy+ay2ep27ivXFI5MXYZ1PpoNtZrMk43A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RfV63aZ9; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/Y7wQIKHB2gq2BWMhBnSoQS3+JIUXE1z7kR4Lhi96W9SmLm22twOXxvrl/3ujs6v+/J9zG+8Q7aKa3koQdfiisH+HzwctEJiVKzP+s4V7jqM9cF68JQTE8bqFlYk1oqbQw3+1jo1bKWer4vnPha/yz5AESW9PWt2+h1J/BWrzns+Pd6/+0Nk4V0nNjLKG5KVFZVpfhKueXw3UuXMWXOubiqRlW2BxO7+9x8AiyrGzlvoIhxL/tNN2oOzPRcfCWFdBD2b/HG8cWs6sFNy6PbtOxmE18eMdEspJ2mEtXGLKNEQd7OxpoRHAdDvX8uGmzCtnUD3j5SZxb4szx9EyAnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwFOiK3ouMKDF4kJtJ+QcmT/4d8UpatWOdCZFOfzJKE=;
 b=y5T7N/JHSM1AdOtgyw3vjwxWX4tKM9t7Xp++Un81iFcsVPdA9q0e5Vgk+j1QST3UaMF9gy3vEkDwo2U+KS/Y+7gSmL/D/h2l88eyUz0BTbZt2WoUpSr53E/EaA+YTgU1gu+GrbH0YIIoV5AbOfEtU07N7ZZTmOKszqPYuDdce0ZJ0OyKvBXN3OtvEvPd/eeItH+D8OtMFWUuuP7Rf6YEBNNVq8YJiAqLtEYbBuXkDNkKRr6Ad44AZxHCAPxaYBGIJ57GXpTWTqfSU5K/dX8oAfkMhLom5i12DtZ3NesCIKnlSWjjgw6aVs77L0CI82ryk4+IxGX5AvR5G/HEgt+3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwFOiK3ouMKDF4kJtJ+QcmT/4d8UpatWOdCZFOfzJKE=;
 b=RfV63aZ9hmo9oxNgJFNrUH9dMefw84tB+dJjLQ0rf7ASkWXrE0PFAN/792yAopnf6rhhrlESh5s/n3OI7bjoULit9WlF/2zVgQ154uG15xOeJOsfeKQJcO5B5fPCpUtm4tgpSh4e8Wfh3XGYphaZmgrMHsrclY3CifNlQ2WUhp+RXPsGhpnB+4sfCwEHgIppe3IHtrx7wHamcP+BanYosgtpY/X7c87mXp7JDOSuBGBszLrU5hx3mUyHSt7CWPCRbqtWKgaIyZqjCeasz2EPl5Zs7cBu+L/f5CJXAPKPMufYCIWoSwxmYGmRTaTgXAZVp0zgCPhS/AhaAHs7zYcQKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9356.eurprd04.prod.outlook.com (2603:10a6:10:36a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 09:37:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 09:37:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: aziz.sellami@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] net: enetc: add port MDIO support for ENETC v4
Date: Thu, 30 Oct 2025 17:15:38 +0800
Message-Id: <20251030091538.581541-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030091538.581541-1-wei.fang@nxp.com>
References: <20251030091538.581541-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6491b6-6712-4957-3459-08de1798011e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Vve1VGedUmNuVGtetQt6nveoAyebL3/ywXAoiSymsJMVu6A5c04tpsy2QYD?=
 =?us-ascii?Q?w4R1ZrHCpHAZmM6x6LHWI5/NYm6/FC24auK+IC9lSfmMr6rUM9uAHgSNASki?=
 =?us-ascii?Q?7ALr137snKfd+g2JwQztrx4sQE15+5F61DgZiaDVsMgIeX3SV02JGCjXTMuG?=
 =?us-ascii?Q?YTGNOTV5Hsi2ST9DxgisCGgHi1M8qeEYJ5sXwt3BUJrIvmHslwJYSgGrPrXk?=
 =?us-ascii?Q?npCF6lc2a0BtGFlQcwPftI7tEZgJVz2iO5CPEvSR3j8687xxwcOAdY3RKsI8?=
 =?us-ascii?Q?QtWxI1rxlrTCo1gUimdjxLRoKymQ2s/9D7K1Qgruu8RW3hZAUpfKxUx0vZk+?=
 =?us-ascii?Q?8IU9xnbtcqsoPCSsyBQqOr1D6CQuAPljlMmH38Fznwl8TNWXlWy8LSBdsEcL?=
 =?us-ascii?Q?NAd1e36DCaY2q9RUCNDOzs9HQbe0vn6mx2Uv7sDnqGU8fAmZK5vWS4ClbwV5?=
 =?us-ascii?Q?kOpp4jQJjxMNWZ8ISHzptYKshkQRR+NI+T2iy4XlkMP+kDzY7VASnKA7HdRa?=
 =?us-ascii?Q?nkWlszDCerindlEIbtboX+KxhQDM+d302l0yDmtwpk5TE6KTXfkMwuWQDQlA?=
 =?us-ascii?Q?ahilyKiVePaHRDui5YpLl89+NQHeMR/KEomNt1Q84Rjwg84uEV/2rCmrMSFB?=
 =?us-ascii?Q?UNRqPdZXYfBdgb+YHhItf2yfH0LQNcKy4PQo0It7KoobbZmUcKQkitpnmyFJ?=
 =?us-ascii?Q?iEhtpk/f/1d4seDRFQQ2QfwYo/UvnSLvyayIGix7rNxC5Sk8oiNtJJhCjk2H?=
 =?us-ascii?Q?6c81unfMtl2m6+VDouGhoSSAxTivgMdZfVgSq3jQWJSft1khzqgZSWms8cFH?=
 =?us-ascii?Q?9quaQDQOD3B1COQ5N+h5CIifAIA3dQa9PG+qHkDkpaQ9MVO/pJZsbe6192g0?=
 =?us-ascii?Q?5dGJ/ExvXLQqOHFCW/SgnV2Z1qfhi2K5f29VDdrzXGy8kwMxIWKmyoXJOpOj?=
 =?us-ascii?Q?9DFW3NnQqVwDfO0Bxe3ceyuIvAmnQawODyiM5oMke7T1pFWHhyGKR/gLG7ue?=
 =?us-ascii?Q?pMv3Sr1X6FUHikw1A6prvOGMcCML3NiHXu/oz//OlKY5yXsIwIsadTzlJroe?=
 =?us-ascii?Q?6qzRCphj/d1euRLF8UQAsxY1vrkphWx4wpfaCNZgkmiLiRM/JpBFcvzePmbq?=
 =?us-ascii?Q?wYUsNA/YttJMVe6MDqnKiGbfqOH/PQBBMwlhU3oOmQBVnrw3Kv4dmEIuZ45z?=
 =?us-ascii?Q?/kHJbZb7FmRi6S3s4rXiomscn1kRut497xtiVx17PLuu1u58UTVt6TFmu9Xe?=
 =?us-ascii?Q?C+nl0veYcwlrPYE6IqGMORI1xTAVWoHqdLl7MpVMfYHfs4Rw1kjIN4/3u+Ps?=
 =?us-ascii?Q?Bq6SQL2xoG/bi5pLcGMnDEwowWqMTX6mgBuSm3bRe1su5HKY9HKlMWt0iK3h?=
 =?us-ascii?Q?3zCWk+jdNJxhd+lCLnb1le0cehQ/JM3gs9ObL8JtjTYicePGbZ9ErO7b8bjc?=
 =?us-ascii?Q?E9QLWqT8NJLtpqCTZiYutrmcfISB8r8fJ8/jWy1mz+buTfZCWcKnWx7LitAo?=
 =?us-ascii?Q?g1T00SqVMZo8HFs/aHzK/CPsHQQLuxTmbYRY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rt/NvgyhPCvNlKIScOTNKHdCe68aNriBHFTtPmBGkR3MEFfnJlH4ZPe0bb/j?=
 =?us-ascii?Q?dDWU3cGVm+hwX/tmyCbESAp8//iqK1ydF/0iwnOAihj8vfqgU0SQo0kZypTf?=
 =?us-ascii?Q?rYsHyajByHQlJIc0/HYPtQzLL+SGmh32QoYfiM9BJHOPUqm8ZlWe9+YXc4ki?=
 =?us-ascii?Q?/gjHu+k6K/Vw6oWk3F8RMzAXLxbJSamN0+YDDFuYpj3WfuPdyOekGsf+OLxn?=
 =?us-ascii?Q?dFT5wsthqDqGcMTUKNdE4Od6HnsaQbfIpyu/Q+FAG3Cyw40G+RNKlABUQUWx?=
 =?us-ascii?Q?bM3h6N8vYpuRrVAmEf0zyz/Es7pt6sATw15lS8dAKgRoERYIT5CY6lMLQxit?=
 =?us-ascii?Q?KDHug8LxrGUOKU1/2b+aQ/G0lyWnAsKWklwxqMTub0DgxgGBes5VUoD+5xvT?=
 =?us-ascii?Q?GbfhcKQgvAJYAy1Fa1ob7lnK8Min/Emu4wPC6cpuqSnjyFT2rUlhLbzKsVwR?=
 =?us-ascii?Q?io+y+i59RcAg8o5Thw0eRskJLI8MgUYOUMxkAjM372GfXz1KX7XzVJW+cCP6?=
 =?us-ascii?Q?SRVLcQfFAcKDdO4WQKTB5Pznd5kfz1pyL+mCcugENlCfy4JJgdJSUcjsNOkw?=
 =?us-ascii?Q?DttCTu0SE6XoFrpi34ywiqGjImAbhCcvRNpaOdP7foEh8DMqQxc/HunXWJLm?=
 =?us-ascii?Q?fWgR3ZpPhYa8cmOkAASHKCHZrlcAYKT7zO5U5P6wI6Fy4eMali79OzAVNDKj?=
 =?us-ascii?Q?ryyxbKZY+KQXbbPGSJ4dG9EQKiXpXo6qYuphqCRz0mLhK1FImpc+/JGYA46L?=
 =?us-ascii?Q?NrwMEFI692/4291CDp8u2HGd1tzYlOb4dY72BSKzocSEZH5lh2pYTTYK6hjr?=
 =?us-ascii?Q?g5AsOdvb0Q3XT5jvNwymDozM6a0UK0bRUmLHDsYPb+JIzL14u730YQ4+7rzk?=
 =?us-ascii?Q?yabc4N1MybRf7uVoEW+zF8eqHFhi71O6nYOPIVt4utjG2bBt4SjS3Z789T+8?=
 =?us-ascii?Q?O2IjYqgPRKFjci1kvJp8OUAEsINjX017Ziu3LLdme7ob76GELsSWyBZVNK6n?=
 =?us-ascii?Q?9ctz+g2ROlcXQdyj6zsi5bheO+iuq20cgqMLVwub9nDlosmXR4cLXwC/XCqK?=
 =?us-ascii?Q?ClpncBMkRgxRtuRg5z5jV2yc3Yr4UHwNkyibNBOikh6C1rphrT5EnezdmCc+?=
 =?us-ascii?Q?pSBvg3w8h5u6LvaW4ZsFaHUnG88KP90SbLoWjpat2NuyVGybELiAOUYhWVgE?=
 =?us-ascii?Q?uaMYyId2C7TbTsxWZkpVHPDKVrXDlnPHmTL6yNA84Ac96vQW2H8Oh3+rKbXa?=
 =?us-ascii?Q?Msfz7n+92lxD7YUxud0jQfpsH01g4heLJbu/0/O4t7udJiQYhSu8wLm617/b?=
 =?us-ascii?Q?g5XX6tBcJbKeo+2hCnbKfg0XrXgsx7P2bml6AhAfpC8yQ2srY1i1jApYKxJQ?=
 =?us-ascii?Q?4ywntKyGgQ7NG4cmElv4SEKxMIKkSLPrGjt5dhUN3+Z0KJ0YU2NfIOeB3sKo?=
 =?us-ascii?Q?03rRtffcMZ/Ue2HeO3L4i/K0aVuAQzQk+KfMGrmFAFtDCycdEH6nL0/MMwr5?=
 =?us-ascii?Q?+pn7dY5WyN9vqkWmLSd6boWtU0CBkvMZVUyHySpwEKIm0sTPEi27v/MA+JrQ?=
 =?us-ascii?Q?Hfpr/Ya6Dq/Re11eU04MTzMPoEmjJioHates3WKL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6491b6-6712-4957-3459-08de1798011e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:37:57.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyLcNxmE4msarAIeNGlYxWxP16hkKpwwMVH8OsdMvhiHrPSQ0KL7UGg8R2G+qSR4fOQdVL4NITp6gtWrfTRHfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9356

The NETC IP provides two ways for ENETC to access the external PHY, one
is the external MDIO interface is controlled by EMDIO module, and EMDIO
provides a way for different ENETCs to share a set of MDIO signals to
access their PHYs. And this EMDIO support has been added in the commit
a52201fb9caa ("net: enetc: add i.MX95 EMDIO support"). The other way
is that each ENETC has its set of MDIO registers to access and control
its PHY.

In addition, each ENETC has one internal MDIO interface for managing
on-die PHY (PCS). So add port internal and external MDIO support for
ENETC v4.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_hw.h   |  6 ++++++
 .../net/ethernet/freescale/enetc/enetc_pf_common.c | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index ebea4298791c..3ed0f7a02767 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -170,6 +170,9 @@
 /* Port MAC 0/1 Maximum Frame Length Register */
 #define ENETC4_PM_MAXFRM(mac)		(0x5014 + (mac) * 0x400)
 
+/* Port internal MDIO base address, use to access PCS */
+#define ENETC4_PM_IMDIO_BASE		0x5030
+
 /* Port MAC 0/1 Pause Quanta Register */
 #define ENETC4_PM_PAUSE_QUANTA(mac)	(0x5054 + (mac) * 0x400)
 
@@ -198,6 +201,9 @@
 #define   SSP_1G			2
 #define  PM_IF_MODE_ENA			BIT(15)
 
+/* Port external MDIO Base address, use to access off-chip PHY */
+#define ENETC4_EMDIO_BASE		0x5c00
+
 /**********************ENETC Pseudo MAC port registers************************/
 /* Port pseudo MAC receive octets counter (64-bit) */
 #define ENETC4_PPMROCR			0x5080
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 9c634205e2a7..76263b8566bb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -176,7 +176,12 @@ static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
 	bus->parent = dev;
 	mdio_priv = bus->priv;
 	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
+
+	if (is_enetc_rev1(pf->si))
+		mdio_priv->mdio_base = ENETC_EMDIO_BASE;
+	else
+		mdio_priv->mdio_base = ENETC4_EMDIO_BASE;
+
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
 
 	err = of_mdiobus_register(bus, np);
@@ -221,7 +226,12 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 	bus->phy_mask = ~0;
 	mdio_priv = bus->priv;
 	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
+
+	if (is_enetc_rev1(pf->si))
+		mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
+	else
+		mdio_priv->mdio_base = ENETC4_PM_IMDIO_BASE;
+
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
 
 	err = mdiobus_register(bus);
-- 
2.34.1


