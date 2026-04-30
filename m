Return-Path: <netdev+bounces-282890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJGHEIVs82lf2gEAu9opvQ
	(envelope-from <netdev+bounces-282890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:51:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 771AD4A443D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50519303747D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BBE429825;
	Thu, 30 Apr 2026 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zkt4rIoK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AE634E746;
	Thu, 30 Apr 2026 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560591; cv=none; b=IYBlgUxoXzNMAPxUCRUQZ6N/2cEDKewPkL/0Z7rl+1kFaEJ1ZNIiaZDIiWP/nrZ/NS8hcbiE0BYng/E46vFMO2/EYxvAvR+bdtuPbtv0RnkP2scwX13b/arUMOc6W0J+WRTrzJy4y6tojh140lb1WWsfXtzk3ziaLvJ73sD6Mik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560591; c=relaxed/simple;
	bh=pOUIyA2ElRjnyxonQTBep8jNlmfo3itmCpaK+XXNojo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXshcjkXzRR9rP6tSfXwS5z+sDIiS2Fr4x+4KNUTcDI1D1M0YgmMW2JWoRqSiALH9tAXd8phNld6MGKd9lRmpUauVdSSw0QMHTafEQFvZdqB0aOXcNTKw5yij1BHgEIdd446Z7Obebv34HttBdW9OQlrQO1MZyoVI7lS/hDLXhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zkt4rIoK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SUMRIeygXZqTo/dYnTvE2OPHdxFRuBvdjenOkHyA5RQ=; b=zkt4rIoKuC1xij7KzGhcc8YsBA
	gCNWojQSmex4xnxMI83P2pUzqhtRAqkGl/sWwEh2rT8LT8R/An2s/Zj5Yn2qEvqhNOkvbZbmONRi4
	oRUrSePRQe+nHRY9nz+hrgVmRF1WEYRV8jtUET+a+V6zxeuVZY1/y10KnXhkusC7Enqo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIShr-000h8L-Fi; Thu, 30 Apr 2026 16:49:35 +0200
Date: Thu, 30 Apr 2026 16:49:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Robert Marko <robert.marko@sartura.hr>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, Divya.Koppera@microchip.com,
	horatiu.vultur@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: micrel: fix LAN8814 QSGMII soft reset
Message-ID: <2983d402-83c1-477b-887e-7a8fd1535884@lunn.ch>
References: <20260428134138.1741253-1-robert.marko@sartura.hr>
 <0060104c-bb38-45d5-8f8e-14708702feac@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0060104c-bb38-45d5-8f8e-14708702feac@redhat.com>
X-Rspamd-Queue-Id: 771AD4A443D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sartura.hr,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,microchip.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282890-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

> > @@ -4548,6 +4548,13 @@ static int lan8814_config_init(struct phy_device *phydev)
> >  	struct kszphy_priv *lan8814 = phydev->priv;
> >  	int ret;
> >  
> > +	if (phy_package_init_once(phydev))
> > +		/* Reset the PHY */
> > +		lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> > +				       LAN8814_QSGMII_SOFT_RESET,
> > +				       LAN8814_QSGMII_SOFT_RESET_BIT,
> > +				       LAN8814_QSGMII_SOFT_RESET_BIT)
> 
> Sashiko says:
> 
> ---
> Could this introduce a race condition if multiple ports are brought up
> concurrently?
> Because phy_package_init_once() does not provide a synchronization
> barrier for followers, they might proceed immediately to configure their
> registers while the leader is still performing the reset.
> ---
> 
> on top of my head IDK if such race is possible at all.

config_init() is called from phy_init_hw(). That is called from
mdio_bus_phy_resume() and phy_attach_direct().

It seems unlikely resumes of devices on one bus is done in parallel,
same as probing of devices on one bus is not performed in parallel.

phy_attach_direct() is either used in the MAC drivers probe() or
open(). Again, probe should not be running in parallel especially
since this PHY is likely connect to a switch, and the ports are
created sequentially by the DSA core. open() should be protected by
RTNL.

So it seems unlikely to me.

lanphy_modify_page_reg() also takes the MDIO bus lock. That will
prevent any other MDIO operations being performed in parallel. This
does however make the assumption the software reset can be performed
within one MDIO bus cycle.

So a race here seems pretty theoretical to me.

    Andrew

