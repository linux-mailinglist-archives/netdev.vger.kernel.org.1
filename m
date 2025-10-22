Return-Path: <netdev+bounces-231534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D01BFA15A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CCF18C7291
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 05:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7F52ED164;
	Wed, 22 Oct 2025 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jwz8nK3U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E9B2ECD11
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111623; cv=none; b=beYbBaXW0i/g+5+hWI2IgjVmzLdVZLOCmxGXX1SUtf6T3dhnrpl2WYDpRn4pLtKidX563GlOerib/92GBzSK1UcofzERrSD88NT+gKeDcMtQWd9Ng7GnJp7bPY9yuFBZvgzudRuEqdDFor/cusGxxENIXeuJAtblnjwHn1F6ZOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111623; c=relaxed/simple;
	bh=o11dQqGxQPB6VddiB9Y6bOHtcTR0jnHbMjsjQDj1j3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DRuYUe7dWkH1Hu2SzJQmGr2YMvX4HcYwVk6UYl6f/usoP8aWmcrpJQ4ue23KRK5j7iilSvVv0oaiBGJgFcTj3xh7gWJz1U22nn2drUcb5InwjNgBJeu7AVLDylpZPwUtro8e7J0f2dG1Qx+u0juk3U+60SHch/bdA4ftZveKKus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jwz8nK3U; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33c6140336eso10849281a91.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 22:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761111621; x=1761716421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RiILfeh6wMSqhJH+kW8h3qN4h3JqEwVwWeMdlx3tIyk=;
        b=Jwz8nK3UJmY60ia38bt2MTZYk4MlAZcxkHHX+TYxEFPyvpFQwlduW0kb0A6jctxxYU
         6vSjC8NMjH6/Gci7t+i/WzHsrWB2bn0o1hAUlfcBs7Xb7jYxdPH4j7gU/znfs+vCE2l4
         oNfEMvqaRFlcd1fQeoHZYfFeNj2UiqYpE+4AtQ8RhulNchTSEeN7t/N213EHTvhxfpsw
         hxP6W87hllal/D/0szbPrKBgLu/nx1czjv5SjtG8zhn7ffVoEELWCYy64invQeqFOs2H
         qneYzQJ6b5V9C4Wwlmy5EYVuts6LrNeEN5QbK+D7beu0M08PEPg4G/ngiRahDxNmDeY7
         H73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111621; x=1761716421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiILfeh6wMSqhJH+kW8h3qN4h3JqEwVwWeMdlx3tIyk=;
        b=qPG3+Fa/NY7A/NmtIiY0jDU5TDVX42yWAhTqdtF29AQdITJLrVztU0MS5Oy8gFDJjq
         0eJgmEN3FHx3/QxPukdyGSHUAE/d62G1Keu/uL91nxib+LcQTdiXNFKU8Mlmxm+Wjftz
         DuEwuXk0nZu61HN6wpq4Fvzjh6Lx/gCE72T3ax4cDv0DhTngytnHtNhT5VhrZkHsCgoO
         Hap6vLrz0cjUksqt5VZ1qJiF6weBadcwzxRVhEp2Du4xlbIJq42uk6ggwlOXfs6qdkB/
         nuLE4nWzTTnPBFTeIXP4MvJ9PxQy4GEnXDupCeIw1i3oaNBxYEvTJfg4wx/JsE9ItV/n
         T92w==
X-Forwarded-Encrypted: i=1; AJvYcCWu4SesyHmwogSJnm3uhwe6Qix+h45MITOlmxt48AVtf86UJ+YFwbcfIJusfz+cl1nhPrsm/C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGIH8FJANa72OFfkZyIWHAoUAi1iliaLOweQ3Vvadggl8+zCQ+
	XQuCFtjD6jpjk5pbbSYKUkAmwGUPWL6/hIwYhO2APEfqaBkuE+6BfZdvBC1F1w8HriioCqIrkNw
	dVZNGDw==
X-Google-Smtp-Source: AGHT+IHGpysk00iWHAEO5kB8LA4jzvnwe7/ZJHLETRauupABpcX+NAEjnAcHZrq/yrCtweyvbewYVqFdyuU=
X-Received: from pjqo11.prod.google.com ([2002:a17:90a:ac0b:b0:33b:e0b5:6112])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1250:b0:290:dfab:ca91
 with SMTP id d9443c01a7336-290dfabccd9mr207181275ad.54.1761111621477; Tue, 21
 Oct 2025 22:40:21 -0700 (PDT)
Date: Wed, 22 Oct 2025 05:39:48 +0000
In-Reply-To: <20251022054004.2514876-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022054004.2514876-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251022054004.2514876-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/5] neighbour: Convert RTM_SETNEIGHTBL to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neightbl_set() fetches neigh_tables[] and updates attributes under
write_lock_bh(&tbl->lock), so RTNL is not needed.

neigh_table_clear() synchronises RCU only, and rcu_dereference_rtnl()
protects nothing here.

If we released RCU after fetching neigh_tables[], there would be no
synchronisation to block neigh_table_clear() further, so RCU is held
until the end of the function.

Another option would be to protect neigh_tables[] user with SRCU
and add synchronize_srcu() in neigh_table_clear().

But, holding RCU should be fine as we hold write_lock_bh() for the
rest of neightbl_set() anyway.

Let's perform RTM_SETNEIGHTBL under RCU and drop RTNL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 0c5170438c51e..807a0d2457728 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2362,9 +2362,9 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
+	struct nlattr *tb[NDTA_MAX + 1];
 	struct neigh_table *tbl;
 	struct ndtmsg *ndtmsg;
-	struct nlattr *tb[NDTA_MAX+1];
 	bool found = false;
 	int err, tidx;
 
@@ -2380,20 +2380,27 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	ndtmsg = nlmsg_data(nlh);
 
+	rcu_read_lock();
+
 	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
-		tbl = rcu_dereference_rtnl(neigh_tables[tidx]);
+		tbl = rcu_dereference(neigh_tables[tidx]);
 		if (!tbl)
 			continue;
+
 		if (ndtmsg->ndtm_family && tbl->family != ndtmsg->ndtm_family)
 			continue;
+
 		if (nla_strcmp(tb[NDTA_NAME], tbl->id) == 0) {
 			found = true;
 			break;
 		}
 	}
 
-	if (!found)
-		return -ENOENT;
+	if (!found) {
+		rcu_read_unlock();
+		err = -ENOENT;
+		goto errout;
+	}
 
 	/*
 	 * We acquire tbl->lock to be nice to the periodic timers and
@@ -2519,6 +2526,7 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 errout_tbl_lock:
 	write_unlock_bh(&tbl->lock);
+	rcu_read_unlock();
 errout:
 	return err;
 }
@@ -3909,7 +3917,8 @@ static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] __initconst = {
 	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
 	{.msgtype = RTM_GETNEIGHTBL, .dumpit = neightbl_dump_info,
 	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
-	{.msgtype = RTM_SETNEIGHTBL, .doit = neightbl_set},
+	{.msgtype = RTM_SETNEIGHTBL, .doit = neightbl_set,
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED},
 };
 
 static int __init neigh_init(void)
-- 
2.51.0.915.g61a8936c21-goog


