Return-Path: <netdev+bounces-118254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A6495115D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 03:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71A41C20B8D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 01:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E2AD59;
	Wed, 14 Aug 2024 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+D8nxAJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822CEA3B
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723597545; cv=none; b=Nc3Wr1djlQbwJIS72rn+MldlMLf+wyHS11XcJRz7uK+xjS4Wduh8Suryf19NTGef5G8jgkjdSUgwACrDcuHZVf2yVnwG+VQyzUQqdARyXsi+7o9/IuAqLzLj89K4QCna5UUxHzTF4MZz7il76VnJfcy0wZg8LvTJxjzNwK51XNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723597545; c=relaxed/simple;
	bh=y2bosLJeg6Y2WresWb4uDX5m9GvZVT8/aC8XiCKNmHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFur0XjnXG/LjR+9keYroU71uk6b9eybcOT/8f2g4LPxhrlwkPbvG/BPm8GuCozb1ROQDlliCg2dbA/7cAjOlPUOYj1n/RgXgeCDHEnekxsL49hq6Lewqu5YyvzY3yMIs4DbFtMg39aaDHcz9kdh2kHMQ0gsf40bb/vFYl0wwfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+D8nxAJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723597542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YkRhfAskJxHibVQ1Z2AjBj3U9TOqwYe1BypQBib3gVo=;
	b=e+D8nxAJPRCDCEiG1jQ4+zrM1zcupRGghNGS/hkPtBMacWb2GF9tXY9vLYV7zAnK+J9IOz
	fRpT5jzT9St7LxNf1mbr52RsaJbTl/4GdqrlG192Xr8+MtWrFMuOtj1K8ASWi4Pd9l71ud
	UMSvpEyfQe0CPkpz5IIft5A33HEKapc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-jCXCl_F7O6isQtRU1Ryj4Q-1; Tue, 13 Aug 2024 21:05:40 -0400
X-MC-Unique: jCXCl_F7O6isQtRU1Ryj4Q-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-70947f2854dso6632894a34.3
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 18:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723597540; x=1724202340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkRhfAskJxHibVQ1Z2AjBj3U9TOqwYe1BypQBib3gVo=;
        b=U/ZAut9R6thPHm+5GbOhwaYMnd0a9sszfVfEeoBELQDwxVmDPdzmmf2IncTJ/8/eoH
         m1lCubvnBjfZ6SF5yt8OxhWsN0XJJv6LPPQT3b7ojefiyN1c1CfPURvRuu8mV+jaLrCa
         RmvbxeXfwtBrv7EGAkKlnmoM8ylTB5IeOSIRMtsdJZ+9XL24PF6jWFipANZ3j2yMVbdG
         OQE9mIH9WhsQvQgngYAwUQ1UoXwk67Frx6peeT/8X/68PwNCW3qi87eG5DUQ4PQonQqE
         GfKlXmop8OlYEHd+dE1yVtdpc04kpV5YgKZE70IX+dbElVBhUVNDbwnsiKdXXcALnIlP
         OyIw==
X-Forwarded-Encrypted: i=1; AJvYcCUi5bH3NPPe32RvoLVHjISvrXWXY0vzfcYHMtY9wURZVb71dh4F1da1jary7c0g0ZVA5DMrq8QWcPbF6aeRGeHHnDaN0d6D
X-Gm-Message-State: AOJu0YwBChP5xzQa4I4Bbm2JVhWracU3iv1nw9qyI4jCaAUAi4BCd6jN
	6I372vO3sRVz7wzvk7ViaSNoBVDwk+HN0IAAWnEvWNUKbmBJVCuwicVaaR/rXkGy3GQNhgXcf6+
	FeSHrlTOPFSzjnpmDPBrbKIltyc+iTcxccL/G+cKtvtTqT80E9iiEmA==
X-Received: by 2002:a05:6358:5302:b0:1ac:f5fe:91c2 with SMTP id e5c5f4694b2df-1b1aaba69cemr156242055d.16.1723597539858;
        Tue, 13 Aug 2024 18:05:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFljkRr9u1gJGNOmLRfTXQOBTtcZ6xWeCaXGTurezGO2n8OOoydh4LqSLgX13QhG01z5W5OTg==
X-Received: by 2002:a05:6358:5302:b0:1ac:f5fe:91c2 with SMTP id e5c5f4694b2df-1b1aaba69cemr156238755d.16.1723597539290;
        Tue, 13 Aug 2024 18:05:39 -0700 (PDT)
Received: from x1gen2nano ([184.81.59.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d65006sm386009885a.1.2024.08.13.18.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 18:05:38 -0700 (PDT)
Date: Tue, 13 Aug 2024 20:05:36 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Giuseppe CAVALLARO <peppe.cavallaro@st.com>, Russell King <linux@armlinux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: Fix false "invalid port speed" warning
Message-ID: <kawkk44ngexucxsrybieysvp356rdfi3ypyskcx3l3dhe4g6sp@avjjgcb2ci7p>
References: <20240809192150.32756-1-fancer.lancer@gmail.com>
 <32bevr5jxmmm3ynnj3idpk3wdyaddoynyb7hv5tro3n7tsswwd@bbly52u3mzmn>
 <tcneleue5kvsn4ygf2mrrt6gpz5f47zz6sp2wveav5wr5glbhi@7thgrb44kt3m>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tcneleue5kvsn4ygf2mrrt6gpz5f47zz6sp2wveav5wr5glbhi@7thgrb44kt3m>

On Mon, Aug 12, 2024 at 07:48:34PM GMT, Serge Semin wrote:
> Hi Andrew
> 
> On Fri, Aug 09, 2024 at 03:41:04PM -0500, Andrew Halaney wrote:
> > On Fri, Aug 09, 2024 at 10:21:39PM GMT, Serge Semin wrote:
> > > If the internal SGMII/TBI/RTBI PCS is available in a DW GMAC or DW QoS Eth
> > > instance and there is no "snps,ps-speed" property specified (or the
> > > plat_stmmacenet_data::mac_port_sel_speed field is left zero), then the
> > > next warning will be printed to the system log:
> > > 
> > > > [  294.611899] stmmaceth 1f060000.ethernet: invalid port speed
> > > 
> > > By the original intention the "snps,ps-speed" property was supposed to be
> > > utilized on the platforms with the MAC2MAC link setup to fix the link
> > > speed with the specified value. But since it's possible to have a device
> > > with the DW *MAC with the SGMII/TBI/RTBI interface attached to a PHY, then
> > > the property is actually optional (which is also confirmed by the DW MAC
> > > DT-bindings). Thus it's absolutely normal to have the
> > > plat_stmmacenet_data::mac_port_sel_speed field zero initialized indicating
> > > that there is no need in the MAC-speed fixing and the denoted warning is
> > > false.
> > 
> 
> > Can you help me understand what snps,ps-speed actually does? Its turned
> > into a bool and pushed down into srgmi_ral right now:
> > 
> > 	/**
> > 	 * dwmac_ctrl_ane - To program the AN Control Register.
> > 	 * @ioaddr: IO registers pointer
> > 	 * @reg: Base address of the AN Control Register.
> > 	 * @ane: to enable the auto-negotiation
> > 	 * @srgmi_ral: to manage MAC-2-MAC SGMII connections.
> > 	 * @loopback: to cause the PHY to loopback tx data into rx path.
> > 	 * Description: this is the main function to configure the AN control register
> > 	 * and init the ANE, select loopback (usually for debugging purpose) and
> > 	 * configure SGMII RAL.
> > 	 */
> > 	static inline void dwmac_ctrl_ane(void __iomem *ioaddr, u32 reg, bool ane,
> > 					  bool srgmi_ral, bool loopback)
> > 	{
> > 		u32 value = readl(ioaddr + GMAC_AN_CTRL(reg));
> > 
> > 		/* Enable and restart the Auto-Negotiation */
> > 		if (ane)
> > 			value |= GMAC_AN_CTRL_ANE | GMAC_AN_CTRL_RAN;
> > 		else
> > 			value &= ~GMAC_AN_CTRL_ANE;
> > 
> > 		/* In case of MAC-2-MAC connection, block is configured to operate
> > 		 * according to MAC conf register.
> > 		 */
> > 		if (srgmi_ral)
> > 			value |= GMAC_AN_CTRL_SGMRAL;
> > 
> > 		if (loopback)
> > 			value |= GMAC_AN_CTRL_ELE;
> > 
> > 		writel(value, ioaddr + GMAC_AN_CTRL(reg));
> > 	}
> > 
> > 
> 
> In addition to the method above there are three more places related to
> the SGMRAL flag (SGMII Rate Adaptation Layer Control flag) setting up:
> 
> 2. drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> stmmac_probe_config_dt():
>   of_property_read_u32(np, "snps,ps-speed", &plat->mac_port_sel_speed);
> 
> Description: Retrieve the fixed speed of the MAC-2-MAC SGMII
> connection from DT-file.
> 
> 3. drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:
> stmmac_hw_setup():
>    if (priv->hw->pcs) {
> 	int speed = priv->plat->mac_port_sel_speed;
> 
> 	if ((speed == SPEED_10) || (speed == SPEED_100) ||
> 	    (speed == SPEED_1000)) {
> 		priv->hw->ps = speed;
> 	} else {
> 		dev_warn(priv->device, "invalid port speed\n");
> 		priv->hw->ps = 0;
> 	}
>    }
> 
> Description: Parse the speed specified via the "snps,ps-speed"
> property to make sure it's of one of the permitted values. Note it's
> executed only if the priv->hw->pcs flag is set which due to the
> current stmmac_check_pcs_mode() implementation is only possible if
> the DW GMAC/QoS Eth supports the SGMII PHY interface.
> 
> 4. drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c:
>    drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c:
>    drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:
> dwmac*_core_init():
>    if (hw->ps) {
> 	value |= GMAC_CONTROL_TE;

Might have missed it today when looking at this, but what's the
GMAC_CONTROL_TE bit about? Otherwise, I agree that mac_link_up()
basically does similar work at different times in the driver.

> 
> 	value &= ~hw->link.speed_mask;
> 	switch (hw->ps) {
> 	case SPEED_1000:
> 		value |= hw->link.speed1000;
> 		break;
> 	case SPEED_100:
> 		value |= hw->link.speed100;
> 		break;
> 	case SPEED_10:
> 		value |= hw->link.speed10;
> 		break;
> 	}
>    }
> 
> Description: Pre-initialize the MAC speed with the value retrieved from
> the "snps,ps-speed" property. The speed is then fixed in the SGMII
> Rate adaptation Layer by setting up the SGMIRAL flag performed in the
> dwmac_ctrl_ane() method you cited. 
> Note the same register fields (MAC_CONTROL.{PS,FES}) are touched in
> the stmmac_mac_link_up() method in the framework of the MAC-link up
> procedure (phylink_mac_ops::mac_link_up). But AFAICS the procedure is
> done too late, and after the SGMIRAL flag is set in the framework of
> the stmmac_open()->stmmac_hw_setup()->dwmac_ctrl_ane() call. That's
> probably why the MAC2MAC mode developer needed the speed being
> pre-initialized earlier in the dwmac*_core_init() functions.
> 
> 
> To sum up the MAC-2-MAC mode implementation can be described as
> follows:
> 1. The platform firmware defines the fixed link speed by means of the
> "snps,ps-speed" property (or by pre-initializing the
> plat_stmmacenet_data::mac_port_sel_speed field in the glue driver).
> 2. If the SGMII PHY interface is supported by the DW GMAC/QoS Eth
> controller, the speed will be fixed right at the network interface
> open() procedure execution by subsequently calling the
> stmmac_core_init() and stmmac_pcs_ctrl_ane() methods.
> 
> Please note I can't immediately tell of how that functionality gets to
> live with the phylink-based link setup procedure, in the framework of
> which the link speed is also setup in stmmac_mac_link_up(). Alas I
> don't have any SGMII-based device to test it out. But I guess that it
> lives well until the pre-initialized in the "snps,ps-speed"
> speed matches to the speed negotiated between the connected PHYs. If
> the speeds don't match, then I can't tell for sure what would happen
> without a hardware at hands.
> 
> > What is that bit doing exactly?
> 
> Here is what the DW MAC databook says about the bit:
> 
> "SGMII RAL Control
> 
> When set, this bit forces the SGMII RAL block to operate in the speed
> configured in the MAC Configuration register's Speed and Port Select
> bits. This is useful when the SGMII interface is used in a direct
> MAC-MAC connection (without a PHY) and any MAC must reconfigure the
> speed.
> 
> When reset, the SGMII RAL block operates according to the link speed
> status received on the SGMII (from the PHY)."
> 
> Shortly speaking the flag enables the SGMII Rate adaptation layer
> (SGMII RAL) to stop selecting the speed based on the info retrieved
> from the PHY and instead to fix the speed with the value specified in
> the MAC_CTRL_REG register.
> 
> > The only user upstream I see is
> > sa8775p-ride variants, but they're all using a phy right now (not
> > fixed-link aka MAC2MAC iiuc)... so I should probably remove it from
> > there too.
> 
> Right, there is only a single user of that property in the kernel. But
> I don't know what was the actual reason of having the "snps,ps-speed"
> specified in that case. From one side it seems contradicting to the
> original MAC-2-MAC semantics since the phy-handle property is also
> specified in the ethernet controller DT-node, but from another side it
> might have been caused by some HW-related problem so there was a need
> to fix the speed. It would be better to ask Bartosz Golaszewski about
> that since it was him who submitted the patch adding the sa8775p-ride
> Ethernet DT-nodes.
> 
> > 
> 
> > I feel like that property really (if I'm following right) should be just
> > taken from a proper fixed-link devicetree description? i.e. we already
> > specify a speed in that case. Maybe this predates that (or reinvents it)
> > and should be marked as deprecated in the dt-bindings.
> 
> Exactly my thoughts of the way it should have been implemented in the
> first place. The fixed-linked semantics was exactly suitable for the
> MAC-2-MAC HW-setup since both of them implies the link-speed being
> fixed to a single value with no PHY-node required.
> 
> Note if the respective code conversion is planned to be done then I
> guess it would be better to do after the Russell' series
> https://lore.kernel.org/netdev/ZrCoQZKo74zvKMhT@shell.armlinux.org.uk/
> is merged in, since the changes are related.
> 
> > 
> > But I'm struggling to understand what the bit is really doing based
> > on the original commit that added it, so I don't know if my logic is
> > solid. i.e., what's different in the phy case vs mac2mac with this
> > particular bit?
> 
> Please see my notes above for more details about the SGMRAL bit
> semantics. Shortly speaking The difference is basically in the way the
> link-speed is established:
> - If the SGMRAL bit is set the MAC' SGMII RAL will operate with the
>   speed specified in the Speed and Port Select bits of the
>   MAC_CTRL_REG register.
> - If the SGMRAL bit is reset the SGMII RAL will operate according to
>   the link speed status received on SGMII (from the PHY).

I think with all of that in mind, long term it might make sense to:

    1. Remove ps-speed handling
    2. Program GMAC_AN_CTRL in mac_link_up() as specified in the
       kerneldoc (i.e. iiuc only in !phylink_autoneg_inband(@mode) case)
    3. Program SGMRAL bit in pcs_config as specified in the kernel doc
       (iiuc mode == PHYLINK_PCS_NEG_OUTBAND)

I'm probably misunderstanding the phylink interactions while reading
on the plane today (and hence may have misunderstood what callbacks
should configure that and when), but in general sounds like the forward
looking step would be to build on top of Russell's PCS changes and rip out the
ps-speed stuff, relying on phylink to indicate what the speed / port
select stuff needs to be in the PCS and MAC in the various configs
possible (i.e. stop treating fixed-link special here).

Maybe Qualcomm can help with testing the SGMII fixed-link setup, as I
think they're the only folks I know of with a board with that at least.
I have acess to a sa8775p-ride, but that has SGMII with a phy so its not
going to cover all testing.

FYI.. I'm traveling the next two weeks, sorry in advance if I disappear
for a bit :)

Thanks,
Andrew


