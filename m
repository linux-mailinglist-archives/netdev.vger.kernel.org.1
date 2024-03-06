Return-Path: <netdev+bounces-77829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31171873228
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CDC1F27DF8
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 09:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F3A605C6;
	Wed,  6 Mar 2024 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="od7K+B61"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C715604D4
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715829; cv=none; b=AnGzHdGu+w1IKGk4U5JgdXGH1P7SNUpRdJ5N+XqS6AtBJA+ydY8vEhKbvXAe2IZ/u9cP0RujDjc2ZiNofOvRu5KxDlUjfAKI99W6nnKvVoloqho3WVtRuSNY2CBz1YWmk5a/EMzITBrq0gqZTzvnmoy/sbiTNBpUCSNQX1hqbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715829; c=relaxed/simple;
	bh=MTuT19JZZrNFRbGttqnosgvFkNW3Quab1xPTgUgjTkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bInrdrBkZfyQ6XrpmLHqOd1UNhjB9lW788gHj0gl6X8RK+DNgkVJVp+GX2NbGTv2cC0ZB5n6mILnR9U65CGBMMbCAonDfZapHF2Le46+eK2fBlZe/LszTojIRG8K+A4Wzv3U5/e8MACSqW25BbtNd/A2dyjwG5GDk7GBf4++2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=od7K+B61; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6087396e405so5551617b3.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 01:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709715826; x=1710320626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNKZ7A/WJk+lPfE1tZuzbZKiRTIcPzY9aV6hM5q3yvk=;
        b=od7K+B61ICqiSV2r+bJYXxEjNrAF+U6hf9WGdvO4o/y2SoeykxBk3pEsqkzJrDKHQM
         VvhGwPjogB93w+LCDhmd1shcwc17iNJ9AB/bXxJisUiYO3RO6C+I65fdoAnqWpYvXOVT
         2DgSL8lM3jvbrHUOagPAdrakvUpBVVwDn7A8Xd+objgdx2/CKirWUufbvHL+9bkz0G3A
         +zZ1sZMbSjbKpQPgTQ1PFgoEB1C+vS93icOT1ES4vcTc6/VUct75glOSB7ZOt0jGOJql
         MgsFywiik3NzNbT3+sJfI5W3Rjza2VFfhU6/1XGaeB7SNwLFnkqQvqiLAZjrxRwqNCVJ
         a8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709715826; x=1710320626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNKZ7A/WJk+lPfE1tZuzbZKiRTIcPzY9aV6hM5q3yvk=;
        b=IzrWTTax+s6wGDc7b0Z5wIPdmAKDXe1MLaKjTH6F2adBzEaB41Ruaob4cydJWfN7WG
         gVQu3liZ7W0gKbGgaNcDB5mOlhX252JUr5Ty3Ycwui9berSScj1q26QpjgNdXPMY8bRh
         pRymQkzOIDvgeJ0tFGoYSb7KtnDPjox+N6ekToKzK4qsaA0N/I7pI9ZOoEKRD6tdsHBi
         FghltDMqK+iYwQcMyIPXuUYgf0N6HD38IUMUqwOWO9/Pys+hHaeVhElxbmL6Kb7cZLXc
         qQPSJFBaQ1il/SHUxF2FrZkjLpb9XhbH29DmKJsV3rGB3BgBXXbBGm9oad00uwvQy6Ni
         sDdw==
X-Forwarded-Encrypted: i=1; AJvYcCV74ZOQ7GKgcYa9RK1apxEm4DsLKpLEg0MPkwLL4OFVQrPjHUwbrmkBMsoECtDqU7708uEJDrGKujg7OLRvhgNCc2BpxHqj
X-Gm-Message-State: AOJu0Yx4k9XWdHH6xG8+jwG9fEDJmNb01MpZuMyoqUN+bBXxc6GgEBkO
	HHGcCrKggJ9z8V0yl9cjzdFWokQ0aZabEVuaAz2gSm7nPBLGzmpQEpizFqC5E3x2mnMRuaJpJn0
	+oD4b5YE7sfG8EfWKlvcKkVQhG6L5EduFuEBe+A==
X-Google-Smtp-Source: AGHT+IEq0l4q0PGKGt/n9ZV87AxjL59m+ib2AxsDu8+ir/Z6fft6885YjPaR5xoKLN5EeK7eKL/Ps1HmkmZxbVDhpYg=
X-Received: by 2002:a0d:d894:0:b0:609:e180:5e67 with SMTP id
 a142-20020a0dd894000000b00609e1805e67mr119509ywe.25.1709715826481; Wed, 06
 Mar 2024 01:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <CACRpkdY1QfeqRfU-doq_qss8VzgWo9jLnULQREGmHPqsgpqWaQ@mail.gmail.com> <51913f10-892e-42b0-b609-c4f56878c473@gmail.com>
In-Reply-To: <51913f10-892e-42b0-b609-c4f56878c473@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 10:03:34 +0100
Message-ID: <CACRpkdZ7s2kNOFjG0v7U2xBtw8Ri2UTOxhQ2sa6_2KjkFsOA=Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/16] net: dsa: vsc73xx: Make vsc73xx usable
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 12:28=E2=80=AFAM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
> On 3/5/24 14:45, Linus Walleij wrote:
> > On Fri, Mar 1, 2024 at 11:17=E2=80=AFPM Pawel Dembicki <paweldembicki@g=
mail.com> wrote:
> >
> >> This patch series focuses on making vsc73xx usable.
> >
> > Can't help to think it is a bit funny regarding how many units
> > of this chips are shipped in e.g. home routers.
>
> How many use this particular DSA driver as opposed to an user-space SDK
> driver though?

They don't have a userspace driver either, they all have a kernelspace
hack on kernel 2.6.15 or so :/

https://github.com/linusw/linux-SL3516/blob/SL93512R_v2.6.6/drivers/net/sl_=
switch.c

> Do you have a list of devices, so I make sure I don't buy those :P?

- StorLink reference design SL93512R (and the rest of them, and later resol=
d
  from Cortina Systems). I got this from Imre Kaloz who got it from StorLin=
k.

- ITian Square One
  https://dflund.se/~triad/krad/itian-squareone/
  https://openwrt.org/toh/itian/square_one_sq201
  (The place where I started this switch support.)
  using the same hack as above.

HEY! You sent that to me :D

I think a bunch of other random router vendors copied this from the StorLin=
k
reference design as well, I just don't have all the Gemini devices.

Yours,
Linus Walleij

