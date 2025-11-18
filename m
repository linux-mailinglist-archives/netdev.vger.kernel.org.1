Return-Path: <netdev+bounces-239695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAADC6B5FE
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90DF03676FA
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990B53A1CE4;
	Tue, 18 Nov 2025 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ei5EQSA8"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA2036CDF5;
	Tue, 18 Nov 2025 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492777; cv=fail; b=cIjK1fRlMAu+A80TOe+60ISN4a7kDEIutU8/Zj3h+Yu562zJ4qZznCXBHcuinPC4Z5NHzg+tnYpIiQtz4f8O2rmahm1AONP8OJ13vXodor1AecxCgyZ0B2oE1Upw51BsF4ePhNXsBGGFgmtQ/7iC4wP2XncYaJ0ieN+zpB+caJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492777; c=relaxed/simple;
	bh=vk1Ws0OUmtb1Q9eJT6SykYuD6to5A8VNppR2oJAlMAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NaxAY5AnwtIUmqgptZSgIXntuCq2v+Q38pmIqxmt2JFZmGHUUYv6912+zet5GqBKIutiX5uPNxzilb0koZsO4EW6JfIm2OKcfsbczkzaek8wG5BRvKo5gLyNkhmSw705W3iPvfSJas78oTR+0jtkuDtBAdwd+GEYY4lX3yj7mYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ei5EQSA8; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwGxSTurjRMJxGloEyN/EcGwhpcHDWwMoz0oS+xAwAmGwS+HYBIRo3L5G7yPv8biJCJ/+Xac5PzdPkH5TDP7CA3ZK2xOSwDJXU6a/oCOHzWsJmZ42W3BRr5nE70qwGSrq0Gc1EuR1SJl5fYxprazg66IwbXrooc8SEKfXXk3A1NYEGkGI1Tukc711pQ2XIKF1XimNx6qVl5Ls0mFnNUYc93tvnI6uWDKK7sYRalcPAGUpylbz75G80bViMsc4FUowGzRXvD0u1Bn4uD7hS5mfWhndOiLtxz6NvREe/DbCedFW5UcV5GfsYNhzs1n5Lr10JyrXUrofAIgNoN9foUItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxbPVgq9kEY6Gba2+9d3krkYFukEfZM5IPPZ8l7VOaw=;
 b=S0M0mG4X3l9uHqDr8xzPpZF4U2VgXui4uc3QS32RXQD6ILYq8yem6mhIktVQZ1EC5YdKX5rDSpA2IhzJ1W4briOif3XR98SSKAXk4m+LZn94ZVtx4e9G5ajz6LeQjt4pGEB82R+q0+G2bfmJ/NqTr8fzqAqt6AtnIDZAhJRMLF8/X8nEQqK3M7NNUu2jknIggJN5rm8YV3sjGBnR6yyLpHnW1E8qeFL550lxjPgiv/JJGvHgSUmVqsZ29TfD+XbJMIQuFWY+nNh2S9IHJtesvqW7Lzf8OOQBmxh+bhqWeNqIvxP0XUqllWtez2Q9+B78STx6V8ywbXGsQnhukNSLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxbPVgq9kEY6Gba2+9d3krkYFukEfZM5IPPZ8l7VOaw=;
 b=Ei5EQSA8Bt8hWX/PVILxYf7ayNJIluVThYRGrQ7ZlfW9q2zx/ejLbS5/oPN4779enXIRvA6TJhM3BXB6QIiu5n0n2kvejKlEM36yieRJsEIlNWTnT+niCUAuLPUxA2nDCwKt7CmpMgV6LgnAyUR+1c+cNjRO32FIi2PsiKctTc9S01P3kwRutMwK/XPtrVlBkBtqzEB9nUORTx8x5i2rEEx1XbRtyU0/NXu07BKwHxXUGqQZ2neazhEjJsN6kuldrB7SGkKpcQw3/RWu2JZA3ywhyd6kzaCg63UPP7iImGWimmWTwKOCVp7quZqK/v3j1e0lx04me0bxcu2hDny3cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:06:05 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:06:05 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 15/15] net: dsa: sja1105: permit finding the XPCS via pcs-handle
Date: Tue, 18 Nov 2025 21:05:30 +0200
Message-Id: <20251118190530.580267-16-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118190530.580267-1-vladimir.oltean@nxp.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e30d250-dff4-4026-bbeb-08de26d5865d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S1uOIi0F6U44ftlWOIS7A7sKX46ujJdfxCV5+XBN23IWm61c9u560MWpYNPf?=
 =?us-ascii?Q?dodlTkb73AfZIVuINnIi+zyZeqybz6prV2ThbwubCu/qvpb9FfSLaRmpkB9P?=
 =?us-ascii?Q?c0b8qC5pvmJQudRq7wgBW4/k82loz8BGB2M70S9goTw3yZFqMsgTySnXRpRo?=
 =?us-ascii?Q?Hiz2nml6K6ogoxJFGNy+MuGiSe29mXdwHkyG7ugK4RCUHzKj2nYcHNmxbzUu?=
 =?us-ascii?Q?xdC4LsyXkxtBL1SbtJwOm3IGBePyRvjSAnk2sviRFW98CPz8mFKA27YcZoZk?=
 =?us-ascii?Q?Cu6Z6x2Aty0UAYXjGepIkTCMr+/El40jubt0JKmksZgzGTwrCFFobcQcwQ8X?=
 =?us-ascii?Q?B8fz7zCzFjK9PpRm/pDbL2VPyu0zKcQAq7S7r9F3AHW/EKv+H6MJTW8jg0wO?=
 =?us-ascii?Q?fa/tg2hGtuSi9Ng+dNPRCOHpdBscG3ImniL/uGEbZm9zxHLSCUk0PlPKkeiC?=
 =?us-ascii?Q?y5+5+F9LY9+C/+t16072hL6Cdrin2Q3xdBE8PYXXYruAteP+DvW7RTPaBP+L?=
 =?us-ascii?Q?e16ktzsELn0VjjqdmteXtCtAuWkixgPcW8GqWaFNkzdRdfNCDE6gSeMOY92k?=
 =?us-ascii?Q?H4p6TR5OwRJdCNIN4Vlq5w2ZyJ+9sl2RxDXccr0aphQ6MU6Vb4WhixOvzddE?=
 =?us-ascii?Q?LzQmOuu7DLmNk/qeCptWGrzUzKpyC12Kdl0Gz9ciE45oTnLBmGnNij9MEOp6?=
 =?us-ascii?Q?K65WzwBhk/rQIDT9xvYy8digRMaXcwLEd2fy1iKLjLnvWr5wiyAETTxbIxWK?=
 =?us-ascii?Q?HbOf8nDKCkxBIdwe8+rjVKAUKGJ1h/t1F/zQ/yoVeFMTgCcZ/QXqN8WkaL9T?=
 =?us-ascii?Q?ncz1YQ9wk2PJOnBkCEmyRnHeIJlwelAnPDmsLcSumBl+pSIFyIUcM/SXa81N?=
 =?us-ascii?Q?Lic6O82959o0x9r2RpTgE06ytCN8r6ncRANZlbzyfihSTq+RddRKLWO8mmrt?=
 =?us-ascii?Q?bD/PVkfeU0iOGRHow5UXVZaiZVks7AwSnhpk8EOS08pXhcaDEH63Ev/2wVlt?=
 =?us-ascii?Q?QdIcyije2uUVKSPmVVMLaQCjn4XMEE7AE+vNkubW+HW5QnAkbR7q8iul0YSJ?=
 =?us-ascii?Q?/bLrKlAqpYmXzwORGYJ/VXFfLsVf8T72Ayx/8yzg4pfDLyFbmfcTW8UI/vDq?=
 =?us-ascii?Q?q/MeVQxw7kvvHBuEO/DjCAnffTS0DuQe5QFM8VDW872YFtbhP9D8xIdoha1e?=
 =?us-ascii?Q?9pJB9JOX7jeREbOIPZh/laFhat8OWplIVLtfulc1gWp4NaPl2Xjhyxhx1Q2J?=
 =?us-ascii?Q?goUBHmtgebowFtIyFIAK6oAqt7ULglm1qDBUTbiKRBImTXMo9qMTUQaLWZtx?=
 =?us-ascii?Q?b6Uu7S9Y36FYCLNgOTXAjKVd8RshRthwvMGE9/Gjrbouf+f0ySHeOTC9TAWY?=
 =?us-ascii?Q?vaD+IfCJYF6+K48fat4npfPHT7LCwj19FgJCy2t+LtL/+Ie2/FVIppgUC+HF?=
 =?us-ascii?Q?a4q2+IraRjZSC8Bxwlodp7dnPp8C819d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tTA0OxYCC1+bvQdAkAFPOvVFTspPqjSITb+JkIrdgzLMBSnPc9KxqOgs1ItJ?=
 =?us-ascii?Q?zotUPaaa8w0FoY5HcehyVr5iaU+a2y7k7Xz0GTqIM3Ea3Cuv1XB97xy9HzQ4?=
 =?us-ascii?Q?9ddX2ZbsV9VLjMN+FOz4mxzbqx0VDjeqvP4FOFEDDTvpqbjd5ClbPsjEqWHi?=
 =?us-ascii?Q?xn9XgQjCQOTae6QxpPUKiDoK2jfIeMawJ6NCf/eW5GNy3WsDUMVslnn+JW+4?=
 =?us-ascii?Q?N9S8HdoUwRnepcBLj9/G1E27OuL6tPsGQqlaqr9MkwixDru5oT0Yk/FHZGh/?=
 =?us-ascii?Q?Mnx1RMuTP5EXaMmQpPKPUmxGempgYZBAf5wL9yra3fHd5Y/BrJ5rKSDPXXD7?=
 =?us-ascii?Q?2UtVcTvIqqJ6NXAUkSh1zmhEdYXWHgrK2cqJBDvNTGfqwFJoqqIeTKnYf1Tq?=
 =?us-ascii?Q?JniSbiQQWNFw2noXMPK+h4QP4YgwzzMNVbH53zE0CxBhCYDYMPRcaEq39Muw?=
 =?us-ascii?Q?87bS3cpn47Ls9vPCWu4P027gezzwbUL6deznhldjDRArf1VN4U4pp2TbRl3d?=
 =?us-ascii?Q?es0XMEBVDMEJ80l32xWQk8NPpJMq0p4kS6DKIXkI0JNMUp+dVOaAkcoksM/X?=
 =?us-ascii?Q?jVppnbv3YpxnrFj6NJAXE7rmkKbiNP45gTp+hFoKs1bCfNnkx1jhJ8Tx6cDu?=
 =?us-ascii?Q?9QXHDoL5vcE1Q3+mYHPiJhwMXiqamF/0z8QjBqhVSVIkVDl1hdrs54e+gx6s?=
 =?us-ascii?Q?zAxHRkalNaPkPuWrRvozF9//bY4tYO8ONzcq1Qg62LbMssCTqU8VJGuMNSgA?=
 =?us-ascii?Q?YFHiqbwtMoClQYiDtr9QRovs9vqdeAhlPqu1jZtDU4yOFZbCco6E9Jvkuow+?=
 =?us-ascii?Q?xHAwQV4A242ivaG5aKdJbYDlwaCXRzR4MPHCMsciFxhHsdlQf1wZ05IrAQK4?=
 =?us-ascii?Q?1fBeFcJoVs2/vfwvonH+rlmHFQmTyzpEkPKhw6vD+iI8XnFiysPc8TkrpzjR?=
 =?us-ascii?Q?Vo+keO+DHsWdeD3JjY+V4RZPPcNWbLiGW/5VYxk+yTKQ3ATKfAC3PY2uhctQ?=
 =?us-ascii?Q?DZbJbzmY+Ws0t0p9dcNWZStaDl68wPFyV1iCpCGYDv+kOPtc1cVGuf10iVhu?=
 =?us-ascii?Q?YNSKLtUsCHn70eQNAJZ/dHpTQz3CKMnuxNRbY8oPTfTCkzSUuGJU6w+SQNs5?=
 =?us-ascii?Q?hkoHhhEpz1Q8UJUtasCeD5tjWbEPSXK+znj/bcJZHQon90BLYwr7O9rgQCQn?=
 =?us-ascii?Q?5lhQIlgnPMaSQdHq0ZR0JVJPp5kkRALHyKZTjpUnMZkF0GXTPvAvJDWw43UF?=
 =?us-ascii?Q?7zz3rHxQZNZJ6mT+OVgo6e7JTmUFKYsDb+vwibaMJYvXCOLiYsuUMlH5CEX/?=
 =?us-ascii?Q?fCaJeIgY7tJgG/ruMwK/uA9NmAgWkbrNrR6ZRsWkFGa7R7NJfuvBpDlYTjxc?=
 =?us-ascii?Q?+3pwN188vdWsfyLk3stmXzK/0xvl3iT1T50RlW5/Xlf2VcFF5WZ1MtICDGR1?=
 =?us-ascii?Q?klq1oUKQKBOsY4iGXK2GhYGduN780htmDEeLDr6znk8MytoO5+X6qeTS27ZJ?=
 =?us-ascii?Q?CzBsA05GzwLwKKi81yY94u/GqUxZ1y6+dYtHJTSwXS2bGy0P/48VRAD6tZ4q?=
 =?us-ascii?Q?6FBf2KxJrLItmJT9VhHF200PjdoGx7zNqvQp9cR6H98bUhU/YIIblyTgYmrR?=
 =?us-ascii?Q?POmjMsPzv1oOJoGNd8hG8fI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e30d250-dff4-4026-bbeb-08de26d5865d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:06:05.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4eIh7dicXhsyFmi5XYJSFiVbO62+baGO6xvwZPGbS4IDQ9XlwdxYBbtuqkaHirzgv+91nlteZz+mJNwoeUqVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

This completes support for describing the XPCS in the device tree,
rather than just the case where sja1105_fill_device_tree() populates it.
Having it in the device tree is necessary when configuring lane polarity.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 70aecdf9fd0e..e62b2facc1be 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3035,14 +3035,26 @@ static int sja1105_port_bridge_flags(struct dsa_switch *ds, int port,
 
 static int sja1105_create_pcs(struct dsa_switch *ds, int port)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct sja1105_private *priv = ds->priv;
+	struct fwnode_handle *pcs_fwnode;
 	struct phylink_pcs *pcs;
 
 	if (priv->phy_mode[port] != PHY_INTERFACE_MODE_SGMII &&
 	    priv->phy_mode[port] != PHY_INTERFACE_MODE_2500BASEX)
 		return 0;
 
-	pcs = xpcs_create_pcs_fwnode(priv->pcs_fwnode[port]);
+	pcs_fwnode = fwnode_handle_get(priv->pcs_fwnode[port]);
+	/* priv->pcs_fwnode[port] is only set if the PCS is absent
+	 * from the device tree source. If present, there needs to
+	 * be a pcs-handle to it.
+	 */
+	if (!pcs_fwnode)
+		pcs_fwnode = fwnode_find_reference(of_fwnode_handle(dp->dn),
+						   "pcs-handle", 0);
+
+	pcs = xpcs_create_pcs_fwnode(pcs_fwnode);
+	fwnode_handle_put(pcs_fwnode);
 	if (IS_ERR(pcs))
 		return PTR_ERR(pcs);
 
-- 
2.34.1


