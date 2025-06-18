Return-Path: <netdev+bounces-199199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD2AADF61F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B22817E7E0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C232F5473;
	Wed, 18 Jun 2025 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V38gq5WI"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307963085B3;
	Wed, 18 Jun 2025 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750272279; cv=fail; b=PpboH02Cv9erQaX98UPvbv7ODyxGxaw4FTtS8lXjCAmuPUN5zIVCp6pb+n9WlSDPOR+e49jZMl1n7YNqnh1sY1we0iEx/SkDccmgsW8A8r5w9QBe0i0slhTp9VGdD4pV3B47CHh7VW5fJoJavkUI1kXzrxl9AoIrhp/IZlAkv9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750272279; c=relaxed/simple;
	bh=cC5LdU5eZns59T0tY2JxLCizbt+qjXgFJ1Qi7G5bHX4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TNtIZQWqv7qtul3VMU2iNXXoA6ce71t+5FApWy0Lby9I6nd9w2ZVy0xkUnYbpdnby3k2iGnY7efeLKsafQpgQ6nGuUu90BBo0BVS/oyUBg/cLwGpUccSwQ365aT6d5btqSg39LH4PYNb/4ycTozymUsga1718jdPkCOLjcM9woE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V38gq5WI; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvxlyuy6fyB0JuJV03A6LM5+nOg8XNZborboo1RVKlGJNITG1/+mTTnsJ6W+LVLD8qQu9yhyEZrqQtOzMnFTnyKyvtmzEvAfVxBAOcK6T0doL9HmC/6XRwkRo+GBKa218mYsymN3u4cWENIXKSa2y9yEwU6kI9D3gyOYq3dlO77hyc582S1tRtJc8BL52kjHjQSU51Bc1a6vnpw8sx5MJT5tOvCUdGEDF052tO1wSYsSSLA0FOzz8U7lRKMG6EmVPwpGAdjELy0Fe/etBIv3ilXmDk2sNUd9+ouT8qIhmVJMrA3tUug537uYk1r4psawAHkGJ64hC8d7ahJB0OSwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWF0L33H7mc5k6d6hGmaNTXQQ3vffIPM+nU/tIPAqBw=;
 b=DY605KIO1+8bdNc/3QOrvC79sF9f7AADpOFN+CuvkEGl41mt4rBm66YHtgOa78DgJyDfUwzGlxaXaoVUivpSJFb4OIzkTYIt7b5JY84wCf/bTbtQF5i0blfcNeQe7p879JMUVF4y0t7cZl1hXOWO0yDPBHpLFq4K1YAWr0a+UWSLXg0TUqL7/rjWL/E8C2h2WjOJcLh1rTXjSVHK6uaBzQo/cb4+IE2kJR6xDWvlnwtdIwM8BNdsDug6sUkZBZ8sKTQ1rZUVxuaBeTHbbZYPaTIvPsyjU9HAnE1opOo3HGQbRTe6ZJggu87YWtVF/6wyBr4w5i1psNr/j65Sc9m8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWF0L33H7mc5k6d6hGmaNTXQQ3vffIPM+nU/tIPAqBw=;
 b=V38gq5WIP7YNDpRdv7QGaChl4laGoNcqTqNlAhbItGDXFm/cpkrKDjtJfrsrGa3oCpdkJ/piEeUolrXaxcat8905NDMyG/cxn2DNvqxWSC45Sxa3d83wmluhJRDbcuqiHsOQ4ILwXzHt8gpuJ0Bt6vQ8XTJnJoaB7FRZPoBFqmDSYGph8AsYlTAsVlGP+zQ03Dbv5bFjVCgTnM3QFMo64Y6RrzwAJofVbyBfxCFBGPLqRBTBjSJpdYdIP6KYV5fy6Gjl+yOLVIL4ykSBRwZlhtHz0GNxlyFP2/ZiThZHoC5nxd5YxsSPpD/KsODafISCBkF5tHoUIFz+7jm85PVehw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10324.eurprd04.prod.outlook.com (2603:10a6:102:448::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 18:44:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:44:34 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v5 1/1] dt-bindings: net: convert qca,qca7000.txt yaml format
Date: Wed, 18 Jun 2025 14:44:16 -0400
Message-Id: <20250618184417.2169745-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:a03:331::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10324:EE_
X-MS-Office365-Filtering-Correlation-Id: 785d0b22-8fa8-4338-cde8-08ddae982b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KKOeFjS3rI0A2l4mRAwiAvB91B3tuFq97Qdx+KZa/7IyAKwdby15RDikyFpm?=
 =?us-ascii?Q?V4Arh/ZC0MGHjjUSq5xa8O/PXIs9tNofHbk9Tyg3ibP1PDdNiDeJrKG3Bu1G?=
 =?us-ascii?Q?bBKgKt78sjfi2Xn0CkpsS09B/dcYdKcBJ66P1SMapfzCT6VDny4dRg+ObuB4?=
 =?us-ascii?Q?/p2yLRN9A9mSqLvKWPwWZtjOIf0Ns6M1BmXKbUDQE/+THAFd23KryTDlySy2?=
 =?us-ascii?Q?wgCkqHsrIppG5gsV+FSkqvTrcokj6iXdtxAkVYYR2Y/BQA98QOBgh5R1pUqo?=
 =?us-ascii?Q?EphikJK2rtjq8ZF0jiEkk4yZPFzsFR86siuouTDOo7GCQJdD0Z5Snr0KpCm3?=
 =?us-ascii?Q?Sjg1hcQBgqzCpNDfOjaQzURQB1bnWtoOhpW2emxuzVlxrXJmEWnHgQJZow9e?=
 =?us-ascii?Q?n7omsN8C+AvY+BB0Srj+ohB56Lw7jEyeT4tgt7f3KdpCzil1iO9IOxaARSLN?=
 =?us-ascii?Q?e5KHlNM9KL+RMlXn0/WNnRbun7AbgK6HWlR7oOpSDlIXIWcCVQnxcX+5wO6X?=
 =?us-ascii?Q?mXRVT1anFF9vyA9SaNz2xhK2XfiMzS9iCEoGiziqYbFQV7Y8Eu8bFqffu5nJ?=
 =?us-ascii?Q?Bp8ENYw6Hq5byVeiQ7gnAFsE3n16N07xZwwPqR8ZU3z8u3YCA3arAe1fPEPD?=
 =?us-ascii?Q?baZ1ZNj7HJagah9P3jt1oBvKSHBdCaFSecnIyKEP9D+xtVkAH1magWKG+mbI?=
 =?us-ascii?Q?FK8PHpiFWuCG4i7IWFp4alO+0znCND9OpovVkyGeB4J6zokoxLb6HXpkFlLG?=
 =?us-ascii?Q?v7EIyUB2gT1vUQKbOyCo7+9YNtPWSnQxIB+OpCOj/UKAnLyf+pK3h8gQ1yy4?=
 =?us-ascii?Q?6I3IL5Pwo8179rPb5lZAfpWM+CxNsuN7ufNMw8zD7x9GaKzrKvBqG212dMrr?=
 =?us-ascii?Q?ciVaSnq55xXLr6YJV/Df7JwdY7IExnJbgqbzrABLSXSXmY2SX9KTnjlF3z1z?=
 =?us-ascii?Q?412ikEP1rA2dbaNcucfhy+jdylJys+7WxsrEt+vdfzJtBWG4teE+l2ObddT7?=
 =?us-ascii?Q?kelxMXKUPZtWn3VxKVln3jEjGRB9iItVxmH6mlI2upBKISN/W3jDiJzkO7XB?=
 =?us-ascii?Q?GQ4KNlFZE+eW84YDKCEzHTgbzWTxpZh6YiPEQw2N41r85C93BaSA359JN4cm?=
 =?us-ascii?Q?om/+q2ldDq92eM6GWFF4sIZYLfJDDwLk/nasYXRcxPEOHrW4xDT468FPV+j5?=
 =?us-ascii?Q?1IKZ/Lx/gJ9kazXZULDiCBSfwib+ohCF+zbhvRlenhrw+8qx82vjHzulvWOV?=
 =?us-ascii?Q?ylL1hIQqbDCyuBY1DfGwrOadUAby1vzeoHWnVEiv5XtMh+HxD2kvxUMtFJnO?=
 =?us-ascii?Q?b1vLKxi53EiXp5auVp/aqyCF28kfV3XfWNHZM+4yHoto0/JJn/zCQbL33+U1?=
 =?us-ascii?Q?zIQWWXr/EohFLUbefimRPtpAG09zEnRzXoj0Sz41PmfVuetnYjiK18jK4skV?=
 =?us-ascii?Q?mt34qT7T9JkQMju2CQe659gZxbH1dNGS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nQAofyhkBztXqww1z+iWwQdoARoTAweBdN7G+GvFH+FLfvVwsUozcoLq8glL?=
 =?us-ascii?Q?tBiwWgW6labARhmU7YZJeVAgzFxgMyPt4eSg8koAq/kSLV74JyIbeS4CQJW+?=
 =?us-ascii?Q?VeD+OaWZ9XKFfqqFRn+XiyOifWy24aYlBxyXNq8EIPy8E5LBzZ2rk6l4vpv0?=
 =?us-ascii?Q?yJsqbhMz+xLumkDcEX5yto6zIcUE/lif+Vx9LmVcOt7+PMynidWiP9IWYRaG?=
 =?us-ascii?Q?jWA9U8zw3r5B9qOvz1AEiCD4bDwWgBt7hBDnJ/q47bgrs3vFQ7Rfn7kZIFsV?=
 =?us-ascii?Q?HrKDprsjzOFHGQPa8U+yQVu3XfLoe2agae32weWT2NcW/+Vq3Ic/rBu1Fn8Q?=
 =?us-ascii?Q?Mqebik21sDuyT6DxjY7a5dJaN63nioOm7o9vCFHwWkR9U0p/73hFKp45sTlN?=
 =?us-ascii?Q?o+qkRd4DLw36ssvhnLfvuftrGR63nabkvmcRlNaUK+6xiBstPXe7+1hnI4DA?=
 =?us-ascii?Q?ZZR+gwQYBVQumZ0Bapl2SrEdMAMARC28Gvr/zxFWomhaeO9MsGCm/MX65wNv?=
 =?us-ascii?Q?QGnj+7poKG7Ruww3/w1/rxrezRWDbb/jaG0qygYq+9UIG+fzBN5sLTmQ1nXD?=
 =?us-ascii?Q?TB54hWubH9QdZQbsycbes/Og7UpsZrMZdwjFm0OFw3934xcVdwu+Q+3hIxmg?=
 =?us-ascii?Q?a6APXL/+x0iAdf1J9O5tvoTGbCqf5q7GElUHbKqMf1ul5jW4H9yjPfKuwrj4?=
 =?us-ascii?Q?lNp5z0K+pRsMg9zysWZ58izQ3yy8qAZ+PejRWadV9FTjRneCvai06YJM6MXU?=
 =?us-ascii?Q?VhptUEAr62Ek8Ea0k4vIybltX4LUDFOWntdidg92CDoERy/gam7QQnyh3/VY?=
 =?us-ascii?Q?j81YP7pzMyaeXoq7wypRS8dHq0MjPCb9PQfFQagwnO2YjBn6XQokrcK0h1Kd?=
 =?us-ascii?Q?Z9Q+ZvxPXz4YUSxQ3dLWAozYqRsG57MIHdlgJaf569khFE8VvUeeBhXPeEcH?=
 =?us-ascii?Q?5Jj2oz4aLFegCjN7UBt/eim4nPaeMDrfZNiME/5TwKMKJSUPE6y0H6DRmEGr?=
 =?us-ascii?Q?eowWBCYXCrtLEYfYdn/saDAthr4pUQEnBIvHgTSwwGqI7v5oCQk2+KSTVqZ3?=
 =?us-ascii?Q?km9E79jSGEOZziRMVoaV3GsL1iY8izgmngtnb7ZeWC1tX0Jzn3OtqsFU1/LP?=
 =?us-ascii?Q?hLKBQBYUaPJSob1zWxgmXHyCZBo6v9Rw3GqzWGlNF6d3V3Po+YtrUOGsKW96?=
 =?us-ascii?Q?e7sJdDBusKURry3QRyJrpmfAQ7Hic2xH6847DLq3y+aEdQA8SPTcG8rzptWh?=
 =?us-ascii?Q?/zjvkFS5R/QfyMVhisMsp+l100MjsVIrTwru+bf8JlD8iBSbBSJCmh4GjFrV?=
 =?us-ascii?Q?1PUAqoy1AMKXzVTHHlVdSOhYs//WdVt4nw6C/FcIKMTFhBIm8kS3CHB/uwlX?=
 =?us-ascii?Q?SsEtmZIGHtAHSvwk678WfDwVzyde22FZ1Y+BBX+PVKQTPXfv8xCYvHarUnmv?=
 =?us-ascii?Q?paUaDrvUsRbdhhp/FuTn1lwqDDo69NcWhK8YveHbCsf81dWT2aSQOTHjTrJy?=
 =?us-ascii?Q?15uPvYxs0C/5hlewUwdm48Z9uTaHKyTqaQA5DsQrHW4bqKYe3U1PKbYZ3pfQ?=
 =?us-ascii?Q?fqA7DzHCZvEOH48VwDXkXqPglwwQtd53ydT/rXrX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785d0b22-8fa8-4338-cde8-08ddae982b78
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:44:34.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRbYVOzYIPlpYggw0Dsw7Zws+jr2rgiveSBZK2RgxaBwe70cZgOAvdzKUzKye1/Qaeb5YBFNGRDqVSk4l+W2Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10324

Convert qca,qca7000.txt yaml format.

Additional changes:
- add refs: spi-peripheral-props.yaml, serial-peripheral-props.yaml and
  ethernet-controller.yaml.
- simple spi and uart node name.
- use low case for mac address in examples.
- add check reg choose spi-peripheral-props.yaml or
  spi-peripheral-props.yaml.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v5
- use IRQ_TYPE_EDGE_RISING.
- remove comments in examples.
- add Krzysztof's review tag.
- add Jacob Keller's review tag.

change in v4
- move if into allOf
  move qca,legacy-mode to top and use qca,legacy-mode: false to disallow it
  for uart

change in v3
- move ethernet-controller.yaml# out of if branch

change in v2
- add Ethernet over UART" description here back
- add add check reg choose spi-peripheral-props.yaml
- move spi related properties in if-then branch
- move uart related properies in if-else branch
---
 .../devicetree/bindings/net/qca,qca7000.txt   |  87 --------------
 .../devicetree/bindings/net/qca,qca7000.yaml  | 109 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 110 insertions(+), 88 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/qca,qca7000.txt
 create mode 100644 Documentation/devicetree/bindings/net/qca,qca7000.yaml

diff --git a/Documentation/devicetree/bindings/net/qca,qca7000.txt b/Documentation/devicetree/bindings/net/qca,qca7000.txt
deleted file mode 100644
index 8f5ae0b84eec2..0000000000000
--- a/Documentation/devicetree/bindings/net/qca,qca7000.txt
+++ /dev/null
@@ -1,87 +0,0 @@
-* Qualcomm QCA7000
-
-The QCA7000 is a serial-to-powerline bridge with a host interface which could
-be configured either as SPI or UART slave. This configuration is done by
-the QCA7000 firmware.
-
-(a) Ethernet over SPI
-
-In order to use the QCA7000 as SPI device it must be defined as a child of a
-SPI master in the device tree.
-
-Required properties:
-- compatible	    : Should be "qca,qca7000"
-- reg		    : Should specify the SPI chip select
-- interrupts	    : The first cell should specify the index of the source
-		      interrupt and the second cell should specify the trigger
-		      type as rising edge
-- spi-cpha	    : Must be set
-- spi-cpol	    : Must be set
-
-Optional properties:
-- spi-max-frequency : Maximum frequency of the SPI bus the chip can operate at.
-		      Numbers smaller than 1000000 or greater than 16000000
-		      are invalid. Missing the property will set the SPI
-		      frequency to 8000000 Hertz.
-- qca,legacy-mode   : Set the SPI data transfer of the QCA7000 to legacy mode.
-		      In this mode the SPI master must toggle the chip select
-		      between each data word. In burst mode these gaps aren't
-		      necessary, which is faster. This setting depends on how
-		      the QCA7000 is setup via GPIO pin strapping. If the
-		      property is missing the driver defaults to burst mode.
-
-The MAC address will be determined using the optional properties
-defined in ethernet.txt.
-
-SPI Example:
-
-/* Freescale i.MX28 SPI master*/
-ssp2: spi@80014000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	compatible = "fsl,imx28-spi";
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi2_pins_a>;
-
-	qca7000: ethernet@0 {
-		compatible = "qca,qca7000";
-		reg = <0x0>;
-		interrupt-parent = <&gpio3>;      /* GPIO Bank 3 */
-		interrupts = <25 0x1>;            /* Index: 25, rising edge */
-		spi-cpha;                         /* SPI mode: CPHA=1 */
-		spi-cpol;                         /* SPI mode: CPOL=1 */
-		spi-max-frequency = <8000000>;    /* freq: 8 MHz */
-		local-mac-address = [ A0 B0 C0 D0 E0 F0 ];
-	};
-};
-
-(b) Ethernet over UART
-
-In order to use the QCA7000 as UART slave it must be defined as a child of a
-UART master in the device tree. It is possible to preconfigure the UART
-settings of the QCA7000 firmware, but it's not possible to change them during
-runtime.
-
-Required properties:
-- compatible        : Should be "qca,qca7000"
-
-Optional properties:
-- local-mac-address : see ./ethernet.txt
-- current-speed     : current baud rate of QCA7000 which defaults to 115200
-		      if absent, see also ../serial/serial.yaml
-
-UART Example:
-
-/* Freescale i.MX28 UART */
-auart0: serial@8006a000 {
-	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
-	reg = <0x8006a000 0x2000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&auart0_2pins_a>;
-
-	qca7000: ethernet {
-		compatible = "qca,qca7000";
-		local-mac-address = [ A0 B0 C0 D0 E0 F0 ];
-		current-speed = <38400>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/net/qca,qca7000.yaml b/Documentation/devicetree/bindings/net/qca,qca7000.yaml
new file mode 100644
index 0000000000000..b503c3aa3616b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qca,qca7000.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qca,qca7000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCA7000
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |
+  The QCA7000 is a serial-to-powerline bridge with a host interface which could
+  be configured either as SPI or UART slave. This configuration is done by
+  the QCA7000 firmware.
+
+  (a) Ethernet over SPI
+
+  In order to use the QCA7000 as SPI device it must be defined as a child of a
+  SPI master in the device tree.
+
+  (b) Ethernet over UART
+
+  In order to use the QCA7000 as UART slave it must be defined as a child of a
+  UART master in the device tree. It is possible to preconfigure the UART
+  settings of the QCA7000 firmware, but it's not possible to change them during
+  runtime
+
+properties:
+  compatible:
+    const: qca,qca7000
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  qca,legacy-mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Set the SPI data transfer of the QCA7000 to legacy mode.
+      In this mode the SPI master must toggle the chip select
+      between each data word. In burst mode these gaps aren't
+      necessary, which is faster. This setting depends on how
+      the QCA7000 is setup via GPIO pin strapping. If the
+      property is missing the driver defaults to burst mode.
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+  - if:
+      required:
+        - reg
+
+    then:
+      properties:
+        spi-cpha: true
+
+        spi-cpol: true
+
+        spi-max-frequency:
+          default: 8000000
+          maximum: 16000000
+          minimum: 1000000
+
+      allOf:
+        - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+    else:
+      properties:
+        current-speed:
+          default: 115200
+
+        qca,legacy-mode: false
+
+      allOf:
+        - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet@0 {
+            compatible = "qca,qca7000";
+            reg = <0x0>;
+            interrupt-parent = <&gpio3>;
+            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+            spi-cpha;
+            spi-cpol;
+            spi-max-frequency = <8000000>;
+            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
+        };
+    };
+
+  - |
+    serial {
+        ethernet {
+            compatible = "qca,qca7000";
+            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
+            current-speed = <38400>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2c74753e2df41..ffc80ec9b3d6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20383,7 +20383,7 @@ QUALCOMM ATHEROS QCA7K ETHERNET DRIVER
 M:	Stefan Wahren <wahrenst@gmx.net>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/qca,qca7000.txt
+F:	Documentation/devicetree/bindings/net/qca,qca7000.yaml
 F:	drivers/net/ethernet/qualcomm/qca*
 
 QUALCOMM BAM-DMUX WWAN NETWORK DRIVER
-- 
2.34.1


