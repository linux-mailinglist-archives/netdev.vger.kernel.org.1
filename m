Return-Path: <netdev+bounces-100678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A98728FB8D1
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A691F27945
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8A1487D4;
	Tue,  4 Jun 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Bvq/Sg6e"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319DB33F6;
	Tue,  4 Jun 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518332; cv=none; b=FditFPGzwK7miRk6Op38ogGTqQwWFBdbAd8azq6Bk/xoJcAsGaz/yP8wJIvfT1/BrzQyRA9iKBDTGY6/Wu/fJCc4JwFq+nDzoIEXyRqpir12bpg+Ect5kncQgSZX9OizZImDZW4iQjIe5gdXoyl5WsV+tdnoDRCUxqw7cz0ndHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518332; c=relaxed/simple;
	bh=eXgKK995QJkI16v8AHd1bJ96/lu2AJQnfmy1AdFN/BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L5myIAd5dzikD3tuVM1ivGDzMyg/DnzZ2izCPUll9Det1/eF00EgGf3Tym+tIgCUKyzRE+kGiDytuArhdJc5PguR3xbsOTMo3j7EQuqmu1DZv7F6mkKwCAZYe0TKumgof10TYu1lktTscqt1zFkNr9LXb8WBaHKKdcIGqWMX5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Bvq/Sg6e; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454CsuuG017307;
	Tue, 4 Jun 2024 18:25:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	dJ77y7c728Jg6E1QmWVy5duFFQvEtHeeBSjFdyv4STk=; b=Bvq/Sg6edTyauCyO
	9uG49QJBcW73vSaWpt8MYDgSL0bMdq5jqeypZLlKT0FK+WwnjAYrOHpFF1MTRO7j
	HdckTs8ZDKYNyjBgBWQqPZl+OoFoaZU9veuurpCx//k1reFO4kU+/CuK22xorGqQ
	61BqTV+l++n8Hr6MVgeTmbcHpkI1S6hzG/DWMCfEMWtQVMyapt51iXFfWvjJMZVm
	tnOnzfopE7KtFf/tF7bYFRwQGH5Ir/xpElEck4zXkDRxiqMo3N8acPfEqAHZQbyc
	EwU2Zd8hpFGaM//iHyD5qlflmJtPR+dzF+sDLGZ3fwVQFLVJSosokJrWsczV7WoZ
	7dJ5cw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw91d4wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 18:24:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3F25E40049;
	Tue,  4 Jun 2024 18:24:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1D91320AAA8;
	Tue,  4 Jun 2024 18:24:05 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 18:24:04 +0200
Message-ID: <b9fc4d73-fce3-4628-b931-c523d9718240@foss.st.com>
Date: Tue, 4 Jun 2024 18:24:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] Series to deliver Ethernet for STM32MP13
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: <devicetree@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski
	<kuba@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Marek Vasut
	<marex@denx.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Mark Brown <broonie@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jose
 Abreu <joabreu@synopsys.com>
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
 <171751455073.786330.16354287861829975663.robh@kernel.org>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <171751455073.786330.16354287861829975663.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01


On 6/4/24 17:29, Rob Herring (Arm) wrote:
> On Tue, 04 Jun 2024 16:34:51 +0200, Christophe Roullier wrote:
>> STM32MP13 is STM32 SOC with 2 GMACs instances
>>      GMAC IP version is SNPS 4.20.
>>      GMAC IP configure with 1 RX and 1 TX queue.
>>      DMA HW capability register supported
>>      RX Checksum Offload Engine supported
>>      TX Checksum insertion supported
>>      Wake-Up On Lan supported
>>      TSO supported
>> Rework dwmac glue to simplify management for next stm32 (integrate RFC from Marek)
>>
>> V2: - Remark from Rob Herring (add Krzysztof's ack in patch 02/11, update in yaml)
>>        Remark from Serge Semin (upate commits msg)
>> V3: - Remove PHY regulator patch and Ethernet2 DT because need to clarify how to
>>        manage PHY regulator (in glue or PHY side)
>>      - Integrate RFC from Marek
>>      - Remark from Rob Herring in YAML documentation
>> V4: - Remark from Marek (remove max-speed, extra space in DT, update commit msg)
>>      - Remark from Rasmus (add sign-off, add base-commit)
>>      - Remark from Sai Krishna Gajula
>>
>> Christophe Roullier (6):
>>    dt-bindings: net: add STM32MP13 compatible in documentation for stm32
>>    net: ethernet: stmmac: add management of stm32mp13 for stm32
>>    ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
>>    ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
>>    ARM: dts: stm32: add ethernet1 for STM32MP135F-DK board
>>    ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support
>>
>> Marek Vasut (5):
>>    net: stmmac: dwmac-stm32: Separate out external clock rate validation
>>    net: stmmac: dwmac-stm32: Separate out external clock selector
>>    net: stmmac: dwmac-stm32: Extract PMCR configuration
>>    net: stmmac: dwmac-stm32: Clean up the debug prints
>>    net: stmmac: dwmac-stm32: Fix Mhz to MHz
>>
>>   .../devicetree/bindings/net/stm32-dwmac.yaml  |  41 ++++-
>>   arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi   |  71 ++++++++
>>   arch/arm/boot/dts/st/stm32mp131.dtsi          |  38 ++++
>>   arch/arm/boot/dts/st/stm32mp133.dtsi          |  31 ++++
>>   arch/arm/boot/dts/st/stm32mp135f-dk.dts       |  23 +++
>>   arch/arm/configs/multi_v7_defconfig           |   1 +
>>   .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 172 ++++++++++++++----
>>   7 files changed, 330 insertions(+), 47 deletions(-)
>>
>>
>> base-commit: cd0057ad75116bacf16fea82e48c1db642971136
>> --
>> 2.25.1
>>
>>
>>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>    pip3 install dtschema --upgrade
>
>
> New warnings running 'make CHECK_DTBS=y st/stm32mp135f-dk.dtb' for 20240604143502.154463-1-christophe.roullier@foss.st.com:
>
> arch/arm/boot/dts/st/stm32mp135f-dk.dtb: adc@48003000: 'ethernet@5800e000' does not match any of the regexes: '^adc@[0-9]+$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/st,stm32-adc.yaml#
>
Hi Rob,

I will provide v5 to fix it.

Thanks

>
>
>

