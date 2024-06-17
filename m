Return-Path: <netdev+bounces-104258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C3D90BC6D
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 22:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E861F21D93
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FF8199241;
	Mon, 17 Jun 2024 20:54:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5771A1990A8
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657662; cv=none; b=iykZOK6+CKPZAjtsK3RoxQ+/coNV+0JwKMG1IbJnM7TbclPHTQH0Goy+JRdmorkChiZpJOtuzFMvsva7j1uZli6KBqKQvonmZF+2AzZnlvrswhaKUGer5E61eFkLmgnPlQjVeKHVXXJLApYlMyQyjjEqyQG2g4TCMxuoPy9JEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657662; c=relaxed/simple;
	bh=c+XvZSFybbO+JSKwWl/paiMX31tasAgAnvgd2oopo+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipapy/Ipj4DOcppAcZlR5/Z7TbFpeYPT+xvOU8axRvMoL7tGYqk+ILjTx2aEvIjj/WFfpCMo5mnJR5e9Cywoc6DK1x2LYDQDFfILyXaYpTv7a5lEGF+sH/+yAcQ1qKAu3+iHEh6HbAWFbEfCLK/JP0wPX3vG3ldQI0bVBIWJGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.big (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id C1D087D126;
	Mon, 17 Jun 2024 20:54:20 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v4 06/18] xfrm: add mode_cbs module functionality
Date: Mon, 17 Jun 2024 16:53:04 -0400
Message-ID: <20240617205316.939774-7-chopps@chopps.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617205316.939774-1-chopps@chopps.org>
References: <20240617205316.939774-1-chopps@chopps.org>
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
 include/net/xfrm.h     | 39 ++++++++++++++++++++++++++++++++++
 net/xfrm/xfrm_device.c |  3 ++-
 net/xfrm/xfrm_input.c  | 14 ++++++++++--
 net/xfrm/xfrm_output.c |  2 ++
 net/xfrm/xfrm_policy.c | 18 ++++++++++------
 net/xfrm/xfrm_state.c  | 48 ++++++++++++++++++++++++++++++++++++++++++
 net/xfrm/xfrm_user.c   | 13 ++++++++++++
 7 files changed, 127 insertions(+), 10 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 7c9be06f8302..cb75ec2993bf 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -206,6 +206,7 @@ struct xfrm_state {
 		u16		family;
 		xfrm_address_t	saddr;
 		int		header_len;
+		int		enc_hdr_len;
 		int		trailer_len;
 		u32		extra_flags;
 		struct xfrm_mark	smark;
@@ -292,6 +293,9 @@ struct xfrm_state {
 	 * interpreted by xfrm_type methods. */
 	void			*data;
 	u8			dir;
+
+	const struct xfrm_mode_cbs	*mode_cbs;
+	void				*mode_data;
 };
 
 static inline struct net *xs_net(struct xfrm_state *x)
@@ -444,6 +448,41 @@ struct xfrm_type_offload {
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
+			     struct nlattr **attrs,
+			     struct netlink_ext_ack *extack);
+	int	(*copy_to_user)(struct xfrm_state *x, struct sk_buff *skb);
+	int     (*clone)(struct xfrm_state *x, struct xfrm_state *orig);
+	unsigned int (*sa_len)(const struct xfrm_state *x);
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
index 2455a76a1cff..f91b2bee8190 100644
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
index 71b42de6e3c9..8ef1af2d39bf 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -438,6 +438,9 @@ static int xfrm_inner_mode_input(struct xfrm_state *x,
 		WARN_ON_ONCE(1);
 		break;
 	default:
+		if (x->mode_cbs && x->mode_cbs->input)
+			return x->mode_cbs->input(x, skb);
+
 		WARN_ON_ONCE(1);
 		break;
 	}
@@ -485,6 +488,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		family = x->props.family;
 
+		/* An encap_type of -3 indicates reconstructed inner packet */
+		if (encap_type == -3)
+			goto resume_decapped;
+
 		/* An encap_type of -1 indicates async resumption. */
 		if (encap_type == -1) {
 			async = 1;
@@ -672,11 +679,14 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
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
index 298b3a9eb48d..a3b50e8bc85a 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2721,13 +2721,17 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 
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
index 649bb739df0d..e9ea5c5dd183 100644
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
@@ -678,6 +710,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		x->replay_maxage = 0;
 		x->replay_maxdiff = 0;
 		spin_lock_init(&x->lock);
+		x->mode_data = NULL;
 	}
 	return x;
 }
@@ -1747,6 +1780,12 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
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
@@ -2786,6 +2825,9 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 	case XFRM_MODE_TUNNEL:
 		break;
 	default:
+		if (x->mode_cbs && x->mode_cbs->get_inner_mtu)
+			return x->mode_cbs->get_inner_mtu(x, mtu);
+
 		WARN_ON_ONCE(1);
 		break;
 	}
@@ -2871,6 +2913,12 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
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
index 6537bd520363..dfd52637abed 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -914,6 +914,12 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
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
@@ -1327,6 +1333,10 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
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
@@ -3526,6 +3536,9 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 	if (x->dir)
 		l += nla_total_size(sizeof(x->dir));
 
+	if (x->mode_cbs && x->mode_cbs->sa_len)
+		l += x->mode_cbs->sa_len(x);
+
 	return l;
 }
 
-- 
2.45.2


