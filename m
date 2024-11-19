Return-Path: <netdev+bounces-146291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 850839D2AA7
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 17:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13047B37D19
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E71BCA0A;
	Tue, 19 Nov 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nyQm/C7/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF519D07A;
	Tue, 19 Nov 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031382; cv=none; b=fQvXBrrD8khxXxrguZpWRVpLR5LUwmxNB7kwbC0GB8ODj+7E5sJaM2U0Ss2fi5ZSFDiXtwR91UQMXZ49zk9Mq/i49rmnCUZluww1Q0FqJLb1fD24g1UxIscZOAFlq6ikahw4hoqbbCYyLPOxy7tv+PwHFRclduvwdQ81Eb61PZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031382; c=relaxed/simple;
	bh=d85uQ7gXeZyZFb61sgWMHoOGaZXFD6ol3m68Bfp/wSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLWz+tltEhRFTRQPCbunsjzLBFdz9WOdFz1fnenJfVWmcxDKyQMK29cEyAQshIIZlpGcV78dQnT9UG9KTRlrvgGLbNzNReUTA12jphB9kVmzlGG9ZYF8fepUtCQfkhp63QndRIjamZgdOizHVWsVOu7kCTopBeF/RzEuMaapQDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nyQm/C7/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qnQRqocn/VRT/81Ql3s0QeMFooHZBkWosHmPORCjQhA=; b=nyQm/C7/PauPVNEBcpCuSxF7q4
	aPVRUgpsV908uUmyAlEBhyWBM37HjkDLD6/0nPF98GBKVYheUF2PL1stCIJgYpoY7acJ1Do+0EEhr
	sEGkrWgEj8fg249awdbsUtKlB/met1b4Pavt8UcTtdrx3VsaTu7jc4Yd8BGqtVKoE23RulUZPqfyR
	CmibYEdiY4SfR/9pcTF/gNkmpDsalkxhC3TJXsDuMPzIUdBfvB8qch/DhFDk8ndTcJZldNI/jZifI
	FojM7t7Ns944esyRn50m4fJVDg81mFr+dtx2ivmmQ+k40xCXudGkJ1rvpStA5Pl7g7rvQJJ5AsVgG
	aHGm10QQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40134)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tDQTn-0003qf-20;
	Tue, 19 Nov 2024 15:49:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tDQTk-0006AN-2Y;
	Tue, 19 Nov 2024 15:49:24 +0000
Date: Tue, 19 Nov 2024 15:49:24 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Suraj Gupta <suraj.gupta2@amd.com>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
	radhey.shyam.pandey@amd.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, git@amd.com, harini.katakam@amd.com
Subject: Re: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
Message-ID: <ZzyzhCVBgXtQ_Aop@shell.armlinux.org.uk>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-3-suraj.gupta2@amd.com>
 <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
 <657764fd-68a1-4826-b832-3bda91a0c13b@linux.dev>
 <9d26a588-d9ac-43c5-bedc-22cb1f0923dd@lunn.ch>
 <72ded972-cd16-4124-84af-8d8ddad049f0@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72ded972-cd16-4124-84af-8d8ddad049f0@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 19, 2024 at 10:26:52AM -0500, Sean Anderson wrote:
> On 11/18/24 20:35, Andrew Lunn wrote:
> > On Mon, Nov 18, 2024 at 11:00:22AM -0500, Sean Anderson wrote:
> >> On 11/18/24 10:56, Russell King (Oracle) wrote:
> >> > On Mon, Nov 18, 2024 at 01:48:22PM +0530, Suraj Gupta wrote:
> >> >> Add AXI 2.5G MAC support, which is an incremental speed upgrade
> >> >> of AXI 1G MAC and supports 2.5G speed only. "max-speed" DT property
> >> >> is used in driver to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
> >> >> If max-speed property is missing, 1G is assumed to support backward
> >> >> compatibility.
> >> >> 
> >> >> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> >> >> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> >> >> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> >> >> ---
> >> > 
> >> > ...
> >> > 
> >> >> -	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
> >> >> -		MAC_10FD | MAC_100FD | MAC_1000FD;
> >> >> +	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
> >> >> +
> >> >> +	/* Set MAC capabilities based on MAC type */
> >> >> +	if (lp->max_speed == SPEED_1000)
> >> >> +		lp->phylink_config.mac_capabilities |= MAC_10FD | MAC_100FD | MAC_1000FD;
> >> >> +	else
> >> >> +		lp->phylink_config.mac_capabilities |= MAC_2500FD;
> >> > 
> >> > The MAC can only operate at (10M, 100M, 1G) _or_ 2.5G ?
> >> 
> >> It's a PCS limitation. It either does (1000Base-X and/or SGMII) OR
> >> (2500Base-X). The MAC itself doesn't have this limitation AFAIK.
> > 
> > 
> > And can the PCS change between these modes? It is pretty typical to
> > use SGMII for 10/100/1G and then swap to 2500BaseX for 2.5G.
> 
> Not AFAIK. There's only a bit for switching between 1000Base-X and
> SGMII. 2500Base-X is selected at synthesis time, and AIUI the serdes
> settings are different.

Okay. First it was a PCS limitation. Then it was a MAC limitation. Now
it's a synthesis limitation.

I'm coming to the conclusion that those I'm communicating with don't
actually know, and are just throwing random thoughts out there.

Please do the research, and come back to me with a real and complete
answer, not some hand-wavey "it's a limitation of X, no it's a
limitation of Y, no it's a limitation of Z" which looks like no one
really knows the correct answer.

Just because the PCS doesn't have a bit that selects 2500base-X is
meaningless. 2500base-X is generally implemented by upclocking
1000base-X by 2.5x. Marvell does this at their Serdes, there is
no configuration at the MAC/PCS for 2.5G speeds.

The same is true of 10GBASE-R vs 5GBASE-R in Marvell - 5GBASE-R is
just the serdes clocking the MAC/PCS at half the rate that 10GBASE-R
would run at.

I suspect this Xilinx hardware is just the same - clock the transmit
path it at 62.5MHz, and you get 1G speeds. Clock it at 156.25MHz,
and you get 2.5G speeds.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

