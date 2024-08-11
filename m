Return-Path: <netdev+bounces-117484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAED94E18A
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FEFA1C20E00
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B8E1494B2;
	Sun, 11 Aug 2024 13:59:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893B2AD18;
	Sun, 11 Aug 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723384751; cv=none; b=RiKRRSUVaPaGURPKJ7K2gqXeOBZ5uaQOcS8X7Ro1dJVGVaifmU1XKc7681sLgjIGZ91y5owmUEhjEi+JC1egVVUhErDnU6+ONp9X2qVSfPfsO2VFibpc4eS2ZSMOppLjwQpJoMfmAofheOaP9CqNQBq6FtU/OtD9GiEGBw+0mLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723384751; c=relaxed/simple;
	bh=JaKh76HgcEnPVMiqBrySbQttBOagdFZCdBEh2QYS3PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaS5f/koRzYMFSo4Mg8gJHDZxzPzE7+szBl5Jk9EYw0mwatHPOmnZ6AHJg/Jamz5+pLgUd6yh5IeVLvXrdxsBfO7H2cxZZmWUBCi1i+XX53kBZv6cbwz3M1hD9JAszhENiIMWh4ALOBh6Ux/BheHPye73qBo3I1L1FTr4hPyTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from 192.168.208.130(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.YoCuORw_1723384734)
          by smtp.aliyun-inc.com;
          Sun, 11 Aug 2024 21:58:55 +0800
Message-ID: <c44be0f3-7850-4038-bffb-942a85e3c7d0@motor-comm.com>
Date: Sun, 11 Aug 2024 06:58:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: phy: Add driver for Motorcomm yt8821 2.5G
 ethernet phy
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
 xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com, jie.han@motor-comm.com
References: <20240727092031.1108690-1-Frank.Sae@motor-comm.com>
 <Zqd/6u5b7z1bCFaT@shell.armlinux.org.uk>
Content-Language: en-US
From: "Frank.Sae" <Frank.Sae@motor-comm.com>
In-Reply-To: <Zqd/6u5b7z1bCFaT@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/29/24 04:41, Russell King (Oracle) wrote:
> On Sat, Jul 27, 2024 at 02:20:31AM -0700, Frank.Sae wrote:
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
> Before each and every call to .config_init, phydev->possible_interfaces
> will be cleared. So, please use __set_bit() here.
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
> What link status is this reporting? For interface switching to work,
> phydev->link must _only_ indicate whether the _media_ side interface
> is up or down. It must _not_ include the status of the MAC facing
> interface from the PHY.
>
> Why? The interface configuration of the MAC is only performed when
> the _media_ link comes up, denoted by phydev->link becoming true.
> If the MAC interface configuration mismatches the PHY interface
> configuration, then the MAC facing interface of the PHY will
> remain down, and if phydev->link is forced to false, then the link
> will never come up.
>
> So, I hope that this isn't testing the MAC facing interface status
> of the PHY!
>
MAC facing interface will be switched according to phy interface. when phy
media side state is link down, the mac facing interface will not be
configured, this refers to Marvell10g.c(mv3310_update_interface) and
Realtek.c(rtl822xb_update_interface).


