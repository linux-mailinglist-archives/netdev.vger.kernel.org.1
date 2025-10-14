Return-Path: <netdev+bounces-229075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79562BD7FD5
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325A33B67D9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1672D5C9B;
	Tue, 14 Oct 2025 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="KqrF/D7/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DsOGAPwk"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD2A25A631
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427916; cv=none; b=HP/SrunzM12C3PCXBWyixYHnvIPK7HgBJ5RjNfhjxUpuOJJHsj+LFboYRFTt9AX6aD3ivi8h2sQOf9vfWXQW+JkIEE0i+O0izyt3FTcqWxFjZTPYEh9QLkDK/wtzu2ebkbG/Z5UuST5z8t3gHQBEwx1OKxXqX1WhaEo0jP0S+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427916; c=relaxed/simple;
	bh=sthrbobElKRp/CbJMI6LaL2EhNgWPlEV/Rf1wQHB0OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVU9bNyvpZxXlO6KKY+HWN838LFgTqW5Ku9bBK1nLg2dCcAB8EGX+XxqtHJuq5oOG5mbjaSzzFsRj4Vuku6hIXQdVBnp4Q6tNnIxmvqzUzTADIHZZNCdIP2aBkn2n3LCCgrwxeE/VlQWjqMrsK2ZacJrpu6qeNAKb/h8aDpKFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=KqrF/D7/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DsOGAPwk; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE9D614001EE;
	Tue, 14 Oct 2025 03:45:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 14 Oct 2025 03:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760427911; x=
	1760514311; bh=wjUjLOVnW8u+Gu6MG0INeFzxRVl2pW4n77I2aHeKkqc=; b=K
	qrF/D7/ANJ0kt/tp5Kw1AgJOm5hMA0LsEL2Y5FNl0r8kv+A3J5AM1ckkzVIGklcC
	cXA8cY1+M0wPPO8ZlfVSTiWsQJ1WF0e3VUO6BVaOHzq+IphlR+NejHvIPEcW/V8D
	1R2EEKLESvk2Ah6X45pWUUjfc7WZ0lfz6qDKtT++d6BnDmZnAq0LGOH6BBaK9Fkq
	RnDpm80ytWTWzqQpSYQpegT+qsybVzVZXAyHpNCCaMDCsYjDkYqDbsBDemuqDDAS
	kC+7HQ9fFFL4+Si0fhAHbSoTL98QEJSPAZ1wZAm7GRjW13iR/tkD7zPY4EL64V6D
	BH4zbRZnGvA6+odiChtqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760427911; x=1760514311; bh=wjUjLOVnW8u+Gu6MG0INeFzxRVl2pW4n77I
	2aHeKkqc=; b=DsOGAPwk/jNIwa+rMV8WmJESvqDtf/YuqITaT1qUj5hgME2nv9F
	gLLYa5H5+tDemE4hDydP7LICnON3AQudZDueN34tnNZ93zqZCzS1YJ9YGFiJy8fj
	Y1ulsqTJfMkcyloXznwlE4sMkT8RTmn+JrpWWkR1ODWWPb6wl/ZchWz6ScXT3IKW
	XMq4no5WPQ1gZ2zg//13s3fMqLvUth3EHzHkBl++ISy/4NW8Hw6DpYxWeeuM49x+
	FmRANCXuE9yyCmIvKg835aws64xu6IpDhB4SEeaaj+Kuah49TkR5cVYfpcOaXtRl
	fgQ02d2s4PFAhluw/mYkZu/OaemF/LY1nUg==
X-ME-Sender: <xms:h__taOVUijW-xUClsiXGpB8szmdLAMgvjbf6FU66qMYe4yV2KiTwQw>
    <xme:h__taNLD-x-Je1XlTnK0qY_TKFupmV0AQ_ceqFq3q8o1htOgeY1SEnk_Xx0hKVxTX
    qh5IXHrmHYTbbx-039Ufs9CyPKt8CfvMimnSTfs1Rt95BSU0yhTMXQ>
X-ME-Received: <xmr:h__taGDh1vhUS4QnCxlu4TMBNwwK016sZVVZrW7ycAeIqbpN0m1WMf2qR5_z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudelleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegu
    rghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphht
    thhopeifihhllhgvmhgssehgohhoghhlvgdrtghomhdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvrhhitgdrughumhgriigv
    thesghhmrghilhdrtghomhdprhgtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtii
X-ME-Proxy: <xmx:h__taFfrBhR7vOKjY7FtSyDymC8ubE8YNO5fmYHLPpzh50Am8WujMA>
    <xmx:h__taN2NFqZ40uBSo2cESKRJQdN5drpQ8w7X8GIqnPKrHokpe-pmWw>
    <xmx:h__taEirbHp8OUFYj0icAQnV_suDjtoCpLSHefRUcFB9tUjut0bXVQ>
    <xmx:h__taOmZjuFuKRdgMhjFGWL0oAoZOsBZNcIPp6gbg3O_DHNPG14Ijw>
    <xmx:h__taKPvMmxuYqWIJmwODmA1Us--fR4Kx4PYvYHrJixTuK1gMR0dklFE>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 03:45:10 -0400 (EDT)
Date: Tue, 14 Oct 2025 09:45:08 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive
 queue
Message-ID: <aO3_hBg5expKNv6v@krikkit>
References: <20251014060454.1841122-1-edumazet@google.com>
 <aO3voj4IbAoHgDoP@krikkit>
 <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c502f3e2-7d6b-4510-a812-c5b656d081d6@redhat.com>

2025-10-14, 09:32:09 +0200, Paolo Abeni wrote:
> 
> 
> On 10/14/25 8:37 AM, Sabrina Dubroca wrote:
> > 2025-10-14, 06:04:54 +0000, Eric Dumazet wrote:
> >> Michal reported and bisected an issue after recent adoption
> >> of skb_attempt_defer_free() in UDP.
> >>
> >> We had the same issue for TCP, that Sabrina fixed in commit 9b6412e6979f
> >> ("tcp: drop secpath at the same time as we currently drop dst")
> > 
> > I'm not convinced this is the same bug. The TCP one was a "leaked"
> > reference (delayed put). This looks more like a double put/missing
> > hold to me (we get to the destroy path without having done the proper
> > delete, which would set XFRM_STATE_DEAD).
> > 
> > And this shouldn't be an issue after b441cf3f8c4b ("xfrm: delete
> > x->tunnel as we delete x").
> 
> I think Sabrina is right. If the skb carries a secpath,
> UDP_SKB_IS_STATELESS is not set, and skb_release_head_state() will be
> called by skb_consume_udp().
> 
> skb_ext_put() does not clear skb->extensions nor ext->refcnt, if
> skb_attempt_defer_free() enters the slow path (kfree_skb_napi_cache()),
> the skb will go through again skb_release_head_state(), with a double free.

Thanks Paolo, I was going down the same path, you got there faster :)

> I think something alike the following (completely untested) should work:
> ---
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 95241093b7f0..4a308fd6aa6c 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1851,8 +1851,10 @@ void skb_consume_udp(struct sock *sk, struct
> sk_buff *skb, int len)
>  		sk_peek_offset_bwd(sk, len);
> 
>  	if (!skb_shared(skb)) {
> -		if (unlikely(udp_skb_has_head_state(skb)))
> +		if (unlikely(udp_skb_has_head_state(skb))) {
>  			skb_release_head_state(skb);
> +			skb->active_extensions = 0;
> +		}
>  		skb_attempt_defer_free(skb);
>  		return;
>  	}

-- 
Sabrina

