Return-Path: <netdev+bounces-68589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B8084750B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CFD1C274AE
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97446148303;
	Fri,  2 Feb 2024 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JmqtD+jD"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC4A1487D2
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891939; cv=fail; b=GPy0K+23+O8vqWi/nuctUz+4lyar7gHVA0WEtLKp5xgwLsmBZ6P3zuJt8WhTl91z+/0ItKip0U6rEGAsNb2cSOXUjIk/JJc5iSyLwBQS1wkl1NQRm2Tt7pg5IKY/CJUpTkYATJESWpJvCi5RE0ZCtXR+a8g2QAA22wEsdjixilQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891939; c=relaxed/simple;
	bh=+LmrV9F43P33v2xP3Hj8OTB8AkLAXVj5XYA05ONuFNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wq4UeLL9sTJZXBnFDmoX+TkD23VuUdIwGfJQ0pzRVWVMA8vIR8l0n6KVHI3wuyQIl9zbIhaB78JzRroP3yIOvAyQy6vkHwW51ZUGAfKfOf7VXwwYewDyooRJu7moKcPHp2PRZt4k70Wlco/a4Xr/42fAYbLII4LasQPOq0nZJGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JmqtD+jD; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0WKdtmVKF3Hh1X/lethxPLpK9fok5mFsxQjiiFpj+5Px4dkN8qhzdRP2Kp4go7HPBlDdnA94AUmWQ+AOmgQmf0mrNTuqYkKrs9nk/y9rts+7PJPJto2JcNVrsWCr2zPWjESndXC2asBvMNFQjTzGgkeburS9T5Wc2XrfLjTTZw3FLqD4VBk9HNQHkiKCh4ieF4cD/ik7lSPGU8OzJBfBIU5+QK/pRfzSSDqFN47CGrr0DowT5ymqsvwQ90RHGPUM0yznpUcXOPNfjZ86Za+8HIs+Ez+ng/1ep9AqNWgIcycQQyNIM+Uw6IEdXHbAYKZrXGgKtmGVlpYyOac4sNMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaQwmwJYiwpIEf3JkN3YWg2Hazw1wKYZJjttZpyqsAw=;
 b=ftjmtN6Zngh0nIyKnzFSqrX7iMUSSP44LfSiYOwwrGukiOwe7+zMCeuKvnpSCGUc0x3oFmyGURHvqMG8KjrJ5j11h/fdxV0+w3+PQDvn6aY0Qb1QLQW3qI1DQX24ukrhoYbVVfFt5KLJlzopJMsEfEgZQqjIIfOjoLwJNd37P2DeijWy1y/XWEgoOiwit1aYAMGdrkw+2zfeX6gO4dClcoihEj8uFqupsS9aEcdX3u0IfTs/6hfiMVmRvgEOa1VqpmTevSBPGt7GXV86OTSJG34DwaTkI0173yZyIhenTHjLrDysdS5Fg6LfXapZOw0t5e2zuZ/8qKCb53CochRETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaQwmwJYiwpIEf3JkN3YWg2Hazw1wKYZJjttZpyqsAw=;
 b=JmqtD+jDqE6vs7mr2MWR5TCqF2N7o9JMY7cZxjK7Sp8isqeqcBvtok7ptxp/haMxqO83I7ck64XfXQPBcJO/9YMYjjQIAPWDbGSgA6X8IVQiHnBi2ruRTn4rwjCcYBcHptm2im2rjA5ExERE2WDejqzl3euwXhmqK3XlL6AekLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by GVXPR04MB9974.eurprd04.prod.outlook.com (2603:10a6:150:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Fri, 2 Feb
 2024 16:38:46 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 16:38:46 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH net-next 2/2] net: dsa: qca8k: consistently use "ret" rather than "err" for error codes
Date: Fri,  2 Feb 2024 18:36:26 +0200
Message-Id: <20240202163626.2375079-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202163626.2375079-1-vladimir.oltean@nxp.com>
References: <20240202163626.2375079-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0094.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::35) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|GVXPR04MB9974:EE_
X-MS-Office365-Filtering-Correlation-Id: a433538e-cf57-478e-73ba-08dc240d6cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bEn7T3GjxHPDQiqlOnGNDbFIzq0+q+fspo1FeDwu/gvnHIG4RXWKZAbhrh2WMgd09ex/GW1PlDKmMO6g5Abx1UWxOCHTLMER8H+P8jS3877BkOBHKo2xFOtR5ekCMWGtFpvv6kZkGT33Xwk3JVggpTWz0s3gCgWMzXf9C8BRSZj9xlkDihtPKC7CoYnFbW8p8U5aqJmCuA0iXElVwK73KE01aHNm/lvZNNQrCKIYVURfzvN60LEofRNFeIh8kjz9JYiAeADgRwriRuAJSB6wxWkiAaP2TmOllTU928RTyAeMNl3unZKtvvQiLfvqVU1iXLPrjHwNx8AlWyKjFtNki5SUzwSV2u7XJaY8QOiWfx7M69Vs0hV6rWq7MlNFXUdxB9E4duKz25q3X4jYq2amCe2o83Degw08l0WlLGX6mild6IYBpdvtkSq065SsVlnEj3bFbhU3e9eOhDrUbRnmKBoOMJpXZvqH6VJqocHs0gNYO2m/GTKAaNyosOVjBkRW1Y43n3RhN0AwKTattGwuYgCk+nq+27j4iLZYvyaTD54sGwtXCiQ4kZWow/pQa+x8js1ld88pHmVnpQKDbvRzR3YkcoYTZ9lAN46Cu9xlGFHFY68Q+fnCw73nzGNgyzTrqs+L3fAyQOMTUuTXM2cQTTDJQyRz0CjIw5aZ87RujLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(2616005)(6512007)(38100700002)(4326008)(26005)(66574015)(8936002)(2906002)(1076003)(5660300002)(6916009)(966005)(66556008)(6506007)(66476007)(66946007)(44832011)(54906003)(478600001)(6666004)(52116002)(6486002)(8676002)(316002)(38350700005)(36756003)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFpGSHI4V2RyZEJQQkRicDg1YitMc1l6anZyYnAxdUNkcE4vcnR5bnFsSGZV?=
 =?utf-8?B?TGFZbWdzUS83Y1V6M0luZDdpUWNzK1ZCZXV4V2trT0V4bG1ZUlByVUIvNXZk?=
 =?utf-8?B?M3VVM0NaWUh5Z3dMUXJvelZZZ2RaNzdSc1VNRDU1cXk5RDY1Sm9PRmVWY0JF?=
 =?utf-8?B?Y1p1ZGhhNis2Qy9iR2pEZkpKbXlQVWdMRHF5cDQ2Uk12VXcyS1FWT0tadGZW?=
 =?utf-8?B?MHJ1RWFuZG51ZW9WUWJJVFluVDVHS3IveWRpVjc0Um1DRFhmNVFFWFJtMytV?=
 =?utf-8?B?Uk5acUNwQTdKME45K3pobUdMTEZIUkRsbmlhUFVwSWlqTzlPd3prUGtyQnI0?=
 =?utf-8?B?d25VeVp5M0JRN1dDU2VMVUsyUVhPMTdwRFEwREk2Q081TVNLOUZ0SFUxVDVZ?=
 =?utf-8?B?c3ZDSExWdG5JNFM4UzA0aTdrRGJSZ3AxRmxHQzRrbHNRTGtsMVl1V0pmUC9n?=
 =?utf-8?B?UUlwSEhrM3pVVzZqWnZmUkI2OTBoR2VpMGtCQlphVmdBK251b2szbm14MFl1?=
 =?utf-8?B?cS8vdURsbEtyL2RpSUxtZk1zb0IrVzlhMnM1YjUwMWtuWVFQbkJWaEhxbTlQ?=
 =?utf-8?B?Y2N0NmRROWg0Y0p0cks3TEUySVlVWGdPWlRTclNqL3o1TGtmRVlKVkxhMFc1?=
 =?utf-8?B?dDhraThXaHM2TmRtcDkyQ0dQR0t1a2hUMWNuekVUZW45YWxuZTVnWm9yRExm?=
 =?utf-8?B?OVJTV2dDcmtzYVY0UXJqWGF5NGhLM1FxNXgrSlF3Sno0aEQwN1JXeTRGNmVW?=
 =?utf-8?B?UzMxSDk2bStaNlpEVFJ1dGNwYXRNZTY0YnJMdHhIbTJRZlkxYzhwRFBIbTZ3?=
 =?utf-8?B?M09ZYnNHSSswd2VUNzFMNCtSaHFSOHpPZWh6bFZHa21Wem5FRnh1Wm9RbitQ?=
 =?utf-8?B?blBZbzc0cVJUSTZTR29uUy9CRVEyUnp0MGxQWWFselZoL0c4NXEvNWlEU09r?=
 =?utf-8?B?RWJic1UvMFNjODBlL0Y1TkQzV2NhcHF4NVVWZGpXK2F3TXlYRytvUWFBeFdJ?=
 =?utf-8?B?QlN0SlBHWG85Y3p2SE9FWUxpMTFySDZOOWwrRXBsOWlDQXRab0l1U2tsR0JM?=
 =?utf-8?B?WnppMFlzUWlFTU52VXE5REVwZ3RQb3h0S3JUTlZWdjBXSEVsMjU5Mm84eCt4?=
 =?utf-8?B?N21DOWUybzA0RzJEVTRCazBXcHhhK3kxRjBTZm9sa0ZTZW5aZVZUNStzUVhY?=
 =?utf-8?B?SFJzV0x0bkhCc3ZFSzRTaytnZGFvRzkzTmxFVEk1SlVJNWlyZ0Yva0o1ek50?=
 =?utf-8?B?a2ZudXlXazVOdHlKTEFNSkRUL1YyaFpFRVBuV1ZrUXZxQ3g5U3FZeW9laHo2?=
 =?utf-8?B?SHVvZ1FIR1hLcis0b2t4NTB4cHBmSnJWcy9JbFRaN0JIYWFSVHJ4MzhUQVJt?=
 =?utf-8?B?R3NWdkxnMnFHRWRVQ2FqQlpRTjNwMm9zRm82SjZlNFlqcEowVkhrckRGbWlR?=
 =?utf-8?B?czBRNVpqTWhnRjVzM3VDOUErTlJzdDNPTVlHWUtZVmk1bDZZQmx1SC84YkFU?=
 =?utf-8?B?VXZsdi9FOHBWeFU4bGk4bkYxR2hURGZHV3BpakJFTUo5SDYwTGZncmw1eDBp?=
 =?utf-8?B?WFFyeDZUT1BzQ1VrdU4xM3JUQ25mZmQ4REVTU1V3aFAwdUk5QmlaMWNWdlNu?=
 =?utf-8?B?RHY5NEtOQmxCNzlXUXBBakFHS2UwNkk4aDR4RjZkSHVONTQ1SWtyemIyT3dW?=
 =?utf-8?B?a1FTVi9UenpVM2NRSnVGT2lHaUhGRW5BUzVpR1FFTFMwTThpZlYzK1g1TGxm?=
 =?utf-8?B?S1pGVTcyRC9oQnJYMFJLd3hzUSs2SzZ5Y2tFeitOYm5vMlNxRmV1UGlZSGkv?=
 =?utf-8?B?R0xEVTR2eTNNbG83OU44TUpFR0ZTaDNUSmg4MTI2cm4zNjdWS0FoMENCQlJS?=
 =?utf-8?B?c1pwTkR0OW9LQnNVT1pPNjMwV3lNZlc1TWJLRHBVUW1Lb0N5VFlpcGREZXhG?=
 =?utf-8?B?NmU5bTdnQzVSMENZZnNCc3ZXUmdzRzF3YUNhdERCU2VKd1JpZ05RVmhEdlFM?=
 =?utf-8?B?LzBMdXM3bnBwaFRIa2ZwWXV6Y2tZVGhtTTI1WERtcld4Wjk2OUh0dTQ1QUh3?=
 =?utf-8?B?K3VIdU5HaTQ0aG4ydmduWjUvUzA3UGRGaFJOS0NDRnVEU0JJbUUzQ0VKdDhQ?=
 =?utf-8?B?SExtcGJxRzJLdUNIa3JFOUZFMWRCdDJua1h2bFJqdzRzeUVVSENRWWZ1aHIy?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a433538e-cf57-478e-73ba-08dc240d6cd1
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 16:38:45.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mm7uUZBxAaqJboT/dbKOpoqJ9db3SYDSE9GYWTvhdwE+8SmUTYzx+QTmu2Z8Ll4NqNj5bekpye6fmnTMQ9M2Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9974

It was pointed out during the review [1] of commit 68e1010cda79 ("net:
dsa: qca8k: put MDIO bus OF node on qca8k_mdio_register() failure") that
the rest of the qca8k driver uses "int ret" rather than "int err".

Make everything consistent in that regard, not only
qca8k_mdio_register(), but also qca8k_setup_mdio_bus().

[1] https://lore.kernel.org/netdev/qyl2w3ownx5q7363kqxib52j5htar4y6pkn7gen27rj45xr4on@pvy5agi6o2te/

Suggested-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 95d78b3181d1..dab66c0c6f64 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -950,7 +950,7 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 	struct device *dev = ds->dev;
 	struct device_node *mdio;
 	struct mii_bus *bus;
-	int err = 0;
+	int ret = 0;
 
 	mdio = of_get_child_by_name(dev->of_node, "mdio");
 	if (mdio && !of_device_is_available(mdio))
@@ -958,7 +958,7 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 
 	bus = devm_mdiobus_alloc(dev);
 	if (!bus) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out_put_node;
 	}
 
@@ -984,11 +984,11 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 		bus->write = qca8k_legacy_mdio_write;
 	}
 
-	err = devm_of_mdiobus_register(dev, bus, mdio);
+	ret = devm_of_mdiobus_register(dev, bus, mdio);
 
 out_put_node:
 	of_node_put(mdio);
-	return err;
+	return ret;
 }
 
 static int
@@ -997,7 +997,7 @@ qca8k_setup_mdio_bus(struct qca8k_priv *priv)
 	u32 internal_mdio_mask = 0, external_mdio_mask = 0, reg;
 	struct device_node *ports, *port;
 	phy_interface_t mode;
-	int err;
+	int ret;
 
 	ports = of_get_child_by_name(priv->dev->of_node, "ports");
 	if (!ports)
@@ -1007,11 +1007,11 @@ qca8k_setup_mdio_bus(struct qca8k_priv *priv)
 		return -EINVAL;
 
 	for_each_available_child_of_node(ports, port) {
-		err = of_property_read_u32(port, "reg", &reg);
-		if (err) {
+		ret = of_property_read_u32(port, "reg", &reg);
+		if (ret) {
 			of_node_put(port);
 			of_node_put(ports);
-			return err;
+			return ret;
 		}
 
 		if (!dsa_is_user_port(priv->ds, reg))
-- 
2.34.1


