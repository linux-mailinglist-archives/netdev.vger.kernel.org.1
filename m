Return-Path: <netdev+bounces-229989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B73DBE2D77
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC0E94E99B6
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA0B2DF15B;
	Thu, 16 Oct 2025 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="RhorwtR6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kZ8TYSvA"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D002D12F5
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611171; cv=none; b=COMop2fONdKJipQf6WYVn0UrNSlmLjbUysZqxPi4wBizSdKyBpwx1rGAF6wlF2nbd/vP30WkBQFsqDKnWo30MwD9UPOiZH3X5yRcg1JqVIeoMkNBhogbvTD85caTNO90jYmh6GWdaXTsUc3ZrJsYME2U0kxM7tsb0Ez+Fjilo3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611171; c=relaxed/simple;
	bh=qVxWqSkEXdEQ2Aq/GqkVXsuP/rKkLat8tDgjDjI4/i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1MxFR9Iq1HI3JTP68uPUM6IXn/uLGGsWnW3Tc1ZAr+8SYdCCtw6Lzadp0HohbBGtjOkoDsfPT6W6SHTDFHyWJNEDR/geD9TKDA3SpYT8heyUMKU6WjoFOHSQ4MsJnKr1Lhcf9ev3b1zMHv9uABoDEcyL5DfWb+gsbnmgkGP9gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=RhorwtR6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kZ8TYSvA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F1F197A0128;
	Thu, 16 Oct 2025 06:39:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 16 Oct 2025 06:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760611165; x=
	1760697565; bh=qSQCqButz9pk5v/4otpcklq1ek2F7NFbvgm6bSx0D4U=; b=R
	horwtR68BPU8Kv64UJ3tllXy0rTLvE/3TpWUwRkFfbWAkPb46NbD1tTpioRDRW20
	aoFwSTYQSDom9EA7+hNQNQOAfwfMQjUERs/ApLVpGS2UWpX5epyR3mMl0ckAuMAd
	z9yBeRLv8QGdGjmeZQxivtsTdo/j6BoyNGNDAtNHwSWqq8KHkxFll9ShUKTvtTP7
	zy3utv8upDius1UDvb8GWS+g59TnowEajXXZx059e5oPsZevRAQv4lok969HC2NP
	4nTGwzVRZvV6pFMmy7SV+jOnvmEhrILeKYkEc6+majcR14sVYV1+Jecx13MBIBSM
	LmLwKO4oAcyLUEgIlyXhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760611165; x=1760697565; bh=q
	SQCqButz9pk5v/4otpcklq1ek2F7NFbvgm6bSx0D4U=; b=kZ8TYSvAYkIEial56
	mTSvR0fkKmqs9X8hQHu60PtV1p3PKrK/uXb4z/kQU59cu6d6G9roNKQzcvo7tqDp
	9RZvoGLfio7jzyp4keiHb15S3kXq5IzVjdyr3vP8ksYjBIVk5+bS85pHgJqf/BNP
	i0QG7zJ4scQDM3/+Jc4C5qx2kBSCH7lUnPZSPLVwjRbNEjRiaxGWU9sEmBqgppSA
	zzTnWgvwfi2cnDXdrYkuj4xKIebvjOH1zKxS5oNhj/+oOPC+Z1x4gfxi54HrxkdK
	f2meIqa6dvUctzrldMEUUc1zIFkO/ve6gNyLSZ1DsceVDPLcr+Ht/NOwUcmuJCMe
	afyIw==
X-ME-Sender: <xms:XcvwaF3qxS6fhJSPJUIPy5iJnKb3miqIYDZwtauG40uj1G8hd6p6mg>
    <xme:XcvwaDEYv9F3O_HIHgu8NOQ3ePUeLaONqHreQKofECczpkOoBl71j3KZ297J1gG42
    22GQmTij3LC4_ZU5WzHZn6VttjFQFcBqdbsgPAQ5D_-YlrAyEJ1qvI>
X-ME-Received: <xmr:XcvwaK5gLzdI3X0q3Zc_P67RJd_nyGszlnhJWAldXi7-zl4PPBzds_E2Mv2N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeitdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgv
    thdrtghomhdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtph
    htthhopegrnhhtohhnhidrrghnthhonhihsehsvggtuhhnvghtrdgtohhm
X-ME-Proxy: <xmx:XcvwaBuMkO1F6sN_G3Q1TE9elqAB-vzG5TSmmjZzAy6X23eOSA7XRw>
    <xmx:XcvwaD4fkUQt0SXEe2JEBU7r6K9H082uRmsq3INMAOY8a9y8TYWAEw>
    <xmx:XcvwaEVPmnOlGPdzQ6qCygi5G3DLQiCYqGcgMN2vb19BhJzuW3eKdQ>
    <xmx:XcvwaN_Rck3dvpxRpXv1aICctWOFk2AoQT67Y83uXHrGDlWyTSLKxw>
    <xmx:XcvwaJ3KS_MzGB-5LQFLGOpxhxUoFhGbgSaWYfOTK4d1mUk2h9TxRO3Q>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 06:39:25 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antony Antony <antony.antony@secunet.com>
Subject: [PATCH ipsec 1/6] xfrm: drop SA reference in xfrm_state_update if dir doesn't match
Date: Thu, 16 Oct 2025 12:39:12 +0200
Message-ID: <13baa5e3fea9c7555031ba399c7798b89f2bf954.1760610268.git.sd@queasysnail.net>
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

We're not updating x1, but we still need to put() it.

Fixes: a4a87fa4e96c ("xfrm: Add Direction to the SA in or out")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index d213ca3653a8..e4736d1ebb44 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2191,14 +2191,18 @@ int xfrm_state_update(struct xfrm_state *x)
 	}
 
 	if (x1->km.state == XFRM_STATE_ACQ) {
-		if (x->dir && x1->dir != x->dir)
+		if (x->dir && x1->dir != x->dir) {
+			to_put = x1;
 			goto out;
+		}
 
 		__xfrm_state_insert(x);
 		x = NULL;
 	} else {
-		if (x1->dir != x->dir)
+		if (x1->dir != x->dir) {
+			to_put = x1;
 			goto out;
+		}
 	}
 	err = 0;
 
-- 
2.51.0


