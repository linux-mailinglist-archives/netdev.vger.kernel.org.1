Return-Path: <netdev+bounces-216362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECA7B33526
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12E017B123
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F12279DB3;
	Mon, 25 Aug 2025 04:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UxiWNc2I"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011041.outbound.protection.outlook.com [52.101.70.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE5424EAB2;
	Mon, 25 Aug 2025 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096594; cv=fail; b=OMFQvrJS1U2VgocevMSP2FNa7+KrPWMHNXCuF8EdS3TS7zYaAW1KcQ4YsFpRjYceNQnGtcsq7dzjim2V0fuujJTwezZtDEcIjrwD1vR5y/KFQhl4wN9zGZKxoDOjW5epeCeADKeAh2R2IvW7HIJj6XP4++Vlx0tGyxzMm4tilYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096594; c=relaxed/simple;
	bh=rO/2IeFmTb7V1Tctac4WUJfO8rFpTUefjJZ7qQ/KqcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZavLNBPAFjUYDSWeT+Y/Ex20koErM1a2PHLz0SoU24mljWSINrAgDZbjiUayUQQ7e1ex30c5mBNaUWesjlRc73Lb6a19AUvSGWoyIIlLHugc2+ZKa1fgb0ztqiWyf8rjUeO65hjvSWBiY3gms3RpYHbkOHhjgYBVOXUdwuRCmMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UxiWNc2I; arc=fail smtp.client-ip=52.101.70.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9HASbg1I9ZZzHyb5Mze5pozZBmt9GpuPRzXewzyfRPI/XmDDpBwj2fLL6rZb6sZXfTQ973oflbxCqX7y+QqMK6rQbVJDelGqK+GbEhfE9hYp8RehZd2/u/mEkRfy+Lt7/dssJztW+MD27yUCkN3T//vfoMFblajOf5UAoLXveD26Y+UGHKJrQ1dCeYYaAO847F9wCD4t7rzn2mSv/rF3KBzi3nMO4xzYCnjDoBS6Ie/3/zSbdzNbAWZZk2onRJI2QAUZjUBUDCUjtJ1uekAobLKpgL1YBqDBMEmbJH4b+nMcHd4ZqCKUOGnAbwm4QBWoqmeOwUqeuOpbqv7oUeLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11oApDb/zOSwXDJP3RIT756WGy3tqlgS6jus4VzaXYY=;
 b=ZV2EiXumF7D1avCHymsqW07P0QeRv7chh65yv6vwyQJgeSiCT3iFdieM86b/BIe5xbB/E9pn6RNKdC6h6df0lXM3ngpeII+yHxXt10LJI44lb346S9MuWhU/tw+WJr3g9Ldfd6/ibD9wz4g/yL9iP9F1AbVfsGEO8LrVde1X2VTAkvJX45z2tRFkSbyRWCyUPZ1DILZBUCAISB2zSyyGnj90BCq3XVc6MAzK9O68kgc4ud3RnPqjOMbZTjzCH+hnM80s2DzGhbiRk8ekISBmYITqKWOxbY4gzOJodPQ/+Xcl54hHH3+OJehquvUNNV/IjucQXWw8YHdJTD5LhOP7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11oApDb/zOSwXDJP3RIT756WGy3tqlgS6jus4VzaXYY=;
 b=UxiWNc2IKOLEnQYToikG4GE4ZgaiwqAY4tkEzkPVKeCvjVwhneUIaFeajvpeUMxTgRPegyFuE9S5g09q1h0XGroxET/gkyqT4AuXp1PT/l7edqgNSFcfXPiRFgX/GIKxLx4CN4yk4qIDnQLZZb8pxrqIJsavH1h8ZtmNzcr6tlQALVPVR1egXaLq6F4hId18SFSjV5DnOudhhTgp754SQ6SBoWUSpG+E6vGTHKLUZZsnowxKmklsxOupdscwdDVHbwP7ZpetcMvdhAe5PoxaRI18uQcZegdEM7fCn0fUiQcJXOBAn1Uqxsj0M0iSVAZAgiH+FxHtB6d8aGJ/GMIpWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9661.eurprd04.prod.outlook.com (2603:10a6:102:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 04:36:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:36:29 +0000
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
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v5 net-next 01/15] dt-bindings: ptp: add NETC Timer PTP clock
Date: Mon, 25 Aug 2025 12:15:18 +0800
Message-Id: <20250825041532.1067315-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825041532.1067315-1-wei.fang@nxp.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: e558417c-eb1c-4a88-9442-08dde390f592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nAAjIsLesKC3TPkZOR5us10O24jDpqwbq/XOf5ki3+zW0tzdeD3F8T6TF4Mv?=
 =?us-ascii?Q?jNPZ5TjV31bpf8M6dGDg4/jJRTqkgScfo2wVnK7FsCeJjfGMl6Ph7NMIvE4o?=
 =?us-ascii?Q?1ybt68qzrYJHIKwf82bB1QpuAU92c+MT4rm8XFD4W1CfqseVYxWzvbeoAViN?=
 =?us-ascii?Q?1lqned1KrGg5ZrJMOzsczTBEZrjfhKP3SMIUlCZ1ALwHHSiOjel9Ly1aoipb?=
 =?us-ascii?Q?6Raq+bs9xjoHdcKKgo+amzLow2A+MzrevxCn5+6w8L/jIfBf59ESIZfj+D4P?=
 =?us-ascii?Q?O1WKx/GlCpgz+w12EjTvWbK9WuC6FyMBcfwHOC+qTS39mWoXJpgHSSrhe551?=
 =?us-ascii?Q?Bbjr14uYJZbeU44ga7uNaneergxcrRNx9XIw+yNHzGWChmCNOscb0icwm+9u?=
 =?us-ascii?Q?z8+SY/OW5kQFUE+pZuhwyRQOGsftll3BVa4X/27HZSnf+bZ09qjZRHNXcu6v?=
 =?us-ascii?Q?39JvxvQFn6TLv4R/XKG2pV7l6QlzLmP/s09q0GO0l/l759WRj4ursYz39z1t?=
 =?us-ascii?Q?D0BWxqGRztnGBJVwucb8h2rFVx4jcNBQVfKGX9nNnJr3XOD+Y8xWVhZHpzzH?=
 =?us-ascii?Q?xnNVLxrGTPIw8VD8C2gmgc0nzV1/we2hPwnXSgzNrankgiW0J2V74x3sQZCF?=
 =?us-ascii?Q?zsv9WlYUMDKhGRapyR7nnplmpaS+3yzSqRwjFgATVIfQ25OykPoLRC8HzOZD?=
 =?us-ascii?Q?sXz8pGwDbfoKf/KYJZ/QUojZ3MiOPNGqZSB64V7qVq43WzA6YCu0p1WAwn0g?=
 =?us-ascii?Q?dKGT+3Lr/pEirzf9UM17gVbYixyjPtzJBFkSTm8Y0D6Yu/MzSRQX6Dqx/kZS?=
 =?us-ascii?Q?2qp5xwKzmoEEwTUp6S2QkxPkiD6CPnLRq1ISoqBAWZ0SPrDBekXXZRarwcXu?=
 =?us-ascii?Q?Xc8495OYIBjOrhVf9p0mNfDkPiAzYZaaTrqXG2oWBogNvUdNXPjx4y+DItcR?=
 =?us-ascii?Q?MYOWrdDNfjSvcvZUtJimO547io/nbOSBuNpvsvMSLR6ipFCf2draLJ5AXKq8?=
 =?us-ascii?Q?aLi1b5vth5dswIcYYan0tptmL/TuKwWaSwFSavKrbrus7M2iCmcfd//WH6Jw?=
 =?us-ascii?Q?YNqvS+zIk/h9QvWigDm5QcGe1t9NfUarVhBEIlX2XLCAPtDFu1rfcGTqCffk?=
 =?us-ascii?Q?OoMbIX0CfCdd9TFd43UBrhgBqBSe2NEBnlH+o0C0YdkQRV43xPjhsoe09iHO?=
 =?us-ascii?Q?Amc79dUGvRdBQ4sJF59KD9JuE4/wUVI4/GYETFV+Nf7eW+9BdfG8BNlbvzv7?=
 =?us-ascii?Q?+sNgYWAFyXhUpXMeFraJCK8Z+ek39CbQYskU0MPY1o6pe4UjNwV4Rdpqdnbo?=
 =?us-ascii?Q?EJFswdwuri1G/1bSZVV2WTplVhE1YtT5h/U9Ax8OhMWY+SkHJlDC4kuZpwZn?=
 =?us-ascii?Q?GbloKNZ7ZOPFPuaq+kSbZe247UWibKZPomy3fkUBhnEgLnuSDoFeLZMRaTbv?=
 =?us-ascii?Q?9FMuWtzI+JS9zh3pjUs3fiyZVPASkjBb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IkS/+3ENfQi2ACRAJiOZk3s3Su4l58QbOvCScAil7kguo6EL4p/YjjAOe99T?=
 =?us-ascii?Q?MaxCR68+qFJcTh3iRfxkNCc6+KGTCq8vwK3yKt6rm6266uySX1k6WbSHW4wz?=
 =?us-ascii?Q?LLXAOqvdN2PQ/onWI7DNO0oOMfjf/zP4uglUViupMs1EDEOF5g/xxAa4aP2l?=
 =?us-ascii?Q?zX2tzGNBiH4vUZqDErIHrkwJGpyXW5QdifiisbFmsMPvlTZKSPOvxJ6OwfeR?=
 =?us-ascii?Q?dy6P1WYBjI+OKeUWc3YvMVIPHaay1Ld7nJqftzwu3df6LrPvm9/dgb1mifaF?=
 =?us-ascii?Q?WDf20ToXMVCe5ligxlQrk7WzL0k9nx40jBvXIzf+J3YDD6cj4DOTwO71ZIf7?=
 =?us-ascii?Q?SyBbxz1cc4Q7jTHHO0mGT75QZY93MPyfvvgAcwN4GUreNZSlPfOXGoKNgnD4?=
 =?us-ascii?Q?slcyf8rOZ1N2ZuTNfg1i+xCLAA6HcogkbgzXwCxKlKbiw6hQl7E9Br23hSDD?=
 =?us-ascii?Q?OsyViMIHKbLRX0lZaPGLrP7CyhBviB///ywwCxCRWvnRzHKIIGpi+n5r112X?=
 =?us-ascii?Q?Y3D5pMsmIH8br4nb9CqmlbKS2dHnIlgB7Dx7HcgGl9KqPzu7N41MZ0xaPg5R?=
 =?us-ascii?Q?6SWcYel85C3opFOOjihyEBxuzGdkuuYsKkJS3Okb43pPm9FN1fQrx+Up5r3U?=
 =?us-ascii?Q?WR0unp2S4Hf8Qs+794w2XQSBpivEfyPY1gRYsnhZL2voL1/vdC7rd7mCJcba?=
 =?us-ascii?Q?fFS6xzcCy5+bCxi2ga+k369nHNgvw8aRpy/uRdF4g/cYXT5mtfMhxFuaXJht?=
 =?us-ascii?Q?nHL0mtWEiZJdAUX0bBe9VAgYsgwnE+3l4w8YojibxoLkQ5WLI0P3rQqZCGAH?=
 =?us-ascii?Q?LyBjxs0zTmQPDvNevWWPn4q5wg68goNqPBMzhvZbs1ACoKsOcXNqB1phUkfJ?=
 =?us-ascii?Q?SC6m3QjJkbvOth6uPnbcScp13BM3T3MBOfCvRdn+BqXaAPbZvU6zyPi5ZiQo?=
 =?us-ascii?Q?ejJHA4JpPx/Ts3pEcFKhPrSSzfVffrDAszqL0MeMPt6Qou6sK+9pNJXsoZTR?=
 =?us-ascii?Q?ei+OfWe2H2utFKbReJ3PhrIJX+N6u6IP/YtzZBiizqE2XAuAz34or33SjWHV?=
 =?us-ascii?Q?O/rJzLasnUYPIwXG7F0E8wkh2HCWHD9+cm1aemaYqTU+QDBy5oh5uaCf+D44?=
 =?us-ascii?Q?WLdYAHeRdJQPdhL4AI2TWEKnjVLzBHrgT7BvDsETc7I/9Q+q9uahGPDOjoA9?=
 =?us-ascii?Q?Aeo5S5PvAvTne7u9QCAXqb1y/qjy9o4jf4witg/8CzFBdfFGtseZWHnuUpTf?=
 =?us-ascii?Q?qFGVlYBVk0cfF39UeGhQdzVts15mA5MaZSYOO6PUm5qvWZDa8AB/Cs71AgmP?=
 =?us-ascii?Q?n4FQuODxuxTg+dndHH/uWGkW6R9ycS/d2/EU57gUT0Un63Z28Q5f5ggNYe/0?=
 =?us-ascii?Q?ceFXIRx1rfxRR/conX4CDgR+A2ttkK1T2EF+DUN0RB07EqXN3wbEBo+EGyT7?=
 =?us-ascii?Q?XKKLxu1HgPH7XJqzHQAqvHN34zHxw3tPjO7WlK/WkMIUy/UlclHSd0pR/rCn?=
 =?us-ascii?Q?E9bsook2yJTWWX5vlGexnJOfKco7Uo9igmuGfjmGJpxn54J3fRCQlveekkgu?=
 =?us-ascii?Q?saEKKC1ACJAAvIEJYI6S6+HJCOdJVwabh0ptK5/J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e558417c-eb1c-4a88-9442-08dde390f592
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:36:29.4988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/vLd2Vv3jvB9tDPyj5tjgiVRC426di1c0ILR02VHRiNHq6LJzW5fUvnTo+J9R7KgC4SkTp6zv7Qt+xPbq34Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
Integrated Endpoint (RCiEP), the Timer is one of its functions which
provides current time with nanosecond resolution, precise periodic
pulse, pulse on timeout (alarm), and time capture on external pulse
support. And also supports time synchronization as required for IEEE
1588 and IEEE 802.1AS-2020. So add device tree binding doc for the PTP
clock based on NETC Timer.

It is worth mentioning that the reference clock of NETC Timer has three
clock sources, but the clock mux is inside the NETC Timer. Therefore, the
driver will parse the clock name to select the desired clock source. If
the clocks property is not present, the NETC Timer will use the system
clock of NETC IP as its reference clock. Because the Timer is a PCIe
function of NETC IP, the system clock of NETC is always available to the
Timer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v5 changes:
Only change the clock names, "ccm_timer" -> "ccm", "ext_1588" -> "ext"
v4 changes:
1. Add the description of reference clock in the commit message
2. Improve the description of clocks property
3. Remove the description of clock-names because we have described it in
   clocks property
4. Change the node name from ethernet to ptp-timer
v3 changes:
1. Remove the "system" clock from clock-names
v2 changes:
1. Refine the subject and the commit message
2. Remove "nxp,pps-channel"
3. Add description to "clocks" and "clock-names"
---
 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml

diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
new file mode 100644
index 000000000000..042de9d5a92b
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ptp/nxp,ptp-netc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP NETC V4 Timer PTP clock
+
+description:
+  NETC V4 Timer provides current time with nanosecond resolution, precise
+  periodic pulse, pulse on timeout (alarm), and time capture on external
+  pulse support. And it supports time synchronization as required for
+  IEEE 1588 and IEEE 802.1AS-2020.
+
+maintainers:
+  - Wei Fang <wei.fang@nxp.com>
+  - Clark Wang <xiaoning.wang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - pci1131,ee02
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      The reference clock of NETC Timer, can be selected between 3 different
+      clock sources using an integrated hardware mux TMR_CTRL[CK_SEL].
+      The "ccm" means the reference clock comes from CCM of SoC.
+      The "ext" means the reference clock comes from external IO pins.
+      If not present, indicates that the system clock of NETC IP is selected
+      as the reference clock.
+
+  clock-names:
+    enum:
+      - ccm
+      - ext
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/pci/pci-device.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        ptp-timer@18,0 {
+            compatible = "pci1131,ee02";
+            reg = <0x00c000 0 0 0 0>;
+            clocks = <&scmi_clk 18>;
+            clock-names = "ccm";
+        };
+    };
-- 
2.34.1


