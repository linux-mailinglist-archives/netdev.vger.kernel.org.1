Return-Path: <netdev+bounces-86783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B3F8A040D
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 01:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E1A283801
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 23:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D1938F84;
	Wed, 10 Apr 2024 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGqugmpE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233251D558
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791947; cv=none; b=fk7qZfcBWyDoXSCnGQz4uHmL0u2PkVQGENY/S2tOsdv+Tm1FSkVXkNzISReU81PY9zARgbbM8ejiz8GZJlIxYad2/fZtDjmZU5hFHrNYMumFMX8w3PGjPmt4OF2CAGxMue6VSueKR3ahQuRB7QVPHUdndCe2xpAmBMM1Qr60EMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791947; c=relaxed/simple;
	bh=Fc2hLqX63xlbcdaJXOigdJMMNQstlz/z4zSiMSVrR0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM6hjE8MbivHgKqN4Cwe46H76Aod7ZmPIDy8h3RlMwgrJrfQEiz7/T14t4VCl7ayLEkiTK3RvXMD8YTFDOLptHoRwA05fSB+XZ7lG6ApqUh7X4CtmWDmUBee5d4E2y+zk3lvrSUQLKJIvMuV7oRXnTTGTtx4TY1lI2Waej3CLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGqugmpE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343d7ff2350so3982710f8f.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 16:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712791944; x=1713396744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nmv4cD/w/9Q5B/IjxZ5dwRtRn51HPLqgDxJVdTLPneA=;
        b=IGqugmpEiXoMdcS76rwPRRrznjWTAiJtHkbVEgGHGjsKmOAl2oWn0x1xmFHhO+rYfY
         WbaqShDCf/sPj5MOWjBqyFHuIVKCRa1rG1NxOH3zxoh68ZfUiK8KS8sml0mCWLJ244ee
         lT+xwnD7eUhHJORK3/U4eRXoj8woFCyf8nwR156ArixM5UXeWZMAP/UeYk2gf3vbJq+i
         jRgWU/qbFAB8mld9CRLZxbbSQVjTN02Y5uK/NfZl1CV+yQ7NYugWLi2B+V71q4ec6BZy
         1eFHhbutuxwORjp3BW0JfQfvF4CQ7VF3dQZwrCu/qefRXUyQeddlfsxJYfLOsuy069gt
         pyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791944; x=1713396744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nmv4cD/w/9Q5B/IjxZ5dwRtRn51HPLqgDxJVdTLPneA=;
        b=p/vA9pZ3O99SM7EoNOjajXraUKaz+PYeC4IM1JBNWiFe89jtmPKdrOA+Ra/Izeoh+M
         Pl+7UAWzRoPxCizQndv0J7apuz9XyEWzLrXhwsn6uxmvBwyMb8i9b4T57bmdNr4VVDas
         kUiM1pQ3KjbVFkxTnxBoSBMxM3vc5tqKapTEwwxxnzE6FjcnG4EfOH9LdawrEzM8bW3p
         Rv2HoCku5pjsqEzALEtKQaCDumae8FUr9FI3QlkDOZaAkhzag/URuC86yoD0c0HjsLl6
         zaIwArsk5hiInGS0+jAM01l4+j0cJSNPXAgXnyiyT9oly1uzRbXwBIuosz1Xx5X1XOvy
         gbNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi8rg2/Ur5t4A5bHid0+FlZjDo+XZ2ADEi3/is88tZW1cmlY9akUQ5QBC9KiK0HA/LpDvbgnp6DMgtIAJVSQyuEr+j/nLT
X-Gm-Message-State: AOJu0YzhFkjHZj1hitNb897d/w07E/6ooq4iiu86osVH/m2V8EWSb8aW
	u1mGp58XOEL6JGcH+iGUGilVOIE8FJxjqnTF/FNg7U3pvdgHGx34
X-Google-Smtp-Source: AGHT+IFybtOO2EQHlZTOCXt0BXDVd+iBXQ00knscVZ18qYaV0Q9OPsUKYcVY/NKNKp7LVnyeyweVZQ==
X-Received: by 2002:adf:f703:0:b0:343:742c:6a57 with SMTP id r3-20020adff703000000b00343742c6a57mr3090398wrp.35.1712791944290;
        Wed, 10 Apr 2024 16:32:24 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b0041563096e15sm3771067wmb.5.2024.04.10.16.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 16:32:23 -0700 (PDT)
Date: Thu, 11 Apr 2024 02:32:21 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Gregory Clement <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/8] net: Add helpers for netdev LEDs
Message-ID: <20240410233221.ntpxm7hfjiwod32u@skbuf>
References: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
 <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-4-eb97665e7f96@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-4-eb97665e7f96@lunn.ch>

On Sat, Apr 06, 2024 at 03:13:31PM -0500, Andrew Lunn wrote:
> +/**
> + * netdev_leds_setup - Parse DT node and create LEDs for netdev
> + *
> + * @ndev: struct netdev for the MAC
> + * @np: ethernet-node in device tree
> + * @list: list to add LEDs to
> + * @ops: structure of ops to manipulate the LED.
> + * @max_leds: maximum number of LEDs support by netdev.
> + *
> + * Parse the device tree node, as described in
> + * ethernet-controller.yaml, and find any LEDs. For each LED found,
> + * ensure the reg value is less than max_leds, create an LED and
> + * register it with the LED subsystem. The LED will be added to the
> + * list, which should be unique to the netdev. The ops structure
> + * contains the callbacks needed to control the LEDs.
> + *
> + * Return 0 in success, otherwise an negative error code.
> + */
> +int netdev_leds_setup(struct net_device *ndev, struct device_node *np,
> +		      struct list_head *list, struct netdev_leds_ops *ops,
> +		      int max_leds)
> +{
> +	struct device_node *leds, *led;
> +	int err;
> +
> +	leds = of_get_child_by_name(np, "leds");
> +	if (!leds)
> +		return 0;
> +
> +	for_each_available_child_of_node(leds, led) {
> +		err = netdev_led_setup(ndev, led, list, ops, max_leds);
> +		if (err) {
> +			of_node_put(leds);
> +			of_node_put(led);
> +			return err;
> +		}
> +	}
> +	of_node_put(leds);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(netdev_leds_setup);
> +
> +/**
> + * netdev_leds_teardown - Remove LEDs for a netdev
> + *
> + * @list: list to add LEDs to teardown
> + *
> + * Unregister all LEDs from the given list of LEDS, freeing up any
> + * allocated memory.
> + */
> +void netdev_leds_teardown(struct list_head *list)
> +{
> +	struct netdev_led *netdev_led;
> +	struct led_classdev *cdev;
> +
> +	list_for_each_entry(netdev_led, list, led_list) {

list_for_each_entry_safe(), since there is a kfree() inside.

> +		cdev = &netdev_led->led_cdev;
> +		led_classdev_unregister(cdev);
> +		kfree(netdev_led);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(netdev_leds_teardown);
> 
> -- 
> 2.43.0
> 

