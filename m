Return-Path: <netdev+bounces-20081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B7A75D8CE
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 03:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9162A1C21870
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 01:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493B66AA9;
	Sat, 22 Jul 2023 01:42:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862FE613F
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 01:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4124C433CD;
	Sat, 22 Jul 2023 01:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689990161;
	bh=iooMBmB0ljs0AntvKmjJ8Aaq9xp+5rxb0ZchwG/lHiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9//Ma7nUq2oppvb20oZ/3eFuGFjBki/8IaHTiRzwSbtYOF701HYSlqBnV9arqZx+
	 mTO3cQcQc11KwnhhFM12R/10ZnqU94EfARs8zO0jhWFiI1pr/hGER0RIgBjzGM56u7
	 M+lryLOAQhqdtX5wpzbpiHnImGYuuDyFbz79oXl5OUMMUSUZksM0X8x3xJSONjaz/X
	 1eOV6BYpJNJSZOZ0lhVGvPV1qdS7qwSlsYFy+ABTjbWQ9D6Q3TXSNxxQuXVJ2hzjgs
	 6sOTd9KNul1mQnsoO4t5HdXhn1EI290z8qni4xr0KvUjTZHJrvRtdvIyyR1XIjzWoN
	 mxgVIJ5eL1Gdg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	mkubecek@suse.cz,
	lorenzo@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] net: convert some netlink netdev iterators to depend on the xarray
Date: Fri, 21 Jul 2023 18:42:37 -0700
Message-ID: <20230722014237.4078962-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230722014237.4078962-1-kuba@kernel.org>
References: <20230722014237.4078962-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reap the benefits of easier iteration thanks to the xarray.
Convert just the genetlink ones, those are easier to test.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h |  3 ++
 net/core/netdev-genl.c    | 37 +++++---------------
 net/ethtool/netlink.c     | 59 ++++++++-----------------------
 net/ethtool/tunnels.c     | 73 +++++++++++++++------------------------
 4 files changed, 52 insertions(+), 120 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3800d0479698..1159ca17e246 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3014,6 +3014,9 @@ extern rwlock_t				dev_base_lock;		/* Device list lock */
 			if (netdev_master_upper_dev_get_rcu(slave) == (bond))
 #define net_device_entry(lh)	list_entry(lh, struct net_device, dev_list)
 
+#define for_each_netdev_dump(net, d, ifindex)				\
+	xa_for_each_start(&(net)->dev_by_index, (ifindex), (d), (ifindex))
+
 static inline struct net_device *next_net_device(struct net_device *dev)
 {
 	struct list_head *lh;
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 65ef4867fc49..797c813c7c77 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -101,43 +101,22 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct net *net = sock_net(skb->sk);
 	struct net_device *netdev;
-	int idx = 0, s_idx;
-	int h, s_h;
-	int err;
-
-	s_h = cb->args[0];
-	s_idx = cb->args[1];
+	int err = 0;
 
 	rtnl_lock();
-
-	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
-		struct hlist_head *head;
-
-		idx = 0;
-		head = &net->dev_index_head[h];
-		hlist_for_each_entry(netdev, head, index_hlist) {
-			if (idx < s_idx)
-				goto cont;
-			err = netdev_nl_dev_fill(netdev, skb,
-						 NETLINK_CB(cb->skb).portid,
-						 cb->nlh->nlmsg_seq, 0,
-						 NETDEV_CMD_DEV_GET);
-			if (err < 0)
-				break;
-cont:
-			idx++;
-		}
+	for_each_netdev_dump(net, netdev, cb->args[0]) {
+		err = netdev_nl_dev_fill(netdev, skb,
+					 NETLINK_CB(cb->skb).portid,
+					 cb->nlh->nlmsg_seq, 0,
+					 NETDEV_CMD_DEV_GET);
+		if (err < 0)
+			break;
 	}
-
 	rtnl_unlock();
 
 	if (err != -EMSGSIZE)
 		return err;
 
-	cb->args[1] = idx;
-	cb->args[0] = h;
-	cb->seq = net->dev_base_seq;
-
 	return skb->len;
 }
 
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 39a459b0111b..ae344f1b0bbd 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -252,8 +252,7 @@ int ethnl_multicast(struct sk_buff *skb, struct net_device *dev)
  * @ops:        request ops of currently processed message type
  * @req_info:   parsed request header of processed request
  * @reply_data: data needed to compose the reply
- * @pos_hash:   saved iteration position - hashbucket
- * @pos_idx:    saved iteration position - index
+ * @pos_ifindex: saved iteration position - ifindex
  *
  * These parameters are kept in struct netlink_callback as context preserved
  * between iterations. They are initialized by ethnl_default_start() and used
@@ -263,8 +262,7 @@ struct ethnl_dump_ctx {
 	const struct ethnl_request_ops	*ops;
 	struct ethnl_req_info		*req_info;
 	struct ethnl_reply_data		*reply_data;
-	int				pos_hash;
-	int				pos_idx;
+	unsigned long			pos_ifindex;
 };
 
 static const struct ethnl_request_ops *
@@ -490,55 +488,27 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 {
 	struct ethnl_dump_ctx *ctx = ethnl_dump_context(cb);
 	struct net *net = sock_net(skb->sk);
-	int s_idx = ctx->pos_idx;
-	int h, idx = 0;
+	struct net_device *dev;
 	int ret = 0;
 
 	rtnl_lock();
-	for (h = ctx->pos_hash; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
-		struct hlist_head *head;
-		struct net_device *dev;
-		unsigned int seq;
+	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
+		dev_hold(dev);
+		rtnl_unlock();
 
-		head = &net->dev_index_head[h];
+		ret = ethnl_default_dump_one(skb, dev, ctx, cb);
 
-restart_chain:
-		seq = net->dev_base_seq;
-		cb->seq = seq;
-		idx = 0;
-		hlist_for_each_entry(dev, head, index_hlist) {
-			if (idx < s_idx)
-				goto cont;
-			dev_hold(dev);
-			rtnl_unlock();
+		rtnl_lock();
+		dev_put(dev);
 
-			ret = ethnl_default_dump_one(skb, dev, ctx, cb);
-			dev_put(dev);
-			if (ret < 0) {
-				if (ret == -EOPNOTSUPP)
-					goto lock_and_cont;
-				if (likely(skb->len))
-					ret = skb->len;
-				goto out;
-			}
-lock_and_cont:
-			rtnl_lock();
-			if (net->dev_base_seq != seq) {
-				s_idx = idx + 1;
-				goto restart_chain;
-			}
-cont:
-			idx++;
+		if (ret < 0 && ret != -EOPNOTSUPP) {
+			if (likely(skb->len))
+				ret = skb->len;
+			break;
 		}
-
 	}
 	rtnl_unlock();
 
-out:
-	ctx->pos_hash = h;
-	ctx->pos_idx = idx;
-	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
-
 	return ret;
 }
 
@@ -584,8 +554,7 @@ static int ethnl_default_start(struct netlink_callback *cb)
 	ctx->ops = ops;
 	ctx->req_info = req_info;
 	ctx->reply_data = reply_data;
-	ctx->pos_hash = 0;
-	ctx->pos_idx = 0;
+	ctx->pos_ifindex = 0;
 
 	return 0;
 
diff --git a/net/ethtool/tunnels.c b/net/ethtool/tunnels.c
index 67fb414ca859..05f752557b5e 100644
--- a/net/ethtool/tunnels.c
+++ b/net/ethtool/tunnels.c
@@ -212,8 +212,7 @@ int ethnl_tunnel_info_doit(struct sk_buff *skb, struct genl_info *info)
 
 struct ethnl_tunnel_info_dump_ctx {
 	struct ethnl_req_info	req_info;
-	int			pos_hash;
-	int			pos_idx;
+	unsigned long		ifindex;
 };
 
 int ethnl_tunnel_info_start(struct netlink_callback *cb)
@@ -243,56 +242,38 @@ int ethnl_tunnel_info_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct ethnl_tunnel_info_dump_ctx *ctx = (void *)cb->ctx;
 	struct net *net = sock_net(skb->sk);
-	int s_idx = ctx->pos_idx;
-	int h, idx = 0;
+	struct net_device *dev;
 	int ret = 0;
 	void *ehdr;
 
 	rtnl_lock();
-	cb->seq = net->dev_base_seq;
-	for (h = ctx->pos_hash; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
-		struct hlist_head *head;
-		struct net_device *dev;
-
-		head = &net->dev_index_head[h];
-		idx = 0;
-		hlist_for_each_entry(dev, head, index_hlist) {
-			if (idx < s_idx)
-				goto cont;
-
-			ehdr = ethnl_dump_put(skb, cb,
-					      ETHTOOL_MSG_TUNNEL_INFO_GET_REPLY);
-			if (!ehdr) {
-				ret = -EMSGSIZE;
-				goto out;
-			}
-
-			ret = ethnl_fill_reply_header(skb, dev, ETHTOOL_A_TUNNEL_INFO_HEADER);
-			if (ret < 0) {
-				genlmsg_cancel(skb, ehdr);
-				goto out;
-			}
-
-			ctx->req_info.dev = dev;
-			ret = ethnl_tunnel_info_fill_reply(&ctx->req_info, skb);
-			ctx->req_info.dev = NULL;
-			if (ret < 0) {
-				genlmsg_cancel(skb, ehdr);
-				if (ret == -EOPNOTSUPP)
-					goto cont;
-				goto out;
-			}
-			genlmsg_end(skb, ehdr);
-cont:
-			idx++;
+	for_each_netdev_dump(net, dev, ctx->ifindex) {
+		ehdr = ethnl_dump_put(skb, cb,
+				      ETHTOOL_MSG_TUNNEL_INFO_GET_REPLY);
+		if (!ehdr) {
+			ret = -EMSGSIZE;
+			break;
 		}
-	}
-out:
-	rtnl_unlock();
 
-	ctx->pos_hash = h;
-	ctx->pos_idx = idx;
-	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
+		ret = ethnl_fill_reply_header(skb, dev,
+					      ETHTOOL_A_TUNNEL_INFO_HEADER);
+		if (ret < 0) {
+			genlmsg_cancel(skb, ehdr);
+			break;
+		}
+
+		ctx->req_info.dev = dev;
+		ret = ethnl_tunnel_info_fill_reply(&ctx->req_info, skb);
+		ctx->req_info.dev = NULL;
+		if (ret < 0) {
+			genlmsg_cancel(skb, ehdr);
+			if (ret == -EOPNOTSUPP)
+				continue;
+			break;
+		}
+		genlmsg_end(skb, ehdr);
+	}
+	rtnl_unlock();
 
 	if (ret == -EMSGSIZE && skb->len)
 		return skb->len;
-- 
2.41.0


