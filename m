Return-Path: <netdev+bounces-241047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 214CFC7E05E
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 12:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 966604E1881
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F10A2D23B8;
	Sun, 23 Nov 2025 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiEK8K05"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB0F29E10B
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763897811; cv=none; b=J8rsX7vkpwaf1NrsT90MEXT0J20yluNO6bnzxy3rtuwI9zFq/d/1+kXalb9LuEAajvFWprh3WVzBS0bcBconXzdILlMynKV19PjLTVuppnz1cQ3inTwp4T+RNrShFraXCgI3z2M7cURtKyPhR6p06u1bLwdZ9f0Ax/88ZcuiHsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763897811; c=relaxed/simple;
	bh=ja6UFnzGAB4ebKVAp8A8FBBLaCeSYVrAk0QZPuMqtSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2Oc9PyTro2ebZFne3MfS2oU0N7O6v4pJfTo2Lp1VysdUgy/NGjNzt3kj23uu/ByAkvND2PMQWRm6i2wkukWN8vcjLwp5MisdC33IZrpNfonknpnkwWzFw4rD6l5DdR6buwGl+IXzKTma8AGXDd97gPTWcWo3DPhIFRO7F+IIBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiEK8K05; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c8d1be2eso376319f8f.0
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 03:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763897808; x=1764502608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HfwuTUTAUfU1xG2cflPLZU4s1JAz92iyW+2u9F/7P6Q=;
        b=CiEK8K05pvo4JomSPBeYbJu2tVtdOy8vpAniXH8yMcJHs45WNU+OTuFn5o1ouIsh1/
         4q1ODsFpXrkKIPAt2uaukMZsz7+0zkOU4JUy4mUaECQdtQFJQJ660MWfXg1EbPURNf7l
         3SzP5dhvRm3bt98NfblmLTgUDG5g0ONyydvWwhqtWnoqjICrSx3IadWS/c5471vAElle
         CRy29K5UnIz7Ij6zS2fcmFJV/HfqIy8EaiD6iOZxThhH37RXC7/qgIm15sPymyXeqIA3
         aMUh5RvgynN2LaZXv8dm9/HbcQIMeITEcVPiBPcbNIuo9cmG1wDdrAidJjE+ZTTwAPiK
         Ngpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763897808; x=1764502608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfwuTUTAUfU1xG2cflPLZU4s1JAz92iyW+2u9F/7P6Q=;
        b=VqPgCBYxdygt8lvxRUwuDLgITP1pti3B2cQjEPs02seuG7WLZsuDEWQELVDOwpC0yd
         HjelJp+dgAfI5SOvzS36ML1mUaHXHkZuNRpU5eR4pC8Rqb+46u5lqQpFTC2a4asA5dOK
         1XWwXt5W/NNolW+JDNHRBq1s+C3tBtFJM8rVz0prlSCHAWXfRHqf68LVi0YlnoBdmrP9
         1fGyKg7RvyDyRVY03tBVX6P5SLSBMtZTaGPnTCvFYME2dczPqqRjdBuE1xyOel8Wkfsl
         vHwRxvHRRJWAHARIXt68J1E6sSpWpw9GzOYbfyw5lvTvDCiuv0nHf3LIr0fLZUO7iGdz
         Yp6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPAYV3J9tS+jeOhbg7XE+aREZAtyZSqztieZED4Jz7HM3SUVzovRUC3PhnDp4O0EM2lwifSMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wdUIkAo9zA9FFJittXpBboazq+ftcwaMkhSQNso60uUEVBAY
	vKtxikSu1aSLzg9GFRybB93wlbriYLntz301VF6e7bGJvVp8/EM/bj7a
X-Gm-Gg: ASbGnctO422w+MWCR7gEDq3z7reBBWj08VJ+CXCDq/5S1cOdMXF1xWcISX9s+0wx9H+
	OkiHnZxsLBgoq2ndwfkOChe+QSf7HFMN32dPrcdawDrMOc4tkIir/GoBlZIdLrfSFt7/X5dG5Uo
	rI0Bd2z5nN0AQc7a73IttA7Jpv8GEtstbe0vBrpu4L5sSLCa124B+iSo9pPwagBFHyB0rwO8F6v
	R5myysI3l1kHKgSdgEezZuuVrkpfjRnd/VlGo32y5Xpp/skP/jbZrhLWq3pfZHWpDW4xbkwgck2
	6ZvoksUHJZg3p1nhVpEoluxWE4vVcFH2RqbRAOpdf0pTHXlw8/yyXg/8jatXRxJSZgDNv046a7r
	aRor+4AU1HU7YZ+xfTuMCW4YB14kTzeHchlFuPrlRrwf7GXGh/2PAylilwLnlqCt34raeyJypns
	kqVAI=
X-Google-Smtp-Source: AGHT+IFYbDFURjdFNzDsXM81xihMEV6/yHyWNUp8Xym4Agx1uNZFO0N3vjkBtnV6TVXFITr30mic6Q==
X-Received: by 2002:a5d:5d89:0:b0:429:bdaa:9672 with SMTP id ffacd0b85a97d-42cc3f5f766mr4429554f8f.3.1763897807474;
        Sun, 23 Nov 2025 03:36:47 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:272e:6a6f:51d7:2024])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363c0sm22232822f8f.18.2025.11.23.03.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 03:36:46 -0800 (PST)
Date: Sun, 23 Nov 2025 13:36:43 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, o.rempel@pengutronix.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: microchip: fix mdio parent bus reference leak
Message-ID: <20251123113643.cf2kc7i5cvdkkaf2@skbuf>
References: <20251121042000.20119-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121042000.20119-1-make24@iscas.ac.cn>

On Fri, Nov 21, 2025 at 12:20:00PM +0800, Ma Ke wrote:
> In ksz_mdio_register(), when of_mdio_find_bus() is called to get the
> parent MDIO bus, it increments the reference count of the underlying
> device. However, the reference are not released in error paths or
> during switch teardown, causing a reference leak.
> 
> Add put_device() in the error path of ksz_mdio_register() and
> ksz_teardown() to release the parent bus.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9afaf0eec2ab ("net: dsa: microchip: Refactor MDIO handling for side MDIO access")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 933ae8dc6337..49c0420a6df8 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2795,6 +2795,11 @@ static int ksz_mdio_register(struct ksz_device *dev)
>  	}
>  
>  put_mdio_node:
> +	if (ret && dev->parent_mdio_bus) {
> +		put_device(&dev->parent_mdio_bus->dev);
> +		dev->parent_mdio_bus = NULL;
> +	}
> +
>  	of_node_put(mdio_np);
>  	of_node_put(parent_bus_node);
>  
> @@ -3110,6 +3115,11 @@ static void ksz_teardown(struct dsa_switch *ds)
>  		ksz_irq_free(&dev->girq);
>  	}
>  
> +	if (dev->parent_mdio_bus) {
> +		put_device(&dev->parent_mdio_bus->dev);
> +		dev->parent_mdio_bus = NULL;
> +	}
> +
>  	if (dev->dev_ops->teardown)
>  		dev->dev_ops->teardown(ds);
>  }
> -- 
> 2.17.1
> 

Thank you for the patch.

I see 2 problems:

1. I'm not sure that releasing the reference to the parent_mdio_bus
   device is compatible with devres, since the MDIO bus created by
   ksz_mdio_register() will continue to exist after we release the
   parent_mdio_bus reference. I think it would be better to remove
   devres, introduce ksz_mdio_unregister(), and only release the
   reference once our MDIO bus is unregistered.

2. Error path handling is incomplete:

	ret = ksz_mdio_register(dev);
	if (ret < 0) {
		dev_err(dev->dev, "failed to register the mdio");
		goto out_ptp_clock_unregister;
	}

	ret = ksz_dcb_init(dev);
	if (ret)
		goto out_ptp_clock_unregister; // needs to call ksz_mdio_unregister()

