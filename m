Return-Path: <netdev+bounces-149457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B599E5B63
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C921885FE5
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640CA217735;
	Thu,  5 Dec 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtWveSTL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC221C197;
	Thu,  5 Dec 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416086; cv=none; b=XlypWvK5Jq27WD4c73JvaMemF+v/rHL/+Dqb1oT51A0bDkf1bsp6gUNIyGhuKR0W07yOwLl3FGyVuup+WuU3zhTPEvf2UaFMR0sQniBSsfXO3Cl8Q6p5xbTQvGM/0Vjh1g3/1DThsaXkWD1b/E3eu2m6C8mMWZ6vMeyot010voo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416086; c=relaxed/simple;
	bh=/xJ3xaMYdGaw1aBEs70Kib26Ogo2MTy5725TA2ft150=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLFgI092P3s3/VUYrNou/w+ReuqYwMG6Q8MutcuPiG20V1DmFCyQYsa5uDdex0n0fq4R9M0J3x22cTPtf7RYvpFTURe7H5wyfIFwxbvco4yXVJ3i2Y3StN3KYDhXT0m5pKg2VHTT6snE//L5QPm+z/gy2LcuqGrf10qk1QxdZ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtWveSTL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa62fc2675cso8107566b.1;
        Thu, 05 Dec 2024 08:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733416083; x=1734020883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPXoJcPeSQwufs65dme8yzbSHiM4hQw48CgHRQis7MU=;
        b=KtWveSTLXNB1KUzT1SXTfAhbDuU7jOt/n3VQdZB7BVXiCoJOdtZl+Ip8WBvhCFK/RU
         IhXDQfPnPImbB4L81NwWscpYG0Qxxv9NUt8+p9VXxI3vZi0k4ylgWIXBCgVuhYNvkp+u
         sHcHF3iGxXPjuYg5AmZCJbrFd48v+fZhgyK+ZBl9jWW6Y3lUrFjJTkE2VRg5R3geoBlK
         1XCE67ujpqhLy6PjuFy5jjaoC00UEzjtiG9ZzFHJ3EtJmL1ZAKVW72gqPKVqQIzPfOO8
         FeLebQOpmjPGv36yQiX+HOlAtrdFByT8c1CE0n17VIslQx5Hul33Q74LZ/CkvA77no6P
         e7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733416083; x=1734020883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPXoJcPeSQwufs65dme8yzbSHiM4hQw48CgHRQis7MU=;
        b=AVutGVWEnKDcEUb787RkiZ94VatTuRymhrj1ezALd59cZm4JYVopebLCShwFTD680g
         4/hz1QDSyS9HiVkkXz/IxTCwJ2yfyqlQRZPrZzjSJ0euCErwnTPSjCYAdbvVSA6OUDeW
         vZeVcVSMpFCgI7if5rJMzg/Pa8QOvZ0NtLzGd507DPPc9MgBmgSeeT+XAiiGs6jODQhX
         NyLTR1qZBeZAbHsLBpfWapcFNibgmVQqen5Q8tYKU26R/lvpu/PfDZ+B+y3AEso3gdPA
         0SeTkmvZsM1AJ1hQNKBr4Os/owxdXPc9vNYVWmmscLUE1B7tamVGZtTMTFUK+GEMxPAy
         rLKg==
X-Forwarded-Encrypted: i=1; AJvYcCWT+r/qygbyzR5WaBGuX792VIle01rY+w0CYZS/xUkbiQKl7dGCnkggwzPkTW9FDSj6xDNVBUVgPXfVyGhM@vger.kernel.org, AJvYcCWZEhqZZuN/ez3nt/69yXmo6WPNqHNGwNIurlN7JBuEtLTqGTR9mMf2I8IN3Mj9XrYGGEyhMilC@vger.kernel.org, AJvYcCX8beG9RQ+lC6h4I9T24OzN2SY4lga/FCQvbhv3Kg0QfqrTtulEBuGRw+Jlc9mbed5Z9QT+CdX1e4/r@vger.kernel.org
X-Gm-Message-State: AOJu0YxqfijVM/inCscB0YkbUiNDnL0eynRRqQvlLDoF72UWnxVluA1q
	xyOzwx0vntmyxsZ2xUAT15JrfmA4MIBeKZ71Horh7jnvZRKd7GHU
X-Gm-Gg: ASbGncsSWwpv8V0jSwzBbFD8DTYAEvMn9p0CCb7ilkHsGeA/M6nuiIyAUgWZGYL//Wc
	cDUCrBdv/G1M7OxOTg4scbjCn9RyxWCgKx8kbM0Cb7lynu8lJYGUgdhk3yQU0lyXWtv0rn/4P6A
	2+Y2H73bj5zGspxIugvUhQ14o0aJUi00QlnXgxuKjv0bcEoc1u7KY2GVYrsSU2qFsnpg2wg1C0u
	ONk5KFHLVNcjcXzkxivfI2NMzw8RjEwxYE+m/4=
X-Google-Smtp-Source: AGHT+IFXo8dPa3kP8TWBFDql5AxNgfAf43Sw1KmsQzDEJFJ2Gu14qwW18WvRihEawx3T8P1t1NEPUw==
X-Received: by 2002:a17:907:7b85:b0:a99:f230:8d6e with SMTP id a640c23a62f3a-aa5f7d9a1c9mr486801166b.7.1733416082676;
        Thu, 05 Dec 2024 08:28:02 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b5ddsm111902466b.118.2024.12.05.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:28:02 -0800 (PST)
Date: Thu, 5 Dec 2024 18:27:59 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
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
Message-ID: <20241205162759.pm3iz42bhdsvukfm@skbuf>
References: <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205145142.29278-4-ansuelsmth@gmail.com>

On Thu, Dec 05, 2024 at 03:51:33PM +0100, Christian Marangi wrote:
> +static int an8855_efuse_read(void *context, unsigned int offset,
> +			     void *val, size_t bytes)
> +{
> +	struct an8855_priv *priv = context;
> +
> +	return regmap_bulk_read(priv->regmap, AN8855_EFUSE_DATA0 + offset,
> +				val, bytes / sizeof(u32));
> +}
> +
> +static struct nvmem_config an8855_nvmem_config = {
> +	.name = "an8855-efuse",
> +	.size = AN8855_EFUSE_CELL * sizeof(u32),
> +	.stride = sizeof(u32),
> +	.word_size = sizeof(u32),
> +	.reg_read = an8855_efuse_read,
> +};
> +
> +static int an8855_sw_register_nvmem(struct an8855_priv *priv)
> +{
> +	struct nvmem_device *nvmem;
> +
> +	an8855_nvmem_config.priv = priv;
> +	an8855_nvmem_config.dev = priv->dev;
> +	nvmem = devm_nvmem_register(priv->dev, &an8855_nvmem_config);
> +	if (IS_ERR(nvmem))
> +		return PTR_ERR(nvmem);
> +
> +	return 0;
> +}

At some point we should enforce the rule that new drivers for switch
SoCs with complex peripherals should use MFD and move all non-networking
peripherals to drivers handled by their respective subsystems.

I don't have the expertise to review a nvmem driver, and the majority of
them are in drivers/nvmem, with a dedicated subsystem and maintainer.
In general I want to make sure it is clear that I don't encourage the
model where DSA owns the entire mdio_device.

What other peripherals are there on this SoC other than an MDIO bus and
an EFUSE? IRQCHIP, GPIOs, LED controller, sensors?

You can take a look at drivers/mfd/ocelot* and
Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml for an example on
how to use mfd for the top-level MDIO device, and DSA as just the driver
for the Ethernet switch component (which will be represented as a
platform_device).

