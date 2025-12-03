Return-Path: <netdev+bounces-243426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCE8CA0961
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 18:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 423E9300441F
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 17:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA36C345CD8;
	Wed,  3 Dec 2025 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lewGYjsS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41BC345CC8;
	Wed,  3 Dec 2025 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764783316; cv=none; b=I5glpUEplbfOmM5TJuG4CTHmBrS8xz3rj9N/HPFshOI4qi1df9z584gQgHIgC+ptYNYE3QhgWktoYehQkXvjfW9wDH+jE4aSJnSl1RqP87gXg6Lx9KVgFN3vjtAmpPy4ivDs6AEFawe/im6X44ZUI8aFH8FjXBTjoey0lruSPZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764783316; c=relaxed/simple;
	bh=JQu2b9NRJ42gK/PkDEGWkopCmcHjk7Ko53avW+LVta0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZL7lr8j0JA9fzBHTYQRWC/PW/TuFOWo1IzgHcNaTGTBFSNlX2sidSE2qY2tDmBAsYGd8E4hmuxBY7DN0FvrwhTWKQpjsj1MLpk6UBIL1BKXfyCs75WA9H5sHnmgH8tELRGEElvroo6lP2BECgJxwjQrgr+XUlAGCYea0G/bjE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lewGYjsS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hHpyxNIaNZfRKRMNY9ujvPysDB/fwgyutsqY/P0Voz0=; b=lewGYjsSaALyjLtDk/pb3BAqNH
	bhlottucCkUAMeRvyc5Lz6sloZgbnmBWwwEDK5PiFeztiscWTAHsKiJNwsh3AjBL5mqkIotoy6ykH
	4hTlRB8JFBDiCdR8w/UKZe63p7kuTn/C/0NGjwn3K6/r0jtJoChwoXud9DSdbGg76mX+1SzdJqPUH
	RIrRnTGU17H+6kCJJqUQmsPASLA1j0hRIxlb1pdcyYHmjfWxjg0eNYQtAfKNfa7UiArf3jiOljYbv
	/zrwEmWoEZ9UbTqiQAi48Lcfg3fRu/UdmcDRENluwuaeEWJehemGKfCg7K2or1FpedF6gWqttX6jl
	nTHh71kA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54608)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vQqks-000000002lv-3ejX;
	Wed, 03 Dec 2025 17:35:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vQqkp-000000000BX-1aLc;
	Wed, 03 Dec 2025 17:35:03 +0000
Date: Wed, 3 Dec 2025 17:35:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [net-next,PATCH 3/3] net: phy: realtek: Add property to enable
 SSC
Message-ID: <aTB0x6JGcGUM04UX@shell.armlinux.org.uk>
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-3-marek.vasut@mailbox.org>
 <aTAOe4c48zyIjVcb@shell.armlinux.org.uk>
 <20251203123430.zq7sjxfwb5kkff7q@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203123430.zq7sjxfwb5kkff7q@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 03, 2025 at 02:34:30PM +0200, Vladimir Oltean wrote:
> On Wed, Dec 03, 2025 at 10:18:35AM +0000, Russell King (Oracle) wrote:
> > On Sun, Nov 30, 2025 at 01:58:34AM +0100, Marek Vasut wrote:
> > > Add support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
> > > RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. The implementation
> > > follows EMI improvement application note Rev. 1.2 for these PHYs.
> > > 
> > > The current implementation enables SSC for both RXC and SYSCLK clock
> > > signals. Introduce new DT property 'realtek,ssc-enable' to enable the
> > > SSC mode.
> > 
> > Should there be separate properties for CLKOUT SSC enable and RXC SSC
> > enable?
> 
> That's what we're trying to work out. I was going to try and give an
> example (based on stmmac) why you wouldn't want RXC SSC but you'd still
> want CLKOUT SSC, but it doesn't seem to hold water based on your feedback.
> Having one device tree property to control both clocks is a bit simpler.

The problem I see is that if we introduce a single property for both,
we then need to maintain this single property ad infinitum. If we
later find that we need separate control, we could end up with three
properties - the combined one, and two for individual controls.

If we are to go with a single property, then I think we should have at
least discussed what we would do if we need separate control.

If we go with two properties now, then we don't have to consider this,
and we will only ever have the two properties rather than three.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

