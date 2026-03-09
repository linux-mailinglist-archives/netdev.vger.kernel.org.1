Return-Path: <netdev+bounces-265469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Mu8Mzeirmk9HAIAu9opvQ
	(envelope-from <netdev+bounces-265469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:34:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBA62372C6
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3B653017A8A
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 10:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F91392805;
	Mon,  9 Mar 2026 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="l738GErJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zTI1yZET"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEA73921F6
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052392; cv=none; b=IVusVOLo4ydxV8Q7qHyYU2fHQSouUfptY7eYU/bkyk4G8xS6L3Y9SnO7n1VXruMWvXUH+G1NpwyS3xfSlCyYUgGPAee8/tBz1uACc+KwOSm8Els2t0fhHO09e6hYi4UKZ1yANKxUmPv41IOGBrOXyiJT3m5AMns5+PyI2HIG9VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052392; c=relaxed/simple;
	bh=+jmSSww1S6bF/yPnekH9HKEgRK8SIBfjd7iElGotjuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAh//uGi50bA0rihWrVYLhzYGn5jCtbborFne/NhvzX/tEEEJoO3W8HLz4VlzidHm+f3guPdaU97WpEtmxv8KMyZ2ZxMPgzIeowwdfD1B+p/CREkzV4W7aLwz0vbqod5bLrGEBnlv5VUB0Bv9cLzIuoZFp6jFydu5eNKpEAkNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=l738GErJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zTI1yZET; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 701481D00128;
	Mon,  9 Mar 2026 06:33:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 09 Mar 2026 06:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773052390; x=
	1773138790; bh=DFjnefFZKhix9UUf4269TdZR68pnBMsopqiKP7Dt8lo=; b=l
	738GErJ14r5FKZ3hdhM9fSXbauO88cSxRV5WRN2C9tEze4NgZ1JFVcxCdm1yVaD6
	lQzUutNgtZsVy4+YJtt/MihDQnFBrg8GUwcsT6iPhukbsw/eJ+rrUpQ5D0NND/3j
	ROeSrFCQZmvjHfDOACj4zFLvhr6PPHRphkrbEbu5WmA6Dgjp+3c1YAScB20KP7k9
	KtOXnUI46UrWAtdh1rmLRE8w1H1jfr1XwyBtPN6H0sHg0Lyp0h2fpeM9xg2mDohr
	LoF6eLDMjae0frEufntN6wD7SV1wau4b7BmDdog3MHhx/SORz89XHfmkV9UQQcOn
	MyYshdxtLdwCai5p7rldQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773052390; x=1773138790; bh=D
	FjnefFZKhix9UUf4269TdZR68pnBMsopqiKP7Dt8lo=; b=zTI1yZET1WFRxjatc
	2xok+j2KE32/PuCnDf6vq1aO/Aq4BxieUr+ZDWObJuPP2NsndCmNi+4gOxpvCOdt
	PQVIiQPdrLrTDYFmTMBisDBI6VbRpngitFlqmibEXCsLZTFzHO4cnjjTCPV6lhU+
	NpCgkYkNfvx5ZMI7FyArty+SmmmFyMHrdvfUE/CEBEJsBY507hHDVnIAsbxhTVx9
	wC/iATq5HABJwPYAyK683PLdtBnhCKsol9RJqXzKWKjnZUV3mlRKudxqjGhh/NKg
	cDKH9VGXPx1YR7920eSzZo7TK8QfMGojPi4cchD9/KYeZ/lUfVZG3N78cMtq6aQ9
	zG8Wg==
X-ME-Sender: <xms:5qGuaZVtZcVY5sRBivxDzVjLj8nl4kU8EU7ZRaORQ1s0i23TSdq4XA>
    <xme:5qGuaVDUlbYa_6vs6NWD0lRYjiDEuoFTRo7tYKmbLk6ErciEnqtBqqnpCT_iQHqrX
    vSAPe1dZOl0rsGdzLGnkTwYt7eONG8Ld72Q19ificbd4-KjdX_o2Gzz>
X-ME-Received: <xmr:5qGuaY5ZNvymxOvANohVgQffM66-CiCPyFLyG66Fvc_zJGGwo0AAGZiYupYq>
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
X-ME-Proxy: <xmx:5qGuaQycrgWwQ8GsZL88ni2C0i1Xu6LA_SeolhVeMtjBdja4xXMq8A>
    <xmx:5qGuafzLrTEohSrqPsMQLtIH2DBJ3TfJ4qMFXCw4Eu715VeMR9miww>
    <xmx:5qGuaYxsNWaxNn_QUaubJXDzJ_3ETRbaFkMA3jUDOZKocNsdXY0H9g>
    <xmx:5qGuaZa8ajJ92G3PkJE3bif8zibwfAzE5eT85yq_yLZ4l40NA8FD3Q>
    <xmx:5qGuaQJzboYYv9S0dvPiswrSgQNrA29wO6GsvfhUqL64C8LHv6fBdn1M>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 06:33:09 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next 07/10] xfrm: policy: fix sparse warnings in xfrm_policy_{init,fini}
Date: Mon,  9 Mar 2026 11:32:40 +0100
Message-ID: <de5b319a60e802352fb102e24b6120400b4f2f54.1773051558.git.sd@queasysnail.net>
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
X-Rspamd-Queue-Id: CEBA62372C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265469-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid,messagingengine.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

In xfrm_policy_init:
add rcu_assign_pointer to fix warning:
net/xfrm/xfrm_policy.c:4238:29: warning: incorrect type in assignment (different address spaces)
net/xfrm/xfrm_policy.c:4238:29:    expected struct hlist_head [noderef] __rcu *table
net/xfrm/xfrm_policy.c:4238:29:    got struct hlist_head *

add rcu_dereference_protected to silence warning:
net/xfrm/xfrm_policy.c:4265:36: warning: incorrect type in argument 1 (different address spaces)
net/xfrm/xfrm_policy.c:4265:36:    expected struct hlist_head *n
net/xfrm/xfrm_policy.c:4265:36:    got struct hlist_head [noderef] __rcu *table

The netns is being created, no concurrent access is possible yet.

In xfrm_policy_fini, net is going away, there shouldn't be any
concurrent changes to the hashtables, so we can use
rcu_dereference_protected to silence warnings:
net/xfrm/xfrm_policy.c:4291:17: warning: incorrect type in argument 1 (different address spaces)
net/xfrm/xfrm_policy.c:4291:17:    expected struct hlist_head const *h
net/xfrm/xfrm_policy.c:4291:17:    got struct hlist_head [noderef] __rcu *table
net/xfrm/xfrm_policy.c:4292:36: warning: incorrect type in argument 1 (different address spaces)
net/xfrm/xfrm_policy.c:4292:36:    expected struct hlist_head *n
net/xfrm/xfrm_policy.c:4292:36:    got struct hlist_head [noderef] __rcu *table

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_policy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7bcb6583e84c..9b8d37502de3 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4235,7 +4235,7 @@ static int __net_init xfrm_policy_init(struct net *net)
 		net->xfrm.policy_count[XFRM_POLICY_MAX + dir] = 0;
 
 		htab = &net->xfrm.policy_bydst[dir];
-		htab->table = xfrm_hash_alloc(sz);
+		rcu_assign_pointer(htab->table, xfrm_hash_alloc(sz));
 		if (!htab->table)
 			goto out_bydst;
 		htab->hmask = hmask;
@@ -4262,7 +4262,7 @@ static int __net_init xfrm_policy_init(struct net *net)
 		struct xfrm_policy_hash *htab;
 
 		htab = &net->xfrm.policy_bydst[dir];
-		xfrm_hash_free(htab->table, sz);
+		xfrm_hash_free(rcu_dereference_protected(htab->table, true), sz);
 	}
 	xfrm_hash_free(net->xfrm.policy_byidx, sz);
 out_byidx:
@@ -4288,8 +4288,8 @@ static void xfrm_policy_fini(struct net *net)
 
 		htab = &net->xfrm.policy_bydst[dir];
 		sz = (htab->hmask + 1) * sizeof(struct hlist_head);
-		WARN_ON(!hlist_empty(htab->table));
-		xfrm_hash_free(htab->table, sz);
+		WARN_ON(!hlist_empty(rcu_dereference_protected(htab->table, true)));
+		xfrm_hash_free(rcu_dereference_protected(htab->table, true), sz);
 	}
 
 	sz = (net->xfrm.policy_idx_hmask + 1) * sizeof(struct hlist_head);
-- 
2.51.2


