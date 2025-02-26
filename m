Return-Path: <netdev+bounces-169956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1491CA469E0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E13A1953
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A55621CC53;
	Wed, 26 Feb 2025 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ntYMS4pb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959C233D64
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594888; cv=none; b=KO70/MOMN2I7ej8f9I8a3+llAlgRyEEmU0qy85ab7g19fnx3jUdSIOxCVYbyvLE024o/Z6bvgm1ti299ZjQaixEtyyeTZYhtIMUNVbW8avskdGQksd5F8L/0j8+dWbdhm38uVOBVDU/twIpwy/KKtHLoud58ZnpXnnpDMV4wmCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594888; c=relaxed/simple;
	bh=3sZfZtOKL3PpVdC39mlrXhBge0rl1bXXre5FIIr8k4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BJU4ZK0du/6sJWmJzqJY31wB8UWcoLxC8agX0/r8pr/CTz9FQPmFjI/hyiq9iNiBMPFWv7lxpIZnQUhpOdx5UUC0nz/V3HJPiVnV0+U9+cfhO2ppf5Yo+zTXrBY/rbZDMq6+lNzyD/KsCrYnfft9oRj7IbcgKVfasCRbC4dWk8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ntYMS4pb; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e66da368dcso3243766d6.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740594886; x=1741199686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I4hiN/VZM10UazaG5cSjXr3c/vEDQf1vDgCFbogESV0=;
        b=ntYMS4pb8EWjl74dRC5pJvaYUxIQUB/KNFVhTe+NdHeR/R5sXvLagdd9iVx5yXEMHd
         t34FSt40BhTxCVyd48MtSn0eC4wjLM2WubawZg/iC7jFEMT+aDsUo+ua0UOEKuwBji5z
         GCoD59CFES9W44xK6OUqPI0lpsGrmwk0vWjaNeMSS/JeDRdKZa+KkelJoTxTLaVAgKFm
         Zp0pie4nPYDQfwyM+p9re8QlD4+sYk44NCUWv3nBstqmZWeVpeVQaqNsdbLeoeiGnPTX
         sEF7s8tRRtrN020/mYPR4BwWjHMtGBbndOy5Rgkr5F41sZmeA4FFpIwql5e5xM2OLa+4
         6mTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594886; x=1741199686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4hiN/VZM10UazaG5cSjXr3c/vEDQf1vDgCFbogESV0=;
        b=deSjGPjBo1FqVdLO5n7xtDc0NxVVf5CVa9ZLhnCh8WBmkddnQbUQIHtR3fFZh4rDmC
         gSs5rpfx2K4FrEMT+1VcbqJW5zPTd4XGcXhL+ZgW7uQyrmROw34FuklqA09JWEJtcwST
         Bx2uxlom90mhz/D77X9VSNa6IJELP5jYG1T5HGW+LiVVUbgGqoE7NDGPRLUUnkvTqJ+j
         EdqhIl1OHNggyDnMf9kBzguHfn1b4Yh0d2PbrF6sqhoEYag3H2kmjU34MIHGMPYRe2we
         pcv7FfC7OBRQUxrhEgUmaZ+fIYN+AwNnkAEUhxgNkry3rJxQLeHzH97F7SlYXEp/HXyL
         +L8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/X+3BV760bNfa6fTn/1ex9gfFuGGg+dUtuOYC2etjY6qQ0d4q9L90f2QHg/n+QQb7jG1Ox6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xA4FBC4Rg0EreHLcbdLTD9EChwqwcpUKyCcbPTQ7cHuJd9RP
	zQAYQlXpZTJ3CMVMNvKYrUzEvfzuhOML+jyWuXN1SQ/c0YHd43CEhWPig4zVhhVSmS0m5AhqoAO
	aoVBukrSTEQ==
X-Google-Smtp-Source: AGHT+IG16cDtr7NH9TWdwx1dia+HRZzDsTVJZZbv7Fjlq5tfQQm4iGULi25+4YzjCIdvmFvEmC01UPEl7za0IA==
X-Received: from qvzc2.prod.google.com ([2002:a05:6214:702:b0:6e6:5bdc:ac7d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2b08:b0:6e4:6ef7:b5fc with SMTP id 6a1803df08f44-6e6ae7f7ef2mr284964336d6.14.1740594885888;
 Wed, 26 Feb 2025 10:34:45 -0800 (PST)
Date: Wed, 26 Feb 2025 18:34:37 +0000
In-Reply-To: <20250226183437.1457318-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226183437.1457318-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226183437.1457318-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] inet: ping: avoid skb_clone() dance in ping_rcv()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ping_rcv() callers currently call skb_free() or consume_skb(),
forcing ping_rcv() to clone the skb.

After this patch ping_rcv() is now 'consuming' the original skb,
either moving to a socket receive queue, or dropping it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/icmp.c |  5 +++--
 net/ipv4/ping.c | 20 +++++---------------
 net/ipv6/icmp.c |  7 ++-----
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 058d4c1e300d0c0be7a04fd67e8e39924dfcd2cc..717cb7d3607a1c77a3f54b56d2bb98b1064dd878 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1274,9 +1274,10 @@ int icmp_rcv(struct sk_buff *skb)
 		}
 	}
 
-	if (icmph->type == ICMP_EXT_ECHOREPLY) {
+	if (icmph->type == ICMP_EXT_ECHOREPLY ||
+	    icmph->type == ICMP_ECHOREPLY) {
 		reason = ping_rcv(skb);
-		goto reason_check;
+		return reason ? NET_RX_DROP : NET_RX_SUCCESS;
 	}
 
 	/*
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 85d09f2ecadcb690f01985771afa37ce2cd0befc..c14baa6589c748026b49416688cbea399e6d461a 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -966,10 +966,9 @@ EXPORT_SYMBOL_GPL(ping_queue_rcv_skb);
 
 enum skb_drop_reason ping_rcv(struct sk_buff *skb)
 {
-	enum skb_drop_reason reason = SKB_DROP_REASON_NO_SOCKET;
-	struct sock *sk;
 	struct net *net = dev_net(skb->dev);
 	struct icmphdr *icmph = icmp_hdr(skb);
+	struct sock *sk;
 
 	/* We assume the packet has already been checked by icmp_rcv */
 
@@ -980,20 +979,11 @@ enum skb_drop_reason ping_rcv(struct sk_buff *skb)
 	skb_push(skb, skb->data - (u8 *)icmph);
 
 	sk = ping_lookup(net, skb, ntohs(icmph->un.echo.id));
-	if (sk) {
-		struct sk_buff *skb2 = skb_clone(skb, GFP_ATOMIC);
-
-		pr_debug("rcv on socket %p\n", sk);
-		if (skb2)
-			reason = __ping_queue_rcv_skb(sk, skb2);
-		else
-			reason = SKB_DROP_REASON_NOMEM;
-	}
-
-	if (reason)
-		pr_debug("no socket, dropping\n");
+	if (sk)
+		return __ping_queue_rcv_skb(sk, skb);
 
-	return reason;
+	kfree_skb_reason(skb, SKB_DROP_REASON_NO_SOCKET);
+	return SKB_DROP_REASON_NO_SOCKET;
 }
 EXPORT_SYMBOL_GPL(ping_rcv);
 
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 4d14ab7f7e99f152cd5f5adaa023f0280957f275..3fd19a84b358d169bbdc351c43ede830c60afcf3 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -957,12 +957,9 @@ static int icmpv6_rcv(struct sk_buff *skb)
 		break;
 
 	case ICMPV6_ECHO_REPLY:
-		reason = ping_rcv(skb);
-		break;
-
 	case ICMPV6_EXT_ECHO_REPLY:
-		reason = ping_rcv(skb);
-		break;
+		ping_rcv(skb);
+		return 0;
 
 	case ICMPV6_PKT_TOOBIG:
 		/* BUGGG_FUTURE: if packet contains rthdr, we cannot update
-- 
2.48.1.658.g4767266eb4-goog


