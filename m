Return-Path: <netdev+bounces-56994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121EA811841
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C992F1C21265
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8C3306C;
	Wed, 13 Dec 2023 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaM9v6xu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BC3F2;
	Wed, 13 Dec 2023 07:47:24 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2cc259392a6so42984621fa.2;
        Wed, 13 Dec 2023 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702482443; x=1703087243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EhvWEh807oUIcSem4VDgk6dTPM+cYeOF5hlufV89DoI=;
        b=DaM9v6xuPKDYm4Kyb/wttByJTbgU1JRNzLNpXJMk2sLR/aDSlzQ7M8YFBOlmcUGhUX
         amxFegOmdy1Pj++hPY6A/WeyIfNAoeSZhGZDo761/9PQcq66Sj7c5vpbTTyCqerF498O
         S/FmcG/TqizEWAieIaogjSwVjUfp3WhlYaZ2xLD0XqtfTP0Kc9JQAZMcUZz7XspERXSp
         kTyi4zWKOwZo6KZGfYJWj3R8VdzhY/5YHUhOBkCswmnN0THhh03v0lvQPY87zcQJvePo
         4IoA1KdMYf62Yp/NxI5cBxynwX+VS9EHcqTMuIgDnWCk8XcyM+eyPv3pwSlT7rwg7hU5
         dBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702482443; x=1703087243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhvWEh807oUIcSem4VDgk6dTPM+cYeOF5hlufV89DoI=;
        b=cBkZu+/N1ea8g57MnHh+Jt2bczeENCZo2iCLx1NMEVnuNd9bUZz37R06/ZUSnYucT3
         Ycm4Q5RFeWyseDygGiYcdNudyqraDljC9xQaSt8Vzo5pf4EXNpNDFHDe5BP3a/ns2Vl3
         OiV5Ff9lumnh9Q24p7wP+Z7jFUAJ4VPKyF+TTYbDjAL7DizJ4LCrUA//B4eI8RbSnytS
         G/uYo8x79cEtD7YHzeIs+oHSW4d4TaYC7xR6iL+85I1jiPdHF7Nnk7RwT+W5GUGMGn0o
         m9ThVR8D8gyy2VnthweL+cXByhvgqGHxGKSx/DGJutJSFyRutxG13/VwAE9YeBnTpYKh
         2Z2g==
X-Gm-Message-State: AOJu0YyXFDRYihL8ssoF8PLXRXYCevhqWexRbl7/XvOqABl4Isv8O/5p
	Xlr9dFBIi4fiIpyOUO1DK6M=
X-Google-Smtp-Source: AGHT+IHfEac18zoY0gBPJcbuOObR91TUzD3b56b0y+7kI2XbIcuwhPK2c/DDUaHKl+amw8uRZizW/A==
X-Received: by 2002:a2e:a103:0:b0:2cc:1dc8:4e96 with SMTP id s3-20020a2ea103000000b002cc1dc84e96mr4567741ljl.24.1702482442739;
        Wed, 13 Dec 2023 07:47:22 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e8048000000b002ca026f777fsm1867436ljg.48.2023.12.13.07.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:47:22 -0800 (PST)
Date: Wed, 13 Dec 2023 18:47:19 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/16] net: pcs: xpcs: Avoid creating dummy XPCS
 MDIO device
Message-ID: <eeyhdczfpgxwxbtljjc7tkjwi64avqkn2h7tehh56xq6pss3x3@7cun56p633o4>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <ZW8pxM3RvyHJTwqH@shell.armlinux.org.uk>
 <ZW85iBGAAf5RAsN1@shell.armlinux.org.uk>
 <kagwzutwnbpiyc7mmtq7ka3vhffw4fejuti5vepnla74rocruh@tryn6lxhwbjz>
 <ZXivRofyIpvmfOyR@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXivRofyIpvmfOyR@shell.armlinux.org.uk>

On Tue, Dec 12, 2023 at 07:06:46PM +0000, Russell King (Oracle) wrote:
> On Tue, Dec 12, 2023 at 06:26:16PM +0300, Serge Semin wrote:
> > I would have used in the first place if it was externally visible, but
> > it's defined as static. Do you suggest to make it global or ...
> 
> That would be one option - I didn't make it visible when I introduced it
> beacuse there were no users for it.
> 
> > > At some point, we should implement
> > > mdiobus_get_mdiodev() which also deals with the refcount.
> > 
> > ... create mdiobus_get_mdiodev() instead?
> > 
> > * Note in the commit message I mentioned that having a getter would be
> > * better than directly touching the mii_bus instance guts.
> 
> What I'm thinking is:
> 
> /**
>  * mdiobus_get_mdiodev() - get a mdiodev for the specified bus
>  * @bus: mii_bus to get mdio device from
>  * @addr: mdio address of mdio device
>  *
>  * Return the struct mdio_device attached to the MII bus @bus at MDIO
>  * address @addr. On success, the refcount on the device will be
>  * increased, which must be dropped using mdio_device_put(), and the
>  * mdio device returned. Otherwise, returns NULL.
>  */
> struct mdio_device *mdiobus_get_mdiodev(struct mii_bus *bus, int addr)
> {
> 	struct mdio_device *mdiodev;
> 
> 	mdiodev = mdiobus_find_device(bus, addr);
> 	if (mdiodev)
> 		get_device(&mdiodev->dev);
> 	return mdiodev;
> }
> EXPORT_SYMBOL(mdiobus_get_mdiodev);
> 
> should do it, and will hold a reference on the mdiodev structure (which
> won't be freed) and also on the mii_bus (since this device is a child
> of the bus device, the parent can't be released until the child has
> been, so struct mii_bus should at least stay around.)

Right. That's exactly what had in mind. Thanks for suggesting a
ready-to-apply solution. I'll add it to the series as a separate patch
if we decide to keep the proposed in this patch change.  See my
question in the next message:
https://lore.kernel.org/netdev/wnptneaxxe2tq2rf7ac6a72xtyluyggughvmtxbbg5qto64mpa@7gchl5e4qllu/

> 
> What would help the "the bus driver has been unbound" situation is if
> we took the mdio_lock on the bus, and then set the {read,write}{,_c45}
> functions to dummy stubs when the bus is being unregistered which then
> return e.g. -ENXIO. That will probably make unbinding/unloading all
> MDIO bus drivers safe from kernel oops, although phylib will spit out
> a non-useful backtrace if it tries an access. I don't think there's
> much which can be done about that - I did propose a patch to change
> that behaviour but apparently folk like having it!
> 
> It isn't perfect - it's racy, but then accessing mdio_map[] is
> inherently racy due to no locking with mdiobus_.*register_device().
> At least if we have everyone using a proper getter function rather
> than directly fiddling with bus->mdio_map[]. We only have one driver
> that accesses it directly at the moment (mscc_ptp):
> 
>                 dev = phydev->mdio.bus->mdio_map[vsc8531->ts_base_addr];
>                 phydev = container_of(dev, struct phy_device, mdio);
> 
>                 return phydev->priv;
> 
> and that should really be using mdiobus_get_phy().

Regarding the driver bind/unbind. I guess the maintainers just forget
about that problem. Do you think it's worth reminding them about it? 

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

