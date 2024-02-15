Return-Path: <netdev+bounces-71965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5849C855BDA
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 08:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36A81F2D797
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B631118F;
	Thu, 15 Feb 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aTGVftkU"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7717C101CE
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983621; cv=none; b=cqQ0HSLLr4ldDQErnzTCgSfA6sh6CvzQxF31NWuX6A+BGzl4MEBhP10HonZEWuMBhy+blGnYhlJjModUyzsuytnG3lmV+3PxtQG+K1yiVnZcXTm50o443vdgDIT/J3MQxnSvYXXvOV6kdwe6eR9HKTs2+QA1+PW9kFVuwqEEfkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983621; c=relaxed/simple;
	bh=9cHg3wjcin5y0D9ElWUVLUBFZq0JeImjD7keR8Hmkps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hYVPweGG0zXSFH365QnVciWLSAA/HlMfA4TKKfJMUqI+fHNIx646oMtGO5gFooNUc6JE1BtGz7ZmiwwkJRDVFHI+0eKYR/h1urpD4ZmARqPYB6xUQyyPj+oyfl0JHHBsKjGjsrbib6t6FJIaYWNlOS/9zabfud5IMKJl1VectcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aTGVftkU; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id CE32E201BD; Thu, 15 Feb 2024 15:53:30 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1707983610;
	bh=yGYwpJe0AvePSo/Ejb9VzBlifhHcN5/yw9ZU3wnDojY=;
	h=From:To:Cc:Subject:Date;
	b=aTGVftkUGQaOsXlho2Raxk6YwRP4opncA3ds8orpwSgiOwlq/PM6RDGhtFjzEl25F
	 FO412ux3ipI4G/5MsMUhmdmKZ1hjQBhJ8zeNTn4n1myHYeZ4LLVAbEEPu68tvefIJI
	 QZC+d0Pog2hYWMNGgWnKpcsiJU4I1ycrMdlquSu+fwmdHxzu0MiwO06IAB5FMYxTxh
	 4B/cUoyMlahMx2D9Lv6qQtlknUVRV/8DwChbZGjjqHfTadzawW5k63YRGWrIwrCZJ5
	 HAcZAtIK+dtV4y628Xky2GjJDLGM3tdLUF4hstaLvK8xngvPGyOgFnF/19AxBw/uGy
	 9pWJAM86ecqDA==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: mctp: take ownership of skb in mctp_local_output
Date: Thu, 15 Feb 2024 15:53:09 +0800
Message-Id: <f05c0c62d33fda70c7443287b2769d3eb1b3356c.1707983334.git.jk@codeconstruct.com.au>
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
 include/net/mctp.h | 1 +
 net/mctp/route.c   | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

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
index 7a47a58aa54b..a64788bc40a8 100644
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
@@ -903,7 +903,7 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
 		rt->mtu = 0;
 
 	} else {
-		return -EINVAL;
+		goto out_free;
 	}
 
 	spin_lock_irqsave(&rt->dev->addrs_lock, flags);
@@ -966,12 +966,17 @@ int mctp_local_output(struct sock *sk, struct mctp_route *rt,
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


