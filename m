Return-Path: <netdev+bounces-68587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49987847509
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B411F2C6B4
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69066148301;
	Fri,  2 Feb 2024 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DaxKlj5B"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8D77C6E9
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891931; cv=fail; b=EkXPlMjtSeT1HgLObTUXKulafZNWf5wLsdsqV1fjT0Ncs+ng9XxGDb3XmoyI4//LgwSqYvr0fjO5lJ8MNEzTlDm9Wl88qmLIRzBji/ZuoL8sc26HJ6riDzVBP1FJquCocvuY84xqqAhEm1FPURlSq2PNBvl0EV+kSEMomPIAYtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891931; c=relaxed/simple;
	bh=8w4L5iRUwy9daFHuKz/kbsHfPNUdUlpcMdTeH01/NNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EyBlMKz/hlbHeV1UDzgq+a5MMzy51waoNutqQii6Rc9uYnFat72vhcNri3FiEKUNFjVyAwt1plqcuvFiQyoSWjDK6geR4qLQ7lI7H7pMeAFrTjLSTggfpTRqZcp5ck1hbcSYAaKPQSB4hQUTqMxdlHFC9nx8MyQVEOGipfvIt+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DaxKlj5B; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y22Diez8dgvyzLABGV/O3rjKNQISc9fMWQWpg1J8kKKt1cv5ZWdq6k/S5gpWqmL9LnOSsZSzbdYf03WQ6b1My9yT0Ks/hLlCIjgk/FPdcGjadmSmy/b/ROD5staZaQV0g5XYiVUqoY33z3Ts4v09v38bqDMcfdRWlMqAyxbhRSXKw5QO0JMcLw/p4NeEG/jEwphhhkrjOiYbzZxLSzEQ73TLOQA9dep81NaKnckWxAPwR+kqi9ijAtYaVBsxUc1bs0OHFJ3pMINsfvAnxm9jUPELOCsidYK/n+A7KLaYAGViAWtCWRWa6k7D32TdR51HjpVN7dW5D7SxDXHAWlRbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtDBDFi8u+XxQA+VOclNg3nBYwnvpdBo08Vq4t2QZT4=;
 b=czYWgbYqaNMbdDbH1KKDvemKvyPn0kIAITLA0LfvLVA5PIMeKZuu1XPNVueDJFGbIdL24P+88OfvXpDef654mZULUfXqT7EG6xBS+kRdVkVs/MIDnBULHk6/xeLRlRLNkA0yoanp/ZFHbW2nxtqbdOocatxevHYVJwasOo5tPbDx5X7xYQRTyEuZQe4unFzEa9woHdsbb783pEHNxp6MKYNXbgnKbHyGYpaVU74+AcBWENA3KaksUbPjoNRI4S08c5UapwP5/TwrKnPGHOLHX0yUhnakUIwETUc4Eum6SHEbGQy+HKBH5OuaHRH3TDMCFRtfODH9BupBwqJ5aUsJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtDBDFi8u+XxQA+VOclNg3nBYwnvpdBo08Vq4t2QZT4=;
 b=DaxKlj5BDuUpy6SqMgQRwSlwGORoRCgVU3HWOnFEpmbFQS+NI0NC60EOY4NrAEQdSd4NhjcILZAvD794Vp087RFdBUs2fgw5/kaZjt2oTSgKHvkrIl+aqnGhtpTnEFmGEbYS9KISRuAfmrCQZVYa+6i1bvxIjAyETbe0Vgt0GXM=
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
	Christian Marangi <ansuelsmth@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next 1/2] net: dsa: qca8k: put MDIO controller OF node if unavailable
Date: Fri,  2 Feb 2024 18:36:25 +0200
Message-Id: <20240202163626.2375079-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202163626.2375079-1-vladimir.oltean@nxp.com>
References: <20240202163626.2375079-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-MS-Office365-Filtering-Correlation-Id: 7c0fcb37-1b3c-44c8-1da0-08dc240d6c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xof4HboFt+pyCNM21zjdRKVwUrAOHBV5vjXwPeamLfBLp44GwrebJiE3AUoS3rA6Zw5Aho21ZQ9xajdnG3jD77Fpw+rcclG3VKPV6IqsZZKA4sP1ltg3Arzo1x+Tav6nhk/LhgEuSLDYUqIRRp5wHIjR1vP43b7BYXVSYgnle1ejzmcRzXRpqudmhSJUIqgpymOKkEdI+Mg6P8e7TTQFYvTOitj8OfwVlHBroGm99lN/n93b9Bm/84nzkmk26m0NHFw+i6mnnUDZVejVDSfs042iyJ09zI9Bx7DXdEnpUsL+Zugm2yKo4+oQFdiQVLeIhfprpm+iIb6RHqOFsVmiWSVd5N6OfLNI6QdgSqngGy6QVaOqaW19CPtq9QnZBpWBplZwoc/kIQdg/jKqrDfn8iVz1tYyqb/HOnve31b+zJpYR3bzw1aM+SyF1O2uvNjUay8xJtfhmF6GVEZ/Tju2Wtcv/EbtU94jiFLUnTfplcFbygFa0ujGaGpWEIDMa7md9WavpcjzBL+Pa7AyLT2Gh+t+ARouveqZEIl7/YTbQBUO4+UwfEDH2Xwg8lJ8A5W0jQz6VzfpC2h03BTeBpFH6zBNrTxpIEZla9YuriaAu05ZGw/vijf4rLRudYiTjDTC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(2616005)(6512007)(38100700002)(4326008)(26005)(8936002)(2906002)(1076003)(5660300002)(7416002)(6916009)(966005)(66556008)(6506007)(66476007)(66946007)(44832011)(54906003)(478600001)(6666004)(52116002)(6486002)(8676002)(316002)(38350700005)(36756003)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N+C29rRUjXwSsK4pJSSUT7o1VuUIFZsypCDOt/okna3o2TQpzECEuEhsNWC6?=
 =?us-ascii?Q?WBsIQcokD7K/qHNTQEKE5qY7dr2dlKpcb55PRfD8lJTkMQMozV5JiAWmI3KW?=
 =?us-ascii?Q?JggNtMBz+x5bRnFx0SS7vkSPSaIjBgi9aw3pVvOaZAIkozTdfJRr83TYlX3N?=
 =?us-ascii?Q?zw+xs8BBRiwTJaska/tmWaxfXnh8YvyriRrR1mbHZdj+TsCG2PrNCUcvtjhl?=
 =?us-ascii?Q?kH01jdW+SKOaxYBGETURrcUNR0fmRirCMCzh7I/gE5ZNuCs/xfMOm9jxAkQs?=
 =?us-ascii?Q?oB9oeNhjfDpAZ/B+gObTmu4RZ8lqEXjxIIRWtTm5YCVD/H7f8K9zuTd7gfQz?=
 =?us-ascii?Q?wjfeG86VJ2sSgIhz2QhFsf/RJAx+T9K9dHUzMz5poOZd9AdD9Utwb6M4uQwP?=
 =?us-ascii?Q?mUI/4O6BWG9P7ETMzQ+WM1dYC7qDFD41BJJM9yKn7SaEaLHqNlzHZ1wNadUo?=
 =?us-ascii?Q?cjR9wAuHeY7LLe7GP2Hzb/osgTMQzdfdHrMjIukiy6zhy8xhjXcC9/LtyRx1?=
 =?us-ascii?Q?tyUn1JYEUHH+AMU+KVtp1zkyPGwmzyzghdwhUExH17mmjuPxOzFQ7/x7e9YH?=
 =?us-ascii?Q?xvv4gQzSPtdHkh7RRGtM66miDZyX4/OzYo+jWFlKJKcxRKvmH5KyoNKJv8NO?=
 =?us-ascii?Q?BsLpIh5OwhCyCUh1yW5p+JXcLLAbDibbqcy8T48/UXK+kUepWLvLgXV5zCJE?=
 =?us-ascii?Q?6smoAv5J0K22v1EgsiUUncVh1ITRI0LfHuUBTPomjJh4ZMBtP4UdoBscw82G?=
 =?us-ascii?Q?9K3kxe6rLrhBdIcDFPecUKjO0FvAT3jkxBesvhQ4XpFVNQavD8McABDNGMAy?=
 =?us-ascii?Q?lYl2TEFq9B9UZAck/YlGmdHeJzgOYFpvhzTIXE/s4AoYwgsUJDo+fb6EGiod?=
 =?us-ascii?Q?2SremWc/0Pz4bn6qglj2V1raW0Udv/9uAEKOBCko7jlY9+uckP37UnaQ0Smh?=
 =?us-ascii?Q?LY0GahNDQhj5Q2Cvh5deXitMukFOhlp2xpSGmshX3R3Cxki55FQ2d5ju8vDx?=
 =?us-ascii?Q?vXlRQ8ZiaSKZBdVH0G/7lVIiuF9FJSFipwpmhoNv/9wsA1p3+wUJa6NCoaF+?=
 =?us-ascii?Q?6XAbKOEX2b7mRuwasfWLsQfxIZEiYCAfiwNgvtTWwvEIKQKGi7jWhz6snJi4?=
 =?us-ascii?Q?e9h0MbzqwWTy629QUFX0gbctNRYMixLSYEsajUU/oiHHg6x8EpXgwEhr5MyT?=
 =?us-ascii?Q?1xxdBd6GVzJv4kz16scXfpuFmD8Q2kmU7R8Tf+7LUm9GpF17sbdbrRvHqVgT?=
 =?us-ascii?Q?cEel6v8ZGl6Xuf6ihhjwJ2sSszQ6p+8ttaE02OppD+zeVSC/5NHr3vXcm+1S?=
 =?us-ascii?Q?yHRSzWQ5F0Ay+I1VjFgNxWqTebk5siqNlmZYDOHlxVf8FHRqmyqF0u/T81hi?=
 =?us-ascii?Q?Dw/9A/kAtR9ZxWc1KbHmBpLWGIft7XeWLHS3pklmshovUoKQsspFuNQhOj9o?=
 =?us-ascii?Q?g7734bGpuuWU70fOmWCeJLePPDozpPkWJaBcLV43jbDPhPWVfxabEL9jjyKQ?=
 =?us-ascii?Q?WhV4v5qFX/AYvsSpdDdcaJowIRzYWfQ5IeEo+s+HwmY5SlfHPlPAHGsckt/W?=
 =?us-ascii?Q?NZ1MlnXhtTVRzW93k5I2WWEaQdqXdrUnCLBTttm7Voa0SqWRRJ8Hv/qf0gu+?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0fcb37-1b3c-44c8-1da0-08dc240d6c81
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 16:38:45.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adVF1TEP4weGEQSN9WmjAX/k1bC/r5uvyJ+/GCAD4cpotHSpzoC2eycqsyTjMGTJwe8VWwPuu3zJcUItrWhROw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9974

It was pointed out during the review [1] of commit e66bf63a7f67 ("net:
dsa: qca8k: skip MDIO bus creation if its OF node has status =
"disabled"") that we now leak a reference to the "mdio" OF node if it is
disabled.

This is only a concern when using dynamic OF as far as I can tell (like
probing on an overlay), since OF nodes are never freed in the regular
case. Additionally, I'm unaware of any actual device trees (in
production or elsewhere) which have status = "disabled" for the MDIO OF
node. So handling this as a simple enhancement.

[1] https://lore.kernel.org/netdev/CAJq09z4--Ug+3FAmp=EimQ8HTQYOWOuVon-PUMGB5a1N=RPv4g@mail.gmail.com/

Suggested-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 7a864329cb72..95d78b3181d1 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -954,7 +954,7 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 
 	mdio = of_get_child_by_name(dev->of_node, "mdio");
 	if (mdio && !of_device_is_available(mdio))
-		goto out;
+		goto out_put_node;
 
 	bus = devm_mdiobus_alloc(dev);
 	if (!bus) {
@@ -988,7 +988,6 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 
 out_put_node:
 	of_node_put(mdio);
-out:
 	return err;
 }
 
-- 
2.34.1


