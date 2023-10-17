Return-Path: <netdev+bounces-41931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8DC7CC4C6
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1971C2084C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2055243697;
	Tue, 17 Oct 2023 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hd0vtH8x"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0A41743
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 13:31:38 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9CEED;
	Tue, 17 Oct 2023 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5UMBSoXh6IILW9YyX2/MRn867bDMWY7Lg7IduUgaZaU=; b=hd0vtH8xR45nyajazw33Ze8KlG
	Jez7dJNjz6tSR3610P0xEel9vJNlk8LlY4MkixjcLe2fLDbH/bMn2LFTVhyUZLdwrH7tHPr+DnUL1
	Oz0/EY0DblqXTpe+y2szH3+L1tPQv2ROKx6fNkpK9u1n9CpEBwlptcrBqQWhQHYcA79Iwc6vfWE5b
	vh8gJwZmOOAvGzRQwsrCrTd2HoH2QZVifVtbMvPxJh95JolZKkTf/SNC6rh5q645TAyfhpaBOKl7K
	xxsIEGYrj0p8vKYRujFoFFPvOuQSjPmwSvev9BDfdghWqyVmoxiM03Bve0OCLeT9Uz2q1S8+yfv7N
	pYNUifGA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45450)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qskAU-0003JA-2m;
	Tue, 17 Oct 2023 14:31:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qskAU-0006ii-SB; Tue, 17 Oct 2023 14:31:30 +0100
Date: Tue, 17 Oct 2023 14:31:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: mdio-mux: fix C45 access returning -EIO after
 API change
Message-ID: <ZS6Mskpb6gDpBD3z@shell.armlinux.org.uk>
References: <20231017113222.3135895-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017113222.3135895-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 02:32:22PM +0300, Vladimir Oltean wrote:
> The mii_bus API conversion to read_c45() and write_c45() did not cover
> the mdio-mux driver before read() and write() were made C22-only.
> 
> This broke arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso.
> The -EOPNOTSUPP from mdiobus_c45_read() is transformed by
> get_phy_c45_devs_in_pkg() into -EIO, is further propagated to
> of_mdiobus_register() and this makes the mdio-mux driver fail to probe
> the entire child buses, not just the PHYs that cause access errors.
> 
> Fix the regression by introducing special c45 read and write accessors
> to mdio-mux which forward the operation to the parent MDIO bus.
> 
> Fixes: db1a63aed89c ("net: phy: Remove fallback to old C45 method")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/mdio/mdio-mux.c | 45 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/net/mdio/mdio-mux.c b/drivers/net/mdio/mdio-mux.c
> index a881e3523328..7d322c08c1e9 100644
> --- a/drivers/net/mdio/mdio-mux.c
> +++ b/drivers/net/mdio/mdio-mux.c
> @@ -55,6 +55,27 @@ static int mdio_mux_read(struct mii_bus *bus, int phy_id, int regnum)
>  	return r;
>  }
>  
> +static int mdio_mux_read_c45(struct mii_bus *bus, int phy_id, int dev_addr,
> +			     int regnum)
> +{
> +	struct mdio_mux_child_bus *cb = bus->priv;
> +	struct mdio_mux_parent_bus *pb = cb->parent;
> +	int r;
> +
> +	mutex_lock_nested(&pb->mii_bus->mdio_lock, MDIO_MUTEX_MUX);
> +	r = pb->switch_fn(pb->current_child, cb->bus_number, pb->switch_data);
> +	if (r)
> +		goto out;
> +
> +	pb->current_child = cb->bus_number;
> +
> +	r = pb->mii_bus->read_c45(pb->mii_bus, phy_id, dev_addr, regnum);

What if the parent bus doesn't have read_c45 or write_c45 ?

> @@ -173,6 +216,8 @@ int mdio_mux_init(struct device *dev,
>  		cb->mii_bus->parent = dev;
>  		cb->mii_bus->read = mdio_mux_read;
>  		cb->mii_bus->write = mdio_mux_write;
> +		cb->mii_bus->read_c45 = mdio_mux_read_c45;
> +		cb->mii_bus->write_c45 = mdio_mux_write_c45;

Maybe make these conditional on the parent bus implementing the c45
read/write ops?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

