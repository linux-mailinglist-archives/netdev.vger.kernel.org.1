Return-Path: <netdev+bounces-166455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F23A360A0
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C813A9ADE
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5A426656F;
	Fri, 14 Feb 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Qnv1zqqw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828292661AA
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543884; cv=none; b=OysG//fBA+yu2xdG4CgIAowOkyZoru/qNop3gU4Y211puEyTKo+cL3Y41bacLr2XFwf8FSiRv0TsJEnqmWlEH4iHMLSSaQJRs5o1Ce1RxZCuA+yWEWJezqmVrP0/q7vfRCAZj0rL7B9hmF7lAvBD68h+l4YicdF6Qbq5vaxHI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543884; c=relaxed/simple;
	bh=VWb5MkKgJlcOONgIwkXIHXhOHFOwyrjuHcEUQBNf7xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuQdpTis2Lq92bTMmYFlcQWN7meyuHFBYUTyPw45R2TRCpO/VWF8JvUxDiAUZa5OVfaipYsl9nigl6qEC9IQ8wZijvho9AgUg5qMfXw2Mf2vhZerPIYmiytMr2dcoEv+U+HAQRjvCl6kzYn4mD8s2HFlshuXSgdTTw9Iy/kih8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Qnv1zqqw; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5450abbdce0so2214456e87.3
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 06:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739543880; x=1740148680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/nWo8rBImm3/oJoY9sZaYO485tQZOmVynsCXssfwwk=;
        b=Qnv1zqqwxfpLkHSKnNaLKIKFbyg75JB75IxlrE/h7+F420HlaTZ+0ioMQqu2R3G8A9
         5BJeHLjkdJ4Scs8zR7CGNgrn1Hq2yd/8rzx8/FHm8o2m0+iSIHobu5RXwXHJOEN9Vyp0
         SG9Xb44XbjaJ+UPIykTyGaUtMahI5L88E5Klr1vxbfJsvmfp2jLQMzD5iRWAMaCyiKXE
         6FSSEAfZew371SuTnJ+cCy75G2ljIMVUnu4y/5SjXLvz07kBlQFjaxGmZSDawf+GVHDY
         R0MKJDjjVisJNvlmVmHX4BYB3sTGMCbeqY5bS6GMgHTk46GF1+7BSId+Gd+MVbhRZ3yZ
         KeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543880; x=1740148680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/nWo8rBImm3/oJoY9sZaYO485tQZOmVynsCXssfwwk=;
        b=M0TSFfZWhTuCbyJwVbgD64jwYskEKgWz+5tTn5YOShg5BMlG+YePMPpNsYDED3OBtD
         ddQh9reNBN9nu5WB9yC09JvnBPIetFJplkt0kiDkzwmXEd6JNKQb3KDyESOq+YH1yLUL
         VUIHTT5jH2ZGlhjqz3cAIrDA2wtFaezZ7hi21GeVaalmnLgEqa83DP/T3ZC7OH9nZL64
         TzoBSi8g0O15qvEKBRC5zQSbbvzpbubMkeYI2/4e6FV9yboFp7dlibnUnd8qwlUYuxkk
         eRUPnmkVWJL0stG8YsWQ+qo7pouG8wqLBZUMdm0ttOCPdiepDY6481HAeu3eD3q4BEc+
         CEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRqR72aPMzA+8Dv7Wdv5If9fcEGiviHEU3OzGDwxV15DBS1GbC2DYga4cT2LH/v/qynshr2bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBH4YLDMnX5q6EYk7TyIgLRY55+CVafM0kY1C/x44o78grY0RG
	xw4uUFPrgUSJUshhfLK+S6z5Kg7PhSNRLIdhQt4MsxovtxtZcJhAL51vnWB1+jkbDI4dTIlE2t0
	bKwEEbKByL3xrY4aRMqW2mLcyAkJzDgg46UMMKQ==
X-Gm-Gg: ASbGncu3yL0nU7poDVlSIc2OxkIuNZseaTBDjXWCsNU7eHR6gQN7Fh3PLlKftjUHquJ
	P3ihC+n6xfZy5oCM/5leMOQxTBgNvlKPo0BYNMvAEWXOmTNqDvSzu80sYZy6pXfAND5vudbGmnu
	I0Ti7X3gS12u2XOyhXVugvGs1p0ZA=
X-Google-Smtp-Source: AGHT+IFI84zGNU/5Prn01Vy8fWHPKleDbw82zc5GSdSgL+oYsNCtPFeqOqBeE0yzBu7Mgzm4cA6Jih86DZ3F3f8DtA8=
X-Received: by 2002:a05:6512:ac7:b0:545:1049:eb44 with SMTP id
 2adb3069b0e04-545184a2edcmr3543131e87.36.1739543880482; Fri, 14 Feb 2025
 06:38:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <173952845012.57797.11986673064009251713.b4-ty@linaro.org> <CAHp75VcjAFEdaDQAMXVMO96uxwz5byWZvybhq2fdL9ur4WP3rg@mail.gmail.com>
In-Reply-To: <CAHp75VcjAFEdaDQAMXVMO96uxwz5byWZvybhq2fdL9ur4WP3rg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 14 Feb 2025 15:37:48 +0100
X-Gm-Features: AWEUYZmZOOzJ-2PYVb-j2HjRho5iTG1Da6ZcvH4AymKKHcJZkPFSmjChMriWUzs
Message-ID: <CAMRc=MefPRs-REL=OpuUFJe=MVbmeqqodp+wCxLCE8CQqdL4gQ@mail.gmail.com>
Subject: Re: (subset) [PATCH v3 00/15] gpiolib: add gpiod_multi_set_value_cansleep
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, David Lechner <dlechner@baylibre.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 3:35=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Feb 14, 2025 at 12:21=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> > On Mon, 10 Feb 2025 16:33:26 -0600, David Lechner wrote:
> > > This series was inspired by some minor annoyance I have experienced a
> > > few times in recent reviews.
>
> ...
>
> > [07/15] iio: adc: ad7606: use gpiod_multi_set_value_cansleep
> >         commit: 8203bc81f025a3fb084357a3d8a6eb3053bc613a
> > [08/15] iio: amplifiers: hmc425a: use gpiod_multi_set_value_cansleep
> >         commit: e18d359b0a132eb6619836d1bf701f5b3b53299b
> > [09/15] iio: resolver: ad2s1210: use gpiod_multi_set_value_cansleep
> >         commit: 7920df29f0dd3aae3acd8a7115d5a25414eed68f
> > [10/15] iio: resolver: ad2s1210: use bitmap_write
> >         commit: a67e45055ea90048372066811da7c7fe2d91f9aa
>
> FWIW, Jonathan usually takes care of patch queue on weekends.
> But whatever, it's not my business after all :-)
>

Too many conflicting suggestions. I just picked up all Acked patches. =C2=
=AF\_(=E3=83=84)_/=C2=AF

Bart

