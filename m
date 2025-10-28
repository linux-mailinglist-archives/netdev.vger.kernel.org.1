Return-Path: <netdev+bounces-233487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7A2C14461
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889581887DD6
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BED62E7F2C;
	Tue, 28 Oct 2025 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="hL6g78HH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0DfJs6zU"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105AC304BA2
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649424; cv=none; b=HJljoS4851jNvrhLIdnw2cY6hpg7jDjAuMj8+umNJhGBavbdksed8eTLfSQMON/9A/ne9+5Ustb1xbVYpPfleoXRDS0120d3qgV7uChhYLm6x3iEkRhp0ZpG0eeiCxcwPK+/iegBnIvZoBKww8i8I2WU+lNhlVB/fuKGz5NMNus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649424; c=relaxed/simple;
	bh=6+SVeCHcDo+dTjAZi2LgbANQoIWvtBXY8JWAqFJ9fL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgkVC0LWFDa6ZZ53dzG2xF8+8m+WpHVMJg2Ky4jWQ3zTRUKxFXjBpa3V6PoJWcBcN2Mv196dCnoV4OYXaQKa89jpepr9vBxjmW0Hdnkc53RyCT+aHrUdipwImWB8kUvmtozWtd/mpRRn5am4JOoPlmKJ2/2Eujvr2jzm4SvguJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=hL6g78HH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0DfJs6zU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 07689EC0377;
	Tue, 28 Oct 2025 07:03:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 28 Oct 2025 07:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761649420; x=
	1761735820; bh=Ei+of7EvLgIKE771IeYWhC5OPvi8h8EKNo0c0ZuGw4I=; b=h
	L6g78HHFIgheejVCDcwUWg5IgoMHafD0LIrlaPJ3W2h5KgImucihqwyFICOFuxPD
	y0O9OgC3XkyrhAs3pWu0+bNGeqA6mOF22ywlSaicXDQPn8YP5cFZElB2VobTXZMY
	J9fyPjMwCw4Uvu9gVzIBB9Eli9WOteMEQqRBC2pjipGMtENmzV6PqUvpvgszJCxq
	A9f8ZemGVabbUo7ADZm4Px0sypN0VphxGK8AYrlnrF35ISvX2aAQoC+e0aSeyrne
	KOw3BeTC2uuX7wGC0eWRIIlwrLBYJx8bqfc6kTIBhavoFCktmrAqUNDvbtzs3vfx
	crcjRqDxz1U8aLe+lQE6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761649420; x=1761735820; bh=Ei+of7EvLgIKE771IeYWhC5OPvi8h8EKNo0
	c0ZuGw4I=; b=0DfJs6zUlUMQOySxMsDBcdSwMDpeHMvj4BRzSYVCf/cG55qbfWz
	gFUsoPjVwE23iqR2WBVlnOI9wCFBd4KJO/bv6+2Ect7ltJqoPVYGg3UwQtm4B/v3
	tz9DbndonE4nSe2elnavYBwWQNG7j++GL1ci51tTw8QYEhqkoHA64INKybt+YHmE
	n9p7Mc4xmIRlnNZmVExdjJYHLpPhkSvWsGtx51JZbJU/TdLKIqv14TqLFNFMwEMu
	VpvSe/nsaBHlIizAjzL506dPzmPc1+QfyJRbjtyS5oWQPg1+/cnn8tCfmVe/n2dV
	36J5ejKaRyOxzNJmTlFqrlMVRGzU8mDpA2Q==
X-ME-Sender: <xms:C6MAaekjIyuI0hKsmTJBj_xmxQSwL-z884RsDdlrjaN95gP4HfbrcQ>
    <xme:C6MAaRtz6g99j4YsjKOt2P-q0JdP7lS0QzNJaTnQ7JYDL97UMdGu0Wzg4sw8dFF95
    MiXkeWMhExs3LdVR-3lgZfCDgxtExWMufq_kJBW4HPOldiEyLGR6g>
X-ME-Received: <xmr:C6MAaZpf7MAXblYXcEnl1ioFFdEla4VphZjl-4myIKS8YYT0ijowX09TkqZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehjihgrnhgsohhlsehnvhhiughirgdrtghomhdprhgtphhtthhopehnvghtuggvvhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlh
    hofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtph
    htthhopegtrhgrthhiuhesnhhvihguihgrrdgtohhmpdhrtghpthhtohephhgvrhgsvghr
    thesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopegvughumhgrii
    gvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdr
    tghomh
X-ME-Proxy: <xmx:C6MAaXd7su0C4GKhEMOrcmZVlBoFTpNWGR33HiFDCf3ZDZ0pD2l9SA>
    <xmx:C6MAaRm18Ftv7shi1f4JyJl1Uvjy6cTYNk7ED1OQtXRh57klnNoLMQ>
    <xmx:C6MAaebO6zstTNlvuehme-K5Mex0T_MM10Tiei4WKp80LweHMVlHAg>
    <xmx:C6MAaW5S3NXnfQL769df00K6HDao5l6n0jdzZYk4VccTanxwE_jUNw>
    <xmx:C6MAaVKYR-8JC4hqW-83JIAigp1SxQUMEEITwr08SP15Yv1X2s9KWKdC>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 07:03:38 -0400 (EDT)
Date: Tue, 28 Oct 2025 12:03:36 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	steffen.klassert@secunet.com, Cosmin Ratiu <cratiu@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH ipsec v3 2/2] xfrm: Determine inner GSO type from packet
 inner protocol
Message-ID: <aQCjCEDvL4VJIsoV@krikkit>
References: <20251028023013.9836-1-jianbol@nvidia.com>
 <20251028023013.9836-3-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028023013.9836-3-jianbol@nvidia.com>

2025-10-28, 04:22:48 +0200, Jianbo Liu wrote:
> The GSO segmentation functions for ESP tunnel mode
> (xfrm4_tunnel_gso_segment and xfrm6_tunnel_gso_segment) were
> determining the inner packet's L2 protocol type by checking the static
> x->inner_mode.family field from the xfrm state.
> 
> This is unreliable. In tunnel mode, the state's actual inner family
> could be defined by x->inner_mode.family or by
> x->inner_mode_iaf.family. Checking only the former can lead to a
> mismatch with the actual packet being processed, causing GSO to create
> segments with the wrong L2 header type.
> 
> This patch fixes the bug by deriving the inner mode directly from the
> packet's inner protocol stored in XFRM_MODE_SKB_CB(skb)->protocol.
> 
> Instead of replicating the code, this patch modifies the
> xfrm_ip2inner_mode helper function. It now correctly returns
> &x->inner_mode if the selector family (x->sel.family) is already
> specified, thereby handling both specific and AF_UNSPEC cases
> appropriately.

(nit: I think this paragraph goes a bit too much into describing the
changes between versions)

> With this change, ESP GSO can use xfrm_ip2inner_mode to get the
> correct inner mode. It doesn't affect existing callers, as the updated
> logic now mirrors the checks they were already performing externally.

Sorry, maybe I wasn't clear, but I meant that the callers should also
be updated to not do the AF_UNSPEC check anymore (note: this will
cause merge conflicts with your "NULL inner_mode" cleanup patch [1]).

And I think it would be nicer to split the refactoring into a separate
patch. So this series would be:

patch 1: fix xfrm_dev_offload_ok and xfrm_get_inner_ipproto (same as now)
patch 2: modify xfrm_ip2inner_mode and remove the AF_UNSPEC check and
         setting inner_mode = &x->inner_mode from all callers
         [no behavior change, just a refactoring to prepare for patch 3]
patch 3: use xfrm_ip2inner_mode for GSO (same as your v2 patch 2/2)

Does that seem ok to you?


And to avoid the merge conflict with [1], maybe it also makes more
sense to integrate that clean up in patch 2 from the list above, so
for ip_vti we'd have:

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 95b6bb78fcd2..89784976c65e 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -118,16 +118,7 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
 
 	x = xfrm_input_state(skb);
 
-	inner_mode = &x->inner_mode;
-
-	if (x->sel.family == AF_UNSPEC) {
-		inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
-		if (inner_mode == NULL) {
-			XFRM_INC_STATS(dev_net(skb->dev),
-				       LINUX_MIB_XFRMINSTATEMODEERROR);
-			return -EINVAL;
-		}
-	}
+	inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
 
 	family = inner_mode->family;
 


Does that sound reasonable?

[1] https://lore.kernel.org/netdev/20251027023818.46446-1-jianbol@nvidia.com/

-- 
Sabrina

