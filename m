Return-Path: <netdev+bounces-167747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4ACA3C0D4
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479A917B689
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1371F1538;
	Wed, 19 Feb 2025 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad+Hio/A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7F1DE89D
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973081; cv=none; b=l0FKYYi9Au1xrJJzDnHVJUdxx6qd+BB6oPNEJHw2jd5k5IXBswuejSvM4UZcM/PYkXBqK+EhHMqpuJmkw33yC5LP7UjF7P3q6NufkA36B6xayIAYpPKp1NUzGll1HswG4eFwA1xNoodAjy8hFaQfkvca99k2sum6ChnDy3Y/Ujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973081; c=relaxed/simple;
	bh=8Z/3Q3fwr5V298lSrJ/NVQvOdiKdH/kG4BkiU8Hj160=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6H6kWTKsY3KO1eSdT8Fk6tarKQnYG/XS9FWXcMIUJMtqmBENVOv+KQbQiTwOdivf8EjKbm31WIFeMfuzmUK0/RFkBjsSNcYe9Cej46aA3RmWUczBeHXwIy6W8ehwcyr63OlSHSRIFUSZnlDqKkjcHK1ikM8wmQS4Q49m0r0Q2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad+Hio/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F05AC19422;
	Wed, 19 Feb 2025 13:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973080;
	bh=8Z/3Q3fwr5V298lSrJ/NVQvOdiKdH/kG4BkiU8Hj160=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ad+Hio/AzZdJCePuqJq3+nfGF1h0k++eOQ7okEKoAYbpSl0j5AKcBqJ47aI0ZSyJY
	 NYO0izA7oFXaBcX45ypsLrQtU5FMsQjCPii/DWO/EpDC580Y8rhsiOU0iUZqQ8pYjz
	 daenCH8FEC2DZpiqbBY+iTrtuqYzfdzfbrx88ytwbBySidS5gIaiHOFImlOCZzWmGS
	 KJCWfv5nSieBlhRFFBwiuucyQ6A8EA6c1Fw/1HaKrAKBRLSkTQ5YR7XUd6aewl8Glu
	 jDHPJHxiZU47MHvsCfnMThGUxAL4y22TIUH0hUfIPNdqu00Fg6+k+sAq3vphfLuXJ8
	 vkiePspUyAt6w==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH ipsec-next v1 1/5] xfrm: delay initialization of offload path till its actually requested
Date: Wed, 19 Feb 2025 15:50:57 +0200
Message-ID: <3a5407283334ffad47a7079f86efdf9f08a0cda7.1739972570.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739972570.git.leon@kernel.org>
References: <cover.1739972570.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

XFRM offload path is probed even if offload isn't needed at all. Let's
make sure that x->type_offload pointer stays NULL for such path to
reduce ambiguity.

Fixes: 9d389d7f84bb ("xfrm: Add a xfrm type offload.")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/xfrm.h     | 11 ++++++++++-
 net/xfrm/xfrm_device.c | 13 ++++++++-----
 net/xfrm/xfrm_state.c  | 32 ++++++++++++++------------------
 net/xfrm/xfrm_user.c   |  2 +-
 4 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index ed4b83696c77..e1eed5d47d07 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -464,6 +464,15 @@ struct xfrm_type_offload {
 
 int xfrm_register_type_offload(const struct xfrm_type_offload *type, unsigned short family);
 void xfrm_unregister_type_offload(const struct xfrm_type_offload *type, unsigned short family);
+void xfrm_set_type_offload(struct xfrm_state *x);
+static inline void xfrm_unset_type_offload(struct xfrm_state *x)
+{
+	if (!x->type_offload)
+		return;
+
+	module_put(x->type_offload->owner);
+	x->type_offload = NULL;
+}
 
 /**
  * struct xfrm_mode_cbs - XFRM mode callbacks
@@ -1760,7 +1769,7 @@ void xfrm_spd_getinfo(struct net *net, struct xfrmk_spdinfo *si);
 u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
 int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack);
 u32 xfrm_state_mtu(struct xfrm_state *x, int mtu);
-int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
+int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
 		      struct netlink_ext_ack *extack);
 int xfrm_init_state(struct xfrm_state *x);
 int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index d1fa94e52cea..97c8030cc417 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -244,11 +244,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 	xfrm_address_t *daddr;
 	bool is_packet_offload;
 
-	if (!x->type_offload) {
-		NL_SET_ERR_MSG(extack, "Type doesn't support offload");
-		return -EINVAL;
-	}
-
 	if (xuo->flags &
 	    ~(XFRM_OFFLOAD_IPV6 | XFRM_OFFLOAD_INBOUND | XFRM_OFFLOAD_PACKET)) {
 		NL_SET_ERR_MSG(extack, "Unrecognized flags in offload request");
@@ -310,6 +305,13 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}
 
+	xfrm_set_type_offload(x);
+	if (!x->type_offload) {
+		NL_SET_ERR_MSG(extack, "Type doesn't support offload");
+		dev_put(dev);
+		return -EINVAL;
+	}
+
 	xso->dev = dev;
 	netdev_tracker_alloc(dev, &xso->dev_tracker, GFP_ATOMIC);
 	xso->real_dev = dev;
@@ -332,6 +334,7 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		netdev_put(dev, &xso->dev_tracker);
 		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
 
+		xfrm_unset_type_offload(x);
 		/* User explicitly requested packet offload mode and configured
 		 * policy in addition to the XFRM state. So be civil to users,
 		 * and return an error instead of taking fallback path.
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ad2202fa82f3..69af5964c886 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -424,18 +424,18 @@ void xfrm_unregister_type_offload(const struct xfrm_type_offload *type,
 }
 EXPORT_SYMBOL(xfrm_unregister_type_offload);
 
-static const struct xfrm_type_offload *
-xfrm_get_type_offload(u8 proto, unsigned short family, bool try_load)
+void xfrm_set_type_offload(struct xfrm_state *x)
 {
 	const struct xfrm_type_offload *type = NULL;
 	struct xfrm_state_afinfo *afinfo;
+	bool try_load = true;
 
 retry:
-	afinfo = xfrm_state_get_afinfo(family);
+	afinfo = xfrm_state_get_afinfo(x->props.family);
 	if (unlikely(afinfo == NULL))
-		return NULL;
+		goto out;
 
-	switch (proto) {
+	switch (x->id.proto) {
 	case IPPROTO_ESP:
 		type = afinfo->type_offload_esp;
 		break;
@@ -449,18 +449,16 @@ xfrm_get_type_offload(u8 proto, unsigned short family, bool try_load)
 	rcu_read_unlock();
 
 	if (!type && try_load) {
-		request_module("xfrm-offload-%d-%d", family, proto);
+		request_module("xfrm-offload-%d-%d", x->props.family,
+			       x->id.proto);
 		try_load = false;
 		goto retry;
 	}
 
-	return type;
-}
-
-static void xfrm_put_type_offload(const struct xfrm_type_offload *type)
-{
-	module_put(type->owner);
+out:
+	x->type_offload = type;
 }
+EXPORT_SYMBOL(xfrm_set_type_offload);
 
 static const struct xfrm_mode xfrm4_mode_map[XFRM_MODE_MAX] = {
 	[XFRM_MODE_BEET] = {
@@ -609,8 +607,6 @@ static void ___xfrm_state_destroy(struct xfrm_state *x)
 	kfree(x->coaddr);
 	kfree(x->replay_esn);
 	kfree(x->preplay_esn);
-	if (x->type_offload)
-		xfrm_put_type_offload(x->type_offload);
 	if (x->type) {
 		x->type->destructor(x);
 		xfrm_put_type(x->type);
@@ -784,6 +780,8 @@ void xfrm_dev_state_free(struct xfrm_state *x)
 	struct xfrm_dev_offload *xso = &x->xso;
 	struct net_device *dev = READ_ONCE(xso->dev);
 
+	xfrm_unset_type_offload(x);
+
 	if (dev && dev->xfrmdev_ops) {
 		spin_lock_bh(&xfrm_state_dev_gc_lock);
 		if (!hlist_unhashed(&x->dev_gclist))
@@ -3122,7 +3120,7 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 }
 EXPORT_SYMBOL_GPL(xfrm_state_mtu);
 
-int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
+int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
 		      struct netlink_ext_ack *extack)
 {
 	const struct xfrm_mode *inner_mode;
@@ -3178,8 +3176,6 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
 		goto error;
 	}
 
-	x->type_offload = xfrm_get_type_offload(x->id.proto, family, offload);
-
 	err = x->type->init_state(x, extack);
 	if (err)
 		goto error;
@@ -3229,7 +3225,7 @@ int xfrm_init_state(struct xfrm_state *x)
 {
 	int err;
 
-	err = __xfrm_init_state(x, true, false, NULL);
+	err = __xfrm_init_state(x, true, NULL);
 	if (!err)
 		x->km.state = XFRM_STATE_VALID;
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 08c6d6f0179f..82a768500999 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -907,7 +907,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 			goto error;
 	}
 
-	err = __xfrm_init_state(x, false, attrs[XFRMA_OFFLOAD_DEV], extack);
+	err = __xfrm_init_state(x, false, extack);
 	if (err)
 		goto error;
 
-- 
2.48.1


