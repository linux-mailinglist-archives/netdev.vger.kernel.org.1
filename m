Return-Path: <netdev+bounces-207621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C7B08049
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7281C566EC1
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56FA2EE96C;
	Wed, 16 Jul 2025 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1nYTe10"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384E2EE960
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703951; cv=none; b=LwmE7OmUhBr9Cdn6sE9WD3NO/bUncsTlJRPqiadT8v7DgIFdK1tCYIDpuqnCFF8pzq4xed7cM8zZMZRR2rny4K3ptBy74S+ttgn9CKYotTB5K5KaLUwgjqTeLNi7vHijjpCzQeIk+NsmnZcR0TYOklcWNzYZy4BBybNJ8DS7IrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703951; c=relaxed/simple;
	bh=5KGCOnQnXHIWd3IM6XMl+dZMWpcVR/anTsojBY+xnN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G5ZTQIn4zqL37r7oIfMHDDF9s0aXtihlFL/CpKA/Ce88kR0R9WqpsHZqEiZFb2RvEdzmgeCuWbDxan3r69Xdie1bSMs97X+nST3+0SWP1En3SHYppksVE0lMTDMmHH0lJugvgzKa/G2naCBchD3h+JWg9HJJG6Zk8O1WQ1btRWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o1nYTe10; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748e6457567so882673b3a.1
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703949; x=1753308749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rE2yij5+6ouogsS3UvVIotF2zX0undygWvWl2xtwRqY=;
        b=o1nYTe10mo5A8m+Ll8B5aL6bpaErjr74aL932Ae6QX6Cb4R+6zV7V/cYIN/x2KXHi+
         HSknA9FoAvRGyTiXqWPwkbYI0Ulyz1DBKEe1ogcRfTwHj7+sLZsuA8uoo9qwTrKtlXLu
         KcmwnyU0rCBpX045bWXCna1KD9kyPhgyN9uJNhSRmrsH5FBUkxoSOUUdYz1Y5VBAkxAi
         WMLMTA05Hm25re3hoFcca+qhl2IZ0GisjlK42yrGzleQIOBqDt/W/v5htYgnwmbsslf7
         TeJF4N0TLHoaARgBMIhFxoMKLQiwwUS6oO6RdhRXptAv12AwS9hYFWJ8e8b3FiiwIHP4
         H1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703949; x=1753308749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rE2yij5+6ouogsS3UvVIotF2zX0undygWvWl2xtwRqY=;
        b=VRelcSK36Pi7UJMNCoBsL0GABPzdPS7xC1EyJdCZNyLfowlAlAr2EM6McdObGjiWGm
         v5Dqdax0Vxfe7o76UqzYqi8/Gl7Wl3N3MdIvBM4g1LTeNo7K0J7QXpYmWHue33RXShNN
         lbP/1USBqrPqN/wK5fEGEAD9kaoiqA4+pEfYjQC7yxvCINGhopiAOqvuZmLC+4eIz9kk
         GKmch3a76GuoxBjVA+Z9TQmzfwZNdpz72p66pCqeWhki5fDLmMn/Ak0Pl8OAa0SmJbeY
         HUDldj4MDqysrhUjMP6Rw5tGVdIsfJucmN0mAVZEXkEmVPgk0fNRUPG/8EJ0VD4vamDp
         /+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXKin3Becf8NbrpItjEcNq2+RN1ZcEvhu3VrwD3D/gGP0KcE/owFRNaCk7H1pWevfpJy4l4Q2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrTELbXuHq7qyRh0C/TOARN53xR9BQQyPWqZGgcT5zIWNWRRZe
	VMlKF/hoARuLa4apis9UfyLM8GRBcrMO/6aOlwaCGmeYEo+raDnSlES//CzPaRCLG52OmLBo4Ji
	YPoDieA==
X-Google-Smtp-Source: AGHT+IGat7xf/o7ZRVg91vBcHFlpTz9prFRtL93TluZc78x4/AwUZyCRc3FrlZsE711hdLyWveOvNycd0JQ=
X-Received: from pfbef6.prod.google.com ([2002:a05:6a00:2c86:b0:747:b682:5cc0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6da9:b0:225:ba92:447d
 with SMTP id adf61e73a8af0-2390c799fdbmr1479399637.9.1752703949406; Wed, 16
 Jul 2025 15:12:29 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:09 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-5-kuniyu@google.com>
Subject: [PATCH v3 net-next 04/15] neighbour: Move neigh_find_table() to neigh_get().
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
 net/core/neighbour.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index e73a4e37ad0a0..c6ff53df9a012 100644
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
 
@@ -2945,12 +2944,6 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 	if (err < 0)
 		return ERR_PTR(err);
 
-	*tbl = neigh_find_table(ndm->ndm_family);
-	if (!*tbl) {
-		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
-		return ERR_PTR(-EAFNOSUPPORT);
-	}
-
 	for (i = 0; i <= NDA_MAX; ++i) {
 		switch (i) {
 		case NDA_DST:
@@ -2958,12 +2951,6 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 				NL_SET_ERR_ATTR_MISS(extack, NULL, NDA_DST);
 				return ERR_PTR(-EINVAL);
 			}
-
-			if (nla_len(tb[i]) != (int)(*tbl)->key_len) {
-				NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
-				return ERR_PTR(-EINVAL);
-			}
-			*dst = nla_data(tb[i]);
 			break;
 		default:
 			if (!tb[i])
@@ -3001,16 +2988,17 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
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
 
@@ -3021,6 +3009,21 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (!skb)
 		return -ENOBUFS;
 
+	tbl = neigh_find_table(ndm->ndm_family);
+	if (!tbl) {
+		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
+		err = -EAFNOSUPPORT;
+		goto err_free_skb;
+	}
+
+	if (nla_len(tb[NDA_DST]) != (int)tbl->key_len) {
+		NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
+		err = -EINVAL;
+		goto err_free_skb;
+	}
+
+	dst = nla_data(tb[NDA_DST]);
+
 	if (ndm->ndm_ifindex) {
 		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
 		if (!dev) {
-- 
2.50.0.727.gbf7dc18ff4-goog


