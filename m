Return-Path: <netdev+bounces-164002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F62A2C442
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE5516A448
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8087E1F91E3;
	Fri,  7 Feb 2025 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imLN6fJF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02871F9410
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936731; cv=none; b=XmVczUsE5AkXzc4YAOW4ZJvMmFf1jYGkmKZfs/lTr2CX6ALBSeL4TeeUn0YDES0yntvu2No8hvBrRcMmOKXAyK3PP8GxX2di5bd9VSnVFDbB0lFxLROuzhkbVMJlzwQH2Edz4/+N5PxRgqgF0IcCoJFOd/s+bI8ZfTXcUgktawU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936731; c=relaxed/simple;
	bh=YZdlvoj7JhlWR5246svYqvlf7WhjvSCGAJ2LxegGSgo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eQJZ35cngedxGFRYbJHbXFYPM9XL0bVcTKHfTXXgsD1Z0OErxAFdZp5VSrkzboBQfF6iOjqI2LeN4dKdzE9rYTuiR+AIzZKmcHW2MOtGVi0QkbCIIaw88W/lnOYyhKP8f7fyZBICtBzMLEUQeIW7Df0sfSqBoMcSRiytn9TLzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imLN6fJF; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e4482f62d3so16914226d6.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 05:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738936729; x=1739541529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jUTM0uTs91sgxjB4NsZKQ816BSYC7SHxHAK0Ey/6UXg=;
        b=imLN6fJF6Pzp2vzOZCU1z/FZz9d/GtmJlR6zxAFGsbm3pGrh5pXBSYAqBdnq+Crr9Y
         m9/YwnXi+RHsPGbTwLQwtu3EZylWdh1m3Kvdi90LLJI67EItLV+He6IhjbQOR2RDu1C2
         mE4pDXT/Wg6zhLu+dg0HNLATYHGdlQLOYRTlbvmq15eNwRjwtaaen2pFtinAChrb0pBM
         0t0qiy+dOZ5ACrY8IwgDYRxRL+lEeCx3ZKGXH9sbEOgn4m6GB89UMpA8WqWrw4tmUeZY
         8qHOJ4EIPOQWEJb41tDWxdx2TkWH/fZ82WhfFhigR5IL2/nQpAD5qS9oQSnZl2qMeTy6
         Qezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738936729; x=1739541529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUTM0uTs91sgxjB4NsZKQ816BSYC7SHxHAK0Ey/6UXg=;
        b=J+BuZkCqTjiJNUDwpAT8cJkTmWsWhy0Le58VHPYn54Cb3pa+WszzejJykTeLpIlMe4
         i+JSMAHSESbWgKcQhqNTfvj2t+WgNbPCp1iNycjN6SrOqd51u3CWsXkWNIWjfEJwN8JJ
         h2fZ49tn06SIcd/Xzwc1kVMu7dM5HhbOwtObdBRSIahn75As7H1OJBCp92MEY2/mA+U6
         ce4waAdASkz1Y7HW7XUJsg+ibvVApCh4PUZ02R4QDu2nNWW8CEYGvH5xtbGKG+UWcoYz
         8KrNkhKzgCDvUY5N9gSorbZLCFPoFuQvM4x00F/ubjtPMffIMsRIC2yulxjaWASgTEjC
         mA1g==
X-Gm-Message-State: AOJu0Yzy+vmDFjPZbGib+82dcP7o6NYaQDMqrNFlXrIPNnqB+9RLExF/
	b7quwzrvfLpkVnQ/OqsFdNGIYBWA/DLehu/a6pU5goCYFOFVXmdShcbJ4kPld9TavwVWDeNC0ji
	Rb+Jg4cWrdg==
X-Google-Smtp-Source: AGHT+IGmUIFwH6VsoM7VllML1Pv+8e3FzGm45KDEN7pJa4raKRBq0EARiz9ZfiRS/2gHVmQootRUjNzbIZT8Lw==
X-Received: from qvbks20.prod.google.com ([2002:a05:6214:3114:b0:6e4:3c9f:e520])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5f89:0:b0:6d1:9f29:2e3b with SMTP id 6a1803df08f44-6e4455ea3c8mr45908216d6.13.1738936728268;
 Fri, 07 Feb 2025 05:58:48 -0800 (PST)
Date: Fri,  7 Feb 2025 13:58:36 +0000
In-Reply-To: <20250207135841.1948589-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207135841.1948589-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207135841.1948589-5-edumazet@google.com>
Subject: [PATCH net 4/8] arp: use RCU protection in arp_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

arp_xmit() can be called without RTNL or RCU protection.

Use RCU protection to avoid potential UAF.

Fixes: 29a26a568038 ("netfilter: Pass struct net into the netfilter hooks")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/arp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index cb9a7ed8abd3ab17403f226ea7e31ea2bae52a9f..f23a1ec6694cb2f1bd60f28faa357fcad83c165a 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -659,10 +659,12 @@ static int arp_xmit_finish(struct net *net, struct sock *sk, struct sk_buff *skb
  */
 void arp_xmit(struct sk_buff *skb)
 {
+	rcu_read_lock();
 	/* Send it off, maybe filter it using firewalling first.  */
 	NF_HOOK(NFPROTO_ARP, NF_ARP_OUT,
-		dev_net(skb->dev), NULL, skb, NULL, skb->dev,
+		dev_net_rcu(skb->dev), NULL, skb, NULL, skb->dev,
 		arp_xmit_finish);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(arp_xmit);
 
-- 
2.48.1.502.g6dc24dfdaf-goog


