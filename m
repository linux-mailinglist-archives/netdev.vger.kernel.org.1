Return-Path: <netdev+bounces-110158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0218A92B210
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3001F2181D
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC79154434;
	Tue,  9 Jul 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ps7cKKMW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233415252E
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513392; cv=none; b=miEDBDvkjnYdn+LiToCRIBfOYx/wp8i3DaUodjhlTiWzBHirKWlJxBj3ctPw+aNS5lRHD7eeJzSmhlje3RBzXMscbEZLQ8tMhmcolV2YdQ8/2ipsCZeKDY4afswLqlNP5rUDwGcHuuwPTmTuurtMEVdgqlGjKNDwbBA3BYXFmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513392; c=relaxed/simple;
	bh=7Z6us27qIuTlxBXAFyHcsMvVHOHakLdFL2jtnKejVHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJD+ibtFECDABtLuqql0L31Jh2hkQltz8wlFqe+u0gRSB9Xaid0zMdgweK1OYNoXYSmdOkl3zam9uDXAF4IWejhwBy8OTHTFJqKrdoacyoIks9OV8p4HGAh7Ih0L4xqZ1jHuSdq/KPolfFMj96ZpVRVtIY2iZZ3mNMWTfeVVKEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ps7cKKMW; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so30705881fa.1
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 01:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720513389; x=1721118189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HGUof91eotwEdfihh0OBz6TKkOSwGergxDj8SELw6I=;
        b=Ps7cKKMWaMTKxEmOaxW2SSN1nAfCJPz6BUI9yUb5R+1Hm2jZP6T8nfYP/vZjlowFcW
         hIBH7U7vvLaGuaIEM1P4QKmFqkOe8Oc1X8cenBPAM1GSzTUMn/y46cDEu4F0dYX0UZoy
         riRBiN9OIjZ5RGna8dNQ1pZwK2uVKWZyVoBOykaEiahCfzw+qfhcYizaHC0icIsGlaDE
         V08bdSUHK+r3Dl7wvZoe7i5/3wj3+J9MglilMO5HVGLXv+Oeg+4KcDw7nG5Y1Hrlehag
         qNEOkyMYEVCnfaFOKxbC/QXQWBMCyK12gSnHRRpW2h2HfbYOiXmRumYVjBsru+v6w+L9
         JtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720513389; x=1721118189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HGUof91eotwEdfihh0OBz6TKkOSwGergxDj8SELw6I=;
        b=QlgiK+KX93vJUdL+BWd2blxD3TH0ShP1m6IWSjzABiFsVxobUKumrcmcl4siQGss7D
         HzZZ0Qs/KNPd9hvmf7jUHeFBQx96H0n5xRnLYuJc436hdG5brrlq8vokMANQZtEugf/m
         LngClCjB8l/5zkQky6fK5nFvXXy4T0d5zRVGqDaSbCeI0JfjnejcPMlXaGVYQIbqvZt9
         THp5u2/rBtRvK8MIHcVkQJEVia/uuNYRDE0bIHgtP00rjhQEXDLPoDkarVS4S3+eSPS9
         7zYRVdfaUdF+MVtANPdaMdseKI53+6W1PvDGyj+2Pu5UyZRGa8Ypnhn5AJPOwPqTt75c
         Hobg==
X-Forwarded-Encrypted: i=1; AJvYcCWux/QRzjvGtuQHFiIfViosZJ2g8EykwPo70IkiLAOvwumUOmW888cQ2ISoy+/A9d6ApsBB2efYPFUaz5yxc4ruPRerqTU0
X-Gm-Message-State: AOJu0Yy1Rh2egXcny3hbHHx02O8vwQDZeJ/Qiwiy8roN8sJw8voQqxSo
	P0WzRuT0y0i0u0KSb/LShRGwym0s3cNaGamxLUGv6btslKg7PaXMBsq5Dr72Ph8ZhTpdcsLPoi9
	xDby/CzTwPqvXrOQJ2Eh/hGEibUQ+hLg1Wi9bgQ==
X-Google-Smtp-Source: AGHT+IEjr783ZzbCEinWzyI7wDmtA25dbr46RPbhoYwSLTpW27laIhd76XiAAgguwAZROdppDcw7BBgS+Ujd64hgPcs=
X-Received: by 2002:a2e:a316:0:b0:2ec:5945:62e9 with SMTP id
 38308e7fff4ca-2eeb316b47bmr13784661fa.32.1720513389359; Tue, 09 Jul 2024
 01:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703181500.28491-1-brgl@bgdev.pl> <172049643096.15240.14162761125981219295.git-patchwork-notify@kernel.org>
In-Reply-To: <172049643096.15240.14162761125981219295.git-patchwork-notify@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 9 Jul 2024 10:22:58 +0200
Message-ID: <CAMRc=McHFoVEJrMM6UpOZY2Ct7PvuQd-yPeWquUPNYHfDYkSww@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/2] net: stmmac: qcom-ethqos: enable 2.5G
 ethernet on sa8775p-ride
To: kuba@kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bartosz.golaszewski@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 5:40=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Wed,  3 Jul 2024 20:14:57 +0200 you wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Here are the changes required to enable 2.5G ethernet on sa8775p-ride.
> > As advised by Andrew Lunn and Russell King, I am reusing the existing
> > stmmac infrastructure to enable the SGMII loopback and so I dropped the
> > patches adding new callbacks to the driver core. I also added more
> > details to the commit message and made sure the workaround is only
> > enabled on Rev 3 of the board (with AQR115C PHY). Also: dropped any
> > mentions of the OCSGMII mode.
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next,v3,1/2] net: stmmac: qcom-ethqos: add support for 2.5G BASE=
X mode
>     https://git.kernel.org/netdev/net-next/c/61e9be0efbe8
>   - [net-next,v3,2/2] net: stmmac: qcom-ethqos: enable SGMII loopback dur=
ing DMA reset on sa8775p-ride-r3
>     https://git.kernel.org/netdev/net-next/c/3c466d6537b9
>

Hi Jakub,

Does picking these patches up now mean they will still make the v6.11
merge window? If so: could you also consider picking up the associated
PHY changes[1] as - with the DT changes already in next - this is the
last missing bit allowing enabling the 2.5G ethernet on the
sa8775p-ride-r3 board?

Best Regards,
Bartosz

[1] https://lore.kernel.org/netdev/20240708075023.14893-1-brgl@bgdev.pl/

