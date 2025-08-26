Return-Path: <netdev+bounces-216837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD6BB356B2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 10:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAB11B66927
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8342877E3;
	Tue, 26 Aug 2025 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UusjxQNF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m15588.qiye.163.com (mail-m15588.qiye.163.com [101.71.155.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E727AC45;
	Tue, 26 Aug 2025 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196655; cv=none; b=PT2mXUAcLomksyPtZqTuL44n8uHWeEqWuxwJiytWwZU73GkeUmtq6XYZzcYyFoomdNquuNuukw6+b5RIZ487rtYJPXy8kMvbdQlwjS8pjp8q26wI3y+BKVnvmnApxlAeceGZPZYUTibe4lUu6CvVz+dagIqNMn9Lwkmt3ku0CkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196655; c=relaxed/simple;
	bh=NYQxuzRoyE3fAv952wesSvek/3GuuzRVk1hPqosGcc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPSGJqBKd0VMPymdj+5TLb72yURy3yEhXibNnk4v7hiZ4+Rj1jALU9XcO331dxTyQzZ/rKV0/r1+kHBBUn9DD6xW4LOwp23JCD7I27wXLSuuzhZOt3GMLGrDYMoz2+hczW5vb60qsTJoy7u4YBoxOzU8OjCZgk3NUeait9neYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UusjxQNF; arc=none smtp.client-ip=101.71.155.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 20a3254b0;
	Tue, 26 Aug 2025 16:08:42 +0800 (GMT+08:00)
Message-ID: <8240a3cc-aade-40d8-b2f4-09681f76be68@rock-chips.com>
Date: Tue, 26 Aug 2025 16:08:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: ethernet: stmmac: dwmac-rk: Make the
 clk_phy could be used for external phy
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Chaoyi Chen <kernel@airkyi.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20250815023515.114-1-kernel@airkyi.com>
 <CGME20250825072312eucas1p2d4751199c0ea069c7938218be60e5e93@eucas1p2.samsung.com>
 <a30a8c97-6b96-45ba-bad7-8a40401babc2@samsung.com>
 <d0fe6d16-181f-4b38-9457-1099fb6419d0@rock-chips.com>
 <809848c9-2ffa-4743-adda-b8b714b404de@samsung.com>
 <aKxnHFSrVeM7Be5A@shell.armlinux.org.uk>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <aKxnHFSrVeM7Be5A@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98e56c163203abkunmeb456a22128a486
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlJTFZJHRpIT0lNTh1KT0hWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UusjxQNFmrhgPsBeO4BSS3vwfcXBVWMPRqRdZNCreD0Y3L9qO8EqBSlYU2i1ULdp+iyY6GbBaf/00QZeXLzGw3wjtT9ZJo4HN1rR7oYsMs2ha4d9dM+kLxiPLGjbAciiCssQvAVh1ppofzqZbMudcpH4MkQE7IH114QtmiGhntE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=59s5xl47iUIECmsf5jnpdKqma5NgiHbA2ceA9PEBxGI=;
	h=date:mime-version:subject:message-id:from;

Hi Russell,

On 8/25/2025 9:37 PM, Russell King (Oracle) wrote:
> On Mon, Aug 25, 2025 at 12:53:37PM +0200, Marek Szyprowski wrote:
>> On 25.08.2025 11:57, Chaoyi Chen wrote:
>>> On 8/25/2025 3:23 PM, Marek Szyprowski wrote:
>>>> On 15.08.2025 04:35, Chaoyi Chen wrote:
>>>>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>>>
>>>>> For external phy, clk_phy should be optional, and some external phy
>>>>> need the clock input from clk_phy. This patch adds support for setting
>>>>> clk_phy for external phy.
>>>>>
>>>>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>>>>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>>> ---
>>>>>
>>>>> Changes in v3:
>>>>> - Link to V2:
>>>>> https://lore.kernel.org/netdev/20250812012127.197-1-kernel@airkyi.com/
>>>>> - Rebase to net-next/main
>>>>>
>>>>> Changes in v2:
>>>>> - Link to V1:
>>>>> https://lore.kernel.org/netdev/20250806011405.115-1-kernel@airkyi.com/
>>>>> - Remove get clock frequency from DT prop
>>>>>
>>>>>     drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 11 +++++++----
>>>>>     1 file changed, 7 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>>>>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>>>>> index ac8288301994..5d921e62c2f5 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>>>>> @@ -1412,12 +1412,15 @@ static int rk_gmac_clk_init(struct
>>>>> plat_stmmacenet_data *plat)
>>>>>             clk_set_rate(plat->stmmac_clk, 50000000);
>>>>>         }
>>>>>     -    if (plat->phy_node && bsp_priv->integrated_phy) {
>>>>> +    if (plat->phy_node) {
>>>>>             bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
>>>>>             ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
>>>>> -        if (ret)
>>>>> -            return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
>>>>> -        clk_set_rate(bsp_priv->clk_phy, 50000000);
>>>>> +        /* If it is not integrated_phy, clk_phy is optional */
>>>>> +        if (bsp_priv->integrated_phy) {
>>>>> +            if (ret)
>>>>> +                return dev_err_probe(dev, ret, "Cannot get PHY
>>>>> clock\n");
>>>>> +            clk_set_rate(bsp_priv->clk_phy, 50000000);
>>>>> +        }
>>> I think  we should set bsp_priv->clk_phy to NULL here if we failed to
>>> get the clock.
>>>
>>> Could you try this on your board? Thank you.
>> Right, the following change also fixes this issue:
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>> index 9fc41207cc45..2d19d48be01f 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>> @@ -1415,6 +1415,8 @@ static int rk_gmac_clk_init(struct
>> plat_stmmacenet_data *plat)
>>           if (plat->phy_node) {
>>                   bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
>>                   ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
>> +               if (ret)
>> +                       bsp_priv->clk_phy = NULL;
> Or just:
>
> 		clk = of_clk_get(plat->phy_node, 0);
> 		if (clk == ERR_PTR(-EPROBE_DEFER))

Do we actually need this? Maybe other devm_clk_get() before it would fail in advance.


> 			...
> 		else if (!IS_ERR)
> 			bsp_priv->clk_phy = clk;
>
> I don't have a free terminal to work out what "..." should be.
>

