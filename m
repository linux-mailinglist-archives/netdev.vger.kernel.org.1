Return-Path: <netdev+bounces-43122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1265C7D17E0
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69934B2150C
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3282F249EE;
	Fri, 20 Oct 2023 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KrC9prAh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C620315
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 21:11:09 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E471810F4
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:11:03 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so19107661fa.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697836259; x=1698441059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLj+SmhNGHAbmx7AtEGeh++5cFknBV82w6tQGWOTRUk=;
        b=KrC9prAhht6EFVE/Afk0Sybte5WtLOe7DTWL9yuy0J2gbJYSrrZVVwuqffMt5gp51r
         3fZ8dOQNH6rrLcYApreplUVpThIuQUcDH05TgCqMIuu5b3U9UrOZ+tI/4jyvY5ZD17Uu
         V9d8UpVFFRV09/ZvgzYUuSLFuyyUtoKQO2VXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836259; x=1698441059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLj+SmhNGHAbmx7AtEGeh++5cFknBV82w6tQGWOTRUk=;
        b=Gl3xWpze2JlYcAVivNvXunfB/I0+xw65g+XN2hPGLGk6lOS5JSHuTSuP0pg5aQJ8+H
         cuY9uRMdAXVWwqh6rIEOcGHfmyXXetMOjuSM9JUvH85BpzCpOQL950fubGEpDWv4t/CR
         0/LBySozfYRGqUWsQWhniU8qJJQ/7bRGeQjP4ZrG+Ksn2pMlr2ZbGlicUmLfIDyh7NwQ
         Yj6aUU4bg7D7C+3CT5vCC5Y25fHIMTtyq+E63UTdOPugnZWx2OMrKPgvsLkcZlMc89xf
         2kje+wnN+Tv6RwCpUy4WvVD2CkS23cnwRvdXf/nNSwZJIcDQ58Iu3D8Y/9Vu3gPKGVHQ
         2NnQ==
X-Gm-Message-State: AOJu0Yz3UjvI/8zdWMMzfGBKzBkfz+sn9Cr07pMFvrQVTscpkRfDxkei
	S8qr1qPr07rcJqDUKqHNLwRWfW62VGWsKN8/3qqGb0pi
X-Google-Smtp-Source: AGHT+IG0wUJD2gbuzeNvvoE9cNz9K/KTVG4IISDsc+hVygZgCjzH7QtaKUsuns3tOcoFuPtkyzS2uQ==
X-Received: by 2002:a2e:b8c7:0:b0:2c5:968:6daf with SMTP id s7-20020a2eb8c7000000b002c509686dafmr2744199ljp.39.1697836259074;
        Fri, 20 Oct 2023 14:10:59 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id w25-20020a17090633d900b0099bcf9c2ec6sm2207663eja.75.2023.10.20.14.10.57
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 14:10:58 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so6835e9.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:10:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4f91:b0:408:3e63:f457 with SMTP id
 n17-20020a05600c4f9100b004083e63f457mr157300wmq.2.1697836257414; Fri, 20 Oct
 2023 14:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019212130.3146151-1-dianders@chromium.org>
 <20231019142019.v4.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
 <eaf05cf1486c418790a1b54cbcda3a98@realtek.com> <CAD=FV=XZQ0XXY7XpX2_ubOwGsi0Hw5otHyuJS2=9QzDJsaSGWg@mail.gmail.com>
In-Reply-To: <CAD=FV=XZQ0XXY7XpX2_ubOwGsi0Hw5otHyuJS2=9QzDJsaSGWg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 20 Oct 2023 14:10:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vx60LchWqQbALx_tAzK3hnqwSF949KY+R7yWvxfYPQAQ@mail.gmail.com>
Message-ID: <CAD=FV=Vx60LchWqQbALx_tAzK3hnqwSF949KY+R7yWvxfYPQAQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] r8152: Block future register access if register
 access fails
To: Hayes Wang <hayeswang@realtek.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Grant Grundler <grundler@chromium.org>, Edward Hill <ecgh@chromium.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Simon Horman <horms@kernel.org>, 
	Laura Nao <laura.nao@collabora.com>, Alan Stern <stern@rowland.harvard.edu>, 
	=?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 20, 2023 at 8:42=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> > > @@ -8293,6 +8394,8 @@ static int rtl8152_post_reset(struct usb_interf=
ace *intf)
> > >         if (!tp)
> > >                 return 0;
> > >
> > > +       rtl_set_accessible(tp);
> > > +
> >
> > Excuse me. I have a new idea. You could check if it is possible.
> > If you remove test_bit(PROBED_WITH_NO_ERRORS, &tp->flags) in pre_reset(=
),
> > the driver wouldn't be unbound and rebound. Instead, you test PROBED_WI=
TH_NO_ERRORS
> > here to re-initialize the device. Then, you could limit the times of US=
B reset, and
> > the infinite loop wouldn't occur. The code would be like the following,
> >
> >         if (!test_bit(PROBED_WITH_NO_ERRORS, &tp->flags)) {
> >                 /* re-init */
> >                 mutex_lock(&tp->control);
> >                 tp->rtl_ops.init(tp);
> >                 mutex_unlock(&tp->control);
> >                 rtl_hw_phy_work_func_t(&tp->hw_phy_work.work);
> >
> >                 /* re-open(). Maybe move after checking netif_running(n=
etdev) */
> >                 mutex_lock(&tp->control);
> >                 tp->rtl_ops.up(tp);
> >                 mutex_unlock(&tp->control);
> >
> >                 /* check if there is any control error */
> >                 if (test_bit(RTL8152_INACCESSIBLE, &tp->flags) {
> >                         if (tp->reg_access_reset_count < REGISTER_ACCES=
S_MAX_RESETS) {
> >                                 /* queue reset again ? */
> >                         } else {
> >                                 ...
> >                         }
> >                         /* return 0 ? */
> >                 } else {
> >                         set_bit(PROBED_WITH_NO_ERRORS, &tp->flags)
> >                 }
> >         }
>
> The above solution worries me.
>
> I guess one part of this is that it replicates some logic that's in
> probe(). That's not necessarily awful, but we'd at least want to
> reorganize things so that they could share code if possible, though
> maybe that's hard to do with the extra grabs of the mutex?
>
> The other part that worries me is that in the core when we added the
> network device that something in the core might have cached bogus data
> about our network device. This doesn't seem wonderful to me.
>
> I guess yet another part is that your proposed solution there has a
> whole bunch of question marks on it. If it's not necessarily obvious
> what we should do in this case then it doesn't feel like a robust
> solution.
>
> It seems like your main concern here is with the potential for an
> infinite number of resets. I have sent up a small patch to the USB
> core [1] addressing this concern. Let's see what folks say about that
> patch. If it is accepted then it seems like we could just not worry
> about it. If it's not accepted then perhaps feedback on that patch
> will give us additional guidance.
>
> In the meantime I'll at least post v5 since I don't want to leave the
> patch up there with the mismatched mutex. I'll have my v5 point at my
> USB core patch.
>
> [1] https://lore.kernel.org/r/20231020083125.1.I3e5f7abcbf6f08d392e31a582=
6b7f234df662276@changeid

OK, Alan responded to the patch above and suggested simply putting the
retry in the probe routine itself. I think that's actually in the same
spirit as your suggestion but addresses the concerns that I had. I
coded it up and tested it and it seems to work, so I posted that as v5
[2]. Please take a look.

[2] https://lore.kernel.org/r/20231020210751.3415723-1-dianders@chromium.or=
g

