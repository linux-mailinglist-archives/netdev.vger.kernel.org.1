Return-Path: <netdev+bounces-240970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42262C7CF0F
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 12:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC913A9515
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 11:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0152FA0E9;
	Sat, 22 Nov 2025 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BlwhR55N"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63172FB09A
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763812694; cv=none; b=S8k9AkhFe26NkGtCVd+DWSXcRHt/H57xhn1AAk4nHo/kKKDsQyNk/zQfGPC+nKlwuhifmchdoNSHrVz5j4nLPqrsTGtFzp584w/eX9Wv7MccCGnaUqHOPLyHFk6YAvusvA4GVp/pt+9bD+nakFLuCkb/OC2K6CbnQHEe3CqNAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763812694; c=relaxed/simple;
	bh=eLrKIwNs0zn+2d4Q6jkuxMQFuq0ogmc4fR5FK/YOhF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHIJBLapAeu6pm/prWxhJBpuq6GGAWbTqlZtz0RZwoUVoxKoi9Ba950EIHe8NwgbfW944BpzJCPOh9Px/qHfIrRv4aY2w5jwgtU/YHCNj4Hp1V0RnkjlZbTmECqAmkgBaLEDrmRIOfwm5XfiM2q3rit+IqbGaHBuq5hcLZe84/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BlwhR55N; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4cKYzoVc8aSgsLLMPeCgQEPQksBr558IwJqgCFiGYbo=; b=BlwhR55N5h3U/vIJO+Xhsk8HWU
	Pvm0ZQAE2IPxCpqEjAp/67+afSbzMd/dq/lBMOpfD2XhNZHN6a4VBU+PKS6jg2TZVsb/av2ln6ymu
	El8grFBpbj1E8ye/vpoLR5ysXuprCZDsKdDCXukwrHIZ5M1Ub2iot+T1zasaUF6bXmdSZUI/i5KqN
	rnsar7B2TTf3QByvWuGOTwnKa64lCUPW1QlfQZnWeE539Ogy6O1UYr9D/NptOuyKa2wxrmD2bHMne
	jlICmvAWWKV+c5bMuBUvRKerU3dRSmQA2OoScCgdjGHIQMfSlC2PqL78ubilg/32TeS2j/nu+Sm23
	h9exVwnA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42962)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vMmFf-0000000007q-29S1;
	Sat, 22 Nov 2025 11:58:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vMmFc-000000006IU-1rDv;
	Sat, 22 Nov 2025 11:58:00 +0000
Date: Sat, 22 Nov 2025 11:58:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Wilhelm <alexander.wilhelm@westermo.com>
Subject: Re: [PATCH net-next] net: pcs: lynx: accept in-band autoneg for
 2500base-x
Message-ID: <aSGlSJ1Z_Sjj_Ima@shell.armlinux.org.uk>
References: <20251122113433.141930-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122113433.141930-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Nov 22, 2025 at 01:34:33PM +0200, Vladimir Oltean wrote:
> Testing in two circumstances:
> 
> 1. back to back optical SFP+ connection between two LS1028A-QDS ports
>    with the SCH-26908 riser card
> 2. T1042 with on-board AQR115 PHY using "OCSGMII", as per
>    https://lore.kernel.org/lkml/aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX/
> 
> strongly suggests that enabling in-band auto-negotiation is actually
> possible when the lane baud rate is 3.125 Gbps.
> 
> It was previously thought that this would not be the case, because it
> was only tested on 2500base-x links with on-board Aquantia PHYs, where
> it was noticed that MII_LPA is always reported as zero, and it was
> thought that this is because of the PCS.

Yay. 

> 
> Test case #1 above shows it is not, and the configured MII_ADVERTISE on
> system A ends up in the MII_LPA on system B, when in 2500base-x mode
> (IF_MODE=0).
> 
> Test case #2, which uses "SGMII" auto-negotiation (IF_MODE=3) for the
> 3.125 Gbps lane, is actually a misconfiguration, but it is what led to
> the discovery.
> 
> There is actually an old bug in the Lynx PCS driver - it expects all
> register values to contain their default out-of-reset values, as if the
> PCS were initialized by the Reset Configuration Word (RCW) settings.
> There are 2 cases in which this is problematic:
> - if the bootloader (or previous kexec-enabled Linux) wrote a different
>   IF_MODE value
> - if dynamically changing the SerDes protocol from 1000base-x to
>   2500base-x, e.g. by replacing the optical SFP module.
> 
> Specifically in test case #2, an accidental alignment between the
> bootloader configuring the PCS to expect SGMII in-band code words, and
> the AQR115 PHY actually transmitting SGMII in-band code words when
> operating in the "OCSGMII" system interface protocol, led to the PCS
> transmitting replicated symbols at 3.125 Gbps baud rate. This could only
> have happened if the PCS saw and reacted to the SGMII code words in the
> first place.
> 
> Since test #2 is invalid from a protocol perspective (there seems to be
> no standard way of negotiating the data rate of 2500 Mbps with SGMII,
> and the lower data rates should remain 10/100/1000), in-band auto-negotiation
> for 2500base-x effectively means Clause 37 (i.e. IF_MODE=0).
> 
> Make 2500base-x be treated like 1000base-x in this regard, by removing
> all prior limitations and calling lynx_pcs_config_giga().
> 
> This adds a new feature: LINK_INBAND_ENABLE and at the same time fixes
> the Lynx PCS's long standing problem that the registers (specifically
> IF_MODE, but others could be misconfigured as well) are not written by
> the driver to the known valid values for 2500base-x.
> 
> Co-developed-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

This looks to be incomplete - if AN is now supported at 2500base-X,
lynx_pcs_get_state_2500basex() is obsolete. As with 1000base-X,
phylink_mii_c22_pcs_get_state() can be called to retrieve the state
and it will do the right thing wrt 2.5G speeds.

Next, please look at whether lynx_pcs_link_up_2500basex() is necessary,
and whether the speed and duplex modes need to also be programmed for
1000base-X when inband is not enabled.

Essentially, by saying that inband is supported at 2.5G speeds as well
as 1G, both 1000base-X and 2500base-X should be treated the same way
by the PCS driver, so the code paths should be the same.

I note that SGMII_SPEED_2500 == SGMII_SPEED_1000, which means the
IF_MODE programming as far as HD+speed should end up being the same
for both these interface modes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

