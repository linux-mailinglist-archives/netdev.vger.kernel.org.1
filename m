Return-Path: <netdev+bounces-94952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863DF8C115C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D12928615D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698D631A66;
	Thu,  9 May 2024 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FACGXN/A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744A15AF1
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265525; cv=none; b=lZwrSnvkEc53f6y69yo1RuJcPip9fU91FK4jp+5Z0JUDLR169F6s2tde7Q84PUhtip9yXIIgbWL/n+V7awTzH+OkxhFpYvXFdVVIWM53PORpHj4QmJkuvfwu/0kE2J1Uqwk5QKv6mpKUlWa1g0d+afU0r51O5Qepw7nmJiZnn+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265525; c=relaxed/simple;
	bh=PPPjdYb41uc7xIn+uvpRXVu5uZppou/3XJNhZ0cnn6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctWCg0GXdN7Xyn5ML+oG88tuFQBFlk+zeZZQBHQLL7vLwI9H6vS7wb++zoFBh9F7nSqRbN4iELnBxJV8KnUG22oIgnQJPfLRwbYe1/bCRnpaLuvjMVvNCohfwt4XqFFgIobE4sPt2vF3KtAIwCvqpHKj1iMaFktO9/degNSIq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FACGXN/A; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de45385a1b4so849106276.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 07:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715265522; x=1715870322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2hqaVPgf9CmbqrYSPiHKb8A/h9/MLbbdKnirUGyoOI=;
        b=FACGXN/A9kKILgtOSayxwkeNPk5LvMdGTG6QyPdT0D7X6zfls64xPhntkcphb49fhS
         9btf6y5ZdwqRUvi/QOwZay56W7iDgHBRqIrRKchv5x5drMPHtnyJsNqDgl5geryBhU66
         GsfFiHoyb6ZeyX6XRHuf7CCVWFIrlj1sqwm9V+RLApgvqmqeItWelzWIIcX+xBZBruTh
         4Vwjv6YeiZAMA1lLQ135DYtststhtyalg1BRQ+mNEMxaWsuOVJB9rNuY5h8K5FgnNr8k
         EddylJDZN3kqILyLvU+lnZD711tXdGr3oLpzozF2+b5VXwjJscyQI+/JBma1qeiKbTxH
         /YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715265522; x=1715870322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2hqaVPgf9CmbqrYSPiHKb8A/h9/MLbbdKnirUGyoOI=;
        b=tQ/kwgR2te6U9YiBvEgYX5BV0WGsEE5KzV8+CHC2TZcUdqIkaAvfzIKRQrPSX1y287
         gWU4TarDyVXajsWov2tod/KDCvC6cQbzoZoR7zT0n8Rw8U7cNjAnSOG/IgaoI4YLrFHx
         kpVY+QmNcEWNiXkjFjp1mm82e/ilbinCXx9udJMVsdHiMCJhyHsODhDXiAFSPNAK1Qfm
         PS6sV9QElcz6OZ2EyQfla9ycpDbMyNc1dGqjE73iC4sSmYPMeq871G1KXaVYwNds7H9j
         Oujf50EGU67ltWN7RtHLVwg5vq9xfeWBDqp4Kvcktog1G5P85gdeoBQ0DRrslNOpeVm8
         bPgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLQEVUquuFy/95iTABvJg0fl38G+knVxvvGDfeVSDLWRxsVkX3JLD+ACYFdWS4zXUPMgo1Ej3jK/Z8xY7Etv6ivbAoDT9F
X-Gm-Message-State: AOJu0YwbQzIyJc9AghYLE/BHLfjfr7ZqRdRh8rWOp0t13W0fZMLRon+W
	yf+UBxPu/GFSay0ekQhkMi2taheTgcpuLeMIgzpcNSRfNxkuErmfkD/dwude/buerRtnmv1E/o5
	+qumQijSIuCOvYsg2vsHaInQbNJvfML/onabhdg==
X-Google-Smtp-Source: AGHT+IEVnx7xug/dgb3VQgdriK0DzwoDdocU7f75Tv5ChH35g2t7VKHbquf2sXhm8yO4/ru5Dl/qsG5ab9YbksTc6EM=
X-Received: by 2002:a25:a283:0:b0:de5:4ba0:5b61 with SMTP id
 3f1490d57ef6-debb9d6fd17mr5772893276.3.1715265522504; Thu, 09 May 2024
 07:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-gemini-ethernet-fix-tso-v1-0-10cd07b54d1c@linaro.org>
 <20240509-gemini-ethernet-fix-tso-v1-1-10cd07b54d1c@linaro.org> <CANn89iKgi6yEEenSy1M-PVRYWz=Ri9UorV7irCywOZ8xTbNk_A@mail.gmail.com>
In-Reply-To: <CANn89iKgi6yEEenSy1M-PVRYWz=Ri9UorV7irCywOZ8xTbNk_A@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 May 2024 16:38:30 +0200
Message-ID: <CACRpkdYyyQ_=2FmEe7FjDT-2BrhO5GezdXk35werHwBNA=uO=Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: ethernet: cortina: Restore TSO support
To: Eric Dumazet <edumazet@google.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 10:21=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
> On Thu, May 9, 2024 at 9:48=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> >
> > An earlier commit deleted the TSO support in the Cortina Gemini
> > driver because the driver was confusing gso_size and MTU,
> > probably because what the Linux kernel calls "gso_size" was
> > called "MTU" in the datasheet.
> >
> > Restore the functionality properly reading the gso_size from
> > the skbuff.
> >
> > Tested with iperf3, running a server on a different machine
> > and client on the device with the cortina gemini ethernet:
> >
> > Connecting to host 192.168.1.2, port 5201
> > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D1c8a
> > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D1c8a
> > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D27da
> > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D0b92
> > 60008000.ethernet-port eth0: segment offloading mss =3D 05a8 len=3D2bda
> > (...)
> >
> > It also performs well: ~268 MBit/s.
>
> This does not look very good to me ?

Oh it's pretty typical. This is an ARMv4 router from 2007, end-of-lifed
in 2015, and it is not meant to be stressed by the software like
this, the idea is that packets get routed by the DSA switch
(RTL8366RB).

> What number do you have when/if TSO is turned off ?

Around 187 MBit/s.

> > +       /* Translate to link layer size */
> > +       mss +=3D ETH_HLEN;
> > +       if (skb->protocol =3D=3D htons(ETH_P_8021Q))
> > +               mss +=3D VLAN_HLEN;
>
> Are you sure this is needed at all ?
> Why not include IP and TCP header sizes as well, if the datasheet
> mentions 'link layer size' ?

Actually that code is just reusing the mss variable for
skb->len in the case where TSO is not used, so I'll try to
be more elaborate in the code :/

I guess I actually need to account for it if ->gso_size expand
to the MTU of the interface if I bump it up. But I don't
know if the the TSO code actually does this or if it is
more conservative?

> To double check, please disable GRO on the receive side and verify the
> packet sizes with tcpdump.
>
> Typically, for MTU=3D1500, IPv4, and TCP timestamp enabled,
> skb_shinfo(skb)->gso_size is 1448
>
> (Because 20 (ipv4 header) + 32 (tcp header with TS option) + 1448 =3D 150=
0)

I disabled all segment offloading on the receiving side:
ethtool -K enp2s0 gro off gso off tso off

The iperf3 -c generates segmens like in the commit message:
gemini-ethernet-port 60008000.ethernet-port eth0: segment offloading
mss =3D 05a8 len=3D2bda
gemini-ethernet-port 60008000.ethernet-port eth0: segment offloading
mss =3D 05a8 len=3D27da
gemini-ethernet-port 60008000.ethernet-port eth0: segment offloading
mss =3D 05a8 len=3D0b92

And 05a8 is 1448 so it is expected.

tcpdump -e -X enp2s0 gives this on a single segment in a segmented
iperf3 -c transfer:

16:24:09.182095 14:d6:4d:a8:3c:4f (oui Unknown) > fc:34:97:01:a0:c6
(oui Unknown), ethertype IPv4 (0x0800), length 1448: OpenWrt.lan.56624
> Fecusia.targus-getdata1: Flags [.], seq 18664:20046, ack 1, win
4198, options [nop,nop,TS val 2770370491 ecr 3490176978], length 1382
    0x0000:  4500 059a 8ff6 4000 4006 218d c0a8 0188  E.....@.@.!.....
    0x0010:  c0a8 0102 dd30 1451 a701 4f9d e809 8788  .....0.Q..O.....
    0x0020:  8010 1066 0b60 0000 0101 080a a520 7fbb  ...f.`..........
(...)
    0x0580:  de60 2081 5678 4f8b 31b1 6f85 87fe ae63  .`..VxO.1.o....c
    0x0590:  e2ca 8281 fa72 16aa 52e2                 .....r..R.

As can be seen in the header, it is indeed 1448 bytes when arriving
as well, so it seems to work!

Yours,
Linus Walleij

