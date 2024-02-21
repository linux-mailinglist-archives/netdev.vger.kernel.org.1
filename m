Return-Path: <netdev+bounces-73825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8756D85EB98
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 23:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83561C21FAF
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309FB128828;
	Wed, 21 Feb 2024 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tE5CbTty"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131D10953
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553246; cv=none; b=srLeA+ibA6S8qZkn6aTLwxfSjy5B08fT79J+KSOWDOn+EPEpg5nJbqnPLWdK5dhjxsENcBMknWk2kno3Pe3kUsFCQq2FZHC5ltK4/xYhAS7rI2a7wMi7eFVpgh49DwRX6Cv4Fiex31U/PdsgLgqL+GTlfxNXOk+vNNtMwWGMdD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553246; c=relaxed/simple;
	bh=iNidW3f5wsCISbKAXdYoDRvGkkbi4875RfDnKAT5TGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwT1X5rc6J2ZrLiYQxGW/O6SOBhGHcE4ht+c8u4v5B3Ay8el3Lc5wT++pAAIndmONayzVfTOohhcWb/iVpD9eWpsE2LTx6mBc/TgOmjva5ga+B/1dF2j04LbNPCqnHe2v7Ui3YTRmh1vGaSLOkzSSyT2rXEoPBefycbTTZIH/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tE5CbTty; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-607d9c4fa90so74790767b3.2
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 14:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708553242; x=1709158042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cIdAj9Rc9YrdEZf80SuI9gbBcjMeYE4blz3NlBPNkk=;
        b=tE5CbTty8JoVcAb7WjBqLRfrAV27yaXE5g+MkmfL2vfm6VD/EBCADX6YbvvGGvfWqE
         ECkjUVRifnTAdb3lHfrQP2o4c7YOr0y1RfN37DQNm8QSR1XCDDdQTQw7ynSRW6rQGBi3
         4QGRhIwUT7iAJxV6VznNSo6iQ647Dagfkp3tyToU2dkjSo+Xid9+Mrn1lO3Qv9yu0iDE
         5uM2bl5B4bj+nMG/ZTKyVQVwIxtNBvg/W8GlZzPCR7hnyiAsWBvPrEnNNUoSSq94txlZ
         RAmC1Bke4WkKePOkoeR5bLH7FC4vvBfo+x7+zVTLs5OCMRtRf5EJUKfq9XLLa1JUupMO
         nO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553242; x=1709158042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cIdAj9Rc9YrdEZf80SuI9gbBcjMeYE4blz3NlBPNkk=;
        b=JUOLSAwBiBgcZcaHpsv/HUwJoo3o8XPH/Hp21mGM7x6fpXTQIIr2CwJ7o6U1CsbZVS
         56D4q/vkiDvxCWCXOBmbbZH1wg7tJENzMWOcXe1KiOJIm7HXa9fw/Vc5jUkIuDywWCIw
         jzo1vCfTPk/kwT/0AH5qHV1VHZinyODA4qzeBAa4YH0tJmgXtzupnTSeXjMRXwFFy5b2
         eeJJoMEXq3mnGX19vVWlFxLRScd/TgorBdmbo1dgjBHcviIS3mg5fJI3syN0BhsChcPn
         Ka2Fo4LZML0e/1cPl1uLBGk1EudEmn7yrD9BjOq20knaRibO1fv591yra0VwuXDQWafD
         gHDA==
X-Forwarded-Encrypted: i=1; AJvYcCWHuRnsqnrwm44HUtbXpUY9aQvZbqEUHa+sNSvG0lXkUVdJ9P9mpyGjTsbd9d1bWTmgX7QvpMNoKAGt6e5LZkMU5GOXcla7
X-Gm-Message-State: AOJu0Yx6eRi1p78GbOVJMyA9Ai5Z1CpNzo2BcKETkwCm6npwrPGcXAqu
	m7B/LP7I8qPQgyymCneDjUC1MWJA7hzfPtQt9S8Dbh1qmpcSUS9Y7Xx+SP6sfvUn8n+qxmbz0yl
	0U+9D2KWfkh5s1uRr1gjP9qC7rLWeGzEj5m7zb//IXtg6kfs1
X-Google-Smtp-Source: AGHT+IHcXCkZHHGUkDm2xvIgiK6VurrE3eAJdP/r6uC/vcQd0YLTd8DmYtHQlaiiKrj98oMZezfQEBryKYUS8JEchGY=
X-Received: by 2002:a05:690c:86:b0:607:d9f7:e884 with SMTP id
 be6-20020a05690c008600b00607d9f7e884mr20419761ywb.4.1708553242109; Wed, 21
 Feb 2024 14:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217093937.58234-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240217093937.58234-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 23:07:11 +0100
Message-ID: <CACRpkdajVH4Y2K5W+o5XAoiEr57ObVbaR+9QdFV=Cp765B+dfQ@mail.gmail.com>
Subject: Re: [PATCH] phy: constify of_phandle_args in xlate
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 10:39=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The xlate callbacks are supposed to translate of_phandle_args to proper
> provider without modifying the of_phandle_args.  Make the argument
> pointer to const for code safety and readability.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
(...)
>  drivers/pinctrl/tegra/pinctrl-tegra-xusb.c         |  2 +-

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

