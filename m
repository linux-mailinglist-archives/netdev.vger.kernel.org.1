Return-Path: <netdev+bounces-270424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM5pBDr9wGmiPQQAu9opvQ
	(envelope-from <netdev+bounces-270424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:43:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6D72EE697
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FF57304C7D1
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E437F8A9;
	Mon, 23 Mar 2026 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="TkTRp38G"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF8337FF64
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254980; cv=none; b=sceGQJ+tR4wFQSritmkO4+U1i7zeI02hLsRZpzGcRNzHLZh9/vOKJw1uMV3mvCBO1uVnNVbOZs8B1/UCft1dArwk8cQyLVdIKekgzcD09Mi+fiHpClJElzoVjcLLCAMJMe8ZYFLFcKE3C5yMYT0Xogcb4eiNk7cNyUNccVDH/ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254980; c=relaxed/simple;
	bh=GfGjYkgb6m8DDXWaKMUkLIzj3ccmtvs/XcO9m3MCGiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNgEN0OZ1M/SKvSWw9M1hKNBXv4VUCMRoyEWpGzcD8exjM+WB30yD4+vXvLchuKRlyrTfXKJVQXSFX1vDlhEJwL5FyV17nvLHTyDmgNRClhXUpvxRLNiuKjawxOn5jYDb1S1EzcEvcp1UsSTTH0VYAbYVJn8UvgKXrASqodUuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=TkTRp38G; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id DE104207D1;
	Mon, 23 Mar 2026 09:36:16 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id esyrBEOEiET3; Mon, 23 Mar 2026 09:36:16 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1D029205DD;
	Mon, 23 Mar 2026 09:36:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1D029205DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254976;
	bh=Vgu9N431++2MOcanNMODUJjIe+OAeO7nwN3mC2ZX7/g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=TkTRp38GD9xwxI5tH1MaO+1vPSGE5ZWkAmbdCNLdydFAITD9PPMAsJDkyFsPq2Rda
	 tOUq730Dhg6th7arPx8epzzZ0rVO5L2ljPtI2wx+oNrFPAotsS700PshCW5M0xjGZD
	 xAih2b2nFGh9VY5fis1UGj4h91HP9FigHGx7avnWI0PwD7QiMS3Di84MSQT4wQWv74
	 Qp4gKBAlZ1jio+PiIwVTRy3jbKL4iTI0WmEl9A91f/UBQmehTODPRsRJKghdPAvrRP
	 yydx7yZGzTXhF6uzRuEzOuCdP/EFFaqC9y+eEQDBJAUmfUA3Qbmz+Zr4SQ+CQ4Vaib
	 WZmh27wPXxuUw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:36:15 +0100
Received: (nullmailer pid 2741845 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 16/20] xfrm: avoid RCU warnings around the per-netns netlink socket
Date: Mon, 23 Mar 2026 09:33:57 +0100
Message-ID: <20260323083440.2741292-17-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323083440.2741292-1-steffen.klassert@secunet.com>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
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
	TAGGED_FROM(0.00)[bounces-270424-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:email,secunet.com:mid,queasysnail.net:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6B6D72EE697
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sabrina Dubroca <sd@queasysnail.net>

net->xfrm.nlsk is used in 2 types of contexts:
 - fully under RCU, with rcu_read_lock + rcu_dereference and a NULL check
 - in the netlink handlers, with requests coming from a userspace socket

In the 2nd case, net->xfrm.nlsk is guaranteed to stay non-NULL and the
object is alive, since we can't enter the netns destruction path while
the user socket holds a reference on the netns.

After adding the __rcu annotation to netns_xfrm.nlsk (which silences
sparse warnings in the RCU users and __net_init code), we need to tell
sparse that the 2nd case is safe. Add a helper for that.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/netns/xfrm.h |  2 +-
 net/xfrm/xfrm_user.c     | 25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index 23dd647fe024..b73983a17e08 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -59,7 +59,7 @@ struct netns_xfrm {
 	struct list_head	inexact_bins;
 
 
-	struct sock		*nlsk;
+	struct sock		__rcu *nlsk;
 	struct sock		*nlsk_stash;
 
 	u32			sysctl_aevent_etime;
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 4dd8341225bc..1656b487f833 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -35,6 +35,15 @@
 #endif
 #include <linux/unaligned.h>
 
+static struct sock *xfrm_net_nlsk(const struct net *net, const struct sk_buff *skb)
+{
+	/* get the source of this request, see netlink_unicast_kernel */
+	const struct sock *sk = NETLINK_CB(skb).sk;
+
+	/* sk is refcounted, the netns stays alive and nlsk with it */
+	return rcu_dereference_protected(net->xfrm.nlsk, sk->sk_net_refcnt);
+}
+
 static int verify_one_alg(struct nlattr **attrs, enum xfrm_attr_type_t type,
 			  struct netlink_ext_ack *extack)
 {
@@ -1727,7 +1736,7 @@ static int xfrm_get_spdinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = build_spdinfo(r_skb, net, sportid, seq, *flags);
 	BUG_ON(err < 0);
 
-	return nlmsg_unicast(net->xfrm.nlsk, r_skb, sportid);
+	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, sportid);
 }
 
 static inline unsigned int xfrm_sadinfo_msgsize(void)
@@ -1787,7 +1796,7 @@ static int xfrm_get_sadinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = build_sadinfo(r_skb, net, sportid, seq, *flags);
 	BUG_ON(err < 0);
 
-	return nlmsg_unicast(net->xfrm.nlsk, r_skb, sportid);
+	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, sportid);
 }
 
 static int xfrm_get_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -1807,7 +1816,7 @@ static int xfrm_get_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (IS_ERR(resp_skb)) {
 		err = PTR_ERR(resp_skb);
 	} else {
-		err = nlmsg_unicast(net->xfrm.nlsk, resp_skb, NETLINK_CB(skb).portid);
+		err = nlmsg_unicast(xfrm_net_nlsk(net, skb), resp_skb, NETLINK_CB(skb).portid);
 	}
 	xfrm_state_put(x);
 out_noput:
@@ -1898,7 +1907,7 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	err = nlmsg_unicast(net->xfrm.nlsk, resp_skb, NETLINK_CB(skb).portid);
+	err = nlmsg_unicast(xfrm_net_nlsk(net, skb), resp_skb, NETLINK_CB(skb).portid);
 
 out:
 	xfrm_state_put(x);
@@ -2543,7 +2552,7 @@ static int xfrm_get_default(struct sk_buff *skb, struct nlmsghdr *nlh,
 	r_up->out = net->xfrm.policy_default[XFRM_POLICY_OUT];
 	nlmsg_end(r_skb, r_nlh);
 
-	return nlmsg_unicast(net->xfrm.nlsk, r_skb, portid);
+	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, portid);
 }
 
 static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -2609,7 +2618,7 @@ static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (IS_ERR(resp_skb)) {
 			err = PTR_ERR(resp_skb);
 		} else {
-			err = nlmsg_unicast(net->xfrm.nlsk, resp_skb,
+			err = nlmsg_unicast(xfrm_net_nlsk(net, skb), resp_skb,
 					    NETLINK_CB(skb).portid);
 		}
 	} else {
@@ -2782,7 +2791,7 @@ static int xfrm_get_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = build_aevent(r_skb, x, &c);
 	BUG_ON(err < 0);
 
-	err = nlmsg_unicast(net->xfrm.nlsk, r_skb, NETLINK_CB(skb).portid);
+	err = nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, NETLINK_CB(skb).portid);
 	spin_unlock_bh(&x->lock);
 	xfrm_state_put(x);
 	return err;
@@ -3486,7 +3495,7 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto err;
 		}
 
-		err = netlink_dump_start(net->xfrm.nlsk, skb, nlh, &c);
+		err = netlink_dump_start(xfrm_net_nlsk(net, skb), skb, nlh, &c);
 		goto err;
 	}
 
-- 
2.43.0


