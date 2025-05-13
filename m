Return-Path: <netdev+bounces-190148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB73AB54C7
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010103BA807
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCA01DE2BC;
	Tue, 13 May 2025 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sjemz6n5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7F7483;
	Tue, 13 May 2025 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139580; cv=none; b=mzcaKKJP1cHiMkOhfLFCaFeqJg2MwqVZtOr+jCfZW1NZ7KBnYVdHwhFpP9ycib9eda1AYTB6XO3aqpFvKReLpi1AoVq8/DX0A24GgxKgAq+eOOv20rLS7o5IpJJzJbeL1lm7mZUIYSglSEqMvW5aaF2L9RsLV2wX9KI6iAjMvtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139580; c=relaxed/simple;
	bh=mLMzTDvVEsw75/6eFnr/1KEDw3sumrUGXyc25RczOGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T52zaqPW0XTvEzJNf6jbi7FXhcJ8/P4Jt19C6p2Nrf8p0Fu5JFi6IIMx8hqsWrrW4Ogxtz5C7b1h2SnfdrJ8GuV8KC10YfofIkOAprRJXqj/zRUxe1e5jfrqLbSRCZ5cCHL0FE4YHszglLLh2ObjR37gl+V/W5YV1cCR9YUvVu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sjemz6n5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ikO6NxPSIIjD1kUAHzPCWxeEkTOjGoN0DmnRySn4PCk=; b=sj
	emz6n58GPUmWdFVzAHRjKI2dWuI0rPQE8SL/5bYfGaf3w24mGVb9f0MujMpWRRsD0Uf3JyFv5eIVp
	+S43WT3eawgxo08pQ0i2Yjr8Sx3wlWf9hSC9Jm8lJCuaesVHG56wUYi9WlyHQ/d7Um/fp9Ef8n6c4
	Upwr265iTWTKWnU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uEooK-00CS0n-Mk; Tue, 13 May 2025 14:32:40 +0200
Date: Tue, 13 May 2025 14:32:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Message-ID: <8b67fa4c-a07a-4941-ba7b-23d4e1104451@lunn.ch>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
 <20250219083910.2255981-4-SkyLake.Huang@mediatek.com>
 <Z7WleP9v6Igx2MjC@shell.armlinux.org.uk>
 <74ce0275952a9c60af87ded9d64ca7301fd69d0f.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74ce0275952a9c60af87ded9d64ca7301fd69d0f.camel@mediatek.com>

On Tue, May 13, 2025 at 10:12:04AM +0000, SkyLake Huang (黃啟澤) wrote:
> On Wed, 2025-02-19 at 09:33 +0000, Russell King (Oracle) wrote:
> > 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > 
> > 
> > On Wed, Feb 19, 2025 at 04:39:10PM +0800, Sky Huang wrote:
> > > +static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
> > > +{
> > > +     struct pinctrl *pinctrl;
> > > +     int ret;
> > > +
> > > +     /* Check if PHY interface type is compatible */
> > > +     if (phydev->interface != PHY_INTERFACE_MODE_INTERNAL)
> > > +             return -ENODEV;
> > > +
> > > +     ret = mt798x_2p5ge_phy_load_fw(phydev);
> > > +     if (ret < 0)
> > > +             return ret;
> > 
> > Firmware should not be loaded in the .config_init method. The above
> > call will block while holding the RTNL which will prevent all other
> > network configuration until the firmware has been loaded or the load
> > fails.
> > 
> > Thanks.
> > 
> > --
> > RMK's Patch system:
> > https://urldefense.com/v3/__https://www.armlinux.org.uk/developer/patches/__;!!CTRNKA9wMg0ARbw!iV-1ViPFsUV-lLj7aIycan8nery6sQO3t6mkpdlb_GW8hswhxc4ejJozxqkU3s2WzxSizs4kfdC77yr7HGGRIuU$
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 
> Actually, I wrote fw loading flow in .probe. However, during boot time,
> .probe is called at very early stage (about the first 2s after booting
> into Linux Kernel). At that time, filesystem isn't ready yet and phy
> driver can't locate /lib/firmware/mediatek/mt7988/i2p5ge-phy-pmb.bin.

Tell Dracut or whatever you are using to build the initramfs to
include the firmware. That is what MODULE_FIRMWARE() is for.

	Andrew

