Return-Path: <netdev+bounces-239266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA5CC66927
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C771D4EB317
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 23:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8837314B94;
	Mon, 17 Nov 2025 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fHtTLyUG"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020530F53A
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422899; cv=fail; b=gItFGgsUTV3Q7db4mr5YhS9yPPj162qAPv8ebmsOL09EEUmWYJ0h3qUXysKlNA+bpmvu5Awd5fWp+ci0F+Be5bfwUJt+zwdu312hUq2R40dsxXcEg3lMlZsSgCuZcacKJR2bmNoI/qi43MSdAh/yTGIVM17jpyMnUe56qL05mtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422899; c=relaxed/simple;
	bh=DS4YilmNnA8Wbs+2cm+b2eb9vuU8Rd1d7vqiUbbg9vA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fSWbrRNBWmNFt28v/OwpebgDK7X1iZwtLLUwTPLZe+LbTE4OWc5Y/0ewXCCTJNpZ//E9o6dQGPrfAkhfOh32ot4PsJFJ1vHSwAduiemjQFY4Yw3g7RPdTqzed5ydAB7J2yOTXhEcusDfW02cS6rDoKA+BKdeABeoifFl5wQp6yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fHtTLyUG; arc=fail smtp.client-ip=40.107.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnkkBFoDhRbjgGytes3sX37NKIdujDOwwlmWe/V0rOHcSUQIrSzfNYMZZfCT/VhS69CtpRIqnpsuode2wkDLXz+DukUV140W+lwj2hZkmOAJK5D9vpavr2uTibahxb6KDKidiW3162xvBzcqtLKASNeFmUJPgxqyaEoWMw/pOhWwihGT0tvjb+Mv3SoYjsrpVBH7RAdQ1KIHjQ/8xT91m2wsQF5gjwvyjT2fDPi0AbY/UEUCvH18AZ6efrMHs9z7Y7TH/E220sR/ZvUkeo8QYViotlamcfDXXfxUjO27w54EPFndEU/Oz/5Fw2y+noAG/MQHUGkSbl/U5GHAbsAP/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTW/lFpdErd9EzfK6UOcxYq3LKc4iVDfej36eVKHNHQ=;
 b=SeBabcUEe6V7BOD+HtIRQM4oxj06JykjYj1IKGwkFu+7k93NfnefnKLvHC6M+zy791i9EZO9kECUf4r4ylGHttmtXrd6TQInzupTb8WTgTVoetiJlxF0k0grRx54IWJX58bdn2NAQo6+Ib8hwH9AmdIy6xktkgQedvNtFpNjAKg7z+XO0jtCdYkHPl/IaLnhm+8NUTe4d6skH6nc/zixoQ5H4U0FTVQen/alzeE6SKZ6/Bzq6tICzNq9GkX2mm0qdiI4nzjFhYljkCa9t3Q/tU+Qf4FcmtGChxaLgH61PF6bg5FlZYIU+FmCCQ2XAblYu0ejADSrMtgBnNVa+99bqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTW/lFpdErd9EzfK6UOcxYq3LKc4iVDfej36eVKHNHQ=;
 b=fHtTLyUGs7humvPh8yXaYA1Otl4nNAHiuwHcpvZcV8ohsG4FD1VF+1OgXNXTZ6W+GbFE+hZ11cPKM2l+hH/deEGxn7Eogzl7X6a/+J+xNtVbspSDAKe68NnWRGel7OrC1I6NjX1IqpAyRV37FkbkzW3n2b7pwt+GYMJcKyS5JYhHwfdB/Tk8Xui6+vOyEzZ+oXmYDBJ+6gY1aRYJswU/QLM5sgsD6NfDL+VYbeT2Il8VFLKfKYYiq3kncUQrXtd+NpwFrCuCaLnwpj8EhxLM5dA+CXa7WuY4JACqTr1AiDTaTM/psr+c4dgA2cpo0iRCeCWjmjVUKi6mk6VTXEmhNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Mon, 17 Nov
 2025 23:41:33 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 23:41:33 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH v3 net-next 0/6] Disable CLKOUT on RTL8211F(D)(I)-VD-CG
Date: Tue, 18 Nov 2025 01:40:27 +0200
Message-Id: <20251117234033.345679-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::17) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|AM7PR04MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd03527-c5e5-487c-8c8e-08de2632d6e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?235tzXrOhogm0geY6/F5c80pVDBhNYzKPv0PKctiR9+C7ysJfHn3HaOVbkth?=
 =?us-ascii?Q?Hwuv78Ied52XrR5ow2SwuR/++5MWJc03IZVD2SsgWHc5zLGLLrsZ9SmDD4yE?=
 =?us-ascii?Q?w8GtZ+U8ayFBpNlL7Lx+HR8A0QEzgYuL3eVkJbLpvKZS/Z4tXrUEW7qf9tZj?=
 =?us-ascii?Q?7lEasVkn4DsclQrKuwtCPthaC3HUUYCcH95BIX+zZfw9gnxhxjp8Ir4od5uJ?=
 =?us-ascii?Q?qcnUl/5wfU2vGL9/XsPF4eFnd6YQBRZ1ZCl/B4oF+f+MHii2x8r3yP57QA1a?=
 =?us-ascii?Q?piNKvH36QBSYZqy6kj8vPycd1zR+H1EMDutAMV51ofFQYd5/XQ4ZA9PbhhGJ?=
 =?us-ascii?Q?laHjLQMzyK8pfo+kdv060eVCMoivjSeWGrNsqnz/rpFIWI1utZdmSie/H9RT?=
 =?us-ascii?Q?3aOGjNCU4zScvNPB+SaMr++ecbeBU2XTggfUfS42M6buTZGU5o5dpf2DAtTh?=
 =?us-ascii?Q?ATJOUj/KztcearabynKLP0A5OtX9KLeHpV/cHZcsLCvuQztS7F5g7jyzQJcV?=
 =?us-ascii?Q?9C8LXJWHwSHu8cVC3niNDumyXpckWXBGKzM/cMHa6ng0BbE344H2Fq5wf/ue?=
 =?us-ascii?Q?N3JEKGDwcIiIgK4E7yG3afmR3YWSYt6pandpeg8h3F+DzxC9EF3JDSNT/zEN?=
 =?us-ascii?Q?fhxupn+qZa5XI3fVUzTjxmtmNVejX3dNReczQuLUOFWKw9aCN5K+ZuOXb4NO?=
 =?us-ascii?Q?PprQfY5sqRW7WBBQUJfKnndr5XSEvwI58hal0Muq6SLtM4MLzRJNfT3IwAEV?=
 =?us-ascii?Q?zZYIrqdcn1lTjrL8IH/W5i3vr/jDlNzF0HfFROCmsZcqjzHsIeyctW2WDN0o?=
 =?us-ascii?Q?loRVokMbSNyYxny0+sbwQ2fsyXlOYemWbIvUjERlUhAklJpQuGHYikjQd8CG?=
 =?us-ascii?Q?N8rw3dQsDm22NILdf69aiMcqKdnR1+04IqOJ/sLiR9klBpcQLvPTHapBgyHU?=
 =?us-ascii?Q?C+Hor9GRxdXHvoargn8TxMfnjA43Onco/oa92sGoCOGW6eTJbtnfEhZQFwvQ?=
 =?us-ascii?Q?MWzO1MyUEyCLCnB6JzclSI2KD4sA/a7KLAsT/T46nCJYXuhZhkiQZgCz8Dxt?=
 =?us-ascii?Q?WE/d2YsDt26HY9uDMx0au69XL4we6CTs/9fRvT4dgNKa1cXvz9tnTK+Vs4ro?=
 =?us-ascii?Q?acZpkzv4zXZ8UF3stq3saaozlDfiCaVmSGxM6UngOva5GHmvvQfQZUyv8Tc3?=
 =?us-ascii?Q?j54eovI9eFjsSXy/WpwaCt2mru/9TNFoHM7UTJGZ/KHnPu7nc/gklALnBi05?=
 =?us-ascii?Q?qFcxSMtYJlnYmBx3QBQNWq/o5v6UPOTByjbPbcNWYkI4JC4u/7pn5sJ57hwn?=
 =?us-ascii?Q?3rzRG9kIgTGEY/eybHIuDdDF2gjkynVJZR5Z6heSfXbdbG4TJdz62AA86sRU?=
 =?us-ascii?Q?i735EI0CBYCiDMAbbZT+/3rb3qA13QDvhWsM2QuNgIXXVsozGuCs9Ot2ebbi?=
 =?us-ascii?Q?mIDRg381NZggtCHeBuv5L99cXK9uTO+KzRXYuI5+UBYnNwBx3bKGbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ndW+zfapeSSvu0sQ1fJKOhbjVAZGRPm4GFxzNhqQQYkK0/n9YuiERPMZInUy?=
 =?us-ascii?Q?8K88uTm8GTKaIduuAEO8+3QP3OLkJdI933FJ4GAnTeeZ+sjKReOIGSShAHBh?=
 =?us-ascii?Q?rc6whJAXRnRN86csfAChZYDvou7XL9KjkmwYSdnfy/FRwH/uUnM8NjJyLl+5?=
 =?us-ascii?Q?Kg2JdHr3gJBB8v+cdKlVZAtGBYSluLK4g26TgG2jcw1dnil0he3WVKkJwATs?=
 =?us-ascii?Q?Y486AOEJ2i1m5Hdj/M+BqOnzPeV+OwKaN2iMKM21ZJy9UbUK7GOrw4gLFxMR?=
 =?us-ascii?Q?hoZQFlPMb1Fec3QKRE+yiTYYzPqexE4pOBFCqj95ZkBcAjTTsSP3OSZDhvAC?=
 =?us-ascii?Q?3paOFD8+Z+BGggGmK0ZDUk+6rMNU0LcapNy0gLZjwzXy/5AC2/WioRBZoInO?=
 =?us-ascii?Q?G/+IdzrokWfZ3fj2oUu2lkcbg8oj2Y6naneNWJA4t/xSnTrzioX8e+NjtchX?=
 =?us-ascii?Q?LjdbF3KHDrpO3iRVazw8izus5iXmVMXgIrnXltMolLSGhuVHNSk7B7cPVyfP?=
 =?us-ascii?Q?wG/kYUazWEX8CZU+F7CvF220U3gKTzHZZI7ppQNqLBGLMyqzXhK3uby4IKQF?=
 =?us-ascii?Q?iP6mGQ0o9yFFx+UcXtGraQEsPGEG5Lg3ShAqjpF5XTg165TP6vOgup9bRiQ9?=
 =?us-ascii?Q?WWaI1zg+jUYbEmTSNJItktZhCsH/pQB6jrCgo+rb5veRFkOTRpy42oZIlWLR?=
 =?us-ascii?Q?UaOjLBeOzggc9MtDwfNYHu1TRR46APCc9p+fk1s/RqR9gSE2gxJC/lWmqT5G?=
 =?us-ascii?Q?/HzzLaRw//zBcBgeWnHOWWhMQRvbMEhRXugphrbHP+Rw3jpkKGMQZKc+QInO?=
 =?us-ascii?Q?G4OmFCtOUDHQOh74/IWwix1cwiz93d/3HiW3z18V+N+1rshzLhmXeJPIPkAM?=
 =?us-ascii?Q?t5acUrqyN6RzJItbQY9AisTcXxeX0bDJnqhFf7zu8rNi5+Tq0d/xw58zb4F6?=
 =?us-ascii?Q?PgmFzXfIScyNCrL2cPTwd1Ta/cOq2sr2Efh5lcULOfoDmfOsXJD9LLSYXJvw?=
 =?us-ascii?Q?aXwOSAsXNtId2Qw9eE+RwjPjJHzDtKrZLFvra5xWi6PiIzOXxVmaCS5c7xNF?=
 =?us-ascii?Q?Gd1N0bZtW6Lklo5iKRj7R7KGLnbZCMMuvjJ5FaxTFQWhjJoUBhX3DiePzWN9?=
 =?us-ascii?Q?fFCGHK3KzHpc8idHy1DrLFpHChWSo4udSaeDRgxepeOmIin6PiH71fRCoeST?=
 =?us-ascii?Q?KMceLy7z2sUXz+458Q6K1As51S/yBpxP/4fK7COhIC/hkXNMwNg6ChiucfIi?=
 =?us-ascii?Q?qNNFV/gChYUHklYuNfTJZThqqRbZZ0rSjR8ifJbXvUzU9fFgeq6SgcMyqtgg?=
 =?us-ascii?Q?fAwneg/KZx1C38WRw/PA5cWd2SnpSDOz3DJ1oGm1PxYjvbI4vR3nZT4SsV64?=
 =?us-ascii?Q?32TI/P8Oulr/j0pg8KacEIG6xbDs2p4k4EP2JzvgChmSI9KoL1cVwdxil8UN?=
 =?us-ascii?Q?u78M8bJRj8hSBo298gJlFyk9tvV+gTJDaxQvUvUkVGPNq654eEru8+c8t2V6?=
 =?us-ascii?Q?5s6tzk7QAb7LAIky0zs33JaULvR5Q1Z4JNsjxVQccX9VnkbXjhzzYPR3Gmx5?=
 =?us-ascii?Q?O8AMMCGkrWJT/unjlriVlRsp9u2VnTnes+IcGqGXf25aqEoLt1MMYHRtQJej?=
 =?us-ascii?Q?zCMhWaqwUqKzo4xOFsieCgo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd03527-c5e5-487c-8c8e-08de2632d6e0
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 23:41:33.0424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DczXfMPZp+Te2lJXDE83Cst6LUO9QamXtEF6OSv09YRPUKwbaJkSlDIuYfhJ7YqqkxKbUoXwJHMIM11a5twVpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999

The Realtek RTL8211F(D)(I)-VD-CG is similar to other RTL8211F models in
that the CLKOUT signal can be turned off - a feature requested to reduce
EMI, and implemented via "realtek,clkout-disable" as documented in
Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml.

It is also dissimilar to said PHY models because it has no PHYCR2
register, and disabling CLKOUT is done through some other register.

The strategy adopted in this 6-patch series is to make the PHY driver
not think in terms of "priv->has_phycr2" and "priv->phycr2", but of more
high-level features ("priv->disable_clk_out") while maintaining behaviour.
Then, the logic is extended for the new PHY.

Very loosely based on previous work from Clark Wang, who took a
different approach, to pretend that the RTL8211FVD_CLKOUT_REG is
actually this PHY's PHYCR2.

v2 at:
https://lore.kernel.org/netdev/20251107110817.324389-1-vladimir.oltean@nxp.com/

Changes since v2:
- Move genphy_soft_reset() to rtl8211f_config_clk_out()
- Perform the genphy_soft_reset() also for RTL8211FVD.

v1 at:
https://lore.kernel.org/netdev/20251106111003.37023-1-vladimir.oltean@nxp.com/

Changes since v1:
- Apply Andrew's feedback regarding rtl8211f_config_clk_out() function
  naming
- Revisited the control flow that I was commenting on, and found an
  issue with RGMII delay handling which resulted in me declaring war on
  complex control flow schemes, and more specifically in patches 1/6 and
  6/6 which are new. Patch 1/6 is "probably" a bug fix, so it is at the
  top of the list in case the autosel bot wants to pick it up.

Vladimir Oltean (6):
  net: phy: realtek: create rtl8211f_config_rgmii_delay()
  net: phy: realtek: eliminate priv->phycr2 variable
  net: phy: realtek: eliminate has_phycr2 variable
  net: phy: realtek: allow CLKOUT to be disabled on RTL8211F(D)(I)-VD-CG
  net: phy: realtek: eliminate priv->phycr1 variable
  net: phy: realtek: create rtl8211f_config_phy_eee() helper

 drivers/net/phy/realtek/realtek_main.c | 159 ++++++++++++++++---------
 1 file changed, 102 insertions(+), 57 deletions(-)

-- 
2.34.1


