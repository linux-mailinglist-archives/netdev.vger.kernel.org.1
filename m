Return-Path: <netdev+bounces-164006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6290CA2C450
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6C516B4DF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E823822068D;
	Fri,  7 Feb 2025 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJpuaj5C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4FF212FBC
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936736; cv=none; b=e7TDaoZbBxADNWjS4dte5CPbGJLQHozH7DoIbn7pwVu7E8Hili1aMQfATFfqEuInusX2fisrzGC7pBeuorIyMhspZhes4kyWpBWLGK3MOZBLDDLDM7/bTGuV28IRHfWbSyqiMzcP0vIK4CnxX2I1dymYIadz3a+Cdi26++3qjsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936736; c=relaxed/simple;
	bh=BSlpgDTG2Fr7hbiihOQf1WACP2NvQoi7ZQqYL9HMoKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vFlUCW4F8uaGkw1eiClFas/BiCxcgOaznkxM5brm2YHFFIL9TWay0lSTTbweMb7a6M+CbNUE0RXFuTgB28JukOK9WulFUyquXxXeQjtAiU0bozvl1DbKIU8lJZ/+qCO5P+yNUYxJGTL38REebu75OXk0RDB7lg44K7dRZ69MI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJpuaj5C; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-467b5861766so39028681cf.2
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 05:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738936734; x=1739541534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ChZ4IRphUYImFbjgGHf7CKcI7RILBkFZjntsWsfQYgY=;
        b=sJpuaj5C2pQSHIofG/xs3jzU28VsltcjZYDPZCDnnxhI7BSLixntcabXH1Yzj+NVu+
         b1AzkX/6/JcjEBdGsprrzlFRtTODqIMxOrenIvKFczZHl3BcHkjyYZAzAGON7wHQ4Wnn
         S24NbtHU02oZQNumhdzwQBubMufgVUBRtET+kwaEgt93i6sP5mLYJSBykSRDwZEczvwI
         kHEEU8AKxVFETm3EjX9snkCn6yBBKok4KE9aXo8yEOenGlfE+j/nxp9AnOtQJMNr6pGI
         l4zBhtDu/o5rRNDJoyIcw6+3Nx/Hy2DKwNXhkE5yCoyiZjNWcW+cL/exqnoWgPBzUk50
         bMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738936734; x=1739541534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChZ4IRphUYImFbjgGHf7CKcI7RILBkFZjntsWsfQYgY=;
        b=qNra57lTWfpYfYRKqjYUPGZm7X98GmvV2UrOd6SDZp32VsQZTundU8vM3XZAvNT/ow
         bqY0kgZxsZ5HMrDYbe4agESsdnTm0S+lWMNCZCnrC1dbfb8JFZ1r1V5ZpGMFUYmkyxNV
         1I3KugViNP8a2OUq1a5BEhxAks/LmANLqS8w46zUFQd/EfFHQ8fcGB+nHp8hWo8rK6VU
         tLDVxsI5TnshKXB+DYgsJjkEE3bpIrrnYlhGaCUMcfIpRbG530mpDUNMZy8vUkv8tvYT
         wLYSnbEQWptGI7+MQbVnUG2QBlfaPG3bVhe83ZhzW5o33/W5mpBnUHqlTnxKKmYrQ9lA
         ut+Q==
X-Gm-Message-State: AOJu0Yx6rfNpOgaAXL5/ImlCxEK0BJpZdFCHQKw5bdOC3mpMN45THkNX
	EOWSvUG5vs297mdJnqigPizyjSfSWJjONj18FXGd5CIgqhTGl4IAGZxi/Fs2mK8OC6DhLgaA4Vj
	PCIOHqZiVMg==
X-Google-Smtp-Source: AGHT+IG5lPJTOUia1yxV4mb6TxVSgxlYEX0B/TzZNnqIN2yX+bdC58iBKUHxZ7Iqn+E4jV+m6Egy0mPIc9s0eg==
X-Received: from qtbgd21.prod.google.com ([2002:a05:622a:5c15:b0:467:971c:6905])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a51:0:b0:460:8f80:909a with SMTP id d75a77b69052e-47167ad842dmr41409961cf.32.1738936734100;
 Fri, 07 Feb 2025 05:58:54 -0800 (PST)
Date: Fri,  7 Feb 2025 13:58:40 +0000
In-Reply-To: <20250207135841.1948589-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207135841.1948589-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207135841.1948589-9-edumazet@google.com>
Subject: [PATCH net 8/8] ipv6: mcast: extend RCU protection in igmp6_send()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

igmp6_send() can be called without RTNL or RCU being held.

Extend RCU protection so that we can safely fetch the net pointer
and avoid a potential UAF.

Note that we no longer can use sock_alloc_send_skb() because
ipv6.igmp_sk uses GFP_KERNEL allocations which can sleep.

Instead use alloc_skb() and charge the net->ipv6.igmp_sk
socket under RCU protection.

Fixes: b8ad0cbc58f7 ("[NETNS][IPV6] mcast - handle several network namespace")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/mcast.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 9dfdb40988b0f8edd882c07b555ea0115ee95cab..81a739ebf7094694a6f5de5020cd4c4d1c9642d1 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2165,21 +2165,21 @@ static void mld_send_cr(struct inet6_dev *idev)
 
 static void igmp6_send(struct in6_addr *addr, struct net_device *dev, int type)
 {
-	struct net *net = dev_net(dev);
-	struct sock *sk = net->ipv6.igmp_sk;
+	const struct in6_addr *snd_addr, *saddr;
+	int err, len, payload_len, full_len;
+	struct in6_addr addr_buf;
 	struct inet6_dev *idev;
 	struct sk_buff *skb;
 	struct mld_msg *hdr;
-	const struct in6_addr *snd_addr, *saddr;
-	struct in6_addr addr_buf;
 	int hlen = LL_RESERVED_SPACE(dev);
 	int tlen = dev->needed_tailroom;
-	int err, len, payload_len, full_len;
 	u8 ra[8] = { IPPROTO_ICMPV6, 0,
 		     IPV6_TLV_ROUTERALERT, 2, 0, 0,
 		     IPV6_TLV_PADN, 0 };
-	struct flowi6 fl6;
 	struct dst_entry *dst;
+	struct flowi6 fl6;
+	struct net *net;
+	struct sock *sk;
 
 	if (type == ICMPV6_MGM_REDUCTION)
 		snd_addr = &in6addr_linklocal_allrouters;
@@ -2190,19 +2190,21 @@ static void igmp6_send(struct in6_addr *addr, struct net_device *dev, int type)
 	payload_len = len + sizeof(ra);
 	full_len = sizeof(struct ipv6hdr) + payload_len;
 
-	rcu_read_lock();
-	IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_OUTREQUESTS);
-	rcu_read_unlock();
+	skb = alloc_skb(hlen + tlen + full_len, GFP_KERNEL);
 
-	skb = sock_alloc_send_skb(sk, hlen + tlen + full_len, 1, &err);
+	rcu_read_lock();
 
+	net = dev_net_rcu(dev);
+	idev = __in6_dev_get(dev);
+	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 	if (!skb) {
-		rcu_read_lock();
-		IP6_INC_STATS(net, __in6_dev_get(dev),
-			      IPSTATS_MIB_OUTDISCARDS);
+		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 		rcu_read_unlock();
 		return;
 	}
+	sk = net->ipv6.igmp_sk;
+	skb_set_owner_w(skb, sk);
+
 	skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(skb, hlen);
 
@@ -2227,9 +2229,6 @@ static void igmp6_send(struct in6_addr *addr, struct net_device *dev, int type)
 					 IPPROTO_ICMPV6,
 					 csum_partial(hdr, len, 0));
 
-	rcu_read_lock();
-	idev = __in6_dev_get(skb->dev);
-
 	icmpv6_flow_init(sk, &fl6, type,
 			 &ipv6_hdr(skb)->saddr, &ipv6_hdr(skb)->daddr,
 			 skb->dev->ifindex);
-- 
2.48.1.502.g6dc24dfdaf-goog


