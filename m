Return-Path: <netdev+bounces-229126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB1DBD861F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E24304F9D1A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6354F25D546;
	Tue, 14 Oct 2025 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="MAcPLmul";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pWuyOeg5"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E582E36E3
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433487; cv=none; b=XShfRkU0FKr8Ow4jz7kI+6vH1b+lYMWRrDbOyHbpTQtU1nt3Y6HlmppJt/GGnl8lY2xwG9ZQ748pyBlL6nEMd3IAkJ0JaVQ8+yqLVGqQosLC3OSoUBdJVeBdtIDmIe1wz5DdCkRpbbI2D+9q/YdxpIyfgImYDHpDP/CXeamdiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433487; c=relaxed/simple;
	bh=E5hdFOES43aP5/ZuTg06NAl+g0REHa9XedQF69CSDfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1hK4kH1wlqADH/HIuqdvf67Seq3Od6WTyqEXoch6W3XQiPDJezNxwlez4oxZRNehbQi+bfHv/Qh6pxB0AsB+EG8M7L0sA5lK/bOWYTe1+JT6P5NnIwFh8SwslA5jjYyLC058XljogUxRdloNxoRGfk8kIWc6KPCw8g2ueZqFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MAcPLmul; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pWuyOeg5; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CDF0EC023D;
	Tue, 14 Oct 2025 05:18:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 14 Oct 2025 05:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760433485; x=
	1760519885; bh=LquEGaSJAJNTW4E4jtkBp7oSmjXHpt6pK5qtc9gMQNU=; b=M
	AcPLmula3koTnwjeKUJ8CBkhcptgvJLi7zLHDRfXTMzVTqBah/LMukq9QX997XG3
	wXQeHNxN/MCo5AEFSmEWBLjn/1IhTKJ8KKVHQ7dQ622IycgyTiAhgC987le3MVUW
	zFuBt6EDtUBe467PPpmDKoFZBS39/J1Qw1m0KLao4NxhFrADaIejTEXaM0d2srpa
	GW2yB7LwWqu2CNAWbYrVZILo0O3VUF2WC8cjj+oZYum2LTtVjm7XEa66+3zuohXJ
	DWvZAsutMnjtE1ga7/qIIuYDeNgcfNjC9pGPKwHtvQbcfj/JB0VX7hIPjkJenqV3
	WePqZ5hyfV/iZ9JB3Sskw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760433485; x=1760519885; bh=L
	quEGaSJAJNTW4E4jtkBp7oSmjXHpt6pK5qtc9gMQNU=; b=pWuyOeg5wetperxSG
	7ln46BO7e0Ab7OjkBLacrg9G6PG83hH88/pgfduZENGThRZSfzaNuAOdnpbCxgC2
	NSuEG0tZcmE1IeTlRbEIOO9F6RWe8OOv5fhSTZW2ZfiIzfCDfv8HSRuevLFkQCYR
	TbF/WzFw5/56Rfr2vt2UneUzDAk9uRYTlpUwI4xzwM3kVVppLCsd5KAs8sNGnbWi
	zhd0lJkk9MwdY6WJd7k7IeJrrp9sCguIDQ1avtB11S4Ac1Ttx36Db00yR0m4dOgM
	schNgHlD4LSSucq7bmLEBPHuvm1rsKCvq1eynErTD6vuyfajSpN6ZaXXJP5XeXJe
	tnMKg==
X-ME-Sender: <xms:TBXuaHnJ_BdXbzohc2RZoJI7PmRwvoc2zOOTKLbvX0zbdz1R7VYmaw>
    <xme:TBXuaBtlXRiQEvdGd7Ruv6-Iph5huO49MNsXqrLmOYunOc3DVD3iH_9T9wTyNW_V0
    B5kyFqWGZzPjcKqFPtYcnnA3Ot6xp0edqjgMUwXHgL-5qyYTIi-ow>
X-ME-Received: <xmr:TBXuaF_hkIp19Sw5b87TpqoMyKHWP4X7RyzK-4i5DIZiosp3wHxRX3mBlbwG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhf
    egveeuhfetveeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrg
    hshihsnhgrihhlrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhhnh
    drfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:TBXuaLN5YNVG7ELo6BDLU5gahUykmEEyuEN_No3CXK53XSaOd4AU7w>
    <xmx:TBXuaDFghCdVOgptqHuagrMagA_QbRBnQRhbiaMq5Ct8fJKmN2w69Q>
    <xmx:TBXuaJRU8fDllYNOzUZLx18ECcwJcom0vCImbIIpJdzfJiNCUEwc8g>
    <xmx:TBXuaAtDZw_S5utZtRXxPb8SxEmFouraUGs4hNAJXBEMVSDUKhQDiQ>
    <xmx:TRXuaEqKE9Ooi7oGPNhBDxbmkgDBVeM3GpQRTC3EzirvQJW3cQPF92Qe>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 05:18:04 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	kuba@kernel.org,
	jannh@google.com,
	john.fastabend@gmail.com
Subject: [PATCH net 4/7] tls: wait for pending async decryptions if tls_strp_msg_hold fails
Date: Tue, 14 Oct 2025 11:16:59 +0200
Message-ID: <b9fe61dcc07dab15da9b35cf4c7d86382a98caf2.1760432043.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760432043.git.sd@queasysnail.net>
References: <cover.1760432043.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Async decryption calls tls_strp_msg_hold to create a clone of the
input skb to hold references to the memory it uses. If we fail to
allocate that clone, proceeding with async decryption can lead to
various issues (UAF on the skb, writing into userspace memory after
the recv() call has returned).

In this case, wait for all pending decryption requests.

Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 1478d515badc..e3d852091e7a 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1641,8 +1641,10 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 
 	if (unlikely(darg->async)) {
 		err = tls_strp_msg_hold(&ctx->strp, &ctx->async_hold);
-		if (err)
-			__skb_queue_tail(&ctx->async_hold, darg->skb);
+		if (err) {
+			err = tls_decrypt_async_wait(ctx);
+			darg->async = false;
+		}
 		return err;
 	}
 
-- 
2.51.0


