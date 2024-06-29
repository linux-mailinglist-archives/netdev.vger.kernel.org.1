Return-Path: <netdev+bounces-107913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED64691CFBA
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 01:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727711F22254
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 23:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4E839FD9;
	Sat, 29 Jun 2024 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq3v850U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477D5660
	for <netdev@vger.kernel.org>; Sat, 29 Jun 2024 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719705080; cv=none; b=IrS5auWZ1htdkCzmcH7Vhxo/eroogVq1ntWoVEDaIIZioGsTXLyWvaJyyUZFDcfmtGHPV4U9tanC25D1BUU0UOSZvT62PVDHQwjcStjrGNXpPep2UoB8xcM9k6nFyl7oRJf0g2p20dpUdij9pkrE/zpZZMFCHou1Kd6WAqXhl7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719705080; c=relaxed/simple;
	bh=BF7MxgfHjlWTaJDKr5QG+IE2KTKlfWPFuEDaKCbbYO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuwmJNP0N6Qn0U0dOkIoVOIr0XVJqvIv5sC/ti7gS4R4FvEL7m8UPatC01aNMTqBnGHw5lEq10qeRa0OCbsqirb1olhQvBA0i60t+smv3VmPaISqnKAJ97HRTLPaKNe/AdOnXzFl/5Mx6cnATTMo+TiXGn/kUAQG4q5VRaNtXA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lq3v850U; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-700cc388839so1174752a34.0
        for <netdev@vger.kernel.org>; Sat, 29 Jun 2024 16:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719705077; x=1720309877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8kHgj+wjmDz4/OTkFaTaXvrFil1IoXlCWv1fEj41oc=;
        b=lq3v850U2FDxHFFs50sizuCckKIl2TSACcxoZVucV0jQ8eP5KczMByGvFwlz7qhPVl
         B9+9Btj9UgNqD/hDqx4yWMgBA5DtpLCIKywYIrFk7SRy8ESeVdMB8NHOw5Kwe3dXKOTC
         pO3X7LodVYDatz5BAM21CVdS2aQ+sPzWcULZmRALYJJ31h23CPA9CzEEw6oTAkmzCfNT
         AYYRsJF9u49EWgNmj8Y/k4UbYylAq6MlCX7ro4ufpoaVor8EnrMm0elGylAh436UkVqd
         DZFXC9GSb+QqL2wrC5IpVJXE/NEwcmDUxUp/CPqavdwHG6oM9kFc7Mh7iHom2hb0L4yx
         J9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719705077; x=1720309877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8kHgj+wjmDz4/OTkFaTaXvrFil1IoXlCWv1fEj41oc=;
        b=QNExw7ZLDunvjhXs4jrswvmThx9oR/FcCbbrtd0hGsD4zxr2Z20lm3q+iUmNTsv1gL
         ycU6EC1VcjYsjtbOiu2g52xt6cOsnHalAHx/J2hAyiOaeK/llUP0Y/dsw3TzjyFu9eyN
         jr7+/NYacDBhuQx6b9fww0RiIFCzlarifPKzJoa5lBDxBbT4dbo5g/xnWEClmiFHzYTp
         s5USfMXPtnis1WsUvvgaxUtpNk4tk0TZug7VSoEHHrJ2RJp8zh1rVPA/upjIvWPNS7mg
         Frl+3o9ch/ukHeP9ikfdNjztCl+dKZ5w/hJhTSRk/gFuSW+dhw3T1TqODnGdhZ5UF5zU
         vttg==
X-Gm-Message-State: AOJu0YxJVv8mq+RJL+8wtQMB4L2OFi3jWHudp/vdbxoL7kP0nXBezfl0
	8FK/E0/tOrp1LXbyJ8J6TsReKOSYLZOYXhrS7dsFxraBUcICWHzX9D4/ZBMv4g4O29Y4WSLrLlG
	X+xDszzuMx2hCdQb8kPqXRtKvtfTw4cJDVI0=
X-Google-Smtp-Source: AGHT+IFRi4pLgY3p9xuGb5C93zBWSj7xmvBVgYHlR1HqP9rO0RXq5CEyQABkeIDonFpb7+GTnRRrEAa4FQICbFH7I6c=
X-Received: by 2002:a05:6808:200b:b0:3d6:838b:8286 with SMTP id
 5614622812f47-3d6b2d19c2emr2617178b6e.16.1719705077397; Sat, 29 Jun 2024
 16:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZuGQGM+mNOtD+B=GQJjH3UaoqUkZkoeiKZ+ZD+7FR5ucQ@mail.gmail.com>
 <20240628105343.GA14296@breakpoint.cc> <CAA85sZvo54saR-wrVhQ=LLz7P28tzA-sO3Bg=YuBANZTcY0PpQ@mail.gmail.com>
 <CAA85sZt8V=vL3BUJM3b9KEkK9gNaZ=dU_YZPj6m-CJD4fVQvwg@mail.gmail.com>
 <CAA85sZt1kX6RdmCsEiUabpV0-y_O3a0yku6H7QyCZCOs=7VBQg@mail.gmail.com> <CAA85sZscQ0f1Ew+qugkO6x6cL6OSuPpR1uU2Q6X=cSD2O2yUkA@mail.gmail.com>
In-Reply-To: <CAA85sZscQ0f1Ew+qugkO6x6cL6OSuPpR1uU2Q6X=cSD2O2yUkA@mail.gmail.com>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Sun, 30 Jun 2024 01:51:06 +0200
Message-ID: <CAA85sZu5S1WdJEoDWCEM7dr8CQf32M6S38Gz0TOQ5PpgHbgrig@mail.gmail.com>
Subject: Re: IP oversized ip oacket from - header size should be skipped?
To: Florian Westphal <fw@strlen.de>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So, yeaj, caffeine induced thinking, been reading RFC:s and yes, it's
completely correct that fragment ip headers should be skipped

completely logical as well, what does confuse me though is that i can
get thousands of:
[ 1415.631438] IPv4: Oversized IP packet from <local ip>

I did change to get the size, and
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -474,7 +474,7 @@ static int ip_frag_reasm(struct ipq *qp, struct
sk_buff *skb,
        err =3D -ENOMEM;
        goto out_fail;
 out_oversize:
-       net_info_ratelimited("Oversized IP packet from %pI4\n",
&qp->q.key.v4.saddr);
+       net_info_ratelimited("Oversized IP packet from %pI4 %i >
65535\n", &qp->q.key.v4.saddr, len);
 out_fail:
        __IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
        return err;

Yields:  66260 > 65535

Which is constantly 725 bytes too large, assumed to be ~16 bytes per packet

Checking the calculation quickly becomes beyond me
        /* Determine the position of this fragment. */
        end =3D offset + skb->len - skb_network_offset(skb) - ihl;

Since skb_network_offset(skb) expands to:
(skb->head + skb->network_header) - skb->data

And you go, oh... heck ;)

I just find it weird that localhost can generate a packet (without raw
or xdp) that is oversize, I'll continue checking
(once you've started making a fool of yourself, no reason to stop =3D))

On Fri, Jun 28, 2024 at 3:35=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com>=
 wrote:
>
> So this bug predates 2.6.12-rc2, been digging a bit now... Unless
> gp->len has been pointing to something else weird.
>
> On Fri, Jun 28, 2024 at 1:44=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.co=
m> wrote:
> > On Fri, Jun 28, 2024 at 1:28=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.=
com> wrote:
> > > On Fri, Jun 28, 2024 at 12:55=E2=80=AFPM Ian Kumlien <ian.kumlien@gma=
il.com> wrote:
> > > > On Fri, Jun 28, 2024 at 12:53=E2=80=AFPM Florian Westphal <fw@strle=
n.de> wrote:
> > > > > Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > > > > Hi,
> > > > > >
> > > > > > In net/ipv4/ip_fragment.c line 412:
> > > > > > static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
> > > > > >                          struct sk_buff *prev_tail, struct net_=
device *dev)
> > > > > > {
> > > > > > ...
> > > > > >         len =3D ip_hdrlen(skb) + qp->q.len;
> > > > > >         err =3D -E2BIG;
> > > > > >         if (len > 65535)
> > > > > >                 goto out_oversize;
> > > > > > ....
> > > > > >
> > > > > > We can expand the expression to:
> > > > > > len =3D (ip_hdr(skb)->ihl * 4) + qp->q.len;
> > > > > >
> > > > > > But it's still weird since the definition of q->len is: "total =
length
> > > > > > of the original datagram"
> > > > >
> > > > > AFAICS datagram =3D=3D l4 payload, so adding ihl is correct.
> > > >
> > > > But then it should be added and multiplied by the count of fragment=
s?
> > > > which doesn't make sense to me...
> > > >
> > > > I have a security scanner that generates big packets (looking for
> > > > overflows using nmap nasl) that causes this to happen on send....
> > >
> > > So my thinking is that the packet is 65535 or thereabouts which would
> > > mean 44 segments, 43 would be 1500 bytes while the last one would be
> > > 1035
> > >
> > > To me it seems extremely unlikely that we would hit the limit in the
> > > case of all packets being l4 - but I'll do some more testing
> >
> > So, I realize that i'm not the best at this but I can't get this to fit=
.
> >
> > The 65535 comes from the 16 bit ip total length field, which includes
> > header and data.
> > The minimum length is 20 which would be just the IP header.
> >
> > Now, IF we are comparing to 65535 then it HAS to be the full packet (ie=
 l3)
> >
> > If we are making this comparison with l4 data, then we are not RFC
> > compliant IMHO

