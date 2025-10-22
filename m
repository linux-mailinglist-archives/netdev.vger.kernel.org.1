Return-Path: <netdev+bounces-231813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C4FBFDC7C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A73294F78D6
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33B92DC770;
	Wed, 22 Oct 2025 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oUDa7GAI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765782EC0A8
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156685; cv=none; b=oa+62IJk8ANI7UQuDGXIx8gNjJLLy5UncqHStJTThGgvAyQLilT4I7qlWUFG75XktgY/d9b1aCgYiAqR6PbGEnoOzigKCgz8v2k/UFAECq3iX34ENW/wN5OyLAj8sqqaRVVfs32Kv7ju++EAXc9zBrB7SwgIDeB4eD138U3PArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156685; c=relaxed/simple;
	bh=L+owJetuA7Ix3bqsfBLi98iz66O5e+AaujiNsjJkgc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPhmYJCnDKjv7b2CrYyajlyAsG+sNSHrjNuZOr21JXGkVDJ1WME+aGQ2Ll72x5PqWX5bqcBlqF1JCTd/7QSTwKCz2lqVx7g6exlpACTTUxfeXj9v5FBFPtss9oHSuMxctyObmeyxnwv5AZJ5lS1hVWNkRHnYxncLgfHO9Ce95GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oUDa7GAI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rA2LYAqEb92Q4g4Yq5hfL5BuClXd15oA216rjXGuuxw=; b=oUDa7GAInMplqxvZSxR7xdnKfh
	gnH6WvqRq/oIBsMGn5B4Ks5GnfWDskOvVYABlOA8tn8Phd8Dp7vZrjhCud8Fzmqj/iaKFdMEuCxnY
	kZvFEFV0mmL5eZU2ZxkV8WAEFsf2UL0JcrMjG7K/4TbXTaabn8auv8wRmqRN4miJ74OHF2XkN71iw
	RGfxe6FO+nXNyGucn/kr9fZQW6Fr+rd9AbX3hTGL4ag4Y+E6rLalGw44eGLv/adpU0DlyaCbVSoTN
	E1fcCouudt62ivDHgkNWQpp8exExqQYx1XBEDtlg4ILJUHnKvov2uOrXITsn5NXJgdUAhPKZAyyla
	2VkdLFkw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57282)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vBdIf-000000005HL-3eJg;
	Wed, 22 Oct 2025 19:11:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vBdIb-000000000uh-3ctw;
	Wed, 22 Oct 2025 19:11:01 +0100
Date: Wed, 22 Oct 2025 19:11:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 4/6] net: phylink: add phylink managed
 wake-on-lan PHY speed control
Message-ID: <aPkeNRyRtHOMs5h5@shell.armlinux.org.uk>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
 <E1v9jCZ-0000000B2PP-2cuM@rmk-PC.armlinux.org.uk>
 <eb0d1b55-307b-4b51-953f-fdcc1a8fbe27@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb0d1b55-307b-4b51-953f-fdcc1a8fbe27@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 22, 2025 at 04:28:19PM +0200, Maxime Chevallier wrote:
> Hi Russell,
> 
> > +
> > +	if (phylink_phy_pm_speed_ctrl(pl))
> > +		phy_speed_down(pl->phydev, false);
> 
> Should this rather be phylink_speed_down, to take into account the fact
>  that the PHY might be on SFP ? either here or directly in
> phylink_phy_pm_speed_ctrl() above ?

I think using phylink_speed_*() makes more sense than merging the test
into phylink_phy_pm_speed_ctrl(). If something changes in what we do
with speed_up/down() then we want everyone to be affected (not that I
forsee any change there.) Logically though...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

