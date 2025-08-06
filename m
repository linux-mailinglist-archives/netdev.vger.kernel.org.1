Return-Path: <netdev+bounces-211862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DABB1C01A
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 07:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03C46287AC
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 05:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5591FCFEF;
	Wed,  6 Aug 2025 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hPZq8Ego"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49208.qiye.163.com (mail-m49208.qiye.163.com [45.254.49.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15BB273FE;
	Wed,  6 Aug 2025 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459733; cv=none; b=YUH58ZiBJ+N2EhcEQsFxTxVz83eDbTHNuS20rRUr+8wu/XfbIHz666jTg65jME1UAII5KM5ITBKAzaS+JZ9133BVGaIRomt3NkRW1gER4Khr0LjEQPBef1ksIoB+V9wbeGO+QE/G1J7MB4f22r+vEUXumBhBcbjnEYJUh+S071g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459733; c=relaxed/simple;
	bh=tRu2MOTYT8KJYDw5bOFLBDKdTceUlMhJ4Mr7ocKZQiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9K+cy0nFL8jdGOFoDWFPoi99sWpo0MZvK8H2E1Ygl/fkD9Q7J1UMTyPeBmlUikato+s7EQKgtN22AbVKtRUufLrbquAPJaqoGX4rwd9EtEjiTlvAkrPzhuFoTAMXgeGP18+Qu6kCkK27oY0reKxZnGtikakw1/qBLFByVHyCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hPZq8Ego; arc=none smtp.client-ip=45.254.49.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1e71dd486;
	Wed, 6 Aug 2025 11:32:50 +0800 (GMT+08:00)
Message-ID: <d99c50ed-797b-4086-b1b5-d3df281d3c2a@rock-chips.com>
Date: Wed, 6 Aug 2025 11:32:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: stmmac: dwmac-rk: Make the clk_phy could
 be used for external phy
To: Andrew Lunn <andrew@lunn.ch>, Chaoyi Chen <kernel@airkyi.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <20250806011405.115-1-kernel@airkyi.com>
 <3c401e82-169f-4540-9c12-175798ac72a6@lunn.ch>
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <3c401e82-169f-4540-9c12-175798ac72a6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a987d70527103abkunmabbf8f177f0aa3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ00YSVZPT01CTElDHR9MGkpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hPZq8Ego38BXBeFh0nPLyfRxD634qAt3/p9YeuZs7mlvK3zqz2UF8JDVcd7x7Iu0ISGWD9ysDjHYSPFFWBw1dte+CwZssdF8F7luxfAtg/yPugeeE0IgJXf027Jg2ikOFGz4g0yofKftPXIpJx14vM5GyRvP0o9O3dLUnYsBFH4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=a1MobyGLfI/GmuK0n7WO7Oiwrjqt/Y28chaKKbEzA5U=;
	h=date:mime-version:subject:message-id:from;

Hi Andrew,

On 8/6/2025 11:14 AM, Andrew Lunn wrote:
> On Wed, Aug 06, 2025 at 09:14:05AM +0800, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> For external phy, clk_phy should be optional, and some external phy
>> need the clock input from clk_phy. This patch adds support for setting
>> clk_phy for external phy.
>>
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Please take a read of:
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> net-next is closed at the moment for the merge window.
>
> You also need the indicate the tree in the Subject: line.

Sorry for that, I will send v2 at an appropriate time.


>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>> index 700858ff6f7c..703b4b24f3bc 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
>> @@ -1558,6 +1558,7 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
>>   	struct device *dev = &bsp_priv->pdev->dev;
>>   	int phy_iface = bsp_priv->phy_iface;
>>   	int i, j, ret;
>> +	unsigned int rate;
> Reverse Christmas tree. Longest to shortest.

Will fix in v2.


>
>>   
>>   	bsp_priv->clk_enabled = false;
>>   
>> @@ -1595,12 +1596,19 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
>>   		clk_set_rate(bsp_priv->clk_mac, 50000000);
>>   	}
>>   
>> -	if (plat->phy_node && bsp_priv->integrated_phy) {
>> +	if (plat->phy_node) {
>>   		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
>>   		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
>> -		if (ret)
>> -			return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
>> -		clk_set_rate(bsp_priv->clk_phy, 50000000);
>> +		/* If it is not integrated_phy, clk_phy is optional */
>> +		if (bsp_priv->integrated_phy) {
>> +			if (ret)
>> +				return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
>> +
>> +			ret = of_property_read_u32(plat->phy_node, "clock-frequency", &rate);
> Is this property already in the DT binding?

I didn't see explicit binding, but make dtbs_check W=1 didn't generate 
any warning. I will drop this in v2.


>
>
>      Andrew
>
> ---
> pw-bot: cr
>
>

