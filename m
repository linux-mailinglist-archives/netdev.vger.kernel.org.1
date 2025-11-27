Return-Path: <netdev+bounces-242268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F29C8E333
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80FC735026E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676CE32F74A;
	Thu, 27 Nov 2025 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hdsJYQlZ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B37532ED55
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245388; cv=fail; b=V3Nyr0KReTzeFdzEbCEAx8xi3/RA1sxOVnB9NsfVRjgPbAhn8VB5p6EyG4WlR2I+vXAXgSBN1mehNprO6FnHQzhKlQg9HzRj+eyYsrJb2E1BkoDFyI39jsPcrxHfK523T8rksb8zj354hu6PVI+iz8L04egz6LCq1pxGsKjuG+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245388; c=relaxed/simple;
	bh=xGKiYa9pzzJszo2aHZ338xtCRm7l23vIuOkT+l1thFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CoFgcCSB/FyqcqFucP4NKQncX1wRK7PQGY3jskW1Ovn+3E6w5GbAf4kdlweEVK+anF9H+CHzDVdrLnM63USskIkrAyEDz0kzlIdRmi1OxglpxvwfMHzm5qLoqL5alkPWAF4jRfdz/lGQkSu+DF69GS5aUF3lPNiLm5wK36dnXJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hdsJYQlZ; arc=fail smtp.client-ip=52.101.70.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKWaytWu3NES9jKlwJOrcq0vUzQWOMPBLO5rWP53KVy02VACjydDgBDMLLxROPWSkchO+AyjLww/YMKwtij0/EG+rn8jio6j1C7njpluOMoDRvY6EXg/5f/SN+NJgNqsXZaXVx2wynpt60fcZVO26F5fUg9n/90WdGvEkLYa9ja+TLOEbgn2nAjSbK5mdgQlvwHivCNOzoC/S59qRq9DIYzwBb536zVlJF+Hpz/TUhKBO0GhKC9LGIzUBGZ3goaWJpDoVHv9Ql5xOTpKMNU+T3/1dJmyv/UAvdCWwX55E/UdFwMEN9cxE4+xGI0kNoDB2iW3edlUwbrQuOjTjHjEvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqu78xJA6H57cX94PdwI3qXne4hHTWw+J0mX3+sqL4k=;
 b=A4XqP2CQTExTxVweycWmTQ//AwCv3K2UCxXSSP5E687is+7iZFGexDpu5i/L2DSXtFtBQhAhHvNToIaDr7uJDhvgVjajnqHDjZjFZAZmuCm9bllZdE3lhbiDmaSAbgHYrBaydzISNANq9T3OG0pN1nt2hclQxihLT1bJ3hLFXAeGRIWTj5ScH3RlUynxfr/5mUnYJYpGWsSGmpW0snlDWR8U+ssFam55BQLgy89zKLOiMjZxowRzlHwnrbDn9xaXTZ1U/bvmG+8teEo3UXowUHz8/YsBtiH00hK8frkMIWz0TencOSfr+A2Ehw5ntfRY1tC7uImEhSmRKeDfV5XxSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqu78xJA6H57cX94PdwI3qXne4hHTWw+J0mX3+sqL4k=;
 b=hdsJYQlZ9099uGGJu+O7Qw7Smk41tbBuBthgnzcDUBk/AB32YOGtKt3kl0sUQFVdNGgRizBKOIhLIizT8yEydUDxM4rZBxkBr1vQs+AR4qF+fujA/jlvBXzea+aexGtplAssxwkkP0Nzo2LoItXslGydiiEHbQIh7TyKfJFkoQtxAEuOTKOOC/iJI1gXDRybG5P96BdNO6mlUH6HOigWn1Sc8RiTEWMecU+6Lm7zilFMPWsjJj/0RWG8QV3soojC+Aqd34kTfZjqJoRDEfr1NOPsUxY9nnNDHHIwRRI6woC7R0g38jUk0H0GH4SIMn8xGlmbx9lwzBaSUiZ+8cPogQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB11844.eurprd04.prod.outlook.com (2603:10a6:800:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 12:09:32 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:09:32 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	George McCollister <george.mccollister@gmail.com>
Subject: [PATCH net-next 14/15] net: dsa: tag_xrs700x: use the dsa_xmit_port_mask() helper
Date: Thu, 27 Nov 2025 14:09:01 +0200
Message-ID: <20251127120902.292555-15-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127120902.292555-1-vladimir.oltean@nxp.com>
References: <20251127120902.292555-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB11844:EE_
X-MS-Office365-Filtering-Correlation-Id: 64eb2dbd-1c81-4860-55a3-08de2dadd2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|10070799003|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pnKMb0CNGtNJX+dMLfEWDznKYKXWC7gQKDfyHYBhmvqg+eBMhL7741ZTrUJy?=
 =?us-ascii?Q?qh6iOARQok0xxiTpmu+79ckGNMv64ppx0s2P1r+xqN/0xVyxwFS4ZS36p0zE?=
 =?us-ascii?Q?zSS+dr0P7gv5eqCmrex1ooerpanmyq+9BPXXO3LD8uHHe3rd82S6mu0Cn5nV?=
 =?us-ascii?Q?j+uDzATa/1RSd/M3H2+4OLXtj1QId4fL5cGm+hhgKO3guLeB26FnuLBpR5M9?=
 =?us-ascii?Q?JMfvUMq/O/9gR0s9a0ckLK25Dckld4iRIrS9JaDoS4nyFWobm+61/49N406+?=
 =?us-ascii?Q?3nRSoUT+Fwr7u/9lj17fynaok/77AbVyocHCEPRinuFS6Tkf3caBl9O2qPcF?=
 =?us-ascii?Q?h9FFhvvx7qc89eMTgYpRkKgKm7uBrBSIxBnbn6ykWKnHiZFvZJ/2BtQx92m1?=
 =?us-ascii?Q?JvNtMJlTP9+G6R9cq/WmUNwS63Cui8nyQgy1Q5cNJnp0VZKK/Q4zuX0I7n6P?=
 =?us-ascii?Q?pHPEGAdX0oqjkUklbDGnnCHu6HL1p6ZMmkJAp1rPMl61ar+CdLmykRtIiuRX?=
 =?us-ascii?Q?8eG0V+7sY+Dv7gXPdoSvE395Owq/Lakjral2++sRNi8kPPxRhttmfRQlxUTJ?=
 =?us-ascii?Q?ErZhzraaWrlfGS8rSuAN1yuMDRROP2pLVTZZ4PNWctJYmKPjz/fG2n3YeMFG?=
 =?us-ascii?Q?2p1Y2jrW3Zky0hek0mqdRGGqQkOF+DJv0TnsgW4SvkGKM0qkGg+afugL2QzT?=
 =?us-ascii?Q?R950FJPcktsxX40zC+8zRJXAk9oWmrScTREVJabyNVKz6UVtFyuaqRmF1xyv?=
 =?us-ascii?Q?Hsp3XyGpRLq9t3rfGgQCRW2Wmgdbr4XbT7gE0r2QitN/fOB1HGC25H6XtBQB?=
 =?us-ascii?Q?qZUWohwy3tD7znHnNBSRrq5EaJRAofQSyPBJ+iwgDtnFWM2FzBPvy+TS8Zu5?=
 =?us-ascii?Q?f2yZ6Pm/jD9wNeVQ0H0T0QDPX5vhJajU8Hjn35qDzwggQz2kk/sBJOcfAWxh?=
 =?us-ascii?Q?CUTCkCvQLLg4oK4UE3afqzUzW4aW6hajKuFLjhFE8J4udbOE7TYp7Cdk3tj9?=
 =?us-ascii?Q?lrxe8XFFq/D5824wtns/urIrJWRIqMnYfxsCcPZwmWNEgILeUXG5CTmsXQhb?=
 =?us-ascii?Q?jCjAEiEys+Lg+1/bh5eqw9MsC3TqgGoY/RPGMa7Y0NplFlcdHi/ZBOHpey+z?=
 =?us-ascii?Q?RoYxZDzXJNhhU/KqykUwDNNFVFO5uRxQnCQS9mQtVl/FWb1ro5HCnEQvATpp?=
 =?us-ascii?Q?/zhKjdcei3gjsH+AMzx/jgcVpssEvSqG+oVKjbk0ZXHto1X753LKO7qItg1L?=
 =?us-ascii?Q?wGNWyBF0i+v447KM1duFYAxzCqlhGloBb9FYFeQVCEKnU5Tkox5ktevRLpKg?=
 =?us-ascii?Q?x5w8j3TxqIwan2AImZZcVyJIdmxIeF3FBWu7M0vdx0J9BBf/E0hTxxTS38HX?=
 =?us-ascii?Q?+4PtCBaYY0gZMx6WDc37I28M7W4netJcazNKrnZK/V/YFTgWVRvY2ybvNLDE?=
 =?us-ascii?Q?tqUsTr9dnv6WOZRHdy2GkkOfYsAFlGL+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(10070799003)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lrafqRXQA8FIVYRN9FtlWxt9GpComMmiXp1dGOIsfULcj1WDkFrnZob5wB86?=
 =?us-ascii?Q?pmUPmYBpYscn69SJaep7mGQH2EmprpROSF20XkpNC1TFXmrgFWakKNabbVdf?=
 =?us-ascii?Q?SnARO6EpFvJq8BuN7JcJTNEzWt757jhq3N58Q1zKgOuqUKf9U5cCqGkM32LL?=
 =?us-ascii?Q?lCeHOcdp7kwok00KLf+Ar47OfyVBdzyNJwyDPA66nrbEoR0J40an50kifmDg?=
 =?us-ascii?Q?TIg4Sj1fVaZigpfaw2xKoK/WoHGBe4yHzErqrbKstmQ3Z+rHOTqCmH9luIVW?=
 =?us-ascii?Q?3br/6hZ10naGTuESbXJWdn6bRex1i6GvzH0J9sMUzUp79AQs7oszEAaw+ON/?=
 =?us-ascii?Q?LITdyFOKCDRYavv0m1dIZjteyBGgkQwXu9hP4sjH+QBdi47xMPDNij+yAiwb?=
 =?us-ascii?Q?mTw4vLGJGAArshI71W3aj5Rm/UAmXxIXFjo30Q8VewKbitxEEzxKp9eubNhP?=
 =?us-ascii?Q?rmu80tTkMJNAUk8gfYFp5MVMVE9qhLY57myV1hwNI26746Ue1Nlepg6nDu4A?=
 =?us-ascii?Q?m0vD9aBM8ZCG2YTJTmpawMZpJfVR5BFC6JVvQVbXMX/ZWudOuF0aY1ztJ37W?=
 =?us-ascii?Q?Zlec7Zk3jqCmbbpAtx2s9vtQkZCguZgDNCtsg62TloJTn50TE8GB/Z4EqMqk?=
 =?us-ascii?Q?4idzVEUptLTusnQWIUzrIamfVQlYxuUqQPPeLH4qo+7KvzDG/YvVVh/eeRZB?=
 =?us-ascii?Q?hzssSSpt2nq3ZHx1obt/NLRrQDhouU+ALZbxbiPH0h4sxTVaCGUrWqe39REY?=
 =?us-ascii?Q?Kmsopg9SZ4sasatAS0d0I6syRaiDVAbHoMfCJh0xHHQBgGpcntNfYqkI2j80?=
 =?us-ascii?Q?9S3LmfjxNVN7MTYwDw9mIEBwN9bpeDp9Y4g/8b2p40IqHy/KqiwM55ZoCTsB?=
 =?us-ascii?Q?ZKW+P9aAXfzdOoV3sObUakkmYIomr6Uf1fKKo3u5YEW2wn8NZMFgOsYauyfu?=
 =?us-ascii?Q?wSV2FRZlgB7uGaCv9xA5RiGG9wwOFsIi3rN8+XLx8+WN1pvl6DTUbR1CwM+L?=
 =?us-ascii?Q?Xt1GvES+L4f5HL1dqDyjH7LWAuIOc6hWQnYdEDjelbFC5tpx8zZFxs0gU6co?=
 =?us-ascii?Q?53aiP8OG+8xGgDExKm1sAePVd9H0c+Y6V6QI695kDn73iJjDp6x7tcM/K1WX?=
 =?us-ascii?Q?puYjSkUd8Z5+jYA5QnBl3KnlpCtjFA1pxkmTIvL3pyZzxMqs4RFdwSP0kj3o?=
 =?us-ascii?Q?b5UCshaLXqOGkKlf00H/h+G00CHjpTMtbVPftQKlEVINR4YF4J+KGOzwmc2L?=
 =?us-ascii?Q?KnIDBC4au3wP3ssYxSCiIKwoZi9kAYCuPO+tTYDJjjajbk7LfD2nnbBHYYHE?=
 =?us-ascii?Q?Q/vefnx6C2KmMB5/kFcfkhR9sxHhgKwO1eIWFFUgvH8PSqmY7o83bXa/wHCl?=
 =?us-ascii?Q?THX8kbRZk1cx66dirjvuOLKNuumlSuc51Y1fL3pd+377lnxGPywupeuZXVNn?=
 =?us-ascii?Q?u43GPA+D3nOvWUhVREf36Bw+xSY6CaNkpnkulhynz0G9+YAGRTN2W6BulEQv?=
 =?us-ascii?Q?ZmR8WFKVW2xMf5a+dtZSX/PCuw7su1WGjwVQE1b6kPnH6Us0+FhihnERIcju?=
 =?us-ascii?Q?QndqiIJbDfGddffHsF4OW8rtd9cSv50taRIBToHHbU2avNyZhJ7hGie6cRYb?=
 =?us-ascii?Q?ZZbsSjiHLRTLmceC9VGunWKdwgTdruBRI/rKZk+GAZQbkdJcPlJCmobpHeoa?=
 =?us-ascii?Q?SHugCw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64eb2dbd-1c81-4860-55a3-08de2dadd2a9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:09:32.2360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUXqNCOAS0CVxOKge7LbkV7NFZyf9MtJdSHHaApnTVuUAV8HxqfjuTpKDcK0/LbAvdVmJy8R3SPZLytUo/SFuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11844

The "xrs700x" is the original DSA tagging protocol with HSR TX
replication support, we now essentially move that logic to the
dsa_xmit_port_mask() helper. The end result is something akin to
hellcreek_xmit() (but reminds me I should also take care of
skb_checksum_help() for tail taggers in the core).

The implementation differences to dsa_xmit_port_mask() are immaterial.

Cc: George McCollister <george.mccollister@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_xrs700x.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/dsa/tag_xrs700x.c b/net/dsa/tag_xrs700x.c
index 68d4633ddd5e..a05219f702c6 100644
--- a/net/dsa/tag_xrs700x.c
+++ b/net/dsa/tag_xrs700x.c
@@ -13,16 +13,10 @@
 
 static struct sk_buff *xrs700x_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct dsa_port *partner, *dp = dsa_user_to_port(dev);
 	u8 *trailer;
 
 	trailer = skb_put(skb, 1);
-	trailer[0] = BIT(dp->index);
-
-	if (dp->hsr_dev)
-		dsa_hsr_foreach_port(partner, dp->ds, dp->hsr_dev)
-			if (partner != dp)
-				trailer[0] |= BIT(partner->index);
+	trailer[0] = dsa_xmit_port_mask(skb, dev);
 
 	return skb;
 }
-- 
2.43.0


