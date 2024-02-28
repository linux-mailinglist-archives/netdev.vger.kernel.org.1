Return-Path: <netdev+bounces-75896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFF386B97E
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 21:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B641328C2B7
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF7086259;
	Wed, 28 Feb 2024 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YDLSFNYe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CFC86245
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153873; cv=none; b=DBhvsEqPcauVt63CpEgWscwYKtKd49sAgsKcpqV3bdrUPW/C1EjsI9KHsi7us/9VFL9d402v00DCpooXpn/UofATYy2f+JshUjVxMg751b0eoV49FRTq19FfKHNxu3XVZv3C02ZEFszUD/sW0noP1sxgS5ZD0x7Ii/WiKaLk62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153873; c=relaxed/simple;
	bh=BWK+pvcfV2O3YEKV4oJw3LGLSCHFNN4QIpIDXt2sN9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sv2uf9Kk1J3/vZeOv4IZ0fOfN/EbCB+4NfBjy2rh32eYVBd0mGqdGaOW2wOMtfbcgw6C3Wxw/9MNAnpptVhNENOFuPouuTuvAyzsej7ZXHCQ2mQsbSO1mUmvZTe8XCJjOt+wvDSkRxbyY49oDiBbwgO/2n7UHw96sgniJ99lLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YDLSFNYe; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso2007591fa.2
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709153868; x=1709758668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e4AfvVPSrhK1drWl8zME51ZTsz4Zd61RouuRi/BwYE=;
        b=YDLSFNYeZ2o8Li6YIKeBGjjEV1kXv9SKeZuDq5S5eAVipbpetuMbCWEnCtG+QHk7mN
         rjY+6cFF2NjPLzUuFxwszsvVtrAcdzCT2/gUE/xhEzsQT7Bo0zaMFSjaZas3fmJg3cdP
         3nlzYqqg8fMvvTrkkCdiRdZKwuIYnveoqAiEr+FVRccHeNYbVZNot0ZxL34JlLIM/+LC
         pcNy1g4BmM4j874sUSAVYSaXaiKNAQ9WVu1u6RhJ37XdusAslPOq+fxYEbnLQs23J7wt
         tI4a8VRHDWgmuA2SIEdEkEuyUtcclgoCMkE0WBAdzDvphKUGu2TGbjerOvXbBUFpmDtU
         uBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709153868; x=1709758668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6e4AfvVPSrhK1drWl8zME51ZTsz4Zd61RouuRi/BwYE=;
        b=o2xqrjTlULaW3OIX2scOALEmlXuNRU8ydzVUcNL3uZipJx8JtTHo9eFxQqE/5XTjja
         0fdLmLuCz7PEmT1uXOL28o9t0r7nIJbsC8Y3ZEzUwLdiLsyf5D36zbt1NCRsD9HJEZCD
         KOyqkVPoPYbleHWZOly7HYnTcuAXPIx7IyTqaT7pB+T7BRVbpWkluTDAJWN5pw5EBTl7
         Tx5vixOHUZAEzc3vc0IPcmXA/0NWCqTuURuFvACAv8BYZT7YhZ8sJUvDRZ98Ev04Jq6J
         bSephAu8fCYDLzULY9PTRUNQ2av3aBvuQ10x720e5KLSzk3Mcpjoy+VhIV9Oa2KKb5d/
         D+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXVHo1GaWyJP27ECrnHIy1i1XidmeIFACEepr5JhhnEcakQhBcbEuBknOBPTcLPVwm2FNrtoryhDY8Gf3MII7bnhIjMKe+g
X-Gm-Message-State: AOJu0Yz9aOfD+oqm6HScDN1RDggrf6Q2pbyRlm9T3ymRuf0IqtU06LQe
	lpzhGrv8cIzORu8MvgW3yRyruQVz/r9fg5qg7qSDJr7f1A9rP8mg1RIRFPdDHLSRZ1P0PAcP60L
	UVS421q43E/X8bpWDn6FbP24kOiNfi4ST/EFrfw==
X-Google-Smtp-Source: AGHT+IEOnOOyvWjN2Iqi7AnFbpftsb9Ykrl/ECUJUwlscNtR6jsb4MdUfMY/fGs0PnTtZQ7ONz+3NPiATH7jgCyTqPQ=
X-Received: by 2002:a05:651c:14a:b0:2d2:b452:3adf with SMTP id
 c10-20020a05651c014a00b002d2b4523adfmr24174ljd.27.1709153868001; Wed, 28 Feb
 2024 12:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com> <20240228204919.3680786-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240228204919.3680786-5-andriy.shevchenko@linux.intel.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 28 Feb 2024 14:57:36 -0600
Message-ID: <CAMknhBGj_+hw0F-g3R6iY0HEooGH1a8gfj1hYx_Laj93OQbQwQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] iio: core: Calculate alloc_size only once in iio_device_alloc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mark Brown <broonie@kernel.org>, 
	Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-spi@vger.kernel.org, netdev@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 2:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> No need to rewrite the value, instead use 'else' branch.
> This will also help further refactoring the code later on.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/industrialio-core.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index bd305fa87093..1986b3386307 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1643,11 +1643,10 @@ struct iio_dev *iio_device_alloc(struct device *p=
arent, int sizeof_priv)
>         struct iio_dev *indio_dev;
>         size_t alloc_size;
>
> -       alloc_size =3D sizeof(struct iio_dev_opaque);
> -       if (sizeof_priv) {
> -               alloc_size =3D ALIGN(alloc_size, IIO_DMA_MINALIGN);
> -               alloc_size +=3D sizeof_priv;
> -       }
> +       if (sizeof_priv)
> +               alloc_size =3D ALIGN(alloc_size, IIO_DMA_MINALIGN) + size=
of_priv;

Isn't this using alloc_size before it is assigned? Perhaps you meant this:

    alloc_size =3D ALIGN(sizeof(struct iio_dev_opaque),
IIO_DMA_MINALIGN) + sizeof_priv;


> +       else
> +               alloc_size =3D sizeof(struct iio_dev_opaque);
>
>         iio_dev_opaque =3D kzalloc(alloc_size, GFP_KERNEL);
>         if (!iio_dev_opaque)

