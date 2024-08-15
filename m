Return-Path: <netdev+bounces-118919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F90995384F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DEE1F2468E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C62E1B4C2D;
	Thu, 15 Aug 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ftmxS0wJ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6396817C9BD;
	Thu, 15 Aug 2024 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739670; cv=fail; b=t0EbOF+Jv39ZZEdnm7jaz6h4bAkYX1L+iLcrILe98eE9BHkpe4QPbEMOSffIsa77YrLFRS61rASm1THwLfYr32Y9CHDD+uMhUdFTtfR7CMOpmmwix2yoIEDasLOxgBIhpI5YmqU9JG1bw9NHqDwdzv9uAQ5EbR6oOC1RUrHmuP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739670; c=relaxed/simple;
	bh=G19CSiZR3FzaCVgeW+32jKk5th90BcXpwhdT1bO8EY0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rqumdlsJYReVIq2qeZucckPmH9kLNsnMhCcpsy79NN5VL21m0KGFDJw1N715/IkLRe2My3sKDMBnTpu6+tFtHwwSOYVvDCSlpEAGgZngI51p4L8zZ0uEpwCbnbczyasyI34Y/17SOcgLUacsRG4mBANf79H1qRdMXlPr0GQh/Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ftmxS0wJ; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcGgSKdkUbPRjXnHVgmE1WV3np1kfeeDfZ/vaBJsIxkXmbeZwXk3CqUp+1EmokBmmGQtyag+Ask/OXmXaKGwq8kIarayqVHZtZ21/ZDc2uuUUQ0uLccoKMVaB+FEd4Z4hcb8Yt15aQcEC8XCCtR+WNMwqGQeHXjs2TgGmSJilvQN1Rf61SKY5i9biY0osDO92ybfNOIaxkN93WR4pSkDf0CwXss+DpEjy97eqw9v+8KcqYyneNFp6EX9mOGeqlC0Vgj7YWySIs5DlW1bVgC2U93Xz9sYov8SDNZo5GSbvg0xQlwhXa5zfyAxIvUaK1dAnLSWcsF7YBM6hjQ9kXzg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4Vs7dibMtit9/jIXVQo6NUzzirbe7nn9qFME1jtu1o=;
 b=QY953CtQkpixCDIC59CPy/KiOMHSTHJ7xbSEw/mi3hQHrBbmZlfHezlZ9CcjAnbgtwye6r4JHhBXciOOdrE+o8SQB9fqPDfvGeElI17fZmspVKIY0PSra0jXmW4VX3cXXoFpsuhBqucKxUpl4jU9B511JksJpiW8e+5xbtT1o+W50xBCoQ/oT9GoDFg0V6G4wCDTt8r4AY3O7o1ryurnAkzkBbIS8nZT79XbvokIScgcvKTCRShCMDHJfr44s/qVuROVHuDBAjpK3Cj3naUdOlCjV9WE/e6KlEjsAVje4sJEB6ICfAroMOlNS3yKaEtbGSIGKgC/H+V5SG/xKvvbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4Vs7dibMtit9/jIXVQo6NUzzirbe7nn9qFME1jtu1o=;
 b=ftmxS0wJ70CeNLsM/dgP+EUT4XiAf8KkXZdJxZCpOPYI7RTf8EiPT79a+DWZDUV2tIRiIPw16wlJ9CACOBBECW+WUkboF1hP4di+PfSeiXLArF3uLyZhP36lwokWWjJfmd6YZewuSXcojfJe3bxYBheUIV/fNlEHMLOv4L7wMqd1FouxWZgcasKLzOg+lBMVw+GIClIS6sv7POzTTtuSgg7BkbNZUecXawhtNHot/gQNjY5eXOENIbQvS9uLgmc2YFVB2byGQGMP73LAPRCuzedZRlrX5AaByaxfmac1zPW8znr3FVtxxHrBajHe4ThucrcggztONUPRcAmhvVmcuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9928.eurprd04.prod.outlook.com (2603:10a6:150:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Thu, 15 Aug
 2024 16:34:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 16:34:25 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org (open list:ETHERNET PHY LIBRARY),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v4 1/1] dt-bindings: net: mdio: change nodename match pattern
Date: Thu, 15 Aug 2024 12:34:07 -0400
Message-Id: <20240815163408.4184705-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e149be-e040-4362-7ea8-08dcbd481fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o1lreCMNBU174CZvHh+WLwanTdJfKSM8UdZ7MPMp3eWnfMKwE7QpcTLNUI+X?=
 =?us-ascii?Q?EU4qiRNwe5jWEE/9KMtheHyBAARzPCzBrYWCqPwvywNR9eC/n+Pus4DBbg+J?=
 =?us-ascii?Q?oqItu7f0B25SQyh/Oe1MQ3cuSCFx9+TNcYG+BYevfHiGNOjOKh5JM2VXD8+q?=
 =?us-ascii?Q?MQ3IFVFNnDUMA7wTFpAPjmhf2g2oo/48vI7i0RHwlQZ55QbgXozYe73pZKhm?=
 =?us-ascii?Q?qftjbjOQ/vjBDJcJUNHGmudfhUY3OWlNK5xZCikENu860BPdkPMDcmU2Au5f?=
 =?us-ascii?Q?mKgCDXoJW32VXBigbi42+lwvKAUQYWmmXqV3S0ksHJ4wz7s4N4pIJ9UNy2Jd?=
 =?us-ascii?Q?VDPyFZwiZSQUQJ2lJqvSh5NeHAlb1Pu9gwYWyEuh4EBwXhFHd9M6l6f8poNF?=
 =?us-ascii?Q?vdJE5e4G4I8fOWLZsohOHtwuF4c8H89Hivc58PelnUeY0mKfNxGJ76+qdsHu?=
 =?us-ascii?Q?NsEkRveuANrS8q1QV5ELFa7Kf5n+iJbyj+j+XXrHjnfI/NIMD45yp99nVWzi?=
 =?us-ascii?Q?wRwNS2zE20r9MHe0ZKRiT5AW7GuOWbe0npyUIsqIU+dfmsKLFq2BNZLPqRRk?=
 =?us-ascii?Q?ejLAoSkAYA3Ii7J27M4AE31IHsObou4IxqmfG4yw22Ry5Osuz65JC2ba0vdC?=
 =?us-ascii?Q?MJuH4c53fmelbYRURR8Wz8ZdtzSbJuGuHbImsVKUX/8lcvSmDE7ADRGVvXFX?=
 =?us-ascii?Q?zyChHTRkjAJGVBuZ49RYCyhBdNE8/Sqp4xgirXpseFHymjk3ZYIrKL9Q53m0?=
 =?us-ascii?Q?kGeMIBbEnronPvfrJ+eBgPaU4+NnciH25xPY+jWJpY+SYx4f/ePkHtsuHpFg?=
 =?us-ascii?Q?5H4I0Ud05mMB0GEdbduIzeub1kU1bCP/jDxcxuOQkEFuKsaBk/yswM3B94KM?=
 =?us-ascii?Q?HwTYJKFI8ICBn+odjmkDRvUOmuEkd5/PrsWp26lNScJap0dTKOOYiRaj93ff?=
 =?us-ascii?Q?qJs618m5qfMVz1e6rbDOjLXg8bQHpTzGJqgpuRA9BzQys8WyExGCA8DAHEtN?=
 =?us-ascii?Q?9z5O4aprY1orLK99TWMg4XePuQruZ45idTGpYtWFf1iS9jQksYbYZK+fJ9jc?=
 =?us-ascii?Q?2p7F2BXF2cb9DYRcs+sIyPGh8OVeip9W5ouEYO2ZMFBqa7pfnFsMSb+nBmzd?=
 =?us-ascii?Q?q9kTzKfpjgMpKmujTM1316QVbpByUjJUq8Fq5FS8Vpdyly/8/fR7Zi9TJPZD?=
 =?us-ascii?Q?FNt+NXbEV4R49RmedPLjUr+h4EYEdKC0GlbiKLK145Cs1aUbFpedMgblzhOC?=
 =?us-ascii?Q?8Cfjay8rrqkuhFsjJAw/xnvCIJpEqcu0269hZKq8KIfM3s4S4R7F4lzApOEb?=
 =?us-ascii?Q?oGvggkzaYrD07QV/uiOLhVo6ZmMEw35hEfdtRA5CyJCSeh3Fakptqoh/kvo3?=
 =?us-ascii?Q?bm0r3MOvaVy+xjosz3s5XCvwFz2C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KNCRvkHXXxzIEsK7B2nZYePhl7OpNNSYXYjUIdX9Rrdno/c19NaB5qAKSwDA?=
 =?us-ascii?Q?WPjUPuiRfzFx3kEjAAqpGn6eCjwUU2c2VebaQwZQiflsQqdNQxnIcXq6twoy?=
 =?us-ascii?Q?2vQ26cMR4ZISWKKEBJRpuTrXTnX8bmdvluRd+TrOcZkeoB7L1KZJ71M5H/tq?=
 =?us-ascii?Q?DwrA9dpmvHX82Dy8Z6QfdF5ckbevR5bVUebXOBE+lmu53Oq9uCQgRLGetMa0?=
 =?us-ascii?Q?/4euSBz6ARQ8pWAsrDzRnpusGKh5yqQ54GSd3W3whtnBy3uZaok0OC/n0s7q?=
 =?us-ascii?Q?Ro9JA2EvXGTNMwqn3Am1/bH/UH1XeMJbPgoZlA0h2wO3FIlMr1T2oDXRWaqb?=
 =?us-ascii?Q?QzIUXVS2HHaeVjgp0111fYSwGzbJOQ8NoYVzEy4jvhP0myMqTQhBPEPTD1j+?=
 =?us-ascii?Q?BDm+2ClEGBF8/l7uPjbgHx2dr4HPPIUeK/+Tvby87kjUAbUg60cvCm1s+/yM?=
 =?us-ascii?Q?Xo31LlzVBbqPOPGv0+z3DTIgrlaaUHZ4zYpBAlEZBOqFBvi7gYkTP2qIqp0L?=
 =?us-ascii?Q?YGYCEnyUxi/PyhFQMdKrf5vQpVMyVwyhLY2qk8JuHQxs41Yo11i2bTAnrnbQ?=
 =?us-ascii?Q?QlZRr9iNEUguMXOUM0Wz6vVxAqFx1aJ43BEZ1ZSvdlCRILUQsk5z9FcB4T5p?=
 =?us-ascii?Q?E74GrRkW8S9fAOwHid6OjCPieS2xXX0El+mUFrg/1bIHpRT6bRuNsisIZkz6?=
 =?us-ascii?Q?YavBYhUvAXLrcFiTsrNMY3tK2uU5QeTHbmHmwXq39fQz5peq/QaN8gOSoVSf?=
 =?us-ascii?Q?z7mFl1z8N4QiKPucBq/swSvOq6OmqTQpAEh0GtTBrsg0GB/XcBoCO60MV0O7?=
 =?us-ascii?Q?UtXXMOOJ4lelTpqC4GDLDug5zXbDjIR0M+1erBeXtw40QQ900eruwhnLNsjZ?=
 =?us-ascii?Q?G/oUqR4FSlcbsiVjnN05p+XZMdx0lXr1WlH9LAlsK2EObIqfsEW/GN+FzNbK?=
 =?us-ascii?Q?rvjF9w/ZO1/rW5RXwaYARFp1xKwqacoQ2Sy6erxW7KoySWeyYYGmdYrzim12?=
 =?us-ascii?Q?/+kezsFS76cTFTFPjRwpApxerOdqJqyCBs4oQ+7i3Q5Yg7t/HqGX7YS3xs0O?=
 =?us-ascii?Q?xUToodVZllX/FhUDq4BfzyIpNrGvOiOOzCG8E3b1ah/ObGWMSELXfTH9BYvq?=
 =?us-ascii?Q?i4kF8SFy8uTC+Z+LBeMg+pEUpz9S6foNK58E/XauKpj4WEEYtoxm6iJfoGYz?=
 =?us-ascii?Q?DHtgHA8aFUlHrsZxixc2mylVmISj5mfY4BRA3Zv2eZNiuCjGPaApp1sreQ5X?=
 =?us-ascii?Q?55WAeCgM7x60IprxfcJouW6zkmd2cFzdsdXqKfYeCXQ6lSf2PFapWVcu1de3?=
 =?us-ascii?Q?Re/NfJesKoB7TTCsPKMbDr8+RpxkSXFre8oeGWt85xf0FhOiVcLgy5iofhT4?=
 =?us-ascii?Q?8NHflqbYLBkiCzXt1VG5JYsF7li5GLelJIzO4/5r0OXP1Miqr+3dHlIwd8/X?=
 =?us-ascii?Q?pDj8Tw/kClkwWaSgWAs3YdVXUoXHVYZS4v3/9DHplCtQrs8E2Gd7JmBctNlO?=
 =?us-ascii?Q?0rFaGfQfUB4sULyzXVU+h2iADXo/6W0fUNcYQwfDsBMDsXOqD//25AR9VkEV?=
 =?us-ascii?Q?Rez+3YnwPFbfOE2n5yM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e149be-e040-4362-7ea8-08dcbd481fe3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 16:34:25.1434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uma3Q1BvVZ6g2/lag33lpReu2xgK8CuDreeOzdYaSngX3o6bVJLjBFVggkp17ZKxyJpbRCZ+9APzdDGbUFyLTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9928

Change mdio.yaml nodename match pattern to
	'^mdio(-(bus|external))?(@.+|-([0-9]+))$'

Fix mdio.yaml wrong parser mdio controller's address instead phy's address
when mdio-mux exista.

For example:
mdio-mux-emi1@54 {
	compatible = "mdio-mux-mmioreg", "mdio-mux";

        mdio@20 {
		reg = <0x20>;
		       ^^^ This is mdio controller register

		ethernet-phy@2 {
			reg = <0x2>;
                              ^^^ This phy's address
		};
	};
};

Only phy's address is limited to 31 because MDIO bus definition.

But CHECK_DTBS report below warning:

arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54:
	mdio@20:reg:0:0: 32 is greater than the maximum of 31

The reason is that "mdio-mux-emi1@54" match "nodename: '^mdio(@.*)?'" in
mdio.yaml.

Change to '^mdio(-(bus|external))?(@.+|-([0-9]+))?$' to avoid wrong match
mdio mux controller's node.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- add ? in end of pattern to allow mdio{}. not touch mdio-gpio.yaml.

Change from v2 to v3
- update mdio-gpio.yaml node name mdio to mdio-0 to fix dt_binding_check
error foud by rob's bot.

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mdio-gpio.example.dtb: mdio: $nodename:0: 'mdio' does not match '^mdio(-(bus|external))?(@.+|-([0-9]+))$'
	from schema $id: http://devicetree.org/schemas/net/mdio-gpio.yaml#

Change from v1 to v2
- use rob's suggest to fix node name pattern.
---
 Documentation/devicetree/bindings/net/mdio.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentation/devicetree/bindings/net/mdio.yaml
index a266ade918ca7..bed3987a8fbf6 100644
--- a/Documentation/devicetree/bindings/net/mdio.yaml
+++ b/Documentation/devicetree/bindings/net/mdio.yaml
@@ -19,7 +19,7 @@ description:
 
 properties:
   $nodename:
-    pattern: "^mdio(@.*)?"
+    pattern: '^mdio(-(bus|external))?(@.+|-([0-9]+))?$'
 
   "#address-cells":
     const: 1
-- 
2.34.1


