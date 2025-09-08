Return-Path: <netdev+bounces-220868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF11EB494EA
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670ED203105
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47D8213236;
	Mon,  8 Sep 2025 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZTVY4mo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38450205ABA;
	Mon,  8 Sep 2025 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348175; cv=none; b=tQFQGQYr+7JAP2Se33FMMdNyWe9E/seTrR3yM+MVAEjusO1AkH/NleSFkk7Q+7CX2NhCRLoLd3CdhuYPkUkvQEaJbWjI4izAUeI03v6LXUchm+ogTmOFDTwq7LIlE1uuWdjs5YnvUr6IweAwj3pfatKOAmGP36rsFWlKTzORXb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348175; c=relaxed/simple;
	bh=py2SL4Lcp1ebRiKpS+febe1mg26X4LV9Gvpzr3MfcFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlRnChtmXpMyPTb1lVvducmXTskdC02ZGL17RGGJamoR8K9AScoJjB43Us0o9NXq1WZ1Lwec0G7qbud+hL+SS3UE3DPdu0cMWtmCjdOryYC1oUjBgXw3VHlp57+MkF3j2pF+l+vrTdvcZbWrjgEF/mXhtLjB7aITBDj1a293Dxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZTVY4mo; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so3369074276.1;
        Mon, 08 Sep 2025 09:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757348173; x=1757952973; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0DapaqdkpsmqG8gstJ5wzlYQM9cf+yi+nsrLvokSaDA=;
        b=bZTVY4moU8RgPWpJMlKq5tJZPzQVDm9MD8pftbou4ha3UQokUonbs+feBbC2I0K49E
         HocI/Oq+fS6/A9wUYl/3gWS1YZbIdyNaKCT3wn0ULjUKhgEtxZQa+HbzswdBiAhTuyyA
         PKtJOsir7H/kFgsVn8RFoHiCI48JpJ9xKXubuemHcXpUwWvZbdYegvPEj6kOMIGRXzK3
         yLlYcXi4RHedo7M2B5HUegY0EnAS+ecuTso8w7BWy3LXSgns/RIZ3uaGihKhni6QbMM4
         Ip9qjpMguX1/ogulP7SvnbCvUkO8euEGFzrFmGeZL3wpdU+pyeuIQnBFRXw40ny0f9qj
         qKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757348173; x=1757952973;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DapaqdkpsmqG8gstJ5wzlYQM9cf+yi+nsrLvokSaDA=;
        b=lrhkmkSV+H4PKD0Lz44TWTK1JKCYLJxvI88dPo7/lzujTlNOImgMG0EMvC0xqzy04h
         X6bxI/rCyf3M7wKwA7s/ys8xr2d6u63ZWt0eWE4FUYQk1QVfiJb80uRa+ErWW3sL0KiI
         K3wLBKyir7R0bvzzx3Q2pKON1QHj7VEYSEoSWeagKF3vay4AuV4KMof8P4mW8Y5kzLN6
         nWyrp8HvsFlQjQ8o0XFUOH4+Q2/mAjp9W5wzH3gvAURJhNK0t1rt2M6A1XAxaDJUMVAe
         6tGzqXCGYDmQEz7GCXawFdM8fXw/hl5LL00T+6WGaG0DlCIsTthmptpPLVHV1cTu5aeC
         t0rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz0XvB+kb67jSPlGxhbL737G7xkxUDr6zB8eT4Ro9EeePv9rcEBEY2R9sob8vaT07C2CGiQ69IOR8gArM=@vger.kernel.org, AJvYcCVSMrdLTWa1nJNDFqEaip6vVVYcQS9AIHiuwBxYVu0JxhMb8qGV08iDJ/RpEEE7KH7aUpWCIDQQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxE0Q23UxJzkf5gACSPS5OdSVwua2cCW5gkmlnm2+Rin4eR3DpH
	E0bCNlQindZxyzPnHI2Va+K2XLbboaHTElZpnSAVvcsai6MGBHoxt0ev
X-Gm-Gg: ASbGncvXViD500qrEjMgIeQDOAp7EQUBUarGFTR2f8IxaGqJ4HAG3KzdQlQsUA+tBkD
	pHoYEzsPWYxJmx9r20Ob2OTu87I3wB9RHIKyKgY9eSH/RFKGyyCJLwRPNpAvQb9US1UwJgPqf9n
	IEapgNh7lJOL0a7xFvQ10XmRaNOgAL7d28xXe6/RVWvTi2roOdlmiXVi8KK5LTNYxHoGbrWAx4P
	RN4ax+jJOKgmIiLaTX1XzPVEC5M2+A9SsBYF6UTcvnrj0/lhB6t4Q0dasg+DSG4IKBN6P0iXT3+
	spglWEfJgw5hFw62BbRo5/iypNj/Vcip6qnGeUWSiKqE0XxoDQ/u3qNp9bNJQZcsYBuHV+Npfq0
	3+b6KqUy0jhn8RmaL13Pda4cIxhhG/tKaR8ZBv6cok9CoZLsLfQOrx9pkXGwsv2VeLLJh
X-Google-Smtp-Source: AGHT+IE9SzII0RV3oLBhYO8bMjK3ds9EdIM9E+T0eXQi9+L2j3In0oZA7qlVRxPT7WVC3/ENpvQvVA==
X-Received: by 2002:a05:6902:18d1:b0:e9f:bf6a:3108 with SMTP id 3f1490d57ef6-e9fbf6a3734mr7091066276.45.1757348172938;
        Mon, 08 Sep 2025 09:16:12 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9fa95fac8esm2265528276.3.2025.09.08.09.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:16:11 -0700 (PDT)
Date: Mon, 8 Sep 2025 09:16:10 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 2/2] net: devmem: use niov array for token
 management
Message-ID: <aL8BSjUbxYvvvZyD@devvm11784.nha0.facebook.com>
References: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com>
 <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-2-d946169b5550@meta.com>
 <CAHS8izPrf1b_H_FNu2JtnMVpaD6SwHGvg6bC=Fjd4zfp=-pd6w@mail.gmail.com>
 <aLjaIwkpO64rJtui@devvm11784.nha0.facebook.com>
 <CAHS8izMe+u1pFzX5U_Mvifn3VNY2WGqi_uDvqWdG7RwPKW3z6A@mail.gmail.com>
 <aLtKTwBmogXa48Rj@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLtKTwBmogXa48Rj@mini-arch>

On Fri, Sep 05, 2025 at 01:38:39PM -0700, Stanislav Fomichev wrote:
> On 09/05, Mina Almasry wrote:
> > On Wed, Sep 3, 2025 at 5:15 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> > >
> > > On Wed, Sep 03, 2025 at 01:20:57PM -0700, Mina Almasry wrote:
> > > > On Tue, Sep 2, 2025 at 2:36 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:

[...]

> > > >
> > > > AFAIU, if you made sk_user_frags an array of (unref, binding) tuples
> > > > instead of just an array of urefs then you can remove the
> > > > single-binding restriction.
> > > >
> > > > Although, I wonder what happens if the socket receives the netmem at
> > > > the same index on 2 different dmabufs. At that point I assume the
> > > > wrong uref gets incremented? :(
> > > >
> > >
> > > Right. We need some bits to differentiate bindings. Here are some ideas
> > > I've had about this, I wonder what your thoughts are on them:
> > >
> > > 1) Encode a subset of bindings and wait for availability if the encoding
> > > space becomes exhausted. For example, we could encode the binding in 5
> > > bits for outstanding references across 32 bindings and 27 bits (512 GB)
> > > of dmabuf. If recvmsg wants to return a reference to a 33rd binding, it
> > > waits until the user returns enough tokens to release one of the binding
> > > encoding bits (at which point it could be reused for the new reference).
> > >
> > 
> > This, I think, sounds reasonable. supporting up to 2^5 rx dmabuf
> > bindings at once and 2^27 max dmabuf size should be fine for us I
> > think. Although you have to be patient with me, I have to make sure
> > via tests and code inspection that these new limits will be OK. Also
> > please understand the risk that even if the changes don't break us,
> > they may break someone and have to be reverted anyway, although I
> > think the risk is small.
> > 
> > Another suggestion I got from the team is to use a bitmap instead of
> > an array of atomics. I initially thought this could work, but thinking
> > about it more, I think that would not work, no? Because it's not 100%
> > guaranteed that the socket will only get 1 ref on a net_iov. In the
> > case where the driver fragments the net_iov, multiple difference frags
> > could point to the same net_iov which means multiple refs. So it seems
> > we're stuck with an array of atomic_t.
> > 

Yes that is correct, multiple references can occur so the bitmap
will lose all > 1 references.

> > > 2) opt into an extended token (dmabuf_token_v2) via sockopts, and add
> > > the binding ID or other needed information there.
> > >
> > 
> > Eh, I would say this is an overkill? Today the limit of dma-bufs
> > supported is 2^27 and I think the dmabuf size is technically 2^32 or
> > something, but I don't know that we need all this flexibility for
> > devmem tcp. I think adding a breakdown like above may be fine.
> > 

That's my inclination too.

> > > > One way or another the single-binding restriction needs to be removed
> > > > I think. It's regressing a UAPI that currently works.
> > > >
> > 
> > Thinking about this more, if we can't figure out a different way and
> > have to have a strict 1 socket to 1 dma-buf mapping, that may be
> > acceptable...
> > 
> > ...the best way to do it is actually to do this, I think, would be to
> > actually make sure the user can't break the mapping via `ethtool -N`.
> > I.e. when the user tells us to update or delete a flow steering rule
> > that belongs to a devmem socket, reject the request altogether. At
> > that point we could we can be sure that the mapping would not change
> > anyway. Although I don't know how feasible to implement this is.
> > 

I will look at this and see if it is possible, I do think that would be
nicer for the user.

> > AFAICT as well AF_XDP is in a similar boat to devmem in this regard.
> > The AF_XDP docs require flow steering to be configured for the data to
> > be available in the umem (and I assume, if flow steering is
> > reconfigured then the data disappears from the umem?). Stan do you
> > know how this works? If AF_XDP allows the user to break it by
> > reconfiguring flow steering it may also be reasonable to allow the
> > user to break a devmem socket as well (although maybe with
> > clarification in the docs.
> 
> For af_xdp, there is a check in xsk_rcv_check (that runs _after_ bpf
> program that does the redirect exits) and it drops the packet if
> the packet is redirected to the unxpected queue (not the one that
> the socket was bound to). And the only way to observe it after the fact
> is a drop counter on the nic (or, rather, depends on the nic wrt how it
> accounts it). I remember Willem wanted to remove that restriction,
> but looks like he never got to it?
> 
> tl;dr we don't error out explicitly when the user misconfigures the steering
> after the fact (or initially) and drop the packet in the data path.

Sounds like a reasonable default if the explicit ethtool rejection isn't
feasible.

Thanks for the review and comments!

Best,
Bobby

