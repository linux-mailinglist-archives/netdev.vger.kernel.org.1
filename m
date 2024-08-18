Return-Path: <netdev+bounces-119454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE11955B5F
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 08:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F4BB2113C
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 06:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1402D268;
	Sun, 18 Aug 2024 06:37:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654EFC0A;
	Sun, 18 Aug 2024 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963051; cv=none; b=gsqwhJJ7bQi77Y9Fzb/QZIKtPuHIKOsRL5mLQPC8735gv7ggntgjXQ+/5AgRbCOxLEFx+EPK03/AYKS3Bo1XwT5piUY76tvJWBIrmGXUVxiOTSPRTIDYEczFUR7sLY7mZ1uBO9WrtwgCE6zNHU+RtJOvFoJuOFpKThU5kZT1c/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963051; c=relaxed/simple;
	bh=1FLRfl8oDMdmwSZEuccVBa3OVneT0Ya49b2lwc5PqdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5pp8E2HmF9SIYqStXCxsjsl1tpuuIYRcBnjUGvj2/rkIOHM43FpMMoW9QS6KD++NmjHdwB9bIMB6VcWZ6UD8OleeA6u7IFfhplt98nqJ96Ei91+2Ec0O2BQfJV9AVt/U//AisuUqXw4MK2uRP7vj32jicXKtjfA6EOX/NP+7lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from 192.168.208.130(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.YvIfKL8_1723962999)
          by smtp.aliyun-inc.com;
          Sun, 18 Aug 2024 14:37:13 +0800
Message-ID: <0d4d3507-f095-47c6-866f-1e850cf7f3d8@motor-comm.com>
Date: Sat, 17 Aug 2024 23:36:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add driver for Motorcomm yt8821
 2.5G ethernet phy
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
 xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com, jie.han@motor-comm.com
References: <20240816060955.47076-1-Frank.Sae@motor-comm.com>
 <20240816060955.47076-3-Frank.Sae@motor-comm.com>
 <ZsCLMQWoZcVV+7xR@shell.armlinux.org.uk>
Content-Language: en-US
From: "Frank.Sae" <Frank.Sae@motor-comm.com>
In-Reply-To: <ZsCLMQWoZcVV+7xR@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/17/24 04:36, Russell King (Oracle) wrote:
> On Thu, Aug 15, 2024 at 11:09:55PM -0700, Frank Sae wrote:
>> +static int yt8821_get_rate_matching(struct phy_device *phydev,
>> +				    phy_interface_t iface)
>> +{
>> +	int val;
>> +
>> +	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
>> +	if (val < 0)
>> +		return val;
>> +
>> +	if (FIELD_GET(YT8521_CCR_MODE_SEL_MASK, val) ==
>> +	    YT8821_CHIP_MODE_FORCE_BX2500)
>> +		return RATE_MATCH_PAUSE;
> Does this device do rate matching for _any_ interface mode if it has
> this bit set - because that's what you're saying here by not testing
> "iface". From what I understand from your previous posting which
> included a DT update, this only applies when 2500base-X is being
> used as the interface mode.

Here not check parameter iface, it is not to say that iface has no relation
with rate matching. when interface is configed with phy-mode property in
DT, modify YT8521_CHIP_CONFIG_REG register bit2:0 dependent on
phydev->interface in yt8821_config_init(), if phy-mode = "sgmii", bit2:0
will be set 3'b000, if phy-mode = "2500base-x", bit2:0 will be set 3'b001.

so that YT8521_CHIP_CONFIG_REG register bit2:0 may decide enable or disable
rate matching feature in yt8821_get_rate_matching() and do not care input
parameter iface here.

>> +static int yt8821_aneg_done(struct phy_device *phydev)
>> +{
>> +	int link;
>> +
>> +	link = yt8521_aneg_done_paged(phydev, YT8521_RSSR_UTP_SPACE);
>> +
>> +	return link;
>> +}
> Why not just:
>
> 	return yt8521_aneg_done_paged(phydev, YT8521_RSSR_UTP_SPACE);
>
> ?
>
>> +/**
>> + * yt8821_config_init() - phy initializatioin
>> + * @phydev: a pointer to a &struct phy_device
>> + *
>> + * Returns: 0 or negative errno code
>> + */
>> +static int yt8821_config_init(struct phy_device *phydev)
>> +{
>> +	u8 mode = YT8821_CHIP_MODE_AUTO_BX2500_SGMII;
>> +	int ret;
>> +	u16 set;
>> +
>> +	if (phydev->interface == PHY_INTERFACE_MODE_2500BASEX)
>> +		mode = YT8821_CHIP_MODE_FORCE_BX2500;
> Hmm, I think this is tying us into situations we don't want. What if the
> host supports 2500base-X and SGMII, but does not support pause (for
> example, Marvell PP2 based hosts.) In that situation, we don't want to
> lock-in to using pause based rate adaption, which I fear will become
> a behaviour that would be risky to change later on.

yt8821 is pin2pin realtek rtl8221.

please refer to description about interface force 2500base-x and auto
2500base-x_sgmii in datasheet.

In AUTO_BX2500_SGMII mode, The internal flow control buffer is disabled in
this mode.

In FORCE_BX2500, SerDes always works as 2500BASE-X, internal flow control
buffer will be activated if UTP doesn't work at 2.5GBASE-T.

>> +
>> +	set = FIELD_PREP(YT8521_CCR_MODE_SEL_MASK, mode);
>> +	ret = ytphy_modify_ext_with_lock(phydev,
>> +					 YT8521_CHIP_CONFIG_REG,
>> +					 YT8521_CCR_MODE_SEL_MASK,
>> +					 set);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (mode == YT8821_CHIP_MODE_AUTO_BX2500_SGMII) {
>> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
>> +			  phydev->possible_interfaces);
>> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
>> +			  phydev->possible_interfaces);
>> +
>> +		phydev->rate_matching = RATE_MATCH_NONE;
>> +	} else if (mode == YT8821_CHIP_MODE_FORCE_BX2500) {
> 		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> 			  phydev->possible_interfaces);
>
> so that phylink knows you're only going to be using a single interface
> mode. Even better, since this is always supported, move it out of these
> if() statements?

it is ok.

>
>
> Also, it would be nice to have phydev->supported_interfaces populated
> (which has to be done when the PHY is probed) so that phylink knows
> before connecting with the PHY which interface modes are supported by
> the PHY. (Andrew - please can we make this a condition for any new PHYs
> supported by phylib in the future?)

now no supported_interfaces member in struct phy_device.

> Note the point below in my signature.
>

