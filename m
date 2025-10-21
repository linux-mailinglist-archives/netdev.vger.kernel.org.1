Return-Path: <netdev+bounces-231062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C549BBF4499
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 03:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0673188183E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A85023D7E9;
	Tue, 21 Oct 2025 01:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DFa9KXHi"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8702AC2FB
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 01:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761010875; cv=fail; b=k5GsdooW4v77Wepgoc6qTbx6ID3rVZ/aeml53yjk7iOPuI6QFg9GMrF1KYXJAvMV0CWIdmcs/ddmoTPFqQ7xhE8LITRi5srbx33LGuqFjGrsfbQAdSMFHp7VXvYi5damvLKZccl+b6BsjCosoNZGj2knXTfh+N1C1atYi02qMrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761010875; c=relaxed/simple;
	bh=smMW75L/E+S/bXS/i/5njdyIbfPQLRG1D9pQu49Zuxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j846xgicYd2m8jaLtDqpdn05AEOBUeZc31HW+hQb0j8CpkR13gpObSl7uY6kqlOn4RzGyt/azHYYUbz9yS8Zkwp4ZEkjLRasGuDQ71ihAEElVe1URbl6tia7q/CAPru6ba14ipqHXvWTDz8rpTR2xcH6xgZGOp2oyOl8SwRBGyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DFa9KXHi; arc=fail smtp.client-ip=40.93.196.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYeWGSJ6DBsKa8At8oI2FNDNImfjXwZXCrQbcUXY1smYhvU0C6r9/hAeFL6aEqPDZcTbtl+1B2ZEfo7dc31/l6Dco0MDfRQqSbgGFrPokrbOBkPdNji/hKp6YhrpwUTUnQwvH8abnwKB6pHvQyhHh/8faDJX8am4MU7izQnsEiRrW70/jhSRfG/k2RHVloLUco4YaSjeEH3F/hGyUFvefst0xQ85y96Vf5qe1F6h/lr/KXtrkPLi9TqNu9eESMWZ73Y+70y84sHKDCXZxJUVh+8EYnr5HSNhGgHjFmoaJFj18V8GjnRY+eluk0R0LudDt+LOoe0p20VMt6MI02lGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XqzkUBxU2MGYRmalaWdQ3Ob8deZG/zXrPzcffjwuGw=;
 b=TQvVoYDiWqmSn9rjBkb5mQ88ft6GH7DrimGRRtSp2w0+2JkmfBkpLsbIt3mtHuERVdnz3wCfMiLrQ/JSvga2YElJsvpgnVhxTw1hVoXpgQKX27AZpErFGi5lC9IfqraIE4iMBPYV5X0py2W1NNA7mRmyfRHcHXRRev0b5PEKmCxI3NTTp/DcDd5+tq3hWdgiyZJUBZhLZeMn1TyWBGdhFwoAsB11HjqNTc/CmolLNdyd7USCMrlRlTsyxiv7JgBwisK5BXq1qJxfzFP8Z30rf5XRbgZnr3qNCQzNjSoUa9rMENk/M+IbmwWstW8+5cl34DzegafE+xny0B8LPmpB1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XqzkUBxU2MGYRmalaWdQ3Ob8deZG/zXrPzcffjwuGw=;
 b=DFa9KXHioMNffsdNKQrLisNWFvUt/o+VeVNuQvrmahIMc+GWPUXU5RWXLOC2fNyWF3wHhM4hucbTNU4Lsrs610h7a7QtZZRzkgHaBl9o8rUvu5vegqfT6XGjQeQYjbWW899lqJNraF6L6a8oTI07RVHwt00azMCDTtso+2m5O7sFgG5VbbC1qqepHsCPQ7yrC04ldOV10X6sZUnf8HN9pnlpH5e6TqwL/gdOmFoaV9LpRjoHWRu2/GkoGsqJ941PRY12bOunxdpqTzPi54yW0IvMQd4bEb7XPKO5hJw9alxx+3AdEKlZQmQjghgcArTuvbvxS4pypWVyjxMvPziM+w==
Received: from DM6PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:100::30)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 01:41:08 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:5:100:cafe::ce) by DM6PR03CA0053.outlook.office365.com
 (2603:10b6:5:100::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Tue,
 21 Oct 2025 01:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Tue, 21 Oct 2025 01:41:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 20 Oct
 2025 18:40:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Oct
 2025 18:40:54 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Oct 2025 18:40:52 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, Eric Dumazet
	<edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: [PATCH net-next 2/2] xfrm: Skip redundant replay recheck for the hardware offload path
Date: Tue, 21 Oct 2025 04:35:43 +0300
Message-ID: <20251021014016.4673-3-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251021014016.4673-1-jianbol@nvidia.com>
References: <20251021014016.4673-1-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bddafaf-6f29-4c30-32e5-08de1042e80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d2NzvlMRBk0BPOEsPn1DYDctagzSKf3wo5vW3mlADZTMY1VVm8To7HqiFvwf?=
 =?us-ascii?Q?zKi0Ab25CJ5evA3oxZZKLnrL+RiQGZ0gZ7RxfrTzqR39qWfh5YeVii8310s2?=
 =?us-ascii?Q?WSpkD0SCnFR+gBSNzrTLEHIyfx4zxS9G1APsGyc/fsS8L569RX26ZfVOcT37?=
 =?us-ascii?Q?bOQSfNglRjG8svIN52xUgyouOIH19UlbPsIq/GPB5JYis5lmkV5DLR043TNI?=
 =?us-ascii?Q?juZE4o+3ayQAKD6F4lyakn9cLfoHePJctKGtDwwjanJqoC2ob+PwNIdtXxpr?=
 =?us-ascii?Q?fRHTD/TO//sSbyzGrdzflDw1GQVkBOMJK8EPpmqhFsMrnGqAj9KS6tR+KIsB?=
 =?us-ascii?Q?7+Jz2VhHIToHgRjXGCn7F3K25tb8GiZWV3AG8thkmCjL633rZP9mxPvWvcJ0?=
 =?us-ascii?Q?1TIuVRWYsrMrV0it5ZVuLL7spiN6K1S6Ohde80wdcNDQozMcZYnNmOVfO5t2?=
 =?us-ascii?Q?oM/Z+ABYesDHTbLyWBT0vBr/dwrlXfNa7Zm5s1iPKrho9FusTT4Wq0K8SZcU?=
 =?us-ascii?Q?HmbFOUK7IoCNQTwb+GR0ZCuuBBLJ98fgJ+8GMIsfUvlLhkiGfHTLgvoQO1eD?=
 =?us-ascii?Q?3uzPSqWoCL9Vq9cV7d76x53WbdjhK4s3irECEmh8yHLrpGRJ6P7eIO5uoXff?=
 =?us-ascii?Q?llENwKViRjxN7z09dbEcvw8XhNMURDm8qfAAaTAQO6Ajr7PnzZ/zsw9/A+6C?=
 =?us-ascii?Q?kKPpqiUKXd3C0L603ppGeoVZwHLzUUDDL7iIDGCV38aTZX4jKOMXJ9NuDoJ5?=
 =?us-ascii?Q?Re4wjCEkZjgGTS3Xz576q7GJPUvWG4uWadRNZqgnXkRmMi1//2LXzBqGlz9D?=
 =?us-ascii?Q?xRs3GCSf3PBuDQuYTmUHlgovPXr4KILEvMINSn/nnQdpV0HGkQebA247Bph3?=
 =?us-ascii?Q?vwHqv8kHrHfDq9gAfT4MkkXV32vgk3TkWh0vId5eLni46QOl82S+rkHW0o3Y?=
 =?us-ascii?Q?Khp6BbjZh20aCtdKNBZgzo3UxKfYI2hEA3nKv4WVWZKH9j5V3av1RER+y+Xu?=
 =?us-ascii?Q?k+SE0ngnBF6LSt6T0g07L2lr3wkEPycMYt+HBetkJbQrG2N54QupGTbJ+Ee9?=
 =?us-ascii?Q?HMBohcvBe/m9QbO8TSi6nLCc/uKYkGTv2GRqy6QG+lXtxs9NMFjvPGNLksaN?=
 =?us-ascii?Q?HusWpRaT9AAX3rh0OOO8Q1K1y2fYVKhdoiwEgvXCVDFUq5638vMKKgk1HsGa?=
 =?us-ascii?Q?fuCmRlTEqc5vIQck/6VrTtBJtoMPT1k6e5Qnyn7QtDjCo7XnSV5V08KNSMZ2?=
 =?us-ascii?Q?A0Z9Frux6S52wVdJnMRtlv4yk0l8fjxA5AiVOusi7qpm9hyR1cs6BgA9dDRw?=
 =?us-ascii?Q?ZMJxAP7Mqy3VHl4mnR5ToXnsa+FjZ53d1KHwhmaEDUyfz99Lx346xe55zk6k?=
 =?us-ascii?Q?Cgib/UIeJoavoj+gS6yCNjRdAHhTFakALbGNlhgQ7j+p8pImg2T5gwo9XQg/?=
 =?us-ascii?Q?L7cT+9ktV7BTSwCeLQfUHrfvNaXTt6OSZ3eZESR8ExOeRLFlIUuci4JtzFRM?=
 =?us-ascii?Q?4pBXBsUlt4WjgTof21XTDjH8QRw13xSEk4tlDu2RuzxFKxn3YhY8/afjq8Ee?=
 =?us-ascii?Q?bLYbG1/4i2vJobhM/bo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:41:07.8643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bddafaf-6f29-4c30-32e5-08de1042e80d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001

The xfrm_replay_recheck() function was introduced to handle the issues
arising from asynchronous crypto algorithms.

The crypto offload path is now effectively synchronous, as it holds
the state lock throughout its operation. This eliminates the race
condition, making the recheck an unnecessary overhead. This patch
improves performance by skipping the redundant call when
crypto_done is true.

Additionally, the sequence number assignment is moved to an earlier
point in the function. This improves performance by reducing lock
contention and places the logic at a more appropriate point, as the
full sequence number (including the higher-order bits) can be
determined as soon as the packet is received.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/xfrm/xfrm_input.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 257935cbd221..4ed346e682c7 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -546,7 +546,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			nexthdr = x->type_offload->input_tail(x, skb);
 		}
 
-		goto lock;
+		goto process;
 	}
 
 	family = XFRM_SPI_SKB_CB(skb)->family;
@@ -614,7 +614,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop;
 		}
 
-lock:
+process:
+		seq_hi = htonl(xfrm_replay_seqhi(x, seq));
+
+		XFRM_SKB_CB(skb)->seq.input.low = seq;
+		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
+
 		spin_lock(&x->lock);
 
 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
@@ -646,11 +651,6 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop_unlock;
 		}
 
-		seq_hi = htonl(xfrm_replay_seqhi(x, seq));
-
-		XFRM_SKB_CB(skb)->seq.input.low = seq;
-		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
-
 		if (!crypto_done) {
 			spin_unlock(&x->lock);
 			dev_hold(skb->dev);
@@ -676,7 +676,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		/* only the first xfrm gets the encap type */
 		encap_type = 0;
 
-		if (xfrm_replay_recheck(x, skb, seq)) {
+		if (!crypto_done && xfrm_replay_recheck(x, skb, seq)) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATESEQERROR);
 			goto drop_unlock;
 		}
-- 
2.49.0


