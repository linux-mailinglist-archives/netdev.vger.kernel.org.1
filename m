Return-Path: <netdev+bounces-176766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DA6A6C0FD
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127C61892A2E
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4034522D7AD;
	Fri, 21 Mar 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="fyqwrY+G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kn7NbSPd"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162622D792
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577079; cv=none; b=LpwHq5jVIk1BXZPu9GIcbmSXstVgKiGAd4qqy85Be9y7Nl2/VcOU/AoZOonxpsLMTbnnw8OJfy0lCyOs7ROo8eb3ghK718PXRHwi6B7hxfiDx/KAOgxaVvo6jXOfYeKnzJ2gFV8C7hcMQEXuE1NzxUaiQNJfvBvROsr2qAboOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577079; c=relaxed/simple;
	bh=wV8EIhADMKxawKGule3RbYKhSB8Fy28+2mPWKk2ouSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGb67HYEzcBE5ZdL9F216EzfKciPR3y5LjED8vhpelvTRWXO+3LLQScZ/MkMsXLwbkDBhizv/PfvOZItcS+YmAcU1WPOM4H4VjuPRzTAnt2Ce6eXQIURlQPMRmYmFYyUrX8cn0OxGXhbBaCiPkGjvSt9ACA90ulNDkY1UVSqJj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=fyqwrY+G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kn7NbSPd; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF5C7114002D;
	Fri, 21 Mar 2025 13:11:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Fri, 21 Mar 2025 13:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1742577072; x=
	1742663472; bh=A90fANJvN/70JDFKPznsU8kfUFpxEVUI6HgzQ4NLyqM=; b=f
	yqwrY+G3vzHVWDDiHJrXccdVMp5A1X7gQ7HfrbjKJZq0icXQQ6fhAZU4aSUgqjzj
	6yPbBRUUF5fUTjUSVFl6+BHLeXbCL7HWGgW61ouX9T8qc9AhiVit1fQde62trqjc
	J9iKicFd5hSLFCylFGL4BW514L3IXEH+UgzAkAH7yYkcYeXQYdFPVkRmjy18CABA
	BH6J2y6o6JkYjWB3gcls8W6Z+u56KrpGRObNjhsfaxzNq6wfczxbOjgGTgCq9gwl
	/HgZa/xr5MSZCw2JF3oUJ3dUUjr2cA9Pdvd3xkv3C4ndR3efNyaTvjIdt9zvTJoo
	bEch2KoK9dzvLCDjbAshQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742577072; x=1742663472; bh=A90fANJvN/70JDFKPznsU8kfUFpxEVUI6Hg
	zQ4NLyqM=; b=kn7NbSPdQ/i1w8d0AP4AR44af7TJ+xD5cu1S5RzFN6WOCaf51ON
	m0nzLo8GbO4UFX3129EQDG1kZEi/FZXkLZz80XdqwMjp96w+0hUGA5pI9fn6j3qK
	K7pRBcC5Fj3pPjTbwmRUeF6c4AXJjN9uwgA0z75ZrfLE4YMm6tr5E9+eWrBRwJI/
	yQUM07AozWG0bn64gTJWlRyXoZpSW+HJzPPBx0jfZpEvHrYjZZo18I1ngSsAPZgb
	KOuDZhgEhhz5dNPnA5yOoU0IdNTPnyRE4uOX/NqmycehDiSEDuNJFHL/4DoNjK/k
	UXL9XlVmdIsA/HjcADgzLc8O4c9913nDXRw==
X-ME-Sender: <xms:sJ3dZ0ZljOKoBaV6q1BVu2wICpUWeHqGs6DLT5rozWKezXJjcrT6Hw>
    <xme:sJ3dZ_YeQvETnHE1UqRTN86j2iNSyJLhtKd-sEAzF1t4F910MMb6oG5iLauJ0ZxEw
    r-igXErPdTdYxHP_L0>
X-ME-Received: <xmr:sJ3dZ--KIPd985P7sBWJ4z1P2ecKPI-ZunWVCG1fTZTtg3oxesV12fn3GlLd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheduieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepgefhffdtvedugfekffejvdeiieel
    hfetffeffefghedvvefhjeejvdekfeelgefgnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    ugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sJ3dZ-pN5RByEk7Nb4YCaygipffe6FjUhTLABj6kl4MH878q8twLhQ>
    <xmx:sJ3dZ_osnjHAiL-ep4nZqD95NX0dFiN3iMslYZCd9xFElYU3-rITQw>
    <xmx:sJ3dZ8ReIABgNI-5O8MxRCXtdmyQCIiCxtHMGRO1ggP8oJRKMqDnJg>
    <xmx:sJ3dZ_oCOuqfSg8rOLWZpnTDKL_LUAXgrffi_lpoXS28estqG1MDNA>
    <xmx:sJ3dZy298T87W40juQlUASaLcGiggu58Qhr-HBAek-Ck7jKn6GStlyMR>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 13:11:11 -0400 (EDT)
Date: Fri, 21 Mar 2025 18:11:09 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH net-next v2 2/5] udp_tunnel: fix compile warning
Message-ID: <Z92drSwwTq17kOMr@krikkit>
References: <cover.1742557254.git.pabeni@redhat.com>
 <5c4df4171225ab664c748da190c6f2c2f662c48b.1742557254.git.pabeni@redhat.com>
 <67dd9556e1305_14b140294a7@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67dd9556e1305_14b140294a7@willemb.c.googlers.com.notmuch>

2025-03-21, 12:35:34 -0400, Willem de Bruijn wrote:
> Paolo Abeni wrote:
> > Nathan reported that the compiler is not happy to use a zero
> > size udp_tunnel_gro_types array:
> > 
> >   net/ipv4/udp_offload.c:130:8: warning: array index 0 is past the end of the array (that has type 'struct udp_tunnel_type_entry[0]') [-Warray-bounds]
> >     130 |                                    udp_tunnel_gro_types[0].gro_receive);
> >         |                                    ^                    ~
> >   include/linux/static_call.h:154:42: note: expanded from macro 'static_call_update'
> >     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
> >         |                                                 ^~~~
> >   net/ipv4/udp_offload.c:47:1: note: array 'udp_tunnel_gro_types' declared here
> >      47 | static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
> >         | ^
> >   1 warning generated.
> > 
> > In such (unusual) configuration we should skip entirely the
> > static call optimization accounting.
> > 
> > Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/cover.1741718157.git.pabeni@redhat.com/T/#m6e309a49f04330de81a618c3c166368252ba42e4
> > Fixes: 311b36574ceac ("udp_tunnel: use static call for GRO hooks when possible")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> Should CONFIG_NET_UDP_TUNNEL just not be user selectable and only
> enabled by implementations of UDP tunnels like vxlan and geneve?

It's already not user selectable?

config NET_UDP_TUNNEL
	tristate

(no string after bool/tristate, so no manual config)

But there are tunnels that don't do GRO, so they're not counted in
UDP_MAX_TUNNEL_TYPES, and if only those types are enabled, we'll have
CONFIG_NET_UDP_TUNNEL=y with UDP_MAX_TUNNEL_TYPES == 0.


> > ---
> >  net/ipv4/udp_offload.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > index 02365b818f1af..fd2b8e3830beb 100644
> > --- a/net/ipv4/udp_offload.c
> > +++ b/net/ipv4/udp_offload.c
> > @@ -83,7 +83,7 @@ void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
> >  	struct udp_sock *up = udp_sk(sk);
> >  	int i, old_gro_type_nr;
> >  
> > -	if (!up->gro_receive)
> > +	if (!UDP_MAX_TUNNEL_TYPES || !up->gro_receive)
> >  		return;
> 
> If that is too risky, I suppose this workaround is sufficient.
> But having a zero length array seems a bit odd.

I think the alternative would be to add

    #if UDP_MAX_TUNNEL_TYPES > 0

around some of this code.

-- 
Sabrina

