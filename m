Return-Path: <netdev+bounces-86786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7C48A042F
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 01:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE6E1F242AD
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 23:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37453EA83;
	Wed, 10 Apr 2024 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWHvSbHV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ABE381B1
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712792746; cv=none; b=lLiHLStMbIEgl8B+q2MRqg1B/ZKQFQBuNQ5UfdDM6pukTXTCyysYGXGoPeo40YgpCWwaN6vQa/qulFWKQftoJBnocG0a1e6h6I8UzIs2jsgm33S4rSa1Gtqf0iZ7PrXfKtCvqQw8vdKBJomy7S63brF5DT3pU7QBVG0P6LeqUMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712792746; c=relaxed/simple;
	bh=xlHHpyel625hv0e8fs6eveC/+T7pEb0TwqE9qnoAarI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOQOs2VQ8UDM5fqDNXIRG2PPGF17KN5bZ0hdN4nU0ofz4WkvGaXeZu/29pwzZDQa/Wpd/XSIi2NAZfACwfcjm174X6m+QNyi5dDn53pVdjKVB4hs6W2Cpw3d0RcMUTt62UQQK85r27f1AshyI1irTYGiidnCl/+Kcy20yp/muP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWHvSbHV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-346b94fa7ecso101242f8f.3
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 16:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712792743; x=1713397543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aV++u6adkTTcTKvgjjAL6SJv3v9G8Es9CBpCVV0vhxw=;
        b=DWHvSbHV4PIii4zcOpHdwfq6fvem1kFE22yJ+Y4fCa8Y+qG16n/LgCSitLsgN1hg0q
         K0fTlt8OOcJl449h9lAtTzxO3AbT0lmSGhCENxFUCPBOXlWp1zPdeNy5IeEHqtqBqIrf
         dpP7euUUs27g+ClgS+a5KxxFoPgW+ICwvD0vI8Y10PO1St5XjooNRw1HF+Qzd/PmUZAD
         pwQc9Xc6QBs7NCsEW2ioMkWfKYATgQmJD9vnlflAPSMuACXKJR9CemPUALXHH2z8IB3q
         zF8mUZpuH8pXl9mlK81WmnbNAKXl9Ob2YJg9g6jjuGSMjqaTKJ591891V+K8rKdZ9tNB
         a4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712792743; x=1713397543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV++u6adkTTcTKvgjjAL6SJv3v9G8Es9CBpCVV0vhxw=;
        b=vaRkSJnLxsiyayt0A4M8kzXIpw0ww7k4OJJcYoD5q3H2naVHvUe3s42TdwJ1pbsBB0
         4M3c8yTt9nWvUoYcaf29P+T7S89lP04Wo/BdZ4PiVE0DR+9Xt3y5N/1ySDg4Ctf4wmVe
         tm/7lNCkWowu/wlp9DgA0LnBCU6K5iwKaPDl/Wwx0y7FiFSHPvY7K0FeUpoF+8aw6eS3
         3jBYXYv/zUtv1wVZ9jAfRYYj4bBe/Fb1Fco1QAbymRq027E2dcBGMXFYcFjjU4kVRSMg
         qOhhzhfB50c/S1mNOG0nKK7WtngOj3Jz1PYpE9IOaBmxqJ5pu52l25O97CLzmHHPNhXt
         M5/A==
X-Forwarded-Encrypted: i=1; AJvYcCWtK8Lxhv/vNUYvLQApCbnEmPfJbxkP4QQI4fNmeX7aezNH5oxwTpio3j6S7Hn6owz8JzBKK26kiuWbeVWaIjTZD+jBxEWQ
X-Gm-Message-State: AOJu0YxpaAmBazuY9O8mTYF0fb6Iyxc6N81v97cj9ij27tNHw9JOYsdW
	jEikMYR1CSvkRCw100TcyBaXdw/Wnea3qjXU5fL49ZVIJKPsrf5cPl8nwJj3
X-Google-Smtp-Source: AGHT+IFdVs/oCVJ6E8JOvZSBGQEc46ZbvuEmfc5bSQciik7OmR7VKxqncVIfueAuaVp6Cs+iDneyCg==
X-Received: by 2002:a05:6000:188a:b0:344:4bcc:ed28 with SMTP id a10-20020a056000188a00b003444bcced28mr4590724wri.32.1712792743028;
        Wed, 10 Apr 2024 16:45:43 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d6304000000b003437ad152f9sm364897wru.105.2024.04.10.16.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 16:45:42 -0700 (PDT)
Date: Thu, 11 Apr 2024 02:45:39 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Gregory Clement <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 7/8] dsa: mv88e6xxx: Create port/netdev LEDs
Message-ID: <20240410234539.gzqt223s4kgpjwko@skbuf>
References: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
 <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-7-eb97665e7f96@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-7-eb97665e7f96@lunn.ch>

Nitpick: title: net: dsa: mv88e6xxx

On Sat, Apr 06, 2024 at 03:13:34PM -0500, Andrew Lunn wrote:
> Make use of the helpers to add LEDs to the user ports when the port is
> setup. Also remove the LEDs when the port is destroyed to avoid any
> race conditions with users of /sys/class/leds and LED triggers after
> the driver has been removed.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/dsa/mv88e6xxx/Kconfig |   1 +
>  drivers/net/dsa/mv88e6xxx/chip.c  | 119 +++++++++++++++++++++++++++++++++++++-
>  drivers/net/dsa/mv88e6xxx/chip.h  |  13 +++++
>  3 files changed, 132 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/Kconfig b/drivers/net/dsa/mv88e6xxx/Kconfig
> index e3181d5471df..ded5c6b9132b 100644
> --- a/drivers/net/dsa/mv88e6xxx/Kconfig
> +++ b/drivers/net/dsa/mv88e6xxx/Kconfig
> @@ -5,6 +5,7 @@ config NET_DSA_MV88E6XXX
>  	select IRQ_DOMAIN
>  	select NET_DSA_TAG_EDSA
>  	select NET_DSA_TAG_DSA
> +	select NETDEV_LEDS

Do we want mv88e6xxx to select NETDEV_LEDS, or also to be able to build
it without LED control?

If we want to select, do we always want drivers to select NETDEV_LEDS?
Maybe hide the help text from the NETDEV_LEDS option, make it invisible
to the user?

>  	help
>  	  This driver adds support for most of the Marvell 88E6xxx models of
>  	  Ethernet switch chips, except 88E6060.
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 3d7e4aa9293a..4e4031f11088 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -31,6 +31,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/phylink.h>
>  #include <net/dsa.h>
> +#include <net/netdev_leds.h>
>  
>  #include "chip.h"
>  #include "devlink.h"
> @@ -3129,6 +3130,105 @@ static int mv88e6xxx_switch_reset(struct mv88e6xxx_chip *chip)
>  	return mv88e6xxx_software_reset(chip);
>  }
>  
> +static int mv88e6xxx_led_brightness_set(struct net_device *ndev,
> +					u8 led, enum led_brightness value)
> +{
> +	struct dsa_port *dp = dsa_port_from_netdev(ndev);
> +	struct mv88e6xxx_chip *chip = dp->ds->priv;
> +	int port = dp->index;
> +	int err;
> +
> +	if (chip->info->ops->led_brightness_set) {
> +		mv88e6xxx_reg_lock(chip);
> +		err = chip->info->ops->led_brightness_set(chip, port, led,
> +							  value);
> +		mv88e6xxx_reg_unlock(chip);
> +		return err;
> +	}
> +	return -EOPNOTSUPP;

The opposite looks more natural, if (!ops) return -EOPNOTSUPP, followed
by the normal code with 1 level of indentation less.

Comment applicable to all netdev_leds_ops below.

> +}
> +
>  static int mv88e6xxx_set_port_mode(struct mv88e6xxx_chip *chip, int port,
>  				   enum mv88e6xxx_frame_mode frame,
>  				   enum mv88e6xxx_egress_mode egress, u16 etype)
> @@ -4006,7 +4106,9 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
>  
>  static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
>  {
> +	struct dsa_port *dp = dsa_to_port(ds, port);
>  	struct mv88e6xxx_chip *chip = ds->priv;
> +	struct mv88e6xxx_port *p;
>  	int err;
>  
>  	if (chip->info->ops->pcs_ops &&
> @@ -4016,13 +4118,28 @@ static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
>  			return err;
>  	}
>  
> -	return mv88e6xxx_setup_devlink_regions_port(ds, port);

Unfortunate, but there is an existing bug here. chip->info->ops->pcs_ops->pcs_init()
allocates memory. If mv88e6xxx_setup_devlink_regions_port() fails here,
that's memory we're not freeing, by not calling chip->info->ops->pcs_ops->pcs_teardown().

> +	err  = mv88e6xxx_setup_devlink_regions_port(ds, port);
> +	if (err)
> +		return err;
> +
> +	if (dp->dn && dsa_is_user_port(ds, port)) {
> +		p = &chip->ports[port];
> +		INIT_LIST_HEAD(&p->leds);
> +		err = netdev_leds_setup(dp->user, dp->dn, &p->leds,
> +					&mv88e6xxx_netdev_leds_ops, 2);

Does anything bad happen with netdev_leds_setup() on platform_data?
OF APIs are pretty NULL-tolerant.

> +		if (err)
> +			mv88e6xxx_teardown_devlink_regions_port(ds, port);
> +	}
> +	return err;
>  }
>  
>  static void mv88e6xxx_port_teardown(struct dsa_switch *ds, int port)
>  {
>  	struct mv88e6xxx_chip *chip = ds->priv;
>  
> +	if (dsa_is_user_port(ds, port))
> +		netdev_leds_teardown(&chip->ports[port].leds);

On platform_data, we are calling netdev_leds_teardown() when we never
called netdev_leds_setup() and never initialized the port leds list.

> +
>  	mv88e6xxx_teardown_devlink_regions_port(ds, port);
>  
>  	if (chip->info->ops->pcs_ops &&
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
> index 64f8bde68ccf..d15bb5810831 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.h
> +++ b/drivers/net/dsa/mv88e6xxx/chip.h
> @@ -291,6 +291,9 @@ struct mv88e6xxx_port {
>  
>  	/* MacAuth Bypass control flag */
>  	bool mab;
> +
> +	/* LEDs associated to the port */
> +	struct list_head leds;
>  };
>  
>  enum mv88e6xxx_region_id {
> @@ -432,6 +435,7 @@ struct mv88e6xxx_chip {
>  
>  	/* Bridge MST to SID mappings */
>  	struct list_head msts;
> +

Stray change.

>  };
>  
>  struct mv88e6xxx_bus_ops {
> @@ -668,6 +672,15 @@ struct mv88e6xxx_ops {
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

