Return-Path: <netdev+bounces-96090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 958568C44C9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9E01F213F4
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DE915532C;
	Mon, 13 May 2024 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KWL06VFg"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B28155320;
	Mon, 13 May 2024 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616286; cv=none; b=AklhWYDh2q4pdlviqaHDdZVhfzvaOYZlCIrHbPBiH4zeOv3yYdTgdObul0wkNVEcgmhvLCn+gJNXJrs4P8SWM8YPONaJrIL69JvOlIuRZApvF4nouCeelaRwGc9Lq7oeSIiEeVcmVI6xrDvb8VD5qXjVSXkZUFSrYyJgg3i2/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616286; c=relaxed/simple;
	bh=pWUQezwcvEM8YCOr5g1M17xK3KYYf4L5566Iz1r76tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uHAQLJy0GzdgQmmcvnVvFxwesW4gqNgcRXM9oyKSc7AR96M1mJ9ii7iJBvh5n80IXZchkFtGZ1eM09D3aqp221gsm75RA117BsDc/saAHe1m8aJEN/iVMk8NV8JEt5SSfGqvkJAPqWOJ3jJ7h4oXFC+hGOKNH8ZMtq4gp95VptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KWL06VFg; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DC1mtn004753;
	Mon, 13 May 2024 18:02:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=B766p5PPQr7dHmHzceq9OMDPS3Z4QnY2plz4PZdwYqw=; b=KW
	L06VFgIsC51L9S28vBzQzSYHj6WEM4xVAJUqLfJb8ECuAjIsa1qvRrObJzWq+iYe
	X5ordIMO33l3QmE+JiIrWBS8rm0CkFbUGgvNNYWJAwVpNCQkPU2MCfPP8lI8sB8g
	YEcPAQPwCAWh0vkvYm8gUhl+leGGwl7oCEA/x7tncYr9cOG3CGwF4p9yFkXE3sdB
	E+YQYokSpMjCECWYMDEdS0JtK8u8Y3VxtPAdmr9RNkwKZLB/ZcW+LodFYsPQQTJe
	m4wnAncEWTH1eJmt8clMTns0kKc7LT/amdW8mYFS+lSkg4vu2ydcJXH5V2Mx5bo2
	By1TNcybmLqb5IVmFsvw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y2kmhnf0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 18:02:31 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C915640044;
	Mon, 13 May 2024 18:02:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DBD832248DE;
	Mon, 13 May 2024 18:01:13 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 18:01:12 +0200
Message-ID: <8bf3be27-3222-422d-bfff-ff67271981d8@foss.st.com>
Date: Mon, 13 May 2024 18:01:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] ARM: dts: stm32: add ethernet1 and ethernet2 for
 STM32MP135F-DK board
To: Marek Vasut <marex@denx.de>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-11-christophe.roullier@foss.st.com>
 <43024130-dcd6-4175-b958-4401edfb5fd8@denx.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <43024130-dcd6-4175-b958-4401edfb5fd8@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_11,2024-05-10_02,2023-05-22_02

Hi Marek

On 4/26/24 17:44, Marek Vasut wrote:
> On 4/26/24 2:57 PM, Christophe Roullier wrote:
>> Add dual Ethernet:
>> -Ethernet1: RMII with crystal
>> -Ethernet2: RMII without crystal
>> PHYs used are SMSC (LAN8742A)
>>
>> With Ethernet1, we can performed WoL from PHY instead of GMAC point
>> of view.
>> (in this case IRQ for WoL is managed as wakeup pin and configured
>> in OS secure).
> 
> How does the Linux PHY driver process such a PHY IRQ ?
> 
> Or is Linux unaware of the PHY IRQ ? Doesn't that cause issues ?

In this case, we want to have an example to wakeup the system from 
Standby low power mode (VDDCPU and VDD_CORE off) thanks to a magic 
packet detected by the PHY. The PHY then assert his interrupt output signal.
On MP13 DK platform, this PHY signal is connected to a specific GPIO
aka "Wakeup pins" (only 6 wakeup pins an MP13). Those specific GPIOs are 
handled by the PWR peripheral which is controlled by the secure OS.

On WoL packet, the Secure OS catches the PHY interrupt and uses 
asynchronous notification mechanism to warn Linux (on our platform we 
use a PPI). On Linux side, Optee core driver creates an irq 
domain/irqchip triggered on the asynchronous notification. Each device 
which use a wakeup pin need then to request an IRQ on this "Optee irq 
domain".

This OPTEE irq domain will be pushed soon.

cheers
Alex

> 
>> diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts 
>> b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
>> index 567e53ad285f..3b8eb0ab9ab9 100644
>> --- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
>> +++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
>> @@ -19,6 +19,8 @@ / {
>>       compatible = "st,stm32mp135f-dk", "st,stm32mp135";
>>       aliases {
>> +        ethernet0 = &ethernet1;
>> +        ethernet1 = &ethernet2;
>>           serial0 = &uart4;
>>           serial1 = &usart1;
>>           serial2 = &uart8;
>> @@ -141,6 +143,52 @@ &cryp {
>>       status = "okay";
>>   };
>> +&ethernet1 {
>> +    status = "okay";
>> +    pinctrl-0 = <&eth1_rmii_pins_a>;
>> +    pinctrl-1 = <&eth1_rmii_sleep_pins_a>;
>> +    pinctrl-names = "default", "sleep";
>> +    phy-mode = "rmii";
>> +    max-speed = <100>;
>> +    phy-handle = <&phy0_eth1>;
> 
> Keep the list sorted please (is the max-speed even needed? if not, drop it)
> 
>> +    mdio {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        compatible = "snps,dwmac-mdio";
>> +
>> +        phy0_eth1: ethernet-phy@0 {
>> +            compatible = "ethernet-phy-id0007.c131";
>> +            reset-gpios =  <&mcp23017 9 GPIO_ACTIVE_LOW>;
>> +            reg = <0>;
>> +            wakeup-source;
>> +        };
>> +    };
>> +};
>> +
>> +&ethernet2 {
>> +    status = "okay";
>> +    pinctrl-0 = <&eth2_rmii_pins_a>;
>> +    pinctrl-1 = <&eth2_rmii_sleep_pins_a>;
>> +    pinctrl-names = "default", "sleep";
>> +    phy-mode = "rmii";
>> +    max-speed = <100>;
>> +    phy-handle = <&phy0_eth2>;
>> +    st,ext-phyclk;
>> +    phy-supply = <&scmi_v3v3_sw>;
> 
> Sort please
> 
> [...]

