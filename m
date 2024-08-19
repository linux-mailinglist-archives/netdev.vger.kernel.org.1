Return-Path: <netdev+bounces-119733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8BF956C6E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032501C203F3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2289116C69A;
	Mon, 19 Aug 2024 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2689hdt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA516A920;
	Mon, 19 Aug 2024 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075365; cv=none; b=pBsdFgm0K0IUdZDW8VN8HxPLexxgJJf4erlEoeSTdgBQ0WPY/iSHwhUvNmPTbKjdgmuKVQFWSmYSR+2pNzxipS1cUmMIS9WBUe6m+qKsyVr152pmWHJ+o8RSV1qDxep/y3VLVIjZ6YRsrMThfofI2ZYfvzDR8ZTMPdQlfKZMc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075365; c=relaxed/simple;
	bh=98KBjpfeb+jau8Vn/lG+FAiapdT8hW6FKtash7zz2/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIC10asBlEv2F7rfcv0yO8Exwto19+XX85lT74SK75kbjkM1nT+UQKCaXa6JrtnXDe3Hlrgnll6n/oB7xK0gabaJ+3bu+kL10eyuRRG9P9SkGBg+bEmb2BjvhWfUNhHwis323oanom953jbFFl0ZEKiLeHo1aDbp0hb+ZKAKHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2689hdt; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5314c6dbaa5so5793662e87.2;
        Mon, 19 Aug 2024 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724075361; x=1724680161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GgellENjkAC0oDUu9zDn0Phd3BGDigsPQFZK0uSyBck=;
        b=b2689hdtiJmSwxsGF8vfhCK9bNaJyyEXSwo2IFGfZsa3i7uZ+5HQ7Lar3zQKYNLjhF
         20gV7KoW6Rxg1uN5+uGA3oXRSgS1KGh7Nxd7zUf7Zxw4hQUjueO4cm1V7c9s5RCkIXhh
         6Qtsm6d67XVmsA4hMLY6Hj6F0US+lhNfTU4abTDtJjya+EF+Zg2tMtqb+uQNhvnKNHR9
         FiKwL2FXEuq8LeWyYtYMQKm+VxIa3sMYgSmGDFMqjYJf8AKyKOd5chz4hAirtDbs/F15
         h4umnqIDTz0wqOfks9/7ncfEt5W2n0Rmbv+Ey1z6kC5htVwvy5Nc2SSU2vaeEvG4eD9Q
         etmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724075361; x=1724680161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgellENjkAC0oDUu9zDn0Phd3BGDigsPQFZK0uSyBck=;
        b=Sk3hy/6oa08B6Y284P6GcqE3wSt6BKX0qGswf0mwrCWAbuM5uJThcGSGSinbkWCiGr
         NB1yKTPGcZGLGLXJAdzGPjiLzvNdvhuHIh72wk6CSeGv5xZC1z4f/eW3Ngk5Q8hZNmzi
         jsZ7QE9cHN3F6vG/qXBl72AHrnT6fMOUUzJJNb0Xz0FTXOPWdBX632O+iO9cD7D2p/iz
         haRUYilq3DEPO7Xo2d4v5zuYgi9lMOe5l6YUrsMxw5MNX97lKrE2r7EZv7nUverksjZ1
         Zv0OAI5/maM7y3pFuydVPzBTImyeVEiHQiukZJAtehOHP6YIk9jUe3Yb79Zd9dloNzeB
         3JYw==
X-Forwarded-Encrypted: i=1; AJvYcCWTFKIvMaPHffJOpceKEAN6XuMq+a6V7cOw2usc+RicZTmpizOVJP66LPcFAqYMzDXbXVDU2pg7svA203MMWwX5PI1IoXGNVp7qmXg9unRCVXWsv+OL4b3ZJZdOEFcmOSOuOrV7
X-Gm-Message-State: AOJu0YwQ3/AvBxueAS6z+xTJ6V70O45pzx1CS4RVzQuanLh/xOMvxOJY
	0e0jVGR6NOGMmRB978n2SKqaQAjFMV5SHpGrzF0gKwin2UviW1k27Xa5UQ==
X-Google-Smtp-Source: AGHT+IGAQqDu7sXGRuHXtxrXdNIvNzsAl6f2Ihb5sjbF/DzRnYJtYwL6ynEv8wGX5nbPkA2r68rMSQ==
X-Received: by 2002:a05:6512:2821:b0:52c:dfe6:6352 with SMTP id 2adb3069b0e04-5331c6dca19mr8251869e87.48.1724075360523;
        Mon, 19 Aug 2024 06:49:20 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d3b905fsm1546414e87.98.2024.08.19.06.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 06:49:19 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:49:17 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Giuseppe CAVALLARO <peppe.cavallaro@st.com>, Russell King <linux@armlinux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: Fix false "invalid port speed" warning
Message-ID: <wbjdg3woviamust2ukw3og7jlrho2cxruxdz2xxcwgbtik7lwf@6ipyg4nml6c4>
References: <20240809192150.32756-1-fancer.lancer@gmail.com>
 <32bevr5jxmmm3ynnj3idpk3wdyaddoynyb7hv5tro3n7tsswwd@bbly52u3mzmn>
 <tcneleue5kvsn4ygf2mrrt6gpz5f47zz6sp2wveav5wr5glbhi@7thgrb44kt3m>
 <kawkk44ngexucxsrybieysvp356rdfi3ypyskcx3l3dhe4g6sp@avjjgcb2ci7p>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kawkk44ngexucxsrybieysvp356rdfi3ypyskcx3l3dhe4g6sp@avjjgcb2ci7p>

On Tue, Aug 13, 2024 at 08:05:36PM -0500, Andrew Halaney wrote:
> On Mon, Aug 12, 2024 at 07:48:34PM GMT, Serge Semin wrote:
> > Hi Andrew
> > 
> > On Fri, Aug 09, 2024 at 03:41:04PM -0500, Andrew Halaney wrote:
> > > On Fri, Aug 09, 2024 at 10:21:39PM GMT, Serge Semin wrote:
> > > > If the internal SGMII/TBI/RTBI PCS is available in a DW GMAC or DW QoS Eth
> > > > instance and there is no "snps,ps-speed" property specified (or the
> > > > plat_stmmacenet_data::mac_port_sel_speed field is left zero), then the
> > > > next warning will be printed to the system log:
> > > > 
> > > > > [  294.611899] stmmaceth 1f060000.ethernet: invalid port speed
> > > > 
> > > > By the original intention the "snps,ps-speed" property was supposed to be
> > > > utilized on the platforms with the MAC2MAC link setup to fix the link
> > > > speed with the specified value. But since it's possible to have a device
> > > > with the DW *MAC with the SGMII/TBI/RTBI interface attached to a PHY, then
> > > > the property is actually optional (which is also confirmed by the DW MAC
> > > > DT-bindings). Thus it's absolutely normal to have the
> > > > plat_stmmacenet_data::mac_port_sel_speed field zero initialized indicating
> > > > that there is no need in the MAC-speed fixing and the denoted warning is
> > > > false.
> > > 
> > 
> > > Can you help me understand what snps,ps-speed actually does? Its turned
> > > into a bool and pushed down into srgmi_ral right now:
> > > 
> > > 	/**
> > > 	 * dwmac_ctrl_ane - To program the AN Control Register.
> > > 	 * @ioaddr: IO registers pointer
> > > 	 * @reg: Base address of the AN Control Register.
> > > 	 * @ane: to enable the auto-negotiation
> > > 	 * @srgmi_ral: to manage MAC-2-MAC SGMII connections.
> > > 	 * @loopback: to cause the PHY to loopback tx data into rx path.
> > > 	 * Description: this is the main function to configure the AN control register
> > > 	 * and init the ANE, select loopback (usually for debugging purpose) and
> > > 	 * configure SGMII RAL.
> > > 	 */
> > > 	static inline void dwmac_ctrl_ane(void __iomem *ioaddr, u32 reg, bool ane,
> > > 					  bool srgmi_ral, bool loopback)
> > > 	{
> > > 		u32 value = readl(ioaddr + GMAC_AN_CTRL(reg));
> > > 
> > > 		/* Enable and restart the Auto-Negotiation */
> > > 		if (ane)
> > > 			value |= GMAC_AN_CTRL_ANE | GMAC_AN_CTRL_RAN;
> > > 		else
> > > 			value &= ~GMAC_AN_CTRL_ANE;
> > > 
> > > 		/* In case of MAC-2-MAC connection, block is configured to operate
> > > 		 * according to MAC conf register.
> > > 		 */
> > > 		if (srgmi_ral)
> > > 			value |= GMAC_AN_CTRL_SGMRAL;
> > > 
> > > 		if (loopback)
> > > 			value |= GMAC_AN_CTRL_ELE;
> > > 
> > > 		writel(value, ioaddr + GMAC_AN_CTRL(reg));
> > > 	}
> > > 
> > > 
> > 
> > In addition to the method above there are three more places related to
> > the SGMRAL flag (SGMII Rate Adaptation Layer Control flag) setting up:
> > 
> > 2. drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > stmmac_probe_config_dt():
> >   of_property_read_u32(np, "snps,ps-speed", &plat->mac_port_sel_speed);
> > 
> > Description: Retrieve the fixed speed of the MAC-2-MAC SGMII
> > connection from DT-file.
> > 
> > 3. drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:
> > stmmac_hw_setup():
> >    if (priv->hw->pcs) {
> > 	int speed = priv->plat->mac_port_sel_speed;
> > 
> > 	if ((speed == SPEED_10) || (speed == SPEED_100) ||
> > 	    (speed == SPEED_1000)) {
> > 		priv->hw->ps = speed;
> > 	} else {
> > 		dev_warn(priv->device, "invalid port speed\n");
> > 		priv->hw->ps = 0;
> > 	}
> >    }
> > 
> > Description: Parse the speed specified via the "snps,ps-speed"
> > property to make sure it's of one of the permitted values. Note it's
> > executed only if the priv->hw->pcs flag is set which due to the
> > current stmmac_check_pcs_mode() implementation is only possible if
> > the DW GMAC/QoS Eth supports the SGMII PHY interface.
> > 
> > 4. drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c:
> >    drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c:
> >    drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:
> > dwmac*_core_init():
> >    if (hw->ps) {
> > 	value |= GMAC_CONTROL_TE;
> 

> Might have missed it today when looking at this, but what's the
> GMAC_CONTROL_TE bit about? Otherwise, I agree that mac_link_up()
> basically does similar work at different times in the driver.

This bit enables the DW GMAC Transmission engine: "When this bit is
set, the transmit state machine of the MAC is enabled for transmission
on the GMII or MII." So by setting that flag the driver actually
_actiavates_ the MAC to transmission the data to the link. I have very
much doubt whether it's legitimate to do that at this stage.

Honestly this is the most mysterious part for me in the MAC2MAC
implementation, because I failed to find any reason of why it was
necessary to activate the transmissions so early before any of the
following up configs are done. This is normally done at the tail of
the MAC-link up initialization procedure (see the stmmac_mac_set()
method calls). So there is a good chance that the code author confused
the GMAC_CONTROL.TE flag with GMAC_CONTROL.TC flag. The later flag is
actually responsible for the GMAC duplex, speed and link up/down
setups transmission to the RGMII/SGMII/TBI/RTBI link-partner (PHY or
another MAC in the MAC2MAC config). So IMO the GMAC_CONTROL.TC flag
should have be set here instead. But I don't have a device to try it
out.

> 
> > 
> > 	value &= ~hw->link.speed_mask;
> > 	switch (hw->ps) {
> > 	case SPEED_1000:
> > 		value |= hw->link.speed1000;
> > 		break;
> > 	case SPEED_100:
> > 		value |= hw->link.speed100;
> > 		break;
> > 	case SPEED_10:
> > 		value |= hw->link.speed10;
> > 		break;
> > 	}
> >    }
> > 
> > Description: Pre-initialize the MAC speed with the value retrieved from
> > the "snps,ps-speed" property. The speed is then fixed in the SGMII
> > Rate adaptation Layer by setting up the SGMIRAL flag performed in the
> > dwmac_ctrl_ane() method you cited. 
> > Note the same register fields (MAC_CONTROL.{PS,FES}) are touched in
> > the stmmac_mac_link_up() method in the framework of the MAC-link up
> > procedure (phylink_mac_ops::mac_link_up). But AFAICS the procedure is
> > done too late, and after the SGMIRAL flag is set in the framework of
> > the stmmac_open()->stmmac_hw_setup()->dwmac_ctrl_ane() call. That's
> > probably why the MAC2MAC mode developer needed the speed being
> > pre-initialized earlier in the dwmac*_core_init() functions.
> > 
> > 
> > To sum up the MAC-2-MAC mode implementation can be described as
> > follows:
> > 1. The platform firmware defines the fixed link speed by means of the
> > "snps,ps-speed" property (or by pre-initializing the
> > plat_stmmacenet_data::mac_port_sel_speed field in the glue driver).
> > 2. If the SGMII PHY interface is supported by the DW GMAC/QoS Eth
> > controller, the speed will be fixed right at the network interface
> > open() procedure execution by subsequently calling the
> > stmmac_core_init() and stmmac_pcs_ctrl_ane() methods.
> > 
> > Please note I can't immediately tell of how that functionality gets to
> > live with the phylink-based link setup procedure, in the framework of
> > which the link speed is also setup in stmmac_mac_link_up(). Alas I
> > don't have any SGMII-based device to test it out. But I guess that it
> > lives well until the pre-initialized in the "snps,ps-speed"
> > speed matches to the speed negotiated between the connected PHYs. If
> > the speeds don't match, then I can't tell for sure what would happen
> > without a hardware at hands.
> > 
> > > What is that bit doing exactly?
> > 
> > Here is what the DW MAC databook says about the bit:
> > 
> > "SGMII RAL Control
> > 
> > When set, this bit forces the SGMII RAL block to operate in the speed
> > configured in the MAC Configuration register's Speed and Port Select
> > bits. This is useful when the SGMII interface is used in a direct
> > MAC-MAC connection (without a PHY) and any MAC must reconfigure the
> > speed.
> > 
> > When reset, the SGMII RAL block operates according to the link speed
> > status received on the SGMII (from the PHY)."
> > 
> > Shortly speaking the flag enables the SGMII Rate adaptation layer
> > (SGMII RAL) to stop selecting the speed based on the info retrieved
> > from the PHY and instead to fix the speed with the value specified in
> > the MAC_CTRL_REG register.
> > 
> > > The only user upstream I see is
> > > sa8775p-ride variants, but they're all using a phy right now (not
> > > fixed-link aka MAC2MAC iiuc)... so I should probably remove it from
> > > there too.
> > 
> > Right, there is only a single user of that property in the kernel. But
> > I don't know what was the actual reason of having the "snps,ps-speed"
> > specified in that case. From one side it seems contradicting to the
> > original MAC-2-MAC semantics since the phy-handle property is also
> > specified in the ethernet controller DT-node, but from another side it
> > might have been caused by some HW-related problem so there was a need
> > to fix the speed. It would be better to ask Bartosz Golaszewski about
> > that since it was him who submitted the patch adding the sa8775p-ride
> > Ethernet DT-nodes.
> > 
> > > 
> > 
> > > I feel like that property really (if I'm following right) should be just
> > > taken from a proper fixed-link devicetree description? i.e. we already
> > > specify a speed in that case. Maybe this predates that (or reinvents it)
> > > and should be marked as deprecated in the dt-bindings.
> > 
> > Exactly my thoughts of the way it should have been implemented in the
> > first place. The fixed-linked semantics was exactly suitable for the
> > MAC-2-MAC HW-setup since both of them implies the link-speed being
> > fixed to a single value with no PHY-node required.
> > 
> > Note if the respective code conversion is planned to be done then I
> > guess it would be better to do after the Russell' series
> > https://lore.kernel.org/netdev/ZrCoQZKo74zvKMhT@shell.armlinux.org.uk/
> > is merged in, since the changes are related.
> > 
> > > 
> > > But I'm struggling to understand what the bit is really doing based
> > > on the original commit that added it, so I don't know if my logic is
> > > solid. i.e., what's different in the phy case vs mac2mac with this
> > > particular bit?
> > 
> > Please see my notes above for more details about the SGMRAL bit
> > semantics. Shortly speaking The difference is basically in the way the
> > link-speed is established:
> > - If the SGMRAL bit is set the MAC' SGMII RAL will operate with the
> >   speed specified in the Speed and Port Select bits of the
> >   MAC_CTRL_REG register.
> > - If the SGMRAL bit is reset the SGMII RAL will operate according to
> >   the link speed status received on SGMII (from the PHY).
> 
> I think with all of that in mind, long term it might make sense to:
> 

>     1. Remove ps-speed handling

I guess this can't be completely dropped due to the DT backward
compatibility requirement.

>     2. Program GMAC_AN_CTRL in mac_link_up() as specified in the
>        kerneldoc (i.e. iiuc only in !phylink_autoneg_inband(@mode) case)
>     3. Program SGMRAL bit in pcs_config as specified in the kernel doc
>        (iiuc mode == PHYLINK_PCS_NEG_OUTBAND)

(mode == MLO_AN_FIXED) seems more appropriate.

> 
> I'm probably misunderstanding the phylink interactions while reading
> on the plane today (and hence may have misunderstood what callbacks
> should configure that and when), but in general sounds like the forward
> looking step would be to build on top of Russell's PCS changes and rip out the
> ps-speed stuff, relying on phylink to indicate what the speed / port
> select stuff needs to be in the PCS and MAC in the various configs
> possible (i.e. stop treating fixed-link special here).

Sounds like a plan. But please note that it's normally prohibited to
break the DT properties functionality so the kernel would work on the
older platforms (although I have doubts there is any real device with
the MAC-2-MAC setup). In anyway it's better to wait for the Russell'
series to be merged in, and then think of the "snps,ps-speed"-related
code refactoring (perhaps in a dedicated emailing thread).

> 
> Maybe Qualcomm can help with testing the SGMII fixed-link setup, as I
> think they're the only folks I know of with a board with that at least.
> I have acess to a sa8775p-ride, but that has SGMII with a phy so its not
> going to cover all testing.

Very much hope they will, but there is a good chance they don't have
an appropriate device either (with the MAC-2-MAC setup). The original
code author was Giuseppe Cavallaro - former driver maintainer from
STmicroelectronics, who hasn't been activate in the driver support for
years. Alas there is no info left in the mailing list archive for what
device he has introduced the ps-speed property functionality.

> 
> FYI.. I'm traveling the next two weeks, sorry in advance if I disappear
> for a bit :)

No worries. I am quite busy currently too.)

-Serge(y)

> 
> Thanks,
> Andrew
> 

