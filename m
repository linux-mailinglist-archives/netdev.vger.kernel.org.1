Return-Path: <netdev+bounces-41941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198037CC5BF
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E7C28149E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8C043AA6;
	Tue, 17 Oct 2023 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wa2XdJlp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2781743A84
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 14:17:25 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BB0EA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:17:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9bdf5829000so618075866b.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697552241; x=1698157041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhfkjFsxmGF82cD1/zPvd0Z9FpQNYOUYA0aagsJzr4o=;
        b=Wa2XdJlpa2WrADa42UyRAP0CIaiwAMdAmCoDww0WbJg+ymnin6+tpSfBnxSbZr2MxH
         GyD8r3LTd9PDsjLDDKkcZlFlvFx2q1FCkY66aBkUJT03860pIluGa3BPASgXID/jWTLF
         5pKFMov7zyA0Ne5jQc0IaRh0WDKh8luJN//OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697552241; x=1698157041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhfkjFsxmGF82cD1/zPvd0Z9FpQNYOUYA0aagsJzr4o=;
        b=u9XLFhohs7Ru3fonOR0TwC1Bo9V6+TuQIY9aI4WRzeiVLNo88WqR0TCHPhBWa7QfUf
         Vi6vR5w2ewYAbHgSZot+VwuxBBQOct7fYoFmoLfpXZCsCojBohOlpCyiZI0uv+dRIN5i
         JcQKLNpPDQTKLd8j854me2P5tzw3oYncDTUxznN4yupKiumyBduFe28uBGuMLEE6yehr
         3n0lzK6EPZMji5jVVQ1F2+/feDq9xK2c86Ix+Gj8BfQykcHCkHy8BpE4JUGsBnD0BaEY
         AqmKTtGjssgjXC00+8CmUilTysAYribAOlUpoiDz73JgLmBY0Lad12RAWc25yoi8WxNz
         u2Lw==
X-Gm-Message-State: AOJu0YwButZbZ0B+XYmNsIFC2WkKSClpZry33JsU4TZFfGTL1w7Ac6Dg
	TIcEu7aGnp3A11NvPpackIwCSZPO/o3dsrl5tdW2gR0/
X-Google-Smtp-Source: AGHT+IFtXm+7Eutt7ZFetGgl3ViIzUwSknGk5n7yddT71PTHLcPAXQxg2rUnTyDz+KwxsXHFYshXRQ==
X-Received: by 2002:a17:907:1c0d:b0:9bf:5771:a8cf with SMTP id nc13-20020a1709071c0d00b009bf5771a8cfmr2157671ejc.70.1697552240926;
        Tue, 17 Oct 2023 07:17:20 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id qx1-20020a170906fcc100b009c387ff67bdsm1355155ejb.22.2023.10.17.07.17.20
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 07:17:20 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40662119cd0so75775e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:17:20 -0700 (PDT)
X-Received: by 2002:a05:600c:214d:b0:408:2b:5956 with SMTP id
 v13-20020a05600c214d00b00408002b5956mr2161wml.6.1697552239873; Tue, 17 Oct
 2023 07:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012192552.3900360-1-dianders@chromium.org>
 <20231012122458.v3.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
 <29f9a2ff1979406489213909b940184f@realtek.com> <CAD=FV=U4rGozXHoK8+ejPgRtyoACy1971ftoatQivqzk2tk5ng@mail.gmail.com>
 <052401da00fa$dacccd90$906668b0$@realtek.com>
In-Reply-To: <052401da00fa$dacccd90$906668b0$@realtek.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 17 Oct 2023 07:17:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XQswgKZh-JQ6PuKGRmrDMfDmZwM+MUpAcOk1=7Ppjyiw@mail.gmail.com>
Message-ID: <CAD=FV=XQswgKZh-JQ6PuKGRmrDMfDmZwM+MUpAcOk1=7Ppjyiw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] r8152: Block future register access if register
 access fails
To: Hayes Wang <hayeswang@realtek.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Alan Stern <stern@rowland.harvard.edu>, Simon Horman <horms@kernel.org>, 
	Edward Hill <ecgh@chromium.org>, Laura Nao <laura.nao@collabora.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Grant Grundler <grundler@chromium.org>, 
	=?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Tue, Oct 17, 2023 at 6:07=E2=80=AFAM Hayes Wang <hayeswang@realtek.com> =
wrote:
>
> Doug Anderson <dianders@chromium.org>
> > Sent: Tuesday, October 17, 2023 12:47 AM
> [...
> > > >  static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
> > > > @@ -8265,6 +8353,19 @@ static int rtl8152_pre_reset(struct
> > usb_interface
> > > > *intf)
> > > >         if (!tp)
> > > >                 return 0;
> > > >
> > > > +       /* We can only use the optimized reset if we made it to the=
 end of
> > > > +        * probe without any register access fails, which sets
> > > > +        * `PROBED_WITH_NO_ERRORS` to true. If we didn't have that =
then return
> > > > +        * an error here which tells the USB framework to fully unb=
ind/rebind
> > > > +        * our driver.
> > >
> > > Would you stay in a loop of unbind and rebind,
> > > if the control transfers in the probe() are not always successful?
> > > I just think about the worst case that at least one control always fa=
ils in probe().
> >
> > We won't! :-) One of the first things that rtl8152_probe() does is to
> > call rtl8152_get_version(). That goes through to
> > rtl8152_get_version(). That function _doesn't_ queue up a reset if
> > there are communication problems, but it does do 3 retries of the
> > read. So if all 3 reads fail then we will permanently fail probe,
> > which I think is the correct thing to do.
>
> The probe() contains control transfers in
>         1. rtl8152_get_version()
>         2. tp->rtl_ops.init()
>
> If one of the 3 control transfers in 1) is successful AND
> any control transfer in 2) fails,
> you would queue a usb reset which would unbind/rebind the driver.
> Then, the loop starts.
> The loop would be broken, if and only if
>         a) all control transfers in 1) fail, OR
>         b) all control transfers in 2) succeed.
>
> That is, the loop would be broken when the fail rate of the control trans=
fer is high or low enough.
> Otherwise, you would queue a usb reset again and again.
> For example, if the fail rate of the control transfer is 10% ~ 60%,
> I think you have high probability to keep the loop continually.
> Would it never happen?

Actually, even with a failure rate of 10% I don't think you'll end up
with a fully continuous loop, right? All you need is to get 3 failures
in a row in rtl8152_get_version() to get out of the loop. So with a
10% failure rate you'd unbind/bind 1000 times (on average) and then
(finally) give up. With a 50% failure rate I think you'd only
unbind/bind 8 times on average, right? Of course, I guess 1000 loops
is pretty close to infinite.

In any case, we haven't actually seen hardware that fails like this.
We've seen failure rates that are much much lower and we can imagine
failure rates that are 100% if we're got really broken hardware. Do
you think cases where failure rates are middle-of-the-road are likely?

I would also say that nothing we can do can perfectly handle faulty
hardware. If we're imagining theoretical hardware, we could imagine
theoretical hardware that de-enumerated itself and re-enumerated
itself every half second because the firmware on the device crashed or
some regulator kept dropping. This faulty hardware would also cause an
infinite loop of de-enumeration and re-enumeration, right?

Presumably if we get into either case, the user will realize that the
hardware isn't working and will unplug it from the system. While the
system is doing the loop of trying to enumerate the hardware, it will
be taking up a bunch of extra CPU cycles but (I believe) it won't be
fully locked up or anything. The machine will still function and be
able to do non-Ethernet activities, right? I would say that the worst
thing about this state would be that it would stress corner cases in
the reset of the USB subsystem, possibly ticking bugs.

So I guess I would summarize all the above as:

If hardware is broken in just the right way then this patch could
cause a nearly infinite unbinding/rebinding of the r8152 driver.
However:

1. It doesn't seem terribly likely for hardware to be broken in just this w=
ay.

2. We haven't seen hardware broken in just this way.

3. Hardware broken in a slightly different way could cause infinite
unbinding/rebinding even without this patch.

4. Infinite unbinding/rebinding of a USB adapter isn't great, but not
the absolute worst thing.


That all being said, if we wanted to address this we could try two
different ways:

a) We could add a global in the r8152 driver and limit the number of
times we reset. This gets a little ugly because if we have multiple
r8152 adapters plugged in then the same global would be used for both,
but maybe it's OK?

b) We could improve the USB core to somehow prevent usb_reset_device()
from running too much on a given device?


...though I would re-emphasize that I don't think this is something we
need to address now. If later we actually see a problem we can always
address it then.


-Doug

