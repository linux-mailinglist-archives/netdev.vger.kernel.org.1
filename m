Return-Path: <netdev+bounces-229918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7BCBE20DB
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3422A4E6C5C
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F4E2FDC30;
	Thu, 16 Oct 2025 07:57:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953606F06A
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601434; cv=none; b=EoIyXcw3AFgLMWuqlTEOHqE5UEonTIaG6lXM4+mWzs8WFO7mFGBV3QG0+3liQ0pfA5V3FMv9Ixce/BrlAyChC1xJF+SO0n9o2Uac8TQqiMiPqsihSON0UVK0kap3jhHZGaMx6bMky6w/9YILdnTmeDjqAe5KCBcu+NX3ggKfGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601434; c=relaxed/simple;
	bh=1eGQTAnWNGY3mGah0Neq02H/T5/f9gtIvSd+fn8FW2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3eRMtsDYpPJPCSKsgMrjjR4Fbhqrzna5NnNaPJ0zDl1mlZ4PhV9ABgADRa1YNEUYKaTEsVy9RPwGFdKdV57ANCX8/2VLLqfLVuDXBlmCEXNsNRDIywjrx1AbEkBT4SZs6QM7SdZnKgiuJN9Jz+1c07I1/tgz8omDx1siRhi7yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54bbc2a8586so124766e0c.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 00:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760601431; x=1761206231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kd9DhXGFTz7VluvF3CXaOYryMfT47ujx56ubcyYXsIw=;
        b=TxOho4p20MTqwma2dmkL4rjfge7+eT/GS9OVOFyKL7B9MUsmBJbfKe3CbqOpIAkAAM
         b7npt8t19F+WC2u7fHO80SYKgj0AsLjEpGh4yq81RhcmZy/Vu6AiRiBsm135Sc4on8SY
         aSZAHMZ3oB3q5JT3Y6knjxJmXGVyQnCETaDGqIps/ykjt1Rp2xDXHhPXMLk3mIVeQ+eF
         1/vUW1kdQzExeRVxnUdDLsoKHKlDjX2L/KeB07+7badI3bbLSg4RypnTtfaAU6BbnI3S
         2v19e23QLeG+o3lT2ngqXfFYH6NUSTIPuusi0Z/Cu/mJCv0bc8m8tqKm/Yvp83BuoHAJ
         BSWg==
X-Forwarded-Encrypted: i=1; AJvYcCUXPT/R06CW2dGljSkJda/IPpJwFkMKtIeksRHRw1rDA1Mgl/qGNxzTBcfVDtfqbGbAKI5Mb9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzBA9540ixQKHjpDN5l3dsXxdRjMUkxmhjxc662CAjbg0SdU0X
	R/OZQuubNHlq+unG0pAcJstR2vq/viHD9X5c+wtcQdEoMq+OrOWQYMPzXIOd59Sk
X-Gm-Gg: ASbGncueqvXstf8AI6eeucAq5MgzMZxhVPK0oy3uwa9QjI1x7H+uMtfMDHc/Z672uoD
	TBNULAP42Vx7Hvhinx6NhqbcV8THaXzMnyIHiuCThNtCxhwSikGqFOkacwBk+opIQSPQse/ZKXf
	YfxErK6vmpGeUsthIohnShw5jN0lZGiaYM/D1LuRteat2o9IlgEI12zVlyMAhuWqtvneRDttQIF
	rOUAcjI6/oeJDu5825ZO1TAi4E2pJEJf2ebcit70RsyjFFzpYuGaEN1Hw1BqDAudMrEZGVn6Mim
	xnvPuLvKehCeshgyWCA/IlUeAQO4cBFwwAccS4IycqmeRYGGzeQ2p5RMrnsgftAUILSqL0oesvI
	0JrQPMtwzr9w7kAIDmr7+xRjPvbe1WGTae2ZoK5UhkacbI0CyFbCWtpptblyxiiei+9A5Dw09pv
	cSQfxWwADwuwfC1A9TS64XNxkxZv+Q0vbsNpHqpw==
X-Google-Smtp-Source: AGHT+IG2fpRfqNApR/krEcweS5o38K+7URS/RPwjCkC821okQMskN7bz23fwGBEzeCREgucIEXg8RQ==
X-Received: by 2002:a05:6122:8c6:b0:54a:99e2:47db with SMTP id 71dfb90a1353d-554b8bba313mr10943475e0c.13.1760601431304;
        Thu, 16 Oct 2025 00:57:11 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80dc9e8sm5742619e0c.20.2025.10.16.00.57.11
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 00:57:11 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-8e401b11bfaso119312241.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 00:57:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNkymKhDGyQnYA4U2QLh/GFh8sKOnF+z1hX13h3nN6iT6PYPUne0FsKfsT0dAzefLoDTOIo+0=@vger.kernel.org
X-Received: by 2002:a05:6102:512a:b0:519:534a:6c20 with SMTP id
 ada2fe7eead31-5d5e23afcd1mr10705349137.30.1760601430958; Thu, 16 Oct 2025
 00:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015232015.846282-1-robh@kernel.org>
In-Reply-To: <20251015232015.846282-1-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Oct 2025 09:56:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVBDN8-gWVs1f=1E2NgD6Dp4=ZFUnyzqHaQj9JWPpZepw@mail.gmail.com>
X-Gm-Features: AS18NWDjBoTWi0arzS-uHQaIyzTZ8PYUb4ECqZaEUF0sSO-4JEe-m7M7qjhxsvY
Message-ID: <CAMuHMdVBDN8-gWVs1f=1E2NgD6Dp4=ZFUnyzqHaQj9JWPpZepw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
To: "Rob Herring (Arm)" <robh@kernel.org>
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

Hi Rob,

On Thu, 16 Oct 2025 at 01:20, Rob Herring (Arm) <robh@kernel.org> wrote:
> yamllint has gained a new check which checks for inconsistent quoting
> (mixed " and ' quotes within a file). Fix all the cases yamllint found
> so we can enable the check (once the check is in a release). Use
> whichever quoting is dominate in the file.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks for your patch!

Since you are mentioning mixed quotes, is one or the other preferred?
Shouldn't we try to be consistent across all files?

> --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> @@ -129,7 +129,7 @@ additionalProperties:
>
>      - type: object
>        additionalProperties:
> -        $ref: "#/additionalProperties/anyOf/0"
> +        $ref: '#/additionalProperties/anyOf/0'
>
>  examples:
>    - |
> @@ -190,7 +190,7 @@ examples:
>
>              sdhi0_pins: sd0 {
>                      groups = "sdhi0_data4", "sdhi0_ctrl";
> -                    function = "sdhi0";
> +                    function = "sdhi0';

Huh?

>                      power-source = <3300>;
>              };
>      };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

