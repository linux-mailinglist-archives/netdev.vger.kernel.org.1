Return-Path: <netdev+bounces-103615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B7D908CAE
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409631C2385B
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D344C96;
	Fri, 14 Jun 2024 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLfzyx96"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE16C133
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372772; cv=none; b=sFBU4eO+h6fFSDIZICwn8GrYwsf4gDFmOJmzwp8AB7Z6uo3A2CkSG6QL57RrNnNqsjE+wq2Dm3f7demexnNg6+QbQVa4++/KlV254zfVkchrvYXXv3bSPI+GbdXqB/dLXhRfTOdbc4fuyrquZtrF/I/FjK50Z+pAJDJ5Au2W8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372772; c=relaxed/simple;
	bh=zTyIZedtWX2FApGDJgWkCYBBo5yO4RKS1RIBqNmnQ/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP1mt6fNNOFfSqfiDJTROEhiYq3Vn5jowDeM2uwNRnGm5V6DLvN++sEVvl45jz/6WzD0OzQXCH4bZuQI5MnOS9jdhMpwyYjjhWx0iTlBHuka3JWLd0b9VUyU1UZVGC6e90dE/zx/nWkGBZ7Z6DvzFkF4xzkdUemQdoQQ9/Eiees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLfzyx96; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52c8ddc2b29so2425130e87.3
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718372769; x=1718977569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqtvZEeZfg5PFo8/EJ1xZoE8ZwqK47qnIgVHBHL0/ak=;
        b=gLfzyx96taqPORzLundsg/l1beOo0R9WH3P5bF6cIk9YOkJdK3H8qVcQ7lQol06MZC
         oOdhIFmRGteX7J/6Fa7X8b0TYqYTmOsb3mTXfDGFxoDesJPQSALubUtMFBR5TrJkaIGZ
         PQ0/uFtw1P6HAUnEOxugdFNpen8VfJ2MkeOjO7yz/3245dkRTFVg1sOeIGvVruRdaKvB
         4EEUHsBgS7WgvDwQbX69fLWrmN9f/Sj21/9n/pKIcT77tDe8ifTsuDt25jiLJyFA5pPo
         x81yJsheZnuFOi/TOOnA4A8r0Tv2BKFKiyT+9Zm+lZOiNh9fwBNwdqhqxP7wEu6cIA7h
         FDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718372769; x=1718977569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqtvZEeZfg5PFo8/EJ1xZoE8ZwqK47qnIgVHBHL0/ak=;
        b=Hygo3dCNddL+9yFM6t8MU13sEuM7nKy8VT7gmbeReODG+WiemKCYOBufIjOyasSxH1
         THMh9NwThW5FBqjsDm29PkNoncC4DNuL3mOqB49gcVucst4+t+x+nVI+iO1b+i4w2VRX
         k13q5xp2kvd3d290QUmqhjlz+uj8I4yA3bNrn2cMqls530rqrT4Dhz9F2ZaP5wHjpoAw
         bfCbdOytr4kFcSM4RA/QcKS5hzptJi8ZYY19kmI1p1p52GS5iPbzGIhqUJA+9pmjg5m2
         wxKfdcW5/YK4kvRuAXAqe80umb7cw5umjAjuNingzdQWryDsJ0nQJD+RsW3qy2THd/4c
         ZXRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKf6D8nWZLKq2YmFn3Ik5RfD1lq/IhEIkUAk2N4ALHnJpTnWXQlnphxjEpR2HuZlrjlKiBboOVuuER1d1u5M+p/i1XfFks
X-Gm-Message-State: AOJu0YyYZU9uTlV9GTWuyuLa2fO70lMyzTSQpALxyNrKuKBC76SyUlJ/
	zyz+14/ay5rW2JglMozb2nyz+p4zr0L0bR88DpbnNu2sFg0UVVoPoVkMMkhC
X-Google-Smtp-Source: AGHT+IHXH1Jr/cDMWmIdk5tNNb4rGlnFXcxxcuQ0mlmvtouMDoOEIQW+nad/P8kcSZJTKz+Ifx8XYw==
X-Received: by 2002:a05:6512:12ca:b0:52c:84a2:d848 with SMTP id 2adb3069b0e04-52ca6e9b087mr2983049e87.65.1718372768334;
        Fri, 14 Jun 2024 06:46:08 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2888595sm523020e87.284.2024.06.14.06.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 06:46:08 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:46:05 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 04/15] net: stmmac: dwmac-loongson: Drop
 duplicated hash-based filter size init
Message-ID: <67gnb2k2hyyfycopv2tpyn6ccgp5x7a52sct3boj6pedoix44d@crv36xvkt55a>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <486b9be6b4b33836d03563679af8b8e3427efb8c.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486b9be6b4b33836d03563679af8b8e3427efb8c.1716973237.git.siyanteng@loongson.cn>

On Wed, May 29, 2024 at 06:19:01PM +0800, Yanteng Si wrote:
> The plat_stmmacenet_data::multicast_filter_bins field is twice
> initialized in the loongson_default_data() method. Drop the redundant
> initialization, but for the readability sake keep the filters init
> statements defined in the same place of the method.

Looking good. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 9e40c28d453a..9dbd11766364 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -16,7 +16,7 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
>  	plat->force_sf_dma_mode = 1;
>  
>  	/* Set default value for multicast hash bins */
> -	plat->multicast_filter_bins = HASH_TABLE_SIZE;
> +	plat->multicast_filter_bins = 256;
>  
>  	/* Set default value for unicast filter entries */
>  	plat->unicast_filter_entries = 1;
> @@ -41,7 +41,6 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
>  	plat->dma_cfg->pbl = 32;
>  	plat->dma_cfg->pblx8 = true;
>  
> -	plat->multicast_filter_bins = 256;
>  	return 0;
>  }
>  
> -- 
> 2.31.4
> 

