Return-Path: <netdev+bounces-72848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF31C859EF7
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C429D1C2251E
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A962E224C9;
	Mon, 19 Feb 2024 08:59:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5002822F00
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333169; cv=none; b=LHuKeJxVX1o3tsHdT7lZ2iBqxXJ4gFcnKE90aWPCmifMpfdjQbXG/r8t+l8j0k4E+giiUSqnEA5SOH64PRBd+IfdkC1qVJGMREntoKolk+gUwwjZpeZNmvMGkgIHjxHeTN3M5XrZQ5T6mW61OuUSnLXeqfSMEPsWUCnanD4TBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333169; c=relaxed/simple;
	bh=TYty0GOOkST36GgQXjAwBBRMREHJrsv7hqIt7oxyI7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtUfJHKtMB8bG8uRGExX8PkzKhhjNPhcSGWTUnVSCoQoMb58SNxz9ZWG1uLTMtXugdizU5+lp0jraA2J+R2P384MFP27ww5kRlj01KINhcBZmAYXhbOG3iCCfpXJi1EnjP9/7BBeoA45/dJASUCEnBwwJOGCovKl2m/A5fwRecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from labnh.int.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id E666B7D11A;
	Mon, 19 Feb 2024 08:59:26 +0000 (UTC)
From: Christian Hopps <chopps@chopps.org>
To: devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH ipsec-next v1 7/8] iptfs: xfrm: add generic iptfs defines and functionality
Date: Mon, 19 Feb 2024 03:57:34 -0500
Message-ID: <20240219085735.1220113-8-chopps@chopps.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219085735.1220113-1-chopps@chopps.org>
References: <20240219085735.1220113-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Hopps <chopps@labn.net>

Define `XFRM_MODE_IPTFS` and `IPSEC_MODE_IPTFS` constants, and add these to
switch case and conditionals adjacent with the existing TUNNEL modes.

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 include/net/xfrm.h         |  1 +
 include/uapi/linux/ipsec.h |  3 ++-
 include/uapi/linux/snmp.h  |  2 ++
 net/ipv4/esp4.c            |  3 ++-
 net/ipv6/esp6.c            |  3 ++-
 net/netfilter/nft_xfrm.c   |  3 ++-
 net/xfrm/xfrm_device.c     |  1 +
 net/xfrm/xfrm_output.c     |  4 ++++
 net/xfrm/xfrm_policy.c     |  8 ++++++--
 net/xfrm/xfrm_proc.c       |  2 ++
 net/xfrm/xfrm_state.c      | 12 ++++++++++++
 net/xfrm/xfrm_user.c       |  3 +++
 12 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index f1d5e99f0a47..1e2af0b27631 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -37,6 +37,7 @@
 #define XFRM_PROTO_COMP		108
 #define XFRM_PROTO_IPIP		4
 #define XFRM_PROTO_IPV6		41
+#define XFRM_PROTO_IPTFS	IPPROTO_AGGFRAG
 #define XFRM_PROTO_ROUTING	IPPROTO_ROUTING
 #define XFRM_PROTO_DSTOPTS	IPPROTO_DSTOPTS
 
diff --git a/include/uapi/linux/ipsec.h b/include/uapi/linux/ipsec.h
index 50d8ee1791e2..696b790f4346 100644
--- a/include/uapi/linux/ipsec.h
+++ b/include/uapi/linux/ipsec.h
@@ -14,7 +14,8 @@ enum {
 	IPSEC_MODE_ANY		= 0,	/* We do not support this for SA */
 	IPSEC_MODE_TRANSPORT	= 1,
 	IPSEC_MODE_TUNNEL	= 2,
-	IPSEC_MODE_BEET         = 3
+	IPSEC_MODE_BEET         = 3,
+	IPSEC_MODE_IPTFS        = 4
 };
 
 enum {
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index a0819c6a5988..06907abbdab9 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -337,6 +337,8 @@ enum
 	LINUX_MIB_XFRMFWDHDRERROR,		/* XfrmFwdHdrError*/
 	LINUX_MIB_XFRMOUTSTATEINVALID,		/* XfrmOutStateInvalid */
 	LINUX_MIB_XFRMACQUIREERROR,		/* XfrmAcquireError */
+	LINUX_MIB_XFRMINIPTFSERROR,		/* XfrmInIptfsError */
+	LINUX_MIB_XFRMOUTNOQSPACE,		/* XfrmOutNoQueueSpace */
 	__LINUX_MIB_XFRMMAX
 };
 
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 4ccfc104f13a..7607698690f9 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -818,7 +818,8 @@ int esp_input_done2(struct sk_buff *skb, int err)
 	}
 
 	skb_pull_rcsum(skb, hlen);
-	if (x->props.mode == XFRM_MODE_TUNNEL)
+	if (x->props.mode == XFRM_MODE_TUNNEL ||
+	    x->props.mode == XFRM_MODE_IPTFS)
 		skb_reset_transport_header(skb);
 	else
 		skb_set_transport_header(skb, -ihl);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 2cc1a45742d8..81bdaceead27 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -867,7 +867,8 @@ int esp6_input_done2(struct sk_buff *skb, int err)
 	skb_postpull_rcsum(skb, skb_network_header(skb),
 			   skb_network_header_len(skb));
 	skb_pull_rcsum(skb, hlen);
-	if (x->props.mode == XFRM_MODE_TUNNEL)
+	if (x->props.mode == XFRM_MODE_TUNNEL ||
+	    x->props.mode == XFRM_MODE_IPTFS)
 		skb_reset_transport_header(skb);
 	else
 		skb_set_transport_header(skb, -hdr_len);
diff --git a/net/netfilter/nft_xfrm.c b/net/netfilter/nft_xfrm.c
index 452f8587adda..291b029391cd 100644
--- a/net/netfilter/nft_xfrm.c
+++ b/net/netfilter/nft_xfrm.c
@@ -112,7 +112,8 @@ static bool xfrm_state_addr_ok(enum nft_xfrm_keys k, u8 family, u8 mode)
 		return true;
 	}
 
-	return mode == XFRM_MODE_BEET || mode == XFRM_MODE_TUNNEL;
+	return mode == XFRM_MODE_BEET || mode == XFRM_MODE_TUNNEL ||
+	       mode == XFRM_MODE_IPTFS;
 }
 
 static void nft_xfrm_state_get_key(const struct nft_xfrm *priv,
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 8b848540ea47..a40f5e09829e 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -69,6 +69,7 @@ static void __xfrm_mode_beet_prep(struct xfrm_state *x, struct sk_buff *skb,
 static void xfrm_outer_mode_prep(struct xfrm_state *x, struct sk_buff *skb)
 {
 	switch (x->outer_mode.encap) {
+	case XFRM_MODE_IPTFS:
 	case XFRM_MODE_TUNNEL:
 		if (x->outer_mode.family == AF_INET)
 			return __xfrm_mode_tunnel_prep(x, skb,
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 8f98e42d4252..938b81c0a8d3 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -677,6 +677,10 @@ static void xfrm_get_inner_ipproto(struct sk_buff *skb, struct xfrm_state *x)
 
 		return;
 	}
+	if (x->outer_mode.encap == XFRM_MODE_IPTFS) {
+		xo->inner_ipproto = IPPROTO_AGGFRAG;
+		return;
+	}
 
 	/* non-Tunnel Mode */
 	if (!skb->encapsulation)
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index f3cd8483d427..ed19e3d19296 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2474,6 +2474,7 @@ xfrm_tmpl_resolve_one(struct xfrm_policy *policy, const struct flowi *fl,
 		struct xfrm_tmpl *tmpl = &policy->xfrm_vec[i];
 
 		if (tmpl->mode == XFRM_MODE_TUNNEL ||
+		    tmpl->mode == XFRM_MODE_IPTFS ||
 		    tmpl->mode == XFRM_MODE_BEET) {
 			remote = &tmpl->id.daddr;
 			local = &tmpl->saddr;
@@ -3258,7 +3259,8 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
 ok:
 	xfrm_pols_put(pols, drop_pols);
 	if (dst && dst->xfrm &&
-	    dst->xfrm->props.mode == XFRM_MODE_TUNNEL)
+	    (dst->xfrm->props.mode == XFRM_MODE_TUNNEL ||
+	     dst->xfrm->props.mode == XFRM_MODE_IPTFS))
 		dst->flags |= DST_XFRM_TUNNEL;
 	return dst;
 
@@ -4495,6 +4497,7 @@ static int migrate_tmpl_match(const struct xfrm_migrate *m, const struct xfrm_tm
 		switch (t->mode) {
 		case XFRM_MODE_TUNNEL:
 		case XFRM_MODE_BEET:
+		case XFRM_MODE_IPTFS:
 			if (xfrm_addr_equal(&t->id.daddr, &m->old_daddr,
 					    m->old_family) &&
 			    xfrm_addr_equal(&t->saddr, &m->old_saddr,
@@ -4537,7 +4540,8 @@ static int xfrm_policy_migrate(struct xfrm_policy *pol,
 				continue;
 			n++;
 			if (pol->xfrm_vec[i].mode != XFRM_MODE_TUNNEL &&
-			    pol->xfrm_vec[i].mode != XFRM_MODE_BEET)
+			    pol->xfrm_vec[i].mode != XFRM_MODE_BEET &&
+			    pol->xfrm_vec[i].mode != XFRM_MODE_IPTFS)
 				continue;
 			/* update endpoints */
 			memcpy(&pol->xfrm_vec[i].id.daddr, &mp->new_daddr,
diff --git a/net/xfrm/xfrm_proc.c b/net/xfrm/xfrm_proc.c
index fee9b5cf37a7..d92b1b760749 100644
--- a/net/xfrm/xfrm_proc.c
+++ b/net/xfrm/xfrm_proc.c
@@ -41,6 +41,8 @@ static const struct snmp_mib xfrm_mib_list[] = {
 	SNMP_MIB_ITEM("XfrmFwdHdrError", LINUX_MIB_XFRMFWDHDRERROR),
 	SNMP_MIB_ITEM("XfrmOutStateInvalid", LINUX_MIB_XFRMOUTSTATEINVALID),
 	SNMP_MIB_ITEM("XfrmAcquireError", LINUX_MIB_XFRMACQUIREERROR),
+	SNMP_MIB_ITEM("XfrmInIptfsError", LINUX_MIB_XFRMINIPTFSERROR),
+	SNMP_MIB_ITEM("XfrmOutNoQueueSpace", LINUX_MIB_XFRMOUTNOQSPACE),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 2b58e35bea63..eaa21456bbe2 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -465,6 +465,11 @@ static const struct xfrm_mode xfrm4_mode_map[XFRM_MODE_MAX] = {
 		.flags = XFRM_MODE_FLAG_TUNNEL,
 		.family = AF_INET,
 	},
+	[XFRM_MODE_IPTFS] = {
+		.encap = XFRM_MODE_IPTFS,
+		.flags = XFRM_MODE_FLAG_TUNNEL,
+		.family = AF_INET,
+	},
 };
 
 static const struct xfrm_mode xfrm6_mode_map[XFRM_MODE_MAX] = {
@@ -486,6 +491,11 @@ static const struct xfrm_mode xfrm6_mode_map[XFRM_MODE_MAX] = {
 		.flags = XFRM_MODE_FLAG_TUNNEL,
 		.family = AF_INET6,
 	},
+	[XFRM_MODE_IPTFS] = {
+		.encap = XFRM_MODE_IPTFS,
+		.flags = XFRM_MODE_FLAG_TUNNEL,
+		.family = AF_INET6,
+	},
 };
 
 static const struct xfrm_mode *xfrm_get_mode(unsigned int encap, int family)
@@ -2089,6 +2099,7 @@ static int __xfrm6_state_sort_cmp(const void *p)
 #endif
 	case XFRM_MODE_TUNNEL:
 	case XFRM_MODE_BEET:
+	case XFRM_MODE_IPTFS:
 		return 4;
 	}
 	return 5;
@@ -2115,6 +2126,7 @@ static int __xfrm6_tmpl_sort_cmp(const void *p)
 #endif
 	case XFRM_MODE_TUNNEL:
 	case XFRM_MODE_BEET:
+	case XFRM_MODE_IPTFS:
 		return 3;
 	}
 	return 4;
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 92d11f2306e7..80617c0d040f 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -353,6 +353,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 	case XFRM_MODE_TUNNEL:
 	case XFRM_MODE_ROUTEOPTIMIZATION:
 	case XFRM_MODE_BEET:
+	case XFRM_MODE_IPTFS:
 		break;
 
 	default:
@@ -1830,6 +1831,8 @@ static int validate_tmpl(int nr, struct xfrm_user_tmpl *ut, u16 family,
 				return -EINVAL;
 			}
 			break;
+		case XFRM_MODE_IPTFS:
+			break;
 		default:
 			if (ut[i].family != prev_family) {
 				NL_SET_ERR_MSG(extack, "Mode in template doesn't support a family change");
-- 
2.43.0


