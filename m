Return-Path: <netdev+bounces-100502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C998FAECE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3321C21234
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A292E143C70;
	Tue,  4 Jun 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dxHUTOg0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2828143C64;
	Tue,  4 Jun 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493430; cv=none; b=XimmdBO87AfdNWgFEcSYsejk7A2XTVa+kvDWD6L74XPbIeIOH14H3wf1w6spY2OdGsrJjuZNTG6xIpn8+uESNBjBQ45EvM8J3gNMaTRvnY7eQ1jLTPLPfXyPRp3USb6LBqTlTJYPr7Dh6i+kRIc6pkog5cue2UnHTm1y14yVVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493430; c=relaxed/simple;
	bh=hWAo4QYNiSwpEk0zOaWt5KaOgt7K7mWrytT/+CIK6x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZis9/L551StW/48LFIDGWhxdrAgYIFaBgE8s+DzzMZlRsUVpfgRo+8c3AWK3E38yxoR8QhMoF/YkdTUYNSuH9cWgeLyCvqoELR7XvUaopX7BseAT7k0lfELqPzZEoDOJkHNPGuKPQ7juKj9dNayp5v/aHfDxYjcC5GLsTrVsCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dxHUTOg0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cJHyOTgW8f0pN+pCyR+4SzbNPLvRm+LG1KsjKfxQdzA=; b=dxHUTOg0VSgGtqy42SOW3p4CjT
	xELElaKATDvZn+4zAtgTGWkoldejd08xOyaxJnIVgQrlu8tIkMwvMKusSfH5yaJYR4ZwGpBBf0FAH
	Xx/+52i5aucCmHzD3vNYfLHSBr2DBCkYJIuir2Iwup7LzHLfVGH81x0O+yMQM31E70ybtpqcPgQON
	KD8qUlExo9NOnB0TWy+Gtj+/o4Pz3Vr1bM4mLE8d7amME2uyD9EiHLAXZ53LXPwxzJXRx79T3XBh6
	VSNb3uuDcU9x+wM7+4GuK80w2hl5VMkilDZjm7QoOCZ4b05S10EOXS1E6XXblqfHNMGb24x/u1VUh
	KiaYStGQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49244)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sEQUD-0003hA-0U;
	Tue, 04 Jun 2024 10:29:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sEQU9-0001IS-3H; Tue, 04 Jun 2024 10:29:41 +0100
Date: Tue, 4 Jun 2024 10:29:40 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
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
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 10/10] net: stmmac: Add DW XPCS specified via
 "pcs-handle" support
Message-ID: <Zl7ehKqLlzTUQIJG@shell.armlinux.org.uk>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-11-fancer.lancer@gmail.com>
 <2lpomvxhmh7bxqhkuexukztwzjfblulobepmnc4g4us7leldgp@o3a3zgnpua2a>
 <Zl2G+gK8qpBjGpb3@shell.armlinux.org.uk>
 <equlcrx6dgdtrmrlnxxhdunpghw46sjcyn5z6m6lszyiddbag4@eo6oeotzsxef>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <equlcrx6dgdtrmrlnxxhdunpghw46sjcyn5z6m6lszyiddbag4@eo6oeotzsxef>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jun 04, 2024 at 12:04:57PM +0300, Serge Semin wrote:
> On Mon, Jun 03, 2024 at 10:03:54AM +0100, Russell King (Oracle) wrote:
> > I can't think of a reasonable solution to this at the moment. One
> > solution could be pushing this down into the platform code to deal
> > with as an interim solution, via the new .pcs_init() method.
> > 
> > We could also do that with the current XPCS code, since we know that
> > only Intel mGBE uses xpcs. This would probably allow us to get rid
> > of the has_xpcs flag.
> 
> Basically you suggest to move the entire stmmac_pcs_setup() to the
> platforms, don't you? The patch 9 of this series indeed could have
> been converted to just moving the entire PCS-detection loop from
> stmmac_pcs_setup() to the Intel-specific pcs_init.

Yes, it's not like XPCS is used by more than one platform, it's only
Intel mGBE. So I don't see why it should have a privileged position
over any other PCS implementation that stmmac supports (there's now
three different PCS.)

If you don't want the code in the Intel driver, then what could be
done is provide a core implementation that gets hooked into the
.pcs_init() method.

The same is probably true of other PCSes if they end up being shared
across several different platforms.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

