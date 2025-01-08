Return-Path: <netdev+bounces-156347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA86A0625B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39D31883DFF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B0C1FF7C2;
	Wed,  8 Jan 2025 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VeX5kEvv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C361FF61A;
	Wed,  8 Jan 2025 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354494; cv=none; b=dFcVTJ2+LLqgBZ4GDfsb9RcCqvySBJyNPp1xmd+THSWLnS7wWyhKiVpFToNOtDW92e5E5cusqgNi1aV19bnwgzpYFO+7tF12g6JbZqGTbAUJ/INP5eWKgzBISy9GzHGhbcdYzK4a1einIe/J58mOZTb12b8+xopnlcxfFot5ETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354494; c=relaxed/simple;
	bh=ESBuGREyX9ruJ5iqYydbCjaDAKiWH0OavmwQOIvKwd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwxWS//51w6mhM/ViGUUWiU9UtEKQpVGt8vrSvmtHRl000+75UdZK1cWre/JCxzSLwfZy73XKIPLayJ0WiHEW5LurT+PGMbQ50sBl8LiOISPx+Q57HrXS7xSiIq3SvhH96mxJxXtu926+oxZ+6aiH89Lxoh+y6aW+7NdP2wnNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VeX5kEvv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508E6Uf6000755;
	Wed, 8 Jan 2025 16:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5TOBBH
	qOyMS3+b4kdmRdFAaeLkCWkCmxH8nM0f3matc=; b=VeX5kEvv6hbysgCW66F8P3
	xB0o/Zqz2DzsETrksxR2urmZYNmnmrst2bOKwm3rz89l9uKn6aWTbq3RlfJCK8Dz
	yzfi+ci+/6Olf+mnowpzBsdvJYWi+az/eVnRIUF0AzwVN6y5437YqdXLEbiFsJca
	J+/tPn8MezziAbxu+1MDwmUbi+sSvX8nIo6cGsmQk95KPzCqx5N6R/l83WzpKIDU
	BnCZmQAKrGpvC7HWtNfUHZ7WTtUwYk6+6LEP1arJqC5FW7uB0ggP3I3yAJSc77io
	FpWaJy79dVbjtT7cwjm2GWJ5AiPillkLrV080eW3x/UXygC2elAXHKypp/e2Y/Ig
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441tu5gpw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:40:42 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 508GY3r1007659;
	Wed, 8 Jan 2025 16:40:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441tu5gpvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:40:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508Ei9SX026179;
	Wed, 8 Jan 2025 16:40:40 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yj128drg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:40:40 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508GeecU33096362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 16:40:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AFAE58058;
	Wed,  8 Jan 2025 16:40:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6BDD58059;
	Wed,  8 Jan 2025 16:40:38 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2025 16:40:38 +0000 (GMT)
Message-ID: <eeee4fac-49b4-4ca5-96a7-d074a154c698@linux.ibm.com>
Date: Wed, 8 Jan 2025 10:40:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] bindings: ipmi: Add binding for IPMB device intf
To: Rob Herring <robh@kernel.org>
Cc: minyard@acm.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ratbert@faraday-tech.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20250107162350.1281165-1-ninad@linux.ibm.com>
 <20250107162350.1281165-3-ninad@linux.ibm.com>
 <20250107231311.GA1965288-robh@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250107231311.GA1965288-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _jrtb6V25uHEEaH06T2WnmoHwGUcggFZ
X-Proofpoint-ORIG-GUID: XJ4GUB3CwPUykCi4vVr_Tm-vLPt7okCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080137

Hello Rob,

Thanks for the review.

On 1/7/25 17:13, Rob Herring wrote:
> On Tue, Jan 07, 2025 at 10:23:39AM -0600, Ninad Palsule wrote:
>> Add device tree binding document for the IPMB device interface driver.
> Please mention this is already is already in use both in a driver and
> .dts files.
>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 42 +++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
>> new file mode 100644
>> index 000000000000..9136ac8004dc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
>> @@ -0,0 +1,42 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/ipmi/ipmb-dev.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: IPMB Device Driver
> Bindings are for devices, not drivers. Drop 'Driver'. It's a stretch
> that IPMB is even a device, but since there are already a few users, I
> guess we're stuck with it.
Updated the title.
>
>> +
>> +description: IPMB Device Driver bindings
> No point in a description that just repeats the title. Please expand
> this. For example, AIUI, this is for the device end, not the BMC end.
Updated the description.
>> +
>> +maintainers:
>> +  - Ninad Palsule <ninad@linux.ibm.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ipmb-dev
>> +
>> +  reg:
>> +    maxItems: 1
> As this is the slave end, I2C_OWN_SLAVE_ADDRESS should be set. So:
>
> minimum: 0x40000000
> maximum: 0x4000007f

The dt_check script doesn't allow min, max for the reg type.

/home/ninad/dev/sbp1/linux/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml: 
properties:reg: 'minimum' should not be valid under {'enum': ['const', 
'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 
'multipleOf', 'pattern']}
     hint: Scalar and array keywords cannot be mixed
     from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/home/ninad/dev/sbp1/linux/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml: 
properties:reg: 'maximum' should not be valid under {'enum': ['const', 
'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 
'multipleOf', 'pattern']}
     hint: Scalar and array keywords cannot be mixed
     from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

>
> Maybe 10-bit addressing has to be supported too?
Driver only uses 7 and 8 bit addresses
>
>> +
>> +  i2c-protocol:
>> +    description:
>> +      This property specifies that the I2C block transfer should be performed
>> +      instead of SMBUS block transfer.
> This can be more concisely said:
>
> Use I2C block transfer instead of SMBUS block transfer.
Done
>
>> +    type: boolean
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        i2c@10 {
> 'i2c' node name is for i2c buses and this is not one. 'ipmb' is probably
> fine here.

Done

Regards,

Ninad

>> +            compatible = "ipmb-dev";
>> +            reg = <0x10>;
>> +            i2c-protocol;
>> +        };
>> +    };
>> -- 
>> 2.43.0
>>

