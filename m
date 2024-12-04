Return-Path: <netdev+bounces-148914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402BE9E3661
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B350168739
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC5E19F101;
	Wed,  4 Dec 2024 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ozygJ8nt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4718B492;
	Wed,  4 Dec 2024 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304138; cv=none; b=OkS7k1Z7hknHo6na0t3Bb+AlsL8TS0V0C1pZftauEziNAOFYv6rANgI9JyBIvC25AkGsMSDUDEP8DH3l5dv906tClJFkyIfX9sQgbm7SvsxY+Y/VmfCGaM89fgPVe+C/CNVdh4MFYUG8jhDy7Mo8UuoTJIz/rnC1rkrgVl6fpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304138; c=relaxed/simple;
	bh=tCPngtc7SMUyyVmnCa62NzA0sUhIzah1p8uOADYYzs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9CeVkpFM3fMMzWzvL77eWWErE9VAVWlaXL8dE9cBb025zSCsR4zNTLpQdOtz75ok2FvdmeVYjBJ8amqfuIY7SKj3Dbov5//98hmqiSYBvBpXFbVcqJpsiB6Gbl/E4b8U6koLSH9Tbeyw9/cADCFHxOD4aUMrnqxBw3oFPIxA9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ozygJ8nt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=okVu3EWXg5ZKgPN58NmG9R0ASPajE8msC4O7SNVEAX8=; b=ozygJ8ntGUL2SuY2qeYJa4D8Sl
	PmSm3PgpmrT5v3mdT5RnXi7jA9UdSVRzNj12RyGvlCRDyReEGiHIrj6tlriwes83yo/sqThAPQo9J
	kRajDoRSL/ASBxwZikwhXxH3eaXoG6LxgzWC6OqX8XhIutXgJ+E+yhDA4HR8uRYJyu7wY8axE4jJ2
	oJNsznRYJkizcFYZngvCji3vFeeHVqZRrO05MXOcc8zj+m6wwapZMvZtvH66ZLU+DchaAKbs6mMEj
	BVn6LLjmBXvtwxiO0FfXpV/JlNefpt5wfLxfcljxDXJKq73oFp86UMiTm42ptTMSBwUkvb37KBW/B
	xEo99K7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41554)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tIla3-00032D-0w;
	Wed, 04 Dec 2024 09:21:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tIlZz-0005RO-1q;
	Wed, 04 Dec 2024 09:21:55 +0000
Date: Wed, 4 Dec 2024 09:21:55 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v8 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <Z1AfM5PzlTN19hF3@shell.armlinux.org.uk>
References: <20241204072427.17778-1-ansuelsmth@gmail.com>
 <20241204072427.17778-4-ansuelsmth@gmail.com>
 <20241204100922.0af25d7e@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204100922.0af25d7e@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 04, 2024 at 10:09:22AM +0100, Maxime Chevallier wrote:
> Hello Christian,
> 
> On Wed,  4 Dec 2024 08:24:10 +0100
> Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > +static void
> > +an8855_phylink_mac_config(struct phylink_config *config, unsigned int mode,
> > +			  const struct phylink_link_state *state)
> > +{
> > +	struct dsa_port *dp = dsa_phylink_to_port(config);
> > +	struct dsa_switch *ds = dp->ds;
> > +	struct an8855_priv *priv;
> > +	int port = dp->index;
> > +
> > +	priv = ds->priv;
> > +
> > +	if (port != 5) {
> > +		if (port > 5)
> > +			dev_err(ds->dev, "unsupported port: %d", port);
> > +		return;
> > +	}
> 
> Looks like the above condition can be simplified to :
> 
> 	if (port > 5)
> 		dev_err(...);

Not quite, since if port is 0..4, the function returns at this point.
If >5, then it prints an error and returns. So:

	if (port > 5)
		dev_err(...);
	if (port != 5)
		return;

However, net/dsa/dsa.c::dsa_switch_parse_ports_of() already validates
that the port number will not exceed ds->num_ports, so if that is set
appropriately, the phylink functions will never be called with a port
number larger than this, and checking it is redundant.

So I think this should just be:

	if (port != 5)
		return;

> > +	case 5:
> > +		phy_interface_set_rgmii(config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> > +			  config->supported_interfaces);
> > +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> > +			  config->supported_interfaces);
> > +		break;
> > +	}
> > +
> > +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > +				   MAC_10 | MAC_100 | MAC_1000FD;
> 
> For port 5, you may also add the MAC_2500FD capability as it supports
> 2500BASEX ?

Agreed, that's needed.

> > +		case SPEED_5000:
> > +			reg |= AN8855_PMCR_FORCE_SPEED_5000;
> > +			break;
> 
> There's no mention of any mode that can give support for the 5000Mbps
> speed, is it a leftover from previous work on the driver ?

Or maybe it's because 5GBASE-R wasn't a phy interface type when the
driver was originally developed (iirc it's a relatively recent
addition.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

