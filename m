Return-Path: <netdev+bounces-83957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7363E89515B
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9314B27D73
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 11:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18614605C6;
	Tue,  2 Apr 2024 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TceTocz4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D1664CE9
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055842; cv=none; b=U4I5+lGE9ae1EFdQ7AUVMq1ETw22VumJU1UbRo260R7bC9U12Om39kN0cSuDCgEHZp+aoe3UA/E357+bWfgJTGipzqjBQUNJfFJAECkm4VU1d/qaV6+DkEJm5I9hCEJ8aoil08JhSu0Ym4zSGgHVkloKdka0MPb9S6GmkzDc4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055842; c=relaxed/simple;
	bh=lE6kl+kfprg6l+685lfC8nwP0KKvlBsCynRbW86bRao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA6bXdh4iw7fxAbx9Nxq+GihTKFhkTA4rcVkyiW3UMQvdGTcPzGmTShovx8z3F+339gndLYmJ+qQlD4La9NmLPT5akA+YSI5VmYdHFz30m2Vb0q6Lr5rSEPtD4nKVXL9aHB6IneRlrwTrGxj2DEVU7hLWX1yLgy7Zjup+vIQOnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TceTocz4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a46ba938de0so660703766b.3
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 04:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712055838; x=1712660638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=92plEj3upt88EqVeQpnLDQO6nBTMFEX1DSkUDbyVjFk=;
        b=TceTocz4ElrBOIl2LXswa7tdyByHJDV/6XxVR+yLsrDU7d+NLSh7vvpi+D4dRWWxMD
         0AAnrSEpdcdiQpkOqeuy/c395mRtU8n6NPuC3e/xHjKm00EeYNwDGIV5exTHPrzKEqsr
         ccxIgPTaR7/8xn4SY8tk7Fs8xHJ3lGQClmLhNRv8OfWDQExtyPeN6WwN+vlSNZpTEDMe
         FCjXf3a1+KhrFAkQAXstYaTUozJOaHdEi3H043KUED8rnpukVVWkZEPVdVLzJvOsTPJc
         PadIi03Ly9pr58BaQfjjIdI0v9dNzbnnHKlZCUauQ56KBaOk+W7GE9HLJ2+0ctcskrTM
         DENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055838; x=1712660638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92plEj3upt88EqVeQpnLDQO6nBTMFEX1DSkUDbyVjFk=;
        b=hGeJ6dhmhw26H9yx13auyegoHQIVue9ibuW7L0hoTaypa+UuaPUOfgYtzAUqvL52WJ
         z2TGrr1Vmh9lleJwqvwmHniWwfljfjvA7wsUbcZGJ4zJpZU0ZnjKo/xOLD8Q6MG+w/ba
         jkKMNbDgy2H5JKTPcTgqlrpQFnQ/7Owjd09bXxqZB+hfT0JDpen6W+lLiTGWR42WRL2f
         JEII3CmVXzk2a/IsdM0VKwNw1xPJDhcGw8BcBi3b8Sr5qvcDCfHfdazXK4i9OumsU1X0
         FK/2ISaORphSb1oiaxV7jIuOsOawn9aWB/4MCrbSqCtJI/y3TwsvrNlc8CgTVmOFP9Lx
         OfIg==
X-Forwarded-Encrypted: i=1; AJvYcCX3DtUCfXPirK6k3UlrsxIWpTY/Pt2ceeoyt7o7EuNn4ghzvtFxZM3NpWVMzpyDLAWVGdLkm+tnOG48/sViR3gTGgQJyvlk
X-Gm-Message-State: AOJu0Yw/UE7ZHVbpKu6iJXhVEiYoV+adTpSfHiuLZ0Q6jzqFesudfd8+
	Zq9KBuSnGbSRaHV+EjFi1XoElqmV5I1zQTjjrIZyDpKvrnak7mWK
X-Google-Smtp-Source: AGHT+IHk35z6f4EmAV9t/9ST+mwzxvuOxLpM1WR8oVTMw+G4UuZV9S3xqGRtlUb2H7/GRrYNpJEmSA==
X-Received: by 2002:a17:906:e83:b0:a46:e8dc:5d51 with SMTP id p3-20020a1709060e8300b00a46e8dc5d51mr7665786ejf.25.1712055838146;
        Tue, 02 Apr 2024 04:03:58 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id e5-20020a1709061e8500b00a4e07760215sm6377441ejj.69.2024.04.02.04.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 04:03:57 -0700 (PDT)
Date: Tue, 2 Apr 2024 14:03:55 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Gregory Clement <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/7] dsa: mv88e6xxx: Create port/netdev LEDs
Message-ID: <20240402110355.oruwspikc2u56qzh@skbuf>
References: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
 <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
 <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-6-221b3fa55f78@lunn.ch>
 <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-6-221b3fa55f78@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-6-221b3fa55f78@lunn.ch>
 <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-6-221b3fa55f78@lunn.ch>

On Mon, Apr 01, 2024 at 08:35:51AM -0500, Andrew Lunn wrote:
> @@ -4006,6 +4106,7 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
>  
>  static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
>  {
> +	struct dsa_port *dp = dsa_to_port(ds, port);
>  	struct mv88e6xxx_chip *chip = ds->priv;
>  	int err;
>  
> @@ -4016,13 +4117,26 @@ static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
>  			return err;
>  	}
>  
> -	return mv88e6xxx_setup_devlink_regions_port(ds, port);
> +	err  = mv88e6xxx_setup_devlink_regions_port(ds, port);
> +	if (err)
> +		return err;
> +
> +	if (dp->dn) {
> +		err = netdev_leds_setup(dp->user, dp->dn, &chip->leds,
> +					&mv88e6xxx_netdev_leds_ops, 2);

This (dereferencing dp->user regardless of dp->type) is a dangerous
thing to do. Let alone the fact that dp->user is NULL for DSA ports. It
is actually in a union with struct net_device *conduit, for CPU ports.
So you're also setting up LEDs for the conduit interface here...

Please make it conditional on dsa_port_is_user(), and same for teardown.

> +		if (err)
> +			mv88e6xxx_teardown_devlink_regions_port(ds, port);
> +	}
> +	return err;
>  }
>  
>  static void mv88e6xxx_port_teardown(struct dsa_switch *ds, int port)
>  {
> +	struct dsa_port *dp = dsa_to_port(ds, port);
>  	struct mv88e6xxx_chip *chip = ds->priv;
>  
> +	netdev_leds_teardown(&chip->leds, dp->user);
> +
>  	mv88e6xxx_teardown_devlink_regions_port(ds, port);
>  
>  	if (chip->info->ops->pcs_ops &&
> @@ -6397,6 +6511,7 @@ static struct mv88e6xxx_chip *mv88e6xxx_alloc_chip(struct device *dev)
>  	INIT_LIST_HEAD(&chip->mdios);
>  	idr_init(&chip->policies);
>  	INIT_LIST_HEAD(&chip->msts);
> +	INIT_LIST_HEAD(&chip->leds);
>  
>  	return chip;
>  }
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
> index 64f8bde68ccf..b70e74203b31 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.h
> +++ b/drivers/net/dsa/mv88e6xxx/chip.h
> @@ -432,6 +432,9 @@ struct mv88e6xxx_chip {
>  
>  	/* Bridge MST to SID mappings */
>  	struct list_head msts;
> +
> +	/* LEDs associated to the ports */
> +	struct list_head leds;
>  };
>  
>  struct mv88e6xxx_bus_ops {
> @@ -668,6 +671,15 @@ struct mv88e6xxx_ops {
>  	int (*led_blink_set)(struct mv88e6xxx_chip *chip, int port, u8 led,
>  			     unsigned long *delay_on,
>  			     unsigned long *delay_off);
> +	int (*led_hw_control_is_supported)(struct mv88e6xxx_chip *chip,
> +					   int port, u8 led,
> +					   unsigned long flags);
> +	int (*led_hw_control_set)(struct mv88e6xxx_chip *chip,
> +				  int port, u8 led,
> +				  unsigned long flags);
> +	int (*led_hw_control_get)(struct mv88e6xxx_chip *chip,
> +				  int port, u8 led,
> +				  unsigned long *flags);
>  };
>  
>  struct mv88e6xxx_irq_ops {
> 
> -- 
> 2.43.0
> 


