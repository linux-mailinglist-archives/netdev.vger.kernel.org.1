Return-Path: <netdev+bounces-73183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D51885B49A
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593E42823C0
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEC25C03D;
	Tue, 20 Feb 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="UzPkOK9S"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA15BAF7
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416662; cv=none; b=NF2LMiXn8BVg5wxBgI5qWYEY27vW/ZE3/QC5zul8MsQ1JSwWZ7ZMcIdJm83txi/omgccCmFown14b5iUvjRTKWvtkIyOzsAZS46pIhEdjoVPByKcvq48W9jkxGg0a0ETjuzjGzVYC62Kmnp4P0yn8t+mAPrDMK3ZcdTaSm5nAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416662; c=relaxed/simple;
	bh=T9EwXJqCkGNWNhDPMZf1uaNk7G1DJs3s0eDFQKSfOfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uKKy5XC0zVOiP+OB/7AdrsBwkXLsoy+9IbMJKYa7NXCtNSU9Jeo+ffRrfp/+AHDs0zzpKnYIcSYTJ6c9Pk08xyGOIjb6vB2B5NzWmnfNV73vHgo5j7AGmasp1z3lj9vmt4ZRVBwjOPyDpnAEE6hfzgk/q18H0yzoT2udJeEPo1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=UzPkOK9S; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 291EA201C4; Tue, 20 Feb 2024 16:10:59 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708416659;
	bh=vrGtsY0rQGA/ofVK3j9p4tcFMAw7x9tuYCk7m9RZd/M=;
	h=From:To:Cc:Subject:Date;
	b=UzPkOK9SDbyAmoyM13fWYsrSVJVz6z2CHiUTtM6q10MM6kLCDsnzwkPgpQ1dejqPR
	 MSRpPANwZJKpeV0qDFAK84WjCIYcSw5wNNYCSSVFh4SSqBdv8pu9EYHPS9OkFjjjGy
	 T4z4q2OyoSEwAJ3Fhi+8fsbkLEsbGZSLuQGzTDBXRNIboqX10OxKI30pfpYkNE0MGd
	 SemzjzZMzHU3c+2P9HQ82iZ0azzNNjDe44XrAbR9V1Cng6DqFR/IY8EEYYGr/t/hd/
	 uHHw92p4pJiLRarNd2hZQA0S7EF7KAyR+0fFB+IAnijak9I5WDZY8Fr6gIjDEcNj5a
	 cZJlnV5Ju0QKw==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2] net: mctp: take ownership of skb in mctp_local_output
Date: Tue, 20 Feb 2024 16:10:53 +0800
Message-Id: <20240220081053.1439104-1-jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, mctp_local_output only takes ownership of skb on success, and
we may leak an skb if mctp_local_output fails in specific states; the
skb ownership isn't transferred until the actual output routing occurs.

Instead, make mctp_local_output free the skb on all error paths up to
the route action, so it always consumes the passed skb.

Fixes: 833ef3b91de6 ("mctp: Populate socket implementation")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v2:
 - retain EINVAL return code in !rt && !ifindex case. Based on feedback
   from Simon Horman <horms@kernel.org>.
---
 include/net/mctp.h |  1 +
 net/mctp/route.c   | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/net/mctp.h b/include/net/mctp.h
index da86e106c91d..2bff5f47ce82 100644
--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -249,6 +249,7 @@ struct mctp_route {
 struct mctp_route *mctp_route_lookup(struct net *net, unsigned int dnet,
 				     mctp_eid_t daddr);
 
+/* always takes ownership of skb */
 int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 		      struct sk_buff *skb, mctp_eid_t daddr, u8 req_tag);
 
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 7a47a58aa54b..d0c43812bec3 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -888,7 +888,7 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 		dev = dev_get_by_index_rcu(sock_net(sk), cb->ifindex);
 		if (!dev) {
 			rcu_read_unlock();
-			return rc;
+			goto out_free;
 		}
 		rt->dev = __mctp_dev_get(dev);
 		rcu_read_unlock();
@@ -903,7 +903,8 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 		rt->mtu = 0;
 
 	} else {
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out_free;
 	}
 
 	spin_lock_irqsave(&rt->dev->addrs_lock, flags);
@@ -966,12 +967,17 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 		rc = mctp_do_fragment_route(rt, skb, mtu, tag);
 	}
 
+	/* route output functions consume the skb, even on error */
+	skb = NULL;
+
 out_release:
 	if (!ext_rt)
 		mctp_route_release(rt);
 
 	mctp_dev_put(tmp_rt.dev);
 
+out_free:
+	kfree_skb(skb);
 	return rc;
 }
 
-- 
2.39.2


