Return-Path: <netdev+bounces-239984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2123C6EA26
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 9671C2A3B1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F0D311968;
	Wed, 19 Nov 2025 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="C8lYSGtM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O+PdprZc"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E02D2DCF5D
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763557145; cv=none; b=ru/Cdi0N7WmkaiOdcuq47yKtdiItZ17WTJ+TMdW2FJYuTkMGcw1wRvR2Z4qI+o1m3llB59UmZxWXou6ceePz+nLgHbZA52RUxLGtI4zAMm8Z5zXrFNyHjUIw2GNlwSgXRwfQ83x2phZSbJcTCOt4ON+xieA9i3JOuXxn3TMULmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763557145; c=relaxed/simple;
	bh=R4entDCq94AuEGtP5w7qfitkVN7YwG/0+GrBuf7vwis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRmzqJur2ufaaMTCE66VIKIhlkS7X6kZIsI41WHqz4TSb22PWUkw7nymnDFUJMJhBh+h0cHRzO4nItY6d1HbAcG5TBRJXAWQU6mkJujpKe5s23SPgjKUV9IsaH3jY25y5SkM+ST5ZD1wvr/usGkWSPYhlbdLK6xPqeSujgiNdIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=C8lYSGtM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O+PdprZc; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 19EB11D0016A;
	Wed, 19 Nov 2025 07:58:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 19 Nov 2025 07:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1763557138; x=
	1763643538; bh=13eP7Wbg+SvzNZ0BgOogCk4y6i5sHlypruTU0fAPebQ=; b=C
	8lYSGtMA32M9C73LDJFoN0A48Dwph8UMj5IjGZriq7MabRKnJvUYhIp7qQgBWzsT
	13Ba3tyUYCQ6YibXb+jdnBU4Zb0++EJz7BgginFcXt9mCRQbj3CYRF9bTiz3jNZz
	KoCZ3eghxTZfAB641PjVwEQXuW1PpmK0E8siq2UG0E/KtihHyTjryeP6tZzVqO88
	+cqSZf0U3pfX6D9DiUdAg2XrAfX549bIorWmgBjTcuY0i7AlBgHUgdkeLwFhzGgZ
	uuFWHqWZ50q8WJtzlpk2R/AOFsPVlEQgjivei/8c8E3e/UpTWhtAcsiEKNeCjRLq
	IBqkL4m7dfzJ2NqbFe9Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763557138; x=1763643538; bh=13eP7Wbg+SvzNZ0BgOogCk4y6i5sHlypruT
	U0fAPebQ=; b=O+PdprZc0Px07+8JMnuWi99kZ3fIGjq+nDRf/1Byf/lKYCl+v5u
	C63TSvNGuC9vySZBNm2TwgAF2RPOysqtAkqwWxeUzZ9hyb5lNOLNKirzHzGsuBpD
	FaMNovie73DpVVPaULTQPv7M9mp0iQ5+IXO/YbtlEtVD8OmyZsalTVe0Ga19/6uM
	4NQhoL76ZqnR008laS1vWzpL+SVbQ2kz8KHKVx0CLrIlMqkz2+PXxDyoo9cPBJ/M
	YHqnopJyUyb5G58HilVFxtPrfx1QcKqxXSKMqz/sovDuB3znf4EackU/Y9lU6l83
	kUuTXJuwl0HPohuzxJoMAaO6W/UR3syCEHA==
X-ME-Sender: <xms:Eb8daSvxx_TOKoX8al1SLDJlTMa8doPEljsHWTMPlAiDktvjgR00jA>
    <xme:Eb8daTUkV3C5AjoO7T09KIt_SZaatPFEgdxVoEbOvksEJ8c5JPjA1pYKF4eYguc9i
    JcQuB53UnmPDpWMLIppQ1OFx3ZvVyOWCadAThUP1STD04dLJ7Cf9hs>
X-ME-Received: <xmr:Eb8daawjSUaOl0o6YCaMbRkCkmd5s5KnO2VeJ8YGm1NrVESd5rkpaarYlvs3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdegvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirghnsgholhesnhhvihguihgrrdgtoh
    hmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhht
    sehsvggtuhhnvghtrdgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrd
    grphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:Eb8daSEj8mrm8JF20pYBCdqGHOf1nsJjvJX6rWb5-EooygL9RUf2YA>
    <xmx:Eb8daXvUZd3yJCg-nWg38rhCQmZr-PBkRukZH00jOaZ8lvpXbxl-XQ>
    <xmx:Eb8daaA3VH9lKEVETJ8U9D9GLEaz_ao0m5_DpZgt6QBNENlzdYDmVQ>
    <xmx:Eb8daaAF4C51BZtZl6pmIAGSPko0N7eIxL3YKGVSXfQqUc3rkmzGMQ>
    <xmx:Er8dab7U0LzsrYClOgGrh-YqiV6z_BB5lQBEZ0FoTXgNwGkNfflBsJNU>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 07:58:57 -0500 (EST)
Date: Wed, 19 Nov 2025 13:58:55 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	steffen.klassert@secunet.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH ipsec] xfrm: Fix inner mode lookup in tunnel mode GSO
 segmentation
Message-ID: <aR2_D3iEQvAklDEW@krikkit>
References: <20251114035824.22293-1-jianbol@nvidia.com>
 <aRpaNMxGlyV_eAHe@krikkit>
 <d18ab53f-b91b-4c64-926f-4a1466d2d31e@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d18ab53f-b91b-4c64-926f-4a1466d2d31e@nvidia.com>

2025-11-17, 10:12:32 +0800, Jianbo Liu wrote:
> 
> 
> On 11/17/2025 7:11 AM, Sabrina Dubroca wrote:
> > 2025-11-14, 05:56:17 +0200, Jianbo Liu wrote:
> > > Commit 61fafbee6cfe ("xfrm: Determine inner GSO type from packet
> > > inner protocol") attempted to fix GSO segmentation by reading the
> > > inner protocol from XFRM_MODE_SKB_CB(skb)->protocol. This was
> > > incorrect as the XFRM_MODE_SKB_CB(skb)->protocol field is not assigned
> > > a value in this code path and led to selecting the wrong inner mode.
> > 
> > Your testing didn't catch it before the patch was submitted? :(
> > 
> 
> I admit I didn't test all the cases for the previous submission, but I have
> tested all the cases now with this fix.
> 
> > 
> > > The correct value is in xfrm_offload(skb)->proto, which is set from
> > > the outer tunnel header's protocol field by esp[4|6]_gso_encap(). It
> > > is initialized by xfrm[4|6]_tunnel_encap_add() to either IPPROTO_IPIP
> > > or IPPROTO_IPV6, using xfrm_af2proto() and correctly reflects the
> > > inner packet's address family.
> > 
> > What's the call sequence that leads to calling
> > xfrm4_tunnel_gso_segment without setting
> > XFRM_MODE_SKB_CB(skb)->protocol? I'm seeing
> > 
> > xfrm_output -> xfrm_output2 -> xfrm_output_one
> >   -> xfrm_outer_mode_output -> xfrm4_prepare_output
> >   -> xfrm_inner_extract_output -> xfrm4_extract_output
> > 
> > (almost same as what ends up calling xfrm[4|6]_tunnel_encap_add)
> > so XFRM_MODE_SKB_CB(skb)->protocol should be set?
> > 
> 
> I think we both made mistaken.
> a. XFRM_MODE_SKB_CB(skb)->protocol is assigned in that path, but it is
> assigned the value from ip_hdr(skb)->protocol. This means it holds the L4
> protocol (e.g., IPPROTO_TCP or IPPROTO_UDP). However, to correctly determine
> the inner mode family, we need the tunnel protocols (IPPROTO_IPIP or
> IPPROTO_IPV6), which xfrm_af2proto() expects.

(not "expects" but "returns"? or did you mean
s/xfrm_af2proto/xfrm_ip2inner_mode/?)

Ah, right. Thanks. Then please update the commit message to explain
that XFRM_MODE_SKB_CB(skb)->protocol is not the right value, rather
than being unset.

> b. Furthermore, XFRM_MODE_SKB_CB(skb) shares the same memory layout as
> XFRM_SKB_CB(skb). This area can be overwritten during the transformation
> process (for example, in xfrm_replay_overflow and others), making the value
> in XFRM_MODE_SKB_CB unreliable by the time we reach GSO segmentation.

Ok, that could also happen.

> > Also, after thinking about it more, I'm not so sure that
> > xfrm_ip2inner_mode is wanted/needed in this context. Since we already
> > have the inner protocol (whether it's via xo->proto or
> > XFRM_MODE_SKB_CB(skb)->protocol), and all we care about is the inner
> > family (to get the corresponding ethertype), we can just get it
> > directly from the inner protocol without looking at
> > x->inner_mode{,_iaf}? (pretty much just the reverse of xfrm_af2proto)
> > 
> 
> I still prefer to reuse the logic in xfrm_af2proto()/xfrm_ip2inner_mode for
> two main reasons: a. It keeps the code easier to understand by using
> standard helpers rather than open-coding the reverse mapping. 

We don't have to open-code it, we can add something like

static inline int xfrm_proto2af(unsigned int ipproto)
{
	switch(ipproto) {
	case IPPROTO_IPIP:
		return AF_INET;
	case IPPROTO_IPV6:
		return AF_INET6;
	default:
		return 0;
	}
}


I don't think xfrm_ip2inner_mode, which does "if [some ipproto value]
and [some x->* property] match then use inner_mode, otherwise use
_iaf", is easier to understand. To me it seems clearer to add
xfrm_proto2af.


And looking for all uses of inner_mode_iaf, I'm not sure we need this
at all anymore. We only use inner_mode_iaf->family nowadays, and
->family is always "not x->props.family" (one of AF_INET/AF_INET6), or
0 with unspec selector on transport mode (makes sense, there's no
"inner" AF there). (but that's a separate issue)


I'd be ok with using xfrm_ip2inner_mode for this fix and trying to
clean this up later in -next.

> b. It keeps
> the logic directly related to the xfrm configuration and state properties.
> 
> Thanks!
> Jianbo
> 

-- 
Sabrina

