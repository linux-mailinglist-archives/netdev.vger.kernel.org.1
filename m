Return-Path: <netdev+bounces-93369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E928BB526
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 23:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAEB28205B
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 21:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5570A2EB1D;
	Fri,  3 May 2024 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFMAhoIH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC52E84E
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770109; cv=none; b=fJeNMniFA+QgbKBoV9ZJlPXdFiTkshUFGDtYX9yj6mBkuzzBt+SThWvlvqpDU6ecf4Lrvaqg7unVnfwDQ0pKj9vCskg7MyG1J6WDqt+CpwQv2DpmH/tfmOjJwFB3CTR5ivd4UpdG+xO+/JmpTUy8krlQ54PAlowJKVeZDrw9u9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770109; c=relaxed/simple;
	bh=dWbXNNGNGH2u7Nlrki56r/uMDO5h3SSN8BF5tXfi2BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3QhBaKPcnpoPjQaYcdEq8ly5iitJrblI4PWrJz+9QPgz+usASkoQPzv1FnEUxmPZ4opo5iaEvfjw9BJCr7EJ3MEj3SOET5EfuW6sWngGPaS2rGGbrG52mJ+2tX8I7Q0DMR5yJIC55qsLyQEbM3YWWmJbpB+NDV8mOcTngi6XUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFMAhoIH; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so82798e87.1
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 14:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714770106; x=1715374906; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pmGcS635b6gKRsf+sqGVwDN7nw3JPq1D7Yxtah34o08=;
        b=UFMAhoIHzEbmBw+EfewnaTNqKbnJ0ZWwwp8isszIy5TtLyXhqkIfqE1izOqWT359DI
         0wiDZ1hsbqlnn06b3BMhjLzIDxMhFfpl+Nk4lZkmzZPIkPAn2lTiIUnxnNprakLv3krX
         m27/Lf2vx37M6rtCI91YzRedwtxSBU68zoRaoAa79tJ4UA8YHUvHRop/jiZ4/sa1qlIF
         pAl25Tzu5iBjFyBRDwiYcQhTAq/hPp/MAFmhNLlzmHcq9pSHzEosLyYGeAJYm8Virzao
         p1vql/8YgFbGKMZV0+K8Qlh5TMmBx2Lc6ekVvgigXohEJCouyZdZhyvuidm9nmS3w0fB
         SH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714770106; x=1715374906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmGcS635b6gKRsf+sqGVwDN7nw3JPq1D7Yxtah34o08=;
        b=vtrEZW93JEEnkGpHJe23e5zJ1Adjqcn6wXlhBjpm7DxydH7nvGhmMz3IASPGuk0BGM
         h+S+DGdKwg7uVBEr1aIxyqC2Y9iKW0IxiOsV6i94FeQv/BNRfPqcWBNJmoHTpn/3hszA
         i7gb1moi0jyDpLNm4AsClAjFrnn362eBT3xTV0CeVBawgka5V5qXgxqrf9cofwmysILA
         53DwsOl6mvBj85+S0eF3u7a6uk7FLIUov5bvm3sE4ZX5D3tI5JWNsPNhZ6F0IKBRycZM
         rwWCsVybmguIDC3iCaaGX1JH/98Gemu7q3hlPxKV2naKi9gsXL74yO7DInxpFfpR4GGj
         ZdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzx5Gq1IqoxPlT6rgDzX120Ujm0OrFqzrpjhZ3VnqXUIOe3gSplb9SFLeUZxGDtdnY9prsv9IOlczGlz1/KpSM7hRPVo3D
X-Gm-Message-State: AOJu0YwJI466SLpMJ8CthmnRyFp4qcTeqMuptxqzcvvtae8c+dQ2iKPh
	X8etPSaPEuxah8ZA+4dkdOKxvQdMLv9gThL3hj6hjzNUSUmW+6lk
X-Google-Smtp-Source: AGHT+IGznWBy64PjDJJixaCp8XFTJDrn+77GdM4plGGazV7dtzTH3S7gMSQurR53cAbrziE4qxNzHQ==
X-Received: by 2002:a05:6512:4810:b0:51e:e5cf:9940 with SMTP id eo16-20020a056512481000b0051ee5cf9940mr1087456lfb.4.1714770105518;
        Fri, 03 May 2024 14:01:45 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id l8-20020ac24308000000b0051d4e5b47afsm647030lfh.124.2024.05.03.14.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:01:44 -0700 (PDT)
Date: Sat, 4 May 2024 00:01:42 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Yanteng Si <siyanteng@loongson.cn>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, 
	hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, Jose.Abreu@synopsys.com, chenhuacai@kernel.org, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, 
	siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 09/15] net: stmmac: dwmac-loongson: Add
 phy_interface for Loongson GMAC
Message-ID: <eycodyo57suhzb4jgxjn5fmltzxogo6nszgnkvgak6lqarsw72@lz47ughdxy5r>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <d0ca47778a424a142abbfa7947d8413dfbffc104.1714046812.git.siyanteng@loongson.cn>
 <ZipqaHivDaK/FJAs@shell.armlinux.org.uk>
 <36afcb40-7e09-4a17-ad12-c27ac50120e1@loongson.cn>
 <ZiuJSY5oC8DWFAxk@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiuJSY5oC8DWFAxk@shell.armlinux.org.uk>

On Fri, Apr 26, 2024 at 12:00:25PM +0100, Russell King (Oracle) wrote:
> On Fri, Apr 26, 2024 at 06:16:42PM +0800, Yanteng Si wrote:
> > Hi Russell,
> > 
> > 在 2024/4/25 22:36, Russell King (Oracle) 写道:
> > > > The mac_interface of gmac is PHY_INTERFACE_MODE_RGMII_ID.
> > > No it isn't!
> > Ok, that's a typo.
> > > 
> > > > +	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
> > > You don't touch mac_interface here. Please read the big comment I put
> > > in include/linux/stmmac.h above these fields in struct
> > > plat_stmmacenet_data to indicate what the difference between
> > > mac_interface and phy_interface are, and then correct which-ever
> > > of the above needs to be corrected.
> > 
> > Copy your big comment here:
> > 
> >     int phy_addr;
> >     /* MAC ----- optional PCS ----- SerDes ----- optional PHY ----- Media
> >      *       ^                               ^
> >      * mac_interface                   phy_interface
> >      *
> >      * mac_interface is the MAC-side interface, which may be the same
> >      * as phy_interface if there is no intervening PCS. If there is a
> >      * PCS, then mac_interface describes the interface mode between the
> >      * MAC and PCS, and phy_interface describes the interface mode
> >      * between the PCS and PHY.
> >      */
> >     phy_interface_t mac_interface;
> >     /* phy_interface is the PHY-side interface - the interface used by
> >      * an attached PHY.
> >      */
> > 
> > Our hardware engineer said we don't support pcs, and if I understand
> > 
> > your comment correctly, our mac_interface and phy_interface should
> > 
> > be the same, right?
> 

> It only matters to the core code if priv->dma_cap.pcs is set true.
> If it isn't, then mac_interface doesn't seem to be relevent

Absolutely correct. Moreover AFAICS from the databooks the PCS module
is only available for the DW GMACs with the TBI, RTBI and SGMII
interfaces. So the STMMAC_PCS_RGMII PCS flag seems misleading. The only
info about the link state that could be runtime detected on the MAC
side is: link speed, duplex mode and link status. It's done by means
of the RGMII in-band status signals. That's what is implemented in the
dwmac1000_rgsmii() method. I've checked it works as soon as the
GMAC_INT_DISABLE_RGMII IRQ is unmask. But the RGMII-capable DW GMACs
don't support the Auto-negotiation feature, because it has no PCS
inside. Thus what has been implemented for the RGMII case in
stmmac_ethtool_get_link_ksettings() and
stmmac_ethtool_set_link_ksettings() seems incorrect to me.

> (it
> does get used by a truck load of platform specific code though
> which I haven't looked at to answer this.)

IMO the most of them are using the plat_stmmacenet_data::mac_interface
field as just an additional storage of the PHY-interface type. The
only cases which I would consider as validly using the field are the
ones with the SGMII interface support (and TBI/RTBI).

BTW I see the "mac-mode" DT-property support was introduced in 2019 by
the commit 0060c8783330 ("net: stmmac: implement support for passive
mode converters via dt"). The commit didn't touch any of the platform
drivers, but merely changed the plat_stmmacenet_data::mac_interface
semantics to containing the intermediate interface type if the
property was specified. So IMO all the platform drivers which had been
available by the time the change was introduced can be converted to
using the plat_stmmacenet_data::phy_interface field with a small
probability to break things.

I can't help but notice that since that commit there have been no any
DW MAC DT-node introduced with the "mac-mode" property specified. So
all of that makes me thinking that the code implemented around the
mac_interface data has been mainly unused and most likely was needless
overcomplication. Sigh...

> 
> I would suggest that if priv->dma_cap.pcs is false, then setting
> mac_interface to PHY_INTERFACE_MODE_NA to make it explicit that
> it's not used would be a good idea.

I bet it will be false. But Yanteng, could you please double check
that?

If it is could you convert this patch to setting
plat_stmmacenet_data::mac_interface with PHY_INTERFACE_MODE_NA by
default for all your device and setting the
plat_stmmacenet_data::phy_interface with PHY_INTERFACE_MODE_RGMII_ID
for the Loongson GMAC devices?

BTW Yanteng, are you sure it's supposed to
PHY_INTERFACE_MODE_RGMII_ID? AFAICS from the Loongson DTS files
(loongson64-2k1000.dtsi, ls7a-pch.dtsi) the phy-mode is just
PHY_INTERFACE_MODE_RGMII with no internal delays.

-Serge(y)

> 
> While looking at this, however, I've come across the fact that
> stmmac manipulates the netif carrier via netif_carrier_off() and
> netif_carrier_on(), which is a _big_ no no when using phylink.
> Phylink manages the carrier for the driver, and its part of
> phylink's state. Fiddling with the carrier totally breaks the
> guarantee that phylink will make calls to mac_link_down() and
> mac_link_up().
> 
> If a driver wants to fiddle with the netif carrier, it must NOT
> use phylink. If it wants to use phylink, it must NOT fiddle with
> the netif carrier state. The two are mutually exclusive.
> 
> stmmac is quickly becoming a driver I don't care about whether my
> changes to phylink end up breaking it or not because of abuses
> like this.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

