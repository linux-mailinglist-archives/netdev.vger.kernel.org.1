Return-Path: <netdev+bounces-150118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308DA9E8FB5
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AA8164CF9
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F0216E0C;
	Mon,  9 Dec 2024 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uD859AVI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C944216611
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738875; cv=none; b=Qkuo4sm6x8oodcA7mUAXgx5EoQLnDHkNC3ZuENI1//NPVV0eAdXLU9oqbrvWFkhLjVx/zT+r7oBkmrGfOlcPjm5teG2Nbfd6ePzCYkFNErzRSamDfmXIk1byao7A7l+9339z3Ro+Lc4AkT/CUA3LQgrJYd0o82LB/vL12r+qMCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738875; c=relaxed/simple;
	bh=2cL5qNmYJ/VPNv4E9JhXhjTEnakvAx/aV8PDkLBqdDw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eo0wOQTuSDFruZd64NcqzWRiu8T7ab1DklW0wQDjI7K7NBEMGLmis3n7Jb0AWeVkYq62jk7Sn/9xn4zol49z9D/OoDOWVJ4jonb+5lChc1wo7EMAbjspqrfkrp2qZxeaEWEmSIJccFafawJLvY+PkSoYdCg7F0+lfzdwjwOIoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uD859AVI; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4668f208ff7so89803671cf.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 02:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733738872; x=1734343672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qblZ6PQss9q9GHhzkkP8KvYUrI0jUrlzeKUCXqtiubc=;
        b=uD859AVIAe0UWsKCkM2XZy/CLrxDVhC6jR5n0/Q0Q9oTVSmNOmetSExzBbp227fagu
         5DOJ8uteb0vprnzs+uaqQrSjJreOXq+1Q58eg9PE4fY+ReQvtWGV3afXPZ4gd2rWTGf5
         1sTLcJqDtKkDLJxNfvYf0TI0FbNfakHqvGEVSTKsfJRj9KmbGHGZiyZFE+9p8F2dI9wX
         8xY+Zp8B3u40wfhdDcJ1SjpcYRu/J+hLbKNLof4IN44UJUOPaFTxf025hyiTj/R5oTWa
         Lkr+9QjZ72vNl7DsxaeWM0F/1aXicuvlHg8k5ZwEUgfBSQDzl0WmMNJ9nnx3O5BCUHG8
         P4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738872; x=1734343672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qblZ6PQss9q9GHhzkkP8KvYUrI0jUrlzeKUCXqtiubc=;
        b=cpX7/SwwizJ3GeBz0D5AxiYv4+UcRB9BXmq36ceoO5XabkRVsU0UsL4grOhTTuxR/Y
         SFll7eSkWhRzYUK6Gvycp29FCfUBKa+AUqyFFFY+MJt5teMAnsBInMiuEFQv0lj5PseJ
         +FCzyi7WxMsDfkmFvq9igqdDsbvuhNBMbbE/n+/vJEZYL9UGBHis/vBO9zaD9HG1X4z8
         dqc7rrvzffrFF/APPrdFP4Q5whEIRG2U8adRyTRJY0osJZ6NOJMU3ErBl8bqTAw2Bjgk
         0/mK7v7nr/D6W8xECFQpiY/O9fo/n2R/+K8jzbvYd6Uf85eCrb88LtUrrKkqmTMX3dvb
         O4KA==
X-Gm-Message-State: AOJu0Yzv2sE1QJmrAEJV8a6RaXp0qE+hI5hY285RS0xl4wuOY62pr6ie
	tQ8jCOahjw+TnET2/e7CZfoeMPuXaORyWJiB8IMgvPnM8faGep/Eor6sQe+E7+f0lwQihFWEdqH
	eyE3MfH4U2w==
X-Google-Smtp-Source: AGHT+IH6/F2ADq02KWZVqKSXCukcTTS+u4izLKISgFoEcufTtBjfdx9vhTUC/r7S9+5X8N4ssrAgNVSTuavnaw==
X-Received: from qtcw37.prod.google.com ([2002:a05:622a:1925:b0:466:867e:7235])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:8e1a:b0:467:45f2:58b with SMTP id d75a77b69052e-46745f209fcmr85054081cf.6.1733738872398;
 Mon, 09 Dec 2024 02:07:52 -0800 (PST)
Date: Mon,  9 Dec 2024 10:07:46 +0000
In-Reply-To: <20241209100747.2269613-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209100747.2269613-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209100747.2269613-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/3] rtnetlink: switch rtnl_fdb_dump() to for_each_netdev_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Roopa Prabhu <roopa@nvidia.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Ido Schimmel <idosch@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is the last netdev iterator still using net->dev_index_head[].

Convert to modern for_each_netdev_dump() for better scalability,
and use common patterns in our stack.

Following patch in this series removes the pad field
in struct ndo_fdb_dump_context.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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
index 453cc8bf18fbe0d2ac41fed13576279b4c7a2c07..8fe252c298a2dbcb3a187a117741cd0149fac4cf 100644
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
 
 	NL_ASSERT_CTX_FITS(struct ndo_fdb_dump_context);
 
@@ -4941,69 +4938,50 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
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


