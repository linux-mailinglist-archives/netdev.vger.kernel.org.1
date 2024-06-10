Return-Path: <netdev+bounces-102189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C615901C7D
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B096FB2254F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 08:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDDC55C29;
	Mon, 10 Jun 2024 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NeBN5ovA"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217A1CD15;
	Mon, 10 Jun 2024 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006938; cv=none; b=JakRetRv4dU+S2p5I/l2ogj8zdy2piYP4UkQ6uRz3AqI2PsbDZ+w0TV7hYl4/iQPpl6RasFcFZH7fXDQnyKWWxddaDfnvcyTw7DbhkY4yo1scav3OqZFbnQv1a6ZQbbC1NqCu+RDtyoZC5VhByuh2A28MprCZXlVXb4XgsEAi+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006938; c=relaxed/simple;
	bh=LdFyq5xNJx2y6o35truTeFf/LgknSa47Y4v/6/uQX6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cswY/dgK7yqebttPPk6WHWhoLoFFmSnHlmVkJH3niJhh6J1XRxwx6Eyp77zWN8jjKe0DFdw9mNYFfkR2GxVyosNMGBWQK3py0x0V+kVQChbnhKNrWZwliR7dhU9U0OTGV1DtC2hRCeiouk25OroeOUOXl8Li2UDTlYQExcA88sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NeBN5ovA; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459MPVMf009372;
	Mon, 10 Jun 2024 10:08:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	dRbbtVz+VqS7/TuWoSy7X/93HAbVqJfuFI4hivhbQiw=; b=NeBN5ovAO8lH5T3I
	vDTZhPG9Cv3sbaAVx4JG6cmaa7BobZvnr4byyUwXe4l9WCnfAanyQb+SZA/pBCi5
	JV+Uga8WDL/UARTZIdV2AQfwYwDDKIDVKiaKX/wiqo+nFvSkROeqiq7+2OCfdsbR
	eBjOpYg+KmnJadXTfDMEhamkhZH1jTi2oXpBVUwzVskH7tEmFeQjt39MqVokTJgd
	XsJBlhyIbn7nelIOquo/IPDbiTahQUyzrNOHjbCWdWhy638ioRpTE/9mVx2nBC+d
	l5htt3H+4o7CuGsrNOlQfOznjliG7U4EfEV+QKEmlKwp1uOoZYgkZ/3mEgdA3WD3
	sQGffA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ymce5ntxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 10:08:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C46094004A;
	Mon, 10 Jun 2024 10:08:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 71F08211940;
	Mon, 10 Jun 2024 10:07:12 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 10 Jun
 2024 10:07:11 +0200
Message-ID: <036c9f0d-681d-461d-b839-f781fa220e94@foss.st.com>
Date: Mon, 10 Jun 2024 10:06:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] ARM: dts: stm32: add ethernet1 and ethernet2
 support on stm32mp13
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
References: <20240607095754.265105-1-christophe.roullier@foss.st.com>
 <20240607095754.265105-10-christophe.roullier@foss.st.com>
 <6d60bbc6-5ed3-4bb1-ad72-18a2be140b81@denx.de>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <6d60bbc6-5ed3-4bb1-ad72-18a2be140b81@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01

Hi Marek

On 6/7/24 14:48, Marek Vasut wrote:
> On 6/7/24 11:57 AM, Christophe Roullier wrote:
> 
> [...]
> 
>> @@ -1505,6 +1511,38 @@ sdmmc2: mmc@58007000 {
>>                   status = "disabled";
>>               };
no space here ?
>> +            ethernet1: ethernet@5800a000 {
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

The list is currently not sorted. I agree that it is better to have a 
common rule to easy the read but it should be applied to all the nodes 
for the whole STM32 family. Maybe to address by another series. For the 
time being we can keep it as it is.

Alex

