Return-Path: <netdev+bounces-210804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D40FB14E2A
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497A018A29A6
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFD146447;
	Tue, 29 Jul 2025 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WnjH/Q2d"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9021758B
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794826; cv=none; b=tTWrnsYhbsgVCZO2OzbQCSFn4FAGtCYLTRFeVgyFGi3VGFb7SkDidpZ3PeSVjI3E/2q616MVy+K9POMl7HY6zIg1xh0UFbzOEVRIkx2J27t5ZZWg54d7wHO5fL2SYcLpYCWHn5HAjemtNd8JfBv5frTKEHVcGHtVcu5KUo1/Tdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794826; c=relaxed/simple;
	bh=hSch7o2Xc1r2BTjKRfDDV58XTrGoWKEtS3iMrZQ5gnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NrOFliYb8PyBYvJQWyclv7iLjg/na7M4cjRHE1qr4AfLU17FtZuhJsmuo4wDsVrISQQnqnxvdzqyNK9Ydknm2yriEgsH9ZBj+30sfzjc0sjDKOVXZ0c5hoVLd9qRdDCw2W37b5KzjGTk9+OxJf7Q5glyDzY+pCfYtb8acfOjmkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WnjH/Q2d; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TCmGLH000922;
	Tue, 29 Jul 2025 15:13:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Ma4q65Oz/loCMB5BOPIxsnfj+s5ECTQC6dNxwWijbSk=; b=WnjH/Q2dhA/T+cZ/
	RbEXPq7E/gm43Fj29lp4fbD2mrBefbVt5pwdS6ITAlt0vlo8McXaAhp4zeSZS/bB
	a95LUm17u6gG9fyE94EXblqKhrfZ71p0G7a3NkZLuIswrSwCUQ8P4mxFGozOZN8k
	77purQNv6qefzvGtbTtSENED2HNE0sv5TL6pd73zXShKn9q5O6DEx6N757muddK/
	5JxBVJmGkd12Swu43FSu0Xfp/59UgGgD3AOEX11LY02ITqdpeCgDmzKhjpsZk9k6
	8fLN9pgVcZ+avIWJKwpUoFNfYQhb/fUbq7W+6mD8FlzUJxBOLLKkIPSiTbUTaxCo
	zhu5pw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4858k52d8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 15:13:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 90D204004B;
	Tue, 29 Jul 2025 15:11:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 84FC576C44A;
	Tue, 29 Jul 2025 15:10:57 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 15:10:56 +0200
Message-ID: <d300d546-09fa-4b37-b8e0-349daa0cc108@foss.st.com>
Date: Tue, 29 Jul 2025 15:10:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH RFC net-next 6/7] net: stmmac: add helpers
 to indicate WoL enable status
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ33-006KDR-Nj@rmk-PC.armlinux.org.uk>
 <eaef1b1b-5366-430c-97dd-cf3b40399ac7@lunn.ch>
 <aIe5SqLITb2cfFQw@shell.armlinux.org.uk>
 <77229e46-6466-4cd4-9b3b-d76aadbe167c@foss.st.com>
 <aIiOWh7tBjlsdZgs@shell.armlinux.org.uk>
 <aIjCg_sjTOge9vd4@shell.armlinux.org.uk>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <aIjCg_sjTOge9vd4@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01



On 7/29/25 14:45, Russell King (Oracle) wrote:
> On Tue, Jul 29, 2025 at 10:03:22AM +0100, Russell King (Oracle) wrote:
>> With Thierry's .dts patch, PHY interrupts completely stop working, so
>> we don't get link change notifications anymore - and we still don't
>> seem to be capable of waking the system up with the PHY interrupt
>> being asserted.
>>
>> Without Thierry's .dts patch, as I predicted, enabling WoL at the
>> PHY results in Bad Stuff happening - the code in the realtek driver
>> for WoL is quite simply broken and wrong.
>>
>> Switching the pin from INTB mode to PMEB mode results in:
>> - No link change interrupts once WoL is enabled
>> - The interrupt output being stuck at active level, causing an
>>    interrupt storm and the interrupt is eventually disabled.
>>    The PHY can be configured to pulse the PMEB or hold at an active
>>    level until the WoL is cleared - and by default it's the latter.
>>
>> So, switching the interrupt pin to PMEB mode is simply wrong and
>> breaks phylib. I guess the original WoL support was only tested on
>> a system which didn't use the PHY interrupt, only using the interrupt
>> pin for wake-up purposes.
>>
>> I was working on the realtek driver to fix this, but it's pointless
>> spending time on this until the rest of the system can wake up -
>> and thus the changes can be tested. This is where I got to (and
>> includes work from both Thierry and myself, so please don't pick
>> this up as-is, because I can guarantee that you'll get the sign-offs
>> wrong! It's a work-in-progress, and should be a series for submission.)
> 
> Okay, with this patch, wake-up now works on the PHY interrupt line, but
> because normal interrupts aren't processed, the interrupt output from
> the PHY is stuck at active level, so the system immediately wakes up
> from suspend.
> 

If I'm following correctly, you do not use the PMEB mode and share
the same pin for WoL and regular interrupts (INTB mode)?

> Without the normal interrupt problem solved, there's nothing further
> I can do on this.
> 
> Some of the open questions are:
> - whether we should configure the WoL interrupt in the suspend/resume
>    function

For the LAN8742 PHY with which I worked with, the recommendation when
using the same pin for WoL and regular interrupt management is to mask
regular interrupt and enable the WoL IIRC.
This prevents the PHY from waking up from undesired events while still
being able use the WoL capability and should be done in suspend() /
resume() callbacks. I guess this means also that you share the same
interrupt handler that must manage both WoL events and regular events.

On the other hand, on the stm32mp135f-dk, the nPME pin (equivalent to
PMEB IIUC) is wired and is different from the nINT pin. Therefore, I
guess it should not be done during suspend()/resume() and it really
depends on how the PHY is wired. Because if a WoL event is received at
runtime, then the PHY must clear the flags otherwise the WoL event won't
trigger a system wakeup afterwards.

I need to look at how the PHYs can handle two different interrupts.

> - the interaction between the WoL interrupt configuration and the
>    config_intr method (whether on resume, the WoL interrupt enable
>    could get cleared, effectively disabling future WoL, despite it
>    being reported as enabled to userspace)
> - if we don't mark the PHY as wake-up capable, should we indicate
>    that the PHY does not support WoL in .get_wol() and return
>    -EOPNOTSUPP for .set_wol() given that we've had broken WoL support
>    merged in the recent v6.16 release.
> 
> I'm pretty sure that we want all PHYs that support WoL to mark
> themselves as a wakeup capable device, so the core wakeup code knows
> that the PHY has capabilities, and control the device wakeup enable.

I agree.

> Thus, I think we want to have some of this wakeup handling in the
> core phylib code.
> 
> However, as normal PHY interrupts don't work, this isn't something I
> can pursue further.
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi
> index a410fc335fa3..8ceba83614ed 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi
> @@ -39,9 +39,10 @@ mdio {
>   				phy: ethernet-phy@0 {
>   					compatible = "ethernet-phy-ieee802.3-c22";
>   					reg = <0x0>;
> -					interrupt-parent = <&gpio>;
> -					interrupts = <TEGRA194_MAIN_GPIO(G, 4) IRQ_TYPE_LEVEL_LOW>;
> +					interrupt-parent = <&pmc>;
> +					interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
>   					#phy-cells = <0>;
> +					wakeup-source;
>   				};
>   			};
>   		};
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> index 09ae16e026eb..bcaa37e08345 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> @@ -261,7 +261,8 @@ static int tegra_eqos_probe(struct platform_device *pdev,
>   	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
>   	plat_dat->bsp_priv = eqos;
>   	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE |
> -			   STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
> +			   STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP |
> +			   STMMAC_FLAG_USE_PHY_WOL;
>   
>   	return 0;
>   
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index dd0d675149ad..ef10e2c32318 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -10,6 +10,7 @@
>   #include <linux/bitops.h>
>   #include <linux/of.h>
>   #include <linux/phy.h>
> +#include <linux/pm_wakeirq.h>
>   #include <linux/netdevice.h>
>   #include <linux/module.h>
>   #include <linux/delay.h>
> @@ -31,6 +32,7 @@
>   #define RTL821x_INER				0x12
>   #define RTL8211B_INER_INIT			0x6400
>   #define RTL8211E_INER_LINK_STATUS		BIT(10)
> +#define RTL8211F_INER_WOL			BIT(7)
>   #define RTL8211F_INER_LINK_STATUS		BIT(4)
>   
>   #define RTL821x_INSR				0x13
> @@ -255,6 +257,28 @@ static int rtl821x_probe(struct phy_device *phydev)
>   	return 0;
>   }
>   
> +static int rtl8211f_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	int ret;
> +
> +	ret = rtl821x_probe(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Mark this PHY as wakeup capable and register the interrupt as a
> +	 * wakeup IRQ if the PHY is marked as a wakeup source in firmware,
> +	 * and the interrupt is valid.
> +	 */
> +	if (device_property_read_bool(dev, "wakeup-source") &&
> +	    phy_interrupt_is_valid(phydev)) {
> +		device_set_wakeup_capable(dev, true);
> +		devm_pm_set_wake_irq(dev, phydev->irq);
> +	}
> +
> +	return ret;
> +}
> +
>   static int rtl8201_ack_interrupt(struct phy_device *phydev)
>   {
>   	int err;
> @@ -426,12 +450,17 @@ static irqreturn_t rtl8211f_handle_interrupt(struct phy_device *phydev)
>   		return IRQ_NONE;
>   	}
>   
> -	if (!(irq_status & RTL8211F_INER_LINK_STATUS))
> -		return IRQ_NONE;
> +	if (irq_status & RTL8211F_INER_LINK_STATUS) {
> +		phy_trigger_machine(phydev);
> +		return IRQ_HANDLED;
> +	}
>   
> -	phy_trigger_machine(phydev);
> +	if (irq_status & RTL8211F_INER_WOL) {
> +		pm_wakeup_event(&phydev->mdio.dev, 0);
> +		return IRQ_HANDLED;
> +	}
>   
> -	return IRQ_HANDLED;
> +	return IRQ_NONE;
>   }
>   
>   static void rtl8211f_get_wol(struct phy_device *dev, struct ethtool_wolinfo *wol)
> @@ -470,12 +499,16 @@ static int rtl8211f_set_wol(struct phy_device *dev, struct ethtool_wolinfo *wol)
>   		__phy_write(dev, RTL8211F_WOL_SETTINGS_STATUS, RTL8211F_WOL_STATUS_RESET);
>   
>   		/* Enable the WOL interrupt */
> -		rtl821x_write_page(dev, RTL8211F_INTBCR_PAGE);
> -		__phy_set_bits(dev, RTL8211F_INTBCR, RTL8211F_INTBCR_INTB_PMEB);
> +		//rtl821x_write_page(dev, RTL8211F_INTBCR_PAGE);
> +		//__phy_set_bits(dev, RTL8211F_INTBCR, RTL8211F_INTBCR_INTB_PMEB);
> +		rtl821x_write_page(dev, 0xa42);
> +		__phy_set_bits(dev, RTL821x_INER, RTL8211F_INER_WOL);
>   	} else {
>   		/* Disable the WOL interrupt */
> -		rtl821x_write_page(dev, RTL8211F_INTBCR_PAGE);
> -		__phy_clear_bits(dev, RTL8211F_INTBCR, RTL8211F_INTBCR_INTB_PMEB);
> +		//rtl821x_write_page(dev, RTL8211F_INTBCR_PAGE);
> +		//__phy_clear_bits(dev, RTL8211F_INTBCR, RTL8211F_INTBCR_INTB_PMEB);
> +		rtl821x_write_page(dev, 0xa42);
> +		__phy_clear_bits(dev, RTL821x_INER, RTL8211F_INER_WOL);
>   
>   		/* Disable magic packet matching and reset WOL status */
>   		rtl821x_write_page(dev, RTL8211F_WOL_SETTINGS_PAGE);
> @@ -483,10 +516,30 @@ static int rtl8211f_set_wol(struct phy_device *dev, struct ethtool_wolinfo *wol)
>   		__phy_write(dev, RTL8211F_WOL_SETTINGS_STATUS, RTL8211F_WOL_STATUS_RESET);
>   	}
>   
> +	device_set_wakeup_enable(&dev->mdio.dev, !!(wol->wolopts & WAKE_MAGIC));
> +
>   err:
>   	return phy_restore_page(dev, oldpage, 0);
>   }
>   
> +static int rtl821x_suspend(struct phy_device *phydev);
> +static int rtl8211f_suspend(struct phy_device *phydev)
> +{
> +	struct rtl821x_priv *priv = phydev->priv;
> +	int ret = rtl821x_suspend(phydev);
> +
> +	return ret;
> +}
> +
> +static int rtl821x_resume(struct phy_device *phydev);
> +static int rtl8211f_resume(struct phy_device *phydev)
> +{
> +	struct rtl821x_priv *priv = phydev->priv;
> +	int ret = rtl821x_resume(phydev);
> +
> +	return ret;
> +}
> +
>   static int rtl8211_config_aneg(struct phy_device *phydev)
>   {
>   	int ret;
> @@ -1612,15 +1665,15 @@ static struct phy_driver realtek_drvs[] = {
>   	}, {
>   		PHY_ID_MATCH_EXACT(0x001cc916),
>   		.name		= "RTL8211F Gigabit Ethernet",
> -		.probe		= rtl821x_probe,
> +		.probe		= rtl8211f_probe,
>   		.config_init	= &rtl8211f_config_init,
>   		.read_status	= rtlgen_read_status,
>   		.config_intr	= &rtl8211f_config_intr,
>   		.handle_interrupt = rtl8211f_handle_interrupt,
>   		.set_wol	= rtl8211f_set_wol,
>   		.get_wol	= rtl8211f_get_wol,
> -		.suspend	= rtl821x_suspend,
> -		.resume		= rtl821x_resume,
> +		.suspend	= rtl8211f_suspend,
> +		.resume		= rtl8211f_resume,
>   		.read_page	= rtl821x_read_page,
>   		.write_page	= rtl821x_write_page,
>   		.flags		= PHY_ALWAYS_CALL_SUSPEND,
> 

