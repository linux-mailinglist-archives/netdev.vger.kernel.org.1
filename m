Return-Path: <netdev+bounces-149497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E17D9E5CDB
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 18:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387CE2864A7
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FD0224B19;
	Thu,  5 Dec 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgGKGSSq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5224224AF7;
	Thu,  5 Dec 2024 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419049; cv=none; b=Tg3UQzDpIOeg+r5GujneatZ5YvC1cf/cB6Kc7Rh+R3larsBwPHj2tV6K/wrBcrfoWMXmlEC6EViiJo9jm3QzHfz34b/zFJjtFzobRaGqEvOz1y4dxOQSUMmmb0HxGVhorxryBHBSm+/ex2STpRb8+1tjG1Au3So9tyfvvYVmhUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419049; c=relaxed/simple;
	bh=kRYEY1KRiU7EUBCY1eeoFd1xZYooU1OgACuow2eogX4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYevc1KIsU67lYJGYtfqnjG0mxtrNzIyLRmuMzltGiEzV2CjDcMzSamG1ya4eXBQEYmmrnGCF9IjLkNh+B6PE0YwxGpxC0lW47UbE7HYtGcDV32rkQdRbw8XcF716hpwRozUbI8E3rnGFQV2k4Z/Uojw5649G3fYO/UDBqcHSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgGKGSSq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so1030403f8f.0;
        Thu, 05 Dec 2024 09:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733419044; x=1734023844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SN1IUjCKosvwoMP78JjC9pNaPeczyqUZO6x+klQrhM8=;
        b=MgGKGSSqDyOODt8w9RHFBJ2SI4/2eoayhwvJRUJI2SQXCQqkZ0W8LanoZR1s2rI1ZS
         d/SiyCauvTPDFjVKUYKilHIPYYwBrSFb7kKjoQnSsn/PnnV1YzIlfVKLrQZ+9ln7pwOD
         5MwbOV1LlEF9hNdS/PDCwYk782oyrW4fM3MONgXqTrhDiisXaxbz8aEFs3z3Ak15CxFB
         ymzxWJyg7lJ84dAOAtTZbPrLREKK8Yz/bLbRpEmAdYEENAhC5wMqNBRce0lsn7k+3yoZ
         VOVrrN2nKcqXDJGPpxW/EFU0VYOjBK3mLdXETuI4YRi/G0QvhVGRva2ZN73U/+ZSZ1dY
         40rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733419044; x=1734023844;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SN1IUjCKosvwoMP78JjC9pNaPeczyqUZO6x+klQrhM8=;
        b=SGtdjdyWLE5KjWDYDFST4aWi++FfIlAk6aWwAgC6rqs00s2JfAOp7dFquKyjNEUx+9
         /rUXFrsWiAAvqyFfjhNqsZ6RfkxY1t02Yev9AzGbX14GVwzTQh7DbIlvfAZYHF3RuhFe
         trj+tlwvOea6x3w5b5gtDOP9sA5GIfiVj8xZj2mQ2aewj+ncITQ6V31vIx0HoMbjjyX+
         GRzRrLohV/p2Yd6Wx4xMCoaYagXyHtkNZcRWtaTvaFSp6vIIvvHYXHKyS1bBDl/ypNWs
         rXjg2YXTe8osgdbmJrBOTMoYd9cW1eQelpq02RNXMfJMtS2NUGr/iMKJQgoRCpgsWUhQ
         /BZw==
X-Forwarded-Encrypted: i=1; AJvYcCVSZc1TM2IcVtHauXns2UPsVZWu/ncT0wWIXs/uNP0e4fuEOKIoSU0EZsy6bczgLrAmZyl1CEK3@vger.kernel.org, AJvYcCVurWE568794bnNkYOTfxTng01Zo6QryeelTT3eUGvO81mtg0EvXcMN5n7UCciu0fU87g66IM0cxzfP@vger.kernel.org, AJvYcCWIPk7XzgcXr6/rpPWV9UcKA7UZRSCxmTT3e7qlZlLzEQ/8X1ViElgu6RrQAJ9lnhnF9UPpR/2mQaGIw9pF@vger.kernel.org
X-Gm-Message-State: AOJu0YyIqz8tBpXYRVUFmIEM5ts58fqWubFyyKYS5SBDuNoA6Pg7ebCX
	snl5HHiiYvSGTTptdWThgpi/Gi0Opz0JPXJUAJam1SuSj0umcHi5
X-Gm-Gg: ASbGncsVlW4P3KBRGL8HvT06JUg1h4AGC03xw1ZJHHp3ZU/z5EzQS+sz3jXNBbdSGwN
	dulMXNuTSsrUB577qlsvgR20/xJGzegL/LK6FfyukwtAj6Y9S8Ur0W5K9s+89MCfiCkMxFIAOlW
	sWsG/uc4A0hryeZVJ47bxaZViiXlyB/AXQa5/Y3Wlp7EqQE30GgMQ1i9HQ2FM9QCn/Yz9Jghm4l
	BH4Bdd+tkzmkRp87E/+xKoBdoTXXVWIwMJwWfnv3x2LERUzIV/4vwlDCPEjxlP16y1eojv24BQr
	eMTVFg==
X-Google-Smtp-Source: AGHT+IFGLdccQZZT6SK2+da//mSq/Cl9jdeyY32lqwWVf3M+gX0V6WTHyQEf5kO3jT5sbZpH2fuN1A==
X-Received: by 2002:a05:6000:1faa:b0:385:f7d9:99f5 with SMTP id ffacd0b85a97d-385fd433612mr9315287f8f.51.1733419043842;
        Thu, 05 Dec 2024 09:17:23 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a8591sm2443049f8f.36.2024.12.05.09.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:17:23 -0800 (PST)
Message-ID: <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
X-Google-Original-Message-ID: <Z1HgHu93YLoS_D4P@Ansuel-XPS.>
Date: Thu, 5 Dec 2024 18:17:18 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v9 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
References: <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
 <20241205162759.pm3iz42bhdsvukfm@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205162759.pm3iz42bhdsvukfm@skbuf>

On Thu, Dec 05, 2024 at 06:27:59PM +0200, Vladimir Oltean wrote:
> On Thu, Dec 05, 2024 at 03:51:33PM +0100, Christian Marangi wrote:
> > +static int an8855_efuse_read(void *context, unsigned int offset,
> > +			     void *val, size_t bytes)
> > +{
> > +	struct an8855_priv *priv = context;
> > +
> > +	return regmap_bulk_read(priv->regmap, AN8855_EFUSE_DATA0 + offset,
> > +				val, bytes / sizeof(u32));
> > +}
> > +
> > +static struct nvmem_config an8855_nvmem_config = {
> > +	.name = "an8855-efuse",
> > +	.size = AN8855_EFUSE_CELL * sizeof(u32),
> > +	.stride = sizeof(u32),
> > +	.word_size = sizeof(u32),
> > +	.reg_read = an8855_efuse_read,
> > +};
> > +
> > +static int an8855_sw_register_nvmem(struct an8855_priv *priv)
> > +{
> > +	struct nvmem_device *nvmem;
> > +
> > +	an8855_nvmem_config.priv = priv;
> > +	an8855_nvmem_config.dev = priv->dev;
> > +	nvmem = devm_nvmem_register(priv->dev, &an8855_nvmem_config);
> > +	if (IS_ERR(nvmem))
> > +		return PTR_ERR(nvmem);
> > +
> > +	return 0;
> > +}
> 
> At some point we should enforce the rule that new drivers for switch
> SoCs with complex peripherals should use MFD and move all non-networking
> peripherals to drivers handled by their respective subsystems.
> 
> I don't have the expertise to review a nvmem driver, and the majority of
> them are in drivers/nvmem, with a dedicated subsystem and maintainer.
> In general I want to make sure it is clear that I don't encourage the
> model where DSA owns the entire mdio_device.
> 
> What other peripherals are there on this SoC other than an MDIO bus and
> an EFUSE? IRQCHIP, GPIOs, LED controller, sensors?
> 
> You can take a look at drivers/mfd/ocelot* and
> Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml for an example on
> how to use mfd for the top-level MDIO device, and DSA as just the driver
> for the Ethernet switch component (which will be represented as a
> platform_device).

Hi Vladimir,

I checked the examples and one problems that comes to me is how to model
this if only MDIO is used as a comunication method. Ocelot have PCIE or
SPI but this switch only comunicate with MDIO on his address. So where
should I place the SoC or MFD node? In the switch root node?

Also the big problem is how to model accessing the register with MDIO
with an MFD implementation.

Anyway just to make sure the Switch SoC doesn't expose an actualy MDIO
bus, that is just to solve the problem with the Switch Address shared
with one of the port. (Switch Address can be accessed by every switch
port with a specific page set)

But yes the problem is there... Function is not implemented but the
switch have i2c interface, minimal CPU, GPIO and Timer in it.

Happy to make the required changes, just very confused on how the final
DT node structure.

-- 
	Ansuel

