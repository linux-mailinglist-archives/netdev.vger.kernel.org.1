Return-Path: <netdev+bounces-214960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA5B2C476
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F08BD7B0B9C
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D8A345746;
	Tue, 19 Aug 2025 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gAzjUREa"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00457343D9A;
	Tue, 19 Aug 2025 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608392; cv=fail; b=iE3J8QueAN5G5s73ia6fartpv+n21yMZxyL7omROoqBz3O8diNio1JkfoyKf3cdmcUIyvul9ah7tXLP5+9iq9KpOXWQJFuSaDB4oGTNPzDlV3HuZS2jkbq0YwuWRdQCfAvdYnCahD6bJtIOeygGM7y0PDwrgTMadL9ufnLXenAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608392; c=relaxed/simple;
	bh=CkKuUQo77/6Bsid9gISKPCco9ZCqu6JAyUVn/1OeQVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DnOrY0+7tyE9gTb+vtohsEJfVE1+2vKKp4cXCQ1g0c48ciDkaruYD2CIFxC4iJ1Sy8t9uFi50Agu9hi/SQTgHa2h9413QS99pV/sPBKvFMGiR1pBffHP/kdvmThqRen91544w/ph6j/9QCIMKjp7T7U8FXtcFnU/MMABnOVtjVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gAzjUREa; arc=fail smtp.client-ip=52.101.72.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D27WfkcjUJXBezNFSkZTsLYHt+BDMiOaBpziyOojoPzTzs6UQC56dxgibUwlXo0Xw+iz2yugURi+yPqfzeyDnlJs0Bdgjf7INiXGONnpTr+/B9/hGxj39/sWd4/GXVdNdw8Zn/BovZsR1sz2Kc+xs3DE7nBlKVQFZnvOgIz66nRBgCI9DD+nb0JJekt2ZzGkgeoWtNx4pH/z7LQNPCgl0ZIU9au3w7mEiXqiJWX6Q8EVQro0IjZ0vmUpoXfqjkg6BrYWNCv0/CYnV4D6gMTzwG/S5uGzAWFy41zCTnQ+eaMUoK6SnaWiBawrwEOfvNBlmvZJfXyT2jhZ/ApDL/ZSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6AjQTwpITTpQXwlvr3UsSda5pIcERSr2k2iUIJndF0=;
 b=Ev7HIbXV6uqH8mr7LCkhSzxMsDi5XyNK/8yCNaQVP9A+rjHSTm9E0TPvHM7OCgUEZvY5Qj5Fr0WRPMuleEHAHUpRiB0I8Kx5t0SVyLHfT2Tsmt+Z7qBg64Cjm+K633V6YrnPtrkkyIqSP2Lzf6ujc3PxKyq3JkGn2Av4JfEHCb26HU8ID12bbKm8sEW6kfsoibWAkZ2pZHPe4wd6x1d7Jt+ZxyMpzCVA405dI2b9esz6IgS+uBAqOZy5IX/7Ci5Dht6S8tMtfQfK6gcc5JIJSJYq0Gmkv+l/eNmzjSFjzZgJA86IFCSAlgNJnTGxakXoruUO/sQeeNI2liAtJUvrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6AjQTwpITTpQXwlvr3UsSda5pIcERSr2k2iUIJndF0=;
 b=gAzjUREaNf2HBj8MjzHgshPQhw4hyJOfyAZXsuP0JEE4GP3EOvTusb1Ro3l40lzN5RZGb3Q1f0XMau/e8OiGcRbLaJ5YtstVrDQCIriT+H8hXRVl4GdBlMoBJKiQWbyrKjXyOybNAOI8rkHxGH4u40lD4p1bAvxUhqyNspG1OPMaTWUooIgfageQwRmu722xl9o8923jRbpYqsR9uFLNppJzvXkG0n+uxwWbSXzrv+hScxyRU7sxrrqu0DC/+8tfV0+bIKQ1zQMIwbDQxQgLdT2AOsGQTXZsRUeRnDf1ynfGEgUJo0UFsuvQN7izexDHAfOPyz7OYhsS/q2/Xq5RLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 12:59:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:59:23 +0000
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
Subject: [PATCH v4 net-next 10/15] net: enetc: save the parsed information of PTP packet to skb->cb
Date: Tue, 19 Aug 2025 20:36:15 +0800
Message-Id: <20250819123620.916637-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819123620.916637-1-wei.fang@nxp.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: af38ac1a-950a-4ab5-cc95-08dddf2037d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U3cI1lRvtWoqlp3pOX1SSnoXHsjH2DLXV/9UUnF30rEAuBqr72N+gDaTfQsC?=
 =?us-ascii?Q?FAvsK8UAakJAlFdPQQtMjnQu7+pp3GpZld0DuCcWfQoyptOP+77miAoZUHFu?=
 =?us-ascii?Q?/o0CTOvgKbEl4FC/37dltlRS7sH1elr5o9wh8l6VMjZVCaorvHHNyULxnBkw?=
 =?us-ascii?Q?qwn9Pw4DNnbUbNAthnnEMGibi2yl9MWg1pW1OW57/6Chq0AOs/pV6MVZYbv9?=
 =?us-ascii?Q?8T5taQSR9FipGbtGxLH9aEaVoHy3d4zojebI77AnJjADaDvF+HMLgrYdcYwD?=
 =?us-ascii?Q?K9HayjaUUfP7ksZWQqKdgGvxj7a4/BsbSLhdyuANttDk72f8XOJ19bLbj2PB?=
 =?us-ascii?Q?40nSNuap4xbGe2Yy0sxkL/GWJ97iwEN9R6/kcCdbFNDUzwdbbuiCqAKnuadz?=
 =?us-ascii?Q?uJriUHgYis12xb2PPOPGf04fYVOvW2j1wPEK99nLeIi9TBWB1zESO6BSu7cC?=
 =?us-ascii?Q?4HHRZm8oWeqU1cm3xMV63X0anqYzdDJ6s4GrcA2J9/7MTa9N+F3R6kYHFnX5?=
 =?us-ascii?Q?yZOWePvPAwsf+cj6WVLBGlVwzsm9598wgejTDYTi5oRBhYyPhHuKzLtsdcI4?=
 =?us-ascii?Q?BQ8fESuGRSmgIgvAeBhxwTgKCC1IvO/f0zO0g3unb7fh7NiQh7YiYJSxZkc/?=
 =?us-ascii?Q?vwE+77Tet4S36RKLHPk2EfREy7PI7D/ZQ3DI/0oMRPuWJygZeB9rbAmHkwLG?=
 =?us-ascii?Q?OImwxvN+/QZk9ljB1c9A364Y3nn0s+23OhycoHl06LqrimI9CYqDLtdo1QHQ?=
 =?us-ascii?Q?fiIS4A8ux8nw5KC5fOr9chyiUQ3TWHyuwlGV5yhm/tSlCgHx5sYzkQI2dw6I?=
 =?us-ascii?Q?XXS5Cv8tOzFneAIGm0YHhsQMbyCNEhJr1kWrkRxk2g4lKn/23rQUVOkUELdm?=
 =?us-ascii?Q?ghQ/nL26BqQyKfFtPlZ+lOvNLz4BVFGnDv6eHxF0ruy7emsG1d5RCR86AbUh?=
 =?us-ascii?Q?KlMR05y2GxicI+gJfjNdJuu5qEkYdjUuKgM9ohZUZPQjI27uPmgLN139ozFV?=
 =?us-ascii?Q?w2VmaTivSL5x8R2bUOQqxPB6Uautdp6VSW/Wd1itFEoRwxuSic47okabI0V5?=
 =?us-ascii?Q?iJRjMok4riwwzJf2bsltrBK43D/thyYIkxSErvCQ36p0X/9ilyAPsvLwDYs0?=
 =?us-ascii?Q?TfU0eAXDUdQfFm/rDMkjSY/rp54o3KzgzxvCy1612JKcMWHzanf2EYdiK5Xv?=
 =?us-ascii?Q?VpwpjHK7K+GnYW759vJwsU8I30u8FPqoASOqRZ2BN9PXwqkaCUiMAJUK3cBt?=
 =?us-ascii?Q?CGaoG2e4n0LDpuzm8zVf3dHKumuv+moXE0KKyR5l3c1eVs6hTpY56U8/cDgc?=
 =?us-ascii?Q?R3kiRwvuObVjdR66LtxSy/ZkCv4jqf6TXVGsNhoe56/V2Jj8rEoUumjjHldz?=
 =?us-ascii?Q?T6CKN1f2n48NhlEuF9WITM4dv4WFMzHRNt2siVFkWdFIw/lMALQCgN356w/y?=
 =?us-ascii?Q?eOZuJjTvCOU6gIxAFHPO+hY7iOv4nDsYo7+k1ELI5I6wDDC4NT4GDhoLjPmc?=
 =?us-ascii?Q?utSoxmJkrk8DbnU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B63IsiLbd4t+ik4JViZ8AFVh+W0WjnY0O7kq6zlNJc9ak/4C1tpTixvqXXWh?=
 =?us-ascii?Q?pArhrvCiJ7Sca5A0DH7rmupYFcBUze6Zln1C/SwY9IrH0nfFE/DFNwNmOaE1?=
 =?us-ascii?Q?RDp+sPMwjjDaJ7fkTBxfnPndZDS08Iww9BXjZCpmGZME519+VyKidv/6pNVQ?=
 =?us-ascii?Q?ybLfv2JCM9ouB9t40r+ffY3teMKqnl0bfi6DqPBUiozhOg7FBes6yLcu4CFT?=
 =?us-ascii?Q?LpTjTF7d6zRKtSRvav2I4YS/c2UWYV5jFT1sHDsuh+WN5O8c/Xlm895hlSZX?=
 =?us-ascii?Q?OT1UxqVuJYeiS/r+k121UiYopDsWu2sjSsTvVY+e7CPNIdZrasyewzFGMqCo?=
 =?us-ascii?Q?X04wlF+tIXLLUwRSZP1oEyQ2zWlwo7uyygcqu3BS9M/+267L5aXwcpWjWqN8?=
 =?us-ascii?Q?VDtS0sLYmh37tCNaWMfzYW3Ef2k3Tf5nVOSOqcA0JAOSqPNX52HZlf4Dds08?=
 =?us-ascii?Q?5eGnHrMtBPcOF1Rx6yflX9HXZ/vQFPKXai0H00C4eM+/0DS84Eg0sWD9/1kM?=
 =?us-ascii?Q?mGs+1HT/M++GlE67C57gsSQUbFdT6+gQN0qbA9/BiVBc5H5M1/RSsVElG3mt?=
 =?us-ascii?Q?cWtMCj/bqRvb2LmVJFWzZg9GuRUQX5zZ1Ht9HuVsHQyXVsXuT6urV7W65zP8?=
 =?us-ascii?Q?2fXC3UqqNpSsZAtmC0qkahoKXVtg+LdvN0SK2bqa62knylnPojHYn6YWiyTS?=
 =?us-ascii?Q?YumxICsjskBXmLwcDLx4MiHD0gQQt56THVhNPxgVgcUVg+NChKv/WGHmc/R3?=
 =?us-ascii?Q?UFa4/IxtILnjKFk/4zxPxxbmMViAF0eQPOyA4jrHpZgJuYpcth6OKkrtQvbv?=
 =?us-ascii?Q?uye0xxOEWKu8VYUixrVEFqCKocVFlmIgnbfCvn1NZ3yZSw8vd7GYSeCkGuF9?=
 =?us-ascii?Q?jRaYWu0S3AbsyB7j75rc7M9B9C7aMJyL0m4eI1bttIUrTflP6vwzTN7d/U4R?=
 =?us-ascii?Q?WllvrSkB0RQNPdH2nFxhpCQGLsuOKg54Kyh9zaQ6Nh25hB7Kjk342dRseALt?=
 =?us-ascii?Q?O9tZAUVVcIURUvg26LXYnziU0c7rYpQxw0N3hn8gfeilSNSfdAt23Vl4W6vx?=
 =?us-ascii?Q?5YfMAUOE6nZzVzn3ffvcwh40apcUPYKsmCe1JqZMZVYNA21KTW8Nip0HJPGp?=
 =?us-ascii?Q?N3qsDSqMRj48thOLvloqVBf93GRY/nhODqI2YMlYItkv1K2ERwB7rlToAe5V?=
 =?us-ascii?Q?DxbjF+T56u/hZEwSzbavYofPU68hXssUEIySQ1pW7g2r1bKla49PVRj7zAMX?=
 =?us-ascii?Q?qZvwF59A9g00cqqCU96K9pDF8IdRfctYIjCaXA2qAHIh0nkQPovBGgt3z1yw?=
 =?us-ascii?Q?0YshNgvjJv9xr0eLpAm2F/2JLOB5tA5jpoFriQeclHQ1wUQQRTnovEY+CW1f?=
 =?us-ascii?Q?LtaLEeGzHMEUN6O85idUiE3ns6dtCSdzD/gTlvifjYrCDR1QuDEK6fM1vvI8?=
 =?us-ascii?Q?UfArqRxVfauMZ7dr60OzocDrJXfYLSyZ02GV5aOOIczvMDib7JWGdwGazXvl?=
 =?us-ascii?Q?T+2XNY5Y1P3d0kjMRIHBcqpUhB2SP3DDeTg91GZtIFeZyuxWzi3ggLnPTI0v?=
 =?us-ascii?Q?9NsAAgiqBohKMXG7CrI8O8StwRwxE2zQ6rDAUquU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af38ac1a-950a-4ab5-cc95-08dddf2037d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:59:23.0704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQvGhV4VbH3uKNtLdpYRNWXBso46nPDucR48G84CKmtinPYw28cBmvxq5YwUFuImmxohW9rfGMD1uvFQ5HSAMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

Currently, the Tx PTP packets are parsed twice in the enetc driver, once
in enetc_xmit() and once in enetc_map_tx_buffs(). The latter is duplicate
and is unnecessary, since the parsed information can be saved to skb->cb
so that enetc_map_tx_buffs() can get the previously parsed data from
skb->cb. Therefore, add struct enetc_skb_cb as the format of the data
in the skb->cb buffer to save the parsed information of PTP packet. Use
saved information in enetc_map_tx_buffs() to avoid parsing data again.

In addition, rename variables offset1 and offset2 in enetc_map_tx_buffs()
to corr_off and tstamp_off for better readability.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v2 changes:
1. Add description of offset1 and offset2 being renamed in the commit
message.
v3 changes:
1. Improve the commit message
2. Fix the error the patch, there were two "++" in the patch
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 65 ++++++++++----------
 drivers/net/ethernet/freescale/enetc/enetc.h |  9 +++
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e4287725832e..54ccd7c57961 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -225,13 +225,12 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
-	u8 msgtype, twostep, udp;
 	union enetc_tx_bd *txbd;
-	u16 offset1, offset2;
 	int i, count = 0;
 	skb_frag_t *frag;
 	unsigned int f;
@@ -280,16 +279,10 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	count++;
 
 	do_vlan = skb_vlan_tag_present(skb);
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
-		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep, &offset1,
-				    &offset2) ||
-		    msgtype != PTP_MSGTYPE_SYNC || twostep)
-			WARN_ONCE(1, "Bad packet for one-step timestamping\n");
-		else
-			do_onestep_tstamp = true;
-	} else if (skb->cb[0] & ENETC_F_TX_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
+		do_onestep_tstamp = true;
+	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
 		do_twostep_tstamp = true;
-	}
 
 	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
 	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
@@ -333,6 +326,8 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
+			u16 tstamp_off = enetc_cb->origin_tstamp_off;
+			u16 corr_off = enetc_cb->correction_off;
 			__be32 new_sec_l, new_nsec;
 			u32 lo, hi, nsec, val;
 			__be16 new_sec_h;
@@ -362,32 +357,32 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 			new_sec_h = htons((sec >> 32) & 0xffff);
 			new_sec_l = htonl(sec & 0xffffffff);
 			new_nsec = htonl(nsec);
-			if (udp) {
+			if (enetc_cb->udp) {
 				struct udphdr *uh = udp_hdr(skb);
 				__be32 old_sec_l, old_nsec;
 				__be16 old_sec_h;
 
-				old_sec_h = *(__be16 *)(data + offset2);
+				old_sec_h = *(__be16 *)(data + tstamp_off);
 				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
 							 new_sec_h, false);
 
-				old_sec_l = *(__be32 *)(data + offset2 + 2);
+				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
 				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
 							 new_sec_l, false);
 
-				old_nsec = *(__be32 *)(data + offset2 + 6);
+				old_nsec = *(__be32 *)(data + tstamp_off + 6);
 				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
 							 new_nsec, false);
 			}
 
-			*(__be16 *)(data + offset2) = new_sec_h;
-			*(__be32 *)(data + offset2 + 2) = new_sec_l;
-			*(__be32 *)(data + offset2 + 6) = new_nsec;
+			*(__be16 *)(data + tstamp_off) = new_sec_h;
+			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
+			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
 
 			/* Configure single-step register */
 			val = ENETC_PM0_SINGLE_STEP_EN;
-			val |= ENETC_SET_SINGLE_STEP_OFFSET(offset1);
-			if (udp)
+			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
+			if (enetc_cb->udp)
 				val |= ENETC_PM0_SINGLE_STEP_CH;
 
 			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
@@ -938,12 +933,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 				    struct net_device *ndev)
 {
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
 	int count;
 
 	/* Queue one-step Sync packet if already locked */
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,
 					  &priv->flags)) {
 			skb_queue_tail(&priv->tx_skbs, skb);
@@ -1005,24 +1001,29 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 
 netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	u8 udp, msgtype, twostep;
 	u16 offset1, offset2;
 
-	/* Mark tx timestamp type on skb->cb[0] if requires */
+	/* Mark tx timestamp type on enetc_cb->flag if requires */
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
-	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK)) {
-		skb->cb[0] = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
-	} else {
-		skb->cb[0] = 0;
-	}
+	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK))
+		enetc_cb->flag = priv->active_offloads & ENETC_F_TX_TSTAMP_MASK;
+	else
+		enetc_cb->flag = 0;
 
 	/* Fall back to two-step timestamp if not one-step Sync packet */
-	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
+	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep,
 				    &offset1, &offset2) ||
-		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0)
-			skb->cb[0] = ENETC_F_TX_TSTAMP;
+		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0) {
+			enetc_cb->flag = ENETC_F_TX_TSTAMP;
+		} else {
+			enetc_cb->udp = !!udp;
+			enetc_cb->correction_off = offset1;
+			enetc_cb->origin_tstamp_off = offset2;
+		}
 	}
 
 	return enetc_start_xmit(skb, ndev);
@@ -1214,7 +1215,9 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 		if (xdp_frame) {
 			xdp_return_frame(xdp_frame);
 		} else if (skb) {
-			if (unlikely(skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
+			struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
+
+			if (unlikely(enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)) {
 				/* Start work to release lock for next one-step
 				 * timestamping packet. And send one skb in
 				 * tx_skbs queue if has.
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 62e8ee4d2f04..ce3fed95091b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -54,6 +54,15 @@ struct enetc_tx_swbd {
 	u8 qbv_en:1;
 };
 
+struct enetc_skb_cb {
+	u8 flag;
+	bool udp;
+	u16 correction_off;
+	u16 origin_tstamp_off;
+};
+
+#define ENETC_SKB_CB(skb) ((struct enetc_skb_cb *)((skb)->cb))
+
 struct enetc_lso_t {
 	bool	ipv6;
 	bool	tcp;
-- 
2.34.1


