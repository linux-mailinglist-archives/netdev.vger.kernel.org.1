Return-Path: <netdev+bounces-240554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16020C76409
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 44B5628E95
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 20:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFD23502A6;
	Thu, 20 Nov 2025 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF/qQ4HO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7043128C4
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763672132; cv=none; b=MbMcpEuiP1MPbJccMJ/t9I2h3sZfu59VFM7ISisZ03XiBxXybD1NirQUM4h+zvY800u06xs9WCyBozxOmq/zcSj2Cz4jO6t6OUciT6+pQRa/z1XUBNdNuT3AEMkni0wu2QeDReBqujvCWCL4P1ZbVWIi7e3f2GGaAOxjQtFnR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763672132; c=relaxed/simple;
	bh=Tw6PzwmFUH3yzaToVragN2xPLBkERaK2J51NDxu9Hfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGu2A3JTbNR9uyb/Zub7tq5vM/1GTGxpV6wna2p29Zo2AhzC2Io8lHOFHNI3cYxxYvvXsbQGWzM4zv1v2QUdJeQqGgYgeytFseSULd+JS4F1Cmr8vzXEUlOSyOw+VNJfJdF8UetW/Rd34oZfisC88dvczkm7LULwD0p6O+lnXrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF/qQ4HO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so782830f8f.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763672128; x=1764276928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZ0TiYuUwtM/It7RYy4vPWkMc0+ElnY6WAKQWRtqUCo=;
        b=DF/qQ4HOp3KcqgrqStk0NkyNYM+SW4WOMvU/oeEVHq2SDhc2ZLwyCb0w9G6KbVvtoP
         aCWSkck1LCOFVdcdzpXcqraSu/DZ9W+PQ1KiRRJ3oGbq/eDOgcz0hUfPoHhNyl2hTEwC
         RHMh2lNyMhz80IVgoSr4QNXBmFf30Gh5g8RKUB6OHOUNWwxQnQWmUJSNgm/nHy0rjEfq
         uk89p28N3IZdT1eL1HDzOG16dKIyvnFU6L2JidA5ThTcriOBueHsfWZyBUVNQ1GbRWLe
         ugEssAuSCZL+bkYg7l5i1JwxOHPC0pByKpBBH4o7Cfgsb5/pyAF7OZatOjnygGR5kvpr
         guKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763672128; x=1764276928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZ0TiYuUwtM/It7RYy4vPWkMc0+ElnY6WAKQWRtqUCo=;
        b=jYmBYpsSvlt4/72QhJYA1SiI+oBV1uYqVpy82oT9V5Ne/uHZfYFKMgHI4eA3vOuaVU
         FYmp4oVEDsCVbt+iRuErFT2ws5pVDyLnIFtexYgZ/vpo5XX9NCwtyHzgwgWAQNX/y3Dz
         T3uYLLqIrIAWHY4oW7S0GuBlTNi7xGUJHFFAil9pQsf458J4AS1wFnGstEW5y6Wz3mqY
         P0Gd8zPnYd94Jcu9ds1aS9PKM0zWTR+Rz1a8CgcbCjCbejRaBjP7SC9vQ3Hg/0ZO2o8z
         TwcrtdeRNYUctTHzRE0UWMwh7xrirSkxz5eqkcGe2mPlrRDQqSmoclMkfNJdxaeI5s/U
         5tHA==
X-Gm-Message-State: AOJu0Yxc6UN5hYRCa7nHmmfWltuBFfwY3QelDnWclMJKIpwr+DqJRKVl
	bw11vhdrxvzTFUsa4pfIPQX01Ro4OLjK+nHUIOsWqfD9JcLUbHGzfSjG
X-Gm-Gg: ASbGncvBdfVnAIj4EZvPYLvEY6h8ddWdX6B1qlsYBYFkuhTvZdBwyBApTKd8vsgSPU0
	9slBPMHzJeSrIhpWmxPgV6khFyoxSXdjBbettYH92uRfsxH8jbM2cfLCpT4BmTmYlDWcp3RzxJR
	iunGpI67qiw7bRdKcXVn8kjbSd2GRj5ozvpk8C6fWuiLVmibCFtyr99dm3IkRz238BsgRJCoNBT
	3IMu/Qq+GDawqI/n19GoaTl5ytl0DoSxfXSCYKd+TtT8y4MaNw5ZzLMTYGAI64IK0hC/KY0YER8
	pOdOs9BJYg+k32KYnWeE7S3219BjIiV3XYljMmfUoU9TWX6iHE/38zq5AIz8mTG7KJJPZ0HZLJV
	I3+Xja3ADdw6aN3je23ruKSqhFvBFliplwFRF/mySjmTx3cdWyq8hwaeLzxo8NSyKVRW+P/MMz2
	Oyc1/eBT0zEGcO4zy/29a/DM+nh7ZMV5E1vnw8zCb35nT7JxMi+952EM8ceqeDiyz02yqI0Tt6M
	SDcherbn9hOoHZnvb8TpCkVPY37xcbn0GAXLqSeS9lcfaBRE2iPFA==
X-Google-Smtp-Source: AGHT+IG3rjXFlUC2x656rCC2Pxt5Kfvcgeo+c3M2JQoDuHBQrq/vXa4AmsyR7jlMTliyV9bcCy5tbg==
X-Received: by 2002:a05:6000:1863:b0:42b:3c8d:1932 with SMTP id ffacd0b85a97d-42cb99f595dmr4082151f8f.23.1763672128221;
        Thu, 20 Nov 2025 12:55:28 -0800 (PST)
Received: from ?IPV6:2003:ea:8f3a:7100:6cbf:5f75:6c2d:3ca3? (p200300ea8f3a71006cbf5f756c2d3ca3.dip0.t-ipconnect.de. [2003:ea:8f3a:7100:6cbf:5f75:6c2d:3ca3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm7538676f8f.33.2025.11.20.12.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 12:55:27 -0800 (PST)
Message-ID: <f263daf0-70c2-46c2-af25-653ff3179cb0@gmail.com>
Date: Thu, 20 Nov 2025 21:55:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] r8169: add support for RTL8127ATF
To: Fabio Baltieri <fabio.baltieri@gmail.com>, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Michael Zimmermann <sigmaepsilon92@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251120195055.3127-1-fabio.baltieri@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20251120195055.3127-1-fabio.baltieri@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/2025 8:50 PM, Fabio Baltieri wrote:
> Add support for ATF variant of the RTL8127, this uses an SFP transceiver
> instead of the twisted pair one and only runs at 1Gbps or 10Gbps, only
> 10Gbps is supported with this patch.
> 
> The change is based on the r8127 driver package version 11.015.00
> available on the Realtek website and also on
> https://github.com/openwrt/rtl8127.
> 
> There's no public datasheet for the chip so this is just porting over
> the original vendor code to the API and style of the upstream one.
> 
> Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> ---
> 
> Hi, did more tests with 1g mode on the v1 of this patch, the setting
> itself works but triggering it from ethtool reliably seems problematic
> due to some weird behavior of the phy code which end up reporting a
> specific link speed when the link is down, making it impossible to set
> it with ethool as it thinks it's already set.
> 
> Since it seems like supporting 1g properly needs expanding the scope of
> the patch, I'm taking the suggestion from Heiner in v1 review and
> stripped this down so it only supports 10g, which is likely what the
> vast majority of the users need anyway.
> 
> Also tested this on suspend/resume, this is also affected by the wol
> issue but with that bit set it now works correctly.
> 
> v1 -> v2
> - stripped out 1g support
> - moved the sds settings in rtl8169_init_phy() so it get called on
>   resume
> - renamed fiber_mode to sfp_mode to avoid confusion
> 
> Cheers,
> Fabio
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 128 +++++++++++++++++++++-
>  1 file changed, 126 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index d18734fe12e..e19518c7b98 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -729,6 +729,7 @@ struct rtl8169_private {
>  	unsigned supports_gmii:1;
>  	unsigned aspm_manageable:1;
>  	unsigned dash_enabled:1;
> +	unsigned sfp_mode:1;
>  	dma_addr_t counters_phys_addr;
>  	struct rtl8169_counters *counters;
>  	struct rtl8169_tc_offsets tc_offset;
> @@ -842,7 +843,8 @@ static bool rtl_supports_eee(struct rtl8169_private *tp)
>  {
>  	return tp->mac_version >= RTL_GIGA_MAC_VER_34 &&
>  	       tp->mac_version != RTL_GIGA_MAC_VER_37 &&
> -	       tp->mac_version != RTL_GIGA_MAC_VER_39;
> +	       tp->mac_version != RTL_GIGA_MAC_VER_39 &&
> +	       !tp->sfp_mode;
>  }
>  
>  static void rtl_read_mac_from_reg(struct rtl8169_private *tp, u8 *mac, int reg)
> @@ -1399,6 +1401,95 @@ DECLARE_RTL_COND(rtl_ocp_tx_cond)
>  	return RTL_R8(tp, IBISR0) & 0x20;
>  }
>  
> +#define R8127_SDS_CMD 0x2348
> +#define R8127_SDS_ADDR 0x234a
> +#define R8127_SDS_DATA_IN 0x234c
> +#define R8127_SDS_DATA_OUT 0x234e
> +
> +#define R8127_MAKE_SDS_ADDR(_index, _page, _reg) \
> +	(((_index) << 11) | ((_page) << 5) | (_reg))
> +
> +#define R8127_SDS_CMD_IN BIT(0)
> +#define R8127_SDS_WE_IN BIT(1)
> +
> +DECLARE_RTL_COND(rtl_sds_cmd_done)
> +{
> +	return RTL_R16(tp, R8127_SDS_CMD) & R8127_SDS_CMD_IN;
> +}
> +
> +static u16 rtl8127_sds_phy_read(struct rtl8169_private *tp,
> +				u16 index, u16 page, u16 reg)
> +{
> +	RTL_W16(tp, R8127_SDS_ADDR, R8127_MAKE_SDS_ADDR(index, page, reg));
> +	RTL_W16(tp, R8127_SDS_CMD, R8127_SDS_CMD_IN);
> +
> +	if (rtl_loop_wait_low(tp, &rtl_sds_cmd_done, 1, 100))
> +		return RTL_R16(tp, R8127_SDS_DATA_OUT);
> +	else
> +		return 0xffff;
> +}
> +
> +static void rtl8127_sds_phy_write(struct rtl8169_private *tp,
> +				  u16 index, u16 page, u16 reg, u16 val)
> +{
> +	RTL_W16(tp, R8127_SDS_DATA_IN, val);
> +	RTL_W16(tp, R8127_SDS_ADDR, R8127_MAKE_SDS_ADDR(index, page, reg));
> +	RTL_W16(tp, R8127_SDS_CMD, R8127_SDS_CMD_IN | R8127_SDS_WE_IN);
> +
> +	rtl_loop_wait_low(tp, &rtl_sds_cmd_done, 1, 100);
> +}
> +
> +static void rtl8127_sds_phy_modify(struct rtl8169_private *tp,
> +				   u16 index, u16 page, u16 addr,
> +				   u16 mask, u16 set)
> +{
> +	u16 val;
> +
> +	val = rtl8127_sds_phy_read(tp, index, page, addr);
> +	val = (val & ~mask) | set;
> +	rtl8127_sds_phy_write(tp, index, page, addr, val);
> +}
> +
> +static void rtl8127_sds_phy_reset(struct rtl8169_private *tp)
> +{
> +	RTL_W8(tp, 0x2350, RTL_R8(tp, 0x2350) & ~BIT(0));
> +	udelay(1);
> +
> +	RTL_W16(tp, 0x233a, 0x801f);
> +	RTL_W8(tp, 0x2350, RTL_R8(tp, 0x2350) | BIT(0));
> +	udelay(10);
> +}
> +
> +static void rtl8127_sds_phy_exit_1g(struct rtl8169_private *tp)
> +{
> +	rtl8127_sds_phy_modify(tp, 0, 1, 31, BIT(3), 0);
> +	rtl8127_sds_phy_modify(tp, 0, 2, 0,
> +			       BIT(13) | BIT(12) | BIT(6),
> +			       BIT(6));
> +
> +	rtl8127_sds_phy_reset(tp);
> +}
> +
> +static void rtl8127_set_sds_phy_caps_10g(struct rtl8169_private *tp)
> +{
> +	u16 val;
> +
> +	RTL_W16(tp, 0x233a, 0x801a);
> +
> +	val = RTL_R16(tp, 0x233e);
> +	val &= BIT(13) | BIT(12) | BIT(1) | BIT(0);
> +	val |= BIT(12);
> +	RTL_W16(tp, 0x233e, val);
> +
> +	r8169_mdio_write(tp, 0xc40a, 0x0);
> +	r8169_mdio_write(tp, 0xc466, 0x3);
> +	r8169_mdio_write(tp, 0xc808, 0x0);
> +	r8169_mdio_write(tp, 0xc80a, 0x0);
> +
This function isn't usable on RTL8127.

> +	val = r8168_phy_ocp_read(tp, 0xc804);
> +	r8168_phy_ocp_write(tp, 0xc804, (val & ~0x000f) | 0x000c);
> +}
> +
>  static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
>  {
>  	RTL_W8(tp, IBCR2, RTL_R8(tp, IBCR2) & ~0x01);
> @@ -1512,6 +1603,15 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static bool rtl_sfp_mode(struct rtl8169_private *tp)
> +{
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80 &&
> +	    (r8168_mac_ocp_read(tp, 0xd006) & 0xff) == 0x07)
> +		return true;
> +
> +	return false;
> +}
> +
>  static void rtl_set_d3_pll_down(struct rtl8169_private *tp, bool enable)
>  {
>  	if (tp->mac_version >= RTL_GIGA_MAC_VER_25 &&
> @@ -2390,7 +2490,10 @@ static void rtl8125a_config_eee_mac(struct rtl8169_private *tp)
>  
>  static void rtl8125b_config_eee_mac(struct rtl8169_private *tp)
>  {
> -	r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
> +	if (tp->sfp_mode)
> +		r8168_mac_ocp_modify(tp, 0xe040, BIT(1) | BIT(0), 0);
> +	else
> +		r8168_mac_ocp_modify(tp, 0xe040, 0, BIT(1) | BIT(0));
>  }
>  
>  static void rtl_rar_exgmac_set(struct rtl8169_private *tp, const u8 *addr)
> @@ -2440,6 +2543,25 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
>  	    tp->pci_dev->subsystem_device == 0xe000)
>  		phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
>  
> +	if (tp->sfp_mode) {
> +		rtl8127_sds_phy_exit_1g(tp);
> +		rtl8127_set_sds_phy_caps_10g(tp);
> +
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_100baseT_Full_BIT);
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_1000baseT_Full_BIT);
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_5000baseT_Full_BIT);
> +
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_Autoneg_BIT);
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_Pause_BIT);
> +		phy_remove_link_mode(tp->phydev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
> +
> +		tp->phydev->autoneg = 0;
> +	}
> +
>  	/* We may have called phy_speed_down before */
>  	phy_speed_up(tp->phydev);
>  
> @@ -5453,6 +5575,8 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	tp->dash_type = rtl_get_dash_type(tp);
>  	tp->dash_enabled = rtl_dash_is_enabled(tp);
>  
> +	tp->sfp_mode = rtl_sfp_mode(tp);
> +
>  	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
>  
>  	if (sizeof(dma_addr_t) > 4 && tp->mac_version >= RTL_GIGA_MAC_VER_18 &&

Your patch is a good starting point, however it needs more thoughts / work how to somewhat cleanly
integrate Realtek's design with phylib. E.g. you would want to set 10G and aneg off via ethtool,
but that's not supported by phy_ethtool_ksettings_set().
I'll prepare patches and, if you don't mind, would provide them to you for testing, as I don't
own this hw.
At least you have a working solution for the time being. Thanks!

