Return-Path: <netdev+bounces-76924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF1F86F722
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 22:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF311C20952
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F348379B74;
	Sun,  3 Mar 2024 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="BGuQZ4m1"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105CBA957
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709500153; cv=none; b=dYPfNgW3TsKutvVznwj04bckqEraBBMiiHQbuomzFDTfPRdp3l+P+l+o0C6FLY/gyju+lNcIEzHzgE6xJoKB4F/A04Dvo932Yr7+mpEuyBNKt5meTFRN8Aall+Y5p1q2bQxFFFHGE0kSriv3VV6Uvn3ETv/sZsZdhkH7GavZYtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709500153; c=relaxed/simple;
	bh=vtVR9ZOMBU7ygXJHsZw/nVmNbARzHuZTuf0r3kXaugE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QWnGQHR2LIXmQI9OKDuTDQi/JTaMdWnQtidfgq+2OT7DsmQG5+lmH0bU9FQHLS8qYdJy45ROZ0S7Lmay1YwsxItQTpE8UPSVWNMGVSo4/o7YVCT2Fyn5r63iZyGrulBFM7vHtK5WOhNI3zMwYSBES+eTGPDgR9sezwukvnGJOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=BGuQZ4m1; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 587E120612;
	Sun,  3 Mar 2024 22:09:02 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JkRAQEp-Yr-4; Sun,  3 Mar 2024 22:09:01 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7F46720519;
	Sun,  3 Mar 2024 22:09:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7F46720519
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709500141;
	bh=vKDYsU72XYUKNO3py3OJoh81K51tZZrdrKSYXFEM2Ec=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=BGuQZ4m1dY0hPWJ6hoSTfmI71J1Cg+7CnXfnfrNjuJeHHmztFKee/FIBQYQ9Dl0dV
	 LF3G4hCnLpqBPdPhRNt2kMBYWirDzm19RhxLF7fs/wcEBFSFuZgadHT9KPHC5M2viL
	 SUhpaRgN4ASKCKGLRjyaPlZREFTKnMamPNNq5ICC4xEVxKSfKPEs28eARuSrQKd+vT
	 uafCOCf0WY7ZCBU5NNMJvgiN7WnJ7SLXRVG2BuZ9kJ0izEk4VRI51rr0tCJccX9AO8
	 2iJx/Q3oBpdmBFOpgjSwPGqMXE5U9eN9KqRMrHc+vO+cCaTCbtRV5LB95Lx7+1vFJ0
	 63dpGU88xZ0Gg==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 6CA4080004A;
	Sun,  3 Mar 2024 22:09:01 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 22:09:01 +0100
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 3 Mar
 2024 22:09:00 +0100
Date: Sun, 3 Mar 2024 22:08:41 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next] xfrm: Add Direction to the SA in or out
Message-ID: <d84a02e019ef188c4295089f6134af67ef7e7452.1709498351.git.antony.antony@secunet.com>
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
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

This patch introduces the 'dir' attribute, 'in' or 'out', to the
xfrm_state, SA, enhancing usability by delineating the scope of values
based on direction. An input SA will now exclusively encompass values
pertinent to input, effectively segregating them from output-related
values. This change aims to streamline the configuration process and
improve the overall clarity of SA attributes.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 include/net/xfrm.h        |  1 +
 include/uapi/linux/xfrm.h |  8 ++++++++
 net/xfrm/xfrm_compat.c    |  6 ++++--
 net/xfrm/xfrm_device.c    |  5 +++++
 net/xfrm/xfrm_state.c     |  1 +
 net/xfrm/xfrm_user.c      | 43 +++++++++++++++++++++++++++++++++++----
 6 files changed, 58 insertions(+), 6 deletions(-)

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
index 6a77328be114..2f1d67239301 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -141,6 +141,13 @@ enum {
 	XFRM_POLICY_MAX	= 3
 };
 
+enum xfrm_sa_dir {
+	XFRM_SA_DIR_UNSET = 0,
+	XFRM_SA_DIR_IN	= 1,
+	XFRM_SA_DIR_OUT	= 2,
+	XFRM_SA_DIR_MAX = 3,
+};
+
 enum {
 	XFRM_SHARE_ANY,		/* No limitations */
 	XFRM_SHARE_SESSION,	/* For this session only */
@@ -315,6 +322,7 @@ enum xfrm_attr_type_t {
 	XFRMA_SET_MARK_MASK,	/* __u32 */
 	XFRMA_IF_ID,		/* __u32 */
 	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
+	XFRMA_SA_DIR,		/* __u8 */
 	__XFRMA_MAX
 
 #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index 655fe4ff8621..de0e1508f870 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -129,6 +129,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
 	[XFRMA_MTIMER_THRESH]	= { .type = NLA_U32 },
+	[XFRMA_SA_DIR]		= { .type = NLA_U8 },
 };
 
 static struct nlmsghdr *xfrm_nlmsg_put_compat(struct sk_buff *skb,
@@ -277,9 +278,10 @@ static int xfrm_xlate64_attr(struct sk_buff *dst, const struct nlattr *src)
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
@@ -434,7 +436,7 @@ static int xfrm_xlate32_attr(void *dst, const struct nlattr *nla,
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
index ad01997c3aa9..fe4576e96dd4 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -360,6 +360,16 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		}
 	}
 
+	if (attrs[XFRMA_SA_DIR]) {
+		u8 sa_dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
+
+		if (!sa_dir || sa_dir >= XFRM_SA_DIR_MAX)  {
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
 
@@ -3046,6 +3071,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
 	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
+	[XFRMA_SA_DIR]		= { .type = NLA_U8 },
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);
 
@@ -3186,8 +3212,9 @@ static void xfrm_netlink_rcv(struct sk_buff *skb)
 
 static inline unsigned int xfrm_expire_msgsize(void)
 {
-	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire))
-	       + nla_total_size(sizeof(struct xfrm_mark));
+	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire)) +
+	       nla_total_size(sizeof(struct xfrm_mark)) +
+	       nla_total_size(sizeof_field(struct xfrm_state, dir));
 }
 
 static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
@@ -3214,6 +3241,11 @@ static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct
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
@@ -3321,6 +3353,9 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 	if (x->mapping_maxage)
 		l += nla_total_size(sizeof(x->mapping_maxage));
 
+	if (x->dir)
+		l += nla_total_size(sizeof(x->dir));
+
 	return l;
 }
 
-- 
2.30.2


