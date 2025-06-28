Return-Path: <netdev+bounces-202198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB10FAECA5B
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 23:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA5527AB4D6
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 21:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAD21DE3DC;
	Sat, 28 Jun 2025 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jBh+P0wC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0ED2F1FD0
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751145362; cv=none; b=X6r8SG6HonLm/VIAk8TyrHbbgz4uE3W/5l/ldxAipCUklyJuwpkcWCb2PGk1Y/0b+kGO3S2F27y3NPeicc6PnbwfnCRkE5Ah8yrvOjXGzg7qWz/P/AFeBzkgu4x+xCtz+iGRGF3BwnHx4KlWRIgQ6j353wDdinxJwEgfJ2wC4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751145362; c=relaxed/simple;
	bh=mG1NWfUfpZr2Uiu+L9UWPYaf59UUb4xZOT5zAkfMl8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TG745UW3/WvTNZM/0TAl2YJZnVVjEfpoRGMQWxD4ove7pgDMlqeymqOPFFALQqhEYFBPUHYmpYkuQUjgZ4B/5VW0IY0zrpPryP60RE0PcdC+61dWf8f2C6Zt/tbSDS6aazOkuge2p76GyBosZkeT23/y6vGlUNh6Coih4yNUC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=jBh+P0wC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7481600130eso1338477b3a.3
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 14:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751145360; x=1751750160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Afje3Y+SnNxpOorS2ohm0jP+NBJ4ArhNcTGWaoZfF+c=;
        b=jBh+P0wClCV0sce2VgcZFNFpaoWIBFMVibVrCkCFVwQYtQsfggLubawhV5XQCFwKlk
         EVzPlnaYaOyK7eoNExZwENgumzlxEhC4fZFMCPNoUML7F6IIg7rzeZL5krV0PVEAKbdl
         XL2AiqkMLHee58N0H3v0ld6gdjJJ0Z9XZnrtVJKhxK4xQtW+MRvPtwkZem3LV+ShqCit
         g3WHlTHd+ct9RVCHe4ei4flGhmIW8/S7TafFap+hAzdU89i8XnKtyG3/GMwURncxlF1w
         1szzv4n64DZ8yAEu7z90bqsPDShaqcHYzcHUhiiRn/2kDbhgysDEzTxI/GY3QrG45DUK
         Ucvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751145360; x=1751750160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Afje3Y+SnNxpOorS2ohm0jP+NBJ4ArhNcTGWaoZfF+c=;
        b=gSbvuXLjbzI59vHAFhhWB6xMUuAn8Tbqy4Q3THM5Z6Q463P/VL7pdfmCARz/nsqO+5
         fjzW4Ya9bJ9bvh56EHChNUeLWLk0WUVrMrRXQhPE3EIxqcERhFYY1Jpj2vxWMoN+9BdK
         Oibca8ZaNsnb3HjlZQjHsr0cFUyCHGGoloi1nwYkvSAlY0LhV7Vgwmy7VGAvPvlDCNNF
         T5F4krHL65P8fFUl5PW5Do/N0nx6jxNARSktRcDyE2bSmiyhrl5ViJivuR7O0WUdV5x6
         r6o/4NItReBjK0ulL+x08JUw6hJKvt+aXxZs1K1LakJfieRlwRt1AAU0alKDIKf+ccRX
         abgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjocSXk0qNiXA9cwnyE7S6EoBDxaAwZDE7tCejr+X9Jdw1HB1NOmtKBg/OOD2F/8KsTO2+Gzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExPvyhvGPMiKCrvSl1f5+dYxbhZUsnjj249n+DNlNu2SplKg9
	/hE+m1IuMkcQwX2PIZ7rhQcAqDeuwEVFymgS9IL8CJC4GOB3UVnuEDp/hGvXqXIJz0nKZesQQJz
	biw31WLnTiHB5y1+TnljP1YqnBTWvJfEH+UhsPQvO
X-Gm-Gg: ASbGnctkFG+zv03UzvJ9b0EgbWjhqTsghkhmRfpZHDGoJUrKvcxqCrVPIRB+EuCUcCK
	EtaDU1jPxhgtoIqhp3wCZIKX2yWKWuuWXMC/WXxgKS8x3z5nqq+45+LAOLq15mub7KARGBUXK45
	t2LZgSbQ8uN4EmG3xscunQtfb+/CKlbPO5aFW6HC8TkA==
X-Google-Smtp-Source: AGHT+IEDBZ6LE4WxUyAHJfeBvCwTfzQfc4PQ40/Y0ORyo+bE3iY1QVisUs9Ri49C6rpMMiulyNuKO4f8gREhQnqeXYo=
X-Received: by 2002:a05:6a00:2e98:b0:748:311a:8aef with SMTP id
 d2e1a72fcca58-74af6fcd65bmr12115622b3a.12.1751145360340; Sat, 28 Jun 2025
 14:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627061600.56522-1-will@willsroot.io> <aF80DNslZSX7XT3l@pop-os.localdomain>
 <20250628081510.6973c39f@hermes.local>
In-Reply-To: <20250628081510.6973c39f@hermes.local>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 28 Jun 2025 17:15:49 -0400
X-Gm-Features: Ac12FXycB1RpYHaGn7eEHLJnyQYO2hWtcOjbtiFCZaZdSRAsK7a3imJTqDVqaWw
Message-ID: <CAM0EoMnFHWBzRMVWYDZRvJYC+KwGPZhFOMsGn2PGV9RyY3yyiQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, William Liu <will@willsroot.io>, netdev@vger.kernel.org, 
	victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, 
	kuba@kernel.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 11:15=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Fri, 27 Jun 2025 17:15:08 -0700
> Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> > On Fri, Jun 27, 2025 at 06:17:31AM +0000, William Liu wrote:
> > > netem_enqueue's duplication prevention logic breaks when a netem
> > > resides in a qdisc tree with other netems - this can lead to a
> > > soft lockup and OOM loop in netem_dequeue, as seen in [1].
> > > Ensure that a duplicating netem cannot exist in a tree with other
> > > netems.
> > >
> >
> > Thanks for providing more details.
> >
> > > Previous approaches suggested in discussions in chronological order:
> > >
> > > 1) Track duplication status or ttl in the sk_buff struct. Considered
> > > too specific a use case to extend such a struct, though this would
> > > be a resilient fix and address other previous and potential future
> > > DOS bugs like the one described in loopy fun [2].
> > >
> > > 2) Restrict netem_enqueue recursion depth like in act_mirred with a
> > > per cpu variable. However, netem_dequeue can call enqueue on its
> > > child, and the depth restriction could be bypassed if the child is a
> > > netem.
> > >
> > > 3) Use the same approach as in 2, but add metadata in netem_skb_cb
> > > to handle the netem_dequeue case and track a packet's involvement
> > > in duplication. This is an overly complex approach, and Jamal
> > > notes that the skb cb can be overwritten to circumvent this
> > > safeguard.
> >
> > This approach looks most elegant to me since it is per-skb and only
> > contained for netem. Since netem_skb_cb is shared among qdisc's, what
> > about just extending qdisc_skb_cb? Something like:
> >
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index 638948be4c50..4c5505661986 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -436,6 +436,7 @@ struct qdisc_skb_cb {
> >                 unsigned int            pkt_len;
> >                 u16                     slave_dev_queue_mapping;
> >                 u16                     tc_classid;
> > +               u32                     reserved;
> >         };
> >  #define QDISC_CB_PRIV_LEN 20
> >         unsigned char           data[QDISC_CB_PRIV_LEN];
> >
> >
> > Then we just set and check it for duplicated skbs:
> >
> >
> > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > index fdd79d3ccd8c..4290f8fca0e9 100644
> > --- a/net/sched/sch_netem.c
> > +++ b/net/sched/sch_netem.c
> > @@ -486,7 +486,7 @@ static int netem_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
> >          * If we need to duplicate packet, then clone it before
> >          * original is modified.
> >          */
> > -       if (count > 1)
> > +       if (count > 1 && !qdisc_skb_cb(skb)->reserved)
> >                 skb2 =3D skb_clone(skb, GFP_ATOMIC);
> >
> >         /*
> > @@ -540,9 +540,8 @@ static int netem_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
> >                 struct Qdisc *rootq =3D qdisc_root_bh(sch);
> >                 u32 dupsave =3D q->duplicate; /* prevent duplicating a =
dup... */
> >
> > -               q->duplicate =3D 0;
> > +               qdisc_skb_cb(skb2)->reserved =3D dupsave;
> >                 rootq->enqueue(skb2, rootq, to_free);
> > -               q->duplicate =3D dupsave;
> >                 skb2 =3D NULL;
> >         }
> >
> >
> > Could this work? It looks even shorter than your patch. :-)
> >
> > Note, I don't even compile test it, I just show it to you for discussio=
n.
> >
> > Regards,
> > Cong Wang
>
> Looks like an ok workaround, but the name 'reserved' is most often used
> as placeholder in API's. Maybe something like 'duplicated'?
>
> Why a whole u32 for one flag?
>
> This increases qdisc_skb_cb from 28 bytes to 32 bytes.
> So still ok, but there should be a build check that it is less than
> space in skb->cb.
>

This is a nonsensical setup (in this case, it is nonsensical to have a
netem duplicate with a child netem in the hierarchy both with
duplicates) and imo adding fields to handle nonsensical setups is not
a good idea. I doubt that code will compile as is for example..

From my POV Ive had it with these nonsensical setups from the bounty
hunting crowd (the majority of the pawning ones are nonsensical) -
disallowing these setups by adding deny lists is a good approach. I
would not have minded to add the field if this was a legitimate
setup....

cheers,
jamal

