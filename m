Return-Path: <netdev+bounces-56448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3EA80EEC0
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C74B20D2F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817D77318E;
	Tue, 12 Dec 2023 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8xVnYgM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE148F
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 06:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702391323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sic7JgTbCqXENzuaXidvmcJDkf8Pxtwv2IpV4/8llXA=;
	b=T8xVnYgMARx5PtC8U6HMT7YmO3iXRDCEOn8lB/SQ7w/p3lCWEfxxizd2nm8MdBLPnDjd2G
	3zeDAz2go1KJIFUMacQrZUXBBqOFjpof1zLJ8yjUVfVTEvf7k2SgSCxHprOrmwZtvh12Go
	6a2yMhker4NRcWyYgAoD+uvRI7SMvaM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-lSieMQegOQ2M4qHTJ-UgTg-1; Tue, 12 Dec 2023 09:28:39 -0500
X-MC-Unique: lSieMQegOQ2M4qHTJ-UgTg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-67ab0fa577fso78794016d6.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 06:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391319; x=1702996119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sic7JgTbCqXENzuaXidvmcJDkf8Pxtwv2IpV4/8llXA=;
        b=RygMUdgfQO6Ptk7ILpU2w2xakx99Nt3eJvo34VY5dnjK4GJeb5PXYN7dmTYH4N4Xg0
         WTB6ymsZpnML6hAbG+wxNN8URNhobe7ytk/jakdtp++FwR4mKNRBMV7FOaAT5cqRFP+g
         ENpUtVeaT+t3kxC36HeozH9oAvSU3pKpqzqnQQs5DsJeaLSRVyWdxaYkExWlO9AdYADk
         ljDPUkC1KVjvNJyiKIDrcbi0qC+/elLghNfgAOerPZWy7tVFiX5qqYAcJlZlIWWdK0EY
         WgXVvGM+X43NDbwvorOYl7toL5sNUgmj930dPNwUEGrc8o1CX382ho+ymhpwILOdWiU2
         LhGw==
X-Gm-Message-State: AOJu0YxTEdLfC+/20mT9TyYuzpHyX7Ip5LMa0WuVSmfRKNSJeKkKhNhI
	o7vmJRmeSuuteUOVN25uZDUTHeSzjqLzI2D3Zt773ZVjA9u8R488PQIZ1sPjRUqRgCWkUbMjVKt
	cqfBPI7DSwKUkhEVX
X-Received: by 2002:a05:6214:c25:b0:67a:a721:830b with SMTP id a5-20020a0562140c2500b0067aa721830bmr7837487qvd.101.1702391318792;
        Tue, 12 Dec 2023 06:28:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHOEPNqyZdk9QNuyLbwX1ImY1txSg6BBuVoLWOx94ej3ijMZxTQS0qC/sSDGxEP2PvMWaFUg==
X-Received: by 2002:a05:6214:c25:b0:67a:a721:830b with SMTP id a5-20020a0562140c2500b0067aa721830bmr7837469qvd.101.1702391318451;
        Tue, 12 Dec 2023 06:28:38 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id jr12-20020a0562142a8c00b0067a14d996e9sm4231045qvb.1.2023.12.12.06.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:28:37 -0800 (PST)
Date: Tue, 12 Dec 2023 08:28:35 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: Handle disabled MDIO busses from
 devicetree
Message-ID: <d7vwj7p55ig7fjste3ctqwpccuoowh2ryqnmcxq3qqrn6exzjd@z5mbsitxbupk>
References: <20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com>
 <ggbqvhdhgl6wmuewqtwtgud7ubx2ypmnb3p6p6w7cy37mnnyxn@2eqd63s2t5ii>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ggbqvhdhgl6wmuewqtwtgud7ubx2ypmnb3p6p6w7cy37mnnyxn@2eqd63s2t5ii>

On Tue, Dec 12, 2023 at 01:59:25PM +0300, Serge Semin wrote:
> On Mon, Dec 11, 2023 at 03:31:17PM -0600, Andrew Halaney wrote:
> > Many hardware configurations have the MDIO bus disabled, and are instead
> > using some other MDIO bus to talk to the MAC's phy.
> > 
> > of_mdiobus_register() returns -ENODEV in this case. Let's handle it
> > gracefully instead of failing to probe the MAC.
> > 
> > Fixes: 47dd7a540b8a (net: add support for STMicroelectronics Ethernet controllers.")
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> > index fa9e7e7040b9..a39be15d41a8 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> > @@ -591,7 +591,13 @@ int stmmac_mdio_register(struct net_device *ndev)
> >  	new_bus->parent = priv->device;
> >  
> >  	err = of_mdiobus_register(new_bus, mdio_node);
> > -	if (err != 0) {
> > +	if (err) {
> > +		if (err == -ENODEV) {
> > +			/* The bus is disabled in the devicetree, that's ok */
> > +			mdiobus_free(new_bus);
> > +			return 0;
> > +		}
> > +
> >  		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
> >  		goto bus_register_fail;
> >  	}
> 
> This can be implemented a bit simpler, more maintainable and saving
> one indentations level:
> 
> 	err = of_mdiobus_register(new_bus, mdio_node);
> 	if (err == -ENODEV) {
> 		err = 0;
> 		dev_warn(dev, "MDIO bus is disabled\n");

Thanks for all your reviews, I agree this is cleaner!

I'm going to opt to use dev_info() here as this isn't something that's
wrong, just worth noting.

> 		goto bus_register_fail;
> 	} else if (err) {
>   		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
>   		goto bus_register_fail;
> 	}
> 
> -Serge(y)
> 
> > 
> > ---
> > base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
> > change-id: 20231211-b4-stmmac-handle-mdio-enodev-82168de68c6a
> > 
> > Best regards,
> > -- 
> > Andrew Halaney <ahalaney@redhat.com>
> > 
> 


