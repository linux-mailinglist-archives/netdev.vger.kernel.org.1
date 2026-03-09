Return-Path: <netdev+bounces-265466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKwTHz+irmk9HAIAu9opvQ
	(envelope-from <netdev+bounces-265466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:34:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E53C72372CE
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC880304031E
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 10:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8803921D3;
	Mon,  9 Mar 2026 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="BgmYIM3c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FFT2AwOU"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C2390C98
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052386; cv=none; b=id5RZb0shq/QJ+7NoP+l7X6vGxUqpkSlKibdg8myGJrCbxnBRsbqIEQCHth+4NnMbZpsf5LDfNd7PO8ufsgav5pnnts8rjonEZQkiFZ/hXPBnjVPEDJ+0d7AhVVUi12/oXHQmAo6bYZlCjJ2b5koQeRTygaExklo1rVzuvRpc28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052386; c=relaxed/simple;
	bh=dwBHtB4W/lwM3i1H00EjK/JgG+uDKKS0vYPKIH7b/x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I64z0EIuBxaGDaGm2p0WnZf+mvGykPsDcSt9RCwVyynZLt0OSCpa/I+chZW4rntF9JB4LvH9kKPN15P0hIB6Tyl8/b1PY2DeRkHKKwWTOSNjPnmMF3Df+DmdFTEI0nrMYxdaprYIriBLS3VXABrDYXanm7AmGbMKF9eBu23UZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=BgmYIM3c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FFT2AwOU; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CBBD37A015B;
	Mon,  9 Mar 2026 06:33:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 09 Mar 2026 06:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773052383; x=
	1773138783; bh=ph5v+AHvoCVQdeCLfzIBAhBe1DyrJV2V4CzD3RSilmM=; b=B
	gmYIM3c1tKKCtRz9WxNZmHHYdmMg2t/Jv1AwwLnkRLS+WhPH5oCas74rH7it+Gof
	SVMwsfUvpjj4zIq90dVqheTLsEi6cW+LCe9MYVJhYGC/3B8x43dFJH4C4pY+oPwr
	PidIIlLUqAlnNJ3TyC7QEZ8e4tYqrwiC76lfQjkITCvpjTTZk9lJ2aBsgxrekjKn
	69VchMXZuodKeNSrl47GZUZF/OzF8/WqAKRSPCp2P8yhRpgSqxDVLFm+968gN26e
	X3fDh/QqjHbsO9+eJZrbXeBhteaoMVGxHMZckI8T2QFM9/otMLNIwJCrYyclVf+O
	VDlxqfpDyQDVJ9Dc3sW8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773052383; x=1773138783; bh=p
	h5v+AHvoCVQdeCLfzIBAhBe1DyrJV2V4CzD3RSilmM=; b=FFT2AwOUnW0HuqRq4
	3WyzovnWKdP53XnEiOcVzYWd26OtBuP7Hl4PLA+Oem/atp8pQpYYQnkw/fXERU7o
	EDlSL4Dz9g9v5L5H5MvqxbQ7JRenwBpW/QPb5G+kpvhCbB8dV45YPq/AdNpmA+m6
	6e0v46aMmfQ2yjtzQ4THzNOQqE6++4ByXzQEW/irJFMMywQecxLdvViljtgjt/oz
	FtyFjI7yCrE/xYjVnObEZ8BCteQ879d/9hf6WRYPRbJQJWiM+tKtoWzLs7S38zZy
	6F48cgtJbn/nyKSnMczKzxBTybfWeic/ZBgu0wbd/sN7+I2PDwT4MSATY99YmGFp
	IZR0Q==
X-ME-Sender: <xms:36GuaWlfDZQ1oq10WYGSOPGzKmughwYHH8QGexef0SFe8UXMiPsXvA>
    <xme:36GuaZRDzF6Wq5Kz3VsR8Yn-CbDk2pzzMBLcDOroORTr7Q6z_jq2c9rQA2rH6AsVQ
    kFoSHP6X_202QRG6a-9IoVGa04XLIWEk-zKdaXC-Z8SVzLL3gVh2Q>
X-ME-Received: <xmr:36GuaYLRCg7WjgXsXh4TPtY8UqE5RoV4uuUPVjn9xdcZBTiAfpJjB7l8cfWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeejkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgv
    thdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdroh
    hrghdrrghupdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:36GuafDm2q1mt3kEOiZ6y5Tp4MFH1h3P9cJAx32asjDqT-TdammxkQ>
    <xmx:36GuaRCHAloum45sr3oDn3I0SZLzCb_HMXTuFoEgXVuk5yJMwsyTMA>
    <xmx:36GuaRAMzYDdwYR-74b3RJZUH4XADsV7catDp3-TntHSXVvQwE7WSQ>
    <xmx:36Guaco_-kMsZjGmgbHQN5v1WmzPDVr2CEwMj1w7l9FxQc6roiHXKg>
    <xmx:36GuaXbE6H2IisLpFZyylSm2G_kOPZRfLQTOlCI23cjtqstg86Cx4M8a>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 06:33:03 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next 04/10] xfrm: state: add xfrm_state_deref_prot to state_by* walk under lock
Date: Mon,  9 Mar 2026 11:32:37 +0100
Message-ID: <e1d4a1754879070dbc184f6fed308f631a9d9668.1773051558.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1773051558.git.sd@queasysnail.net>
References: <cover.1773051558.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E53C72372CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265466-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

We're under xfrm_state_lock for all those walks, we can use
xfrm_state_deref_prot to silence sparse warnings such as:

net/xfrm/xfrm_state.c:933:17: warning: dereference of noderef expression

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 3ad25b85cd92..c234431e1967 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -870,7 +870,7 @@ xfrm_state_flush_secctx_check(struct net *net, u8 proto, bool task_valid)
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
 		struct xfrm_state *x;
 
-		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + i, bydst) {
 			if (xfrm_id_proto_match(x->id.proto, proto) &&
 			   (err = security_xfrm_state_delete(x)) != 0) {
 				xfrm_audit_state_delete(x, 0, task_valid);
@@ -891,7 +891,7 @@ xfrm_dev_state_flush_secctx_check(struct net *net, struct net_device *dev, bool
 		struct xfrm_state *x;
 		struct xfrm_dev_offload *xso;
 
-		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + i, bydst) {
 			xso = &x->xso;
 
 			if (xso->dev == dev &&
@@ -931,7 +931,7 @@ int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
 		struct xfrm_state *x;
 restart:
-		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + i, bydst) {
 			if (!xfrm_state_kern(x) &&
 			    xfrm_id_proto_match(x->id.proto, proto)) {
 				xfrm_state_hold(x);
@@ -973,7 +973,7 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 	err = -ESRCH;
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
 restart:
-		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + i, bydst) {
 			xso = &x->xso;
 
 			if (!xfrm_state_kern(x) && xso->dev == dev) {
@@ -1652,7 +1652,7 @@ xfrm_stateonly_find(struct net *net, u32 mark, u32 if_id,
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
 	h = xfrm_dst_hash(net, daddr, saddr, reqid, family);
-	hlist_for_each_entry(x, net->xfrm.state_bydst+h, bydst) {
+	hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h, bydst) {
 		if (x->props.family == family &&
 		    x->props.reqid == reqid &&
 		    (mark & x->mark.m) == x->mark.v &&
@@ -1779,7 +1779,7 @@ static void __xfrm_state_bump_genids(struct xfrm_state *xnew)
 	u32 cpu_id = xnew->pcpu_num;
 
 	h = xfrm_dst_hash(net, &xnew->id.daddr, &xnew->props.saddr, reqid, family);
-	hlist_for_each_entry(x, net->xfrm.state_bydst+h, bydst) {
+	hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h, bydst) {
 		if (x->props.family	== family &&
 		    x->props.reqid	== reqid &&
 		    x->if_id		== if_id &&
@@ -1815,7 +1815,7 @@ static struct xfrm_state *__find_acq_core(struct net *net,
 	struct xfrm_state *x;
 	u32 mark = m->v & m->m;
 
-	hlist_for_each_entry(x, net->xfrm.state_bydst+h, bydst) {
+	hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h, bydst) {
 		if (x->props.reqid  != reqid ||
 		    x->props.mode   != mode ||
 		    x->props.family != family ||
@@ -2097,7 +2097,7 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 	if (m->reqid) {
 		h = xfrm_dst_hash(net, &m->old_daddr, &m->old_saddr,
 				  m->reqid, m->old_family);
-		hlist_for_each_entry(x, net->xfrm.state_bydst+h, bydst) {
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + h, bydst) {
 			if (x->props.mode != m->mode ||
 			    x->id.proto != m->proto)
 				continue;
@@ -2116,7 +2116,7 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 	} else {
 		h = xfrm_src_hash(net, &m->old_daddr, &m->old_saddr,
 				  m->old_family);
-		hlist_for_each_entry(x, net->xfrm.state_bysrc+h, bysrc) {
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bysrc, net) + h, bysrc) {
 			if (x->props.mode != m->mode ||
 			    x->id.proto != m->proto)
 				continue;
@@ -2318,7 +2318,7 @@ void xfrm_state_update_stats(struct net *net)
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
-		hlist_for_each_entry(x, net->xfrm.state_bydst + i, bydst)
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_bydst, net) + i, bydst)
 			xfrm_dev_state_update_stats(x);
 	}
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
@@ -2509,7 +2509,7 @@ static struct xfrm_state *__xfrm_find_acq_byseq(struct net *net, u32 mark, u32 s
 	unsigned int h = xfrm_seq_hash(net, seq);
 	struct xfrm_state *x;
 
-	hlist_for_each_entry_rcu(x, net->xfrm.state_byseq + h, byseq) {
+	hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_byseq, net) + h, byseq) {
 		if (x->km.seq == seq &&
 		    (mark & x->mark.m) == x->mark.v &&
 		    x->pcpu_num == pcpu_num &&
-- 
2.51.2


