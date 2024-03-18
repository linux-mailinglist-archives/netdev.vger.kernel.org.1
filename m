Return-Path: <netdev+bounces-80480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C4D87F09B
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 20:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9331280A07
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 19:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F4E56B83;
	Mon, 18 Mar 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmuaCjLS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881B56B65
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791684; cv=none; b=GR+kdfk1G2i2Rei2Xszqzb1PFYHGl4jCHicrBcl/wF26TI1VCQIdhQrg+LKeGaDI6D+1s81DUqmCeiTBqkNctcIu0X2oQMXVYuwqEVXAeO7BwGGoBFosY5wPG5flfLAPEQjtENs/rsE8nOaHhP1dSVdmNNVNqx+IBnqUCzWLnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791684; c=relaxed/simple;
	bh=5VzSmo007GQo1t98L9QoSRB18oANuzQ8I7+cIGAdelw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qp33shL1tu/nQd8DDg2AAY9oK+hCeQLen+dXpCX5+Xj1eFmjOt6qaaJByj8Hx9SyKs6mixAs6A4WgoAjWdaBsqL3BskDkKVDJjRjqh8fSSETFLSKWPGth5WJaABRLg+0a19zh3H6E8IXfuj09+E7iD83pN7F+JJDa9V8D4Z07yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmuaCjLS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so2935507a12.1
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 12:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710791682; x=1711396482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DD9ukHFC+EnbEjSznn7aj/QlpQIPVVu5nUrTvmSyTKo=;
        b=TmuaCjLSGJeDSgBjiexXoZYyidabLWI8+Cbob7q/AA/n8Zuu8Wl2DnaZDwFepW2vii
         rw6vJyWFnTtMl0aMyQfjC20Qdf0FGpzTQiomhTK/KRNoD8PY92mf1nTWV3+aQXC+Sz0H
         VgNuF+On/Pkzrc4Gyb7dDTmDHNfaGrCbR9uiuhNsLkuAB9BBd3hodTO/y5lauBFgahsO
         yY4rN5baRkOdvDMVXlexZ7o7uyGjwUGY58drG9IuP3+CDgjrmM+jj+ziFgM5cffkoHHU
         Fa4rj+F83v1hFTAYuPqqiZy2tTyxDYHgy7wOAbaTYEQLiV1PjBA/0qTQBDrKY3oNPtgf
         362w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710791682; x=1711396482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DD9ukHFC+EnbEjSznn7aj/QlpQIPVVu5nUrTvmSyTKo=;
        b=c/x0icw/3HfFAbWwSijHjJXW4X3kP4lL/fSOjw6u8haFHIy6QG04LjK8tjslZ/q5VH
         EkqB7DHWWpT/EUoXS69qtXUOu7f8cFKP9/IxKX33D/wJYL9113tHHIaoXwYqBKTbAQkT
         R6LiKtHsG0uWgSez+JnY/mT+JCMt6WzlsdrcdOFcE42vcRokdxlwDy67j+6dLZ8JzqpQ
         HcPy2RBgUlTRvwmvYTCgXDN2OO2NczDPLgta9HAuHiWi/25jcm8QCmoQk1qvXaFuTBWY
         lFfioj+9pGhtWblz6ye/HvR+7xuMaRpyXWqz3+1wAZZGTBnpG/WgICGq+ox+tJK6mDfy
         gz8w==
X-Forwarded-Encrypted: i=1; AJvYcCWyvkPVEwr6mi6Zem8Ridt2/yLNXOuUUlZ3RIz2fi7V7GNQr/cUhrJp/8T1A85rTGPvdi6AhnLkNAbzI0uIzgDrWS8s8JyG
X-Gm-Message-State: AOJu0YzBxzBDtZhP+u/yc3RXJJiKBiBZsVTTCKX6R2PNrpUVmR5qKa/6
	DJNSuoPaLr0To8m3tILawL3T+q86nKfNZ6+ennjak5/vkYb4BvBY3rdibUPBNSHn840BRK7NnTr
	GSmtza5ILuDdeHmvgzbq8x27ssw==
X-Google-Smtp-Source: AGHT+IEXZwNALPKDfXMZ+gyhwSHD3p7T5lBBN1GwEWl9ZiWjRWytWS9ydwFpYdAHVcTC3i3IqYEl0i6P1ueYhG7RldU=
X-Received: by 2002:a17:90a:b016:b0:29c:5ba3:890e with SMTP id
 x22-20020a17090ab01600b0029c5ba3890emr646084pjq.4.1710791682427; Mon, 18 Mar
 2024 12:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfiWjOWDs2osFAnX@cy-server> <CANn89iKjdynvAddoWrQ-Akm=fQeHD9Ww=rAwfGCmYMDSRk6iJw@mail.gmail.com>
In-Reply-To: <CANn89iKjdynvAddoWrQ-Akm=fQeHD9Ww=rAwfGCmYMDSRk6iJw@mail.gmail.com>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Mon, 18 Mar 2024 14:54:30 -0500
Message-ID: <CALGdzuoBH+3B=9m_Fif7-+auGUsD6CUDqRDMbc2RMHVuhu2XPw@mail.gmail.com>
Subject: Re: [net/sched] Question about possible misuse checksum in tcf_csum_ipv6_icmp()
To: Eric Dumazet <edumazet@google.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, zzjas98@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you very much for your swift response.

> It seems we have proper pskb_may_pull() calls.
I realized that I had overlooked verifying the suitability of the SKB
in this context. Your observation is indeed correct, and I now
understand that this should not present any concerns.

Thank you once again for your valuable feedback.

Best,
Chenyuan

On Mon, Mar 18, 2024 at 2:46=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Mar 18, 2024 at 8:31=E2=80=AFPM Chenyuan Yang <chenyuan0y@gmail.c=
om> wrote:
> >
> > Dear TC subsystem maintainers,
> >
> > We are curious whether the function `tcf_csum_ipv6_icmp()` would have a=
 misuse of `csum_partial()` leading to an out-of-bounds access.
> >
> > The function `tcf_csum_ipv6_icmp` is https://elixir.bootlin.com/linux/v=
6.8/source/net/sched/act_csum.c#L183 and the relevant code is
> > ```
> > static int tcf_csum_ipv6_icmp(struct sk_buff *skb, unsigned int ihl,
> >                               unsigned int ipl)
> > {
> >   ...
> >         ip6h =3D ipv6_hdr(skb);
> >         icmp6h->icmp6_cksum =3D 0;
> >         skb->csum =3D csum_partial(icmp6h, ipl - ihl, 0);
> >         icmp6h->icmp6_cksum =3D csum_ipv6_magic(&ip6h->saddr, &ip6h->da=
ddr,
> >                                               ipl - ihl, IPPROTO_ICMPV6=
,
> >                                               skb->csum);
> >   ...
> > }
> > ```
> >
> > Based on this patch: https://lore.kernel.org/netdev/20240201083817.1277=
4-1-atenart@kernel.org/T/, it seems that the `skb` here for ICMPv6 could be=
 non-linear, and `csum_partial` is not suitable for non-linear SKBs, which =
could lead to an out-of-bound access. The correct approach is to use `skb_c=
hecksum` which properly handles non-linear SKBs.
> >
> > Based on the above information, a possible fix would be
> > ```
> > -       skb->csum =3D csum_partial(icmp6h, ipl - ihl, 0);
> > +       skb->csum =3D skb_checksum(skb, skb_transport_offset(skb), ipl =
- ihl, 0);
> > ```
>
> Why would this code be an issue only in  tcf_csum_ipv6_icmp(), and not
> in other functions ?
>
> It seems we have proper pskb_may_pull() calls.
>
> If you have a syzbot/syzkaller trace, please share it.

