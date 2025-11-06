Return-Path: <netdev+bounces-236159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7CEC38ED1
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 03:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638DD1A2219C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 02:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD6D2139C9;
	Thu,  6 Nov 2025 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syueqX9j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA645038
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397822; cv=none; b=FWZUQfaGH4HEYNW9SKd236BkqdxelWmIwioIwCdgnvS4zJJlCdkA+N/ACTMouIAc/jBKrvOcSM6yOAz37LUsnxi85Gf76OhW5Um68bRzBrjtxIfKh/6fUjysapDRw/INlf0K/liq2E3+e/rLoMuNlB6yeR1pYP8a0CtwG+g5zNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397822; c=relaxed/simple;
	bh=KO0HgacN+wrz+fcQ05+6ChuZEjppxP+jsu1mXG+XNFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcXSLaATk3RD81PFiF/2qPhIocw4sZ8sHoV/y8LIa6FYNStiBjpDKLv7Ybeu/mSq/4wZ2YQoDQHVmd4Q+N90hEMUXJmQG3ztBL6vXbPVGtbyeu2yK+9Moe03OlrT9Zv1pr4XxVJbAYZT8yQ3q+PAGnu9LNr7bOhfuoYjUsB1nhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syueqX9j; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5942f46ad87so4569e87.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 18:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762397819; x=1763002619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrosdiVf/Gz+H710qexMyPsQSNuuRWVYFgyQNahREeM=;
        b=syueqX9jg5+bQkO575UINH0yhASlWlo6uWnml6DtRqLt2CeAIsWB43wjXGTkAGMA4C
         zAW7WjqfJcPGoxrGIlbUDV/C16WxcW599vAa6TeLyCPzmjv6QKlnyu7QuSgYpYDW/QSB
         OR5uK4w0dY9VDPKWA+jhp9xo0NR7EOH86LbUZzsKfg62kvpHTzX3YhYC5aWgStsnBrtA
         ZxIIA0xavjhgpRbBFOaAjMB58+82rlEFrL/hUvV1SkaVj5pie1yqAfyPpaCcmJvxQUXl
         5zVWBI0xVs8hjUXE2qkk4fNTLLmkl0utlGfPuwWT3GvibonPfYfQbEWozLChio3k+rkf
         psBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762397819; x=1763002619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RrosdiVf/Gz+H710qexMyPsQSNuuRWVYFgyQNahREeM=;
        b=Rhjj7xocMY2pbTkdZJw9rQg9z0czmodmCS+2UgEhv8D+XqaSFOHku/Crtm/Gqp9eTc
         ZiQZKRr9bE2QJn5G3R1D/aJElRfgGxjlf1BTSFpTl3+RntwMKXsAF745SrbFSgQcCLjD
         yh7eW/QRu2eKrlbhUFjSjSgCqjwChDpuc73SIgFTRD22Zvxo9qLl+Z7vSTTSAjbTlcdC
         Po1441qu3AmvKkqk+SJ5C2N/aCksMBk/w9ck8p+QqTc6Zz0HjEAhsIVOKut66pe/U8AI
         badAosGP/euAxvdEY6ayGIMWrnVppbYMNZub2Nb8qcfSEj7xFwK0gRMKEEyc/lIghyec
         Z6Kw==
X-Gm-Message-State: AOJu0Ywiftf54MSkXcNgs8ofsgJcFC239bLEVMEm6r0DJfMUTwCxnQkN
	gNKykP4hAyvYo+6bDtmtgGZcGh3PwS3J29Igr5zcHEu1ZmKJkzys4pndodn7xj4y2RkMWORF8p1
	p/8sra01tcFjS8QOptAcVJobzQ6uiQP/ROrWUM21N
X-Gm-Gg: ASbGncvkXwDNpubBa2ZlRZwHMS2hbALhHAOloXqjMzVwgct8ZgTxVu5+cDB/5ZhBISm
	02L3E85hK3yujXPwOKQZUY6K1ji92yI8MkTmq2KmvdxTCqyl8dMrloIO6ZWayAzNCZUMQQcZYyH
	rko3vTs+a7EDNevek1xUN1Lahw3PLZL7T33I+q98QqWRhAT79h+ZaN5ijSdR0572k2JCUbWif+c
	N3wxft9pcrKaDdiX1YZj6HRePwIjnwUsYVyPWHb7oKA3Xptrj2rIZEuKQRGk9PJAuYRRQc=
X-Google-Smtp-Source: AGHT+IFr/UGg5sBN9bVdMzHc8NnT+HD6hpWKoyRn41p3xvts5bvpnTlNiGZ55tFzBm2vf10TY9Z5X0KwQqcwCDMEgnA=
X-Received: by 2002:ac2:5f58:0:b0:594:33c3:e724 with SMTP id
 2adb3069b0e04-5944c848b73mr77501e87.5.1762397818874; Wed, 05 Nov 2025
 18:56:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105200801.178381-1-almasrymina@google.com>
 <20251105200801.178381-2-almasrymina@google.com> <20251105171142.13095017@kernel.org>
 <CAHS8izNg63A9W5GkGVgy0_v1U6_rPgCj1zu2_5QnUKcR9eTGFg@mail.gmail.com> <20251105182210.7630c19e@kernel.org>
In-Reply-To: <20251105182210.7630c19e@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Nov 2025 18:56:46 -0800
X-Gm-Features: AWmQ_bmIDWMz3eePaZmq1cVMbHZCO4uFMn3om9Yopbzoff0vbmiyvxl0GNzxoMk
Message-ID: <CAHS8izP0y1t4LU3nBj4h=3zw126dMtMNHUiXASuqDNyVuyhFYQ@mail.gmail.com>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC page_pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, 
	Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 5 Nov 2025 17:56:10 -0800 Mina Almasry wrote:
> > On Wed, Nov 5, 2025 at 5:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > > On Wed,  5 Nov 2025 20:07:58 +0000 Mina Almasry wrote:
> > > > NCCL workloads with NCCL_P2P_PXN_LEVEL=3D2 or 1 are very slow with =
the
> > > > current gve devmem tcp configuration.
> > >
> > > Hardcoding the ring size because some other attribute makes you think
> > > that a specific application is running is rather unclean IMO..
> >
> > I did not see it this way tbh. I am thinking for devmem tcp to be as
> > robust as possible to the burstiness of frag frees, we need a bit of a
> > generous ring size. The specific application I'm referring to is just
> > an example of how this could happen.
> >
> > I was thinking maybe binding->dma_buf->size / net_iov_size (so that
> > the ring is large enough to hold every single netmem if need be) would
> > be the upper bound, but in practice increasing to the current max
> > allowed was good enough, so I'm trying that.
>
> Increasing cache sizes to the max seems very hacky at best.
> The underlying implementation uses genpool and doesn't even
> bother to do batching.
>

OK, my bad. I tried to think through downsides of arbitrarily
increasing the ring size in a ZC scenario where the underlying memory
is pre-pinned and allocated anyway, and I couldn't think of any, but I
won't argue the point any further.

> > > Do you want me to respin the per-ring config series? Or you can take =
it over.
> > > IDK where the buffer size config is after recent discussion but IIUC
> > > it will not drag in my config infra so it shouldn't conflict.
> >
> > You mean this one? "[RFC net-next 00/22] net: per-queue rx-buf-len
> > configuration"
> >
> > I don't see the connection between rx-buf-len and the ring size,
> > unless you're thinking about some netlink-configurable way to
> > configure the pp->ring size?
>
> The latter. We usually have the opposite problem - drivers configure
> the cache way too large for any practical production needs and waste
> memory.
>

Sounds good, does this sound like roughly what we're looking for here?
I'm thinking configuring pp->ring size could be simpler than
rx-buf-len because it's really all used by core, so maybe not
something we need to bubble all the way down to the driver, so
something like:

- We add a new field, netdev_rx_queue[->mp_params?]->pp_ring_size.
- We add a netlink api to configure the above.
- When a pp is being created, we check
netdev_rx_queue[->mp_params]->pp_ring_size, if it's set, then it
overrides the driver-provided value.

Does that make sense? I don't immediately see why the driver needs to
be told the pp_ring_size via the queue API, as it's really needed by
the pp anyway, no? Or am I missing something?

--=20
Thanks,
Mina

