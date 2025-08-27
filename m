Return-Path: <netdev+bounces-217261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104E4B381E6
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2297B17F21E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096612F7475;
	Wed, 27 Aug 2025 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lUTLSW9F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF013009F2
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296310; cv=none; b=eCxT2N64uNcNJ8vpUJ4wISENXjZV4rvpD53OKDmDOiDCXBf1+U/5aOext8jRdYTCkMqE7gynIlcBs+B1PMl/Heubzy5BuTtkuKLV51S1BeAceXtZU4QLWmrf+XsAlSDOyWsxCjOQ8toDgFX5+jMWBHqCP4j7BsB2fPFSTSaN/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296310; c=relaxed/simple;
	bh=hJUsoHFkPkz6MfpZ7OCahimn/b1s/afFfjf3K9lZzqc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VvIoPc9ha4dnIXmPDanzB9zjLOx4O77k/BiB16JScZVCAnN7gVGEjpcA+fdZs+Cyux3rD88e3YLjKtYyxhgVa9g3Ea9AZz/5F7UgtNJZllvKFeE/6B2oLGvhvqoyrQrmAYi3tiUaNsz7N4o2JOEVMyvBvvucgFyU1SQe5XajQv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lUTLSW9F; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e931cb403daso9903084276.1
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756296308; x=1756901108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L3oTFol3dQmGF8HN8J5HIMESkdBmfQht460zkn3PtpQ=;
        b=lUTLSW9F2hnwou3KKT8bpPUqklOToPUJrCo2bYkHcJMC190jExqIXha+bra3EB4iTn
         kcOR3Wp3tsAAH1re+GdW0JK3o8gnlVB8cAtFfrdfeyhc2aWYi6IFl2sP/BY+TASywqdE
         XR1Z/DTeOT06C8E1WFuL0R7eH2l8O5R/WCMy+r5IljKFbi2l8V1DhOvIs2oFbTYXj4s+
         GyO6DAnLy+MYHQKQmRnP6HBcwayaCZ2eTpQJTUIVBobEiH3jwgsChiWA9aBDVa+uXMDW
         hSqcxnqhWaaIPWg/DGL151UVM++54peeNZhTTS6Uear5WLIJOtbciMKMzHMeBrhAIl+0
         4a2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756296308; x=1756901108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3oTFol3dQmGF8HN8J5HIMESkdBmfQht460zkn3PtpQ=;
        b=UwruJqcKIr1zErJAbGCs7BXoxEaJ6Zr3kAp+FSy+3lnxHUILv5nfg/l+MAVPRq+Ph/
         wmAoQSrJYqvwfafN+k91z4LviS92PAQHpS2b7VtTBBJHRCIwJxKap3o3kOG4SZLbeW9/
         LkAhhdwGzpzTEzJR1NYDahBLGIo7/M1Ear6sFiEKaki+EcTZqOMvEYZRos9ahPrghHBv
         QqaCu6IF96sOaS2f8Uzl51QhoWZ13tXAvEsv31gCK6d3oddzQfBZfFapRSeMYnGTrpsz
         nui+xomOrgxJgAzr0M70CyRDd1Fdg798LfSLRu7IYBJJbc38jpcDqNnG41D0lD6/Teza
         T5NA==
X-Forwarded-Encrypted: i=1; AJvYcCXMf5B3TgWEPfFmlAPxRuwRHN2lnvwzF0el6K9ToINvvRmAVGZpCYLgp+guvLxyL6QnPHyFgrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEjh/vzbxE8dgJHuLyf2lawcaOrQABkpWQ6qEJPKV+8d4jpADQ
	P8cHdwF6YTZDUK4ffabgwvmBsYPkcpXxP6qCJhWxJ/e+qVoRrXRW37l6pzBc8gwL9lQK0U/aAWB
	1X9KG7vkG/93jkg==
X-Google-Smtp-Source: AGHT+IHlAFTP2vELfuoohKZIk+zl5GGCue+fkVc7CumFIHeNc3zMUGrxeO+6kfLu0vWtAFnhQu8sNn1hRsiLKQ==
X-Received: from ybbgd4.prod.google.com ([2002:a05:6902:4084:b0:e94:f666:9876])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:1884:b0:e95:32a9:908 with SMTP id 3f1490d57ef6-e9532a910b1mr14621375276.42.1756296308183;
 Wed, 27 Aug 2025 05:05:08 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:05:01 +0000
In-Reply-To: <20250827120503.3299990-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827120503.3299990-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250827120503.3299990-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] inet: ping: check sock_net() in ping_get_port()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We need to check socket netns before considering them in ping_get_port().
Otherwise, one malicious netns could 'consume' all ports.

Fixes: c319b4d76b9e ("net: ipv4: add IPPROTO_ICMP socket kind")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ping.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 031df4c19fcc5ca18137695c78358c3ad96a2c4a..3734e2d5c4814ea0a8d318c54e38b4dc978f6c77 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -77,6 +77,7 @@ static inline struct hlist_head *ping_hashslot(struct ping_table *table,
 
 int ping_get_port(struct sock *sk, unsigned short ident)
 {
+	struct net *net = sock_net(sk);
 	struct inet_sock *isk, *isk2;
 	struct hlist_head *hlist;
 	struct sock *sk2 = NULL;
@@ -90,9 +91,10 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 		for (i = 0; i < (1L << 16); i++, result++) {
 			if (!result)
 				result++; /* avoid zero */
-			hlist = ping_hashslot(&ping_table, sock_net(sk),
-					    result);
+			hlist = ping_hashslot(&ping_table, net, result);
 			sk_for_each(sk2, hlist) {
+				if (!net_eq(sock_net(sk2), net))
+					continue;
 				isk2 = inet_sk(sk2);
 
 				if (isk2->inet_num == result)
@@ -108,8 +110,10 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 		if (i >= (1L << 16))
 			goto fail;
 	} else {
-		hlist = ping_hashslot(&ping_table, sock_net(sk), ident);
+		hlist = ping_hashslot(&ping_table, net, ident);
 		sk_for_each(sk2, hlist) {
+			if (!net_eq(sock_net(sk2), net))
+				continue;
 			isk2 = inet_sk(sk2);
 
 			/* BUG? Why is this reuse and not reuseaddr? ping.c
@@ -129,7 +133,7 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 		pr_debug("was not hashed\n");
 		sk_add_node_rcu(sk, hlist);
 		sock_set_flag(sk, SOCK_RCU_FREE);
-		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
+		sock_prot_inuse_add(net, sk->sk_prot, 1);
 	}
 	spin_unlock(&ping_table.lock);
 	return 0;
-- 
2.51.0.261.g7ce5a0a67e-goog


