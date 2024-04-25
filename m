Return-Path: <netdev+bounces-91473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 725428B2B41
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 23:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34CA1F21440
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 21:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BADE2773C;
	Thu, 25 Apr 2024 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E/QJxbgO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B1520DFF
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081696; cv=none; b=nWw8FpDfHSh5WcZ91n/ibTn29su2kd3WkRX6E6OFRelC6vWPx3hJC/ZebIGWBH94YRuagoOHYbgZlRpEeDdX0fZu8HzSQ1i+zO7tp4F5C3WbT9Q+yTCTddhL6RA4yc+onL4nUDo4IBxx+J4BWInchNaR6Ul1ToNbg3UxIkABQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081696; c=relaxed/simple;
	bh=HJg0cGhpBNZi9fVDLR0DXpRwaOUMbDJZc6PmILsq55o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiNFtdp4xOMYcRWmEyu+Q3MvQyh4/dYRbTZ2k3rEGPuPadvMLw2R6IRVqvzpW/NW+6xuexfgJn98VhlDcbXLYHCeZIc9PCDSkgX6TFDhvdp1lGvI3td2LjiHvYHRZn78PoUfj85uZXtIJa1HOBhl4dvFSxrooQCXjRb7LdSwhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E/QJxbgO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-618769020bcso16723527b3.3
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714081693; x=1714686493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yd8C63tt6stlpov3/fL8YKfcsYUe9baS0DiJGEcUnjI=;
        b=E/QJxbgOiJNFpYWdb5UcHBXLqDKzyUVaCM9vW+O0d2dWlmoOIl4a1FEKNxe/Cm/db8
         LFjdCwwqhvdtiBMrQ4jo8pdb4wgffWrOL5e/sOCAp4u7TCQhFMDZD5mmE8z+wsXCMN8x
         fW+oA9O4iThHatImhzPN9lVLGL7FfacVFRDt2QwXSyComG5lYjUzvNtxsR9QeaKYmJZE
         ea7yELGEtxNiU0Zd2ct3v4FRcGFM064OkKTt5fPxvAAmAVVZqQQMS0AUzNtoCxamdnvV
         xutoQ4EKJGcuU8zj5PITYuMyGo/Tt59ZqWFI/uVIg4OoOFLF2Hvhq23t6VA0tWtUbFnv
         4c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714081693; x=1714686493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yd8C63tt6stlpov3/fL8YKfcsYUe9baS0DiJGEcUnjI=;
        b=NO+mXH9N+pUu+NAWhx3c5AEKkxbHuiOBJjrCBJv8g1Cjum/BNN0LcYP6oIPSmdTxis
         IDzseh3YQaXnflXTTzZqGrJtDh2gPVIj2EXNRGn8CdNc39N+/nD1evA5rlamgK4FqL87
         bRRWTcY0yPfScIBcIlP8bzhiXbfav5catRzyowdlTjqidJ7Z7I1I8oYjMnN2NQPUSnx3
         LA8XYCIMQ4ZEevTygL+fEJvrGVDj3UZtl/hCVEIXuOwuQTiXi8TMZ38xfObKSoVlhzMx
         ni/Hy+8tKO3ZVB5HQ4F4A7+cebs8MrljdaF4WbHdHzPnUfe2PhKmGwlXfIkgLvAafYkD
         3B3Q==
X-Gm-Message-State: AOJu0YwEKqfnhHkhU8Lf++uqbv5cs91hH40a4Sll/hb+HFErYNKff6eB
	NIHrzRFUvkXlDQCl2qxsTM4I3vYGfH2JgNc8jNywIBRhSh0pg+FI9ZwtlUu0/1AQo+QwFOQ09Ta
	L5xmRDgY5uiPQyqAaG24SBbkuKwkA8aEzowwI
X-Google-Smtp-Source: AGHT+IHf4OpEW7qGGSsxWPSm0VhLu2xaGbfnSvi2TOrrqAHZ7xdUrh68WndEoVMVBmlMwIWaBdLhbEreZTvnIgeH1+w=
X-Received: by 2002:a05:690c:6105:b0:61b:1b51:371f with SMTP id
 hi5-20020a05690c610500b0061b1b51371fmr997604ywb.12.1714081693285; Thu, 25 Apr
 2024 14:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416152913.1527166-3-omosnace@redhat.com> <085faf37b4728d7c11b05f204b0d9ad6@paul-moore.com>
 <CAFqZXNvm6T9pdWmExgmuODaNupMu3zSfYyb0gebn5AwmJ+86oQ@mail.gmail.com>
In-Reply-To: <CAFqZXNvm6T9pdWmExgmuODaNupMu3zSfYyb0gebn5AwmJ+86oQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Apr 2024 17:48:02 -0400
Message-ID: <CAHC9VhTxhcSDfYCK95UsuZixMSRNFtTGkDvBWjpagHw6328PMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 9:03=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Tue, Apr 16, 2024 at 8:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Apr 16, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > As the comment in this function says, the code currently just clears =
the
> > > CIPSO part with IPOPT_NOP, rather than removing it completely and
> > > trimming the packet. This is inconsistent with the other
> > > cipso_v4_*_delattr() functions and with CALIPSO (IPv6).
> >
> > This sentence above implies an equality in handling between those three
> > cases that doesn't exist.  IPv6 has a radically different approach to
> > IP options, comparisions between the two aren't really valid.
>
> I don't think it's that radically different.

They are very different in my mind.  The IPv4 vs IPv6 option format
and handling should be fairly obvious and I'm sure there are plenty of
things written that describe the differences and motivations in
excruciating detail so I'm not going to bother trying to do that here;
as usual, Google is your friend.  I will admit that the skbuff vs
socket-based labeling differences are a bit more subtle, but I believe
if you look at how the packets are labeled in the two approaches as
well as how they are managed and hooked into the LSMs you will start
to get a better idea.  If that doesn't convince you that these three
cases are significantly different, I'm not sure what else I can say
other than we have a difference of opinion.  Regardless, I stand by my
original comment that I don't like the text you chose and would like
you to remove or change it.

> > > Implement the proper option removal to make it consistent and produci=
ng
> > > more optimal IP packets when there are CIPSO options set.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  net/ipv4/cipso_ipv4.c | 89 ++++++++++++++++++++++++++++-------------=
--
> > >  1 file changed, 59 insertions(+), 30 deletions(-)
> >
> > Outside of the SELinux test suite, what testing have you done when you
> > have a Linux box forwarding between a CIPSO network segment and an
> > unlabeled segment?  I'm specifically interested in stream based protoco=
ls
> > such as TCP.  Also, do the rest of the netfilter callbacks handle it ok=
ay
> > if the skb changes size in one of the callbacks?  Granted it has been
> > *years* since this code was written (decades?), but if I recall
> > correctly, at the time it was a big no-no to change the skb size in a
> > netfilter callback.
>
> I didn't test that, TBH. But all of cipso_v4_skbuff_setattr(),
> calipso_skbuff_setattr(), and calipso_skbuff_delattr() already do
> skb_push()/skb_pull(), so they would all be broken if that is (still?)
> true. And this new cipso_v4_skbuff_delattr() doesn't do anything
> w.r.t. the skb and the IP header that those wouldn't do already.

Fair point on skbuff size changes in netfilter and
cipso_v4_skbuff_setattr(), that wasn't part of the original
NetLabel/CIPSO support and I forgot about that aspect.  On the other
hand, I believe cipso_v4_skbuff_delattr() was part of the original
work and used the NOOP hack both to preserve the packet length in the
netfilter chain and to help ensure a consistent IP header overhead on
both sides of a forwarding CIPSO<->unlabeled labeling/access control
system.  Which brings me around to the reason why I asked about
testing; I think we need to confirm that nothing bad happens to
bidirectional stream-based connections, e.g. TCP, when crossing over a
CIPSO/unlabeled network boundary and the IP overhead changes.  It's
probably okay, but I would like to see that you've tested it with a
couple different client OSes and everything works as expected.

> [...]
> > > @@ -2246,7 +2253,8 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb=
,
> > >   */
> > >  int cipso_v4_skbuff_delattr(struct sk_buff *skb)
> > >  {
> > > -     int ret_val;
> > > +     int ret_val, cipso_len, hdr_len_actual, new_hdr_len_actual, new=
_hdr_len,
> > > +         hdr_len_delta;
> >
> > Please keep line lengths under 80-chars whenever possible.  I know Linu=
s
> > relaxed that requirement a while ago, but I still find the 80-char limi=
t
> > to be a positive thing.
>
> I believe the line is exactly 80 characters, so still within the
> limit. Or is it < 80 instead of <=3D 80? Does it really matter?

I thought I saw it wrap on my terminal when reviewing the code, maybe
it was just the newlink wrapping that I saw.  As long as it is <=3D 80
I'm okay with it.

> >
> > >       struct iphdr *iph;
> > >       struct ip_options *opt =3D &IPCB(skb)->opt;
> > >       unsigned char *cipso_ptr;
> > > @@ -2259,16 +2267,37 @@ int cipso_v4_skbuff_delattr(struct sk_buff *s=
kb)
> > >       if (ret_val < 0)
> > >               return ret_val;
> > >
> > > -     /* the easiest thing to do is just replace the cipso option wit=
h noop
> > > -      * options since we don't change the size of the packet, althou=
gh we
> > > -      * still need to recalculate the checksum */
> >
> > Unless you can guarantee that the length change isn't going to have
> > any adverse effects (even then I would want to know why you are so
> > confident), I'd feel a lot more comfortable sticking with a
> > preserve-the-size-and-fill approach.  If you want to change that from
> > _NOP to _END, I'd be okay with that.
> >
> > (and if you are talking to who I think you are talking to, I'm guessing
> > the _NOP to _END swap would likely solve their problem)
>
> So, to reveal all the cards, the issue that has prompted me to send
> this patch is that a user may have a router configured to drop packets
> containing any IP options [1][2] and may expect a Linux host with
> NetLabel configured as unlabeled for a target IP address to
> output/forward packets without IP options if CIPSO was the only option
> present before NetLabel processing (such that it can then pass through
> the strict router(s)).
>
> Padding with IPOPT_END *might* solve this particular case, but I'm not
> sure if the routers would really interpret such padding as "no
> options"... I'll try to ask the reporter to test such a patch and
> we'll see. But still, I don't yet see a convincing reason to not go
> all the way and make sure we send optimally-sized packets here.

I'm about 99.5% certain we are talking about the same reporter,
although I was missing the detail about an intermediate
switching/routing node; the problem report I saw was that there was
simply a black-box device on the network that was dropping packets due
to the presence of NOOP options.  IMO, the original RFCs are a little
too vague in this area, but it doesn't really matter if an
intermediate node is dropping the packets.

> Side note: We could only clear CIPSO with IPOPT_END if it's the last
> option in the header ...

Obviously, I kinda assumed anyone following along would understand that.

> ... but that limitation doesn't really matter for
> the use case described above.

--=20
paul-moore.com

