Return-Path: <netdev+bounces-102768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002519047E6
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 02:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E491F23906
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 00:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1619419E;
	Wed, 12 Jun 2024 00:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERmB5so1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21517C;
	Wed, 12 Jun 2024 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718150600; cv=none; b=A8OUlL4HSQfDr9XSeSr3Y4mBkfmJzLrSmiI5nuQfmeh6MEwXj3/UQn3AyyY4qzoRmA04XNkrkS7O88scmF5v5HD4lDRpLnTdKUv8KaUYhE8qKYUK4tDksy65Rm8vRMAG1dGlQecx41eidGnViX5HRPzKizvsbk66x62NHjX+xws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718150600; c=relaxed/simple;
	bh=CfmyTtQtTR+NEjqwxQHjbPbQLc9kh23HqpCVVQcN7s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdzhtnfRSvmH5P/nxnzqa5x9ITySJHZ8+emm4Mc9viSSeiB1C2Ofnj+vkTMdLnt9esfCAh3lX7zecc/5ciO1/3yAPouvfd3W1mlsqpfdJCOReDVtIxkW9EVjFKg7zdQZOxnHtAQ3evDoaz/6p8uX2qtFcVVeWG2ZHes/VU0firE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERmB5so1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c8c0d73d3so3382038e87.1;
        Tue, 11 Jun 2024 17:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718150596; x=1718755396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfmyTtQtTR+NEjqwxQHjbPbQLc9kh23HqpCVVQcN7s8=;
        b=ERmB5so1mgkNHOi7TrQgHedrn6UmFfsNudHIvGUkO9GBN9huFn30RiELRhR5ijc1Mq
         PGtnIpJNxQe7BVgtLkx9CPpi3fPnBD0bxPITFg3TxvyFbkFm8PD0wzd7+99K8vNGILKT
         ECVP9QpCwlKSBpU/WrfOQvuQTngAHAwYTQqi3VEaCByiFL0TONco2sCTA+GiVIy2isql
         Aj0ebDxcVDGJSI1szvw+hrJiICnBpAVeRk3aiLgqq/lVYacCDDLZIwXNtCjogdlHDXkB
         YO3+JYkzC9zHPCF5PThHJ01+4SCJh+sKNTO3y96tw5u3VFx06K8/M1bw/QeW6s7K6NMl
         hNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718150596; x=1718755396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfmyTtQtTR+NEjqwxQHjbPbQLc9kh23HqpCVVQcN7s8=;
        b=Je1dntzzlyqjIvb48gDVyKZ1FLG1YsCxkf3hvKlp4MpEzvrRFuRAYp8UF6YhrgZVIU
         APDqQFakdybxPM1mepqMwhV5kV7tFfhUdNAFUhO8lB7NidGOhk+4Niay35OL9YLrddOG
         shtYaETFPclUdzggzp4Hj9siQvrLprksGcBDNtU9Pn8VTk+DxxeTAQHHKlR61w4PhrG+
         HPkvgd4UkQgn5OvX6bS6RwwVcntWzrp6XcYlASMaZBMdDKuAFNlgOawmAFxtopnfQtlA
         Ih4GvTHia4gAcGWDK9+PizcxGHbOtZMll2B0PPmpD+DonuQWmLjhGDD3zE3sTi5cWIKh
         4K8A==
X-Forwarded-Encrypted: i=1; AJvYcCX0wi8ZTPLETil1XJAaQO9BAI4weiccsGEVkxpwrSB5+K92cVYmP6spzm4LOcpJqk3j9WDkBTDfcVgPqh33kyZ167ybcm2g99yQ0Zmrt3kuCayqyBjp9Csb7sIvi8htjgyn60iY
X-Gm-Message-State: AOJu0Yz+2BrW+2rh9HNyvXRvP4DcmZDm9qnKWDIYrXIbQ0ijxSukwWLI
	WpEgJ0t5KEQfSivZjEm1G7xgZmcdHmtQJQhzhwFygnxZ1GwNd64oYZWDrjP7vWecOyumOgZpONK
	0n+I4CjRWCTaAkrhhR0XW8/KZH4w=
X-Google-Smtp-Source: AGHT+IEBVVvYLSGYvm4uf1GOSV5JMsYxcpBlNHTVh0/GQvXEgkeNNjR+vtvzEvRhncIOCmt177HI2gV083bAUyjEonY=
X-Received: by 2002:a05:6512:2004:b0:52b:b8c9:9cd7 with SMTP id
 2adb3069b0e04-52c9a3d1c0bmr86074e87.18.1718150596124; Tue, 11 Jun 2024
 17:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528120424.3353880-1-arnd@kernel.org> <CACRpkdYOb3S8=EffjE8BpP1GTu5SWSEyorJ7i9HA2u7GQexwzg@mail.gmail.com>
In-Reply-To: <CACRpkdYOb3S8=EffjE8BpP1GTu5SWSEyorJ7i9HA2u7GQexwzg@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 11 Jun 2024 21:03:04 -0300
Message-ID: <CAJq09z7y_Hfnmgtb+0+Fh7cnAL==xoExr2e_GfSk6SMPD7yPig@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: realtek: add LEDS_CLASS dependency
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Tue, May 28, 2024 at 2:04=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> w=
rote:
>
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > This driver fails to link when LED support is disabled:
> >
> > ERROR: modpost: "led_init_default_state_get" [drivers/net/dsa/realtek/r=
tl8366.ko] undefined!
> > ERROR: modpost: "devm_led_classdev_register_ext" [drivers/net/dsa/realt=
ek/rtl8366.ko] undefined!
> >
> > Add a dependency that prevents this configuration.

Thank you, Arnd.

> >
> > Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb"=
)
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> I tried to create a separate .c file for the leds and stubbed functions
> for the LED stuff, but it ended up having to create a set of headers
> just to share things between the different parts of the drivers and
> it was so messy that it's not worth it.

Thanks, Linus. I'll give it a try next month. For now, the fixed
dependency is not a big deal as this switch was designed for small
routers, which normally have LEDs.

>
> Yours,
> Linus Walleij

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

