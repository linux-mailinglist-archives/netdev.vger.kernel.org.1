Return-Path: <netdev+bounces-20034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF5F75D6CA
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 23:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395491C217AB
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB32C100A5;
	Fri, 21 Jul 2023 21:58:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA37227F12
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 21:58:11 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B26E65;
	Fri, 21 Jul 2023 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3UeAOx0ajpTlT5WCtehLjoDaH5qdKZhHVF9hjtMO+no=; b=rCNQ/SMAUMJ9GQxyqAdU0wXO0L
	meIKipc28uNzSrk8grgu3HGM92qy+K/WaLhHJerxzxArqOurBaENiA61zkCA3l5N2XyuOvLU+lE2M
	93A7YnEyLPqebJrMqWltQDJ02wGkr/bsNx73kqbPATEJ8PfrL4dcQaaho/pShFpYna+s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qMy8B-001uIp-P8; Fri, 21 Jul 2023 23:57:47 +0200
Date: Fri, 21 Jul 2023 23:57:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: nick.hawkins@hpe.com
Cc: verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/5] net: hpe: Add GXP UMAC MDIO
Message-ID: <64a33933-cdf7-4cc1-9a77-5bbdc925fdff@lunn.ch>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
 <20230721212044.59666-3-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721212044.59666-3-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>  drivers/net/ethernet/hpe/gxp-umac-mdio.c | 158 +++++++++++++++++++++++

This looks to be a standalone MDIO driver. So please move it into
drivers/net/mdio.

> +config NET_VENDOR_HPE
> +	bool "HPE device"
> +	default y
> +	depends on ARCH_HPE

Please add || COMPILE_TEST


> +	help
> +	  Say y here to support the HPE network devices.
> +	  The GXP contains two Ethernet MACs that can be
> +	  connected externally to several physical devices.
> +	  From an external interface perspective the BMC
> +	  provides two SERDES interface connections capable
> +	  of either SGMII or 1000Base-X operation. The BMC
> +	  also provides a RMII interface for sideband
> +	  connections to external Ethernet controllers.
> +
> +if NET_VENDOR_HPE
> +
> +config GXP_UMAC_MDIO
> +	tristate "GXP UMAC mdio support"
> +	depends on ARCH_HPE

You probably also need

        depends on OF_MDIO && HAS_IOMEM
        depends on MDIO_DEVRES

> +static int umac_mdio_read(struct mii_bus *bus, int phy_id, int reg)
> +{
> +	struct umac_mdio_priv *umac_mdio = bus->priv;
> +	unsigned int value;
> +	unsigned int status;
> +	int ret;

Networking uses reverse christmas tree. Please sort these longest to
shorted.

...

> +	ret = readl_poll_timeout(umac_mdio->base + UMAC_MII, status,
> +				 !(status & UMAC_MII_MOWNER), 1000, 100000);
> +	if (ret) {
> +		dev_err(bus->parent, "mdio read time out\n");
> +		return -ETIMEDOUT;

return ret;

Don't transform error codes.

> +static int umac_mdio_write(struct mii_bus *bus, int phy_id, int reg, u16 value)
> +{
> +	struct umac_mdio_priv *umac_mdio = bus->priv;
> +	unsigned int status;
> +	int ret;
> +	ret = readl_poll_timeout(umac_mdio->base + UMAC_MII, status,
> +				 !(status & UMAC_MII_MOWNER), 1000, 100000);
> +	if (ret) {
> +		dev_err(bus->parent, "mdio read time out\n");
> +		return -ETIMEDOUT;
> +	}

You can simplify this, do a dev_err() inside an if, and then
unconditionally return ret;

> +static int umac_mdio_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct mii_bus *bus;
> +	struct umac_mdio_priv *umac_mdio;
> +
> +	int ret;


More sorting needed.

And no blank lines please.

    Andrew

