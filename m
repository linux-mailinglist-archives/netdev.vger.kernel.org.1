Return-Path: <netdev+bounces-160249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CDDA18FB8
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FED8188852D
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDB8211461;
	Wed, 22 Jan 2025 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xo9IwH7w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFE221128A
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541773; cv=none; b=HiXv2rjsJWwwRDT/74WUP8MPziroZy8R9RIT+ptpz4IikrLxm6rZ+slrHBqMM4/IgfjWszPV9GhHZuHuxVYlzBIzQ4C9uLyIPR++RaQNUSXrvrpQ5geeWjrjRc4Xq36/GqjYihiENjaso8+qAxdvzb3MOTG9DSaQUrB9KaAWWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541773; c=relaxed/simple;
	bh=86KJUQ5/HFfIquFqVHd9Sx95iDBPZf+KqDj2V+2Bkrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bstZ1mWm2H896HysmAKzcIT+5Hb3+5lDxSmS9TcVe2cOzxmPv0LifMumYILRWSSNKCuW0ALciSZvl57TugEeVeC68Q9CR3IAwFFq4w43ucEOX0MuS7AIDgnkGndSovLGU0eW7p2kBolMMYIL4+uj1lyWm1TNRO8aIj5DkQY7rkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xo9IwH7w; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dbe8e62407so2862204a12.2
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 02:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737541770; x=1738146570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR7GVp/mu5noPNZc8BkqEdtNOqOQREkQIVPGE7T3aHE=;
        b=xo9IwH7wIsXcwT3o2e3DY5S3Rx1TZpxGvlgaRo4hLNsDIqR+WOZwBk0Fj9HEWxQcwW
         rh1Js55yFqb1rVKdQFhxnPvqwhC4OC6995NLaw+vvSs0iT26fMOD+tVKkZOZy0MlLre9
         kly5yoLU0VsK0sIrAEBPuIq31EuQNlGfY23aEmvNCcL0HLgRYR9hH1rg5rL49flK4Ed6
         QveoH+TB8kBlbsNyH+IcJtxUw+xLINsDUmIF9MGfj/K+CHM0n17TVU+PrAqDcdMWWbe9
         7o/gpUztCd3ytdtvozMCE2FBsN8RvH+4BAsmVY7TmWnKx6bf8Y8p5RoAkx8indfDiix1
         WqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737541770; x=1738146570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zR7GVp/mu5noPNZc8BkqEdtNOqOQREkQIVPGE7T3aHE=;
        b=iYUb57S/ZXrzSHm3dl878Ca9xSZ1bryEyBkWGF7/SJk5BVg1KjqWm0W9QqSUtGz1K8
         qfK+8yNlrVGBXzDJcsbmvywd/JhRVfUz2IHeiRNKXzAacbjWB6zitU3uppWlONGy7q+b
         XWxh64SPB90zbCw4UUdjBwpdgzyCdFY1Pl13sOSHGYAqwcoDYtED2timq/pFZ5TPyZHU
         fnlvWGcXMLg8K2j9vOHDSp/sno5Uq6y+R2R/jp2pw7RmRcCwIsxNA8SfO29e4GAa7fQ8
         ueWuVkyqn0D5OPorxn2kNm6Vq9rEnqehbKB3SzAXbrCvDlaO9XUUCZjpCo/vUeWh+o21
         E7Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWFWXoOY7FH7TWrI5JzFiA78Lk28oUojwaroh+oMOeyyr/hdj9RE/qph7+enjZot3sZs+D9xsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1+K933XlIQBfm9qxQAdachuzW6B3W2ZUv52tNyCTyK9Z4Mzua
	X6VybkfneoHV8wPbtaY4Jw4WLdVb+ta3SaquOXxBx8+J7GcJ06ku2QlLZ3ZK16umQ78EVCZv1Wa
	drC6kgYOuTOIFZ8V3ud6SQ9GJ1AiHZb/wqsB7
X-Gm-Gg: ASbGncuFC+FeOjoyjBkjF3l4Os2EtiZo7msmKcMH4nRN5KLRA8Nkd/WqADgUt3MZ0Sq
	JluWJ5ju90l+4he3Mu4YahJsp1x1Junsy3a2SlDCd+096XmJgpQ==
X-Google-Smtp-Source: AGHT+IEaFYiS7TQ3WZPWli2P3Rmkl4eSKPfM3I9HiT0/Xi1bJD02j3CepvMyivIvmBHNhkb4wL2Es5gHnPNY2jGs/TE=
X-Received: by 2002:a05:6402:4313:b0:5db:f5e9:674d with SMTP id
 4fb4d7f45d1cf-5dbf5e96a01mr1674781a12.0.1737541769751; Wed, 22 Jan 2025
 02:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126144344.4177332-1-edumazet@google.com> <Z4o_UC0HweBHJ_cw@PC-LX-SteWu>
 <CANn89iLSPdPvotnGhPb3Rq2gkmpn3kLGJO8=3PDFrhSjUQSAkg@mail.gmail.com>
 <Z4pmD3l0XUApJhtD@PC-LX-SteWu> <CANn89i+e-V4hkUmUALsJe3ZQYtTkxduN5Sv+OiV+vzEmOdU1+Q@mail.gmail.com>
 <CANn89iJghv1JSwO7AVh97mU1Laj11SooiioZOHJ+UbUVeAcKUQ@mail.gmail.com>
 <Z4370QW5kLDptEEQ@PC-LX-SteWu> <CANn89iLMeMRtxBiOa7uZpG-8A0YNH=8NkhXmjfd2Qw4EZSZsNQ@mail.gmail.com>
 <Z4-5zhRXZbjQ6XxE@PC-LX-SteWu> <CANn89iJ0+==pXHdMBcAXDd4MFDMvtFQhajKWWKj5kX7gU+NtTw@mail.gmail.com>
 <Z5DH4cIqndQOyUfX@PC-LX-SteWu>
In-Reply-To: <Z5DH4cIqndQOyUfX@PC-LX-SteWu>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jan 2025 11:29:18 +0100
X-Gm-Features: AbW1kvZsNVMwX1R-9yfFF3W2Do5yUV3PjUe2HbhOF7NTf4evniD4upOTsNJO0ls
Message-ID: <CANn89iKFgz05346NqwuCCnHTP4uaeORdtJVkdZ7K+c5+h7_J_g@mail.gmail.com>
Subject: Re: [PATCH net] net: hsr: avoid potential out-of-bound access in fill_frame_info()
To: Stephan Wurm <stephan.wurm@a-eberle.de>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+671e2853f9851d039551@syzkaller.appspotmail.com, 
	WingMan Kwok <w-kwok2@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, 
	MD Danish Anwar <danishanwar@ti.com>, Jiri Pirko <jiri@nvidia.com>, 
	George McCollister <george.mccollister@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 11:27=E2=80=AFAM Stephan Wurm <stephan.wurm@a-eberl=
e.de> wrote:
>
> Am 21. Jan 16:35 hat Eric Dumazet geschrieben:
> > On Tue, Jan 21, 2025 at 4:15=E2=80=AFPM Stephan Wurm <stephan.wurm@a-eb=
erle.de> wrote:
> >
> > > I did some additional experiments.
> > e
> > > First, I was able to get v6.13 running on the system, although it did
> > > not fix my issue.
> > >
> > > Then I played around with VLAN interfaces.
> > >
> > > I created an explicit VLAN interface on top of the prp interface. In =
that
> > > case the VLAN header gets transparently attached to the tx frames and
> > > forwarding through the interface layers works as expected.
> > >
> > > It was even possible to get my application working on top of the vlan
> > > interface, but it resulted in two VLAN headers - the inner from the
> > > application, the outer from the vlan interface.
> > >
> > > So when sending vlan tagged frames directly from an application throu=
gh
> > > a prp interface the mac_len field does not get updated, even though t=
he
> > > VLAN protocol header is properly detected; when sending frames throug=
h
> > > an explicit vlan interface, the mac_len seems to be properly parsed
> > > into the skb.
> > >
> > > Now I am running out of ideas how to proceed.
> > >
> > > For the time being I would locally revert this fix, to make my
> > > application working again.
> > > But I can support in testing proposed solutions.
> >
> >
> > If mac_len can not be used, we need yet another pskb_may_pull()
> >
> > I am unsure why hsr_get_node() is working, since it also uses skb->mac_=
len
> >
> > Please test the following patch :
> >
> > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > index 87bb3a91598ee96b825f7aaff53aafb32ffe4f9..8942592130c151f2c948308e=
1ae16a6736822d5
> > 100644
> > --- a/net/hsr/hsr_forward.c
> > +++ b/net/hsr/hsr_forward.c
> > @@ -700,9 +700,11 @@ static int fill_frame_info(struct hsr_frame_info *=
frame,
> >                 frame->is_vlan =3D true;
> >
> >         if (frame->is_vlan) {
> > -               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, =
vlanhdr))
> > +               if (pskb_may_pull(skb,
> > +                                 skb_mac_offset(skb) +
> > +                                 offsetofend(struct hsr_vlan_ethhdr, v=
lanhdr)))
> >                         return -EINVAL;
> > -               vlan_hdr =3D (struct hsr_vlan_ethhdr *)ethhdr;
> > +               vlan_hdr =3D (struct hsr_vlan_ethhdr *)skb_mac_header(s=
kb);
> >                 proto =3D vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
> >         }
>
> Thank you very much! With this patch (slightly modified) everything works
> as expected now :)
>
> I only needed to invert the logic in the if clause, as otherwise all
> proper VLAN frames were dropped from PRP.

Yes, of course.

>
> Here is the modified version:
>
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 87bb3a91598e..3491627bbaf4 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -700,9 +700,11 @@ static int fill_frame_info(struct hsr_frame_info *fr=
ame,
>                 frame->is_vlan =3D true;
>
>         if (frame->is_vlan) {
> -               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vl=
anhdr))
> +               if (!pskb_may_pull(skb,
> +                                  skb_mac_offset(skb) +
> +                                  offsetofend(struct hsr_vlan_ethhdr, vl=
anhdr)))
>                         return -EINVAL;
> -               vlan_hdr =3D (struct hsr_vlan_ethhdr *)ethhdr;
> +               vlan_hdr =3D (struct hsr_vlan_ethhdr *)skb_mac_header(skb=
);
>                 proto =3D vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
>         }

Thanks, I am going to submit an official patch then.

