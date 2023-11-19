Return-Path: <netdev+bounces-49005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12357F0625
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 13:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850B2280D9A
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 12:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7B2DF65;
	Sun, 19 Nov 2023 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbP6ibPW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319EE11D
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 04:19:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40842752c6eso8923385e9.1
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 04:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700396351; x=1701001151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=axSsydUUF0Y5l9vNKJsJ3FX1bA0js+eFGLbf4CShQpE=;
        b=LbP6ibPWGNA87a1YUqxEUOEozCPrh/i3baFLDC4jc7CxscnDoTcuzqt0qNc7AEi4lc
         E/G/dnfb+f8iXPYLgtqkrm5fuVSJCgyl7aM2mURfaYtp19HUhXZXM5KA0Q/0/UaGp9+s
         SQaL4GgBHNOicWpKmthTFrzaYlFogVQdKyXYag71+SNo6FQG6Ki588dLNEbNL0czok+3
         5I/5O7k4vYCaRdEqVe1Xmn7+RimfqqUe5YUhTC9Ke9uei/FgdGruNUeF8f+dqfvl60Mq
         V47oM2CB7aJZJll8lmnZnifsUuzUVQaB3FGO/5WiaT86fbEWqH3/M+KUOEjroorD4BnZ
         aRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700396351; x=1701001151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axSsydUUF0Y5l9vNKJsJ3FX1bA0js+eFGLbf4CShQpE=;
        b=O2cR2RD6Oul946cywmiNnFrjx54zMEG3PVKFddQGFWbnFE6ntitmDyT3O7/z/cnqw+
         4+LUuUyXJCA9R2WW6rmC2h/puIdt2u9UBJ/12oFSmd3yYrNGj3TL/WJHSH8o0p9MUK0C
         +0V2MOaehIuqPAGYvp7SuUHqz7AIvnEgKbtxQ15BVvtFn8i1J4oOJ1WMAfjTcACYSFsn
         24cbU2WcAwCHUS/rhAaAi/YuSUiGHmAsPgyC9Nv6+eUuDrJvTBhJFX2w59osUUVXnSUE
         JbZooDcwZRcSO3Ll3zWwNzvup6fUzenkp/1fmaoDh95GsqElYyhFaU3JhM+F95YupjCl
         vbOQ==
X-Gm-Message-State: AOJu0YwJml3sn5gi9JqPRZ14+5BS8U8AjJ0CSBcd6LC+3GtqtAmh+uA7
	LJ+Bqg5qlou8q8w/dSZd04w=
X-Google-Smtp-Source: AGHT+IH0RXH5bCARCn+/Lm6hq9aYDeV23nSvoshZi8Dos9dcCDih1bHSsN557OjbqXxdw3Q9wZ1tZQ==
X-Received: by 2002:a05:600c:3b02:b0:408:389d:c22e with SMTP id m2-20020a05600c3b0200b00408389dc22emr3413597wms.25.1700396351344;
        Sun, 19 Nov 2023 04:19:11 -0800 (PST)
Received: from skbuf ([188.26.185.114])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c315400b004063c9f68f2sm9841477wmo.26.2023.11.19.04.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 04:19:11 -0800 (PST)
Date: Sun, 19 Nov 2023 14:19:08 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [net-next 2/2] net: dsa: realtek: load switch variants on demand
Message-ID: <20231119121908.k4vfqgbkget5e3j5@skbuf>
References: <20231117235140.1178-1-luizluca@gmail.com>
 <20231117235140.1178-1-luizluca@gmail.com>
 <20231117235140.1178-3-luizluca@gmail.com>
 <20231117235140.1178-3-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117235140.1178-3-luizluca@gmail.com>
 <20231117235140.1178-3-luizluca@gmail.com>

On Fri, Nov 17, 2023 at 08:50:01PM -0300, Luiz Angelo Daros de Luca wrote:
> diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
> index b865e11955ca..c447dd815a59 100644
> --- a/drivers/net/dsa/realtek/realtek-mdio.c
> +++ b/drivers/net/dsa/realtek/realtek-mdio.c
> @@ -145,7 +145,7 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
>  	ret = priv->ops->detect(priv);
>  	if (ret) {
>  		dev_err(dev, "unable to detect switch\n");
> -		return ret;
> +		goto err_variant_put;
>  	}
>  
>  	priv->ds->ops = priv->variant->ds_ops_mdio;
> @@ -154,10 +154,15 @@ static int realtek_mdio_probe(struct mdio_device *mdiodev)
>  	ret = dsa_register_switch(priv->ds);
>  	if (ret) {
>  		dev_err_probe(dev, ret, "unable to register switch\n");
> -		return ret;
> +		goto err_variant_put;
>  	}
>  
>  	return 0;
> +
> +err_variant_put:
> +	realtek_variant_put(priv->variant);
> +
> +	return ret;
>  }
>  
>  static void realtek_mdio_remove(struct mdio_device *mdiodev)

This is not so great at all from an API presentation point of view - the
fact that the caller needs to know that realtek_variant_put() undoes
the effect of realtek_common_probe().

You said you don't like too many abstractions, and fair enough, but
maybe we could have
- realtek_common_probe_pre(), realtek_common_remove_pre()
- realtek_common_probe_post(), realtek_common_remove_post()

which leads to even more code sharing from probe(), as well as an
opportunity to have a clearly matched unwind function for everything
that is done in probe()?

