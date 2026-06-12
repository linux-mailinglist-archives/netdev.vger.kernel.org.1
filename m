Return-Path: <netdev+bounces-298464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vj+kKamfK2oHAgQAu9opvQ
	(envelope-from <netdev+bounces-298464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:56:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FA6676D44
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:56:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=AEIPlzWQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298464-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298464-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D89B30CAE08
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 05:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDED3905E6;
	Fri, 12 Jun 2026 05:56:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9597138D3E0
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 05:56:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781243800; cv=none; b=PFzC6ZFunz8T4LnRgnz+2rgjNxN3m+luee4jpW5u5KBnvkMWOfgtD7/qk/QlgtpYNzcnTXacs2WjBcSWRRM33ATotdhfxdZjmZ2aX2MhQ29Q3CsvxGgfcdOsnPqTIMAIt1XdOBlw8Q7xofIc5FnQ+oTpKcgUkguVtjRw1P71utI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781243800; c=relaxed/simple;
	bh=IO9Dhi5ja7r/SSOxW7nTfQA00yWkEbnfAAV+akbpUcQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Tkwz1TLS50gy8e7MZXLySpDTdP4Ts72PAbdFkj8MoELyH8eah7U0Y3wAYFICR0aXZvMTFXzekPbWuYIEyJ8FoKVRUmAU6gM7/RdF9dvPdo7LPGXYXqypZWeBXYepIP3uquO5WIPVBwuRGLLQAC+fiq0w7bcHk7TDd5bFLNWzuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEIPlzWQ; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8cceb5a9686so18651026d6.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 22:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781243796; x=1781848596; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IIYdqqNoHLZ6UYXUQ3B/R5KfPXFgS4KwYfeYBgjBBVA=;
        b=AEIPlzWQD/th7/5/LjK2RNdGGlsgLh+rpSg8jJifZMCmf9UML2kMsh3mj72PljCGUX
         RnvqsB3BO56niTsgEDuYaMgm8UXfAwjLgCG2vVm0hxHExuZiN180gs7uKmyjEIh3lppV
         euHhXgpxAH21Wvq6xa+1C4emQZOtPQgE0o6t0hcpgz93Dwxzn02JQ7Mgq79s0uWAswlS
         fdSDcptaxCso6pqh0NESoqV6XV6Vw32iWa/FDYWpUQut3thL1sBJJlYSlOLhmK6TTebQ
         oX8qLI8Ft2oKC5DWc9+4xZlwOAxoLNA22hkBFlDZUmbcf+b06HB29u/w2omJiKsT6ugy
         xS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781243796; x=1781848596;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IIYdqqNoHLZ6UYXUQ3B/R5KfPXFgS4KwYfeYBgjBBVA=;
        b=In4vKMz0d1AqLLo7qkxl0xw9ada4qUNWxtDw62RHED9Qq+M+IQLawcjRkomhmAX9SI
         1RbPzirDlBJzV0DifG+reuH+Amv0BU7TPUf+N/B8sT+Ny2Tg4Cg6xQDG4uvKOJa5UUgF
         nWo/1fwMFEVu2hcI0Pw2HZjoKVSI6IA46rhCezM+eRf5QaRagLGzISstCPt0LD20XE4V
         JJRQdD/FgJkb9LasqK3OxwQycWmemNEFRHhcFyZd51oVopH62fgvkAul3W7ukKbmEWL2
         KJGpzI76x/CSwh4k0eVFWbw+TcVBbDr0kXPLLQq5Av0P4uBrJb9vsewsNt5dtDSXKO7r
         rzrg==
X-Forwarded-Encrypted: i=1; AFNElJ/H3RaOpqWIHZAI7pn/etQ0y0WmPk+RRQrvWwtO8JCWC+aesXxC/ktuWzo1zqignpRrwNVlrF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYVTzVibD7mqXgYQ2lMPVhpKB/lB5e/i8lyLO/O6eCvGsLmFS
	KPUX4ck9PL+tMUoUVKytqm3X0tyBBBqgqgFfIPgyGwAdRS7hzf+02p3dO0e04DLKspjjYwNo4TY
	yCbPhqxqLIt7o3Q==
X-Received: from qkkb16.prod.google.com ([2002:a05:620a:1190:b0:915:885f:3aa7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:198f:b0:915:769d:554 with SMTP id af79cd13be357-9161bf5e9a6mr186658985a.46.1781243796074;
 Thu, 11 Jun 2026 22:56:36 -0700 (PDT)
Date: Fri, 12 Jun 2026 05:56:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612055634.3560352-1-edumazet@google.com>
Subject: [PATCH net] xfrm: annotate data-races around xfrm_policy_count[] and xfrm_policy_default[]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+d85ba1c732720b9a4097@syzkaller.appspotmail.com, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298464-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:syzbot+d85ba1c732720b9a4097@syzkaller.appspotmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com,secunet.com,gondor.apana.org.au];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,d85ba1c732720b9a4097];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,secunet.com:email,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1FA6676D44

KCSAN reported a data race involving net->xfrm.policy_count access.

Add missing READ_ONCE()/WRITE_ONCE() annotations on
xfrm_policy_count and xfrm_policy_default.

Fixes: 2518c7c2b3d7 ("[XFRM]: Hash policies when non-prefixed.")
Reported-by: syzbot+d85ba1c732720b9a4097@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a2b9e96.99669fcc.12a77b.0006.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 include/net/xfrm.h     |  8 ++++----
 net/xfrm/xfrm_policy.c | 24 ++++++++++++------------
 net/xfrm/xfrm_user.c   | 18 +++++++++---------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 874409127e292197c17dbac4686efdd5ff56c185..35a7431293298a9eb7f82c8a865ca45e227e81e1 100644
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
index 95954442569290719b9fdb7b0f9462d70b5d755e..1f4afd580105f97094c6ad8d10001912f67cc731 100644
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
index 71a4b7278eba92a7014f877428a587587d0fd476..8de2ebb0f9d7940b28802fc1421f21312df698fe 100644
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
2.54.0.1136.gdb2ca164c4-goog


