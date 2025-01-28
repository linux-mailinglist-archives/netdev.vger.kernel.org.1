Return-Path: <netdev+bounces-161409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D03EA2118D
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 19:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C191886C8A
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF611DF270;
	Tue, 28 Jan 2025 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqatwjnw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899171DE8A5;
	Tue, 28 Jan 2025 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738088806; cv=none; b=A7fkh9h2u/bUBqeJv+09vXaBCKyOqoXvadyMEdp7LmwjXmeS468B8NJK/Gcat5atTgFq9k3s/Et2VcRLiNr7R7kueHEhGubOaWLOdDJ9pXiQDjBpg0zEpS4qifM8NVo6Gltj9Oqz7JJtVse17OS1POmCChGZXeEOQCqcmVxTenE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738088806; c=relaxed/simple;
	bh=Klu59aLxWn493WY42POkLoY6hkJutzcCfvvaYE8A1xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFGcaq/mzZEySF59c43x+uQwspfpLXFrQpp+CPt0MmqevKZ86obme4JLJTSMRdYPpcEFqh0Ozh8w6lFrtBP3BJnoMv8lAxNfT0HMj4kb87DYXTwG+HL4tUHkYEGm7onQe99yKz5MB6Tf33XS5wrHR7KChhlpEAd3XkB9d9iVcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqatwjnw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385d7fe2732so642515f8f.1;
        Tue, 28 Jan 2025 10:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738088803; x=1738693603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWbhuv3dm653StpvWrxOIX0qcv33ljtMgwEreLmvTIk=;
        b=KqatwjnwQ1qJ/PPQ9bCKaUQ9++zodzcdZNpfeY/lwq00DTjX5k53/5+jRgZi8Esokv
         PWf/ja4pwGU0Gt7Z8A9cxHjKMZYHvq6BD70/euiEteJaI0rajsZXhCNMdO6UYbbB8EAO
         KeKYfcbIbFhdlPBan+FIv0bIlMBcny5NTW8XKY8S6BSnMv/32Tn6inmjAjLIJrOTkf5/
         A6CxH7VVg5a8J7p/dlOs/TkyX6Gxk+vZgThaDwqoY/uVwKi+dyZa7XVDA2qLLtI0sL2i
         X1eZczi4Ff9TrVCTBrl0+5MZd5OSlRGLsfxzPEenmQ6TPncDqmo2hLHHyHDXIANwGc7r
         mkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738088803; x=1738693603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWbhuv3dm653StpvWrxOIX0qcv33ljtMgwEreLmvTIk=;
        b=SKFV0whCbQErj63OGr6y2YR+WcDvd+MiICmBXwY00xvWqku1SkuIVSJnOdhNOqwjHs
         Pwc6acT9a11FWKA6tVthJ1Su7pDONB15zYRHtFuuNDA1QIVWfdMfH/1GvQapDIbTGP5N
         Hi0Z37GnsaXQK5sDl/M/YZkGa87OD22JMzcroEakjcClnUJ5c0gNBRAq+RNJFqja/gjq
         6a55iFmt6nzwcFebH0qeRI2nadblVxeF0Fw17qSG05+z8L7nIQdZAyQ7ZcAfZC3rygfP
         3AMnUNCVLWrGH2miMi2gR2xM1PH+LxaT5BkF9Lq+ZKx3t5wFWyec58BAP0J5YW6rAsq7
         gKhg==
X-Forwarded-Encrypted: i=1; AJvYcCUn5kIyqf74U4ZXcllvxALY2TUEFRDIDYFPJ72EciIxPbKkj6NHYpnznBjuRVo+9Zu9Hg9SkJCI@vger.kernel.org, AJvYcCXDFDRJe4RrYie8bHc6v2Kdql1NZ7wxxNaWdduX0+OJ3nfkCtOEzrGVlogFFVt5xK2E3LQ8AfEUOw2GLHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVGQ+IZa3VBfR5O0/w4KvzWgruM3tmGK4D3PE0XbeQrH0ENlj
	AVGkaFIQ39kQh9nhAo/QFH5mMlW8lzuh22iTW5PV6PzciuhqhBhf
X-Gm-Gg: ASbGncvYkWFRHRcivzenltpMl9sIi5JzAefBkVFWzMw8Xcv9DzwjAi8IWXUOWNhq9Ak
	Huo3HOfb0FUqmdC8umQ8mc5TVpPp1UfkXuiA6yf1tNdtRo60RRtL6uZPqF3Ydv6u3DRBqMQduiK
	RhkEowvOpaV1tHCj41AFCxhhZ4znuxEgJQmkeJ6ktWyH8cfePmqDF5wx9u3PmEGXp9KspErAwiT
	QNhNBccKoVsUwAnsTyY1MEdrbrTIXBOFnOI7Tq3XUFpggH2y8PWDFkLq8yIg/V4a2QCf9fF9ey5
	3cE=
X-Google-Smtp-Source: AGHT+IEQBo0UHEQ0MrknygrPcc9HL1Jybfv3L/G0XszChlOhBS5p9mIK45a8sQjOO9tgcXuZ9i+kng==
X-Received: by 2002:a05:600c:1d0f:b0:434:a0fd:95d0 with SMTP id 5b1f17b1804b1-43891440a8amr160709855e9.4.1738088802444;
        Tue, 28 Jan 2025 10:26:42 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4857cesm174798235e9.13.2025.01.28.10.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 10:26:41 -0800 (PST)
Date: Tue, 28 Jan 2025 20:26:38 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <20250128182638.uz7xzdi6jnvtxi3m@skbuf>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <Z5kGhzWr2ZSxGdlX@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5kGhzWr2ZSxGdlX@shell.armlinux.org.uk>

On Tue, Jan 28, 2025 at 04:32:07PM +0000, Russell King (Oracle) wrote:
> I note that in the KSZ9477 documentation, bit[0] of VR_MII_DIG_CTRL1
> is marked as "reserved" and takes the value zero, so in the case of
> PHY-side SGMII, (6) always applies to KSZ9477 and (5) never does.

Good point. In human language, this means that when configuring the
KSZ9477 XPCS for the SGMII PHY role, it always expects the contents of
the autoneg code word to come from registers (VR_MII_AN_CTRL,
SR_MII_AN_ADV and SR_MII_CTRL), and never from input wires coming
from blocks external to the XPCS IP (xpcs_sgmii_link_sts_i,
xpcs_sgmii_full_duplex_i, xpcs_sgmii_link_speed_i[1:0]).

With the very important note that said SGMII PHY mode is still
under-specified in Linux, and the discussion about it still needs
to be had.

> This also solves my concern about 2a22b7ae2fa3 ("net: pcs: xpcs: adapt
> Wangxun NICs for SGMII mode"), because there (5) would apply.

Ok, so Wangxun shimmied in an operating mode where the XPCS does act
like a PHY, but receives the info about how to populate the autoneg
code word from wires, not from registers, and that's why Tristram is
noticing that the driver does not write the registers.

Not great, but at least the info we're gathering seems consistent thus far.

> > So my understanding is that SR_MII_AN_ADV needs to be written only if
> > TX_CONFIG=1 (SJA1105 calls this AUTONEG_CONTROL[PHY_MODE]).
> 
> Yes, agreed. Thankfully, SJA1105 sets PHY_MODE/TX_CONFIG=0 and leaves
> SGMII_PHY_MODE_CTRL unaltered. TXGBE sets TX_CONFIG=1 but sets
> SGMII_PHY_MODE_CTRL=1 which also avoids this requirement.

Correct, for SJA1105 I realized the mode where PHY_MODE/TX_CONFIG=1
isn't supported in phylink, and I didn't consider it important enough to
raise the issue, so it's simply not configurable that way. I was thinking,
just like we have phy-mode = "rev-mii" and "rev-rmii" for MII and RMII
in the role of a PHY, that something like "rev-sgmii" would be the way
to explore. But I really have no interest or use case to explore this myself.

> > That's quite
> > different, and that will make sense when you consider that there's also
> > a table with the places the autoneg code word gets its info from:
> > 
> > Config_Reg Bits in the 1000BASE-X and SGMII Mode
> > 
> >  +----------------+-------------------+--------------------+--------------------------------------------+
> >  | Config_Reg bit | 1000Base-X mode   | SGMII mode value   | SGMII mode value                           |
> >  |                |                   | when TX_CONFIG = 0 | when TX_CONFIG = 1                         |
> >  +----------------+-------------------+--------------------+--------------------------------------------+
> >  | 15             | Next page support | 0                  | Link up or down.                           |
> >  |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 0, |
> >  |                |                   |                    | this bit is derived from Bit 4             |
> >  |                |                   |                    | (SGMII_LINK_STS) of the VR_MII_AN_CTRL.    |
> >  |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 1, |
> >  |                |                   |                    | this bit is derived from the input port    |
> >  |                |                   |                    | 'xpcs_sgmii_link_sts_i'                    |
> >  +----------------+-------------------+--------------------+--------------------------------------------+
> >  | 14             | ACK               | 1                  | 1                                          |
> >  +----------------+-------------------+--------------------+--------------------------------------------+
> >  | 13             | RF[1]             | 0                  | 0                                          |
> >  +----------------+-------------------+--------------------+--------------------------------------------+
> >  | 12             | RF[0]             | 0                  | FULL_DUPLEX                                |
> >  |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 0, |
> >  |                |                   |                    | this bit is derived from Bit 5 (FD) of     |
> >  |                |                   |                    | the SR_MII_AN_ADV.                         |
> >  |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 1, |
> >  |                |                   |                    | this bit is derived from the input port    |
> >  |                |                   |                    | 'xpcs_sgmii_full_duplex_i'                 |
> >  +----------------+-------------------+--------------------+--------------------------------------------+
> >  | 11:10          | Reserved          | 0                  | SPEED                                      |
> >  |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 0, |
> >  |                |                   |                    | these bits are derived from Bit 13 (SS13)  |
> >  |                |                   |                    | and Bit 6 (SS6) of the SR_MII_CTRL.        |
> >  |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 1, |
> >  |                |                   |                    | this bit is derived from the input port    |
> >  |                |                   |                    | 'xpcs_sgmii_link_speed_i[1:0]'             |
> >  +----------------+-------------------+--------------------+--------------------------------------------+
> >  | 9              | Reserved          | 0                  | 0                                          |
> >  +----------------+-------------------+--------------------+--------------------------------------------+
> >  | 8:7            | PAUSE[1:0]        | 0                  | 0                                          |
> >  +----------------+-------------------+--------------------+--------------------------------------------+
> >  | 6              | HALF_DUPLEX       | 0                  | 0                                          |
> >  +----------------+-------------------+--------------------+--------------------------------------------+
> >  | 5              | FULL_DUPLEX       | 0                  | 0                                          |
> >  +----------------+-------------------+--------------------+--------------------------------------------+
> >  | 4:1            | Reserved          | 0                  | 0                                          |
> >  +----------------+-------------------+--------------------+--------------------------------------------+
> >  | 0              | Reserved          | 1                  | 1                                          |
> >  +----------------+-------------------+--------------------+--------------------------------------------+
> > 
> > I haven't figured out either what might be going on with the KSZ9477
> > integration, I just made a quick refresher and I thought this might be
> > useful for you as well, Russell. I do notice Tristram does force
> > TX_CONFIG=1 (DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII), but I don't understand
> > what's truly behind that. Hopefully just a misunderstanding.
> 
> If you want to peek at the KSZ9477 documentation, what I'm looking at is
> available from here:
> https://www.microchip.com/en-us/product/ksz9477#Documentation

Thanks.

> Interestingly, there are a number of errata:
> 
> Module 7 - SGMII auto-negotiation does not set bit 0 in the
> auto-negotiation code word
> Basically requires MII_ADVERTISE to be written as 0x1a0, and is only
> needed after power-up or reset.

Ok, I guess 0x1a0 would otherwise be the SR_MII_AN_ADV default value -
Nothing looks special about it. The layout of this register is the
table above. Bits 8:7 (PAUSE) and 5 (FULL_DUPLEX) are set, the rest
(NEXT_PAGE, REMOTE_FAULT, HALF_DUPLEX) are unset.

It's odd that writing this register would fix anything, especially
seeing that it isn't documented anywhere that bit 0 of the autoneg code
word would ever originate from SR_MII_AN_ADV in the 2 SGMII mode columns,
or would be affected by a modification of that register. But ok, I can't
contradict that...

It is under-specified whether the erratum occurs when TX_CONFIG is 1 or 0.
Unless specified otherwise, I am going to assume both modes.

I believe this erratum workaround should be implemented by Tristram;
I'm not seeing it in this patch.

> Module 8 - SGMII port link details from the connected SGMII PHY are not
> passed properly to the port 7 GMAC
> Basically, AUTONEG_INTR_STATUS needs to be read, and the PCS
> manually programmed for the speed.

Ok, I think this is answering my question to Tristram:
xpcs_link_up_sgmii_1000basex() needs to force the speed in MII_BMCR even
for PHYLINK_PCS_NEG_INBAND_ENABLED, where that otherwise shouldn't be
needed. It means that VR_MII_DIG_CTRL1[MAC_AUTO_SW] doesn't work? Bit 9
of "SGMII DIGITAL CONTROL REGISTER" is also hidden, and marked as reserved (0).

A reference to the KSZ9477 errata sheet module 8 in the code would be
nice. To me that is sufficient.

> Module 15 - SGMII registers are not initialized by hardware reset
> Requires that bit 15 of BASIC_CONTROL is set to reset the registers.

Nothing actionable here, the xpcs driver already performs reset.

> All three are not scheduled to be fixed, apparently.
> 
> There seems to be no information listed there regarding the requirement
> for SGMII PHY mode.

Not that I can find either.

> > Tristram, why do you set this field to 1? Linux only supports the
> > configuration where a MAC behaves like a MAC. There needs to be an
> > entire discussion if you want to configure a MAC to be a SGMII autoneg
> > master (like a PHY), how to model that.
> 
> (Using SJA1105 register terminology...)
> 
> Looking at the patch, Tristram is setting PHY_MODE=1 and SGMII_LINK=1
> not when configuring for SGMII, but when configuring for 1000base-X.

Yeah, you're right... (?!) Again, misunderstanding, I hope?

> This is reflected in the documentation for KSZ9477 - which states that
> both these bits need to be set in "SerDes" aka 1000base-X mode. The
> question is... where did that statement come from, and should we be
> doing that for 1000base-X mode anyway?

Here, because SJA1105 only supports SGMII and _not_ 1000Base-X, I don't
have practical experience. Thus I can only refer you to:

Programming Guidelines for Clause 37 Auto-Negotiation

The Clause 37 auto-negotiation is enabled only when Bit 12 of the
SR_MII_CTRL Register is set. For Backplane Ethernet configurations,
the default value of this bit is 0. For all other configurations, the
default value of this bit is 1. When this bit is enabled, the Clause 37
auto-negotiation is initiated on the following events:
- Power on Reset
- Soft Reset

The DWC_xpcs initiates the auto-negotiation on the following events:
- When the link partner requests auto-negotiation by transmitting
  configuration code groups.
- When the receive data path loses code group synchronization for more
  than 10 ms (in 1000BASE-X mode) or 1.6 ms (in SGMII mode).
- When an error condition is detected while receiving the /C/ or /I/
  order sets.
- When the host or software requests auto-negotiation by setting Bit 9
  in the SR_MII_CTRL Register.

The following list explains the auto-negotiation process:

1. The DWC_xpcs starts auto-negotiation by first transmitting the
   configuration words with all zeroes for 10 ms (1.6 ms for the SGMII
   interface).

2. The SR_MII_AN_ADV Register content is transmitted in the
   configuration words in the 1000BASE-X mode. In the SGMII mode, the
   values given in the "Config_Reg Bits in the 1000BASE-X and SGMII Mode"
   table are transmitted in the configuration word. The auto-negotiation
   is complete when both link partners have exchanged their base pages.

3. DWC_xpcs generates an interrupt on completion (sbd_intr_o) of
   auto-negotiation when Bit 0 of VR_MII_AN_CTRL Register is set to 1.

4. The auto-negotiation completion is indicated in the VR_MII_AN_INTR_STS
   register.

Note: In configurations with MDIO interface, you must read the
      VR_MII_AN_INTR_STS register after the auto-negotiation is complete.
      Auto-negotiation Status reads incorrect value when Status is not
      read in the previous Auto-negotiation session and MDC clock is not
      active when the Management is not accessing the PHY/PCS registers.
      Because of this limitation, Management may get incorrect
      information of Link partner and this can cause link failure.
      However, this limitation is not visible if the programming
      guidelines are followed as mentioned in the databook. This is
      because the minimum time between two successive auto-negotiations
      has at least 3.2ms and Management or Host is expected to read the
      current status of the Auto-negotiation before the next auto-negotiation
      is completed.

5. In the MAC attached to the DWC_xpcs, the Transmit and Receive Flow
   Control mode is determined based on the capabilities of the partner
   (given in SR_MII_LP_BABL) and the half-duplex or full-duplex
   operating mode.

   In SGMII auto-negotiation, the received link status such as speed,
   duplex mode is also given in the VR_MII_AN_INTR_STS Register.

   When Clause 37 auto-negotiation is complete, DWC_xpcs automatically
   resolves the duplex mode by selecting the duplex mode of its link
   partner. If auto-negotiation is disabled, the DWC_xpcs selects the
   duplex mode defined in Bit 8 of SR_MII_CTRL Register.

Nothing, in my reading, suggests to me that DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII
would be considered by the XPCS when operating in 1000Base-X mode
(DW_VR_MII_PCS_MODE_MASK == DW_VR_MII_PCS_MODE_C37_1000BASEX).

