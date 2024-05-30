Return-Path: <netdev+bounces-99467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B0F8D4FE3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1FADB23A13
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3370422F11;
	Thu, 30 May 2024 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pf8F+LkL"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F7D1CD24
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086835; cv=fail; b=ZbMny21I2j1xCc8Ihg/7nSICMpL5I/R4fSI44oDqpk+TBm3YpG1jWlhL3TwYbNEvKg7s/++Fm9X4xMVtT8uIRPui36KCdHO11Ksgr6vK3l6TwcWmMWLRZHY5+CZg4REom7T7VKJzfFoXGqkpY3EDjQuG6D912V1UAFe5Q36w+dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086835; c=relaxed/simple;
	bh=wWtlRTqG9GqAHJL8Q0xQuWr6nA7t5prlJ9Hb/zBLM1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sg0/QbTVvpaYRQbUPI/XymqEnxj6Txjjo1jLYh8o1YHpyGsAfZpPVbNLZXsOCPxHdtKTQkdxtwZJaEdO6SDrbfSAo961gm0l8qmezC4ztPDJcaF/FGg6/KYx/t2mT293Ql4kyn0vV71+YPc5f5PHGirC8COgYvrbJ/eMY3LCCJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pf8F+LkL; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hn2vk8Ha07FcStD0MBSfbBTJzIAqX/P0FXcqZuUvoXVQqG7pGuqDCZXbWDjOfyX0S6AmaFtzjm8NDyxoeqZ8hJjM8zLeyWzJGwocC9preFNJAn4xoTEqCA7jxcXmxiq7HSQXFIhhqgpoZaziP92PHey2/+FtCzRGoI8k/YBskIwD3uKmSA4dyv+nEtF6XZ4l/ymEy/0Jx8y9LU1trinX/oMKIA1Qm7I5F5oc6gZB9icPGbZohcrogAmOT4uiumMWIkT0LyAh4s49P6GO/W+GkSQU8RyGPr9ca38yYiA/MbpvpL8yO5svQRW/5RbVg6r2IBQKTuShmdGL1rS5J/N6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fArHhUaIGni4jJqgYTmB67JgRdNEWCmc1zs+y1v0EBo=;
 b=Z3XctduvvidwKgyrvAFT6RJnF8uQ2Jc50wbAZqZ86XQdTwRL93Qu60UZ7Fa3XKluRph2hi//oq2rn1eIbvuExJRmKoH7tf3rEHao2f+9ui/WorRaKHA3MNNuzk38VoAKnVbB6lNoQHGINl9LKBs9IhTNvEiYIsTwysUabx/H/D0TpNkE3R3xuyIITwq7WypR8/MTx/BZLaAxnysnANhgJs3tDHkKXfuDO/tZ5OQX144zxWk6APCFdDbV1oj+hNeSDnxsP+V+LM+8vSPszLbGGxTnKMRbj89eyM+CGyRdnQYWsxru1UxJOfxGPuq/LTN1gX2lcWzj6uEzMx9dfBSq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fArHhUaIGni4jJqgYTmB67JgRdNEWCmc1zs+y1v0EBo=;
 b=Pf8F+LkLxRd0fZRtzFgQ/jCwb9WFMsn1vYI6rhn5XideZvVUy8tA6HN7XMrk1089397vYpNPibgeTgTx/9y0G23cMMU61zn3kWStgj9WTlPYlg5hbZs0uNG5xCjOSyjzNQj2qUaJr2xWD07i+21V1hE/9p/I6mWZogDNfmXXzBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Thu, 30 May 2024 16:33:50 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 16:33:50 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next 1/8] net: dsa: ocelot: use devres in ocelot_ext_probe()
Date: Thu, 30 May 2024 19:33:26 +0300
Message-Id: <20240530163333.2458884-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::20) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|DU0PR04MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8ca45f-66a6-4e1d-f1a6-08dc80c6493c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9sIOI/pgC+lu5HH3W9rA8lFQ9a2b2YqBkaJ4IaPWDwdVkxoiH3pz7WL6N6Vp?=
 =?us-ascii?Q?sOof8At5gbboi+pnK01Vx3S4WjVux0qQxhP8/hvR1Gw/xfT9Nbqerl5OghiW?=
 =?us-ascii?Q?kPtpxjdDdyUjad0KwO95hbLFVhmjeVF+unc0lgAWlIjyF/W3Fg7mMCyo8U6G?=
 =?us-ascii?Q?b/ki3ZcCaPgpCxMQck4QfcU0t+jmmJdVuAx1cHbS+RlhnPpqMO3qV5lcovCV?=
 =?us-ascii?Q?jomvNilxNX0eiWlUqc0MHwtJc218/wuSe0sPZ6vUGcpExPOYTT+2jnt4iYZa?=
 =?us-ascii?Q?W/xwjj77cGub9t4nvrFjehg0s9Mpd9HNBKM1rdJMfzfMuRBt+/ijW2yGM1Mr?=
 =?us-ascii?Q?aQHn9TEoLI2UU5sHtYmJduOxz9RZHUB2G+VE8UCrDmPTXrHDjEBDqV2lkNMt?=
 =?us-ascii?Q?ZqggVD2RnqPP3bYGgOx9G/SNPuoNqa7w4JiA8mVka1olK3q77oEYJwAZHU/v?=
 =?us-ascii?Q?skNPVBCcw7gDkGnF9mPoYMsHHFQ6Y7w2HpYGi610au0+ea64SVYFwOCK1FQH?=
 =?us-ascii?Q?49GsKW2WKUnILz+apwuW/p64nH2b/R5t9gq5RWfGVTznV+KNOkBsYJAr2AFb?=
 =?us-ascii?Q?55i0OBeLm4inwC5gcAjx9MCeXJ0OARfGJT6nD2gn9P3AIOmhF361nDnUB1nB?=
 =?us-ascii?Q?yAqRrsev+cisRi/R3fjhBkROWWeXAu7aBgZ5JZcRdJULkY85SzsG0mQDNG1Y?=
 =?us-ascii?Q?t2JK5MXOdmXulU6OzztKs5UWRIjXP1VNhL4PS+QH/S/5nSqZO4TXbCYs9TMX?=
 =?us-ascii?Q?IfjYUgDck1B+u2N+B9RgNHoj9KiFrjUOrqJalllYRlEo7Qf9fs99INTpAgEK?=
 =?us-ascii?Q?jDCYgkw/orudYM3+fi9scK43eA9xKun7HiO8dXN+yyA8jaIjmejqstUWcgRU?=
 =?us-ascii?Q?Y0oAdKVqDSZ7C6VBFj80TmzA1Dm/LbrzqPeGdbs5pgzV8l9UsalZoN1xR5ln?=
 =?us-ascii?Q?KUJBKwv11lpJrMOSRUhhmGXUWmWnTwso0gGtyM+xpL0x2wdjsV95or+rQeCd?=
 =?us-ascii?Q?0v1ImPUMbhOM/gTRr1PQg0KFXU6Pt/nCjJOU0ZoVNQc2wiGEZ1dKCjgkwrQx?=
 =?us-ascii?Q?jWXSzRVj+u7YSNCXEi8Liwz82MvGMb/biMXQ3UN9o0vq9rtgK5awQeN9RkFA?=
 =?us-ascii?Q?EKo/gOh/JyjfQ/jsLM60pr53h5EiSNTDh7HIfov7spvbqsTpW/nstgmSi+9f?=
 =?us-ascii?Q?M345Wmmk9cCxjO72VuK9aDyn3bm/XK6RKi9kC2rY2SkUK1VmWkn5aFpDlCjT?=
 =?us-ascii?Q?ElRy1STu1DBaTTSOo8ERTsT02bWyBvUULmDC2vEZpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y8Il7fejdNsIdTOZtnytHUMNZmJ5pc9O7thIvuPw/vTdkM/H+/k8WXRaKy7t?=
 =?us-ascii?Q?Etf9wH7WfPtlg1B1O4xzNrsAffXuXIZAbTqQVWEGLznYVkDYhyFaxzmYE9eW?=
 =?us-ascii?Q?psQnbvZ7WIcvwyHhlOR1nApGERKgcma3HKOH+iAyDOIkp7KI8K6g1YG/0e9b?=
 =?us-ascii?Q?tFbuO7Jy+AGk8tzBljGxKut0VpxYtgnpvONLw8lAPpPUk5q0bQ04fsDqp52s?=
 =?us-ascii?Q?f8xPm62nBePftyU4nVNMpERCcGSFsnHT6RNzOu1En8m1XpieN6MRGvgV+Jtu?=
 =?us-ascii?Q?6VFGja0iHfZaan7euCSaEXFW+9Nf6tdEIPpmfWPnNsfvRdQ1Zs1sSUWilYRJ?=
 =?us-ascii?Q?DF8+3xPUvujShZ5roYgQFq05gJPCfmG3rI5GSDUHleAyIQoOpp95uWBtJ+hX?=
 =?us-ascii?Q?wxdcCyKVEtR25OBoT174d/OebnOUYJ+DrDAGryP7stDFKXuTWgoqHLNxJKlM?=
 =?us-ascii?Q?2v1SPf7thv7uNxEFW70VSUUk+gFixAUvuYdgQdfYNDeamxMlzd1cNKwEvRJ9?=
 =?us-ascii?Q?/pDD4TBhJeZ8NIq3J7CwrUpEZZgQC1g18gO/L/1bij4tEvjyg4Q1zHZCIPzr?=
 =?us-ascii?Q?KhjQIVRPFYZff6/I+Syzs221QXPw8baa9ym4B6fyhGwJoEkxO6hs+JkNyBbk?=
 =?us-ascii?Q?XEowGPBdjXT7f3bhHkJKkg8nsGmJlQUj7PTUb4MMcqt1uEPncTiDwf9fNajo?=
 =?us-ascii?Q?QD5NEZLHA4nnjE4mnoWsSCraFHePk1pqje5SsXJ1gihoHPtTLACgkKVxrd1B?=
 =?us-ascii?Q?KlyWmJIhivwQ4DJ4RE5zcfLkNN+hDNBrQlQWem1jlrPPGzaJmUBmHYYffypD?=
 =?us-ascii?Q?otWoWMr6pZKF3cZJo5ZIavY9BN+r+OmfgQ01+Ra1lms0fuDkuBcqS+dMzIqi?=
 =?us-ascii?Q?lF4OemFZwZ9SCOBrgWdQ5Dg1QVPg5UFyoLRYHMoWT0MJUXbMDUhq0w3fdW1h?=
 =?us-ascii?Q?Xopa9nJHmNk3vN/FAX//8KVYAXcunACHNrdl30S+lpI5Gd+5urwlXbVpSUIC?=
 =?us-ascii?Q?5Embttia1PG4kpCLlKoBarfXL6ysV4EyQ/PBwbr9JRYIudgxLd43B4AHft+S?=
 =?us-ascii?Q?2Gz9atsPi9wDp9tSp9DtANhAmnzhp11KIJaGwdR3ydGeniJ8wwvfPkANiUFp?=
 =?us-ascii?Q?q4o028phQbfvKSnjlOAxgx4B0TW1m070cQYxvef/vNNBWMnWLfMypHUPlCky?=
 =?us-ascii?Q?zzCqGo+YdkowhsTfcSE6hqsE3kdLEm05fS008txsHR+g9nVJsq48zzqF0K9c?=
 =?us-ascii?Q?AOCqeBA+Zh7D+ErsUGFH2UfvcF1pzi2uzn6q62y4SD6KR9fw56Ph9Fg6SQf9?=
 =?us-ascii?Q?0TFKuOZJLlA44YAx/HNNDDJHc8NtgAdBMdB+qPFUFrP4PX2OCQ8Ddt1VfRVm?=
 =?us-ascii?Q?XcEXbie0ZDLualRM2S0ajiW7LkQbFRHSDWpb0xb0Aooh3JblQKG+KJeYPLeH?=
 =?us-ascii?Q?ZJCNRo3XWm3SQNjw1bnrRk8x9C40MfQj0eq+kBB2d2ADMtRBqY2rogRKEGux?=
 =?us-ascii?Q?YOlfQr6W42dLW//K8XRB9zrI/yQoqrahjAdiuX97R6s/amlmbYCCnwrjFN1X?=
 =?us-ascii?Q?fopbADV39SFHlgzWekGcLuOC8iK5l2AGwssrU8qcMNVUz6I8AI6q8H3ec/Ow?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8ca45f-66a6-4e1d-f1a6-08dc80c6493c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:33:50.2303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEDuB6dPj8tMk3/C9iHcCTNcgo7M7kCibLz1s4LT7qLvTeq84u/hJvH+qBwtKft2LmojfQk+EjjXMcNsiORsfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

Russell King suggested that felix_vsc9959, seville_vsc9953 and
ocelot_ext have a large portion of duplicated init and teardown code,
which could be made common [1]. The teardown code could even be
simplified away if we made use of devres, something which is used here
and there in the felix driver, just not very consistently.

[1] https://lore.kernel.org/all/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk/

Prepare the ground in the ocelot_ext driver, by allocating the data
structures using devres and deleting the kfree() calls. This also
deletes the "Failed to allocate ..." message, since memory allocation
errors are extremely loud anyway, and it's hard to miss them.

Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/ocelot_ext.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/ocelot/ocelot_ext.c b/drivers/net/dsa/ocelot/ocelot_ext.c
index a8927dc7aca4..c893f3ee238b 100644
--- a/drivers/net/dsa/ocelot/ocelot_ext.c
+++ b/drivers/net/dsa/ocelot/ocelot_ext.c
@@ -71,7 +71,7 @@ static int ocelot_ext_probe(struct platform_device *pdev)
 	struct felix *felix;
 	int err;
 
-	felix = kzalloc(sizeof(*felix), GFP_KERNEL);
+	felix = devm_kzalloc(dev, sizeof(*felix), GFP_KERNEL);
 	if (!felix)
 		return -ENOMEM;
 
@@ -84,12 +84,9 @@ static int ocelot_ext_probe(struct platform_device *pdev)
 
 	felix->info = &vsc7512_info;
 
-	ds = kzalloc(sizeof(*ds), GFP_KERNEL);
-	if (!ds) {
-		err = -ENOMEM;
-		dev_err_probe(dev, err, "Failed to allocate DSA switch\n");
-		goto err_free_felix;
-	}
+	ds = devm_kzalloc(dev, sizeof(*ds), GFP_KERNEL);
+	if (!ds)
+		return -ENOMEM;
 
 	ds->dev = dev;
 	ds->num_ports = felix->info->num_ports;
@@ -102,17 +99,9 @@ static int ocelot_ext_probe(struct platform_device *pdev)
 	felix->tag_proto = DSA_TAG_PROTO_OCELOT;
 
 	err = dsa_register_switch(ds);
-	if (err) {
+	if (err)
 		dev_err_probe(dev, err, "Failed to register DSA switch\n");
-		goto err_free_ds;
-	}
-
-	return 0;
 
-err_free_ds:
-	kfree(ds);
-err_free_felix:
-	kfree(felix);
 	return err;
 }
 
@@ -124,9 +113,6 @@ static void ocelot_ext_remove(struct platform_device *pdev)
 		return;
 
 	dsa_unregister_switch(felix->ds);
-
-	kfree(felix->ds);
-	kfree(felix);
 }
 
 static void ocelot_ext_shutdown(struct platform_device *pdev)
-- 
2.34.1


