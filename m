Return-Path: <netdev+bounces-196656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0DFAD5B8B
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB5D3A52BA
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FC61E47BA;
	Wed, 11 Jun 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nHNSOBGb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C2A1A725A;
	Wed, 11 Jun 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658398; cv=none; b=HbwHRjvUm0Yo9NlUBNX7uYih8uhM03vnUWS2QNA2OzgeudM44I3U41QGlVoeSj2wfbwI9ig8trY3daP5jMm6jlwrkYcAF96rBNPnxuXJPClWY0IQMunHBTjKqcgy4D0iaTtHtEv2cejdiJVs3isPjlgWWJ6lFrjJoLzeg1WFAEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658398; c=relaxed/simple;
	bh=ADdy1oX/BGm/0yfMjA6C1xUCsUR3Il5JAfLEmSkSbpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4RWi2Z3AQDin3Y3WhNc//ErMqa5aduA+ZS4RoUPx3kI+vlG0Ferz0yPzip5EAHdTEtY+uiSCGfwcU0JwMebn73Z8cnL0YimqCOjdEKAe52ANz22t6ojCjY+SVSLSir8L7VHcPZDbmbfcNViqgBHQIeLINCzzv2S8kFptvNkQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nHNSOBGb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5Pah9/CBtffo+lrIVkKDlsrLYUZHo+PGjMuqf3Dti3w=; b=nHNSOBGbRNP8l8/sOdiLU3RC5W
	7oIdZKQsC3Yyg5Nz4H1AsjKFQSG3miVUFKAYqSkGkVKLxk6roKXNElCQHyV3Q91pTENKucD11UZcX
	zfZoyNJ4Cl0yj+fZJaNFXs0pDjXUuAFYQhvO9hovm+8deePxRYep9qk7Y/OlwVxg6auM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uPO4S-00FQMS-G7; Wed, 11 Jun 2025 18:13:00 +0200
Date: Wed, 11 Jun 2025 18:13:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: mdio-mux: Add MDIO mux driver for
 Sophgo CV1800 SoCs
Message-ID: <eb419ffa-055f-48db-8c6a-60bf240fbb9d@lunn.ch>
References: <20250611080228.1166090-1-inochiama@gmail.com>
 <20250611080228.1166090-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611080228.1166090-3-inochiama@gmail.com>

On Wed, Jun 11, 2025 at 04:02:00PM +0800, Inochi Amaoto wrote:
> Add device driver for the mux driver for Sophgo CV18XX/SG200X
> series SoCs.
> 
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sophgo CV1800 MDIO multiplexer driver
> + *
> + * Copyright (C) 2025 Inochi Amaoto <inochiama@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/mdio-mux.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define EPHY_PAGE_SELECT		0x07c
> +#define EPHY_CTRL			0x800
> +#define EPHY_REG_SELECT			0x804
> +
> +#define EPHY_PAGE_SELECT_SRC		GENMASK(12, 8)
> +
> +#define EPHY_CTRL_ANALOG_SHUTDOWN	BIT(0)
> +#define EPHY_CTRL_USE_EXTPHY		BIT(7)
> +#define EPHY_CTRL_PHYMODE		BIT(8)
> +#define EPHY_CTRL_PHYMODE_SMI_RMII	1
> +#define EPHY_CTRL_EXTPHY_ID		GENMASK(15, 11)

There are a lot of defines here which are not used, but as far as i
see, there is one 8bit register, where bit 7 controls the mux.

It looks like you can throw this driver away and just use
mdio-mux-mmioreg.c. This is from the binding documentation with a few
tweaks:

   mdio-mux@3009000 {
        compatible = "mdio-mux-mmioreg", "mdio-mux";
        mdio-parent-bus = <&xmdio0>;
        #address-cells = <1>;
        #size-cells = <0>;
        reg = <0x3009000 1>;
        mux-mask = <128>;

        mdio@0 {
            reg = <0>;
            #address-cells = <1>;
            #size-cells = <0>;

            phy_xgmii_slot1: ethernet-phy@4 {
                compatible = "ethernet-phy-ieee802.3-c45";
                reg = <4>;
            };
        };

        mdio@128 {
            reg = <128>;
            #address-cells = <1>;
            #size-cells = <0>;

            ethernet-phy@4 {
                compatible = "ethernet-phy-ieee802.3-c45";
                reg = <4>;
            };
        };
    };

    Andrew

