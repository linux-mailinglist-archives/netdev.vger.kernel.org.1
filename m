Return-Path: <netdev+bounces-77515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43978720E1
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 14:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E798B2716C
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D41085C7F;
	Tue,  5 Mar 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IG1Eho3g"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9918593E;
	Tue,  5 Mar 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646857; cv=none; b=kRdL+TR+RKvT2vxvv1ViqEyMlOxlslrtsZHxXEuCRxAAGIOvErM8+8toBX79NZz60YtujEH5qeeLXf0drGjzBnMhTkLortjQmEGyiZNLdxrEc1moZJxGrQjVXblT8KclaLu/e7Re3miwmPp4uq5tCTtq5TiupLQkCVNAGiydmjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646857; c=relaxed/simple;
	bh=iE+d6WHLQ8dtk72zJx79UKKdAtbVsGqE7b1/AEJKdg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyR1//FvkX6BGDkzIRnsDkP9R9vd8wApjXG6gZ9G38gy6T9SDCCKPeEZGLraFDrYLU/hd9SA9+PH4J6n9lPoHeJaJsKlAwY7O03268skCh4EzlnF5U8qrP09hb8IkAPDbEDk4pMcce77FCwqCIqi7LXx+cIN1X83ocyP8aRYRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IG1Eho3g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=whBP21HAQ3Frp1IUY6JzJ0sm0jK2Dg8CkXh4X6cnDe0=; b=IG1Eho3gmXNSip/areixddTUPD
	IOmqwXCRipvCc312V3ZpFXAv08+39xyTeqtLLjwvc2wnSCtP/A3Le2Eq7XkDiq/Yo9Pp0jvRHZdBA
	ibWE3m7F/a/WAZZAt//gV15LlYYo6Eao92Enj7Xt/yB8H/ZbXEvXG6HEgCM0//n9383g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhVFL-009Qg4-42; Tue, 05 Mar 2024 14:54:19 +0100
Date: Tue, 5 Mar 2024 14:54:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <99541533-625e-4ffb-b980-b2bcd016cfeb@lunn.ch>
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <89f237e0-75d4-4690-9d43-903e087e4f46@lunn.ch>
 <b27e44db-d9c5-49f0-8b81-2f55cfaacb4d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b27e44db-d9c5-49f0-8b81-2f55cfaacb4d@gmail.com>

On Tue, Mar 05, 2024 at 09:13:41AM +0100, Eric Woudstra wrote:
> 
> Hi Andrew,
> 
> First of all, thanks for taking the time to look at the code so
> extensively.
> 
> On 3/3/24 18:29, Andrew Lunn wrote:
> >> +enum {
> >> +	AIR_PHY_LED_DUR_BLINK_32M,
> >> +	AIR_PHY_LED_DUR_BLINK_64M,
> >> +	AIR_PHY_LED_DUR_BLINK_128M,
> >> +	AIR_PHY_LED_DUR_BLINK_256M,
> >> +	AIR_PHY_LED_DUR_BLINK_512M,
> >> +	AIR_PHY_LED_DUR_BLINK_1024M,
> > 
> > DUR meaning duration? It has a blinks on for a little over a
> > kilometre? So a wave length of a little over 2 kilometres, or a
> > frequency of around 0.0005Hz :-)
> 
> It is the M for milliseconds. I can add a comment to clarify this.

Or just add an S. checkpatch does not like camElcAse. So ms will call
a warning. But from context we know it is not mega seconds.

> >> +static int __air_buckpbus_reg_write(struct phy_device *phydev,
> >> +				    u32 pbus_address, u32 pbus_data,
> >> +				    bool set_mode)
> >> +{
> >> +	int ret;
> >> +
> >> +	if (set_mode) {
> >> +		ret = __phy_write(phydev, AIR_BPBUS_MODE,
> >> +				  AIR_BPBUS_MODE_ADDR_FIXED);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +	}
> > 
> > What does set_mode mean?
> 
> I use this boolean to prevent writing the same value twice to the
> AIR_BPBUS_MODE register, when doing an atomic modify operation. The
> AIR_BPBUS_MODE is already set in the read operation, so it does not
> need to be set again to the same value at the write operation.
> Sadly, the address registers for read and write are different, so
> I could not optimize the modify operation any more.

So there is the potential to have set_mode true when not actually
performing a read/modify/write. Maybe have a dedicated modify
function, and don't expose set_mode?

> 
> >> +static int en8811h_load_firmware(struct phy_device *phydev)
> >> +{
> >> +	struct device *dev = &phydev->mdio.dev;
> >> +	const struct firmware *fw1, *fw2;
> >> +	int ret;
> >> +
> >> +	ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
> >> +	if (ret < 0)
> >> +		goto en8811h_load_firmware_rel1;
> >> +
> > 
> > How big are these firmwares? This will map the entire contents into
> > memory. There is an alternative interface which allows you to get the
> > firmware in chunks. I the firmware is big, just getting 4K at a time
> > might be better, especially if this is an OpenWRT class device.
> 
> The file sizes are 131072 and 16384 bytes. If you think this is too big,
> I could look into using the alternative interface.

What class of device is this? 128K for a PC is nothing. For an OpenWRT
router with 128M of RAM, it might be worth using the other API.

> 
> >> +static int en8811h_restart_host(struct phy_device *phydev)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> >> +				     EN8811H_FW_CTRL_1_START);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	return air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> >> +				     EN8811H_FW_CTRL_1_FINISH);
> >> +}
> > 
> > What is host in this context?
> 
> This is the EN8811H internal host to the PHY.

That is a very PHY centric view of the world. I would say the host is
what is running Linux. I assume this is the datahsheets naming? Maybe
cpu, or mcu is a better name?

> 
> > Vendors do like making LED control unique. I've not seen any other MAC
> > or PHY where you can blink for activity at a given speed. You cannot
> > have 10 and 100 at the same time, so why are there different bits for
> > them?
> > 
> > I _think_ this can be simplified
> > ...
> > Does this work?
> 
> I started out with that, but the hardware can do more. It allows
> for a setup as described:
> 
>  100M link up triggers led0, only led0 blinking on traffic
> 1000M link up triggers led1, only led1 blinking on traffic
> 2500M link up triggers led0 and led1, both blinking on traffic
> 
> #define AIR_DEFAULT_TRIGGER_LED0 (BIT(TRIGGER_NETDEV_LINK_2500) | \
> 				 BIT(TRIGGER_NETDEV_LINK_100)  | \
> 				 BIT(TRIGGER_NETDEV_RX)        | \
> 				 BIT(TRIGGER_NETDEV_TX))
> #define AIR_DEFAULT_TRIGGER_LED1 (BIT(TRIGGER_NETDEV_LINK_2500) | \
> 				 BIT(TRIGGER_NETDEV_LINK_1000) | \
> 				 BIT(TRIGGER_NETDEV_RX)        | \
> 				 BIT(TRIGGER_NETDEV_TX))
> 
> With the simpler code and just the slightest traffic, both leds
> are blinking and no way to read the speed anymore from the leds.
> 
> So I modified it to make the most use of the possibilities of the
> EN881H hardware. The EN8811H can then be used with a standard 2-led
> rj45 socket.

The idea is that we first have Linux blink the LEDs in software. This
is controlled via the files in /sys/class/leds/FOO/{link|rx|tx}
etc. If the hardware can do the same blink pattern, it can then be
offloaded to the hardware.

If you disable hardware offload, just have set brightness, can you do
the same pattern?

As i said, vendors do all sorts of odd things with LEDs. I would
prefer we have a common subset most PHY support, and not try to
support every strange mode.

    Andrew

