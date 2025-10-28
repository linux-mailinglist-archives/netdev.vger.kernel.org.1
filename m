Return-Path: <netdev+bounces-233553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 129EDC15572
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EEAC4EEA18
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99D6222599;
	Tue, 28 Oct 2025 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="let3/ilr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L8PT2jlU"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD50D275B06
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663883; cv=none; b=WvaFTBc2isNMjrO/n+loSmwcZtnhlzPdUhUGkFkf4u0OwNJpTJ//abh4mhj2612NCKaEpS2tmoY31KztU8CckwIv6kjJxdS8cPGbqkp/MKyVmw7LS1T0arGL4gr8Jb8pkhjhqFLk69CYOrE1aSeFEgSSzSHwq0Hw9p3Q4+ARHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663883; c=relaxed/simple;
	bh=VU4yAreZLxH/RexY58C3WpTb8cAXs3U8BzYluzB1U3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOsOj0QvNiTtWwRLoran4VBliTAeqUDPe0LgachCRKx27Xcl0VXkqi0LQGJjtkgYRn0uvG1zslcE0LwPGrJEpqMahf8HiM9E4ZQq2AMkdTVu0Hnn+9rYVyCfk+U/HGzLkAUC8zmPt3F8O9ove7j0lp6XguSO9hQW4WW+kvUfpeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=let3/ilr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L8PT2jlU; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AD297EC0313;
	Tue, 28 Oct 2025 11:04:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 28 Oct 2025 11:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761663879; x=
	1761750279; bh=x60ITIcygNx6GFU92V4j3pXVB2M8vZbcFMB7zEsDanI=; b=l
	et3/ilr7ailG76QYmwNepc+jDuA+eB22k2/3bEk+ktwdRnV1d6+GG7GjTkv4QQ3P
	d2V2hCknHmUNr3G/m4zyjbL4kR20/Fn/EW3WbiIOZxZGIRqCTGFYjon+3T/98c72
	Th0QrR/3Bitrav9BGy5DPOrAyICddwi2qQvagmROJz8hm41+kHk1g8QoAqRKzjBR
	0ia/pHxwt2QjcC8gZx5nIfMpdI49D0pvhb2SNHgXSfL7wJiaMFvzG6Ay6614Ns+/
	gA7hYLNz4VkxsAUeTJEAPh3HF+q3dEfLS3Wymb3NNkjKaeBHJgm9KONOtwp8ZVcy
	wo9RtmtkRhAT45gHT841w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761663879; x=1761750279; bh=x60ITIcygNx6GFU92V4j3pXVB2M8vZbcFMB
	7zEsDanI=; b=L8PT2jlUCoDTLDYwZC/FX1uHcU8IxFRzrWOhDDAY4zumzk4q2Hm
	cbiy+zvmwXXVQbUBTgMWpcRILrcUhe8HSbjq1QJ/3mUL0VEkRJSf0kgLig/dVriy
	Qx9t9M+nDhSN7ZsCwVutETeGwl8hvaXH9di+fa5g/Tm3viRHRut9SYlBHLAFTXIz
	gGsQj4LzFL70umI0ovPrnuJqZgjlqVNyP/L0i1qOrc0EkW8xv6DNy86RGnqzcgKl
	z4kVZlyxJGOjqkF7gi41znH/A/EgNRj+gnyuk/FH8gU3oGlqLpTcwD3WrCWU+iRM
	efJsdI+IBiKA67CDe1qAwpsp00lA0lD9I0Q==
X-ME-Sender: <xms:htsAaTkQGvIdrttA72B9oDJmcbDEOvjWae59tV_bdPkdOHjen7BDdw>
    <xme:htsAaSvxHNlT6DbQV4nLAsO9XXRp1GrajBTL5H-r7jSOHtPBvll-nKgrgia4a8RAs
    cXBU5iHtfAnhnW41xgF11GOfmH_WwVESP_nXDcG4jPs-oYwm4yNFw>
X-ME-Received: <xmr:htsAaWpsbt81P9zqnuMZk1w4EyPhi0WeeDxs7LYBk8UVvxebfb_FOnZM7rjN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieduudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehjihgrnhgsohhlsehnvhhiughirgdrtghomhdprhgtphhtthhopehsthgvfhhfvghn
    rdhklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegtrhgrthhiuhesnhhvihguihgrrdgtohhmpdhrtghpthhtohephhgvrhgsvghr
    thesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopegvughumhgrii
    gvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdr
    tghomh
X-ME-Proxy: <xmx:htsAaQfQVPIhbB256kyHoG6IgLlaeSCXyr51v-ALqUJcxO93-BRYMQ>
    <xmx:htsAaWkWyAElS3DyzBolDqtR0O3zp11ffSjh46ZXXWeOflGQQSNMog>
    <xmx:htsAafYdzm_Z9_zlQFq6QDGNteTQ1mmuy7TlKzm1yTebMJVlkrZbcA>
    <xmx:htsAaT5cAANHA0pKDH3AIU-76vjVTRARri1BqlgdX8K1eJBYIGGTZw>
    <xmx:h9sAaWLLm7PghlWyVWX_jageI4_eh_CZAcUVCOMLmtdKNlt6co2uzPcj>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 11:04:38 -0400 (EDT)
Date: Tue, 28 Oct 2025 16:04:36 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jianbo Liu <jianbol@nvidia.com>, steffen.klassert@secunet.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH ipsec v3 2/2] xfrm: Determine inner GSO type from packet
 inner protocol
Message-ID: <aQDbhJuZqFokEO31@krikkit>
References: <20251028023013.9836-1-jianbol@nvidia.com>
 <20251028023013.9836-3-jianbol@nvidia.com>
 <aQCjCEDvL4VJIsoV@krikkit>
 <c1a673ab-0382-445e-aa45-2b8fe2f6bc40@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1a673ab-0382-445e-aa45-2b8fe2f6bc40@nvidia.com>

2025-10-28, 21:36:17 +0800, Jianbo Liu wrote:
> 
> 
> On 10/28/2025 7:03 PM, Sabrina Dubroca wrote:
> > 2025-10-28, 04:22:48 +0200, Jianbo Liu wrote:
> > > The GSO segmentation functions for ESP tunnel mode
> > > (xfrm4_tunnel_gso_segment and xfrm6_tunnel_gso_segment) were
> > > determining the inner packet's L2 protocol type by checking the static
> > > x->inner_mode.family field from the xfrm state.
> > > 
> > > This is unreliable. In tunnel mode, the state's actual inner family
> > > could be defined by x->inner_mode.family or by
> > > x->inner_mode_iaf.family. Checking only the former can lead to a
> > > mismatch with the actual packet being processed, causing GSO to create
> > > segments with the wrong L2 header type.
> > > 
> > > This patch fixes the bug by deriving the inner mode directly from the
> > > packet's inner protocol stored in XFRM_MODE_SKB_CB(skb)->protocol.
> > > 
> > > Instead of replicating the code, this patch modifies the
> > > xfrm_ip2inner_mode helper function. It now correctly returns
> > > &x->inner_mode if the selector family (x->sel.family) is already
> > > specified, thereby handling both specific and AF_UNSPEC cases
> > > appropriately.
> > 
> > (nit: I think this paragraph goes a bit too much into describing the
> > changes between versions)
> > 
> > > With this change, ESP GSO can use xfrm_ip2inner_mode to get the
> > > correct inner mode. It doesn't affect existing callers, as the updated
> > > logic now mirrors the checks they were already performing externally.
> > 
> > Sorry, maybe I wasn't clear, but I meant that the callers should also
> > be updated to not do the AF_UNSPEC check anymore (note: this will
> > cause merge conflicts with your "NULL inner_mode" cleanup patch [1]).
> > 
> > And I think it would be nicer to split the refactoring into a separate
> > patch. So this series would be:
> > 
> > patch 1: fix xfrm_dev_offload_ok and xfrm_get_inner_ipproto (same as now)
> > patch 2: modify xfrm_ip2inner_mode and remove the AF_UNSPEC check and
> >           setting inner_mode = &x->inner_mode from all callers
> >           [no behavior change, just a refactoring to prepare for patch 3]
> > patch 3: use xfrm_ip2inner_mode for GSO (same as your v2 patch 2/2)
> > 
> > Does that seem ok to you?
> > 
> > 
> > And to avoid the merge conflict with [1], maybe it also makes more
> > sense to integrate that clean up in patch 2 from the list above, so
> > for ip_vti we'd have:
> > 
> > diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
> > index 95b6bb78fcd2..89784976c65e 100644
> > --- a/net/ipv4/ip_vti.c
> > +++ b/net/ipv4/ip_vti.c
> > @@ -118,16 +118,7 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
> >   	x = xfrm_input_state(skb);
> > -	inner_mode = &x->inner_mode;
> > -
> > -	if (x->sel.family == AF_UNSPEC) {
> > -		inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
> > -		if (inner_mode == NULL) {
> > -			XFRM_INC_STATS(dev_net(skb->dev),
> > -				       LINUX_MIB_XFRMINSTATEMODEERROR);
> > -			return -EINVAL;
> > -		}
> > -	}
> > +	inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
> >   	family = inner_mode->family;
> > 
> > 
> > Does that sound reasonable?
> 
> I have a concern regarding backporting.
> 
> Patches 1 and 3 in your proposed structure are bug fixes that should ideally
> go into the ipsec tree and be suitable for stable backports.
> Patch 2 should be targeted to ipsec-next as refactoring often does.

If it's part of a bugfix series, I think it's ok to do a small refactoring.

> If so, patch 3 becomes dependent on a change that won't exist in older
> kernels, making it difficult to backport cleanly.

It shouldn't be a problem to backport the refactoring, as this is code
that doesn't change much (the code around calls of xfrm_ip2inner_mode
hasn't been modified since 2019).

> To maintain backportability for the GSO fix, I'd prefer to keep the
> modification to xfrm_ip2inner_mode within the same patch that fixes the GSO
> code (which is currently my v3 patch 2/2).
> 
> My proposed plan is:
> 
> Send the patch 1 and patch 3 (including the xfrm_ip2inner_mode change)
> together to the ipsec tree. They are self-contained fixes.

So, keep v3 of this series unchanged.

> Separately, after those are accepted, I can modify and re-submit that patch
> [1] to ipsec-next that removes the now-redundant checks from the other
> callers (VTI, etc.), leveraging the updated helper function.
> 
> This way, the critical fixes are self-contained and backportable, while the
> cleanup of other callers happens later in the development cycle.

The only (small) drawback is leaving the duplicate code checking
AF_UNSPEC in the existing callers of xfrm_ip2inner_mode, but I guess
that's ok.


Steffen, is it ok for you to

 - have a duplicate AF_UNSPEC check in callers of xfrm_ip2inner_mode
   (the existing "default to x->inner_mode, call xfrm_ip2inner_mode if
   AF_UNSPEC", and the new one added to xfrm_ip2inner_mode by this
   patch) in the ipsec tree and then in stable?

 - do the clean up (like the diff I pasted in my previous email, or
   something smaller if [1] is applied separately) in ipsec-next after
   ipsec is merged into it?


[1] https://lore.kernel.org/netdev/20251027023818.46446-1-jianbol@nvidia.com/


-- 
Sabrina

