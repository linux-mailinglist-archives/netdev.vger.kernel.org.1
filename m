Return-Path: <netdev+bounces-260255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIYwG6LdnGl/LwQAu9opvQ
	(envelope-from <netdev+bounces-260255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:07:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B843117ED2B
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79FBF309EE09
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1584A37D13E;
	Mon, 23 Feb 2026 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="htAm/taj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QWFrPNx4"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7837E2F0
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887935; cv=none; b=IV12btRvY+ApET979s70Pr+Y+04+yVnaw9NzAOczho3YxyodzYRSk+34srqGvVD7S11fpbJW0iBzhwPRVe1dAFmutEfCkEJapX2KjqnQvzsKN0ut2feOz2hfngmVyBHlYuKD/U9i7s124NiOrPWKr527lpev0oTGdrP0YaG0UFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887935; c=relaxed/simple;
	bh=dcFZobSdZleXcBshvXUH04ftS3Nj3J0i576wfhBAZDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I39qCZgadTOKb1d3SWOLSnvyWAYwo9GxL+JaGBcWYnRutiiE2jNM97BRrHpB9rsiRij5IHHeaaeXQor7cBYoUhAss3OuBH710V6twi5INnlDsVZQTMqdlpp5aCLEPGnhz8VnbaRUMiFu5kdP9IVJ+S8/EO6SidNhwmqhtgm0AGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=htAm/taj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QWFrPNx4; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D82907A00AB;
	Mon, 23 Feb 2026 18:05:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 23 Feb 2026 18:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1771887931; x=
	1771974331; bh=MVfrPg4TuomKfqwDbrLRxevlaiKdNInrhaGUA5lXoD4=; b=h
	tAm/tajszKPs5bnMX8pAdY5+bFmgS6Up5gYCTfc85OExR305pGGnXWNNsqjWBYzS
	v1/7XYy0gPsoCyn8NFx3A0q/h8+KaXvgpLoSyACqCTFs7dEy0GlDzZEpTVK2abnB
	Wp/gcU/f/ZhuVpKHk3aLw+5sJEQhul6c6BNRpJr9MURK0LBDmNm1KqiYVS7MRkjT
	87o8KR2ZgBr/Mh4LUUQ2AC6hjHeewY+/dROyf9Cu9UUh3Xy6O4fDFaNUApaGF0ip
	izHKgVgfqr+zyKLfQFOHHH4fEfkDlbpdRPF+QCTUiz2SToQTNlEQhHuIh1U7oNaZ
	GTNbct4v563iaOUoVDbYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1771887931; x=1771974331; bh=M
	VfrPg4TuomKfqwDbrLRxevlaiKdNInrhaGUA5lXoD4=; b=QWFrPNx4L4ZVsY0CY
	OAHBF4pgCwTesYiJp9Z4Jt88t6yY3us7qJZ7Fg3Rnh+8ijlmmuP7ZI6KItMj5jZ0
	I76KG4Kr7PC3ZRq/Mh6ujdjQJ/hU6zRMftk0+JiyvrQZt/GjM3Womaw0ltT/yCJN
	GIBp3a5Sv7QZcVJ0lHBBr6P2nLkh9/FnYT+nupHHkoiTixigloCtXuuPzIdQDRLT
	NmZyrTrKiGn7/rIiApAhouyJ3k0SgbKF++JF/oYhE3ptKjGuBj9sexF0be74Utga
	tJy500WJGkULQ21lRGMz1GUxc2wPf4u33zUQfPOt/lI89Xv7oRe+8w0PVMf9EJI9
	9LaZA==
X-ME-Sender: <xms:O92cabJ9C_OZVLwMOJOsi4begYOPi5F00sceUqop0DdevoNUNkJxHQ>
    <xme:O92caam-gFkAyHTipaIrW-_rt5270BvvR_JG5mDIGA7y2IwjZWPyz_fd-AKbOkjn0
    gzCVseMYc1PLgPomQ1aJ2gXpIqx2XlQQuEfWzwKk1JDuBPAKAlimn4>
X-ME-Received: <xmr:O92caXMX1KCu_ZwHMZFcOeu_wNUGNz9mz4q57YaGt9kD8tBBZ1uWVuJH7WpR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekhedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:O92caY00kHrx5B12sr5Faw1NwbXtHTZV0y6kDNrx1m0tTgdN84wAQA>
    <xmx:O92caemgqxmiIpAZVB1ZES87qWAhLK7dwXxuqMHWBEgi7_YAgZKyHQ>
    <xmx:O92caXUDEguQYbgEIKLR-CFK90J4EtaruJg9h07xI36HMWhbrIFpmQ>
    <xmx:O92cactTuMDkK5N3hKfRAlkoPy50CzAxJSa0tyj6z1ucjAKMhGbbug>
    <xmx:O92caUdaa1VvJnskwZFBODWc7RbEgk_45mHobbTFtJhEm-pzQ_0lB16D>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 18:05:31 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec 4/4] esp: fix skb leak with espintcp and async crypto
Date: Tue, 24 Feb 2026 00:05:14 +0100
Message-ID: <05971caeac5d8518c95f5c506121317fbc13e4d1.1771876412.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1771876412.git.sd@queasysnail.net>
References: <cover.1771876412.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260255-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:mid,queasysnail.net:dkim,queasysnail.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: B843117ED2B
X-Rspamd-Action: no action

When the TX queue for espintcp is full, esp_output_tail_tcp will
return an error and not free the skb, because with synchronous crypto,
the common xfrm output code will drop the packet for us.

With async crypto (esp_output_done), we need to drop the skb when
esp_output_tail_tcp returns an error.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/ipv4/esp4.c | 9 ++++++---
 net/ipv6/esp6.c | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 2c922afadb8f..6dfc0bcdef65 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -235,10 +235,13 @@ static void esp_output_done(void *data, int err)
 		xfrm_dev_resume(skb);
 	} else {
 		if (!err &&
-		    x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
-			esp_output_tail_tcp(x, skb);
-		else
+		    x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP) {
+			err = esp_output_tail_tcp(x, skb);
+			if (err != -EINPROGRESS)
+				kfree_skb(skb);
+		} else {
 			xfrm_output_resume(skb_to_full_sk(skb), skb, err);
+		}
 	}
 }
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index e75da98f5283..9f75313734f8 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -271,10 +271,13 @@ static void esp_output_done(void *data, int err)
 		xfrm_dev_resume(skb);
 	} else {
 		if (!err &&
-		    x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
-			esp_output_tail_tcp(x, skb);
-		else
+		    x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP) {
+			err = esp_output_tail_tcp(x, skb);
+			if (err != -EINPROGRESS)
+				kfree_skb(skb);
+		} else {
 			xfrm_output_resume(skb_to_full_sk(skb), skb, err);
+		}
 	}
 }
 
-- 
2.51.2


