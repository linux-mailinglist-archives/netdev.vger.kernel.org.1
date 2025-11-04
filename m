Return-Path: <netdev+bounces-235454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 020A6C30D9F
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 13:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FD54605A5
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303182BDC34;
	Tue,  4 Nov 2025 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Payiagug"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A791C8631
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257682; cv=none; b=laCsv6MXIFqj9ucT/apQ8bHWV8L55e9oFcm/Flc3BGdf3dTJabm1KtA4S+2GEbFHUFZdJvEKosM5grz4qB921FsNs5Yf4qLjg/+6InlzSbm7b4XqQW47mBemHVa4gPgb73JGOHCAWwapCQabcFeXEz//u6YbGxZcK/p8DeYEOgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257682; c=relaxed/simple;
	bh=iV5WlNJsexEomSTtugsmAZnwIzTY7lOv4y7cDAEP/lg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZsuV6+28BxSBQlWH0iHKWj/5z3A4FrwSes3hxiz4naDvWp5VTM+tzJ+SrOCSgV908XR+KkzqRkyDFCJQJ6w36/JHMxX4fhK1vjCU67W+D+I8TsMGm+7XFzeOWX9NXWSRB/KsLykZ7+PhCcErsc24ywAw3RsxQd7jPz0K8ZzBs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Payiagug; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471191ac79dso60646315e9.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 04:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762257679; x=1762862479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Oa9c5I2G9C7etQhDShMhCrIwhIqdSNp/I0n/6rWHFZY=;
        b=PayiagugcmK7p5vY/UnAL6wNcAL1FOwXY6iU5+p1BvqAURP4fk6tUTCX0U21OYg8nF
         of3MxZkbCJTuQjSPlqQa2rWmV8XVMvoS0YLRc5GqnqIVtqKJuHCOpoZ7JzYhBP1yT3bZ
         UeDHp23b62eoUuBe9W8JXnYC+AOt2b/i1BuH5OQGd+amd+aQIUgcdr6ivhrKERJfoCAT
         ef7ivcMYPqxHuUXBs/6XyekYyKWu9dZiTPxrpRbo3qtrZmLF3+hmaDynwLtpqpPgyS1t
         7rb0zqWH4rsEb+kW64WcGRqnZILPaJEKx07IIsGUtPXeRY1sabmTJmaLbRFMUU5LENU4
         5KpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257679; x=1762862479;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oa9c5I2G9C7etQhDShMhCrIwhIqdSNp/I0n/6rWHFZY=;
        b=nn07GkIOifxiY+krCcuRy6xXxetKqVcsyXl9khI7ZDd4D24lDp2Wx29I1+2fh+1W3x
         wNxNTpJQRgyoHiRKJEVJNe1+3crLBXoPdFkgsvJ9Jv0dJ2+6qKd6rxFDk3eacT8Ghtyc
         oz2tF07IX4/HYDWGqCU+SiQuwk8PgUjF+h+STFgjvrnEpsq4Z3HJUCGi40uZKX5Xvhnl
         4jtIKjtHFk5O359DMlBVCqACLucHRtKtxZGLga4qCnuWREUXxvzffS+qvTCrfoOJEFh2
         /H9eQU1RoYu0D5erUxFdI9hxRgqtR7Mr+V2u43P/cacTediWI6eT+SKACp1xQ+13TTHY
         nbow==
X-Forwarded-Encrypted: i=1; AJvYcCWQjmQYulpyGfz8CzPS2CJzTxB9k5uP3N3Fx/kkHKFpaQnb3QeBKwsjuNLS6CmeFpUz1ocskSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyp/grrLLKDYY4hAGE6HcNZzng1bec5lpYpdMi+gE3bb+9ykPD
	xEDq6RhxeZ3kaS8dwBo8z1iQKLXL08bzth8As4GvDPe9C4Dcp1WTWeiH
X-Gm-Gg: ASbGncuFoqGJg9y6wASssIKUWP6Pq1h1QCUDIzkqtAjXr2Edy2WYpYOYLnVdc431JMo
	eeQ/gg38/MplnSH2tbal7ubH8v3g8c2D3ik5Af21XHoegyJAdfeE36toAEwXg4Es1z8Bg9XVApl
	Y1lbcza9kLbRdFl9S6BURBYMKLGxn0JbxVM7RnSxQ+jPqGhhwyaVOVrkd5G7lBXv1gr2ugxvF2x
	nlaB6KN2MQaMRr/NvR0U5b8DN1OL4iAQ8kxUUd5hLigS/yXtLCUloqXVxXb4pbJA0yTPWxBhngG
	LiLRs9bEWkB0wXMR1N92BUJPEKYdMUU/3lZqSkQAxiNyejWa8BNrxQzgT+OG39nLIOJx0kaHOua
	I3NOmn7DIZaa9Yli5ntHurUHQnJdS3AYFWYItOFbIqXnERsQ7H33V8aIMR7MmaYiISe8inm7V7K
	iPfErq0Ki2LfxxY2ltNHB4HmFH6OEebyy3+XJlw/U=
X-Google-Smtp-Source: AGHT+IFDBHRu/DzIcF0dLILa2Wl3cNodbIcp1Kz4HNLg9oeMLbDfttP6R7Efh4S7lQLyC/9TbSUV0Q==
X-Received: by 2002:a05:6000:2005:b0:427:454:43b4 with SMTP id ffacd0b85a97d-429bd6a94cfmr14119577f8f.48.1762257678426;
        Tue, 04 Nov 2025 04:01:18 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5bc0sm4382920f8f.29.2025.11.04.04.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:01:17 -0800 (PST)
Message-ID: <6909eb0d.df0a0220.3d8529.c3fb@mx.google.com>
X-Google-Original-Message-ID: <aQnrC2A5FEEZeM3_@Ansuel-XPS.>
Date: Tue, 4 Nov 2025 13:01:15 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: hkallweit1@gmail.com, andrew@lunn.ch, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net] net: mdio: Check regmap pointer returned by
 device_node_to_regmap()
References: <20251031161607.58581-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031161607.58581-1-alok.a.tiwari@oracle.com>

On Fri, Oct 31, 2025 at 09:15:53AM -0700, Alok Tiwari wrote:
> The call to device_node_to_regmap() in airoha_mdio_probe() can return
> an ERR_PTR() if regmap initialization fails. Currently, the driver
> stores the pointer without validation, which could lead to a crash
> if it is later dereferenced.
> 
> Add an IS_ERR() check and return the corresponding error code to make
> the probe path more robust.
> 
> Fixes: 67e3ba978361 ("net: mdio: Add MDIO bus controller for Airoha AN7583")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks for taking care. It goes against the schema but yep it's a corner
case that should be handled.

> ---
>  drivers/net/mdio/mdio-airoha.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/mdio/mdio-airoha.c b/drivers/net/mdio/mdio-airoha.c
> index 1dc9939c8d7d..52e7475121ea 100644
> --- a/drivers/net/mdio/mdio-airoha.c
> +++ b/drivers/net/mdio/mdio-airoha.c
> @@ -219,6 +219,8 @@ static int airoha_mdio_probe(struct platform_device *pdev)
>  	priv = bus->priv;
>  	priv->base_addr = addr;
>  	priv->regmap = device_node_to_regmap(dev->parent->of_node);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
>  
>  	priv->clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(priv->clk))
> -- 
> 2.50.1
> 

-- 
	Ansuel

