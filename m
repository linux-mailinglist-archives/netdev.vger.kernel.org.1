Return-Path: <netdev+bounces-199928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AAFAE24E4
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 00:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137801703F9
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 22:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A232623814A;
	Fri, 20 Jun 2025 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXSSPqjv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2DB221DAC
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750457387; cv=none; b=aGxj/89i2uYeniru8OlVy7u/WVRAxDVWoUv5Kx0DbrqSK9sESmT6/wdGWU/vllQUpRy/fMLSSCg6rjwSTLEFegcQZmuv4knMHT9kMEckwNPLl0CFd9hj8bNeYFeIYeutgTnWxkK//uFksYh7PFuOZ2bpMyaV6r2rlhlp7pSGeY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750457387; c=relaxed/simple;
	bh=K31odUOz/vTmFsiaHy13s7bVO/cpGX9qQuXpKe97C7U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=c/MkX2OPEzZm89GDmOUsu1CRrmfAC9VNbt7roqn/hKslVI1xwkFXMIzmK3h+ZeTqxS+0/dM7tfWbaxzk3dq7xm+RU3h0tTvnXpLVHqDx3kH/2UO3VdtF/ry5In6s66tCCFUfkeINVVMeRK36BSoiL0mh+dLzZobHhb6rsJfK5WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXSSPqjv; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e767ce72eso20152627b3.1
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 15:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750457385; x=1751062185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrpHK+z1xA24NV4efUtZFDjR5mRbS2AidodO0YiR8gQ=;
        b=SXSSPqjveOZK+UluVcDaBVB7DgLkCBtPOdmDtl+MLB0+9UBTY6AyaezDkXj3mDbp94
         a+3buZIFOupBIeXMZjIuU4+QqXlJSHG0NaGCUOW3l3GNGFrW/EfwjYNm2Y1di9iqnur2
         RWwbYviVjY+n8/kV0hGHxZg6v88nUkVNSnAB1jdN7+6Os1G7xRYVujIatFhftOx+E/35
         d005z1+duT+V3TwB3oHsZ0XgWQXSbkpwGlkfDPqvvR8uehNc3KzcSOyeqbgArPgi2V4t
         VF7igSk8FKXwbRuNt7nStrtgoGv5lxOmKfOS88ZHFbNIWOru5ItaQxAQnwyXRPHdU4p4
         Q2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750457385; x=1751062185;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qrpHK+z1xA24NV4efUtZFDjR5mRbS2AidodO0YiR8gQ=;
        b=t5zsZ38Db/ocWIHH4l6qgxVIG2c94CJ60mWJKN+zRkVITX57MfFYQ7uqLBr47NuAdP
         JsFm0muUvk2iZdzh0J1Bfn9pBBF29fQwGgZut0RVFZKacWWHXJ7xDwKogZmp+Dd1Kc1x
         Vg5bHknj4rDwldtYE7EGIQKQQfwfmmYR/qDH9S+PLg+Z9savEcnd2eiXbnfOTC191waq
         M9ZAZeJ9vkbwIlB0fOkt91/jQkpkaeiuS1J0YjAcOWmE7PNlwKfgC76fdCDa+hIsDdfJ
         eo9f3r//y+tgLqlT8gsfshwvcY3xayAGfgjf7jY73afahdxKg9ha6gbhwyaoQ/3eC0HU
         qRKA==
X-Forwarded-Encrypted: i=1; AJvYcCWKGwrRC2zhwqT2qyMwdsXdNpIl2xV0ftk03dpSbpxIFlZkB+SV6ceNS2tHWK3Vm67q3k5dsgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13FxIAOs8l6jFke4/YLG9MUEYt9O50qYZD0bJJRo3x5BUyY4S
	h1WvEHXymhuJoAgz62lsqCPXVgmfaXo2U4iHBeMtF1iw3GFNRpyIAH6N
X-Gm-Gg: ASbGncuGZB/JbUH0JNNDGQLbgeUIoJImJfPGWfW3GDX4kLXkgmuFa/uCjjvxxw4AhZF
	Khw0x6A6DqkhRuLZlszU8BInC8oSRyQbIUwrjVTDAkRtMwiUpDI2ytXUD4tMCaxiDgJN/JXjxWJ
	nNW4GdCPIGWtzoKNSS3ONFJxd+xNAmcXta8XN9ebOn9jKIeV2P12fAOm8tsQTi3RUnlCPpi0+4m
	HeMXnQVMnkH5iooCAh8rKTjBE6Kmpp4P2uhaUU8YogYODEJi6hQxFf9E37LAD22CVAAybWp2nYY
	VRTMYKzJA6DG7FS2XOAgDbJp84ki5VpyP9eZwAQWqTermG0LLU5hFh1/vUXOU22qesjkFmWrXM7
	oXPz61z3g+rITwcMF7CzCqlCpLdxaUI4giQkvWuUu8g==
X-Google-Smtp-Source: AGHT+IGfQG5jB1l7sp+CfHyslZH7OkVqc+VQPO4gScNKthF3ffv0TFUs7Btq/1zWX6tg6HgvMscODg==
X-Received: by 2002:a05:690c:6:b0:70e:a1e:d9f8 with SMTP id 00721157ae682-712c64f520amr61583977b3.22.1750457384756;
        Fri, 20 Jun 2025 15:09:44 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4c1d7a0sm5907687b3.111.2025.06.20.15.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 15:09:44 -0700 (PDT)
Date: Fri, 20 Jun 2025 18:09:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <6855dc27a51d2_1ca4329428@willemb.c.googlers.com.notmuch>
In-Reply-To: <81b7e1a5-3c7c-484d-a588-de67eb907bbf@redhat.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <1c6ffd4bd0480ecc4c8442cef7c689fbfb5e0e56.1750176076.git.pabeni@redhat.com>
 <685572ce376c8_164a2946a@willemb.c.googlers.com.notmuch>
 <81b7e1a5-3c7c-484d-a588-de67eb907bbf@redhat.com>
Subject: Re: [PATCH v4 net-next 7/8] tun: enable gso over UDP tunnel support.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 6/20/25 4:40 PM, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> >> @@ -1698,7 +1700,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> >>  	struct sk_buff *skb;
> >>  	size_t total_len = iov_iter_count(from);
> >>  	size_t len = total_len, align = tun->align, linear;
> >> -	struct virtio_net_hdr gso = { 0 };
> >> +	struct virtio_net_hdr_v1_hash_tunnel hdr;
> > 
> > Not for this series.
> > 
> > But one day virtio will need a policy on how multiple optional
> > features can be composed, and simple APIs to get to those optional
> > headers. Perhaps something like skb extensions.
> > 
> > Now, each new extention means adding yet another struct and updating
> > all sites that access it.
> > 
> > A minimal rule may be that options can be entirely independent, but
> > if they exist at least their headers are always in a fixed order.
> > Which is already implied by the current extensions, i.e., hash comes
> > before tunnel if present.
> 
> If I read correctly, you are suggesting that negotiating tunnel and not
> hash would yield this layout:
> 
> < basic vnet hdr> <tnl fields>
> 
> with no gaps/data between the basic header fields and the tunnel-related
> one. Am I correct?
> 
> This has been discussed in the previous revisions, and a recent
> specification update explicitly states differently: with tunnel support
> and without hash report the only possible layout is:
> 
> < basic vnet hdr> <hash report field (unused)> <tnl fields>

Indeed. Long-term it seems odd to just keep extending the header with
every optional feature, even when disabled.

> Since it's in the spec it's too late to change it, unless we add yet
> another feature for that. I'm gladly leaving that joy and fun to someone
> else:)

Agreed!

> FTR the initial revisions of this series, before I stumbled upon the
> mentioned spec change, followed the schema you mentioned.
> 
> >> @@ -1721,7 +1733,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> >>  	if (tun->flags & IFF_VNET_HDR) {
> >>  		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
> >>  
> >> -		hdr_len = tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, from, &gso);
> >> +		if (vnet_hdr_sz >= TUN_VNET_TNL_SIZE)
> >> +			features = NETIF_F_GSO_UDP_TUNNEL |
> >> +				   NETIF_F_GSO_UDP_TUNNEL_CSUM;
> > 
> > Maybe a helper virtio_net_has_opt_tunnel(), to encapsulate whatever
> > conditions have to be met. As those conditions are not obvious.
> > 
> > Especially if needed in multiple locations. Not sure if that is the
> > case here, I have not checked that.
> 
> Yep, as an outcome of Ajihiko's review I'm encapsulation the above in
> a new helper - tun_vnet_hdr_guest_features() to be more generic.

Saw that. Awesome.
 
> >> @@ -2812,6 +2849,8 @@ static void tun_get_iff(struct tun_struct *tun, struct ifreq *ifr)
> >>  
> >>  }
> >>  
> >> +#define PLAIN_GSO (NETIF_F_GSO_UDP_L4 | NETIF_F_TSO | NETIF_F_TSO6)
> >> +
> > 
> > Minor/subjective: prefer const unsigned int at function scope over untyped
> > file scope macros.
> 
> Unless it's blocking I would keep the current code here.

Ack.

> >> +static inline int
> >> +tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features,
> >> +			struct sk_buff *skb,
> >> +			const struct virtio_net_hdr_v1_hash_tunnel *hdr)
> >> +{
> >> +	return virtio_net_hdr_tnl_to_skb(skb, hdr,
> >> +					 !!(features & NETIF_F_GSO_UDP_TUNNEL),
> >> +					 !!(features & NETIF_F_GSO_UDP_TUNNEL_CSUM),
> > 
> > Double exclamation points not needed. Compiler does the right thing
> > when arguments are of type bool.
> 
> Will drop in the next revision.
> 
> Thanks!
> 
> Paolo
> 



