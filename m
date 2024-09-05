Return-Path: <netdev+bounces-125393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CD496CF79
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9460C1C20327
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 06:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF3118B49A;
	Thu,  5 Sep 2024 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QV+AJ2vZ"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58018950D;
	Thu,  5 Sep 2024 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518281; cv=fail; b=QKE6y8/f+hXbVJQFLY6AEqQF4sPavYOdLwT3nwzs9yuOGKHxdzhmcS+jjymxxhv7P04HgCHqqN9WBqV6BVQaJsT8TocLsa4arx+k0HaA+Mxr4JkhfbOcbYotECDqTrPMPEJl23LpKMmkC6YBNDV/a4LHtgBlxMGleNT6dV4Bzq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518281; c=relaxed/simple;
	bh=tiisjBbrLwZypdTNDZ9PSaS37876/53LN0IZrJ1R9SA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GWdgTDsGX01lKwh3mPm//pqoCdGl+81U+It5ZgTb1rB+pUlxdfhSa3L5W7hiSxy4WiQNjDsOsaC4Tr29ItL7OWkBXGt59RSIu5r6z6QevBKhtuVokSH3pwMYVRPkanip+f901zDWylV9cXXyYDe8DWsOrMmuq0eNlT665tBRerI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QV+AJ2vZ; arc=fail smtp.client-ip=40.107.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7PcX+AoeWnpnRGTYomk0+MOpbMJySSeUfFtBMsOTaDTbYAEyrL1QM5S7MOEwAAFN3tlgpkmUpa4HtYpdWenxWhgElL0S5ZueovxbNRXV2VMq2cgsntvaojGDC1fHFEglrLfvuaccFBMwstQNCN2rAEEzsfrPEVaFRkMb9cocuJds6Kf4w1ElUkBAtmPi11ZOdYXetQSRmcmAaB8cRSQ/iAmTa4XbyHeuCFBNDuwNK4FyV6oJwVPT16lVREhfGvcgiYblLfoTKDJLXhs4GrlSyYKvdqgM54u0EAbYE/lGEZA5P0aUqa3CWc+HF1TM8/r5JQawQ1vcoobuQFKXhvlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNQYWPseIk7CBR08AKfqy/HQzs5vgzBPjvw0T9xw0i4=;
 b=dUu2sywY0JKnMHNCXYE4TQtUdXNq0ypc1AoW9v443fVBhYEM4xyAnSv+vaEZylRGHHA7ryKYNBFaT/IwwzrQE8QzGpYLFQlT58kLlmG4/88CQk6hygswEhn3wuvkrg2K33+rFO+CTbhgYal1U4BmVj3kD7MfqZhZ9dLujrh2nLEpYnrKB4FsdRJtpH8OqmgZC8YLi+ouGHqt3zCaW7biXXbnq1zKNXfjrNmeOCkiL4w4NWnb4obfF0jegJed0RaFkViTZhwR413OJFfyGdAX9OJtOg8AJJammSeTQKxnU7NoIOnu+TUhlEubtkH/UrG+d6Aq1b8fXW3epnfQnegGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNQYWPseIk7CBR08AKfqy/HQzs5vgzBPjvw0T9xw0i4=;
 b=QV+AJ2vZ5SQX1PL/2TNA9sI3R2peteOAberNXVM2+QsreuJKBymuNI8cH6zhun0NgJFv1Nqq1apbwVGAZSWvVo8vSTK5HX01EB6YaGkzr3Itr5ZvfFs9czi16n0JgD4PtjxtYMB57+1gai8EY5YWdciWSwdjIMVFhjT9IVN/XMwvNT19ygMHy0Wnr35dQ3pKjADE2A5GwExIY2M7scxqQgGCVx3GuNv5McbbYxKREt0WZhw580jrqgypTa2boYabGF4Cj69H9p9YYTaH4BeERO4VzgJMRSyTu8x0PTd/eBeozYpFaQHuUKVCC6eQPd7roTOpRDlzANQdJyBt0mpgFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by TY0PR06MB5754.apcprd06.prod.outlook.com (2603:1096:400:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 06:37:55 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 06:37:55 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: marcin.s.wojtas@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openkernel.kernel@vivo.com,
	horms@kernel.org,
	David.Laight@aculab.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH net-next v1] net: mvneta: Avoid the misuse of the '_t' variants
Date: Thu,  5 Sep 2024 14:36:45 +0800
Message-Id: <20240905063645.586354-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::13) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|TY0PR06MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 740da947-50a5-4c50-2b42-08dccd754645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S+bcI1KQK1eub3IIR17eyO7BD+cpqOS0vZ2NEXi6Gnu55xdkLHlV1WJgrqtC?=
 =?us-ascii?Q?nGqiBds/5p7Gx2vADrptvH/xoU8gC4K1tHzSS0TUw8v4Gvq4DdrhfTlAOy43?=
 =?us-ascii?Q?F2UCrdf6wgHNYe1SCOsA/YCLwm/FknskKutK+lrW5ovWL6n6C/H7uqzjnv/M?=
 =?us-ascii?Q?C0X0+SzZtd1LkHYERrtC6BNrd9Tu2g9etIUYdya8ZM/EMuklPFLBgld8IGdZ?=
 =?us-ascii?Q?OM2gkdyAYEUtTJ/TbywL4lyTJ+u1O+kSRJbyja9Kd6ooBjQ7rG66zvBt3mLu?=
 =?us-ascii?Q?N8htXGtwqR7X2q5SIaP808rsbUn7MBwoBEfil45jbyV9EGvzSoKXI+SwoCzN?=
 =?us-ascii?Q?FLDHyycSxaSm5BFrxQUA3Xmv0I7oYPewnrGzhiRERitS2dGtsyY3QzvyqAp6?=
 =?us-ascii?Q?4hHzDUWBOsfw8eOOZEhFlLZa2xqGON7JAMG/vH4oHY+CvHaTVfXcOg7iHyiy?=
 =?us-ascii?Q?jbIDcU1QXtIzaIyqngRp8Z+c5DCg58FurtSS6A7/7od+yv38+EoCm7jEJcqT?=
 =?us-ascii?Q?4UwSHUIQNDy3/bSdbJ1+/f0rklX6j17CV/qS8PM8GmlFSBT6MYi209HansRu?=
 =?us-ascii?Q?1U4djjlqYzPxAic0Dwah/ZHCm8eD0h7mtJXaI9gbNcaxjZVCN3FQLzRZf9kK?=
 =?us-ascii?Q?8XTnhsFLEk5o9e4V0EOzuxv3d+LfZEHGoDkPu7SSjb608hxFSId52XJa0MbH?=
 =?us-ascii?Q?uezCZbeudnDePMyT0L0olXi015qf0TcB4UJ8qfQcZ8O2WbVWBBwB77B/E9ep?=
 =?us-ascii?Q?8Owc1/COTlrnuFYZ4qoNf2VkGEtN34q7vag3kANCUB/hEve/9WP1OTJUFAYO?=
 =?us-ascii?Q?6jEM56ppT+yqEOU6JBhyNtwO1nQS85rTsZAaTeC2Iy86/ZtrPoG5LYXYyJB9?=
 =?us-ascii?Q?XSBVolWKWxHEYoJrS+Naom0y1XNz8m5gQ23W2SqmF7PyW/3biilAKSpyxbQl?=
 =?us-ascii?Q?gwJGznIb2Wm9swA1GfFccZKp+SJMheldlOmi+rY5AZeiFSRvf98HBz2pb/V3?=
 =?us-ascii?Q?5Y06ihH+Uawh1Jra92U8CuaqcFXdtHes4twJmq3ruKB8uSZAdOeFH44DO/jl?=
 =?us-ascii?Q?y6FITuoZb9DoP33Vc/kzhGRe72kkAGRLX7PvnJKflOYU8WEheiYLPj1SC43A?=
 =?us-ascii?Q?TZgndci/48SNkfVUoADCgX9Z+aYR3dsSetAvNoqaa2WeCqZBsBcuOJzH5vxT?=
 =?us-ascii?Q?7BInBJzTYagb+d1W98d2vjC3vwGpcKa0AJ4zAiln+Ebs6DFzrqrHIgQGfUO1?=
 =?us-ascii?Q?N9ubWCqJr2ImxCSO8a+pEyx5jBcXU+ICERe1aysT4c6zAe+nWjlzm3XDEKK/?=
 =?us-ascii?Q?BrncEztB+0+m6IOV0anQbqUvVVQycL+O95OqituFAtk739nXZ+r41V2CNELT?=
 =?us-ascii?Q?GnV7wbgZBxefsMcJ+cvQWlPjl3I3TJ/WYY2pS1AvKnQ0VTMWzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zJClqe1Qwfg+oKVz8tyW3Xl9KY34dQG9YYGInWkA1/Y0eA6+de6bWPceiGcZ?=
 =?us-ascii?Q?tqRmVJ9xuuiHPx2D4vgnt/r+1BBJbVlIm8ipMQAk6W4bdQEQyEApPaGjmleJ?=
 =?us-ascii?Q?SL7EBI1VNrPKLSx56QWejKItEmvMWuJs8Q6nnUAVI7RvRvMQjNaP770afPlW?=
 =?us-ascii?Q?ORnXFsYSXWzYmFLCcGbB7KOKyHhau8/auEC1rH9hoWGUTLNwkXm07+5Z4oL+?=
 =?us-ascii?Q?0u04g0aJL+SE3YPrSMYCrJQ6SzB/o0cN79iC/5GKlwhPhLuEMdgPMrw7Bavx?=
 =?us-ascii?Q?VmQL/+L7j0ISYfHyFNMpdqXMZRVUGl4WWU5V8YUsqkeG/I+tHQBQEv8MXt59?=
 =?us-ascii?Q?lIwFHO32/0G0qVk/CVN0Md5FI/shSZzSsNnt571nYpWjvcwen7xfxgeJwWNT?=
 =?us-ascii?Q?xoUafJuHmD3YBD2MHPJwT7jjgsS93asMZbvT1Amz60AqceiWTQCu6OtLAemz?=
 =?us-ascii?Q?78C5jyEy05zUVM0uo6Uye1pkRGhJWzGbBsq+3MSRkOiUPM7m2buAEjBzNYhn?=
 =?us-ascii?Q?q7IdUWbArdXaW6AiV51Hujpvjm5r8kZxEmrBYOsBDCOOMUow/upnJnzllPnl?=
 =?us-ascii?Q?9xY3DnXA0e+Q6RwJ38dniwmpDUu8Ed1tW+S60sdPWiXhlq0makc14fs1MB0G?=
 =?us-ascii?Q?N0g3Nm7+nzypdU2m2+H1WMVMUWE8Rra7OuNy3/90Z/JCzbmQi3rAjaBLfYRG?=
 =?us-ascii?Q?7MMC9hwv8nIpVVvAT6QBPCzUi/C9++XUWreXYSkUNo3rrGsWgkwfobGXeTMK?=
 =?us-ascii?Q?tFojMS8lQ6JeAdfwQBXk0igzAlL0pDWIEumf4rYd/1KkLuvj7PbrD11aBMXx?=
 =?us-ascii?Q?xYT0rH5r5vMZh3MDkBIQ52IEE9sFmSaWT6guaNJSkqB7uzzaMeBOx4YwAj2v?=
 =?us-ascii?Q?mogK44oOTJI9Vu7b24GOrPT8NwkRkwWKWEzZmoMGX/uD1aF+97F+7JcWwbfw?=
 =?us-ascii?Q?i5vyDiiDfYQK8qNv2B4NfQd8o3WQLdCswd+ySBGcl8BRxf4WrBfna1fbH1OB?=
 =?us-ascii?Q?aTELz4s8TKA+JYt20SNS9UWO8vAav48NM8aFkyi3HLh4qludGLlu5VTNpOYo?=
 =?us-ascii?Q?zWaUtbnqpgaaE/RhlwV+yk0PMtS0enJ7yBUx1dPyquNFrt8NJSSetKWUaMSO?=
 =?us-ascii?Q?PR62NXxcayAX+UDKwx4Jr68Ay0axzR5LUpXWDr+s9rjVWPJtqmum5Etb3HaT?=
 =?us-ascii?Q?CLjgO079PSpoKsilyU+ZSHGdmXRnV6/bAjS9aS11Ohmo9TMxwFDfmtXwMZfs?=
 =?us-ascii?Q?7ysGtU58/9Z+d8wqECV0ZgesoPp9XI5pBt/NkVFGfoZ1XCOVyokKAQmvQLyR?=
 =?us-ascii?Q?J7NQi/3GxJlez95/zZwLVbn3lL2G9M/mNfMPyC+i0W9azan0LJMwmyHzJIOM?=
 =?us-ascii?Q?L4DZeFYDRQErp5B8g8hTccph+q1U4bNLQ+5CsvXtoipNi5myrsO7vc+NGVUY?=
 =?us-ascii?Q?AQu9zCr9h5hBKX0BmMi5HxPGuJdUlXkgbcJgk2bB/GGBjAquaDNM7a72QvOz?=
 =?us-ascii?Q?3pCxPa0BdL7I3couPirjU6xie/9MreiiLzl/Wqi5D32u/yH//j8EhIVdi6+/?=
 =?us-ascii?Q?+8MNGgedsAuGELHqzcH7Yds894w+WI21Mw2ai48B?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740da947-50a5-4c50-2b42-08dccd754645
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 06:37:55.5155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PNBkMwNR+cgqYosxAwjDQAjDg0peT8/RwGHoK7JdvOW+Lzpw8lRJ2ClGCqELBSSjH4cSFh17npTAaLo4l03gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5754

Type conversions (especially when narrowing down types) can lead to 
unexpected behavior and should be done with extreme caution.

In this case if someone tries to set the tx_pending to 65536(0x10000),
after forcing it to convert to u16, it becomes 0x0000, they will get
the minimum supported size and not the maximum.

Based on previous discussions [1], such behavior may confuse users or even
create unexpected errors.

[1] https://lore.kernel.org/netdev/d23dfbf563714d7090d163a075ca9a51@AcuMS.aculab.com/

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index d72b2d5f96db..b41de182cc88 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4753,8 +4753,8 @@ mvneta_ethtool_set_ringparam(struct net_device *dev,
 	pp->rx_ring_size = ring->rx_pending < MVNETA_MAX_RXD ?
 		ring->rx_pending : MVNETA_MAX_RXD;
 
-	pp->tx_ring_size = clamp_t(u16, ring->tx_pending,
-				   MVNETA_MAX_SKB_DESCS * 2, MVNETA_MAX_TXD);
+	pp->tx_ring_size = clamp(ring->tx_pending,
+				 MVNETA_MAX_SKB_DESCS * 2, MVNETA_MAX_TXD);
 	if (pp->tx_ring_size != ring->tx_pending)
 		netdev_warn(dev, "TX queue size set to %u (requested %u)\n",
 			    pp->tx_ring_size, ring->tx_pending);
-- 
2.34.1


