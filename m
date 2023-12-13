Return-Path: <netdev+bounces-56966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC33A811784
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C521C20C43
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5D23306B;
	Wed, 13 Dec 2023 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWDH10r0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC213C39;
	Wed, 13 Dec 2023 07:27:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50c05ea5805so8339336e87.0;
        Wed, 13 Dec 2023 07:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702481278; x=1703086078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vcu9z/fG3mvtC4sTQWKLDyPuKX4cPyylkV7syb1LtxQ=;
        b=CWDH10r01g7re+qCbz/lfgM1bRlaHPOei8qPhaWFVI40lzFqHpvvdm9LzdbpwwN2Ei
         HN3AYHnAmiGfNS+uysu4Jo6VOLGBcs/MnUgRpxrLc6Z4K8faX9j0zrpBcMPrYYEiwxwJ
         3ysA1YSW2R3RgyuD792ZPeyWOf52Mw+ZIC/d2zBkFmoIgfXRZC0xkdh7QYHpBXbnN6/H
         6+EGLvIwiTmnhj5HSfxnoUBtEdSWF6/6MtyX6o0PzYy0Q7EmSyVZbbpgrbl2utl3UeQL
         /8MGlJlmJhs1zfrPac34jpNTvdPFA4Ju1+Qx4aPsOp1sUZL7sxpTy84S0SQzrgKmVSdg
         I7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702481278; x=1703086078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcu9z/fG3mvtC4sTQWKLDyPuKX4cPyylkV7syb1LtxQ=;
        b=hnG1q0tkbcpVLSEX91S/FZmFx4I1DVENfi5mHQPvKvGkkSet0JsMykPSi6tgmbn6Wx
         l5o2IoAcfh8uh8ldNFn/12fK9/HrwyzfjycBX+G1oLmtUvEHjSnR4bmLll1Kf2uuD9SB
         Q7eJ//ZN0DcTm8viSrIW83//gf1jDAJlCRTnxXZMsR1CxXmr/8LAR6cdh2H4wPBNRllG
         INY2N0qCdSb/nIsmALCYnh8tM4C8vwphoHaSWjFAPlSimKNq+mUTLCww/LLeOBFHB4Wi
         NeZjVrwh4W8p2Q6Szva7pVrj7KJq9eRJ0hCDS5AxmUysFyKrtHtdoIpnmLSspJ4t2swt
         IV0g==
X-Gm-Message-State: AOJu0YxBpp8BUjf2GGWkrDb0VUQQqvRRW7axKlQUVIoZ5LnALSDjz7YW
	57PVmxJu9o7m7mMfqF6zWR8=
X-Google-Smtp-Source: AGHT+IG20zIu9IgmaWg0JorODZUkVG4iYfjNdT8CuX3p2RzEFn907upn4oVLIeVdXst9pwUU1EXyig==
X-Received: by 2002:a19:5e1d:0:b0:50b:d9fc:7bca with SMTP id s29-20020a195e1d000000b0050bd9fc7bcamr3438591lfb.134.1702481277255;
        Wed, 13 Dec 2023 07:27:57 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id i23-20020ac25237000000b0050e02507a0csm729096lfl.221.2023.12.13.07.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:27:56 -0800 (PST)
Date: Wed, 13 Dec 2023 18:27:53 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Russell King <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/16] net: pcs: xpcs: Avoid creating dummy XPCS
 MDIO device
Message-ID: <wnptneaxxe2tq2rf7ac6a72xtyluyggughvmtxbbg5qto64mpa@7gchl5e4qllu>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <20231205103559.9605-7-fancer.lancer@gmail.com>
 <20231205115234.7ntjvymurot5nnak@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205115234.7ntjvymurot5nnak@skbuf>

Hi Vladimir,

On Tue, Dec 05, 2023 at 01:52:34PM +0200, Vladimir Oltean wrote:
> On Tue, Dec 05, 2023 at 01:35:27PM +0300, Serge Semin wrote:
> > If the DW XPCS MDIO devices are either left unmasked for being auto-probed
> > or explicitly registered in the MDIO subsystem by means of the
> > mdiobus_register_board_info() method
> 

> mdiobus_register_board_info() has exactly one caller, and that is
> dsa_loop. I don't understand the relevance of it w.r.t. Synopsys XPCS.
> I'm reading the patches in order from the beginning.

Well, one user of the DW XPCS driver is updated in this series in the
framework of the patch:
[PATCH net-next 13/16] net: stmmac: intel: Register generic MDIO device
https://lore.kernel.org/netdev/20231205103559.9605-14-fancer.lancer@gmail.com/

I can convert of them (it's sja1105 and wangxun txgbe) and then just
drop the MDIO-device creation part from xpcs_create_mdiodev(). As I
also described in another emails thread below this patch I used to
think that unmasking non-PHY device is also appropriate to get the
MDIO-device instance. I was wrong in that matter obviously.

Anyway I just realized that my solution of using
mdiobus_register_board_info() is a bit clumsy. Moreover the patch 13
(see the link above) shouldn't have the mdio_board_info instance
allocation (it can be defined on stack) and most importantly is wrong
in using the device-managed resources for it. The problem is that
mdiobus_register_board_info() registers an MDIO-device once for entire
system lifetime. It isn't that suitable for the hot-swappable devices
and for drivers bind/unbind cases. Since there is no
mdio_board_info-deregistration method, at the simplest case the no
longer used board-info descriptors might be left registered if a
device or driver are unloaded. That's why the device-managed
allocation is harmful in such scenario. At the very least I'll need to
convert the allocations to being non-managed.

> 
> > there is no point in creating the dummy MDIO device instance in order
> 

> Why dummy? There's nothing dummy about the mdio_device. It's how the PCS
> code accesses the hardware.

I call it 'dummy' because no actual device is registered (though
'redundant' or similar definition might sound more appropriate). The
entire structure is used as a communication layer between the XPCS
driver and MDIO device, where the device address is the only info
needed. Basically nothing prevents us from converting the current DW
XPCS driver to using the mdiobus_c45_read()/mdiobus_c45_write()
methods. Though in that case I wouldn't be able to easily add the
fwnode-based MDIO-devices support.

> 
> > to get the DW XPCS handler since the MDIO core subsystem will create
> > the device during the MDIO bus registration procedure.
> 

> It won't, though? Unless someone is using mdiobus_register_board_info()
> possibly, but who does that?

As I said above I wrongly assumed that unmasking non-PHY device was
ok. But mdiobus_register_board_info() could be used for that as I (a
bit clumsy) demonstrated in the patch 13.

> 
> > All what needs to be done is to just reuse the MDIO-device instance
> > available in the mii_bus.mdio_map array (using some getter for it
> > would look better though). It shall prevent the XPCS devices been
> > accessed over several MDIO-device instances.
> > 
> > Note since the MDIO-device instance might be retrieved from the MDIO-bus
> > map array its reference counter shall be increased. If the MDIO-device
> > instance is created in the xpcs_create_mdiodev() method its reference
> > counter will be already increased. So there is no point in toggling the
> > reference counter in the xpcs_create() function. Just drop it from there.
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> 

> Sorry, because the commit log lost me at the "context presentation" stage,
> I failed to understand the "what"s and the "why"s.
> 
> Are you basically trying to add xpcs support on top of an mdio_device
> where the mdio_device_create() call was made externally to the xpcs code,
> through mdiobus_register_board_info() and mdiobus_setup_mdiodev_from_board_info()?

Basically yes, but there is more of it. The main idea is to convert
the XPCS driver to using the already created non-PHY MDIO-devices
instead of manually creating a 'dummy'/'redundant' one. From my point
of view there are several reasons of doing so:

1. mdiobus_register_board_info() provides a way to assign the device
platform data to being registered afterwards device. Thus we can pass
some custom data to the XPCS-device driver (whether it's just an
xpcs_create_*() call or a fully functional MDIO-device driver
registered by the mdio_driver_register() method). For instance it can
be utilized to drop the fake PHYSIDs implementation from
drivers/net/dsa/sja1105/sja1105_mdio.c .

2. The MDIO-devices actually registered on the MDIO-bus will be
visible in sysfs with for instance useful IO statistics provided by
the MDIO-bus. Potentially (if it is required) at some point we'll be
able to convert the DW XPCS driver to being true MDIO-device driver
(bindable to the DW XPCS device) with less efforts.

3. Having an MDIO-device registered that way would make the DW XPCS
IO-device implementation unified after the fwnode-based XPCS
descriptor creation support is added in one of the subsequent patches.

So based on the listed above I've got a question. Do you think all of
that is worth to be implemented? Andrew, Russell?

I am asking because the patchset advance depends on your answers. If
you do I'll need to fix the problem described in my first message,
implement some new mdiobus_register_board_info()-like but
MDIO-bus-specific interface function (so MDIO-device infos would be
attached to the allocated MDIO-bus and then used to register the
respective MDIO-devices on the MDIO-bus registration), then convert
the sja1105 and wangxun txgbe drivers to using it. If you don't I'll
get back the xpcs_create_mdiodev() implementation and just provide a
fwnode-based version of one.

Note we already settled that converting DW XPCS driver to being normal
MDIO-device driver is prone to errors at this stage due to a
possibility to have the driver unbindable from user-space. I'll just
move the DT-compatibles check to the xpcs_create_fwnode() method and
drop the rest of the MDIO-device-driver-specific things.

-Serge(y)

