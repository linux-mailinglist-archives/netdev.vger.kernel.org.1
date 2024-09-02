Return-Path: <netdev+bounces-124111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE806968158
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784081F21E2A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 08:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556CC17DFFA;
	Mon,  2 Sep 2024 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KpRh+uVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A6015573F
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264289; cv=none; b=hPm1daiNj+qmABzG5ptdalfCAKCRhoXrVOtsyPjRGFE7RKEdXJJQZcwi6uMnGrBmrdRBnACmnWoQz2mjzZeGwj2hygrPpuz4KzYMoLu2Qrgs72lAaiMk3jwNf9A4L73KudJBGsQ7IRsCs+y8lK1Xk0MXl8XnZ4L7om50Av7AXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264289; c=relaxed/simple;
	bh=+UTkjM/YpFeicUPaHWpIAijZq8DD+lel03KrAl7Eqn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQKsaYVENqVuKQKRctOz38LD8rWpIuVJo2LCvCgzTMwP7wYCuF+SsSy1PxO6AIf/2bps+1w6KjS/9FMkQMbK74llb0/cuw2quB9gUaHKWZo75+42EZytbJVec2UAe4L0pRY86eMnZvDXzR7IgWEyPfgQlqItY5SSHRzmlv3r5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KpRh+uVV; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f3f07ac2dcso42921591fa.2
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 01:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725264285; x=1725869085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UTkjM/YpFeicUPaHWpIAijZq8DD+lel03KrAl7Eqn0=;
        b=KpRh+uVVyE6rv3WYK/eXnl8mE6+ez2C4Cu9CukSxOFB5pSVO3r0UEPece1wwLiO1Qv
         JO21Lpg26PewAGKRClUfCAxkxtImWx2g8Zfo2b5MEkcHzD3ofzsjnO7Y3RbeRs2JyXvX
         fQFGGd6sJyaC7NMNVdlDq+ULQiripPIKOlI3bO9bqNui1T2ejw6eBCxqk43DB0tnEXq9
         984V8tMF/9Ovv5b5T02eTHdaKC2AwubMcCkwKmX3BbshiVux2XVytXHZHIJLG+nhCUjs
         tVgitYJzo3kQl1Xcp0TjvWDW25rD1N0MR1DzAMmh8Wd+e5oRtTl2iOKuEAiKsdufWX2k
         lYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725264285; x=1725869085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UTkjM/YpFeicUPaHWpIAijZq8DD+lel03KrAl7Eqn0=;
        b=iVrfEgoX8E/0/yJO9/0eNWoA2Xw0yergV7bmRb9UNDBszVZoGi/c8K67JkOmn206X/
         UNWrzfprxBzLKB86UIFAUBEYKeOM6gFDtbj09M2C9JKA2NRKCy+hae8kICD1D+cTJK08
         MMGO0fbTJeHav1kqe9/TXBs6UmkZpyWDWL444LhNrUqvolhdypixUWPqfi+wBpDbDzRE
         bzfJR4XlTLnagrePCQM+IRcYRzF44I/SPWXXEFrNhfYCvGL3QuKzUypySl6WsnAd05mz
         6h67cb9EFGARnXCkuX08EMGuKojAeTOW1IQKx7L9rvbr6vvQkHa2j2pK6zyYewGjoU7/
         IhOw==
X-Forwarded-Encrypted: i=1; AJvYcCUm1MWJ/2uTyjpFjRcFuD+68VUDtV4z5XCYhtrRSmShXzV5tk1IC6xkXAGn7Gvp2AJEjxFC/L0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxml0iAsrtVdYb/oXlFlBBaEM+AhCtRkeidjOAV2len4JYuGE2Y
	29fYA247GTlgVy72mE+lW0+vRVaGcvptRRPUEa+ZthYX5uNa3SfkTY0lmgIpkcLuvrUzT/zJa1f
	UejzwfWUAQ7dkeFQWqpJSBcClUi4G4oM7g+ZJgQ==
X-Google-Smtp-Source: AGHT+IH/2Sron2senQlaG+hNYCIf5KgSiTssWFHnzlYklHs8dJj/QIMBsSouj5aXuELLgPa/B5+9AnhJvxEmPM1PyIw=
X-Received: by 2002:a05:651c:1505:b0:2ef:216c:c97 with SMTP id
 38308e7fff4ca-2f6103a520emr84062511fa.19.1725264284861; Mon, 02 Sep 2024
 01:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528120424.3353880-1-arnd@kernel.org>
In-Reply-To: <20240528120424.3353880-1-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 10:04:33 +0200
Message-ID: <CACRpkdZqj7-mxCBBoWZm5QAVfNhak6PdrMnSmUWRKb6DpJLQNA@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: realtek: add LEDS_CLASS dependency
To: Arnd Bergmann <arnd@kernel.org>, netdev <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David/Jakub,

On Tue, May 28, 2024 at 2:04=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver fails to link when LED support is disabled:
>
> ERROR: modpost: "led_init_default_state_get" [drivers/net/dsa/realtek/rtl=
8366.ko] undefined!
> ERROR: modpost: "devm_led_classdev_register_ext" [drivers/net/dsa/realtek=
/rtl8366.ko] undefined!
>
> Add a dependency that prevents this configuration.
>
> Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Can you please apply this patch, the buildbots keep complaining about this,
and we agreed (I think) to take this dependency approach for now.

Yours,
Linus Walleij

