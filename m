Return-Path: <netdev+bounces-102181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCD4901C25
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A3BB20EF9
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A763BBC9;
	Mon, 10 Jun 2024 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4b+FObhI"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2972CCB7;
	Mon, 10 Jun 2024 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006215; cv=none; b=VbpCyv3B6abXYdic8q4xAyIhnS1nyhriSpM24ZD1QReyJZFoHgURInh0o3yZUQLMBz1druGho5J7VqWqBPyNpXi6oQEUYiQTqUxbPZFRLYF0KQdqK+v9KTS6dFRTelwp9rrwzRSh5Ztwu2JeCOeeoB/I0KrgmMM8CxzEed9tRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006215; c=relaxed/simple;
	bh=dh3H2sVa5FYN8i0we4x3+R7a9sJ1pfHXhQg9MzCf3is=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XUPV0JWt7JcviFp2oRXtIjBG4AAswv1z+nfmtatYVt8PpbaSJSZDiS7w4wDlXEaO1w9k9CxL1EGlVpMoNsd9N0khq9cKiLbXULsr/0Q5wO5UZLi4Gka064NYZHI6vwjezaQ4qmXJY9anC38MpjqlYghIlo0+qBZ8doMTwvnIxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4b+FObhI; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459KxQcm013767;
	Mon, 10 Jun 2024 09:56:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	yUKOFPOQwgaRW01h/tUPDgk5dTLq6HjrNeJuxMsBV3w=; b=4b+FObhIu7awR+Oj
	axyQMwNtyspUjkysg4sAb4ZMzRR9eaHY+fccYwXqQQNk83L5UA7vGr12lHrxqjxY
	Kxnelk55DtgzfmIt5fD0Cu/S/nFt+dmOsNcCndDwN20CvzgGHOLmKEoYqJ+X2+RN
	Rcne6hOqisd/rwg/0bfweDNrhpYi/YpflY6mUTni5FYSOnyC5w6QdUHd/1hUnDAC
	tstW9dpmalPvNhkgld9C9jHjbL1cD+YKdVGCgLEnuV+yI9empFO8RAUjzPXmppIh
	UiPoo4GE23wFSDePOQCHPwaPj9rJdL5+hpfBG9Y9xztRQGHDX+4kLBe4IaNNOe8C
	MdabPg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ymemxnmtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 09:56:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2D57540044;
	Mon, 10 Jun 2024 09:56:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 60AF7211940;
	Mon, 10 Jun 2024 09:55:07 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 10 Jun
 2024 09:55:06 +0200
Message-ID: <908c2e86-8255-4e76-8665-0b7d02853681@foss.st.com>
Date: Mon, 10 Jun 2024 09:55:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] ARM: dts: stm32: add ethernet1 and ethernet2
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
References: <20240607095754.265105-1-christophe.roullier@foss.st.com>
 <20240607095754.265105-10-christophe.roullier@foss.st.com>
 <6d60bbc6-5ed3-4bb1-ad72-18a2be140b81@denx.de>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <6d60bbc6-5ed3-4bb1-ad72-18a2be140b81@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01

On 6/7/24 14:48, Marek Vasut wrote:
> On 6/7/24 11:57 AM, Christophe Roullier wrote:
>
> [...]
>
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
> Keep the list sorted.

Hi Marek,

As already explained, all MP13 IPs have this property before "status". 
If we must move this property, we will do it later and do it for all IPs.

Thanks



