Return-Path: <netdev+bounces-61541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0239182433C
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C971C23EB6
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4C8224CA;
	Thu,  4 Jan 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hKEIo2y6"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C5922EFB
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etH0JdGPpXH4ULmu0c4Sjng4e5YFEbthzx4EYywauZ0NfckYIs84jDskDIod5oLBIsXEeNWk8pUzSJ1+rX7MW5pVv6QeZLGI7rLvlpGOUQ+mU7F12igG2s1WRYJwF8JaAYxC1DF6KHlBMkQCbQzgglXcuuYL723tJHMwQVoJq9fljpvH+yz1QJZveOkhunJX4DWj8q/n7xzngse3uFQC2wMZ2KLsI9jgsNWRBE8CYSxXpQlM81En5VZ3f3gPZx21JmqAKWkH9qZlx39NAelWM7w+mOLlVwa4qjixmqVPxJk2AA7S21Mq8jVLiCgwWpQsr/rtnhTSyE7CdVxx90GhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jzr5gT1LVGPzvtI0OgsAoDbufboqIOjyypggs+qasc0=;
 b=FkwGyu8LVIuRMFb35qRDMbWe91fDBAEhSX3UV57mMHQVY7cehBaLfHEhiQWlMX9HV+xBjFyd5ml260FsFNjCbi4p9Zccv5OXXrFbhH+/MB7bbXbunvhdy/Ph5yqTJbc+LPmvBgpcaEu1cRBTwrYbY70vXV5PhMj9HY2PVNQMFHq0CShkx9UhqjVqwV3cOUFcsTMrQMWRiq+TD/AQGp+Z1H/ieJToTYcLrRiJ6zOxEr60gaJ+CxWGT+T6CwqF8WXKZ6O0/GEFrDHLY8lpCKW7Znthn1GdmP6G/vbxIjvVyh/GTFRB05cJcD+6nmlDMrS4NHMHleI7m4qZIApaFnoUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jzr5gT1LVGPzvtI0OgsAoDbufboqIOjyypggs+qasc0=;
 b=hKEIo2y6r60onQVkcUxCfpQxNPg69Eg2Udw10cRPzt4TFuxW6LxeziBQqgGza8HGJinVACIp6l8kKb0UwgfEaAekKSSgueI5nHL9kPlbEuMpqY+OGtce+dTcFiSKn076FCYFeHZKVkpSDWuITl627PexKpJ52mwoNXAtMX0YHqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AS8PR04MB8579.eurprd04.prod.outlook.com (2603:10a6:20b:426::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 14:01:21 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 14:01:21 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH net-next 10/10] net: dsa: bcm_sf2: drop priv->master_mii_dn
Date: Thu,  4 Jan 2024 16:00:37 +0200
Message-Id: <20240104140037.374166-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104140037.374166-1-vladimir.oltean@nxp.com>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0063.eurprd04.prod.outlook.com
 (2603:10a6:802:2::34) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AS8PR04MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: d047daec-1d85-4638-5dbc-08dc0d2da157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lCl/CB4Zs30cs0S/sH2BMzuowYPU4HH6+oRfG13YABICyrc05OFeN98J1rYU1hr5f6vWEwFz0hzzn6OKBr63aH53XAhICt0GcLh83Qfu4d/TZ282CyQ8UaX6p4kqnECN4AFCGbgpe9exV2hHxXiJnDAO3JOpqLhHlMj4zv24f49uL6qJe8NyC+0LhlBbxr4jBa9SioUcOOxeue52JnmgKhnbjTWbip38+65HuAfzimE5lprMVypjjt7UhsPA7H5zn+sNYWuiXZL2zeMwlfx+2Lf1Yap10lovkVNGfmryO7S6kM8tHfeHd3JvdQM5LypvtjQE4o13NNNPilCPTxVBoZWPHCeZb+BrQRf+RLvrFGuBBaJ8pM78tjiBuF+v+2VTy6S8bAB6TgME1wDM0upCmiaHPWm5czoNYLKMLxxQwa3EKQYijHj9x4HpASWrOS6qqqSvrdamHRq83w/ijFxdAdFsgiUFO7uYswUN9SYHlB8heGBjihbOCN9K8raV8nNEOKgUz3oZ43MuDGuAP3KnrlqU3aeoCTuuiH+fYm1mh9c7gnO/p4pyFc9gdpOFwI6p1f44fX63YE4v0odaIe4Y1mV1vrbWAp5pkd8jH21zLGRBaWE6oQr1hhZVTfkbuii1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(52116002)(26005)(1076003)(2616005)(478600001)(6506007)(6486002)(6512007)(83380400001)(41300700001)(7416002)(2906002)(66476007)(66556008)(66946007)(6916009)(316002)(54906003)(4326008)(44832011)(8676002)(8936002)(5660300002)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F/4s7Ks+a9n5WqBzTfq+HxSRzATNDO7QQh6Rl8ouvUZLw7viyVSNmf5ICjNV?=
 =?us-ascii?Q?fkDxtDgTu/UGxBvNuQjY8XBNKvcPLoCZXvKfi0v7znfbkytLpS5LhP6KxCDy?=
 =?us-ascii?Q?TUhMtbfhuY1/1x1TJAV3qRE8HT7MTvxmVgFRJt5uDCrV7XkbxuBNwyXOOqq+?=
 =?us-ascii?Q?+lIPYcHlh8tQvEHzokyvlWG+WlbAJMVQjQqjY5U8YKduI9Kkexq10c2r6525?=
 =?us-ascii?Q?n7MMoO7mT+ZYd+u/Gkd527ykS4ZW0wFO3Myr36yE2tvTlpr72ecF6O8ceZ9F?=
 =?us-ascii?Q?xF4F115VUhZN9ciXQkfckKlusYKFrvsFjfVAa6tNrx1iASdkgTSSQgUlgooU?=
 =?us-ascii?Q?Nmc39wsr0+op++NhCvcpgXrd8iOwUwSghHOr2Dsr670qfj4ClGoVgvvn8QXI?=
 =?us-ascii?Q?38YhgPb4XwCXSsZSKVPl6w+TDoGeuRcdIbPsR1LUOACCl7/HWqohKtfZOMp8?=
 =?us-ascii?Q?6hm9NEC87mVc2njZrXv2YSef8S6Zpf1yrk8Ej4VVtUMz9lJpmh7RqnP3M0jN?=
 =?us-ascii?Q?jEa059Kvxsbj1dhTd1XGQI56r7YxcDs9NTMSoFRqrzQPPtBL6CZt4GwnUVN/?=
 =?us-ascii?Q?dBtIiC0DXuOVBtZ8TjofdUztXswYSkQt9aznI28pO73b+lI+Qrkx0yy/eRsk?=
 =?us-ascii?Q?aSdTKTec0HphyLOPtKdfrjndSzQNYz5XA1Un7Bh/1SbNDcV6kT+tmfmSJUOw?=
 =?us-ascii?Q?8OliaTo9GrhyjorLPvZXF6oMEk8eNFGPuhVUVyZu4Q/UFrM17qhjORiFR5Ki?=
 =?us-ascii?Q?/werx0pv2P2ty3mRWgLsmEuYb6krdK4MDLTUACMDMdnHFpi+zOobMdN0qtVu?=
 =?us-ascii?Q?MOkFBY2e+SUZTpSgwLqf8i+nCbQr/ffRr45aTxB0X1SkWaKaCNL05Jt8bZ18?=
 =?us-ascii?Q?fsMtJKRJztvCQOzheHXIfvrBa0u2/rUpOjYYRbO9QlYeJnlijRdrcly36+vk?=
 =?us-ascii?Q?tJIBeCuFPH64pLJnx6utYISYOnAg/WZepFzFab/vOTa9fc4lwLXMGE0+3GAi?=
 =?us-ascii?Q?9th3/gV2XT4C0jvjlj80en60lTZlwWm1RyQ90zt9s+0z/QCtSfeLkv7HuYAO?=
 =?us-ascii?Q?ReKV+9NkDdy0k1FolEBnevDrLBJEiOghzMhDfxOqHsSphIxPkGYK2ej7iaBw?=
 =?us-ascii?Q?oQFql/6+xLzjGu4QNaxDQqK+maMdjwBgV69WAT5uG1i85oaZC7rK0GCTsy5h?=
 =?us-ascii?Q?ykUty6TcLhf57fIB93VNtHTQF6HMi2MFycIIGW0jKhnicBidfZRjh9wYeVJO?=
 =?us-ascii?Q?dqEmrrpvaKcfgJN+2GqY6wJ4OZS+KDxSd/4Lc97/yxuaJY2nuaciz+TPtl7a?=
 =?us-ascii?Q?OOG31UFF5BGDHLK8eClHRn91gxT03/o/Xby7lJp42SbBOpdOgh/86GIr9umf?=
 =?us-ascii?Q?EjDlLBo9ZrrvrzmT5Gnh2z8U4EMD30Za7bnjMv+BFMM34rrkrpEFkkOEFC0L?=
 =?us-ascii?Q?I76r7l74LrrVAzckQlCcgIvkzRMYdFsnn7mh5TntkU2XoK6ZowKEQBazUJ40?=
 =?us-ascii?Q?uCF0QgGtJzH8vMtQI9Ypr/ouL/7T0IJKllenUX6rggbecJfHrNrC6wMbgHcF?=
 =?us-ascii?Q?dV9oywylmNtX2k61HOAOeJyNj3P7l9qfFvrn9S1/pZOloqfwus6W0dQBqPYR?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d047daec-1d85-4638-5dbc-08dc0d2da157
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:01:21.2670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMzJ71jJArbNoNMsTV/SiFiAouznzAIycnpONtQeglSFCGtRBQKlqvUc9SECN2hs4MPyZRn/D5GCZpd5eMgQSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8579

There used to be a of_node_put(priv->master_mii_dn) call in
bcm_sf2_mdio_unregister(), which was accidentally deleted in commit
6ca80638b90c ("net: dsa: Use conduit and user terms").

But it's not needed - we don't need to hold a reference on the
"brcm,unimac-mdio" OF node for that long, since we don't do anything
with it. We can release it as soon as we finish bcm_sf2_mdio_register().

Also reduce "if (err && dn)" to just "if (err)". We know "dn", aka the
former priv->master_mii_dn, is non-NULL. Otherwise, of_mdio_find_bus(dn)
would not have been able to find the bus behind "brcm,unimac-mdio".

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/bcm_sf2.c | 6 +++---
 drivers/net/dsa/bcm_sf2.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 19b325fa5a27..4a52ccbe393f 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -621,8 +621,6 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 		goto err_of_node_put;
 	}
 
-	priv->master_mii_dn = dn;
-
 	priv->user_mii_bus = mdiobus_alloc();
 	if (!priv->user_mii_bus) {
 		err = -ENOMEM;
@@ -682,9 +680,11 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 	}
 
 	err = mdiobus_register(priv->user_mii_bus);
-	if (err && dn)
+	if (err)
 		goto err_free_user_mii_bus;
 
+	of_node_put(dn);
+
 	return 0;
 
 err_free_user_mii_bus:
diff --git a/drivers/net/dsa/bcm_sf2.h b/drivers/net/dsa/bcm_sf2.h
index 424f896b5a6f..f95f4880b69e 100644
--- a/drivers/net/dsa/bcm_sf2.h
+++ b/drivers/net/dsa/bcm_sf2.h
@@ -107,7 +107,6 @@ struct bcm_sf2_priv {
 
 	/* Master and slave MDIO bus controller */
 	unsigned int			indir_phy_mask;
-	struct device_node		*master_mii_dn;
 	struct mii_bus			*user_mii_bus;
 	struct mii_bus			*master_mii_bus;
 
-- 
2.34.1


