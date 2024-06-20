Return-Path: <netdev+bounces-105253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C614891043D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFDD1F21E72
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439751AC79C;
	Thu, 20 Jun 2024 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lh5FwdeX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68B1AC42F
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886718; cv=none; b=LjjdKKKBL/o6H6pIJwVIuyfoepR4FNE20d2mMjXsnUklRKV60H0fMpGrnKUyEWff9Jd2RC7+kWeq7/Rghl67/4LA3IBytx+lZBmZiv6PZoLbXwJ1MqSj7G/EwW2wdeFQObn1Y5dBSDvR7QdK/xzY2xXLPkUNkeY8SrbFiG5XPzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886718; c=relaxed/simple;
	bh=jCb6yC3LV7RS1SBbrETONCjgbXRTz+kthAeBoPZk3uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3wSM0xV3IZw66pt3l0jAKoC7K6nq9SOjU8Q87hroS+PpFBahqu0a8IMfE7mF0HJudvlL1FY+ekJeXZ4ExfJwAi5xyJUa6jy7cDKG2K9KdlSyAmN6GYLJnQkoVc2KhQmRzzlNunBOVt+6hpVBNO5xM9l9E9pgTSKEQyXx0SekLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lh5FwdeX; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cc129c78fso770257e87.2
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718886715; x=1719491515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCb6yC3LV7RS1SBbrETONCjgbXRTz+kthAeBoPZk3uE=;
        b=lh5FwdeXYRte/hibWQKRwvHpAFYIEi4E9KdPKeus3b/NANRah3MN0ZsjBIWtkeZVh0
         UtqMe/7gnUesKVU+fpcfpH1NdMZhbwC0GoHk/ufJj+ZiF01CPmlYhqXuKCUVHBVtdQiT
         upTOX59tCycNV1phIJ1oeMjyveovrCUrBZokEp9V6CClnJO5C1T66xMihFPSmiFWGlDC
         QDEfZaY6xEltKwoTSJGwGYesnt79Ti5Wjyf0U68wNTCEP58fmdr5Wis9G8rz4rqF0bl3
         f/aOqzQKDncGmcnJ3Z2wuORCcNOFdBtZ+ByexrEqci5BjwCbDJfFcY15TnZcD8cRf2ic
         clXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718886715; x=1719491515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCb6yC3LV7RS1SBbrETONCjgbXRTz+kthAeBoPZk3uE=;
        b=vhWaSHYZg7tMo/LlrgXPNB9Ldv1O+ldHeOn7ace2NLK0HbairTpfz/Ct7SRAYbKM2G
         nMxYzjaIJA2hx6nadtK2EbqFVv5moDeQlOH/9VlscgS49OKp/dIA4qDWsDxoMukVSHpU
         uxSt7tnvTAA9Rx7Gfe3pya9II/XOimervy3lQoKDo8pLhiaXR7Zi3KmMpnZR2+SCx2LY
         3oq5FoGCNzAoTtVwbt4QxphFIql5tKHAITb/5Mxea4QtW9TTm2WNFCrIBfLKCuBsOsf/
         5Wv3AYNRGZDyKwahpokYcFIFoyd/0Zg7mgEBAflXoDKOhYpBgJL3CiHvzw0q2cEXw687
         IwvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUIFkZQxH6ip3X25BoI/IXzkuayZugFSb4YbnTu35jmxOrT+Fp/jVGI2Hht+zAi7B8DUM8WoP9KX27UShQLNV4PoWCK2MI
X-Gm-Message-State: AOJu0Yx3DX5MujH6b1tHme3WZoQT/SOD9YoU4minz1b2k3BOpKpyK2nT
	z3tZQF6+efxCKO+5auXCU9hhq96q2+0R3cUr6NK9626GSaZNbJ5IFN/lf6jt898BEToSe2S35Cj
	wC/PEc0lrd++ZOxLpPhEoid7E4Q/tw9wAatMWKw==
X-Google-Smtp-Source: AGHT+IFEBqVhz8d0V1M1pa0KZH9RCnVL/MBWmCY5jwSJkoCnbHQgQ/4ArnXiI+p5/MiLtoJrmvDlZdKPBbVkobzIYGE=
X-Received: by 2002:a05:6512:1242:b0:52c:8837:718a with SMTP id
 2adb3069b0e04-52ccaa918b4mr4529720e87.43.1718886714538; Thu, 20 Jun 2024
 05:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619184550.34524-1-brgl@bgdev.pl> <20240619184550.34524-9-brgl@bgdev.pl>
 <ZnQLED/C3Opeim5q@shell.armlinux.org.uk> <ZnQPnrfoia/njFFZ@shell.armlinux.org.uk>
In-Reply-To: <ZnQPnrfoia/njFFZ@shell.armlinux.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Jun 2024 14:31:42 +0200
Message-ID: <CAMRc=MeNGQBMZFg3FTtcFzVKU4xMpnm0BxsAgs+++sFDpU9t_g@mail.gmail.com>
Subject: Re: [PATCH net-next 8/8] net: stmmac: qcom-ethqos: add a DMA-reset
 quirk for sa8775p-ride-r3
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 1:16=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jun 20, 2024 at 11:57:20AM +0100, Russell King (Oracle) wrote:
> > I don't have time to go through stmmac and make any suggestions (sorry)
> > so I can only to say NAK to this change.
>
> Also... where is the cover message? I don't have it, so I don't have the
> context behind your patch series - and I haven't received all the
> patches either.
>

It's in lore alright:
https://lore.kernel.org/netdev/20240619184550.34524-1-brgl@bgdev.pl/

You were in TO for all the patches (as evident from lore) so maybe spam fol=
der?

Bart

