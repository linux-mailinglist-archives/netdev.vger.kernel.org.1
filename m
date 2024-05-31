Return-Path: <netdev+bounces-99664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A609F8D5BCE
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 09:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C8D7B24111
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 07:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716B4762D0;
	Fri, 31 May 2024 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rVSKoCRT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975867441F
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717141697; cv=none; b=l1VAG5YfAiM9iaP0qyC7dOuqrGF0y/j6J/6kj8vDJ0LwTuppBx3aQaw4hlb8XVhxt0tvl+pRWynAUoD4VkMNmawzb8Oe8X/yP/Z/t3LvgIMvD0KuqxkcpYV+Dm+ZPszBSf1AIbwOjbxGYsWzjKbCoxL4/TsBQ8EoX7vDhb1ZTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717141697; c=relaxed/simple;
	bh=9e8sNM+ssP8xW+4abcU4AuzrNXd1o7HhNG9uZB5MJcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQgPLpj0kEw0PWTpm20YDTt0Li6MKMs/vrbxdabFi3eLwGHVPAagGj3KvvCOTVec4mW9w8+qwRuD+PL1Ou1DE/uI3uPJzGrsvfN/v8UuokrL5hjTd8u/zZhDaHUAh2TThn0F+hBAr9MY0mxSzLCbHuLBs07nrw4IhDKAKnzNY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rVSKoCRT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WMRgCjIjbnYaXtuP/I/6StaZplNnsNrJiV1yPXkSpc8=; b=rVSKoCRT29DjaaZzMujbgHq9LD
	90ThmysLqYk8kBgTirxDcImYvqch2BS/sG4o1TWfMrUcrcesAzM/UtPwjjXm2IH86mkCWhIlfKXop
	KCkqXrMVTVl8sRxZrolPFJLvB1GprWLjic15Vd+cVgEY7RHNrCAUDR83p5c1gMoLO9w0Nk1X+/EaJ
	xF5IOeDqesRPhBohC9DqdTYJ1FsFnoJ+S6isTm0Zma9EfwqAYePu4VpAgNxvsHTzWwcpxVNGkXbN0
	OqMULfPDPiui34vCmGjijgCWLQm3v4x0Tt0O9FQH6NAQRLtImMOofCia055GAE7FizFNt/tKmbwQZ
	DdTB/kNA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45718)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCwzY-0008Ea-2R;
	Fri, 31 May 2024 08:48:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCwzX-0005uo-7t; Fri, 31 May 2024 08:47:59 +0100
Date: Fri, 31 May 2024 08:47:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Colin Foster <colin.foster@in-advantage.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next 0/8] Probing cleanup for the Felix DSA driver
Message-ID: <ZlmAry5lo/Mrrlhl@shell.armlinux.org.uk>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
 <Zlk/GmpxUq/iOqs4@colin-ia-desktop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zlk/GmpxUq/iOqs4@colin-ia-desktop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 30, 2024 at 10:08:10PM -0500, Colin Foster wrote:
> Hi Vladimir,
> 
> On Thu, May 30, 2024 at 07:33:25PM +0300, Vladimir Oltean wrote:
> > This is a follow-up to Russell King's request for code consolidation
> > among felix_vsc9959, seville_vsc9953 and ocelot_ext, stated here:
> > https://lore.kernel.org/all/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk/
> > 
> > Details are in individual patches. Testing was done on NXP LS1028A
> > (felix_vsc9959).
> > 
> > Vladimir Oltean (8):
> >   net: dsa: ocelot: use devres in ocelot_ext_probe()
> >   net: dsa: ocelot: use devres in seville_probe()
> >   net: dsa: ocelot: delete open coded status = "disabled" parsing
> >   net: dsa: ocelot: consistently use devres in felix_pci_probe()
> >   net: dsa: ocelot: move devm_request_threaded_irq() to felix_setup()
> >   net: dsa: ocelot: use ds->num_tx_queues = OCELOT_NUM_TC for all models
> >   net: dsa: ocelot: common probing code
> >   net: dsa: ocelot: unexport felix_phylink_mac_ops and felix_switch_ops
> > 
> >  drivers/net/dsa/ocelot/felix.c           |  62 ++++++++++++-
> >  drivers/net/dsa/ocelot/felix.h           |  10 +-
> >  drivers/net/dsa/ocelot/felix_vsc9959.c   | 113 +++++++----------------
> >  drivers/net/dsa/ocelot/ocelot_ext.c      |  55 +----------
> 
> Just FYI I tried testing this but hit an unrelated regression in 6.10,
> and a `git b4` on 6.9.3 has conflicts. So I'm still alive, but probably
> won't get to testing this tonight. Looks good though.

You will need... the net-next tree because it's dependent on a patch I
submitted earlier this week.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

