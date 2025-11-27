Return-Path: <netdev+bounces-242260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AE5C8E31A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 760A54E4931
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991C332E736;
	Thu, 27 Nov 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kbiIJ6++"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3EE32E6AA
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245378; cv=fail; b=LgADoLCBlfb7SBuw6EZfIqp1pk4PAG7fcssGTh/aQ/fEARGQIVTfVrrb2I8BL4oKgXpYm4e5oOnkkHV6azasuVQI8bPYsOrm3aAp55d7bxVwh7A8wp4xHKbDKMJvDlKB1U+O0oPp1jbhwMyA84qGpg1ZN4W+T3NVpqVw2XyrP2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245378; c=relaxed/simple;
	bh=ZUSZnjt+HjlcC+5131r5ICmbWmLKBSx5AEKqHNngOo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mYBr7a80f0jpYg/bbgscvvAe3UpCYCr8ad3xh0KPqvWypD6qCIDJOyfR9zS4m0x13g/VXswZH+SSgQT5fEFYdmu3J8bwc+cMXJswBFSdpgc/rNzyG/WfS6lwrC0P4FBeGoeepXDbX8pcfHwIkj3ODW0TX9jmjqR4piug4+dxCFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kbiIJ6++; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6blF7TiEQt7hDjSdp1Dt+Oog67tv03r7V6h3d8s7doEC5931CAQxN9Zb8MjbOjMUaDi+lc0X5XtSpi0HgLwKiHMSXc5n24LpDM035Tlx/WbjMYtAMr4GpEDOuCQqstltiDKInJGqjuxQeszP3Uag8dVD44dsr8GVtjq5HpXqjYFfS6uAkaf5Gcc4EayytFWTM8L0dog2uCmDDYHJ5Pv6CSIgbU3skJCbhdDp87kWCiO2gko728puRn0/zZmkvRuhB1rTrr90/tag9aeeJnvx9VonR/4T/YczG/oZXHUcIEN5361J1YxEiFufnBdb04q3axXoG424397y8asTgQ8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmRmOpOBw6vZ8IpeEV4ZeQP+erD56sHUYpc4i7sfFSA=;
 b=Hs2knTohbF800LJf4cy4Cgc8MxjUBApkvDjY4fpK6DXoc1++Cy28tUyMgnrV8USdwFCYEcA48jw4U3/Y96CnnQLM1++TG90hcb6RUpU5rvgKhytMgm0ytZ8QjMwp1uUm7OHhxpIa89p84VP1MzSv6kNClC+0lYh435WMPwdttq1EPZWuuR6h5fZFckiVw6nfrAq30Plh3jLV34Czt/q1H4jollIgI4sLdZey5UeMmeoZlnvT2Cci6lFgeeiJ+UiYJu7tMffriPm4VQA8dRDx3F4uEajLjl1mAIb8L2ohWnk9R4x3eTzvXtmenG5yF6ayrh3psWUwZ4qbqFO4wV1ugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmRmOpOBw6vZ8IpeEV4ZeQP+erD56sHUYpc4i7sfFSA=;
 b=kbiIJ6++YttdGqqDgJMgF77CliltQfcfTaPaupuiPJB8rMKn8pGWWaUke/uhGmuLc2kNTq5B9o9/Gwt+4qK3g+9f70MdWn92MupD3wOPnDnNAfpFfqwvZph4VkzZOoos91ic6nxiXP1hJtA5zSlLJJ1oUT9Dzx/15T67tbYNOMhBw8bXHhzmAhPDuwGLKJychPyGOX9ws8HQ/g9Cm0agO67RmTX+gA4NgWPsJ2MOCHouTOjcmg5Sb6gicKeUjt4HYIrDmGZvBch9p3NF7WudYewdnlJI2Px1TLg7xJhjrgJIyOwSrHxNrzkB5UzThfKzKcbHxF9UDfprszmHHUwhwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB11844.eurprd04.prod.outlook.com (2603:10a6:800:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 12:09:27 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:09:27 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH net-next 03/15] net: dsa: tag_gswip: use the dsa_xmit_port_mask() helper
Date: Thu, 27 Nov 2025 14:08:50 +0200
Message-ID: <20251127120902.292555-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127120902.292555-1-vladimir.oltean@nxp.com>
References: <20251127120902.292555-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB11844:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b44347e-3c56-4d8d-b8be-08de2dadcd74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|10070799003|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pX2oXq5VGD/aL9bZ/ss0EiOivq9rwxcBtJClaZSdLZ7+gzdKVf1uDdJ+WHYi?=
 =?us-ascii?Q?MB6pvbJv7gearHzzvnZTCoKG+1xUn8s7qCyJctRBJgGplnJNRwPY3ashAq1F?=
 =?us-ascii?Q?+1zThuIAfR+xm4Hpri5cj1NyB0W6rvi2HqqOtthdk8wmsfOcqpIMiVFkWaB9?=
 =?us-ascii?Q?Ua+oyNikYc33qFG8JR19xuFPBP3zzrfc+O0CDTTPpyonWe0CkFEOITYx0MQS?=
 =?us-ascii?Q?H3cbeHkEgk9OW9xwaxeftGqNqHiAgXHyw0guh50vA2rPonIDBOXDr0oKwy+V?=
 =?us-ascii?Q?GJNNJw/rOnomkoOsd7OI7Sd+aceleFoAyubW+eAt+RbC18xE3zHjis5kD3Qp?=
 =?us-ascii?Q?75eeSOecf5sH5ysllX3rRaaXgyw1FQV/HPLpEkTKww7BwJVSepppRZkWozzX?=
 =?us-ascii?Q?M1FfRVgCJSJJCa0gjD18HuSHA7WCmqh7P4HwAE7fRoJVTZjEPF//BPjI0cWJ?=
 =?us-ascii?Q?6nCcmPQyKYsQ8Y2XmIRdTMSQcrfw4RHSqbB83Xf5WQyqDTsIw6Zh3maemXAu?=
 =?us-ascii?Q?EiwD5kbw1EvBs0AoxN81ExEKXI3vH5GL9oAZFEIxSAd1tGQjxJ64TYIuzSNo?=
 =?us-ascii?Q?jjCs4S4KDxIYQ6S/wxRZxXrz6RWlPvqVQ14UgOSi6Vc6teGFUm7Ht9B8h4DN?=
 =?us-ascii?Q?b1VXY6qWkU7OedZCc4+7EPQ9l6qZq7bQXrdnhqKkksrnW47l+0LbBSOH8RtH?=
 =?us-ascii?Q?X9Di9Z8G0y0lbwrWsOzJaFF03YTjg42GADRZ7HmRN+GhQ/2iGGKO4r2HBxl+?=
 =?us-ascii?Q?abW4wzarfIq2PERrityPcq4N/VOCeIFfY6nHN+4665u7qyr+8eZLdrHs1VgC?=
 =?us-ascii?Q?ltBqxnx5GGlIh35xUvT2p5QA3KjkembNbME1hjacT2l+WQLGcZD+N1rlQH2B?=
 =?us-ascii?Q?npuG0VTvLMM7D8jZW70Cs8N/Nx2t65Ae4OaErlRnpgN7jDTBheBkVivfElDw?=
 =?us-ascii?Q?fjoAbKY2x1VqyaWTToDE4iHOjZ0S128s+HCvFGelHJL+/Xolsim59C3VqB3a?=
 =?us-ascii?Q?l/2jXX/hgXxSZC5zI3+XY6jp3CwOijDtV2X83fLrKAMMxyk2Ywo38J75ihx8?=
 =?us-ascii?Q?xve/X6i0pUblKOtHrMvE+z1V4GRhFLNJ9nKr7lkPVU6np7Tjp/P3LDUyr5JT?=
 =?us-ascii?Q?MOxdXdv6LGaVl56RbBQfyTTO8z+9dJYQrGFIA/an8ki257/OjgdBx1BGr3NZ?=
 =?us-ascii?Q?+LMIBJEiepICUI9bHfJYZ/11SZqKq+VwKn7ZWEcO1T5drF25GZdZ585vkwQd?=
 =?us-ascii?Q?emwp/LnAohIT9JXJBWb4Ecy5gimSBmR/6LG8WXYepDygNKbSJ3N3XGAzGGD2?=
 =?us-ascii?Q?k/hFu/8gY5IVBFPIvy4sY2O98/UGBb80oJHl/kltRn169x/Q7qLDU/1Ng3SD?=
 =?us-ascii?Q?yFlmuG/xuZ5EGY69vFJCa5qG7ib2ul6X3D80C72xEBNhi6v7kS/QElh6owBy?=
 =?us-ascii?Q?gyiWnoO9jf5mpJ/8daVmNs+LNqMSyOuQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(10070799003)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SzvY5OXV7JA4dgn3k1C4ibcWEmKrEWP79TCd01ZItEQy3xI3lkP8JdzirgJn?=
 =?us-ascii?Q?7mV5lrIc/qeS11ydBSpb0IZH19KharC0d9jlk6o7EP+e583BcY/gbc+gLDf+?=
 =?us-ascii?Q?U36+e6lneLyPG3eFt5DSz5+8ysbkDlR9qCF+y8hJNa4agtgaucfKW2CdOLmY?=
 =?us-ascii?Q?YXxmle2h9v7H464gO5rzuduOE7bsyTC25jblRCWMmTE4e+NM0w+N1aFGxUvR?=
 =?us-ascii?Q?okUgn4avknyxw2mFTv1qFhSC7QrGkRvFLsl5G6/w7xc6brDa17StzVK8+bIZ?=
 =?us-ascii?Q?4pb/fjdGreaJ1NAuaQeTW1WFHuHWcU5yPBFuUuCbGHZJGTJf+vy3q7lf+sXy?=
 =?us-ascii?Q?oNAig9n1+kfpoktiKoCtyG4iMkzte8/ATMkTpOF1J77GNtnVXtfJKdb03uXN?=
 =?us-ascii?Q?/5CATgkXa5QWzOazgZPwnFZRJmnwZpApvIYhjPfiYQP67SgSTluD4iFx0MQH?=
 =?us-ascii?Q?oHyrk1WfPaD29+Sy2kYIRGtE+INuMrygdZ5LA3kkqg2OdofQKEG52r5HyM/r?=
 =?us-ascii?Q?RA/DBeoXfs1KydgwbGxfZG0w2Y6ZsDEQ0d2bTeJdmY7q66tUHsXlywHdgLTE?=
 =?us-ascii?Q?Qv2G4ZRtAbW65xK6D474RQm1lfgBwCKObST1Vv1dB+dONuop/ZkoOeo5/bd7?=
 =?us-ascii?Q?u8pzhLlvUHCRWAzyh+GbHa+21FWlrEu6YQzcgOH+pz3BNSLm97/raEQHjSXY?=
 =?us-ascii?Q?E3GtyWealWof8juH5pK5igD128mZ495D4tPlkOSbb2QKIEYz5iRN16VjWy1B?=
 =?us-ascii?Q?1HrbeXZYevmzWN2/uvzgoDrGImzNsmgbr5oratEKUuln8hDdHHBW6h9Rc9eT?=
 =?us-ascii?Q?eiF5WNriTW1xHcasmGiiOTcKMHRSHTD4eT+W7ljlZ1Ag7C+W27vecGxf0h2r?=
 =?us-ascii?Q?ap0GYu2kcI6b/+Ldjb/3vtPlN7QSZjfvLxBNut8fHHVyeoB+xP/K17BPFuCJ?=
 =?us-ascii?Q?SOX8dALiaK4RfymMHkGwXNZE/nAw5mFYzh6jKg+f0v7MlRlZdDz2SgScP9I4?=
 =?us-ascii?Q?gB5iZWfoj98jYAqhUD7978kw8edrMWvSI2GmcvRdxGOQDxE55gvsS1jaKgMt?=
 =?us-ascii?Q?tegjvuIP3wVuGX734tK8MW7D3l5KH5xsCvKYRNd/o+HUHtKHc6qmw9C5RHJn?=
 =?us-ascii?Q?Iv6ewspr8bG/IQcffFyepmFzkgzMxDRN4XJWk/eFSFnEnbxS+QA0PzJgPVcz?=
 =?us-ascii?Q?UP2CMH+GezxpLTF8/ifHjh61KfdVwKZwdcfrvs39vAHIfjkaA2HLTkuuoqWS?=
 =?us-ascii?Q?c79ALJVEE79R/xPccWX1JRUoR62leuU4/HPIc4WqXH5hYT8a8+tDBjqjhAcb?=
 =?us-ascii?Q?zcw5pLuEa6KRr/kPLS9CmkhY2f/ZD16nEB9RS6303cO6x4avgCKtAeJlH9yM?=
 =?us-ascii?Q?33nbXGD+ItPS1FOWzZZx8hteu+Sx4ECsNDHvllrAd/IDAkUcxUwxKasEy4Og?=
 =?us-ascii?Q?FrZZHmlhl7dEKdzSp8FoD1Fcg2kA84dXSIQuHYQZJV9WH9fCgIKS/RBWxsxb?=
 =?us-ascii?Q?fXKdE+2jtKyimi7mmNgspZT9MaXJ9LyvFb61PkKd7Q0ry+3cdCSrWpc0X0i7?=
 =?us-ascii?Q?UI4R6O1g7ylh5zX6K177bR52h0xoy3r/cFGDlqk5fI3ySumdm3B5DRh4uiGF?=
 =?us-ascii?Q?RGFS3nJqxe+65apDZsEuSPlrN8rbkE9xSnbzdheaSnFcdHUP6sHMSl6dMuhn?=
 =?us-ascii?Q?aQlv3g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b44347e-3c56-4d8d-b8be-08de2dadcd74
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:09:23.3856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XaC25E+1hB1o3sMpik7h+GxlNa7Vgb4erkQ1KMUg/mxAaMBHA4jWwLOKDjqibvJv6TrkSseqeFMp1imGC89dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11844

The "gswip" tagging protocol populates a bit mask for the TX ports, so
we can use dsa_xmit_port_mask() to centralize the decision of how to set
that field.

Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_gswip.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/dsa/tag_gswip.c b/net/dsa/tag_gswip.c
index 51a1f46a567f..5fa436121087 100644
--- a/net/dsa/tag_gswip.c
+++ b/net/dsa/tag_gswip.c
@@ -48,8 +48,7 @@
 
 /* Byte 3 */
 #define GSWIP_TX_DPID_EN		BIT(0)
-#define GSWIP_TX_PORT_MAP_SHIFT		1
-#define GSWIP_TX_PORT_MAP_MASK		GENMASK(6, 1)
+#define GSWIP_TX_PORT_MAP		GENMASK(6, 1)
 
 #define GSWIP_RX_HEADER_LEN	8
 
@@ -61,7 +60,6 @@
 static struct sk_buff *gswip_tag_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_user_to_port(dev);
 	u8 *gswip_tag;
 
 	skb_push(skb, GSWIP_TX_HEADER_LEN);
@@ -70,7 +68,7 @@ static struct sk_buff *gswip_tag_xmit(struct sk_buff *skb,
 	gswip_tag[0] = GSWIP_TX_SLPID_CPU;
 	gswip_tag[1] = GSWIP_TX_DPID_ELAN;
 	gswip_tag[2] = GSWIP_TX_PORT_MAP_EN | GSWIP_TX_PORT_MAP_SEL;
-	gswip_tag[3] = BIT(dp->index + GSWIP_TX_PORT_MAP_SHIFT) & GSWIP_TX_PORT_MAP_MASK;
+	gswip_tag[3] = FIELD_PREP(GSWIP_TX_PORT_MAP, dsa_xmit_port_mask(skb, dev));
 	gswip_tag[3] |= GSWIP_TX_DPID_EN;
 
 	return skb;
-- 
2.43.0


