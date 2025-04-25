Return-Path: <netdev+bounces-186051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D335FA9CEDC
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44F47BA4B5
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 16:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD2020E6F3;
	Fri, 25 Apr 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0KB45/Cl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB820E323;
	Fri, 25 Apr 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599727; cv=none; b=CsVcGzSa44nIQBheWj0tIaD9nMH+hQgrbyq9EIgCt8txjtHh7jLbjrAh17iaPYdOISHZhSZxdOYn0edmhYF+9juUMD0O3crzOee2hBymaxGisdrdnfOtaV2U/zkg/OHDWVi8VoDFyWHF3RZ9Bi4gsmn8CS+hd6eA4fbyZaorfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599727; c=relaxed/simple;
	bh=VVJ/We/Lly+0+S2CLvE4/58LVy6SII/cRyTQmokO6BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8415WiUelo2xiPZK16b0Ow/XeoqwWhzkR1siOoUs1rXGxKQvm2LG42FnUEBtTqPwhDBPQb/zdIhJr9Ki7AicT5o1TGF1fekypvHpRE9ZEgHyx4pzqFLaZSAscE0AustB9+vixzEcRMlCh/ivg8wNki1ReJoBy6MhaEzXczerr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0KB45/Cl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ATk4v7NoBbgEunymz2bPZNqMG9U+8M7uzCmg6xrMY44=; b=0KB45/ClHbma9nV8LFMrAFqIcZ
	uMCK2HFTVDTLlb0emgjJJ9qW7jckH+Xu7sX14t2sMI/SYFzdp3dg9Gb3gvozBPh4LGhOm+bjYOImo
	STD7pSRVApFE+l7PToHHgNZ0R4rX46h0R5VU/5SPjoFp61Q0KY+8O7CXgHjwJ1aUh6oudMeQBBGmc
	3KRlqDrkvg7kHdTcg3EVJ5+WC8tFLvTZ3eZ92WW3xv4uNXqnKGu7HP3ZaXJrMr/Oow4J9k84p3D13
	KyU3ZzjYzvvaoSEHYuWLcTtvpJTtKgugYQyn7PsjhfiZDQ7rDX5cKQrd2BoTt3jRdbWWFHgMoMvCX
	BCjvee0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55842)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u8ME5-0000iH-0U;
	Fri, 25 Apr 2025 17:48:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u8ME1-0002H8-0J;
	Fri, 25 Apr 2025 17:48:29 +0100
Date: Fri, 25 Apr 2025 17:48:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v2 1/1] net: dsa: microchip: Remove ineffective
 checks from ksz_set_mac_eee()
Message-ID: <aAu83HGXOxQ6H8on@shell.armlinux.org.uk>
References: <20250425110845.482652-1-o.rempel@pengutronix.de>
 <aAuRAadDStfwfS1U@shell.armlinux.org.uk>
 <aAubnUSDpwtfuCrm@pengutronix.de>
 <aAufpsLhs8GLMm_b@shell.armlinux.org.uk>
 <aAu41tjRIir8oMK7@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAu41tjRIir8oMK7@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 25, 2025 at 06:31:18PM +0200, Oleksij Rempel wrote:
> Additionally, it seems that setting eee_enabled automatically based on
> advertisement in phy_probe() is no longer appropriate.
> If you agree, I would propose a patch to remove this initialization.

Remember how eee_enabled is implemented. It controls whether we program
the EEE advertisement with the contents of the software advertisement
state, or clear it.

So, if the hardware has a non-zero advertisement, then it is completely
correct that we read the advertisement and set eee_enabled to be true.
The alternative is, we set eee_enabled false and clear the
advertisement.

We can't leave the advertisement and set eee_enabled to be false. That
is inconsistent with the way we handle any attempt to set the
eee_enabled state.

I think the correct approach in this case is to set
config->eee_enabled_default to be true in ksz_phylink_get_caps(),
thereby correcting the bug introduced in March 2024. That has the
effect of setting phy->eee_cfg.tx_lpi_enabled, which means we should
report tx_lpi_enabled as true when reading the EEE state.

For the stable kernels between March 2024 and the integration of
phylink EEE support, a similar approach will be necessary to restore
the pre-March 2024 behaviour, but that will be much harder to correct
as the DSA driver doesn't have an appropriate hook to set that field
at the appropriate time.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

