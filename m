Return-Path: <netdev+bounces-128702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3917B97B187
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 16:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A2EB24B93
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8046B169AC5;
	Tue, 17 Sep 2024 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MTXSedCW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3E165EE4;
	Tue, 17 Sep 2024 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726584087; cv=none; b=iNqlDYN2KMMcuyJlzNmk13rM1AShI0EJY4FUtMiLEn5kL8WpeJoZkm0vC9Hgv0+6mx2moVNFpliILIFxuabgcslNR025qsZBEQVUS0vJUTooH5tujcBjeypvS1+pnzzeS8iObXbYkjSMZX8BC3MauMg4pqRe59LxjoJC+F1MCAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726584087; c=relaxed/simple;
	bh=m0zCo/wJoDNZOu7VIMvxq3l6FXVvA9R7xVYEGMtz6Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFpXpl8T6teuX4/MG5Rv4AKOVJxcjiwvam8dslxYnY4tl7SJqSCYNBbI9oXUiZCjQN51RT4YgD5y1lseUbD9RhSzJNpCQfOSht5g4H6rLuThj0YNAzwLHkHhMRDCn7CbBudxolAOChU5UcrulvF/LRtXsRR2w/81XaA9PhHeMas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MTXSedCW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wg+AK5gAuMSTXcM6Mu8HIiJ/brOf2BQerEtgNxpz8Zg=; b=MTXSedCW7euNlO9Uc8k+bbbwrS
	jWVfzQdAUDAe0aDJB8B30+Foa8nwN1Vcp5vSLcluy2D/2Zin3COBiX0MaA6H0fFJkY/hhFGHaTcDr
	9ZBA4ekwKp/fVTxQvEwuTyP9nKwqiKcdm4jvWcNlF+2WpGVApxqmIxWmA6y7sTJVCTLjxc7JqScmT
	2sc+C9Qa6zvvwjxidloST1P7mgQi9eiLiu9rXLAKIi4RJE3P5uUXf9Sgt5FuJm6JyIWlrrgK4bV8G
	5/WWUp4ebMeC4Bh8N4dK4df/AQnfiXaAHXfH45LTMvRI1vBVUh/YYMn/3MU1hGy/i+ITEoGPWx0rh
	/Ptw8TMQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35146)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqZOE-00071f-0M;
	Tue, 17 Sep 2024 15:41:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqZOB-00083p-2w;
	Tue, 17 Sep 2024 15:41:11 +0100
Date: Tue, 17 Sep 2024 15:41:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: phy: aquantia: fix applying active_low bit
 after reset
Message-ID: <ZumVB5yQJCrzrvM5@shell.armlinux.org.uk>
References: <ab963584b0a7e3b4dac39472a4b82ca264d79630.1726580902.git.daniel@makrotopia.org>
 <9b1f0cd91f4cda54c8be56b4fe780480baf4aa0f.1726580902.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b1f0cd91f4cda54c8be56b4fe780480baf4aa0f.1726580902.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 17, 2024 at 02:49:55PM +0100, Daniel Golle wrote:
> for_each_set_bit was used wrongly in aqr107_config_init() when iterating
> over LEDs. Drop misleading 'index' variable and call
> aqr_phy_led_active_low_set() for each set bit representing an LED which
> is driven by VDD instead of GND pin.

Assuming that the intention is only to set LEDs active-low that were
previously configured to be active-low, then:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

It's good that we don't call aqr_phy_led_active_low_set() for every LED
in the .config_init method because we don't know whether the LED
outputs for this PHY are used on SFPs to drive e.g. the SFP LOS pin,
and changing LED settings in such a case could cause incorrect
signalling. If this ever changes, then this code needs to be
conditional on !phy_on_sfp(phydev).

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

