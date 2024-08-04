Return-Path: <netdev+bounces-115594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EFE94718B
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 01:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFC128106A
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 23:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F13113A3F0;
	Sun,  4 Aug 2024 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ev6HNtZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9ED1CD39;
	Sun,  4 Aug 2024 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722812913; cv=none; b=DOuw3tkplA1zdGSz5IXyTHXTdiR5aOtjjUIg4T7F+9YtqMc8fzXoziBS1RwEtHDp6z2OiWz3COBDr24JccHny5I6b4N9QmiA+Z+OeIbVaYbc7RY91W78IRdwz51L8jkyu5IJ+e4LYTG2ZdrYlFeKAE86vAJp7lwK/dyZVTYzsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722812913; c=relaxed/simple;
	bh=lXkvCUKuspU5YnISfawngSPy7/NlLoNTHVKPlPPrtYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvuNjFo2MhSkKWnAI2eouvODdbuMQw8BZZSiSjXFwizdOhe8BrFuAH2L5DRc0mP0mkPFfoSzcwJlLnj8zhsseV9iXkxxreogrSKRrCn64bfKi7Cx0GlvuupfwyLHpkOH46E4A/TKvd4tOZNc9NrmAqxcHtDX0ORkJHNZXV9wnlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ev6HNtZx; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0857a11862so8538300276.1;
        Sun, 04 Aug 2024 16:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722812911; x=1723417711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXkvCUKuspU5YnISfawngSPy7/NlLoNTHVKPlPPrtYw=;
        b=Ev6HNtZx6tDtKB8f8Lo/7TFmylJMPpNe+l8wHJ/+BeHCWYf4xG7dHB6dBj0YNVhldX
         UkN693LemRcLwmglGnEZ8g0wHahw7ONTKUnkckqgE7XmjGz/r9aNgvCtEyR28v1D0KCH
         FCabrAtmqBaE+gVBmz2Ps2sEwycOuI7HI/poPdwwB95E4atZ0u51YDfy5cic3uZW28+L
         Mli38Zkag804N4wl/rQuf2qlhD0Ijf9VN/IrQiTosgaWvDB4VJev5E17JMICBBA0VT4S
         DdUCeu4LSGkzf7xPk4CVYl/ONYVnQrD6k8x+yf7ylH59MdRfz8QZT0DbcD8C3145BQCW
         SdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722812911; x=1723417711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXkvCUKuspU5YnISfawngSPy7/NlLoNTHVKPlPPrtYw=;
        b=A7tdKzOEmh8nn6q1uo382vcm43Xnr5avKQcoucFxl7/fRfLqP6VkhiZUUWdx58HHrp
         purBQ2bZ7V9w/fj7XF02sHhjfNtMCd2j2FaFToxho15w4fqpLndLpMFx4mcpsuCgq1Gx
         P4mHLLb4Uq59c3ul8kfESCpwIX55WpkbO7/Cju+ZXpaT9aKg5sYPQclIyQxq0V6gwUP+
         VwGuBKlXlDAMrlx4rNwxnQUPAhhrhG2o6fonoTDwPT9d0VyDc2+NYR04wcEm9lCSyqtb
         xOQjCnKOpJ+i0b6K2o/yXR1FpCxICLAxHGp+9hf1749sW9uzsrWukgS98fbii2KJY+LE
         +x8w==
X-Forwarded-Encrypted: i=1; AJvYcCXXSMLmEbDz//qYTrH6/Obb/yUDY5az4kud9rOm/L/in5nPC8G08t3kUdzwi2e95YKzzNg4VI175DJnv1K0nmFc5kbB0MD47GH2QGjo
X-Gm-Message-State: AOJu0YzXJZozQ1G1xc6dseyjbNEF5LJGoAMTtGTy5KU1xERO1+HC0L3M
	b2Ym3KoLtV2WbklcuJp588Vv+p3SaqM3ePFsr1CbGHnnaphIAFhJfhHW14mAiRCp6598GGa5lev
	vajvjaabbutbPDwYiKk3A1iUGFLs=
X-Google-Smtp-Source: AGHT+IG1ZbG9Hz6R6W6o1mrYqEEUv6KgLBWDZHOfI77oW35Cn3gcgZMnFqq5WcjZZqhKXEq/1zOV7Wtr2Ki4wxyRgqs=
X-Received: by 2002:a05:6902:70e:b0:e0b:c402:b037 with SMTP id
 3f1490d57ef6-e0bde2f099bmr13189712276.3.1722812910771; Sun, 04 Aug 2024
 16:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com>
 <20240802080403.739509-4-paweldembicki@gmail.com> <20240802221554.x5z26rj4bkbry6xy@skbuf>
In-Reply-To: <20240802221554.x5z26rj4bkbry6xy@skbuf>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Mon, 5 Aug 2024 01:08:19 +0200
Message-ID: <CAJN1KkyaZf35t4yQcDGpjd_TJbuY-k8VV3wm0yGR2aYnPo24cA@mail.gmail.com>
Subject: Re: [PATCH net 3/6] net: dsa: vsc73xx: use defined values in phy operations
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sob., 3 sie 2024 o 00:15 Vladimir Oltean <olteanv@gmail.com> napisa=C5=82(a=
):
>
> On Fri, Aug 02, 2024 at 10:04:00AM +0200, Pawel Dembicki wrote:
> > This commit changes magic numbers in phy operations.
> > Some shifted registers was replaced with bitfield macros.
> >
> > No functional changes done.
> >
> > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> > ---
>
> Your patch helps. It makes it clearer that the hardware could be driven
> by the drivers/net/mdio/mdio-mscc-miim.c driver. No?

Older VItesse hardware implementation is similar. vsc73xx has slightly
different registers but it could be resolved.
However I'm not sure if it is possible to have one implementation for
platform and spi driver. I can't prepare support for spi connection
without a device for tests.

To be honest, I would prefer to merge the fixes to the existing
implementation at this point.

> Otherwise, I wonder if the triage you've done between bug fixes for
> 'net' and cleanup for 'net-next' is enough.

This patch isn't a fix. It helps to reduce magic numbers in the next
patch. I could send it to net-next and add missing definitions to the
"busy_check" patch.

