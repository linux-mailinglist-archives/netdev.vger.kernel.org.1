Return-Path: <netdev+bounces-70844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24607850BB6
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 22:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026181C20ADE
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 21:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC8F5F57E;
	Sun, 11 Feb 2024 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cF88L7oL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C965F49D
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707687853; cv=none; b=G6RiIxhFBQ6lsO+XTqWiJTAmq6kXEA77Sr27GQDepDf3iDNbk1G7cBQBkPn9Dtmiekh+cYt84bm98UwCCjzs7BQfTl5O0Ko6g25wgZSk22UEJYCMBotGskj8xyTzS9lLaYAENSyRIySbz99DoNKGaWfIJF8M/MvlbOsoqLikt3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707687853; c=relaxed/simple;
	bh=4WF7pt6ujr2Pw3eNk+PDjtWA5JYWiKphFKTt1Q8+zSw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U9fBgMI5wDVfx4M21p5nXw1KPFe9u1YjVoQ6wfnoaw/Bnd3VXuYpI0Y90glQTOprGxURgm/Xo0qsftB79Qx7Bwl/ahIznoBa0j4XN2MiJ4LiuHiOvaiL9112rOzYbUV2HpPGXp/5SHyj4oHJq6G4yo8j1gLY6weWH6v1b3pJOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cF88L7oL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso3635628276.3
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 13:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707687850; x=1708292650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n2FhvwrXZzedGEU8XFH8+BqiIqdqYU7vpBjj8vcVwqY=;
        b=cF88L7oLoDi4PPVKIoQc26l5JTBHxCgi4QVveGj1PUPACczopNxaPWAFBuUPM7Ptrl
         rB4CPrXDqdGvGSUKws0AUb3Hr57odXZQ8QyAkkTW9b3RUNQtOwNjvSLWd+rL0OcMqaUg
         S531uY0hAxdxgE6vv+/zqYxTr2mRorR4GHWb1VMtwpqwoiwthaSBAQs35I4ix1wk4Gk0
         Ivj/2GcCDQEl/FL/Jwm4FLHq1n54Q7/SNlWKuscB/007mDcM9AvkLqE8dlL5Tobgois2
         ugoPfdZcEEjHPsj2hEzPzcp3xs1BC0oJJeigwE6BsXN2QFEewXnzufjBoPu9XoIfDvM+
         0wZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707687850; x=1708292650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2FhvwrXZzedGEU8XFH8+BqiIqdqYU7vpBjj8vcVwqY=;
        b=EqQyuxTlfwjgCDSZFKMIkrsHz/ZqR25e2U+uyWpr5ghsu4naYwN6SuW7KzNZ+46StM
         y/rkE6lJouKoSZi2K14Oju+GPZIf2roxskQuIZrV9PiPrVbE4UgYswxESHGhybGD+wx4
         2bIyYXN4N24vRzAkJax5sWLmr64R6OQ/0rqY+KZdlAyXW1e4b7WLVA2OlcCejjZ03OzY
         dX2SjSd0K6CMzpznmUIXLJoEum3JmGEQA/MLQs2Xy1c6LOCqyyK4zzf0jVmxnBhPScPI
         R8TvUy1yRswrJr72NMCaAdFfjne1b54vusxWdyoKkxm5GlMgU4uZqVi7hIEEmSwFJa4v
         nB4A==
X-Forwarded-Encrypted: i=1; AJvYcCUhYGJaINnrx7k7gmmODhjH8GBcLD5bP/oQhr9ECWnh2kAuZ0yQVfjqK+okr8n9buUyI65u7JTgbQhAbhAJhAo1+YbcG8SX
X-Gm-Message-State: AOJu0YznCfdp/YQUbVUocJcxsnFG8qMqnaH4XxljBqXX2GvLJCzBQnmM
	RGDA3bDy3IdJGB0GJyXlZbzNtkO3cdmAsWdwY17w6fJ7p5WlpaIXUdpRV6oCgScXPSutG+iyXMU
	2H228Tqb9oQ==
X-Google-Smtp-Source: AGHT+IEta4HUet2jrekxzn4feb3qMzq2iNXNJ0hrWfynLSktJfGLZvY1+ljIN3jeuLjjoLTRjwEuAb+2rjy5Bw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:69c1:0:b0:dc2:3268:e9e7 with SMTP id
 e184-20020a2569c1000000b00dc23268e9e7mr200162ybc.10.1707687850551; Sun, 11
 Feb 2024 13:44:10 -0800 (PST)
Date: Sun, 11 Feb 2024 21:44:04 +0000
In-Reply-To: <20240211214404.1882191-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240211214404.1882191-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240211214404.1882191-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/2] rtnetlink: use xarray iterator to implement rtnl_dump_ifinfo()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Adopt net->dev_by_index as I did in commit 0e0939c0adf9
("net-procfs: use xarray iterator to implement /proc/net/dev")

This makes sure an existing device is always visible in the dump,
regardless of concurrent insertions/deletions.

v2: added suggestions from Jakub Kicinski and Ido Schimmel,
    thanks for the help !

Link: https://lore.kernel.org/all/20240209142441.6c56435b@kernel.org/
Link: https://lore.kernel.org/all/ZckR-XOsULLI9EHc@shredder/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 58 +++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 38 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 31f433950c8dc953bcb65cc0469f7df962314b87..6f1c5537e8421bdb677e926e7fc9be1beb5ff969 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2188,25 +2188,22 @@ static int rtnl_valid_dump_ifinfo_req(const struct nlmsghdr *nlh,
 
 static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 {
+	const struct rtnl_link_ops *kind_ops = NULL;
 	struct netlink_ext_ack *extack = cb->extack;
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
-	struct net *tgt_net = net;
-	int h, s_h;
-	int idx = 0, s_idx;
-	struct net_device *dev;
-	struct hlist_head *head;
+	unsigned int flags = NLM_F_MULTI;
 	struct nlattr *tb[IFLA_MAX+1];
+	struct {
+		unsigned long ifindex;
+	} *ctx = (void *)cb->ctx;
+	struct net *tgt_net = net;
 	u32 ext_filter_mask = 0;
-	const struct rtnl_link_ops *kind_ops = NULL;
-	unsigned int flags = NLM_F_MULTI;
+	struct net_device *dev;
 	int master_idx = 0;
 	int netnsid = -1;
 	int err, i;
 
-	s_h = cb->args[0];
-	s_idx = cb->args[1];
-
 	err = rtnl_valid_dump_ifinfo_req(nlh, cb->strict_check, tb, extack);
 	if (err < 0) {
 		if (cb->strict_check)
@@ -2250,36 +2247,21 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 		flags |= NLM_F_DUMP_FILTERED;
 
 walk_entries:
-	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
-		idx = 0;
-		head = &tgt_net->dev_index_head[h];
-		hlist_for_each_entry(dev, head, index_hlist) {
-			if (link_dump_filtered(dev, master_idx, kind_ops))
-				goto cont;
-			if (idx < s_idx)
-				goto cont;
-			err = rtnl_fill_ifinfo(skb, dev, net,
-					       RTM_NEWLINK,
-					       NETLINK_CB(cb->skb).portid,
-					       nlh->nlmsg_seq, 0, flags,
-					       ext_filter_mask, 0, NULL, 0,
-					       netnsid, GFP_KERNEL);
-
-			if (err < 0) {
-				if (likely(skb->len))
-					goto out;
-
-				goto out_err;
-			}
-cont:
-			idx++;
+	err = 0;
+	for_each_netdev_dump(tgt_net, dev, ctx->ifindex) {
+		if (link_dump_filtered(dev, master_idx, kind_ops))
+			continue;
+		err = rtnl_fill_ifinfo(skb, dev, net, RTM_NEWLINK,
+				       NETLINK_CB(cb->skb).portid,
+				       nlh->nlmsg_seq, 0, flags,
+				       ext_filter_mask, 0, NULL, 0,
+				       netnsid, GFP_KERNEL);
+		if (err < 0) {
+			if (likely(skb->len))
+				err = skb->len;
+			break;
 		}
 	}
-out:
-	err = skb->len;
-out_err:
-	cb->args[1] = idx;
-	cb->args[0] = h;
 	cb->seq = tgt_net->dev_base_seq;
 	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 	if (netnsid >= 0)
-- 
2.43.0.687.g38aa6559b0-goog


