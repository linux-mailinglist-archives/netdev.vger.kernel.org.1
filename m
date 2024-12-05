Return-Path: <netdev+bounces-149504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D249E5DF9
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 19:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34EE285E64
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 18:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE257226ED3;
	Thu,  5 Dec 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZq4M45N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB661922FB;
	Thu,  5 Dec 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421951; cv=none; b=W9DG9erPxE1ism0/Q9/RYZzpT9J6/cbXqlpe9QqpMPMPxTAYocpIkAU76eeXlWnCqJYj9TVweJgHvzkVyzKqcmHHPgXSme8MlOmMJw37s9Ok4AmC4S3gxsZSvTVP0wOesC3FdHpIyKZwdthH37HV0X+PjqD75bMBlA3Xu3A5TxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421951; c=relaxed/simple;
	bh=SjIPREhBR4IU+XluzYW9qjN6GMwoDxsaQo5rh1Ifc+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3SpDl2FI0QpRh7JbnFlN+O6mHo2Pa1nJ/iFce/1QiQ7svoWk4YFeoRfWoAbVgxrpJCsVMyGTb3ESM5m3QiDKmQd8WUSUcQ342j+q9z4h45E+TMPcIb7whpHuml5pQEOEUqmCzPAPgn6Fg/XrjpckyhxNkpPqAw19bzzYViV9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZq4M45N; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d0ac3be718so170016a12.1;
        Thu, 05 Dec 2024 10:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733421948; x=1734026748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y9GVm87bSpq/hl/hsc8tzDLtFmHzFt/UjSs+LY2xa7s=;
        b=PZq4M45NhoWtoYU5MTepP/tN3d0SWN2Bsr5pmTmjlqnwk0vGIgAw9Gme+JKN/0gWVE
         9cHcBONWYY1AbnY5UH+1w+dZw69Nh0Rymy95t/AMMcOYSI1suuEO5sgCHkPwswKU9VDE
         Amk3YxhzSGGfUAn85SzM3vCfOy0TBcKft4AkheTdeOWNRWlb54IZCyB0Wld1lr1YNDa/
         fRun/eOhJlf7dKYmpSmxQhfdhUQIyJgaUj2abNPTEEBEkq5Gsadt8iQIyiksKmmgtWNn
         M8n40SS9hFKj3SREKfa6R3YfYwQGCE8BxwitOiQxv9Xjctx60p2UAiXCFdazgJigR0U3
         XwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733421948; x=1734026748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9GVm87bSpq/hl/hsc8tzDLtFmHzFt/UjSs+LY2xa7s=;
        b=iXc7gMr4OOu2g5Pnt7rgu5ZP+watTl+ysuEYUBrT3hPREEguG7+i7bWL2R3Oz3BCNw
         1v04KV5KL5ZQxQifn5KLa4x/9FBE8QcPgd8GFbBR/x1KXTpiMiyjgqC2pzzCqT2/gXX4
         5WuaaNtlT9ajerQo4SzCLkxhzNW5qcsb4dZyU8M+enmfRFjZi1eED7smhxCBWM2+fF1u
         i2BS2ifhVEZfhhRrgfgZlrayiQTXIYc9XFTFflxoLNm7But1Q14l98E8X1qufNvUO0fP
         IrED/yp52eQ8uKdNcXmx76Mx8PQmVgly4LA1SW/Fru2+BuvJ6O4B6pseGGlJhd+vqYCj
         mYiA==
X-Forwarded-Encrypted: i=1; AJvYcCUvl61RrIVAvySkLIeq4aoGWVtVK/8zrG1Nbq1kEddOEKBv5Yn41+BJm1OQ93oznoJQQz1nV+aS@vger.kernel.org, AJvYcCVFzU81dpY6L9kKNGrNCeGfQGUFWZrAK5h9LzFGLGolA6uB1z6ntT/xAnNyniD7DgapxaG6b4yqZUGY@vger.kernel.org, AJvYcCXHV2iqhfQHbiyge0WIoI7gdapck6X3/ur/EyFFj7feCZRnO/GNbGsdPttA8kuDnGhV9G8idk62hIxdE5Gn@vger.kernel.org
X-Gm-Message-State: AOJu0YzTvgEN5fR1nNUJFBKRf3WIkUGDsfD/CKLrpR2PTbW9F+goesiV
	3SyI71+6SinNsE/KytsTgGCgkaeuVvatMx9IW66VQ+TcGoeJ0Z0w
X-Gm-Gg: ASbGnctY4v0K9H0Nuz3M3D7bTssKlTiMRb/bFm1RldD40CW3oseJuGi6GLYYp6mlx4h
	mATr8WOBNxw9XWOfHzFHOi7zuWzYt2CaAeyNiw4rWof2Kw5kcdZYxi6nyxb3wOXrmrq/1ymotC9
	/A6coJxV31SVRnLipz8DH/eY80/zx1gnsIwaZGNoZDGuJnqTdkoN+uLH53xemWb4bn6xV/HVLKo
	BKDuxmFeQ2aO1rGGxZUq72hx0z1DA5vJ/QGcqc=
X-Google-Smtp-Source: AGHT+IG7B9QIHNCPW0oiA+I6ajVzIYVZWOIIvvoz5mac5vhllldMUr+wRDfdj7IWVlyWYwVezRdCUA==
X-Received: by 2002:a05:6402:1d55:b0:5d0:e522:9731 with SMTP id 4fb4d7f45d1cf-5d3be47d80bmr31759a12.0.1733421948119;
        Thu, 05 Dec 2024 10:05:48 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d150f544e1sm1073330a12.89.2024.12.05.10.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:05:47 -0800 (PST)
Date: Thu, 5 Dec 2024 20:05:39 +0200
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
Message-ID: <20241205180539.6t5iz2m3wjjwyxp3@skbuf>
References: <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
 <20241205162759.pm3iz42bhdsvukfm@skbuf>
 <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
 <20241205162759.pm3iz42bhdsvukfm@skbuf>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>

On Thu, Dec 05, 2024 at 06:17:18PM +0100, Christian Marangi wrote:
> I checked the examples and one problems that comes to me is how to model
> this if only MDIO is used as a comunication method. Ocelot have PCIE or
> SPI but this switch only comunicate with MDIO on his address.

I don't see why this matters. There will be a top-level device driver,
which in this case will be an mdio_driver and will use mdiobus_{read,write}
to physically access registers. This driver will create regmaps and add
them to devres using devm_regmap_init(). From devres, DSA and other child
drivers can use dev_get_regmap(dev->parent) and perform their I/O through
regmap.

This driver is already written for regmap, so part of the work can
already be reused.

> So where should I place the SoC or MFD node? In the switch root node?

The SoC should be placed on the host MDIO bus. And the Ethernet switch
component should be a child of the SoC. Ideally, so should be all other
switch peripherals: on the same level as the Ethernet switch.

> Also the big problem is how to model accessing the register with MDIO
> with an MFD implementation.
> 
> Anyway just to make sure the Switch SoC doesn't expose an actualy MDIO
> bus, that is just to solve the problem with the Switch Address shared
> with one of the port. (Switch Address can be accessed by every switch
> port with a specific page set)

Sorry, I don't understand this, can you explain more? "Switch Address
can be accessed by every switch port with a specific page set"

In the code, I see that the priv->bus and priv->phy_base are used to
perform MDIO accesses for anything related to the switch. That's perfect,
it means that all switch registers are concentrated on a single MDIO
address, behind a single mdio_device. If that weren't the case, things
would get messy, because the Linux device model associates an MDIO device
with a single address on its bus.

And then we have an8855_phy_read() and an8855_phy_write(), which in my
understanding are the ops of a fake MDIO controller, one which has no
registers or MDIO address space of its own, but is just a passthrough
towards the host MDIO bus's address space. I have no idea why you don't
just put a phy-handle from the switch user ports to PHYs located on the
host MDIO bus directly, and why you go through this middle entity, but I
expect you will clarify. Creating an MDIO bus from DSA for internal PHYs
is completely optional if no special handling is required.

To explain again: In the MFD proposal, there is only one driver who has
access to the mdio_device from the host bus: the MFD driver. Depending
on how it implements the regmaps it presents to the children, it can
control page switching, etc etc. The child devices only operate with
regmaps, and have no idea of the underlying hardware access method.

> But yes the problem is there... Function is not implemented but the
> switch have i2c interface, minimal CPU, GPIO and Timer in it.
> 
> Happy to make the required changes, just very confused on how the final
> DT node structure.
> 
> -- 
> 	Ansuel


