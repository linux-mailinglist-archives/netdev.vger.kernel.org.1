Return-Path: <netdev+bounces-130535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBBA98ABE6
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7FDB23433
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E5A19992C;
	Mon, 30 Sep 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWz2HKCt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7E19047D
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720242; cv=none; b=RHEk0evzJ88ctKuZ9a0P9Y2OKbdcSPJJ13O+hevA6QD0u/fEflAFwyP6p2mFtNq1LtAkkquiGDqTpsrjjdTXLSS+moCet/WKai/c0b/2HBl+2fsVpCYNlLrRl9JS7VGJaE3E5D6Uvn92iBUW9RQSqxuQIp4j/4xMvrEXRFrOhnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720242; c=relaxed/simple;
	bh=JPUh09REwpJ909FZAqOsykNyHi/w+EwP4k3ak4GSh/0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=t5iuzLa3ZQ2XdIzxT+zU9+v9HW/5w19yi8mqvPtdkzl+nWHIRWDd3SFZghU3kEbmnjxYZDlfQliUJ8VWdnGMiwIjRFZQGhhuTr+9bVhbNrP/Af8ka1njrGTwP2+pERG0/mEicDNN5Q2gE8mJljpFumF0B8iG5N5452KGN2mlqjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWz2HKCt; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7ac83a98e5eso409258785a.0
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727720239; x=1728325039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlrRCNldOdoCv4Gx/R1j0wzlUpRS2H/491Qtsxdl9yQ=;
        b=DWz2HKCtgRHDCeOIAGAwmxnE61NSByGbo/tL96FaXvvUtgkkdlw+vmHjTSh7eSHQBW
         bJFsBCNklXbRfDKC6efrWgL3CiNOBxwRx4IUh7UrlnNDqKvUskpk5EcYT52mn3785ou5
         niN/NF5EJDodBGz5EmOJgsAuPB6Hr1AI4IDuOmormFXA/fnQ2aLz0zWcdGkjyY5u1lTf
         tEjfuoRU84mgoCea5f8JJ7bZaFU6UO6EJmvc56yNTtNeN2rUPNlvhmnUj6tIwu5NHOqo
         NK/kodel7hC1K8iAcOpEi02LmMizw2jcqv5i79owjo+8Goq0muXp/9EYvLR+aFnysynx
         z/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720239; x=1728325039;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rlrRCNldOdoCv4Gx/R1j0wzlUpRS2H/491Qtsxdl9yQ=;
        b=CJ2oLFVlLpNyTxF5q6i/20vTpXkuL3vJNkwggdF7zoywbXC8Xrpo31KchbQaFofd+K
         g16lywSlgs1oGxdjOcOo1Kyd/w2nCZof9yVENUoJmxx50XceBRuXaJ85fNNE8WBku07E
         CbKV/N5uXTB9nrmeki2ZW9aSZXhYfKme2r5VgzH1u02YEc2fJJXgQ7fF4rzTliNydri3
         8EVd+nLSPNUA/75x7F0amJRgIsZ2CIpTxkFO4lKqQs8gFN4VPp+YMByCbPRGgsP21pQh
         1Jxm/VSF0Uuo4Tmmkf6IwY0XgBHcGCEsAguqCc8STjA61XSpG5IDoRFjIRdeZEnWovVF
         gxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNUPyXreev2zQ57mB87Lrdk5swrsZWzkjKLurg4jCXgp57qqidCeL36JyDzUJiPfLppfw0Vpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo5RPhWaLIesXhfXm476d9yJ75dcA/q5b2Qyh2oXOcD/u4i70w
	Iz3ZxM1GTetYGvvjgD76IDcx3DV6lGG4xzJ0Ax8WmnxHCBJ4UyLH
X-Google-Smtp-Source: AGHT+IGfhQyCtiwVuY2A6LS8wq9ufw0BbY0vOL67ijDJOMGDM9N0qPZjuFUPIluG8Rhs8/SSMSlAoQ==
X-Received: by 2002:a05:620a:45a2:b0:7a9:b798:5e29 with SMTP id af79cd13be357-7ae5b842801mr82341285a.30.1727720239594;
        Mon, 30 Sep 2024 11:17:19 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377bc78csm436438285a.19.2024.09.30.11.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:17:19 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:17:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jeffrey Ji <jeffreyji@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com
Message-ID: <66faeb2ed4866_18b99529496@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iKdVt7AAh0bcx=zEUz0O+oBneOHvq2EjRbyNifQozEv4A@mail.gmail.com>
References: <20240930152304.472767-1-edumazet@google.com>
 <20240930152304.472767-3-edumazet@google.com>
 <66fae0f1f12f1_187400294c0@willemb.c.googlers.com.notmuch>
 <CANn89iKdVt7AAh0bcx=zEUz0O+oBneOHvq2EjRbyNifQozEv4A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net_sched: sch_fq: add the ability to
 offload pacing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Mon, Sep 30, 2024 at 7:33=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Eric Dumazet wrote:
> > > From: Jeffrey Ji <jeffreyji@google.com>
> > >
> > > Some network devices have the ability to offload EDT (Earliest
> > > Departure Time) which is the model used for TCP pacing and FQ packe=
t
> > > scheduler.
> > >
> > > Some of them implement the timing wheel mechanism described in
> > > https://saeed.github.io/files/carousel-sigcomm17.pdf
> > > with an associated 'timing wheel horizon'.
> > >
> > > This patchs adds to FQ packet scheduler TCA_FQ_OFFLOAD_HORIZON
> > > attribute.
> > >
> > > Its value is capped by the device max_pacing_offload_horizon,
> > > added in the prior patch.
> > >
> > > It allows FQ to let packets within pacing offload horizon
> > > to be delivered to the device, which will handle the needed
> > > delay without host involvement.
> > >
> > > Signed-off-by: Jeffrey Ji <jeffreyji@google.com>
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > > @@ -1100,6 +1105,17 @@ static int fq_change(struct Qdisc *sch, stru=
ct nlattr *opt,
> > >               WRITE_ONCE(q->horizon_drop,
> > >                          nla_get_u8(tb[TCA_FQ_HORIZON_DROP]));
> > >
> > > +     if (tb[TCA_FQ_OFFLOAD_HORIZON]) {
> > > +             u64 offload_horizon =3D (u64)NSEC_PER_USEC *
> > > +                                   nla_get_u32(tb[TCA_FQ_OFFLOAD_H=
ORIZON]);
> > > +
> > > +             if (offload_horizon <=3D qdisc_dev(sch)->max_pacing_o=
ffload_horizon) {
> > > +                     WRITE_ONCE(q->offload_horizon, offload_horizo=
n);
> >
> > Do we expect that that an administrator will ever set the offload
> > horizon different from the device horizon?
> =

> We want to be able to eventually deal with firmware/hardware bugs,
> like lack of backpressure on the timer wheel, which probably has some
> kind of capacity limit.
> =

> I think it is much better to let the admin choose, eventually
> disabling the whole thing, or enabling it for a small horizon like
> 2500 ns.
> =

> >
> > It might be useful to have a wildcard value that means "match
> > hardware ability"?
> =

>  "ip link" will show the device max capability.
> Same story for gso_max_size attribute.
> We do not automatically set it to dev->tso_max_size
> =

> I do not think we have a precedent for a qdisc/link attribute where
> the kernel automatically caps the user
> choice with the device capability.
>
> >
> > Both here and in the device, realistic values will likely always be
> > MSEC scale?
> =

> msec granularity proved to be not good for TCP stack, we went to us alr=
eady.
> =

> Fast path compares in ns unit, storing the value in ns removes
> multiplies from it.

Ack on all points. Thanks Eric.



