Return-Path: <netdev+bounces-148915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C98CA9E367C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F04A2831DA
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853411993B5;
	Wed,  4 Dec 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xpd9hEgI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A313DBE5E;
	Wed,  4 Dec 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304300; cv=none; b=k1/uCtn6cvXIC1nmf9HT7CgfC6pTCHycW4tOlAlSZKZyPJQ1MBrnpmbRnQpM4LKcnbNTAJR6anVvHAMcekwX56n+O7i2WuwK4GLbmVBQAc6/ctikdOhQD5aoK1t7LelnHT+LT5cL/My+WUFgInc/0r1RKpnYfEkXSsPxe98PyoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304300; c=relaxed/simple;
	bh=Z1ep7hZwDhdPbX5EmgjX6VI1qGLY8Zy9ALNVZJHmgBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEoC5NrQ3oU2smD2iDt5couNUGcfIIkZTLSikcZ2fQaozVGtv2WcZ/qAZSUeRcOD8v9Wol3nXGF1Ks5oPnYnQtpR02iGTtPjV/t/bj76wSQYzJG43tSxiuCSCqSbn4Xf+kopnTZ3pBLgBjMt+QEsm+e+E/qasYrJguteABl3Sjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xpd9hEgI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Cy/XJ04+zf5LbxiN66hAMvCUA3gWid9DTtZSOXqwwIw=; b=xpd9hEgI7XauUdJTL4JW/stQ64
	5V8Pt/IwwETi+P6/XqImUjn6tmDH8mGrBM985xtQ0aL16sW0E0Ru1UccmYSx6CKH5cwUqFK7UtYe3
	JWCUBmQ//Q3GNNP7zTe01I3eGt7LjayInwDb9h36o+UVftNZBBNcOBQS5gZWbgspf8NXQY4RJMZTU
	JgcOVNWPpXqyJx4Ro8XpKpq8oxtM0voPZg14xD8GmvqA6BpS/A95hKQhTFAxlSmeYk2fm3WNJrg7b
	1qrRt0H20hDOM1QQxFrK0GW/9OOxiKsx7LyQBpP2n+hqgUtJrDH8HAinYxqQhkk+Wb4D438hcK49/
	oFd3awpw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43590)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tIlcl-00032d-0T;
	Wed, 04 Dec 2024 09:24:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tIlcj-0005RX-2j;
	Wed, 04 Dec 2024 09:24:45 +0000
Date: Wed, 4 Dec 2024 09:24:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <Z1Af3YaN3xjq_Gtb@shell.armlinux.org.uk>
References: <20241204072427.17778-1-ansuelsmth@gmail.com>
 <20241204072427.17778-4-ansuelsmth@gmail.com>
 <20241204100922.0af25d7e@fedora.home>
 <67501d7b.050a0220.3390ac.353c@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67501d7b.050a0220.3390ac.353c@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 04, 2024 at 10:14:31AM +0100, Christian Marangi wrote:
> On Wed, Dec 04, 2024 at 10:09:22AM +0100, Maxime Chevallier wrote:
> > > +	case 5:
> > > +		phy_interface_set_rgmii(config->supported_interfaces);
> > > +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> > > +			  config->supported_interfaces);
> > > +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> > > +			  config->supported_interfaces);
> > > +		break;
> > > +	}
> > > +
> > > +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> > > +				   MAC_10 | MAC_100 | MAC_1000FD;
> > 
> > For port 5, you may also add the MAC_2500FD capability as it supports
> > 2500BASEX ?
> > 
> 
> I didn't account for the CPU port that runs at 2.5. The LAN port are
> only 1g. Will add or maybe add the 2500FD only for cpu port?
> 
> Maybe Russel can help in this?

*ll* please.

Well, 2500BASE-X runs at 2.5G, so if MAC_2500FD isn't set in the mask,
validation will fail for 2500BASE-X.

> > > +		case SPEED_5000:
> > > +			reg |= AN8855_PMCR_FORCE_SPEED_5000;
> > > +			break;
> > 
> > There's no mention of any mode that can give support for the 5000Mbps
> > speed, is it a leftover from previous work on the driver ?
> > 
> 
> Added 5000 as this is present in documentation bits but CPU can only go
> up to 2.5. Should I drop it? Idea was to futureproof it since it really
> seems they added these bits with the intention of having a newer switch
> with more advanced ports.

Is there any mention of supporting interfaces faster than 2500BASE-X ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

