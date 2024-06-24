Return-Path: <netdev+bounces-106232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E81915661
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 20:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242221C20C66
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 18:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCD61A00CE;
	Mon, 24 Jun 2024 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JiMQW0no"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27084503C
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719253063; cv=none; b=BXKorv4k1MF7kD/xXKy40BKD0gasvnv8Hspw26o7Cthz4op5W4nTPl9EFTuCOjbaBjuFIOH3IGZQyZzJaqnyluvgn05Go4CAoocaH+G6ENmNlH5cgWWIIEbk2lZPZwivXn0SBLGgkXBdqwTB8QUeif8KNOajE7z5XkI/FCCsZb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719253063; c=relaxed/simple;
	bh=eS2NBgus2lhrJmMuOApu7qG31qWqdOhq592pTuDCHzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LL4wdjsmQQHySFwLgjglBrULCD1mc3Q5zf7e98Bx9+Gg88ZmQgaYMtMrgrvjdPK9dAdqhoCkjn5KmsH2LphXI1Y0qvWqiHZQDsFFOXGG7/3187L/596IOGbFixgm1GQTm7saFTeVxO/BfIszk97O6QuMpvQfYcjj5iRYAe64yj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JiMQW0no; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a72510ebc3fso195619966b.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719253060; x=1719857860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2a+NCZqg9T2WqRUZ+lmaVYwVwGQsZAgxI0oVQ2Ef2c=;
        b=JiMQW0noKhNGNiC26nCAS1PoCe4H6NTuMR+MG3V11Ozhc7uSqk1xDd9TGMNjO87Ihu
         576Rqr5r7v0wwQjSTtgoAKmeLmzFaMpHa+PGUw57juQviybVhotRFjM7iL97yqN7Jg/0
         TUq6BKZtVUabCg6bqRrAmxoFtCQk0kQfqxLNztQ/7YnLReTgokWA9o1RfOp3ZPiYzeru
         Aov2VdYaNgPvMIbM7mOXlDGlWRCGqY2KvhLenxtSj2IhvY5sK73YRC7WcDBUxJ3WN8lq
         HH2BIJSOOdfd504lgqU/azmPlp/ykGRLfd/dxA7BoWsdT3t8W9MLZtUraFfVzykq7jBa
         yT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719253060; x=1719857860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2a+NCZqg9T2WqRUZ+lmaVYwVwGQsZAgxI0oVQ2Ef2c=;
        b=XpxrAvfMIyvoCveHfBnWEqbxSTWXm9kd2sJRe3bPjOq6CS2sW+FZmAD+oHobZx6zkn
         5CAzbvNx4T8KayDS1SYIRn8HcKaYerU+ut5cmEAaSzuLjep2WSwxyILe9qwyi2xVAXVb
         DW4qAUXLteq3HYTZUuA8CY2QgWLvbzdgQW5/T3vhyINGe2zRu4qq9G2/sf0GMEgsPVlx
         Wv5lphd8MI93xo1c+LO852/AKfy9NuAiBjQoopTO46cSYjao/N4FM8h2R13XzyvO7tFP
         MTzgwSwKARBJG82nvN3jGQYdHy6S0/ZmtTX0//iuQzYiXBh1t8woptxgl1vsUHOOzorS
         bVFA==
X-Gm-Message-State: AOJu0YxdvDVri6YxYRYX3CvOvWWqJvuWrNuU0MzIAnCt5UcXwZ57FF+f
	JlC80yHcjCi1GYX+CVQS0lmAEgkNk1bUM2auDkvX6S2MWz59rDUbyJCRo92djq96xjhpJpyPShO
	Uk0AQH4D2MO1MAMioHURXhvr/pE3oUXPYHzIu72L6p90O8sXR
X-Google-Smtp-Source: AGHT+IFwdzvdf6eoTAzP+XmZu+K0VWtvprAM3USVdpUEkJfziQcuGP2kmcBKy+64YkMnSOHjdD8n+UixgPrLnQVWhIk=
X-Received: by 2002:a17:906:e0c4:b0:a6f:96b0:ed2 with SMTP id
 a640c23a62f3a-a7242c39c5fmr451623566b.30.1719253059793; Mon, 24 Jun 2024
 11:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718919473.git.yan@cloudflare.com> <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
 <66756ed3f2192_2e64f929491@willemb.c.googlers.com.notmuch>
 <CAO3-Pbp8frVM-i6NKkmyNOFrqqW=g58rK8m4vfdWbiSHHdQBsg@mail.gmail.com> <6677dc5cb5cca_33522729474@willemb.c.googlers.com.notmuch>
In-Reply-To: <6677dc5cb5cca_33522729474@willemb.c.googlers.com.notmuch>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 24 Jun 2024 13:17:28 -0500
Message-ID: <CAO3-PbrKRqeA4bCPnv7xkDiUFtuCMfzYZiEur3wM=+x8nc2xpQ@mail.gmail.com>
Subject: Re: [RFC net-next 1/9] skb: introduce gro_disabled bit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Mina Almasry <almasrymina@google.com>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	David Howells <dhowells@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	David Ahern <dsahern@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, 
	Antoine Tenart <atenart@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 3:27=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Yan Zhai wrote:
> > > > -static inline bool netif_elide_gro(const struct net_device *dev)
> > > > +static inline bool netif_elide_gro(const struct sk_buff *skb)
> > > >  {
> > > > -     if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
> > > > +     if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_prog=
)
> > > >               return true;
> > > > +
> > > > +#ifdef CONFIG_SKB_GRO_CONTROL
> > > > +     return skb->gro_disabled;
> > > > +#else
> > > >       return false;
> > > > +#endif
> > >
> > > Yet more branches in the hot path.
> > >
> > > Compile time configurability does not help, as that will be
> > > enabled by distros.
> > >
> > > For a fairly niche use case. Where functionality of GRO already
> > > works. So just a performance for a very rare case at the cost of a
> > > regression in the common case. A small regression perhaps, but death
> > > by a thousand cuts.
> > >
> >
> > I share your concern on operating on this hotpath. Will a
> > static_branch + sysctl make it less aggressive?
>
> That is always a possibility. But we have to use it judiciously,
> cannot add a sysctl for every branch.
>
> I'm still of the opinion that Paolo shared that this seems a lot of
> complexity for a fairly minor performance optimization for a rare
> case.
>
Actually combining the discussion in this thread, I think it would be
more than the corner cases that we encounter. Let me elaborate below.

> > Speaking of
> > performance, I'd hope this can give us more control so we can achieve
> > the best of two worlds: for TCP and some UDP traffic, we can enable
> > GRO, while for some other classes that we know GRO does no good or
> > even harm, let's disable GRO to save more cycles. The key observation
> > is that developers may already know which traffic is blessed by GRO,
> > but lack a way to realize it.
>
> Following up also on Daniel's point on using BPF as GRO engine. Even
> earlier I tried to add an option to selectively enable GRO protocols
> without BPF. Definitely worthwhile to be able to disable GRO handlers
> to reduce attack surface to bad input.
>
I was probably staring too hard at my own things, which is indeed a
corner case. But reducing the attack surface is indeed a good
motivation for this patch. I checked briefly with our DoS team today,
the DoS scenario will definitely benefit from skipping GRO, for
example on SYN/RST floods. XDP is our main weapon to drop attack
traffic today, but it does not always drop 100% of the floods, and
time by time it does need to fall back to iptables due to the delay of
XDP program assembly or the BPF limitation on analyzing the packet. I
did an ad hoc measurement just now on a mostly idle server, with
~1.3Mpps SYN flood concentrated on one CPU and dropped them early in
raw-PREROUTING. w/ GRO this would consume about 35-41% of the CPU
time, while w/o GRO the time dropped to 9-12%. This seems a pretty
significant breath room under heavy attacks.

But I am not sure I understand "BPF as GRO engine" here, it seems to
me that being able to disable GRO by XDP is already good enough. Any
more motivations to do more complex work here?

best
Yan

>
> >
> > best
> > Yan
>
>

