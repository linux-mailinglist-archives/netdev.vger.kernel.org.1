Return-Path: <netdev+bounces-85227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17359899D35
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C161C21917
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A09015FA95;
	Fri,  5 Apr 2024 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="i0ZaZMyJ"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE941649DF
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320833; cv=none; b=WphCAhLauKP6B1omPoFAdmr29JZL83kTV7jZQ7uIgisMgNXKc5v0UXbXrdpjKntCS28FpW18OU+24NTK/AmCTUZqUUOlMY+a4V9Wgeqd6eNj+VLY4cvPvcnnSrsCmzI4JmimPEuZOaxrK8SBaRyFMz286FhAL0b/jcI53ozic9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320833; c=relaxed/simple;
	bh=7uOs+L6aPhxx7PNYJimMgn5NFVvaJiV8W6PCKyaqT/k=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t/Bxq64a476AVbf50HOApig5ikVg9+Pf0nkIFr0mL3xRveFowySt25AhSs4SCRUM1X3iVoh90qbwPQYk9WRHInJ2JqN1cD4NMp3MRx/vcf3BhxLwfDBrobBQxp/ZcdSLGyDrWq4Utb9Ey8TvS4nxLFb5K+FpEr0itABgt2dvFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=i0ZaZMyJ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 4DC18208C3;
	Fri,  5 Apr 2024 14:40:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nT6fDBlzgdlA; Fri,  5 Apr 2024 14:40:21 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 0A939208AE;
	Fri,  5 Apr 2024 14:40:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 0A939208AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712320821;
	bh=5o7jkibJ+E9VHIwmUOzqF5+wJkTqTFRDkRBfjW1iJeE=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=i0ZaZMyJ0JLTVbmFuBZ6A3nDmcHEFkC5NsRZ58K9kWrb8M9n3tvR1rrWiJG8pZOGv
	 ottb9pG/90YONwRBRNqI1gdzjAYc3JKm1tSTbyfSGvCk6CzxQM8yeHx5H9P2cqgww+
	 OxR0NZDqegRbGjRduGV+rYB5crbdU9gtMUpfIzFSkxgi7nGDgP0rl2hHPj1PPH2z9c
	 u9dFrF6qT/Xbsnxce1gqqI/7U24mzViVcdDg9A2AZ6GJZ1zmccfjFB9mOLCGNiMwyO
	 dVWEAampxV0auUi9mG0BrmbrLXSzfxmcDsUvlLn77no+LwucYNZjjUdMbMuARomZyC
	 QBK7I4AOMsInA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id EE63E80004A;
	Fri,  5 Apr 2024 14:40:20 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 14:40:20 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 5 Apr
 2024 14:40:20 +0200
Date: Fri, 5 Apr 2024 14:40:07 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>
Subject: [PATCH ipsec-next v6] xfrm: Add Direction to the SA in or out
Message-ID: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

This patch introduces the 'dir' attribute, 'in' or 'out', to the
xfrm_state, SA, enhancing usability by delineating the scope of values
based on direction. An input SA will now exclusively encompass values
pertinent to input, effectively segregating them from output-related
values. This change aims to streamline the configuration process and
improve the overall clarity of SA attributes.

This feature sets the groundwork for future patches, including
the upcoming IP-TFS patch.

Currently, dir is only allowed when HW OFFLOAD is set.

---
v5->v6:
 - XFRMA_SA_DIR only allowed with HW OFFLOAD

v4->v5:
 - add details to commit message

v3->v4:
 - improve HW OFFLOAD DIR check check other direction

v2->v3:
 - delete redundant XFRM_SA_DIR_USE
 - use u8 for "dir"
 - fix HW OFFLOAD DIR check

v1->v2:
 - use .strict_start_type in struct nla_policy xfrma_policy
 - delete redundant XFRM_SA_DIR_MAX enum
---

Signed-off-by: Antony Antony <antony.antony@secunet.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/xfrm.h        |  1 +
 include/uapi/linux/xfrm.h |  6 +++++
 net/xfrm/xfrm_compat.c    |  7 ++++--
 net/xfrm/xfrm_device.c    |  6 +++++
 net/xfrm/xfrm_state.c     |  1 +
 net/xfrm/xfrm_user.c      | 52 ++++++++++++++++++++++++++++++++++++---
 6 files changed, 67 insertions(+), 6 deletions(-)

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
index 655fe4ff8621..007dee03b1bc 100644
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
+	[XFRMA_SA_DIR]          = { .type = NLA_U8}
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
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 0c306473a79d..749c9cf41c06 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1744,6 +1744,7 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
 	x->lastused = orig->lastused;
 	x->new_mapping = 0;
 	x->new_mapping_sport = 0;
+	x->dir = orig->dir;

 	return x;

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 810b520493f3..c26f26a100a1 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -360,6 +360,22 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		}
 	}

+	if (attrs[XFRMA_SA_DIR]) {
+		u8 sa_dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
+
+		if (sa_dir != XFRM_SA_DIR_IN && sa_dir != XFRM_SA_DIR_OUT)  {
+			NL_SET_ERR_MSG(extack, "XFRMA_SA_DIR attribute is out of range");
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (!attrs[XFRMA_OFFLOAD_DEV]) {
+			NL_SET_ERR_MSG(extack, "Missing required offload attribute for XFRMA_SA_DIR");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
 out:
 	return err;
 }
@@ -627,6 +643,7 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
 	struct nlattr *et = attrs[XFRMA_ETIMER_THRESH];
 	struct nlattr *rt = attrs[XFRMA_REPLAY_THRESH];
 	struct nlattr *mt = attrs[XFRMA_MTIMER_THRESH];
+	struct nlattr *dir = attrs[XFRMA_SA_DIR];

 	if (re && x->replay_esn && x->preplay_esn) {
 		struct xfrm_replay_state_esn *replay_esn;
@@ -661,6 +678,9 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,

 	if (mt)
 		x->mapping_maxage = nla_get_u32(mt);
+
+	if (dir)
+		x->dir = nla_get_u8(dir);
 }

 static void xfrm_smark_init(struct nlattr **attrs, struct xfrm_mark *m)
@@ -1182,8 +1202,13 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
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
@@ -2402,7 +2427,8 @@ static inline unsigned int xfrm_aevent_msgsize(struct xfrm_state *x)
 	       + nla_total_size_64bit(sizeof(struct xfrm_lifetime_cur))
 	       + nla_total_size(sizeof(struct xfrm_mark))
 	       + nla_total_size(4) /* XFRM_AE_RTHR */
-	       + nla_total_size(4); /* XFRM_AE_ETHR */
+	       + nla_total_size(4) /* XFRM_AE_ETHR */
+	       + nla_total_size(sizeof(x->dir)); /* XFRMA_SA_DIR */
 }

 static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
@@ -2459,6 +2485,12 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
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

@@ -3018,6 +3050,7 @@ EXPORT_SYMBOL_GPL(xfrm_msg_min);
 #undef XMSGSIZE

 const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
+	[XFRMA_UNSPEC]		= { .strict_start_type = XFRMA_SA_DIR },
 	[XFRMA_SA]		= { .len = sizeof(struct xfrm_usersa_info)},
 	[XFRMA_POLICY]		= { .len = sizeof(struct xfrm_userpolicy_info)},
 	[XFRMA_LASTUSED]	= { .type = NLA_U64},
@@ -3049,6 +3082,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
 	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
+	[XFRMA_SA_DIR]          = { .type = NLA_U8 }
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);

@@ -3189,8 +3223,9 @@ static void xfrm_netlink_rcv(struct sk_buff *skb)

 static inline unsigned int xfrm_expire_msgsize(void)
 {
-	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire))
-	       + nla_total_size(sizeof(struct xfrm_mark));
+	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire)) +
+	       nla_total_size(sizeof(struct xfrm_mark)) +
+	       nla_total_size(sizeof_field(struct xfrm_state, dir));
 }

 static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
@@ -3217,6 +3252,12 @@ static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct
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
@@ -3324,6 +3365,9 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 	if (x->mapping_maxage)
 		l += nla_total_size(sizeof(x->mapping_maxage));

+	if (x->dir)
+		l += nla_total_size(sizeof(x->dir));
+
 	return l;
 }

--
2.30.2


