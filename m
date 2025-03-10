Return-Path: <netdev+bounces-173395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90867A58A15
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 02:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCED81672FD
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 01:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2A37B3E1;
	Mon, 10 Mar 2025 01:32:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB9C11CBA;
	Mon, 10 Mar 2025 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741570341; cv=none; b=p+C/TerL1NKNhqn1M7E7gETT2Hs14lZMeNko6gz1lOUqVuvhIPKr9+2O6uML24Dmr/CwOaNkuUy/PBcAa1t/860AaS3o/EZLHsap1TqBvvTCc43fk4zLWcT85UAfFbgQ9tgKpSE+aRDGAWcMvpuEHLzT6olLATuFU2/SEhHPl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741570341; c=relaxed/simple;
	bh=K0VE+sJrY0WaN2KfS6hpRMlDZ2kaL50SG92UpBHuuZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo2eQy6p27N+vR6Shmu+AztXIYfiUNMEQ1VtaC2IPsJ++H/Tws6B3S24YaWpDQTKA+25idApD+EQnschfbxO4+IFep0LlPhj9lhxgHmhDZppp0QqojbU4kGX3yDoek6c3woa8aA8k6HNK+loGzOiF67BXgz7QDK8eTeVZr5IvRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1trRzl-000000003B6-3CoK;
	Mon, 10 Mar 2025 01:31:53 +0000
Date: Mon, 10 Mar 2025 01:31:35 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, sander@svanheule.net, markus.stockhausen@gmx.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9] net: mdio: Add RTL9300 MDIO driver
Message-ID: <Z85A9_Li_4n9vcEG@pidgin.makrotopia.org>
References: <20250309232536.19141-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309232536.19141-1-chris.packham@alliedtelesis.co.nz>

Hi Chris,

On Mon, Mar 10, 2025 at 12:25:36PM +1300, Chris Packham wrote:
> Add a driver for the MDIO controller on the RTL9300 family of Ethernet
> switches with integrated SoC. There are 4 physical SMI interfaces on the
> RTL9300 however access is done using the switch ports. The driver takes
> the MDIO bus hierarchy from the DTS and uses this to configure the
> switch ports so they are associated with the correct PHY. This mapping
> is also used when dealing with software requests from phylib.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---

> ...
> +static int rtl9300_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
> +{
> +	struct rtl9300_mdio_chan *chan = bus->priv;
> +	struct rtl9300_mdio_priv *priv;
> +	struct regmap *regmap;
> +	int port;
> +	u32 val;
> +	int err;
> +
> +	priv = chan->priv;
> +	regmap = priv->regmap;
> +
> +	port = rtl9300_mdio_phy_to_port(bus, phy_id);
> +	if (port < 0)
> +		return port;
> +
> +	mutex_lock(&priv->lock);
> +	err = rtl9300_mdio_wait_ready(priv);
> +	if (err)
> +		goto out_err;
> +
> +	err = regmap_write(regmap, SMI_ACCESS_PHY_CTRL_2, FIELD_PREP(PHY_CTRL_INDATA, port));
> +	if (err)
> +		goto out_err;
> +
> +	val = FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
> +	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
> +	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, 0xfff) |
> +	      PHY_CTRL_READ | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;

Using "raw" access to the PHY and thereby bypassing the MDIO
controller's support for hardware-assisted page access is problematic.
The MDIO controller also polls all PHYs status in hardware and hence
be aware of the currently selected page. Using raw access to switch
the page of a PHY "behind the back" of the hardware polling mechanism
results in in occassional havoc on link status changes in case Linux'
reading the phy status overlaps with the hardware polling.
This is esp. when using RealTek's 2.5GBit/s PHYs which require using
paged access in their read_status() function.

Markus Stockhausen (already in Cc) has implemented a nice solution to
this problem, including documentation, see
https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/realtek/files-6.6/drivers/net/ethernet/rtl838x_eth.c;h=4b79090696e341ed1e432a7ec5c0f7f92776f0e1;hb=HEAD#l1631

Including a similar mechanism in this driver for C22 read and write
operations would be my advise, so hardware-assisted access to the PHY
pages is always used, and hence the hardware polling mechanism is aware
of the currently selected page.

Other than that the driver looks really good now, and will allow using
existing RealTek PHY drivers independently of whether they are used with
RealTek's switch SoCs or with non-RealTek systems -- this has always
been a big issue with OpenWrt's current implementation and I look
forward to use this driver instead asap ;)


