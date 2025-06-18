Return-Path: <netdev+bounces-199059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEBFADEC67
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2A71891931
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A12EAB8E;
	Wed, 18 Jun 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dYakY6J5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5D62EA15F
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249693; cv=none; b=pOFF5j9vKU5iBNOhk9a+U0vK8r1Ksxk/UEiIZZbRY7UMYCwjoilhdAImtpR8lRw25u7pJIIDEpw+w3e8cueIoKDYbrY+TpyPRzpmfQWkmg7tdNy12q/54PR7fi3O5yL02/lNMejgon4mTBnTL8Sd486wfBJW2Q3htZJ7RB8/QyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249693; c=relaxed/simple;
	bh=lvDeYY1tyHLW44AqHwWF82BKnD0o1q8Cao4PGtdqJcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaOgj8n3kdJ+QH4tKmHglxEKtjhKAFF5KjbEAB+WA4nQa+V6IiY170LBI4xbRv0tYqSRV79WNV49e3J0YU4H3sKJZwT95qDE57u9133WuUIU7kCP+Dpc4EhfLheLfWEP9FzLSIiJrCPYU6eI4kaNRs/dHpZmHPcnQYG7dox+ryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dYakY6J5; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553b51f5218so5203372e87.0
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 05:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750249687; x=1750854487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvDeYY1tyHLW44AqHwWF82BKnD0o1q8Cao4PGtdqJcc=;
        b=dYakY6J5RcYzb6omLmKYYIz3TI3xl/KZHg1mfJgQ/ArkezRGWpHZALVwx2Ssm3uIux
         dwfgA8QHt1H6TGPmDx/nQ1Co8QKFzoAB0r4PhB6A+8q4CzbNhzMkxycx8MiiFOHXfy0F
         Y0P9YQL21+lWZD/v4hB1eQXMmPF9TgEyik/eH3A98lbfmNu2CGv/GNLhylgIkeLugSHZ
         ffxHVk2Zxp1mK6kUOo6pA4ZwGh0Ov0nLJXiaJ2GSXuLCJ7gruSeeKZZOAGDm7+WZhQBA
         TbPig0qdgIAQ+bC+XSuiSJ+ihuc/wDfQK4MHfw34BPC2uit/IjfFuxSShOvjqYxTuLAs
         eXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750249687; x=1750854487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvDeYY1tyHLW44AqHwWF82BKnD0o1q8Cao4PGtdqJcc=;
        b=pSX0+rs0o3D+nElE5s6CSNHLE/kw7QfetYMFc3X21tqLEPXmOuQni0WKQRt4FY9T1+
         9xjhEcSCncUBaXqmSMBWGUJ2yzW9uPcXLVcxTDYenaZa7FsYVhO+2BOH+/dB+PBlUB7W
         bRHuuOwjBPS54cW7PZvnrVh2T92QPtXLJxNyDKQyCpj7HP7bZP1PDlH0pfznW2UOx7Fc
         3QC+jo7YkECYYJFPgpUWgN7pbYleUAzXnX/vz2Q1r09KlWnCBrVJORQoCR6qoDxo0CNe
         OqyLikOwP/VXiUoA52M+rTSBgUIUDvBeIPkEhBk0mEuhxM7suK8OSxJlznlJ/2nUh7O2
         /QcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYA45b92RjQcDSzECGhaP1Usv68RGDwxMA3FlDM8emxylCmleZ3EqpyiHG6yEVzfYoAPdIn9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRvoFMf9czxHtPgnVHCSnKQUOCWBG5wYg1Z2VzUIUSDZ80DFX6
	JbcyRCsdZTMnt0f0QJVak5iwsNVCkbQilPieVRw90mhOcYCKinP7KJjken5yd7gZX/0qSa/tN+H
	eq19OYFzVirKyIBpcjN83M7sK3XVR1WYHiYPGDzZWlg==
X-Gm-Gg: ASbGncsc2TmuBTeVVFq7aJz3LgB45PnzjzTEzZiSpcsuQLFkuORCacH3jQVkBS+IPQK
	vXIWsoZfT0PKkz2MipUJlVhsc/g+HVnzpfI56KGSKM4YLPssmlaQCXdWO72PUg4Ao/OERQbgH+R
	m5aaeXKZ5dOQR77/75FeOEzkTujxrmEPp6J0MNP1osmFg=
X-Google-Smtp-Source: AGHT+IEqcYdJwMh4FSJGyni6X0wxHGpPoUz/ob8ESveA1VpUKphDYobFyqmST5aw3MNHLgS47EAGeONWHSlMXxk934Q=
X-Received: by 2002:a05:6512:2315:b0:553:adf2:38bb with SMTP id
 2adb3069b0e04-553b6f42459mr4514077e87.46.1750249687261; Wed, 18 Jun 2025
 05:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616-gpiochip-set-rv-net-v2-0-cae0b182a552@linaro.org> <20250616-gpiochip-set-rv-net-v2-2-cae0b182a552@linaro.org>
In-Reply-To: <20250616-gpiochip-set-rv-net-v2-2-cae0b182a552@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Jun 2025 14:27:53 +0200
X-Gm-Features: AX0GCFtOmBUtsD4jP5iXZmqQJNmNp3Xkluag7JKU4cjSCOXhD78FpOnWyAbPHYM
Message-ID: <CACRpkdYi0oVa3uek7zcb2Jy_YPded6jfEKoXUp=BL01V5XX1MQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] net: dsa: mt7530: use new GPIO line value setter callbacks
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

On Mon, Jun 16, 2025 at 9:24=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
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

