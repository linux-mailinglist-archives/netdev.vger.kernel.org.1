Return-Path: <netdev+bounces-99470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4D38D4FE6
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788B9282D85
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA20200C7;
	Thu, 30 May 2024 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gJATBTB2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5957E2E84E
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086841; cv=fail; b=t6o1+3KpiLPN9AOYD0Z2YSnlmG0K/us02BBzFXG4uIDhu2T2qBC/9/TXo4vs0Sdstuo+INTRSYyr7WgcZZGbwBI6Ho28QiNWAOgoWMsLgkuhj6nXipN+vpKwp10KogYIwa2pi++Rb+8RUbgTeWA/0HGYXlEVgKWC5kweUf0UJWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086841; c=relaxed/simple;
	bh=NxF07vw4znJ4Chkr8u5M/U0U8uan7AdWtpebuoeoU58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qRhQaegvJVVh+3c/0TrEiKTLicjizXa5Bc94jnUfYzU+GpSJVZX41gelPjT4ea/h2K4JQw5HRT6fMmPKaChg0zFVksDiw6bIBicW9WGp7/GAK3DDdxI/cqt958zdv1n9QtURbVT3UA747oXFUb29Xw6unTcFOiCEX+tBiF4gBRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gJATBTB2; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nySjtPpGljKPx9PW9pkJjl2oQAdxz7oehEYLJfUdqh4oSehShlYM++oQjLiutGZB2O1XPW8EHk3jW1CifQ/USxdJOO7jqiYjYIcc5Ttoe/n3nHCEfSw4xkBt8p+UeLhMAMS8ghrL/3LF1Q7h2B4yeJS8vEMwq1VNYemWgAHizYHkURdEDkmEEXwH8JPlODTKsD9b9AJaRoLUPiVCophE+jXS/jCJIN9zxwXPuTLrX5ScZ/SgCLOHm7W6fxA6enf3kceipl2VCPX5L1bq6PsRX4+FEa33KLyOFfWDiYC7IFPgfcaOuCYEyBUC9TaGuzanTRyp/bRFH8R9jVMsX3KtDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqKEQyl309wcqmoovZloPdl+QZBS5j/r0ULZM8v4XZ4=;
 b=KIOFmTqTN5OjxaWz1AVeMfRn3MSm8WB+Fx3be6NhAFRkf0RciB3syRpdULi7hVbVTnsik9AaI3GsTwhhbC8IQJNv0KOgRKxiMSanv6GPsymGxatmYycTTDq75siqZCA6atso0tiN/HcvIdj8aPxn9ldn5/0KtnfY1NPJKDnWopIjKFBbEgGvXOkFjsRrxCk1iJ/O8S/MRDmVJ4+5KrYYBKt9C8+rpR9pj2nzxPY/hSlhM3uEryjGUY+DZfpKbcNvKIN3WENjfwBoOziUMZWV4jl5o8+gPtt+o+Bmume6KJJeTAk9jMEPTgXwycsq49VGOKoZ0a6ipJQYfwxL8KHTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqKEQyl309wcqmoovZloPdl+QZBS5j/r0ULZM8v4XZ4=;
 b=gJATBTB2tmxP4Sw2g0m1jQddmphXsta6hViiwhDbfyL4Fl8DCDyW40uhrCfOcrDuWwZsnungBoh3NqMGn1TLhytacIjEg5ZdAhTsLwwoRCPqebBlCHLRxCrNlbjRCX+oP9GDfgIhCQPQGHzNfSQXV8YmPZxdGZihqsvVftTFdKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Thu, 30 May 2024 16:33:53 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 16:33:53 +0000
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
Subject: [PATCH net-next 4/8] net: dsa: ocelot: consistently use devres in felix_pci_probe()
Date: Thu, 30 May 2024 19:33:29 +0300
Message-Id: <20240530163333.2458884-5-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0cc231a6-e496-4fb3-a892-08dc80c64b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UkNJlV2hT60eFp3TzLToW0aJtQGbQGD5jFOjfRhR/ZF4CXSdCCKj88sLDAGZ?=
 =?us-ascii?Q?rYaTC9vw3emcaGlvNAT41GnICn+51nWVLHzNWxM70adXamBTRIuyufijl5gJ?=
 =?us-ascii?Q?fa+ctn1B8REkr291fEVX9lnSq0/pGNF9w+hcPMNkrDwYBEhd9QJxmymT2ADo?=
 =?us-ascii?Q?qFPoyj/Vb4acLFBgOqbdBWwsY7jY03Aaq2lJfANRlAvDc1k6AV0FuGbDLUDb?=
 =?us-ascii?Q?wFgW0wV36z9W3Ze0L27y6cF4LBGNknjbvBbMtw+DaNGx17fxU0ltmw1wrcv0?=
 =?us-ascii?Q?UDjcEP7vub1QUwzS1Qz7Lnr7+LbbZT2QHrfeXboW4AxzaaipFTO6w4cy4NE0?=
 =?us-ascii?Q?Z4s/m/Fmo/Xd0ZKBKCBztrSl4CUY4H4RGZropyzSpEIsO73scV4h2dvLXt7j?=
 =?us-ascii?Q?J2IVd1jToczDQA9T0tSVa3tA4wuXeoBV4Lhg6NLGPZOWYsLc2bO953JQ28J5?=
 =?us-ascii?Q?kR21N8icEI9RPwD7KEG7PaJXQOQS71Fln8hk1doaIOEOEcPbPyjuKfq8MUZ8?=
 =?us-ascii?Q?+yB/cdNk+4eWkiEj/3MjrZhZOXekX2t+D7wdJjaMFT/QQeWajltMMj3mldGs?=
 =?us-ascii?Q?O7ArGIYveApRi98sgLtnSt8xzj9wrqHQAwBM7M9MSC8De2pkLN3J1+nfraY8?=
 =?us-ascii?Q?0LNQqqBJ7Vojw0TCkXed1ElnaQEkwDCTnhony6AQxsA4YI3lyJgx5R2S8Jqw?=
 =?us-ascii?Q?Kb97geLk0OeCQHIJMkU3nmF6T+ftifLktp90LMTuehiK83SDD9Q6MoZ0ALBO?=
 =?us-ascii?Q?UlxHvS1dd5hT6dzOfDXuUkIWxFWU9fB1X0b/aFyxd5XfFrsGF0GyyslmN+V5?=
 =?us-ascii?Q?QoFrxG28loSI7kHm+QtXZyGmJYSaohiWNhn94tw9Sb583VfcVoupv2HMK5Sc?=
 =?us-ascii?Q?hiOsuz1a4XFP2X388R2KVI5nqIdqOmFnRsKwyW6l6xewC1q1ENDIiYHsXdc/?=
 =?us-ascii?Q?tgaSxxh1+CLcHGXWWx+Fmp89tVSTK4d/qhfBYSYZdzxJa6r3trooB2+SNRV8?=
 =?us-ascii?Q?HVuIA37b1JhVtdQZ0JnXt1uO9gvlzrf4+h8QK/Lh5ZW4Rm2DYzpmKidWwFr7?=
 =?us-ascii?Q?kMrfXbaMSwQzRqQhu9x+MiqTyavVUj9AzesLGwuk2hBHcXll+3iw+XYW7ia+?=
 =?us-ascii?Q?BiDKYUfn1ntPSLX90VKoXxgXg0mS2rYbnEV02AgXvHxF0A1/wXKcxXd2/081?=
 =?us-ascii?Q?ZjWY6vLvWkcWnt4YqLmgUZA8ZnSEA+s8gUxeu5QmJWdg/ZcfUsKOwzsKJO3y?=
 =?us-ascii?Q?sdp7+OGqLL6lT/4vIyXRKj5FYxb1o8myDhaInmf5pQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2OeFGNC+Q2++EAMzmErXZGWlBFr7aaVeK5aBdHozQZ+ztAs3atcigH6QHj46?=
 =?us-ascii?Q?NxGsrTRaRhYJCkHaXCCDihc2sHORfBCI+xXTWnLPiVYE1KNh25wXUy9Skhyc?=
 =?us-ascii?Q?yva0sNX1Ir2y7XLX24N4KiZQfw3u2jNApmBvELg4Ll7k4YeSmBHfDyP3QGh0?=
 =?us-ascii?Q?IpgZAieYI1nefAtJbrTWpaCHfpP88Wh5D2TtO01CSpMA3xFG+FmvechKPLS7?=
 =?us-ascii?Q?+dIC0MoOIZdE3Qwo8nSxxYYMfdwBgfaTvpcUJNeHt1am1iSe9v4H1NC0ePrQ?=
 =?us-ascii?Q?yyKw1srETvNT5R0tJHh3INjxlbihI3YE69rGYaYhBnJSsHDX4H+8or9PRdMm?=
 =?us-ascii?Q?5dlCh/t3ofHXxccuvaOe2bShOclftcHs6Q5aMeRcDd5SNkbtmoTzdNsC29JG?=
 =?us-ascii?Q?lLU3JRtYLrZGrIBY/OHM7fBYHKQdvp7M2wnl+3+uul8gwg50cZ/3U3Aj/3f6?=
 =?us-ascii?Q?Gm01fn7FfYBl8BmO89yiKasQq/Z3kqD+w0gupp8YF9+bqASZQUsn1gQ0wjz8?=
 =?us-ascii?Q?OE5PJTOAL/64qxlX+FB8FcpgRJ/SwhPgor6FWP5OHOTU8EAg0qJ8je6web8d?=
 =?us-ascii?Q?Epwiu3f0pPh4+OhnzgsBHLnDfPw07Aet3BAM4/61rM2LVk0Z8iPjHNtXkHNO?=
 =?us-ascii?Q?ZRcCGr5kmUrZwevBexUwFbqjTuEL9eyfaf79TcmqOL8HCsyajCIF8X3mR6nr?=
 =?us-ascii?Q?9qKxyIKDzdlr28i2Wdww18owFry5Hce75OWhRo9u3X4u2uLs/aSNkzF5MVsL?=
 =?us-ascii?Q?IAtpn0AOtmCPgSkfQp11CB8tqnCKa9aJk5ItLa9kftvusd6gkxTGCulI6+Rq?=
 =?us-ascii?Q?A3SKgO1sgAElh8utdzfCZM7sDcT7biBLiENTguQjHKDbRc6nF6Q7UKytfJBi?=
 =?us-ascii?Q?OoUs+lJuZqtmIZuKuftGU6e+PJWQQQBPp8o3iLRJkTjqF4IVpVuxrCrAEG75?=
 =?us-ascii?Q?J6aMFWKuKbiPBYlinRLfadju6qy1RXp1rzMcUK+y1CE8nBksjbtcYLiuBRKu?=
 =?us-ascii?Q?GcRfqURgpZ/XPp3U2aHOgHJgIkNZxGF7BYOolygpgu7sWjsKhHhKA5s2BZxL?=
 =?us-ascii?Q?i04DWeghsG+hbvPUrdWbaOam7A6OOokIW3j5QyOGizRm+XykOIj9At45oBpD?=
 =?us-ascii?Q?/E51H1D4SWRbuQHi3oycGCjLPqVnD6emWE7n0fhV5uF8qzVUZScPkNiWY4lU?=
 =?us-ascii?Q?jRWAK6V8dXwHmNEnhtO74MaTdk/ZJau04q5tnmE2jo077sYTB4wyxDBEVaAO?=
 =?us-ascii?Q?WRUHrlKG1EfHJ6/H0pDEbIQppzR9FTQmlqYV67+GjzHCZFbeuVuEAdypdvSd?=
 =?us-ascii?Q?XOVkNzCO3usB83kf9Znn4AAZ5zzDpANfr+vQFrfLV24Tm17iwdsphQ5IsoC0?=
 =?us-ascii?Q?jCGU4iO/6UizK4BNaxKdc2mH/bohdlo2YZV7aAxrME3vdhPX9LcC9cIjoB6H?=
 =?us-ascii?Q?2NbCqojcBV3EU+3uwHkdwZ35hPiIWFw2xh1BBmSvkBZ0qFrgvzgeY37AJ0N7?=
 =?us-ascii?Q?Zw6OkuzumwZvO3Set9XhhO16luG7sMO5RuExXtlE/UmdVb+jQco+WuMj83QY?=
 =?us-ascii?Q?H5as7FyiF5w7LvdAiIQ2cXydbStbfPX29ef1qYHGxzDPY0tqD65g+6dV/3Ac?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc231a6-e496-4fb3-a892-08dc80c64b6e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:33:53.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwbfaxVLmIZwZn+VNSKbskP53NQ17WFkjqYDVE6i0HOXG3gmG4ipx5HsSYWDwv6sfBVHdoWN0zlN0R5oYarYIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

Russell King suggested that felix_vsc9959, seville_vsc9953 and
ocelot_ext have a large portion of duplicated init and teardown code,
which could be made common [1]. The teardown code could even be
simplified away if we made use of devres, something which is used here
and there in the felix driver, just not very consistently.

[1] https://lore.kernel.org/all/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk/

Prepare the ground in the felix_vsc9959 driver, by allocating the data
structures using devres and deleting the kfree() calls. This also
deletes the "Failed to allocate ..." message, since memory allocation
errors are extremely loud anyway, and it's hard to miss them.

Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c | 40 ++++++++++----------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index eabb55da0982..34155a0ffd7e 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -2663,6 +2663,7 @@ static irqreturn_t felix_irq_handler(int irq, void *data)
 static int felix_pci_probe(struct pci_dev *pdev,
 			   const struct pci_device_id *id)
 {
+	struct device *dev = &pdev->dev;
 	struct dsa_switch *ds;
 	struct ocelot *ocelot;
 	struct felix *felix;
@@ -2670,45 +2671,43 @@ static int felix_pci_probe(struct pci_dev *pdev,
 
 	err = pci_enable_device(pdev);
 	if (err) {
-		dev_err(&pdev->dev, "device enable failed\n");
-		goto err_pci_enable;
+		dev_err(dev, "device enable failed: %pe\n", ERR_PTR(err));
+		return err;
 	}
 
-	felix = kzalloc(sizeof(struct felix), GFP_KERNEL);
+	felix = devm_kzalloc(dev, sizeof(struct felix), GFP_KERNEL);
 	if (!felix) {
 		err = -ENOMEM;
-		dev_err(&pdev->dev, "Failed to allocate driver memory\n");
-		goto err_alloc_felix;
+		goto out_disable;
 	}
 
 	pci_set_drvdata(pdev, felix);
 	ocelot = &felix->ocelot;
-	ocelot->dev = &pdev->dev;
+	ocelot->dev = dev;
 	ocelot->num_flooding_pgids = OCELOT_NUM_TC;
 	felix->info = &felix_info_vsc9959;
 	felix->switch_base = pci_resource_start(pdev, VSC9959_SWITCH_PCI_BAR);
 
 	pci_set_master(pdev);
 
-	err = devm_request_threaded_irq(&pdev->dev, pdev->irq, NULL,
+	err = devm_request_threaded_irq(dev, pdev->irq, NULL,
 					&felix_irq_handler, IRQF_ONESHOT,
 					"felix-intb", ocelot);
 	if (err) {
-		dev_err(&pdev->dev, "Failed to request irq\n");
-		goto err_alloc_irq;
+		dev_err(dev, "Failed to request irq: %pe\n", ERR_PTR(err));
+		goto out_disable;
 	}
 
 	ocelot->ptp = 1;
 	ocelot->mm_supported = true;
 
-	ds = kzalloc(sizeof(struct dsa_switch), GFP_KERNEL);
+	ds = devm_kzalloc(dev, sizeof(struct dsa_switch), GFP_KERNEL);
 	if (!ds) {
 		err = -ENOMEM;
-		dev_err(&pdev->dev, "Failed to allocate DSA switch\n");
-		goto err_alloc_ds;
+		goto out_disable;
 	}
 
-	ds->dev = &pdev->dev;
+	ds->dev = dev;
 	ds->num_ports = felix->info->num_ports;
 	ds->num_tx_queues = felix->info->num_tx_queues;
 	ds->ops = &felix_switch_ops;
@@ -2719,20 +2718,14 @@ static int felix_pci_probe(struct pci_dev *pdev,
 
 	err = dsa_register_switch(ds);
 	if (err) {
-		dev_err_probe(&pdev->dev, err, "Failed to register DSA switch\n");
-		goto err_register_ds;
+		dev_err_probe(dev, err, "Failed to register DSA switch\n");
+		goto out_disable;
 	}
 
 	return 0;
 
-err_register_ds:
-	kfree(ds);
-err_alloc_ds:
-err_alloc_irq:
-	kfree(felix);
-err_alloc_felix:
+out_disable:
 	pci_disable_device(pdev);
-err_pci_enable:
 	return err;
 }
 
@@ -2745,9 +2738,6 @@ static void felix_pci_remove(struct pci_dev *pdev)
 
 	dsa_unregister_switch(felix->ds);
 
-	kfree(felix->ds);
-	kfree(felix);
-
 	pci_disable_device(pdev);
 }
 
-- 
2.34.1


