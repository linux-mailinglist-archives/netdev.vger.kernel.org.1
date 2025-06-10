Return-Path: <netdev+bounces-196355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD0DAD45AE
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FF417C59C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A672874EB;
	Tue, 10 Jun 2025 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNuDHYPl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9428688D
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593335; cv=none; b=DAW7cPO7m63HKy18wiI0vdBCxlzoUchCawltF+9m/9q6zgUqfNTCRENQLkf7dIHjEaCx7sSQTZ5hBjHy+Ya+dDkruvVBfWUzSPpvzl8vfenv7NbM9j67CswtlLfOw18XoGcerrNdKFxiKHJUtrcGKlSA1yXjdAEP0PzC1rldK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593335; c=relaxed/simple;
	bh=y7nuDXxHMeW+apAcE+4L7YtuvyqeNU/MY3xvfvw+85c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihqIvfJya7dk8hWvjEibNNAuO+PQ3ft/Nur4m5op4tQVxWPuOVinLyYYJgI1IsW5IJGURRQUwMoWd9c3hUZxDO83X7ecoxUm/68zThclGwTP5snbgXnVGj+I8AL+wzv75ZXpsgRna9CdeFfkainev+YRB2IfjvNWF2VaScxPd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HNuDHYPl; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55350d0eedeso6227826e87.2
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 15:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749593332; x=1750198132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7nuDXxHMeW+apAcE+4L7YtuvyqeNU/MY3xvfvw+85c=;
        b=HNuDHYPl+K2Zm5Mnxn2A5pYoDofWUVMI9eny4zxnJqj9L+tNaq3dT9srblTB9Cl+Yo
         cMdG/rtMGo02HzGBe2TU3voDdHpHg5Eb9cK1o/VLXS0Ng2MjiKY9lrmh0Un6XNL643eq
         cEhhRXkcoMAEZTdH0eBxGpsluQHJJtox9sdfAuS5hd0vRva4vdtsTOXF8ChPGfVsOLvR
         KLOza4yaAa/VOROLBFy9QhzupDz0JVGzXkYMKwwFLmjR/rdX2++MX6ESNmNZQOceaQuJ
         oAFBK9EKp6EK0rChdUA5oZfrJ35zRnxZtJmqJqVbcocgfahNKuCTtVGupI6Y82qhuSh8
         qcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749593332; x=1750198132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7nuDXxHMeW+apAcE+4L7YtuvyqeNU/MY3xvfvw+85c=;
        b=ggBpMIUj2bF9XpqmOk9dZDtcK1heXNgITwH8OH8iSgXPvKuLJ8B2hyHeKpb2l7zpcX
         zftgpNurSNJDGS3nZeLTpyBmJFTeluI33WtfvDJv3Y8s+j8CdacP+8wSTKszXfdqejXE
         dbMvAj2nf9eFkBbfIbg/Mo3g/NMGTXdpzAi0DrrUzzDAjiyKmYPrArVZZC2uzqnZ8zib
         TRVM4zxAG6N8ml6Q/xYeZm27PzjjoTS9zO87NBu8iJsqji7KSknmfX3hZFE17/fpSLRB
         7jwLzCiQU2vlcSZhHELWIfICkiz+xzY9bUBsPEXqi9eL7hditx4QFBu6tpSZteBTsuPF
         UO1w==
X-Forwarded-Encrypted: i=1; AJvYcCWRoC1UAKydAbGieVXQGAWygM+btzOgpUdJB0ZkW38bdg5g6jA8zYH6spWxUHDW7JPvQHGZayw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+bdsBYfKP4ltiIpi2RoXLBH3fvBcQOiOjPO0dbtq5De7DnzP
	voOpEUFCHTZD9XrVxf1kU+IBDcnefdhh42vrDQixiWTRHgK9ryZNy3TOaV6m6u1iTvDLGJ5Rpi3
	GeiQoKIBeH4BLYEOTw1QKdzWOTmI7FhTynx3mMiV80A==
X-Gm-Gg: ASbGncvEdiaiJBGOWRDlcc/0G+/q4pFrmEnD1Hi1XRSlcDIMSoWawdZcXr1TAeQiYTz
	7pFAoWexjG7fVShDxjMev+1hGacToRfLxvpe1Pj2S8INhJJHdKSUlXjbm75EEkRuOuGsKuNv7nt
	zVSZzlUtvanxMCdPvFVb6dl6ddANGPyaT2/ljgvsfJvL8=
X-Google-Smtp-Source: AGHT+IH8MetiTltiLxVsoQdcqnz9SyKbfeIivBe6BgaYPax7FqypUr47bqpDDYKrtQHdmKVxRlIZT6Fr1Q1yswx0lfM=
X-Received: by 2002:a05:6512:3b96:b0:553:202e:a405 with SMTP id
 2adb3069b0e04-5539d327776mr135286e87.0.1749593331540; Tue, 10 Jun 2025
 15:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610-gpiochip-set-rv-net-v1-0-35668dd1c76f@linaro.org> <20250610-gpiochip-set-rv-net-v1-1-35668dd1c76f@linaro.org>
In-Reply-To: <20250610-gpiochip-set-rv-net-v1-1-35668dd1c76f@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Jun 2025 00:08:40 +0200
X-Gm-Features: AX0GCFvL7R8uIhwfFeu8Zy5wwVjWQCtUtnOLFaGyd-WVGbMxfXjNiZWqOaZW5QQ
Message-ID: <CACRpkdb+1uYy92975JbFUgvO0GWZBru1A8gOsF_VY-opzxopSQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] net: dsa: vsc73xx: use new GPIO line value setter callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Chester A. Unal" <chester.a.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, 
	DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-can@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 2:38=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

