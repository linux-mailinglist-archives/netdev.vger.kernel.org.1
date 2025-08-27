Return-Path: <netdev+bounces-217177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9F3B37AF4
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B431B67E50
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7446314A9D;
	Wed, 27 Aug 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E028wjaE"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A19314A69;
	Wed, 27 Aug 2025 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277727; cv=fail; b=Nimr5mXda+4ca86EdZiQz0NibP8QrhoSoNnY8kGFbbAWVosqmQIg5HwXA5PQx+nr2j0ftY9m5byPLHuU7QlBtTAbjmO2+KfULdTOC8RoRf2fmbCgiKLcv5dIPKRuRtCw9FVljbRQYZQY49Hnbiy9O+/6zagyWaKkVb6n9CjVPPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277727; c=relaxed/simple;
	bh=0NIaQzCxSzZYVi7zOjBB6kwCuKz0YCAqrbQzu5I9fKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uz3aOLgYXIdt0ApKUpHhPo0c0n1BoaMCNpY7I1c2gMjOcgC7pxSj0uhLasrJZxU8K9HfcChD54kdbJNv42yqC2c2vxpn6iQUaKc2NrxsnAK0bIhgugxdbDZloFInBCt6HY+tYsv7J/p67I2UnTiNPEk62TBEbeXLpvekSCt7hSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E028wjaE; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgDbodRUEZXwJ7EwaNfZjGB/zhNY7vjYIcvt0r05u8EwTme87ccxj1q+7PZFPiJ6kNZiNJyLvyENR/RsWMQsy+jrGpWRx6Cx45lXsP8UBzB1vOboA4mBrgML5v1HWWlRc8l3t2nHaOwCH3hlPVEXNIx8IXbRqn9CNHN1rCDaoAGizDm3yEUmIN04VA8q3Tk36zU9N5PmibHoNULD2XEIkQM+xcQvrXqozW7yaalCf+pafAFiN38YT0PURMe7eEUNezlorx9KqsyQneycAjCkrfCcQkGQcIrn0BxjNCQnByi5DiMoY/6JUAh28c7D3e0KEFzfBeEKIATulzaxGZjOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhzkM+FCHFddd9zy+xiLivBYascmIqaX3cjc3Rd8Rgk=;
 b=VVyn8fOXd0fg0PHJInDoFZINUQax6pISPC9JkKa1RWyqJ1YFASNZwIlV6Y7BnNb+qWgVSceWac7XF3GnAK6XO2Wv+IoGr/0nDDbNCv+apzYQIfAJLSiYsac354Izuv0dhbvMSCoCMPWxjxLkNZIuBdvl1pwFA2dN3RBXNL1jmXlGXJc5fT4POGqv7PAMuXLtwjdo6zblEqxMQxGrTf+ajgf6HN1uNvkF/dPOxlFIAKAsENNQDP+2M+YUuYqE1NneX/90V/jUji0TxTULDckHdIm31WeAbKCeI/9dGCTdNRIqlsn0/J0b71OhvjMFoYjqmodTKKrwiYtbORFxpYQV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhzkM+FCHFddd9zy+xiLivBYascmIqaX3cjc3Rd8Rgk=;
 b=E028wjaEABNqXpr5k/M93j+NTiFMQwJ0QDi7rZp+OugPSDHbeoGXgAP/gx+8G37/vB5Y6+zX//uYYzWaNV0mcq4kQa7BhbYPRaR3VWOiyUJsFwsN5fpoTRhAtzm7TN54jaj0n3ce0ajAhBg4/MqiIYyabrzddxhLnDr1CfMb5uZhc4TqKbHpEzmcnP+noEP7GMN2XmPl6g1NJ2iXAw3lg+Ols4QjURfxPoq1bO6JdbAWn1MV5aogIcXfI0iDdnOB+ZA4beGiVxvChWoc/Y6Aj/80UzcXgrCPzXrlXyDR0OsBquRe9EWLEMEPJosVgI96E55/4WHVyEr3zv0dWtSAng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 06:55:22 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:55:22 +0000
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
Subject: [PATCH v6 net-next 05/17] ptp: netc: add NETC V4 Timer PTP driver support
Date: Wed, 27 Aug 2025 14:33:20 +0800
Message-Id: <20250827063332.1217664-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: 537407a7-f0c6-46ee-7bac-08dde536b00f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OwdJ8GAhlBfhYpxzVQARAtx8Kqp8oKfRHco8+StAulsgZnvtBiZH7sVgEQXL?=
 =?us-ascii?Q?XHcfr9BRa6ngYWCApbZi4mn7wxZZ/8/U8USFyjENJYFbDcwea+N9zfXnEdS+?=
 =?us-ascii?Q?FitypHGLwK082MB82bhJYZRhulpgh0PumAN4tNOwvzdbkySxPR6hq9wAz5Zk?=
 =?us-ascii?Q?nd1czHBHsGAQJq4M5VwAZH72DOYMx3qnpt2Xk0EYee9+3q08qaq1zftoyfNl?=
 =?us-ascii?Q?aLYow2zdemrwmIMuSG9NH1xT9KHm7mxX2skfLNbFnLAeVtrGrUZl0WiC66Ww?=
 =?us-ascii?Q?sIqpIOJpBhscxK4Q06tOHPzlaZnuv8sdY85QwmcMGAeQkpYYd/ZqhFNugBgW?=
 =?us-ascii?Q?Whnyd/SyWMBrxF442x9+vU9Qve1abhq7WGTFhubbQgCbW82kacAPkf831VaU?=
 =?us-ascii?Q?nx9OQGFGSQkYLVZ4Zhl42TqC343HghcqXUaP6c9hacx1J29hTQ6B/Y6OowFJ?=
 =?us-ascii?Q?eOU9s0MOgGeo49rNrVlpC2lBocjvmoJ6Up1zEcYAjfqCDVgXGUMwmAqrc+jh?=
 =?us-ascii?Q?olCdasKRpDPgToPEXTzbcpQLB8NXd5i9loUZY2JktgFZV6o1ocMKrL8TfT2G?=
 =?us-ascii?Q?HWUNUMpLkCsv1/1WbGmM7rYH2/KmFC9/DUt+ozvMIP9HrlaEckqOazCwR5ap?=
 =?us-ascii?Q?aDMcjXpRBQ/1tR1ZGj7Taa2A1EyUsD3TcRWQiXRjTohFDIgnAIyyhh8cBH0J?=
 =?us-ascii?Q?EOp7sc1B7BHgBDL7L9UqGTptLSXAKj5dJRE4YdcuGRB44m+PRIji58LD9p8v?=
 =?us-ascii?Q?/9HLP/jEA1FcjyHoyAxWYu/IZ2MF4W2iXf/DAXhSfcNg4JHTE30UKri0p3uN?=
 =?us-ascii?Q?79AKgIaP3rYxCBzdjpczKe0tJw9HPQ0XwKfhLVkHn2LkP2pQWsCUEysHNlYs?=
 =?us-ascii?Q?bYNclnDsuVEb2Rfb758ORFt79fqiwG7iq+r117g7rjUzGIcZuBZeB06Y2xx+?=
 =?us-ascii?Q?ILf/RMH90Y5o5ITBfdOP54GEsSOc/siPy71VHBL+mneTm1ep94xopwJxfIu0?=
 =?us-ascii?Q?iDbFMBRCfsRbIx8S7B2pZN/oii4ArJqQbC6WabX6arUYTZCN8U08ZDXH50So?=
 =?us-ascii?Q?KjfiC7j52iEM+Er6suEjePwnsuGiTHsI3vMWjNVJLjVOM9/MPPywJdjlPzen?=
 =?us-ascii?Q?MLjUbDPZ2c2iWwZV503/Yz7wHl5MmtbnNM6Wg9bleoSBBTb72KTHdqO7VZ45?=
 =?us-ascii?Q?naMzNNzYU+lmlD29CztyHePeilxc/mC17tUR9luG5mV8slGeiAa9fBCVi3N9?=
 =?us-ascii?Q?Nd9IC2Mdd1R4ThBxQNB+AiPV8foNPT1AR5YPx23XT+793LXUgbrc9BaCiFGf?=
 =?us-ascii?Q?4lWEjDiq037DSsccqaP6xDRXwCCBF5kU8LX7qX43mum3MttoQl70zqA03Zqs?=
 =?us-ascii?Q?S6rIE/zl/nfshr8/uqZR0VGFz5F3zELT7gOAwjxf4WjTSreqMM4rLguo3+OI?=
 =?us-ascii?Q?br/mkNgy2nJ9HKSoMmAhfyPjjo9p3lAkw1LNGUzR2PME1SEr9VI6vmae0g1a?=
 =?us-ascii?Q?QWPX81lkFC9I7sw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tp5JByQRzS20+Lp2ViHa8OqLTaRKfc07+dOHtTfuxc8CFJuaWErUwqbKj+V6?=
 =?us-ascii?Q?VqCJWTaE+rSGi5clWd9XFNJeeIs1ab3E6sHcIz5XlHv6mnEtvV4dX0EdBCdo?=
 =?us-ascii?Q?60H40R1U4rRSg0MOJ6+mYXobC/Hb+z1Uysm8lzRxFg6ui+NlIJuVz+HdQPZ6?=
 =?us-ascii?Q?jZ3jYVu+x4/7N5ljE2gcplSr8FZDX6s7IZl/LySK2ZBT8uad6GT0j+KYj6yf?=
 =?us-ascii?Q?rhdz1Tsd+uWcfd7tjW6ChddUuJ2V0fl2dWh2PBV31lKQSu47Qd8WwkiW46Dd?=
 =?us-ascii?Q?GgSTQDLTxJ7xcEBV8LRxGYlZXjrWfZoekWfpHFvDxFVQ9w04GIN8MTHK8Amn?=
 =?us-ascii?Q?jePLNSnwwkJbyhgPAW4EPjXIWapgupYD0YTT806r0tW9DbMKqijkxzRl2p3M?=
 =?us-ascii?Q?n9ToO+0Eskfe4MhX/rCl4N8+KpzbB+y63UvKspc19TkMa3+KJzzlOgtRviIu?=
 =?us-ascii?Q?bhHSeqXTYOH9DGZpkpuNR2BUcLQjlLTbJc70kK2nQdI/dg7siNNhRlWJs4RG?=
 =?us-ascii?Q?YE2fiuKsHpw3heWcIr8C/yPiEsj9TXvk1z0SFTCwgqD/vl618s+ha/juT9K6?=
 =?us-ascii?Q?4JpOkQampVjZ1NpPc3biQmUQ6C6UpEAGSUU3UcvnuYh1Hrw9A0pu+R7p/Uvt?=
 =?us-ascii?Q?/vDxSdzuIlWleD4yTgpJU+IdT9FDLvNhrnSld/nNByLCF5fwGh+R79wuiCnv?=
 =?us-ascii?Q?z2WByBHBglfnjgOTVWYHXuq38XZHgShJiGoJ7wkpz4sC0EcJMhbIz8Fa3MGw?=
 =?us-ascii?Q?VOhqRIwgyAVOD/mkU5FNP+zTi45x2lWlMqWiKkOpS5VDLHRmI9MfQvXKmCv6?=
 =?us-ascii?Q?pAOzwtRJmVuqbEgYVTh6atJKfs1Z2VhBXeFjnasB/wbpmwkZM7v+q0tm2wRc?=
 =?us-ascii?Q?kxX8cZYdoTjbNN7LV6TxgkI29Y8+5QylC+MZ+7bz9UYa/I7cEKD/e/hg4EYn?=
 =?us-ascii?Q?rw+/2nDJr9fT1CKsuqEv4Wq38426gnsoXBsd/CLfiADdTnSw53d9Y/F+OeEF?=
 =?us-ascii?Q?mSPhU3GiyBU67Lip2Ic4maQt0n9/bxCapsb2+IsCu4psfK60QwAgm/aCdp1X?=
 =?us-ascii?Q?0ZKGAsB151zmqfmW59Xagc167QZ6YY279nMZahcBAERytkhs05oE1eTvKRb5?=
 =?us-ascii?Q?h5uAtiXxR2gV/f1bzGU9UX4zMAVnqtjjbYglXXDUP57G7tzpna9CVhYtDRXE?=
 =?us-ascii?Q?a+Wl1ugx6T2Vw89oZcXvqI5JtZQHTHX1zdcRMxOgShKkzn9+wXITPFn4IlBX?=
 =?us-ascii?Q?so3PzPaPCfZqYyveLaDLCCHaCrD78r5BpSw30V3TH0VEQsEBF1YYoSX9IukQ?=
 =?us-ascii?Q?BIAgw4hbaOKBIr8bFPjLDBss/5M4PWu8SlstvH9wSItAA81elBcp7vn25Ryc?=
 =?us-ascii?Q?y1TwWq8qubeTJcftauhCKv/3a58nuCfMQB9Xyvf2P3d3QUSZaRge+JEIQsq3?=
 =?us-ascii?Q?xZZD6Q6tU4WvvAP5bkP1hoxhltAUg6M47f7c745jNtbelk8T7zy8WHfEiTOX?=
 =?us-ascii?Q?gk7113L3HuwPzpMd/qHRWBBx89SYTw9C3UGfXY6O6QzFDOX+f8hAT4e9rGeR?=
 =?us-ascii?Q?wPxJ+c2nFIvZ4j1jEKnX7Y4Fg+kqPYWqVQswDo5k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537407a7-f0c6-46ee-7bac-08dde536b00f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:55:21.5149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1/H4QCj0vF3ypknH02C+Dgik+sbI4SWzFqbLG64dwv04Lwwh2cRuBcWj0JQ0j9WN+5kStiuoIQ7Eo6bvCy09g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

NETC V4 Timer provides current time with nanosecond resolution, precise
periodic pulse, pulse on timeout (alarm), and time capture on external
pulse support. And it supports time synchronization as required for
IEEE 1588 and IEEE 802.1AS-2020.

Inside NETC, ENETC can capture the timestamp of the sent/received packet
through the PHC provided by the Timer and record it on the Tx/Rx BD. And
through the relevant PHC interfaces provided by the driver, the enetc V4
driver can support PTP time synchronization.

In addition, NETC V4 Timer is similar to the QorIQ 1588 timer, but it is
not exactly the same. The current ptp-qoriq driver is not compatible with
NETC V4 Timer, most of the code cannot be reused, see below reasons.

1. The architecture of ptp-qoriq driver makes the register offset fixed,
however, the offsets of all the high registers and low registers of V4
are swapped, and V4 also adds some new registers. so extending ptp-qoriq
to make it compatible with V4 Timer is tantamount to completely rewriting
ptp-qoriq driver.

2. The usage of some functions is somewhat different from QorIQ timer,
such as the setting of TCLK_PERIOD and TMR_ADD, the logic of configuring
PPS, etc., so making the driver compatible with V4 Timer will undoubtedly
increase the complexity of the code and reduce readability.

3. QorIQ is an expired brand. It is difficult for us to verify whether
it works stably on the QorIQ platforms if we refactor the driver, and
this will make maintenance difficult, so refactoring the driver obviously
does not bring any benefits.

Therefore, add this new driver for NETC V4 Timer. Note that the missing
features like PEROUT, PPS and EXTTS will be added in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v5 changes:
1. Remove the changes of netc_global.h and add "linux/pci.h" to
   ptp_netc.c
2. Modify the clock names in timer_clk_src due to we have renamed them
   in the binding doc
3. Add a description of the same behavior for other H/L registers in the
   comment of netc_timer_cnt_write().
v4 changes:
1. Remove NETC_TMR_PCI_DEVID
2. Fix build warning: "NSEC_PER_SEC << 32" --> "(u64)NSEC_PER_SEC << 32"
3. Remove netc_timer_get_phc_index()
4. Remove phc_index from struct netc_timer
5. Change PTP_NETC_V4_TIMER from bool to tristate
6. Move devm_kzalloc() at the begining of netc_timer_pci_probe()
7. Remove the err log when netc_timer_parse_dt() returns error, instead,
   add the err log to netc_timer_get_reference_clk_source()
v3 changes:
1. Refactor netc_timer_adjtime() and remove netc_timer_cnt_read()
2. Remove the check of dma_set_mask_and_coherent()
3. Use devm_kzalloc() and pci_ioremap_bar()
4. Move alarm related logic including irq handler to the next patch
5. Improve the commit message
6. Refactor netc_timer_get_reference_clk_source() and remove
   clk_prepare_enable()
7. Use FIELD_PREP() helper
8. Rename PTP_1588_CLOCK_NETC to PTP_NETC_V4_TIMER and improve the
   help text.
9. Refine netc_timer_adjtime(), change tmr_off to s64 type as we
   confirmed TMR_OFF is a signed register.
v2 changes:
1. Rename netc_timer_get_source_clk() to
   netc_timer_get_reference_clk_source() and refactor it
2. Remove the scaled_ppm check in netc_timer_adjfine()
3. Add a comment in netc_timer_cur_time_read()
4. Add linux/bitfield.h to fix the build errors
---
 drivers/ptp/Kconfig    |  11 ++
 drivers/ptp/Makefile   |   1 +
 drivers/ptp/ptp_netc.c | 419 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 431 insertions(+)
 create mode 100644 drivers/ptp/ptp_netc.c

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 204278eb215e..9256bf2e8ad4 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -252,4 +252,15 @@ config PTP_S390
 	  driver provides the raw clock value without the delta to
 	  userspace. That way userspace programs like chrony could steer
 	  the kernel clock.
+
+config PTP_NETC_V4_TIMER
+	tristate "NXP NETC V4 Timer PTP Driver"
+	depends on PTP_1588_CLOCK
+	depends on PCI_MSI
+	help
+	  This driver adds support for using the NXP NETC V4 Timer as a PTP
+	  clock, the clock is used by ENETC V4 or NETC V4 Switch for PTP time
+	  synchronization. It also supports periodic output signal (e.g. PPS)
+	  and external trigger timestamping.
+
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 25f846fe48c9..8985d723d29c 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
 obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
 obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
+obj-$(CONFIG_PTP_NETC_V4_TIMER)		+= ptp_netc.o
diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
new file mode 100644
index 000000000000..defde56cae7e
--- /dev/null
+++ b/drivers/ptp/ptp_netc.c
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC V4 Timer driver
+ * Copyright 2025 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/fsl/netc_global.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/ptp_clock_kernel.h>
+
+#define NETC_TMR_PCI_VENDOR_NXP		0x1131
+
+#define NETC_TMR_CTRL			0x0080
+#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
+#define  TMR_CTRL_TE			BIT(2)
+#define  TMR_COMP_MODE			BIT(15)
+#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+
+#define NETC_TMR_CNT_L			0x0098
+#define NETC_TMR_CNT_H			0x009c
+#define NETC_TMR_ADD			0x00a0
+#define NETC_TMR_PRSC			0x00a8
+#define NETC_TMR_OFF_L			0x00b0
+#define NETC_TMR_OFF_H			0x00b4
+
+#define NETC_TMR_FIPER_CTRL		0x00dc
+#define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
+#define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
+
+#define NETC_TMR_CUR_TIME_L		0x00f0
+#define NETC_TMR_CUR_TIME_H		0x00f4
+
+#define NETC_TMR_REGS_BAR		0
+
+#define NETC_TMR_FIPER_NUM		3
+#define NETC_TMR_DEFAULT_PRSC		2
+
+/* 1588 timer reference clock source select */
+#define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
+#define NETC_TMR_SYSTEM_CLK		1 /* enet_clk_root/2, from CCM */
+#define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
+
+#define NETC_TMR_SYSCLK_333M		333333333U
+
+struct netc_timer {
+	void __iomem *base;
+	struct pci_dev *pdev;
+	spinlock_t lock; /* Prevent concurrent access to registers */
+
+	struct ptp_clock *clock;
+	struct ptp_clock_info caps;
+	u32 clk_select;
+	u32 clk_freq;
+	u32 oclk_prsc;
+	/* High 32-bit is integer part, low 32-bit is fractional part */
+	u64 period;
+};
+
+#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
+#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
+#define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
+
+static const char *const timer_clk_src[] = {
+	"ccm",
+	"ext"
+};
+
+static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
+{
+	u32 tmr_cnt_h = upper_32_bits(ns);
+	u32 tmr_cnt_l = lower_32_bits(ns);
+
+	/* Writes to the TMR_CNT_L register copies the written value
+	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
+	 * register copies the values written into the shadow TMR_CNT_H
+	 * register. Contents of the shadow registers are copied into
+	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
+	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
+	 * register first. Other H/L registers should have the same
+	 * behavior.
+	 */
+	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
+	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
+}
+
+static u64 netc_timer_offset_read(struct netc_timer *priv)
+{
+	u32 tmr_off_l, tmr_off_h;
+	u64 offset;
+
+	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
+	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
+	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
+
+	return offset;
+}
+
+static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
+{
+	u32 tmr_off_h = upper_32_bits(offset);
+	u32 tmr_off_l = lower_32_bits(offset);
+
+	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
+	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
+}
+
+static u64 netc_timer_cur_time_read(struct netc_timer *priv)
+{
+	u32 time_h, time_l;
+	u64 ns;
+
+	/* The user should read NETC_TMR_CUR_TIME_L first to
+	 * get correct current time.
+	 */
+	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
+	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
+	ns = (u64)time_h << 32 | time_l;
+
+	return ns;
+}
+
+static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
+{
+	u32 fractional_period = lower_32_bits(period);
+	u32 integral_period = upper_32_bits(period);
+	u32 tmr_ctrl, old_tmr_ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
+				    TMR_CTRL_TCLK_PERIOD);
+	if (tmr_ctrl != old_tmr_ctrl)
+		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+
+	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static int netc_timer_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	u64 new_period;
+
+	new_period = adjust_by_scaled_ppm(priv->period, scaled_ppm);
+	netc_timer_adjust_period(priv, new_period);
+
+	return 0;
+}
+
+static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	unsigned long flags;
+	s64 tmr_off;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	/* Adjusting TMROFF instead of TMR_CNT is that the timer
+	 * counter keeps increasing during reading and writing
+	 * TMR_CNT, which will cause latency.
+	 */
+	tmr_off = netc_timer_offset_read(priv);
+	tmr_off += delta;
+	netc_timer_offset_write(priv, tmr_off);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int netc_timer_gettimex64(struct ptp_clock_info *ptp,
+				 struct timespec64 *ts,
+				 struct ptp_system_timestamp *sts)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	unsigned long flags;
+	u64 ns;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	ptp_read_system_prets(sts);
+	ns = netc_timer_cur_time_read(priv);
+	ptp_read_system_postts(sts);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	*ts = ns_to_timespec64(ns);
+
+	return 0;
+}
+
+static int netc_timer_settime64(struct ptp_clock_info *ptp,
+				const struct timespec64 *ts)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	u64 ns = timespec64_to_ns(ts);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	netc_timer_offset_write(priv, 0);
+	netc_timer_cnt_write(priv, ns);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static const struct ptp_clock_info netc_timer_ptp_caps = {
+	.owner		= THIS_MODULE,
+	.name		= "NETC Timer PTP clock",
+	.max_adj	= 500000000,
+	.n_pins		= 0,
+	.adjfine	= netc_timer_adjfine,
+	.adjtime	= netc_timer_adjtime,
+	.gettimex64	= netc_timer_gettimex64,
+	.settime64	= netc_timer_settime64,
+};
+
+static void netc_timer_init(struct netc_timer *priv)
+{
+	u32 fractional_period = lower_32_bits(priv->period);
+	u32 integral_period = upper_32_bits(priv->period);
+	u32 tmr_ctrl, fiper_ctrl;
+	struct timespec64 now;
+	u64 ns;
+	int i;
+
+	/* Software must enable timer first and the clock selected must be
+	 * active, otherwise, the registers which are in the timer clock
+	 * domain are not accessible.
+	 */
+	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
+		   TMR_CTRL_TE;
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
+
+	/* Disable FIPER by default */
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		fiper_ctrl |= FIPER_CTRL_DIS(i);
+		fiper_ctrl &= ~FIPER_CTRL_PG(i);
+	}
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+
+	ktime_get_real_ts64(&now);
+	ns = timespec64_to_ns(&now);
+	netc_timer_cnt_write(priv, ns);
+
+	/* Allow atomic writes to TCLK_PERIOD and TMR_ADD, An update to
+	 * TCLK_PERIOD does not take effect until TMR_ADD is written.
+	 */
+	tmr_ctrl |= FIELD_PREP(TMR_CTRL_TCLK_PERIOD, integral_period) |
+		    TMR_COMP_MODE;
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
+}
+
+static int netc_timer_pci_probe(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_timer *priv;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	pcie_flr(pdev);
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable device\n");
+
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
+	if (err) {
+		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
+			ERR_PTR(err));
+		goto disable_dev;
+	}
+
+	pci_set_master(pdev);
+
+	priv->pdev = pdev;
+	priv->base = pci_ioremap_bar(pdev, NETC_TMR_REGS_BAR);
+	if (!priv->base) {
+		err = -ENOMEM;
+		goto release_mem_regions;
+	}
+
+	pci_set_drvdata(pdev, priv);
+
+	return 0;
+
+release_mem_regions:
+	pci_release_mem_regions(pdev);
+disable_dev:
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static void netc_timer_pci_remove(struct pci_dev *pdev)
+{
+	struct netc_timer *priv = pci_get_drvdata(pdev);
+
+	iounmap(priv->base);
+	pci_release_mem_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static int netc_timer_get_reference_clk_source(struct netc_timer *priv)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct clk *clk;
+	int i;
+
+	/* Select NETC system clock as the reference clock by default */
+	priv->clk_select = NETC_TMR_SYSTEM_CLK;
+	priv->clk_freq = NETC_TMR_SYSCLK_333M;
+
+	/* Update the clock source of the reference clock if the clock
+	 * is specified in DT node.
+	 */
+	for (i = 0; i < ARRAY_SIZE(timer_clk_src); i++) {
+		clk = devm_clk_get_optional_enabled(dev, timer_clk_src[i]);
+		if (IS_ERR(clk))
+			return dev_err_probe(dev, PTR_ERR(clk),
+					     "Failed to enable clock\n");
+
+		if (clk) {
+			priv->clk_freq = clk_get_rate(clk);
+			priv->clk_select = i ? NETC_TMR_EXT_OSC :
+					       NETC_TMR_CCM_TIMER1;
+			break;
+		}
+	}
+
+	/* The period is a 64-bit number, the high 32-bit is the integer
+	 * part of the period, the low 32-bit is the fractional part of
+	 * the period. In order to get the desired 32-bit fixed-point
+	 * format, multiply the numerator of the fraction by 2^32.
+	 */
+	priv->period = div_u64((u64)NSEC_PER_SEC << 32, priv->clk_freq);
+
+	return 0;
+}
+
+static int netc_timer_parse_dt(struct netc_timer *priv)
+{
+	return netc_timer_get_reference_clk_source(priv);
+}
+
+static int netc_timer_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_timer *priv;
+	int err;
+
+	err = netc_timer_pci_probe(pdev);
+	if (err)
+		return err;
+
+	priv = pci_get_drvdata(pdev);
+	err = netc_timer_parse_dt(priv);
+	if (err)
+		goto timer_pci_remove;
+
+	priv->caps = netc_timer_ptp_caps;
+	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
+	spin_lock_init(&priv->lock);
+
+	netc_timer_init(priv);
+	priv->clock = ptp_clock_register(&priv->caps, dev);
+	if (IS_ERR(priv->clock)) {
+		err = PTR_ERR(priv->clock);
+		goto timer_pci_remove;
+	}
+
+	return 0;
+
+timer_pci_remove:
+	netc_timer_pci_remove(pdev);
+
+	return err;
+}
+
+static void netc_timer_remove(struct pci_dev *pdev)
+{
+	struct netc_timer *priv = pci_get_drvdata(pdev);
+
+	netc_timer_wr(priv, NETC_TMR_CTRL, 0);
+	ptp_clock_unregister(priv->clock);
+	netc_timer_pci_remove(pdev);
+}
+
+static const struct pci_device_id netc_timer_id_table[] = {
+	{ PCI_DEVICE(NETC_TMR_PCI_VENDOR_NXP, 0xee02) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, netc_timer_id_table);
+
+static struct pci_driver netc_timer_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = netc_timer_id_table,
+	.probe = netc_timer_probe,
+	.remove = netc_timer_remove,
+};
+module_pci_driver(netc_timer_driver);
+
+MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1


