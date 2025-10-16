Return-Path: <netdev+bounces-229990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A544BBE2DBC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E37C404C6A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C392E541F;
	Thu, 16 Oct 2025 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="XoBjkCDT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wTbM9/er"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29C32863E
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611171; cv=none; b=s4dETkVJJgWoP2vwRvAVaCiy8SNJYZ/BgYe6z/X1Tuw6oDO7ZR3gNW/yFfpBD6oePq/bN0NH4deXftWYJ9nhspc8egW4i7d+LaHuq5mRKcA1Fl/RRQVkT1OOMKZV9WbTlr2AzErHPJwVcMUaLurQLhn8nFDqVtHZWldiOLuopM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611171; c=relaxed/simple;
	bh=yt0x77WhdmVGZAVP0mi71naEO9h4ADHhasQN54sH8mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZ4P/2QwmuC8dRGfD7QSzMftVc4p1apaRZA3ovFQ/XemEUsfgqiktosJ/F5ZPyhGIwpEu20GUos5a8iSJMec7htHyb82z6kYMeYT8yJH65xv2pN1yo0fF4BAhxLky+388QwoUkA8xDK3OYQjiu/ZnnqB4IYTGwW4coOVqXbC1j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=XoBjkCDT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wTbM9/er; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 73EDC7A015D;
	Thu, 16 Oct 2025 06:39:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 16 Oct 2025 06:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760611168; x=
	1760697568; bh=Tk72nHULt4cuEo3Gp9b6Qd7CGujfOTBLZ71xUf6a8/w=; b=X
	oBjkCDTLOYQC30n0mzMB2IoqmhGyoqqWIICkch5u9efPtVIbFP4VH8PHUYxVw21B
	wOZaxmL94hb9YsCCT6skGYDtbSZHKTuUAOMx43ZpuMFAzEyuMgCMPvge1MkaBOxj
	wx8+V144lgh4rSdNhNbDxMLUHfpujB6K2U/xGO/vCPWtFhiZOrgx/EWMF4dGECRI
	r96uRE+OPAbZFyvXYbtq63ZjWzHsAfChEBNDoNFIxqtK/7WYAwCCfm8sLaSd16XB
	wWhgxS43IdGKBrVJD8UU8vvRzwehiAXltghZ/IyH60Y+fO1dqjTNvj4XfzwreoZA
	RyDLHfVdnMiMQ90O2kEqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760611168; x=1760697568; bh=T
	k72nHULt4cuEo3Gp9b6Qd7CGujfOTBLZ71xUf6a8/w=; b=wTbM9/ervWmA02kox
	JCWPMVYJ34vgPkSN/V/RJb26eHa8g9FsSWB7mQy/rKKj4J24VhbCywvvB+JuZkKg
	clYsHe/rZV4v067dbITxsrUiTD0SbV3z9JKOxC1fDSGvqP1qDF23y+r+s3BO3cnN
	AXfZltqJopROXGOdPfxC8kjlWtxReJ5vZrAJa0USnH5qxlzrlSTN+4ZaNNTmUlUC
	2S0nLuiRuVoINm9SfZSBrRmpg28A5vWYj4p/s5C4xZQ+nqk1EUt1t/tyXIHRK4kY
	T/zJ6qSYS6w4RpUM4M4FX3Ltp6YKNw34z6I9AU5cZtvAts0JPzcuGJskzZUqrBzC
	0L5bg==
X-ME-Sender: <xms:X8vwaL2kDv49p_1A8Yy_HWyqx-A6oYY0gxgOeYYhN5TpAAXe1wdIvQ>
    <xme:X8vwaH4AmvHayGA0GRaW90Meaaq_4lJunuCkK6C2KipMBB2SjXFNDt3tWLDV8FcAO
    VoZTgCYYFHFGsRquVJGF77aUIlWA42LGOfKvVa1Af1tesFZeqTQXOE>
X-ME-Received: <xmr:X8vwaGWfbKBBXCYjYX5aAPFsFQ2bXllzDytWiVHk575Fe4aBBH6xxr0VN-kU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeitdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeekheettdetffdufeegjedvve
    ekudefjeejueevkeethedvhfejgfeiveelieehvdenucffohhmrghinhepshihiihkrghl
    lhgvrhdrrghpphhsphhothdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghs
    shgvrhhtsehsvggtuhhnvghtrdgtohhmpdhrtghpthhtohepshgusehquhgvrghshihsnh
    grihhlrdhnvghtpdhrtghpthhtohepshihiigsohhtodelleelvggsvdefgeeijehfkeef
    fhelsghflegsfhesshihiihkrghllhgvrhdrrghpphhsphhothhmrghilhdrtghomh
X-ME-Proxy: <xmx:X8vwaODpJrvUvslDlIfSCP91-qpYA7O3lqxdiQyBNKyczIAccsTTBA>
    <xmx:X8vwaN7nGwiRLbxQpbkwYQJC4GGpH5IMAAprt0itIEGUbRNCGEt3rA>
    <xmx:X8vwaBwUCOYylU57hpK_kEO29XON-P3PnB1PQhVdo0S1q7ZCXjop5Q>
    <xmx:X8vwaMxKZKjYHm5iIMvKazEVV09631bw2dPxE2dPUuZk86_JWaOcvw>
    <xmx:YMvwaCGu_PdL8p0HZP_rq4mhZkheS-ETVvdFAQAfDplTJAtStxdtDAHU>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 06:39:27 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com
Subject: [PATCH ipsec 2/6] xfrm: also call xfrm_state_delete_tunnel at destroy time for states that were never added
Date: Thu, 16 Oct 2025 12:39:13 +0200
Message-ID: <15c383b3491b6ecedc98380e9db5b23f826a4857.1760610268.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760610268.git.sd@queasysnail.net>
References: <cover.1760610268.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit b441cf3f8c4b ("xfrm: delete x->tunnel as we delete x"), I
missed the case where state creation fails between full
initialization (->init_state has been called) and being inserted on
the lists.

In this situation, ->init_state has been called, so for IPcomp
tunnels, the fallback tunnel has been created and added onto the
lists, but the user state never gets added, because we fail before
that. The user state doesn't go through __xfrm_state_delete, so we
don't call xfrm_state_delete_tunnel for those states, and we end up
leaking the FB tunnel.

There are several codepaths affected by this: the add/update paths, in
both net/key and xfrm, and the migrate code (xfrm_migrate,
xfrm_state_migrate). A "proper" rollback of the init_state work would
probably be doable in the add/update code, but for migrate it gets
more complicated as multiple states may be involved.

At some point, the new (not-inserted) state will be destroyed, so call
xfrm_state_delete_tunnel during xfrm_state_gc_destroy. Most states
will have their fallback tunnel cleaned up during __xfrm_state_delete,
which solves the issue that b441cf3f8c4b (and other patches before it)
aimed at. All states (including FB tunnels) will be removed from the
lists once xfrm_state_fini has called flush_work(&xfrm_state_gc_work).

Reported-by: syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=999eb23467f83f9bf9bf
Fixes: b441cf3f8c4b ("xfrm: delete x->tunnel as we delete x")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index e4736d1ebb44..721ef0f409b5 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -592,6 +592,7 @@ void xfrm_state_free(struct xfrm_state *x)
 }
 EXPORT_SYMBOL(xfrm_state_free);
 
+static void xfrm_state_delete_tunnel(struct xfrm_state *x);
 static void xfrm_state_gc_destroy(struct xfrm_state *x)
 {
 	if (x->mode_cbs && x->mode_cbs->destroy_state)
@@ -607,6 +608,7 @@ static void xfrm_state_gc_destroy(struct xfrm_state *x)
 	kfree(x->replay_esn);
 	kfree(x->preplay_esn);
 	xfrm_unset_type_offload(x);
+	xfrm_state_delete_tunnel(x);
 	if (x->type) {
 		x->type->destructor(x);
 		xfrm_put_type(x->type);
@@ -806,7 +808,6 @@ void __xfrm_state_destroy(struct xfrm_state *x)
 }
 EXPORT_SYMBOL(__xfrm_state_destroy);
 
-static void xfrm_state_delete_tunnel(struct xfrm_state *x);
 int __xfrm_state_delete(struct xfrm_state *x)
 {
 	struct net *net = xs_net(x);
-- 
2.51.0


