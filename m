Return-Path: <netdev+bounces-86599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A289F8A4
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D50B2D38B
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF8C15ECC6;
	Wed, 10 Apr 2024 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2dyGatK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C415B546
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755471; cv=none; b=LoDElvoy8hneivrpL1Rml6gcUmyaJFzVF61R//1CdI4JdNNXGpzZMt01BLNsHHlY/Pp0XXx39vL3XgRxUDMpqIRUS7EW5SQQUVmtu/TQUgiwI2pmDzApW+95E2CknzLgYMq/WzjszZ+obXxG5d89ZYqXHiHuyl/ZggI9gR4y67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755471; c=relaxed/simple;
	bh=vr+4ffR4jsfWvVOtie8JoKGzi7PY20SWLMj6c9lX9I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnCHo2qV26+bU9pAgot59AFv6NKWS9KY/RLRIrzapH9YKkNPo/oeXNqXsNDFKWa2rKQGHPP10nv+2soxR4fT0vsxwSa8mQYfw2MPD9tWXUDuENq9vvGIqX9Nr6CUz68U/KUVqoD6YNc5cKu9TBGIVy7ogBjH3HowW8W+ZNbBT2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y2dyGatK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44f2d894b7so762098466b.1
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712755467; x=1713360267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=npLaMK294OPrkh2ya1IAeraELco6ekrdVJi99oUA5ds=;
        b=Y2dyGatKsu1wYLWvns4aAnEnl/Gm9sLI9Doqz+RxWeDOOgiIb8/XtFis8kHvUWARU7
         9VKtTbgytWOkb+ozjJVc4uhzI2r5hKH0V2Q2Agl2jzOYGOj2dH5ct1Y+u3jf2E0UBKhz
         iZLnduFv4/cm/zaHU7JK4A6/9uSSkgOIwrpDemUz1tlhPbsXo8QG3kNzFgGMZG6KLOeB
         Gi/rRiqLT9iNpkiSiPk6NR4dg4IQ6rPxTYBjPDmesXwRsniYJKxn3uXMIYOSZNqT08iX
         gItNsji0hr6+b6c0teRAIQwCVq0wbj5ZAIqP0CQEUGbRiGkMwgJREdG7+SMMH06IPvQd
         2l5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755467; x=1713360267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npLaMK294OPrkh2ya1IAeraELco6ekrdVJi99oUA5ds=;
        b=V+CT9i0qoC9WFKfgtFfvPTUW40G8yEv9tZIir9cYctL0NbptvTvpbwURn1auRozv1C
         dLd40j9KQ71AuLXdkld7zpJnLuHAo7tL5zrLzC/dhLuEto1hfJ/UWa0x/w1eeLWQfJZL
         kgA5t9Kn6cQ2adpiBYdnp3V6UtLzxoxm9qIKT1KFGyGUfLWJteWSnkkyrbcjMm5Q0Cq5
         UNgDhbiDWRmk2MtBwlnyySPBlo6vQ6C8MDc+fxYF1QO+kdEG2Y+NmlDT5K/nM7fcuMgS
         /Mb0Vc4qyTpQtmfEDaJKu7gSrjYWAhGiGPuKNn6xuFIb/g+zp8p+m5OPtjMxE53weX7H
         cVcg==
X-Forwarded-Encrypted: i=1; AJvYcCXjHj6YYskHNvVyqwAlNqinQQjXg6+04CLOJKXuyWiUxCKX07j4OQoeishylh9msZdUFVcyhxAgDBkemS2zCdZAQYs55PeF
X-Gm-Message-State: AOJu0YzsCgkPCLlIiPm8LPo1Ch+p8KKEiaSOoTmBBj0SEphkUHqhudqA
	QJS0y6xSHkkwgkNLAIMzrQ0fkb8jRBmP6Ff6sLobl44AIyGu4P6fPeQk/b+rBrw=
X-Google-Smtp-Source: AGHT+IFhqpQQ135//p0GKqHNBTftHaDnlynNRGpsuVHSNcdM0dnZe6Q8vKk1z9WLxXOP9rg1ltfdQQ==
X-Received: by 2002:a17:907:94c1:b0:a51:d1f6:3943 with SMTP id dn1-20020a17090794c100b00a51d1f63943mr2066368ejc.56.1712755467255;
        Wed, 10 Apr 2024 06:24:27 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id hg11-20020a1709072ccb00b00a4e379ac57fsm6927117ejc.30.2024.04.10.06.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:24:24 -0700 (PDT)
Date: Wed, 10 Apr 2024 16:24:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net V2 12/12] net/mlx5: SD, Handle possible devcom ERR_PTR
Message-ID: <ebf275e7-f986-436d-b665-3320a04eb83e@moroto.mountain>
References: <20240409190820.227554-1-tariqt@nvidia.com>
 <20240409190820.227554-13-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409190820.227554-13-tariqt@nvidia.com>

On Tue, Apr 09, 2024 at 10:08:20PM +0300, Tariq Toukan wrote:
> Check if devcom holds an error pointer and return immediately.
> 
> This fixes Smatch static checker warning:
> drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c:221 sd_register()
> error: 'devcom' dereferencing possible ERR_PTR()
> 
> Fixes: d3d057666090 ("net/mlx5: SD, Implement devcom communication and primary election")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/all/f09666c8-e604-41f6-958b-4cc55c73faf9@gmail.com/T/
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> index 5b28084e8a03..adbafed44ce7 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> @@ -213,8 +213,8 @@ static int sd_register(struct mlx5_core_dev *dev)
>  	sd = mlx5_get_sd(dev);
>  	devcom = mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_SD_GROUP,
>  						sd->group_id, NULL, dev);
> -	if (!devcom)
> -		return -ENOMEM;
> +	if (IS_ERR_OR_NULL(devcom))
> +		return devcom ? PTR_ERR(devcom) : -ENOMEM;

Why not just change mlx5_devcom_register_component() to return
ERR_PTR(-EINVAL); instead of NULL?  Then the callers could just do:

	if (IS_ERR(devcom))
		return PTR_ERR(devcom);

We only have a sample size of 4 callers but doing it in this
non-standard way seems to introduce bugs in 25% of the callers.

regards,
dan carpenter


