Return-Path: <netdev+bounces-149900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 801049E80FD
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 17:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36361281F05
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BA314D2AC;
	Sat,  7 Dec 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SzHhbCpJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273FB14C5AA
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733588582; cv=none; b=ZW7ZztD/QgbMrwkAJdm2iMkBK/f+qkNwmkqZJGzCGGFz4gPYWFiAjZbZRInNIe5ZzIaCSgdcTO4IKAWEsnLKZ66fYpKB70L+v7rIRZ+1towWtNI+V5gbQHGacA4o6u5aCInoihUPfdhPTI+BS76xfXxwMqVNr60Aff46YGpsfGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733588582; c=relaxed/simple;
	bh=mcuxVimTDVFaBUeaYQS0aykEsC4nm5KfQqOK3SnWKCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CaioE3SOgzd3dfj78wFmI0evgIsah9r1vV+EPHeOfkujTgamQJadgee5YkwVcRbhWYU6oLJRtiFATZd+OGBi7e3XBJwajiS85heHm8Mr3jokXk6rFoR2KL+99Ii6DePLZfNR5jJ/xqQxz/dGhS/sl/f/a6oTtT1bLPe/xEKI5XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SzHhbCpJ; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-466b72ca44eso43360441cf.0
        for <netdev@vger.kernel.org>; Sat, 07 Dec 2024 08:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733588578; x=1734193378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6QRTawL+6Yqt9YzIX1HcIs3HxK3NWFqJyLbSHBWQpAY=;
        b=SzHhbCpJgVN0wbxXwTsdeNcSaFanbkcVsfkZk2H0/ffo4EOKbFKAbtVr2JYCiOYEoP
         G4MNLcHwdnfDzTu7q57iT/cgwvd+HsNsT44DZnPOLTUGMHvDO59Zi12iZPWdU3D22gOq
         d6xjYs7+0XOMk4ilqO7W22o7bk3qVZAr15ogEEWozSAgj9V83M9WKF5GDeeX3Gf28qu/
         qw+mPIYtChtwORPQOpv5ypSvPUwJM/7biGo6EJKb1feSgTG0teU7a+3Iav/WAHmsR/xD
         AAaPfJPP1Uzmb+WXkvYAvv2CwLyci787OAntNaQVpyxOq+ISZGqtSzC+dBZmarXzR/gz
         1Ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733588578; x=1734193378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QRTawL+6Yqt9YzIX1HcIs3HxK3NWFqJyLbSHBWQpAY=;
        b=L/aLPbmP8JzJao6SZeJ1JgVOG3WXe5bbCGH+hgmFQ68Mi/jMuFWA2Z8j0SuGdKMKQt
         w7pLIkfSWxFaeQ3XyEZi8Eh1aVpUcrqvb20AH2mGYbCh1Sa8lTbsH86qK9ws9icGH+UW
         zTRJ3u2PlDcNYUy/92Pwm2ua7j+QlCHUNDQqWe5pKnICroMQl2UPvLjM3ha+3dDFGE4l
         s9X7zW6AuWg9Pn6jxUz7W+x3aHYevdTxxisHbjDEhG5ExiZQO3xWN/p09eaxCGVo1blC
         8f5ETeKmpOwbsptQN9vuP9GybPx/74PyLL8kaZLTwOsq42Vy8UaPX/mUEI+1ewUkEH+0
         iaxQ==
X-Gm-Message-State: AOJu0YxkPCc8kCADm4/V+JsUZNJmpKbg1+I4ujjNSQJskvtVasNXLFKo
	5yUOW+UkXLCij+6s4j68JQ24Mc11QJT3bpJInZi5Pim+QZIhi7/3Ul8RRTuzHd+UVOBDmrdl0+/
	QogmOIWYUGQ==
X-Google-Smtp-Source: AGHT+IENcFd1S9aLJ6rnsWr9MY9ihlMhIypdmxNO0B018J2m4HXtjXFufj+60QuamfxUwbdvhe6J5NjCd0fmgQ==
X-Received: from qtben8.prod.google.com ([2002:a05:622a:5408:b0:466:975f:b220])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:8e07:b0:467:4f0a:1b5d with SMTP id d75a77b69052e-4674f0a7a43mr28158721cf.42.1733588578056;
 Sat, 07 Dec 2024 08:22:58 -0800 (PST)
Date: Sat,  7 Dec 2024 16:22:46 +0000
In-Reply-To: <20241207162248.18536-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241207162248.18536-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241207162248.18536-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] rtnetlink: add ndo_fdb_dump_context
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Roopa Prabhu <roopa@nvidia.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

rtnl_fdb_dump() and various ndo_fdb_dump() helpers share
a hidden layout of cb->ctx.

Before switching rtnl_fdb_dump() to for_each_netdev_dump()
in the following patch, make this more explicit.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   |  3 ++-
 drivers/net/ethernet/mscc/ocelot_net.c        |  3 ++-
 drivers/net/vxlan/vxlan_core.c                |  5 ++--
 include/linux/rtnetlink.h                     |  7 ++++++
 net/bridge/br_fdb.c                           |  3 ++-
 net/core/rtnetlink.c                          | 24 +++++++++----------
 net/dsa/user.c                                |  3 ++-
 7 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index a293b08f36d46dfde7e25412951da78c15e2dfd6..de383e6c6d523f01f02cb3c3977b1c448a3ac9a7 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -781,12 +781,13 @@ static int dpaa2_switch_fdb_dump_nl(struct fdb_dump_entry *entry,
 				    struct ethsw_dump_ctx *dump)
 {
 	int is_dynamic = entry->type & DPSW_FDB_ENTRY_DINAMIC;
+	struct ndo_fdb_dump_context *ctx = (void *)dump->cb->ctx;
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
index ab5f201bf0ab41b463175f501e8560b4d64d9b0a..02791328102e7590465aab9ab949af093721b256 100644
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
@@ -4939,8 +4939,8 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		ops = br_dev->netdev_ops;
 	}
 
-	s_h = cb->args[0];
-	s_idx = cb->args[1];
+	s_h = ctx->s_h;
+	s_idx = ctx->s_idx;
 
 	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
 		idx = 0;
@@ -4992,7 +4992,7 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 			cops = NULL;
 
 			/* reset fdb offset to 0 for rest of the interfaces */
-			cb->args[2] = 0;
+			ctx->fdb_idx = 0;
 			fidx = 0;
 cont:
 			idx++;
@@ -5000,9 +5000,9 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
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


