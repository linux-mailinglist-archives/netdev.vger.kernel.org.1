Return-Path: <netdev+bounces-54191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F2806382
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 01:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50C52821F8
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 00:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704EA190;
	Wed,  6 Dec 2023 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0NbMKas"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640149A
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 16:37:10 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a00cbb83c80so29770566b.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 16:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701823029; x=1702427829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fJZIZprl+e+dcCnDPtNYvYcwm8wNiuLAHUOvS32HTAg=;
        b=j0NbMKasfDyGMQeF2Yj+mrNJ/d29U4xn+BUqF2cWeqzLBO+PuQmS7Q15rhHWqhZfd+
         E1HUdUvLm1eBmQFAKv1/j0yE/lGr+2o5hnhtFSlKrXPpmlb7dZRp20zT5gfcOnGPCUst
         JmlDfnjwDa2Tdjcxse4P8kwzrhqMC/s7zZw3t3dujBE2H1UE//GZJtlA/v8DYydtox1+
         a+WZVIKeku6z+4AQ0srH5EAfspaoFeXJpGAjPQJyZLU4aVW7kOq9vwLXlCN6DrH6Fxpy
         F0uaLobIdd9a5Ji+qM6AHphzgqG/kcwrWpUFuTfv+frQ5ZMifs82kWJ75Mh216H4Ppkb
         5nRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701823029; x=1702427829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJZIZprl+e+dcCnDPtNYvYcwm8wNiuLAHUOvS32HTAg=;
        b=OSUip9EV8Jm4iH3fF5qNIWB0A7I5gy3UaWh2XAny66w+i7sQHHHGBQfefVMlxQgBO4
         2+PkWqCoE7Cg5KemQIWvnjAEIYNFJYjYA7TsyxwJDCoy9S3XDoL9Y8KPPb3Zh2x7ymzs
         Mpbp/563icJpOmUGVjsmjYi97XS57BEJh4/FhOufHBZXDi9gvpDK9pJlQrlUqQHgmnQq
         zd6y5CVLhAAFeCcGf46OURyTruvK+gzGGHOnNgDKQxGbecQLxcXIQtwQD9kt1jTRhbHq
         5lXFhd7881R0tovwnz9hNnc6eCBGb2FV9heFNHw8XnxPLG9ia8cKujKXC8XJl1MjmiUA
         zO6A==
X-Gm-Message-State: AOJu0Yyz+R4le9y0u/gyfH/DLtcgaDSkRtDKpBl5wE9yImhTxZVZokut
	J/pexHNkaC5n1f8V73mo0Mo=
X-Google-Smtp-Source: AGHT+IHwUVXsGsfmd5LZg+5Vhukzfd05oc0tCT6xldCQ71WJNdxQ3lq51GWFFjDmDKugmG3IxuCK7Q==
X-Received: by 2002:a17:906:aed4:b0:a19:a19a:eabb with SMTP id me20-20020a170906aed400b00a19a19aeabbmr46582ejb.116.1701823028663;
        Tue, 05 Dec 2023 16:37:08 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id h14-20020a1709063c0e00b00a1b7747e3c0sm3133180ejg.151.2023.12.05.16.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 16:37:08 -0800 (PST)
Date: Wed, 6 Dec 2023 02:37:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Danzberger <dd@embedd.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
Message-ID: <20231206003706.w3azftqx7nopn4go@skbuf>
References: <20231204154315.3906267-1-dd@embedd.com>
 <20231204174330.rjwxenuuxcimbzce@skbuf>
 <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>
 <20231205165540.jnmzuh4pb5xayode@skbuf>
 <e37d2c6678f33b490e8ab56cd1472429ca3dcc7a.camel@embedd.com>
 <20231205181735.csbtkcy3g256kwxl@skbuf>
 <52f88c8bf0897f1b97360fd4f94bdfe2e18f6cc0.camel@embedd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f88c8bf0897f1b97360fd4f94bdfe2e18f6cc0.camel@embedd.com>

On Tue, Dec 05, 2023 at 11:15:58PM +0100, Daniel Danzberger wrote:
> The lan* devices are then bridged together:
> 
> root@t2t-ngr421:~# brctl show
> bridge name	bridge id		STP enabled	interfaces
> br-lan		7fff.00139555cfd7	no		lan4
> 							lan2
> 							lan3
> 							lan1

Ok, so it forwards traffic because the ports are bridged, not that it
does that by default.

I see in your output that the internal PHY network interfaces are
registered and functional, and now I know how that works.

ksz_mdio_register() is indeed bypassed by the lack of OF as I suspected,
so it's not that function which is responsible for creating the MDIO bus.
But this piece of code from dsa_switch_setup() will kick in:

	if (!ds->user_mii_bus && ds->ops->phy_read) {
		ds->user_mii_bus = mdiobus_alloc();
		if (!ds->user_mii_bus) {
			err = -ENOMEM;
			goto teardown;
		}

		dsa_user_mii_bus_init(ds);

		dn = of_get_child_by_name(ds->dev->of_node, "mdio");

		err = of_mdiobus_register(ds->user_mii_bus, dn);
		of_node_put(dn);
		if (err < 0)
			goto free_user_mii_bus;
	}

aka DSA will set up a ds->user_mii_bus which calls into ds->ops->phy_read()
and ds->ops->phy_write() to access the internal PHYs. Although this bus
may be OF-based (if "dn" above is non-NULL), the of_mdiobus_register()
implementation simply calls mdiobus_register() if there is no OF node.

So, surprisingly, there is enough redundancy between DSA mechanisms that
platform_data kinda works.

