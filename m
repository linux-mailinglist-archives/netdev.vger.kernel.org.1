Return-Path: <netdev+bounces-102033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28489012A0
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 18:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6ED91F2194E
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358B0179675;
	Sat,  8 Jun 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6TKevMO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6B5524C4;
	Sat,  8 Jun 2024 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717862613; cv=none; b=b3ooIILy6lYbck656Qsz/aucUNUFZcX2dc0aH2EuscFmK0ZP2grpMKWIk3W0lXpypiDWGScZ6/Ua05EBPqML+lyqyxDk77xIyWiy8FfVfuELt1+W+YGjspeZKN3x8Hi9SfyXAyC088l1Me/cQ9K/FIG7UAUT6F0Cm2DnlFH7LUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717862613; c=relaxed/simple;
	bh=DVCcvAEZkk+J4XLaV4zyh1uIJlCOuy8yqlyWyqCZ1Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crPbMPcrQj07i1RprICzQTwxglNRQbZL082+9mzP6zpVyr1uBS3FtOFPD6bZ8g+pXNRItM4hVkyimCIjn3Z/KJiexz1LThgcv1QIURdAjpmwrvvW81kGcdpfwMihRywsh3FyYiOx8KsIhhy3G61z7l+VFAbvpZwhy9j5FfIfRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6TKevMO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so3602495a12.1;
        Sat, 08 Jun 2024 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717862609; x=1718467409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVCcvAEZkk+J4XLaV4zyh1uIJlCOuy8yqlyWyqCZ1Aw=;
        b=H6TKevMOZRWB8mSrQOtWdMZPuINN/lm0Tuz6DCkQNo/zNfSdA7UOWX2D3ATtpbWogq
         sCct5y/rG7K5BET3Riw9TULDZJdVNfq+1sKEgSoqfgvA5Lgk6FCAiP5UPx0JDYMLQ7VO
         1Al9A5NjSBsTlyjWJspV5opsjTsl2Wf2u6L+57e+i2kA4QbElLKLSM3XNzvo1ChANJA0
         0HkN4lPNh2aLSyZKW97v1hZqRyCDyTjfcOcmDrF55YHFRJDNiojVnfvfiOVHeGDbECol
         fGk75AmUsGHgKpi4avcJoEUkl5Wu1P9mtFgDl8ujijwDChHFzyGEllCJdo5fC9mtsH/R
         /gPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717862609; x=1718467409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVCcvAEZkk+J4XLaV4zyh1uIJlCOuy8yqlyWyqCZ1Aw=;
        b=kFfm2q/xUHx+JlOtaP/g6Kx1Atio1ZLdyDLw2BB1mHYyuMp0dc0gnYIx8IGDo225+r
         Z0zt0lVSg84GmVyQWlFNJvUJQBf/hyqZTT+GsgdZriHagFXJhnz7NqraRlUyiWgTIOvk
         ++6xjFNX/fo4rAdpmqJkwnG/Exwb5vNM9ugpOf+Ui842vXcLVXkTLVhzdLxHQhNtml3u
         5kQKVhHtnudJ8KXgpZ9audvf3lPzQUiD5pf6Y4aDvgQNfuje51VCTwHQt2NUH+8i0nml
         jzrZ06of4XkpxGlOxdI5mLNPFH1YgJI6+uyZY9gN77+2YdhNFhChtXXTJ6rrao9v8V/T
         am4w==
X-Forwarded-Encrypted: i=1; AJvYcCXmN4oNVOumo6kJ5OKp9JCMBH01OSv5/KGo0vovl79dHVqlSW2I2v9cX33lXGUWTbisDg4qc8K+5+RANX0oqj29a2GlDJvzCuqu1O6OY5WnFtjsjJ0KZlm79iVTnI46Hkrqjmn4
X-Gm-Message-State: AOJu0YxJxGgZUdUNyBbQ7/1hPxv1H3UTSuvyUiBYV7kX99rn8EpOJbwb
	WwHvEHHUa68lyw4zEtwFK9HK67KDkbqGTLJXrSgbH0Kbj1v0utFeYnF6Pf40rQPY7zQ4udZnOMR
	vSY9F+VwN3vi+HaBTuvSDMuhOb9Y=
X-Google-Smtp-Source: AGHT+IE8MGT+M1jvE75XSLCBtvXLzkQYO+2PWbZTvvHID/fnMt4rNDUADERCPKOhezptB4e0I8ICp1BjpVkB1JunR04=
X-Received: by 2002:a50:9509:0:b0:57a:339f:1b2d with SMTP id
 4fb4d7f45d1cf-57c5086e237mr3547214a12.5.1717862608805; Sat, 08 Jun 2024
 09:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528120424.3353880-1-arnd@kernel.org> <CACRpkdYsFBw907rH4pmgmA6R=0FsOac7-_2xzqP8vu=aVS5JJQ@mail.gmail.com>
In-Reply-To: <CACRpkdYsFBw907rH4pmgmA6R=0FsOac7-_2xzqP8vu=aVS5JJQ@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 8 Jun 2024 13:03:16 -0300
Message-ID: <CAJq09z7O7v4B50jXCA5ipv73vhtb=yxY-x6Wt_9Tr62st=LQpw@mail.gmail.com>
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
> >
> > Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb"=
)
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> The QCA driver in drivers/net/dsa/qca/* instead makes the feature
> optional on LED class, so it is in a separate file with stubs if the
> LED class is not selected.

That would be great.

> Luiz do you wanna try this or should I make a patch like that?

You can do it. I'm a bit away from programming these days. Thanks.

> Yours,
> Linus Walleij

Regards,

Luiz

