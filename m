Return-Path: <netdev+bounces-154893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24D8A00441
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785721883ED1
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 06:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26291B87ED;
	Fri,  3 Jan 2025 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gj2yhs8V"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB721BDA91;
	Fri,  3 Jan 2025 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735885408; cv=fail; b=aRBlbXpYeNImLdn3HeurRA5OpU+TqgFGcqGOdYOET88/jl4fNTNy53L0KuxWnsinY1nWr717kU/OGEuj4uG4fCJ/nh4eY3fjzkVkzU2FTqMrx+W3yTP75Tf3d40aAcXbOi9FIj4lhURzUP6vfzRbJAPBQn3urEUzYs52BzxHi1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735885408; c=relaxed/simple;
	bh=3WM6gf6d144fcrw0cpmTs6ssWr3uZc9Abr85XKgHaNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rsBinQJP21dCtdakjDfVOMjKZ2c/i+2Ob1GWbLzYSoJtus2OB3uxY3ikA6t2o4djrftEPd0hj/vgNANkeLQp6ipIFDA+zYGJ+n9yxGmDnatngnX2OxjVGfsj0neyZfjH8R6auWS2M/jHOW5tECEMcwMsm0XXlR2yB6aZ0L/rMVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gj2yhs8V; arc=fail smtp.client-ip=40.107.105.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x84wA4aH09TQRsBpyd0EuIPMKT9hujEWd3p5CAErPjV2/CRIJFFtw0rF0x2+/XkR4vk9Z2+AfHtIXtqn3Je/cr/MIm05Os5fXtGBA8+QW9nq2BQZ20eq5iSBJqXTObWCkiYappVKEY8LPH8XkUcSYhx5ThTc0FWz3oHo1Os6eawQdSgDf+Raqqky+XDVKfCKqVd/KTQ6uAsfNtA77CSQAMHL+YUS7JopEimn4vAkHfa7+rn/KKeL4k28IPKr4nxsAu994ck9hGUB8Q3zczy7SFZ4hQlUM/1p0e9GqwEDFlowdEJdRIvJaY7gHlXuPc78OuOc1QIbxCvJ15+6pIwPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uq57KfeaiJQsMzv4tbxyCcNUdmsqzxYB4eTARgBL3PA=;
 b=DWZWTYtdzXt+9OxV+YcAZYwE78qJgTY5RAuuxeqFbbq08hZwZEq0nbCZjYgwGNSS4SeqWVFCNPZ36MqzrbIF0CvOVcShvcC8F3WycVCag2dFUdW21UeB2pIyGnfyiGyIkOY+WHsHy8RJkmV7u6rJRt7OQO62ha0XxS3QVzAMMOQLRy8eFmUWgigAJlhDpst+u8QBFWI8G0GGf97EUmxkniciewAMpscOGmMGp5mJ0vD9umNCYGM8Pr7kI2i8bj4CZfhd+A13i9gJaE3CnCQgIYE7z1cTxkr5R32+8/e+4pWBHUN/VXF/wnb3UsYbLzwBrz/ys+PBrHB+wmCwOPV5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uq57KfeaiJQsMzv4tbxyCcNUdmsqzxYB4eTARgBL3PA=;
 b=Gj2yhs8VkAkujr+YMrsn38Sn/u6jH2yXy4sIdlLUTVwdKS9ppijUuHgICX2z/aktjj7Z7/VOor2/S5cm/bddpWY2Xl2hntJ6UKG8wcCTrJeGVx8RXpO5lc07QXun02KH5DyXfUA+NvN7g8AmwbT2gr0BXQ2Ize/iQ5YxT0P0oX37UCHKBNdo1nJziS6A2d8f1orJhpcczGPI746Uc18OzF69tfr/64rWcYYM48OVeLAVmsAXG46aJIjUBq1OJf3Cni493Xbe8Y6WCYb81aSOWiGjHCyXs4AmnYcisbcU6F92TwrN/tk2aVBfHzEOF6wzzzQWO/HsWU/v9RHgJgxmIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9331.eurprd04.prod.outlook.com (2603:10a6:10:36d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 06:23:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 06:23:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	christophe.leroy@csgroup.eu
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 05/13] net: enetc: add debugfs interface to dump MAC filter
Date: Fri,  3 Jan 2025 14:06:01 +0800
Message-Id: <20250103060610.2233908-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103060610.2233908-1-wei.fang@nxp.com>
References: <20250103060610.2233908-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 803ec32f-5487-4338-bf6a-08dd2bbf1ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AEXGOpsd7c4fsZu8zRn1E89A7iRBQ7BwEV6dkmp1BXPJbKXCz87TgBwmdSl6?=
 =?us-ascii?Q?x9azDvgpodwTBY3hb7dJRH0jZzt0ucz8sptoa4lbg5b8g9AK7k0y8pRC3Mg8?=
 =?us-ascii?Q?BoOWq7rLcRG3QSfpZD0t2c2UWxF7xw41zky6ey1wg0ej06c/19A5+bHLp8q+?=
 =?us-ascii?Q?ONK42WZ8OKXsJ2/tBn9ijTIIt+gQdGdRHMn39VcwH9u0gBr15IJ3PVFC2kXN?=
 =?us-ascii?Q?uQ9emtHc15FpALUjsBNb+zXs/AHQUZz47fS8jputQm8gvUMib5uxqUIARlmE?=
 =?us-ascii?Q?kif/sAzig0e7hWTH67sUR5iND0ogWii2S5khtcT9liccsHYr2eoZvmLFiDEU?=
 =?us-ascii?Q?iUxTgPZ+lOKiSOdAsudzDdthSs5sHwAtHv4dCu0yE9Xh3hldG+ZXsDWAlyny?=
 =?us-ascii?Q?YVSf7KMTKhjR7+fZkX/9QBb+yD8aUXE2A0UZma+zqItIci3dh5Kyne0rNxi/?=
 =?us-ascii?Q?PO4OUA2QfiSE1YFMIP3827E6ugqnHtiFId+BAoTijxFFRtEKhRxyIjWhWTGD?=
 =?us-ascii?Q?170gShfWA904BqVEaiq79F6S7QyjT70YA3CmOK5TDsf3inhH8o4aJcru7MSW?=
 =?us-ascii?Q?RuKCnW+0nqGOjgytlqyQbWbaeEeUyWP23YdGefrJ7iTXrol+3Q7cUqIZGCAU?=
 =?us-ascii?Q?vP8kFoL9bJ8USZ/mVLwPJFwqUdO+7v8w09SCtSIfqmWaRy1ctPylGpMjMzAS?=
 =?us-ascii?Q?xnrIQT7vARI7v9EDrnhX80xZrad+MUXe2lZklrdfqHuI+ulv3Eqz33EuhaH3?=
 =?us-ascii?Q?CtBepOqf3IrDo2+MD5NiSIsdm0iI2najBuj1pHMsBfThQgsEgX48mh9Id6OT?=
 =?us-ascii?Q?3dkJINtQMxpDk5Vt9xsxZm4zUteO3Xh1fTBPz4RfPeYwMf79xPTQsYBt5lYX?=
 =?us-ascii?Q?50iXSGyRnyLNMdJPqCs8NN3C5QR18FVVBLsn/hB+On1DauyGC0c818b7q4r3?=
 =?us-ascii?Q?nT2uH4Upz+nKGrnX7wxwqcIh0jiCfNhHAK883YNrSGNooui+pw2c0kiHtzyQ?=
 =?us-ascii?Q?2DZKXh2NDw2Eu46c4OfXsXoFdDKtdIBetqHoVFIF+RAHyQbIE2FtHEPhc2sa?=
 =?us-ascii?Q?hKkU2OE4eZiC5AMqOF009dXRXJDmfm/OgJDFoSx2ptKNSOiBrJg8mHl22FE7?=
 =?us-ascii?Q?khxxSAQ89tv7TBGd8WPjWzVHa9pVQTuJwg9K6y/kDcuR1F51X+hFLm3+ySb1?=
 =?us-ascii?Q?DhdVyjzdURHa+vH6aZ5vg7fNJ76ZVZGC/JOO01rY7zvYVLGb7o++mNczd3Yv?=
 =?us-ascii?Q?VXne0ktNX3H5ovKvG9PPF4ieIW3qBjF8zBGN9oh4yVDvBWGwRSedj6cKJM3l?=
 =?us-ascii?Q?WUXKhzbUOTSThnJpBLOvKU0Re0ycunv2AJM6yyv0mvidc6n0WnuwP/cmMua1?=
 =?us-ascii?Q?+zejRYWk28i2fyt1qiSNkzsc4alyqitgCm0kcqb5NiF8YlTSZnYSBoe1uAA0?=
 =?us-ascii?Q?rUEFKxPBuqbEynJy55Y08SMGEqKYMFYU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2e3mpWqCs9ia9Bc/raD4B5o1f0FoGqPBqLYAveS6uTH0RSVxg0usVwxwWuG1?=
 =?us-ascii?Q?2YlQmxZskld6gR64azDBHteqt6zq4O462q8KBjfxModhwiglKhnL5u21F4qi?=
 =?us-ascii?Q?mb+BgeELPrW46nYy3llA2iMVBxNL5dhzwcJj9ty+V801UHLGLrP71cFZNqCY?=
 =?us-ascii?Q?WYiv1B1TPRI3TOko2xGuy3m183nwWhS0GjHKHI5I1NrBAn0/TPwFhNUBI0xr?=
 =?us-ascii?Q?RqoebGxZ2qHxgsby3JzQsspyApGFyWyvu5wAdIiCMHwOGO0eW5Y1/LJNeyxf?=
 =?us-ascii?Q?W/dz9GUMd2dE2JBV3ZLNxMxM1+7wj/o16T+rQp/0IazLjFHWUtcZns+HIOz7?=
 =?us-ascii?Q?gZTG2yRsGgqgwsXUQG1nSt4pjwCwP5whz0/q31NeqTbUcWA1LMXBmWgq/wcF?=
 =?us-ascii?Q?u7TJLP0cCTCAwb9SnXPRDCERgONOoouiQqOgdQOo3jCbPZ3zG1n/q8dU0suQ?=
 =?us-ascii?Q?n+D7+3Q38xhZKsOqxWWx0dleDUONjytBWOhjpM94MLSbuJVb8LHvDimn63mm?=
 =?us-ascii?Q?RfhV50+B3glC1EB8zIadSSM7v2LW9hpRxzPaH4W2wEe5SOE4HAgP+ShO8eEe?=
 =?us-ascii?Q?TCZUfhHc5HC79hWLLdPRHSMAIUQpA84HCb1rG4ONI3PZO7HVH6MVnNd4gMRr?=
 =?us-ascii?Q?0uqNgoVFn1xw3tLmg0NsuageUVVYlcHrkQRzZQjfRdyZ8bttiZ/FAid3icpc?=
 =?us-ascii?Q?BOn+303JTQGoXD4rm2ZXcBSeFW1YWvx8VOacCKFvhBYPOPHofxY7+SLj6OIR?=
 =?us-ascii?Q?NysIvcoNTiB9F/QaQuEn8Q7xV6lVZsuJQ+1FbhoU0Le6sx1fkoLZGrzc3a64?=
 =?us-ascii?Q?kTSedH9Av9FumtLe788ZPgJcJwvRY7dJpS/snmonBjj2UWV7xJWt+gAR/hsm?=
 =?us-ascii?Q?J/eoBnZVAh/qRd9KCT8di0O+I9Za97CVDz6t8gtgCKvMQrr1n2zdRfkMqgIU?=
 =?us-ascii?Q?+j5eu+jcjcjiICGlKTz6+W48eOeWBfMGy5b1gt+aTddQHZDtRPLKV3241J5W?=
 =?us-ascii?Q?x+NwNjzPj7+HCiCXRdg7xdswX70k8+4GLmxn0pDqYxsyFEJpWPQGfq3q22jF?=
 =?us-ascii?Q?d/sDY7rwfQFa3bbEqPu0Uje3Ew/3EI3yj68yLPLjRj6NVNnocu9CowZBSxCN?=
 =?us-ascii?Q?ENOCtuz3spqGw6j4e09g8VUM3OGyFmoFiRGdJNf2FU4NUfYEMB5LFgRv2Vtg?=
 =?us-ascii?Q?5n82y54uc4pCuI/30o5pAvfoMhTmPoRKohKXENznKghgxVfWLOrUb0+Cw4SO?=
 =?us-ascii?Q?xNRN0R8cTvtcsprQgyMlI3nXxYurMtNVfj2i7K3hOIevfbkz6+BNe2rUg2eX?=
 =?us-ascii?Q?q3tPDVg4vOhNxk73jJv613xLYS9g066jiviZXmctOGrMg6hKEhRlCfXfUcVg?=
 =?us-ascii?Q?YLTJztxMD8lsxiGu1N5/dMpTGXd69FRZSbAtErhBeSH1X7awz2maHMaghV87?=
 =?us-ascii?Q?Yevo9pRu7S4/XzdExflOwghDXANindw8QDb+IK+Jc++JbTol/G7cHk04WXBQ?=
 =?us-ascii?Q?fK5NM7/n/tyS1h6nk6K31uXpFlPptYodq5JRxG1yYe+2wC16NRiY6/pHukvT?=
 =?us-ascii?Q?ivQrzRdGcsQxZs9pXlaMf77xwMT3ffT2n4diZ6yX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803ec32f-5487-4338-bf6a-08dd2bbf1ebf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:23:21.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEMeBpjddjhaqmWHIlC6MFfLxMzLxW52IiffgXhZAu66iZCXekBusm6oimkEdnG2/HQ3YKZPcWl7pedujCzwLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9331

ENETC's MAC filter consists of hash MAC filter and exact MAC filter. Hash
MAC filter is a 64-entry hash table consisting of two 32-bit registers.
Exact MAC filter is implemented by configuring MAC address filter table
through command BD ring. The table is stored in ENETC's internal memory
and needs to be read through command BD ring. In order to facilitate
debugging, added a debugfs interface to get the relevant information
about MAC filter.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/Makefile |  1 +
 drivers/net/ethernet/freescale/enetc/enetc.h  |  1 +
 .../ethernet/freescale/enetc/enetc4_debugfs.c | 93 +++++++++++++++++++
 .../ethernet/freescale/enetc/enetc4_debugfs.h | 20 ++++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  4 +
 5 files changed, 119 insertions(+)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h

diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 707a68e26971..f1c5ad45fd76 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -16,6 +16,7 @@ fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
 obj-$(CONFIG_NXP_ENETC4) += nxp-enetc4.o
 nxp-enetc4-y := enetc4_pf.o
+nxp-enetc4-$(CONFIG_DEBUG_FS) += enetc4_debugfs.o
 
 obj-$(CONFIG_FSL_ENETC_VF) += fsl-enetc-vf.o
 fsl-enetc-vf-y := enetc_vf.o
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 4dba91408e3d..ca1bc85c0ac9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -318,6 +318,7 @@ struct enetc_si {
 	struct enetc_mac_filter mac_filter[MADDR_TYPE];
 	struct workqueue_struct *workqueue;
 	struct work_struct rx_mode_task;
+	struct dentry *debugfs_root;
 };
 
 #define ENETC_SI_ALIGN	32
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
new file mode 100644
index 000000000000..3a660c80344a
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2025 NXP */
+
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include "enetc_pf.h"
+#include "enetc4_debugfs.h"
+
+#define is_en(x)	(x) ? "Enabled" : "Disabled"
+
+static void enetc_show_si_mac_hash_filter(struct seq_file *s, int i)
+{
+	struct enetc_si *si = s->private;
+	struct enetc_hw *hw = &si->hw;
+	u32 hash_h, hash_l;
+
+	hash_l = enetc_port_rd(hw, ENETC4_PSIUMHFR0(i));
+	hash_h = enetc_port_rd(hw, ENETC4_PSIUMHFR1(i));
+	seq_printf(s, "SI %d unicast MAC hash filter: 0x%08x%08x\n",
+		   i, hash_h, hash_l);
+
+	hash_l = enetc_port_rd(hw, ENETC4_PSIMMHFR0(i));
+	hash_h = enetc_port_rd(hw, ENETC4_PSIMMHFR1(i));
+	seq_printf(s, "SI %d multicast MAC hash filter: 0x%08x%08x\n",
+		   i, hash_h, hash_l);
+}
+
+static int enetc_mac_filter_show(struct seq_file *s, void *data)
+{
+	struct maft_entry_data maft_data;
+	struct enetc_si *si = s->private;
+	struct enetc_hw *hw = &si->hw;
+	struct maft_keye_data *keye;
+	struct enetc_pf *pf;
+	int i, err, num_si;
+	u32 val;
+
+	pf = enetc_si_priv(si);
+	num_si = pf->caps.num_vsi + 1;
+
+	val = enetc_port_rd(hw, ENETC4_PSIPMMR);
+	for (i = 0; i < num_si; i++) {
+		seq_printf(s, "SI %d Unicast Promiscuous mode: %s\n",
+			   i, is_en(PSIPMMR_SI_MAC_UP(i) & val));
+		seq_printf(s, "SI %d Multicast Promiscuous mode: %s\n",
+			   i, is_en(PSIPMMR_SI_MAC_MP(i) & val));
+	}
+
+	/* MAC hash filter table */
+	for (i = 0; i < num_si; i++)
+		enetc_show_si_mac_hash_filter(s, i);
+
+	if (!pf->num_mfe)
+		return 0;
+
+	/* MAC address filter table */
+	seq_puts(s, "Show MAC address filter table\n");
+	for (i = 0; i < pf->num_mfe; i++) {
+		memset(&maft_data, 0, sizeof(maft_data));
+		err = ntmp_maft_query_entry(&si->ntmp.cbdrs, i, &maft_data);
+		if (err)
+			return err;
+
+		keye = &maft_data.keye;
+		seq_printf(s, "Entry %d, MAC: %pM, SI bitmap: 0x%04x\n", i,
+			   keye->mac_addr, le16_to_cpu(maft_data.cfge.si_bitmap));
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);
+
+void enetc_create_debugfs(struct enetc_si *si)
+{
+	struct net_device *ndev = si->ndev;
+	struct dentry *root;
+
+	root = debugfs_create_dir(netdev_name(ndev), NULL);
+	if (IS_ERR(root))
+		return;
+
+	si->debugfs_root = root;
+
+	debugfs_create_file("mac_filter", 0444, root, si, &enetc_mac_filter_fops);
+}
+
+void enetc_remove_debugfs(struct enetc_si *si)
+{
+	debugfs_remove_recursive(si->debugfs_root);
+	si->debugfs_root = NULL;
+}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h
new file mode 100644
index 000000000000..96caca35f79d
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright 2025 NXP */
+
+#ifndef __ENETC4_DEBUGFS_H
+#define __ENETC4_DEBUGFS_H
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+void enetc_create_debugfs(struct enetc_si *si);
+void enetc_remove_debugfs(struct enetc_si *si);
+#else
+static inline void enetc_create_debugfs(struct enetc_si *si)
+{
+}
+
+static inline void enetc_remove_debugfs(struct enetc_si *si)
+{
+}
+#endif
+
+#endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 6ec849949267..6de571b5b425 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -8,6 +8,7 @@
 #include <linux/unaligned.h>
 
 #include "enetc_pf_common.h"
+#include "enetc4_debugfs.h"
 
 #define ENETC_SI_MAX_RING_NUM	8
 
@@ -1169,6 +1170,8 @@ static int enetc4_pf_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_netdev_create;
 
+	enetc_create_debugfs(si);
+
 	return 0;
 
 err_netdev_create:
@@ -1186,6 +1189,7 @@ static void enetc4_pf_remove(struct pci_dev *pdev)
 	struct enetc_si *si = pci_get_drvdata(pdev);
 	struct enetc_pf *pf = enetc_si_priv(si);
 
+	enetc_remove_debugfs(si);
 	enetc4_pf_netdev_destroy(si);
 	enetc4_pf_free(pf);
 	destroy_workqueue(si->workqueue);
-- 
2.34.1


