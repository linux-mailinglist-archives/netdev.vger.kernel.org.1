Return-Path: <netdev+bounces-125276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8923096C99A
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 23:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175501F265A0
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 21:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3FA14E2CC;
	Wed,  4 Sep 2024 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FD6LI1Cz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CB14F118
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725485955; cv=none; b=TDJWzuyDU++hCvUkLrwis64ZYVwWrYhUfKuXPsiDW9IRsK9ir7bvweXurVpnhEoLLYvZkn6ZYatL+MlAUnaabxYhI4z0LXw9rQng2IquttJqGK8jYCTc5mSSNe37h5TXHnDaAyrEKdKgb/2tcTvIXiee516jmsyD0ftCDP27SuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725485955; c=relaxed/simple;
	bh=7/0S2WULOU7MpI99LlH3AJqAPzoUCWBLE9vK43p5xi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgecgWOY/YzNSAe27XkAPTgGpgDrE1doxIbJrOjgbhDyuqPMT1tC1W4e9FZgxR8fyMRrThufW9xeyOSB0HSEppuAdPS7/bF9QCjwvl2xcShpYRH2SnlQ741t9fqJd2HTI1+RbVOgJ8OZ1hbF1fD+Y4k56pUbVlVj/OT3jZNKOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FD6LI1Cz; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82a316f8ae1so1076539f.1
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725485953; x=1726090753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH1dmyUqpO2w55L+ZEnnTz3U3EKIx86RX+jTQobURGw=;
        b=FD6LI1CzUSVFE66VA3BQRdPAHit8b49a2fzC2iq73yfidiO+W2ILmgmH1I8WKpf06A
         N3MheWDnOm/Qj+fohGeQr3u5bHz5EIfmoCaV5a2DbDWM1cMaRcpEAODQMI6WKgGbaYpr
         T9OEZ+lH/UI0X35wvMuk+/Qo8LDbNJ4Tq84I2X47S8GQWHU1Dd7/GptuRIRMVOz+lr6Q
         UR/aAcyyXaxw5lfrZGzLsNxIgCyMUAV5Tb6qbEzQXMGQcWspYU9XrIUTKgkT3nRPQW/O
         xdzhML/eOz/d6BzgJob76wOiVNQP7XvCrFA2sEYWdwH1h16uvYpnn7kVX80Z7tbGy6O0
         hPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725485953; x=1726090753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gH1dmyUqpO2w55L+ZEnnTz3U3EKIx86RX+jTQobURGw=;
        b=MCW43iuARhKk8jd5lhFPy0llfFmnJw2gtdmRFiklpJQO6kv0FN7f3+ZJ7qZGBJGEHq
         fnrJ3BEDMv0qxK/NHa+aQU6C9JvLZmwzlj5WdvselgdriAS8RhQ3KKh4oifzpX9D1TMH
         2V5obgZLnWfponXqiORIau6RvNAWhw6FbyZ+CpqUAgK8A9T4OP9kmJEbFDDfp9czjQo9
         FALYpuMRNNMU5C8xa6Y+df/Wr+XzUT4qwVFn55STMGOKLTicyaWdmUkxdqVlvFwzSaxc
         f1FRrg6krqoKNcxNG33h2OLLiwDrWVrouNLy2XbNzZcByJHQMKrMa5T76sFSR/1I8Pix
         J4hg==
X-Forwarded-Encrypted: i=1; AJvYcCXnHRVOVDDox8uNMbCS2J1JXbStcLnBuFWQfIY8Mt53BBo8/jdqLQLk+u9dLVWvlK02xtSndkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyns9R0oLSIzxJ3HgLQb+eHtTD7zE6yv4QNcx5UwHZQ+TrZm2S
	zvLLp9uoqxyVvgd+pdUy7QYBLEU6BXbMFHaEdGEBTxBUn3Jith4m4PGHKtvS/GpTLfNTD71Bzgr
	bbRui5WK1Pb99iwPCKYuVyG3VjGo=
X-Google-Smtp-Source: AGHT+IEwEXCGvGKTh/hps7hyiHsfwiDwx0JuJCi2qK+vxlxAc4UTkJiL+KBYdSX2rWrogB7NMsfBzA4s9Vi9vJ7B+Hg=
X-Received: by 2002:a05:6e02:1a02:b0:36c:4688:85aa with SMTP id
 e9e14a558f8ab-39f6a99105emr108569565ab.10.1725485952941; Wed, 04 Sep 2024
 14:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830153751.86895-1-kerneljasonxing@gmail.com>
 <20240830153751.86895-2-kerneljasonxing@gmail.com> <20240903121940.6390b958@kernel.org>
 <66d78a1e5e6ad_cefcf294f1@willemb.c.googlers.com.notmuch> <CAL+tcoASfb-EPtdpmunbo2zxpQx19Kv+b8Bzs91diVFYYqQz7Q@mail.gmail.com>
 <66d8c21d3042a_163d93294cb@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d8c21d3042a_163d93294cb@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 5 Sep 2024 05:38:36 +0800
Message-ID: <CAL+tcoD1eq-Gj1Du5U1X=pw97yT0fNvkwFb5iQeeTis4ekGbOQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net-timestamp: filter out report when
 setting SOF_TIMESTAMPING_SOFTWARE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, willemb@google.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 4:25=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Wed, Sep 4, 2024 at 6:13=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jakub Kicinski wrote:
> > > > On Fri, 30 Aug 2024 23:37:50 +0800 Jason Xing wrote:
> > > > > +   if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
> > > > > +       val & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> > > > > +           return -EINVAL;
> > > >
> > > >
> > > > > -           if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFT=
WARE)
> > > > > +           if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > > > > +               (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > > > > +                !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FIL=
TER)))
> > > > >                     has_timestamping =3D true;
> > > > >             else
> > > > >                     tss->ts[0] =3D (struct timespec64) {0};
> > > > >     }
> > > >
> > > > >     memset(&tss, 0, sizeof(tss));
> > > > >     tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > > > -   if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> > > > > +   if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > > > > +        (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > > > > +        skb_is_err_queue(skb) ||
> > > > > +        !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER))) &=
&
> > > >
> > > > Willem, do you prefer to keep the:
> > > >
> > > >       tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > > >       !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> > > >
> > > > conditions?IIUC we prevent both from being set at once. So
> > > >
> > > >       !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> > > >
> > > > is sufficient (and, subjectively, more intuitive).
> > >
> > > Good point. Yes, let's definitely simplify.
> > >
> > > > Question #2 -- why are we only doing this for SW stamps?
> > > > HW stamps for TCP are also all or nothing.
> > >
> > > Fair. Else we'll inevitably add a
> > > SOF_TIMESTAMPING_OPT_RX_HARDWARE_FILTER at some point.
> > >
> > > There probably is no real use to filter one, but not the other.
> > >
> > > So SOF_TIMESTAMPING_OPT_RX_FILTER then, and also apply
> > > to the branch below:
> > >
> > >         if (shhwtstamps &&
> > >             (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
> > >             !skb_is_swtx_tstamp(skb, false_tstamp)) {
> > >
> > > and same for tcp_recv_timestamp.
> >
> > When I'm looking at this part, I noticed that RAW_HARDWARE is actually
> > a tx report flag instead of rx, please also see the kdoc you wrote a
> > long time ago:
> >
> > SOF_TIMESTAMPING_RAW_HARDWARE:
> >   Report hardware timestamps as generated by
> >   SOF_TIMESTAMPING_TX_HARDWARE when available.
>
> Right, this is analogous to the software part that you modify:
>
>         if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
>             ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
>                 empty =3D 0;
>
> The idea is to also add for hardware timestamps your suggested
> condition that the socket also sets the timestamp generation flag
> SOF_TIMESTAMPING_RX_HARDWARE or that the new OPT_RX_FILTER flag
> is not set.
>
>
> > If so, OPT_RX_FILTER doesn't fit for the name of tx timestamp.
> >
> > I wonder if I can only revise the series with the code simplified as
> > Jakub suggested and then repost it? I think we need to choose a new
> > name for this tx hardware report case, like
> > SOF_TIMESTAMPING_OPT_TX_HARDWARE_FILTER?
> >
> > Since it belongs to the tx path, can I put it into another series or a
> > new patch in the current series where I will explicitly explain why we
> > also need to introduce this new flag?
>
> I think the confusion here comes from that comment that
> SOF_TIMESTAMPING_RAW_HARDWARE only reports
> SOF_TIMESTAMPING_TX_HARDWARE generated timestamps. This statement is
> incorrect and should be revised. It also reports
> SOF_TIMESTAMPING_RX_HARDWARE.
>
> Unless I'm missing something. But I think the author of that statement
> is the one who made the mistake. Who is.. also me.

That's all right :)

Then, the OPT_RX_FILTER is fine under this circumstance.

Let me also revise the documentation first in the series and put it
into a separate patch because the rule of writing the patch is to keep
one patch doing only one thing at one time.

Similar action will be done to the "rx hardware" part because I think
mixing the long description for both of them (software & hardware) can
be a little bit messy to readers.

Let me try a better organization of the series: keep each patch clear,
small, atomic and easy to review.

Thanks for your help!

