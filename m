Return-Path: <netdev+bounces-300981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3IvnN3nrOGpQkAcAu9opvQ
	(envelope-from <netdev+bounces-300981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:59:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FACA6AD773
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:59:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=t8iEvVSZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300981-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300981-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACB1A303E4D2
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568FB38399E;
	Mon, 22 Jun 2026 07:57:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6B38398E
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 07:57:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115068; cv=none; b=M73N2AbsUIxxX5gfguv28Jv3xeVjHBhvOyhA2PcHXPjCS2GzuvHdjwpxrGZy0fYAgD2afomqdLSHgN1z3UbuBot0OKltBe4pG/qYR4Q6ZG9ElKhgmynlVp3Ddywuu+NfZn8lrcF0cFYbrUOFXA3xeIf5B85KcAYri7MAMULphEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115068; c=relaxed/simple;
	bh=U3SQIXfEQlLs1/iv655t1a5K4oA1pQvZjhahOMKr1Rs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edEGuOpb2Uw5t562hxqXPcwzr9x68cTScxK125LBaRYSjqITOVHdNum8XwAy0qLb8/5vcFq718Ckg1s5DAnT6zYg1h82W2XhSaYtq9Dg4GoFr9nozzQ9QMZll7YYgW6lA0VaNiQA37A1duRHbZuepgntRpa48ybwx3e1gwTc3OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=t8iEvVSZ; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 060D4207A4;
	Mon, 22 Jun 2026 09:57:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FtVXFQtoMJqa; Mon, 22 Jun 2026 09:57:39 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CFB8720748;
	Mon, 22 Jun 2026 09:57:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CFB8720748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1782115059;
	bh=wAlM8rbUhnFyUd+FWSoUhj4OmVDVg6M2Hv/2PTjXxFg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=t8iEvVSZZy8n0/2G0BMlpAQuPM5EuJ2myclgDIfB6oG7eGcyhefJCriUnRAQQ2low
	 3cwJiNhI3tZGh/dsIRrTJmF10J4grLBVSouWEAbOoGD5uTDt02XnPUNasKWDJaBd0D
	 pHYrJvW3LFRQ5Z69PFld2WsLhWz6JG/AZ6qBiAjHftta/Eif/EaxKzbPzykLD5zRX6
	 tPgJ74kHWHHN5Aj1b0sVpx2Dfldy8bvHR2C19HfAcb2vUnApbAKNgJEi5IzARL8uPE
	 rxxB4b+YnVqPI/UxIS4Pq5xjDg10vFB+yms3+QAAsD4oLC/lY/GHtuuQZVCzGQ4d76
	 Y2OUJJKa0vU4w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 09:57:39 +0200
Received: (nullmailer pid 30067 invoked by uid 1000);
	Mon, 22 Jun 2026 07:57:32 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 5/7] xfrm: annotate data-races around xfrm_policy_count[] and xfrm_policy_default[]
Date: Mon, 22 Jun 2026 09:57:07 +0200
Message-ID: <20260622075726.29685-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622075726.29685-1-steffen.klassert@secunet.com>
References: <20260622075726.29685-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300981-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,secunet.com:dkim,secunet.com:email,secunet.com:mid,secunet.com:from_mime,appspotmail.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FACA6AD773

From: Eric Dumazet <edumazet@google.com>

KCSAN reported a data race involving net->xfrm.policy_count access.

Add missing READ_ONCE()/WRITE_ONCE() annotations on
xfrm_policy_count and xfrm_policy_default.

Fixes: 2518c7c2b3d7 ("[XFRM]: Hash policies when non-prefixed.")
Reported-by: syzbot+d85ba1c732720b9a4097@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a2b9e96.99669fcc.12a77b.0006.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h     |  8 ++++----
 net/xfrm/xfrm_policy.c | 24 ++++++++++++------------
 net/xfrm/xfrm_user.c   | 18 +++++++++---------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 874409127e29..35a743129329 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1250,8 +1250,8 @@ int __xfrm_policy_check(struct sock *, int dir, struct sk_buff *skb,
 static inline bool __xfrm_check_nopolicy(struct net *net, struct sk_buff *skb,
 					 int dir)
 {
-	if (!net->xfrm.policy_count[dir] && !secpath_exists(skb))
-		return net->xfrm.policy_default[dir] == XFRM_USERPOLICY_ACCEPT;
+	if (!READ_ONCE(net->xfrm.policy_count[dir]) && !secpath_exists(skb))
+		return READ_ONCE(net->xfrm.policy_default[dir]) == XFRM_USERPOLICY_ACCEPT;
 
 	return false;
 }
@@ -1351,8 +1351,8 @@ static inline int xfrm_route_forward(struct sk_buff *skb, unsigned short family)
 {
 	struct net *net = dev_net(skb->dev);
 
-	if (!net->xfrm.policy_count[XFRM_POLICY_OUT] &&
-	    net->xfrm.policy_default[XFRM_POLICY_OUT] == XFRM_USERPOLICY_ACCEPT)
+	if (!READ_ONCE(net->xfrm.policy_count[XFRM_POLICY_OUT]) &&
+	    READ_ONCE(net->xfrm.policy_default[XFRM_POLICY_OUT]) == XFRM_USERPOLICY_ACCEPT)
 		return true;
 
 	return (skb_dst(skb)->flags & DST_NOXFRM) ||
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 959544425692..1f4afd580105 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -685,7 +685,7 @@ static void xfrm_byidx_resize(struct net *net)
 
 static inline int xfrm_bydst_should_resize(struct net *net, int dir, int *total)
 {
-	unsigned int cnt = net->xfrm.policy_count[dir];
+	unsigned int cnt = READ_ONCE(net->xfrm.policy_count[dir]);
 	unsigned int hmask = net->xfrm.policy_bydst[dir].hmask;
 
 	if (total)
@@ -711,12 +711,12 @@ static inline int xfrm_byidx_should_resize(struct net *net, int total)
 
 void xfrm_spd_getinfo(struct net *net, struct xfrmk_spdinfo *si)
 {
-	si->incnt = net->xfrm.policy_count[XFRM_POLICY_IN];
-	si->outcnt = net->xfrm.policy_count[XFRM_POLICY_OUT];
-	si->fwdcnt = net->xfrm.policy_count[XFRM_POLICY_FWD];
-	si->inscnt = net->xfrm.policy_count[XFRM_POLICY_IN+XFRM_POLICY_MAX];
-	si->outscnt = net->xfrm.policy_count[XFRM_POLICY_OUT+XFRM_POLICY_MAX];
-	si->fwdscnt = net->xfrm.policy_count[XFRM_POLICY_FWD+XFRM_POLICY_MAX];
+	si->incnt = READ_ONCE(net->xfrm.policy_count[XFRM_POLICY_IN]);
+	si->outcnt = READ_ONCE(net->xfrm.policy_count[XFRM_POLICY_OUT]);
+	si->fwdcnt = READ_ONCE(net->xfrm.policy_count[XFRM_POLICY_FWD]);
+	si->inscnt = READ_ONCE(net->xfrm.policy_count[XFRM_POLICY_IN+XFRM_POLICY_MAX]);
+	si->outscnt = READ_ONCE(net->xfrm.policy_count[XFRM_POLICY_OUT+XFRM_POLICY_MAX]);
+	si->fwdscnt = READ_ONCE(net->xfrm.policy_count[XFRM_POLICY_FWD+XFRM_POLICY_MAX]);
 	si->spdhcnt = net->xfrm.policy_idx_hmask;
 	si->spdhmcnt = xfrm_policy_hashmax;
 }
@@ -2318,7 +2318,7 @@ static void __xfrm_policy_link(struct xfrm_policy *pol, int dir)
 	}
 
 	list_add(&pol->walk.all, &net->xfrm.policy_all);
-	net->xfrm.policy_count[dir]++;
+	WRITE_ONCE(net->xfrm.policy_count[dir], net->xfrm.policy_count[dir] + 1);
 	xfrm_pol_hold(pol);
 }
 
@@ -2337,7 +2337,7 @@ static struct xfrm_policy *__xfrm_policy_unlink(struct xfrm_policy *pol,
 	}
 
 	list_del_init(&pol->walk.all);
-	net->xfrm.policy_count[dir]--;
+	WRITE_ONCE(net->xfrm.policy_count[dir], net->xfrm.policy_count[dir] - 1);
 
 	return pol;
 }
@@ -3222,7 +3222,7 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
 
 		/* To accelerate a bit...  */
 		if (!if_id && ((dst_orig->flags & DST_NOXFRM) ||
-			       !net->xfrm.policy_count[XFRM_POLICY_OUT]))
+			       !READ_ONCE(net->xfrm.policy_count[XFRM_POLICY_OUT])))
 			goto nopol;
 
 		xdst = xfrm_bundle_lookup(net, fl, family, dir, &xflo, if_id);
@@ -3296,7 +3296,7 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
 
 nopol:
 	if ((!dst_orig->dev || !(dst_orig->dev->flags & IFF_LOOPBACK)) &&
-	    net->xfrm.policy_default[dir] == XFRM_USERPOLICY_BLOCK) {
+	    READ_ONCE(net->xfrm.policy_default[dir]) == XFRM_USERPOLICY_BLOCK) {
 		err = -EPERM;
 		goto error;
 	}
@@ -3750,7 +3750,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		const bool is_crypto_offload = sp &&
 			(xfrm_input_state(skb)->xso.type == XFRM_DEV_OFFLOAD_CRYPTO);
 
-		if (net->xfrm.policy_default[dir] == XFRM_USERPOLICY_BLOCK) {
+		if (READ_ONCE(net->xfrm.policy_default[dir]) == XFRM_USERPOLICY_BLOCK) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOPOLS);
 			return 0;
 		}
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 3b1cf29bc402..61eb5de33b87 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2485,9 +2485,9 @@ static int xfrm_notify_userpolicy(struct net *net)
 	}
 
 	up = nlmsg_data(nlh);
-	up->in = net->xfrm.policy_default[XFRM_POLICY_IN];
-	up->fwd = net->xfrm.policy_default[XFRM_POLICY_FWD];
-	up->out = net->xfrm.policy_default[XFRM_POLICY_OUT];
+	up->in = READ_ONCE(net->xfrm.policy_default[XFRM_POLICY_IN]);
+	up->fwd = READ_ONCE(net->xfrm.policy_default[XFRM_POLICY_FWD]);
+	up->out = READ_ONCE(net->xfrm.policy_default[XFRM_POLICY_OUT]);
 
 	nlmsg_end(skb, nlh);
 
@@ -2511,13 +2511,13 @@ static int xfrm_set_default(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct xfrm_userpolicy_default *up = nlmsg_data(nlh);
 
 	if (xfrm_userpolicy_is_valid(up->in))
-		net->xfrm.policy_default[XFRM_POLICY_IN] = up->in;
+		WRITE_ONCE(net->xfrm.policy_default[XFRM_POLICY_IN], up->in);
 
 	if (xfrm_userpolicy_is_valid(up->fwd))
-		net->xfrm.policy_default[XFRM_POLICY_FWD] = up->fwd;
+		WRITE_ONCE(net->xfrm.policy_default[XFRM_POLICY_FWD], up->fwd);
 
 	if (xfrm_userpolicy_is_valid(up->out))
-		net->xfrm.policy_default[XFRM_POLICY_OUT] = up->out;
+		WRITE_ONCE(net->xfrm.policy_default[XFRM_POLICY_OUT], up->out);
 
 	rt_genid_bump_all(net);
 
@@ -2547,9 +2547,9 @@ static int xfrm_get_default(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	r_up = nlmsg_data(r_nlh);
-	r_up->in = net->xfrm.policy_default[XFRM_POLICY_IN];
-	r_up->fwd = net->xfrm.policy_default[XFRM_POLICY_FWD];
-	r_up->out = net->xfrm.policy_default[XFRM_POLICY_OUT];
+	r_up->in = READ_ONCE(net->xfrm.policy_default[XFRM_POLICY_IN]);
+	r_up->fwd = READ_ONCE(net->xfrm.policy_default[XFRM_POLICY_FWD]);
+	r_up->out = READ_ONCE(net->xfrm.policy_default[XFRM_POLICY_OUT]);
 	nlmsg_end(r_skb, r_nlh);
 
 	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, portid);
-- 
2.43.0


