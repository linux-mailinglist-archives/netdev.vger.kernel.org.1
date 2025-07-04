Return-Path: <netdev+bounces-204054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 482DEAF8B41
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316271888D27
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F28328B18;
	Fri,  4 Jul 2025 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MllK1c7P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064E328AF4
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751616169; cv=none; b=IgKZe9Vsuc0Cs42FfdzoJo5IgzqAvnbtY7gbWBEa+sdE3UUgf+HoNllJ+HsohQc0NNADvN08sxdDWxcaUvJNvNPZlYg4ur3xZeAHhyLbiHLcYQbLOBV7o9pxq/uO/ymD8t4wPx2z8Ekrmk/h/f6KYF1Y9qtpXP1Ux1W3hCQ99o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751616169; c=relaxed/simple;
	bh=46Q1fd2UmAUeRYeGhPM7wSGhz2EFf4uCAOpm7Lsa8zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCc19mNYSeM3+Tid7wo7ZktBt50v4TTHsNcLHvt69dY2CzbbYvAsaEjuKhEB9UOjuiyOev1hu1fq2Lvxv6BF5m4DSQQl9TgCp9IC/8Wh60KZN0T4cKC9lofZXRVxC/9Xh8eXucYzyIeNEmTvCDyjzA+MXMBC2TRT8bZwlwwSp70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MllK1c7P; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so1990757e87.1
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751616166; x=1752220966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46Q1fd2UmAUeRYeGhPM7wSGhz2EFf4uCAOpm7Lsa8zU=;
        b=MllK1c7PNs9qQQbLSM7G+74lLv8BXWTBxGZK299gH0fjH5la+q98CSR84sP76JXcg1
         k49QquKoLT2I+0t4QKL3DJZtCiPdGpkjmfsp+kYxFyEUFj18mWgHTl8kvm0SMkl32ywW
         LW+1xGIl0XbVJV2mfWFhUTg1AiBjcHEIDAL8C37FDRMNSos6/ddA1cudanLbzR5WFZo0
         k5oJnnRXdw3rv1C4V3BBlA5zev1PBcezg3wLPO23PBkuVXjyM/Ua6iThDN4KZr/bR+sH
         wupHSciSCbjnE8YURVmPK2HJS5dfdy/KyWqrALT2EAIT/zhkqFOpxePaV0KCfNR8x+Fn
         +OuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751616166; x=1752220966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46Q1fd2UmAUeRYeGhPM7wSGhz2EFf4uCAOpm7Lsa8zU=;
        b=T01w76pOD3f6lor5q6FOHgFKuMXj7aErkzEBhJflE/qY7KWEqXbS8jvgjimEPLQYvl
         s6tMPrsHNPdnaMGxkxsE8UBOqFwwDzyfO9+qu1XP6ANHFNZwdirlukafPXpTtoP4mUvT
         WBTOFhBO83bu9QfHD7eSQNX4mAWoiRGBD6GhT5IUhBHXlQ3lh+y8o6o3NGYisnBIRUjq
         JBzZE4Wx7+s+YBFHe3aNuG9J1vFP3R104DTwrLaQK1hZh83yGqtLfBbJtxQkx4hv3uQB
         4w4lrEXvE2txtGOXtQNn3/OzCJ/XrSJAGvz080kxCHA9U/k+yC2tbSt6gBniZ3TjbyRt
         bf0g==
X-Gm-Message-State: AOJu0Yw1LCU/rXVQMDEPDNTFPLKYZgXouOJPETMiyHrN5zKAUfTpaH+u
	unMLeSRuj1jrUQdW3FMCeZ+Z7Kjtu6dJ10JzWhPFbudS+hOOfs8fumfWF/h955qbzXZecyjS9St
	EbFDYcgeUMnReV1P5FCx7qIn0hAff5mbXGAe2ulyB4A==
X-Gm-Gg: ASbGnctO6UeHen3iINRHDG2e0uWB0NbUv2AVtCQC3Nmw5M6XydDVx2JjT8edZ7zkJQC
	tzdlM7rLyHzmjJ3kbDT5Ej1z52oHVCcuAP6XiXt5Oo4evHNylELOKO49hZmU/sMg/QJ0R1iPlJ4
	oYU86Z/5KmJCItSaf1/IzMnZsNLT+Ob8DOnK4j0CycwXo=
X-Google-Smtp-Source: AGHT+IEViFXCMcn+u4hb5R0d0ojGEnFpfDhNI4g0r3Lc44CnC/koM/mbdYAwzUnF/KlRRn9NNEY5bmwt+E5RollIb+w=
X-Received: by 2002:a05:6512:1102:b0:550:e692:611b with SMTP id
 2adb3069b0e04-5565baa727cmr564962e87.16.1751616165679; Fri, 04 Jul 2025
 01:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626080923.632789-1-paulk@sys-base.io> <20250626080923.632789-2-paulk@sys-base.io>
In-Reply-To: <20250626080923.632789-2-paulk@sys-base.io>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 4 Jul 2025 10:02:34 +0200
X-Gm-Features: Ac12FXzEoK3lIRrRhHYuQcLxyMKzE37BJ8MYgC7nOBJcQ6FysNDrbqPOTwFxTFY
Message-ID: <CACRpkdZ+kw0=X5L90Wuno9GjEi3pEnAV_bdJX=ELUxCbk5spRA@mail.gmail.com>
Subject: Re: [PATCH 1/5] pinctrl: sunxi: Fix a100 emac pin function name
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 10:11=E2=80=AFAM Paul Kocialkowski <paulk@sys-base.=
io> wrote:

> The Allwinner A100/A133 only has a single emac instance, which is
> referred to as "emac" everywhere. Fix the pin names to drop the
> trailing "0" that has no reason to be.
>
> Fixes: 473436e7647d ("pinctrl: sunxi: add support for the Allwinner A100 =
pin controller")
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>

This patch 1/5 applied to the pin control tree.

Yours,
Linus Walleij

