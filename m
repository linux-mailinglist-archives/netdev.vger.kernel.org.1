Return-Path: <netdev+bounces-149899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D384B9E8100
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 17:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6679B188473F
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F18A14AD2E;
	Sat,  7 Dec 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQFk7Ss8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94231AAC4
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733588582; cv=none; b=D1QbSHcgABnLcNWdQHOTIn0AbZ5c7MBx68aSqLvCpw2QzVxJ6AjxMtvP9f5DEy8oW+nFLSYotbnRrU/uwAmPDpNFmoJ5Hios9JekWu0RJCveLOLhVyZxoKfBOfrby32/VSIYun7dBqvc2ayjvHmEN8AT+ll8dVTws7i0wqs6NsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733588582; c=relaxed/simple;
	bh=N1kwMeSNlbHzYyNp/qwOpPf35SX6fxu0cMZ3/S3YPOs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KNMg5+anOk5gaEMNLZk058WBJYbShFbjoJcY9aaXpVNMhCEgA1FJqoUXij7UNiinR0MtfOb68HhsoUhne4Z7BbgmbrEIV97P9mKNN9JRZoKcj8CckM9OTKpORKdZSq2zCeqVQ+nlzHOqmMTgzbuNVX1P3PvRNLweE81MJc9aZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZQFk7Ss8; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d8eb5ea994so22226146d6.1
        for <netdev@vger.kernel.org>; Sat, 07 Dec 2024 08:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733588579; x=1734193379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cBeUvaqxTUa0vvaeake0pfkuB0PcxzzK5ZCov9MMdGY=;
        b=ZQFk7Ss8Hv8jgls0t3dcVcD7Du09BOrX5d0FIN0IHeh9Toj7AFpI48l4jmVg8WVkZW
         JgncP7t9pFGAWrG0+1sxGjRzwwHHs+siXcO8kBCzd6eyfDwjCL+CYpk/DIYGZwfeBAdm
         /afiy8zPeP5ZZL11o5qcJFJNoGgatS169fDEDYCYHsMEtGGQLLAjT74UHFZ36CRpro8k
         OZnc+Xezope/iKKau9n21HY8Hc6XzWwA+nnmekMR4WGNur90PXXI3FUKwZ1MpDWYhbfs
         js25u67hacMpRcagXiIr7msio7isrQ6hEEa09Fd2Z6hN0koy9pQRGkmUsJX3hmL8MfVl
         ChvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733588579; x=1734193379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBeUvaqxTUa0vvaeake0pfkuB0PcxzzK5ZCov9MMdGY=;
        b=YjQDPzODR3vv/iYxPT1zWrOTVaug+1l4qRha4uTPMgwRH0+/l8lz13m+sF3HTZwr4Z
         sGKZGz3FEYwv9Eb4Q5QjJAZ62eWVXr4e/OIpFS2gjFKKnU4Wl9N/TWpZJiN2ah//db+v
         fwMphkR7UnUv07fpLKCX5oz24G8mp6tAauZTCMJokY52PdSajebYUbTe9Q2BXQr6TIQ9
         zul2n7XIwDU3ps13rYdNd3SyH38jMHLwE6y/M4YuyStQXbrmJpvNZny8RRoybWfr1XOZ
         KnOA1G7R2oKuu4J3LMBDouUuzPmwvV3v8EPVHoDBnnaZCRnksC5Z7CzcIncK6+87oYDc
         U3hA==
X-Gm-Message-State: AOJu0YzwRmPyK8DUQzNRk9ENWK7cxoC5v5ZMowZ2Wdm9pWA4GsYPYGQ2
	Zh8+9bO1SoPfuBZoXHN+AFt8ETomdxUJeDScefVLB2x+zNc5qB2YS6EMiPjHsq28PsDGTpyM+Vl
	0alsNzYi0ug==
X-Google-Smtp-Source: AGHT+IHMm6x90ijCQbbNUPARd6N6TxPGyvvJBWKANnXSD12E3CZ/e7NVvTh2AbReBmsVP2ZkTDUN24ixPlxMVQ==
X-Received: from qvbqz1.prod.google.com ([2002:a05:6214:4d41:b0:6d8:9c4c:32fd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:c64:b0:6d8:899e:c3bf with SMTP id 6a1803df08f44-6d8e71a6668mr106250176d6.34.1733588579595;
 Sat, 07 Dec 2024 08:22:59 -0800 (PST)
Date: Sat,  7 Dec 2024 16:22:47 +0000
In-Reply-To: <20241207162248.18536-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241207162248.18536-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241207162248.18536-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] rtnetlink: switch rtnl_fdb_dump() to for_each_netdev_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Roopa Prabhu <roopa@nvidia.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is the last netdev iterator still using net->dev_index_head[].

Convert to modern for_each_netdev_dump() for better scalability,
and use common patterns in our stack.

Following patch in this series removes the pad field
in struct ndo_fdb_dump_context.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/rtnetlink.h |  4 +-
 net/core/rtnetlink.c      | 92 +++++++++++++++------------------------
 2 files changed, 37 insertions(+), 59 deletions(-)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index a91dfea64724615c9db778646e52cb8573f47e06..2b17d7eebd92342e472b9eb3b2ade84bc8ae2e94 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -180,8 +180,8 @@ void rtnl_kfree_skbs(struct sk_buff *head, struct sk_buff *tail);
 
 /* Shared by rtnl_fdb_dump() and various ndo_fdb_dump() helpers. */
 struct ndo_fdb_dump_context {
-	unsigned long s_h;
-	unsigned long s_idx;
+	unsigned long ifindex;
+	unsigned long pad;
 	unsigned long fdb_idx;
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 02791328102e7590465aab9ab949af093721b256..cdedb46edc2fd54f6fbd6ce7fb8e9a26486034e7 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4914,13 +4914,10 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	struct ndo_fdb_dump_context *ctx = (void *)cb->ctx;
 	struct net_device *dev, *br_dev = NULL;
 	struct net *net = sock_net(skb->sk);
-	struct hlist_head *head;
 	int brport_idx = 0;
 	int br_idx = 0;
-	int h, s_h;
-	int idx = 0, s_idx;
-	int err = 0;
 	int fidx = 0;
+	int err;
 
 	if (cb->strict_check)
 		err = valid_fdb_dump_strict(cb->nlh, &br_idx, &brport_idx,
@@ -4939,69 +4936,50 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		ops = br_dev->netdev_ops;
 	}
 
-	s_h = ctx->s_h;
-	s_idx = ctx->s_idx;
-
-	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
-		idx = 0;
-		head = &net->dev_index_head[h];
-		hlist_for_each_entry(dev, head, index_hlist) {
-
-			if (brport_idx && (dev->ifindex != brport_idx))
-				continue;
-
-			if (!br_idx) { /* user did not specify a specific bridge */
-				if (netif_is_bridge_port(dev)) {
-					br_dev = netdev_master_upper_dev_get(dev);
-					cops = br_dev->netdev_ops;
-				}
-			} else {
-				if (dev != br_dev &&
-				    !netif_is_bridge_port(dev))
-					continue;
+	for_each_netdev_dump(net, dev, ctx->ifindex) {
+		if (brport_idx && (dev->ifindex != brport_idx))
+			continue;
 
-				if (br_dev != netdev_master_upper_dev_get(dev) &&
-				    !netif_is_bridge_master(dev))
-					continue;
-				cops = ops;
+		if (!br_idx) { /* user did not specify a specific bridge */
+			if (netif_is_bridge_port(dev)) {
+				br_dev = netdev_master_upper_dev_get(dev);
+				cops = br_dev->netdev_ops;
 			}
+		} else {
+			if (dev != br_dev &&
+			    !netif_is_bridge_port(dev))
+				continue;
 
-			if (idx < s_idx)
-				goto cont;
+			if (br_dev != netdev_master_upper_dev_get(dev) &&
+			    !netif_is_bridge_master(dev))
+				continue;
+			cops = ops;
+		}
 
-			if (netif_is_bridge_port(dev)) {
-				if (cops && cops->ndo_fdb_dump) {
-					err = cops->ndo_fdb_dump(skb, cb,
-								br_dev, dev,
-								&fidx);
-					if (err == -EMSGSIZE)
-						goto out;
-				}
+		if (netif_is_bridge_port(dev)) {
+			if (cops && cops->ndo_fdb_dump) {
+				err = cops->ndo_fdb_dump(skb, cb, br_dev, dev,
+							&fidx);
+				if (err == -EMSGSIZE)
+					break;
 			}
+		}
 
-			if (dev->netdev_ops->ndo_fdb_dump)
-				err = dev->netdev_ops->ndo_fdb_dump(skb, cb,
-								    dev, NULL,
-								    &fidx);
-			else
-				err = ndo_dflt_fdb_dump(skb, cb, dev, NULL,
-							&fidx);
-			if (err == -EMSGSIZE)
-				goto out;
+		if (dev->netdev_ops->ndo_fdb_dump)
+			err = dev->netdev_ops->ndo_fdb_dump(skb, cb, dev, NULL,
+							    &fidx);
+		else
+			err = ndo_dflt_fdb_dump(skb, cb, dev, NULL, &fidx);
+		if (err == -EMSGSIZE)
+			break;
 
-			cops = NULL;
+		cops = NULL;
 
-			/* reset fdb offset to 0 for rest of the interfaces */
-			ctx->fdb_idx = 0;
-			fidx = 0;
-cont:
-			idx++;
-		}
+		/* reset fdb offset to 0 for rest of the interfaces */
+		ctx->fdb_idx = 0;
+		fidx = 0;
 	}
 
-out:
-	ctx->s_h = h;
-	ctx->s_idx = idx;
 	ctx->fdb_idx = fidx;
 
 	return skb->len;
-- 
2.47.0.338.g60cca15819-goog


