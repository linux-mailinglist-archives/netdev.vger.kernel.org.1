Return-Path: <netdev+bounces-193069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A53CAC2612
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB83188255C
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69005296162;
	Fri, 23 May 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="S60pdhkL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rukBuz51"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14FA296D1A
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013098; cv=none; b=E2aBYQaFhi7o3X2ndZ8dWRBlVJ6s7Nmt9tCqfEvzFvlu1iC+RooBEbHytlHo7G1xUM5bMZj7xATXx/eA3lLSh3xOvWDFH03vGM3MMYDdVRck/aLhcauCWr6zMjVxz2R52i1vfcAt1DcuIum4xN2v1KAjYFiOLaCBhrCl+NV2ADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013098; c=relaxed/simple;
	bh=RCVgcJD+cHzC06OvEI+ebaaJ6Q3cqypWFsSgpurOru4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqFwX0nk92ObWbVowuyBzsqWCy9cZBbU55B6x0Fp+C69F1hFMtP2VevCW2jTznxLHrPS6uFVCWvSdBrN31ausBGTd/F2SitMuP+YNyHjN2TKhHyD++7hjjRU8Z0dEbD4PVAFiZJlSm45bNQqcjcyjmdAOEJsK6EEpulkDSTSv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=S60pdhkL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rukBuz51; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3E25254013B;
	Fri, 23 May 2025 11:11:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 23 May 2025 11:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1748013094; x=
	1748099494; bh=WnHrsvaVvHHRRsBYI5Z31hJszPAO7NT/og9X88yKxJ8=; b=S
	60pdhkL1h0hH6tPZ6vwbL2miFRZuSEdCzE4p5n84hbgKDKnc3kWl6DX61LwNYdpn
	M6V2OpRbk9WRLsYA7M3HEt3tYA4XtbTvy+pjkcDlrCoBt7E3szt9tCzJ3ojb3CJ5
	TgUod6lw6VzKSBNarpaQfrx11/h8vJV1EXUMdzOF0eluCPflzKWvf/WPXyq8Dr8o
	EYIj08JXelFFwmRuMJnE8calGdR2pVWgiFNjx5duinN/Nt6YUg3FlYFca8gw99wO
	Y7IPVUkjBFwnJmTGuQbKe2nC9eGVVuHdn93+kfcXsQrrZdLSWwRsXWO2/eF0wPno
	Ku29nnwz6Cw2R8Va9/BWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1748013094; x=1748099494; bh=W
	nHrsvaVvHHRRsBYI5Z31hJszPAO7NT/og9X88yKxJ8=; b=rukBuz51tZRWxRkjN
	NhMehae3FwOTBcP8fmyeTy4J5kQyUkHikd5HMzI02lqjQbWF5aHu8cydXZBCSfoP
	h4T3G0msD9ne+AX33tqt2Jm0aAC5/io7PiBa4NpYgBtTuo+EeWJh+AyM9C6AUVh/
	ikyCp2lM3W+gfljbWVpGHs9FZMDqHNMFizWnVI/oYKXUc1x5xnHZuCONzI4Q3sFY
	3SXMRWEtfrbDngXA33y6n2OMEoPp817Z97gKrrLod790DPeAwArjisXDp53jcn5g
	U1EY2dky8m+INuTcvYHp7v8+Dn74VAcbspxBQjY3wh7lfh4TpIEPh73A5rB75xbo
	ioEnA==
X-ME-Sender: <xms:JpAwaH1Rkik3hZql5tCaYHTzYFKduH6AFQhYgKRWSFN0ZclE6fSYaA>
    <xme:JpAwaGEctfU_a_vBw7Dm38kc6yHzspheGe9PtrFJUX6Rd2SnkmJIsFsKSzRMEoWLD
    ME1FzGjfvy10hkkXmQ>
X-ME-Received: <xmr:JpAwaH6TaJT5v3_1f7betSEF6H9otPiR1GFbezmNb8K3_aPuWoyiUHt7ZJYlJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeludejucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoe
    hsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepieeiueei
    teehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfehudfghefgnecuvehluhhsth
    gvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihs
    nhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthhopehsthgvfhhfvghnrd
    hklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtthhopegrnhhtohhnhidr
    rghnthhonhihsehsvggtuhhnvghtrdgtohhmpdhrtghpthhtohepthhosghirghssehsth
    hrohhnghhsfigrnhdrohhrghdprhgtphhtthhopehffiesshhtrhhlvghnrdguvg
X-ME-Proxy: <xmx:JpAwaM1sFaaozZPeu4PnvR12v7vBDwt3i5urnSc3UB6aH5MXpBfCgw>
    <xmx:JpAwaKFFH0YM4lOWN-cqKUrl0vOyVl_SgAHh2sr6MfWW_gBTbbswFg>
    <xmx:JpAwaN_nMUM1xh484FUC66ZsUf6aqsvPKz7W3iws7vpL4JMfiktKNQ>
    <xmx:JpAwaHmlwwiM-GRHrOxjQiWtRapWea0Y_jyaxnDaLdTFP3rNh-MxpQ>
    <xmx:JpAwaPI_6lFhaBpRB13E7gjh51wNlug_BuPUlmcgZXCDbOC6E_lkJYU0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 11:11:33 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Antony Antony <antony.antony@secunet.com>,
	Tobias Brunner <tobias@strongswan.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec 2/2] xfrm: state: use a consistent pcpu_id in xfrm_state_find
Date: Fri, 23 May 2025 17:11:18 +0200
Message-ID: <6d0dd032450372755c629a68e6999c3b317c0188.1748001837.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748001837.git.sd@queasysnail.net>
References: <cover.1748001837.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we get preempted during xfrm_state_find, we could run
xfrm_state_look_at using a different pcpu_id than the one
xfrm_state_find saw. This could lead to ignoring states that should
have matched, and triggering acquires on a CPU that already has a pcpu
state.

    xfrm_state_find starts on CPU1
    pcpu_id = 1
    lookup starts
    <preemption, we're now on CPU2>
    xfrm_state_look_at pcpu_id = 2
       finds a state
found:
    best->pcpu_num != pcpu_id (2 != 1)
    if (!x && !error && !acquire_in_progress) {
        ...
        xfrm_state_alloc
        xfrm_init_tempstate
        ...

This can be avoided by passing the original pcpu_id down to all
xfrm_state_look_at() calls.

Also switch to raw_smp_processor_id, disabling preempting just to
re-enable it immediately doesn't really make sense.

Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_state.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ff6813ecc6df..3dc78ef2bf7d 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1307,14 +1307,8 @@ static void xfrm_hash_grow_check(struct net *net, int have_hash_collision)
 static void xfrm_state_look_at(struct xfrm_policy *pol, struct xfrm_state *x,
 			       const struct flowi *fl, unsigned short family,
 			       struct xfrm_state **best, int *acq_in_progress,
-			       int *error)
+			       int *error, unsigned int pcpu_id)
 {
-	/* We need the cpu id just as a lookup key,
-	 * we don't require it to be stable.
-	 */
-	unsigned int pcpu_id = get_cpu();
-	put_cpu();
-
 	/* Resolution logic:
 	 * 1. There is a valid state with matching selector. Done.
 	 * 2. Valid state with inappropriate selector. Skip.
@@ -1381,8 +1375,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 	/* We need the cpu id just as a lookup key,
 	 * we don't require it to be stable.
 	 */
-	pcpu_id = get_cpu();
-	put_cpu();
+	pcpu_id = raw_smp_processor_id();
 
 	to_put = NULL;
 
@@ -1402,7 +1395,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, encap_family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 
 	if (best)
@@ -1419,7 +1412,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 
 cached:
@@ -1460,7 +1453,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 	if (best || acquire_in_progress)
 		goto found;
@@ -1495,7 +1488,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    tmpl->id.proto == x->id.proto &&
 		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
 			xfrm_state_look_at(pol, x, fl, family,
-					   &best, &acquire_in_progress, &error);
+					   &best, &acquire_in_progress, &error, pcpu_id);
 	}
 
 found:
-- 
2.49.0


