Return-Path: <netdev+bounces-206365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6720DB02CDF
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB5E4A447F
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034E7226533;
	Sat, 12 Jul 2025 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uC5TMusd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9E2253A9
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352525; cv=none; b=JdjDn8rCcefYtzwFDEpKC/XkbEGFy21p+0lIFeKpBRX7EbyiZbv5sucJlp0iSrN2knXwlTGQcPx2jPhttYgXdR2EmesBj1XlKjtbbN5KRDhPzlotFZanQq7SNxo8yD8RzxbGBjLuCrd3gaRBqxh/s/KwBRVzgtKfJcCdkiniQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352525; c=relaxed/simple;
	bh=QuQ6d8r+101uLPJPbNwU9kfo8GZqC6Uz/6ANFIyS0h0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ia+R8LUtTHlilZPyw2LCK8ni4aXZpkiz2kAFcHlxKtTWZeFS1qB4KsVifHBKEjHafdfBjH/1uR/asoO1bbdT+EChXy6PBFuzftM9Tc9Inr8lxkZFYqrOrW0DJNeyInX+dw2qNZs+l6TuA9QvtHEiHJbd0cmByo6mFEkZQIrmcdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uC5TMusd; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31cc625817so3410320a12.0
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352524; x=1752957324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HdTNkZqr+AtANgl8MZ+nO9ZRekcVUalHvfBsZneUgC4=;
        b=uC5TMusd1HM2FvSLkIc1ywN7antRgRhB9/ABEjljDRF/bIfjCN0NkEnJHivcq7qBFo
         sNcTymwjVG/lyA9QADCsUCB9NZXdQY8UXuTvWH3gUjQR7q6TuCpQyDzDomlgl/eikUAT
         ZKH6PfkvT1YyBZV6/vqqCm/1El7PbTHWf7xz9vQeKospbZK1+c4ImVF+jeghuVVewKze
         JKAxKeWkyiBEgdNysSXmN5o9hWyvmFq5GKaZRMNJkZbwAadw2PWLJHoQlTqvuG06GiDs
         tBjFZrH30nPd5JGuheDOMiqnkk0AEBUOSmQHhiaSyVu7jBvR8FttEjI6aSjieVUit2qp
         /XjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352524; x=1752957324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdTNkZqr+AtANgl8MZ+nO9ZRekcVUalHvfBsZneUgC4=;
        b=E8sPulF35P52gIpHw8okR3MXv2UGpXYVa0kU1TPKNeaBOuMY6WacbwCXNpXxxGlHZi
         YSK1r90y1/t82ccBhyTYRYnJsSLm/XVKs3FjIz+1OGeQDDviE3FgZ34NPZS7YCIg9fVQ
         khUIm7WUNV/uw7L1J8F/R4NY7p0qnBjvnj6xNyv743dYLZw3J8l/V+nsRg8OrQPZGapg
         6Envez/H/fKxMPCro8GgHObWPP1qaoqg8Psnxb7PS/ogK+5BY0p+SPLUJbTSw6cooKac
         v7qIzTldvgZe5ibDjJKnnjzjPvjo+HFjendu6P9BFlHN376kzF8xln4hLb+vOnvI0ajg
         sQFA==
X-Forwarded-Encrypted: i=1; AJvYcCXk7KHIC8JwuyR0iJvGLTUS5aCUQOw9E5Bb5MVA9C41ttBXOAmR9EuL4PepmZH9Be0gauGwAv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUNHrl9dG9T0BbQf2MwkWxjuw9jCYwkp5yF65omdsKeBp7ks+6
	IsP7yBHknraR4ZIo9Q97VAHqxIYLEvV+2zdBbIYJTRo8w2uuGgLkQDXxli1x+fxtpEuEA9QjCQl
	vRONlJA==
X-Google-Smtp-Source: AGHT+IGXmnNCeNkrNZM2x+p5Dgen8iPbxVBkgid6IkeeVsL8aK4s+43LBAGHopAA5h3GGWxVda5zHQDJwOg=
X-Received: from pjbok7.prod.google.com ([2002:a17:90b:1d47:b0:314:626:7b97])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d886:b0:312:dbcd:b93d
 with SMTP id 98e67ed59e1d1-31c3d0c2bc7mr18359384a91.14.1752352523780; Sat, 12
 Jul 2025 13:35:23 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:12 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 03/15] neighbour: Allocate skb in neigh_get().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will remove RTNL for neigh_get() and run it under RCU instead.

neigh_get_reply() and pneigh_get_reply() allocate skb with GFP_KERNEL.

Let's move the allocation before __dev_get_by_index() in neigh_get().

Now, neigh_get_reply() and pneigh_get_reply() are inlined and
rtnl_unicast() is factorised.

We will convert pneigh_lookup() to __pneigh_lookup() later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 88 ++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 56 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 2c3e0f3615e20..df5938b6020f1 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2998,27 +2998,6 @@ static inline size_t neigh_nlmsg_size(void)
 	       + nla_total_size(1); /* NDA_PROTOCOL */
 }
 
-static int neigh_get_reply(struct net *net, struct neighbour *neigh,
-			   u32 pid, u32 seq)
-{
-	struct sk_buff *skb;
-	int err = 0;
-
-	skb = nlmsg_new(neigh_nlmsg_size(), GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
-	err = neigh_fill_info(skb, neigh, pid, seq, RTM_NEWNEIGH, 0);
-	if (err) {
-		kfree_skb(skb);
-		goto errout;
-	}
-
-	err = rtnl_unicast(skb, net, pid);
-errout:
-	return err;
-}
-
 static inline size_t pneigh_nlmsg_size(void)
 {
 	return NLMSG_ALIGN(sizeof(struct ndmsg))
@@ -3027,34 +3006,16 @@ static inline size_t pneigh_nlmsg_size(void)
 	       + nla_total_size(1); /* NDA_PROTOCOL */
 }
 
-static int pneigh_get_reply(struct net *net, struct pneigh_entry *neigh,
-			    u32 pid, u32 seq, struct neigh_table *tbl)
-{
-	struct sk_buff *skb;
-	int err = 0;
-
-	skb = nlmsg_new(pneigh_nlmsg_size(), GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
-	err = pneigh_fill_info(skb, neigh, pid, seq, RTM_NEWNEIGH, 0, tbl);
-	if (err) {
-		kfree_skb(skb);
-		goto errout;
-	}
-
-	err = rtnl_unicast(skb, net, pid);
-errout:
-	return err;
-}
-
 static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		     struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(in_skb->sk);
+	u32 pid = NETLINK_CB(in_skb).portid;
 	struct net_device *dev = NULL;
 	struct neigh_table *tbl = NULL;
+	u32 seq = nlh->nlmsg_seq;
 	struct neighbour *neigh;
+	struct sk_buff *skb;
 	struct ndmsg *ndm;
 	void *dst = NULL;
 	int err;
@@ -3063,11 +3024,19 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (IS_ERR(ndm))
 		return PTR_ERR(ndm);
 
+	if (ndm->ndm_flags & NTF_PROXY)
+		skb = nlmsg_new(neigh_nlmsg_size(), GFP_KERNEL);
+	else
+		skb = nlmsg_new(pneigh_nlmsg_size(), GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+
 	if (ndm->ndm_ifindex) {
 		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
 		if (!dev) {
 			NL_SET_ERR_MSG(extack, "Unknown device ifindex");
-			return -ENODEV;
+			err = -ENODEV;
+			goto err;
 		}
 	}
 
@@ -3077,23 +3046,30 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		pn = pneigh_lookup(tbl, net, dst, dev, 0);
 		if (!pn) {
 			NL_SET_ERR_MSG(extack, "Proxy neighbour entry not found");
-			return -ENOENT;
+			err = -ENOENT;
+			goto err;
 		}
-		return pneigh_get_reply(net, pn, NETLINK_CB(in_skb).portid,
-					nlh->nlmsg_seq, tbl);
-	}
-
-	neigh = neigh_lookup(tbl, dst, dev);
-	if (!neigh) {
-		NL_SET_ERR_MSG(extack, "Neighbour entry not found");
-		return -ENOENT;
-	}
 
-	err = neigh_get_reply(net, neigh, NETLINK_CB(in_skb).portid,
-			      nlh->nlmsg_seq);
+		err = pneigh_fill_info(skb, pn, pid, seq, RTM_NEWNEIGH, 0, tbl);
+		if (err)
+			goto err;
+	} else {
+		neigh = neigh_lookup(tbl, dst, dev);
+		if (!neigh) {
+			NL_SET_ERR_MSG(extack, "Neighbour entry not found");
+			err = -ENOENT;
+			goto err;
+		}
 
-	neigh_release(neigh);
+		err = neigh_fill_info(skb, neigh, pid, seq, RTM_NEWNEIGH, 0);
+		neigh_release(neigh);
+		if (err)
+			goto err;
+	}
 
+	return rtnl_unicast(skb, net, pid);
+err:
+	kfree_skb(skb);
 	return err;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


