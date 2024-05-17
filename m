Return-Path: <netdev+bounces-97005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B7A8C8A46
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B151F24340
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E97F13D890;
	Fri, 17 May 2024 16:50:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.6.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AC438DD6;
	Fri, 17 May 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.6.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964635; cv=none; b=B5UGodzSNzuxC6LGgimx+eg3mNq1zQiok83GmBJp+zBzZdrRTPbkBmMnPlIYM0AsxrBhtCNfmEbmiYX/+GPTlkPcToHHXQv0xBAWoFIZOBTiRMNGyaDU02oIxDrR5J/+ne3cUEc64UhMg0tb3UdtVwhJceEaJ0s72fxiwc++1fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964635; c=relaxed/simple;
	bh=vMk0iJkt/6usvlUHcGZ0FKv+OTl9fcKjbBfN0zsDtHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SwRyTrVCBnnhnuX5VL94DBIvdJ4jp79XiV8fOnmt4oXKhR3TWyQTnwurt7nWjlIfPr/9321gr7Mr4aHsq0vlPu+0JzoIaOCVT9+CR6M3HfZTL2q9yd7svM0EcFKe0zClhYWwndoQxvxDH30k1KhqrzpFRyuWcLvZGo04qhevUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.6.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 44HGkJN1020258
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 17 May 2024 18:46:20 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Lebrun <david.lebrun@uclouvain.be>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [net] ipv6: sr: fix missing sk_buff release in seg6_input_core
Date: Fri, 17 May 2024 18:45:41 +0200
Message-Id: <20240517164541.17733-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

The seg6_input() function is responsible for adding the SRH into a
packet, delegating the operation to the seg6_input_core(). This function
uses the skb_cow_head() to ensure that there is sufficient headroom in
the sk_buff for accommodating the link-layer header.
In the event that the skb_cow_header() function fails, the
seg6_input_core() catches the error but it does not release the sk_buff,
which will result in a memory leak.

This issue was introduced in commit af3b5158b89d ("ipv6: sr: fix BUG due
to headroom too small after SRH push") and persists even after commit
7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane"),
where the entire seg6_input() code was refactored to deal with netfilter
hooks.

The proposed patch addresses the identified memory leak by requiring the
seg6_input_core() function to release the sk_buff in the event that
skb_cow_head() fails.

Fixes: af3b5158b89d ("ipv6: sr: fix BUG due to headroom too small after SRH push")
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_iptunnel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 03b877ff4558..a75df2ec8db0 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -459,10 +459,8 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	int err;
 
 	err = seg6_do_srh(skb);
-	if (unlikely(err)) {
-		kfree_skb(skb);
-		return err;
-	}
+	if (unlikely(err))
+		goto drop;
 
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
@@ -486,7 +484,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 	if (unlikely(err))
-		return err;
+		goto drop;
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
@@ -494,6 +492,9 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 			       skb_dst(skb)->dev, seg6_input_finish);
 
 	return seg6_input_finish(dev_net(skb->dev), NULL, skb);
+drop:
+	kfree_skb(skb);
+	return err;
 }
 
 static int seg6_input_nf(struct sk_buff *skb)
-- 
2.20.1


