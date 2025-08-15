Return-Path: <netdev+bounces-213938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79838B2766F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 05:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 665E77A3F6B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD97E2BD593;
	Fri, 15 Aug 2025 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eFSyTybM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F77189BB0
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227035; cv=none; b=MzNgKa6rVKp7T4WAZAyUPtIV90jTzEwACi/kiuOL8FFC2vG3e4UXwFPx5q2bSXWc0QKcspiD9R1ArMLiG1Akb2BPWKDfowUi3trad+D3y3RYOVbRpgrn/FpI0aJV/EaUEJqv4xtCuOgH/9hNkwUYvFqHw4vzjtZ7z2qc3CmXdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227035; c=relaxed/simple;
	bh=HinHQKZUtxe4t41iR9D9bn+PEZ105vFBbOQmMnTwk9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3rNhAEUUaNXBXsLPIYn9XjbVlInyR9t58Aa7wKerpqDOKHA0O/vucPOM7dw1d6/OX5ybYILcHAASe3bxw2qJusT1t2eIdAwnPpBDknRnPbPvKUrik4Ut16QPrkakIYytp85qIGrK/N4Ars9x66bqB70JAatLj9jVAJiH+hH1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eFSyTybM; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ce522c7a3so1316759e87.1
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 20:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755227031; x=1755831831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HinHQKZUtxe4t41iR9D9bn+PEZ105vFBbOQmMnTwk9Y=;
        b=eFSyTybMep2zGs8cgTE9pFyv+RTx1qg/TRgwPwPzjOQ7yhv/VSIHID5g3GxVInSYYs
         MEYzYAInQbb171Zo4sOPVbxWclPPKuptT/OeJ9TBJAvsCWXlngg9fkFLbU6PW1q805dl
         OiqErf0N1aN3mvk2cDicMkezFJiuU/xQAQxCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755227031; x=1755831831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HinHQKZUtxe4t41iR9D9bn+PEZ105vFBbOQmMnTwk9Y=;
        b=FuIVNKpoyf9ajDxsMz4zqJuzkTYZNr4EM/vZfJIZnN8nrkYRm+whgu06lUz/YIK43S
         DJCmNQeUw11u+avhGPv61euOLG83AzcxgQCMrQLKjltVJGfYJxHpy5zNLGUZ8NBg6eiv
         kswiMP/g3h3x+sa1hVgp9Kq07nLCFJBzAiAtdzDjFt5YQSTfjDK8EJ2KcZOhKYaJYdC4
         McacHBRXbSGfmp8N5NYd7iYM0PIGrOTLa3ncmFKAZox6TkiJF2KkZHtY50/BqsEVdet7
         ddBNp4UeWoEGKiWbDuugFgMYcKBX1fi4z22hrFu6nlI4ZYoXgaC6CzmS0RZDgo4nEZAM
         SmOA==
X-Forwarded-Encrypted: i=1; AJvYcCVH4t42cXsrg11Bx45N0xfxP9y4dmcF5cs9NnkptBuK0bHIufKhkpGn8mc91wEbyGAVuJ6E+BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOoNq/NNe28ZgC58l/O/yjGR8SQCaBL1Nlu9yiyTtOTXSFNVBS
	mD227BTTNYerHeAZBKuuOxrZNlY/llMegi1cVEFhgAyMgwl8PiiVLBH9YliVBHFbIoYPpRvwKHY
	BwhUHdn1InA1OhhH70NsiEhdHGdZcudDakhZQyq2+
X-Gm-Gg: ASbGnctJDSkk1eITJabAVX/3Ofu3CHbptVNTu7S2YdtYM9rFgjLMwW6ROKg8xAlXh3f
	kxb3zo9D6OeM+EYN7HV7PnkRQ7vOjiFCEjxHagB3Ym8qaCAyc7nDvsob5VvrsiTIaP41G8qg5g1
	fYJV/HYsgiM2CEJLaD1shcv8jvVEho7zGgt5ioLYoBxab74+F62Zzbd9GrJUGRLLwB0mDCdEpUi
	i8AW3psc+9Esblx5fcNg6cH1XfdE0EPxKM4Dw==
X-Google-Smtp-Source: AGHT+IE5oudoWOuExXFcWc613ObdeU+xcba/kkjYM4lQww+ElYzSmi2/gSXFiaP7UzcFCgh/kx+W9zwxu3OJ8SIUDuU=
X-Received: by 2002:a05:6512:1104:b0:553:a9af:9e43 with SMTP id
 2adb3069b0e04-55ceeb906demr143594e87.53.1755227031067; Thu, 14 Aug 2025
 20:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805135447.149231-1-laura.nao@collabora.com> <20250805135447.149231-2-laura.nao@collabora.com>
In-Reply-To: <20250805135447.149231-2-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 15 Aug 2025 12:03:40 +0900
X-Gm-Features: Ac12FXzlE2kni0q5NyqXgX7d170kjvAVh0V3KwwS63urIxRRXRRBW2zdHpmR4vA
Message-ID: <CAGXv+5GDU45O46A+mpdu1HQ_sfT2Su4fgFCtr4xPjoRPzwOWmg@mail.gmail.com>
Subject: Re: [PATCH v4 01/27] clk: mediatek: clk-pll: Add set/clr regs for
 shared PLL enable control
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:55=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> On MT8196, there are set/clr registers to control a shared PLL enable
> register. These are intended to prevent different masters from
> manipulating the PLLs independently. Add the corresponding en_set_reg
> and en_clr_reg fields to the mtk_pll_data structure.
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

