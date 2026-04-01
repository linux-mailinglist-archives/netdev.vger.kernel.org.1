Return-Path: <netdev+bounces-274099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMW3C+EVzWmMZwYAu9opvQ
	(envelope-from <netdev+bounces-274099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:56:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3EE37AD01
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3224300406F
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BAF3D5256;
	Wed,  1 Apr 2026 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MBsZFjh2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E263FEB2E
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047720; cv=none; b=rNqD6KznrRK1hQXw/ygxhBP0t9Fhg1QfViIC3Bz7pppfOK2QCXQKvkNoh/3o/EDSvW5O/t/tXhAxclXieWVu7xYI8NDk57YJsTRgPDUIYr5lcroNe95cVOoqyHsJ7puPC0RqzCU5YMgNW5Hnqld9D2a/cKkLKyMAL2EABA1EtOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047720; c=relaxed/simple;
	bh=8N67YFrrdhKExUHeI2HlQPoaIy6fDf06XQLLZto3jpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mX05/J7iTYZQ52sxV43tEPdE58wktua6fdFOCZjGOFNZ4QRy1jCtIR3LllmCFrWvAI96dp84gfS4Kz7GS3kTzDws7srj53VtCpk9JDxaJiny01FwKOUgxvGzImA18LJe2noL0gTV39NRQbZtYLA43HPPSi/If5uVK8IV2zz2oFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MBsZFjh2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FGKo0V3/yjmrsgZssHyq7YqLIadlOITNH8jBcghRHtQ=; b=MBsZFjh25TV4ADoCm8vb+b5hKj
	EPce7dtj7zD7MboyNp4TDhcG32dw6AxvjmyjAmUeFea+rgJ44A8Lv3icNolaUEmeffKhnpOygEZCU
	iirv3gbUnEN+5ozEaOZea/evbSQtFh1vHs5TcQa0jxCQaVEksCYUCR2IIlrzhpr/TO2g3N2G+44mY
	O487BaTuQkO372/g3NJylwjISGcsYxaNdeKTMCXFsyhPofpH9jFnnia1ZQNHgox7EriwrnLfFTCpr
	/9qSxUkd65GGY30q2C63G9a7k7XlSv+lt7Uy86SQTALEoO/2hkTQypYYuorz6hbkZ7Gkgmwl37Wst
	wD4mTlEA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46596)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7uzs-000000003Bg-3p2X;
	Wed, 01 Apr 2026 13:48:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7uzr-000000004ny-3mIQ;
	Wed, 01 Apr 2026 13:48:35 +0100
Date: Wed, 1 Apr 2026 13:48:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: RFC: phylink: disable PHY autonomous EEE when MAC manages LPI
Message-ID: <ac0UI-v6GXNThdSh@shell.armlinux.org.uk>
References: <d86c53213a6328b701b8aabbde5d1c83@tipi-net.de>
 <04ff15af-26be-4278-bc2a-889e7802d271@lunn.ch>
 <aczMqBNesQH-tHx0@shell.armlinux.org.uk>
 <ccb68eaaca5512d5d662326d0817bd50@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccb68eaaca5512d5d662326d0817bd50@tipi-net.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	TAGGED_FROM(0.00)[bounces-274099-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.364];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 2C3EE37AD01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 02:12:43PM +0200, Nicolai Buchwitz wrote:
> On 1.4.2026 09:43, Russell King (Oracle) wrote:
> > On Wed, Apr 01, 2026 at 12:56:08AM +0200, Andrew Lunn wrote:
> > > On Tue, Mar 31, 2026 at 11:27:20PM +0200, Nicolai Buchwitz wrote:
> > > > Hi
> > > >
> > > > Some PHYs (e.g. Broadcom BCM54xx "AutogrEEEn") manage EEE LPI
> > > > autonomously without forwarding LPI signaling to the MAC. This works
> > > > fine when the MAC doesn't support EEE, but conflicts with MACs that
> > > > implement their own LPI control via phylink's mac_enable_tx_lpi /
> > > > mac_disable_tx_lpi.
> > > >
> > > > When the MAC has lpi_capabilities set, the PHY should use Native EEE
> > > > mode so the MAC can control LPI entry/exit and observe RX LPI
> > > > transitions.
> > > >
> > > > I'm thinking of a flag on phy_device (similar to mac_managed_pm) that
> > > > phylink sets when the MAC has lpi_capabilities, and that PHY drivers
> > > > check in config_init to disable their autonomous EEE mode:
> > > >
> > > >   /* set by phylink when MAC manages LPI */
> > > >   phydev->mac_managed_lpi = true;
> > > >
> > > >   /* in bcm54xx_config_init: */
> > > >   if (phydev->mac_managed_lpi)
> > > >       bcm_phy_modify_exp(phydev, MII_BUF_CNTL0,
> > > >                          AUTOGREEEN_EN, 0);
> > > >
> > > > This came up while adding EEE support to the Cadence macb driver (used
> > > > on Raspberry Pi 5 with a BCM54210PE PHY). The PHY's AutogrEEEn mode
> > > > prevented the MAC from tracking LPI state. As a workaround, the
> > > > Raspberry Pi tree currently carries a downstream patch that
> > > > unconditionally disables AutogrEEEn for all BCM54xx PHYs, since both
> > > > genet and macb now support EEE properly. That's obviously not suitable
> > > > for upstream where other MACs paired with BCM54xx may not have LPI
> > > > support.
> > > >
> > > > Does this seem like a reasonable approach, or is there a better way to
> > > > handle PHY autonomous EEE within phylink?
> > > 
> > > You should also think about it from the other direction. What happens
> > > with the MAC does not indicate it supports EEE, but the PHY has
> > > autonomous EEE. At some point in the future we are going to want the
> > > PHY drivers to export API calls so that phylink/phylib can implement
> > > ethtool set_eee and get_eee using this autonomous EEE.
> > 
> > Indeed - this needs to first be solved in phylib so that non-phylink
> > drivers can work before adding support to phylink.
> > 
> > > Maybe it makes more sense for Broadcom BCM54xx etc, to implement a
> > > .set_eee() call which only accepts eee_enable == False, and when
> > > called so, disables autonomous EEE. .get_eee() can similarly return
> > > that EEE is disabled. When phylink sees the MAC implements EEE it can
> > > calll into the PHY driver to turn off autonomous EEE. And we have a
> > > path to later add support for turning on and fully configuring
> > > autonomous EEE.
> > 
> > I think the current phylink_ethtool_[sg]et_eee() may eventually need
> > tweaking - for the case where the MAC eee ops are populated but the
> > MAC support is disabled for some reason - e.g. the instance doesn't
> > support EEE but the driver does for other instances.
> > 
> > However, I don't think we can re-use phy_ethtool_set_eee() for this -
> > even with MAC based EEE, we still call through to phylib's
> > phy_ethtool_set_eee() which would change the on-PHY EEE support in
> > ways we wouldn't want. This call remains necessary because of the
> > requirement to configure the EEE advertisement which happens at phylib
> > level.
> > 
> > I think we need a separate phylib interface which disables PHY-based
> > EEE.
> 
> Thanks Russell and Andrew. You're both heading in the same direction,
> so to make sure I understand correctly:
> 
> 1. Add a new phylib interface (separate from phy_ethtool_set_eee) to
>    control PHY-autonomous EEE, e.g. phy_set_autonomous_eee(phydev,
>    enable) and phy_get_autonomous_eee(phydev) to query the current
>    state.

Actually, I think:
- phy_disable_autonomous_eee()
  this disables that support at the PHY.

- phy_support_autonomous_eee()
  this allows phy_ethtool_[sg]et_eee() to handle the EEE enable/disable
  state, and means that the MAC driver wants the PHY to do so.

Remember that phy_ethtool_[sg]et_eee() are the user API, and we want
them to control EEE no matter where it is.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

