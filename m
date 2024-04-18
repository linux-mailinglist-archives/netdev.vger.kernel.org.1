Return-Path: <netdev+bounces-89088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E608A96AF
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA6D1F22565
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BA715B55D;
	Thu, 18 Apr 2024 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yAqCjF94"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB7A15B543
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433873; cv=none; b=RooKmbhjLCJycLGiEbiceIUkFx0rdtb0w6ap/kjd3lfkIu+DVMZOTwT7Q6+AUGr1/N1RvArHpfJnuBJ2OB9cDPPLpwSunTeCfShdzQ7k28L5nFfQK3divxh3quIJw91EUUVZlC0zDjk8rdTIWtthBdWrbeuis7pMyKrHrDbAls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433873; c=relaxed/simple;
	bh=yU4C62hAypHkcELIRLfOiOBZGR07TTBYreifZOeQdw0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F+cb4mc7sbA9gyHMQsVm+Qrgpzfgv/PIjXu54QMfrw/jcPEgUrPexmxWgQm0F8qNjqYL6oGVJHMxPKix2vlUztNMVxgQHDsSe6Ng2QQPX4s/jkPzFcb+aQDfPv/3bfxjXWl9qySE3Nkceb4LhAKRrZ/DEQCKVIpH35yYzbJe14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yAqCjF94; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b13ce3daaso15125357b3.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713433871; x=1714038671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LDTF76PXlvWlAKDyw0CXHPAGr9TKANpCgR+hOZHip8Y=;
        b=yAqCjF94mSO3YI7iTslZRXl3URb77hyEXiqZbaHrXTdai9a+5pfJ1ElSNJoOb1WLrb
         e4Zd59GFTLjtLqu7CBy1gHgXN9tFoc0QtAhWrRw11iuwYp47gSiYY3FXn0zOkzQPFliM
         YZ21W5S5UB2HDrJXfwpb7+nQM7yMKJEEP/RjLlthtK/qyJMscrpfn/e+wGtV5LHo2fRu
         Qn/cvUYEQQuab5f7hUlGvrxKIcNpDMLuqoJoUqaapV5NZ1FzgZDjDZd6NhEXbkr7YhKz
         Skli7gcerXii2DvDp+gtpsxhkd+mhLTqo9moR8jEx6wkNimT463hgytokgNcmIYsUEzM
         e5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433871; x=1714038671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDTF76PXlvWlAKDyw0CXHPAGr9TKANpCgR+hOZHip8Y=;
        b=ekQlyq7qRCVLTQ7rFtj5PJEzafywGwC98QfyAPmUDsYujJ/JMipgGWkRg5oxXaJivO
         37aggZncIh+ENBEuLnTChT6Ap5T6TIl99woEqP5TVASIu11TY4lE2xPbZMZvX8XUpeSI
         rmVL8xaqIlohJt168ZYJyIDJ+9Ef55iqT5VGl1V3JrmuvmpnrzJAJXgPJI1RuMg24vVi
         ErhRlb/F6EpOV0JyMWFhFkTi8Z0kKBrdKngUZFA6GW3+LAiXmwnTQDEHz5iLEr0DdT4q
         94JUuke1TcApX4CoYN/dYMmGsaj6VaeE1ggiCil9nsJm6VFnIIXzsESGTvVJuucP5j8R
         0vpQ==
X-Gm-Message-State: AOJu0YzEGusx+uDX7TIBwAaJSmsNaI5MDmg1qZZiIu6xik61yYglmexl
	idCa+iJxZqXT/1kdWpzyX7uqSyHIssG/5d5Vtx0uBkqGkZxuaTdgq/nPybM+EGIzbRXlzen9vLM
	Q4urJdlcbzw==
X-Google-Smtp-Source: AGHT+IHhapjuUfcATYT9NSCmrfzo0OKTXG8fdxxqTpDJ3BJUyxots3QiEwuOo9SwkL+kk1GHTGHcveiDvYu4EQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4ed0:0:b0:619:1534:db93 with SMTP id
 c199-20020a814ed0000000b006191534db93mr449666ywb.0.1713433871047; Thu, 18 Apr
 2024 02:51:11 -0700 (PDT)
Date: Thu, 18 Apr 2024 09:51:05 +0000
In-Reply-To: <20240418095106.3680616-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418095106.3680616-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418095106.3680616-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] neighbour: fix neigh_dump_info() return value
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Change neigh_dump_table() and pneigh_dump_table()
to either return 0 or -EMSGSIZE if not enough
space was available in the skb.

Then neigh_dump_info() can do the same.

This allows NLMSG_DONE to be appended to the current
skb at the end of a dump, saving a couple of recvmsg()
system calls.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/neighbour.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 33913dbf4023bcb1f18107fc3b5c26280dce7341..2f9efc89e94e0f6d9e1491019583babb7bae77c7 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2713,7 +2713,7 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 {
 	struct net *net = sock_net(skb->sk);
 	struct neighbour *n;
-	int rc, h, s_h = cb->args[1];
+	int err = 0, h, s_h = cb->args[1];
 	int idx, s_idx = idx = cb->args[2];
 	struct neigh_hash_table *nht;
 	unsigned int flags = NLM_F_MULTI;
@@ -2735,23 +2735,20 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
 			    neigh_master_filtered(n->dev, filter->master_idx))
 				goto next;
-			if (neigh_fill_info(skb, n, NETLINK_CB(cb->skb).portid,
-					    cb->nlh->nlmsg_seq,
-					    RTM_NEWNEIGH,
-					    flags) < 0) {
-				rc = -1;
+			err = neigh_fill_info(skb, n, NETLINK_CB(cb->skb).portid,
+					      cb->nlh->nlmsg_seq,
+					      RTM_NEWNEIGH, flags);
+			if (err < 0)
 				goto out;
-			}
 next:
 			idx++;
 		}
 	}
-	rc = skb->len;
 out:
 	rcu_read_unlock();
 	cb->args[1] = h;
 	cb->args[2] = idx;
-	return rc;
+	return err;
 }
 
 static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
@@ -2760,7 +2757,7 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 {
 	struct pneigh_entry *n;
 	struct net *net = sock_net(skb->sk);
-	int rc, h, s_h = cb->args[3];
+	int err = 0, h, s_h = cb->args[3];
 	int idx, s_idx = idx = cb->args[4];
 	unsigned int flags = NLM_F_MULTI;
 
@@ -2778,11 +2775,11 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
 			    neigh_master_filtered(n->dev, filter->master_idx))
 				goto next;
-			if (pneigh_fill_info(skb, n, NETLINK_CB(cb->skb).portid,
-					    cb->nlh->nlmsg_seq,
-					    RTM_NEWNEIGH, flags, tbl) < 0) {
+			err = pneigh_fill_info(skb, n, NETLINK_CB(cb->skb).portid,
+					       cb->nlh->nlmsg_seq,
+					       RTM_NEWNEIGH, flags, tbl);
+			if (err < 0) {
 				read_unlock_bh(&tbl->lock);
-				rc = -1;
 				goto out;
 			}
 		next:
@@ -2791,12 +2788,10 @@ static int pneigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	}
 
 	read_unlock_bh(&tbl->lock);
-	rc = skb->len;
 out:
 	cb->args[3] = h;
 	cb->args[4] = idx;
-	return rc;
-
+	return err;
 }
 
 static int neigh_valid_dump_req(const struct nlmsghdr *nlh,
@@ -2903,7 +2898,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 	cb->args[0] = t;
-	return skb->len;
+	return err;
 }
 
 static int neigh_valid_get_req(const struct nlmsghdr *nlh,
-- 
2.44.0.683.g7961c838ac-goog


