Return-Path: <netdev+bounces-149975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B439E85BF
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDB2163A6E
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 15:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B576149C4D;
	Sun,  8 Dec 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC495VKC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B017BA5;
	Sun,  8 Dec 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733670757; cv=none; b=rNnyq79SCs8Sicbk8F81NRsfmDJQskvtyI3bwxxiiRuqKl5NulPomwXAFvTgaa+u0TyXlcdq2kAhyiUTSzu2WdQdm4+HRhrXImjL0HlFQ3uDsZv+5WKlRr+XX/hGgeXboy66vGf7yfypHsF9K07PSkMJ2zEIezpkrmid92vT97I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733670757; c=relaxed/simple;
	bh=gcFaRUNaDsnyDl2My6iI9MElicnxRF2lXYW6WwymHZM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHFM5Gm4Zb6H9Sh67e76Omzic+He9z+dlxZf05cBZrcWZcnJFXPebVP4w0wiDvhC8PzhYEpzsRwnQqSdH6KWYxRczJ+ICE8LwMGQXdY1seR2Qm7S7JljpFotNnjXZ3UzLy6O0s5pXRVcnN9q+OcaAD0aJvBpxo/Iv3yaPA+KCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC495VKC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so26577765e9.1;
        Sun, 08 Dec 2024 07:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733670754; x=1734275554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6svUt4iTKLUfioqlz6n+zi3gVpzojRZdfSEAIIkW1Pw=;
        b=GC495VKCwJmh6MIN9OHbDdnjSki/5M4UwfluVOD8BxYkAm/xIRhKAS8TemVusRIBeX
         nOOq4Z+heRT9g/DZFoGDQQZ8Lylfts90nIY2o7ET0W/PUcT8GaEiCwSKkkmvQQwQy/0a
         Iq0/6HPa2EC86ujbc3bFk6MGB0UuCxVFLeL+oC+KBGUl2rSnAt50W0g/3tW2NL9IyO2y
         a6sUgToCx7UeNgmEt32CelissyN2DYcNGv6/6DkSUbLVceujbEvKkW5TaRroKCJmr4xn
         jV7DZtxpVj7pKwwJl2gSXPdRHzGAZRtx+utO+T0BTaefs7uIQPJkArQfjgP1V+rJPxpJ
         3UEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733670754; x=1734275554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6svUt4iTKLUfioqlz6n+zi3gVpzojRZdfSEAIIkW1Pw=;
        b=OIrK0iA8RusfuDLyzi9XkqqNehm2UfKTIDm0hKah8vc7n/KFEU4jQd76Rru6TNQbFi
         VS8PpaDBArTRSNgbT8NzsqSNkLlLF9Y7PG8a0og4uXTCEX/AThq1h2D30fp/tY4VNA05
         Eu1zKx16AJ4cMznpwMPrAvXdGGFVBhGqXkP3xE2PpU3Xe5uRo+Vd2n0Dq2TI3xsZxxCG
         OWgjsbNvqmyZdFo6eboKRL7uGfuGxmBFX+JxMs8pAJ/FERvzRSZ3aMCx+BegiFqCxmXZ
         h93YdxprJwql4Dqnc3btzzuO2eQuxVZZbUEyfvG2MoSdvAUAhFjchZCDqlh4gkcNdRws
         705Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqcfWXLpMG9gvaSlwDJNdwxf7kK4wU4YLO2DFP8tKtEuR/3hr/TpF/inEgkvuVPPLcNr13AITr@vger.kernel.org, AJvYcCV+0LFuwGM5ujkwQAEGEM40MJrGopybmXyjlwKtjlqb49DeuTY64gfTia0NP8CEFErxUAwFlifRKRgP@vger.kernel.org, AJvYcCWY9eG1QY3+z6KsFWWlzuWpbNfgObMzlgk5jfYBq4wu+UbtAQ+H0O9aTDHcYQb+NtZvtRkGCmU+C8Y+ZomJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt6kUn2m4Uxxi8gLPBSLKAHdshwM0fyIMkdKmzNr/Au33XPy61
	r4/bP4n3kNlNZod95HFw1MZhVBulmbN1WnGbK8LWArDEJXhoxZTD
X-Gm-Gg: ASbGnct0zNI0UvBRhc0snBCdsM+QBuS8ZbqS2pWU8rJ35j3qcSCPeSy7TmYe8/jEdZ8
	OXzfEK91/66+41uKthHQenY/RqARhiyBUtDwwdnIvdYoR7NV/GkCnNawbSZ4yU80p2BZIuTOf0S
	kiicP5zIchtxTR1ZWHBgUOFwZaffqT5k9cacNtCItYAKxASKqnV/mG2S/EJkWDAPfw3Bdy0Y1dA
	J3bk72sixEPSe1gCncqyQ1rHzCwZuq9LQdCXtiWME0WUqI3P6BtrJ5O5UbvDrLnk7EzH6bTumUh
	pYW2fQ==
X-Google-Smtp-Source: AGHT+IE8MWiF0ZIMr/Rqxq6z65CLXruJETdntJZe3cATM5wP/XUEsgObmORo8sJbHeUy7FtBYkm9/Q==
X-Received: by 2002:a05:600c:3ca1:b0:42c:b8c9:16c8 with SMTP id 5b1f17b1804b1-434dded7ad7mr69333975e9.10.1733670753440;
        Sun, 08 Dec 2024 07:12:33 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm123459485e9.29.2024.12.08.07.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 07:12:33 -0800 (PST)
Message-ID: <6755b761.050a0220.223761.2b14@mx.google.com>
X-Google-Original-Message-ID: <Z1W3XKvIVTsuClew@Ansuel-XPS.>
Date: Sun, 8 Dec 2024 16:12:28 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	"AngeloGioacchino Del Regno," <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v10 5/9] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
References: <20241208002105.18074-1-ansuelsmth@gmail.com>
 <20241208002105.18074-6-ansuelsmth@gmail.com>
 <8e9cf879-b188-4bfe-8200-f6a6ae285cb5@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e9cf879-b188-4bfe-8200-f6a6ae285cb5@wanadoo.fr>

On Sun, Dec 08, 2024 at 04:09:25PM +0100, Christophe JAILLET wrote:
> Le 08/12/2024 à 01:20, Christian Marangi a écrit :
> > Add support for Airoha AN8855 Switch MFD that provide support for a DSA
> > switch and a NVMEM provider. Also provide support for a virtual MDIO
> > passthrough as the PHYs address for the switch are shared with the switch
> > address
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >   MAINTAINERS                           |   1 +
> >   drivers/mfd/Kconfig                   |   9 +
> >   drivers/mfd/Makefile                  |   1 +
> >   drivers/mfd/airoha-an8855.c           | 279 ++++++++++++++++++++++++++
> >   include/linux/mfd/airoha-an8855-mfd.h |  41 ++++
> >   5 files changed, 331 insertions(+)
> >   create mode 100644 drivers/mfd/airoha-an8855.c
> >   create mode 100644 include/linux/mfd/airoha-an8855-mfd.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f3e3f6938824..7f4d7c48b6e1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -721,6 +721,7 @@ F:	Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml
> >   F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
> >   F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> >   F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
> > +F:	drivers/mfd/airoha-an8855.c
> >   AIROHA ETHERNET DRIVER
> >   M:	Lorenzo Bianconi <lorenzo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index ae23b317a64e..a83db24336d9 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -53,6 +53,15 @@ config MFD_ALTERA_SYSMGR
> >   	  using regmap_mmio accesses for ARM32 parts and SMC calls to
> >   	  EL3 for ARM64 parts.
> > +config MFD_AIROHA_AN8855
> > +	bool "Airoha AN8855 Switch MFD"
> > +	depends on MDIO && OF
> > +	select MFD_CORE
> > +	help
> > +	  Support for the Airoha AN8855 Switch MFD. This is a SoC Switch
> > +	  that provide various peripherals. Currently it provides a
> 
> provides?
> 
> > +	  DSA switch and a NVMEM provider.
> > +
> >   config MFD_ACT8945A
> >   	tristate "Active-semi ACT8945A"
> >   	select MFD_CORE
> 
> ...
> 
> > +static int an8855_mfd_probe(struct mdio_device *mdiodev)
> > +{
> > +	struct an8855_mfd_priv *priv;
> > +	struct regmap *regmap;
> > +
> > +	priv = devm_kzalloc(&mdiodev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->bus = mdiodev->bus;
> > +	priv->dev = &mdiodev->dev;
> > +	priv->switch_addr = mdiodev->addr;
> > +	/* no DMA for mdiobus, mute warning for DMA mask not set */
> > +	priv->dev->dma_mask = &priv->dev->coherent_dma_mask;
> > +
> > +	regmap = devm_regmap_init(priv->dev, NULL, priv,
> > +				  &an8855_regmap_config);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(priv->dev, "regmap initialization failed");
> 
> Nitpick: Missing ending \n.
> Also, return dev_err_probe() could be used.
>

Can regmap PROBE_DEFER? Or it's just common practice?

> > +		return PTR_ERR(priv->dev);
> > +	}
> > +
> > +	dev_set_drvdata(&mdiodev->dev, priv);
> 
> Is it needed?
> There is no dev_get_drvdata() in this patch
> 

Yes it is, MFD child makes use of dev_get_drv_data(dev->parent) to
access the bug and current_page.

> > +
> > +	return devm_mfd_add_devices(priv->dev, PLATFORM_DEVID_AUTO, an8855_mfd_devs,
> > +				    ARRAY_SIZE(an8855_mfd_devs), NULL, 0,
> > +				    NULL);
> > +}
> 
> ...
> 
> CJ

-- 
	Ansuel

