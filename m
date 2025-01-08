Return-Path: <netdev+bounces-156492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E47A06858
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF01F162F37
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2C1F0E3F;
	Wed,  8 Jan 2025 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y7hv7dbW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3A19EEBF;
	Wed,  8 Jan 2025 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375602; cv=none; b=FO9CFlZU3fx8wwzphk2WyyEDVV2R5viCFpGZ+dqRnYttOnjqHQsml/pbggXoC0GJ48NHmnOWFc+koaFDzpOo6je0mDgwuvnEMMUX3dExWiVpSTyR4E6IaIuQNL243w4qTv5ckbONLYv486N0j3NHvfIVhR1CJR28KHLmrKyeYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375602; c=relaxed/simple;
	bh=fvJCixGmHFVLT7pMQvqNZbSTMI7Q/NWxHe31Oi8ZWro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/uRL+7L/mIIeL4EBxaWTUcD1qMOMDJDxaTjGHT/OQWANSwdsiBKs9jDj9+P+WlE+W36YgFvwC7Yqv9GaAPRhG5PHtJ67WW/HU8eCCk+tSeKb5AimaJrWxgwAQ7l3e8Uyij8gzrz/E137Y91ftNPkG9LJ7+f2ANGV7hFQwAfQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y7hv7dbW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508Eq5hO017974;
	Wed, 8 Jan 2025 22:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KlRCuG
	PMlwejbHsntRyxIV2YbKHWZVl6PpAh0SlJ7uk=; b=Y7hv7dbWvdQz7PK+ZEV0Yt
	68MJwPffxgt3I7dOB4MMEgHpvTwa+nfyXdn0yITIRovp3+6ofQsxi0KDFXfPdDzs
	RAnIfGdy+dd2+3HKp0FPC9A8Trw+E4lCP1AeDhtbc3e9YKsj2CxA4D+o8d/Elh3s
	30ekYqllsNpooSgPNN97PoM+7GASKgvUd7JZHVSBpxZN7Pi9uqlPI4SE9azFTdE8
	ZuQ/03szX3Bh2VBObAMLs2aRTWsTLszu4c9ELDZ39QI3KwftgmuGE9LPAwFEfNmj
	ZMN52e2C7A+Xu1e9dCOFM8Bnky0J9xoHiCZ+2dVfH1/CC3jBwo12PDCgrcgDMx6A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441huc4uj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 22:31:34 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 508MSagq026621;
	Wed, 8 Jan 2025 22:31:34 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441huc4uhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 22:31:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508Jx6pX003572;
	Wed, 8 Jan 2025 22:31:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfata8nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 22:31:32 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508MVWUL54854004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 22:31:32 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 263FE5806B;
	Wed,  8 Jan 2025 22:31:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DC925804E;
	Wed,  8 Jan 2025 22:31:29 +0000 (GMT)
Received: from [9.61.139.65] (unknown [9.61.139.65])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2025 22:31:29 +0000 (GMT)
Message-ID: <b2aec97b-63bc-44ed-9f6b-5052896bf350@linux.ibm.com>
Date: Wed, 8 Jan 2025 16:31:28 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] ARM: dts: aspeed: system1: Add RGMII support
To: Andrew Lunn <andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>
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
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uaFUIc6cD4X9PAgDaJFKrNEJKqlvTD0C
X-Proofpoint-GUID: 6xbf0HjJ6pVuQmMW_ljUl1BLsijg_a4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080184

Hello Andrew & Jacky,

On 1/8/25 11:52, Andrew Lunn wrote:
>>> Does the mac0 TX clock have an extra long clock line on the PCB?
>>>
>>> Does the mac1 TX and RX clocks have extra long clock lines on the PCB?
>>>
>>> Anything but rgmii-id is in most cases wrong, so you need a really
>>> good explanation why you need to use something else. Something that
>>> shows you understand what is going on, and why what you have is
>>> correct.
>> Here I'll add some explanation.
>>
>> In our design, we hope the TX and RX RGMII delay are configured by our MAC side.
>> We can control the TX/RX RGMII delay on MAC step by step, it is not a setting to delay to 2 ns.
>> We are not sure the all target PHYs are support for RX internal delay.
>>
>> But ast2600 MAC1/2 delay cell cannot cover range to 2 ns, MAC 3/4 can do that.
>> Therefore, when using ast2600 MAC1/2, please enable the RX internal delay on the PHY side
>> to make up for the part we cannot cover.
>>
>> Summarize our design and we recommend.
>> AST2600 MAC1/2: rgmii-rxid
>> (RGMII with internal RX delay provided by the PHY, the MAC should not add an RX delay in this
>> case)
>> AST2600 MAC3/4: rgmii
>> (RX and TX delays are added by the MAC when required)
>>
>> rgmii and rgmii-rxid are referred from ethernet-controller.yaml file.
> O.K, so you have the meaning of phy-mode wrong. phy-mode effectively
> described the PCB. Does the PCB implement the 2ns delay via extra long
> clock lines or not. If the PCB has long clock lines, phy-mode is
> 'rgmii'. If the PCB does not have long clock lines, 'rgmii-id' is
> used, meaning either the MAC or the PHY needs to add the delays.
>
> The MAC driver is the one that reads the phy-mode from the DT, and
> then it decides what to do. 95% of linux MAC drivers simply pass it
> direct to the PHY. If the phy-mode is 'rgmii', the PHY does nothing,
> because the PCB has added the delays. If it is rgmii-id, it adds
> delays in both directions. This works, because nearly very RGMII PHY
> on the market does support RGMII delays.
>
> There is however a very small number of MAC drivers which do things
> differently. Renesas produced an RDK with a PHY which could not do
> delays in the PHY, and so were forced to do the delays in the
> MAC. Please look at how the ravb driver works. If the PCB does not add
> the delays, rmgii-id, the MAC driver adds the delays. It then masks
> the phy-mode it passes to of_phy_connect() back to 'rgmii', so that
> the PHY does not add any delays. If the PCB did add the delays,
> 'rgmii', the MAC driver does not add delays, and it passed rgmii to
> the PHY driver, and it also does not add delays.
>
> So, your MAC driver is broken. It is not correctly handling the
> phy-mode. First question is, how many boards are there in mainline
> which have broken phy-modes. If this is the first board, we can fix
> the MAC driver. If there are already boards in mainline we have to be
> much more careful when fixing this, so as not to regress boards which
> are already merged.

There are around 11 boards in Aspeed SOC with phy-mode set to "rgmii" 
(some of them are mac0&1 and others are mac2&3). "rgmii-rxid" is only mine.

No one in aspeed SOC using "rgmii-id".

>
> Humm, interesting. Looking at ftgmac100.c, i don't see where you
> configure the RGMII delays in the MAC?
>
> 	  Andrew
>

