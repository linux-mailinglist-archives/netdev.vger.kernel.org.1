Return-Path: <netdev+bounces-70551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E9584F7F6
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC42B221E6
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A159D6A037;
	Fri,  9 Feb 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNbKbGRV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140756DCEB
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490583; cv=none; b=dfr/eAFxTOeDwWiKikeoDtU/T3tAGcNTmel0RLluIqkp0PbeAhcLi93bWJwTqFMdrRh2kC9O8DDPhmAxTlOBXt7OsziD2rP9eNp2vf9fpFTA9j4/ATCP03yJLfUXXa5weVkQHBW04ocZguv8Ie3nElkOZ6e2+oDo/qFlFL7amlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490583; c=relaxed/simple;
	bh=8yQF8FR1l9TVynptGgh2ccwZDV7Su20nOHFxFeuQ5hg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i01PEzktVFfKpmcvsy9C4hM/rIO29iMJIyEUbk0OHAQPzQCX9HlWeisRJCq7d/5v72Lw0oZ/NFoNhN0Ie9lCuO/T2pF/2noawrqEam5TLy+n5FXctwhSD1ydvFQ+1UHDHHvEHhW2tJB6LTA/cZhWQsNDNLZmmfMxN8xWwy4aD0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jNbKbGRV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so1435574276.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 06:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707490581; x=1708095381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HH3vdhmKs6CuIDGtYb1dSzhwGgMJ2U2w+361jJK3Fu0=;
        b=jNbKbGRVovO+6Xfj8K94nO9KSUJTxVUB6+ymwpPrGjWpYFr83cvWyj/icKLKnTIQcL
         41sy5z1vgpYfetWQX4OsvJAFggch+uQGyYpkmy7EjARlSOwqkgbyQ6i/96rMUrJwEJAF
         YqktVPVfSnYGzF/ewDtAeyhwGFzOwNYzZUa2yL7bbhvkoG4YlK7prlaE/Nn3LJQwlA6m
         eTwOjso7qztMm4UQi72Z1AuDFj4wkevsViKRloRCPz8dGcOf71N2VkKFLBiMLuIZHy4A
         biKwNHAKsB/M5WEXvyqdJ1Gp/BKH8zep0/mxVH6le0lYbkpbjm15PkIsN+qJ1uXCwOGP
         K/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707490581; x=1708095381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HH3vdhmKs6CuIDGtYb1dSzhwGgMJ2U2w+361jJK3Fu0=;
        b=gMRjo5K9rGMjcIFo07PDPxvMRFevzQ8X0W/rrkLvvcFJh58QsfJ4dqSWnLonDiZIWP
         JIJH8YyB4SSycKyaA8fbgP1lqMdxQP14uew7Kxq9swWn6U1KdN5zsX0Ely9ZYNnAcP5/
         Zlz37pos4uQG3QiqKGgpxfSv6vmb1X81UDyUKjl97e2etP+RrkwhQt3hiK2IjQyDtbXM
         hXW1VS/BB/QhCLLbx3cozzy+WqJ3rx8knn2jeAVTdLtv3RupWbkoqufdxp1sKeHTuoBj
         nuyfCjczW2EyheT2OJKid6FKuaLjFnVqNnmq41YlmH/tCL6t2UznLkIMu6cjkGGbGVUF
         n82w==
X-Gm-Message-State: AOJu0YxTtAFXhHMkbgX295cUkymgCn8YhVFsLo5umAFk2gFIKrHpOt5S
	BIuucI2ydtDbuYU28hXSS7j2eOHIj4oiy3zFN3CgHAyQukY3raNtOXjPnen5t2ipI3O4/R27dgJ
	ZAfp7opngxg==
X-Google-Smtp-Source: AGHT+IG5DixspMpKqYFxU0Yydy8roHiS1C4uTQpAXIjprFhOJiaKVHuDKFgTHh2m3aczC7JMu5ELoatufVYaeA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:c586:0:b0:dc6:a6e3:ca93 with SMTP id
 v128-20020a25c586000000b00dc6a6e3ca93mr29414ybe.10.1707490581041; Fri, 09 Feb
 2024 06:56:21 -0800 (PST)
Date: Fri,  9 Feb 2024 14:56:15 +0000
In-Reply-To: <20240209145615.3708207-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209145615.3708207-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209145615.3708207-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] rtnetlink: use xarray iterator to implement rtnl_dump_ifinfo()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Adopt net->dev_by_index as I did in commit 0e0939c0adf9
("net-procfs: use xarray iterator to implement /proc/net/dev")

This makes sure an existing device is always visible in the dump,
regardless of concurrent insertions/deletions.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 59 ++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 31f433950c8dc953bcb65cc0469f7df962314b87..68a224bbf1dd6118526329782362a4bfc192d6b1 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2188,25 +2188,20 @@ static int rtnl_valid_dump_ifinfo_req(const struct nlmsghdr *nlh,
 
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
+	unsigned long ifindex = cb->args[0];
+	unsigned int flags = NLM_F_MULTI;
 	struct nlattr *tb[IFLA_MAX+1];
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
@@ -2250,42 +2245,26 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
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
-		}
-	}
-out:
 	err = skb->len;
-out_err:
-	cb->args[1] = idx;
-	cb->args[0] = h;
+	for_each_netdev_dump(tgt_net, dev, ifindex) {
+		if (link_dump_filtered(dev, master_idx, kind_ops))
+			continue;
+		err = rtnl_fill_ifinfo(skb, dev, net, RTM_NEWLINK,
+				       NETLINK_CB(cb->skb).portid,
+				       nlh->nlmsg_seq, 0, flags,
+				       ext_filter_mask, 0, NULL, 0,
+				       netnsid, GFP_KERNEL);
+
+		if (err < 0)
+			break;
+		cb->args[0] = ifindex + 1;
+	}
 	cb->seq = tgt_net->dev_base_seq;
 	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 	if (netnsid >= 0)
 		put_net(tgt_net);
 
-	return err;
+	return skb->len ?: err;
 }
 
 int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
-- 
2.43.0.687.g38aa6559b0-goog


