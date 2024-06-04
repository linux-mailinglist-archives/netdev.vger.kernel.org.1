Return-Path: <netdev+bounces-100505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2616C8FAEDE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33372876A9
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A235814386D;
	Tue,  4 Jun 2024 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NNFQbzPs"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D73143C61;
	Tue,  4 Jun 2024 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493551; cv=none; b=nBwoGyoZqx+zYKO6MVLi3uaNNHuXAtevxI2vOYczJ0DwoxVYT5oGTsteY36oCioD3ypemqXH3G0415k7Kpava+BIUtOHLmmg23wSbH+YYHmur9ZJidqVDG6m0op4P4Y7ynZIVptybnR+mJzCReQS3esHoA42zhqIC1/pJpwwXGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493551; c=relaxed/simple;
	bh=GZXn3XmJqoOaFGUB/lXDS5b6YpMHC6+1oGZopS4SywE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qQRnXeO6eCgnlBNiGemzySHpoKL6C4D8OJitRHnzPh5lghVMJ6aJlh15zrMcOcgd+0ffwUQHzFROfOxocDQZWqn9KN/XEhC6V1TKLjgpFSZKWeRAYhYvtx2UsniHnXTUSWSRI5MxjxG4wXGeWsMaSorzQa+tzeljy9od9vV7nCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NNFQbzPs; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4548spgB031426;
	Tue, 4 Jun 2024 11:31:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	FQi2ng79ZmbW4+Hz+M/vUkFGo0dt44niiSmJA3UNOB8=; b=NNFQbzPsDaCwdtSy
	KCUCxh7vVExEbs/WTmc6yBoocLwdNPcmaMvPOrXmvjPyz3nfjvVK8yHVSleKOCYm
	/M1EuRO+4cfQrS3NAk+RhnWopiCC3u+/EJCaKq3ifO1fjPucLkaL5CCsBczqvGUo
	EL7+ulOBJs4NgJ2Vk51Y6DXsu+7lUS/HGnX29LRDtgu+XWj4JtjYjdhe5EPlAVrL
	1TPqEiCUivRfx/hU0ztCgTou81vLETZ3TbOOpLzJUUgtPnv0R1Qy2jz7HvubfqNp
	EM5UUJ0hhbTOKwFSbr+T3OQEzWFCvxAslndZQlZTO0P1jIiATomnYh85TDMQBfVZ
	az5vEg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ygd70sge1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 11:31:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0626840045;
	Tue,  4 Jun 2024 11:31:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 46232211F37;
	Tue,  4 Jun 2024 11:30:43 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 11:30:42 +0200
Message-ID: <291953b7-ed37-4b09-9009-588ffdd12fe7@foss.st.com>
Date: Tue, 4 Jun 2024 11:30:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] ARM: dts: stm32: add ethernet1 for
 STM32MP135F-DK board
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
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
 <20240603092757.71902-11-christophe.roullier@foss.st.com>
 <29b79c7d-7ff6-40fb-97be-7198a0e9d437@denx.de>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <29b79c7d-7ff6-40fb-97be-7198a0e9d437@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_03,2024-05-30_01,2024-05-17_01


On 6/3/24 15:08, Marek Vasut wrote:
> On 6/3/24 11:27 AM, Christophe Roullier wrote:
>> Ethernet1: RMII with crystal
>> PHY used is SMSC (LAN8742A)
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> ---
>>   arch/arm/boot/dts/st/stm32mp135f-dk.dts | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts 
>> b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
>> index 567e53ad285fa..cebe9b91eced9 100644
>> --- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
>> +++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
>> @@ -19,6 +19,7 @@ / {
>>       compatible = "st,stm32mp135f-dk", "st,stm32mp135";
>>         aliases {
>> +        ethernet0 = &ethernet1;
>>           serial0 = &uart4;
>>           serial1 = &usart1;
>>           serial2 = &uart8;
>> @@ -141,6 +142,29 @@ &cryp {
>>       status = "okay";
>>   };
>>   +&ethernet1 {
>> +    status = "okay";
>> +    pinctrl-0 = <&eth1_rmii_pins_a>;
>> +    pinctrl-1 = <&eth1_rmii_sleep_pins_a>;
>> +    pinctrl-names = "default", "sleep";
>> +    phy-mode = "rmii";
>> +    max-speed = <100>;
>
> Is this needed ? RMII cannot go faster than 100 .
>
ok (I will put in v4)
> Also, keep the list sorted alphabetically , P goes after M .
ok (I will put in v4)
>
>> +    phy-handle = <&phy0_eth1>;
>> +
>> +    mdio {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        compatible = "snps,dwmac-mdio";
>> +
>> +        phy0_eth1: ethernet-phy@0 {
>> +            compatible = "ethernet-phy-id0007.c131";
>> +            reset-gpios =  <&mcp23017 9 GPIO_ACTIVE_LOW>;
>
> Extra space between = and < , please drop.
ok (I will put in v4)

