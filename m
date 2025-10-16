Return-Path: <netdev+bounces-229991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2331ABE2D7D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF1B74F7944
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFF430507B;
	Thu, 16 Oct 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="c7w3RjH+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AODYqdWl"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5492E54BE
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611173; cv=none; b=i+TmHlDt+Zmeu+fFxZlZryOdc3q01bLEyuj1/DgE9m8w1LfuTqYQAjU0LJFotr60Bm2Y6bZMmDahkqD2+anVSRdyz9BxhBsVtOT6TRtjiJWzkKqw9hjzURVqpwNBodbhM/ydMM8wVUI4vOwZDT4POi7NZE+vf09tqQWluvcf5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611173; c=relaxed/simple;
	bh=elZAJSKQYkHZ/u5huzCuSYtkLm8ftQN9WUka2fuBsUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfG5ckLhKevF1SRzMyNCrA1q06oDaQFPsiSxS7J1eWZuLE229k3dBeSrhWVebnUOx7FC3lO6T8hlkUyo0Qke4AsC+hHKzAhaBjH5xmAixFY9Ovp9ZPryi+mAnBuDrVgup9rmZxldoiJy5jmaoJsTRPlYx/HbwgRtnyfiw2qFlAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=c7w3RjH+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AODYqdWl; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 446461D0012F;
	Thu, 16 Oct 2025 06:39:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 16 Oct 2025 06:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760611171; x=
	1760697571; bh=KLy3rGIHXva/Tnf+qRUOwFOsqfBwRLKxQ2oNEwIHKiM=; b=c
	7w3RjH+qrummGDzuDa0Jia+pnFk863dSsQt3BV1TMaa3LAhbtqGqEFwZQV7e4tXi
	x754MIjcooH7YQwSCKndBLx/t2n7ypHogPNvKkES4/cnnlgNhntx99x6wQxHrq/z
	MuStntmKdgZJgufmcC5iWbAzm1Sv/46QmzDaFX79tR1WP2lu6cMBy0NEmOTjX7E3
	NHTv2yifE/bPhHJXWSfur6XzmEkEbLVmYuxIjvm/4oXUV4vrQGg6YvyKPKCkDmL2
	mpUeDC14jO/tD0yPWhEOECJMhLR36piL+ZUcBdvj/lXaUei3V9gAWTJfYRZ3ivb6
	0c7C6xdepZ32URHAAAi6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760611171; x=1760697571; bh=K
	Ly3rGIHXva/Tnf+qRUOwFOsqfBwRLKxQ2oNEwIHKiM=; b=AODYqdWlC3/MKAFpz
	qYFwzf1mMO2wpbKNJuArUXmySaqYYgfb/lHdJDDBomNPTkWiWoaKA+bCDC2CFurD
	tdySE4ELzObD1PCutdcc1YZQeKfFPkfVp3jzWNeuhjBkUpfkw2A6qK5Lz9Oy4nc1
	mxhDPvyOvnj9Xn/9HFk7Z24TeLMBs3IUXTs9cVlQON8LuwcRy+pkbTyKgViQnX9y
	XKb7Uet9FhXzwEVoypaKViVXtKwlZmJobNaFJXpk+5vaJBUYildOyn3ZP4PjLo9o
	CLdlEQTYEkzUo3EcPDNQdyYW0AeQPhpTGJpZgZzg3eyf2TFcTXO366eT23b7njXU
	ad+ZA==
X-ME-Sender: <xms:YsvwaDWiTRZn4BOFbG3V3CAXA-4wYmP9FqMuZ-TnIiZYX6G0Nz0aCA>
    <xme:YsvwaJa8xZZ_AIQIJqU68kMyBYYhU3HdYuWoTplH5Pssq_32OQ9Qur2z-BwkPhG6a
    mPiuRsLBJeJ1VgKqohxy4e0l2LX1bWLvmFBIYB2ApcO0kc6SazGwo3U>
X-ME-Received: <xmr:YsvwaJ1FKXUDBZquwkp5sjg1kbOKchHhzjkyM11uRjsjm8mOt_QWmQu-IaXW>
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
    grihhlrdhnvghtpdhrtghpthhtohepshihiigsohhtodehtgguiedvleelvgguvgegugeg
    fhejtdelkeejsgesshihiihkrghllhgvrhdrrghpphhsphhothhmrghilhdrtghomh
X-ME-Proxy: <xmx:YsvwaLj_b5hKA1B2RnIKxv4Cn-dexzvfo55AeVWbIfUPJuPbojaJXg>
    <xmx:YsvwaNZE-lz1vRllCcy6adtDQEfYH4GypXnRgqxwj4gG1GUp0I0-iA>
    <xmx:YsvwaLR53JSsp96y1qVk7IyxBcCe4ZHM4OhtMIw08ga6nqlQCHS9Lw>
    <xmx:YsvwaIQcOmRaLvgoxAONRZRcImXFUurZa0Ta6ogFmOHT6j1dIxm1HA>
    <xmx:Y8vwaNkUNUIj9TINEPoBYzZ_12UCj4444E67EHpx1_kFKAPD9-5bLSyN>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 06:39:30 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	syzbot+5cd6299ede4d4f70987b@syzkaller.appspotmail.com
Subject: [PATCH ipsec 3/6] xfrm: make state as DEAD before final put when migrate fails
Date: Thu, 16 Oct 2025 12:39:14 +0200
Message-ID: <2fdfa244565952f0937b64b3a5822e548e1aad66.1760610268.git.sd@queasysnail.net>
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

xfrm_state_migrate/xfrm_state_clone_and_setup create a new state, and
call xfrm_state_put to destroy it in case of
failure. __xfrm_state_destroy expects the state to be in
XFRM_STATE_DEAD, but we currently don't do that.

Reported-by: syzbot+5cd6299ede4d4f70987b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5cd6299ede4d4f70987b
Fixes: 78347c8c6b2d ("xfrm: Fix xfrm_state_migrate leak")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 721ef0f409b5..1ab19ca007de 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2074,6 +2074,7 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	return x;
 
  error:
+	x->km.state = XFRM_STATE_DEAD;
 	xfrm_state_put(x);
 out:
 	return NULL;
@@ -2163,6 +2164,7 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 
 	return xc;
 error:
+	xc->km.state = XFRM_STATE_DEAD;
 	xfrm_state_put(xc);
 	return NULL;
 }
-- 
2.51.0


