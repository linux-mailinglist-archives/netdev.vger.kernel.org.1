Return-Path: <netdev+bounces-79037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4002C877800
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 19:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BDB1F21028
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 18:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55912383B5;
	Sun, 10 Mar 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJNxaL9Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F861E516
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710095620; cv=none; b=hvAZWo/yQ9p0Ga9x8n8Z6IlWa2vpGOXBEYRjniu+/7S1cl+rCAZtWo/Ag8pnLKJTN1xwzy0qBOlfnvEcXmpVcDEaHq5TRLvZoVj/VVGWZW02WhANUhpF3Yty/xLAE1juj/MAYtqifbjtmwqcsr007wYDbFjoPwqXGGA7TJ7wK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710095620; c=relaxed/simple;
	bh=MmuHHmxJmjWcNPf7DeIDPD3TRmMZ/XQvYTWvLXfrFtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cez6dnsmgiuIM7DO+MTjEoADSASBtFwaMS3F3ckwbtKVt5UmUKneROPinda/RI5GfxdGeQfFcNC9GTr9gEcG1/0Uf8MZqQgrBkD5mL9uDIx/atyHP089Ube3PWDqUwRGtguqoEJNJQCennSK0ATrTJ3SolTfZeJ63fxiue1uYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJNxaL9Z; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6098b9ed2a3so33951797b3.0
        for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710095617; x=1710700417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmuHHmxJmjWcNPf7DeIDPD3TRmMZ/XQvYTWvLXfrFtY=;
        b=IJNxaL9ZbyiZvbHl5PplSI/1TSB1LuRZE0NnCAeh/URtWOG4ZXcJEwZ0FsiYjaYu7a
         S4QBB5kKPchnaZ1cVZHBRrV44RG6k2+SfBOmKLjdohk5ptHOIVLndKR9N7ci26f5SlTA
         mmBtprHg+sd0wNUWC6p7Hv1RJ0vbI16G2cDo0zt/i8F22q9DDZ8t5un1GWzuNCF59n+n
         VQj8lysM4Tdo05V4lwnBjglNLLh4PxH47GTu/e4xdsyQ68fDCk6bSpH1GNeczK4K7ek2
         V7+NB+pQb+4P4/fG7wAsVhEfOekr4lsC8EphzU9O1zCFcLORxNxRxhFoGBT4mYYUyZRL
         UV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710095617; x=1710700417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmuHHmxJmjWcNPf7DeIDPD3TRmMZ/XQvYTWvLXfrFtY=;
        b=jgfdcjmHqezUgnazHlTbUAsooSHFTGGhQAbqg4FsbUW07jni960P5edG+ho+vGw7RM
         jeDzuq8El7IMZFdbNx0fhW4EzwNhh6PbjSK7DmleBur3RoL2OocyQifsn0YnFN6bc7Aq
         ZjngWPlTd0KEaHzYi5eO70J4Ly0Hy5zR4KKXN57AFEQpSt5MDPby0kQDkik+qaMc8yfL
         7XwIB8hO4xSU+brchH14rqx6tKZIQmeJsm2TQA2X0iv+di1yh6EJx8dKj0bTfTl6HOOO
         aI+x+feI+wzUzS2qUhhRtToFplpYjHtnryP2SYMr9kQd5A1VcMBM+5+NIyJggtHjYmD9
         JzIA==
X-Forwarded-Encrypted: i=1; AJvYcCW3HhmcstpR9VakChAYKPYNWt2dOTMXR88AAHuymMUQR/ykfmxW4pw1BEK4hT6EQe/0ZJHFNAxt4VMFnd6u07s6QtDSPD1D
X-Gm-Message-State: AOJu0Yz+tu5EThFymT5OAowf52utONyClOp3BzknuESv9vGEg8FkVmus
	h7lRcB2co21RQcHn/cILcaPXMJ3JcTUMAS1SQXa2imhRr4Os/ROJONBVlUNtpbMmZ9daeIZgFkd
	T0SncEGXDvjw7JegWBu//l+BLRJSvRo8jJ1Yaeg==
X-Google-Smtp-Source: AGHT+IHk9/MZKfH04meNx0eo0VkRFv/IXxZwyToHYYJmCwjWJCWpR3X7GXee/M5l0I1grTFtDjTL9/mR0bD01Xz2tOI=
X-Received: by 2002:a0d:f141:0:b0:5ff:4959:1da8 with SMTP id
 a62-20020a0df141000000b005ff49591da8mr4341361ywf.50.1710095617659; Sun, 10
 Mar 2024 11:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com> <20240310-realtek-led-v1-3-4d9813ce938e@gmail.com>
In-Reply-To: <20240310-realtek-led-v1-3-4d9813ce938e@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 10 Mar 2024 19:33:26 +0100
Message-ID: <CACRpkda0pPwW34QyrKYBOsztPhTdCiZ5cop0T9TP7DFTn8d6cg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net: dsa: realtek: do not assert reset on remove
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 5:52=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> The necessity of asserting the reset on removal was previously questioned=
, as DSA's own cleanup methods should suffice to prevent traffic leakage[1]=
.
>
> When a driver has subdrivers controlled by devres, they will be unregiste=
red after the main driver's .remove is executed. If it asserts a reset, the=
 subdrivers will be unable to communicate with the hardware during their cl=
eanup. For LEDs, this means that they will fail to turn off, resulting in a=
 timeout error.
>
> [1] https://lore.kernel.org/r/20240123215606.26716-9-luizluca@gmail.com/
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

The commit message needs some linebreaks :D

Other than that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

