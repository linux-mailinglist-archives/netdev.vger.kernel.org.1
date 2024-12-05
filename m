Return-Path: <netdev+bounces-149505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538549E5E3C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 19:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A531884F34
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 18:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1EF229B15;
	Thu,  5 Dec 2024 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc7MgTBW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311921C17A;
	Thu,  5 Dec 2024 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733423401; cv=none; b=GPGRdspkTACe8/LOM4rFUp9Rwk6KX2XWKYrd8klmq3KuXNFcrJQEETXwmtBpPeETDCKLOylI6xZA7U0aPzDzmh0VnZE8uJCcZUb5y5DoJebZhR8Ga+qE1gAm/84txVtUQrhtnBDYoHJs4xqa91xHyAEPuk06AKB+k1kc+16D0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733423401; c=relaxed/simple;
	bh=XSZw2Wgdd/4DSswFvkNB9pdesf88N2+IuEgP4J2bvGA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvKNodFh2WwVn6Cmn5pKCw4xDYac+kVj0kaJOldMmkNLLLEUyBGqhp7BuqwUOqG+pD3NvF0PYlvnZ564H5KHkx/oqgTW2JEh/X78dPbS6j0Hefph13QzxhPnzv1EmHLXOG6+Z9Vbny2FCHKONHB0KIN6LNlktNIr5sMTjOcD7Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kc7MgTBW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43494a20379so12435615e9.0;
        Thu, 05 Dec 2024 10:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733423398; x=1734028198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vqa/FJfDuFpf2/icBmOOPejR/n8LB10qbeeDVsmf77U=;
        b=kc7MgTBWT+js0nZqbPRXmKJYoJXkjUNURNTEasn3mQoFK2WnntJ10VQkSUeL29zh/p
         LmrOpcAi+eb8MapFK4jjCzs+aJiKrOkj8WrUGuAJd7sz4GEddJpoeka+2GhGw87nZ1Ab
         i/0IFbMGRGHXQ9inJu8T/gZ4TMoDSD1TkjyRvEQDnPJJuNv2COBc2hvOmvk8ZEeZVqzK
         uzLpaaE8gQkAABPleoY3qkFBuZLUlapGuHkxWLQlLXQX2GLfdXhKkhnAv9MA2Vh+RW+u
         uqAteDMfzQEBBGRx1enMgGwvvE2h7AljTxx3BCNosky3kYAPJvLOusFp1EmhNiGfvYd+
         J11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733423398; x=1734028198;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqa/FJfDuFpf2/icBmOOPejR/n8LB10qbeeDVsmf77U=;
        b=R8ntzN53Kxw/zt4nh0n0NWBHc3ZzGHHGHcNdnA+HIDIuzTsF0SjvdrrdixTL+Paj47
         AbqZd7YbY4MaNtSYGjpUg7Dw2P4H5IoX3RtaIQ9HhQBCOfODTBS4fv+/wRkV7hUnh/zL
         u00bH7sxEOjhmcFJJ9o3S7TTsZ9kckrEMTAa01bzW5p4AvGEmoGQEemMV8/Ee0Ay++2G
         gH55C914pgzrKv3JbbVNZv8Aoudyfb+iBCeODjZw/d2HWRcQl2NV759S45vJmc4JUVG7
         D9RibpQm4SUpY3byqr8LS3LjKuLVnRqnWQEFEFPTqix1ID76EXkWwV0fpyoHgtw4tKmp
         uo3w==
X-Forwarded-Encrypted: i=1; AJvYcCUCLo0FxkJa6+pX74zP5le0VHqQNf8/cJ3NEZMLOnZ4Tihr61AWaqiuINbPc8VQi5ztT/7fq8X/ngCw@vger.kernel.org, AJvYcCUWAiHAYV0hyKoyGpxKaSI+tSa/3bvTssFHuG3hO1Ff65DtsX5yIeg9toANKP/yLulPuiKgpioB@vger.kernel.org, AJvYcCWEKcfJLlLgGPzescI/d2Z9AsCSAfBJZqyxaDXd+iuB6idM85z4lbP0PTEMY84ikkHw2kQp14lmqVqXIhXo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/yi1zUshQzLwFb9TPg/d6omUW0tOfSqfgliigBYdDI0EQMPqb
	JolVzX9elrZsX5IN4CZrfE6/vcJImt2tHwA9TXHolm/oJF5lkL4k
X-Gm-Gg: ASbGncuQrhjz/U4EJiCCr4hR6VAhXRZMF90IHevyN5TiL1IXUrdRTwejVOEK8FNsWJ/
	9hjNQtL/rfvkATw78lo3dpObXe+hD6uEgjoRNiH9Dxd/0KSRVxyga+HrogEjUZrsZdVSWGDg1Jj
	SzsVE/7S3k8HdxSYK0Glbi+g7nsPm69AhyJghvnotNUDROv/WhRzqfE5K7J21Mk6taARRtCdvyR
	praX5VCfXxiYWoEiu+mq/WBJkcfZltGicVBJ5lXIeKLtAJhK+L1wEiO32UTTvnfsjCMdFe/dxWm
	rFX9JQ==
X-Google-Smtp-Source: AGHT+IFTb665DniOhjVw8PuT2tMsXOiRKDE+9zzhmTvFCq7OvOYhsxODyzok3XIotSpVVjcnB4qQFw==
X-Received: by 2002:a5d:5886:0:b0:382:319f:3abd with SMTP id ffacd0b85a97d-3862b3cea9fmr76744f8f.36.1733423397793;
        Thu, 05 Dec 2024 10:29:57 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a874dsm2596621f8f.24.2024.12.05.10.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:29:57 -0800 (PST)
Message-ID: <6751f125.5d0a0220.255b79.7be0@mx.google.com>
X-Google-Original-Message-ID: <Z1HxIYnkilHmBbgK@Ansuel-XPS.>
Date: Thu, 5 Dec 2024 19:29:53 +0100
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
 <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
 <20241205162759.pm3iz42bhdsvukfm@skbuf>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <6751e023.5d0a0220.394b90.7bc9@mx.google.com>
 <20241205180539.6t5iz2m3wjjwyxp3@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205180539.6t5iz2m3wjjwyxp3@skbuf>

On Thu, Dec 05, 2024 at 08:05:39PM +0200, Vladimir Oltean wrote:
> On Thu, Dec 05, 2024 at 06:17:18PM +0100, Christian Marangi wrote:
> > I checked the examples and one problems that comes to me is how to model
> > this if only MDIO is used as a comunication method. Ocelot have PCIE or
> > SPI but this switch only comunicate with MDIO on his address.
> 
> I don't see why this matters. There will be a top-level device driver,
> which in this case will be an mdio_driver and will use mdiobus_{read,write}
> to physically access registers. This driver will create regmaps and add
> them to devres using devm_regmap_init(). From devres, DSA and other child
> drivers can use dev_get_regmap(dev->parent) and perform their I/O through
> regmap.
> 
> This driver is already written for regmap, so part of the work can
> already be reused.
> 
> > So where should I place the SoC or MFD node? In the switch root node?
> 
> The SoC should be placed on the host MDIO bus. And the Ethernet switch
> component should be a child of the SoC. Ideally, so should be all other
> switch peripherals: on the same level as the Ethernet switch.
>

Ohhhh ok, wasn't clear to me the MFD driver had to be placed in the mdio
node.

To make it clear this would be an implementation.

mdio_bus: mdio-bus {
	#address-cells = <1>;
	#size-cells = <0>;

	...

	mfd@1 {
		compatible = "airoha,an8855-mfd";
		reg = <1>;

		nvmem_node {
			...
		};

		switch_node {
			...
		};
	};
};

Consider tho that recently I faced some problem with such structure with
DT mainatiners asking to keep everything in the MFD node. But lets see
how it goes.

Well aware of the MFD API, (had to have some fun recently) so the only
confusing part was the node placement.

> > Also the big problem is how to model accessing the register with MDIO
> > with an MFD implementation.
> > 
> > Anyway just to make sure the Switch SoC doesn't expose an actualy MDIO
> > bus, that is just to solve the problem with the Switch Address shared
> > with one of the port. (Switch Address can be accessed by every switch
> > port with a specific page set)
> 
> Sorry, I don't understand this, can you explain more? "Switch Address
> can be accessed by every switch port with a specific page set"
> 
> In the code, I see that the priv->bus and priv->phy_base are used to
> perform MDIO accesses for anything related to the switch. That's perfect,
> it means that all switch registers are concentrated on a single MDIO
> address, behind a single mdio_device. If that weren't the case, things
> would get messy, because the Linux device model associates an MDIO device
> with a single address on its bus.
> 
> And then we have an8855_phy_read() and an8855_phy_write(), which in my
> understanding are the ops of a fake MDIO controller, one which has no
> registers or MDIO address space of its own, but is just a passthrough
> towards the host MDIO bus's address space. I have no idea why you don't
> just put a phy-handle from the switch user ports to PHYs located on the
> host MDIO bus directly, and why you go through this middle entity, but I
> expect you will clarify. Creating an MDIO bus from DSA for internal PHYs
> is completely optional if no special handling is required.

The difficulties I found (and maybe is very easy to solve and I'm
missing something here) is that switch and internal PHY port have the
same address and conflicts.

Switch will be at address 1 (or 2 3 4 5... every port can access switch
register with page 0x4)

DSA port 0 will be at address 1, that is already occupied by the switch.

Defining the DSA port node on the host MDIO bus works correctly for
every port but for port 0 (the one at address 1), the kernel complains
and is not init. (as it does conflict with the switch that is at the
same address) (can't remember the exact warning)

> 
> To explain again: In the MFD proposal, there is only one driver who has
> access to the mdio_device from the host bus: the MFD driver. Depending
> on how it implements the regmaps it presents to the children, it can
> control page switching, etc etc. The child devices only operate with
> regmaps, and have no idea of the underlying hardware access method.
> 
> > But yes the problem is there... Function is not implemented but the
> > switch have i2c interface, minimal CPU, GPIO and Timer in it.
> > 
> > Happy to make the required changes, just very confused on how the final
> > DT node structure.
> > 
> > -- 
> > 	Ansuel
> 

-- 
	Ansuel

