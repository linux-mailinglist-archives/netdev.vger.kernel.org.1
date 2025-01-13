Return-Path: <netdev+bounces-157884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3C0A0C223
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F4B7A3B29
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2A01D0B8E;
	Mon, 13 Jan 2025 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B5LUh+Vg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55831C760A;
	Mon, 13 Jan 2025 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797979; cv=none; b=iKuzBYiMF+0bOABbZrBrl/D8b6D8XtGz6zjkpZlBJmdR2KKxXY9ODpFLgjQ3FkCw2x6HNKrVU+6CkdbSCeDpq5iMFneRYN0y3lgMFukRjzjVu26x5WsWU+9LLz0l+R1xxGbQsIlxIxKCbhcSJvJRuX+RNyilRmC1bjp5qeDeiDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797979; c=relaxed/simple;
	bh=06GZhc/VkQq++5gRIdPFs5q0JjB601nTRNvV+qE8zLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SalReuJvzcCR2cEAfzDPombGT+TlKYX+NSgI1v0DIIYE6PJZy/VPAgHxxdOPlSnPp3oWxE4Q25eQ8WowBr9UBkiTqVjAqamFpuVavV33SrMMsp2m4/ka9SH3Afc3NPIeb+L1z+VQC4yBjjKhdfpnw6KYJ6Q5ve6O7r61LQI4gjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B5LUh+Vg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DBwHMp024143;
	Mon, 13 Jan 2025 19:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gxfl05
	rEtPi8TykQ9QWVEg0MU5uCG4bE8pKLfbkmBoM=; b=B5LUh+VgN3WK/GxgMfApyL
	zDK2JB86xVFtqkh2cISfja7SdVtOsIfkGleQzynw6Piylorb/2us6xzEeoukuQot
	dAFLlcFPUq1Dy4nmJN3LwWPknBMPu5XagwtLREWveMQ8Ja5OVu7SogufvkYi8w1l
	r93va9nGzztbSiS+6nSIEy3MiVOTLcHqBQyWAU3peLOp5LcyOOT74MNka5aZKhT+
	pY3A1y/SdCxh3cPB/jbMtSDqplAF1ENBHzsX9sLyZFrgMN93Yn5jthXy+DnLG2We
	uombPBbmzmebvuAtrUsPTfV2bdOLDT7qGqBK6A2esZdY9TuHPYmiYNMuBnWtf3vQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444qjameav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:52:05 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50DJcxT5031944;
	Mon, 13 Jan 2025 19:52:05 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444qjameaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:52:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DGREZB016991;
	Mon, 13 Jan 2025 19:52:04 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fjyrwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:52:04 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DJq3p520972040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 19:52:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFB9A5805E;
	Mon, 13 Jan 2025 19:52:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2274F5805A;
	Mon, 13 Jan 2025 19:52:02 +0000 (GMT)
Received: from [9.61.105.40] (unknown [9.61.105.40])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 19:52:01 +0000 (GMT)
Message-ID: <a8893ef1-251d-447c-b42f-8f1ebc9623bb@linux.ibm.com>
Date: Mon, 13 Jan 2025 13:52:01 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] DTS updates for system1 BMC
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-aspeed@lists.ozlabs.org, davem@davemloft.net, edumazet@google.com,
        andrew@codeconstruct.com.au, netdev@vger.kernel.org, kuba@kernel.org,
        joel@jms.id.au, linux-arm-kernel@lists.infradead.org,
        openipmi-developer@lists.sourceforge.net, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com,
        ratbert@faraday-tech.com, eajames@linux.ibm.com,
        devicetree@vger.kernel.org, andrew+netdev@lunn.ch, minyard@acm.org,
        krzk+dt@kernel.org
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <173637565834.1164228.2385240280664730132.robh@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <173637565834.1164228.2385240280664730132.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PvzTUGLChZmlLTohpy8SLvK47px5mEq9
X-Proofpoint-ORIG-GUID: slslK2Na7MpzUMJx3_V1bJjHIgILrmix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxlogscore=886 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130156

Hello,

On 1/8/25 16:34, Rob Herring (Arm) wrote:
> On Wed, 08 Jan 2025 10:36:28 -0600, Ninad Palsule wrote:
>> Hello,
>>
>> Please review the patch set.
>>
>> V3:
>> ---
>>    - Fixed dt_binding_check warnings in ipmb-dev.yaml
>>    - Updated title and description in ipmb-dev.yaml file.
>>    - Updated i2c-protocol description in ipmb-dev.yaml file.
>>
>> V2:
>> ---
>>    Fixed CHECK_DTBS errors by
>>      - Using generic node names
>>      - Documenting phy-mode rgmii-rxid in ftgmac100.yaml
>>      - Adding binding documentation for IPMB device interface
>>
>> NINAD PALSULE (7):
>>    ARM: dts: aspeed: system1: Add IPMB device
>>    ARM: dts: aspeed: system1: Add GPIO line name
>>    ARM: dts: aspeed: system1: Add RGMII support
>>    ARM: dts: aspeed: system1: Reduce sgpio speed
>>    ARM: dts: aspeed: system1: Update LED gpio name
>>    ARM: dts: aspeed: system1: Remove VRs max8952
>>    ARM: dts: aspeed: system1: Mark GPIO line high/low
>>
>> Ninad Palsule (3):
>>    dt-bindings: net: faraday,ftgmac100: Add phys mode
>>    bindings: ipmi: Add binding for IPMB device intf
>>    ARM: dts: aspeed: system1: Disable gpio pull down
>>
>>   .../devicetree/bindings/ipmi/ipmb-dev.yaml    |  44 +++++
>>   .../bindings/net/faraday,ftgmac100.yaml       |   3 +
>>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 177 ++++++++++++------
>>   3 files changed, 165 insertions(+), 59 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
>>
>> --
>> 2.43.0
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
> New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20250108163640.1374680-1-ninad@linux.ibm.com:
>
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: gpio@1e780000: 'hog-0', 'hog-1', 'hog-2', 'hog-3' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#

This is a false positive. So ignoring it.

Regards,

Ninad

>
>
>
>
>
>

