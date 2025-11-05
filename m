Return-Path: <netdev+bounces-235711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5C1C33F5D
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 05:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 010494F5751
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 04:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C3726F476;
	Wed,  5 Nov 2025 04:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CCWnCLsM"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E652526E143;
	Wed,  5 Nov 2025 04:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762318578; cv=fail; b=jhqcN8C/bulbPB3KE5PGa7qBxhcLDU1eTnazpMR0sUqK6Y0lDvlsyu/63WydIUX7cWJ44Ag1Yqth2LBxpKrjAi0Rk31paSEOpqGWkUBiyKhepty+B3xp17IJ95rYUNfmBYUhsk+wMVQlSwd8EU+zj6xVraN4rv5js+MGtzDRoxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762318578; c=relaxed/simple;
	bh=B6UnJ/NK/IW9cUv1Zy1VARHXvT1lk1uPHKyPByZOaf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ruwG63qvwGi2rrRmEyAdQfzFxHM9VT/C2vTmY+qbQMWobTVfB0b/2p/wj4qFP7v6afQimDegzVfnQkWSEsfmX5id7l6er7vUWE3i1FOlJm7MOjzrDtVH0s1T0EBoTrly/xVCQCAKA7g97VKFM+lsBkROqBJiUJK7US/EAqj6KIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CCWnCLsM; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZewHyqN7n+cX40X5maZXZlRBrdYIMq1jfJyHbF+glJ2WaUDGuyb2LQ2DZOukDMnhGSK/2d9TYAjCeVHvFqTjLcXKOxGqJxkvSi+B9h9Fy6gmAIeTsNx0TVopEE3MTsQeBjAaEjKK0eQT546ikfTV6H6y7w8OTMMYB5MBT9ESpARdk0FqCv0cYv7uZKxe4KGXB7T5hfkB1tBQMW7UzU4JYabmr5GxbvJ/TZzcyEKrDBNNPxEAmWdetCAb00S3Gxq6o1WzYOPsNSq2jcv+sRvGFagwKPqZBdlB0eritohVeRr+mD+erWpE9Tepx0X9q5vePShhxyjM5WSemE+K4tc1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rHFcH20J5fxPAo+Yd25GGx+cvRBQiJeRDpBw5BzpWA=;
 b=jKw3xvXum/GFeqSdkelCcw5L9paZMwWuLsCxPSDMt7Tc0CSFV7Pv4kFs9o/IoeT697FbAghzvugbxQ3DQ7IRWJmBfRhq6qV0mRDQWCTJXfVRPCCD47LIFScsI0wS9BgQneKX+Zh+6UIU3hh51pLE+7mIGdsZPMDK/2FPZf3OBF7g9g5SCAiLfUzvvyK2r0dZZ/cZDpwGxdT+nT85RwEb0OCwpeD4LNskvIGt2GGeXVuUojB23YCpEIH2DqKUJ0sCj2e5SmFklgANxbMwXqNmu+00otCYeeVzbTKzJA25y8b7zflEO1SRFQ0nBHzGo4QfYW0mSiWOjGJqe3zjkSMohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rHFcH20J5fxPAo+Yd25GGx+cvRBQiJeRDpBw5BzpWA=;
 b=CCWnCLsMvilA1GlSCt3iHkLCSvHBVKWkqMEgISwHV2kU7+wqE9ZG+wLc5aCQ/4066RKnvspXYvRGdJS4fBdt0Qv47S7AMU4ZOEVVKxIAobdhmSH7WjSH5n9tX8XQ1rIiyukdWk30wF21ME7qbbcZNeqJrJbLqbnUkpLSOXPCn1o2zlT4ZT9elOP+WSJD+y+XZIgxv1Wl/8kjFR9tpfhRDm3w4rfS+S1cX/5i8QEnFi1D8GiGw+E/TwzmIPvwGxUbxAMCJtKwzEWR0WHXaV89uV3oNpI8FLW+4nXzdB9u5JsClpO2olxwg/NYMM8QKSzCilht2C/gCy/vyp02bz0KkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB12053.eurprd04.prod.outlook.com (2603:10a6:800:324::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 04:56:12 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 04:56:11 +0000
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
Subject: [PATCH v2 net-next 2/3] net: enetc: set external MDIO PHY address for i.MX94 ENETC
Date: Wed,  5 Nov 2025 12:33:43 +0800
Message-Id: <20251105043344.677592-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105043344.677592-1-wei.fang@nxp.com>
References: <20251105043344.677592-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0174.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::8) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB12053:EE_
X-MS-Office365-Filtering-Correlation-Id: 502fba7c-d05d-4f45-06fc-08de1c27a41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yJpMgBOmhW5Ikd4amNXIwDcpyy5MMYOAYOC8FaUq1guOrmYOXd0bhHalbzca?=
 =?us-ascii?Q?qCO15IeIekeDbNpKimit1iickY3AM/uXfKY1q3kbjGU0bgSUZSNPVtc8JAI+?=
 =?us-ascii?Q?ElcjC8CfsvpLPNZ01Mwy2ZDe33ZKUuZu05cUyv8jbwiQhfA1m2f8qcc3lGen?=
 =?us-ascii?Q?uQOZ8zIekegy3p/4zDcb7J+6SOnEBzHKgHmjcvtMFGfmMIVhtp2tBPmyZM+N?=
 =?us-ascii?Q?FwhDNxP1NSttmscVbTT3DCF8MiWJ+hNGMI8JOA89IYVv627iWr8zUVrK8x46?=
 =?us-ascii?Q?qO0gvf7i9RVkaVhdcIzDvAy/kRoEtnEOfr74Umji7Jfq+6k2yeXnj/rN9joO?=
 =?us-ascii?Q?mxr/EnMNtCyffw32ZHIVQhPRjJ2msMPFr+GH78QXdnFjASgrht8SgRs3qkhF?=
 =?us-ascii?Q?9O2YVKhDLnYYu9RhqazMgjAUHgusRH+D/W4shGfWXmSI9RG4nl4JY5pz8/ZT?=
 =?us-ascii?Q?xniW8swVj+rjyRLkqI/yHIiyb4oVZVnJzV5h3KRmOFLh80T9Lv2aUamA3rZP?=
 =?us-ascii?Q?UrMlyDl2GQoSbt1cQaV7FJoIvqmalQ0aQ+jjIGq7m+IMUPD8FdILxX0ylNst?=
 =?us-ascii?Q?6y7G5Z97OhHzWlN7UqAO97ZCTnrXMculqYtwAOiOORBTOenjegmtJLRBHZoa?=
 =?us-ascii?Q?fvAvWiCjYZze/Xzbmjdr7+uOTK8U82LTlv8xVHWd5BteafN1RXKeAYQ+Cju7?=
 =?us-ascii?Q?Qm5WIv8vH0fNuUAIjqhxdaX7z2Hyuqrtbr8CkNwRQEGpwezhNN9SwwirYtru?=
 =?us-ascii?Q?pFP9gmHxtpaJs/N3XWVaDEjRlMSQt/m0V0W+NhoCq7/esezTdnO1Jk2yOs+Z?=
 =?us-ascii?Q?21VE4vq61baB+I+K1kwIaTRnOXTCveI71l/CnG9+dP7hyYMp6O3gpoqupiIF?=
 =?us-ascii?Q?5uH+2VthLrhOFpP6TnmIobSFMQujandJ2d3FsMJwRhfswdEeCt+2Pl8S0K8A?=
 =?us-ascii?Q?Eov3+MsxPAuya48No4Rg/5un/iFUtyCUrrbPmAk0Edi88Qod19w2ABYbeodh?=
 =?us-ascii?Q?wq880VE34GzNJunnuJ3FnbB6gNGzvxkdshwUmBnprhTziJTDbzTg9Q1omeVi?=
 =?us-ascii?Q?Z1oTxIN9WXOlmkyQnXlACkKChgjRFoExRJyBMKldhfbgU+3ZLOsSZ79ETNBL?=
 =?us-ascii?Q?E+M0LRn7LyP0UA8q659bE76glVbB9ORKgJn7q8lqxHR2uEScs5jggh0KTI/t?=
 =?us-ascii?Q?++Jv1fLDhPRZy03Sc/BTaCtb/PaQ/1V+UCa3iHY++ZIrZ0ORiwStfZJ9Ol05?=
 =?us-ascii?Q?+pCASshoIwZKyYIGdcnApBoNYYNwCmHty1Q+hFwdPJ5n+6JlHZ4hOjrNDc2A?=
 =?us-ascii?Q?g7CmKTnUm96HkGtTeqTdw+PXkMncGhqw5gtM2H9UFE7chbZuVfltla5spVcj?=
 =?us-ascii?Q?pLd6BgLnYv9NiTUEAqlw6HtOPftpicTpAXiSQvnIrm/D/2m3uIYwMClenWfn?=
 =?us-ascii?Q?xVjGYwukJnQiP3+pkth+vbgCeOkm25Oxz55k2TrY8m4uvGZEZ0Zj77HmD61n?=
 =?us-ascii?Q?CL1eX2lZdrZ2EfNL09QRaiKNy/nGGGigQgsn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mLsuEKcbMvI34n3QDpz9yU3Zdo6g1yYPrSbBQVgFn28R1dzkJ9DEKkqjGlBE?=
 =?us-ascii?Q?58HSHvWvF0S9z9KtPtvDmIpt9LHT6QaE96aJlKlpBgKU5P3zMznVBcfrM61O?=
 =?us-ascii?Q?q5HJgYbBtjEx0ynCMLcc/4hpgfrXx9tOuTsc1V5NarxgQLI+akoXWVaZpd74?=
 =?us-ascii?Q?La5WljChfhhja6IdjVhOrXecC75Pn7VgyB8tElC91VcxqlcXzzXQg1dS/ZCI?=
 =?us-ascii?Q?D39nJUVtxGfmuYQn0tW+cKWW00w1PHya3/ZHqOnu783pmId7mee0yug7tRGV?=
 =?us-ascii?Q?u1LGCPH6kXbi6XsExL13dkcJ9KDi0ikTHCzo15So4ZST6EsmP+66Fd9DAs3v?=
 =?us-ascii?Q?D2XxlFyl1ROpPx4ChIrBdmr+xarnWkU95y6VwClFXqi1vHi2SXtMvSRMesJo?=
 =?us-ascii?Q?wDxaN7VvuaNCdU8HNPuGl5tijSnnsJ43nKfRLwkIIcF5ts5MgX+Nj6WJBYPN?=
 =?us-ascii?Q?/wZHDQ6aYuly+nec2dMViTo8vKCrYhqdyFK0NOePCKjCAiXtE5nY86+JNR71?=
 =?us-ascii?Q?fYpIhVLAaTbZgZMHN1Uebi5ZeXgITl+kiE1LeS/HxK64mdvPJM8XWV3QYmCA?=
 =?us-ascii?Q?nSNs3irsFgVNPQZm6a9sUTZPi8rz790MNOmFeuSK+hNYjtoTFIkwURXQ7Ynj?=
 =?us-ascii?Q?yzc03w2H6GN1OUhVVqPTgladK1XobjFbAoMMfBcQWzxK/UGsANdT4+/35KE/?=
 =?us-ascii?Q?nE1FaRJMkkPIH2JhFDc1k30Iv2kqyR4sLZ8WAq7mnkZm+MwQSHB3V3bC+NFW?=
 =?us-ascii?Q?ezpF3BubwG9MHav0EQVJRZOS6/6Rb9PIKkTw6uTO9I+LXTme8pbM4fyLKfM7?=
 =?us-ascii?Q?aUaGAGXc2IC4Ob6LbZ7kf3/JEaPLpqE7ymIZo4sZz8fql+its47NB0lSkj4s?=
 =?us-ascii?Q?Ezkser3z2qZRPWsQ4KbcySsKPo3zFZC4ABRJ3c3itREtbdLKM/P+nrQ6eQ79?=
 =?us-ascii?Q?N7Zau/uS3AD55D5RTXR/CEnuuL0AencKgAawHeZ++7QSfdqLcfsR7k4L9zIt?=
 =?us-ascii?Q?oZ9inq4zzkzRKu8kEdyIUWq9pz2gULG/unmXhP6i8qP55Q6klz95l4aRiAQU?=
 =?us-ascii?Q?XdPXOMWJ4sTNYvqfYragQsctXRBDwnTwNY1A3JUgtz9hfLISsf0mHWm5c1nI?=
 =?us-ascii?Q?IRi7IpVjCOHp5XNNMODiZGJnrpD8wOFi8VlrAZhzF5Z2IqFQ7qcLpHhn4xBa?=
 =?us-ascii?Q?dmA8PeUENqraou9kXYqnEpzXeaWnExKgyHwV/RFSDAmzDElNwBVqdZVlf/CF?=
 =?us-ascii?Q?IkGSxDE/3SSAiWmsOoFD082PolJOgQTwyk4WwBg5kudRzE+kqV7pCvETPXw6?=
 =?us-ascii?Q?MQDbO+rADpzWYqR4rrajQZ2L4CM7tFf9FD145LHAeJb90cWf3lhxqFIAWa0D?=
 =?us-ascii?Q?VnXEp9I3ti8zeni2LOeH+844FI0bZDY7Wh8xi5qYGOcbQG/qzCWO172o65KQ?=
 =?us-ascii?Q?kCAgjFZ8OJyx1CtzlbQSCnAKMRNtrKLx0X7Oe2KvrBrRJuOZMvuqKMiTL/eM?=
 =?us-ascii?Q?cBFb5H3Dd6cfIf/EGGRX6LLP0VsXOyQkrCJxqhXWC/xA3ZTJZDCuo3vqophU?=
 =?us-ascii?Q?ziYdcw9QlNMCq7Jc6KmO66+485znsUj+zwqc2g12?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502fba7c-d05d-4f45-06fc-08de1c27a41f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 04:56:11.8281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4q4KcNo0J0a4w7XhETNH7A0oLCsKcAMzDYt+y+i9l/G6e9zkjr7l0thyiIuvRo0np+T9TztnJ0C4kk0/ZnzAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12053

NETC IP has only one external master MDIO interface (eMDIO) for managing
the external PHYs. ENETC can use the interfaces provided by the EMDIO
function or its port MDIO to access and manage its external PHY. Both
the EMDIO function and the port MDIO are all virtual ports of the eMDIO.

The difference is that the EMDIO function is a 'global port', it can
access all the PHYs on the eMDIO, but port MDIO can only access its own
PHY. To ensure that ENETC can only access its own PHY through port MDIO,
LaBCR[MDIO_PHYAD_PRTAD] needs to be set, which represents the address of
the external PHY connected to ENETC. If the accessed PHY address is not
consistent with LaBCR[MDIO_PHYAD_PRTAD], then the MDIO access initiated
by port MDIO will be invalid.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 74 ++++++++++++++++---
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 1d499276465f..4617cbc70f5a 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -325,13 +325,29 @@ static int netc_unlock_ierb_with_warm_reset(struct netc_blk_ctrl *priv)
 				 1000, 100000, true, priv->prb, PRB_NETCRR);
 }
 
+static int netc_get_phy_addr(struct device_node *np)
+{
+	struct device_node *phy_node;
+	u32 addr;
+	int err;
+
+	phy_node = of_parse_phandle(np, "phy-handle", 0);
+	if (!phy_node)
+		return 0;
+
+	err = of_property_read_u32(phy_node, "reg", &addr);
+	of_node_put(phy_node);
+	if (err)
+		return err;
+
+	return addr;
+}
+
 static int imx95_enetc_mdio_phyaddr_config(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *phy_node;
-	int bus_devfn, err;
-	u32 addr;
+	int bus_devfn, addr;
 
 	/* Update the port EMDIO PHY address through parsing phy properties.
 	 * This is needed when using the port EMDIO but it's harmless when
@@ -346,14 +362,15 @@ static int imx95_enetc_mdio_phyaddr_config(struct platform_device *pdev)
 			if (bus_devfn < 0)
 				return bus_devfn;
 
-			phy_node = of_parse_phandle(gchild, "phy-handle", 0);
-			if (!phy_node)
-				continue;
+			addr = netc_get_phy_addr(gchild);
+			if (addr < 0)
+				return addr;
 
-			err = of_property_read_u32(phy_node, "reg", &addr);
-			of_node_put(phy_node);
-			if (err)
-				return err;
+			/* The default value of LaBCR[MDIO_PHYAD_PRTAD ] is
+			 * 0, so no need to set the register.
+			 */
+			if (!addr)
+				continue;
 
 			switch (bus_devfn) {
 			case IMX95_ENETC0_BUS_DEVFN:
@@ -479,6 +496,39 @@ static int imx94_enetc_update_tid(struct netc_blk_ctrl *priv,
 	return 0;
 }
 
+static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
+					   struct device_node *np)
+{
+	int bus_devfn, addr;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0)
+		return bus_devfn;
+
+	addr = netc_get_phy_addr(np);
+	if (addr <= 0)
+		return addr;
+
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		netc_reg_write(priv->ierb, IERB_LBCR(IMX94_ENETC0_LINK),
+			       LBCR_MDIO_PHYAD_PRTAD(addr));
+		break;
+	case IMX94_ENETC1_BUS_DEVFN:
+		netc_reg_write(priv->ierb, IERB_LBCR(IMX94_ENETC1_LINK),
+			       LBCR_MDIO_PHYAD_PRTAD(addr));
+		break;
+	case IMX94_ENETC2_BUS_DEVFN:
+		netc_reg_write(priv->ierb, IERB_LBCR(IMX94_ENETC2_LINK),
+			       LBCR_MDIO_PHYAD_PRTAD(addr));
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int imx94_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -493,6 +543,10 @@ static int imx94_ierb_init(struct platform_device *pdev)
 			err = imx94_enetc_update_tid(priv, gchild);
 			if (err)
 				return err;
+
+			err = imx94_enetc_mdio_phyaddr_config(priv, gchild);
+			if (err)
+				return err;
 		}
 	}
 
-- 
2.34.1


