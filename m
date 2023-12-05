Return-Path: <netdev+bounces-53906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FEF8052E9
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A7E281727
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85265697A1;
	Tue,  5 Dec 2023 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkOdnC2j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591781AB;
	Tue,  5 Dec 2023 03:31:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bfa7f7093so2354334e87.0;
        Tue, 05 Dec 2023 03:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701775904; x=1702380704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iWABwC93ZRSAHZ+Njf9xIdiKvJp/CP14/ZzB27UiO+I=;
        b=dkOdnC2jVcPaiBlOkIvqbrTfzUQ3I7jxR0Kwld7MjSIUuPzjIhXwdTkw1F6sqRfO4k
         Sj91baZc4COMmXwLhS8a8Yp5CVC1rmrK609Z/i/U056UjJ8VpGQAvx4a2+p54cL6eqjM
         M6iVbUIBo+BTlJ+7Ah6Ac2fbe4ENTLQm8hTy6uCFtG8vrOPz5kk6JrLPtbvzyCSg17qY
         B9aDNaZC6jpTSdmuL2BzlqZsEhP6ktmLaGQqTAsjaZ8NACo0f0ntjqqRT21COJ4c9pt1
         U5wA+DQn9RBsTzucjQioQPJmQM95C4+r5QV/9D13823kHWgPRWOsamk5hWp5RHdj73BO
         j42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701775904; x=1702380704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWABwC93ZRSAHZ+Njf9xIdiKvJp/CP14/ZzB27UiO+I=;
        b=hGxGdsJaL7UoCmrD9UVX0DZt3SFivLr6bRvKNYt+Gq2B/ffTN3oRKttPidxrJ4x3X5
         WSqRibG/RVB8AlIiVH7+Pl4jbx6MAvqR386hFoUCWdJvoF1aD4t4T+b9X28kgEbpg76B
         sOKw3h7jYGsJHtB124oiVEJUQnqJTEvpRk+/f9T8KQGdIcLl7Ca8XkdhjI7GvnN2CphV
         GdKqBJGxSd35BjJfV/3trdNngs1f7ihBJKCdFO+gF6y1sRHR6WPRIek6LnZvs6ho237U
         IprrjfqNNsQvRFC9V+Xxt/ztnPY99zeMmg7tT2TU71nMs0G1P9dZGt80xW0rNkWHrf6H
         MUvg==
X-Gm-Message-State: AOJu0YwU8gpUnTzZEpZkf4N1IU/TM44xJpbHvPw2dcJFEtr0bY8API90
	XHuF0M/9CxJlIVEpAbo48PY=
X-Google-Smtp-Source: AGHT+IFOyPrsnNLbi6atUEGuAJC2I0o2XaEEchq0I+1cdYruq2/3i2EBhY8YCpuSc2tnpJmsGAzuyg==
X-Received: by 2002:ac2:5490:0:b0:50b:f2e0:4997 with SMTP id t16-20020ac25490000000b0050bf2e04997mr1735238lfk.103.1701775904378;
        Tue, 05 Dec 2023 03:31:44 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id bi38-20020a0565120ea600b0050bfd88075asm395757lfb.287.2023.12.05.03.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:31:43 -0800 (PST)
Date: Tue, 5 Dec 2023 14:31:41 +0300
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
Message-ID: <rgp33mm4spbpm5tmgxurkhy4is3lz3z62rz64rni2pygteyrit@zwflw2ejdkn7>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <ZW8ASzkC9IFFlxkV@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW8ASzkC9IFFlxkV@shell.armlinux.org.uk>

On Tue, Dec 05, 2023 at 10:49:47AM +0000, Russell King (Oracle) wrote:
> On Tue, Dec 05, 2023 at 01:35:27PM +0300, Serge Semin wrote:
> > If the DW XPCS MDIO devices are either left unmasked for being auto-probed
> > or explicitly registered in the MDIO subsystem by means of the
> > mdiobus_register_board_info() method there is no point in creating the
> > dummy MDIO device instance in order to get the DW XPCS handler since the
> > MDIO core subsystem will create the device during the MDIO bus
> > registration procedure.
> 

> Please reword this overly long sentence.

Ok.

> 
> If they're left unmasked, what prevents them being created as PHY
> devices?

Not sure I fully get what you meant. If they are left unmasked the
MDIO-device descriptor will be created by the MDIO subsystem anyway.
What the point in creating another one?

> 
> > @@ -1437,19 +1435,21 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
> >  	struct mdio_device *mdiodev;
> >  	struct dw_xpcs *xpcs;
> >  
> > -	mdiodev = mdio_device_create(bus, addr);
> > -	if (IS_ERR(mdiodev))
> > -		return ERR_CAST(mdiodev);
> > +	if (addr >= PHY_MAX_ADDR)
> > +		return ERR_PTR(-EINVAL);
> >  
> > -	xpcs = xpcs_create(mdiodev, interface);
> > +	if (mdiobus_is_registered_device(bus, addr)) {
> > +		mdiodev = bus->mdio_map[addr];
> > +		mdio_device_get(mdiodev);
> 

> No, this makes no sense now. This function is called
> xpcs_create_mdiodev() - note the "create_mdiodev" part. If it's getting
> the mdiodev from what is already there then it isn't creating it, so
> it's no longer doing what it says in its function name. If you want to
> add this functionality, create a new function to do it.

AFAICS the method semantics is a bit different. It's responsibility is to
create the DW XPCS descriptor. MDIO-device is utilized internally by
the DW XPCS driver. The function callers don't access the created MDIO
device directly (at least since some recent commit). So AFAIU "create"
means creating the XPCS descriptor irrespective from the internal
communication layer. So IMO the suffix is a bit misleading. I'll
change it in one of the next commit anyway. Should I just merge that
patch back in this one?

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

