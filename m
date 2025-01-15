Return-Path: <netdev+bounces-158377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B09A1181B
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BCE168C7A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535A522F39E;
	Wed, 15 Jan 2025 03:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJ8zSO82"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4A722F397
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 03:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913221; cv=none; b=R5fFrt6p8ozq2Ai17CuyAR14ZmmSeEKIBbksuOo/PPvXfFYK0/zhUSz6e6dp1NUfZ1vCCNdphsuwj53oJFcn43f3yGwBDygtoCG96Co3MSZUJh0VQqs+s34ZWdeIJQH2TZ0kWfEcHIXZdCBds7Pq/bWsMnXG+W0YtBT595yLqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913221; c=relaxed/simple;
	bh=4jodZjNT8rZQ3LqPSS9vu73sgZn78TXGULYqlc9RbVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbkgSyDM6WBVk6xzU5XXWMmIDz68cLRUBTSnw1Rb/fK9w416f+QOB177ZdLyHftwvMnESisYhPM8y6orSvnel8QKNNHlOStwBRC1MaNF3fKKH6h3l69vmVlewAMIV3SFje0bEgOaAe6AeouofZlpZAFR5l98of1HoscD0rhazOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJ8zSO82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E93C4CEE6;
	Wed, 15 Jan 2025 03:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736913220;
	bh=4jodZjNT8rZQ3LqPSS9vu73sgZn78TXGULYqlc9RbVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJ8zSO82bwvIqiBJCXG2bo8gNi1POz/W0RjZM1JYLv+cdsNF1+5mRScE6Z6beP6yR
	 hHh3FEbABy2pEnD1UhHB00sXP9GT3ntCwL+7ACI+K4kZ+teAIgDnPB7whRXEd+ZOTh
	 i3+A0g0ieyab7CRc4lWpKnB14eyFu8FyyxVJJQTHaHmZeJl99bJFN+btswlcFPdk2j
	 KbC0cFCjNP8O+S5PKpO6vKXLl0QXiPyAe2xcgf00hto8/CqHimgMv/1DNuM9Xw6UVs
	 xKuXv2evT2c6ww/Vjn9JjUskQqDaZuJOzk8ozIrUkdN958mLoT5p9NxEFGdBk/fxh1
	 Gv/Sq7NHdjDEQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 07/11] net: make netdev netlink ops hold netdev_lock()
Date: Tue, 14 Jan 2025 19:53:15 -0800
Message-ID: <20250115035319.559603-8-kuba@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115035319.559603-1-kuba@kernel.org>
References: <20250115035319.559603-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In prep for dropping rtnl_lock, start locking netdev->lock in netlink
genl ops. We need to be using netdev->up instead of flags & IFF_UP.

We can remove the RCU lock protection for the NAPI since NAPI list
is protected by netdev->lock already.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.h         |  1 -
 net/core/dev.c         |  3 ++-
 net/core/netdev-genl.c | 46 +++++++++++++++++++++++-------------------
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index ef37e2dd44f4..a5b166bbd169 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -23,7 +23,6 @@ struct sd_flow_limit {
 
 extern int netdev_flow_limit_table_len;
 
-struct napi_struct *netdev_napi_by_id(struct net *net, unsigned int napi_id);
 struct napi_struct *
 netdev_napi_by_id_lock(struct net *net, unsigned int napi_id);
 struct net_device *dev_get_by_napi_id(unsigned int napi_id);
diff --git a/net/core/dev.c b/net/core/dev.c
index 9cf93868ac7e..9734c3f5b862 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -767,7 +767,8 @@ static struct napi_struct *napi_by_id(unsigned int napi_id)
 }
 
 /* must be called under rcu_read_lock(), as we dont take a reference */
-struct napi_struct *netdev_napi_by_id(struct net *net, unsigned int napi_id)
+static struct napi_struct *
+netdev_napi_by_id(struct net *net, unsigned int napi_id)
 {
 	struct napi_struct *napi;
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index c59619a2ec23..810a446ab62c 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -167,7 +167,7 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	void *hdr;
 	pid_t pid;
 
-	if (!(napi->dev->flags & IFF_UP))
+	if (!napi->dev->up)
 		return 0;
 
 	hdr = genlmsg_iput(rsp, info);
@@ -230,17 +230,16 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 
 	rtnl_lock();
-	rcu_read_lock();
 
-	napi = netdev_napi_by_id(genl_info_net(info), napi_id);
+	napi = netdev_napi_by_id_lock(genl_info_net(info), napi_id);
 	if (napi) {
 		err = netdev_nl_napi_fill_one(rsp, napi, info);
+		netdev_unlock(napi->dev);
 	} else {
 		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
 		err = -ENOENT;
 	}
 
-	rcu_read_unlock();
 	rtnl_unlock();
 
 	if (err) {
@@ -266,7 +265,7 @@ netdev_nl_napi_dump_one(struct net_device *netdev, struct sk_buff *rsp,
 	unsigned int prev_id;
 	int err = 0;
 
-	if (!(netdev->flags & IFF_UP))
+	if (!netdev->up)
 		return err;
 
 	prev_id = UINT_MAX;
@@ -303,13 +302,15 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rtnl_lock();
 	if (ifindex) {
-		netdev = __dev_get_by_index(net, ifindex);
-		if (netdev)
+		netdev = netdev_get_by_index_lock(net, ifindex);
+		if (netdev) {
 			err = netdev_nl_napi_dump_one(netdev, skb, info, ctx);
-		else
+			netdev_unlock(netdev);
+		} else {
 			err = -ENODEV;
+		}
 	} else {
-		for_each_netdev_dump(net, netdev, ctx->ifindex) {
+		for_each_netdev_lock_scoped(net, netdev, ctx->ifindex) {
 			err = netdev_nl_napi_dump_one(netdev, skb, info, ctx);
 			if (err < 0)
 				break;
@@ -358,17 +359,16 @@ int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
 	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
 
 	rtnl_lock();
-	rcu_read_lock();
 
-	napi = netdev_napi_by_id(genl_info_net(info), napi_id);
+	napi = netdev_napi_by_id_lock(genl_info_net(info), napi_id);
 	if (napi) {
 		err = netdev_nl_napi_set_config(napi, info);
+		netdev_unlock(napi->dev);
 	} else {
 		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
 		err = -ENOENT;
 	}
 
-	rcu_read_unlock();
 	rtnl_unlock();
 
 	return err;
@@ -442,7 +442,7 @@ netdev_nl_queue_fill(struct sk_buff *rsp, struct net_device *netdev, u32 q_idx,
 {
 	int err;
 
-	if (!(netdev->flags & IFF_UP))
+	if (!netdev->up)
 		return -ENOENT;
 
 	err = netdev_nl_queue_validate(netdev, q_idx, q_type);
@@ -474,11 +474,13 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 	rtnl_lock();
 
-	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
-	if (netdev)
+	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
+	if (netdev) {
 		err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
-	else
+		netdev_unlock(netdev);
+	} else {
 		err = -ENODEV;
+	}
 
 	rtnl_unlock();
 
@@ -499,7 +501,7 @@ netdev_nl_queue_dump_one(struct net_device *netdev, struct sk_buff *rsp,
 {
 	int err = 0;
 
-	if (!(netdev->flags & IFF_UP))
+	if (!netdev->up)
 		return err;
 
 	for (; ctx->rxq_idx < netdev->real_num_rx_queues; ctx->rxq_idx++) {
@@ -532,13 +534,15 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rtnl_lock();
 	if (ifindex) {
-		netdev = __dev_get_by_index(net, ifindex);
-		if (netdev)
+		netdev = netdev_get_by_index_lock(net, ifindex);
+		if (netdev) {
 			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
-		else
+			netdev_unlock(netdev);
+		} else {
 			err = -ENODEV;
+		}
 	} else {
-		for_each_netdev_dump(net, netdev, ctx->ifindex) {
+		for_each_netdev_lock_scoped(net, netdev, ctx->ifindex) {
 			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
 			if (err < 0)
 				break;
-- 
2.48.0


