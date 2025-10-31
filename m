Return-Path: <netdev+bounces-234562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9836BC22FEC
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 03:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737DD188A6DC
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 02:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02017279794;
	Fri, 31 Oct 2025 02:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tb4qlCTK"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924E275AE8
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877638; cv=none; b=G3la4cLNeTqHhYsI50TqV0AooBEaor8ZXrr4UN0oKhIE3x9fEwjPnfEiYV5PUx4aweq0Rtm6e0ef/0E4ibt/q/XDlBWsViMJD9PssF8xpZWOFUxZi9eAZKR7udjanPUQznynH8u4h3UibjgOsDjp+3x19XuYh4hZoOeguSVHk4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877638; c=relaxed/simple;
	bh=/iGTXL8Td9s0MAINbdscjXbuj+qIePHRTPgrESYij4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OymI3WZ7BqsM9tkpz7v5E67ctsvtqWmw1SXTgzqjz742C35uKfTFv0HQvMEoLMmPxoInUue25qrVyI9p9qcB8EM5/4hHtuUaZhiFi1Y26dpup7MEpvGulY0NCA+hIo/rlKwcHs6H2ynqFY0bZU8D12F84djrv1nFOLVN3D0sBv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tb4qlCTK; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761877634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGJYUkdAoAj6erTnt3CjbJ11QGzOZzSpzl2aih0xeqA=;
	b=tb4qlCTKKqmwQ3FZhO2s0PRQ1MtIbpG6qwTDoBOB67YLl4gPfLyn4duKS+ARsh225bQhgw
	iEYTn26w9u2o1AycTDKhYXb5CH3ne14v6QXSd8M6fhIVmaWlIqfyMFi2fTAZIIThK2ZbIf
	uBIAS9cWtqZkzF7xnOw+obOwwnKROZ8=
From: Yi Cong <cong.yi@linux.dev>
To: andrew@lunn.ch
Cc: Frank.Sae@motor-comm.com,
	cong.yi@linux.dev,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH net-next 1/2] net: phy: motorcomm: correct the default rx delay config for the rgmii
Date: Fri, 31 Oct 2025 10:27:00 +0800
Message-Id: <20251031022700.492740-1-cong.yi@linux.dev>
In-Reply-To: <5b97f70c-45c3-41c2-ba7b-d383864f0003@lunn.ch>
References: <5b97f70c-45c3-41c2-ba7b-d383864f0003@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu, 30 Oct 2025 13:57:58 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Oct 30, 2025 at 10:25:09AM +0800, Yi Cong wrote:
> > On Wed, 29 Oct 2025 13:07:35 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Wed, Oct 29, 2025 at 11:00:42AM +0800, Yi Cong wrote:
> > > > From: Yi Cong <yicong@kylinos.cn>
> > > >
> > > > According to the dataSheet, rx delay default value is set to 0.
> > >
> > > You need to be careful here, or you will break working boards. Please
> > > add to the commit message why this is safe.
> > >
> > > Also, motorcomm,yt8xxx.yaml says:
> > >
> > >   rx-internal-delay-ps:
> > >     description: |
> > >       RGMII RX Clock Delay used only when PHY operates in RGMII mode with
> > >       internal delay (phy-mode is 'rgmii-id' or 'rgmii-rxid') in pico-seconds.
> > >     enum: [ 0, 150, 300, 450, 600, 750, 900, 1050, 1200, 1350, 1500, 1650,
> > >             1800, 1900, 1950, 2050, 2100, 2200, 2250, 2350, 2500, 2650, 2800,
> > >             2950, 3100, 3250, 3400, 3550, 3700, 3850, 4000, 4150 ]
> > >     default: 1950
> >
> > Hi, Andrew, thanks for your reply!
> >
> > Let me add the following information:
> >
> > The chip documentation I have for the YT8521 and YT8531S:
> > "YT8521SH/YT8521SC Application Note, Version v1.7, Release Date: January 3, 2024"
> > "YT8531SH/YT8531SC Application Note, Version v1.2, Release Date: November 21, 2023"
> >
> > Both documents specify the RGMII delay configuration as follows:
> > The RX delay value can be set via Ext Reg 0xA003[13:10], where each
> > increment of 1 adds 150ps. After power-on, the default value of
> > bits [13:10] is 0.
> > The TX delay value can be set via Ext Reg 0xA003[3:0], with the
> > default value of bits [3:0] being 1 after power-on.
> >
> > I reviewed the commit history of this driver code. When YT8521 support
> > was initially added, the code configuration matched the chip manual:
> > 70479a40954c ("net: phy: Add driver for Motorcomm yt8521 gigabit ethernet phy")
> >
> > However, later when DTS support was added:
> > a6e68f0f8769 ("net: phy: Add dts support for Motorcomm yt8521 gigabit ethernet phy")
> > the default values were changed to 1.950ns.
>
> Read carefully...
>
> > >       RGMII RX Clock Delay used only when PHY operates in RGMII mode with
> > >       internal delay (phy-mode is 'rgmii-id' or 'rgmii-rxid') in pico-seconds.
>
> What do rgmii-id and rgmii-rxid mean?
>
> > Indeed, the RGMII standard specifies that the clock signal should be
> > delayed by 1-2ns relative to the data signals to ensure proper setup/hold
> > timing, which is likely the origin of the 1.950ns value in the YAML and
> > current code.
>
> https://elixir.bootlin.com/linux/v6.16.5/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L264
>
> > More importantly, the current Motorcomm driver's delay configuration logic
> > is incomplete. In the projects I've worked on, some configurations are
> > obtained from DTS, some from ACPI, but many manufacturers prefer to directly
> > set the delay values in BIOS based on their hardware design.
>
> Which is somewhat fine. If you want to the driver to not touch the PHY
> configuration you use PHY_INTERFACE_MODE_NA
>
> https://elixir.bootlin.com/linux/v6.16.5/source/include/linux/phy.h#L72
>
> However, in general, Linux should not rely on the BIOS, Linux should
> correctly configure the hardware, and in this case, it is trivial to
> do, since it is already all implemented.

The phy-mode is read by the MAC from ACPI. The same MAC paired with
different PHYs, or different vendors using the same MAC+PHY combination
but with varying motherboard designs, may result in differences here
(I've encountered both rgmii-id and rgmii-rxid).

For new products, I might recommend using PHY_INTERFACE_MODE_NA, but
for existing customers who are already using other configurations,
I no longer have control.

> > In fact, Motorcomm's Linux 5.4 driver versions guided PC motherboard
> > manufacturers to configure the delay values through BIOS, and the driver
> > code did not touch the delay registers (Ext Reg 0xA003). This means that
> > upgrading to a newer kernel version, where the driver writes 1.950ns
> > by default, could cause communication failures.
>
> Only if the MAC driver requests the PHY to adds delays.
>
> > To summarize, the current issues with the Motorcomm driver are:
> > 1. It only supports configuration via DTS, not via ACPI
> >     —— I may implement this myself or coordinate with Motorcomm
> >        in the future.
>
> FYI:
>
> https://elixir.bootlin.com/linux/v6.16.5/source/Documentation/firmware-guide/acpi/dsd/phy.rst
>
> You need to work within this framework.

Thank you. I will refer to these documents in my development work.



Our company is an operating system vendor, and our customers' hardware
varies greatly. Therefore, we must strive for maximum compatibility
—this includes accommodating diverse hardware designs from different
customers, as well as supporting upgrade requirements for computers
already sold to end users. I'm not sure if this aligns with the Linux
kernel community's principles.

Given these considerations, the two patches I submitted aim to align
the register's default values with those specified in the chip datasheet.
This ensures, at a minimum, that most customers' products—designed according
to the PHY manufacturer's specifications—will function correctly.

For the minority with special requirements—such as choosing rgmii-id or
rgmii-rxid, using different delay values—we allow configuration via DTS/ACPI,
support BIOS settings, and even ensure functionality when no explicit
configuration is applied, relying on the chip's default settings.

Returning to the current patch: changing the default value to match the
datasheet will not affect any phy-mode directly. This is because the delay value
is first obtained, and then its application is determined based on the phy-mode:
```
static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
{
	...
	/* get rx/tx delay value */
	rx_reg = ytphy_get_delay_reg_value(phydev, "rx-internal-delay-ps",
					   ytphy_rgmii_delays, tb_size,
					   &rxc_dly_en,
					   YT8521_RC1R_RGMII_0_000_NS);
	tx_reg = ytphy_get_delay_reg_value(phydev, "tx-internal-delay-ps",
					   ytphy_rgmii_delays, tb_size, NULL,
					   YT8521_RC1R_RGMII_NONLINEAR_0_750_NS);

	/* Set it based on different phy-mode */
	switch (phydev->interface) {
	case PHY_INTERFACE_MODE_RGMII:
		rxc_dly_en = 0;
		break;
	case PHY_INTERFACE_MODE_RGMII_RXID:
		val |= FIELD_PREP(YT8521_RC1R_RX_DELAY_MASK, rx_reg);
		break;
	case PHY_INTERFACE_MODE_RGMII_TXID:
		rxc_dly_en = 0;
		val |= FIELD_PREP(YT8521_RC1R_GE_TX_DELAY_MASK, tx_reg);
		break;
	case PHY_INTERFACE_MODE_RGMII_ID:
		val |= FIELD_PREP(YT8521_RC1R_RX_DELAY_MASK, rx_reg) |
		       FIELD_PREP(YT8521_RC1R_GE_TX_DELAY_MASK, tx_reg);
		break;
	default: /* do not support other modes */
		return -EOPNOTSUPP;
	}
    ...
}
```

Regards,
    Yi Cong

