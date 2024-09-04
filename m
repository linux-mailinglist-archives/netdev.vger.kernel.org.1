Return-Path: <netdev+bounces-124931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD81B96B641
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26E81C20CFA
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE1A185935;
	Wed,  4 Sep 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv0ZDEaK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FDF2C181
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441286; cv=none; b=nxQeTU+Xhsm4BCZw0WjVpSpr4CACkMl5fjIHavP/hjL5xLPV6nhAFVb24fbH39Sy+uWAcW0UBQs3aQf/S/IKudYflf2KFBPSjN2vrENHuOxhqlJf6WcN1Yp3ZTkCsSBobMde6WBaTGqMZIEHlckHH4P4+nObY2zB4VQZk9wfYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441286; c=relaxed/simple;
	bh=x+AvTO1pXOr3mRNnfh+oRWVQCo5ni5lIhFtj/WUoYJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLASITMQMzl5OoAF0prulU1LXrPEtCzLDVyhi8Z8JdtwDdRvep03kFYUwizW5Re3dNzEgjZyxylYb231FgsMnEAbTRbntEXOHNU3MeftHCUOh5mtch1QztcQzoVRlt7I3j1TXnqL5l0oq5CJOE6ikat3V3n9PCZDG3tFZWuH5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv0ZDEaK; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39f51934f61so14183355ab.2
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 02:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725441284; x=1726046084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlT8pDE0AS+PtnT6Ru+cuG5A+CmSlzNKFYV+D9bEAAk=;
        b=gv0ZDEaK/YhWDBu/77u9sxFUdtax+3exNLeaFSVe7Fna117lv2iOwjR6ucjJVpxknG
         Eu+xxnfCVaIY3/wS1ezKwpJjaxQgxQkhNjtNZwEECoKNgWwk9yiybVu6Y6GkwPuv/NCy
         EcyItuR17WiJcIBR2kM/CVXiEEek5IQlnxE54W84xlvWxE1y7dya4pxMIOB1R1x+ICb/
         xkdyq67cgLBIFLyhv8akXCd9wEABr2JEVCfA27MpAnofMmbUprzmWLPL6+vEX0jIy5FG
         BX9uRN/0W6BMzyoCtDBufs94rx8e+pRnqQtjspRu7YjHtF1gdH8zNP8lkzmJPfwLvQfI
         lELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725441284; x=1726046084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlT8pDE0AS+PtnT6Ru+cuG5A+CmSlzNKFYV+D9bEAAk=;
        b=gP/r/kFbDnWu6L8e2jjRJmS1BSonBpr5Wc2e1cazAegVR8MnnAmte/RGXAWDv5vkoI
         dSo2/roeGDsznosw3EHPKZWYdWHqxL+tkI+bZSuozWqE0FiN0xvKqKSwJmXOfwpAqnr3
         Yz635dLGGuNtPx02tiheui2MkR2ANaF7VXi7b+MHlZeps3tCdzOBCB71maqlCrcDQcSi
         4bpPFTIsNzsB4LIxK9kmTK8lMNSkZyOurZePzs1JqfvFXx0rwYfp+uuSXZxDcr4hFMQi
         ERAoEocjVVkr+ulOcSHeoq5FP+pJ+OyRp33v/hKrDscyKHLXzrngaTNbripvHi4Tabmc
         IMzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf2bH66qgqbNlanoXyT1kvfyYk/Zqlbt/qVFlsWb5rHbkbcsBcAHz/WdIa3DbEzpAYU0Krplw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwO+ZupaqmSr8Z8a+EpQdTrnyuudHd/gsuGjwJjBSgFjpp/qC
	NbT3GGNjnmGm8CmjADUdCymqzLH1jSbz8ARLFDcShwR/VpiujzY/ENTestQaV58Ylsg4wxglvLc
	aYpT4NozOfzb/2bt9avkngfmrZ88=
X-Google-Smtp-Source: AGHT+IE181qZIWC7GK2ttyHE3P92DfzlMhYXNbL4TRjNzuTkqrB4QGobcjg9Idf9rNTRlqTJD6rmeypKFGSc3m9TQs0=
X-Received: by 2002:a05:6e02:13aa:b0:39b:34dd:43d1 with SMTP id
 e9e14a558f8ab-39f6a9f54bfmr67693595ab.22.1725441283640; Wed, 04 Sep 2024
 02:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830153751.86895-1-kerneljasonxing@gmail.com>
 <20240830153751.86895-2-kerneljasonxing@gmail.com> <20240903121940.6390b958@kernel.org>
 <66d78a1e5e6ad_cefcf294f1@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d78a1e5e6ad_cefcf294f1@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 4 Sep 2024 17:14:07 +0800
Message-ID: <CAL+tcoASfb-EPtdpmunbo2zxpQx19Kv+b8Bzs91diVFYYqQz7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net-timestamp: filter out report when
 setting SOF_TIMESTAMPING_SOFTWARE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, willemb@google.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 6:13=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jakub Kicinski wrote:
> > On Fri, 30 Aug 2024 23:37:50 +0800 Jason Xing wrote:
> > > +   if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
> > > +       val & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> > > +           return -EINVAL;
> >
> >
> > > -           if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE=
)
> > > +           if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > > +               (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > > +                !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)=
))
> > >                     has_timestamping =3D true;
> > >             else
> > >                     tss->ts[0] =3D (struct timespec64) {0};
> > >     }
> >
> > >     memset(&tss, 0, sizeof(tss));
> > >     tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > -   if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> > > +   if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > > +        (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > > +        skb_is_err_queue(skb) ||
> > > +        !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER))) &&
> >
> > Willem, do you prefer to keep the:
> >
> >       tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> >       !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> >
> > conditions?IIUC we prevent both from being set at once. So
> >
> >       !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> >
> > is sufficient (and, subjectively, more intuitive).
>
> Good point. Yes, let's definitely simplify.
>
> > Question #2 -- why are we only doing this for SW stamps?
> > HW stamps for TCP are also all or nothing.
>
> Fair. Else we'll inevitably add a
> SOF_TIMESTAMPING_OPT_RX_HARDWARE_FILTER at some point.
>
> There probably is no real use to filter one, but not the other.
>
> So SOF_TIMESTAMPING_OPT_RX_FILTER then, and also apply
> to the branch below:
>
>         if (shhwtstamps &&
>             (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
>             !skb_is_swtx_tstamp(skb, false_tstamp)) {
>
> and same for tcp_recv_timestamp.

When I'm looking at this part, I noticed that RAW_HARDWARE is actually
a tx report flag instead of rx, please also see the kdoc you wrote a
long time ago:

SOF_TIMESTAMPING_RAW_HARDWARE:
  Report hardware timestamps as generated by
  SOF_TIMESTAMPING_TX_HARDWARE when available.

If so, OPT_RX_FILTER doesn't fit for the name of tx timestamp.

I wonder if I can only revise the series with the code simplified as
Jakub suggested and then repost it? I think we need to choose a new
name for this tx hardware report case, like
SOF_TIMESTAMPING_OPT_TX_HARDWARE_FILTER?

Since it belongs to the tx path, can I put it into another series or a
new patch in the current series where I will explicitly explain why we
also need to introduce this new flag?

Thanks,
Jason

