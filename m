Return-Path: <netdev+bounces-61539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E355F82433A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871762867D8
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB3E22EF8;
	Thu,  4 Jan 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kdA3C/sT"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF9225D3
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLfx9bo8aakmkXHDwbSGLdK7zpcY0ljRpFhKhxtIqG4ucb6JSXU+XTYcKE8zqQU/Eco98GdmB9O7/mCdLOPdYd9qrEPDnisfy3lC6iPX+KTxio1S+lBLYKdv4Q58dfEnNHg3wGZcq8G9wwzL/ekNd4QcU5Kqk6TGfo3SLrC/Mf2qcCXtSb2wpzP5tf9Rk6wstgvgiKIRTOkSu4iFPpcQIt/7PkVQAprixDRu2C7tNK+froEOwWn8utE8EfbY69n4XPVbXQM4iacG+Flb7cRgB0ND1fHfHhy/nJXnUn0SFHgkEcq0EHOgKXkUgEmwNrChK2Mq/OzHXUhZmR3+1yZV/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arHWusFAC8VRAneVBfah6QXECy+7pGPkT6gNclO/gk0=;
 b=YOiiIaqpCuR6ZZ+0uV9Gy85TOx/SGmXtNZy6eiWxzrP5jaUiFuuz1lGhJMQd6KxX8Ag0PzutVyfTeMhB+/Eiyx3W9CsG0oBD9mIOhOd8te8CCO4bFbsu+ip2VdJ6gJGB+UrDG9LqbqePYtAIpPVK6F9VeExmWjjNhBXUt15cwRFIEfgQ7g63hPKxb68Nj56BXSRgiW3QXhLhJbuFT0927E3/b0O2/lLt6GsYYR3FIk3n+PCKpfvlseUOjrbDUH47amPUFducbZNetaDfLz4fzhR/UAIecieCenZZ0mZKkaBqJgV7UdOVOJy12DD5EyRhWuspgQWUQoWTwCiajrTlgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arHWusFAC8VRAneVBfah6QXECy+7pGPkT6gNclO/gk0=;
 b=kdA3C/sTK2sAL+j4DS1tLTlzsLBg/ytnVm6ESiZryKUjOY4ezrk/PzVYdu8VzFRjtVFrrzx9k9bA9K21YOBjH0XaF3gKttzt0CfjaNVuUd05BcMvkOUORyCnWwAdsnmN9BStixGiFkrHIAdliOxqGRhKpP1Tw8U7Jx2u5fgEXeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AS8PR04MB8579.eurprd04.prod.outlook.com (2603:10a6:20b:426::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 14:01:20 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 14:01:20 +0000
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
Subject: [PATCH net-next 09/10] net: dsa: bcm_sf2: stop assigning an OF node to the ds->user_mii_bus
Date: Thu,  4 Jan 2024 16:00:36 +0200
Message-Id: <20240104140037.374166-10-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 87d1c76c-f153-4f13-c471-08dc0d2da0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vGIi+RyBvPHTQNGWf+sRB7fFmymK8ZIGns94kRl4nxFf5IQlhIJR3lO7c6NGfzf6AeBqzujE/a+NkIvltJHF05CwCOMzeNbgsW5l4tPeOURV3irbtRRoRx3wnt0AqGA6IZokg5i4RaooSpL4aOJT70MIcaCOirS71tjdlq+lSS/BfjDRzmup3f5XSFBsAeudEYvAsNHcR6D8Ag1JxVTB9bl5G80qlka4Uk/pDFXY/nGODLyi5zOYHXHM7CbK+/0Kkm0SCaljDhriiHC+QeNLhwBeLQsllpeU+x553ZknEvFz+Ar8a+52/TWVlUGANIJvgyBSaFYg6r8vr40WK/2ePsev/SZSAB5AyOFDz9SRPBbBZiu4iS44csvgxWvCJO1rJTkV1HkKw3CG/755mT8uFsfeXWn4v+rDBpST9gu2yS/M9HZFq50hn59NIgNsTRWb89n2ekiSBzBy0PO6eOAijzhb8/W3fZm7B5yi/8sV4s96IWo8Fh4KFuXFd9acC1oFBtlosyj2GZEtHTM8Cnc1hCLrYIc1WbC9+G7sYGdBeW0ILxIEbkao6Wg+NMOOhohubPthZir3+9uW1HcEwueMK7STYKY++CisfsIciRn9Ufl0iHYxwPBxEP+wKLa6Lzfm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(52116002)(26005)(1076003)(2616005)(478600001)(6506007)(6486002)(6512007)(83380400001)(41300700001)(7416002)(2906002)(66476007)(66556008)(66946007)(6916009)(316002)(54906003)(4326008)(44832011)(8676002)(8936002)(5660300002)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KKwhqxFX5IQkXPagez5HktMyc4Xi1izmvli4CBBT8M0Xh1GJE67+5cCTN+Il?=
 =?us-ascii?Q?NfqmNf0I2bSaS+yzTDNwS/M7aIPCeqyOGaRtv+p7UH/n/5Wf2oxWXIJQ2wx7?=
 =?us-ascii?Q?EFYl+3EPu12NqDsOek5bXNHjAeCofoiiik165RN7vzXoLeUSRSWV37kotykw?=
 =?us-ascii?Q?CdlyVgds0XBUZEwxVQAQK6RaJ3CNVBRNFFODbZqbdqt2k/RGRvQ9Ao3xlv8z?=
 =?us-ascii?Q?5i7KdanE+QXrAUSZidTckTDIxxfHr5gFf1/ebvF6zs5/373SyGlDqLX5rI0P?=
 =?us-ascii?Q?XYALNLhSuLNViDu9IN59VQwlimsO1LHayXxjQUU0wFMmMSBnYgrxkQQkicfu?=
 =?us-ascii?Q?ow/+RJw/z9kHgLfLMSrsIpAYXuV8sB5ZzABeWl+18fn4CdgfxsqEorueu4GV?=
 =?us-ascii?Q?ZpMpKYXp+seeZakbgNAsRvTZEot98ji80VswE9s9TU6ZdGZCM0hEFbOgVbSd?=
 =?us-ascii?Q?C7npE27Oo+JVFP2PWsYis8JUY6xEKUo+DS8LhHY6/vkrwuDTWze/yqVJRnbU?=
 =?us-ascii?Q?ETicFMB4cTyoZIyPZ/dLaVwFfhWRwJX89MW4OwDhT3yaL6OGHX8CLwWni90H?=
 =?us-ascii?Q?ARorc2227rhUwF6nvTZKHxco7s8vq6aDtSerUf8wtwzDFsbG3SPDRvcbt53E?=
 =?us-ascii?Q?V7wO6BaLh8MdMeRqHwDNRUre7UWGEYf+RpQc8dr+wuYzwy2jPb7CCywOqS1i?=
 =?us-ascii?Q?wtAI64tfNYY78HvL/cZeNmw+GwjyY2C6tkymh+wvZOpWJiHLXKmoFgzc7C0L?=
 =?us-ascii?Q?qKLJGUP1kh4t8ksLHuYSF1nvDvTA21vZTyJzDO0JgUzmU96BUnSUywFlT/X4?=
 =?us-ascii?Q?msXbNI7EpYsSptsrjori4iH8QWRq/B11plxNhjypkhPkjoSGcIXxkEtBx9hl?=
 =?us-ascii?Q?r2YCINglz8D5LM0/4TNQceNJ6BHE3FWaKxUpe1ezJia4A4SudvZo8+ZRvr3r?=
 =?us-ascii?Q?SsZMyxzZUGIY2URx3C1zK/9LFS3PHukDy79sLq9RVqFIf7Uf5Hb3Tk96ASRs?=
 =?us-ascii?Q?1DE2xE8HHAy5rkfyHbqFgFBqCF5mJHkiMTBW7wAdyESBeGjkqE73heWx2uqq?=
 =?us-ascii?Q?5DmShXlnpvO+ecXkz+DoIAvTL1/MJ6yqL6Ys6Rq+/5onMYVmbc3GCrHZO3+g?=
 =?us-ascii?Q?3cd1hZYfJZGRe8sYGRcy0B1brtvOVfuO78dOkQloUT/aC9/UFieKw9ZuyyEE?=
 =?us-ascii?Q?Oa6GA0UFNpm7S4hQRhmT76eKpaAqTDtkqZHOR5xxwQM5Yceby2QyuMs71MYL?=
 =?us-ascii?Q?9clKiLSPZTiQFEkNlAdTXNkOYY0QafVDYm5dmrwC30lJCh3dCUPHj1CULpd1?=
 =?us-ascii?Q?Pr4nhGNBUOeLPAF5qRTMDXbLyukO36y+Xxk/3VEhHXof7ScmouRNWS5QTnz+?=
 =?us-ascii?Q?ESTW6EuQM6w8UYtgS9fgviW/0ZI678a2W98QFxtTFAynHl4TgtNtR523URPC?=
 =?us-ascii?Q?udnO/UJBFNSEoUgl/G5AvkKsdc+I51Zjq9YB55D/ypHIQbKMzfnSH5dbHAHC?=
 =?us-ascii?Q?2i025f5YNVf7mX2p9bkV9lyReiY0GwiGHLnUMzT1kVprtV6kkntAPFkFWXPr?=
 =?us-ascii?Q?3OsR9K7AiRPwKxXbM4repl1g2exVFHpIF1LLGvj9DDGbGMtQpU46wT6xTCXG?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d1c76c-f153-4f13-c471-08dc0d2da0be
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:01:20.2947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxtDXckbYNnJV5NhYdWKHqSFwe4J2chlHh8miZSwuKZDh7QzID8pUE8oxofSdXfmzjp3r9yJSRm9NALOw8SlXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8579

The bcm_sf2 driver does something strange. Instead of calling
of_mdiobus_register() with an OF node argument, it manually assigns the
bus->dev->of_node and then calls the non-OF mdiobus_register(). This
circumvents some code from __of_mdiobus_register() from running, which
sets the auto-scan mask, parses some device tree properties, etc.

I'm going to go out on a limb and say that the OF node isn't, in fact,
needed at all, and can be removed. The MDIO diversion as initially
implemented in commit 461cd1b03e32 ("net: dsa: bcm_sf2: Register our
slave MDIO bus") looked quite different than it is now, after commit
771089c2a485 ("net: dsa: bcm_sf2: Ensure that MDIO diversion is used").
Initially, it made sense, as bcm_sf2 was registering another set of
driver ops for the "brcm,unimac-mdio" OF node. But now, it deletes all
phandles, which makes "phy-handle"s unable to find PHYs, which means
that it always goes through the OF-unaware dsa_user_phy_connect().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/bcm_sf2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index cadee5505c29..19b325fa5a27 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -635,7 +635,6 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 	priv->user_mii_bus->write = bcm_sf2_sw_mdio_write;
 	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "sf2-%d",
 		 index++);
-	priv->user_mii_bus->dev.of_node = dn;
 
 	/* Include the pseudo-PHY address to divert reads towards our
 	 * workaround. This is only required for 7445D0, since 7445E0
-- 
2.34.1


