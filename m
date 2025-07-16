Return-Path: <netdev+bounces-207620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CCEB0804A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A25E4E597B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761522EE5F9;
	Wed, 16 Jul 2025 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RaOHWj/2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F782EE60F
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703950; cv=none; b=pMKFtJbeFq5lqwjJwHAew2pzcMerP8ux2UtPXRUBWakgt/rnqXepNshhgXnjEfcremrUeCPaG7+nSFlvoXvihgnPO/9mUeH5flN5pINX/6Ot4+MJjic+dUghYiB9Dyi8vlljQZiSjRh0QQkC2MOGaOe0PqiG5ihvICPJ+OuYl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703950; c=relaxed/simple;
	bh=Afr04Nrp8d81f4qcQaS1984p6SrExzPc8WMo+2f4C0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IjryNxHH9wF+7xRoBjqKwo0+zCDIrQ0u4Z/W/O+EgVnDBqSZKZFpnlMSQpE6A+DbKuE5Kuf+/+r1Yt6OIt7sNnfMJwUGXpiy6qGIzA6ieyk9pKyo+BKSEDoqgHY1eOmtf3DATLDz9/8MML+E7o+j+qvyXQwQKmgfSge+gYdTPkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RaOHWj/2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138f5e8ff5so289103a91.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703948; x=1753308748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=chLpv/Yb6hQVZvy8rIeY74VjNLDssG+gkk/oWkYrDBo=;
        b=RaOHWj/2/8akEZUIjKm2q0Kkq8zZqM3BNMW+vqn/KK/Dn0HIwlnVnkeyw5rwp1kP1I
         iiP/8gRCpPyrRYm2eG6HFoNDYApYJ1QmnxtXPshdGafQ0iKMb0TmOt7BEOOx/o3LC1Ii
         ZYwKoJ5giLSY7sdIEPT5YwzWyIL9GEygiUEZH7nmve3GJli5Z8Y529PFJAKgURdYEZiZ
         6js+ZV/3i6j2r6Iynncuf35DO1ptR8M/dl5AH6Ubb+ob3w9f85c/Ptuojz7Y69qcjYOh
         sMOPTufloMLV73Le/yWyxxO3QJWs0UuZQeFRd+0D770gZdgh0OxgRpU3RnBA863HPIvY
         xIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703948; x=1753308748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chLpv/Yb6hQVZvy8rIeY74VjNLDssG+gkk/oWkYrDBo=;
        b=bGf0zhNCeCfP3c/RiYi+GnBJPwu3M+GNX+VBxeg70ZN7qUGNzVXeoy6HIlPf2HdgtO
         a0+vmPvLay+K+PzA1Q8YhmplWjPyYlQfhGFApYqSrFwu4QWNbTRtgoFB6YJSK0tibwaa
         8MLZ3ZJ1NRiQ32LAqWt6X6CIw7FjWWrBgku1QiVQQu+nhqDu00rKNnlE/rbK0XxqPARR
         GggKYLrng9t1FzQyt/z/nzgG3nCvPOy2R9zejRSgtKrdAdT0vNXCnO5pzbujmTlMG4in
         uBIvV6EFt0ThaL8WS5WAQsNBJ1SO2g1VIAHOJmxZlj4OMgyo+OB1+yWrKg3T9tKXFsOW
         mmAg==
X-Forwarded-Encrypted: i=1; AJvYcCX+InB++bzvBWRA7n2zl1y8bnGk1pSHYFlJSmuxg91TuP/OmCepOkeO5KGkstXAEG71Pgw4KkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL7yCriD0kko9hymBO+iQlAn1Iy0r/qa/xCFM29/RGpYgfV3jc
	Fs6fDNjXrnVEgSjyipFwpCPoopzTkA17uaXregLI9gd6g+M97+AMoUolteUUz5p+IRHS/6bvOlu
	THD76HA==
X-Google-Smtp-Source: AGHT+IHDHIiuwdnDBF+ZFRjMns8xxoy6Vi8sk8kCMR1pKj7pOES/w2lnQGs/TryC/8bFQHEYGVgnabBH158=
X-Received: from pjbqo11.prod.google.com ([2002:a17:90b:3dcb:b0:311:7d77:229f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:514d:b0:311:b413:f5e1
 with SMTP id 98e67ed59e1d1-31c9f45b1admr5372181a91.32.1752703948242; Wed, 16
 Jul 2025 15:12:28 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:08 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-4-kuniyu@google.com>
Subject: [PATCH v3 net-next 03/15] neighbour: Allocate skb in neigh_get().
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
v3: Rename label 'err' to 'err_free_skb'
---
 net/core/neighbour.c | 88 ++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 56 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index babedf5e68c44..e73a4e37ad0a0 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2988,27 +2988,6 @@ static inline size_t neigh_nlmsg_size(void)
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
@@ -3017,34 +2996,16 @@ static inline size_t pneigh_nlmsg_size(void)
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
@@ -3053,11 +3014,19 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
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
+			goto err_free_skb;
 		}
 	}
 
@@ -3067,23 +3036,30 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		pn = pneigh_lookup(tbl, net, dst, dev, 0);
 		if (!pn) {
 			NL_SET_ERR_MSG(extack, "Proxy neighbour entry not found");
-			return -ENOENT;
+			err = -ENOENT;
+			goto err_free_skb;
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
+			goto err_free_skb;
+	} else {
+		neigh = neigh_lookup(tbl, dst, dev);
+		if (!neigh) {
+			NL_SET_ERR_MSG(extack, "Neighbour entry not found");
+			err = -ENOENT;
+			goto err_free_skb;
+		}
 
-	neigh_release(neigh);
+		err = neigh_fill_info(skb, neigh, pid, seq, RTM_NEWNEIGH, 0);
+		neigh_release(neigh);
+		if (err)
+			goto err_free_skb;
+	}
 
+	return rtnl_unicast(skb, net, pid);
+err_free_skb:
+	kfree_skb(skb);
 	return err;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


