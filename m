Return-Path: <netdev+bounces-149523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F899E60E5
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 23:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3D916690C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 22:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFD51BE23F;
	Thu,  5 Dec 2024 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5OSApLm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2462219D8B2
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733439172; cv=none; b=kZ8mrAKMqf7qvTMzCcL0p/8JzD0+zAvINX470V/cvaXc4J88TbLG1VHMV1tw4irWPcfmCbf4A3hp7Gc0kNDaLeKSARb3C32Dl6krFp7tQO3z8UZXCHOFO6KWWeZd/rpkiENNlr/ylpj7gexHnQhHUtrK3+bJzVyu0xvGdo3bNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733439172; c=relaxed/simple;
	bh=lBKi3rxM7L9VihWKyR23zClC1vYTdnJy2roPvoqoaEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQVG17eXUNRi77K2Gk+efBwZq8IyWI0rfCY5BPQeSBZDqENfD6FwKj22XFrxYPXhJnOvNE3AfxxpnASe4OAbetFvaPWc7vtJiWKSshuR7v0sZKANgN8xDA1mPWIoUVwf2EZ2/YLYbrV/SyW2PrrD/VydSb6R5Tpg8ey3TnURxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5OSApLm; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso21173266b.2
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 14:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733439169; x=1734043969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyiiC9pG3fMcRyC8ivW97VdIFAzNagQwSt9V5VWnf8M=;
        b=g5OSApLmUc3rk+oEwXNFaEEChIR03Q97kUn/KD/wt9na9hic+STBEG+l5oHRffiR7x
         6plfZAV41kKPLC2R1K3obO3RlOaB2K+RQp/rxbDiOapgIVS0yasJYrb2SSn1qLR6ojWz
         tjyvAK/a3GRNMFjFO71BOvNy7uUYe9zt5562azeadROW4Jh+0y8XSg/PXm6Np/tP01g+
         5ZDm7suthV/LkrEx2N+VJFEXgxwT0weMCLb13D8Z9krW3SQIMblc4QlPgeu+OwatEoOe
         u+foEFWclqRgkEce2NEQAqkDbMWpdsTYn8qh52xHuJQATo2vlmdwUU66kChKbrPSkLRD
         SINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733439169; x=1734043969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyiiC9pG3fMcRyC8ivW97VdIFAzNagQwSt9V5VWnf8M=;
        b=QvcZFjmpnQXNYsoF3QP8WiomB8agR/5Qd1dCOwgfAt0SWYizeb1kD/gncOiLSiqiz8
         HR5POos6Z7br87rkPB3iqRPjCRZDogn5Oz31FjSC2Tyej+hN8q9aqVYy4y/0J/Ao1AJu
         INIjAbp21/JJ6g+pMQ5VwhfyLBUuUjrs/7FyS/2tu9iErXbaKTPGdgbptV/OKqH4IXNB
         yAp2ozbXk5W9hMQfTK1+lHpLHNzwX1O++I/ghr8UJYp8Cc5mIiBDTa/FHDmdw7IfwVkh
         LUTxI0mHB9pFiBgg04WMRRYCIncsLWvXXu0fPBYkxZqHUWjZvcb0Y1SI5HLY8sksc3aS
         vQHw==
X-Forwarded-Encrypted: i=1; AJvYcCXBReTQ1+0lntRcF2Z+L3LGJr9x7Izw8FtlGEstDrvd0IaDrpdDYZz9a7KV0c/A3AMefxk0HmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqK1cdcpkmAHzgKHSNmVyK/6L8OvuoJzao85slO1r4a2OGBypm
	ADXd/da207f9J7oWDrpqpyMsQMgp5MuYT914MEVXEEKrCZ9ai5NL1qbi2SlaeXjXTdTgIrKTYFq
	KJJQ0z2CZp5peGbq6A9tmIjqKzhOHu4n4Z8f3
X-Gm-Gg: ASbGnct8Bmuer0Kux8VwlWaPhP/LgUmS85KbKWw1SeWosHy4geMWnILuq1ivRW0V8Bj
	V7Z82qXeuwUw1aE7GujxlH/uH7j0Q8Q==
X-Google-Smtp-Source: AGHT+IEE4aw96bOOvWXOvBW9ggOnPMG9JbHbcNjivkILYkYq8NO7yGHTdK+Gqj3GbSp+dhVRJoRCuU5tltr5+RdH4Zc=
X-Received: by 2002:a17:906:310d:b0:aa6:2ff8:d62d with SMTP id
 a640c23a62f3a-aa63a2419ccmr45641266b.45.1733439169347; Thu, 05 Dec 2024
 14:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221254.3537932-1-sbrivio@redhat.com> <20241204221254.3537932-3-sbrivio@redhat.com>
 <CANn89i+iULeqTO2GrTCDZEOKPmU_18zwRxG6-P1XoqhP_j1p3A@mail.gmail.com> <Z1Ip9Ij8_JpoFu8c@zatzit>
In-Reply-To: <Z1Ip9Ij8_JpoFu8c@zatzit>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Dec 2024 23:52:38 +0100
Message-ID: <CANn89i+PCsOHvd02nvM0oRjAXxPTgX6V1Y1-xfRL_43Ew9=H=w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] datagram, udp: Set local address and rehash
 socket atomically against lookup
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Stefano Brivio <sbrivio@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Mike Manning <mvrmanning@gmail.com>, Paul Holzinger <pholzing@redhat.com>, 
	Philo Lu <lulie@linux.alibaba.com>, Cambda Zhu <cambda@linux.alibaba.com>, 
	Fred Chen <fred.cc@alibaba-inc.com>, Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 11:32=E2=80=AFPM David Gibson
<david@gibson.dropbear.id.au> wrote:
>
> On Thu, Dec 05, 2024 at 05:35:52PM +0100, Eric Dumazet wrote:
> > On Wed, Dec 4, 2024 at 11:12=E2=80=AFPM Stefano Brivio <sbrivio@redhat.=
com> wrote:
> [snip]
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index 6a01905d379f..8490408f6009 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -639,18 +639,21 @@ struct sock *__udp4_lib_lookup(const struct net=
 *net, __be32 saddr,
> > >                 int sdif, struct udp_table *udptable, struct sk_buff =
*skb)
> > >  {
> > >         unsigned short hnum =3D ntohs(dport);
> > > -       struct udp_hslot *hslot2;
> > > +       struct udp_hslot *hslot, *hslot2;
> > >         struct sock *result, *sk;
> > >         unsigned int hash2;
> > >
> > > +       hslot =3D udp_hashslot(udptable, net, hnum);
> > > +       spin_lock_bh(&hslot->lock);
> >
> > This is not acceptable.
> > UDP is best effort, packets can be dropped.
> > Please fix user application expectations.
>
> The packets aren't merely dropped, they're rejected with an ICMP Port
> Unreachable.

We made UDP stack scalable with RCU, it took years of work.

And this patch is bringing back the UDP stack to horrible performance
from more than a decade ago.
Everybody will go back to DPDK.

I am pretty certain this can be solved without using a spinlock in the
fast path.

Think about UDP DNS/QUIC servers, using SO_REUSEPORT and receiving
10,000,000 packets per second....

Changing source address on an UDP socket is highly unusual, we are not
going to slow down UDP for this case.

Application could instead open another socket, and would probably work
on old linux versions.

If the regression was recent, this would be considered as a normal regressi=
on,
but apparently nobody noticed for 10 years. This should be saying something=
...

