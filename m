Return-Path: <netdev+bounces-125265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D4796C857
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 22:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3730D1F25C23
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 20:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205A1147C71;
	Wed,  4 Sep 2024 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg/AYOrp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2F1EBFEC
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481505; cv=none; b=TaGzCwoEcwG4UgEcjVkh6l5d7yhO3Gc08gm/bs7aWZhjHmkYJx1/Rd8Hs2Y+LAljnb8cVZAkbZKuUSPVuNR6qKX9CbZTggVO6Pb3iQUoy/0Xx6cXZa7Gm6pRwXJs/KQ/GuDHpjMev9ke1aGtCwiQQXoTWANqxTsdaqvt3EiK9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481505; c=relaxed/simple;
	bh=ev8cARq732lQQ2rFu9z31aMfsgXO1YavmhtGzPXUDAs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NpFQccpivNEM1ssSX4jaYXomLzfudvMZbd1w+VAS+GfvFi0rUQRPpHLsnTGXDq/Gw0NfZ/2kVJEavFviCc94ikizHVEctwVwpOEs8v5i0hoGdk4N8mcvoVEagL6RlylzdgahznaUIk2lj9xB4dq/WUIOdCysDBnVTITaD9i85ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg/AYOrp; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a80fe481a9so2054985a.0
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 13:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725481502; x=1726086302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvTvxMIm37M8HriHRSqcnPJUoouGekd+3L65geilqOo=;
        b=Pg/AYOrpanymLypMQ/DmbIIXvarelahUbIeATMrtPznXNpN8LfSR+53heAaahb7vz/
         vSU8Rmpmom5EQcGpkXXreeq4XjsLuvnxneAnpgqte4R+PbnyINlziVdNX7IDYQdnoepa
         rg0QBbtS+xpfbcnvuPrqEww8ahiKNveiftIHMxt8ckBAKyBbSVFlyx0ndPDtR7RxSs7t
         CWSqPeeA7uKBu18wsZ2xgOq81HFisvnCGWv44KVKBlFAgc74h7atpUIdCWGbOrBDSvUI
         f39ejmo3yL2RESOg4tde1SAtSBkHrihXiuYigi2e3YOkMi0e+qEqdGe2EsvX1HmWkAau
         j4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481502; x=1726086302;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kvTvxMIm37M8HriHRSqcnPJUoouGekd+3L65geilqOo=;
        b=R/hNGLTaZkrN5FOFnU0RuheBcqtbH3DChhPSgVBUn0xcnIZdbDH6GRKF8opAXgska9
         F+b7Wpww4aNJIP/lwbjKjBhihfNSH97YUaUSl1AOZWOQ44jAamarG3fzd2TYMVvPq7Oq
         99hMSCGPJxwbEMBp28kJjHVf2fH+bBA9kTTeLgJgQNR297VrSYuC1CYjnNNT6W6zrO2q
         uinuOzimp4oNO9jK7lCMfGu3r+JWTh+njrr2KC94CrdUi3wz6tSJldUlosvR8WHhSsEW
         BeWViwFXT1hewOOmb0yl7WtnHWXqdFHUhn928TSVxUMq12MzBOhzNLeoabeOEwVUm6nC
         7ZHg==
X-Forwarded-Encrypted: i=1; AJvYcCWbHc6ZBuj5y4nQfyfhzxJ0I7iJf4PJmZH+TCgozDJqE8H/2Pc7wwLcYSafgdx4267zSdGAt4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoB6Ct1O1Q+s5pSIgAgvbGKe2wjMkCC5+BhZR0mLizxDuB9HPN
	85BhNQ7r489EMRlgeO1KXTUse00LS4dq0BSTXd8IoKi694AYQiP1
X-Google-Smtp-Source: AGHT+IEYpuErfOKRAcoMfVoyWCncPlFujxFTQBglZb2KziesM6kPKbfEHVL30m2OISgMRZcsoA4v0Q==
X-Received: by 2002:a05:620a:458e:b0:7a7:fab6:62e7 with SMTP id af79cd13be357-7a81d67f927mr1998650785a.15.1725481502002;
        Wed, 04 Sep 2024 13:25:02 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1df33sm15466785a.3.2024.09.04.13.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:25:01 -0700 (PDT)
Date: Wed, 04 Sep 2024 16:25:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 willemb@google.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66d8c21d3042a_163d93294cb@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoASfb-EPtdpmunbo2zxpQx19Kv+b8Bzs91diVFYYqQz7Q@mail.gmail.com>
References: <20240830153751.86895-1-kerneljasonxing@gmail.com>
 <20240830153751.86895-2-kerneljasonxing@gmail.com>
 <20240903121940.6390b958@kernel.org>
 <66d78a1e5e6ad_cefcf294f1@willemb.c.googlers.com.notmuch>
 <CAL+tcoASfb-EPtdpmunbo2zxpQx19Kv+b8Bzs91diVFYYqQz7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net-timestamp: filter out report when
 setting SOF_TIMESTAMPING_SOFTWARE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Wed, Sep 4, 2024 at 6:13=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jakub Kicinski wrote:
> > > On Fri, 30 Aug 2024 23:37:50 +0800 Jason Xing wrote:
> > > > +   if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
> > > > +       val & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> > > > +           return -EINVAL;
> > >
> > >
> > > > -           if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFT=
WARE)
> > > > +           if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > > > +               (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > > > +                !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FIL=
TER)))
> > > >                     has_timestamping =3D true;
> > > >             else
> > > >                     tss->ts[0] =3D (struct timespec64) {0};
> > > >     }
> > >
> > > >     memset(&tss, 0, sizeof(tss));
> > > >     tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > > -   if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> > > > +   if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > > > +        (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > > > +        skb_is_err_queue(skb) ||
> > > > +        !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER))) &=
&
> > >
> > > Willem, do you prefer to keep the:
> > >
> > >       tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > >       !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> > >
> > > conditions?IIUC we prevent both from being set at once. So
> > >
> > >       !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> > >
> > > is sufficient (and, subjectively, more intuitive).
> >
> > Good point. Yes, let's definitely simplify.
> >
> > > Question #2 -- why are we only doing this for SW stamps?
> > > HW stamps for TCP are also all or nothing.
> >
> > Fair. Else we'll inevitably add a
> > SOF_TIMESTAMPING_OPT_RX_HARDWARE_FILTER at some point.
> >
> > There probably is no real use to filter one, but not the other.
> >
> > So SOF_TIMESTAMPING_OPT_RX_FILTER then, and also apply
> > to the branch below:
> >
> >         if (shhwtstamps &&
> >             (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
> >             !skb_is_swtx_tstamp(skb, false_tstamp)) {
> >
> > and same for tcp_recv_timestamp.
> =

> When I'm looking at this part, I noticed that RAW_HARDWARE is actually
> a tx report flag instead of rx, please also see the kdoc you wrote a
> long time ago:
> =

> SOF_TIMESTAMPING_RAW_HARDWARE:
>   Report hardware timestamps as generated by
>   SOF_TIMESTAMPING_TX_HARDWARE when available.

Right, this is analogous to the software part that you modify:

        if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
            ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
                empty =3D 0;

The idea is to also add for hardware timestamps your suggested
condition that the socket also sets the timestamp generation flag
SOF_TIMESTAMPING_RX_HARDWARE or that the new OPT_RX_FILTER flag
is not set.


> If so, OPT_RX_FILTER doesn't fit for the name of tx timestamp.
> =

> I wonder if I can only revise the series with the code simplified as
> Jakub suggested and then repost it? I think we need to choose a new
> name for this tx hardware report case, like
> SOF_TIMESTAMPING_OPT_TX_HARDWARE_FILTER?
> =

> Since it belongs to the tx path, can I put it into another series or a
> new patch in the current series where I will explicitly explain why we
> also need to introduce this new flag?

I think the confusion here comes from that comment that
SOF_TIMESTAMPING_RAW_HARDWARE only reports
SOF_TIMESTAMPING_TX_HARDWARE generated timestamps. This statement is
incorrect and should be revised. It also reports
SOF_TIMESTAMPING_RX_HARDWARE.

Unless I'm missing something. But I think the author of that statement
is the one who made the mistake. Who is.. also me.=

