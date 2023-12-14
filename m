Return-Path: <netdev+bounces-57352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E69812EBA
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6231C21500
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AE4405D2;
	Thu, 14 Dec 2023 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="AhJPn7dz"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95838124
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:36:59 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 690F7204B4;
	Thu, 14 Dec 2023 12:36:58 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nokvKXgLX261; Thu, 14 Dec 2023 12:36:57 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7E3B420885;
	Thu, 14 Dec 2023 12:36:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7E3B420885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1702553816;
	bh=3ooGqUkos6NTzqg/FxqBEiEuNxgzFFVnxB6Hs6p3x7E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=AhJPn7dzP+OO315LNuBls2jVSQq2LQWOt1oCR52jqlGsZ6hY4D6mDrZ09lZBF7mtv
	 evylev8yf+mAit/w8yVwyfWOQ7K/5hLwqOA0bOnDH6fRTLyhPogHl83VoJeS1v18nZ
	 cqL1bDOmFicfZoaDIQzyb9c7yHCpSlsXVG1ubJBDeYAF1c9zxHvrzArtBOF1+Xqq3a
	 adpeqw3jyYNT/MUlWA2UOUAi5G/S/Hqf3SJvg1duSLYTj+t1W7ykwaVdA989HGS82t
	 aWvUCgAzcW4H4mQjdLQVPfebVBLlx0NMMV7yqpM08h2XGftbownh6HHsxsJcr3JVm/
	 OnmNjgvCqb8vw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 79DC880004A;
	Thu, 14 Dec 2023 12:36:56 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 14 Dec 2023 12:36:56 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 12:36:55 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8337A3180D2B; Thu, 14 Dec 2023 12:36:55 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH RFC ipsec-next 1/3] xfrm: Add support for per cpu xfrm state handling.
Date: Thu, 14 Dec 2023 12:36:43 +0100
Message-ID: <20231214113645.2416005-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214113645.2416005-1-steffen.klassert@secunet.com>
References: <20231214113645.2416005-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Currently all flows for a certain SA must be processed by the same
cpu to avoid packet reordering and lock contention of the xfrm
state lock.

To get rid of this limitation, the IETF is about to standardize
per cpu SAs. This patch implements the xfrm part of it:

https://datatracker.ietf.org/doc/draft-ietf-ipsecme-multi-sa-performance/

This adds the cpu as a lookup key for xfrm states and a config option
to generate acquire messages for each cpu.

With that, we can have on each cpu a SA with identical traffic selector
so that flows can be processed in parallel on all cpu.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h        |  5 ++--
 include/uapi/linux/xfrm.h |  2 ++
 net/key/af_key.c          |  7 +++---
 net/xfrm/xfrm_state.c     | 49 ++++++++++++++++++++++++++++++---------
 net/xfrm/xfrm_user.c      | 43 ++++++++++++++++++++++++++++++++--
 5 files changed, 88 insertions(+), 18 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index c9bb0f892f55..8c5ea1802fda 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -183,6 +183,7 @@ struct xfrm_state {
 	refcount_t		refcnt;
 	spinlock_t		lock;
 
+	u32			pcpu_num;
 	struct xfrm_id		id;
 	struct xfrm_selector	sel;
 	struct xfrm_mark	mark;
@@ -1639,7 +1640,7 @@ struct xfrmk_spdinfo {
 	u32 spdhmcnt;
 };
 
-struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq);
+struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num);
 int xfrm_state_delete(struct xfrm_state *x);
 int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync);
 int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_valid);
@@ -1754,7 +1755,7 @@ int verify_spi_info(u8 proto, u32 min, u32 max, struct netlink_ext_ack *extack);
 int xfrm_alloc_spi(struct xfrm_state *x, u32 minspi, u32 maxspi,
 		   struct netlink_ext_ack *extack);
 struct xfrm_state *xfrm_find_acq(struct net *net, const struct xfrm_mark *mark,
-				 u8 mode, u32 reqid, u32 if_id, u8 proto,
+				 u8 mode, u32 reqid, u32 if_id, u32 pcpu_num, u8 proto,
 				 const xfrm_address_t *daddr,
 				 const xfrm_address_t *saddr, int create,
 				 unsigned short family);
diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
index 6a77328be114..1703b6fc868e 100644
--- a/include/uapi/linux/xfrm.h
+++ b/include/uapi/linux/xfrm.h
@@ -315,6 +315,7 @@ enum xfrm_attr_type_t {
 	XFRMA_SET_MARK_MASK,	/* __u32 */
 	XFRMA_IF_ID,		/* __u32 */
 	XFRMA_MTIMER_THRESH,	/* __u32 in seconds for input SA */
+	XFRMA_SA_PCPU,		/* __u32 */
 	__XFRMA_MAX
 
 #define XFRMA_OUTPUT_MARK XFRMA_SET_MARK	/* Compatibility */
@@ -430,6 +431,7 @@ struct xfrm_userpolicy_info {
 #define XFRM_POLICY_LOCALOK	1	/* Allow user to override global policy */
 	/* Automatically expand selector to include matching ICMP payloads. */
 #define XFRM_POLICY_ICMP	2
+#define XFRM_POLICY_CPU_ACQUIRE	4
 	__u8				share;
 };
 
diff --git a/net/key/af_key.c b/net/key/af_key.c
index d68d01804dc7..600c4f829905 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1354,7 +1354,7 @@ static int pfkey_getspi(struct sock *sk, struct sk_buff *skb, const struct sadb_
 	}
 
 	if (hdr->sadb_msg_seq) {
-		x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq);
+		x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq, 0);
 		if (x && !xfrm_addr_equal(&x->id.daddr, xdaddr, family)) {
 			xfrm_state_put(x);
 			x = NULL;
@@ -1362,7 +1362,8 @@ static int pfkey_getspi(struct sock *sk, struct sk_buff *skb, const struct sadb_
 	}
 
 	if (!x)
-		x = xfrm_find_acq(net, &dummy_mark, mode, reqid, 0, proto, xdaddr, xsaddr, 1, family);
+		x = xfrm_find_acq(net, &dummy_mark, mode, reqid, 0, 0, proto,
+				  xdaddr, xsaddr, 1, family);
 
 	if (x == NULL)
 		return -ENOENT;
@@ -1417,7 +1418,7 @@ static int pfkey_acquire(struct sock *sk, struct sk_buff *skb, const struct sadb
 	if (hdr->sadb_msg_seq == 0 || hdr->sadb_msg_errno == 0)
 		return 0;
 
-	x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq);
+	x = xfrm_find_acq_byseq(net, DUMMY_MARK, hdr->sadb_msg_seq, 0);
 	if (x == NULL)
 		return 0;
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index bda5327bf34d..b5caac4678f7 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -677,6 +677,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		x->lft.hard_packet_limit = XFRM_INF;
 		x->replay_maxage = 0;
 		x->replay_maxdiff = 0;
+		x->pcpu_num = UINT_MAX;
 		spin_lock_init(&x->lock);
 	}
 	return x;
@@ -972,6 +973,7 @@ xfrm_init_tempstate(struct xfrm_state *x, const struct flowi *fl,
 	x->props.mode = tmpl->mode;
 	x->props.reqid = tmpl->reqid;
 	x->props.family = tmpl->encap_family;
+	x->type_offload = NULL;
 }
 
 static struct xfrm_state *__xfrm_state_lookup_all(struct net *net, u32 mark,
@@ -1096,6 +1098,9 @@ static void xfrm_state_look_at(struct xfrm_policy *pol, struct xfrm_state *x,
 			       struct xfrm_state **best, int *acq_in_progress,
 			       int *error)
 {
+	unsigned int pcpu_id = get_cpu();
+	put_cpu();
+
 	/* Resolution logic:
 	 * 1. There is a valid state with matching selector. Done.
 	 * 2. Valid state with inappropriate selector. Skip.
@@ -1115,13 +1120,18 @@ static void xfrm_state_look_at(struct xfrm_policy *pol, struct xfrm_state *x,
 							&fl->u.__fl_common))
 			return;
 
+		if (x->pcpu_num != UINT_MAX && x->pcpu_num != pcpu_id)
+			return;
+
 		if (!*best ||
+		    ((*best)->pcpu_num == UINT_MAX && x->pcpu_num == pcpu_id) ||
 		    (*best)->km.dying > x->km.dying ||
 		    ((*best)->km.dying == x->km.dying &&
 		     (*best)->curlft.add_time < x->curlft.add_time))
 			*best = x;
 	} else if (x->km.state == XFRM_STATE_ACQ) {
-		*acq_in_progress = 1;
+		if (!*best || (*best && x->pcpu_num == pcpu_id))
+			*acq_in_progress = 1;
 	} else if (x->km.state == XFRM_STATE_ERROR ||
 		   x->km.state == XFRM_STATE_EXPIRED) {
 		if ((!x->sel.family ||
@@ -1150,6 +1160,8 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	unsigned short encap_family = tmpl->encap_family;
 	unsigned int sequence;
 	struct km_event c;
+	unsigned int pcpu_id = get_cpu();
+	put_cpu();
 
 	to_put = NULL;
 
@@ -1223,7 +1235,10 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	}
 
 found:
-	x = best;
+	if (!(pol->flags & XFRM_POLICY_CPU_ACQUIRE) ||
+	    (best && (best->pcpu_num == pcpu_id)))
+		x = best;
+
 	if (!x && !error && !acquire_in_progress) {
 		if (tmpl->id.spi &&
 		    (x0 = __xfrm_state_lookup_all(net, mark, daddr,
@@ -1255,6 +1270,8 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		xfrm_init_tempstate(x, fl, tmpl, daddr, saddr, family);
 		memcpy(&x->mark, &pol->mark, sizeof(x->mark));
 		x->if_id = if_id;
+		if ((pol->flags & XFRM_POLICY_CPU_ACQUIRE) && best)
+			x->pcpu_num = pcpu_id;
 
 		error = security_xfrm_state_alloc_acquire(x, pol->security, fl->flowi_secid);
 		if (error) {
@@ -1333,6 +1350,9 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			x = NULL;
 			error = -ESRCH;
 		}
+
+		if (best)
+			x = best;
 	}
 out:
 	if (x) {
@@ -1464,12 +1484,14 @@ static void __xfrm_state_bump_genids(struct xfrm_state *xnew)
 	unsigned int h;
 	u32 mark = xnew->mark.v & xnew->mark.m;
 	u32 if_id = xnew->if_id;
+	u32 cpu_id = xnew->pcpu_num;
 
 	h = xfrm_dst_hash(net, &xnew->id.daddr, &xnew->props.saddr, reqid, family);
 	hlist_for_each_entry(x, net->xfrm.state_bydst+h, bydst) {
 		if (x->props.family	== family &&
 		    x->props.reqid	== reqid &&
 		    x->if_id		== if_id &&
+		    x->pcpu_num		== cpu_id &&
 		    (mark & x->mark.m) == x->mark.v &&
 		    xfrm_addr_equal(&x->id.daddr, &xnew->id.daddr, family) &&
 		    xfrm_addr_equal(&x->props.saddr, &xnew->props.saddr, family))
@@ -1492,7 +1514,7 @@ EXPORT_SYMBOL(xfrm_state_insert);
 static struct xfrm_state *__find_acq_core(struct net *net,
 					  const struct xfrm_mark *m,
 					  unsigned short family, u8 mode,
-					  u32 reqid, u32 if_id, u8 proto,
+					  u32 reqid, u32 if_id, u32 pcpu_num, u8 proto,
 					  const xfrm_address_t *daddr,
 					  const xfrm_address_t *saddr,
 					  int create)
@@ -1509,6 +1531,7 @@ static struct xfrm_state *__find_acq_core(struct net *net,
 		    x->id.spi       != 0 ||
 		    x->id.proto	    != proto ||
 		    (mark & x->mark.m) != x->mark.v ||
+		    x->pcpu_num != pcpu_num ||
 		    !xfrm_addr_equal(&x->id.daddr, daddr, family) ||
 		    !xfrm_addr_equal(&x->props.saddr, saddr, family))
 			continue;
@@ -1542,6 +1565,7 @@ static struct xfrm_state *__find_acq_core(struct net *net,
 			break;
 		}
 
+		x->pcpu_num = pcpu_num;
 		x->km.state = XFRM_STATE_ACQ;
 		x->id.proto = proto;
 		x->props.family = family;
@@ -1570,7 +1594,7 @@ static struct xfrm_state *__find_acq_core(struct net *net,
 	return x;
 }
 
-static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq);
+static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num);
 
 int xfrm_state_add(struct xfrm_state *x)
 {
@@ -1596,7 +1620,7 @@ int xfrm_state_add(struct xfrm_state *x)
 	}
 
 	if (use_spi && x->km.seq) {
-		x1 = __xfrm_find_acq_byseq(net, mark, x->km.seq);
+		x1 = __xfrm_find_acq_byseq(net, mark, x->km.seq, x->pcpu_num);
 		if (x1 && ((x1->id.proto != x->id.proto) ||
 		    !xfrm_addr_equal(&x1->id.daddr, &x->id.daddr, family))) {
 			to_put = x1;
@@ -1606,7 +1630,7 @@ int xfrm_state_add(struct xfrm_state *x)
 
 	if (use_spi && !x1)
 		x1 = __find_acq_core(net, &x->mark, family, x->props.mode,
-				     x->props.reqid, x->if_id, x->id.proto,
+				     x->props.reqid, x->if_id, x->pcpu_num, x->id.proto,
 				     &x->id.daddr, &x->props.saddr, 0);
 
 	__xfrm_state_bump_genids(x);
@@ -1731,6 +1755,7 @@ static struct xfrm_state *xfrm_state_clone(struct xfrm_state *orig,
 	x->props.flags = orig->props.flags;
 	x->props.extra_flags = orig->props.extra_flags;
 
+	x->pcpu_num = orig->pcpu_num;
 	x->if_id = orig->if_id;
 	x->tfcpad = orig->tfcpad;
 	x->replay_maxdiff = orig->replay_maxdiff;
@@ -1986,13 +2011,14 @@ EXPORT_SYMBOL(xfrm_state_lookup_byaddr);
 
 struct xfrm_state *
 xfrm_find_acq(struct net *net, const struct xfrm_mark *mark, u8 mode, u32 reqid,
-	      u32 if_id, u8 proto, const xfrm_address_t *daddr,
+	      u32 if_id, u32 pcpu_num, u8 proto, const xfrm_address_t *daddr,
 	      const xfrm_address_t *saddr, int create, unsigned short family)
 {
 	struct xfrm_state *x;
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
-	x = __find_acq_core(net, mark, family, mode, reqid, if_id, proto, daddr, saddr, create);
+	x = __find_acq_core(net, mark, family, mode, reqid, if_id, pcpu_num,
+			    proto, daddr, saddr, create);
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
 	return x;
@@ -2127,7 +2153,7 @@ xfrm_state_sort(struct xfrm_state **dst, struct xfrm_state **src, int n,
 
 /* Silly enough, but I'm lazy to build resolution list */
 
-static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq)
+static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num)
 {
 	unsigned int h = xfrm_seq_hash(net, seq);
 	struct xfrm_state *x;
@@ -2135,6 +2161,7 @@ static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 s
 	hlist_for_each_entry_rcu(x, net->xfrm.state_byseq + h, byseq) {
 		if (x->km.seq == seq &&
 		    (mark & x->mark.m) == x->mark.v &&
+		    x->pcpu_num == pcpu_num &&
 		    x->km.state == XFRM_STATE_ACQ) {
 			xfrm_state_hold(x);
 			return x;
@@ -2144,12 +2171,12 @@ static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 s
 	return NULL;
 }
 
-struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq)
+struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num)
 {
 	struct xfrm_state *x;
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
-	x = __xfrm_find_acq_byseq(net, mark, seq);
+	x = __xfrm_find_acq_byseq(net, mark, seq, pcpu_num);
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 	return x;
 }
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ad01997c3aa9..1ee7d09d8677 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -734,6 +734,12 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 	if (attrs[XFRMA_IF_ID])
 		x->if_id = nla_get_u32(attrs[XFRMA_IF_ID]);
 
+	if (attrs[XFRMA_SA_PCPU]) {
+		x->pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
+		if (x->pcpu_num >= num_possible_cpus())
+			goto error;
+	}
+
 	err = __xfrm_init_state(x, false, attrs[XFRMA_OFFLOAD_DEV], extack);
 	if (err)
 		goto error;
@@ -1182,6 +1188,11 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
 		if (ret)
 			goto out;
 	}
+	if (x->pcpu_num != UINT_MAX) {
+		ret = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
+		if (ret)
+			goto out;
+	}
 	if (x->mapping_maxage)
 		ret = nla_put_u32(skb, XFRMA_MTIMER_THRESH, x->mapping_maxage);
 out:
@@ -1579,6 +1590,7 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 	u32 mark;
 	struct xfrm_mark m;
 	u32 if_id = 0;
+	u32 pcpu_num = UINT_MAX;
 
 	p = nlmsg_data(nlh);
 	err = verify_spi_info(p->info.id.proto, p->min, p->max, extack);
@@ -1595,8 +1607,16 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (attrs[XFRMA_IF_ID])
 		if_id = nla_get_u32(attrs[XFRMA_IF_ID]);
 
+	if (attrs[XFRMA_SA_PCPU]) {
+		pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
+		if (pcpu_num >= num_possible_cpus()) {
+			err = -EINVAL;
+			goto out_noput;
+		}
+	}
+
 	if (p->info.seq) {
-		x = xfrm_find_acq_byseq(net, mark, p->info.seq);
+		x = xfrm_find_acq_byseq(net, mark, p->info.seq, pcpu_num);
 		if (x && !xfrm_addr_equal(&x->id.daddr, daddr, family)) {
 			xfrm_state_put(x);
 			x = NULL;
@@ -1605,7 +1625,7 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (!x)
 		x = xfrm_find_acq(net, &m, p->info.mode, p->info.reqid,
-				  if_id, p->info.id.proto, daddr,
+				  if_id, pcpu_num, p->info.id.proto, daddr,
 				  &p->info.saddr, 1,
 				  family);
 	err = -ENOENT;
@@ -2455,6 +2475,8 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
 	err = xfrm_if_id_put(skb, x->if_id);
 	if (err)
 		goto out_cancel;
+	if (x->pcpu_num != UINT_MAX)
+		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
 
 	nlmsg_end(skb, nlh);
 	return 0;
@@ -2719,6 +2741,13 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	xfrm_mark_get(attrs, &mark);
 
+	if (attrs[XFRMA_SA_PCPU]) {
+		x->pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
+		err = -EINVAL;
+		if (x->pcpu_num >= num_possible_cpus())
+			goto free_state;
+	}
+
 	err = verify_newpolicy_info(&ua->policy, extack);
 	if (err)
 		goto free_state;
@@ -3046,6 +3075,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
 	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
+	[XFRMA_SA_PCPU]		= { .type = NLA_U32 },
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);
 
@@ -3213,6 +3243,11 @@ static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct
 	err = xfrm_if_id_put(skb, x->if_id);
 	if (err)
 		return err;
+	if (x->pcpu_num != UINT_MAX) {
+		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
+		if (err)
+			return err;
+	}
 
 	nlmsg_end(skb, nlh);
 	return 0;
@@ -3314,6 +3349,8 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 	}
 	if (x->if_id)
 		l += nla_total_size(sizeof(x->if_id));
+	if (x->pcpu_num)
+		l += nla_total_size(sizeof(x->pcpu_num));
 
 	/* Must count x->lastused as it may become non-zero behind our back. */
 	l += nla_total_size_64bit(sizeof(u64));
@@ -3450,6 +3487,8 @@ static int build_acquire(struct sk_buff *skb, struct xfrm_state *x,
 		err = xfrm_if_id_put(skb, xp->if_id);
 	if (!err && xp->xdo.dev)
 		err = copy_user_offload(&xp->xdo, skb);
+	if (!err && x->pcpu_num != UINT_MAX)
+		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
 	if (err) {
 		nlmsg_cancel(skb, nlh);
 		return err;
-- 
2.34.1


