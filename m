Return-Path: <netdev+bounces-206243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92B0B0244E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D2537AA938
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6192C2F2359;
	Fri, 11 Jul 2025 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZiLgiUMr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60992F1FFC
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261025; cv=none; b=Jmb8fp8qGWPa+aj5cay2pzHycRm87p7SldGE4L7EY7LW37yAMffNDuSP9KejrL+vDiXgBSOAMB0ENdFGZZyd/WBMMTUcIC2YYPymBhYKsF9coYR+Cr+LuBeSO6t0Np/l55NflEVQCA2T5imlGjSMi7Lr20WLZEoUYgoA1xXXPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261025; c=relaxed/simple;
	bh=ODGIZF9+UPjMnwfZU4BuQnCwEGPg+OpBiCmUoXSE6e8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MFINWpBRiDaXnJ1Lv9+X6NEiNLIPI6T9T0TxmiSBIjGu1LYYLp4jePfa3S7Snzjp+YLbS4UUMr9TPvK3JlJJFs/ceDorCnP6VAOrCDtliIX1wX8LLpKPJYaCEx2Bs+cJot1h+Fil0pfnxVhb0CXQAY+x+czyBOrk/wyu3cYIRiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZiLgiUMr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-315b60c19d4so2068232a91.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261023; x=1752865823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qkJwcKJg+tZTk2PUq5SxJEgWnAxAeKWGsOVHC65hVSY=;
        b=ZiLgiUMr8/l2qaHjrp4F2ex7Whnqk9PFJgvK1isQUSk67/mnFF1OHBYfVm+uOhpbLl
         198AOSVNDxRmwvc3k+wZTKNBnLEd4tBwH4le7HS9BY65bHH4K4SqYX9dvBJwtoy5N6BR
         87jz35HfBCC8OVKJgGddwaIkUJc91Hq68vk0j4dKK6vVBfQcCfVmlwnDwBL4PDFd6m6J
         skGRrBKnVWU6e23CLWY3SlcPrd4uUAE4bhJUCqq7whTVV61QlJzOxLZo/gpCacdCsqoU
         7M61ncAAAKC91rRGy0lExayAm5tgfoUlDPoEeAlJhbkUFpwKtO47mpdpXcpgKeuEN81D
         iuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261023; x=1752865823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkJwcKJg+tZTk2PUq5SxJEgWnAxAeKWGsOVHC65hVSY=;
        b=HDd3JJZvEyTMADBpFHNNaZeV4Epw7a8WuyaddPMJkEIdZbiR/+c4eJSYd0y6ePq3xD
         4GQb5pDW7N37E9S/It3/SlU1PESs36yvkR2rQ2z9J+3+tryV9r6RdF2hJZNphgtIKu/m
         Yr70gLqo7litYHQwbfHvLw9YO9uqSCAcMtYGoWVFlWQ7bQjtHTHjcLlh+7EDHUOe26sL
         FXRFNOaLZuNDQYVBq7m4C2HXV0HxFxbY307DVeNCSAM3ia0FIrnvJ9U1Il43CVEfUBXw
         XCI0tsipWwnf8uVPAHFXBmb+jiDZeP56WDaHkDLxk0pbU4M/Ejm3nzQuynR1kKIktWai
         YaeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFx+rMUhzWpddayOO1TBQXd9B/x7nB60gvKzGW7Fjzgb0N96bCFRbYBTBspRwC7hXL9RM9M2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXd9xvsapybPNJKKip6w8ORzs6tILfgZs6dPUIVFXcQqvj017s
	/7ikQ76y5BfyNEFh8TlDDozI5eQVZirEADyDlu5kjyCJHvbBMlPUGmhpeU9KgZaaXZw21Z+bJoD
	h39bcxw==
X-Google-Smtp-Source: AGHT+IFc38Qj+PXnvK2nOe3R60tTwNNHNHrQywts3HikaLJJCkxZVgZnMSSmO+9psXo+imL+CDxPnoO9s/8=
X-Received: from pjbpl3.prod.google.com ([2002:a17:90b:2683:b0:311:462d:cb60])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2689:b0:311:d05c:936
 with SMTP id 98e67ed59e1d1-31c4ccdd5cdmr7289806a91.17.1752261023470; Fri, 11
 Jul 2025 12:10:23 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:13 +0000
In-Reply-To: <20250711191007.3591938-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711191007.3591938-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-9-kuniyu@google.com>
Subject: [PATCH v1 net-next 08/14] neighbour: Convert RTM_GETNEIGH to RCU.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Only __dev_get_by_index() is the RTNL dependant in neigh_get().

Let's replace it with dev_get_by_index_rcu() and convert RTM_GETNEIGH
to RCU.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index e88b9a4bfe6ea..c5bd52dfd3e5b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3048,6 +3048,8 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (!skb)
 		return -ENOBUFS;
 
+	rcu_read_lock();
+
 	tbl = neigh_find_table(ndm->ndm_family);
 	if (!tbl) {
 		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
@@ -3064,7 +3066,7 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	dst = nla_data(tb[NDA_DST]);
 
 	if (ndm->ndm_ifindex) {
-		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
+		dev = dev_get_by_index_rcu(net, ndm->ndm_ifindex);
 		if (!dev) {
 			NL_SET_ERR_MSG(extack, "Unknown device ifindex");
 			err = -ENODEV;
@@ -3099,8 +3101,11 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 			goto err;
 	}
 
+	rcu_read_unlock();
+
 	return rtnl_unicast(skb, net, pid);
 err:
+	rcu_read_unlock();
 	kfree_skb(skb);
 	return err;
 }
@@ -3900,7 +3905,7 @@ static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] __initconst = {
 	{.msgtype = RTM_NEWNEIGH, .doit = neigh_add},
 	{.msgtype = RTM_DELNEIGH, .doit = neigh_delete},
 	{.msgtype = RTM_GETNEIGH, .doit = neigh_get, .dumpit = neigh_dump_info,
-	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
+	 .flags = RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
 	{.msgtype = RTM_GETNEIGHTBL, .dumpit = neightbl_dump_info},
 	{.msgtype = RTM_SETNEIGHTBL, .doit = neightbl_set},
 };
-- 
2.50.0.727.gbf7dc18ff4-goog


