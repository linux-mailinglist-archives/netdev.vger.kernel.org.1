Return-Path: <netdev+bounces-241473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD3BC843B4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA813B14AA
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15E32EC561;
	Tue, 25 Nov 2025 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VczsR3yu"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D3254AFF
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063006; cv=none; b=DtYIFuenQa/v5y8f7KfOQVI/QTd0TMNkXe70rZcXDktkWiNCSYOpCmw5WpeLuSUvxAo4bzUmZ/KaboeUBrTMiofd4csaeM5nJHW2rO3C8INVyu0qIkukbsv+fKebuvAZFqIqMkQukQkXkgY7ZmMqGsSIvOIHVw2LyrHITNzAm2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063006; c=relaxed/simple;
	bh=GRZne6R80ikxyjzsEsCfIZhZ/fJ0AF7AyC6HvgTB3vM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZf0VFZB0Zcqrwtj+tpauvsvZvMm0NZBfKcNq2sJaMwfeGSIZbXZGj589lW0k6tWaXfLEQ7C98qc6+iFqSKf2tpOAWzLL9FPSM9gCs/oW+2ep8NCI662CAvqv8IewUeMit4QynpybdBmD9y9XWG5Q1SYr1sMeYwbJ+UR3Rczg0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VczsR3yu; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 05CA520896;
	Tue, 25 Nov 2025 10:30:02 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LvrqU91Ax6EQ; Tue, 25 Nov 2025 10:30:01 +0100 (CET)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E5E052088A;
	Tue, 25 Nov 2025 10:30:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E5E052088A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1764063000;
	bh=I4DE5WN9XQvw+UZeSe83FhXsIa1ig7UXNWxEUDftLnM=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=VczsR3yuMfAJ/jbqV6o1ZYG3TxFZ3yxivKIso9FhxHHSC8MfSWPWKj6Z9OE6GmlW2
	 wvPszCGZaVNBDGtpc/aTEJbCb3enLgIbVmz3GLWvNInUGy4ktROZB7NRmjDjzVhq1t
	 gnyopNXcb8DOev4tOjIlM/GcBm34tPP5lKDtHXfmMwVVdo6xC5dVki+aresTxLeiZr
	 I2com1DE9ZFWUMSClRAYPe8BZrapE0m9WiNN+eRLOdnYtHC2Hc6C3vJj3ctEQlVW+t
	 55zjcYGmyVeHBFSfeZjIupKc0sGN3WnUvJJDA35gx/2MJCyGbCwqTiZEM1CRV6G78u
	 5pAybgaArMcBg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 25 Nov
 2025 10:30:00 +0100
Date: Tue, 25 Nov 2025 10:29:54 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>
Subject: [PATCH RFC ipsec-next 3/5] xfrm: new method XFRM_MSG_MIGRATE_STATE
Message-ID: <5fc280b0f2b3448f4d4ce6dce52c984a6100093c.1764061159.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1764061158.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1764061158.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-02.secunet.de (10.32.0.172)

new method to support single xfrm_state migration.
Besides exiting migration (SA + policy), this also
support changing reqid.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/net/xfrm.h          |   5 +-
 include/uapi/linux/xfrm.h   |  10 +++
 net/xfrm/xfrm_replay.c      |  16 ++++
 net/xfrm/xfrm_state.c       |  18 ++--
 net/xfrm/xfrm_user.c        | 161 +++++++++++++++++++++++++++++++++++-
 security/selinux/nlmsgtab.c |   3 +-
 6 files changed, 202 insertions(+), 11 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index ae35a0499168..6a6babcdcd09 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -685,6 +685,7 @@ struct xfrm_migrate {
 	u8			mode;
 	u16			reserved;
 	u32			old_reqid;
+	u32			new_reqid;
 	u16			old_family;
 	u16			new_family;
 };
@@ -1906,6 +1907,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		 struct xfrm_encap_tmpl *encap, u32 if_id,
 		 struct netlink_ext_ack *extack,
 		 struct xfrm_user_offload *xuo);
+void xfrm_sync_oseq(struct xfrm_state *x, struct xfrm_state *orig);
 #endif
 
 int km_new_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr, __be16 sport);
@@ -2011,8 +2013,7 @@ static inline unsigned int xfrm_replay_state_esn_len(struct xfrm_replay_state_es
 }
 
 #ifdef CONFIG_XFRM_MIGRATE
-static inline int xfrm_replay_clone(struct xfrm_state *x,
-				     struct xfrm_state *orig)
+static inline int xfrm_replay_clone(struct xfrm_state *x, struct xfrm_state *orig)
 {
 
 	x->replay_esn = kmemdup(orig->replay_esn,
diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index a23495c0e0a1..df75f7c2b7f7 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -227,6 +227,8 @@ enum {
 #define XFRM_MSG_SETDEFAULT XFRM_MSG_SETDEFAULT
 	XFRM_MSG_GETDEFAULT,
 #define XFRM_MSG_GETDEFAULT XFRM_MSG_GETDEFAULT
+	XFRM_MSG_MIGRATE_STATE,
+#define XFRM_MSG_MIGRATE_STATE XFRM_MSG_MIGRATE_STATE
 	__XFRM_MSG_MAX
 };
 #define XFRM_MSG_MAX (__XFRM_MSG_MAX - 1)
@@ -507,6 +509,14 @@ struct xfrm_user_migrate {
 	__u16				new_family;
 };
 
+struct xfrm_user_migrate_state {
+	struct xfrm_usersa_id id;
+	xfrm_address_t new_saddr;
+	xfrm_address_t new_daddr;
+	__u16 new_family;
+	__u32 new_reqid;
+};
+
 struct xfrm_user_mapping {
 	struct xfrm_usersa_id		id;
 	__u32				reqid;
diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
index dbdf8a39dffe..3404c03a8590 100644
--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -797,3 +797,19 @@ int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack)
 	return 0;
 }
 EXPORT_SYMBOL(xfrm_init_replay);
+
+void xfrm_sync_oseq(struct xfrm_state *x, struct xfrm_state *orig)
+{
+	switch (x->repl_mode) {
+	case XFRM_REPLAY_MODE_LEGACY:
+		x->replay.oseq = orig->replay.oseq;
+		break;
+
+	case XFRM_REPLAY_MODE_BMP:
+	case XFRM_REPLAY_MODE_ESN:
+		x->replay_esn->oseq = orig->replay_esn->oseq;
+		x->replay_esn->oseq_hi = orig->replay_esn->oseq_hi;
+		break;
+	}
+}
+EXPORT_SYMBOL(xfrm_sync_oseq);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 62ccdf35cd0e..17c3de65fb00 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1966,7 +1966,8 @@ static inline int clone_security(struct xfrm_state *x, struct xfrm_sec_ctx *secu
 
 static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 					   struct xfrm_encap_tmpl *encap,
-					   struct xfrm_migrate *m)
+					   struct xfrm_migrate *m,
+					   struct netlink_ext_ack *extack)
 {
 	struct net *net = xs_net(orig);
 	struct xfrm_state *x = xfrm_state_alloc(net);
@@ -1978,7 +1979,6 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	memcpy(&x->lft, &orig->lft, sizeof(x->lft));
 	x->props.mode = orig->props.mode;
 	x->props.replay_window = orig->props.replay_window;
-	x->props.reqid = orig->props.reqid;
 	x->props.saddr = orig->props.saddr;
 
 	if (orig->aalg) {
@@ -2058,7 +2058,10 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 			goto error;
 	}
 
-
+	if (orig->props.reqid != m->new_reqid)
+		x->props.reqid = m->new_reqid;
+	else
+		x->props.reqid = orig->props.reqid;
 	x->props.family = m->new_family;
 	memcpy(&x->id.daddr, &m->new_daddr, sizeof(x->id.daddr));
 	memcpy(&x->props.saddr, &m->new_saddr, sizeof(x->props.saddr));
@@ -2132,7 +2135,7 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 {
 	struct xfrm_state *xc;
 
-	xc = xfrm_state_clone_and_setup(x, encap, m);
+	xc = xfrm_state_clone_and_setup(x, encap, m, extack);
 	if (!xc)
 		return NULL;
 
@@ -2144,9 +2147,10 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 		goto error;
 
 	/* add state */
-	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
-		/* a care is needed when the destination address of the
-		   state is to be updated as it is a part of triplet */
+	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family) ||
+			x->props.reqid != xc->props.reqid) {
+		/* a care is needed when the destination address or the reqid
+		 * of the state is to be updated as it is a part of triplet */
 		xfrm_state_insert(xc);
 	} else {
 		if (xfrm_state_add(xc) < 0)
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 027e9ad10b45..cc5c816f01ed 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3046,6 +3046,22 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 
 #ifdef CONFIG_XFRM_MIGRATE
+static int copy_from_user_migrate_state(struct xfrm_migrate *ma,
+					struct xfrm_user_migrate_state *um)
+{
+	memcpy(&ma->old_daddr, &um->id.daddr, sizeof(ma->old_daddr));
+	memcpy(&ma->new_daddr, &um->new_daddr, sizeof(ma->new_daddr));
+	memcpy(&ma->new_saddr, &um->new_saddr, sizeof(ma->new_saddr));
+
+	ma->proto = um->id.proto;
+	ma->new_reqid = um->new_reqid;
+
+	ma->old_family = um->id.family;
+	ma->new_family = um->new_family;
+
+	return 0;
+}
+
 static int copy_from_user_migrate(struct xfrm_migrate *ma,
 				  struct xfrm_kmaddress *k,
 				  struct nlattr **attrs, int *num,
@@ -3148,7 +3164,149 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 	kfree(xuo);
 	return err;
 }
+
+static int build_migrate_state(struct sk_buff *skb,
+			       const struct xfrm_user_migrate_state *m,
+			       const struct xfrm_encap_tmpl *encap,
+			       const struct xfrm_user_offload *xuo)
+{
+	int err;
+	struct nlmsghdr *nlh;
+	struct xfrm_user_migrate_state *um;
+
+	nlh = nlmsg_put(skb, 0, 0, XFRM_MSG_MIGRATE_STATE,
+			sizeof(struct xfrm_user_migrate_state), 0);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	um = nlmsg_data(nlh);
+	memset(um, 0, sizeof(*um));
+	memcpy(um, m, sizeof(*um));
+
+	if (encap) {
+		err = nla_put(skb, XFRMA_ENCAP, sizeof(*encap), encap);
+		if (err)
+			goto out_cancel;
+	}
+
+	if (xuo) {
+		err = nla_put(skb, XFRMA_OFFLOAD_DEV, sizeof(*xuo), xuo);
+		if (err)
+			goto out_cancel;
+	}
+
+	nlmsg_end(skb, nlh);
+	return 0;
+
+out_cancel:
+	nlmsg_cancel(skb, nlh);
+	return err;
+}
+
+static inline unsigned int xfrm_migrate_state_msgsize(bool with_encp)
+{
+	return NLMSG_ALIGN(sizeof(struct xfrm_user_migrate_state))
+		+ (with_encp ? nla_total_size(sizeof(struct xfrm_encap_tmpl)) : 0);
+}
+
+static int xfrm_send_migrate_state(const struct xfrm_user_migrate_state *um,
+				   const struct xfrm_encap_tmpl *encap,
+				   const struct xfrm_user_offload *xuo)
+{
+	int err;
+	struct sk_buff *skb;
+	struct net *net = &init_net;
+
+	skb = nlmsg_new(xfrm_migrate_state_msgsize(!!encap), GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	err = build_migrate_state(skb, um, encap, xuo);
+	if (err < 0) {
+		WARN_ON(1);
+		return err;
+	}
+
+	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_MIGRATE);
+}
+
+static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
+				 struct nlattr **attrs, struct netlink_ext_ack *extack)
+{
+	int err = -ESRCH;
+	struct xfrm_state *x;
+	struct xfrm_encap_tmpl *encap = NULL;
+	struct xfrm_user_offload *xuo = NULL;
+	struct xfrm_migrate m  = { .old_saddr.a4 = 0,};
+	struct net *net = sock_net(skb->sk);
+	struct xfrm_user_migrate_state *um = nlmsg_data(nlh);
+
+	if (!um->id.spi)  {
+		NL_SET_ERR_MSG(extack, "Invalid SPI 0x0");
+		return -EINVAL;
+	}
+
+	err = copy_from_user_migrate_state(&m, um);
+	if (err)
+		return err;
+
+	x = xfrm_user_state_lookup(net, &um->id, attrs, &err);
+
+	if (x) {
+		struct xfrm_state *xc;
+
+		if (!x->dir) {
+			NL_SET_ERR_MSG(extack, "State direction is invalid");
+			err = -EINVAL;
+			goto error;
+		}
+
+		if (attrs[XFRMA_ENCAP]) {
+			encap = kmemdup(nla_data(attrs[XFRMA_ENCAP]),
+					sizeof(*encap), GFP_KERNEL);
+			if (!encap) {
+				err = -ENOMEM;
+				goto error;
+			}
+		}
+		if (attrs[XFRMA_OFFLOAD_DEV]) {
+			xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
+				      sizeof(*xuo), GFP_KERNEL);
+			if (!xuo) {
+				err = -ENOMEM;
+				goto error;
+			}
+		}
+		xc = xfrm_state_migrate(x, &m, encap, net, xuo, extack);
+		if (xc) {
+			xfrm_state_delete(x);
+			if (x->dir == XFRM_SA_DIR_OUT)
+				xfrm_sync_oseq(xc, x);
+			xfrm_send_migrate_state(um, encap, xuo);
+		} else {
+			if (extack && !extack->_msg)
+				    NL_SET_ERR_MSG(extack, "State migration clone failed");
+			err = -EINVAL;
+		}
+	} else {
+		NL_SET_ERR_MSG(extack, "Can not find state");
+		return err;
+	}
+error:
+	xfrm_state_put(x);
+	kfree(encap);
+	kfree(xuo);
+	return err;
+}
+
 #else
+static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
+				 struct nlattr **attrs, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG(extack, "XFRM_MSG_MIGRATE_STATE is not supported");
+	return -ENOPROTOOPT;
+}
+
 static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 			   struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
@@ -3213,7 +3371,6 @@ static int build_migrate(struct sk_buff *skb, const struct xfrm_migrate *m,
 		return -EMSGSIZE;
 
 	pol_id = nlmsg_data(nlh);
-	/* copy data from selector, dir, and type to the pol_id */
 	memset(pol_id, 0, sizeof(*pol_id));
 	memcpy(&pol_id->sel, sel, sizeof(pol_id->sel));
 	pol_id->dir = dir;
@@ -3301,6 +3458,7 @@ const int xfrm_msg_min[XFRM_NR_MSGTYPES] = {
 	[XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
 	[XFRM_MSG_SETDEFAULT  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_default),
 	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_default),
+	[XFRM_MSG_MIGRATE_STATE - XFRM_MSG_BASE] = XMSGSIZE(xfrm_user_migrate_state),
 };
 EXPORT_SYMBOL_GPL(xfrm_msg_min);
 
@@ -3394,6 +3552,7 @@ static const struct xfrm_link {
 	[XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] = { .doit = xfrm_get_spdinfo   },
 	[XFRM_MSG_SETDEFAULT  - XFRM_MSG_BASE] = { .doit = xfrm_set_default   },
 	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = { .doit = xfrm_get_default   },
+	[XFRM_MSG_MIGRATE_STATE - XFRM_MSG_BASE] = { .doit = xfrm_do_migrate_state },
 };
 
 static int xfrm_reject_unused_attr(int type, struct nlattr **attrs,
diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 2c0b07f9fbbd..9cec74c317f0 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -128,6 +128,7 @@ static const struct nlmsg_perm nlmsg_xfrm_perms[] = {
 	{ XFRM_MSG_MAPPING, NETLINK_XFRM_SOCKET__NLMSG_READ },
 	{ XFRM_MSG_SETDEFAULT, NETLINK_XFRM_SOCKET__NLMSG_WRITE },
 	{ XFRM_MSG_GETDEFAULT, NETLINK_XFRM_SOCKET__NLMSG_READ },
+	{ XFRM_MSG_MIGRATE_STATE, NETLINK_XFRM_SOCKET__NLMSG_WRITE  },
 };
 
 static const struct nlmsg_perm nlmsg_audit_perms[] = {
@@ -203,7 +204,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 		 * structures at the top of this file with the new mappings
 		 * before updating the BUILD_BUG_ON() macro!
 		 */
-		BUILD_BUG_ON(XFRM_MSG_MAX != XFRM_MSG_GETDEFAULT);
+		BUILD_BUG_ON(XFRM_MSG_MAX != XFRM_MSG_MIGRATE_STATE);
 
 		if (selinux_policycap_netlink_xperm()) {
 			*perm = NETLINK_XFRM_SOCKET__NLMSG;
-- 
2.39.5


