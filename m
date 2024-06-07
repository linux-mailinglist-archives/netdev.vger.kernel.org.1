Return-Path: <netdev+bounces-101751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCF88FFF22
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9CC286736
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED89C15B143;
	Fri,  7 Jun 2024 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hmGhh3TD"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C0525D;
	Fri,  7 Jun 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752021; cv=none; b=MRcRoHohGvQlt6fHkQgGqjnamw8KhfIv6XGsCXpwiAHRm4gzBLUN9gmbIK94ZcBI9SqUXEi1Cf6nH4KASWKfCnkc7dXpKtWvgdm3ajR32kUrNdgEOPjRZHUUE31OcWPSLMECIvHbxGt+sZLd8lK0XMFgmUnLdjX+JxgiAJDuZjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752021; c=relaxed/simple;
	bh=5lhAGxbi1WkQqrBzui7aAjXB5BzgLd7FJ24TXfGuHaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZzbMph9kimQQMfU5D6OA68qjqZlAC3xZDZoom8hHQ7k9WacZSN8MtBk14Jmt7Y9uxGBqEHQ6USTz4YoUPXCg5CCpzdmm0kolv3w/GpRXQkdnsKusCx9lgyUdFlXVoEsLWvCDBb5016jR+jz+A7L+TiAjHcZAxL0JdpKBeTqHQIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hmGhh3TD; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45791ZeF002170;
	Fri, 7 Jun 2024 11:19:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	d3Kov9mztOBAq1R8O1XYu0dkAhTelqCjkvoNBjjUVWM=; b=hmGhh3TDJB9G8snz
	L5K5RwqNIWpHceqzBF1ct2BcIvol02o5LJ3j30qBCxtKcnwgmquWjFl1O09TLzPr
	Eydbe7AZr/ipURjAd5X8Xla/9UBd9Dpa64NTB5fRDKF+HzrVnONfvoePLGU5T4Cn
	nd3TTa/ZprsdHs0Z4ypXaqUkCDTyfAEBPVo4en3InsR4/6ayP1PQtTXi7z+fQ2K2
	1zYEcMNtNe2wHmAfmlgCPohrhlDGLSXs3uM6AYbgj8k3ubEywwvPKLswyjIHIpwY
	cRbsUmUWGd8Ig78xP5dm7sVSwYJn0zQQQN3fD4gGExmaVnNsgpw+p4aREqw2mMaU
	1Oxx3Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ygekj809d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 11:19:46 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5AEA340047;
	Fri,  7 Jun 2024 11:19:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 05BD02138CA;
	Fri,  7 Jun 2024 11:18:23 +0200 (CEST)
Received: from [10.252.19.205] (10.252.19.205) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 11:18:19 +0200
Message-ID: <3aeecd23-355e-4824-8706-a746e84b37b7@foss.st.com>
Date: Fri, 7 Jun 2024 11:18:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] ARM: dts: stm32: add ethernet1 and ethernet2
 support on stm32mp13
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
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
 <20240604143502.154463-9-christophe.roullier@foss.st.com>
 <e8e69a34-b9b2-4b4c-9b2e-079c7a23b756@denx.de>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <e8e69a34-b9b2-4b4c-9b2e-079c7a23b756@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_04,2024-06-06_02,2024-05-17_01

Hi

On 6/4/24 18:49, Marek Vasut wrote:
> On 6/4/24 4:34 PM, Christophe Roullier wrote:
>> Both instances ethernet based on GMAC SNPS IP on stm32mp13.
>> GMAC IP version is SNPS 4.20.
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> ---
>>   arch/arm/boot/dts/st/stm32mp131.dtsi | 38 ++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/st/stm32mp133.dtsi | 31 +++++++++++++++++++++++
>>   2 files changed, 69 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi 
>> b/arch/arm/boot/dts/st/stm32mp131.dtsi
>> index 6704ceef284d3..9d05853ececf7 100644
>> --- a/arch/arm/boot/dts/st/stm32mp131.dtsi
>> +++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
>> @@ -979,6 +979,12 @@ ts_cal1: calib@5c {
>>               ts_cal2: calib@5e {
>>                   reg = <0x5e 0x2>;
>>               };
>> +            ethernet_mac1_address: mac1@e4 {
>> +                reg = <0xe4 0x6>;
>> +            };
>> +            ethernet_mac2_address: mac2@ea {
>> +                reg = <0xea 0x6>;
>> +            };
>>           };
>>             etzpc: bus@5c007000 {
>> @@ -1505,6 +1511,38 @@ sdmmc2: mmc@58007000 {
>>                   status = "disabled";
>>               };
>>   +            ethernet1: ethernet@5800a000 {
>> +                compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
>> +                reg = <0x5800a000 0x2000>;
>> +                reg-names = "stmmaceth";
>> +                interrupts-extended = <&intc GIC_SPI 62 
>> IRQ_TYPE_LEVEL_HIGH>,
>> +                              <&exti 68 1>;
>> +                interrupt-names = "macirq", "eth_wake_irq";
>> +                clock-names = "stmmaceth",
>> +                          "mac-clk-tx",
>> +                          "mac-clk-rx",
>> +                          "ethstp",
>> +                          "eth-ck";
>> +                clocks = <&rcc ETH1MAC>,
>> +                     <&rcc ETH1TX>,
>> +                     <&rcc ETH1RX>,
>> +                     <&rcc ETH1STP>,
>> +                     <&rcc ETH1CK_K>;
>> +                st,syscon = <&syscfg 0x4 0xff0000>;
>> +                snps,mixed-burst;
>> +                snps,pbl = <2>;
>> +                snps,axi-config = <&stmmac_axi_config_1>;
>> +                snps,tso;
>> +                access-controllers = <&etzpc 48>;
>
> Please keep the list of properties sorted.
>
To be coherent with all other IP, I will keep "access-controllers" 
property just before "status" property.
>> +                status = "disabled";
>> +
>> +                stmmac_axi_config_1: stmmac-axi-config {
>> +                    snps,wr_osr_lmt = <0x7>;
>> +                    snps,rd_osr_lmt = <0x7>;
>> +                    snps,blen = <0 0 0 0 16 8 4>;
>
> Sort here too.
ok
>
>> +                };
>> +            };
>> +
>>               usbphyc: usbphyc@5a006000 {
>>                   #address-cells = <1>;
>>                   #size-cells = <0>;
>> diff --git a/arch/arm/boot/dts/st/stm32mp133.dtsi 
>> b/arch/arm/boot/dts/st/stm32mp133.dtsi
>> index 3e394c8e58b92..09c7da1a2eda8 100644
>> --- a/arch/arm/boot/dts/st/stm32mp133.dtsi
>> +++ b/arch/arm/boot/dts/st/stm32mp133.dtsi
>> @@ -67,5 +67,36 @@ channel@18 {
>>                   label = "vrefint";
>>               };
>>           };
>> +
>> +        ethernet2: ethernet@5800e000 {
>> +            compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
>> +            reg = <0x5800e000 0x2000>;
>> +            reg-names = "stmmaceth";
>> +            interrupts-extended = <&intc GIC_SPI 97 
>> IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-names = "macirq";
>> +            clock-names = "stmmaceth",
>> +                      "mac-clk-tx",
>> +                      "mac-clk-rx",
>> +                      "ethstp",
>> +                      "eth-ck";
>> +            clocks = <&rcc ETH2MAC>,
>> +                 <&rcc ETH2TX>,
>> +                 <&rcc ETH2RX>,
>> +                 <&rcc ETH2STP>,
>> +                 <&rcc ETH2CK_K>;
>> +            st,syscon = <&syscfg 0x4 0xff000000>;
>> +            snps,mixed-burst;
>> +            snps,pbl = <2>;
>> +            snps,axi-config = <&stmmac_axi_config_2>;
>> +            snps,tso;
>> +            access-controllers = <&etzpc 49>;
>
> Sort here too.
>
>> +            status = "disabled";
>> +
>> +            stmmac_axi_config_2: stmmac-axi-config {
>> +                snps,wr_osr_lmt = <0x7>;
>> +                snps,rd_osr_lmt = <0x7>;
>> +                snps,blen = <0 0 0 0 16 8 4>;
>
> Sort here too.
>
> [...]

