Return-Path: <netdev+bounces-115046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B56944F6F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002541F2153B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832101AED45;
	Thu,  1 Aug 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKKYsQk/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0821B0106;
	Thu,  1 Aug 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526679; cv=none; b=L0Rm3lJ3Krm+J8WMtN5hIrDBDQbrKNxuIicdn1S32QiWt1a4Ca5fpFPvIZrgY1/QW5Y1QYOu9IC5iJQuBx9/MUjLqRUy5QOW/QSxJy4Rq0orV56FKjCQ4jobEGSphUUDygC8UmYlKzeI0Wnki35iycZKAH8+iUW7Swuui8djeGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526679; c=relaxed/simple;
	bh=HVyiZbaild1Wid4X45Oeo7GhfGPWtHFwhd8iGEXYwsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvhdjZi2miLETKZnVBjkhL1syQJB5A5v8pfNet56yDwmdqhui6XFX61cNMO9zLmJknqzq35eS8Vs6KjAcjdK1hlEPLCWIxMmtxORLUwkFK8yr4CBDqKgsfDAtQhoMHFFXwBzVVhzPvlcmyXrWaRLiEbQUEt2pXxS7nZ17/zJCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKKYsQk/; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2681941eae0so2437521fac.0;
        Thu, 01 Aug 2024 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722526677; x=1723131477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DxaMOzeZ/iAXtwUr1eOqIcyS5wuAZVA6dKRpqc08aRg=;
        b=AKKYsQk/p2+1Q4onaTNHyyuXuz++e4y6o8jp0dMKtXTdEy3P9XBTHHDuN3YNVsH6xR
         Z1r0eZ68IDranSf5i+i76pT5t/FO13u8qmCJiryiiYoi3TwGhmoBlaGuoRn7mVW3E7sx
         04lR60FI13l5ER2ZvYezlbyQ8Z5/qQa2smUMx7dh3VvJS9H24yK/umj2xsW89O7wlsPW
         5MZ5CB4c65bQsvSvrBUccOIom/MaCBRKD540RXrO5A5mLrEbvNlbWa086HeR8E5m+jsF
         F/SFfyuZv9Mqs1jigp9YNmdaj9ffFGpnbVgi+Fr3/j9rEvOHmU77lJv3S1Jgs9ROYA2E
         oF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722526677; x=1723131477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxaMOzeZ/iAXtwUr1eOqIcyS5wuAZVA6dKRpqc08aRg=;
        b=EaytWSZ60au1esiS/L1t/gaX83EPPdUkA04FT/DAxF58HBKiBT6mQyGl71uydA3iPc
         /mbZEqB//g1H4wbWV8iN4YAFNWaaD/dqb8iwz5wFY6wXKnV16c/MRy7NIQMRNpr/Je/k
         bgEwM0hgmwvlFOfE0clsPxkPPwtjjT/5kU9Nz9bC2jyuanGlgkqTDlQBAR0Bk+JqNj98
         nMmG4PB60idM4o55s0QOtJXqWcDBPiKYjnL4ny9LYSP+h/S6tsaNbd7gsrNdiDE7Qpus
         GhooPXxTDWCvnZ2wh2zKNk9OdbpuP+TtmRq+8Q5YxN4ul15RhlxB1u9zDFZJ340nLS8Q
         x7ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUvEYRht495vV1rsqE02hQV/6wiiUYqqFP3NkPb2/aIufa7GzL0PdXDQhhB6kGDDXzlAfTKGmt26VTv6lKw77ULj2UfF9M5
X-Gm-Message-State: AOJu0YxQREUHCYbmJ50dHvx9emE+diHgoOGQGbTvqkMw6KOf6URraqG4
	FIIDR0D7Lp72xmVGBlTSJEMwynoHR1vItVQxChtHU8u5PzOmqpnjlpgeXs55llyAVUIwYPj7rLg
	TsxE3mj3RfpFWt4agVCkjmLz2oU0=
X-Google-Smtp-Source: AGHT+IHO4jiFCkzlp591vNX4hal9iztJ4TzKiL6h8EmN+j5rY0sXgMrfbCwiysgViRP0hJ9psYzbnyLboPjxapGGaiw=
X-Received: by 2002:a05:6871:113:b0:261:575:5384 with SMTP id
 586e51a60fabf-26891aecef4mr577840fac.16.1722526676667; Thu, 01 Aug 2024
 08:37:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801123143.622037-1-vtpieter@gmail.com> <20240801134401.h24ikzuoiakwg4i4@skbuf>
In-Reply-To: <20240801134401.h24ikzuoiakwg4i4@skbuf>
From: Pieter <vtpieter@gmail.com>
Date: Thu, 1 Aug 2024 17:37:43 +0200
Message-ID: <CAHvy4ArS2vgsu0XLE3heUeVrk_mzRjfPszdCg22_xJnuKuKr-A@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] implement microchip,no-tag-protocol flag
To: Vladimir Oltean <olteanv@gmail.com>
Cc: devicetree@vger.kernel.org, woojung.huh@microchip.com, 
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, o.rempel@pengutronix.de, 
	Pieter Van Trappen <pieter.van.trappen@cern.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 01, 2024 at 15:44, Vladimir Oltean <olteanv@gmail.com> wrote:
>
> Hi Pieter,
>
> On Thu, Aug 01, 2024 at 02:31:41PM +0200, vtpieter@gmail.com wrote:
> > From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> >
> > Add and implement microchip,no-tag-protocol flag to allow disabling
> > the switch' tagging protocol. For cases where the CPU MAC does not
> > support MTU size > 1500 such as the Zynq GEM.
> >
> > This code was tested with a KSZ8794 chip.
> >
> > Pieter Van Trappen (2):
> >   dt-bindings: net: dsa: microchip: add microchip,no-tag-protocol flag
> >   net: dsa: microchip: implement microchip,no-tag-protocol flag
> >
> >  .../devicetree/bindings/net/dsa/microchip,ksz.yaml    |  5 +++++
> >  drivers/net/dsa/microchip/ksz8795.c                   |  2 +-
> >  drivers/net/dsa/microchip/ksz9477.c                   |  2 +-
> >  drivers/net/dsa/microchip/ksz_common.c                | 11 ++++++++---
> >  drivers/net/dsa/microchip/ksz_common.h                |  1 +
> >  drivers/net/dsa/microchip/lan937x_main.c              |  2 +-
> >  6 files changed, 17 insertions(+), 6 deletions(-)
> >
> >
> > base-commit: 0a658d088cc63745528cf0ec8a2c2df0f37742d9
> > --
> > 2.43.0
>
> Please use ./scripts/get_maintainer.pl when generating the To: and Cc: fields.
>
> Not to say that they don't exist, but I have never seen a NIC where MTU=1500
> is the absolute hard upper limit. How seriously did you study this before
> determining that it is impossible to raise that? We're talking about one
> byte for the tail tag, FWIW.
>
> There are also alternative paths to explore, like reducing the DSA user ports
> MTU to 1499. This is currently not done when dev_set_mtu() fails on the conduit,
> because Andrew said in the past it's likelier that the conduit is coded
> to accept up to 1500 but will still work for small oversized packets.
>
> Disabling DSA tagging is a very heavy hammer, because it cuts off a whole lot
> of functionality (the driver should no longer accept PTP hwtimestamping ioctls,
> etc), so the patch set gets this tag from me currently, due to very shallow
> justification:
>
> Nacked-by: Vladimir Oltean <olteanv@gmail.com>
>
> Please carry it forward if you choose to resubmit.

Hi Vladimir,

I do understand your reservation for this path, it defeats most of the
advantages
of DSA but I still do need the driver to handle the PHYs over SPI and for the
WoL functionality; using the switch in a bridge configuration. My reason for
mainlining is that I though there might be more people like me in a
similar situation.

This is actually an older issue and solution of mine so inspired by your comment
I revisited the documentation and indeed hardware-wise I can't find back the
MTU limitation. I see now that it's actually a limitation of the macb driver [1]
so I will try to rework this one instead. Or implement `dsa-tag-protocol` as you
propose. Or event better, both!

Patch can be thus be cancelled, sorry for the spam.

Cheers, Pieter

[1]: https://elixir.bootlin.com/linux/v6.11-rc1/source/drivers/net/ethernet/cadence/macb_main.c#L5127

