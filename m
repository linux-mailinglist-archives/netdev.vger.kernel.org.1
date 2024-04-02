Return-Path: <netdev+bounces-84022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05B8895568
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D09A1C20F1F
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69E683CB8;
	Tue,  2 Apr 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IHPCaquH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5A960B96
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064710; cv=none; b=bUSJJBebG6XKAMI/LUlN4tyUWuX0bQOl4SAHVBRjoyCL/GjQvIPeMecUiHYLaGB0Qe4u5cP+i0EQNwGRER2JPxA1EgBHlRh1AJW5N85399sCStyaWawten06HEWzlKQj6ERmTkoRPv+WyKk66TTNdlGkkhWDd9SuwfPFyuOyVaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064710; c=relaxed/simple;
	bh=FkJWSeFrHHNU8ZJGF36MFsyAMjsxBufarNGtN2k4+cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffnAbAtZHKreUUjbC2nnU8aoDASPHxMCNQFFYhnmCj143LBL/bgtTmjaq+gYQu03rGc0hp2lfRbMg3SVFsF66Oz5Z6k2aI2orNo1dy7wov4/VEi/y7cQmyk3KH7nILwHs/5ZIq/abS/ufdOi7QSkC/yXNPZ/IZgA4rFYqpea6b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IHPCaquH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bu4Xh24fb/o5+r+GHF1CQx8gl9GRGMS15plEnXkGgwM=; b=IHPCaquHt+qEIj78bvm91twt5l
	8dI084x/6chCnik8Gm72S7ivvq1fRfr82I+cR0CpxE/Soi6dQxmGpdSpHokcPzpH+P8lsD56HPai1
	ye3V6XkJ9SLXQYFjxM3yB4GIpRIoBrpKZFejdhnwyl0Wa1eGIu/tPCaanj5hPh9BRUuY6PNpv4aHE
	/2/wCqZ9+sFT1DSD0NnhDpXQp7PmWcfVJvW2qcBFas9szlCiNJRk+XEQw1QgVF8MJ9F5jjchkc8Py
	F5zL6fCb5ZOLMcL4+wJ83j7Vr/pe+gDzbKjxADOiS4FkNx/vwjS3RmqCofCr1+oyYXnLbL2K7jleH
	vLcwax0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54560)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rreEi-0006lL-0z;
	Tue, 02 Apr 2024 14:31:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rreEg-0006zB-Iq; Tue, 02 Apr 2024 14:31:34 +0100
Date: Tue, 2 Apr 2024 14:31:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/7] net: dsa: Add helpers to convert netdev
 to ds or port index
Message-ID: <ZgwItu4gETdLbHWi@shell.armlinux.org.uk>
References: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
 <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-5-221b3fa55f78@lunn.ch>
 <20240402105652.mrweu2rnend3n3tf@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402105652.mrweu2rnend3n3tf@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 02, 2024 at 01:56:52PM +0300, Vladimir Oltean wrote:
> On Mon, Apr 01, 2024 at 08:35:50AM -0500, Andrew Lunn wrote:
> > The LED helpers make use of a struct netdev. Add helpers a DSA driver
> > can use to convert a netdev to a struct dsa_switch and the port index.
> > 
> > To do this, dsa_user_to_port() has to be made available out side of
> > net/dev, to convert the inline function in net/dsa/user.h into a
> > normal function, and export it.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> 
> I think the API we have today is sufficient: we have dsa_port_to_netdev(),
> introduced at Vivien's request rather than exporting dsa_user_to_port().
> 
> Also, I believe that having a single API function which returns a single
> struct dsa_port *, from which we force the caller to get the dp->ds and
> dp->index, is better (cheaper) than requiring 2 API functions, one for
> getting the ds and the other for the index.

Yes, I would tend to agree having done this for my experimental phylink
changes. struct dsa_port seems to make the most sense:

static inline struct dsa_port *
dsa_phylink_to_port(struct phylink_config *config)
{
        return container_of(config, struct dsa_port, pl_config);
}

which then means e.g.:

static void mv88e6xxx_mac_config(struct phylink_config *config,
                                 unsigned int mode,
                                 const struct phylink_link_state *state)
{
        struct dsa_port *dp = dsa_phylink_to_port(config);
        struct mv88e6xxx_chip *chip = dp->ds->priv;
        int port = dp->index;
        int err = 0;

        mv88e6xxx_reg_lock(chip);

        if (mode != MLO_AN_PHY || !mv88e6xxx_phy_is_internal(chip, port)) {
                err = mv88e6xxx_port_config_interface(chip, port,
                                                      state->interface);
                if (err && err != -EOPNOTSUPP)
                        goto err_unlock;
        }

err_unlock:
        mv88e6xxx_reg_unlock(chip);

        if (err && err != -EOPNOTSUPP)
                dev_err(dp->ds->dev, "p%d: failed to configure MAC/PCS\n",
                        port);
}

vs the current code:

static void mv88e6xxx_mac_config(struct dsa_switch *ds, int port,
                                 unsigned int mode,
                                 const struct phylink_link_state *state)
{
        struct mv88e6xxx_chip *chip = ds->priv;
        int err = 0;

        mv88e6xxx_reg_lock(chip);

        if (mode != MLO_AN_PHY || !mv88e6xxx_phy_is_internal(chip, port)) {
                err = mv88e6xxx_port_config_interface(chip, port,
                                                      state->interface);
                if (err && err != -EOPNOTSUPP)
                        goto err_unlock;
        }

err_unlock:
        mv88e6xxx_reg_unlock(chip);

        if (err && err != -EOPNOTSUPP)
                dev_err(ds->dev, "p%d: failed to configure MAC/PCS\n", port);
}

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

