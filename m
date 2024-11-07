Return-Path: <netdev+bounces-142646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE09BFD1F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 04:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48790B2220C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5CD190049;
	Thu,  7 Nov 2024 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OvweDaDV"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B90194089;
	Thu,  7 Nov 2024 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730951658; cv=fail; b=qLxcASKNxUDz22yFejuJJudHQ2sIqKII3XxCkytxu8ERaE6tkRPdNj1Jdz5TLfDKdMme6AgpnpSO8QJugwk366paYqTVp02QKh6EEjeBu0MKloK+BKJHTrmoR/M3OC2BRcnEsp8F5e11w/VVmpfJ5gi4st+9ZoolZ7OhXaPK7YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730951658; c=relaxed/simple;
	bh=bVNl9Tu8GcV5eA+hKTHko9gF8fXk8PAfj64OyT3Z6Is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZ5LUC/y9wAFfTii75MRYtx4xCAvL35NQmtSAyyB4kwx5QtxQWN5l0yhsZIPTU8HNvaP4HZl49vjva0BIFj5DKe6e/8zsc61U7eqgmSXiRcnwxtSvBGkPQfVmiHy4HslFrYZWowPPLyXAz4jWn5WKfeEKf7rLCh1GWWEeygzm8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OvweDaDV; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1+BQJRveaFHIzTq1c6ZxM6xOCHpgBssI91TqF0MiHqTXSVT2OSOyN7R8uopuduoy4cQrT/H/usEUCTYG6nfiC0ZlogKcAKnBoF6iTHMdiy6SYGM74o8mUtA5FILErs+28UJcTiRUvpZnZlfNnW6NzZc4KuocyRc1gfDX4f9p8AZRSH0gfsysEeRS5NUYwUCIp5aojYU9zOR+p4IW+d4K7mG4HpmgkDVmilLhzpT47IqXykB/zVVdV6RjoCmSuW5IcZulFhG0ecBa6yKeL1WBZT5F1H+RififgVrqs6rJy55vRP5lNCzNIichAtX2pEXl+vQ9vpoIBjTh4uEpa/O8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibq35Pj/Qc1wDe8VyilUjUiIgk+sfg/vLq0rYyrpySw=;
 b=O3MBiOtUOUfpFRjeXgdQm+U2F7NQZcnDqkSSFfC3sAcVhuwX4vmFzhvsQEI4R40I44/GPXuoQzrqVbb9eCYng4ue7Ev2UiVExSTOkepFXCWNY4if8kg0o8FKDMR5dXGXg5PDI6DlTQGj0aj6r4zygy9JjV5dx6o0oZq4W38OWalmgFDAT+TohmqegHk6f/zuehUqrXpcqaHEQTqxG5T4gCe73s2jT5xUYLme/AWNvoBfBharULzRAvUWfQ7Vs/kCpAltu3pJKEox2SmTJRO6Y68NYS0QhnZXltGlhZRVmERGtqoqxWia5O0SLWh8AHU9rqrrRFc6YJoX5HHgTlKrZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibq35Pj/Qc1wDe8VyilUjUiIgk+sfg/vLq0rYyrpySw=;
 b=OvweDaDVc5a1tQMggUwQ4spH7exfxZE2sXfAmaU5Ag48o8N7EJpydw5XpsLHJw+MDxfH+plEI3VB4jSfjaogorOPbvwP7gotzI85GRI5yjx1zo5Gy7AhAko5bfAziwI4p4VZ9TCahggWzV07VmE7zGUsZo6Vurs3IhatE1r9ZQxcUsQRWjewtQDXBHpfJQR+citKd1vFuZuzlxAk9/cL+uni2REV/LMGGsxG1Z26aKk2SWax+uPYhaZLa6k9yV9ICb800mAHvef82PuC3H+yAgmHs7VjOSgF4n8PzkuUGVKjCnyhulSrRwwcrABidxmh8uSHAsu/bJH7Ah/rwst2Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 03:54:13 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 03:54:13 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 5/5] net: enetc: add UDP segmentation offload support
Date: Thu,  7 Nov 2024 11:38:17 +0800
Message-Id: <20241107033817.1654163-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107033817.1654163-1-wei.fang@nxp.com>
References: <20241107033817.1654163-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::34) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 54940245-4629-4052-8878-08dcfedfd7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MvQsVzcU6mOcXhe1iLVyEtn4eAUo0GV2AOhaeFDpuiM2wDYtq1ZAxPZ3tFFD?=
 =?us-ascii?Q?MThf5yV27vJ7pPxnNsn2IXYL/gqAfFQsCRTN9eHiRlbgDyzbEtX7MOpKW06H?=
 =?us-ascii?Q?Y2ZF1RDoWEv7BIihqyMDTMttcU9CvS+Th4Zd3DYvPrtNxtdy2OWZjboVC0bJ?=
 =?us-ascii?Q?PnVgdFXqgqWC/QwseZe2jNVu+9ifrAGLPOXyxEh9ZL6/O7zHQR9ch3fbYEx5?=
 =?us-ascii?Q?GFmBFPw1sI/5sytRBdTO3BOR8ZlQG+G9EG38oWILIvGaGhrzWMqQ/r9/jexl?=
 =?us-ascii?Q?uwH/S57FV2LDQa8fMmPIhY3U+/1BcHpL5Uy3tOr30ovhX0gqy4Oj8uTMb2cR?=
 =?us-ascii?Q?vNB/tH4Ss3G5BPaYW4y1+ttbnCkkkafJUtTii8e6fqj73/kIgJudUD3M+ghY?=
 =?us-ascii?Q?PrAmD33XrrJPZORQTXNiHW33SCNfWLQMx1Nk2HvYN4KvSqq3mEbofmuPfo2L?=
 =?us-ascii?Q?w+hRQAr2ZxCawWfDprrWwLVV+J4l2PjgCTrcRtEspBqTDJx+PT7VaKhHDGwS?=
 =?us-ascii?Q?MvnnGPpKbyysFc5h7m4sLVFNzEaLgQDyap9cBtBH8zl9sqGvXvxsOqCmb/qW?=
 =?us-ascii?Q?u15eHhoJXFbg5T5oOogywL/lwlSJ+5JWUMXAZ8qpQJ1pf/GfFUk57AeFY90c?=
 =?us-ascii?Q?YTbwzLFhh3Ndw1y8bUirq5nh21DxhoEYgetLVng+RjfTQ0ooTie0kJzFw6At?=
 =?us-ascii?Q?EbtReZGgZoxQAQlptQq6r9s5ja3xqbJlU/ZP1zbMTag+DxEMCTsWHYeb4XBC?=
 =?us-ascii?Q?ggyUOryshifEVHwRTsfxg4VAnW+XTHXfVlssrbJ290dkvqUPHK7wpPFLvYE1?=
 =?us-ascii?Q?0VP2HsVtpZ+Z13oZR/AyA/6+pBCiFWXpS7Y5JNjl1ytXoec+p3uqF4NCSCaM?=
 =?us-ascii?Q?oAWCH1TPgQE64/Oe92Cwr0vR5NuLP6BiaVNfG1X1hi3fwULIL4nMSDu3nBSP?=
 =?us-ascii?Q?ckd3ztSfyfWpEtZXFyxJZVUbRB9SC2FHDEe19sj3+eE22UzuG6YW1dGAuYXp?=
 =?us-ascii?Q?Z67Wk7C9sVW3Av3baLgEsTviilxwbS+LLIS2DbffLBkzdlQXWW2bCKW1IqIO?=
 =?us-ascii?Q?DkqlrtQmV3n55ttwVXyAhXqK6h9ITj15QzGvuZtml5vz1Uudt4mKG5dkRc11?=
 =?us-ascii?Q?J2XTZHvG47WCE8I4/iuXAqi7BIgGtStLqTY1ImVrBEE3bzVbh2fz3Pk9leaa?=
 =?us-ascii?Q?LUnvMfSi+jClI4J1MRLIfivQO0qFTc6dv3E2bIbWU1uJO3/e9xf9H5V/AHx+?=
 =?us-ascii?Q?cQjV9NAyui2mpcVNFbDwych8iSfDOjyVA3hMfhbf9Mllo41at+GdGr3cWSto?=
 =?us-ascii?Q?COs7O9GzihWGAUPuQt6+giqhS6S/YZWc6KzUCXb0D/z7HhbkCBh8S1LY0Z+Z?=
 =?us-ascii?Q?yvnhGQo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IafvZyElUl6+RYNkSyQtwsiQNeMK27L3cMsM6c1hJM/1/XSEHNA0D3FoADjD?=
 =?us-ascii?Q?1NgaVsroQ+ydjHNYkDuNGBF5E1mLCh21FJDR8syhvRg37bFT9DEVUkRow43P?=
 =?us-ascii?Q?qNaU6YpWdZSQcyE1/QHhjQe+Z9NhtfRzjX6MfweHrw8LHdecmCeOxvs2PYv/?=
 =?us-ascii?Q?/8NvFR98JolvufziwZt9pZmcHgie7gQ5Lwvkso9oCVsx/4OZOHt7/1beBrxj?=
 =?us-ascii?Q?uC6vT6mbqtE0w98k3ji6ShX74RKz9SFliPRG3OPJCdS9rNe4EiL5pqH10W0u?=
 =?us-ascii?Q?RK5bFg4lvC+rvc8H7MoXjhLF0t/DvQasgzlueah35+J6Cq7nMD6gucmK1jI6?=
 =?us-ascii?Q?JNd/qQGN2yM5RCTyrr3PN3jHIONi1lXTMMf80aCHRiBvf7LJAH0glJFN26N0?=
 =?us-ascii?Q?nAHsuTcyvtyNlBQB1wNKVH1iHJYGTty4vpQDtgTrlVQgV2p7CWm5/VhGRdPG?=
 =?us-ascii?Q?dIxtx95oCfPdDsZQbcAkJjbxJyK5byyH5LDsMxDRvGcZTNJ2FJzzpCK+ESMw?=
 =?us-ascii?Q?5Pe6b38Xp8BZZaF02TDWdAariyY3XsKEvi1U1WmQldW3nfwlsVBHQ1ujHHLc?=
 =?us-ascii?Q?/yesV1KZBSaxpGtRTdPwCfaLGuMTIp7sVOIwSvD1xcysMVTMR7C3B1nc953N?=
 =?us-ascii?Q?h/ZgguDHy3Bz9w1vTui0jMzOnRxhQgPBIiHU/rv4xILffjizznjptM3aXLE8?=
 =?us-ascii?Q?L2V3QVoavtkw08yv1yGutLEApncxzPlZECRsz+/1j3Hn+dpOZT3k6TyV3J/T?=
 =?us-ascii?Q?knuLVE6dopjboPCLddglVEIeT2Bpa8VA8BsT9F/eTG1JSs3lP1SfFtzuHFH3?=
 =?us-ascii?Q?ckKwcHhzqIxLrAJMW4NEy3lqFYzb/95SJB5vDMZq9XFYYe4Vd7FDaRBCPSzu?=
 =?us-ascii?Q?xuEmypKslRcbKX60nubxksX9z0qasPCrQejt/PUwzMl1tqgusUt+Ou2oN7Og?=
 =?us-ascii?Q?vMOIzlEpBP9BhIL6avdoESpdDH2nDywiR7QyPWvRD0KaHbaV1wJzrYukqSwF?=
 =?us-ascii?Q?UL5OXwXMoTxSEQkUnHeLICL5lKAlxbeQBq6rQYmgdY3tWC4royP5KWZbotof?=
 =?us-ascii?Q?2ttUE8Db4DsAh6Lym+AdEgHGU7pb08/H+S8g/ivzryG3wIro+jy9ELVTK3O0?=
 =?us-ascii?Q?56EDKcjpOzqu/gmUOSNajquTEgreuk9hJWZ2v26HotnfVUql3fQH0rv+B3NS?=
 =?us-ascii?Q?vQlKhXHlCCIJZPcnNwufwfAMGy2NJWOT3Y/J9TpVC6nzdNWlidyDkmCVsW6o?=
 =?us-ascii?Q?qjPgkCyMTeko+F5aXOdUrXfg1hYsbL4VZTaM3r1j3tOM1N53qNeEJx3ez1oW?=
 =?us-ascii?Q?zkfg5eArmbBryu1unaRFiuBqQNfgwqy1zmn/zO2YcwSvzgWOHe04SPlU6r3p?=
 =?us-ascii?Q?GfuPLW/6SyPor6z4/Z419RAr298xsPcLo3pZVpn3SQldxdD6oxPcw8a/yFTN?=
 =?us-ascii?Q?n2auSXjuVgCRulClX7KqTFaIxHxW9w+4emtfDlY5jOyRKa79ktbzCfdtQ20/?=
 =?us-ascii?Q?3vgeQKJ405oh8rL1jSqif8VjTXA/Arak4I5m/jP6ODDhb6b9kcGBLmV69we3?=
 =?us-ascii?Q?RLx435596CyTlAFU6Jb67x/PF6fvvZex2QR6cGtE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54940245-4629-4052-8878-08dcfedfd7c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 03:54:13.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j24cdYvInef9WPs0jpJ8BLEIRSVnMQdvSyPvyf+PARrO9mUhMZzbQ3AecGHrVZlUfHAGbZVCxXRBGJfWkonv8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898

For LS1028A, the enetc driver implements TCP segmentation via the tso
interfaces provided by the kernel, but since the commit 3d5b459ba0e3
("net: tso: add UDP segmentation support"), the LS1028A enetc driver
also supports UDP segmentation.
For i.MX95, the enetc driver implements TCP segmentation via the LSO
feature, and LSO also supports UDP segmentation.
Therefore, setting the NETIF_F_GSO_UDP_L4 bit in the enetc net_device
indicates that enetc supports UDP segmentation offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++--
 drivers/net/ethernet/freescale/enetc/enetc_vf.c        | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 82a67356abe4..76fc3c6fdec1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -110,11 +110,13 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 052833acd220..ba71c04994c4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -138,11 +138,13 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX |
 			    NETIF_F_HW_VLAN_CTAG_RX |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
-- 
2.34.1


