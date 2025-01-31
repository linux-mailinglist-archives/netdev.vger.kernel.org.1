Return-Path: <netdev+bounces-161803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADD2A241B0
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB50A188AD44
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3ED1F2388;
	Fri, 31 Jan 2025 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CYRlLuqA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B81F0E2E
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343639; cv=none; b=MTovATICBuJa6o4U6Jj57g1S2N0J3kZe55t94dXPBvS0lMHx317FdaqdN3D/3/F//XEpKczdiGA9lq8WjpQk0davcsqgtWNvNaYbDAQYJfpNrrg/9/4sUOkHJlu7dsKyyTSX/tiNrtKcw5teEzH9FEQa4d2yy8tf+YOyqB4JGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343639; c=relaxed/simple;
	bh=Rjkgkmd9WlNhCGLwhOYrVQy7Fu3bO/Qwn1QgOk94YJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FmRx4s5st5Fcdf3mqFjQ1soXhl2t37/x1C2vViPoSKZgRyR+qEnjXfW4gD9YtzOeu/4mKEhjRyCwVwL6PTdCtBLmU4+b2GvKFqC288I/SiS41LtGwl4QAz77eo7vVo4gh8UgL+WQ/0U11dEYXyZXL0YuKlKVY9sLdM/jdHHJt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CYRlLuqA; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7be96bd50caso426717585a.3
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343636; x=1738948436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fCuH8g8ti5NQ2ZijQC2+wOKhhnOhYLNmT0OBGWEk+1s=;
        b=CYRlLuqAsQKWzbEV3emWR4YyXi/N4JsRFn0Egg2dlRhHOQdiCpxeWbU7LCE3kFCXYP
         q9SJzXYft9ae9yBdMRNHHQrzTUyOoihzZb4psqoN4liNLcxIV97TdMf2nkxe+sUXS2AX
         JnBlnEGo5kpmSdrsf13bOS1UFrOBIPKlnoK936C/EYUVQ0SboVKZQaXlwwqt8AbbREnF
         zXiFTJtw/+wez8p5+vOOOrvStFz9RvM6TiLFKaXB5lqFWWEOACJyteoBjB6dxW433kGD
         B9u6vEqkTcGFDsSZ+9fkz+6ad7AdxZ6Vkh3pJyFT0+Ihpht1FBGB7LJip37FgZeI0ZV1
         Yzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343636; x=1738948436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCuH8g8ti5NQ2ZijQC2+wOKhhnOhYLNmT0OBGWEk+1s=;
        b=PaMYXptz5kLTGjgYwyRlfCSTPmK3o7HtgtcoE0ZEOKTbeUmjP2j7KMs4XIADCixr0f
         Y3lIca1oeydV3huKl26pV+8/d+ZMhOrt0IAvfDq+4rJiJVzHpWNO7JFxgLjIYYhGoKYw
         xByyv3kOyWT6UdR04HNzZ/DZdJdE+x826xXSj+uSqh4Fw/7vmdSTyslxLW71KZRZgDgf
         LYtUqQHo5HjpOhw6blr4RwAANW6ltREEAxYtCY+nKmybTTKp0sq4e+Y85uaN+x3RZvno
         bFquGG+f0mgp6ttBW62kzxYfGlWUqG7kLbiNZ816MDspi8pdiM0NDrXljmlXRjFBF8vN
         cUlw==
X-Gm-Message-State: AOJu0Yy4E1P7GO697Xa44wj4w2uGrAFsJGSKaifkJbFNRXZ9632NnNzG
	V+75fSJdTdE2ynrot/fS5qa7Xc3+nf1mzu97XUZpDR6IID5UR9px2TwoAyrMT852V/0+o5cayka
	tNMAHUTAYdA==
X-Google-Smtp-Source: AGHT+IF5BgOJKOJyRzueP/Fylsd2XqzmCgDR0SA56Bon6svG3Tw4uwE/sp+7vb+iYf4FGHhBLrGg4GwAfHXc4w==
X-Received: from qkoz12.prod.google.com ([2002:a05:620a:260c:b0:7b6:d073:9cb4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2586:b0:7b6:d0bd:c7e6 with SMTP id af79cd13be357-7bffcd125fbmr2052865585a.32.1738343636619;
 Fri, 31 Jan 2025 09:13:56 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:30 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-13-edumazet@google.com>
Subject: [PATCH net 12/16] ipv6: output: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_net() calls from net/ipv6/ip6_output.c
and net/ipv6/output_core.c are happening under RCU
protection.

Convert them to dev_net_rcu() to ensure LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_output.c  | 4 ++--
 net/ipv6/output_core.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index d577bf2f3053873d27b241029592cdbb0a124ad7..4c73a4cdcb23f76d81e572d5b1bd0f6902447c0e 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -393,7 +393,7 @@ static int ip6_call_ra_chain(struct sk_buff *skb, int sel)
 		     sk->sk_bound_dev_if == skb->dev->ifindex)) {
 
 			if (inet6_test_bit(RTALERT_ISOLATE, sk) &&
-			    !net_eq(sock_net(sk), dev_net(skb->dev))) {
+			    !net_eq(sock_net(sk), dev_net_rcu(skb->dev))) {
 				continue;
 			}
 			if (last) {
@@ -503,7 +503,7 @@ int ip6_forward(struct sk_buff *skb)
 	struct dst_entry *dst = skb_dst(skb);
 	struct ipv6hdr *hdr = ipv6_hdr(skb);
 	struct inet6_skb_parm *opt = IP6CB(skb);
-	struct net *net = dev_net(dst->dev);
+	struct net *net = dev_net_rcu(dst->dev);
 	struct inet6_dev *idev;
 	SKB_DR(reason);
 	u32 mtu;
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 806d4b5dd1e60b27726facbb59bbef97d6fee7f5..94438fd4f0e833bb8f5ea4822c7312376ea79304 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -113,7 +113,7 @@ int ip6_dst_hoplimit(struct dst_entry *dst)
 		if (idev)
 			hoplimit = READ_ONCE(idev->cnf.hop_limit);
 		else
-			hoplimit = READ_ONCE(dev_net(dev)->ipv6.devconf_all->hop_limit);
+			hoplimit = READ_ONCE(dev_net_rcu(dev)->ipv6.devconf_all->hop_limit);
 		rcu_read_unlock();
 	}
 	return hoplimit;
-- 
2.48.1.362.g079036d154-goog


