Return-Path: <netdev+bounces-163098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660F6A2954C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74621885A77
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E61DC9BA;
	Wed,  5 Feb 2025 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0T2HoXs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B283D1DB127
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770701; cv=none; b=JvCIA9yRT5v1upgDkFyBVUy4+3zeDA/HXAU37jkA9C73Pt1slNNElbGFQ14N+LLt3B2Kmx0hcHbgBDtk0WgszEAr/BVxCsvXIi5/RUHHWVFCHcTb8DHsx5IdlR//4sNqtWHqv6nEoJESz/imbaP6H8EC5cTxOC6nBVJ+sXZdx+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770701; c=relaxed/simple;
	bh=23btmb5/UGDMEubSQ5Azq+B7dPv8F6BoOi2IZq4hR/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e6YLOq5cLKuAVOb3oFvaS4aMejxqNpZ/l5yCFbs0m9RGS1OL5dsqPaDSXmAN2UZBCkyNi2DpJ2i8HDG97JZrxRJag5Te62tfCujBd50maAWGaz5B6bfFGkx5KkJbHEQDx9MgBBkQfCXeE3T0dezFAHa1Zc/5ZwNYz2BbShPur6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0T2HoXs; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-866d5db2621so290538241.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 07:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738770698; x=1739375498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZPHU7iJV+gVRf/1/qTDUGCBeN90sukc7iRL0L2hF0Y=;
        b=T0T2HoXssK8hPXipIavCYuUQLpgnubfg9iNzdAOorbmCB+RWy07O8IvCW8zM7/JV+b
         SsDDgRpyLjcnnhUtc+JCSpMRUZh1HZ3l9hmHt4AC+e7yyr3bSv13C2v2a29EMhn/1Hr8
         I+2P97BMb4qcq5C9YTM2JMO0K6pEfoHFq15jA6BAE2SZ+mAFWcHbek4x+XpxpCVriVXA
         HLeE/ZrbvdHT2mz1y8iLOmng0IJ3WKLwTyC1SCZ5fEHtIIhuPBsL0KH8EjuDg9zbRZpj
         1AnF1Rjyfgl1kL4uSoXsPtTig3rVkCWLdy7apPu3RGGdkCmqnJUlYIzJvpbk1VfKK+ov
         Xz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770698; x=1739375498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZPHU7iJV+gVRf/1/qTDUGCBeN90sukc7iRL0L2hF0Y=;
        b=R8JGGEobKFWt5q6Kwjfq9gay3L81GAUZzigj3FYnOPjqiEdSfqzajffh+k+a1MWRLV
         pv68Mb33y3EOa+jb3VuaeP9o4tCYLY6mDwWG0jOgE899RImgz8tdcEDUGfmSkN2nQzbk
         LwQ7iEI7Z5xUDfrn55dTdvONI53ayoP1lLey8GGcasb8kCVL6OtuXzui6fzF1JeQNdAf
         Su90Ar/ggHWfphWtCyc+T9w0px8P2RDznIb3/hvHwmQzVhL/nJ/C7xLiRsC/CYbLQTNQ
         aBisSHuONuOtxBneHr7cFGUFiyMsAzvxsHfNteSy0QH1P4F1WajB1sx5bZKXL7gi6KiY
         hD7A==
X-Gm-Message-State: AOJu0YxY1RHqSBOHSsjFB4yNSQYDDJkwIiaz9k3kggYTtenj4a79NLFd
	JS1M/LAls4nVthk4DhO89kD8KQCBCKdEbY4nKOh41tC8I1wqf5nfdq+SP/RAcjczi2f0p8hDJsj
	fBwNSsdWggw==
X-Google-Smtp-Source: AGHT+IHvy0h/7LxWaCeK6GtBpxkhBAwSQUDHtuvyezO0K+qKUFvpONGgjVslW6dvfYq31p5QCjfjwFAXut099Q==
X-Received: from vsvj15.prod.google.com ([2002:a05:6102:3e0f:b0:4af:e21c:a8f3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:508a:b0:4b4:3a28:6491 with SMTP id ada2fe7eead31-4ba47b1655bmr2101454137.25.1738770698629;
 Wed, 05 Feb 2025 07:51:38 -0800 (PST)
Date: Wed,  5 Feb 2025 15:51:20 +0000
In-Reply-To: <20250205155120.1676781-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205155120.1676781-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205155120.1676781-13-edumazet@google.com>
Subject: [PATCH v4 net 12/12] ipv6: Use RCU in ip6_input()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of grabbing rcu_read_lock() from ip6_input_finish(),
do it earlier in is caller, so that ip6_input() access
to dev_net() can be validated by LOCKDEP.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_input.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 70c0e16c0ae6837d1c64d0036829c8b61799578b..39da6a7ce5f1245145dd74d4ac4eae63dd970939 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -477,9 +477,7 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
 static int ip6_input_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	skb_clear_delivery_time(skb);
-	rcu_read_lock();
 	ip6_protocol_deliver_rcu(net, skb, 0, false);
-	rcu_read_unlock();
 
 	return 0;
 }
@@ -487,9 +485,15 @@ static int ip6_input_finish(struct net *net, struct sock *sk, struct sk_buff *sk
 
 int ip6_input(struct sk_buff *skb)
 {
-	return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_IN,
-		       dev_net(skb->dev), NULL, skb, skb->dev, NULL,
-		       ip6_input_finish);
+	int res;
+
+	rcu_read_lock();
+	res = NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_IN,
+		      dev_net_rcu(skb->dev), NULL, skb, skb->dev, NULL,
+		      ip6_input_finish);
+	rcu_read_unlock();
+
+	return res;
 }
 EXPORT_SYMBOL_GPL(ip6_input);
 
-- 
2.48.1.362.g079036d154-goog


