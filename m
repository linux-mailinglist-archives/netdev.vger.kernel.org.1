Return-Path: <netdev+bounces-108273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EEA91E963
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 22:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F726282D01
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71C1171094;
	Mon,  1 Jul 2024 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Q60WqDUi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6716F908
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864967; cv=none; b=oQaPfWaPLAlnWybx2EamxbtCycfMvhRq1H0EJlGKyJBqQgKrffFbWjPQADBgOwU0etgfRKua9wz/FycUsB5rILGEhZVg+ee/R1na2mMu487zGpd/t4rYQgpkgxCfWAIs8B/G8MyB2IYCwD7c8p/McnN5FQhZfZS6WfYvFPVdZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864967; c=relaxed/simple;
	bh=8BAeJrhfF4MjoWK6BCb1lGegZfneASgqj+Rvzy7n+rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiUSIiQcSngF7Qxg2JPraMt2TTNwUL9ShVVQufVpsgy+2qU42lkrc0ZuPjzUuD/bvOxK9JnU63rYD+0AhrRxGVTG6A3TUtmR9mTzPjs+aBV1mTGVpl883wQvu8XcsFDh5WzRjeCyCAu7ydNlF4+k6tVEbjwzsXx+6/Z7G/pINBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Q60WqDUi; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso39816311fa.0
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719864963; x=1720469763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/7AZmTT+AVERGwwpJNjGUJrmrBTr7GP14K4O8EWIlY=;
        b=Q60WqDUi3pqLWriq7fVrADnm2JxdRl9Qu/HKPaI6G+kwuZOdvFAHvcq8ce0veiz3J2
         q5/3hS3OSDnCx5eT6fd5KXRqvPar4dHnHL3z0brtWdKRPeHmv19B13aIrIOVt6g8/vae
         I+YVodCB6mnvzHE74vmPDmA7GYyE7LH/nShXNeyqxvZPFvMMG1FTgIPj+0t/tex6rurM
         bC7As71en6Bv/3Jgs/VTgL2JPskQHrw0r1x7iJuzOiLbBAckdfdHGVhCU2lu/OzZjTZQ
         cqqUwEwjsUFWTfCIBlVyHWJ2I2nxfVXRykaQfi0wfoKzfOFufq1BdOZ5KpzKC44MuiT+
         mCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719864963; x=1720469763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/7AZmTT+AVERGwwpJNjGUJrmrBTr7GP14K4O8EWIlY=;
        b=sb6FdVkuwXJ83oKyIvzuGNGnXZICPi6PPeDlv/sSR12agwGmBWuBG+aXTD+tpSaJNR
         gNu3YuUhczBJ+mxDxx4StFMMcNvPyIj65E5OflqXKlqWiZNMAQfkCMEIPhfaZlxIzwRa
         pyIKrXZrU/X0RZwNbuCus2t5bm8QVOhUET/uDKWo7lhaL2HrsBaPEi1pamzo1yijpmjo
         /dooXSfMBRM2bqtD8gmAlLPWoD/LysvxwdYTAJXZO4UkVgBe4TcyrHQgt2/8Z/X9pMPC
         kFazn4pulLJroWkuHHRWn9r5NdBdcrEwDGDZcqoIGhOxNiCyzExNbbOPadT0aZQjdm2u
         cTjA==
X-Forwarded-Encrypted: i=1; AJvYcCV2y9o1Heks4FqQRDSTcTceuV5LZXDE4cBfdne41uKoC1pdX9G0+26RuGZbauthIb1I4xIxvPqapBa8+L7gT7cZ7KiLM/9z
X-Gm-Message-State: AOJu0Yzaw4DRkF0h9UynaUpuFaNexaTlNH1m0zodyZIXFiml7WZ92MHQ
	Uzsl/eXKIqTScFab7/4659mzZNP2s+hoWUuT/Qigqhi2K9qykykWK+NGI0D1R6xDUt1D+S8BEpH
	0kDT8RxJFT760d3FfCLmqZETm6HxPGvlA3Ic5jg==
X-Google-Smtp-Source: AGHT+IEKAZ0mm0RcxwgLcfbN1Y6EDGlhonP962JD5DjNt0v+wIWUTtByp8xBB5E9Sy3ozcPBuqs8cSZzA/gNt5LZ0dQ=
X-Received: by 2002:a05:651c:b0b:b0:2ec:5c94:3d99 with SMTP id
 38308e7fff4ca-2ee5e3810b7mr44548691fa.2.1719864963002; Mon, 01 Jul 2024
 13:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627113948.25358-1-brgl@bgdev.pl> <20240627113948.25358-3-brgl@bgdev.pl>
 <td5jbseo7gtu6d4xai6q2zkfmxw4ijimyiromrf52he5hze3w3@fd3kayixf4lw> <f416e06e-e354-4628-883b-07850f05e276@lunn.ch>
In-Reply-To: <f416e06e-e354-4628-883b-07850f05e276@lunn.ch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 1 Jul 2024 22:15:51 +0200
Message-ID: <CAMRc=MdSte_7MSfR1DAH8fHpHWcOfgPX2SO9DR1UnXrgvMDbdg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] net: stmmac: qcom-ethqos: add a DMA-reset
 quirk for sa8775p-ride
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Halaney <ahalaney@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 9:37=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Jun 27, 2024 at 12:07:22PM -0500, Andrew Halaney wrote:
> > On Thu, Jun 27, 2024 at 01:39:47PM GMT, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > On sa8775p-ride the RX clocks from the AQR115C PHY are not available =
at
> > > the time of the DMA reset so we need to loop TX clocks to RX and then
> > > disable loopback after link-up. Use the existing callbacks to do it j=
ust
> > > for this board.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Sorry, not being very helpful but trying to understand these changes
> > and the general cleanup of stmmac... so I'll point out that I'm still
> > confused by this based on Russell's last response:
> > https://lore.kernel.org/netdev/ZnQLED%2FC3Opeim5q@shell.armlinux.org.uk=
/
> >
> > Quote:
> >
> >     If you're using true Cisco SGMII, there are _no_ clocks transferred
> >     between the PHY and PCS/MAC. There are two balanced pairs of data
> >     lines and that is all - one for transmit and one for receive. So th=
is
> >     explanation doesn't make sense to me.
> >
>
> Agreed. We need a deeper understanding of the clocking to find an
> acceptable solution to this problem.
>
> Is the MAC extracting a clock from the SERDES lines?
>
> Is the PHY not driving the SERDES lines when there is no link?
>
> For RGMII PHYs, they often do have a clock output at 25 or 50MHz which
> the MAC uses. And some PHY drivers need asking to not turn this clock
> off.  Maybe we need the same here, by asking the PHY to keep the
> SERDES lines running when there is no link?
>

Yes, there are two 50MHz outputs on this PHY but they are not
connected on this board.

> https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/phy.h#L78=
1
>
> I also wounder why this is not an issue with plain SGMII, rather than
> overclocked SGMII? Maybe there is already a workaround for SGMII and
> it just needs extended to this not quiet 2500BaseX mode.
>

Well, you pointed out that there is a DMA-reset-related workaround in
place for ethqos so I tried to reuse it in this version. Does it
count? :) We did establish that this mode has no in-band signalling,
so we should be fine with the above solution after all.

Also regarding the PHY mode: on a rather non-technical diagram I
found, the four SGMII signals going to the MAC are referred to as 2.5G
HSGMII, not OCSGMII but I'm not sure if that's just naming convention.

I'm still trying to get more info but it's taking time... :(

Bartosz

