Return-Path: <netdev+bounces-206240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B02B02448
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73ECEA60411
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47DC2F3636;
	Fri, 11 Jul 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzFHt2d3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329902F2C6E
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261019; cv=none; b=aFVrLI8CsE/q5mD+/Wn8eel93m0VUjR8oKUNBCk1qRm05HwyvrB3dGkhgiTI82HUvlHvOXnQ7hTphj+IWEfQSY8Tnu9sxr6khb5Vuv7Lez/fZnZrDjscw+P2X/wNI/8PZA5I1lga40jJR1wJOm1bPD3KPDTPUSF6Mr/gt7byRbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261019; c=relaxed/simple;
	bh=ncVbN1qLu8kTVNK0xRqJIzJwmakkxGurtcA+nGTpryg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UNzEjTPtGqlbAnI0+pxdA1iYx8G1zVYS/Q34huzhIiDhGF2nlPnAhhr5tU55Y58GeN19AnoYdbgWfFBJJlg741r67z7u0SoN/dVnQI1bJH9mora5azVTvLoDJpLSWLBtjW2v9U9ga/e/7aQ7OqcZ2QeWKktiPmAVVVqCVs/pPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hzFHt2d3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311a6b43ed7so2382326a91.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261018; x=1752865818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J9mgTTkrwNJeyerld9CLyAZlYSdZO/lR64P5ZZCiosY=;
        b=hzFHt2d3VolH6Y+hccWi1dME5i/JhEXwd4+LLbAVTVyDBCKr1G73tGCxe/A6ZJ+9+v
         RyMb6upA6GrSPLzraFVgdHM9ecMqeI82CRlKWOkcd/W6bpQflHZKLXvOU9gC6XSf9dOO
         6Y8eyfFNe2bhWt35uGM7S2qwXrSK4CABTEcOCK+3wxe7Zd5UTPxBnzhOflyAygXE8Xgk
         zHxPr6sjmtH21V/P8y0Sb/VERmMhUJx+e5wJgtp6w/nfQdd68YACY2olxrlZiCOMJTrg
         Sd8RdIbsU1vVSQzsajTj0SHF2M4Hrcsy9FpE6EcFf2vAdplb/kUXAWtUBPY4dl+cla1k
         K/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261018; x=1752865818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9mgTTkrwNJeyerld9CLyAZlYSdZO/lR64P5ZZCiosY=;
        b=K/siFeBq3CcfPJusi0txNAp/yIv2+jWRyTgt4WDcJBmorIVq2XSuAZlulLaBrqiWhe
         zvzfqoXsNVkQiubkHDdiCcXAGNNXco6U4k4dKt4yzYC1Wcj+LA+jMqZsxUMUunN1HNRc
         rZh5bp9OeYgPdG8ApjxaLPNaXC/wR9usZJKXY17/l0S9LoABIHg2G8ly5pBNeNGm3qBv
         foxn4ciJw1O789tMO083c/xEFT7s3jA+5kqPOxuTDxKQyAwDH9sRBIwWWxP/2/4b3yve
         xec0VJbLcuhi1ZQGwt+va51gredlKgzJ16ZgFRUcgPZ9oGJVTxklcH7CsCyLCbkWvK+8
         7/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCX/8In6hZjI5fIF8o+AZlAoJ5gicQoIOpbbzaaAacr9ovacmDUVG2UPw3IyaU/f+T+tQ8Pnsuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdg3hrFWGsrb/P3oOEWxsPfv7PWgj0SvNLQXCOg9mBmHBtHC6J
	LBOsSTGCzGGB7TTVjjoISQhqCe6p7eZ+f35kdUmfjgtlClaWKm0k6Gc9TwvmLE6MVVzY2NXZpya
	rq0+0jA==
X-Google-Smtp-Source: AGHT+IHpkZ+CnP6+ET6oi/d7qaWChnSC3YpdJWgKBCkaNttKU71CD9GhH+HKhV2ezpHa7S/GuExtKv/FhoA=
X-Received: from pjtq14.prod.google.com ([2002:a17:90a:c10e:b0:313:2213:1f54])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28cf:b0:311:f05b:869b
 with SMTP id 98e67ed59e1d1-31c4f584837mr5431389a91.30.1752261017761; Fri, 11
 Jul 2025 12:10:17 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:09 +0000
In-Reply-To: <20250711191007.3591938-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711191007.3591938-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 04/14] neighbour: Move neigh_find_table() to neigh_get().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neigh_valid_get_req() calls neigh_find_table() to fetch neigh_tables[].

neigh_find_table() uses rcu_dereference_rtnl(), but RTNL actually does
not protect it at all; neigh_table_clear() can be called without RTNL
and only waits for RCU readers by synchronize_rcu().

Fortunately, there is no bug because IPv4 is built-in, IPv6 cannot be
unloaded, and DECNET was removed.

To fetch neigh_tables[] by rcu_dereference() later, let's move
neigh_find_table() from neigh_valid_get_req() to neigh_get().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index df5938b6020f1..ad79f173e6229 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2911,10 +2911,9 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 }
 
 static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
-					 struct neigh_table **tbl, void **dst,
+					 struct nlattr **tb,
 					 struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[NDA_MAX + 1];
 	struct ndmsg *ndm;
 	int err, i;
 
@@ -2949,13 +2948,6 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 	if (err < 0)
 		goto err;
 
-	*tbl = neigh_find_table(ndm->ndm_family);
-	if (!*tbl) {
-		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
-		err = -EAFNOSUPPORT;
-		goto err;
-	}
-
 	for (i = 0; i <= NDA_MAX; ++i) {
 		switch (i) {
 		case NDA_DST:
@@ -2964,13 +2956,6 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 				err = -EINVAL;
 				goto err;
 			}
-
-			if (nla_len(tb[i]) != (int)(*tbl)->key_len) {
-				NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
-				err = -EINVAL;
-				goto err;
-			}
-			*dst = nla_data(tb[i]);
 			break;
 		default:
 			if (!tb[i])
@@ -3011,16 +2996,17 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 {
 	struct net *net = sock_net(in_skb->sk);
 	u32 pid = NETLINK_CB(in_skb).portid;
+	struct nlattr *tb[NDA_MAX + 1];
 	struct net_device *dev = NULL;
-	struct neigh_table *tbl = NULL;
 	u32 seq = nlh->nlmsg_seq;
+	struct neigh_table *tbl;
 	struct neighbour *neigh;
 	struct sk_buff *skb;
 	struct ndmsg *ndm;
-	void *dst = NULL;
+	void *dst;
 	int err;
 
-	ndm = neigh_valid_get_req(nlh, &tbl, &dst, extack);
+	ndm = neigh_valid_get_req(nlh, tb, extack);
 	if (IS_ERR(ndm))
 		return PTR_ERR(ndm);
 
@@ -3031,6 +3017,21 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (!skb)
 		return -ENOBUFS;
 
+	tbl = neigh_find_table(ndm->ndm_family);
+	if (!tbl) {
+		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
+		err = -EAFNOSUPPORT;
+		goto err;
+	}
+
+	if (nla_len(tb[NDA_DST]) != (int)tbl->key_len) {
+		NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
+		err = -EINVAL;
+		goto err;
+	}
+
+	dst = nla_data(tb[NDA_DST]);
+
 	if (ndm->ndm_ifindex) {
 		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
 		if (!dev) {
-- 
2.50.0.727.gbf7dc18ff4-goog


