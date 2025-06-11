Return-Path: <netdev+bounces-196412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659EDAD4A4A
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 07:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1A1179F1E
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 05:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039E521FF45;
	Wed, 11 Jun 2025 05:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bmw3YhiK"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0938F5B;
	Wed, 11 Jun 2025 05:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618688; cv=none; b=AeY2DbzlH5wle0klKAe2Qma736ObSA01mD3TNacWHM8TxQG9yekA23tgxqQYI0oS6U6IDCEiWDXR47eucRHLhtgG7cqfSDpv76W51mqH9Wu0BLqYJPnEAW1F62kKo1iTb618v/52W8URUq4jhjRu4WlR7GtqJDGFe3W/WRzEJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618688; c=relaxed/simple;
	bh=RM5CpY0Enw/hyyNlyClEDl4qkSL++OqhZn2e9P/mW84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXiDJG8bhglJLkxy4E43XNWHTHo86nNzL8FmWPt40h452FZDWoc4mpyEgSOCT2CrG6RbdSzaK1/gBLmGbbrMn2LdmhEoUDRZXSHOdwp9LCnTf9XPVxVyDHD8CsBgkIqJFDuhu6HUo3CHXgzob1dIry0ImoyFglcMvTkyILTixvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bmw3YhiK; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD38C43B0F;
	Wed, 11 Jun 2025 05:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749618677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DoYbi3JELt9emY7SA7bGng9kPhfQuex7MkdinZ5Sc+4=;
	b=Bmw3YhiKxOb3FffWRz1dwPZ6w587I+OLRgWmx4cZDpJz7xFfOSSdn3e+4WhHC4GsFAF9g4
	pS7KaubaItkavkYVFNOArnEz8Wo7HvHADyDMdGtoJtWgCd2xbpSeBLBh5h40J/kRvLqHiI
	istm7ikbbTOK1RHnWuqPCJ/qnoSLo5klrleLUAqMAQincYEvi3pubEtDWZtHRcw0HgEvN5
	fskxm0hsz2HYtfpJ6oWwDa++w9OllXw2yYqz38T87aNa+T0SmHhgXqoHsu+/gyjrr3iR64
	Wry1A2WXf4ltsDkdhoP7u8kpkIcvd82zQGeYcJOjpEuycaDnCJ+8gxh9qtV+4w==
Date: Wed, 11 Jun 2025 07:11:14 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org, Kory
 Maincent <kory.maincent@bootlin.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Horman <horms@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Lei Wei <quic_leiwei@quicinc.com>, Michal Simek <michal.simek@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Robert Hancock
 <robert.hancock@calian.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next PATCH v6 06/10] net: pcs: Add Xilinx PCS driver
Message-ID: <20250611071114.325fb630@fedora.home>
In-Reply-To: <20250610233134.3588011-7-sean.anderson@linux.dev>
References: <20250610233134.3588011-1-sean.anderson@linux.dev>
	<20250610233134.3588011-7-sean.anderson@linux.dev>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehsvggrnhdrrghnuggvrhhsohhnsehlihhnuhigrdguvghvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvhesl
 hhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhk
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Sean,

I only 

On Tue, 10 Jun 2025 19:31:30 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> This adds support for the Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII device.
> This is a soft device which converts between GMII and either SGMII,
> 1000Base-X, or 2500Base-X. If configured correctly, it can also switch
> between SGMII and 1000BASE-X at runtime. Thoretically this is also possible
> for 2500Base-X, but that requires reconfiguring the serdes. The exact
> capabilities depend on synthesis parameters, so they are read from the
> devicetree.
> 
> This device has a c22-compliant PHY interface, so for the most part we can
> just use the phylink helpers. This device supports an interrupt which is
> triggered on autonegotiation completion. I'm not sure how useful this is,
> since we can never detect a link down (in the PCS).
> 
> This device supports sharing some logic between different implementations
> of the device. In this case, one device contains the "shared logic" and the
> clocks are connected to other devices. To coordinate this, one device
> registers a clock that the other devices can request.  The clock is enabled
> in the probe function by releasing the device from reset. There are no othe
> software controls, so the clock ops are empty.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v6:
> - Move axienet_pcs_fixup to AXI Ethernet commit
> - Use an empty statement for next label
> 
> Changes in v5:
> - Export get_phy_c22_id when it is used
> - Expose bind attributes, since there is no issue in doing so
> - Use MDIO_BUS instead of MDIO_DEVICE
> 
> Changes in v4:
> - Re-add documentation for axienet_xilinx_pcs_get that was accidentally
>   removed
> 
> Changes in v3:
> - Adjust axienet_xilinx_pcs_get for changes to pcs_find_fwnode API
> - Call devm_pcs_register instead of devm_pcs_register_provider
> 
> Changes in v2:
> - Add support for #pcs-cells
> - Change compatible to just xlnx,pcs
> - Drop PCS_ALTERA_TSE which was accidentally added while rebasing
> - Rework xilinx_pcs_validate to just clear out half-duplex modes instead
>   of constraining modes based on the interface.
> 
>  MAINTAINERS                  |   6 +
>  drivers/net/pcs/Kconfig      |  22 ++
>  drivers/net/pcs/Makefile     |   2 +
>  drivers/net/pcs/pcs-xilinx.c | 427 +++++++++++++++++++++++++++++++++++
>  drivers/net/phy/phy_device.c |   3 +-
>  include/linux/phy.h          |   1 +
>  6 files changed, 460 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/pcs/pcs-xilinx.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0ac6ba5c40cb..496513837921 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27060,6 +27060,12 @@ L:	netdev@vger.kernel.org
>  S:	Orphan
>  F:	drivers/net/ethernet/xilinx/ll_temac*
>  
> +XILINX PCS DRIVER
> +M:	Sean Anderson <sean.anderson@linux.dev>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/net/xilinx,pcs.yaml
> +F:	drivers/net/pcs/pcs-xilinx.c
> +
>  XILINX PWM DRIVER
>  M:	Sean Anderson <sean.anderson@seco.com>
>  S:	Maintained
> diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
> index f42839a0c332..e0223914362b 100644
> --- a/drivers/net/pcs/Kconfig
> +++ b/drivers/net/pcs/Kconfig
> @@ -52,4 +52,26 @@ config PCS_RZN1_MIIC
>  	  on RZ/N1 SoCs. This PCS converts MII to RMII/RGMII or can be set in
>  	  pass-through mode for MII.
>  
> +config PCS_XILINX
> +	tristate "Xilinx PCS driver"
> +	default XILINX_AXI_EMAC
> +	select COMMON_CLK
> +	select GPIOLIB
> +	select MDIO_BUS
> +	select OF
> +	select PCS
> +	select PHYLINK
> +	help
> +	  PCS driver for the Xilinx 1G/2.5G Ethernet PCS/PMA or SGMII device.
> +	  This device can either act as a PCS+PMA for 1000BASE-X or 2500BASE-X,
> +	  or as a GMII-to-SGMII bridge. It can also switch between 1000BASE-X
> +	  and SGMII dynamically if configured correctly when synthesized.
> +	  Typical applications use this device on an FPGA connected to a GEM or
> +	  TEMAC on the GMII side. The other side is typically connected to
> +	  on-device gigabit transceivers, off-device SERDES devices using TBI,
> +	  or LVDS IO resources directly.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pcs-xilinx.
> +
>  endmenu
> diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
> index 35e3324fc26e..347afd91f034 100644
> --- a/drivers/net/pcs/Makefile
> +++ b/drivers/net/pcs/Makefile
> @@ -10,3 +10,5 @@ obj-$(CONFIG_PCS_XPCS)		+= pcs_xpcs.o
>  obj-$(CONFIG_PCS_LYNX)		+= pcs-lynx.o
>  obj-$(CONFIG_PCS_MTK_LYNXI)	+= pcs-mtk-lynxi.o
>  obj-$(CONFIG_PCS_RZN1_MIIC)	+= pcs-rzn1-miic.o
> +obj-$(CONFIG_PCS_ALTERA_TSE)	+= pcs-altera-tse.o

There's something strange going-on here, as pcs-altera-tse was removed
in v6.4 :)

> +obj-$(CONFIG_PCS_XILINX)	+= pcs-xilinx.o

Maxime

