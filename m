Return-Path: <netdev+bounces-65834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3924283BE9B
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 11:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83B91F26397
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09821CA97;
	Thu, 25 Jan 2024 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpgoIhQT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6C1CAA1
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178331; cv=none; b=Du/zs1G6EquZAq3cs6mwx3vlVVlYfY8obhoLGbEb+B9fs2L+UsdLJeQ0XuWZn025vJUxet8NPsZynaqsrL2/NSSS5A+QiqLoO8Gf6NusJqjin3JHTKk5dRF3FuzidJ+ObLjy93Z95eQ5wASVZTqezH59UztTphTPCm0Cm4YZydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178331; c=relaxed/simple;
	bh=Jn4Edn08EdGNZH6SmITS/I1s1i83aCOmDHRs2Z4DUtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLEZuFi3qn+IhG/mXzk6IBIz7/Bu3J+AVKSmhydHp9QAF6B2m8RHxx6WUtyPftYYVHeMff2XfzRunlBOAmcvjZmU77qwNE5TM/8OxPae+1YHRKhGxRuCex9PTqQEK+YftOMg3QrjrXTy473Q314+AJuF+/MfuV/BWc4+Bu4vFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpgoIhQT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55d050d935cso395970a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 02:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706178328; x=1706783128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vx07nKxyemPUcpsFXml6T4ZE+azAeJXSya/Vx4aRzYg=;
        b=RpgoIhQTBiwkf5MhZDaop1qx3TexrNYQhHxsvT6jPz9VQJ0jy8tep67vXcoa3BeJ4m
         Nq944i1dpiRMEHeDkEz1GMMctVgiGci1usTFkSyoxz/FpIqnQdrt8Qve8dsQPVRDQ2tc
         fJuMvypkI015NUrc27TyrxCFGnssBsPAKAmjKehd/073KT0ogE0QvGxN//fmO8Nv6mVg
         dwYiDu8asKJE1GejwgIC2rYg9Xj6uq1tK9XvurB0UA0nErRcr+1ibZGYn2b/UaPhlER2
         jslu1BnRdjbQBaQVXGCtT6q04zRt4JDWSxbiVP4BJzDIBuj5gkU97/SlzpNM0fT4sDxW
         FtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706178328; x=1706783128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vx07nKxyemPUcpsFXml6T4ZE+azAeJXSya/Vx4aRzYg=;
        b=gg7j+4L4x9HZpZSg6+7o8iJQwunjjqEVFJIdweh+JoujMFaXX1Rwjv8JfWdQvAJpaJ
         xnvqIWy23WyNzxKgo5vyOH5KaI/h/emzTPROuLGlKfcIZTcS0u/tEaJDfn8svyJhdn7/
         VK+mDueRGMrPtYna+CEp1Zaizf+K8bBodZnTN3HltaZkiykDKmiKfGePP6njtFE2R4MV
         nn6lUfGNTraxGBdJCxczdNrSS4XjtCZQrBfIibJiBYqvh/g1OwuqcKjIBNZY1rHOxEvH
         rHJX43FtHFlsYiYjlAs/rqTMQ9zkZ4jPqTGTtidTT0BO7wHS8a5EwDCdMaofgpprletJ
         NVlQ==
X-Gm-Message-State: AOJu0YyhmYcQ6jmm+kDaAmK8dSnLmGP2r6Zbl0dhO2pyQQk02+QKPVvA
	hyxNOmK5uvfWWbcM6UAHXmRUtxKWdOfmjdc5UHgOEcTzIvsRyinF
X-Google-Smtp-Source: AGHT+IHKUJZkP3WyUGmrLAdMAKuIjps2C75U/MmZHvrJ6Ff4ZujwbQ0kjWYmqR3og7k2zK4KjIyAWQ==
X-Received: by 2002:aa7:c311:0:b0:55a:553c:a987 with SMTP id l17-20020aa7c311000000b0055a553ca987mr447586edq.79.1706178327979;
        Thu, 25 Jan 2024 02:25:27 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402401200b00559e65bb529sm9752096eda.28.2024.01.25.02.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 02:25:27 -0800 (PST)
Date: Thu, 25 Jan 2024 12:25:25 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH net-next v4 03/11] net: dsa: realtek: convert variants
 into real drivers
Message-ID: <20240125102525.5kowvatb6rvb72m5@skbuf>
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-4-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123215606.26716-4-luizluca@gmail.com>

On Tue, Jan 23, 2024 at 06:55:55PM -0300, Luiz Angelo Daros de Luca wrote:
> diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> index df214b2f60d1..22a63f41e3f2 100644
> --- a/drivers/net/dsa/realtek/realtek-mdio.c
> +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> @@ -249,8 +276,20 @@ static void realtek_mdio_remove(struct mdio_device *mdiodev)
>  	if (priv->reset)
>  		gpiod_set_value(priv->reset, 1);
>  }
> +EXPORT_SYMBOL_NS_GPL(realtek_mdio_remove, REALTEK_DSA);
>  
> -static void realtek_mdio_shutdown(struct mdio_device *mdiodev)
> +/**
> + * realtek_mdio_shutdown() - Shutdown the driver of a MDIO-connected switch
> + * @pdev: platform_device to probe on.
> + *
> + * This function should be used as the .shutdown in an mdio_driver. It shuts
> + * down the DSA switch and cleans the platform driver data.

, to prevent realtek_mdio_remove() from running afterwards, which is
possible if the parent bus implements its own .shutdown() as .remove().

> + *
> + * Context: Any context.
> + * Return: Nothing.
> + *
> + */
> +void realtek_mdio_shutdown(struct mdio_device *mdiodev)
>  {
>  	struct realtek_priv *priv = dev_get_drvdata(&mdiodev->dev);
>  
> @@ -521,8 +548,20 @@ static void realtek_smi_remove(struct platform_device *pdev)
>  	if (priv->reset)
>  		gpiod_set_value(priv->reset, 1);
>  }
> +EXPORT_SYMBOL_NS_GPL(realtek_smi_remove, REALTEK_DSA);
>  
> -static void realtek_smi_shutdown(struct platform_device *pdev)
> +/**
> + * realtek_smi_shutdown() - Shutdown the driver of a SMI-connected switch
> + * @pdev: platform_device to probe on.
> + *
> + * This function should be used as the .shutdown in a platform_driver. It shuts
> + * down the DSA switch and cleans the platform driver data.

Likewise.

> + *
> + * Context: Any context.
> + * Return: Nothing.
> + *

I'm not sure if the blank line at the end of the comment is necessary.

> + */
> +void realtek_smi_shutdown(struct platform_device *pdev)
>  {
>  	struct realtek_priv *priv = platform_get_drvdata(pdev);
>  

