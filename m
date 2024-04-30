Return-Path: <netdev+bounces-92334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB6B8B6B1F
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 09:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B8B5B219DB
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 07:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3E249E4;
	Tue, 30 Apr 2024 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="XtlRanHX"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6A199AD
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714460950; cv=none; b=nMIVUwu9Tyy0Ge56NT12C8Cd/rEh9JmHmwQ+vW0peN/s0pDw04YTDxCSMwLUJIhYA5TZRrtAuJtjoGUvwemlO9jV8QRYONjQLfzisMOTfTcSocMnzfeNGSX5mzBFz91VBJeFz9yyP/T3U2BSRtE8iWnrL6Sws3Ie7nL2cmY5sw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714460950; c=relaxed/simple;
	bh=3Cs1qlaxIDjKWGTZO5wTtw2xToT+vLywvA3sDiCRTXw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3OyiCVhW8rF6UobVEVfjET46wOJYBLHLOSwBTmaliJB9r4WUQatIlNa+iNvkmWNrSl9Sv9HOIkMbhXnVcGFi9GKw4dWF2MI+TjX4ic4/4UWSYp4tHzCsOrb1j9FT29sz6OEoT7e3ahCz64pD0fU+nkP6kzxaq7YCtHCgahaUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=XtlRanHX; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 89F25204EF;
	Tue, 30 Apr 2024 09:09:05 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5XQhZhZFZHm5; Tue, 30 Apr 2024 09:09:04 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5F780207D8;
	Tue, 30 Apr 2024 09:09:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5F780207D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714460940;
	bh=5VFDTSVQ870RuAZb8NhLO5XRwp/VWwXPk3AOJ4Uxwn0=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=XtlRanHX/+drmNDfBn+bMQihjMIxk61wul1l62RqehxwBb+PQYQxrCGKR7WETl+Xv
	 a6bPFKP+mozBiEd/oZubOQFgAQwDmbP9JZ0Ds7DoU+lCN1VYAGX8wo5IsmM8yzJAbV
	 wiUC/FCTP0uRJO44iiDo4GmZs8Y/BRBJtRk3z5A/4u7kyic33xC3iwH8Pvq/mAcWB3
	 oIn4OVhFEDcY5wqMxOq6nNoozb5QOLGspCg5PZiASmg1W2wIqSfEAOlPBzTxfFzCzO
	 w11fnPHL1AbNqwPInUyvgGGZNmv6jxspmeXj11ou81p0iAOP/mq0ZZqOvrnWwXceVD
	 vDgEgvFgVUxgA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 5038180004A;
	Tue, 30 Apr 2024 09:09:00 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Apr 2024 09:09:00 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Apr
 2024 09:08:59 +0200
Date: Tue, 30 Apr 2024 09:08:52 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v14 1/4] xfrm: Add Direction to the SA in or out
Message-ID: <88a30570ff426ff58a8f9d4ead55901fa84689bc.1714460330.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1714460330.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1714460330.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

This patch introduces the 'dir' attribute, 'in' or 'out', to the
xfrm_state, SA, enhancing usability by delineating the scope of values
based on direction. An input SA will restrict values pertinent to input,
effectively segregating them from output-related values.
And an output SA will restrict attributes for output. This change aims
to streamline the configuration process and improve the overall
consistency of SA attributes during configuration.

This feature sets the groundwork for future patches, including
the upcoming IP-TFS patch.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v13->v14:
 - add more validation of flags XFRM_SA_XFLAG_OSEQ_MAY_WRAP
   XFRM_STATE_WILDRECV

v12->v13:
 - fix typos and white spaces
 - allow UPDSA, using old userpace, to update new acquire with direction

v11->v12:
 - fix typo in error messge for flag ICMP

v10->v11:
 - set dir out for acquire state
 - allow output state with ESN to set replay-window 0
 - change XFRMA_SA_DIR using NLA_POLICY_RANGE()
 - replace verify_sa_dir() with refactored code.

v9->v10:
 - add more direction specific validations
	XFRM_STATE_NOPMTUDISC, XFRM_SA_XFLAG_DONT_ENCAP_DSCP
	XFRMA_MTIMER_THRESH
 - refactor validations into a fuction.
 - add dir to ALLOCSPI to support strongSwan updating SPI to "in" state

v8->v9:
 - add validation XFRM_STATE_ICMP not allowed on OUT SA.

v7->v8:
 - add extra validation check on replay window and seq
 - XFRM_MSG_UPDSA old and new SA should match "dir"

v6->v7:
 - add replay-window check non-esn 0 and ESN 1.
 - remove :XFRMA_SA_DIR only allowed with HW OFFLOAD

v5->v6:
 - XFRMA_SA_DIR only allowed with HW OFFLOAD

v4->v5:
 - add details to commit message

v3->v4:
 - improve HW OFFLOAD DIR check add the other direction

v2->v3:
 - delete redundant XFRM_SA_DIR_USE
 - use u8 for "dir"
 - fix HW OFFLOAD DIR check

v1->v2:
 - use .strict_start_type in struct nla_policy xfrma_policy
 - delete redundant XFRM_SA_DIR_MAX enum
---
 include/net/xfrm.h        |   1 +
 include/uapi/linux/xfrm.h |   6 ++
 net/xfrm/xfrm_compat.c    |   7 +-
 net/xfrm/xfrm_device.c    |   6 ++
 net/xfrm/xfrm_replay.c    |   3 +-
 net/xfrm/xfrm_state.c     |   8 +++
 net/xfrm/xfrm_user.c      | 138 ++++++++++++++++++++++++++++++++++++--
 7 files changed, 160 insertions(+), 9 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 57c743b7e4fe..7c9be06f8302 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -291,6 +291,7 @@ struct xfrm_state {
 	/* Private data of this transformer, format is opaque,
 	 * interpreted by xfrm_type methods. */
 	void			*data;
+	u8			dir;
 };

 static inline struct net *xs_net(struct xfrm_state *x)
diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 6a77328be114..18ceaba8486e 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -141,6 +141,11 @@ enum {
 	XFRM_POLICY_MAX	= 3
 };

+enum xfrm_sa_dir {
+	XFRM_SA_DIR_IN	= 1,
+	XFRM_SA_DIR_OUT = 2
+};
+
 enum {
 	XFRM_SHARE_ANY,		/* No limitations */
 	XFRM_SHARE_SESSION,	/* For this session only */
@@ -315,6 +320,7 @@ enum xfrm_attr_type_t {
 	XFRMA_SET_MARK_MASK,	/* __u32 */
 	XFRMA_IF_ID,		/* __u32 */
 	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
+	XFRMA_SA_DIR,		/* __u8 */
 	__XFRMA_MAX

 #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index 655fe4ff8621..703d4172c7d7 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -98,6 +98,7 @@ static const int compat_msg_min[XFRM_NR_MSGTYPES] = {
 };

 static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
+	[XFRMA_UNSPEC]          = { .strict_start_type = XFRMA_SA_DIR },
 	[XFRMA_SA]		= { .len = XMSGSIZE(compat_xfrm_usersa_info)},
 	[XFRMA_POLICY]		= { .len = XMSGSIZE(compat_xfrm_userpolicy_info)},
 	[XFRMA_LASTUSED]	= { .type = NLA_U64},
@@ -129,6 +130,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
 	[XFRMA_MTIMER_THRESH]	= { .type = NLA_U32 },
+	[XFRMA_SA_DIR]          = NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_IN, XFRM_SA_DIR_OUT),
 };

 static struct nlmsghdr *xfrm_nlmsg_put_compat(struct sk_buff *skb,
@@ -277,9 +279,10 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, const struct nlattr *src)
 	case XFRMA_SET_MARK_MASK:
 	case XFRMA_IF_ID:
 	case XFRMA_MTIMER_THRESH:
+	case XFRMA_SA_DIR:
 		return xfrm_nla_cpy(dst, src, nla_len(src));
 	default:
-		BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_DIR);
 		pr_warn_once("unsupported nla_type %d\n", src->nla_type);
 		return -EOPNOTSUPP;
 	}
@@ -434,7 +437,7 @@ static int xfrm_xlate32_attr(void *dst, const struct nlattr *nla,
 	int err;

 	if (type > XFRMA_MAX) {
-		BUILD_BUG_ON(XFRMA_MAX != XFRMA_MTIMER_THRESH);
+		BUILD_BUG_ON(XFRMA_MAX != XFRMA_SA_DIR);
 		NL_SET_ERR_MSG(extack, "Bad attribute");
 		return -EOPNOTSUPP;
 	}
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 6346690d5c69..2455a76a1cff 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -253,6 +253,12 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}

+	if ((xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir == XFRM_SA_DIR_OUT) ||
+	    (!(xuo->flags & XFRM_OFFLOAD_INBOUND) && x->dir == XFRM_SA_DIR_IN)) {
+		NL_SET_ERR_MSG(extack, "Mismatched SA and offload direction");
+		return -EINVAL;
+	}
+
 	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;

 	/* We don't yet support UDP encapsulation and TFC padding. */
diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
index ce56d659c55a..bc56c6305725 100644
--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -778,7 +778,8 @@ int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack)
 		}

 		if (x->props.flags & XFRM_STATE_ESN) {
-			if (replay_esn->replay_window == 0) {
+			if (replay_esn->replay_window == 0 &&
+			    (!x->dir || x->dir == XFRM_SA_DIR_IN)) {
 				NL_SET_ERR_MSG(extack, "ESN replay window must be > 0");
 				return -EINVAL;
 			}
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 0c306473a79d..649bb739df0d 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1292,6 +1292,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		if (km_query(x, tmpl, pol) == 0) {
 			spin_lock_bh(&net->xfrm.xfrm_state_lock);
 			x->km.state = XFRM_STATE_ACQ;
+			x->dir = XFRM_SA_DIR_OUT;
 			list_add(&x->km.all, &net->xfrm.state_all);
 			XFRM_STATE_INSERT(bydst, &x->bydst,
 					  net->xfrm.state_bydst + h,
@@ -1744,6 +1745,7 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
 	x->lastused = orig->lastused;
 	x->new_mapping = 0;
 	x->new_mapping_sport = 0;
+	x->dir = orig->dir;

 	return x;

@@ -1864,8 +1866,14 @@ int xfrm_state_update(struct xfrm_state *x)
 	}

 	if (x1->km.state == XFRM_STATE_ACQ) {
+		if (x->dir && x1->dir != x->dir)
+			goto out;
+
 		__xfrm_state_insert(x);
 		x = NULL;
+	} else {
+		if (x1->dir != x->dir)
+			goto out;
 	}
 	err = 0;

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 810b520493f3..f5eb3af4fb81 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -130,7 +130,7 @@ static inline int verify_sec_ctx_len(struct nlattr **attrs, struct netlink_ext_a
 }

 static inline int verify_replay(struct xfrm_usersa_info *p,
-				struct nlattr **attrs,
+				struct nlattr **attrs, u8 sa_dir,
 				struct netlink_ext_ack *extack)
 {
 	struct nlattr *rt = attrs[XFRMA_REPLAY_ESN_VAL];
@@ -168,6 +168,30 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 		return -EINVAL;
 	}

+	if (sa_dir == XFRM_SA_DIR_OUT)  {
+		if (rs->replay_window) {
+			NL_SET_ERR_MSG(extack, "Replay window should be 0 for output SA");
+			return -EINVAL;
+		}
+		if (rs->seq || rs->seq_hi) {
+			NL_SET_ERR_MSG(extack,
+				       "Replay seq and seq_hi should be 0 for output SA");
+			return -EINVAL;
+		}
+		if (rs->bmp_len) {
+			NL_SET_ERR_MSG(extack, "Replay bmp_len should 0 for output SA");
+			return -EINVAL;
+		}
+	}
+
+	if (sa_dir == XFRM_SA_DIR_IN)  {
+		if (rs->oseq || rs->oseq_hi) {
+			NL_SET_ERR_MSG(extack,
+				       "Replay oseq and oseq_hi should be 0 for input SA");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }

@@ -176,6 +200,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 			     struct netlink_ext_ack *extack)
 {
 	int err;
+	u8 sa_dir = attrs[XFRMA_SA_DIR] ? nla_get_u8(attrs[XFRMA_SA_DIR]) : 0;

 	err = -EINVAL;
 	switch (p->family) {
@@ -334,7 +359,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		goto out;
 	if ((err = verify_sec_ctx_len(attrs, extack)))
 		goto out;
-	if ((err = verify_replay(p, attrs, extack)))
+	if ((err = verify_replay(p, attrs, sa_dir, extack)))
 		goto out;

 	err = -EINVAL;
@@ -358,6 +383,77 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 			err = -EINVAL;
 			goto out;
 		}
+
+		if (sa_dir == XFRM_SA_DIR_OUT) {
+			NL_SET_ERR_MSG(extack,
+				       "MTIMER_THRESH attribute should not be set on output SA");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	if (sa_dir == XFRM_SA_DIR_OUT) {
+		if (p->flags & XFRM_STATE_DECAP_DSCP) {
+			NL_SET_ERR_MSG(extack, "Flag DECAP_DSCP should not be set for output SA");
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (p->flags & XFRM_STATE_ICMP) {
+			NL_SET_ERR_MSG(extack, "Flag ICMP should not be set for output SA");
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (p->flags & XFRM_STATE_WILDRECV) {
+			NL_SET_ERR_MSG(extack, "Flag WILDRECV should not be set for output SA");
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (p->replay_window) {
+			NL_SET_ERR_MSG(extack, "Replay window should be 0 for output SA");
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (attrs[XFRMA_REPLAY_VAL]) {
+			struct xfrm_replay_state *replay;
+
+			replay = nla_data(attrs[XFRMA_REPLAY_VAL]);
+
+			if (replay->seq || replay->bitmap) {
+				NL_SET_ERR_MSG(extack,
+					       "Replay seq and bitmap should be 0 for output SA");
+				err = -EINVAL;
+				goto out;
+			}
+		}
+	}
+
+	if (sa_dir == XFRM_SA_DIR_IN) {
+		if (p->flags & XFRM_STATE_NOPMTUDISC) {
+			NL_SET_ERR_MSG(extack, "Flag NOPMTUDISC should not be set for input SA");
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (attrs[XFRMA_SA_EXTRA_FLAGS]) {
+			u32 xflags = nla_get_u32(attrs[XFRMA_SA_EXTRA_FLAGS]);
+
+			if (xflags & XFRM_SA_XFLAG_DONT_ENCAP_DSCP) {
+				NL_SET_ERR_MSG(extack, "Flag DONT_ENCAP_DSCP should not be set for input SA");
+				err = -EINVAL;
+				goto out;
+			}
+
+			if (xflags & XFRM_SA_XFLAG_OSEQ_MAY_WRAP) {
+				NL_SET_ERR_MSG(extack, "Flag OSEQ_MAY_WRAP should not be set for input SA");
+				err = -EINVAL;
+				goto out;
+			}
+
+		}
 	}

 out:
@@ -734,6 +830,9 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 	if (attrs[XFRMA_IF_ID])
 		x->if_id = nla_get_u32(attrs[XFRMA_IF_ID]);

+	if (attrs[XFRMA_SA_DIR])
+		x->dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
+
 	err = __xfrm_init_state(x, false, attrs[XFRMA_OFFLOAD_DEV], extack);
 	if (err)
 		goto error;
@@ -1182,8 +1281,13 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
 		if (ret)
 			goto out;
 	}
-	if (x->mapping_maxage)
+	if (x->mapping_maxage) {
 		ret = nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapping_maxage);
+		if (ret)
+			goto out;
+	}
+	if (x->dir)
+		ret = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
 out:
 	return ret;
 }
@@ -1618,6 +1722,9 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		goto out;

+	if (attrs[XFRMA_SA_DIR])
+		x->dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
+
 	resp_skb = xfrm_state_netlink(skb, x, nlh->nlmsg_seq);
 	if (IS_ERR(resp_skb)) {
 		err = PTR_ERR(resp_skb);
@@ -2402,7 +2509,8 @@ static inline unsigned int xfrm_aevent_msgsize(struct xfrm_state *x)
 	       + nla_total_size_64bit(sizeof(struct xfrm_lifetime_cur))
 	       + nla_total_size(sizeof(struct xfrm_mark))
 	       + nla_total_size(4) /* XFRM_AE_RTHR */
-	       + nla_total_size(4); /* XFRM_AE_ETHR */
+	       + nla_total_size(4) /* XFRM_AE_ETHR */
+	       + nla_total_size(sizeof(x->dir)); /* XFRMA_SA_DIR */
 }

 static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
@@ -2459,6 +2567,12 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
 	if (err)
 		goto out_cancel;

+	if (x->dir) {
+		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
+		if (err)
+			goto out_cancel;
+	}
+
 	nlmsg_end(skb, nlh);
 	return 0;

@@ -3018,6 +3132,7 @@ EXPORT_SYMBOL_GPL(xfrm_msg_min);
 #undef XMSGSIZE

 const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
+	[XFRMA_UNSPEC]		= { .strict_start_type = XFRMA_SA_DIR },
 	[XFRMA_SA]		= { .len = sizeof(struct xfrm_usersa_info)},
 	[XFRMA_POLICY]		= { .len = sizeof(struct xfrm_userpolicy_info)},
 	[XFRMA_LASTUSED]	= { .type = NLA_U64},
@@ -3049,6 +3164,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
 	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
+	[XFRMA_SA_DIR]          = NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_IN, XFRM_SA_DIR_OUT),
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);

@@ -3189,8 +3305,9 @@ static void xfrm_netlink_rcv(struct sk_buff *skb)

 static inline unsigned int xfrm_expire_msgsize(void)
 {
-	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire))
-	       + nla_total_size(sizeof(struct xfrm_mark));
+	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire)) +
+	       nla_total_size(sizeof(struct xfrm_mark)) +
+	       nla_total_size(sizeof_field(struct xfrm_state, dir));
 }

 static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
@@ -3217,6 +3334,12 @@ static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct
 	if (err)
 		return err;

+	if (x->dir) {
+		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
+		if (err)
+			return err;
+	}
+
 	nlmsg_end(skb, nlh);
 	return 0;
 }
@@ -3324,6 +3447,9 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 	if (x->mapping_maxage)
 		l += nla_total_size(sizeof(x->mapping_maxage));

+	if (x->dir)
+		l += nla_total_size(sizeof(x->dir));
+
 	return l;
 }

--
2.30.2


