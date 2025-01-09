Return-Path: <netdev+bounces-156716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CA3A07949
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1201886752
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B881221A431;
	Thu,  9 Jan 2025 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D35v4Vwv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45414F98;
	Thu,  9 Jan 2025 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433196; cv=none; b=lXYyDh4byG1L2cAgAUWS7UXzjp0efs7fF8CQX9ESCJx0luDXaWw79magWlXO5cu1LXSxX06Z66WNljB/FBTuUaYn5gB2Y1+Thdu/2LMlouYXH0c1jT0H9GCtgTjBo5erWZTIWgsgoMzqy/c4RXeHmRrUJGQf1MPDo/KzEyIId00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433196; c=relaxed/simple;
	bh=+Kr9JFrQYHHYKs/mJDEC+JVjR8TiSrLUD0MX98tsqd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhrRhp/SwQQjBfU92+V8tWOJhXMWuiOQjTmu04+kzuhU1xx/iXRx+41umauVn1HDbBs4p23w8lsBalc57FHtqzEzRmpZgz2OSEscrdTbJxervO/G4+aGduotbqmuPmLzRq7i+TX8Nk4OIlWf3WeaMY57nAyYubgD2Udi8Iq5T7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D35v4Vwv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50985ZkV022344;
	Thu, 9 Jan 2025 14:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a4WYV/
	lBqDuwS3x6xguYcEfUiXeq4SXjFmogzAE4jlY=; b=D35v4VwvI1M8HpJsAPOasd
	eRruPQqZXqyJ3WhcCy+1kV6fZMnmxpu77zFS/dz+AJCA/cwwldDnkUESVzSkIdXa
	X3dOeIYO7HiD2dLeHTdQdSJzLcTeYLaC0e1bJs9Uh4qiMjaGOsq1SNj/qk2BC/Fe
	lPGrWYuifpNnalP+5rpCV58S5RiDHJGzj1XmozxSj01OBRSE2Q5ot+Hvl26rdr/7
	RQS94A14lVPvKTc5/imLR8zz5fBf8nLoT1EHClzJ0BCIzKYe2zje0YAV7ttYT958
	PKluzbXSlvdV82p8RlR2Q7dfJCeMPUxiGIcfTJO2fo5Vu6ZsCykGFWOPdDaLl/VQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442an2hkvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 14:32:22 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 509EOrxJ010500;
	Thu, 9 Jan 2025 14:32:21 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442an2hkvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 14:32:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 509CG5VP003593;
	Thu, 9 Jan 2025 14:32:20 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfatdqdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 14:32:20 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 509EWKN847776206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 14:32:20 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 404F158056;
	Thu,  9 Jan 2025 14:32:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BFCA58045;
	Thu,  9 Jan 2025 14:32:16 +0000 (GMT)
Received: from [9.61.139.65] (unknown [9.61.139.65])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2025 14:32:16 +0000 (GMT)
Message-ID: <6ac77e5d-e931-494a-9777-6ed0bc4aa1e9@linux.ibm.com>
Date: Thu, 9 Jan 2025 08:32:15 -0600
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
X-Proofpoint-GUID: 8L7sZPoUTETvRf7B5TvBSMQ-8W5xEmny
X-Proofpoint-ORIG-GUID: py666dZ04-ObN4IbDM5590QG7o3LXVlq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090116

Hi Andrew,

Thanks for the explanation.

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

When does someone use rgmii-txid and rgmii-rxid?

Regards,

Ninad

>
> So, your MAC driver is broken. It is not correctly handling the
> phy-mode. First question is, how many boards are there in mainline
> which have broken phy-modes. If this is the first board, we can fix
> the MAC driver. If there are already boards in mainline we have to be
> much more careful when fixing this, so as not to regress boards which
> are already merged.
>
> Humm, interesting. Looking at ftgmac100.c, i don't see where you
> configure the RGMII delays in the MAC?
>
> 	  Andrew
>

