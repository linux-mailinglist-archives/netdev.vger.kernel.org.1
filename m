Return-Path: <netdev+bounces-114845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C84E94461B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AECF1C22354
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF33916DECD;
	Thu,  1 Aug 2024 08:03:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0211716B38E
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499415; cv=none; b=dzII5FDC/2WDNQ5LPZlHvXOPDtVqjJwl+nhW6gffWGRssC7JLdKs4l7Lay0xdIzcOSEWjhkt4rp5aSodGC6Ay2oa1rZ+5TSTh5pHpVgJ8AZ+s0ZGDHydmvUUl8pERbghE53yUOT6/nxBKUiQMJUnx8KGY7c2vBzZ++FjeIHi6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499415; c=relaxed/simple;
	bh=IdFwwEv9TUQfzohSJafvxgFW5cIu0zaNcVFMlDIgsgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzXcI8Ym+lHhtP1NHAtKH6DpAPHmySizJPQtJz9lA0L84+Hqc9Ja8oEYDkE6FPlPa7ID5PFt8Q9TOwnuNwlv1vVFzqf36Nt/i76SP4UEYUYkZpgbFuGpxh2B4HRNGcHEWnFFiYASHpNKg9UUSVTTEKtFL7t063S+pi+bmIw5Swg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 2E32D7D125;
	Thu,  1 Aug 2024 08:03:33 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v7 05/16] xfrm: add mode_cbs module functionality
Date: Thu,  1 Aug 2024 04:03:03 -0400
Message-ID: <20240801080314.169715-6-chopps@chopps.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240801080314.169715-1-chopps@chopps.org>
References: <20240801080314.169715-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Add a set of callbacks xfrm_mode_cbs to xfrm_state. These callbacks
enable the addition of new xfrm modes, such as IP-TFS to be defined
in modules.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 include/net/xfrm.h     | 43 +++++++++++++++++++++++++++++++++++++
 net/xfrm/xfrm_device.c |  3 ++-
 net/xfrm/xfrm_input.c  | 18 ++++++++++++++--
 net/xfrm/xfrm_output.c |  2 ++
 net/xfrm/xfrm_policy.c | 18 ++++++++++------
 net/xfrm/xfrm_state.c  | 48 ++++++++++++++++++++++++++++++++++++++++++
 net/xfrm/xfrm_user.c   | 13 ++++++++++++
 7 files changed, 135 insertions(+), 10 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 54cef89f6c1e..323e768ce4f3 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -209,6 +209,7 @@ struct xfrm_state {
 		u16		family;
 		xfrm_address_t	saddr;
 		int		header_len;
+		int		enc_hdr_len;
 		int		trailer_len;
 		u32		extra_flags;
 		struct xfrm_mark	smark;
@@ -299,6 +300,9 @@ struct xfrm_state {
 	 * interpreted by xfrm_type methods. */
 	void			*data;
 	u8			dir;
+
+	const struct xfrm_mode_cbs	*mode_cbs;
+	void				*mode_data;
 };
 
 static inline struct net *xs_net(struct xfrm_state *x)
@@ -451,6 +455,45 @@ struct xfrm_type_offload {
 int xfrm_register_type_offload(const struct xfrm_type_offload *type, unsigned short family);
 void xfrm_unregister_type_offload(const struct xfrm_type_offload *type, unsigned short family);
 
+/**
+ * struct xfrm_mode_cbs - XFRM mode callbacks
+ * @owner: module owner or NULL
+ * @create_state: Add mode specific state to new `xfrm_state *x`
+ * @delete_state: Cleanup mode specific state from `xfrm_state *x`
+ * @user_init: Process mode specific netlink attributes from user
+ * @copy_to_user: Add netlink attributes to `attrs` based on state in `x`
+ * @clone: Copy mode specific values from `orig` to new state `x`
+ * @sa_len: Return space required to store mode specific netlink attributes
+ * @get_inner_mtu: Return avail payload space after removing encap overhead
+ * @input: Process received packet from SA using mode
+ * @output: Output given packet using mode
+ * @prepare_output: Add mode specific encapsulation to packet in skb. On return
+ *	`transport_header` should point at ESP header, `network_header` should
+ *	point at outer IP header and `mac_header` should opint at the
+ *	protocol/nexthdr field of the outer IP.
+ *
+ * One should examine and understand the specific uses of these callbacks in
+ * xfrm for further detail on how and when these functions are called. RTSL.
+ */
+struct xfrm_mode_cbs {
+	struct module	*owner;
+	int	(*create_state)(struct xfrm_state *x);
+	void	(*delete_state)(struct xfrm_state *x);
+	int	(*user_init)(struct net *net, struct xfrm_state *x,
+			     struct nlattr **attrs,
+			     struct netlink_ext_ack *extack);
+	int	(*copy_to_user)(struct xfrm_state *x, struct sk_buff *skb);
+	int     (*clone)(struct xfrm_state *x, struct xfrm_state *orig);
+	unsigned int (*sa_len)(const struct xfrm_state *x);
+	u32	(*get_inner_mtu)(struct xfrm_state *x, int outer_mtu);
+	int	(*input)(struct xfrm_state *x, struct sk_buff *skb);
+	int	(*output)(struct net *net, struct sock *sk, struct sk_buff *skb);
+	int	(*prepare_output)(struct xfrm_state *x, struct sk_buff *skb);
+};
+
+int xfrm_register_mode_cbs(u8 mode, const struct xfrm_mode_cbs *mode_cbs);
+void xfrm_unregister_mode_cbs(u8 mode);
+
 static inline int xfrm_af2proto(unsigned int family)
 {
 	switch(family) {
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 9a44d363ba62..e412e4afb169 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -42,7 +42,8 @@ static void __xfrm_mode_tunnel_prep(struct xfrm_state *x, struct sk_buff *skb,
 		skb->transport_header = skb->network_header + hsize;
 
 	skb_reset_mac_len(skb);
-	pskb_pull(skb, skb->mac_len + x->props.header_len);
+	pskb_pull(skb,
+		  skb->mac_len + x->props.header_len - x->props.enc_hdr_len);
 }
 
 static void __xfrm_mode_beet_prep(struct xfrm_state *x, struct sk_buff *skb,
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 749e7eea99e4..b7b5cda986fb 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -446,6 +446,9 @@ static int xfrm_inner_mode_input(struct xfrm_state *x,
 		WARN_ON_ONCE(1);
 		break;
 	default:
+		if (x->mode_cbs && x->mode_cbs->input)
+			return x->mode_cbs->input(x, skb);
+
 		WARN_ON_ONCE(1);
 		break;
 	}
@@ -453,6 +456,10 @@ static int xfrm_inner_mode_input(struct xfrm_state *x,
 	return -EOPNOTSUPP;
 }
 
+/* NOTE: encap_type - In addition to the normal (non-negative) values for
+ * encap_type, a negative value of -1 or -2 can be used to resume/restart this
+ * function after a previous invocation early terminated for async operation.
+ */
 int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 {
 	const struct xfrm_state_afinfo *afinfo;
@@ -489,6 +496,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		family = x->props.family;
 
+		/* An encap_type of -2 indicates reconstructed inner packet */
+		if (encap_type == -2)
+			goto resume_decapped;
+
 		/* An encap_type of -1 indicates async resumption. */
 		if (encap_type == -1) {
 			async = 1;
@@ -679,11 +690,14 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		XFRM_MODE_SKB_CB(skb)->protocol = nexthdr;
 
-		if (xfrm_inner_mode_input(x, skb)) {
+		err = xfrm_inner_mode_input(x, skb);
+		if (err == -EINPROGRESS)
+			return 0;
+		else if (err) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMODEERROR);
 			goto drop;
 		}
-
+resume_decapped:
 		if (x->outer_mode.flags & XFRM_MODE_FLAG_TUNNEL) {
 			decaps = 1;
 			break;
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index e5722c95b8bb..ef81359e4038 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -472,6 +472,8 @@ static int xfrm_outer_mode_output(struct xfrm_state *x, struct sk_buff *skb)
 		WARN_ON_ONCE(1);
 		break;
 	default:
+		if (x->mode_cbs && x->mode_cbs->prepare_output)
+			return x->mode_cbs->prepare_output(x, skb);
 		WARN_ON_ONCE(1);
 		break;
 	}
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c56c61b0c12e..f764b1409175 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2719,13 +2719,17 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 
 		dst1->input = dst_discard;
 
-		rcu_read_lock();
-		afinfo = xfrm_state_afinfo_get_rcu(inner_mode->family);
-		if (likely(afinfo))
-			dst1->output = afinfo->output;
-		else
-			dst1->output = dst_discard_out;
-		rcu_read_unlock();
+		if (xfrm[i]->mode_cbs && xfrm[i]->mode_cbs->output) {
+			dst1->output = xfrm[i]->mode_cbs->output;
+		} else {
+			rcu_read_lock();
+			afinfo = xfrm_state_afinfo_get_rcu(inner_mode->family);
+			if (likely(afinfo))
+				dst1->output = afinfo->output;
+			else
+				dst1->output = dst_discard_out;
+			rcu_read_unlock();
+		}
 
 		xdst_prev = xdst;
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 37478d36a8df..6428b48c6764 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -515,6 +515,36 @@ static const struct xfrm_mode *xfrm_get_mode(unsigned int encap, int family)
 	return NULL;
 }
 
+static const struct xfrm_mode_cbs *xfrm_mode_cbs_map[XFRM_MODE_MAX];
+
+int xfrm_register_mode_cbs(u8 mode, const struct xfrm_mode_cbs *mode_cbs)
+{
+	if (mode >= XFRM_MODE_MAX)
+		return -EINVAL;
+
+	xfrm_mode_cbs_map[mode] = mode_cbs;
+	return 0;
+}
+EXPORT_SYMBOL(xfrm_register_mode_cbs);
+
+void xfrm_unregister_mode_cbs(u8 mode)
+{
+	if (mode >= XFRM_MODE_MAX)
+		return;
+
+	xfrm_mode_cbs_map[mode] = NULL;
+}
+EXPORT_SYMBOL(xfrm_unregister_mode_cbs);
+
+static const struct xfrm_mode_cbs *xfrm_get_mode_cbs(u8 mode)
+{
+	if (mode >= XFRM_MODE_MAX)
+		return NULL;
+	if (mode == XFRM_MODE_IPTFS && !xfrm_mode_cbs_map[mode])
+		request_module("xfrm-iptfs");
+	return xfrm_mode_cbs_map[mode];
+}
+
 void xfrm_state_free(struct xfrm_state *x)
 {
 	kmem_cache_free(xfrm_state_cache, x);
@@ -523,6 +553,8 @@ EXPORT_SYMBOL(xfrm_state_free);
 
 static void ___xfrm_state_destroy(struct xfrm_state *x)
 {
+	if (x->mode_cbs && x->mode_cbs->delete_state)
+		x->mode_cbs->delete_state(x);
 	hrtimer_cancel(&x->mtimer);
 	del_timer_sync(&x->rtimer);
 	kfree(x->aead);
@@ -680,6 +712,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		x->replay_maxage = 0;
 		x->replay_maxdiff = 0;
 		spin_lock_init(&x->lock);
+		x->mode_data = NULL;
 	}
 	return x;
 }
@@ -1806,6 +1839,12 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
 	x->new_mapping_sport = 0;
 	x->dir = orig->dir;
 
+	x->mode_cbs = orig->mode_cbs;
+	if (x->mode_cbs && x->mode_cbs->clone) {
+		if (x->mode_cbs->clone(x, orig))
+			goto error;
+	}
+
 	return x;
 
  error:
@@ -2845,6 +2884,9 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 	case XFRM_MODE_TUNNEL:
 		break;
 	default:
+		if (x->mode_cbs && x->mode_cbs->get_inner_mtu)
+			return x->mode_cbs->get_inner_mtu(x, mtu);
+
 		WARN_ON_ONCE(1);
 		break;
 	}
@@ -2945,6 +2987,12 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
 		}
 	}
 
+	x->mode_cbs = xfrm_get_mode_cbs(x->props.mode);
+	if (x->mode_cbs && x->mode_cbs->create_state) {
+		err = x->mode_cbs->create_state(x);
+		if (err)
+			goto error;
+	}
 error:
 	return err;
 }
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index f6ed019192f3..419bbeea6b20 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -918,6 +918,12 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 			goto error;
 	}
 
+	if (x->mode_cbs && x->mode_cbs->user_init) {
+		err = x->mode_cbs->user_init(net, x, attrs, extack);
+		if (err)
+			goto error;
+	}
+
 	return x;
 
 error:
@@ -1331,6 +1337,10 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
 		if (ret)
 			goto out;
 	}
+	if (x->mode_cbs && x->mode_cbs->copy_to_user)
+		ret = x->mode_cbs->copy_to_user(x, skb);
+	if (ret)
+		goto out;
 	if (x->mapping_maxage) {
 		ret = nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapping_maxage);
 		if (ret)
@@ -3540,6 +3550,9 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 	if (x->nat_keepalive_interval)
 		l += nla_total_size(sizeof(x->nat_keepalive_interval));
 
+	if (x->mode_cbs && x->mode_cbs->sa_len)
+		l += x->mode_cbs->sa_len(x);
+
 	return l;
 }
 
-- 
2.46.0


