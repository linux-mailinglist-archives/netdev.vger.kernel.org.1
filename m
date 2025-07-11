Return-Path: <netdev+bounces-206237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB9AB02445
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521D11C454D7
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B302F2374;
	Fri, 11 Jul 2025 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4AkbFxft"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE862ED152
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261015; cv=none; b=K3BVTmLZsjFBZpN9zFSfa5RkOuv+QlunQLk6kTkjrgN76l62QG2ae+dtpWFA9WhZfwFu/h9ZRSvKCQTT0p1CHKZgxPPJKHbF+8yo5yVGPC385W+qfsFDh/2VMTlbkv9cVgEpfwxVdK+11unYfcdchaPEghu03IIZ3Cx3LK+/84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261015; c=relaxed/simple;
	bh=ghAfaxk/rm2z6aYmN0Uqe0VOXHRzawxWt5mifyumHX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uHJXqR1vYNNylLO73ebrleY/p+ZEXdqYIz3MaP2Allvy7FlXwELvcpwppwUxU/pNSaIgvjLnBcqy8nLoLbI/u0ltw/2173qfIqOF1jgx58GCiQy7T372EppTqD+zkqFUE8p4FGQ225DPRjX4UV7eEBykQm1t+HFcjBdZjdTUIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4AkbFxft; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b34abbcdcf3so1839757a12.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261013; x=1752865813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k9qm4lDL4MXYf6qhkJb4jl30W1kGNhheapByVfGSVG0=;
        b=4AkbFxft4/afV5dP1fTYsJPgBAnZstAPLIn9KHB+6M2ZNyQ2QjGcWmhO8DM93ZemAC
         nqQBPc5r2DjnHiH2jZ3MnBXf+njcYx0/NPjXL8IH+eS1XiG1Wn0w/TeL9t08MEBaZZbZ
         HCZzSS9jaZg7kYqkU/EmhFDPey6i95xqit9CH3HOA/Z3Uuv309Nr87Qy5lWVLUCTQ57R
         JH4AA/oP2pR2LS8nPupQZSvm6jiLe1gPZNrrZde8fX1G+j6eHQfdXZuBXAE6egI6i0Ry
         cIFb0JvBrkeMIi0gC8ppU3SBQxRb7X46SSrrUxQ1VXc6zfXvNfcQYr2x+/7dQ0KiP0fm
         I7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261013; x=1752865813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9qm4lDL4MXYf6qhkJb4jl30W1kGNhheapByVfGSVG0=;
        b=RWwH9F2UHdMdouyapkxs3oyG/ixnzcMV1smITEwbecrFDi8cYvkw4ZYidiTU787aIy
         yPcaNDhhtbCxc5TXSjnl104N1+nIuqeUECzc7t/bMo8pskKwEn1hIhU8OASeQAaf5DOc
         kFtFJJvFPfgppQmsdfMtD5thJ8MmcSdE2Ii66rhtdPgvN3jRuIEzAPKRhtXcvT3ItWvH
         iocclm8hJp8jaM0TvEMoQoDj9ONqW0DrIf2XX6hS0f+a0mQnFRTAtE0rXAn65tV1wOqW
         qBkndXHvKsAfO+MVuNOSIVKdf+V6wGcIuiNQmWTOSIDZt977ZtwDseFVKDO+0Fc4ovRC
         Xswg==
X-Forwarded-Encrypted: i=1; AJvYcCXP09+xt8A7YwFmGMNUJnWAwAIxeZ5MH9G+a5vh8aqPfhIY8388ELGhGojEBOgiWQnIBRvzZJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy40L8OdqFBtZQu2L5dJ285uPNmd52sMzhCejcKNhjJqYrM4sDS
	dKtC8+Yz9f2gejeYkDwRTKWzLvCqnCQ0NG3NxwP5Rzl1DMeF/rNDLqF2qH4ABHJOEPm2f7ZFFkv
	dMz33hA==
X-Google-Smtp-Source: AGHT+IGvrK8m/8I4OxReUahi+zDZ6Gxrvj4NvxpUZFaDYX+slnpXBe9IuTwyL7kkDncnTot9E+TMNmq81hs=
X-Received: from pjbnd12.prod.google.com ([2002:a17:90b:4ccc:b0:311:c20d:676d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d88:b0:311:b3e7:fb3c
 with SMTP id 98e67ed59e1d1-31c50e4664bmr4267428a91.31.1752261013525; Fri, 11
 Jul 2025 12:10:13 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:06 +0000
In-Reply-To: <20250711191007.3591938-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711191007.3591938-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 01/14] neighbour: Make neigh_valid_get_req()
 return ndmsg.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neigh_get() passes 4 local variable pointers to neigh_valid_get_req().

If it returns a pointer of struct ndmsg, we do not need to pass two
of them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 51 +++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 43a5dcbb5f9c7..d35399de640d0 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2910,10 +2910,9 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
-static int neigh_valid_get_req(const struct nlmsghdr *nlh,
-			       struct neigh_table **tbl,
-			       void **dst, int *dev_idx, u8 *ndm_flags,
-			       struct netlink_ext_ack *extack)
+static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
+					 struct neigh_table **tbl, void **dst,
+					 struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[NDA_MAX + 1];
 	struct ndmsg *ndm;
@@ -2922,31 +2921,33 @@ static int neigh_valid_get_req(const struct nlmsghdr *nlh,
 	ndm = nlmsg_payload(nlh, sizeof(*ndm));
 	if (!ndm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for neighbor get request");
-		return -EINVAL;
+		err = -EINVAL;
+		goto err;
 	}
 
 	if (ndm->ndm_pad1  || ndm->ndm_pad2  || ndm->ndm_state ||
 	    ndm->ndm_type) {
 		NL_SET_ERR_MSG(extack, "Invalid values in header for neighbor get request");
-		return -EINVAL;
+		err = -EINVAL;
+		goto err;
 	}
 
 	if (ndm->ndm_flags & ~NTF_PROXY) {
 		NL_SET_ERR_MSG(extack, "Invalid flags in header for neighbor get request");
-		return -EINVAL;
+		err = -EINVAL;
+		goto err;
 	}
 
 	err = nlmsg_parse_deprecated_strict(nlh, sizeof(struct ndmsg), tb,
 					    NDA_MAX, nda_policy, extack);
 	if (err < 0)
-		return err;
+		goto err;
 
-	*ndm_flags = ndm->ndm_flags;
-	*dev_idx = ndm->ndm_ifindex;
 	*tbl = neigh_find_table(ndm->ndm_family);
-	if (*tbl == NULL) {
+	if (!*tbl) {
 		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
-		return -EAFNOSUPPORT;
+		err = -EAFNOSUPPORT;
+		goto err;
 	}
 
 	for (i = 0; i <= NDA_MAX; ++i) {
@@ -2957,17 +2958,21 @@ static int neigh_valid_get_req(const struct nlmsghdr *nlh,
 		case NDA_DST:
 			if (nla_len(tb[i]) != (int)(*tbl)->key_len) {
 				NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
-				return -EINVAL;
+				err = -EINVAL;
+				goto err;
 			}
 			*dst = nla_data(tb[i]);
 			break;
 		default:
 			NL_SET_ERR_MSG(extack, "Unsupported attribute in neighbor get request");
-			return -EINVAL;
+			err = -EINVAL;
+			goto err;
 		}
 	}
 
-	return 0;
+	return ndm;
+err:
+	return ERR_PTR(err);
 }
 
 static inline size_t neigh_nlmsg_size(void)
@@ -3038,18 +3043,16 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	struct net_device *dev = NULL;
 	struct neigh_table *tbl = NULL;
 	struct neighbour *neigh;
+	struct ndmsg *ndm;
 	void *dst = NULL;
-	u8 ndm_flags = 0;
-	int dev_idx = 0;
 	int err;
 
-	err = neigh_valid_get_req(nlh, &tbl, &dst, &dev_idx, &ndm_flags,
-				  extack);
-	if (err < 0)
-		return err;
+	ndm = neigh_valid_get_req(nlh, &tbl, &dst, extack);
+	if (IS_ERR(ndm))
+		return PTR_ERR(ndm);
 
-	if (dev_idx) {
-		dev = __dev_get_by_index(net, dev_idx);
+	if (ndm->ndm_ifindex) {
+		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
 		if (!dev) {
 			NL_SET_ERR_MSG(extack, "Unknown device ifindex");
 			return -ENODEV;
@@ -3061,7 +3064,7 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
-	if (ndm_flags & NTF_PROXY) {
+	if (ndm->ndm_flags & NTF_PROXY) {
 		struct pneigh_entry *pn;
 
 		pn = pneigh_lookup(tbl, net, dst, dev, 0);
-- 
2.50.0.727.gbf7dc18ff4-goog


