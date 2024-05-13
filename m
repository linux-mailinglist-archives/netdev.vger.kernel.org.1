Return-Path: <netdev+bounces-96083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821A18C43E1
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4701F2416D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A32F1DDF6;
	Mon, 13 May 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="8HAe26MZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A36139;
	Mon, 13 May 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613234; cv=none; b=chUaS71W28pzREBwvMcX8a500ERcdy7woOlt+hQsiZ2cJY8/VgWd4SY30DL6oAZ1kgz/u7h2N2J6GkxbEnq6zJxXrwBEb6788Jvpgxrw4vMLy9SRCufONJCZlqpZIBDUfAq+09o8gKx5IVoNwcLuxJQ7Dm3XLFJWxP7ebXHod64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613234; c=relaxed/simple;
	bh=CMnuNvZMA1kW0txi/Z56FI+v7g+9xLk1T/sjMlSF6r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WivsX9Uqr/GTgqcgid/0kDk0phvr9q4sPdvPSGAhPCxUggiWEA+6JsaYscfkUiaVaNOiaw/coVDqNxaXlQWIW973N+bHGy1ft0K/O53eMZhjeK1kq7AXVit+RS4DqEL30AdFmX/PdJxs7cUYVUlh8MMFAFKfPGCuXpxNgjxrTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=8HAe26MZ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DBp6pr031443;
	Mon, 13 May 2024 17:13:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=WnCypk5xq6HHOOx2jZdzw5WS7otaqKU1MDbXL+c2PRk=; b=8H
	Ae26MZue27BGaHUkCpZdch6O0tZ3bO806wwLEpgQE1qHqOPCEKpbKc8DkSqS5E2y
	E95sDxLYFmUxhcgEbewMAOcHtF2cbS1AwvGwioWHZDuobZ6j3kA6tT2iRN3Gf5Bx
	TxsIDzm5A67KeRgVasGl7E0yLZqVUs2dI5aNuRa7i7/m+XUrM12bdJ0B+CdHaLy6
	mNL3vZBYmrKofynpWiet6xxxRrY2FFAbmcYfoIi/rt1abj67Km6xpDpDT7YiXuh5
	xwgBln0YmwvBhCoczBtl+YfTIP06j0pXsIH9RKTI2XxRBwuzv/yJ1fKsaUizg4BX
	FaSdWLi3MNTtbxxz8ZRg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y1yjb766r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 17:13:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4EED240044;
	Mon, 13 May 2024 17:13:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 81976222C9C;
	Mon, 13 May 2024 17:11:56 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 17:11:53 +0200
Message-ID: <3137049f-eac8-4522-ad2e-b2b0d3537239@foss.st.com>
Date: Mon, 13 May 2024 17:11:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] net: stmmac: dwmac-stm32: update config
 management for phy wo cristal
To: Marek Vasut <marex@denx.de>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-6-christophe.roullier@foss.st.com>
 <b790f34e-8bfb-44f6-869d-798508008483@denx.de>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <b790f34e-8bfb-44f6-869d-798508008483@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_10,2024-05-10_02,2023-05-22_02


On 4/26/24 17:37, Marek Vasut wrote:
> On 4/26/24 2:57 PM, Christophe Roullier wrote:
>> Some cleaning because some Ethernet PHY configs do not need to add
>> st,ext-phyclk property.
>> Change print info message "No phy clock provided" only when debug.
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> ---
>>   .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 27 ++++++++++---------
>>   1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c 
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> index 7529a8d15492..e648c4e790a7 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> @@ -55,17 +55,17 @@
>>    *|         |        |      25MHz    |        50MHz 
>> |                  |
>>    * 
>> ---------------------------------------------------------------------------
>>    *|  MII    |     -   |     eth-ck    |          n/a |      
>> n/a        |
>> - *|         |        | st,ext-phyclk | |             |
>> + *|         |        |                 | |             |
>>    * 
>> ---------------------------------------------------------------------------
>>    *|  GMII   |     -   |     eth-ck    |          n/a |      
>> n/a        |
>> - *|         |        | st,ext-phyclk | |             |
>> + *|         |        |               | |             |
>>    * 
>> ---------------------------------------------------------------------------
>>    *| RGMII   |     -   |     eth-ck    |          n/a |      
>> eth-ck      |
>> - *|         |        | st,ext-phyclk |                    | 
>> st,eth-clk-sel or|
>> + *|         |        |               |                    | 
>> st,eth-clk-sel or|
>>    *|         |        |               |                    | 
>> st,ext-phyclk    |
>>    * 
>> ---------------------------------------------------------------------------
>>    *| RMII    |     -   |     eth-ck    |        eth-ck |      
>> n/a        |
>> - *|         |        | st,ext-phyclk | st,eth-ref-clk-sel 
>> |             |
>> + *|         |        |               | st,eth-ref-clk-sel 
>> |             |
>>    *|         |        |               | or st,ext-phyclk 
>> |             |
>>    * 
>> ---------------------------------------------------------------------------
>>    *
>> @@ -174,23 +174,22 @@ static int stm32mp1_set_mode(struct 
>> plat_stmmacenet_data *plat_dat)
>>       dwmac->enable_eth_ck = false;
>>       switch (plat_dat->mac_interface) {
>>       case PHY_INTERFACE_MODE_MII:
>> -        if (clk_rate == ETH_CK_F_25M && dwmac->ext_phyclk)
>> +        if (clk_rate == ETH_CK_F_25M)
>
> I see two problems here.
>
> First, according to the table above, in MII mode, clk_rate cannot be 
> anything else but 25 MHz, so the (clk_rate == ETH_CK_F_25M) condition 
> is always true. Why not drop that condition ?
Not agree, there is also "Normal" case MII (MII with quartz/cristal) 
(first column in the table above), so need to keep this test to check 
clk_rate 25MHz.
>
> The "dwmac->ext_phyclk" means "Ethernet PHY have no crystal", which 
> means the clock are provided by the STM32 RCC clock IP instead, which 
> means if the dwmac->ext_phyclk is true, dwmac->enable_eth_ck should be 
> set to true, because dwmac->enable_eth_ck controls the enablement of 
> these STM32 clock IP generated clock.
Right
>
> Second, as far as I understand it, there is no way to operate this IP 
> with external clock in MII mode, so this section should always be only:
>
> dwmac->enable_eth_ck = true;
Not for case "Normal" MII :-)
>
>>               dwmac->enable_eth_ck = true;
>>           val = dwmac->ops->pmcsetr.eth1_selmii;
>>           pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
>>           break;
>>       case PHY_INTERFACE_MODE_GMII:
>>           val = SYSCFG_PMCR_ETH_SEL_GMII;
>> -        if (clk_rate == ETH_CK_F_25M &&
>> -            (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
>> +        if (clk_rate == ETH_CK_F_25M)
>>               dwmac->enable_eth_ck = true;
>> -            val |= dwmac->ops->pmcsetr.eth1_clk_sel;
>> -        }
>>           pr_debug("SYSCFG init : PHY_INTERFACE_MODE_GMII\n");
>>           break;
>>       case PHY_INTERFACE_MODE_RMII:
>>           val = dwmac->ops->pmcsetr.eth1_sel_rmii | 
>> dwmac->ops->pmcsetr.eth2_sel_rmii;
>> -        if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_50M) &&
>> +        if (clk_rate == ETH_CK_F_25M)
>> +            dwmac->enable_eth_ck = true;
>> +        if (clk_rate == ETH_CK_F_50M &&
>>               (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk)) {
>
> This doesn't seem to be equivalent change to the previous code . Here, 
> if the clock frequency is 25 MHz, the clock are unconditionally 
> enabled. Before, the code enabled the clock only if clock frequency 
> was 25 MHz AND one of the "dwmac->eth_ref_clk_sel_reg" or 
> "dwmac->ext_phyclk" was set (i.e. clock provided by SoC RCC clock IP).

You are right, but in STM32MP15/MP13 reference manual it is write that 
we need to update SYSCFG (SYSCFG_PMCSETR) register only in "Ethernet 
50MHz RMII clock selection":

Bit 17 ETH_REF_CLK_SEL: Ethernet 50MHz RMII clock selection.

     Set by software.

       0: Writing '0' has no effect, reading '0' means External clock is 
used. Need selection of AFMux. Could be used with all PHY

       1: Writing '1' set this bit, reading '1' means Internal clock 
ETH_CLK1 from RCC is used regardless AFMux. Could be used only with RMII PHY

>
> I think it might make this code easier if you drop all of the 
> frequency test conditionals, which aren't really all that useful, and 
> only enable the clock if either dwmac->ext_phyclk / 
> dwmac->eth_clk_sel_reg / dwmac->eth_ref_clk_sel_reg is set , because 
> effectively what this entire convoluted code is implementing is "if 
> (clock supplied by clock IP i.e. RCC) enable the clock()" *, right ?
>
> * And it is also toggling the right clock mux bit in PMCSETR.
>
> So, for MII this would be plain:
> dwmac->enable_eth_ck = true;
>
> For GMII/RGMII this would be:
> if (dwmac->ext_phyclk || dwmac->eth_clk_sel_reg)
>   dwmac->enable_eth_ck = true;
>
> For RMII this would be:
> if (dwmac->ext_phyclk || dwmac->eth_ref_clk_sel_reg)
>   dwmac->enable_eth_ck = true;
>
> Maybe the clock frequency validation can be retained, but done 
> separately?
As explained previously, need to keep check of clock frequency in this test.
>
>>               dwmac->enable_eth_ck = true;
>>               val |= dwmac->ops->pmcsetr.eth1_ref_clk_sel;
>> @@ -203,7 +202,9 @@ static int stm32mp1_set_mode(struct 
>> plat_stmmacenet_data *plat_dat)
>>       case PHY_INTERFACE_MODE_RGMII_RXID:
>>       case PHY_INTERFACE_MODE_RGMII_TXID:
>>           val = dwmac->ops->pmcsetr.eth1_sel_rgmii | 
>> dwmac->ops->pmcsetr.eth2_sel_rgmii;
>> -        if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_125M) &&
>> +        if (clk_rate == ETH_CK_F_25M)
>> +            dwmac->enable_eth_ck = true;
>> +        if (clk_rate == ETH_CK_F_125M &&
>>               (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
>>               dwmac->enable_eth_ck = true;
>>               val |= dwmac->ops->pmcsetr.eth1_clk_sel;
>> @@ -219,7 +220,7 @@ static int stm32mp1_set_mode(struct 
>> plat_stmmacenet_data *plat_dat)
>>       }
>>         /* Need to update PMCCLRR (clear register) */
>> -    regmap_write(dwmac->regmap, reg + dwmac->ops->syscfg_clr_off,
>> +    regmap_write(dwmac->regmap, dwmac->ops->syscfg_clr_off,
>>                dwmac->mode_mask);
>>         /* Update PMCSETR (set register) */
>> @@ -328,7 +329,7 @@ static int stm32mp1_parse_data(struct stm32_dwmac 
>> *dwmac,
>>       /*  Get ETH_CLK clocks */
>>       dwmac->clk_eth_ck = devm_clk_get(dev, "eth-ck");
>>       if (IS_ERR(dwmac->clk_eth_ck)) {
>> -        dev_info(dev, "No phy clock provided...\n");
>> +        dev_dbg(dev, "No phy clock provided...\n");
>>           dwmac->clk_eth_ck = NULL;
>>       }

