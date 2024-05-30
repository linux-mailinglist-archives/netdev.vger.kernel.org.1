Return-Path: <netdev+bounces-99468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925208D4FE4
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5024B282EB7
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FE024B26;
	Thu, 30 May 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a3Z6goek"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593D523741
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086837; cv=fail; b=mpHqegoRNBfS2e1N8a5o5nUotRKqZpTg2+g6Y7qORoQ6Eq0kQuR0V5pevzIK0U3/D0cjyO9B11pX8QDOe9gOSY+4kWpYp8vqIRZybpVhJTdGr6ReRvVFuuAgU83f/FrvUznE9FiFJ1lPLPZdA20hq+09qgDSuMACCdLjnl5HiVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086837; c=relaxed/simple;
	bh=evNwcIdx0c+xhOf1eF+k7XYvDJBATOWSsueER2QBjYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nEmFeIvN/iMRqG17hygSETWZQjUTD2TzeqV+Rwgkx7hy8VGfXJ5I20Dnwi6yEFk3AllQAx+67ZWhAdxxkqSqQG6Zn6QOKJykO78uTt7H9lYnlpZpkZmp5M86S6aAET5oCfCPowQwyrUdAT0or/yN28zJkKpiZBkjERlLVMpXnBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=a3Z6goek; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blwQzutLh3NdKZbksMYo5GAdsPARj95AxrnM/143Wqd+vUuZyHmK6YJkz242dQBlmOp1taH4ueEvCilYsgVZlklnJoP4qGLsBuacGbDVwwMCw6kl8WzI7TFzDp3YhRox4IRb/cwQHkQ5qCByz2ZwEdIliHSd9+PBFhOxQb615LUWQMKpeUmloKTxZIan4CEHLadao+xWONH+0RPd/Tuf78Q8OW/ODWgEzS6o7Zl0vNfoGYvFeZvKdWW059mdyR1KA9eskqGw+JUA4qlhrPUiIIqhDJ/6fjKMN06CNol6fN5JWff8cOYUyB4Fupd8qLYDNc/cvJ8rA4+Bb5lbx5I6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm6nZH1dE8qk76xIgwfec9CnQryIddn37Cdcj5MGFQc=;
 b=g/olmUJfVCEN+jHl7mRpkp3DbqCgldwTUFZ3UoyDs3IjReKZAs5pktH7oD2ZqXn4F1+0gYGMwcWiKrIFFranqBVRgxA2bMNX1ko2h1UdLdsnjGshuGtNr3Fy7kPn0dSDF1iGECE5CrLonlWrvRaSr0kL7KIJ6m1B1upcOasyyWVtJa5uKiXJEqfu3VgVpkRMtfTDiDEP/ggvYUhPD1LWdt4I9Pn8nevoAABGnt9mxuxGlHByOsvV5ot8grx4MaLtGwUG4zXRM84aNSqX9mcs+Ld5ki1vmIkpcAfyw4ebS+r6y0x9tSKM51T3z3Hf63NQ2k0GF8UslnkVWSuLUMPOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fm6nZH1dE8qk76xIgwfec9CnQryIddn37Cdcj5MGFQc=;
 b=a3Z6goekRDo2Wz+qj8TdhUy1uBZkwSGs/x75D5h/SDyBl8rTAag5Xlqo8rJLAfuXi55iVGtBqhvZuPQcTIzNWebmhSkv3yuhSDibk+xf5ZebFs+1E0EACkUy5GRwRJEkl2dJMLY//85+/vNHpvDTjhZWRrJUPoJwAUb6zlSn3Z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Thu, 30 May 2024 16:33:51 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 16:33:51 +0000
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
Subject: [PATCH net-next 2/8] net: dsa: ocelot: use devres in seville_probe()
Date: Thu, 30 May 2024 19:33:27 +0300
Message-Id: <20240530163333.2458884-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7defce19-6627-430f-f1f5-08dc80c649fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A28UzsZInaHebOb/KnGF7QspbP2/T369clExVm8nF6rG9K1Z1gOjtHdcZ078?=
 =?us-ascii?Q?SijaK8gooGgSYw8sAdvw8TFj1H2yZv22NV6OTb/UuUu0USQshig69JTNEYaP?=
 =?us-ascii?Q?fNEAEgw3tS2PQdjvnIOVqSfF+W0EjCvB2MKC3ZLTjNwaGzDwkQugNgB5UguD?=
 =?us-ascii?Q?XHrPrYrOOnU3/wAilpKXqG8DdSgcMXKpkTctsO5bzLAhSNSVLR2QA+JLe0fG?=
 =?us-ascii?Q?TQTf5bIvvd/iMOSMv8xJSpCo2nAziHrT+AwspNAVqe/Ogb1/YAVb+dmWw8rR?=
 =?us-ascii?Q?PBczbbICh2v7mTdJj+J6se28Edh795GOC28h5BVb2rOAkl/FDEMwPFxXwHAE?=
 =?us-ascii?Q?sQXtLDdEz2dYawLuLvYaUXnU6cau+8RzTcZHZlDWnS1ZrdZSk+63Pmmy6B6S?=
 =?us-ascii?Q?KSqRHG0EHeHFesrJqhYHFZBt9thv18rECgvYNZcah7NjzLcNS+xx7qntjB+n?=
 =?us-ascii?Q?H74Pdg9PISk88yvtdPFuehKf2BgsBI2B5Ft5dnX4y2n8mdTqa9JyNRlIJM0/?=
 =?us-ascii?Q?V5aPXw7plOq/HfdBsxwPIUMcvGlDJp6BD27M6LZOQjMbOG11/jM+14n6Ms/A?=
 =?us-ascii?Q?RgZ6lOWLTNcj9to+/glO6buMcIZtww30/Yc2dUtRP/6CKqSWIQLbxgBI8dRD?=
 =?us-ascii?Q?qA1wEn6GqDWnjTN3445c6qNV2/NWV7W93Q+50BpDMsWKeg/d+WtT2eTMUn3/?=
 =?us-ascii?Q?ke1Bfqzv6DEHH65M34InIwUspfHwmfc6Ev8i4Jb5vkIJgadk7WmYgcVlyKXO?=
 =?us-ascii?Q?oXZcisVvdqjVXfKkoFVFWfqMbaVvQgPRBkVYF6KnNrVgONYsDlVh/bZFZwNG?=
 =?us-ascii?Q?vN9s6CeYS71ntpFJdNAB7luEgN4oW+XbbL4L1TZkwmR6JhI/YCFZNR/1UUQV?=
 =?us-ascii?Q?tadcxMQfFHJzAlRrkPs+jNDH9szVSxYYj0ydGDjH+6TXJ4Fccs0QqSwpKTmO?=
 =?us-ascii?Q?5bUHLtGgMkgLB1sy0AQSHrXwGbJpJBSg2AYt/T/s/ZtQUQ0ZpcjKoiaTVSbU?=
 =?us-ascii?Q?mTm5VjLejk2I18tu11rMlDCkdfDsyi5GV6lm0HnAH0IjflehqX8H7sP2K0Ig?=
 =?us-ascii?Q?0MViSFc3D6nDLeNNj/TQLyaqSREm8IYSj0//loDTZmrsjpSeNxly0bvA6HuI?=
 =?us-ascii?Q?dggZ4yyKb5oazvqv4tUG0uDogGXUdjWKfhQbG1BDAEJGMv0wwKRk3nwHrw9a?=
 =?us-ascii?Q?tgHdBFIdSsPQ6/2Vu/tg04DzdkjRKWZ+UNpNqTMpagCqWrS+fuTyMafSZS/r?=
 =?us-ascii?Q?IYqja/KPivTyv1zQESG15/Ya+Zl/nnVylT9NEPHvrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tEZ/YpaRAqBx+B29VOlrfFld27dL+ZbC1EQsmXBXzfeBN+zVeqdGz2oB7E2u?=
 =?us-ascii?Q?7ARRdXdFGJBPAJ4UhRttDsoYxAQavm1CTH+cxp8pKAzECJAhBnpPARhRXLTs?=
 =?us-ascii?Q?gKQzRxAlgS9V5dYf0ruO01q1bpE38+az9lKvb16k9iyKruT51F74hvrykLAi?=
 =?us-ascii?Q?hA+8OfWoy93ofQxwoI1mU/orz9+EX40ebH8g5UpJK3fvDLv65vYvTbVDZkSg?=
 =?us-ascii?Q?VvhCyYM1WHcxr8bILap74+2lbJIkZaNcx4/j+LDFTnMjpiau7HvU305mDRoc?=
 =?us-ascii?Q?wIZ6T9nuickTCBntXYNuAIPLoomiE3FKfUdp8qX80eDzArU0vQGdUaPKHo4s?=
 =?us-ascii?Q?jXpHoB9sAFQ3GWOAZE2fuE1YxPLFsZky/ZeKJAuBhdCg4W/6w/KtMFdkESgp?=
 =?us-ascii?Q?ym3a9l5wqTAIR0wzoK0HTANJDzq4C3NNiBto8ksVpjzQ4KFNEEabds5hBU4/?=
 =?us-ascii?Q?cNn0XRvJ12Z9i0W/ZIIqINYaa/vCLCrYsyhv97kvGFQ73HlAiRnx39rdfgLT?=
 =?us-ascii?Q?wE0KDJqI9woE98zXsOhAWpWUSj2/LRLONkr1kUMos72C3D1dBIV3fxRdMFWQ?=
 =?us-ascii?Q?CzdndIcvn87NMrV2vc5QNTxOuLXFNCmVksbCg0zWJEkjDRzmdmaCG5CYvsPA?=
 =?us-ascii?Q?5doyx7etQz6ZYFGPkxN65qgcoA7HcpjxUDmO1OJc4J/UfsAe06BX3avNDyPx?=
 =?us-ascii?Q?5chb+A58L6fqsvDlWN0Nfz2XnelyPVzr1CUCqYwC7mgST7Ot2IceXghsEc7v?=
 =?us-ascii?Q?PznzxiU+ByjnmIaYgrE0oZDzTtGNZwKaKyhIZablITY1dR2Yt92jcT6h+5Hk?=
 =?us-ascii?Q?bGWmyjm/uvftD2Rcqfe5INWUdCUfP5HzOacuojRKwT6A71tLl7NljSrnRIlb?=
 =?us-ascii?Q?miPejB9GPI2vss10Cnri2pyeXr9MRgNvuhRp75yn4RUPkEZCMCQk1NxjUv7o?=
 =?us-ascii?Q?idLNXmYsSYSjXutwLBiuZQkKILHZWdMWlcg2V0yG2o3IOB4bjkomfMVp4HKQ?=
 =?us-ascii?Q?JfNMrJxWFiAQM0J1DGFLEUv2+XV+1LPFTftdafTZL7v7BYiJJuQyED5Qm1N1?=
 =?us-ascii?Q?QglW4SgQJroNhOZFmVMLvr3thx+pmDzHGoMQZ1iP2LIQUrNsDslCCc540ja/?=
 =?us-ascii?Q?hKDN67Mf1YCLiEAoNlHTUp23HYjn846s20vlDHS9fJ9YKinhiX0b+YYES4Qh?=
 =?us-ascii?Q?lSMwzZrYei5dyb4ZZOlNf5XTyRlS+LhBC7F7n9RqCKvqwBVC4oC4fnK8/RPy?=
 =?us-ascii?Q?/9BWHdSqy6zX+nybm0ubUYfeQugKJGej4WXEreW1r3eafL3syeY0fJAvQIyn?=
 =?us-ascii?Q?p7PZJsRln4zkODfmW7Zewiq4sTWyQdmd5z2IiD3vbQ7VLMBpT3X7Soyofjpg?=
 =?us-ascii?Q?WtymxjsEA+IsyDb8PW7y7PtOYd8/Opj1ErJ3rOKT1Hd0ySgGS5SDqCE9ZvI0?=
 =?us-ascii?Q?PNpE5KeUY6WTma8RAkOV4trgniKlqAjeGGAgXG9QiLQG6LctcIRFKjgneGy4?=
 =?us-ascii?Q?huE+cVBmRgK0XbOVIvE9dW0jE+55tckUjNqj9sZazxkkMD2eLvuOwZ2YgdOv?=
 =?us-ascii?Q?cLPBF/QcdbtpQqC03IdzSS74mJh5gn5WYQ+bNShE2tWHWyu+DlSFd1YnLAeJ?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7defce19-6627-430f-f1f5-08dc80c649fb
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:33:51.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VToEs9AVoFezR9mL0BGsirepUUVBGet0Ink/dLzKSIKY/rpQd+ACWY9c4ofVvuvEtHlO+CdRJU8V33Q5cgcXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

Russell King suggested that felix_vsc9959, seville_vsc9953 and
ocelot_ext have a large portion of duplicated init and teardown code,
which could be made common [1]. The teardown code could even be
simplified away if we made use of devres, something which is used here
and there in the felix driver, just not very consistently.

[1] https://lore.kernel.org/all/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk/

Prepare the ground in the seville_vsc9953 driver, by allocating the data
structures using devres and deleting the kfree() calls. This also
deletes the "Failed to allocate ..." message, since memory allocation
errors are extremely loud anyway, and it's hard to miss them.

Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/seville_vsc9953.c | 44 +++++++-----------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dsa/ocelot/seville_vsc9953.c b/drivers/net/dsa/ocelot/seville_vsc9953.c
index 5ac8897e232b..e63247d3dfdb 100644
--- a/drivers/net/dsa/ocelot/seville_vsc9953.c
+++ b/drivers/net/dsa/ocelot/seville_vsc9953.c
@@ -971,42 +971,36 @@ static const struct felix_info seville_info_vsc9953 = {
 
 static int seville_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct dsa_switch *ds;
 	struct ocelot *ocelot;
 	struct resource *res;
 	struct felix *felix;
 	int err;
 
-	felix = kzalloc(sizeof(struct felix), GFP_KERNEL);
-	if (!felix) {
-		err = -ENOMEM;
-		dev_err(&pdev->dev, "Failed to allocate driver memory\n");
-		goto err_alloc_felix;
-	}
+	felix = devm_kzalloc(dev, sizeof(struct felix), GFP_KERNEL);
+	if (!felix)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, felix);
 
 	ocelot = &felix->ocelot;
-	ocelot->dev = &pdev->dev;
+	ocelot->dev = dev;
 	ocelot->num_flooding_pgids = 1;
 	felix->info = &seville_info_vsc9953;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-		err = -EINVAL;
-		dev_err(&pdev->dev, "Invalid resource\n");
-		goto err_alloc_felix;
+		dev_err(dev, "Invalid resource\n");
+		return -EINVAL;
 	}
 	felix->switch_base = res->start;
 
-	ds = kzalloc(sizeof(struct dsa_switch), GFP_KERNEL);
-	if (!ds) {
-		err = -ENOMEM;
-		dev_err(&pdev->dev, "Failed to allocate DSA switch\n");
-		goto err_alloc_ds;
-	}
+	ds = devm_kzalloc(dev, sizeof(struct dsa_switch), GFP_KERNEL);
+	if (!ds)
+		return -ENOMEM;
 
-	ds->dev = &pdev->dev;
+	ds->dev = dev;
 	ds->num_ports = felix->info->num_ports;
 	ds->ops = &felix_switch_ops;
 	ds->phylink_mac_ops = &felix_phylink_mac_ops;
@@ -1015,18 +1009,9 @@ static int seville_probe(struct platform_device *pdev)
 	felix->tag_proto = DSA_TAG_PROTO_SEVILLE;
 
 	err = dsa_register_switch(ds);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to register DSA switch: %d\n", err);
-		goto err_register_ds;
-	}
+	if (err)
+		dev_err(dev, "Failed to register DSA switch: %d\n", err);
 
-	return 0;
-
-err_register_ds:
-	kfree(ds);
-err_alloc_ds:
-err_alloc_felix:
-	kfree(felix);
 	return err;
 }
 
@@ -1038,9 +1023,6 @@ static void seville_remove(struct platform_device *pdev)
 		return;
 
 	dsa_unregister_switch(felix->ds);
-
-	kfree(felix->ds);
-	kfree(felix);
 }
 
 static void seville_shutdown(struct platform_device *pdev)
-- 
2.34.1


