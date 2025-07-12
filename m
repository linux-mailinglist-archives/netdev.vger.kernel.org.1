Return-Path: <netdev+bounces-206364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F313B02CDE
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40D64A448B
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBB91FE44B;
	Sat, 12 Jul 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFQIY3RT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117442206B5
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352524; cv=none; b=qKhvXGDMzC7AD5bLPQG/CqAWc8P+1wbvnfle3olAm+B6LyRhK4WCIkMgykKwHuInhvJ3k2PKAqG06ufdklcfvUflD1CGmPC3xH8MFeSulYDl/n8RBWVcv9+LB/8JhS1B2NJfWAMly8sk7tN35xJFs8GdgNBNVDW9arFrHwfbV3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352524; c=relaxed/simple;
	bh=efEqm6LuvaPz+nlEkruVz/952mjxWhAu4ol4Q1ZTIvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MZUZhcPIujGT27cT7tRLrsmpzaCrRotfSJ8O/jYN25v3LLcarXIkGokRYXbYnv4YLoW7BCNBtBwD/ye+yt13OFancG0e74/ay1IpQ22lYfew3Cv6yVaJC9S/tylj+Hu1VJYnK2PzOCm0nM2lz0UEngD2eppgMKJIF9+8UiySkl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFQIY3RT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b34fa832869so3304374a12.1
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352522; x=1752957322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtOVcgAy6/fBE+D4GvNRvO+lO7uWfIARwsK0pweRohk=;
        b=uFQIY3RTjY5v4BoqIogrzYNOEZJjoPRUl+Q3GlIhTkue+cIqHmY9NnZLnY53kKyPnV
         7aWVOWa32mHVWBRgQYdCJrhqrPNyva77MB5tSOYKdvxXJBeBdnXWBVTwIz3SSU57OZzu
         Ive2v3OlVcwjm1RfEwCJHZ5pgeb1N97niMCFS6sLVKS7nFL25pIc0gszDLelqkjsv6VX
         ivehGxUg1HejXqYZiEq5iRiUrJKvWQgMnaYtW5/kiL5q46OuYYCCkzJ8ELp/BCHn24w2
         oVz8MEhKOP90YHGizJscQX+qDvNHaQ4cmyOzsD5ynMGtQwTok4QBJKWedoD6X3matkvt
         rt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352522; x=1752957322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtOVcgAy6/fBE+D4GvNRvO+lO7uWfIARwsK0pweRohk=;
        b=Pcusq0IzcxYQecDgfS6jOr/w1WNsFVggKf/kOHCr0nHsG6C3WWOWo26kxy4TktfCjq
         bX0yoRK8klUQgD/ePeT9qN8BOxoj51S8BYi4aP6toKpK7beJw7yoJbLjYKyDyvNG/5mC
         RPfi8ay+/74/RE98B+sZn6RLjpQoLqD7eMjzMuFjwXWMaj9KqkfGWNLcw7acCWT8Rsve
         sWQLMbj9xHzlb0xDd0iX9IXwra32zDG2f3iTBqa61N7hQc94OCnUxgOhglaQS0kN2H2q
         0ROtLNm7bvd2C1oP8tK1DMbuovvkvtBf/ElV2bkpaDhD+3lmfAZESYEE2LjVNSMZvrqr
         7FDg==
X-Forwarded-Encrypted: i=1; AJvYcCXoevFLVVM0dGh+Mj37csWrej51hCtZlTFAFKsT41eSZnup8RQncltLRd/HshN5XkHrne7PsvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf14clBZmS2sQdiko9STxdqoWPLG+b9ECEwSixmKHntVExTGRI
	KA85S4iZV+7WYEXjsGkjEHwZSavxglWAxYFU+lU2vaq2cLqOzELIM4HMp43yrjBNzDRARY+DfMw
	b2hX2kw==
X-Google-Smtp-Source: AGHT+IGK/9FDtXBKXKRBKMJm2HE9zXv0oep1PYMjg/LvWpfmiv/qCYpHcA53Zm3BWFXsyLwlY2yWcjx4AH8=
X-Received: from pjbrr7.prod.google.com ([2002:a17:90b:2b47:b0:311:f309:e314])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b44:b0:31c:15c8:4c86
 with SMTP id 98e67ed59e1d1-31c4d4f8898mr11386292a91.14.1752352522314; Sat, 12
 Jul 2025 13:35:22 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:11 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 02/15] neighbour: Move two validations from
 neigh_get() to neigh_valid_get_req().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will remove RTNL for neigh_get() and run it under RCU instead.

neigh_get() returns -EINVAL in the following cases:

  * NDA_DST is not specified
  * Both ndm->ndm_ifindex and NTF_PROXY are not specified

These validations do not require RCU.

Let's move them to neigh_valid_get_req().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index d35399de640d0..2c3e0f3615e20 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2938,6 +2938,12 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 		goto err;
 	}
 
+	if (!(ndm->ndm_flags & NTF_PROXY) && !ndm->ndm_ifindex) {
+		NL_SET_ERR_MSG(extack, "No device specified");
+		err = -EINVAL;
+		goto err;
+	}
+
 	err = nlmsg_parse_deprecated_strict(nlh, sizeof(struct ndmsg), tb,
 					    NDA_MAX, nda_policy, extack);
 	if (err < 0)
@@ -2951,11 +2957,14 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 	}
 
 	for (i = 0; i <= NDA_MAX; ++i) {
-		if (!tb[i])
-			continue;
-
 		switch (i) {
 		case NDA_DST:
+			if (!tb[i]) {
+				NL_SET_ERR_MSG(extack, "Network address not specified");
+				err = -EINVAL;
+				goto err;
+			}
+
 			if (nla_len(tb[i]) != (int)(*tbl)->key_len) {
 				NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
 				err = -EINVAL;
@@ -2964,6 +2973,9 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 			*dst = nla_data(tb[i]);
 			break;
 		default:
+			if (!tb[i])
+				continue;
+
 			NL_SET_ERR_MSG(extack, "Unsupported attribute in neighbor get request");
 			err = -EINVAL;
 			goto err;
@@ -3059,11 +3071,6 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	if (!dst) {
-		NL_SET_ERR_MSG(extack, "Network address not specified");
-		return -EINVAL;
-	}
-
 	if (ndm->ndm_flags & NTF_PROXY) {
 		struct pneigh_entry *pn;
 
@@ -3076,11 +3083,6 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 					nlh->nlmsg_seq, tbl);
 	}
 
-	if (!dev) {
-		NL_SET_ERR_MSG(extack, "No device specified");
-		return -EINVAL;
-	}
-
 	neigh = neigh_lookup(tbl, dst, dev);
 	if (!neigh) {
 		NL_SET_ERR_MSG(extack, "Neighbour entry not found");
-- 
2.50.0.727.gbf7dc18ff4-goog


