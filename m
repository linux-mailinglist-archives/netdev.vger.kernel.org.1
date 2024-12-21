Return-Path: <netdev+bounces-153912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E068E9FA072
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 12:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53429168DDC
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAA01F0E3C;
	Sat, 21 Dec 2024 11:33:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E452594AE
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734780807; cv=none; b=InlzczTBkfGP7mpucd45OzlkeHa2ODCQhGdyGA90q2vWt9zimdv5Bgo97nnn0mDI/rgvVyvvOmiPhK2SR1wUqgi+fUojrndWxh8+ZBOo0OBBRyHqwvmhK8jeqZCotpqg/ZLGO4TjyUKF8BGgP2cUL7orKX96Bg/YViaFUaDfkdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734780807; c=relaxed/simple;
	bh=94C07Fjvs5n1E5lV+WJBjj7ysGDj2KijUo7ERHYc58Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FxQBh241a0AAAUhCr92XJvZhC8S8VOeftWlUyKlfGyNZmDGI9iJ1VIMRcUm4i72nrAg6U/DIr2X1vJBsoMVD5yOB4gIeih/KoXcgQamRVQ3Gz8QGjRl6oeQqWdWK53SYY7z8w/dMvH61HZWECVt3DmX9Z0T1/gZ8t+WBCeo9rQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YFhtv5zXvz21lqk;
	Sat, 21 Dec 2024 19:31:19 +0800 (CST)
Received: from kwepemg500014.china.huawei.com (unknown [7.202.181.78])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FCF51A016C;
	Sat, 21 Dec 2024 19:33:15 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemg500014.china.huawei.com
 (7.202.181.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 21 Dec
 2024 19:33:14 +0800
From: hanhuihui <hanhuihui5@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<pablo@netfilter.org>, <stephen@networkplumber.org>, <jhs@mojatatu.com>,
	<xiyou.wangcong@gmail.com>, <kuba@kernel.org>
CC: <yanan@huawei.com>, <caowangbao@huawei.com>, <fengtao40@huawei.com>,
	<hanhuihui5@huawei.com>
Subject: [PATCH] vrf: Revert:"run conntrack only in context of lower/physdev for locally generated packets"
Date: Sat, 21 Dec 2024 19:33:08 +0800
Message-ID: <20241221113308.1003995-1-hanhuihui5@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500014.china.huawei.com (7.202.181.78)

In commit 8e0538d8, netfilter skips the NAT hook in the VRF context. This solves the problems mentioned in commit 
in 8c9c296 and d43b75f. Therefore, we no longer need to set "untracked" to avoid any conntrack 
participation in round 1.So maybe we can reverts commit 8c9c296a and d43b75fb because we don't need them now.

Fixes: 8c9c296 ("vrf: run conntrack only in context of lower/physdev for locally generated packets")
Fixes: d43b75f ("vrf: don't run conntrack on vrf with !dflt qdisc")

Signed-off-by: hanhuihui hanhuihui5@huawei.com
---
 drivers/net/vrf.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index b90dccdc2..7b0c35003 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -36,7 +36,6 @@
 #include <net/fib_rules.h>
 #include <net/sch_generic.h>
 #include <net/netns/generic.h>
-#include <net/netfilter/nf_conntrack.h>
 
 #define DRV_NAME	"vrf"
 #define DRV_VERSION	"1.1"
@@ -416,26 +415,12 @@ static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
 	return NETDEV_TX_OK;
 }
 
-static void vrf_nf_set_untracked(struct sk_buff *skb)
-{
-	if (skb_get_nfct(skb) == 0)
-		nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
-}
-
-static void vrf_nf_reset_ct(struct sk_buff *skb)
-{
-	if (skb_get_nfct(skb) == IP_CT_UNTRACKED)
-		nf_reset_ct(skb);
-}
-
 #if IS_ENABLED(CONFIG_IPV6)
 static int vrf_ip6_local_out(struct net *net, struct sock *sk,
 			     struct sk_buff *skb)
 {
 	int err;
 
-	vrf_nf_reset_ct(skb);
-
 	err = nf_hook(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net,
 		      sk, skb, NULL, skb_dst(skb)->dev, dst_output);
 
@@ -514,8 +499,6 @@ static int vrf_ip_local_out(struct net *net, struct sock *sk,
 {
 	int err;
 
-	vrf_nf_reset_ct(skb);
-
 	err = nf_hook(NFPROTO_IPV4, NF_INET_LOCAL_OUT, net, sk,
 		      skb, NULL, skb_dst(skb)->dev, dst_output);
 	if (likely(err == 1))
@@ -633,7 +616,8 @@ static void vrf_finish_direct(struct sk_buff *skb)
 		skb_pull(skb, ETH_HLEN);
 	}
 
-	vrf_nf_reset_ct(skb);
+	/* reset skb device */
+	nf_reset_ct(skb);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -647,7 +631,7 @@ static int vrf_finish_output6(struct net *net, struct sock *sk,
 	struct neighbour *neigh;
 	int ret;
 
-	vrf_nf_reset_ct(skb);
+	nf_reset_ct(skb);
 
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
@@ -778,8 +762,6 @@ static struct sk_buff *vrf_ip6_out(struct net_device *vrf_dev,
 	if (rt6_need_strict(&ipv6_hdr(skb)->daddr))
 		return skb;
 
-	vrf_nf_set_untracked(skb);
-
 	if (qdisc_tx_is_default(vrf_dev) ||
 	    IP6CB(skb)->flags & IP6SKB_XFRM_TRANSFORMED)
 		return vrf_ip6_out_direct(vrf_dev, sk, skb);
@@ -866,7 +848,7 @@ static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
 	struct neighbour *neigh;
 	bool is_v6gw = false;
 
-	vrf_nf_reset_ct(skb);
+	nf_reset_ct(skb);
 
 	/* Be paranoid, rather than too clever. */
 	if (unlikely(skb_headroom(skb) < hh_len && dev->header_ops)) {
@@ -1009,8 +991,6 @@ static struct sk_buff *vrf_ip_out(struct net_device *vrf_dev,
 	    ipv4_is_lbcast(ip_hdr(skb)->daddr))
 		return skb;
 
-	vrf_nf_set_untracked(skb);
-
 	if (qdisc_tx_is_default(vrf_dev) ||
 	    IPCB(skb)->flags & IPSKB_XFRM_TRANSFORMED)
 		return vrf_ip_out_direct(vrf_dev, sk, skb);
-- 
2.43.0


