Return-Path: <netdev+bounces-53568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9AD803BE4
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30D2B20A01
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781152E847;
	Mon,  4 Dec 2023 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH3ZyZpo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E48AB
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 09:43:34 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54ca339ae7aso2247085a12.3
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 09:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701711813; x=1702316613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbcwha69FKdiDtAIT067gyDkFiTddeoh7lwsU4NEZVY=;
        b=RH3ZyZpoAVFHhVc1o1WFof7VVYXHhH11qJLjs8R3mAQF7OL2Ka77Uc1ocdvV+m9J77
         6A0HKub6fh6uNVUl6+WrHty9on7vOGkAu9VKnJNnkxu4cz8ANTBXVKIfT/YlLY2Z5S3P
         kwLS00ruDBdlvdTIHdAc9T+ArK/8FoyrMkFZSH+WJFea93gfQIlEYqE/EfcGC70E/QLN
         12bENqiz1xULLhcxYeC0W86QsE6D3CbUn/v/Rug96JCCTwxm8EA68p5CjEKpZO5v9+9D
         N4O+tzG16RSqAuPtkiJqDve4zJPg5mvCFpUnzmJv05ont+AHhX+RJoKdLjrX1Dpd3Ka/
         Rp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711813; x=1702316613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bbcwha69FKdiDtAIT067gyDkFiTddeoh7lwsU4NEZVY=;
        b=tu4RGGsuPw/sB3OnXCNeHUW2gAJ/+CG2DYvpdg3fyXeXyWmFeJyCzHlQuBD15Tohlf
         nD3NcUoTlyBIJtZhjbfpVbo1t8duX41nMnDl1nxCb+HjaJuzJd5529kg4dsmPGPL9Yrh
         Bx4qajAC9ITy+GmnUFk6I0nYRUPPqFZZom6D+Ii0wO+T2pNZ7oENbgyQsyTAMlVQQaxa
         q2pZSnikojo5f11QIVwXOsAAIvYXRolfNhQUqfAJv/D2FX6A/sYAcbTDwUwLpG4MEE5u
         WKuzktwk5wOCdFsmf4jq3LKLeH1xmc6ybySl8tWJsYp2Ag+9i4821HPPfcb28Ao40pUq
         0JsA==
X-Gm-Message-State: AOJu0YyzepgWvzNp7hJ6hLsqbS6IqpYiD0xXcfJQN2edt1o0RwugPq0f
	EKqX6xIkAoC7XpykftzXNCg=
X-Google-Smtp-Source: AGHT+IHQbHLAXxhPpH5IJoltHnxUfwhWn+1X0Rr1OMArx1no3zFFkChDSqMg9fnc3ZzW4xxe8RRHIA==
X-Received: by 2002:a17:906:890e:b0:a17:29b0:573e with SMTP id fr14-20020a170906890e00b00a1729b0573emr2590432ejc.37.1701711812801;
        Mon, 04 Dec 2023 09:43:32 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id jt14-20020a170906ca0e00b00a13f7286209sm5533007ejb.8.2023.12.04.09.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:43:32 -0800 (PST)
Date: Mon, 4 Dec 2023 19:43:30 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Danzberger <dd@embedd.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
Message-ID: <20231204174330.rjwxenuuxcimbzce@skbuf>
References: <20231204154315.3906267-1-dd@embedd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204154315.3906267-1-dd@embedd.com>

Hello Daniel,

On Mon, Dec 04, 2023 at 04:43:15PM +0100, Daniel Danzberger wrote:
> Fixes a NULL pointer access when registering a switch device that has
> not been defined via DTS.
> 
> This might happen when the switch is used on a platform like x86 that
> doesn't use DTS and instantiates devices in platform specific init code.
> 
> Signed-off-by: Daniel Danzberger <dd@embedd.com>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 9545aed905f5..525e13d9e39c 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1678,7 +1678,7 @@ static int ksz_check_device_id(struct ksz_device *dev)
>  	dt_chip_data = of_device_get_match_data(dev->dev);
>  
>  	/* Check for Device Tree and Chip ID */
> -	if (dt_chip_data->chip_id != dev->chip_id) {
> +	if (dt_chip_data && dt_chip_data->chip_id != dev->chip_id) {
>  		dev_err(dev->dev,
>  			"Device tree specifies chip %s but found %s, please fix it!\n",
>  			dt_chip_data->dev_name, dev->info->dev_name);
> -- 
> 2.39.2
> 
> 

Is this all that's necessary for instantiating the ksz driver through
ds->dev->platform_data? I suppose not, so can you post it all, please?

Looking at dsa_switch_probe() -> dsa_switch_parse(), it expects
ds->dev->platform_data to contain a struct dsa_chip_data. This is in
contrast with ksz_spi.c, ksz9477_i2c.c and ksz8863_smi.c, which expect
the dev->platform_data to have the struct ksz_platform_data type.
But struct ksz_platform_data does not contain struct dsa_chip_data as
first element.

