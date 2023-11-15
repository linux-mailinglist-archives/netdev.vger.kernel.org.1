Return-Path: <netdev+bounces-47281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C907E95C5
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 04:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36031F211A8
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 03:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012A91172F;
	Mon, 13 Nov 2023 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776C08F42
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 03:54:04 +0000 (UTC)
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9272A1980
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 19:54:02 -0800 (PST)
Received: from labnh.int.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 40D607D12B;
	Mon, 13 Nov 2023 03:54:01 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [RFC ipsec-next v2 6/8] iptfs: xfrm: Add mode_cbs module functionality
Date: Sun, 12 Nov 2023 22:52:17 -0500
Message-ID: <20231113035219.920136-7-chopps@chopps.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231113035219.920136-1-chopps@chopps.org>
References: <20231113035219.920136-1-chopps@chopps.org>
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
 include/net/xfrm.h     | 36 ++++++++++++++++++++++++++++++++++++
 net/xfrm/xfrm_device.c |  3 ++-
 net/xfrm/xfrm_input.c  | 14 ++++++++++++--
 net/xfrm/xfrm_output.c |  9 +++++++--
 net/xfrm/xfrm_policy.c | 18 +++++++++++-------
 net/xfrm/xfrm_state.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 net/xfrm/xfrm_user.c   | 10 ++++++++++
 7 files changed, 119 insertions(+), 12 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index d2e87344d175..aeeadadc9545 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -204,6 +204,7 @@ struct xfrm_state {
 		u16		family;
 		xfrm_address_t	saddr;
 		int		header_len;
+		int		enc_hdr_len;
 		int		trailer_len;
 		u32		extra_flags;
 		struct xfrm_mark	smark;
@@ -289,6 +290,9 @@ struct xfrm_state {
 	/* Private data of this transformer, format is opaque,
 	 * interpreted by xfrm_type methods. */
 	void			*data;
+
+	const struct xfrm_mode_cbs	*mode_cbs;
+	void				*mode_data;
 };
 
 static inline struct net *xs_net(struct xfrm_state *x)
@@ -441,6 +445,38 @@ struct xfrm_type_offload {
 int xfrm_register_type_offload(const struct xfrm_type_offload *type, unsigned short family);
 void xfrm_unregister_type_offload(const struct xfrm_type_offload *type, unsigned short family);
 
+struct xfrm_mode_cbs {
+	struct module	*owner;
+	/* Add/delete state in the new xfrm_state in `x`. */
+	int	(*create_state)(struct xfrm_state *x);
+	void	(*delete_state)(struct xfrm_state *x);
+
+	/* Called while handling the user netlink options. */
+	int	(*user_init)(struct net *net, struct xfrm_state *x,
+			     struct nlattr **attrs);
+	int	(*copy_to_user)(struct xfrm_state *x, struct sk_buff *skb);
+
+	u32	(*get_inner_mtu)(struct xfrm_state *x, int outer_mtu);
+
+	/* Called to handle received xfrm (egress) packets. */
+	int	(*input)(struct xfrm_state *x, struct sk_buff *skb);
+
+	/* Placed in dst_output of the dst when an xfrm_state is bound. */
+	int	(*output)(struct net *net, struct sock *sk, struct sk_buff *skb);
+
+	/**
+	 * Prepare the skb for output for the given mode. Returns:
+	 *    Error value, if 0 then skb values should be as follows:
+	 *    transport_header should point at ESP header
+	 *    network_header should point at Outer IP header
+	 *    mac_header should point at protocol/nexthdr of the outer IP
+	 */
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
index 3784534c9185..8b848540ea47 100644
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
index bd4ce21d76d7..824f7b7f90e0 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -437,6 +437,9 @@ static int xfrm_inner_mode_input(struct xfrm_state *x,
 		WARN_ON_ONCE(1);
 		break;
 	default:
+		if (x->mode_cbs && x->mode_cbs->input)
+			return x->mode_cbs->input(x, skb);
+
 		WARN_ON_ONCE(1);
 		break;
 	}
@@ -479,6 +482,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		family = x->props.family;
 
+		/* An encap_type of -3 indicates reconstructed inner packet */
+		if (encap_type == -3)
+			goto resume_decapped;
+
 		/* An encap_type of -1 indicates async resumption. */
 		if (encap_type == -1) {
 			async = 1;
@@ -660,11 +667,14 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
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
index 662c83beb345..4390c111410d 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -280,7 +280,9 @@ static int xfrm4_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
 	skb_set_inner_network_header(skb, skb_network_offset(skb));
 	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
 
-	skb_set_network_header(skb, -x->props.header_len);
+	/* backup to add space for the outer encap */
+	skb_set_network_header(skb,
+			       -x->props.header_len + x->props.enc_hdr_len);
 	skb->mac_header = skb->network_header +
 			  offsetof(struct iphdr, protocol);
 	skb->transport_header = skb->network_header + sizeof(*top_iph);
@@ -325,7 +327,8 @@ static int xfrm6_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
 	skb_set_inner_network_header(skb, skb_network_offset(skb));
 	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
 
-	skb_set_network_header(skb, -x->props.header_len);
+	skb_set_network_header(skb,
+			       -x->props.header_len + x->props.enc_hdr_len);
 	skb->mac_header = skb->network_header +
 			  offsetof(struct ipv6hdr, nexthdr);
 	skb->transport_header = skb->network_header + sizeof(*top_iph);
@@ -472,6 +475,8 @@ static int xfrm_outer_mode_output(struct xfrm_state *x, struct sk_buff *skb)
 		WARN_ON_ONCE(1);
 		break;
 	default:
+		if (x->mode_cbs->prepare_output)
+			return x->mode_cbs->prepare_output(x, skb);
 		WARN_ON_ONCE(1);
 		break;
 	}
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index d2dddc570f4f..3220b01121f3 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2707,13 +2707,17 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 
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
index bda5327bf34d..f5e1a17ebf74 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -513,6 +513,36 @@ static const struct xfrm_mode *xfrm_get_mode(unsigned int encap, int family)
 	return NULL;
 }
 
+static struct xfrm_mode_cbs xfrm_mode_cbs_map[XFRM_MODE_MAX];
+
+int xfrm_register_mode_cbs(u8 mode, const struct xfrm_mode_cbs *mode_cbs)
+{
+	if (mode >= XFRM_MODE_MAX)
+		return -EINVAL;
+
+	xfrm_mode_cbs_map[mode] = *mode_cbs;
+	return 0;
+}
+EXPORT_SYMBOL(xfrm_register_mode_cbs);
+
+void xfrm_unregister_mode_cbs(u8 mode)
+{
+	if (mode >= XFRM_MODE_MAX)
+		return;
+
+	memset(&xfrm_mode_cbs_map[mode], 0, sizeof(xfrm_mode_cbs_map[mode]));
+}
+EXPORT_SYMBOL(xfrm_unregister_mode_cbs);
+
+static const struct xfrm_mode_cbs *xfrm_get_mode_cbs(u8 mode)
+{
+	if (mode >= XFRM_MODE_MAX)
+		return NULL;
+	if (mode == XFRM_MODE_IPTFS && !xfrm_mode_cbs_map[mode].create_state)
+		request_module("xfrm-iptfs");
+	return &xfrm_mode_cbs_map[mode];
+}
+
 void xfrm_state_free(struct xfrm_state *x)
 {
 	kmem_cache_free(xfrm_state_cache, x);
@@ -521,6 +551,8 @@ EXPORT_SYMBOL(xfrm_state_free);
 
 static void ___xfrm_state_destroy(struct xfrm_state *x)
 {
+	if (x->mode_cbs && x->mode_cbs->delete_state)
+		x->mode_cbs->delete_state(x);
 	hrtimer_cancel(&x->mtimer);
 	del_timer_sync(&x->rtimer);
 	kfree(x->aead);
@@ -2765,6 +2797,9 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 	case XFRM_MODE_TUNNEL:
 		break;
 	default:
+		if (x->mode_cbs && x->mode_cbs->get_inner_mtu)
+			return x->mode_cbs->get_inner_mtu(x, mtu);
+
 		WARN_ON_ONCE(1);
 		break;
 	}
@@ -2850,6 +2885,12 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
 			goto error;
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
index fa2059de51f5..795da945fbc2 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -779,6 +779,12 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 			goto error;
 	}
 
+	if (x->mode_cbs && x->mode_cbs->user_init) {
+		err = x->mode_cbs->user_init(net, x, attrs);
+		if (err)
+			goto error;
+	}
+
 	return x;
 
 error:
@@ -1192,6 +1198,10 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
 		if (ret)
 			goto out;
 	}
+	if (x->mode_cbs && x->mode_cbs->copy_to_user)
+		ret = x->mode_cbs->copy_to_user(x, skb);
+	if (ret)
+		goto out;
 	if (x->mapping_maxage)
 		ret = nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapping_maxage);
 out:
-- 
2.42.0


