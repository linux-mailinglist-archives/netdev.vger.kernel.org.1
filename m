Return-Path: <netdev+bounces-117482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7598F94E180
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C559A1F21053
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE241494A4;
	Sun, 11 Aug 2024 13:48:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-17.us.a.mail.aliyun.com (out198-17.us.a.mail.aliyun.com [47.90.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41615B7;
	Sun, 11 Aug 2024 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723384103; cv=none; b=mESse+p3FJPUcEruplw0fbhSyTss2t/6cKuweKsBmY8bdIEtBHYKiFKeHr8dBjcNUhqZm54Fh9h9XSN+wYTyF5wqr4I0J9J5h7Y4DLiJyUtzST2pta5lC90o7MctI/1xCeoF5kZuE5t+J9kGKNgBu5a0DWSOB2iudBEKfRN7RXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723384103; c=relaxed/simple;
	bh=l6AWYvjghOVIKq+DmPp7ZxkGzep1C/zfmYgKq7RfczI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MkDcC11eeyJKCW6d2+VZ+sIx0BgB3jPLB5QyXoX2enEAgGMQiNnz0j4ZkM+BDGPIxX01Ne9MZ2lc1Q1GtikWRhBb8lhMhqW4/1Y+kcdbVCltcvMuSSQsHs8gAV8n9u7zLOS3R/CwI5l0C6gJ/6oFCSLWwoCn4HPNmaV+WcWveU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from 192.168.208.130(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.YoCHfYF_1723384075)
          by smtp.aliyun-inc.com;
          Sun, 11 Aug 2024 21:47:56 +0800
Message-ID: <e3e57b83-813d-4b8f-aa8a-cb5d0b070e60@motor-comm.com>
Date: Sun, 11 Aug 2024 06:47:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: phy: Add driver for Motorcomm yt8821 2.5G
 ethernet phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
 xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com, jie.han@motor-comm.com
References: <20240727092031.1108690-1-Frank.Sae@motor-comm.com>
 <fa2a7a4a-a5fc-4b05-b012-3818f65631c4@lunn.ch>
Content-Language: en-US
From: "Frank.Sae" <Frank.Sae@motor-comm.com>
In-Reply-To: <fa2a7a4a-a5fc-4b05-b012-3818f65631c4@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/27/24 04:36, Andrew Lunn wrote:
> On Sat, Jul 27, 2024 at 02:20:31AM -0700, Frank.Sae wrote:
>>   Add a driver for the motorcomm yt8821 2.5G ethernet phy.
>>   Verified the driver on
>>   BPI-R3(with MediaTek MT7986(Filogic 830) SoC) development board,
>>   which is developed by Guangdong Bipai Technology Co., Ltd..
>>   On the board, yt8821 2.5G ethernet phy works in
>>   AUTO_BX2500_SGMII or FORCE_BX2500 interface,
>>   supports 2.5G/1000M/100M/10M speeds, and wol(magic package).
>>   Since some functions of yt8821 are similar to YT8521
>>   so some functions for yt8821 can be reused.
> No leading space please.
>
>> Signed-off-by: Frank.Sae <Frank.Sae@motor-comm.com>
>> ---
>>   drivers/net/phy/motorcomm.c | 639 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 636 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
>> index 7a11fdb687cc..a432b27dd849 100644
>> --- a/drivers/net/phy/motorcomm.c
>> +++ b/drivers/net/phy/motorcomm.c
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0+
>>   /*
>> - * Motorcomm 8511/8521/8531/8531S PHY driver.
>> + * Motorcomm 8511/8521/8531/8531S/8821 PHY driver.
>>    *
>>    * Author: Peter Geis <pgwipeout@gmail.com>
>>    * Author: Frank <Frank.Sae@motor-comm.com>
>> @@ -16,7 +16,7 @@
>>   #define PHY_ID_YT8521		0x0000011a
>>   #define PHY_ID_YT8531		0x4f51e91b
>>   #define PHY_ID_YT8531S		0x4f51e91a
>> -
>> +#define PHY_ID_YT8821		0x4f51ea19
>>   /* YT8521/YT8531S Register Overview
>>    *	UTP Register space	|	FIBER Register space
>>    *  ------------------------------------------------------------
>> @@ -52,6 +52,15 @@
>>   #define YTPHY_SSR_SPEED_10M			0x0
>>   #define YTPHY_SSR_SPEED_100M			0x1
>>   #define YTPHY_SSR_SPEED_1000M			0x2
>> +/* bit9 as speed_mode[2], bit15:14 as Speed_mode[1:0]
>> + * Speed_mode[2:0]:
>> + * 100 = 2P5G
>> + * 011 = 10G
>> + * 010 = 1000 Mbps
>> + * 001 = 100 Mbps
>> + * 000 = 10 Mbps
>> + */
>> +#define YT8821_SSR_SPEED_2500M			0x4
> If these bits are spread around, why 0x4? Ahh, because you extract the
> bits and reform the value. Maybe:
>
> #define YTPHY_SSR_SPEED_10M			(0x0 << 14)
> #define YTPHY_SSR_SPEED_100M			(0x1 << 14)
> #define YTPHY_SSR_SPEED_1000M			(0x2 << 14)
> #define YTPHY_SSR_SPEED_10G			(0x3 << 14)
> #define YT8821_SSR_SPEED_2500M			(0x0 << 14) | BIT(9)
> #define YTPHY_SSR_SPEED_MASK			(0x3 << 14) | BIT(9)
>
please help to confirm it is ok?
#define YT8821_SSR_SPEED_2500M	((BIT(9) >> 9) << 2) | ((0x0 << 14) >> 14)

>> +#define YT8821_SDS_EXT_CSR_CTRL_REG			0x23
>> +#define YT8821_SDS_EXT_CSR_PLL_SETTING			0x8605
>> +#define YT8821_UTP_EXT_FFE_IPR_CTRL_REG			0x34E
>> +#define YT8821_UTP_EXT_FFE_SETTING			0x8080
>> +#define YT8821_UTP_EXT_VGA_LPF1_CAP_CTRL_REG		0x4D2
>> +#define YT8821_UTP_EXT_VGA_LPF1_CAP_SHT_SETTING		0x5200
>> +#define YT8821_UTP_EXT_VGA_LPF2_CAP_CTRL_REG		0x4D3
>> +#define YT8821_UTP_EXT_VGA_LPF2_CAP_SHT_SETTING		0x5200
>> +#define YT8821_UTP_EXT_TRACE_CTRL_REG			0x372
>> +#define YT8821_UTP_EXT_TRACE_LNG_MED_GAIN_THR_SETTING	0x5A3C
>> +#define YT8821_UTP_EXT_IPR_CTRL_REG			0x374
>> +#define YT8821_UTP_EXT_IPR_ALPHA_IPR_SETTING		0x7C6C
>> +#define YT8821_UTP_EXT_ECHO_CTRL_REG			0x336
>> +#define YT8821_UTP_EXT_ECHO_SETTING			0xAA0A
>> +#define YT8821_UTP_EXT_GAIN_CTRL_REG			0x340
>> +#define YT8821_UTP_EXT_AGC_MED_GAIN_SETTING		0x3022
>> +#define YT8821_UTP_EXT_TH_20DB_2500_CTRL_REG		0x36A
>> +#define YT8821_UTP_EXT_TH_20DB_2500_SETTING		0x8000
>> +#define YT8821_UTP_EXT_MU_COARSE_FR_CTRL_REG		0x4B3
>> +#define YT8821_UTP_EXT_MU_COARSE_FR_FFE_GN_DC_SETTING	0x7711
>> +#define YT8821_UTP_EXT_MU_FINE_FR_CTRL_REG		0x4B5
>> +#define YT8821_UTP_EXT_MU_FINE_FR_FFE_GN_DC_SETTING	0x2211
>> +#define YT8821_UTP_EXT_ANALOG_CFG7_CTRL_REG		0x56
>> +#define YT8821_UTP_EXT_ANALOG_CFG7_RESET		0x20
>> +#define YT8821_UTP_EXT_ANALOG_CFG7_PI_CLK_SEL_AFE	0x3F
>> +#define YT8821_UTP_EXT_VCT_CFG6_CTRL_REG		0x97
>> +#define YT8821_UTP_EXT_VCT_CFG6_FECHO_AMP_TH_SETTING	0x380C
>> +#define YT8821_UTP_EXT_TXGE_NFR_FR_THP_CTRL_REG		0x660
>> +#define YT8821_UTP_EXT_TXGE_NFR_FR_SETTING		0x112A
>> +#define YT8821_UTP_EXT_PLL_CTRL_REG			0x450
>> +#define YT8821_UTP_EXT_PLL_SPARE_SETTING		0xE9
>> +#define YT8821_UTP_EXT_DAC_IMID_CHANNEL23_CTRL_REG	0x466
>> +#define YT8821_UTP_EXT_DAC_IMID_CHANNEL23_SETTING	0x6464
>> +#define YT8821_UTP_EXT_DAC_IMID_CHANNEL01_CTRL_REG	0x467
>> +#define YT8821_UTP_EXT_DAC_IMID_CHANNEL01_SETTING	0x6464
>> +#define YT8821_UTP_EXT_DAC_IMSB_CHANNEL23_CTRL_REG	0x468
>> +#define YT8821_UTP_EXT_DAC_IMSB_CHANNEL23_SETTING	0x6464
>> +#define YT8821_UTP_EXT_DAC_IMSB_CHANNEL01_CTRL_REG	0x469
>> +#define YT8821_UTP_EXT_DAC_IMSB_CHANNEL01_SETTING	0x6464
> All these _SETTING are magic numbers. Can you document any of them?
>
please help to confirm it is ok?
#define YT8821_SDS_EXT_CSR_CTRL_REG			0x23
#define YT8821_SDS_EXT_CSR_VCO_LDO_EN			BIT(15)
#define YT8821_SDS_EXT_CSR_VCO_BIAS_LPF_EN		BIT(8)

#define YT8821_UTP_EXT_RPDN_CTRL_REG			0x34E
#define YT8821_UTP_EXT_RPDN_BP_FFE_LNG_2500		BIT(15)
#define YT8821_UTP_EXT_RPDN_BP_FFE_SHT_2500		BIT(7)
#define YT8821_UTP_EXT_RPDN_IPR_SHT_2500		GENMASK(6, 0)

#define YT8821_UTP_EXT_VGA_LPF1_CAP_CTRL_REG		0x4D2
#define YT8821_UTP_EXT_VGA_LPF1_CAP_OTHER		GENMASK(7, 4)
#define YT8821_UTP_EXT_VGA_LPF1_CAP_2500		GENMASK(3, 0)

#define YT8821_UTP_EXT_VGA_LPF2_CAP_CTRL_REG		0x4D3
#define YT8821_UTP_EXT_VGA_LPF2_CAP_OTHER		GENMASK(7, 4)
#define YT8821_UTP_EXT_VGA_LPF2_CAP_2500		GENMASK(3, 0)

#define YT8821_UTP_EXT_TRACE_CTRL_REG			0x372
#define YT8821_UTP_EXT_TRACE_LNG_GAIN_THE_2500		GENMASK(14, 8)
#define YT8821_UTP_EXT_TRACE_MED_GAIN_THE_2500		GENMASK(6, 0)

#define YT8821_UTP_EXT_ALPHA_IPR_CTRL_REG		0x374
#define YT8821_UTP_EXT_ALPHA_SHT_2500			GENMASK(14, 8)
#define YT8821_UTP_EXT_IPR_LNG_2500			GENMASK(6, 0)

#define YT8821_UTP_EXT_ECHO_CTRL_REG			0x336
#define YT8821_UTP_EXT_TRACE_LNG_GAIN_THR_1000		GENMASK(14, 8)

#define YT8821_UTP_EXT_GAIN_CTRL_REG			0x340
#define YT8821_UTP_EXT_TRACE_MED_GAIN_THR_1000		GENMASK(6, 0)

#define YT8821_UTP_EXT_TH_20DB_2500_CTRL_REG		0x36A
#define YT8821_UTP_EXT_TH_20DB_2500			GENMASK(15, 0)

#define YT8821_UTP_EXT_MU_COARSE_FR_CTRL_REG		0x4B3
#define YT8821_UTP_EXT_MU_COARSE_FR_F_FFE		GENMASK(14, 12)
#define YT8821_UTP_EXT_MU_COARSE_FR_F_FBE		GENMASK(10, 8)

#define YT8821_UTP_EXT_MU_FINE_FR_CTRL_REG		0x4B5
#define YT8821_UTP_EXT_MU_FINE_FR_F_FFE			GENMASK(14, 12)
#define YT8821_UTP_EXT_MU_FINE_FR_F_FBE			GENMASK(10, 8)

#define YT8821_UTP_EXT_PI_CTRL_REG			0x56
#define YT8821_UTP_EXT_PI_RST_N_FIFO			BIT(5)
#define YT8821_UTP_EXT_PI_TX_CLK_SEL_AFE		BIT(4)
#define YT8821_UTP_EXT_PI_RX_CLK_3_SEL_AFE		BIT(3)
#define YT8821_UTP_EXT_PI_RX_CLK_2_SEL_AFE		BIT(2)
#define YT8821_UTP_EXT_PI_RX_CLK_1_SEL_AFE		BIT(1)
#define YT8821_UTP_EXT_PI_RX_CLK_0_SEL_AFE		BIT(0)

#define YT8821_UTP_EXT_VCT_CFG6_CTRL_REG		0x97
#define YT8821_UTP_EXT_FECHO_AMP_TH_HUGE		GENMASK(15, 8)

#define YT8821_UTP_EXT_TXGE_NFR_FR_THP_CTRL_REG		0x660
#define YT8821_UTP_EXT_NFR_TX_ABILITY			BIT(3)

#define YT8821_UTP_EXT_PLL_CTRL_REG			0x450
#define YT8821_UTP_EXT_PLL_SPARE_CFG			GENMASK(7, 0)

#define YT8821_UTP_EXT_DAC_IMID_CH_2_3_CTRL_REG		0x466
#define YT8821_UTP_EXT_DAC_IMID_CH_3_10_ORG		GENMASK(14, 8)
#define YT8821_UTP_EXT_DAC_IMID_CH_2_10_ORG		GENMASK(6, 0)

#define YT8821_UTP_EXT_DAC_IMID_CH_0_1_CTRL_REG		0x467
#define YT8821_UTP_EXT_DAC_IMID_CH_1_10_ORG		GENMASK(14, 8)
#define YT8821_UTP_EXT_DAC_IMID_CH_0_10_ORG		GENMASK(6, 0)

#define YT8821_UTP_EXT_DAC_IMSB_CH_2_3_CTRL_REG		0x468
#define YT8821_UTP_EXT_DAC_IMSB_CH_3_10_ORG		GENMASK(14, 8)
#define YT8821_UTP_EXT_DAC_IMSB_CH_2_10_ORG		GENMASK(6, 0)

#define YT8821_UTP_EXT_DAC_IMSB_CH_0_1_CTRL_REG		0x469
#define YT8821_UTP_EXT_DAC_IMSB_CH_1_10_ORG		GENMASK(14, 8)
#define YT8821_UTP_EXT_DAC_IMSB_CH_0_10_ORG		GENMASK(6, 0)

>> +/**
>> + * yt8821_probe() - read dts to get chip mode
>> + * @phydev: a pointer to a &struct phy_device
>> + *
>> + * returns 0 or negative errno code
> kerneldoc requires a : after returns.
>
>> + */
>> +static int yt8821_probe(struct phy_device *phydev)
>> +{
>> +	struct device_node *node = phydev->mdio.dev.of_node;
>> +	struct device *dev = &phydev->mdio.dev;
>> +	struct yt8821_priv *priv;
>> +	u8 chip_mode;
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	phydev->priv = priv;
>> +
>> +	if (of_property_read_u8(node, "motorcomm,chip-mode", &chip_mode))
>> +		chip_mode = YT8821_CHIP_MODE_FORCE_BX2500;
>> +
>> +	switch (chip_mode) {
>> +	case YT8821_CHIP_MODE_AUTO_BX2500_SGMII:
>> +		priv->chip_mode = YT8821_CHIP_MODE_AUTO_BX2500_SGMII;
>> +		break;
>> +	case YT8821_CHIP_MODE_FORCE_BX2500:
>> +		priv->chip_mode = YT8821_CHIP_MODE_FORCE_BX2500;
>> +		break;
>> +	default:
>> +		phydev_warn(phydev, "chip_mode err:%d\n", chip_mode);
>> +		return -EINVAL;
> Didn't the binding say it defaults to forced? Yet here it gives an
> error?
>
>> + * yt8821_get_rate_matching - read register to get phy chip mode
> Why? You have it in priv?
>
>> +/**
>> + * yt8821gen_init_paged() - generic initialization according to page
>> + * @phydev: a pointer to a &struct phy_device
>> + * @page: The reg page(YT8521_RSSR_FIBER_SPACE/YT8521_RSSR_UTP_SPACE) to
>> + * operate.
>> + *
>> + * returns 0 or negative errno code
>> + */
>> +static int yt8821gen_init_paged(struct phy_device *phydev, int page)
>> +{
>> +	int old_page;
>> +	int ret = 0;
>> +
>> +	old_page = phy_select_page(phydev, page & YT8521_RSSR_SPACE_MASK);
>> +	if (old_page < 0)
>> +		goto err_restore_page;
>> +
>> +	if (page & YT8521_RSSR_SPACE_MASK) {
>> +		/* sds init */
>> +		ret = __phy_modify(phydev, MII_BMCR, BMCR_ANENABLE, 0);
>> +		if (ret < 0)
>> +			goto err_restore_page;
>> +
>> +		ret = ytphy_write_ext(phydev, YT8821_SDS_EXT_CSR_CTRL_REG,
>> +				      YT8821_SDS_EXT_CSR_PLL_SETTING);
>> +		if (ret < 0)
>> +			goto err_restore_page;
>> +	} else {
>> +		/* utp init */
>> +		ret = ytphy_write_ext(phydev, YT8821_UTP_EXT_FFE_IPR_CTRL_REG,
>> +				      YT8821_UTP_EXT_FFE_SETTING);
>> +		if (ret < 0)
>> +			goto err_restore_page;
>> +
> ...
>
>> +	}
>> +
>> +err_restore_page:
>> +	return phy_restore_page(phydev, old_page, ret);
>> +}
>> +
>> +/**
>> + * yt8821gen_init() - generic initialization
>> + * @phydev: a pointer to a &struct phy_device
>> + *
>> + * returns 0 or negative errno code
>> + */
>> +static int yt8821gen_init(struct phy_device *phydev)
>> +{
>> +	int ret = 0;
>> +
>> +	ret = yt8821gen_init_paged(phydev, YT8521_RSSR_FIBER_SPACE);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return yt8821gen_init_paged(phydev, YT8521_RSSR_UTP_SPACE);
> That is odd. Why not have two functions, rather than one with a
> parameter. You get better functions names then, making it clearer what
> each function is doing.

In next commit, yt8821gen_init_paged(phydev, YT8521_RSSR_FIBER_SPACE); will
be replaced with yt8821_serdes_init(phydev);,
yt8821gen_init_paged(phydev, YT8521_RSSR_UTP_SPACE); will be replaced with
yt8821_utp_init(phydev);
please help to confirm it is ok?

>> +}
>> +
>> +/**
>> + * yt8821_auto_sleep_config() - phy auto sleep config
>> + * @phydev: a pointer to a &struct phy_device
>> + * @enable: true enable auto sleep, false disable auto sleep
>> + *
>> + * returns 0 or negative errno code
>> + */
>> +static int yt8821_auto_sleep_config(struct phy_device *phydev, bool enable)
>> +{
>> +	int old_page;
>> +	int ret = 0;
>> +
>> +	old_page = phy_select_page(phydev, YT8521_RSSR_UTP_SPACE);
>> +	if (old_page < 0)
>> +		goto err_restore_page;
>> +
>> +	ret = ytphy_modify_ext(phydev,
>> +			       YT8521_EXTREG_SLEEP_CONTROL1_REG,
>> +			       YT8521_ESC1R_SLEEP_SW,
>> +			       enable ? 1 : 0);
> So each page has its own extension registers?

Yes

>
>> +	if (ret < 0)
>> +		goto err_restore_page;
>> +
>> +err_restore_page:
>> +	return phy_restore_page(phydev, old_page, ret);
>> +}
>> +
>> +/**
>> + * yt8821_config_init() - phy initializatioin
>> + * @phydev: a pointer to a &struct phy_device
>> + *
>> + * returns 0 or negative errno code
>> + */
>> +static int yt8821_config_init(struct phy_device *phydev)
>> +{
>> +	struct yt8821_priv *priv = phydev->priv;
>> +	int ret, val;
>> +
>> +	phydev->irq = PHY_POLL;
> Why do this?

phydev->irq = PHY_POLL; will be removed in next commit.

>
>> +
>> +	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
>> +	if (priv->chip_mode == YT8821_CHIP_MODE_AUTO_BX2500_SGMII) {
>> +		ret = ytphy_modify_ext_with_lock(phydev,
>> +						 YT8521_CHIP_CONFIG_REG,
>> +						 YT8521_CCR_MODE_SEL_MASK,
>> +						 FIELD_PREP(YT8521_CCR_MODE_SEL_MASK, 0));
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		__assign_bit(PHY_INTERFACE_MODE_2500BASEX,
>> +			     phydev->possible_interfaces,
>> +			     true);
>> +		__assign_bit(PHY_INTERFACE_MODE_SGMII,
>> +			     phydev->possible_interfaces,
>> +			     true);
>> +
>> +		phydev->rate_matching = RATE_MATCH_NONE;
>> +	} else if (priv->chip_mode == YT8821_CHIP_MODE_FORCE_BX2500) {
>> +		ret = ytphy_modify_ext_with_lock(phydev,
>> +						 YT8521_CHIP_CONFIG_REG,
>> +						 YT8521_CCR_MODE_SEL_MASK,
>> +						 FIELD_PREP(YT8521_CCR_MODE_SEL_MASK, 1));
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		phydev->rate_matching = RATE_MATCH_PAUSE;
>> +	}
> The idea of this phydev->possible_interfaces is to allow the core to
> figure out what mode is most appropriate. So i would drop the mode in
> DT, default to auto, and let the core tell you it wants 2500 BaseX if
> that is all the MAC can do.
>
>> +static int yt8821_read_status(struct phy_device *phydev)
>> +{
>> +	struct yt8821_priv *priv = phydev->priv;
>> +	int old_page;
>> +	int ret = 0;
>> +	int link;
>> +	int val;
>> +
>> +	if (phydev->autoneg == AUTONEG_ENABLE) {
>> +		int lpadv = phy_read_mmd(phydev,
>> +					 MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
>> +
>> +		if (lpadv < 0)
>> +			return lpadv;
>> +
>> +		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising,
>> +						  lpadv);
>> +	}
>> +
>> +	ret = ytphy_write_ext_with_lock(phydev,
>> +					YT8521_REG_SPACE_SELECT_REG,
>> +					YT8521_RSSR_UTP_SPACE);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = genphy_read_status(phydev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	old_page = phy_select_page(phydev, YT8521_RSSR_UTP_SPACE);
>> +	if (old_page < 0)
>> +		goto err_restore_page;
>> +
>> +	val = __phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG);
>> +	if (val < 0) {
>> +		ret = val;
>> +		goto err_restore_page;
>> +	}
>> +
>> +	link = val & YTPHY_SSR_LINK;
>> +	if (link)
>> +		yt8821_adjust_status(phydev, val);
>> +
>> +	if (link) {
>> +		if (phydev->link == 0)
>> +			phydev_info(phydev,
>> +				    "%s, phy addr: %d, link up, mii reg 0x%x = 0x%x\n",
>> +				    __func__, phydev->mdio.addr,
>> +				    YTPHY_SPECIFIC_STATUS_REG,
>> +				    (unsigned int)val);
> phydev_dbg()?
>
phydev_dbg() instead in next commit.

>> +		phydev->link = 1;
>> +	} else {
>> +		if (phydev->link == 1)
>> +			phydev_info(phydev, "%s, phy addr: %d, link down\n",
>> +				    __func__, phydev->mdio.addr);
> phydev_dbg()?
>
> 	Andrew

