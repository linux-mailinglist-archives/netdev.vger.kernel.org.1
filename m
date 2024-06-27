Return-Path: <netdev+bounces-107426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9276A91AF23
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07961B20989
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F21019AA4B;
	Thu, 27 Jun 2024 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="I7LAtZsy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997282139D6
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513331; cv=none; b=RUyHOzNShy74valBHUKAWbF+gbwMkvFkdyVQd58v6VeZrvBVsrvEIaX1Lf4fctTGVSYqBXgpqwkqepo781JDzzucc0gauGObf7STD8LDAA0o4hLKnGkBXPiu4TgRen/yKFsKvefM0ZhzsqpsIuDP1sUn2wzk7BGRTDJInjHujV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513331; c=relaxed/simple;
	bh=5QFuua2mLfu8+V2J8JyWg6XRlGAtD9KqeZ3AVkNmW1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/fopc0FA/9eYK78qUPukblfeFKu3wwFzNjGVE2iqtnZJD8bvPmBrCHXTfdMH5FWV3j0yv3d81msR2nSOd4B8BMsKcrl4xe+BDO/m2mB3ESDShs5qx/j3ttOIUZvuAZx3FVKrEPB/DC3rwe2nNN4YG7vp7YTlbmJZKviKcvMJV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=I7LAtZsy; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso101305361fa.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719513328; x=1720118128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnhHJrE2YHiK16VdIIjwnongX46BL5HzJWY5VQ+uBug=;
        b=I7LAtZsy8pXWXuvFBurOqCdLZqSOWm2tqJWA0uWzahEZO1Ul3jktzHpNsM5FxINJaP
         bLQiyrWke2qnTCZDemyQ/kHD3Qr3TCRgzpbJSs90tvIv26a2y+TpUKxzEB/RJIM3J0U0
         stGVmae7G7y3+M3x7+XgSqltwJBNnSxlAUj0jvy78081lCbPWaNNX1EVxWaa2H2Wmd8k
         cdAlrK+1znR82IEpHGFIaEcxnrfs/hSTbSFHxvBvW7A6lDoN5IsMiDaghAqxY/1zNjGL
         Wt8qpxFTJ3d4qxMrLr295k1o+qAvGkHtgI4hBa/TN48LoVYG+/XkciW6d2XEr6aWlduV
         JoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719513328; x=1720118128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnhHJrE2YHiK16VdIIjwnongX46BL5HzJWY5VQ+uBug=;
        b=W9x7rlv1QAFbir4PZ5osGQOKqTxPQH4tNODGJlWYnjGFmdxsOa+Ah1g11uvA6Pw9hl
         poOVZBaP0c5d9xJhiBLyS/8iYpgB2Y5qXS71i7ILiLTiMR0lAtTALjj9ZBq2ukQfZJcd
         /GOlD22nGVYn4dSI+LG9ItlBt5/t3HP/m/dAX9csbXocE4117AXcHHJd2DLoTiG3UueJ
         IGxCNjF92mOLivZZQFM7sifPirNROnFNufoOfn0LfcwRiu+Xui7kuW9hG1updfFEixvT
         yoKOtEtX2MxvAmE+GAGPYDnloMfZv8b6svP/HVZQ5qFr2ttpVz1loduiH6QZqHOU+m6v
         0rGg==
X-Forwarded-Encrypted: i=1; AJvYcCWBNA/wHNzIZVA95KV6IdEFDcJa5MplHH5MkU8fdTOvy2zchkeEzrshPqGPmnjMsm1dfeFHwhz96KBBQBQkhonipBBLgfqI
X-Gm-Message-State: AOJu0Yzyn1+Dcrvb44lSqwF+mBNiq+xk5uj/dgi6zCegf+yGc4fDlXcl
	fl1sRPCOWX2CoA4sweFgsJVCXccE21yVTR/ySW7EjU594vwvUM1/bq7N/vhAfffAaQLM0wqUuLq
	ERMixzK2e6CR2iv0MoHiuHkoelFNcm2PgulHrkw==
X-Google-Smtp-Source: AGHT+IGPI0c3Vead1xPnQd7v9znU2eKBdWrGSeB26I6sczh6Ia+IqON3GZQ7bJuVZDHty0D3Wd8O0rb6YIAxcM2wQHE=
X-Received: by 2002:a05:651c:889:b0:2ee:4b17:dab9 with SMTP id
 38308e7fff4ca-2ee4b17dae7mr20882461fa.4.1719513327611; Thu, 27 Jun 2024
 11:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627113948.25358-1-brgl@bgdev.pl> <20240627113948.25358-3-brgl@bgdev.pl>
 <td5jbseo7gtu6d4xai6q2zkfmxw4ijimyiromrf52he5hze3w3@fd3kayixf4lw>
In-Reply-To: <td5jbseo7gtu6d4xai6q2zkfmxw4ijimyiromrf52he5hze3w3@fd3kayixf4lw>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 27 Jun 2024 20:35:16 +0200
Message-ID: <CAMRc=MfznDaaNcfvRBg1wpiOkyTE=Ks-_nx=aCY1MR5-50Ka+A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] net: stmmac: qcom-ethqos: add a DMA-reset
 quirk for sa8775p-ride
To: Andrew Halaney <ahalaney@redhat.com>, Russell King <linux@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 7:07=E2=80=AFPM Andrew Halaney <ahalaney@redhat.com=
> wrote:
>
> On Thu, Jun 27, 2024 at 01:39:47PM GMT, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > On sa8775p-ride the RX clocks from the AQR115C PHY are not available at
> > the time of the DMA reset so we need to loop TX clocks to RX and then
> > disable loopback after link-up. Use the existing callbacks to do it jus=
t
> > for this board.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Sorry, not being very helpful but trying to understand these changes
> and the general cleanup of stmmac... so I'll point out that I'm still
> confused by this based on Russell's last response:
> https://lore.kernel.org/netdev/ZnQLED%2FC3Opeim5q@shell.armlinux.org.uk/
>

I realized Russell's email didn't pop up in get_maintainers.pl for
stmmac. Adding him now.

> Quote:
>
>     If you're using true Cisco SGMII, there are _no_ clocks transferred
>     between the PHY and PCS/MAC. There are two balanced pairs of data
>     lines and that is all - one for transmit and one for receive. So this
>     explanation doesn't make sense to me.
>
>
> <snip>
>
> > +}
> > +
> >  static void ethqos_set_func_clk_en(struct qcom_ethqos *ethqos)
> >  {
> > +     qcom_ethqos_set_sgmii_loopback(ethqos, true);
> >       rgmii_updatel(ethqos, RGMII_CONFIG_FUNC_CLK_EN,
> >                     RGMII_CONFIG_FUNC_CLK_EN, RGMII_IO_MACRO_CONFIG);
> >  }
> <snip>
> > @@ -682,6 +702,7 @@ static void ethqos_fix_mac_speed(void *priv, unsign=
ed int speed, unsigned int mo
> >  {
> >       struct qcom_ethqos *ethqos =3D priv;
> >
> > +     qcom_ethqos_set_sgmii_loopback(ethqos, false);
>
> I'm trying to map out when the loopback is currently enabled/disabled
> due to Russell's prior concerns.
>
> Quote:
>
>     So you enable loopback at open time, and disable it when the link com=
es
>     up. This breaks inband signalling (should stmmac ever use that) becau=
se
>     enabling loopback prevents the PHY sending the SGMII result to the PC=
S
>     to indicate that the link has come up... thus phylink won't call
>     mac_link_up().
>
>     So no, I really hate this proposed change.
>
>     What I think would be better is if there were hooks at the appropriat=
e
>     places to handle the lack of clock over _just_ the period that it nee=
ds
>     to be handled, rather than hacking the driver as this proposal does,
>     abusing platform callbacks because there's nothing better.
>
> looks like currently you'd:
>     qcom_ethqos_probe()
>         ethqos_clks_config(ethqos, true)
>             ethqos_set_func_clk_en(ethqos)
>                 qcom_ethqos_set_sgmii_loopback(ethqos, true) // loopback =
enabled
>         ethqos_set_func_clk_en(ethqos)
>             qcom_ethqos_set_sgmii_loopback(ethqos, true) // no change in =
loopback
>     devm_stmmac_pltfr_probe()
>         stmmac_pltfr_probe()
>             stmmac_drv_probe()
>                 pm_runtime_put()
>     // Eventually runtime PM will then do below
>     stmmac_stmmac_runtime_suspend()
>         stmmac_bus_clks_config(priv, false)
>             ethqos_clks_config(ethqos, false) // pointless branch but pro=
ving to myself
>                                               // that pm_runtime isn't ge=
tting in the way here
>     __stmmac_open()
>         stmmac_runtime_resume()
>             ethqos_clks_config(ethqos, true)
>                 ethqos_set_func_clk_en(ethqos)
>                     qcom_ethqos_set_sgmii_loopback(ethqos, true) // no ch=
ange in loopback
>     stmmac_mac_link_up()
>         ethqos_fix_mac_speed()
>             qcom_ethqos_set_sgmii_loopback(ethqos, false); // loopback di=
sabled
>
> Good chance I foobared tracing that... but!
> That seems to still go against Russell's comment, i.e. its on at probe
> and remains on until a link is up. This doesn't add anymore stmmac wide
> platform callbacks at least, but I'm still concerned based on his prior
> comments.
>
> Its not clear to me though if the "2500basex" mentioned here supports
> any in-band signalling from a Qualcomm SoC POV (not just the Aquantia
> phy its attached to, but in general). So maybe in that case its not a
> concern?
>
> Although, this isn't tied to _just_ 2500basex here. If I boot the
> sa8775p-ride (r2 version, with a marvell 88ea1512 phy attached via
> sgmii, not indicating 2500basex) wouldn't all this get exercised? Right
> now the devicetree doesn't indicate inband signalling, but I tried that
> over here with Russell's clean up a week or two ago and things at least
> came up ok (which made me think all the INTEGRATED_PCS stuff wasn't neede=
d,
> and I'm not totally positive my test proved inband signalling worked,
> but I thought it did...):
>

Am I getting this right? You added `managed =3D "in-band-status"' to
Rev2 DTS and it still worked?

>     https://lore.kernel.org/netdev/zzevmhmwxrhs5yfv5srvcjxrue2d7wu7vjqmmo=
yd5mp6kgur54@jvmuv7bxxhqt/
>
> based on Russell's comments, I feel if I was to use his series over
> there, add 'managed =3D "in-band-status"' to the dts, and then apply this
> series, the link would not come up anymore.
>

Because I can confirm that it doesn't on Rev 3. :(

So to explain myself: I tried to follow Andrew Lunn's suggestion about
unifying this and the existing ethqos_set_func_clk_en() bits as they
seem to address a similar issue.

I'm working with limited information here as well regarding this issue
so I figured this could work but you're right - if we ever need
in-band signalling, then it won't work. It's late here so let me get
back to it tomorrow.

> Total side note, but I'm wondering if the sa8775p-ride dts should
> specify 'managed =3D "in-band-status"'.
>

I'll check this at the source.

Bart

> Thanks,
> Andrew
>

