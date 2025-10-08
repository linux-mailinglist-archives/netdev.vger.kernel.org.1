Return-Path: <netdev+bounces-228217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C76A3BC4FE7
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 14:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 932FA4ECAEB
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 12:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C54225392D;
	Wed,  8 Oct 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="P4r5ZVOX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7222576E;
	Wed,  8 Oct 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927985; cv=none; b=bpD4Q1c14/1UJwEldopEiwE+dCoq+RdhcPvWagU0iBpVFr6x+RoTBOAIGAJ0JxcNddu2hHu2DTzU47ncZJbzgXTv87KxeTZAEUH5/mbbaeV9PZsSg2kkslcgiUXckHTWhgs/X9jwFOhIKQd3QrnuAutHsAha2P4Qw16IgyhS8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927985; c=relaxed/simple;
	bh=KE994vaHc9Lub7dV+5qjBDCWtxEyznYGfeEQaGAijBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TclUDbdR4EdjvFWCpSWN+mgAfrmgDO1xBYPtQzPK7ttHXbXA5Mi4BPGLJDYE7auQK0qcBwXtu2NLubrsmQ6T5BhjXmpTKYFNBzZdTYKiy2vRpkYW9agB1Erjrr4CQyw+/9qvgQLEl9CaCawPjgRBXmyEGWA5KAMlN45gbg3LIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=P4r5ZVOX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rUcNF7HmWtTGzIMms9/Q8UU/RXubK/rmOwXw+oXKsP0=; b=P4r5ZVOXQiZxQe2ze5I0fRfgFe
	pSpL71g8anM40noUiJXsS1xp7yhe7SztuvFwnfLEjqAf49e2OQLwcE5TZP0Pg/i4Rf/vXmYe5GqKS
	ZxRDzDuS1Bd8r1TvlSsZ1BW8OV0vDdXB5yAkcADohw3lmkGVx7cRii+Uo5129WxPXBPEheNifZTxR
	WrxZBW6N8RjfU85mN5Cc1hUqI6oUamCnSbXDX06fCeus8sBwf79InY0GglbCWK8y8eLs5tc3veJg4
	eX9w5YCrW7AKcT1QcqduhUqp+U5WRxssoDlh0GVzi4YgTi+7gPx4nDSFpwma8/gDAxdfAxm4xnTxW
	TI2yTqYQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56520)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v6Tex-0000000064b-2vae;
	Wed, 08 Oct 2025 13:52:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v6Ter-000000003sR-3QOm;
	Wed, 08 Oct 2025 13:52:42 +0100
Date: Wed, 8 Oct 2025 13:52:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aOZemYL1iofWyBji@shell.armlinux.org.uk>
References: <20250827073120.6i4wbuimecdplpha@skbuf>
 <aK7Ep7Khdw58hyA0@FUE-ALEWI-WINX>
 <aK7GNVi8ED0YiWau@shell.armlinux.org.uk>
 <aK7J7kOltB/IiYUd@FUE-ALEWI-WINX>
 <aK7MV2TrkVKwOEpr@shell.armlinux.org.uk>
 <20250828092859.vvejz6xrarisbl2w@skbuf>
 <aN4TqGD-YBx01vlj@FUE-ALEWI-WINX>
 <20251007140819.7s5zfy4zv7w3ffy5@skbuf>
 <aOYXEFf1fVK93QeS@FUE-ALEWI-WINX>
 <20251008111059.wxf3jgialy36qc6m@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008111059.wxf3jgialy36qc6m@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 08, 2025 at 02:10:59PM +0300, Vladimir Oltean wrote:
> 1. Configure IF_MODE=3 (SGMII autoneg format) for 2500base-x:

Just to be clear, we're not going to accept SGMII autoneg format for
2500base-X.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

