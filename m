Return-Path: <netdev+bounces-230053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C0BE3495
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6C4F50240B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364B7326D4B;
	Thu, 16 Oct 2025 12:14:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909452FD1CC
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616850; cv=none; b=Yj/5nFHNK/0J9zNa/QITSrVP3QbTjQi65YlUnyfLTzWjfnQQNzJCtpSfulit4to56QiD/dI/e5eTNcJA7DChWiYQQNl5T6a0sW3jKBqmKN8m/l/p1L7Zy1MiBXUgKgBWmhyPb2BhRGZCycYEtkS7Q0QGAwUv1OWPLX9tBNlj0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616850; c=relaxed/simple;
	bh=Qljm2z2l5uF20OnzQWwo+pu0aWLXVl3TFALx6BWruW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3g5TKImBG29t5JX34vw7bOA7MY/La7Z3t154xNhPEbMdPU+SxHCQK8oj5q77n2OLYN+JT3n4bgJ9sKYQ0+mqi/QwXPBSMwVwoY/ptQaq2hdw7kzwKMdsp4bhtdUn4o1Ge00RV34Uk4aPYSfyGPR98ZKuFjA7VFx0JIwEciejdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87c1a760df5so8449206d6.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760616847; x=1761221647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3GThzLUFjGbl3VuQITKYi7/BLSw+ups+ZHEY60Y/84=;
        b=od/G/aoRnnIGaL+BWwXQc98LvS5MAgBuBoOnA6olJhyBi2d2XNyZpNsU8atsqfvd/W
         ftf+ElP+kbP+iTGNhTU5U4kiuxXHCcpQ+JTj0zhCqqu9zdQqKt7TL4byP+Ld46yZ3KIF
         ZMAwsnbYUsDvgZ+eXdZt6uufLYzm7ZzvjBLxMwlm3YR8oPsxg9d/EEufA8gyMRsdo++7
         PHzcMr29I/vrSdfK14byZHHxXlXtpc3OH+V0hL2+nu4wzRaJGua/ihCeaWK+dT1yz16R
         xSkQjRGntMi/bzxGuSXYfgF5iS0ANFmbHhcPXPBvt1CNGJldMWgLk0/ySyVlW+fCOkDX
         43uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZOmlgVaBcleOO1imxxUsmdpS9ctUj/PwgQC0BH4LtyRoo9jLMENPuKvIAocB3DazfYQfsXCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/o1GBgHjcZ09btxfYc5olgJiO2iGZ0qEsZlNFYrKuxjhNH/T
	3snh1AGb1Y0ZAPCVjIJZB+CY6ubHBvAQDbM0mqKkUVhkbqdrKLqR8FB+eLOWv+Lo
X-Gm-Gg: ASbGnctQ01YdsIfxaIPg1bY9/J1W52Wyzo4xMY6SrLpaPWF55fopCB5EuMdH//8bPkv
	t5o+X54xrwY0AhxyDKZ6I5lVEKu0bX45I8ta6V95l9ckV9Yf3qFSDiyGLbx55ZA0KDGCpbounZt
	YtWWpSi04tT63SidwFS5787bS2URPkzrUUflmwY/LF3RAnmH2xY2y8OWo/j1axxeebc+RqxiHyx
	+dLVRCSV1tJcxRl/XPoloK75HfKjh3U1Hm1713Q8kgSPc18UgEME9/cj0p3nXSLDWtwInIvH2oF
	qPjj/NdUO2x4Yqm7R54YTnwrGPuymPJlWiEpx6C5LMTNYp8e2HRHfdxWpZ/s+57nYJJ04zeDV6L
	FtehhK7mYjyCectr3uc3MOQHyQj5wT30lCMjrFmauloenZKKJKP5Sro1xDzSe/9K0hfz0pTNBBq
	8/aqF0ifAk+TQWA0FtQ1w7hVKKDuuwrsJtLdKxLD5hTQ==
X-Google-Smtp-Source: AGHT+IH6nOyKJrZCGTsHKaUq0gJgPWxitOC/aYt/+ul/d/IGCCTcHThVpVAZCNJK9NMzPkpaHeT4Dg==
X-Received: by 2002:a05:622a:1488:b0:4df:c240:d596 with SMTP id d75a77b69052e-4e6ead6a348mr428104701cf.73.1760616847122;
        Thu, 16 Oct 2025 05:14:07 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0122d19asm38297436d6.29.2025.10.16.05.14.06
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 05:14:06 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-87808473c3bso140878385a.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:14:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQvHVnOlvo70boUvpUXjq3d1YoECQ89wY88N9xsT5poSlyo+aquvRggXwqp8Ac5BhJ5/T4b00=@vger.kernel.org
X-Received: by 2002:a05:6102:6c2:b0:4fb:ebe1:7db1 with SMTP id
 ada2fe7eead31-5d5e220448dmr12281536137.12.1760616407229; Thu, 16 Oct 2025
 05:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015232015.846282-1-robh@kernel.org> <CAMuHMdVBDN8-gWVs1f=1E2NgD6Dp4=ZFUnyzqHaQj9JWPpZepw@mail.gmail.com>
 <CAL_JsqL1KL4CvnxF5eQG2kN2VOxJ2Fh1yBx9=tqJEWOeg0DdzQ@mail.gmail.com>
In-Reply-To: <CAL_JsqL1KL4CvnxF5eQG2kN2VOxJ2Fh1yBx9=tqJEWOeg0DdzQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Oct 2025 14:06:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUZaL6qyuTZPoRc11WSuqcoRUFNksXZNJoijTeL+vfKQ@mail.gmail.com>
X-Gm-Features: AS18NWBH0cbPp0cJrT4sY267e4E8JBEuMEr4tkAtjK9DVXEqfelKr3ZBbd1AYGI
Message-ID: <CAMuHMdUUZaL6qyuTZPoRc11WSuqcoRUFNksXZNJoijTeL+vfKQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Lee Jones <lee@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <f.fainelli@gmail.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Thu, 16 Oct 2025 at 13:46, Rob Herring <robh@kernel.org> wrote:
> On Thu, Oct 16, 2025 at 2:57=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Thu, 16 Oct 2025 at 01:20, Rob Herring (Arm) <robh@kernel.org> wrote=
:
> > > yamllint has gained a new check which checks for inconsistent quoting
> > > (mixed " and ' quotes within a file). Fix all the cases yamllint foun=
d
> > > so we can enable the check (once the check is in a release). Use
> > > whichever quoting is dominate in the file.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >
> > Thanks for your patch!
> >
> > Since you are mentioning mixed quotes, is one or the other preferred?
>
> I have a slight preference for single quotes.

OK, so outside human-readable descriptions, there should only be double
quotes in property values, i.e. on lines ending with a comma or a
semicolon.  Sounds like that can be scripted, or validated by scripting.

> > Shouldn't we try to be consistent across all files?
>
> I don't particularly care to change 915 files. And if the tools don't
> enforce it, I'm not going to do so in reviews.

Fair enough.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

