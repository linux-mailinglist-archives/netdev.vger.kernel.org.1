Return-Path: <netdev+bounces-208313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A801B0AE7B
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 09:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00E237A2E4F
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 07:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E20F233152;
	Sat, 19 Jul 2025 07:54:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3332063F3;
	Sat, 19 Jul 2025 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752911656; cv=none; b=Z9dnwepOM89fkyvW1oNFuPskXCKreSGEaVTbPqiQ6iVutL0W9hzrrLC/wAW1eYKZvPxd++in4/0yu+jULCGEwTsKb1Y1fGFNwJS6jFWg8UaCpGJXJ2pZzIugB1PIy6PBbjcM+i0vtYVuG7QXCFV5e8nv9Da7WAQGL1klOQCnyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752911656; c=relaxed/simple;
	bh=xBI0T+96SjFAMoX1/0kuU0TCmJbFkiRVJ+X0k+S96zc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=efnyp7v32LzmZ/QATJrUiaoFyRsh6z88HlKAFJ4ae9Rj26pfsXIrsVvQnmbNH8K4CNFmPwo3DsrEuKviOM0YXoeorC40D7zgE9f0IVYDgCcXDbeoAp/NcpmMI7ZYTWnc62pEQuKLKV+AGaaDr+Z/ijXR0k0Ve7R6tpzx/43Yol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bkf451MfKz13MSy;
	Sat, 19 Jul 2025 15:51:17 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id AD2B0180B60;
	Sat, 19 Jul 2025 15:54:08 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 19 Jul
 2025 15:54:07 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] ip6_gre: Factor out common ip6gre tunnel match into helper
Date: Sat, 19 Jul 2025 16:15:51 +0800
Message-ID: <20250719081551.963670-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Extract common ip6gre tunnel match from ip6gre_tunnel_lookup() into new
helper function ip6gre_tunnel_match() to reduces code duplication.

No functional change intended.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv6/ip6_gre.c | 100 +++++++++++++++------------------------------
 1 file changed, 34 insertions(+), 66 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index a1210fd6404e..74d49dd6124d 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -111,8 +111,32 @@ static u32 HASH_ADDR(const struct in6_addr *addr)
 #define tunnels_l	tunnels[1]
 #define tunnels_wc	tunnels[0]
 
-/* Given src, dst and key, find appropriate for input tunnel. */
+static bool ip6gre_tunnel_match(struct ip6_tnl *t, int dev_type, int link,
+				int *cand_score, struct ip6_tnl **ret)
+{
+	int score = 0;
+
+	if (t->dev->type != ARPHRD_IP6GRE &&
+	    t->dev->type != dev_type)
+		return false;
+
+	if (t->parms.link != link)
+		score |= 1;
+	if (t->dev->type != dev_type)
+		score |= 2;
+	if (score == 0) {
+		*ret = t;
+		return true;
+	}
+
+	if (score < *cand_score) {
+		*ret = t;
+		*cand_score = score;
+	}
+	return false;
+}
 
+/* Given src, dst and key, find appropriate for input tunnel. */
 static struct ip6_tnl *ip6gre_tunnel_lookup(struct net_device *dev,
 		const struct in6_addr *remote, const struct in6_addr *local,
 		__be32 key, __be16 gre_proto)
@@ -127,8 +151,8 @@ static struct ip6_tnl *ip6gre_tunnel_lookup(struct net_device *dev,
 			gre_proto == htons(ETH_P_ERSPAN) ||
 			gre_proto == htons(ETH_P_ERSPAN2)) ?
 		       ARPHRD_ETHER : ARPHRD_IP6GRE;
-	int score, cand_score = 4;
 	struct net_device *ndev;
+	int cand_score = 4;
 
 	for_each_ip_tunnel_rcu(t, ign->tunnels_r_l[h0 ^ h1]) {
 		if (!ipv6_addr_equal(local, &t->parms.laddr) ||
@@ -137,22 +161,8 @@ static struct ip6_tnl *ip6gre_tunnel_lookup(struct net_device *dev,
 		    !(t->dev->flags & IFF_UP))
 			continue;
 
-		if (t->dev->type != ARPHRD_IP6GRE &&
-		    t->dev->type != dev_type)
-			continue;
-
-		score = 0;
-		if (t->parms.link != link)
-			score |= 1;
-		if (t->dev->type != dev_type)
-			score |= 2;
-		if (score == 0)
-			return t;
-
-		if (score < cand_score) {
-			cand = t;
-			cand_score = score;
-		}
+		if (ip6gre_tunnel_match(t, dev_type, link, &cand_score, &cand))
+			return cand;
 	}
 
 	for_each_ip_tunnel_rcu(t, ign->tunnels_r[h0 ^ h1]) {
@@ -161,22 +171,8 @@ static struct ip6_tnl *ip6gre_tunnel_lookup(struct net_device *dev,
 		    !(t->dev->flags & IFF_UP))
 			continue;
 
-		if (t->dev->type != ARPHRD_IP6GRE &&
-		    t->dev->type != dev_type)
-			continue;
-
-		score = 0;
-		if (t->parms.link != link)
-			score |= 1;
-		if (t->dev->type != dev_type)
-			score |= 2;
-		if (score == 0)
-			return t;
-
-		if (score < cand_score) {
-			cand = t;
-			cand_score = score;
-		}
+		if (ip6gre_tunnel_match(t, dev_type, link, &cand_score, &cand))
+			return cand;
 	}
 
 	for_each_ip_tunnel_rcu(t, ign->tunnels_l[h1]) {
@@ -187,22 +183,8 @@ static struct ip6_tnl *ip6gre_tunnel_lookup(struct net_device *dev,
 		    !(t->dev->flags & IFF_UP))
 			continue;
 
-		if (t->dev->type != ARPHRD_IP6GRE &&
-		    t->dev->type != dev_type)
-			continue;
-
-		score = 0;
-		if (t->parms.link != link)
-			score |= 1;
-		if (t->dev->type != dev_type)
-			score |= 2;
-		if (score == 0)
-			return t;
-
-		if (score < cand_score) {
-			cand = t;
-			cand_score = score;
-		}
+		if (ip6gre_tunnel_match(t, dev_type, link, &cand_score, &cand))
+			return cand;
 	}
 
 	for_each_ip_tunnel_rcu(t, ign->tunnels_wc[h1]) {
@@ -210,22 +192,8 @@ static struct ip6_tnl *ip6gre_tunnel_lookup(struct net_device *dev,
 		    !(t->dev->flags & IFF_UP))
 			continue;
 
-		if (t->dev->type != ARPHRD_IP6GRE &&
-		    t->dev->type != dev_type)
-			continue;
-
-		score = 0;
-		if (t->parms.link != link)
-			score |= 1;
-		if (t->dev->type != dev_type)
-			score |= 2;
-		if (score == 0)
-			return t;
-
-		if (score < cand_score) {
-			cand = t;
-			cand_score = score;
-		}
+		if (ip6gre_tunnel_match(t, dev_type, link, &cand_score, &cand))
+			return cand;
 	}
 
 	if (cand)
-- 
2.34.1


