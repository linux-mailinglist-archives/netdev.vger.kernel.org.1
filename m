Return-Path: <netdev+bounces-157174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84225A092EE
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944083A5E14
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E9720E701;
	Fri, 10 Jan 2025 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="At/YlyB0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709E20E021;
	Fri, 10 Jan 2025 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517973; cv=none; b=MjR4J8jyLXzjoquUsu21BYAMgOC7QDjVyxc0ZrDH6koKEBqmDkwtZK5zbaN+M+tvXG3Hk6/RhJd9t6+m6r32gQTWDe9Z4yHh+BdMxO/GaVUEJwnMvDoI2lI2IHMpv+gYZfw0N1OPzKAfucuNUUvSi4kj7Y+yreRyGjWuIMHoy8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517973; c=relaxed/simple;
	bh=DrzFAYzXF2+HIOGECCtnKfQe6+g+5U13Ch+iaOGmyE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biYPUVhEOOo0t6pcJo7Zu1hvl+uJkSl7MJvHe5fXJ7BbuG7GSbcC7ccCrpmnB6CfY0KTjjb245Le/dB/sGSXWyoxIDGs4NxF3Zslmvm7yq12NsHpZ4aSQxPQWTGzd9aLOZnLuvf+g3KE1qeDzu6KXCUgvWBM/uNnbfn3tRHHAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=At/YlyB0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A3qQbG013130;
	Fri, 10 Jan 2025 14:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SzKJtk
	Y+MJUb5JMhu78TtdXOKjCWS6RnEjQeUjrVomI=; b=At/YlyB0ExjZ8DYF7gwLF6
	TcYu0vC3QfTl67c6tQsHTvPkg2AocXyd8Z+XEtNmUKugCJGqb/NDQgDue3C8yqW5
	84t2sOHRYcbw1XXSLpDubeN8s+X9v0fyaHMhiKP3ij2AK/iX3z6iKJx7+c5V2wAZ
	kMo1WjsTJ5lO3+UjWKBfUz0+iXpbyxHnNPq+v/Nn0iKk9zUMi5VwgdmUNhgcjykt
	a68PQqhFfT9ojMrCEnC5qGtUuxSe8Pb3sSP9zMWU/1afFUOXuGgZ6TLNlcwlHl+O
	U7UIM/N4sZzpkCphjDqkRhTpoIReA+ua8lYTV0AstDT/3BEijnjFlBrukw8wjwWw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442v1btb0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 14:05:08 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50ADrLxL024750;
	Fri, 10 Jan 2025 14:05:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442v1btb0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 14:05:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50ADgQTm013663;
	Fri, 10 Jan 2025 14:05:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygapagfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 14:05:06 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50AE55p832375454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 14:05:05 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A6AE5805F;
	Fri, 10 Jan 2025 14:05:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B06C5805D;
	Fri, 10 Jan 2025 14:05:01 +0000 (GMT)
Received: from [9.61.139.65] (unknown [9.61.139.65])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jan 2025 14:05:01 +0000 (GMT)
Message-ID: <d80f5916-4918-4849-bf4e-2ef608ece09d@linux.ibm.com>
Date: Fri, 10 Jan 2025 08:05:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuimhjog5Zue6KaGOiBbUEFUQ0ggdjIgMDUvMTBdIEFSTTog?=
 =?UTF-8?Q?dts=3A_aspeed=3A_system1=3A_Add_RGMII_support?=
To: Jacky Chou <jacky_chou@aspeedtech.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "joel@jms.id.au"
 <joel@jms.id.au>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net"
 <openipmi-developer@lists.sourceforge.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
        "robh@kernel.org" <robh@kernel.org>
References: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
 <59116067-0caa-4666-b8dc-9b3125a37e6f@lunn.ch>
 <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
 <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MeLhr7O8jd-8ePzsQCuKHXgiTwl7M1Df
X-Proofpoint-GUID: pZcWXJhEmsFDJ3lvW_ilyppMTvEAo7cz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100110

Hi Jacky,

On 1/10/25 03:15, Jacky Chou wrote:
> Hi Andrew,
>
> Thank you for your reply.
>
>>> I think the code already exist in the mainline:
>>> https://github.com/torvalds/linux/blob/master/drivers/clk/clk-ast2600.
>>> c#L595
>>>
>>> It is configuring SCU register in the ast2600 SOC to introduce delays.
>>> The mac is part of the SOC.
>> I could be reading this wrong, but that appears to create a gated clock.
>>
>> hw = clk_hw_register_gate(dev, "mac1rclk", "mac12rclk", 0,
>> 	       		scu_g6_base + ASPEED_MAC12_CLK_DLY, 29, 0,
>> 			&aspeed_g6_clk_lock);
>>
>> /**
>>   * clk_hw_register_gate - register a gate clock with the clock framework
>>   * @dev: device that is registering this clock
>>   * @name: name of this clock
>>   * @parent_name: name of this clock's parent
>>   * @flags: framework-specific flags for this clock
>>   * @reg: register address to control gating of this clock
>>   * @bit_idx: which bit in the register controls gating of this clock
>>   * @clk_gate_flags: gate-specific flags for this clock
>>   * @lock: shared register lock for this clock  */
>>
>> There is nothing here about writing a value into @reg at creation time to give
>> it a default value. If you look at the vendor code, it has extra writes, but i don't
>> see anything like that in mainline.
> Agree. You are right. This part is used to create a gated clock.
> We will configure these RGMII delay in bootloader like U-boot.
> Therefore, here does not configure delay again.
>
> Currently, the delay of RGMII is configured in SCU region not in ftgma100 region.
> And I studied ethernet-controller.yaml file, as you said, it has defined about rgmii
> delay property for MAC side to set.
> My plan is that I will move this delay setting to ftgmac100 driver from SCU.
> Add a SCU syscon property for ftgmac100 driver configures the RGMII delay.
>
> // aspeed-g6.dtsi
> mac0: ethernet@1e660000 {
> 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
> 			reg = <0x1e660000 0x180>;
> 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> 			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
> 			aspeed,scu = <&syscon>;    ------> add
> 			status = "disabled";
> 		};
>
> Because AST2600 MAC1/2 RGMII delay setting in scu region is combined to one 32-bit register,
> MAC3/4 is also. I will also use 'aliase' to get MAC index to set delay in scu.
>
> // aspeed-g6.dtsi
> aliases {
> 		..........
> 		mac0 = &mac0;
> 		mac1 = &mac1;
> 		mac2 = &mac2;
> 		mac4 = &mac3;
> 	};
>
> Then, we can use rx-internal-delay-ps and tx-internal-delay-ps property to configure delay
> In ftgmac100 driver.

Thanks. When are you planning to push this change? I might need to hold 
on to mac changes until then.

Regards,

Ninad

>
> If you have any questions, please let me know. Thank you.
>
> Thanks,
> Jacky

