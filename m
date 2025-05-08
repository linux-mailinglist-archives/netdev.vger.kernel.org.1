Return-Path: <netdev+bounces-188954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017BEAAF8E8
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA4A9E13C6
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1653221FA5;
	Thu,  8 May 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V9PQSA35"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF321579F;
	Thu,  8 May 2025 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746704605; cv=fail; b=IQi4NAFWpq+Zfw5+9BF+DNMdyG+8/IOtw9ptGsZy0b++m+sEdWKS0G/qeVuprrnpdq1nbNa1qSXO4JGteyxUnj6jrGw3eVQ2Nf65OBsJFiT+0u7J9Yj7yhFNNDvuvOzwVuRd4HUCDYuSCL2nY1xK6yH+TRGf3WMMlNfk2yBbPSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746704605; c=relaxed/simple;
	bh=q20dONW4DzCnJZ2Fw0oVbJolsnFxqLNl+yi/i/qYnkA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cQvTIpf1pRItxlJtUbfSKDp5z13etXjm+PdfLAKaZ8+/UJWlI3KcS+QW4I9Hdz8ma3l5EPfHvhoZo9udXQgtrM39KljdbPAx75qhwD5yOJh3/ecrXKZxBTFARk4mEDexQ/FGZuKgVObgsxlNJ/nN1T1dUrsBKfc8LXvKxjj/iwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V9PQSA35; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqsj9rG1gqP78ft8CqcktKhWfz7BnmXGgC8ToetrPf4Hxo/Gt4AUsniFiIqm2tAez2wNDWdDPhFloEN5kpq3Z6UE5ajMa1ehpkMN0SmqEP0y9+LeNFcrr42p7BT2JJdXtZeJj+haEn42gFS0JOKCoR+vz/ipUVutU0gSu15jAeMXCDFGgPzrqXNfiGxiRz4ryNXKzLZiP0sU/zKIQSpaHb/nwbweDRWiDgpJlh4QjB/cGXtiXmi68DWf+snahOKKRi1H1TXPHvOMv/LPWWesEjKLPYg89ml3ztdelDaB2iSg/8y2HdSlzc4Y2RVCvM9EGgVlBkqrY5Zkc6M+l1cg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3zE/P5B5P09D6Y1kIhD8M0aqBfkRbs9HGKjihDkVS4=;
 b=wFhf1locEWgiVmKzBSdX0bvUF4M+fs/byLp/EhP0LL4mtGRbE0YlS0/43q50oDeHzStzrV6BU7kyccWCD2/mNxtRs8GVD+A52jlE9VhMjOrPwkOE1yqc9r7q7XXnVvPd4BWJgpUXoRLybrgPuGaRnK7FO3xNUIIcdT3Oi4d9/T+g33+34mHdn2Nj/tGqtqLYHEvwmYiuK7rYHz5HKo+HFMJRZl65uYjqYzfxTxns2fULvZeEyKTqvv047MeMZlgUG7GHPZdPE8JPMgCvPJMvma64WuaTrLzw3GttAY4Xj25NLXWyYz81hLzaHjE/tTrcAv0+tbY8Wh1MLfIkWyOZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3zE/P5B5P09D6Y1kIhD8M0aqBfkRbs9HGKjihDkVS4=;
 b=V9PQSA35mQolIvZke++lnNeZLJrFHV2EZSzar52Xlqxf1VWKYJsp94wCzw9V2o6nZz+4QUH9VK4kpedE3fYMNTSXX1rf7q9jYEoG8ok7RNH1Yk9tjWxmHlrEYgz7pQFaIivMl34gRkkuD7/8eLK6ZO7KdHZwElI2d6j/oNwch3pKs/vqOLt7r6JN6Mq6ztI+EBk549W0nkegxT3qQ2vUGWB+iacRxjhYh5rGFQTNcuAIfnxJUy1nk8GmmqodaxtxoEpnaWHbIVWrvhONGgzhHaDzpE3+nQWbAjIyb5spH88iuulf7xj0M8F1HJRPNapayLbmbNIFV3NAvEM5b5cZWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8420.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 11:43:19 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 11:43:19 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: enetc: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Thu,  8 May 2025 14:43:10 +0300
Message-ID: <20250508114310.1258162-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0028.eurprd03.prod.outlook.com
 (2603:10a6:803:118::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0a8346-b76a-446d-aa17-08dd8e258732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/GP2YM8zfE97vE+EUne62vEhH7ysUPhiEgquMpHdAMzUjVwBMSNirkehL5B0?=
 =?us-ascii?Q?JIT1bFzosRNOSW7l3dWX+n3OydXb+lEWRmnY5IdUsa9cJ3q4HRA/oEojQyO7?=
 =?us-ascii?Q?dI8MkW3gG2/BO4zjaW0cv/7mSNMt+k7TRHf5khmSLv5Xsx0OcDjj9WH5dANl?=
 =?us-ascii?Q?P2lUZ4p5nGeb78WKGMLlYnjG1Ou2ZTundCVdrG4P6Oe4/1duQ6kOwE7anSdJ?=
 =?us-ascii?Q?T9G7sc7j+LiUhL6Pc/dM0Ur9R4POFHkBbHSskLI802hh6bEvdr3lDnuiYX+j?=
 =?us-ascii?Q?mPreOh5xQJXYLtviY92/qFTU5pJu4zt6m4dGJUHO1NaPznVd2LpnN+18PPUp?=
 =?us-ascii?Q?MkTBhBOaZm2p9jpBUtctHb8iaWLCOE4YDoBzJ93bYc+Y4oV/iLpylB8yZhnT?=
 =?us-ascii?Q?cNGzqLpX21BSErRjiUUXZ56fYLfT0F/cNV2T0/Ik+9mqvcyb+AwGzK+cgOP2?=
 =?us-ascii?Q?hW3FXD9awNTC7yJYMsR4n3aXplxxA8NKSrIYGfyR9CzSNSBG6OnMAc3PYylS?=
 =?us-ascii?Q?F4iXcmZX3kW71o+MVZIoInrg1hmVCwLyRgL8Q3QKLc7LIpjGVR6PcwZOdqAI?=
 =?us-ascii?Q?qXLV4BGjAzBkol7TMiYUpPNeqi5iOSIiDKC1t1bC+VQVCBJx3vUkUrtIm4iu?=
 =?us-ascii?Q?TtfywlTLecIQVBPPtV0+/kozFuUguy/MGED1V4z/O6UdkXo4dSkIvY5B6Z3A?=
 =?us-ascii?Q?fyPVn1GeEF7FNwz+c3SklF+8lzJn+PuzxmYQV2+PsbZtnE9H3XF+EqRKcZQH?=
 =?us-ascii?Q?Tqj4AY5PmW+81hp/+Ki5xohrnfB1jMyNhyKPVnq7aMSu0uUd77NcHc+zu5vX?=
 =?us-ascii?Q?n0gRrTzUBzfZAf1NjDJaFloZYMX3/g+8QTWQadY2mVlGTbMjwE4NzdZrleSf?=
 =?us-ascii?Q?ovyJf0jvGiBBAccNyCShQrLzJ7QRH7IR/TWG6iLzxbpadX454CCTgLfqwkwr?=
 =?us-ascii?Q?sc5F2gbfHQUD9MwWWrvS913HLpTYQDLMrKmgYoDdyCQebfWuBBPPZuZzVdI2?=
 =?us-ascii?Q?ppFzmh8Xm6C+C/lgFw7gdYBeK9z6mWKaYvF3E+kVmBG2CLfb2xA6rrElAlAz?=
 =?us-ascii?Q?mgdvqvOnWMB3TBTmGWOUaaDtksdGw2T4q0UsaNNHG11q39d4Dltnkkj0E79u?=
 =?us-ascii?Q?KJQV7C9Hnnk4Y+NY+E3ANe3xfbs1g2CPMOslyR5fWe6HiJuXZ5TXDzBtje1E?=
 =?us-ascii?Q?Es9FuUB2mic5Nz5DyAnvOc8pmnEMeJ92LCYKatkyXeOsV0oSS2n4NLJdnCXV?=
 =?us-ascii?Q?525I3GOF+UjT2Uf3qWsjtVHTDohrhxvqk/ui1s+Bz5YouHjaqsggan0UyW1u?=
 =?us-ascii?Q?dWpwAx3a3lGjZR6JoiKx3s9adyYpk5CgAY19VjEkV4s0Aqyy3AV9x6/bRwA8?=
 =?us-ascii?Q?1jMMaTwCIa181R2BzPBAOgeqwdp9W5yjW5/MSVXyMv6HOMAcIXRBTEnnZG57?=
 =?us-ascii?Q?a+bUKDRwDBX0oR7bHIh+f+ZOf8sNdRCObPQxNQgv5P2a7dHGYcnP7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xcWR1f/8EnHazdXJAULWSFuv7QWl07sEkRgUTEF0okEClYSQASdEZ9jiz2Gs?=
 =?us-ascii?Q?yZpl3Vw21Q2GjcLNzadtKIc7D3YHhohCYonp1M0K0rrNo+ytJnfn0RqLGI8r?=
 =?us-ascii?Q?Wq0bSc9pnR85ScEFZhFvfMRkQJpoIbNzL08OC/XiFwe782pbSf2FLbdiZBLC?=
 =?us-ascii?Q?qBxqxWUub+nxxBVvAUOELcDUfTBm/439TQl3KC+GTO9BJpHZh9Io0WjYbzCM?=
 =?us-ascii?Q?Pu8oBJ6TT9x00tdnpiCUBeQYmnhPbLsjNw/CX7R27NCeVeraSMQyBgKEZp3j?=
 =?us-ascii?Q?/ZcCxGKI1+CFdrxNiNebfpQVpJoF5JPPO36Q4ESnYe8WwBYQKGmTe+VjuFT2?=
 =?us-ascii?Q?ccLANzh6MTDP0ZmczTdKcMncdNqMfk42DD9cy9Zp0HP37/dCDH4ia/DbwUTt?=
 =?us-ascii?Q?NQXaY/POkvsBMC7dq4qPyTLv31yyKbiK4PrZQBIFiSjDQYT5AqD88A7QFaOV?=
 =?us-ascii?Q?UKXCK69f/q1myjF1wFd0FELVFAhbMVruHE0msSAsDmmJxS+CHzLuwj8AXSKQ?=
 =?us-ascii?Q?2VM2DABVzhjJP0ynqAvPXOQ3/bnryWaFYfvZOL4oBStrQuD3gh4yjAll/tuD?=
 =?us-ascii?Q?A5TvhuyTjOuO1998tmHDZaO2Yk6i9ggCDC+pBJFSplMmAjzwgx0YY43Ty1qk?=
 =?us-ascii?Q?E1lQAQ5X7vU7vCTjgBpG4hrW89QX44nhgljULUrhAe/fqmiWn0cruUZgY9h8?=
 =?us-ascii?Q?GXCN2QpOWhpDAnOr/ldhlVJ0871r5miDG16qQM8675Lq3MhKmC+LO6j1Ij00?=
 =?us-ascii?Q?WcsZ3j8jjlOVmHik08NMaLMjPdfe1tkIrNkc+nx38XqCQss/rsHmtUiOkQjm?=
 =?us-ascii?Q?5CzEKaYqrdq2rhJfccZnlFIBh20q/HC+wvzFIFbCiMU5BytXI6XNc8ilgmFY?=
 =?us-ascii?Q?SHA68O11CRPC4FycSdzoRfG/Rm8SLffUQaD89Yh36dNu8f0z39B3yt8Pk1s3?=
 =?us-ascii?Q?2HK0jofPhTHwNZt3CWQ3Rg3bNqu+czAQ058F9x8VdEu5P16rwp/8MguNNjE3?=
 =?us-ascii?Q?SWrSkoF8mTorq671JJxkcqqTppKDygYBNPbvrbbn5tUFgLfURXrh29VGYzI0?=
 =?us-ascii?Q?fLAGDdyCQPmjnZq968M/BVE9twkDomkAdsWVOYF9T4+fgohdCVyfCMp6+JMO?=
 =?us-ascii?Q?xnSKBesbwaGaGtB7RaG0pp2DsKKFHv9cqlMJdJyckKaV0MMUJ8Hp/j3ZgL83?=
 =?us-ascii?Q?wGvGWBIz2pEvAjz7Rdc9TJWDFYXJ2I428FbI8X0LKZkP8idJJNL3pV6qTL5/?=
 =?us-ascii?Q?QWq3zd+lm0mP0VekZTBQ7mwdBztZcpVXA41rV8JwuRDo9VXNksZ8ijybS6kz?=
 =?us-ascii?Q?9MB6GaHDCurLFz9uIK61nDU8KQe01agnVYWfTGGZ+miIOiCqQxMKi7VZLpYn?=
 =?us-ascii?Q?P+tQVGMtvoy/nricxUdfnNWEKNghlzw+Wyv4skJmR4SYc8DY7hNoVvC1uj7H?=
 =?us-ascii?Q?+5KslGDCGpVDd2LwgluEY4Tr1EbKdeWcqAfGN4NF252yin3C855odH5E3In4?=
 =?us-ascii?Q?vlKPZGS1dgEP6hs8BQnZMMNA2KvhtuWJzYRaoplZDA22KiY6ugGNaGuTF8Ee?=
 =?us-ascii?Q?Q9kjMpM4QVxtWRzZW4E982OMni7PjTDoBuqzJepdWvsuuxfemnG8QCW7/DHt?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0a8346-b76a-446d-aa17-08dd8e258732
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 11:43:19.1541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyZ3tcHtXOBty3wt1tU94bAoFV0VPLYd69v+kIlxi58mqwDPGEJyEiIL8zv1R7Z+Bd8APT4nOpxx+cs2Fnsc1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8420

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6. It is
time to convert the ENETC driver to the new API, so that the
ndo_eth_ioctl() path can be removed completely.

Move the enetc_hwtstamp_get() and enetc_hwtstamp_set() calls away from
enetc_ioctl() to dedicated net_device_ops for the LS1028A PF and VF
(NETC v4 does not yet implement enetc_ioctl()), adapt the prototypes and
export these symbols (enetc_ioctl() is also exported).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 45 ++++++++-----------
 drivers/net/ethernet/freescale/enetc/enetc.h  | 15 +++++++
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  2 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   |  2 +
 4 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 3ee52f4b1166..0eb87964f292 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3262,16 +3262,14 @@ void enetc_set_features(struct net_device *ndev, netdev_features_t features)
 }
 EXPORT_SYMBOL_GPL(enetc_set_features);
 
-static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
+int enetc_hwtstamp_set(struct net_device *ndev,
+		       struct kernel_hwtstamp_config *config,
+		       struct netlink_ext_ack *extack)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err, new_offloads = priv->active_offloads;
-	struct hwtstamp_config config;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
 		break;
@@ -3290,13 +3288,13 @@ static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	switch (config.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		new_offloads &= ~ENETC_F_RX_TSTAMP;
 		break;
 	default:
 		new_offloads |= ENETC_F_RX_TSTAMP;
-		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
 	}
 
 	if ((new_offloads ^ priv->active_offloads) & ENETC_F_RX_TSTAMP) {
@@ -3309,42 +3307,35 @@ static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
 
 	priv->active_offloads = new_offloads;
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-	       -EFAULT : 0;
+	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_hwtstamp_set);
 
-static int enetc_hwtstamp_get(struct net_device *ndev, struct ifreq *ifr)
+int enetc_hwtstamp_get(struct net_device *ndev,
+		       struct kernel_hwtstamp_config *config)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct hwtstamp_config config;
 
-	config.flags = 0;
+	config->flags = 0;
 
 	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
-		config.tx_type = HWTSTAMP_TX_ONESTEP_SYNC;
+		config->tx_type = HWTSTAMP_TX_ONESTEP_SYNC;
 	else if (priv->active_offloads & ENETC_F_TX_TSTAMP)
-		config.tx_type = HWTSTAMP_TX_ON;
+		config->tx_type = HWTSTAMP_TX_ON;
 	else
-		config.tx_type = HWTSTAMP_TX_OFF;
+		config->tx_type = HWTSTAMP_TX_OFF;
 
-	config.rx_filter = (priv->active_offloads & ENETC_F_RX_TSTAMP) ?
-			    HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
+	config->rx_filter = (priv->active_offloads & ENETC_F_RX_TSTAMP) ?
+			     HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-	       -EFAULT : 0;
+	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_hwtstamp_get);
 
 int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
-		if (cmd == SIOCSHWTSTAMP)
-			return enetc_hwtstamp_set(ndev, rq);
-		if (cmd == SIOCGHWTSTAMP)
-			return enetc_hwtstamp_get(ndev, rq);
-	}
-
 	if (!priv->phylink)
 		return -EOPNOTSUPP;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 4ad4eb5c5a74..5c2f4e9f68fa 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -481,6 +481,21 @@ int enetc_setup_bpf(struct net_device *ndev, struct netdev_bpf *bpf);
 int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 		   struct xdp_frame **frames, u32 flags);
 
+#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
+
+int enetc_hwtstamp_get(struct net_device *ndev,
+		       struct kernel_hwtstamp_config *config);
+int enetc_hwtstamp_set(struct net_device *ndev,
+		       struct kernel_hwtstamp_config *config,
+		       struct netlink_ext_ack *extack);
+
+#else
+
+#define enetc_hwtstamp_get(ndev, config)		NULL
+#define enetc_hwtstamp_set(ndev, config, extack)	NULL
+
+#endif
+
 /* ethtool */
 extern const struct ethtool_ops enetc_pf_ethtool_ops;
 extern const struct ethtool_ops enetc4_pf_ethtool_ops;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 203862ec1114..e3bbe6916a29 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -728,6 +728,8 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_setup_tc		= enetc_pf_setup_tc,
 	.ndo_bpf		= enetc_setup_bpf,
 	.ndo_xdp_xmit		= enetc_xdp_xmit,
+	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
+	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 3768752b6008..16f311567e47 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -121,6 +121,8 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_set_features	= enetc_vf_set_features,
 	.ndo_eth_ioctl		= enetc_ioctl,
 	.ndo_setup_tc		= enetc_vf_setup_tc,
+	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
+	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 };
 
 static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
-- 
2.43.0


