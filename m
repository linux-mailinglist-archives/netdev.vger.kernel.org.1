Return-Path: <netdev+bounces-150117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A619E8FB3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B532280C72
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34E6216614;
	Mon,  9 Dec 2024 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4NsMzeNS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A102165E4
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738873; cv=none; b=gCo3x9SgNdcPIsxCx0EP/KljVr641DWDgrPpgWnvP2DTIT7RpaT9SSq31gXYpHA81xh2sXacu6X0ujyKBIvsSIbON7V5Aqvic7gAR4L6WfDByy3FdDtHqIU5uF3PxuNN1WLOZlJ9+bC++Se65IOEnQytE29Rzzj9/tj9NpS6MrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738873; c=relaxed/simple;
	bh=8wjfXbBusMgIJ/ZbkgD/nmQt9LQsdPXnhRkNqSxF/a8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ihJmpzpa2FAWoNY2rahsXDfBVrluuRn/eZUgwE4qqbXABfpm+6De+ehR+2ko7XtkXY8ColGdYmYhNt0GZ11Z6jtvJ8bP0P5JlIdLs58pTOsr1t9oS+Ran49htaB0CN2880hrJfJgv7ueK83Ea41o4Sw1uXNBWR75DgtZ2jcEzfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4NsMzeNS; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-466abc6e8f6so3692191cf.2
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 02:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733738871; x=1734343671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCQefQI9mRGgRlujJ/oYfPZxHalY0bDXC3atgnHWslI=;
        b=4NsMzeNSXxLPTsj44+mrnCz2yC7jjKCzYZX1vdIMXFWGdbi+uL5nkDpBILboQ8ag/Z
         8APW7KqTvcIlRtTjXJ9RhxZHsA4aqNvs62NESyJeYD7WZcM8VRgAtyFjoGnqAl6UfyZ1
         Xw+6YExChm8WnZlmwQuGPvPeABKASPV7WvmtjuZxU41mbdtjsT0cGVAIuWf9/DfaKsDR
         si1xWseVsoF9x5ojpSDyCN4Cq255AxVLy/1FBtq9+kArHrB9+IaCq2uiu9Nap+9h1lpn
         SYtiX9wyUF7gNitO7olnejtMfHulPzzKUTJlu4N4psqpDmfjIWieheXnGFmDdroADZAs
         j/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738871; x=1734343671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCQefQI9mRGgRlujJ/oYfPZxHalY0bDXC3atgnHWslI=;
        b=OlZ96mrapkPLJKgN1paThcVpnDU+bN1UfxAFii3TSabZEqbYjtjfe/V1YYBEuUQCaZ
         xUfZKXJBvF9P2MTT8XFA3nIaK99hsp+otbOUWZoR92j7pxXesWQkq6HDAyYJzWBW9LHI
         v03IrfmqWy3a+HG3HfbHaES5BYFoxxZOzqzfRrmHibtYfi7cVPvvVB0azoOFTt2HGHk/
         alcvw7yCjDzSyXTp0doHZfEJPQVGkPE3lI3OOD0ZcQ+aSPxbwCdMIsCwgBu3K/hfO9Z8
         Wd2aWbemJavSN+U6g+SDADMgQDZqHIx6mGfr4h7OdkxbQovXXcQwzJ+bHoKLvPvm7Nww
         A0RQ==
X-Gm-Message-State: AOJu0YyRJj2FE0cuaUVKHio7PmT5TmAqYCemRucMbD3qXKgEk3+9notB
	bR0G4+WlbzXRkcTvtYLL2s+6a6+YlgMgreH4axML5sSe3qX9gY6PwkP5nOqxY4dPbFdxG2fvYbq
	ijejzktgkHg==
X-Google-Smtp-Source: AGHT+IFFgWiSbi0xs/CwzoVFVIwFkq0g6Y7ZP3Vld+dI32gG/gAHxGsrCntr6hE0kd2fMmHg47+qad5jt4iHLQ==
X-Received: from qtbey7.prod.google.com ([2002:a05:622a:4c07:b0:467:637d:58d0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7c52:0:b0:467:6201:818a with SMTP id d75a77b69052e-4676201a841mr70521251cf.36.1733738870981;
 Mon, 09 Dec 2024 02:07:50 -0800 (PST)
Date: Mon,  9 Dec 2024 10:07:45 +0000
In-Reply-To: <20241209100747.2269613-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209100747.2269613-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209100747.2269613-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/3] rtnetlink: add ndo_fdb_dump_context
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Roopa Prabhu <roopa@nvidia.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Ido Schimmel <idosch@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

rtnl_fdb_dump() and various ndo_fdb_dump() helpers share
a hidden layout of cb->ctx.

Before switching rtnl_fdb_dump() to for_each_netdev_dump()
in the following patch, make this more explicit.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   |  3 ++-
 drivers/net/ethernet/mscc/ocelot_net.c        |  3 ++-
 drivers/net/vxlan/vxlan_core.c                |  5 ++--
 include/linux/rtnetlink.h                     |  7 +++++
 net/bridge/br_fdb.c                           |  3 ++-
 net/core/rtnetlink.c                          | 26 ++++++++++---------
 net/dsa/user.c                                |  3 ++-
 7 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index a293b08f36d46dfde7e25412951da78c15e2dfd6..147a93bf9fa913f663676f30559202de9e889f40 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -780,13 +780,14 @@ struct ethsw_dump_ctx {
 static int dpaa2_switch_fdb_dump_nl(struct fdb_dump_entry *entry,
 				    struct ethsw_dump_ctx *dump)
 {
+	struct ndo_fdb_dump_context *ctx = (void *)dump->cb->ctx;
 	int is_dynamic = entry->type & DPSW_FDB_ENTRY_DINAMIC;
 	u32 portid = NETLINK_CB(dump->cb->skb).portid;
 	u32 seq = dump->cb->nlh->nlmsg_seq;
 	struct nlmsghdr *nlh;
 	struct ndmsg *ndm;
 
-	if (dump->idx < dump->cb->args[2])
+	if (dump->idx < ctx->fdb_idx)
 		goto skip;
 
 	nlh = nlmsg_put(dump->skb, portid, seq, RTM_NEWNEIGH,
diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 558e03301aa8ed89e15c5f37d148a287feaf0018..8d48468cddd7cf91fb49ad23a5c57110900160ef 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -758,12 +758,13 @@ static int ocelot_port_fdb_do_dump(const unsigned char *addr, u16 vid,
 				   bool is_static, void *data)
 {
 	struct ocelot_dump_ctx *dump = data;
+	struct ndo_fdb_dump_context *ctx = (void *)dump->cb->ctx;
 	u32 portid = NETLINK_CB(dump->cb->skb).portid;
 	u32 seq = dump->cb->nlh->nlmsg_seq;
 	struct nlmsghdr *nlh;
 	struct ndmsg *ndm;
 
-	if (dump->idx < dump->cb->args[2])
+	if (dump->idx < ctx->fdb_idx)
 		goto skip;
 
 	nlh = nlmsg_put(dump->skb, portid, seq, RTM_NEWNEIGH,
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b46a799bd3904c4183775cb2e86172a0b127bb4f..2cb33c2cb836cf38b6e03b8a620594aa616f00fa 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1352,6 +1352,7 @@ static int vxlan_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			  struct net_device *dev,
 			  struct net_device *filter_dev, int *idx)
 {
+	struct ndo_fdb_dump_context *ctx = (void *)cb->ctx;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	unsigned int h;
 	int err = 0;
@@ -1364,7 +1365,7 @@ static int vxlan_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			struct vxlan_rdst *rd;
 
 			if (rcu_access_pointer(f->nh)) {
-				if (*idx < cb->args[2])
+				if (*idx < ctx->fdb_idx)
 					goto skip_nh;
 				err = vxlan_fdb_info(skb, vxlan, f,
 						     NETLINK_CB(cb->skb).portid,
@@ -1381,7 +1382,7 @@ static int vxlan_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			}
 
 			list_for_each_entry_rcu(rd, &f->remotes, list) {
-				if (*idx < cb->args[2])
+				if (*idx < ctx->fdb_idx)
 					goto skip;
 
 				err = vxlan_fdb_info(skb, vxlan, f,
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 14b88f55192085def8f318c7913a76d5447b4975..a91dfea64724615c9db778646e52cb8573f47e06 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -178,6 +178,13 @@ void rtnetlink_init(void);
 void __rtnl_unlock(void);
 void rtnl_kfree_skbs(struct sk_buff *head, struct sk_buff *tail);
 
+/* Shared by rtnl_fdb_dump() and various ndo_fdb_dump() helpers. */
+struct ndo_fdb_dump_context {
+	unsigned long s_h;
+	unsigned long s_idx;
+	unsigned long fdb_idx;
+};
+
 extern int ndo_dflt_fdb_dump(struct sk_buff *skb,
 			     struct netlink_callback *cb,
 			     struct net_device *dev,
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 82bac2426631bcea63ea834e72f074fa2eaf0cee..902694c0ce643ec448978e4c4625692ccb1facd9 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -955,6 +955,7 @@ int br_fdb_dump(struct sk_buff *skb,
 		struct net_device *filter_dev,
 		int *idx)
 {
+	struct ndo_fdb_dump_context *ctx = (void *)cb->ctx;
 	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_fdb_entry *f;
 	int err = 0;
@@ -970,7 +971,7 @@ int br_fdb_dump(struct sk_buff *skb,
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(f, &br->fdb_list, fdb_node) {
-		if (*idx < cb->args[2])
+		if (*idx < ctx->fdb_idx)
 			goto skip;
 		if (filter_dev && (!f->dst || f->dst->dev != filter_dev)) {
 			if (filter_dev != dev)
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index ab5f201bf0ab41b463175f501e8560b4d64d9b0a..453cc8bf18fbe0d2ac41fed13576279b4c7a2c07 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4762,15 +4762,16 @@ static int nlmsg_populate_fdb(struct sk_buff *skb,
 			      int *idx,
 			      struct netdev_hw_addr_list *list)
 {
+	struct ndo_fdb_dump_context *ctx = (void *)cb->ctx;
 	struct netdev_hw_addr *ha;
-	int err;
 	u32 portid, seq;
+	int err;
 
 	portid = NETLINK_CB(cb->skb).portid;
 	seq = cb->nlh->nlmsg_seq;
 
 	list_for_each_entry(ha, &list->list, list) {
-		if (*idx < cb->args[2])
+		if (*idx < ctx->fdb_idx)
 			goto skip;
 
 		err = nlmsg_populate_fdb_fill(skb, dev, ha->addr, 0,
@@ -4909,10 +4910,9 @@ static int valid_fdb_dump_legacy(const struct nlmsghdr *nlh,
 
 static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	struct net_device *dev;
-	struct net_device *br_dev = NULL;
-	const struct net_device_ops *ops = NULL;
-	const struct net_device_ops *cops = NULL;
+	const struct net_device_ops *ops = NULL, *cops = NULL;
+	struct ndo_fdb_dump_context *ctx = (void *)cb->ctx;
+	struct net_device *dev, *br_dev = NULL;
 	struct net *net = sock_net(skb->sk);
 	struct hlist_head *head;
 	int brport_idx = 0;
@@ -4922,6 +4922,8 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	int err = 0;
 	int fidx = 0;
 
+	NL_ASSERT_CTX_FITS(struct ndo_fdb_dump_context);
+
 	if (cb->strict_check)
 		err = valid_fdb_dump_strict(cb->nlh, &br_idx, &brport_idx,
 					    cb->extack);
@@ -4939,8 +4941,8 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		ops = br_dev->netdev_ops;
 	}
 
-	s_h = cb->args[0];
-	s_idx = cb->args[1];
+	s_h = ctx->s_h;
+	s_idx = ctx->s_idx;
 
 	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
 		idx = 0;
@@ -4992,7 +4994,7 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 			cops = NULL;
 
 			/* reset fdb offset to 0 for rest of the interfaces */
-			cb->args[2] = 0;
+			ctx->fdb_idx = 0;
 			fidx = 0;
 cont:
 			idx++;
@@ -5000,9 +5002,9 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 out:
-	cb->args[0] = h;
-	cb->args[1] = idx;
-	cb->args[2] = fidx;
+	ctx->s_h = h;
+	ctx->s_idx = idx;
+	ctx->fdb_idx = fidx;
 
 	return skb->len;
 }
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 06c30a9e29ff820d2dd58fb1801d5e76a5928326..c736c019e2af90747738f10b667e6ad936c9eb0b 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -515,12 +515,13 @@ dsa_user_port_fdb_do_dump(const unsigned char *addr, u16 vid,
 			  bool is_static, void *data)
 {
 	struct dsa_user_dump_ctx *dump = data;
+	struct ndo_fdb_dump_context *ctx = (void *)dump->cb->ctx;
 	u32 portid = NETLINK_CB(dump->cb->skb).portid;
 	u32 seq = dump->cb->nlh->nlmsg_seq;
 	struct nlmsghdr *nlh;
 	struct ndmsg *ndm;
 
-	if (dump->idx < dump->cb->args[2])
+	if (dump->idx < ctx->fdb_idx)
 		goto skip;
 
 	nlh = nlmsg_put(dump->skb, portid, seq, RTM_NEWNEIGH,
-- 
2.47.0.338.g60cca15819-goog


