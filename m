Return-Path: <netdev+bounces-222912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD00CB56EE2
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 05:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DCE1899292
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E92420A5DD;
	Mon, 15 Sep 2025 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Lvl5S8pN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m15577.qiye.163.com (mail-m15577.qiye.163.com [101.71.155.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E341B6D06;
	Mon, 15 Sep 2025 03:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757907507; cv=none; b=WLSgnX7ZCHqHcb34WsiFMkv3kIIuW0dLM5Um8mXCp5uAtyLGaawB76tyjOhnSc2WgrEkKlmBP30bVJbbUPP7MDiQ9mr0rTKDutOuKx1crgTzGK1Nml+hbX8DgMQ3yBpLQ6v3/yAJlCWBPbyxh9z90CZNherj7xfs12yiCCpO4jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757907507; c=relaxed/simple;
	bh=/xc1zd9KAuHRGU1aPx+ust4hmr4zb1B5xHZFfFubWXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ig346lkSWc7awJuYvAwvKinyYogKFKs7fd5mIKiROnOAViYwKNxmYk7GCb3SzYzB3QATFq+e7QpndW5Wtcyx/rKGllL4yjQ/vWR2XH66rz0QoWL3ORx3DJHhMSG8kwxKsJoTQmmIdMT9byZcch9FijReKg2Mnqe5qzT6Ehx9XPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Lvl5S8pN; arc=none smtp.client-ip=101.71.155.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 22c8b5b47;
	Mon, 15 Sep 2025 11:38:12 +0800 (GMT+08:00)
Message-ID: <bda5453b-5cc8-4d31-9143-3e23b5d914d2@rock-chips.com>
Date: Mon, 15 Sep 2025 11:38:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't contain
 invalid address
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Yao Zi <ziyao@disroot.org>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20250904031222.40953-3-ziyao@disroot.org>
 <aLlwv3v8ACha8b-3@shell.armlinux.org.uk>
 <b5fbeb3f-9962-444d-85b3-3b8a11f69266@rock-chips.com>
 <aLlyb6WvoBiBfUx3@shell.armlinux.org.uk>
 <aLly7lJ05xQjqCWn@shell.armlinux.org.uk> <aLvIbPfWWNa6TwNv@pie>
 <5d691f5b-460e-46cb-9658-9c391058342f@rock-chips.com>
 <wgau7accvif4pcblnkpppyve4isstvmxyljlojt2yu4cwnyqvf@od4zasgpwdjr>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <wgau7accvif4pcblnkpppyve4isstvmxyljlojt2yu4cwnyqvf@od4zasgpwdjr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a994b739fc103abkunm50451f02ab88b3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUtISFZPSUsZTkxLTk5NGklWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Lvl5S8pN8u8JQeTy99+juZGGQlsIspYWMdGRWMc49pPXE9TcJEuPh0U3r5oetVv7l+BEpCygircNrUnlXK5O4vBw3XrB3GkE+xRXa7yy5F+QYIbAQjQQbTjW7dtHcyVBOOfmhyRJEsBS5mokBDNKjJChhqvhpMuacvImDYZckvQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Mq67zs+U1255nllj+V7rSH0ZUO6DNosUCaee26uoN3Y=;
	h=date:mime-version:subject:message-id:from;

Hi Sebastian,

On 9/7/2025 4:25 AM, Sebastian Reichel wrote:
> Hi,
>
> On Sat, Sep 06, 2025 at 02:26:31PM +0800, Chaoyi Chen wrote:
>> On 9/6/2025 1:36 PM, Yao Zi wrote:
>>
>>> On Thu, Sep 04, 2025 at 12:07:26PM +0100, Russell King (Oracle) wrote:
>>>> On Thu, Sep 04, 2025 at 12:05:19PM +0100, Russell King (Oracle) wrote:
>>>>> On Thu, Sep 04, 2025 at 07:03:10PM +0800, Chaoyi Chen wrote:
>>>>>> On 9/4/2025 6:58 PM, Russell King (Oracle) wrote:
>>>>>>> On Thu, Sep 04, 2025 at 03:12:24AM +0000, Yao Zi wrote:
>>>>>>>>     	if (plat->phy_node) {
>>>>>>>>     		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
>>>>>>>>     		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
>>>>>>>> -		/* If it is not integrated_phy, clk_phy is optional */
>>>>>>>> +		/*
>>>>>>>> +		 * If it is not integrated_phy, clk_phy is optional. But we must
>>>>>>>> +		 * set bsp_priv->clk_phy to NULL if clk_phy isn't proivded, or
>>>>>>>> +		 * the error code could be wrongly taken as an invalid pointer.
>>>>>>>> +		 */
>>>>>>> I'm concerned by this. This code is getting the first clock from the DT
>>>>>>> description of the PHY. We don't know what type of PHY it is, or what
>>>>>>> the DT description of that PHY might suggest that the first clock would
>>>>>>> be.
>>>>>>>
>>>>>>> However, we're geting it and setting it to 50MHz. What if the clock is
>>>>>>> not what we think it is?
>>>>>> We only set integrated_phy to 50M, which are all known targets. For external PHYs, we do not perform frequency settings.
>>>>> Same question concerning enabling and disabling another device's clock
>>>>> that the other device should be handling.
>>>> Let me be absolutely clear: I consider *everything* that is going on
>>>> with clk_phy here to be a dirty hack.
>>>>
>>>> Resources used by a device that has its own driver should be managed
>>>> by _that_ driver alone, not by some other random driver.
>>> Agree on this. Should we drop the patch, or fix it up for now to at
>>> least prevent the oops? Chaoyi, I guess there's no user of the feature
>>> for now, is it?
>> This at least needs fixing. Sorry, I have no idea how to implement
>> this in the PHY.
> I think the proper fix is to revert da114122b8314 ("net: ethernet:
> stmmac: dwmac-rk: Make the clk_phy could be used for external phy"),
> which has only recently been merged. External PHYs should reference
> their clocks themself instead of the MAC doing it.
>
> Chaoyi Chen: Have a look at the ROCK 4D devicetree:
>
> &mdio0 {
> 	rgmii_phy0: ethernet-phy@1 {
> 		compatible = "ethernet-phy-id001c.c916";
> 		reg = <0x1>;
> 		clocks = <&cru REFCLKO25M_GMAC0_OUT>;
> 		assigned-clocks = <&cru REFCLKO25M_GMAC0_OUT>;
> 		assigned-clock-rates = <25000000>;
>          ...
>      };
> };
>
> The clock is enabled by the RTL8211F PHY driver (check for
> devm_clk_get_optional_enabled in drivers/net/phy/realtek/realtek_main.c),
> as the PHY is the one needing the clock and not the Rockchip MAC. For
> this to work it is important to set the right compatible string, so
> that the kernel can probe the right driver without needing to read the
> identification registers (as that would require the clock to be already
> configured before the driver is being probed).

Yes, what you said is correct. This is also the issue we encountered earlier on RK3576 board :)


