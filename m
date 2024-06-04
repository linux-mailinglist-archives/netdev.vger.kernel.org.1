Return-Path: <netdev+bounces-100487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F318A8FAE43
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695441F2380C
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF86142E8F;
	Tue,  4 Jun 2024 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMVZl9li"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BEF652;
	Tue,  4 Jun 2024 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491905; cv=none; b=ne2uZh5oT5uI9ZpkLcOVj/dtjzAULtPRukfYf66h5xakTr/M4+iXgAYYRmIVr1YTgMJo1d4u5RB+dvM3sxmrIriBrnnzHLd6hCT52eVxlz+KfGfS39TSypGKaWiAjKlU0C03p7QDN37Lf2IeXzSGiG/G9DCee7ALPc6Ti8l/OH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491905; c=relaxed/simple;
	bh=38i9QNxELC3fqCOoR3HD5LVNxT8PUyR/NiYbaTjAuQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUBrFlldbfqWHABxF4fjH7pDiLsnixZPMdzEFsXf+q3SzHCFLpfGC5M338F1KTGbIOht14Rm/w0iE92beukeB+RM2lTBUG0lR2Ak4S5AT2amJ99j8B5O6fUdQ+wE0MLmC2542e7yQVdFH2/cQF0Hyj48FGMAhZsPwjZI06ysySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMVZl9li; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso73524471fa.2;
        Tue, 04 Jun 2024 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717491902; x=1718096702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ra/05RG+I2wv8KgtJlT+4wpFEIAZV3HX8GrU0T/bo6E=;
        b=iMVZl9lio35X8hI84+Qvf+M0shU2VEjkkY//ywhZLacMBmqBJpeslXobEF0LF2B1FR
         f47UCE7Y2PKbNXV5gJwHIr1F2V3ddSfgLDupLddmhjpLNgPotjfyFp5K2F/JjBs843+z
         +bCo7TasHmY4Nbv3j9OJgREOOXozK+gM/VgjP1XYbP45mADDXJrfMzFzxevSv+HLEOZO
         3igM9bs4mR/yiXPy/bm/NG0ytebUNYcisaMBQFFKPL5yFiX7tyZMh/5p7hiuNCvmWRQv
         VT3Cr4wSHNo94LFKJcxWvwC1/LkuHppUSqr5HnMC9KRHbH6Xhmn6idArTAJYW8ABTFV8
         cPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717491902; x=1718096702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra/05RG+I2wv8KgtJlT+4wpFEIAZV3HX8GrU0T/bo6E=;
        b=aeEfOTpKMiC63GW6xAZyUv7+shR0UMUb/0PWLCKm0lWfYrf/hLimKLsTWXnEB934jU
         OJFv6koJXxCINlwwFZ4EMkkLRFi8fzez7A/oPXxltuunGJRhHJlbc4bRPzWKQX+9lTkK
         1Wp7QvL8KaWJLj0vr1S9iS2EI4NBnqUFPqny1meC8R/goHWbwKULg3V7jwkTAZFKYsC/
         VMsyhe5NxCrJWHc5riFUn955gXQgetRpa9ehRlYqt8jFuruj7kLlmEAOLBOcN6genUS2
         pvEnKl6ZyRz0b/Cfd6JKX+LVn0I46Z5d9H4+ejr4/qYayfFQWfDdE3tgadVkYEKVvDH1
         uPQw==
X-Forwarded-Encrypted: i=1; AJvYcCVx0JLna5ue4HzCwfH3L/ITLy6u34dcZYksSWdTv3McKLOeL01yBnJG24vxAQenI+5j2Se+vmr2RUAWiNKB017MQU+LLSY3f9dXapjSVQsP3gmu46TYgcyKXRS2x2F5RGeaD3/TYlr9d7782ZUY7xy5gZ4OEE/FwbGLy+I03k3Kww==
X-Gm-Message-State: AOJu0YzR7Hpr9DqJ6I/+FcVklbmIuBbPrZ8gAri20hdky0OTefsfTXkD
	JYmultd7S7YKvpPzSI/Aco5CG4IqdjCoFleyh8KLuooI/unhIJtg
X-Google-Smtp-Source: AGHT+IGxu8ZeKox/ETHOIGY9tQlCyxdSpOaMcwX3b4V+1NwYwnwZiIpRFm6IZBuIp5wxpDQGIUfJ0A==
X-Received: by 2002:a2e:3c0b:0:b0:2e5:3f56:2a0e with SMTP id 38308e7fff4ca-2ea9516108emr89381841fa.24.1717491901400;
        Tue, 04 Jun 2024 02:05:01 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91bb4e24sm14583141fa.55.2024.06.04.02.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:05:00 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:04:57 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, Vladimir Oltean <olteanv@gmail.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>, Abhishek Chauhan <quic_abchauha@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 10/10] net: stmmac: Add DW XPCS specified via
 "pcs-handle" support
Message-ID: <equlcrx6dgdtrmrlnxxhdunpghw46sjcyn5z6m6lszyiddbag4@eo6oeotzsxef>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-11-fancer.lancer@gmail.com>
 <2lpomvxhmh7bxqhkuexukztwzjfblulobepmnc4g4us7leldgp@o3a3zgnpua2a>
 <Zl2G+gK8qpBjGpb3@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl2G+gK8qpBjGpb3@shell.armlinux.org.uk>

On Mon, Jun 03, 2024 at 10:03:54AM +0100, Russell King (Oracle) wrote:
> On Mon, Jun 03, 2024 at 11:54:22AM +0300, Serge Semin wrote:
> > >  	if (priv->plat->pcs_init) {
> > >  		ret = priv->plat->pcs_init(priv);
> > 
> > > +	} else if (fwnode_property_present(devnode, "pcs-handle")) {
> > > +		pcsnode = fwnode_find_reference(devnode, "pcs-handle", 0);
> > > +		xpcs = xpcs_create_fwnode(pcsnode, mode);
> > > +		fwnode_handle_put(pcsnode);
> > > +		ret = PTR_ERR_OR_ZERO(xpcs);
> > 
> > Just figured, we might wish to be a bit more portable in the
> > "pcs-handle" property semantics implementation seeing there can be at
> > least three different PCS attached:
> > DW XPCS
> > Lynx PCS
> > Renesas RZ/N1 MII
> > 
> > Any suggestion of how to distinguish the passed handle? Perhaps
> > named-property, phandle argument, by the compatible string or the
> > node-name?
> 

> I can't think of a reasonable solution to this at the moment. One
> solution could be pushing this down into the platform code to deal
> with as an interim solution, via the new .pcs_init() method.
> 
> We could also do that with the current XPCS code, since we know that
> only Intel mGBE uses xpcs. This would probably allow us to get rid
> of the has_xpcs flag.

Basically you suggest to move the entire stmmac_pcs_setup() to the
platforms, don't you? The patch 9 of this series indeed could have
been converted to just moving the entire PCS-detection loop from
stmmac_pcs_setup() to the Intel-specific pcs_init.

But IMO some default/generic code would be still useful to preserve in
the stmmac_pcs_setup() method. When it comes to the fwnode-based
platform we at least could be falling back to the default DW XPCS
device registration if no plat_stmmacenet_data::pcs_init() callback
was specified and there was the "pcs-handle" property found,
especially seeing DW *MAC and DW XPCS are of the same vendor.

Based on that I can convert patch 9 of this series to introducing the
pcs_init() callback in the Intel mGBE driver, but preserve the
semantics of the rest of the series changes.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

