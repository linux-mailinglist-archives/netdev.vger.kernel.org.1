Return-Path: <netdev+bounces-252606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENptFl3ccmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:26:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C800E6F98E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7952303BA59
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EAB2BE05B;
	Fri, 23 Jan 2026 02:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SDgDwIps"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F436E493;
	Fri, 23 Jan 2026 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135018; cv=fail; b=lVAQymcJhF/ghs2UZ87EgpC+m4B43Yim7E+OdIi33hebrIjYWgJqJ56u+hSoBoBnxO/oXKTJspQBx22JBzsI7oux+LsBTiKDLmmV55aCBkNTnh76qaAtVotQAyrkncpCT42LCIRq4seHIbPQnZ3I+wN9Ah8zGnkID+tr2s5ce4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135018; c=relaxed/simple;
	bh=bmMmh0w4BOq31WRsij3wZJGEP/E6AduAZ1d6wUNQjlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jd0Gq2qTLx86yfvja0if4krNUmCqVEOOtyXcOG3pG3gCSXKK0wMUwn5ORkL4nUSd4mXprL7qxjfijmSiMtjq8chxsCp5pfaAjFuBL3dNmBu7H/SwCXj81OeAXeLxVSAZGpngXiah3s2khVpgomNujCgNrNJ/D9sUeJ4jL6OARC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SDgDwIps; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBBL7Hudu1tW9NuPX6giPG7q/+7iF9M2DWo590YIKn9s7yAjSmQR3LCw+MnuwNe70Ni0qdGBSmfACPdwv3JFL6Hosc6fl1hk+rqY2WPEGU5RpXWjJ7ihNV+n3DhjMyU5VMcecKjT9aksjJPMcYFgU4JmZ7Ku3wqqEQrv33uDNTStC6R4HloROliruYqQrLkr88WKBieb0feySFsX0qPrdfX03LMpZndi6GJxIHocVZu85aBX6IAWhCZQxAof9yUt8a4F9mHEXRukHxgXnWB59hOmg9tCmMzpyUWXG06Eft0x+3pzNmZf2RNWva1j+21TTs/+AcWlZ37n9OC4mS9LYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joEZ/nfjW9irnpZXF1HLILnWOm7c8nlWmhV78GDgWlI=;
 b=ZvQo1LI4cCoWoU3hbQd0V4zHoDI/Ux+8nrbaJXEHx+ssMbZbansfOLiGbDv1UojNxPE7vj8KqC6M0XKjMoX9a6IhhYMnv2AuSa9boelmhKNkZafATOUNsNHR50BIrDlLLinL8qi7dlO/bKRrJ1GWabqF3dDrvJy8mjDl5RqIp+ZRKqK+jyqdIoAHuPoUUy9b94FVInLwh8t6+K0l3vWAk3K3zmodeK79JCkSiWXimGkO0KaIQ5B48bOtVJ94g5x8hkF0zLFUlkOqXaZ83yu3c5lQUNJ2I2NnM/gz6ZRDtyTaIM/n55xc4wY3AyUDt63ePNKaYaduLBd7TUOwn8f4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joEZ/nfjW9irnpZXF1HLILnWOm7c8nlWmhV78GDgWlI=;
 b=SDgDwIpsdi3f6E83JJgwbxo9fWHE/Zzo0oOO8tRkrh99IaQHBNRUYEh4nR7rDgP8RK59qorcQr5boGpFpy97IWjiWPepW4eVi/gHOSXsb7tIQGrCXCxVI39nIXlofOeNQlUyw6lYZFCPTR+pWwR29j80vlRGUCQK10/HrtcnnjjzwH6DbKJdJzZ1FB0ne1PT8j6QA56op6P/rNPtfTwVopFoYndpnMy4ufHuDq1pdiVnci/sruhsEsfr9O2orzsxRG/T0HRIUG7EXQihkGCfwPiAewh6MH+LDQudXdKo797gvzwMRoSJI7ptE9XLH4vgHLVEV75FcBzzRoZQY6p7pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:22:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:22:40 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v4 net-next 08/15] net: fec: transmit XDP frames in bulk
Date: Fri, 23 Jan 2026 10:21:36 +0800
Message-Id: <20260123022143.4121797-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123022143.4121797-1-wei.fang@nxp.com>
References: <20260123022143.4121797-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: d51cf2d8-1724-433a-698e-08de5a264864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rWKSjaa9JLX05zqixvo4pM6txfTneLdYxGkYHySYRnuZ5fU+DlPEN/juzQJc?=
 =?us-ascii?Q?lZ2BdzwW/SmW2mIOSW2fpno9iOc5FgWox4vPIEh2XpbEjgVOUAO5Fom8TJM1?=
 =?us-ascii?Q?e7fZeS+VTWJYWwSHxCGfkM9kYCWTbqnG5PdHrcmTUItwgCn2Zo1nkFR15doU?=
 =?us-ascii?Q?k73Z643d52toYfOgBvsCNfXB/KdvnDdepEBaoCXhT+EyaNpDyTc395vHtNrw?=
 =?us-ascii?Q?bYbo5DInjHtIej/f1dHb4TXF+QQ8CwZjC0EgYX6Gxirui5GMuk4XQCF4Fprp?=
 =?us-ascii?Q?0UgyFqPx2l0WlwP1nDYXLMcBXN9NzWisny0r7qKu9FAxCQeQPgsOASb7bXej?=
 =?us-ascii?Q?/5850pz/IBDXWfeQeijKmbCXvjwRb6Wvu0MRCDRs5hQMlBANAF0wbslwXih5?=
 =?us-ascii?Q?+xlnGr1aJtABr9ms77lMrbiBmNrtoSn90Cp7F9dha+f5PM3otfKWeL7esoCy?=
 =?us-ascii?Q?Rs6g2uVf2ip2LPGOvPYeKUNdk5VVD4y7i62j5ViVfpxHB2U29Bb0qeDDn6hq?=
 =?us-ascii?Q?ILDEc7M3SxbivDJMRvQaxpU2zF5ZZxq4a/4U06T9Jc6BajvtDnbg3wPCwkyE?=
 =?us-ascii?Q?WFd1oS1atbYgxkB/5MQSDJoqTNEQ1tYMC8m6JHrU81HTUhbkbp1QBczcKYBT?=
 =?us-ascii?Q?WtEBS3s5IfgjSi1NwiBHzNxXjhHYQmTPmBSujvVozha2H/4vXxzXhQCamLi8?=
 =?us-ascii?Q?/T2RvUFWbnnZRDUTefjK8OYpqkaMC8eg9yHeeQELzb2f0ZXlCvjrcv0KjPPy?=
 =?us-ascii?Q?wJBYB38gem5wOK/z6cVdZ8XGDQRGDN950yLfFmnCtGgc6mnvxdJre6BSFYGE?=
 =?us-ascii?Q?TB0Wpq5Hy7WC/NVEaYqljzXFk3pCUbG4SpGri4QemUSVVR3ErF6RSpb1FDBU?=
 =?us-ascii?Q?Q/VPioXYLheC/u/MloLGxUA1m6FCaldg/5Ze6kWjadd0pYmi+dB3iim6bGgX?=
 =?us-ascii?Q?uDyI4hbA5mC5vJ7x7bwY9/T5sO6+0bHdOG2eHIqVeX7mdFf6QP+o7Zmd5e5v?=
 =?us-ascii?Q?pR6Qf93NrIN5CD6C1DFl+qJubWIuvSdjej4X6ESNJMPfvjqp8DwlXT5tzi4a?=
 =?us-ascii?Q?f50XqTi7Z9VhtrcmhRXsl8U7MKfn1j2BGqcH7F1xb0M8Q6SqPzzmpvMG6DoO?=
 =?us-ascii?Q?XsDE4JTwCIbni4nOujFdJMmNI07uEK4CigQAdyPNIGITDE7riBCENIU20sUB?=
 =?us-ascii?Q?MIYrakWmIHOcICa+oGyP9h59z1TC0tLwy9Zg3XmkYwbI+Y27Q+lE9tIEd2qA?=
 =?us-ascii?Q?uOCVC0xnbgD3EzQ/0DrzmTiHOYio2395rHkCnGbUadawan8ZPrb/OI37RooM?=
 =?us-ascii?Q?t5MhdnQ46h/k/AFXZvjBdIDD7NdKPaKlEPezp7OG11z8T8dSWskSfhed8MnB?=
 =?us-ascii?Q?HsCKSsACItqjL5D9RkRAmK8q/Ne7/Qxc5CA6Cb8Fa+zi+clyNF8lJdyPGAjW?=
 =?us-ascii?Q?Nyogj/aZeDZUm2xkYABllwatDsReYgxcqpQ5l0NB2er0N7L++zeFUUIxtFiI?=
 =?us-ascii?Q?53C/cvgjv4tStR06k+zaXCAuJmjbS/lBv+48bLTDIMcE9XPVmGvAEUbYEsgA?=
 =?us-ascii?Q?G2YhgJP2UNNhOdSAq29Bj9t6uE3BKlHSQHeQHrYfON1US53PveyycHre9dwd?=
 =?us-ascii?Q?xCZJB6Wf1mbQFPovZpbO0f2WtXIeFsCv7vVq2wGLEiXm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YBYZTzcVqjLJaae/iKBTSXgjCHQ/6G5/B7OXHRFT3qJlpr9znDeelDpeiy9U?=
 =?us-ascii?Q?/ZK6XK5TiKM49vLVZ/dav2AAZKy7Eyc6YSamMv+AyGRM3oee6QnsS+LLYgA3?=
 =?us-ascii?Q?EryAIfQmt7f18JzRDvxLYGLmxcZJu9el4RmRFsGIMYfR7MJMDfBIDy7zoQdb?=
 =?us-ascii?Q?4H/pRrChU/hXaloR7aRnmwPxtfz3hknfyoRrQ/cioEt+eNzLr+i0mNsGZZnq?=
 =?us-ascii?Q?xbfQvh26v3SfNqkEH3VHQqv+CDPIu2vz2RTBPlKuD7UwwwUG2IVTjdFgigRf?=
 =?us-ascii?Q?1YfLSp0VAQ2AMkHcoj/hXYChS+XEYzOyKR8WCMWdv6ue+FooM7E58/8d0fkE?=
 =?us-ascii?Q?VlAy+e/sBTAt2ncC3HR/ckBwRTu0ioYm2pDhlSeR1zs9STd9PHasmdzDHICY?=
 =?us-ascii?Q?U9cLhx8UasUoX0Gl8hysb9nQJrAVO+sUB8uRImYoeFR4CtNMwcULS8AhqEyi?=
 =?us-ascii?Q?3Y0ucdLtEs8Kw0VuRwiJeFovV5NllMNjk3/WmrroVrvsMSF3b8g8LXtcDh4i?=
 =?us-ascii?Q?lB31ZkITZXQmG7CQ8R0VSd1vX8AAzIcnATel3vxxyT0+tFWDnlfEDTY8aC2v?=
 =?us-ascii?Q?qDWVZb7HxHofDjZ4nhQBv4sbr/dd3RZlRPIVu2CT8ozro210642t4fwTXU4m?=
 =?us-ascii?Q?7oZ/KwgTDAV6XFYVtNfSTKA1OdrotgnTY8o9DJWqT8zx2szNqdz2Z7Z/5YBz?=
 =?us-ascii?Q?VAN+k+nGR/UbiNNdeJ7GDj9O6oOtSe6amXNJCAX0bsn5XgPKPh2Ap+nmyV1V?=
 =?us-ascii?Q?9GheHFvp25zG2YCbXS/R7CI2OrEkmELVXlQ3b3YsG1AJSQnFAprOvnf1xHio?=
 =?us-ascii?Q?yGolts6wzrDJ2o3BKWF2si8+8CeH22eBTSGh1MvvroJhVTIVA+vbBzaUaYpq?=
 =?us-ascii?Q?Yw9DzMjePGK5ief4b8xhpl/U1MQMrdxajpNPT+BVFNjxC7j5YO0caLauoI3b?=
 =?us-ascii?Q?SnOU8zdY6xwvRFigKwQUNDmRfxtV4/dP+6kJ0Z7Vhz9opMcZI39ejg8OzBxd?=
 =?us-ascii?Q?NmtdEeg6RSQLKUxDxUw/ZgbK8WLb1gmOXaLCnxCoUPYmvJERGgdSeUzJViZW?=
 =?us-ascii?Q?EYRpPOAenpnAtJmiNTZ+f/XWYFxeKUKt/oZXg9u4yGkcDeMh1v12Obo20w5M?=
 =?us-ascii?Q?HHwscHdePcWL/N9d0tABPkugbLUHQa8Wlg2wnlBXkjVC3vfHI4L3Vk/P7zqR?=
 =?us-ascii?Q?oBwX+zHJtVQ0O+WmEEzSZPqFtzEg7nw4oHxjGWCsbwlsyF6wfR2iuJiBrkgL?=
 =?us-ascii?Q?6T+kPSe7UgTXUIaQITUBY6/sO39WSQBam8es1o5PO4fd1CQalo9yLHPnHiKq?=
 =?us-ascii?Q?9NBayqNo/ISf+ZdDDwYPT3OEX0soh11cKjwCQhdf1P/vA8V8+hEscy6Q2T/E?=
 =?us-ascii?Q?9G0wYI0mD49jnY9hS/Syn0Jz0Qo11fbW5NIHc2w8FlDbEIVmjducKiYfjUL1?=
 =?us-ascii?Q?s/NLje+wvq9XLhRcAhvxrK66AAryu97ot41J7Z67zwJM1ykqKl7Zmh0NSgLs?=
 =?us-ascii?Q?mwkBcKJJfyBr3VBqjlsb+ozH0XlVt9cJYz4SIrXtWaF+dSJj8epkLNg9/kiU?=
 =?us-ascii?Q?+aiOsfCJWh7IGPuKsYbsGQHbfBagHfT+ddB1tJt0H3l/+R7SHMyjSRnOfAjy?=
 =?us-ascii?Q?7Y8zdbvXdnl93JRzgg9/ZpWZRghAMIXX7fSI5cadXrwip/0q4oy5RuSoY17x?=
 =?us-ascii?Q?NRQ9bUmHFAeALmK/QRLacrigUGUkN93HN0RUPU/xaY5D+fqer4m5vDGE7akT?=
 =?us-ascii?Q?Mj1mzyJ0Kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51cf2d8-1724-433a-698e-08de5a264864
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:22:40.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkVvvYJ9gAoeIkVCRj/J19cqif/38U9ZzGXjDi5guFCmk8zz+BWPrCkC4CdJe6IWToOolUVT+NXlLSEwzkCnxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252606-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: C800E6F98E
X-Rspamd-Action: no action

Currently, the driver writes the ENET_TDAR register for every XDP frame
to trigger transmit start. Frequent MMIO writes consume more CPU cycles
and may reduce XDP TX performance, so transmit XDP frames in bulk.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index b60c736da027..c927ab5ad8a8 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2006,6 +2006,8 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 				rxq->stats[RX_XDP_TX_ERRORS]++;
 				fec_xdp_drop(rxq, &xdp, sync);
 				trace_xdp_exception(ndev, prog, XDP_TX);
+			} else {
+				xdp_res |= FEC_ENET_XDP_TX;
 			}
 			break;
 		default:
@@ -2055,6 +2057,10 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	if (xdp_res & FEC_ENET_XDP_REDIR)
 		xdp_do_flush();
 
+	if (xdp_res & FEC_ENET_XDP_TX)
+		/* Trigger transmission start */
+		fec_txq_trigger_xmit(fep, fep->tx_queue[tx_qid]);
+
 	return pkt_received;
 }
 
@@ -4036,9 +4042,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 
 	txq->bd.cur = bdp;
 
-	/* Trigger transmission start */
-	fec_txq_trigger_xmit(fep, txq);
-
 	return 0;
 }
 
@@ -4088,6 +4091,9 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 		sent_frames++;
 	}
 
+	if (sent_frames)
+		fec_txq_trigger_xmit(fep, txq);
+
 	__netif_tx_unlock(nq);
 
 	return sent_frames;
-- 
2.34.1


