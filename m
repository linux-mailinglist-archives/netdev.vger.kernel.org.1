Return-Path: <netdev+bounces-101093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3658FD453
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98702871CB
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF38213AD25;
	Wed,  5 Jun 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm4Xt4VM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EDF19D8BE;
	Wed,  5 Jun 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717609768; cv=none; b=AT6ecMRWBKK4hDXKg921IOmjR76gZV6ljGLd4Atuk818+AGYfQ0wC01jsCDTekmdSF85XaiHjPHH1sutggKTMP8WTBfPlMQbwivFI4Zz90SQCCsfsJ3zdrmTEaIb92bSUv+ZHbVmB4oDT4FJtd0fbmDP/Fd2hCKEDuRx4L1GR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717609768; c=relaxed/simple;
	bh=FwUaowYM9CbMgAtVVYcQAHzZ74XJ4DqCZ2hH6TrRPps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMpYVeNn6eZD1h0OZXK9a4c+Dx+4ZyV8jwpQYvD20EOcYHEcgRcmqj1ogPWfbeYcxYY05+kz0aZ7Dzt6evo7ZfUAZ9pKlqYvL+vM7XgmZT2MqewBHyUgG+8vG+uS+KG8nUaZgrQqT7BS7rBnA+41FyRC/hX6wIdOT9IUhwtEjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm4Xt4VM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B24C2BD11;
	Wed,  5 Jun 2024 17:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717609768;
	bh=FwUaowYM9CbMgAtVVYcQAHzZ74XJ4DqCZ2hH6TrRPps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rm4Xt4VMCa0Bdg1NIpHXW5I3D+Rfzouxtpn5mhNpaNTLNw1F6TEZNlQtyvqkPDLgV
	 wkUFUnCjuma2YxYaid2dXDDbKEQsOdjZeZRThBRD64FI0onL0YFQd386VJyU7OffVu
	 7MJdEbqLH62CUuHtYol2hXwmf/+5YMMmlH6Rl4UKF4xI0lTpMSAc4pDAEc+jVCjZMq
	 G+LKc2JRIEsgvCcc6I4g3tLCGtuiEXWBePHFfUh8K+PNN1mzKWc/0qQWKbEMaTZN/D
	 F8PNNrD6WolqKuGuq83d4ZqDbajVYLZq7AK5VM1HwEPTROT0EjbiPmPyLMFI0uWL+a
	 ekNTSVMJc04fQ==
Date: Wed, 5 Jun 2024 18:49:20 +0100
From: Simon Horman <horms@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 08/10] net: pcs: xpcs: Add fwnode-based
 descriptor creation method
Message-ID: <20240605174920.GR791188@kernel.org>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-9-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602143636.5839-9-fancer.lancer@gmail.com>

On Sun, Jun 02, 2024 at 05:36:22PM +0300, Serge Semin wrote:
> It's now possible to have the DW XPCS device defined as a standard
> platform device for instance in the platform DT-file. Although that
> functionality is useless unless there is a way to have the device found by
> the client drivers (STMMAC/DW *MAC, NXP SJA1105 Eth Switch, etc). Provide
> such ability by means of the xpcs_create_fwnode() method. It needs to be
> called with the device DW XPCS fwnode instance passed. That node will be
> then used to find the MDIO-device instance in order to create the DW XPCS
> descriptor.
> 
> Note the method semantics and name is similar to what has been recently
> introduced in the Lynx PCS driver.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Hi Serge,

Some minor nits from my side flagged by kernel-doc -none -Wall

...

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c

...

> @@ -1505,6 +1507,16 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev,
>  	return ERR_PTR(ret);
>  }
>  
> +/**
> + * xpcs_create_mdiodev() - create a DW xPCS instance with the MDIO @addr
> + * @bus: pointer to the MDIO-bus descriptor for the device to be looked at
> + * @addr: device MDIO-bus ID
> + * @requested PHY interface

An entry for @interface should go here.

> + *
> + * If successful, returns a pointer to the DW XPCS handle. Otherwise returns
> + * -ENODEV if device couldn't be found on the bus, other negative errno related
> + * to the data allocation and MDIO-bus communications.

Please consider including this information as a Return: section of the
Kernel doc. Likewise for xpcs_create_fwnode().

> + */
>  struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
>  				    phy_interface_t interface)
>  {
> @@ -1529,6 +1541,44 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
>  }
>  EXPORT_SYMBOL_GPL(xpcs_create_mdiodev);
>  
> +/**
> + * xpcs_create_fwnode() - Create a DW xPCS instance from @fwnode
> + * @node: fwnode handle poining to the DW XPCS device

s/@node/@fwnode/

> + * @interface: requested PHY interface
> + *
> + * If successful, returns a pointer to the DW XPCS handle. Otherwise returns
> + * -ENODEV if the fwnode is marked unavailable or device couldn't be found on
> + * the bus, -EPROBE_DEFER if the respective MDIO-device instance couldn't be
> + * found, other negative errno related to the data allocations and MDIO-bus
> + * communications.
> + */
> +struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode,
> +				   phy_interface_t interface)

...

