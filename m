Return-Path: <netdev+bounces-173355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7208A5866C
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1605416612F
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861221A2C0E;
	Sun,  9 Mar 2025 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiKEAswy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA73910E5;
	Sun,  9 Mar 2025 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741542519; cv=none; b=Vrg92iy6L10We4Zb9RNCLOM1M1ruDwaVwVOWavGsu2P4yM9hScGUl6IqFfnqavplTTTKra1zGC13y9hqjFbjOWpcDgHkOt81C4i2mJpVsyAhFosEtWO4JkNNl2iPT9GG2N0FRH+1WpUvklBSuqvBD1A4jy/kt5eSP0lxftUPvbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741542519; c=relaxed/simple;
	bh=IUW6EZm7/oaNBw5RPSdZbbA/T1kczIvutYqS5/DDbTs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaravzOC20vKiPq9vN4J9KLH+qR9VInt63jJ0gzMS6Xglphvs2ZELWNCOtohNNWwfVruKERb6OL7+qJH8Zki+tpaeQIsC6cppTh8EwIYvKUT28/IzLUmE56FFZB+QlqA42GUzhQJT391LZ4au8FEe6uitmFwaAPghyZfPZVfhKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiKEAswy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bd5644de8so36413735e9.3;
        Sun, 09 Mar 2025 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741542516; x=1742147316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BrmgUU8m2W+dm6XtC7Lvzp3134bSe6hwOO06zK/FM4M=;
        b=UiKEAswycpI3o/APvDq6IJPC2THpOgNWTA9NMz13b8ag/GU9iV119KIMRKDOOPxpfE
         80q+J2/We1CJ0+z2uLub9EM/+qNVwm0SAQ4LgFuBFXTJ8hyNf4RbKqKuOGR40aCA/j8y
         X3HzqzI5EcUa44nAknkGWJRo3346eyxXrKN8ZQZkEPfpVoFcxhLfQ3mLv9FywoUe+IHY
         qn49VT9e9eeJZP2Qhm8zywV8YJiJAlMh5E58iK0vuxkzMpDVQJ1QrGus43tP3rMDNd+r
         eBHMsuEMmJK8Hj/+xZF9nFLCqbHhYUoESHKUx1XzuV+Zb94ETZhFRVH7qwVhOzkDGgm8
         f6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741542516; x=1742147316;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrmgUU8m2W+dm6XtC7Lvzp3134bSe6hwOO06zK/FM4M=;
        b=GORj+TY89pUT87ssRz6DUlh3rVg0EeUvsZvYHZ/OLPsSkIbVixE3Z+DUnyVmfNo8fx
         rys6OP0vq0XabXkWLhhnOraQIh+hgPFqbgoytofjb6RuIOcH4tI7lPWrGvzzgG4oQRs+
         dZs6xrIjUxgeS8YGyVy/QlkCVvWpAz+cjN+QdY9KaaXrz/elqhabQYXG4toavp0l7pnD
         +v1LQuOg5i+IG6pcN5X8Qve5MGOHmsFUU6Vqu09VeJcf7kYNOQNbII2GJ0OcLCRZ+uxI
         NplHVD/oBrmE/g/u0zoJudeJRx4v6BMIcCbfK8Rz/KBFW2LzmD7uKlE4j9nm2fCDzSWZ
         5SyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Dqv0Im8cXz11d3mkaGqUn/VognR3o4f4NsSwKDCbrrtTFUHkUkOI4BTggrmiOuiayBW7SUFg@vger.kernel.org, AJvYcCUkx5/E8v1eIB3egyS5d7Y1Pdr3FWA78qddDg54sXUo1wyNmY9PHQI8WtwvGPmVpNYkhVGgjVAvJBQh@vger.kernel.org, AJvYcCWZCdZRE5PB1NuRryAoscw68wiPApJ+vjDAdjaaySCTUHr7ih/lWS7K06aNpmyox6JUZcf0uIvJGEMAd3GA@vger.kernel.org
X-Gm-Message-State: AOJu0YzYo6BJjwGG1GxWOEPeWbRkPzIYIb6CW7BIKZ/jR0GoIh70wnC0
	xyWv46zhRs85LV7SMRUhf+7MmkT0hZi9L5nk6X5OhfALNqlcmtmf
X-Gm-Gg: ASbGncsOiCwSmQanEvCF0QtE47wnleeJkfFBb8g8swbJ/xqOKuh6iDERfGjzYRmzchi
	/RSPOtAF4q9hjlV5UWwoBZjPw/U9H99aJbJGBsxL1oOcHgmTJWTUe+X2ic9ze/XXu+a/jdtkIfW
	GfNeMCTs+s3OEHGvE7xMX/rqwTyBgO3Og9uHJGDH2cYfI94QncyDpLN9r6diYO4SHsM5iNPUQG1
	yjNX+i0q7EtZw4WN2dnzaGaWpj8Zl1vbp3IrOPmuKThMOAp4gzxUntMkKzNbrDDA7H457ER7q/Y
	jZCspK0WnLZmX6YCVImgN+vjY8zcN11XP4V1GKGiW/jbrqzwW5aKFHBFnljWBuKnOcslj4gSJEX
	C
X-Google-Smtp-Source: AGHT+IFqmRVo6FIysacWzJ33TfZtTvUxXtYg7bp/VcB+skW5kxcsz3otvb9dL4N79FYLMYigyzY4bQ==
X-Received: by 2002:a05:600c:524a:b0:43c:f75a:eb54 with SMTP id 5b1f17b1804b1-43cf75aed5emr10293205e9.13.1741542516005;
        Sun, 09 Mar 2025 10:48:36 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce8a493d0sm59519715e9.1.2025.03.09.10.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:48:35 -0700 (PDT)
Message-ID: <67cdd473.7b0a0220.170541.e2af@mx.google.com>
X-Google-Original-Message-ID: <Z83UcX4X2gpPogQs@Ansuel-XPS.>
Date: Sun, 9 Mar 2025 18:48:33 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v12 08/13] net: mdio: regmap: add OF support
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
 <20250309172717.9067-9-ansuelsmth@gmail.com>
 <Z83R9qVfGbSc8bJs@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z83R9qVfGbSc8bJs@shell.armlinux.org.uk>

On Sun, Mar 09, 2025 at 05:37:58PM +0000, Russell King (Oracle) wrote:
> On Sun, Mar 09, 2025 at 06:26:53PM +0100, Christian Marangi wrote:
> > Permit to pass the device node pointer to mdio regmap config and permit
> > mdio registration with an OF node to support DT PHY probe.
> > 
> > With the device node pointer NULL, the normal mdio registration is used.
> 
> Should this be using a device node, or a fwnode?
> 
> It depends _why_ you're adding this, and you omit to state that in the
> commit description (hint - it should say why!)
>

Ugh totally forgot... It should be a device node. The use of the of_
variant of mdiobus register permits to autoprobe PHY defined in device
tree.

The current regmap driver only permit manual probe using the mask value
so it's problematic for MFD usage with an abstract regmap and PHY
autoprobe.

Will add additional info in the commit.

-- 
	Ansuel

