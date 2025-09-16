Return-Path: <netdev+bounces-223461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B797B593FC
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A51B22E1A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06984305948;
	Tue, 16 Sep 2025 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="C887fnOY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZWsKaEmm"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650C304BD5
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019418; cv=none; b=RkdRgu+aaC1xIbsdXkG4OFfFcK1UX1hxIKDEUMnaje7RdBtq7qLEpLNWF2yUb9teTjvWiKwy2VTbHO3hRtGUV1ub5Iyxu2hm3ddD1HNQgbZMalUPC9dAZVcPtmpUp6M07yJ9q/FyC93oK+CtuGPjZPUrj1kXM41sdon/FjT6Y+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019418; c=relaxed/simple;
	bh=wJShCqi/P8HQ7BHXnqljuH4ZL5k4p2OS0I+xdBpJEDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZmrUIRFO9KvOjCmEDRTGylXpOGQjZIL3qDTCgDS7IRbHDeHRLi3+oQCLDRgnSjpeGx+dJMgPrttB46tdusVkMN9MZsEUp4aLv8fiSXjNGbOTypSuIeV4oT1OyowdbKiZBk1OIEe/kL4CP0tXy7d2YbAL15H9JXt10BSKjjQ94k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=C887fnOY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZWsKaEmm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F5DEEC01E8;
	Tue, 16 Sep 2025 06:43:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 16 Sep 2025 06:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1758019414; x=1758105814; bh=kz4VEmqMdljskYH4BeO8RPA7nSesKw3O
	stf51zTCKxw=; b=C887fnOYP69dbvCKEwMBgTGH2y/FosZPNSY5YWOwMM6yr105
	Tpl0UkDoCpnkwcDW/TU4ZCeSUKqYUbtOwWR+HR09Y8jd9QilXMS3eeNHA/PHNBTk
	6CadWf6ruRYuoSstKbfYcmK7IwTSKsidXc2i2/e6EQGrbGTI6GdlbsRmUtk1YHk4
	SSB+Eqh53KomMetz3ni7N9BkR24gXM6cRgxUr1OsiC5S/FTDXQmI5gOLm36yO+Ec
	d9zt+zlFoRah6n7RKzq3mRyksqg7pDt0wNnME9DoXrLhxoRqUAZvU/9/5cqisoOx
	O/JgopMwV+zVPtXHVumNbPpByDkcgkEM/E7i3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758019414; x=
	1758105814; bh=kz4VEmqMdljskYH4BeO8RPA7nSesKw3Ostf51zTCKxw=; b=Z
	WsKaEmmlR9x5Z+JYl3nrqxoZ4ldig8wDCwXK4wInlreUyWzuVXnPzALj0bMq+uOh
	CNBStEfVaAjRJVJ7fRD65/TN4k8IugLatb10P1PSYHudq13vkWO8Y96/wbilaiq7
	Uqni2bSsQfqWRWDrOAtFmKmwTdi4l5jwVbhQWTds7rdfYIwPVfohNobu/felybmg
	CrlSUxPzNJBakkknEGsGYTOeyialnrSMp1xDrrnnELZaXfzA3lypor9i/svGJ1uW
	oZ5xrOOd2kjByKDG3t95bG1SE6c7AXHo4AaFsvqYQmsS03IZRTxFh4oXFnrj5+IR
	rZ1dRDA+64Gn13ayYz8NQ==
X-ME-Sender: <xms:Vj_JaAm5d7YCMCuALNEtzuL7LfQxew0cDJfmvDWfeBAVp9dhEXSWDg>
    <xme:Vj_JaJQUxVBJWHdWVyeYMNmcr4OnIyjlEQSr7ZO5kr-vbsRby5s4FPF-bj1A6LNgd
    GGnp__j0fMR4t0J650>
X-ME-Received: <xmr:Vj_JaOMIbROhSMzw4Cqiypgb8wV15qJpCmMejRA0Pr-kGvmvs9h9jijFXRY4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtdefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgfdvgeeitefffedvgfdutdelgeeihfegueehteevveegveejudelfeff
    ieehledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmmhhivghtuhhsleejseihrghhohhordgtoh
    hmpdhrtghpthhtoheprghnthhonhhiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehophgvnh
    hvphhnqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvght
X-ME-Proxy: <xmx:Vj_JaCXOl84twnlRecETPDSs2MZWUTppymd39ga575mFB-1Cfy28gA>
    <xmx:Vj_JaFfqIJV0Bpcd2DHmr9mq3H_VYtueNWc4I4tn_fBTL6gImfLuzA>
    <xmx:Vj_JaOuD1C6OFhQD8lbSFn-5hiQqYAXYv2uIxDQXQLjvq97szd6jsA>
    <xmx:Vj_JaE93RsuIsnOROpjcvCvEJyxCy1jCxXO83qznpPOLZ3W9iWMEvA>
    <xmx:Vj_JaODIIP1Mu_19Ca_DYRE49R20ZSzGLofKkovvZRW2G_2-RUpWDsB0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 06:43:33 -0400 (EDT)
Date: Tue, 16 Sep 2025 12:43:31 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Marek Mietus <mmietus97@yahoo.com>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
	openvpn-devel@lists.sourceforge.net
Subject: Re: [PATCH net-next 0/3] net: tunnel: introduce noref xmit flows for
 tunnels
Message-ID: <aMk_U3zeHviJC1GI@krikkit>
References: <20250909054333.12572-1-mmietus97.ref@yahoo.com>
 <20250909054333.12572-1-mmietus97@yahoo.com>
 <b8b604f7-c5c3-4257-93da-8f6881e96fe4@openvpn.net>
 <8e6b83b3-c986-4d6e-b61a-363e13bf1ddc@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e6b83b3-c986-4d6e-b61a-363e13bf1ddc@yahoo.com>

2025-09-09, 16:43:01 +0200, Marek Mietus wrote:
> W dniu 9/9/25 o 13:17, Antonio Quartulli pisze:
> > On 09/09/2025 07:43, Marek Mietus wrote:
> >> Currently, all xmit flows use dst_cache in a way that references
> >> its dst_entry for each xmitted packet. These atomic operations
> >> are redundant in some flows.
> > 
> > Can you elaborate on the current limits/drawbacks and explain what we gain with this new approach?
> > 
> > It may be obvious for some, but it's not for me.
> > 
> 
> The only difference with the new approach is that we avoid taking an unnecessary
> reference on dst_entry. This is possible since the entire flow is protected by RCU.
> This change reduces an atomic write operation on every xmit, resulting in a performance
> improvement.

It would be nice to incorporate this information into the cover
letter, and to provide numbers showing the performance
improvement. That way, it's available to other reviewers and gets
recorded in the git log. Are you doing crypto with some accelerator?
Otherwise I'd imagine skipping a few atomic operations is not really
noticeable.

> There are other flows in the kernel where a similar approach is used (e.g. __ip_queue_xmit
> uses skb_dst_set_noref).
> 
> > Also it sounded as if more tunnels were affected, but in the end only ovpn is being changed.
> > Does it mean all other tunnels don't need this?
> > 
> 
> More tunneling code can be updated to utilize these new helpers. I only worked
> on OpenVPN, as I am more familiar with it. It was very easy to implement the
> changes in OpenVPN because it doesn't use the udp_tunnel_dst_lookup helper
> that adds some complexity.
> 
> I hope to incorporate these changes in more tunnels in the future.

It would also be good to add this to the cover letter. Something like
"For now, only ovpn is updated <for $reason>, but other tunnels could
also take advantage of this."

-- 
Sabrina

