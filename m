Return-Path: <netdev+bounces-204182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F505AF9613
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24AE1C47D07
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A1E1D63EF;
	Fri,  4 Jul 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="eMOqmP4v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lzKbz3bL"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C521917D6
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751640902; cv=none; b=Q19x0k9tcdP7FZvFDZuluTAfvJ9cBtvkNFSgfAXf76Bp21BUTmRjHMhx+Gtf5+ayvGELwybOWfoJkEhJTtL9yvpbKXRZ/tXU1EfOkXu+AjrrQAtociYEwXijQY5QHsUDB5YX2j5Z/ypJIpm538OA0O7tKH36/FtEjX9CSo7BQ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751640902; c=relaxed/simple;
	bh=gZ9w2B8Nooq3TSRW2GaQaRPf173CuP3jYfKERTZwKlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaX8YEa3sIrkAX+MRiJqDkURB4vRiYvdO+CXPxVwY7+0NMnofTir+D+x4YQeoB1qEauxOTpInhVegAL+5Dt0fUP8wRU7I3ZFoHryzcinsMAppg5xj4k4L+yRJAG7JXvQR14TOT4l6KU0gyP3wWS9GoeRQeXZ5KWHST8fGmXfn3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=eMOqmP4v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lzKbz3bL; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8719F7A01AD;
	Fri,  4 Jul 2025 10:54:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 04 Jul 2025 10:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1751640898; x=
	1751727298; bh=ycismGAR13EscupmtdFSNWayRgsqEH7jUsQ3zKwDizM=; b=e
	MOqmP4vviFcfoXzwMJAYcROIhFK2Uth/h+TeNmUMYSDfq1mxImvV1zPd66Ko+qlr
	b9BqXX/MCNvEXxD3eD3k9ZXLHeNAfOZoglI3AwJmmoO9opIvfQuACtRU2othct1u
	K+Tcws/fP3Hfqb3rG0O0RpyQ9TynVuNz59OJ8a8agS0oV2GQBIAJFYsZ8u6D9OfB
	nbkTf91N3YeZ0UgZrT/AyH1CwL/kRV4ppE6oj25rw9Syc5ipPavu8/mreISd0VBa
	LYaj7J7wxb82R/pzhYCayJb0r9Se64SNnztjitlitlXg1wUR1M6l3VfurKlv3uPs
	scOP6LvEFfBq1K5xz5epg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751640898; x=1751727298; bh=y
	cismGAR13EscupmtdFSNWayRgsqEH7jUsQ3zKwDizM=; b=lzKbz3bLkamSmOFPS
	JETwKxdeIR/cgbWNX6gcZFHBDlNYbqEs83uzXieX2xqb16lzyQ07Sn+8cspHLxWw
	nH1PwfbxNQhb1+/9LfT4CIZd+TNUIHu6VIkf7KB0RAXvgG3G9OXtQlY6+1FIvq7W
	LM7IMIkTHfCekNr38eBYV3UAdW4/D8uQ9pbwysCKXuiactX5bduYs++ZBLu+o1gl
	Pb60KKIU/NRuSJ27yrYIn5GlsjJHQo1ngSSd+kU2PlLieuBnDV3RyiSXb/gJDBrP
	asSuuMSqj2rYV8yXjd7qP5U95Wc1xDlWG/r8ZTL5aSJT4mI9QCs/4Z2XFbzZF4im
	O4zEA==
X-ME-Sender: <xms:QetnaGCYSxBizAVyybVjgn7VyRSnXa4LjC7JvQaScS9dybdOEPms1A>
    <xme:QetnaAg9jNuOexbGpsXQsaJ8jB5XKrx-S1pc9wyTspDAhNaR0PiFVRaKS4JKMQUzr
    ts3e8Ri1tA18pylkZk>
X-ME-Received: <xmr:QetnaJmES6R4l8c2cKUVOOx7AJb5FHRaYUUHkCBt5-enl3BSGgcDHxYCVvIa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvfeeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfetveeuleejieejieevhefghedu
    gfehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvght
    rdgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorh
    hgrdgruhdprhgtphhtthhopegrughosghrihihrghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepgihihihouhdrfigrnhhgtghonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshgusehquhgvrghshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:QetnaExXOP02EKvhqhg6o2vhu98zmGva2gthDxV6rW7Kk0wfL72hlw>
    <xmx:QetnaLQ3vw0TeavdPBvKgwyUw69nk_i8M5lUNYZgCqfu1iJEnTPJeg>
    <xmx:QetnaPYLTZkDi7lpmpxqarNfkmAQ4_-crKfFxMrUPPmrILXTXaZs3Q>
    <xmx:QetnaESt8ku9u540p6_HlBSHPUl559SyBBITwNGTnVwCoU56kxuAAw>
    <xmx:QutnaAyjejvNhqaLDKTLo8XG2RI_4spRwviq_NzN3A-jlRR4vtHhkYn->
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 10:54:57 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec 1/2] xfrm: delete x->tunnel as we delete x
Date: Fri,  4 Jul 2025 16:54:33 +0200
Message-ID: <9624611c0bfe8fcac2fad34ba9606e617ac7cf1e.1751640074.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751640074.git.sd@queasysnail.net>
References: <cover.1751640074.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ipcomp fallback tunnels currently get deleted (from the various
lists and hashtables) as the last user state that needed that fallback
is destroyed (not deleted). If a reference to that user state still
exists, the fallback state will remain on the hashtables/lists,
triggering the WARN in xfrm_state_fini. Because of those remaining
references, the fix in commit f75a2804da39 ("xfrm: destroy xfrm_state
synchronously on net exit path") is not complete.

We recently fixed one such situation in TCP due to defered freeing of
skbs (commit 9b6412e6979f ("tcp: drop secpath at the same time as we
currently drop dst")). This can also happen due to IP reassembly: skbs
with a secpath remain on the reassembly queue until netns
destruction. If we can't guarantee that the queues are flushed by the
time xfrm_state_fini runs, there may still be references to a (user)
xfrm_state, preventing the timely deletion of the corresponding
fallback state.

Instead of chasing each instance of skbs holding a secpath one by one,
this patch fixes the issue directly within xfrm, by deleting the
fallback state as soon as the last user state depending on it has been
deleted. Destruction will still happen when the final reference is
dropped.

A separate lockdep class for the fallback state is required since
we're going to lock x->tunnel while x is locked.

Fixes: 9d4139c76905 ("netns xfrm: per-netns xfrm_state_all list")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/xfrm.h      |  1 -
 net/ipv4/ipcomp.c       |  2 ++
 net/ipv6/ipcomp6.c      |  2 ++
 net/ipv6/xfrm6_tunnel.c |  2 +-
 net/xfrm/xfrm_ipcomp.c  |  1 -
 net/xfrm/xfrm_state.c   | 19 ++++++++-----------
 6 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index e45a275fca26..91d52a380e37 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -441,7 +441,6 @@ int xfrm_input_register_afinfo(const struct xfrm_input_afinfo *afinfo);
 int xfrm_input_unregister_afinfo(const struct xfrm_input_afinfo *afinfo);
 
 void xfrm_flush_gc(void);
-void xfrm_state_delete_tunnel(struct xfrm_state *x);
 
 struct xfrm_type {
 	struct module		*owner;
diff --git a/net/ipv4/ipcomp.c b/net/ipv4/ipcomp.c
index 5a4fb2539b08..9a45aed508d1 100644
--- a/net/ipv4/ipcomp.c
+++ b/net/ipv4/ipcomp.c
@@ -54,6 +54,7 @@ static int ipcomp4_err(struct sk_buff *skb, u32 info)
 }
 
 /* We always hold one tunnel user reference to indicate a tunnel */
+static struct lock_class_key xfrm_state_lock_key;
 static struct xfrm_state *ipcomp_tunnel_create(struct xfrm_state *x)
 {
 	struct net *net = xs_net(x);
@@ -62,6 +63,7 @@ static struct xfrm_state *ipcomp_tunnel_create(struct xfrm_state *x)
 	t = xfrm_state_alloc(net);
 	if (!t)
 		goto out;
+	lockdep_set_class(&t->lock, &xfrm_state_lock_key);
 
 	t->id.proto = IPPROTO_IPIP;
 	t->id.spi = x->props.saddr.a4;
diff --git a/net/ipv6/ipcomp6.c b/net/ipv6/ipcomp6.c
index 72d4858dec18..8607569de34f 100644
--- a/net/ipv6/ipcomp6.c
+++ b/net/ipv6/ipcomp6.c
@@ -71,6 +71,7 @@ static int ipcomp6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	return 0;
 }
 
+static struct lock_class_key xfrm_state_lock_key;
 static struct xfrm_state *ipcomp6_tunnel_create(struct xfrm_state *x)
 {
 	struct net *net = xs_net(x);
@@ -79,6 +80,7 @@ static struct xfrm_state *ipcomp6_tunnel_create(struct xfrm_state *x)
 	t = xfrm_state_alloc(net);
 	if (!t)
 		goto out;
+	lockdep_set_class(&t->lock, &xfrm_state_lock_key);
 
 	t->id.proto = IPPROTO_IPV6;
 	t->id.spi = xfrm6_tunnel_alloc_spi(net, (xfrm_address_t *)&x->props.saddr);
diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index bf140ef781c1..7fd8bc08e6eb 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -334,8 +334,8 @@ static void __net_exit xfrm6_tunnel_net_exit(struct net *net)
 	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
 	unsigned int i;
 
-	xfrm_flush_gc();
 	xfrm_state_flush(net, 0, false, true);
+	xfrm_flush_gc();
 
 	for (i = 0; i < XFRM6_TUNNEL_SPI_BYADDR_HSIZE; i++)
 		WARN_ON_ONCE(!hlist_empty(&xfrm6_tn->spi_byaddr[i]));
diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index a38545413b80..43fdc6ed8dd1 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -313,7 +313,6 @@ void ipcomp_destroy(struct xfrm_state *x)
 	struct ipcomp_data *ipcd = x->data;
 	if (!ipcd)
 		return;
-	xfrm_state_delete_tunnel(x);
 	ipcomp_free_data(ipcd);
 	kfree(ipcd);
 }
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index c7e6472c623d..f7110a658897 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -811,6 +811,7 @@ void __xfrm_state_destroy(struct xfrm_state *x, bool sync)
 }
 EXPORT_SYMBOL(__xfrm_state_destroy);
 
+static void xfrm_state_delete_tunnel(struct xfrm_state *x);
 int __xfrm_state_delete(struct xfrm_state *x)
 {
 	struct net *net = xs_net(x);
@@ -838,6 +839,8 @@ int __xfrm_state_delete(struct xfrm_state *x)
 
 		xfrm_dev_state_delete(x);
 
+		xfrm_state_delete_tunnel(x);
+
 		/* All xfrm_state objects are created by xfrm_state_alloc.
 		 * The xfrm_state_alloc call gives a reference, and that
 		 * is what we are dropping here.
@@ -941,10 +944,7 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync)
 				err = xfrm_state_delete(x);
 				xfrm_audit_state_delete(x, err ? 0 : 1,
 							task_valid);
-				if (sync)
-					xfrm_state_put_sync(x);
-				else
-					xfrm_state_put(x);
+				xfrm_state_put(x);
 				if (!err)
 					cnt++;
 
@@ -3068,20 +3068,17 @@ void xfrm_flush_gc(void)
 }
 EXPORT_SYMBOL(xfrm_flush_gc);
 
-/* Temporarily located here until net/xfrm/xfrm_tunnel.c is created */
-void xfrm_state_delete_tunnel(struct xfrm_state *x)
+static void xfrm_state_delete_tunnel(struct xfrm_state *x)
 {
 	if (x->tunnel) {
 		struct xfrm_state *t = x->tunnel;
 
-		if (atomic_read(&t->tunnel_users) == 2)
+		if (atomic_dec_return(&t->tunnel_users) == 1)
 			xfrm_state_delete(t);
-		atomic_dec(&t->tunnel_users);
-		xfrm_state_put_sync(t);
+		xfrm_state_put(t);
 		x->tunnel = NULL;
 	}
 }
-EXPORT_SYMBOL(xfrm_state_delete_tunnel);
 
 u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 {
@@ -3286,8 +3283,8 @@ void xfrm_state_fini(struct net *net)
 	unsigned int sz;
 
 	flush_work(&net->xfrm.state_hash_work);
-	flush_work(&xfrm_state_gc_work);
 	xfrm_state_flush(net, 0, false, true);
+	flush_work(&xfrm_state_gc_work);
 
 	WARN_ON(!list_empty(&net->xfrm.state_all));
 
-- 
2.50.0


