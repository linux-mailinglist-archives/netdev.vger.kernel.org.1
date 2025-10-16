Return-Path: <netdev+bounces-229993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5046ABE2D7E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7141A6345F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB642E0934;
	Thu, 16 Oct 2025 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="AEPwFv19";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rVAY7OVs"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBED305E1B
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611178; cv=none; b=KPbg4X7JVfKQ2t81zEibNscA5bKlNR1yGgcVIsatl8o8hICY2gOxHFwgiqhImJWfpDl8vhJOwkkSwy4DP+I1YRmmaHbZFNPxJb+A4Qh5L9h7WtE0lHDsS4lxPvJCVRJjMyqpE7/I3j+LPLD3JLMLsPENpwHSphhuY3cD11T8AnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611178; c=relaxed/simple;
	bh=fh/h7MAuWs7TKeM7dkBAFFRfeGvg9G9OCwCvRAajwh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDsf1+wFWV96FaA/9p6gZ2FxbO9iXuANN6ZccXdknoDFKkeu2QtXy6GOzbdBrNHoy3VC48GIkDb2+/8zfnHW/9PUmHzCH20EhYn/6p/ko7gBab6AulbeeLuqK3PgTMWGxpPhZUXakVKfY44tvl2Yx+vl1G2DmTjPtrnNRARPy+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=AEPwFv19; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rVAY7OVs; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 505351D000B6;
	Thu, 16 Oct 2025 06:39:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 16 Oct 2025 06:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760611176; x=
	1760697576; bh=MpIoBpCq06CAi+QoJ905xIELPJe03AF6CLwkA6C9mVg=; b=A
	EPwFv19VAWgZcv2i4N/2Z4yxMale5aUhe18YqrXHDkeNCcRyrH7yLkIkiAV4MEr1
	yj3PXEXraOuykmkALKaJ7VuqnXXA1mvFv3Pb9Z8IqkmfyXS2wFXQvNkQCHdMZHp/
	fXS1AmB4e5t+bPKiTIzVRtth4S+Q3MkkYPS55Yg+43m/GHxgICjh4+CXbYCFIX8D
	qN+0f/8S8NkUJrbiaVqYFRBim4E3pJN2yFErVyYEJmYJookvJclJDVjiD+UJtGq6
	ZcbWEN/Y2EB6orgQF7W9T0Fx6SMOad1iJAt2OmG+XOFQGkn6k3S3TAQ590nMhGMy
	QpL2Pe9XClFpHhaYIMCSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760611176; x=1760697576; bh=M
	pIoBpCq06CAi+QoJ905xIELPJe03AF6CLwkA6C9mVg=; b=rVAY7OVsV2pYRz+Cr
	i2Vei/eYgR2u0nsBYMKIIaVsY8HXIxF3wnp4/kXoD9KUHD2DoUMkWSPKfJtt0JFb
	wEvP5iJGiZNWMJN1WrjxIku/gBGGOItRoJAttvG1jkz45VgLbpDDLCoooH09PB0j
	R3FNluI4aw3q8TjyrIYMSLfTx3sb+17BJM3LXoa5SAnURVnTDgSdhe7agLy1X6qq
	WGeuZzAS8brXvymbpFILGJwiNj7PhrnfzB0JI4BWbNV0lreyGQ/bCSQ+YVrgwVkK
	N5SBA/tbeyK8uAeg4SxwEdWKcTdCLO89fD6CgDG8vClTNttMeDbd9BJGXfuI2/GP
	+0oWA==
X-ME-Sender: <xms:Z8vwaGpozycZlhhsNH-mlB6-nZJfQkCXPe27qdSv93_kr7sinEpO2A>
    <xme:Z8vwaLiXA5TyZqDO-TzwjqS-wDu7hhOJYPfRCjyCkV8Fkc4X9pLDkA0mKy-8xDoB5
    7oBjG4tDpNpuybXHnc558_CXBvyAJxDmBN8Nw6qF66XWPw2fRImOnU>
X-ME-Received: <xmr:Z8vwaDh8iVAJoZHEyF_cSME-LnF0T0j_Ddfw-l4tYkU8B88xYWv2LJRWS30N>
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
    htthhopegrnhhtohhnhidrrghnthhonhihsehsvggtuhhnvghtrdgtohhmpdhrtghpthht
    ohepthhosghirghssehsthhrohhnghhsfigrnhdrohhrgh
X-ME-Proxy: <xmx:Z8vwaBheZWlHMGuV0LiUxrxJqvccp0w7nDQ0g4Sm18yevBgOmE2rOQ>
    <xmx:Z8vwaDJd6LXARIzxq0KD7RXnf8w34WGhlYEfVp3YoGh3GHNqOoLD3w>
    <xmx:Z8vwaAH0voEc1fiINuwlbSbtEaJjoBl4vJLEdFhMw459_X42A3gaeg>
    <xmx:Z8vwaHQSrPIXUaWs6SvoA8tGdVVK1SGQj0TzL3J6RP1WbbNVwqIUBg>
    <xmx:aMvwaA98hreoKyBOC2RlgRyDPsazRj4qDGL1PO0P9HyvKDB8H661mDda>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 06:39:35 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antony Antony <antony.antony@secunet.com>,
	Tobias Brunner <tobias@strongswan.org>
Subject: [PATCH ipsec 5/6] xfrm: set err and extack on failure to create pcpu SA
Date: Thu, 16 Oct 2025 12:39:16 +0200
Message-ID: <f4a269dc8a130b18dc6fc8897f76d302465ccb79.1760610268.git.sd@queasysnail.net>
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

xfrm_state_construct can fail without setting an error if the
requested pcpu_num value is too big. Set err and add an extack message
to avoid confusing userspace.

Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_user.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 010c9e6638c0..9d98cc9daa37 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -947,8 +947,11 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 
 	if (attrs[XFRMA_SA_PCPU]) {
 		x->pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
-		if (x->pcpu_num >= num_possible_cpus())
+		if (x->pcpu_num >= num_possible_cpus()) {
+			err = -ERANGE;
+			NL_SET_ERR_MSG(extack, "pCPU number too big");
 			goto error;
+		}
 	}
 
 	err = __xfrm_init_state(x, extack);
-- 
2.51.0


