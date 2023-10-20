Return-Path: <netdev+bounces-43051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BD17D1312
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02EB6B21403
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6334E1DDFB;
	Fri, 20 Oct 2023 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J13NetEm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4881DA49
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 15:42:33 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A631FD71
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 08:42:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so148188766b.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697816546; x=1698421346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGC+3Kmw+D+b5Dj58mb9CrKsjrP+aMd2+KprUNQqghc=;
        b=J13NetEmn6UJVj4RNFAMlmVDcXV9It1K5L4R91DVK+Gc402XcTqMkJlWHzBybOH0Bw
         tn+UGf/0m26Ij8t76V2irnXxUYm7qTr1jWAg9ooMYWQoDg3HPK6uDTxePgub3LV3Lt9a
         Ar4P2jJB5LdtqDnZ7Nf7/VCoyvg/K1qcDKB+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697816546; x=1698421346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGC+3Kmw+D+b5Dj58mb9CrKsjrP+aMd2+KprUNQqghc=;
        b=vJqzzZqrOiii1hPOCHN2mOUjczvHiWPr1KJg57Z4efBErMQZel/3qLNee4E3FCxPXI
         34fX8ByCoIHwusc8j+Y/LQcoEUhQ10bPmr3FMbTQ9BqC3Fzd8624qKnsrwcp9cvZh/jS
         Ex1mi55RhvIjiRJLdvfdWfdJjYy00xgIIK+mxcVGnYhz7jzckBiCkkr5j76Cl3EFhqGp
         TUron1afxmoS8nzGBMhZ7wbEYo9to+dQFA2Yi0WZOS6YRq3HhVm/be4EWkjPUZlV7yw+
         /uJuVBWS1MWGlGOJ9er2ith390Z932Wf9kHM5byZhht2RzIqhxC/8B5J6kP7jYAmLxtr
         QwHQ==
X-Gm-Message-State: AOJu0YzSmlvbZEaL2IB2uuLehflqa6QBRL1pKUvlUymG0U6Pm7wtPkJH
	xlBNzdGgAr5JCr3a8YKnCW4FtAjpZwgclH1Bo3rR7+Pq
X-Google-Smtp-Source: AGHT+IF8OqADSY/3106PRv7nv5yKd4JeHqV/k7IoKOuDaGI/H37+WJJvunGu7EFeeZlbzxtoEBPnyg==
X-Received: by 2002:a17:907:36cc:b0:9c7:657f:8e85 with SMTP id bj12-20020a17090736cc00b009c7657f8e85mr1478143ejc.66.1697816545938;
        Fri, 20 Oct 2023 08:42:25 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id la5-20020a170906ad8500b009adce1c97ccsm1694634ejb.53.2023.10.20.08.42.25
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 08:42:25 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40662119cd0so76965e9.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 08:42:25 -0700 (PDT)
X-Received: by 2002:a05:600c:4a22:b0:408:2b:5956 with SMTP id
 c34-20020a05600c4a2200b00408002b5956mr119419wmp.6.1697816544811; Fri, 20 Oct
 2023 08:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019212130.3146151-1-dianders@chromium.org>
 <20231019142019.v4.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid> <eaf05cf1486c418790a1b54cbcda3a98@realtek.com>
In-Reply-To: <eaf05cf1486c418790a1b54cbcda3a98@realtek.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 20 Oct 2023 08:42:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XZQ0XXY7XpX2_ubOwGsi0Hw5otHyuJS2=9QzDJsaSGWg@mail.gmail.com>
Message-ID: <CAD=FV=XZQ0XXY7XpX2_ubOwGsi0Hw5otHyuJS2=9QzDJsaSGWg@mail.gmail.com>
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

On Fri, Oct 20, 2023 at 4:31=E2=80=AFAM Hayes Wang <hayeswang@realtek.com> =
wrote:
>
> Douglas Anderson <dianders@chromium.org>
> > Sent: Friday, October 20, 2023 5:20 AM
> [...]
> >  static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
> > @@ -8265,6 +8353,17 @@ static int rtl8152_pre_reset(struct usb_interfac=
e *intf)
> >         if (!tp)
> >                 return 0;
> >
> > +       /* We can only use the optimized reset if we made it to the end=
 of
> > +        * probe without any register access fails, which sets
> > +        * `PROBED_WITH_NO_ERRORS` to true. If we didn't have that then=
 return
> > +        * an error here which tells the USB framework to fully unbind/=
rebind
> > +        * our driver.
> > +        */
> > +       if (!test_bit(PROBED_WITH_NO_ERRORS, &tp->flags)) {
> > +               mutex_unlock(&tp->control);
>
> I think you forget to remove mutex_unlock here.

Ugh, thanks for catching. I tested it with a bootup or two but I
didn't re-run all tests or spend lots of time looking through the logs
so I missed this. I'll run a few more cycles this time.


> > +               return -EIO;
> > +       }
> > +
> >         netdev =3D tp->netdev;
> >         if (!netif_running(netdev))
> >                 return 0;
> > @@ -8277,7 +8376,9 @@ static int rtl8152_pre_reset(struct usb_interface=
 *intf)
> >         napi_disable(&tp->napi);
> >         if (netif_carrier_ok(netdev)) {
> >                 mutex_lock(&tp->control);
> > +               set_bit(IN_PRE_RESET, &tp->flags);
> >                 tp->rtl_ops.disable(tp);
> > +               clear_bit(IN_PRE_RESET, &tp->flags);
> >                 mutex_unlock(&tp->control);
> >         }
> >
> > @@ -8293,6 +8394,8 @@ static int rtl8152_post_reset(struct usb_interfac=
e *intf)
> >         if (!tp)
> >                 return 0;
> >
> > +       rtl_set_accessible(tp);
> > +
>
> Excuse me. I have a new idea. You could check if it is possible.
> If you remove test_bit(PROBED_WITH_NO_ERRORS, &tp->flags) in pre_reset(),
> the driver wouldn't be unbound and rebound. Instead, you test PROBED_WITH=
_NO_ERRORS
> here to re-initialize the device. Then, you could limit the times of USB =
reset, and
> the infinite loop wouldn't occur. The code would be like the following,
>
>         if (!test_bit(PROBED_WITH_NO_ERRORS, &tp->flags)) {
>                 /* re-init */
>                 mutex_lock(&tp->control);
>                 tp->rtl_ops.init(tp);
>                 mutex_unlock(&tp->control);
>                 rtl_hw_phy_work_func_t(&tp->hw_phy_work.work);
>
>                 /* re-open(). Maybe move after checking netif_running(net=
dev) */
>                 mutex_lock(&tp->control);
>                 tp->rtl_ops.up(tp);
>                 mutex_unlock(&tp->control);
>
>                 /* check if there is any control error */
>                 if (test_bit(RTL8152_INACCESSIBLE, &tp->flags) {
>                         if (tp->reg_access_reset_count < REGISTER_ACCESS_=
MAX_RESETS) {
>                                 /* queue reset again ? */
>                         } else {
>                                 ...
>                         }
>                         /* return 0 ? */
>                 } else {
>                         set_bit(PROBED_WITH_NO_ERRORS, &tp->flags)
>                 }
>         }

The above solution worries me.

I guess one part of this is that it replicates some logic that's in
probe(). That's not necessarily awful, but we'd at least want to
reorganize things so that they could share code if possible, though
maybe that's hard to do with the extra grabs of the mutex?

The other part that worries me is that in the core when we added the
network device that something in the core might have cached bogus data
about our network device. This doesn't seem wonderful to me.

I guess yet another part is that your proposed solution there has a
whole bunch of question marks on it. If it's not necessarily obvious
what we should do in this case then it doesn't feel like a robust
solution.

It seems like your main concern here is with the potential for an
infinite number of resets. I have sent up a small patch to the USB
core [1] addressing this concern. Let's see what folks say about that
patch. If it is accepted then it seems like we could just not worry
about it. If it's not accepted then perhaps feedback on that patch
will give us additional guidance.

In the meantime I'll at least post v5 since I don't want to leave the
patch up there with the mismatched mutex. I'll have my v5 point at my
USB core patch.

[1] https://lore.kernel.org/r/20231020083125.1.I3e5f7abcbf6f08d392e31a5826b=
7f234df662276@changeid

-Doug

