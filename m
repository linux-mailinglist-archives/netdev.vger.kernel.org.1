Return-Path: <netdev+bounces-121804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB4795EC4C
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 10:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 084EDB207DC
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 08:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D5C12D773;
	Mon, 26 Aug 2024 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="akfXGzOA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC331EB39
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661993; cv=none; b=rp/wFQPs08n4yoMw1KufREFuvjRjW77W5H9KQb5lyu7YzZv0UPspKxUcXyZklAKSf3fk4H/9Jo4Qs2z2dfpWyAZDcucCivCKSAaTqj1a0EKo7YtkbkiuoP9b2VdB7ORTsZnoFs6Iw5+9QE7yHrpWRiAjtiTYTN/WABU7wgwz5xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661993; c=relaxed/simple;
	bh=jRoGc8zZH4oC05abOb5eEX0kRMeyafNXbYdYJflymmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNjn0F+KE9crWYtmQhGnP5s9hC6Xnaj0AIkoWJomo5/8BJMelA05C5tbCEksEhW5jYlh8frq/4SRYtnUIAMKAy0+IH3E7OEb065n8Qw3XfeJ/GCK1vf3xqw0606ceLjGVdpPyvu+0E1pleWCGDKtJZhPz1NeJYxkXzTpfS0sDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=akfXGzOA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5334c018913so3937857e87.0
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 01:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724661989; x=1725266789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRoGc8zZH4oC05abOb5eEX0kRMeyafNXbYdYJflymmE=;
        b=akfXGzOACYv1vaXfxF9H4LBBq05lTfO384/4Rgu678ZMsDHKAzcYMtfD3WvTt/fCWG
         UXEsg/HQ4iqw0MPuuUnM1MFu5BE8PpcgKsc1CyzYEULseNRrvQwqJdDtAbZUDLPXGD6u
         G2wrTlS5kQpVoh1ygWsIF68u6S6ZO3oVkiJFXrLpdsAXXb27JkNVTFseJKvaci/k6zTA
         WwCdWEIQX6f2a2+uBxrTZYOcelRA740+vQ2pdmH+WdWpuNQiixYDYuOmuhfUJTjNc2rK
         duc1gSbRJY/C9bhAjViG+yIHZDH3ZaU+LUGDSggNbBzPF2ZWp9WHzGclUWKrJf89ZFi/
         adoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724661989; x=1725266789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRoGc8zZH4oC05abOb5eEX0kRMeyafNXbYdYJflymmE=;
        b=ZZVcpLujemqe7Ex8e+b8E0626u2FUWNNQZ2r96NVWov3oWdsDCfII1DN/Wgz/zJJyn
         Vf8bhN9KuhUB9jfJcAfXKKn1fPjWhQiDklbUkToJxhmOnRtzJz8iYioFYl68+lOibvQf
         otf0rgcCnTn2D+shEguIB/kfnXVgFt3xtcgSAFiIFtDTkSqDtu/ojYU4+Q/NzCsVvCHT
         DCZhuG1q8kqyKn98OvKOGIf61bIPCJAfhkaAHGfjQ9g2/wDU36jfPeOfutvXTbktjZ2Q
         noJOIzCBkN+698jos6uvz7GN3bnwC8gsHB+cVl3/u0wGnGtJxfWlLd3q+xbHcyG0Kfcd
         TT1A==
X-Forwarded-Encrypted: i=1; AJvYcCW3NTMIylrDx4vNWJz63MDrEaH/CPfuetJ4s6QwNS/n+AD5gK57E5VO/J5IisAz/U3EUVpVWC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmvE9BMHzh7538Be6X9OpFr3wXyQoX0nFf4jy/0MyH7NOjLq1a
	JtJivEuHrs5m0chWIYiXZSxHXroKoX8arhSJ+G49871ejzAhAiDtSBv2EqCo6Q19oxCRkv9jMlg
	1T0gOogQicM4OcmHV2zFVBqyGSaO156NmyvPyog==
X-Google-Smtp-Source: AGHT+IEAKix9avOZKhj3gUarttYPt1B5mxGGiNfGvZNqelGRoDbFczqf/+RGYgGgaLwvWmb22Hq7c+MIRiChzBxFm/8=
X-Received: by 2002:a05:6512:280c:b0:530:ab68:25e6 with SMTP id
 2adb3069b0e04-53438861474mr7188396e87.48.1724661989086; Mon, 26 Aug 2024
 01:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823072122.2053401-1-frank.li@vivo.com> <20240823072122.2053401-4-frank.li@vivo.com>
In-Reply-To: <20240823072122.2053401-4-frank.li@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Aug 2024 10:46:17 +0200
Message-ID: <CACRpkdb0rwN1YxF10MQDkVX1QoYTWot+heOJp4RodAtniCOdsA@mail.gmail.com>
Subject: Re: [net-next v2 3/9] net: ethernet: cortina: Convert to devm_clk_get_enabled()
To: Yangtao Li <frank.li@vivo.com>
Cc: clement.leger@bootlin.com, andrew@lunn.ch, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ulli.kroll@googlemail.com, marcin.s.wojtas@gmail.com, 
	linux@armlinux.org.uk, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	mcoquelin.stm32@gmail.com, hkallweit1@gmail.com, kees@kernel.org, 
	justinstitt@google.com, u.kleine-koenig@pengutronix.de, horms@kernel.org, 
	sd@queasysnail.net, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 9:06=E2=80=AFAM Yangtao Li <frank.li@vivo.com> wrot=
e:

> Convert devm_clk_get(), clk_prepare_enable() to a single
> call to devm_clk_get_enabled(), as this is exactly
> what this function does.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

