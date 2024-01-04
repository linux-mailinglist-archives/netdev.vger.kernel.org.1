Return-Path: <netdev+bounces-61537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12903824338
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758801F22599
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358F7225DD;
	Thu,  4 Jan 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JD2PxS3I"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2054.outbound.protection.outlook.com [40.107.249.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64017224FC
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnZHsv4a4E0MCbqxL09+8PJRNI8lZ4EUm/rjt/+ujzYOgTgNrhBeOHiY8zKTWBkzaPImhKbzv1+beRaC7nMgcFKiUxcNere9SoS8D3a9qqN93HxZpMeRL/J4OgSOOEOai2SPyKe0TWdCwdGXmaqa4/XwuGz2FxVkCfPA3QQXyl8kP3JNt1jMYazrmek4W4U2ex1ivUckLykgHKGhN34RcaNBC48HF/ARQcRjLrpf45OJMIT3BdwEm5KfXHJLyJ2yx61IH51JHwHTGujOrRlrL0wdIjyouj04VhLLYEoGio1lXvMYC7InYGN3W64e73W3obDogcQaofixxnvudiqFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGx6fn/0A6YOv5ng/hkM9VfdKqmtgJMqN6zcwvWmpiU=;
 b=CYpvWOcvWUYpeUE1wD0McIyN0zsptFCeLWzUTKcwAUwqw/nwzpbh5NlLIww8LUW7jL/54/TiD8VZ1ML/0ywgka7MRMSSMWyTuOqDbePCI0k03oV9oqId85VMl0feTdwPklsVLChYEU+0FfQcHGIWVklHalVoSLimAUS3j7hc6SqAJ6rz1GWfVMMXJ3NNMHFpopIZ8AnSLsNzQXVmthbhkC5mWNsu1SoIk7pNxOVvj+LUA3lR6AwAKAgDXXelq37sAgyQ7vwyfB//IpMBUvwHCBGEs6oHzBcvl46BWHvhYv14dwYop/CmbHbnTwgFlY8nfv6ZqKnIlVT8b5n3RYKwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGx6fn/0A6YOv5ng/hkM9VfdKqmtgJMqN6zcwvWmpiU=;
 b=JD2PxS3IZLu2EkZVh3mZ0Fx27X2tzc+D4JMWI37O++s8R2+A1abEeFoRJISudiLuv0wjxLaWGtgxvfzwjnlwmplYKv3QA5JCWkOPLzWSx2Byp5ZNn1btAMoSpVAu73yte2yvPbQwZkU12HSmhIAaAAjhMJC8tB138Fzz3tNprOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PAXPR04MB8176.eurprd04.prod.outlook.com (2603:10a6:102:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 14:01:16 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 14:01:16 +0000
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
Subject: [PATCH net-next 04/10] net: dsa: qca8k: put MDIO bus OF node on qca8k_mdio_register() failure
Date: Thu,  4 Jan 2024 16:00:31 +0200
Message-Id: <20240104140037.374166-5-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PAXPR04MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: aa60a95c-78c9-465a-c0c6-08dc0d2d9e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gqU8n/oTmwoY1QmLfFja8kH43BD3pJpWe7Gywe9ycou0GM0hizMsTr9RU8j3CAk1gwifH9c5X44pSZW1hul4vQPb0U+lV8ifZ/LhF0m3u6VRtDGBziaKPBQK8XvXnHXaPA69mrN9QYE0F3x0xb/qeU/T2qpw4/gwgiq81ikZhljiIVXSkCh/f9uGMSup6/6frp8BQa0Gz0Bk6U5dW8BTeiGqdetrMHRSdfbdza+nuYmnZWhc+4kclc39H4cLtexZtncB6HuwC5QEYHnaDODtKHXRHsDP4ppUYOSEHEnDB1mT3iam8Zw82Y+HXOyWv3PDkhpFgcW8jDG2aRRkgGh8bXe6UAos8lfGFcQ1U7GQi1isaRxG0c9biHIN//g4pWaEMA9f0KYzUvuS1rx/S3asYQ/FqoxkuXEnz3QRns2WhdgEp63I+K4cHpCMnR+qoJ+UCckR17hCHDCgWExFryhhPGibBNZzZw9w9EBJIN2KloCRaat5vj1WpP2hGefHBQNSEIRNULcF4fhTee541DuZBkm7KLXvxMYnd392AqNvaUSOZrcPl+cYu+onNWy58AYR5SPilDY8ZKCpsC77GKHUkHOOtFBGIFp01H2naoQfGOFy8rjzDVK/zmFjujIRH3iV1TXbYqc5ySJhIGTEQ+pnSQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(7416002)(41300700001)(26005)(2616005)(83380400001)(38100700002)(1076003)(8936002)(8676002)(54906003)(316002)(4326008)(6916009)(2906002)(5660300002)(44832011)(6666004)(66476007)(6506007)(6512007)(52116002)(66946007)(478600001)(66556008)(6486002)(86362001)(38350700005)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z4NwbrEaaNAFfQ6GqFn4eG5rAIhFEcAaT/c3KMhSfoVpUuZ4Dhw5rSKgOvWo?=
 =?us-ascii?Q?JnnQ0DN8kTk1QzrsWF79Vha5sIYXE/lL6anmkzGwN5WJ4XjqPZBJLcFz//pf?=
 =?us-ascii?Q?9F/Hx500ZVV4cy+CvobxvX5S9btV2Jnt3inYKaonjGhiFb/mxMFsZEXZE3Md?=
 =?us-ascii?Q?IcCoylZhsvbihlk5IUDGZAeGusGhi/lda7UmHlDMI8pv7etmsx4lKaOXZgJE?=
 =?us-ascii?Q?T2lpgLxu8B3ZwI0ORLRbLyAwykWBGW+k9SgggWdXU0mDKc8rjTfq39uYbCO0?=
 =?us-ascii?Q?17UpsUZauMbtrebEIRnH065CpdTPX0ffq2IxO2Js7r8HKpTQnM8HWiTV0ihM?=
 =?us-ascii?Q?tWptbDGOrtjH6zzoDx+XQu3/qNlwOQVw5wGExBE+C5DLNl7mgr2rBrGT107Z?=
 =?us-ascii?Q?tVTtdrP3CtNAirLN44AMat5BHdMHpkaiZlANOo3Rw58ukvi3anTj8P3ccCzy?=
 =?us-ascii?Q?Vc6g7qx6qxmyfNvPYi3mBnju6qymzIuKoF7PxZkvQYM3+AMSmg4Uhx33Fqrz?=
 =?us-ascii?Q?dCPe/d/CzvAqS5mmIAJmkt3Cero4WgekwlhHSBYetSoo8yUc96aukv/mV/k7?=
 =?us-ascii?Q?jwpFMZFdjxr7AWJSy9ooToZB2hb6nQm3BtvCKdEUrYNc5Um66qJkXmzcfMgk?=
 =?us-ascii?Q?3JFBcBZ3xx9d+ik0HMWhrH4pKCUuM8vYy6poT40DV6D63XnFGU6SFh8F5S1g?=
 =?us-ascii?Q?HQiVHd8L9C751HREDen/BJIlUjyxHGUdm8FsQ94udL5Sp8JWv7mYd7IW6swb?=
 =?us-ascii?Q?1vyDLs+Y8NQ1EUvXY08bohWXVC1xy4O22At/ePN6c/Eq/jlmcCwDBq26oVTH?=
 =?us-ascii?Q?PJiFH+X5vwPjwrcWD1wPMceVKdx6okKaKtPhXu9PQY7Wvug2+e/TKvoCUfu2?=
 =?us-ascii?Q?+6CaOvBLsleDCxLEyqeBzYKAetaaam81dE9OlrDLBHtrn1coawSDwjSNA9iV?=
 =?us-ascii?Q?i57roGnYGssX+LVmMOAIF3lgzbZ5qYkF18GswdSam7nTTE1+IrlP8MszvQxr?=
 =?us-ascii?Q?+H4ZyzNQARj5dw4BSAw5+47xB+wvJr7PPBeFjnmHk3wUV9Aq14mCae1j/pob?=
 =?us-ascii?Q?XXzN6U73MPQT4ZCV8JhZ3ZEb0QlZwL4IQjTP5m26HEI6z9rR2tGvD/nYgA0+?=
 =?us-ascii?Q?2tQ01Xsen/+Oe1Y0PmYVDA+FWJJ4wCKKFZOJCTTxL7dI/UaE+RSb+uR95juQ?=
 =?us-ascii?Q?pe+sLdirvhWFUoWd57wauEkUrDA+sUhDR3EnX8q8qi+obsaRA0KeQsrkBG4Q?=
 =?us-ascii?Q?DwfORQjfTTljIfEhD40L4inI2f3J0pI/9iIhQ4ADb0whRoG637UaX+bBAnCr?=
 =?us-ascii?Q?OaDjeMvnioU+zA1eF23TLRQXPhxv09D762XWi8ZwZuTECBGWtplfRk3VUwre?=
 =?us-ascii?Q?Nx1N9xosHlEuVTvdamfuuMb8JfIZbIhWhgEOdE+DtXL0awFUI7hGfJZaYtzl?=
 =?us-ascii?Q?igMXMF++yNptJshB4sJE9EKgP6y+9XygCEw/hDekw68KoNjIkodOcrUlRQQN?=
 =?us-ascii?Q?cmfC86L8PVWhhFJAok4KvhYNU+Aho8qt13x3JzSvRkdMAjxpAYolexA7qvzp?=
 =?us-ascii?Q?jOxzGdhI8jo9xwImO0XVTBBnOdIcG9sXUXhSH5uVhpkGPDXJrqMpRrTRLEGo?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa60a95c-78c9-465a-c0c6-08dc0d2d9e5e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:01:16.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XxOGPP6F9rUrQ0iGpxIskNWy60vGy5XewFkCj0cQvUvbfaXOEQujd25ICMI6wf6JHudrWH4FZlFuns8C4cdbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176

of_get_child_by_name() gives us an OF node with an elevated refcount,
which should be dropped when we're done with it. This is so that,
if (of_node_check_flag(node, OF_DYNAMIC)) is true, the node's memory can
eventually be freed.

There are 2 distinct paths to be considered in qca8k_mdio_register():

- devm_of_mdiobus_register() succeeds: since commit 3b73a7b8ec38 ("net:
  mdio_bus: add refcounting for fwnodes to mdiobus"), the MDIO core
  treats this well.

- devm_of_mdiobus_register() or anything up to that point fails: it is
  the duty of the qca8k driver to release the OF node.

This change addresses the second case by making sure that the OF node
reference is not leaked.

The "mdio" node may be NULL, but of_node_put(NULL) is safe.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index ec57d9d52072..5f47a290bd6e 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -949,10 +949,15 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 	struct dsa_switch *ds = priv->ds;
 	struct device_node *mdio;
 	struct mii_bus *bus;
+	int err;
+
+	mdio = of_get_child_by_name(priv->dev->of_node, "mdio");
 
 	bus = devm_mdiobus_alloc(ds->dev);
-	if (!bus)
-		return -ENOMEM;
+	if (!bus) {
+		err = -ENOMEM;
+		goto out_put_node;
+	}
 
 	bus->priv = (void *)priv;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "qca8k-%d.%d",
@@ -962,12 +967,12 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 	ds->user_mii_bus = bus;
 
 	/* Check if the devicetree declare the port:phy mapping */
-	mdio = of_get_child_by_name(priv->dev->of_node, "mdio");
 	if (of_device_is_available(mdio)) {
 		bus->name = "qca8k user mii";
 		bus->read = qca8k_internal_mdio_read;
 		bus->write = qca8k_internal_mdio_write;
-		return devm_of_mdiobus_register(priv->dev, bus, mdio);
+		err = devm_of_mdiobus_register(priv->dev, bus, mdio);
+		goto out_put_node;
 	}
 
 	/* If a mapping can't be found the legacy mapping is used,
@@ -976,7 +981,13 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 	bus->name = "qca8k-legacy user mii";
 	bus->read = qca8k_legacy_mdio_read;
 	bus->write = qca8k_legacy_mdio_write;
-	return devm_mdiobus_register(priv->dev, bus);
+
+	err = devm_mdiobus_register(priv->dev, bus);
+
+out_put_node:
+	of_node_put(mdio);
+
+	return err;
 }
 
 static int
-- 
2.34.1


