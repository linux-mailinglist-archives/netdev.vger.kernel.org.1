Return-Path: <netdev+bounces-158063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D86D1A1051A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 12:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B7F1887110
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4681128EC73;
	Tue, 14 Jan 2025 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jM6R8gP4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B462240223
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853322; cv=none; b=jPFZtnGVM7983oUupJvXR9h48kfjiNdfkVBP/l2bM7/eKOF0rcixRjFX2VTFHQX+ITbfeRQCeW1/87PxWCvDtlN38w2VrCXbMhyQ4PKQ8no/IvOCfa3iuLPgQA+T84x9IrBhafuUSGzFNCcYg11ofMdMapmLc/fOkB9KFCPAjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853322; c=relaxed/simple;
	bh=AHAYJtYLNi2WVuSK9ldR8/CoDuaQ0eI+FUTX1wm9rec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paNC03YkebNmSXRtvwiQo8FYMLfmsDrBFNN3Vha5DPP5ixhMM46Z8tzIKRN9wmvDI5JlX9U55I+g8hhUVLLvs3VRsAQdWahw1v3UsoMZ/rcPfiQrFuRIQy1oQQgQB54UqQJpoQxJHRoVU1MZcNOuySY2ijisfcuNXLp4TFUUlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jM6R8gP4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JZBQIV1rRjI0xYXaCOtBy163ScPwbEBWMDHXyIm/YjI=; b=jM6R8gP4ktl0i842LQaaCmoj98
	6Ff1EZ9aNhz4IzmwA6RXLfKqZ9bwN+vaYZHmD8wxjrWoS/Onmro4a8iii2dLVgVAQ0hDnL69WjM8w
	PVqxKHPtT4k7gxC1dtM/u3ex9NcN7gqXCt4l3NBuHjY/QiueQ9hCNSC94uM89fABajHYWv9EIww54
	LYKaas5cyWh20ZG5V4NYuILSG8oZHLK2LBsWvuVykDq2HRO0zLTMdMu1CewCdOtxJr0LjSFWSqnKw
	1pq63da8L2iVNQgqmwem41MgHO1QPsxWroRJTPSk82toIc2nU2RL+M+JXlnVY1AWJtSM1FAiIPn5Q
	xhSc19VQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55932)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tXesa-0007xA-2e;
	Tue, 14 Jan 2025 11:14:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tXesS-00052V-1M;
	Tue, 14 Jan 2025 11:14:32 +0000
Date: Tue, 14 Jan 2025 11:14:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Alexander Couzens <lynxis@fe80.eu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Golle <daniel@makrotopia.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>, kernel-team@meta.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next v2 0/5] net: phylink: fix PCS without autoneg
Message-ID: <Z4ZHGCu1G_26hd3n@shell.armlinux.org.uk>
References: <Z3_n_5BXkxQR4zEG@shell.armlinux.org.uk>
 <Z4TbDnXtG8f3SRmC@shell.armlinux.org.uk>
 <29240b2d-8a34-47d6-8b99-a371668b0bef@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29240b2d-8a34-47d6-8b99-a371668b0bef@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 14, 2025 at 11:59:06AM +0100, Eric Woudstra wrote:
> On 1/13/25 10:21 AM, Russell King (Oracle) wrote:
> > Hi,
> > 
> > Eric Woudstra reported that a PCS attached using 2500base-X does not
> > see link when phylink is using in-band mode, but autoneg is disabled,
> > despite there being a valid 2500base-X signal being received. We have
> > these settings:
> > 
> > 	act_link_an_mode = MLO_AN_INBAND
> > 	pcs_neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED
> > 
> > Eric diagnosed it to phylink_decode_c37_word() setting state->link
> > false because the full-duplex bit isn't set in the non-existent link
> > partner advertisement word (which doesn't exist because in-band
> > autoneg is disabled!)
> > 
> > The test in phylink_mii_c22_pcs_decode_state() is supposed to catch
> > this state, but since we converted PCS to use neg_mode, testing the
> > Autoneg in the local advertisement is no longer sufficient - we need
> > to be looking at the neg_mode, which currently isn't provided.
> > 
> > We need to provide this via the .pcs_get_state() method, and this
> > will require modifying all PCS implementations to add the extra
> > argument to this method.
> > 
> > Patch 1 uses the PCS neg_mode in phylink_mac_pcs_get_state() to correct
> > the now obsolute usage of the Autoneg bit in the advertisement.
> > 
> > Patch 2 passes neg_mode into the .pcs_get_state() method, and updates
> > all users.
> > 
> > Patch 3 adds neg_mode as an argument to the various clause 22 state
> > decoder functions in phylink, modifying drivers to pass the neg_mode
> > through.
> > 
> > Patch 4 makes use of phylink_mii_c22_pcs_decode_state() rather than
> > using the Autoneg bit in the advertising field.
> > 
> > Patch 5 may be required for Eric's case - it ensures that we report
> > the correct state for interface types that we support only one set
> > of modes for when autoneg is disabled.
> > 
> > Changes in v2:
> > - Add test for NULL pcs in patch 1
> > 
> > I haven't added Eric's t-b because I used a different fix in patch 1.
> 
> So I tested this V2 patch and with the first link up command, I get the
> link up which is functional end to end.
> 
> Tested-by: Eric Woudstra <ericwouds@gmail.com>
> 
> PS, FYI: I do however still have the difference in phylink_mac_config().
> 
> At first the link is up with (before phy attached):
> phylink_mac_config: mode=inband/2500base-x
> 
> When the phy is attached, phylink_mac_config() is not called, but we
> have functional link.
> 
> When I do: ethtool -s eth1 advertise 0x28, then:
> phylink_mac_config: mode=inband/sgmii
> 
> And back again: ethtool -s eth1 advertise 0x800000000028, then:
> phylink_mac_config: mode=phy/2500base-x
> 
> I can share more log entries if needed.

I'm not worried - there's a sixth patch that I need to send once this
set of five are merged that will fix the above weirdness.

Thanks for testing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

