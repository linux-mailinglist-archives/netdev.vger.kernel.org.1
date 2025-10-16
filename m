Return-Path: <netdev+bounces-229992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8DDBE2D83
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA9464FD33E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8E12E54BE;
	Thu, 16 Oct 2025 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ScnjOPfC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yj8fSAM3"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C52D97A8
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611176; cv=none; b=ZEYDOKZ4oBWZT4ZLLc5g4PttGoIs6MHRBOJrsenGauGurY70VS8t6pE9MzPygF+B+NUFKhu34dsEf+kygK+Cj+fThw8VoVSEg+IzUhdn4Qws88ojv2jtor5KGtxRDNOcQGWWOMPXJ94bzD38v6UCKdquVke7mecVs2BOEQ3jLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611176; c=relaxed/simple;
	bh=cBCzkFqWsp+AiFQiLMNesy1RaSzXa4jRHcYGCHGN1Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oloA4VxfZuCUNyRP0WJyvwqr4VLGrR0AfOEBqKCY+T3v2zlkpWY+AmISl4WoCOmiyn7TMG0GcDVRWTfl8nHB8Yep1wXNBoLFsL+ycTyD+wCKgEeq/01hOmVy/yYI+Ra7p4tw4WIGbtV3k5a5h2YvMYvkTaa8FMcslATGF6E75ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ScnjOPfC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yj8fSAM3; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A0E1E1D00132;
	Thu, 16 Oct 2025 06:39:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 16 Oct 2025 06:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760611173; x=
	1760697573; bh=umXH41TgMlYn+S3uAcpVWDp6Dt5YIx/xoelbKDVcr3I=; b=S
	cnjOPfCM4JTSKTfumizKd7ys8mNcRTnCCzFC4VSnbxo8IG4VfGu0gXNEs7yyvrmp
	24np/YdoliMZr0+bap/gMixHm0PQANBaC+Ax/wzxRV1vjSrHrLF/BaAUq8hfDUlK
	kevuZI0JSR5Ha2xbRn/VHh0btGDVaczNZvANrMr8mib4Es/q3geWPglr8uMM+WpS
	D6HKIooV1QbpRm3W+4TzbI/VNtLOfFkX3uJMOUHkIliuRL4UdNy96sWWkcA1OUf2
	qLr/aF1Qqva97Ywwix8GmlavwQV6ydmWaM7WEPfj3lirFyobq4OQeAcze84Vyatl
	Nlipftp5E2/hpgxvScExg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760611173; x=1760697573; bh=u
	mXH41TgMlYn+S3uAcpVWDp6Dt5YIx/xoelbKDVcr3I=; b=yj8fSAM33wGArh2kr
	qDs/GO7fuzq5xx/DXvIVxx3/HVGZaQiwNTbY6oroNv5mLvZmkBzsMfadgXg+Yvpc
	ThKwHinWN5a9yyN1n3eKzhQIh/BfAJBgSOGn4xuUu2PKTzfHxjeKCN5NvkEdL7cf
	XC60OoRtzMlIsWlQ6pfryR8WuCBM1wQrDGacmXf72z1P8Dpz1JYiDk2IR8lRWqX8
	6L8cm8heHCWMha3RGbB+w6zi1jnmmYoKJaXmN3rJh9qRvc9NjnW17Hln9rorTv4Y
	/h7Gk66jEwxV4a9zjhFrFApeo5WexVRSFTby7UwRuTINeJ/09qQKszESNqkYQp7w
	jrpAw==
X-ME-Sender: <xms:ZcvwaNpEIr01TflQeMGwRSmPfmHPdnnYKJDdbmUci0Wmpyh8MyNUvA>
    <xme:ZcvwaGgTmPHUpqaFoxLX9KjJjzdfZSPAyvaZx5hkAHF5_bWU_gZRQvTfVeDx4oqKg
    tSY1GMg1_tvy_7dMfZR11dy_tDj5gsD3YtitKI39wN8PGxlu1Q16Z8>
X-ME-Received: <xmr:ZcvwaChGIjZq7h2VxxzWfsgz6DQHXDroc6nPgKF3u07pyl2fqOG5MFN5Qipa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeitdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgv
    thdrtghomhdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtph
    htthhopegthhhirggthhgrnhhgfigrnhhgsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehlvghonhhrohesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:ZcvwaEj5ILrB2E4tAjuFxri48x-nJ-ahdYA0iemUUX08FoWLMyozCw>
    <xmx:ZcvwaKKQdlOtnNsSASKZGjVMSSHo7ekhlfgCfHMxWRPyJRJrSr498w>
    <xmx:ZcvwaLF6weTtrvweJiWqGEwK_CS542r_yp0HpWMTM1ouwrKPrlPbpA>
    <xmx:ZcvwaGSLASpC26Wrsr7If3LMteRFISuY6zlMc5zU_Jarw9viGNr3jg>
    <xmx:ZcvwaN1QjA_xVK6aAW2JZPaDrQi2MsowmCc_rhkWATG49RwDhqOPtutt>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 06:39:32 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Chiachang Wang <chiachangwang@google.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH ipsec 4/6] xfrm: call xfrm_dev_state_delete when xfrm_state_migrate fails to add the state
Date: Thu, 16 Oct 2025 12:39:15 +0200
Message-ID: <6e1c4b4505fa3d822e2e33b681ac4a44bae959ed.1760610268.git.sd@queasysnail.net>
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

In case xfrm_state_migrate fails after calling xfrm_dev_state_add, we
directly release the last reference and destroy the new state, without
calling xfrm_dev_state_delete (this only happens in
__xfrm_state_delete, which we're not calling on this path, since the
state was never added).

Call xfrm_dev_state_delete on error when an offload configuration was
provided.

Fixes: ab244a394c7f ("xfrm: Migrate offload configuration")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1ab19ca007de..c3518d1498cd 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2159,10 +2159,13 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 		xfrm_state_insert(xc);
 	} else {
 		if (xfrm_state_add(xc) < 0)
-			goto error;
+			goto error_add;
 	}
 
 	return xc;
+error_add:
+	if (xuo)
+		xfrm_dev_state_delete(xc);
 error:
 	xc->km.state = XFRM_STATE_DEAD;
 	xfrm_state_put(xc);
-- 
2.51.0


