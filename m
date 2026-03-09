Return-Path: <netdev+bounces-265468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBZMDFuirmk9HAIAu9opvQ
	(envelope-from <netdev+bounces-265468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:35:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA9A2372E5
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D3FB3029C28
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C41F3921EF;
	Mon,  9 Mar 2026 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="CQ8QN2co";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eKK5ZT98"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016923921C9
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052390; cv=none; b=b9DrGbVisw1BQujHDHgSr7r+Mg6QKSZu5yIVpW9vypz2pR89nLRpXwX2j0LxA4U/xnxOcFBU/DWS/MDZyvPBLhueOQk3tSkcQ/GZId56bL4FFvlK0n6e2v8ctk4AzIcSDCCCfchFHSqfgtkMZGK220OD0dJAOVo2rxpDITBfKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052390; c=relaxed/simple;
	bh=4nVx+dfc34wSjxMNFNzob2kqVG8lLshmV89qLyU96wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAKKVb186NJvTMY4lrjN7SkScPiddl1BKoMi+CxdijNC/ox8MnQpCnNVXNVIx1lWktGF4fcxeGK18CJFa0xYqiZDMalQ+awO4Zuu8y7c5X1mVY8ooaWIakjKV7TGELC+O2y/hbis6GdBCXKqz/8CA5AqFXblt9VPQne7oFoCvTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=CQ8QN2co; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eKK5ZT98; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4277E1D000F5;
	Mon,  9 Mar 2026 06:33:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 09 Mar 2026 06:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773052388; x=
	1773138788; bh=9DunP40OM/9+FqBtITT7B0wuTymMMcYD10yc9ex7f3Y=; b=C
	Q8QN2co/bTPC/ogDO5X9k2tzbeNts/hCiZio3/FJ15TdTULXxhXt9s7+W/jtukZN
	CoLJVaDsrLuvMQZmHN87RDXAVYXhqCSTioSHJcckNYkyxPYCjIoYCnby6d9BxXDC
	OZaZmIO/55i5ZDRjnUpVGV4FarwnGUT01L1OCWBeXECnC9bXZdDSaQywM9REP6mx
	QLGUQOZvGVrwp2b68yreSafpR6bX4aR3KUB98QabPoALoHUHVDLAw1O8XsE+7WlG
	cff+eGMpcoyz4+BiFCuvYmhrox51xEMPCeB3H1gHRPPKWyVY2cj8aQqK4v48Xgkn
	685SkvX60TXXoZn+7TOPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773052388; x=1773138788; bh=9
	DunP40OM/9+FqBtITT7B0wuTymMMcYD10yc9ex7f3Y=; b=eKK5ZT98vocUcTIp8
	QXbD22GCNPGFcMdNnXh9qnkjoxP0MUBhpvUVbDQkoQt6b88cgRF0tGYy29hRpf2n
	vZZAUCRGqu60tgaoep7IEcM8/OksbXG5BeVxOSekNh0KizGH3h7POpOFXhsmbRh8
	RkTTxOQjMGmKiZRoRGsns4YWd6SBdC1AObmvTYbs8C3tNCI+4T4xXF3CvTFFXxZ7
	cxnCn0+WIul03UfhUB8I3UxEOZqUmY/BkbLDVVlEi8iL2uEzUF1vZWD/a6sCNRex
	r7mzGoIaWBbZkHtgcRSLm9FuVpk4bru0p03EHCH0zPb4ympEJskMxqal5FL32k+5
	y0VPA==
X-ME-Sender: <xms:46GuaYWarViq_PKTaP-O27ueqsdCaqkD8252P_ncgD7jMem6t2kJ3g>
    <xme:46GuaYCW8NHO_RYcOf-Bq917BJHGeaj22CFlIw4u2ZqtCLeL9ov_qQ7_-Dn-iU4Lc
    Zk14H-qjnV_eg9ZcaF_OqTNidS_Jb3Gw_-4TO0a_EMmNBvzvxDw4Us>
X-ME-Received: <xmr:46Guaf4nktBEaJ4nCy17eOGxKwFJU78R32UWtYQU_OOJky7fu_uSLeiCskUP>
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
X-ME-Proxy: <xmx:5KGuabwhflss2qrAgcz-fjyyw9i9Wu_IKmNVgYy0ebmPEm39BkLGAA>
    <xmx:5KGuaezXZQuw-rRFHFNJM-vgCZyofj3ROEqu8SRz5_bSvNjIB2KmqA>
    <xmx:5KGuabwhjJUc5bHN1F78FSonlP74mLJJlgEWchk9EpBQ184tRd9iSQ>
    <xmx:5KGuaQYCX-nSePR42SrBXpY1p2iaT9zzayLdCa92rQjXRjY-Fox9iA>
    <xmx:5KGuaXKTfPWHfu7tIb0P8D3ZeObZB82fRgMfxsf23cFmnbqUXAOY3d7u>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 06:33:07 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next 06/10] xfrm: state: silence sparse warnings during netns exit
Date: Mon,  9 Mar 2026 11:32:39 +0100
Message-ID: <d7e787dfa3c57b0bb3b7ab1ca7814eacba22494a.1773051558.git.sd@queasysnail.net>
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
X-Rspamd-Queue-Id: BDA9A2372E5
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
	TAGGED_FROM(0.00)[bounces-265468-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

Silence sparse warnings in xfrm_state_fini:
net/xfrm/xfrm_state.c:3327:9: warning: incorrect type in argument 1 (different address spaces)
net/xfrm/xfrm_state.c:3327:9:    expected struct hlist_head const *h
net/xfrm/xfrm_state.c:3327:9:    got struct hlist_head [noderef] __rcu *state_byseq

Add xfrm_state_deref_netexit() to wrap those calls. The netns is going
away, we don't have to worry about the state_by* pointers being
changed behind our backs.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ff421fb73df5..5b29d770a3fa 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3315,6 +3315,8 @@ int __net_init xfrm_state_init(struct net *net)
 	return -ENOMEM;
 }
 
+#define xfrm_state_deref_netexit(table) \
+	rcu_dereference_protected((table), true /* netns is going away */)
 void xfrm_state_fini(struct net *net)
 {
 	unsigned int sz;
@@ -3327,17 +3329,17 @@ void xfrm_state_fini(struct net *net)
 	WARN_ON(!list_empty(&net->xfrm.state_all));
 
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
-		WARN_ON(!hlist_empty(net->xfrm.state_byseq + i));
-		WARN_ON(!hlist_empty(net->xfrm.state_byspi + i));
-		WARN_ON(!hlist_empty(net->xfrm.state_bysrc + i));
-		WARN_ON(!hlist_empty(net->xfrm.state_bydst + i));
+		WARN_ON(!hlist_empty(xfrm_state_deref_netexit(net->xfrm.state_byseq) + i));
+		WARN_ON(!hlist_empty(xfrm_state_deref_netexit(net->xfrm.state_byspi) + i));
+		WARN_ON(!hlist_empty(xfrm_state_deref_netexit(net->xfrm.state_bysrc) + i));
+		WARN_ON(!hlist_empty(xfrm_state_deref_netexit(net->xfrm.state_bydst) + i));
 	}
 
 	sz = (net->xfrm.state_hmask + 1) * sizeof(struct hlist_head);
-	xfrm_hash_free(net->xfrm.state_byseq, sz);
-	xfrm_hash_free(net->xfrm.state_byspi, sz);
-	xfrm_hash_free(net->xfrm.state_bysrc, sz);
-	xfrm_hash_free(net->xfrm.state_bydst, sz);
+	xfrm_hash_free(xfrm_state_deref_netexit(net->xfrm.state_byseq), sz);
+	xfrm_hash_free(xfrm_state_deref_netexit(net->xfrm.state_byspi), sz);
+	xfrm_hash_free(xfrm_state_deref_netexit(net->xfrm.state_bysrc), sz);
+	xfrm_hash_free(xfrm_state_deref_netexit(net->xfrm.state_bydst), sz);
 	free_percpu(net->xfrm.state_cache_input);
 }
 
-- 
2.51.2


