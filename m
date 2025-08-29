Return-Path: <netdev+bounces-218110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 897C1B3B26F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C747B7FEB
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8E722DFB8;
	Fri, 29 Aug 2025 05:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KPOl2L+V"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A07122B8AB;
	Fri, 29 Aug 2025 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445252; cv=fail; b=CgB76oDCKsaYWyFbElabdPZTcRQ3rLMrtRXWYBffnETa1X+y5/nRk/xU/vH/0I4ax/jukn4uxNwY6Cu7v4zWEyPZVBogh49dRswp5Gd4xiyvn3461mCzTOJGnpGQLfo7clhl5DPJjXlBo8o4TBOoBYloDOtXO3HU/FJ2XNILWOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445252; c=relaxed/simple;
	bh=+eL/Nm6j1hcb8rF3gfXMdzBQBQbR4SQLxw5aEIhCNzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U2mZzm7yNIbl/n2J7bjm8EQR8wsX42v1kOJ6MtjUC3IMhm33muGdyWL1Cf3FOOpofA0bJxmOoPK8cYqFVlakX6sMRh8DJNsirdYK8zLozSWj53x1JtqYzNlQyf+GngI05hFJGsLtEhTm4U6ZOD74J6Ey88LVKW+YK6LWyCfFTec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KPOl2L+V; arc=fail smtp.client-ip=52.101.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkbOdIKywxOv7MGwPIwy30+ukLkVZ6XbWu4yzPzJDqlCttUvRGMxa5ebeszsX3tj1yRueqxJN1qUvp/fGjCz80XXfVaAyka3bFRoVru+HzIqazXOC/++pRb1bAXnKaGV4MVVtoPO/BSvjiJG7nF60N8RAusNLfMIZ3Ip0uerdN6Hb9LVR8FJIcB2tULkbgKVkci8TFijTZwobifjvYdPtKbjX29CRZdZrXeXIM5STd6Qaqo0kDuToz1ycAfVhUm8ZShUTbIhSEPhbIqcwq+/HWaaN2KpXBqo6YFzp29SRBrppWUV96NlNjhRl5KZ7ADAZZzO0Wz2Yz4yBDNkDnB3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBMkF+boKbT0owI8NmRSpuPaenL3b6ZeliLOIgLVOyg=;
 b=vQ7LhG8nLcTLZ3hRfkqy30Da4FhhqERd+onqSQiyg4l/YjcUXeHd/CkqUhiZEzLaxMEOXd3EwhsXs+qzpHZ+HzIscgvghnb7Cgo9GtRdIYn0dFddV7mLz5V6FEpJAI0aeDgAUQprC0ETamyFdQoRpnBGAkUaSzga1H9alnU7TQhP8hstrQqvnpqhu8hPu39kUFGZCmCFb4d3irtQsVw+Vh78YYbkeruAN6WTFCqryZa4ugapSx5j8y9YNGp3MgKiUNnKAPvU5JAz1o9q0LcVlMVL74a60KNu53ORksQsORM+9srl4CesNoyFuIyj+hcINmQwjbX4z5s5RAoxYdjI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBMkF+boKbT0owI8NmRSpuPaenL3b6ZeliLOIgLVOyg=;
 b=KPOl2L+VhfxHvl8fwrxJojnXjQj7ykmLCmH5E6AlT/bePwKIP6yEan211ylf/C6+m60+Ytg4qvDdUbjL0uDw615OMeGbtIsxT5QLS60jCJNNoAR+X2qBq2YSuIvh8D+h39I5S8TARJTQ0JSKbiwep5YpE901XbHqwKaScWlOH79LgjzSYl1d7h5ei7xIAtO2OKADCM74/PvaB6kOMHzcbiANjCOK8FT5g0Gqu5oNRngXhqOcWQ5onICauSnFIRLXPsEcXj73v11wx4TlT1N7ChGTG408I4d6m9RJ426xI9RDef5CA65MTuzWGuF4U4bofvCP14q34UCjrvkT8y1dJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:27:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:27:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 03/14] ptp: add helpers to get the phc_index by of_node or dev
Date: Fri, 29 Aug 2025 13:06:04 +0800
Message-Id: <20250829050615.1247468-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829050615.1247468-1-wei.fang@nxp.com>
References: <20250829050615.1247468-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 792b5dd6-5c62-48b0-b9cd-08dde6bcbe9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ofkl4N2ARNSWe3EDxuFYXJDLI00P7lcPU5oU5GcXUqv8NVLJuqNisJsu2OLB?=
 =?us-ascii?Q?1+QpnEUK1RXZS6DOawDXbpmGOTVSzGDy2ia7nCIc6sPwe6j9uTiXy1f3eGh/?=
 =?us-ascii?Q?iKb1lJUeshFXIA2MMMkfiilLxrpM7Lxi1oaRONCO0BXMN4aeUnM/eBnuciT4?=
 =?us-ascii?Q?vFSSJhm7aZS1+P+tI3jHrDxQ9yIt0czSMPyiIe0gSB+1fJl2EKaojQZzSa2S?=
 =?us-ascii?Q?J0zRFPSCvperDGtIPcQgzrXWg1sd1DMaHJ4TfO9Cj1eO35cfuj5U2Wax/u+I?=
 =?us-ascii?Q?EY0jZ6NGC0jjknaegjxYV8tqN/AXrUyerolwVurcoIyhTu0gtP8EwjyGhDYJ?=
 =?us-ascii?Q?/iZcZP0vnRi2JZNkSN1AULFe5qnjzbHwmGO9liDKFxb77wduUu3zTuY0q7CW?=
 =?us-ascii?Q?Z8R5k02sXP6F4QKJdTCeeWaOsZzwkmG1RIHKzf/Ll1HZDMNIaqJKlvOuViZd?=
 =?us-ascii?Q?Lo5NJVxoKv0XWCfVzNDGw9+K1UL6pGkulFDP+ZrhlLltWOaXkE2aC3jzRy0F?=
 =?us-ascii?Q?P0vWy1VTPLbeYjzZApMhyD9W02m9kry7q/L9SwtuHq1n4PEbmOJWl4X4gFey?=
 =?us-ascii?Q?YBBgINKAwk8Ts+u4blLvk03c1lpC1D+mgU+xErrBUlyEhuwixwVCrcrG6q3d?=
 =?us-ascii?Q?lfPRLAgtHDsCl8wvqgBpeJ5La/AKyaIZnwUY50NVe3dyH9uYnkDulkUuDQ8U?=
 =?us-ascii?Q?HCksTjo2scOGDI1Og65hGhWKqDvpsMDZRhncV++NX2JcPPvsY5R5ZgxIZqL6?=
 =?us-ascii?Q?WWVD3373Gsrce9rvJHnWJibepZYA3SpA1GLfTgpNQHc5Y4P2q0xi+wJZtWzJ?=
 =?us-ascii?Q?v0OXokOBPpKSuaNe9XQH3ObhBOXXAgfS+/Lu6eIa5ynlip5/AqjgMUi5ODkw?=
 =?us-ascii?Q?33k96rhzlBd9gLPziuUBCNaF9lJpmMkj0n6qJrNz0bUr3bQoD+DMThA68X1B?=
 =?us-ascii?Q?E9jI6hANR+XeXenwxc5gBHpT71FII8L1iilXOVZT3O7LuwlCNjXw1ymuH9P7?=
 =?us-ascii?Q?CrgU9sSgEFzMBlRODelrzqY9usiGS7AdAlVpSFF5cOkqr9TFUy7gxcvpvZs8?=
 =?us-ascii?Q?4tE4Oz5G3EjeVXAmAh+11UJDXP7AX5P3HIRPJJvIt9SO/PbNs/dnlgn3iDK+?=
 =?us-ascii?Q?Ukh2F/jwbtXOXw+pnSt2fTB9Dcdb5q4uprlqHEGcTsHOEdBKrWl0kPpg2bzb?=
 =?us-ascii?Q?NHQE8Jrt/WhflYrO+ROEPUrREn5QBapAy5xyZDLvMtUK4jhT6JPSPJ3vd/qb?=
 =?us-ascii?Q?137qUUwylYVLsypxlGZG8hbvJOGDk9oj4zUB2EqaXCImKsGqkMb0jPGDVKvy?=
 =?us-ascii?Q?FV0/O9wOLij1jkzQ1zFT0MzF71fUVZ9HdW19TMa1ao3Xkkybhw/OO8cZhwbH?=
 =?us-ascii?Q?wrXao87jcwZbLBMeS65f5O4KwUmHHiKn2rlU5ARNS5NaYIjPTM7w015c6BO5?=
 =?us-ascii?Q?xv394y2qkKunrt5+d8xG42L9NVSwKzwYUmJIQ/RJ7oXkU1AlVp1HLS7309su?=
 =?us-ascii?Q?7pHRpLNMWTbhblc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sSNA4uFlsuklzJxOdXjiiuAJLpxryXnrQBSD9SEeKU3dsqXM7hEPqxOdlND5?=
 =?us-ascii?Q?1tL4NSCZpxtTJHoctBikk38YamdZx7Q0joFBP1H482cewLFq3vVBNU5YArEt?=
 =?us-ascii?Q?KNKbheovaCwHUACT+PhevqgBKmWRbOLtJmPFh8eLR+cNHfA2PaiAAyGarY9R?=
 =?us-ascii?Q?X4egTVhxgJXyI8XLvUUms2LFZHJBid6dS2ed/49og9FtD/6s9IdmZ3nLIW2j?=
 =?us-ascii?Q?VL7UIeF0JbxpvFI7xPR2Y/aEtPOju7CfwgEUxWLi8IxLrYYBqkwhRfr628I0?=
 =?us-ascii?Q?c8IIxB/4ozLs39tQrEC+DN/tP+U54hH1GEigvXG+EE0Muw5rLrL86FnT2bNS?=
 =?us-ascii?Q?n5LaDN0djzXOx0ZhUtFnk8jdBlCHqVCkugOZTTzQpySe1YL9m14QSLRSa2vN?=
 =?us-ascii?Q?QwNxqaPoqi0hdXO0HvRBBesdcmwoROlRhZm2qNJJR+rGtPd0Gf5a2gYKSJ+I?=
 =?us-ascii?Q?+n7szyfx7subakJg2j+ywHvsWnwmyrscFnhVpxn6z3motNXcaKZRopuEjU4Z?=
 =?us-ascii?Q?ud4mTQR+g4eJH4wu+oSxwcrOeXgW4w2lEw7PKHJ56rekpdraj3zximmTIlHG?=
 =?us-ascii?Q?a9hyACFWC5VMmXRegMKA2ahbJXzO2KxJhweXLuUoqyaDxRhqmcSMI3jx0eKv?=
 =?us-ascii?Q?lpDkQUOsfLrdSx6H2Uj2euHdWdK4h8zUETS8aQQpmBoB7jPQMyZr7NRcKNcK?=
 =?us-ascii?Q?vCRnlewvzCmfRtTKYn944q2PsdqXwrZyFUCNKe47eYAxCL2rmAoEH0V29SEp?=
 =?us-ascii?Q?zypD/UTY0+cGO07QwhAA+rozUVFIXKk+Ym6OV3252Icm2EDbYr5eKMQdvcex?=
 =?us-ascii?Q?jmtIWQ5iRdEk5j5wXf/JyAMK458zNsAdVEGEISCc1J4F+7ZEr0fC7YUAB6oo?=
 =?us-ascii?Q?m+dAiMwGe/qcFMVP7M4jQx4UNx32H2YySNRZ5i+5tuGNxMebclqXAmr/HOGg?=
 =?us-ascii?Q?t+4CWSnk7QlY3/Llwhc1zbuqN83x8tVPabLWNGUnMJnDRAj92cyeMM3Dujle?=
 =?us-ascii?Q?zEaALOe4h6FnIQCMtjxS2JPYpMOpgj17Po0LBlOcWUsXza+4nR4o/pFaqqOQ?=
 =?us-ascii?Q?6/rGS4S2Yb5oEWM21Ra9vlDsv4fecr2QZxUU3GsH1sOmOxk03G69HzxTpMur?=
 =?us-ascii?Q?uzCWf44k3eALXlLwYpT43ES81+tO5XyzGhY54mp+il8Sk+jv/oQv2yOdcAVf?=
 =?us-ascii?Q?WVaMhcB+RqhlUiplyYuf3OgQJgfkLzqZtkeLCGTJbNC0IRezgCudCXTGUn/M?=
 =?us-ascii?Q?k985TZtihZArdqp1cAgQt869FZdDwhcTabe5lvJZOecLTuGTu408327kwJAm?=
 =?us-ascii?Q?ZTdDCeoiEEuGe4GA0TYM8ez69OZx64Snxjzo35aa+SO16KpTg5TossG1bP7h?=
 =?us-ascii?Q?5aLlAw/yL2MXzRP7u5rXreDOi3OQjGBvxqp+/5TSYg+tMid2brlnBuEE6lkK?=
 =?us-ascii?Q?r3iBydzfK+uK64A+gXG1KrHE0jkrnfJIph053jAVVgEARyBrQfjN8leY836j?=
 =?us-ascii?Q?HCjdH9veMRptrFnGjbyV5hX3+OfRS5YfZOVds2JmhLf27RqZiwsu6S+z7Lcf?=
 =?us-ascii?Q?SCCq+3zwVPslyIQgtlUczoBEsbI0FyKcq1GyaOzg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792b5dd6-5c62-48b0-b9cd-08dde6bcbe9e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:27:28.5304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztRCUOhZxo/9YyhpPheI3RtAf/H1zq3bQ6aPunRxDxYotJ76AvzGq0t0vxqoRjGT28+hv8pS1LebF3S0Rrgxmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

Some Ethernet controllers do not have an integrated PTP timer function.
Instead, the PTP timer is a separated device and provides PTP hardware
clock to the Ethernet controller to use. Therefore, the Ethernet
controller driver needs to obtain the PTP clock's phc_index in its
ethtool_ops::get_ts_info(). Currently, most drivers implement this in
the following ways.

1. The PTP device driver adds a custom API and exports it to the Ethernet
controller driver.
2. The PTP device driver adds private data to its device structure. So
the private data structure needs to be exposed to the Ethernet controller
driver.

When registering the ptp clock, ptp_clock_register() always saves the
ptp_clock pointer to the private data of ptp_clock::dev. Therefore, as
long as ptp_clock::dev is obtained, the phc_index can be obtained. So
the following generic APIs can be added to the ptp driver to obtain the
phc_index.

1. ptp_clock_index_by_dev(): Obtain the phc_index by the device pointer
of the PTP device.
2.ptp_clock_index_by_of_node(): Obtain the phc_index by the of_node
pointer of the PTP device.

Also, we can add another API like ptp_clock_index_by_fwnode() to get the
phc_index by fwnode of PTP device. However, this API is not used in this
patch set, so it is better to add it when needed.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v5 changes:
1. Remove the last paragrah of the commit message in v4, which is not
necessary, and collect Reviewed-by tag
v4 changes:
New patch
---
 drivers/ptp/ptp_clock.c          | 53 ++++++++++++++++++++++++++++++++
 include/linux/ptp_clock_kernel.h | 22 +++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 1cc06b7cb17e..2b0fd62a17ef 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/posix-clock.h>
 #include <linux/pps_kernel.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
@@ -477,6 +478,58 @@ int ptp_clock_index(struct ptp_clock *ptp)
 }
 EXPORT_SYMBOL(ptp_clock_index);
 
+static int ptp_clock_of_node_match(struct device *dev, const void *data)
+{
+	const struct device_node *parent_np = data;
+
+	return (dev->parent && dev_of_node(dev->parent) == parent_np);
+}
+
+int ptp_clock_index_by_of_node(struct device_node *np)
+{
+	struct ptp_clock *ptp;
+	struct device *dev;
+	int phc_index;
+
+	dev = class_find_device(&ptp_class, NULL, np,
+				ptp_clock_of_node_match);
+	if (!dev)
+		return -1;
+
+	ptp = dev_get_drvdata(dev);
+	phc_index = ptp_clock_index(ptp);
+	put_device(dev);
+
+	return phc_index;
+}
+EXPORT_SYMBOL_GPL(ptp_clock_index_by_of_node);
+
+static int ptp_clock_dev_match(struct device *dev, const void *data)
+{
+	const struct device *parent = data;
+
+	return dev->parent == parent;
+}
+
+int ptp_clock_index_by_dev(struct device *parent)
+{
+	struct ptp_clock *ptp;
+	struct device *dev;
+	int phc_index;
+
+	dev = class_find_device(&ptp_class, NULL, parent,
+				ptp_clock_dev_match);
+	if (!dev)
+		return -1;
+
+	ptp = dev_get_drvdata(dev);
+	phc_index = ptp_clock_index(ptp);
+	put_device(dev);
+
+	return phc_index;
+}
+EXPORT_SYMBOL_GPL(ptp_clock_index_by_dev);
+
 int ptp_find_pin(struct ptp_clock *ptp,
 		 enum ptp_pin_function func, unsigned int chan)
 {
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 3d089bd4d5e9..7dd7951b23d5 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -360,6 +360,24 @@ extern void ptp_clock_event(struct ptp_clock *ptp,
 
 extern int ptp_clock_index(struct ptp_clock *ptp);
 
+/**
+ * ptp_clock_index_by_of_node() - obtain the device index of
+ * a PTP clock based on the PTP device of_node
+ *
+ * @np:    The device of_node pointer of the PTP device.
+ * Return: The PHC index on success or -1 on failure.
+ */
+int ptp_clock_index_by_of_node(struct device_node *np);
+
+/**
+ * ptp_clock_index_by_dev() - obtain the device index of
+ * a PTP clock based on the PTP device.
+ *
+ * @parent:    The parent device (PTP device) pointer of the PTP clock.
+ * Return: The PHC index on success or -1 on failure.
+ */
+int ptp_clock_index_by_dev(struct device *parent);
+
 /**
  * ptp_find_pin() - obtain the pin index of a given auxiliary function
  *
@@ -425,6 +443,10 @@ static inline void ptp_clock_event(struct ptp_clock *ptp,
 { }
 static inline int ptp_clock_index(struct ptp_clock *ptp)
 { return -1; }
+static inline int ptp_clock_index_by_of_node(struct device_node *np)
+{ return -1; }
+static inline int ptp_clock_index_by_dev(struct device *parent)
+{ return -1; }
 static inline int ptp_find_pin(struct ptp_clock *ptp,
 			       enum ptp_pin_function func, unsigned int chan)
 { return -1; }
-- 
2.34.1


