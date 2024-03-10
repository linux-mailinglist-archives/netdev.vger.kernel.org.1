Return-Path: <netdev+bounces-79040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0667887785E
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 21:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF701C206A9
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 20:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFFA39FFF;
	Sun, 10 Mar 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="SrTZXPiy"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF833207
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710101048; cv=none; b=hZ0M294luTGR4X6uTkVv4ovuk9MXISLWAemjjv/N9Sojjc1jaDm17qusIp0tOvqAN2eOPK51wxS4zUVe9G6esynwW7jQmohOBDeLT+dC4M7NwNDx0ADn8jxiHgBVgJMrFU1zwwuupAbpLdNdg7z8dkdPzVzHArQjSe2WO6Xaw1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710101048; c=relaxed/simple;
	bh=Rfx45VSyEwn9QMQ0Qjx08u9bsf8rSDXO4QZrueO5HvQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdC7vYmz0LvNrJ+lJs73zAr7yrYycnH9Ldy/WZOb40MBgslnRXNy1S15xHsCeBd0qBTO/R3ceU2PnYvTVdULWlKF+MjsLp5+BCkwqfoQREWr2b+PPs5Gg9LT6g7YkiIZ/8w60JXNM9Qj8PjgoBW+sF97AUwoyaQmzBvXxusWvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SrTZXPiy; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2406720539;
	Sun, 10 Mar 2024 21:03:56 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iu7ETXnhxHkG; Sun, 10 Mar 2024 21:03:55 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 40AA8201A1;
	Sun, 10 Mar 2024 21:03:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 40AA8201A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1710101035;
	bh=rSO8gBp5iNwkHL5gvd0WYXYod3NbFqcUV2CWr7lrEQ0=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=SrTZXPiyMPUI7EmR0ys2KpjhXrbgGtFZ171bgjlcnZXl8FFu0kOAOLcAtkTAjXg/v
	 tiSTW2RKzm5L3kdfFzMyfJYIHo08oN96pGwS/iQLPtyV0HSy58Lb8dzHHS7lVg2aUX
	 ced+D07muAi0ayLslJUiXF6tihV+tQDPIt5rZXWKvp7o870MNQEo5QFTZ83DuNDUpB
	 OaZCZyPCw6isYCNzu+rvQakq9L3aHkmPLzct7t1YqDfoEurAWwFia1OWlm0X+jcpcO
	 0TSn2shjfYJ51XVfGRSrT8JWi3Hw9ouoWeo+W61maYZChIqLxmsm3/oc9+CgqbGos5
	 wLzDe7RNMfhMw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 3013380004A;
	Sun, 10 Mar 2024 21:03:55 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Mar 2024 21:03:54 +0100
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 10 Mar
 2024 21:03:54 +0100
Date: Sun, 10 Mar 2024 21:03:47 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next v2] xfrm: Add Direction to the SA in or out
Message-ID: <2a6015ddeb9dfff93ce6e2e25fec892a0d99acf1.1710100643.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <d84a02e019ef188c4295089f6134af67ef7e7452.1709498351.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d84a02e019ef188c4295089f6134af67ef7e7452.1709498351.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

This patch introduces the 'dir' attribute, 'in' or 'out', to the
xfrm_state, SA, enhancing usability by delineating the scope of values
based on direction. An input SA will now exclusively encompass values
pertinent to input, effectively segregating them from output-related
values. This change aims to streamline the configuration process and
improve the overall clarity of SA attributes.

v1->v2:
 - use .strict_start_type in struct nla_policy xfrma_policy
 - delete redundant XFRM_SA_DIR_MAX enum

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/net/xfrm.h        |  1 +
 include/uapi/linux/xfrm.h |  7 +++++++
 net/xfrm/xfrm_compat.c    |  7 +++++--
 net/xfrm/xfrm_device.c    |  5 +++++
 net/xfrm/xfrm_state.c     |  1 +
 net/xfrm/xfrm_user.c      | 44 +++++++++++++++++++++++++++++++++++----
 6 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 1d107241b901..91348a03469c 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -289,6 +289,7 @@ struct xfrm_state {
 	/* Private data of this transformer, format is opaque,
 	 * interpreted by xfrm_type methods. */
 	void			*data;
+	enum xfrm_sa_dir	dir;
 };

 static inline struct net *xs_net(struct xfrm_state *x)
diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 6a77328be114..46a9770c720c 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -141,6 +141,12 @@ enum {
 	XFRM_POLICY_MAX	= 3
 };

+enum xfrm_sa_dir {
+	XFRM_SA_DIR_UNSET = 0,
+	XFRM_SA_DIR_IN	= 1,
+	XFRM_SA_DIR_OUT	= 2
+};
+
 enum {
 	XFRM_SHARE_ANY,		/* No limitations */
 	XFRM_SHARE_SESSION,	/* For this session only */
@@ -315,6 +321,7 @@ enum xfrm_attr_type_t {
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
index 3784534c9185..11339d7d7140 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -253,6 +253,11 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}

+	if (xuo->flags & XFRM_OFFLOAD_INBOUND && x->dir != XFRM_SA_DIR_IN) {
+		NL_SET_ERR_MSG(extack, "Mismatch in SA and offload direction");
+		return -EINVAL;
+	}
+
 	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;

 	/* We don't yet support UDP encapsulation and TFC padding. */
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index bda5327bf34d..0d6f5a49002f 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1744,6 +1744,7 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
 	x->lastused = orig->lastused;
 	x->new_mapping = 0;
 	x->new_mapping_sport = 0;
+	x->dir = orig->dir;

 	return x;

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ad01997c3aa9..ae9d2edb4769 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -360,6 +360,16 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		}
 	}

+	if (attrs[XFRMA_SA_DIR]) {
+		u8 sa_dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
+
+		if (sa_dir != XFRM_SA_DIR_IN  && sa_dir != XFRM_SA_DIR_OUT)  {
+			NL_SET_ERR_MSG(extack, "XFRMA_SA_DIR attribute is out of range");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
 out:
 	return err;
 }
@@ -627,6 +637,7 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
 	struct nlattr *et = attrs[XFRMA_ETIMER_THRESH];
 	struct nlattr *rt = attrs[XFRMA_REPLAY_THRESH];
 	struct nlattr *mt = attrs[XFRMA_MTIMER_THRESH];
+	struct nlattr *dir = attrs[XFRMA_SA_DIR];

 	if (re && x->replay_esn && x->preplay_esn) {
 		struct xfrm_replay_state_esn *replay_esn;
@@ -661,6 +672,9 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,

 	if (mt)
 		x->mapping_maxage = nla_get_u32(mt);
+
+	if (dir)
+		x->dir = nla_get_u8(dir);
 }

 static void xfrm_smark_init(struct nlattr **attrs, struct xfrm_mark *m)
@@ -1182,8 +1196,13 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
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
@@ -2399,7 +2418,8 @@ static inline unsigned int xfrm_aevent_msgsize(struct xfrm_state *x)
 	       + nla_total_size_64bit(sizeof(struct xfrm_lifetime_cur))
 	       + nla_total_size(sizeof(struct xfrm_mark))
 	       + nla_total_size(4) /* XFRM_AE_RTHR */
-	       + nla_total_size(4); /* XFRM_AE_ETHR */
+	       + nla_total_size(4) /* XFRM_AE_ETHR */
+	       + nla_total_size(sizeof(x->dir)); /* XFRMA_SA_DIR */
 }

 static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
@@ -2453,6 +2473,11 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
 		goto out_cancel;

 	err = xfrm_if_id_put(skb, x->if_id);
+	if (err)
+		goto out_cancel;
+	if (x->dir)
+		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
+
 	if (err)
 		goto out_cancel;

@@ -3015,6 +3040,7 @@ EXPORT_SYMBOL_GPL(xfrm_msg_min);
 #undef XMSGSIZE

 const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
+	[XFRMA_UNSPEC]		= { .strict_start_type = XFRMA_SA_DIR },
 	[XFRMA_SA]		= { .len = sizeof(struct xfrm_usersa_info)},
 	[XFRMA_POLICY]		= { .len = sizeof(struct xfrm_userpolicy_info)},
 	[XFRMA_LASTUSED]	= { .type = NLA_U64},
@@ -3046,6 +3072,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
 	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
+	[XFRMA_SA_DIR]          = { .type = NLA_U8 }
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);

@@ -3186,8 +3213,9 @@ static void xfrm_netlink_rcv(struct sk_buff *skb)

 static inline unsigned int xfrm_expire_msgsize(void)
 {
-	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire))
-	       + nla_total_size(sizeof(struct xfrm_mark));
+	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire)) +
+	       nla_total_size(sizeof(struct xfrm_mark)) +
+	       nla_total_size(sizeof_field(struct xfrm_state, dir));
 }

 static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
@@ -3214,6 +3242,11 @@ static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct
 	if (err)
 		return err;

+	if (x->dir)
+		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
+	if (err)
+		return err;
+
 	nlmsg_end(skb, nlh);
 	return 0;
 }
@@ -3321,6 +3354,9 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 	if (x->mapping_maxage)
 		l += nla_total_size(sizeof(x->mapping_maxage));

+	if (x->dir)
+		l += nla_total_size(sizeof(x->dir));
+
 	return l;
 }

--
2.30.2


