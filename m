Return-Path: <netdev+bounces-161926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10687A24A47
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 17:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55A43A7C01
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEBA1C5D55;
	Sat,  1 Feb 2025 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="k4gk33Oj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926B1C3C14
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738426943; cv=none; b=JlIC2JvEJptlssQUEGqQpyfx5Gr3z7ySvIoourw2ebQG3MQOL6L9e6G1ohXqiMCUYMnYSxMhufXkamV1pqYxVi2sjEEMFBj28Hrnb9+Z9qWOaKWHXwrp3LrhiWyDKuxVgq4YamqXz6ke6EoEPCOAuKlmlObZCfOVZm+FY1VWsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738426943; c=relaxed/simple;
	bh=gc2yB9uwC+CfjzlaXN3vOgLBSMdhCziTLFTpp/igtbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsrmW4M1Wi+sBmln5myp0DwHumREAmcQhwRYRiO22/QTyoC/EdrystHXKUI/HZg9bPqVYj7gCQIUnx/RjpLmB4FgTW6nxLdwqzKByZpwIJRbQd8Ww0+DyQUHPjnfAL6ATFtrFjAQgKZ71jsD0nED5gR4VuyS24GoDs1S9FOKaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=k4gk33Oj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-540201cfedbso2673459e87.3
        for <netdev@vger.kernel.org>; Sat, 01 Feb 2025 08:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1738426940; x=1739031740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gc2yB9uwC+CfjzlaXN3vOgLBSMdhCziTLFTpp/igtbI=;
        b=k4gk33OjrqZyZ8vAYmHFC6SVUZiZQtw7U/YUtZ4FvXExY4btcCxRNryyrCPvrcImcM
         BHNCZMu4UDoo3CByDYH6ItDBUJB05WadJ+Xb9rKpYOD5HUQwLOzpigmQPjk8SpGqe6hd
         8Gv6ou3vWTgqU8TJzgKNS/71JZk6vOgM1h2KEwCgWRc/qHMzMafQwOnBGS+bhjSOkSiY
         oG9BbUOwNPPALUvi5Mf1S5xLjxJplPK5U/QBOu+TyAlA4HtMJloqZ8I5kcdc+syux9/O
         O/FY2K/YloMAggAv3CyC3tHmb7XLxT75vc79S8wzDAcyKUlA405fJaa4LvO2QvU8qOsD
         6qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738426940; x=1739031740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gc2yB9uwC+CfjzlaXN3vOgLBSMdhCziTLFTpp/igtbI=;
        b=sIAwp2QYXSYvZQX0C/e/X2GBIiRKQ8f8WVjR0s8KKkjQFG6znwcCJVJVX2LiW6gVB/
         xfSO39B4u316aHJ4LtEquJg1snFUlfyBl8ZQ52rvGjf5EsdA42JyhI46EgjYtgaiNQlO
         bcvhppH67w0FgasfNsKfLXNg2moEktCjVuEsDO+Qf6Y2hC+EY4gPpwAHkfCVR8X+Zzmp
         tBtkeSKYLBNtfREt10k73KT3RAO6sjtBLpMFI+VsLP+pRPIEV4oRttWg4VqsvKzw78jL
         j7bC38mwX9l7vsr7Q1ttUMkRwGPTLHZXrXt9X4H2RUYV7d/x6M4LuofroQdELhFxejpY
         HINw==
X-Forwarded-Encrypted: i=1; AJvYcCVaHyoQ9jEqmGEnMcz++n+CXnPwRmf8hvKLsrNbf15PDybm/q06Pu5utuQr3gX+h3RHL/WYucI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztww741IVpMpDlMNTVmn0JocRLUlgFcdOt+hUi/cIW7ki4GhDp
	qadrqdYEDikHXD/jat2lS+W89BYHtJhOF/1Pc9W2/HTdu/PgU+nlwBaE/rmoCxNhN+PMARcsE2g
	OMK7zK8a4trOmh5xND5kMys1xtPI2AJAIM7sSUA==
X-Gm-Gg: ASbGncsfq+7BwwruypuRyrGBaZ+p2+Oz8a5bGnyDL5QnkIw/SFpqi16SCTJiZaJQycc
	f6a0+BG/0GbK5uPfLA+BqjV7pPw1eIsXL9weGNpK2FxmXH2OaPJIkvNlO3zqBEMJAPzEqtjzl
X-Google-Smtp-Source: AGHT+IEMrH29lOkWTlWC69aY0dD2xb+wCJlnehQsFFcBgOS7bovj0ZbCV4vzNowRaHEyenGDcRs81QzQOyPr/8xF7gY=
X-Received: by 2002:a05:6512:12c7:b0:53e:239b:6097 with SMTP id
 2adb3069b0e04-543e4c3fd4cmr5485244e87.50.1738426939852; Sat, 01 Feb 2025
 08:22:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131-gpio-set-array-helper-v1-0-991c8ccb4d6e@baylibre.com>
 <CAMRc=MdwQL8dWU5zF5fp+KUbC2RA2Q264by8HGXMg2k1rxhsTA@mail.gmail.com>
 <9931433b-5cde-4819-ac96-eea4f1f0f1f2@baylibre.com> <CAMRc=McEdcDs01BAKN5vg9POg_xxJBY1k8bfgiDN60C1-e_jow@mail.gmail.com>
 <072be5a9-e0fb-4073-85b3-4a8efcafae09@baylibre.com>
In-Reply-To: <072be5a9-e0fb-4073-85b3-4a8efcafae09@baylibre.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 1 Feb 2025 17:22:08 +0100
X-Gm-Features: AWEUYZndtirbEg_aYtJ6wt5WMFYJObSWPO3NsWCnNmAFKxLlbxMM9F8rxlAsWp4
Message-ID: <CAMRc=Meq_Gfhcjzx0vCL0JPzfnOcijFgB6AuqtsqgGn1eOTMVg@mail.gmail.com>
Subject: Re: [PATCH 00/13] gpiolib: add gpiods_set_array_value_cansleep
To: David Lechner <dlechner@baylibre.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 5:17=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> On 2/1/25 10:14 AM, Bartosz Golaszewski wrote:
> > On Sat, Feb 1, 2025 at 5:09=E2=80=AFPM David Lechner <dlechner@baylibre=
.com> wrote:
> >>
> >> On 2/1/25 4:36 AM, Bartosz Golaszewski wrote:
> >>>
> >>> This looks good to me except for one thing: the function prefix. I wo=
uld
> >>> really appreciate it if we could stay within the existing gpiod_ name=
space and
> >>> not add a new one in the form of gpiods_.
> >>>
> >>> Maybe: gpiod_multiple_set_ or gpiod_collected_set...?
> >>>
> >>> Bartosz
> >>
> >> I was waiting for someone to complain about the naming. ;-)
> >>
> >> I was going for as short as possible, but OK, the most obvious prefix =
to me
> >> would be `gpio_descs_...` (to match the first parameter). Any objectio=
ns to
> >> that?
> >>
> >
> > Yes, objection! As far as any exported interfaces go: in my book
> > "gpio_" is the prefix for legacy symbols we want to go away and
> > "gpiod_" is the prefix for current, descriptor-based API. Anything
> > else is a no-go. I prefer a longer name that starts with gpiod_ over
> > anything that's shorter but doesn't.
> >
> > Bartosz
>
> Oops, that was a typo. I meant to write gpiod_descs_.

Eh... the D in gpioD already stands for "GPIO Descriptor" but if
there's no better option in your opinion than I guess I can live with
that.

Bart

