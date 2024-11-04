Return-Path: <netdev+bounces-141506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A84339BB2BE
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 12:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4201F204DD
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199871B86CC;
	Mon,  4 Nov 2024 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NBEs9DsX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DAF1AF0B3;
	Mon,  4 Nov 2024 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718126; cv=none; b=YoYXAJ7XxrS4rjPuPU1gxs7x+2wc/Bt43iN676bh3JA0+mrHNG1MdS2t5ebF9LPu8CYoe1WrKB4eGnXLGfiVRKxkYBnNR1jZANfLbeboFOPN5k+c4ZzRtoNbtxqsS0AcSZxR3AfkIBAtJ/yqhSEQwrIqz5xgFJooxJ217JnxbRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718126; c=relaxed/simple;
	bh=Hjqtp28MkwTHLGdVMYwCjGKjVh3uTl747qkb8HHPzwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NHwm3hplqZ2WAspO4CM0nshFj6riyv+sVHFdyAJzcf7cBRjEKgWv/cVZFD5QW2YxZuogu2tvlUgBpxh+OfTxto9vOOquRcHAnrhdLx55GhdDjQdpltXON8dS7bL65EdeGIdQNIjahIFAJOp9wOa4Z+qGQcyqYNaM/wa8FIQpyN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NBEs9DsX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3NebjK003006;
	Mon, 4 Nov 2024 11:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QpTybn7wg9kA7W0U5vP4m/bFmDWBpTZhuuFBeCI4ZZU=; b=NBEs9DsXOBTFOjDd
	lPxAwZZbCXkWSe9Av2icziyH6ej643Wok0ScjcqJjlaQGpluucLRb79R6uBN0E3X
	ADzln0lrIvcThnDG9hfUV5JiqW3Qtr1MG8EDSx06+gLn9SJcLb3KP5kRDdXScRJH
	RByCpc9Lh8sTGmevw36scWqVA5UgiEEvD7Nxcjtj757Cm8ggozuhDBQd9GPRhmU4
	xX8Fcr0mLYUAD8+TAsb/Wtn8FgrDDqqFhSKLv1e74TaxaHXpjp7YHQPtP3xBxRlm
	RdxVn97QFa2RM1PdsgXO3kIYxp9j3XJO0G3k+leyDfm+qxRvzu09YzM9w/jvMrRf
	SuPtaw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd4ukx7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 11:01:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4B1koT012239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 11:01:46 GMT
Received: from [10.253.14.204] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 4 Nov 2024
 03:01:41 -0800
Message-ID: <4c849bc5-979f-4f78-bb46-50b93f087d9f@quicinc.com>
Date: Mon, 4 Nov 2024 19:01:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] dt-bindings: net: pcs: Add Ethernet PCS for
 Qualcomm IPQ9574 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
	<linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_luoj@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <bartosz.golaszewski@linaro.org>, <vsmuthu@qti.qualcomm.com>,
        <john@phrozen.org>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
 <20241101-ipq_pcs_rc1-v1-1-fdef575620cf@quicinc.com>
 <c3kdfqqcgczy3k2odbxnemmjvuaoqmli67zisyrrrdfxd5hu4v@thxnvpv5gzap>
Content-Language: en-US
From: Lei Wei <quic_leiwei@quicinc.com>
In-Reply-To: <c3kdfqqcgczy3k2odbxnemmjvuaoqmli67zisyrrrdfxd5hu4v@thxnvpv5gzap>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m-iU_Uh5vpMRv6Ib9agqRvNmNXsXPNSH
X-Proofpoint-ORIG-GUID: m-iU_Uh5vpMRv6Ib9agqRvNmNXsXPNSH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040097



On 11/2/2024 9:34 PM, Krzysztof Kozlowski wrote:
> On Fri, Nov 01, 2024 at 06:32:49PM +0800, Lei Wei wrote:
>> The 'UNIPHY' PCS block in the IPQ9574 SoC includes PCS and SerDes
>> functions. It supports different interface modes to enable Ethernet
>> MAC connections to different types of external PHYs/switch. It includes
>> PCS functions for 1Gbps and 2.5Gbps interface modes and XPCS functions
>> for 10Gbps interface modes. There are three UNIPHY (PCS) instances
>> in IPQ9574 SoC which provide PCS/XPCS functions to the six Ethernet
>> ports.
>>
>> Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
>> ---
>>   .../bindings/net/pcs/qcom,ipq9574-pcs.yaml         | 230 +++++++++++++++++++++
>>   include/dt-bindings/net/pcs-qcom-ipq.h             |  15 ++
>>   2 files changed, 245 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/pcs/qcom,ipq9574-pcs.yaml b/Documentation/devicetree/bindings/net/pcs/qcom,ipq9574-pcs.yaml
>> new file mode 100644
>> index 000000000000..a33873c7ad73
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/pcs/qcom,ipq9574-pcs.yaml
>> @@ -0,0 +1,230 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/pcs/qcom,ipq9574-pcs.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Ethernet PCS for Qualcomm IPQ SoC
> 
> s/IPQ/IPQ9574/
> 

OK, will update.

>> +
>> +maintainers:
>> +  - Lei Wei <quic_leiwei@quicinc.com>
> 
> ...
> 
>> +    const: 0
>> +
>> +  clocks:
>> +    items:
>> +      - description: system clock
>> +      - description: AHB clock needed for register interface access
>> +
>> +  clock-names:
>> +    items:
>> +      - const: sys
>> +      - const: ahb
>> +
>> +  '#clock-cells':
> 
> Use consistent quotes, either ' or "
> 

OK, will use single quotes ' everywhere.

>> +    const: 1
>> +    description: See include/dt-bindings/net/pcs-qcom-ipq.h for constants
>> +
>> +patternProperties:
>> +  "^pcs-mii@[0-4]$":
>> +    type: object
>> +    description: PCS MII interface.
>> +
>> +    properties:
>> +      reg:
>> +        minimum: 0
>> +        maximum: 4
>> +        description: MII index
>> +
>> +      clocks:
>> +        items:
>> +          - description: PCS MII RX clock
>> +          - description: PCS MII TX clock
>> +
>> +      clock-names:
>> +        items:
>> +          - const: mii_rx
> 
> rx
> 

OK.

>> +          - const: mii_tx
> 
> tx

OK.

> 
>> +
>> +    required:
>> +      - reg
>> +      - clocks
>> +      - clock-names
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#address-cells'
>> +  - '#size-cells'
>> +  - clocks
>> +  - clock-names
>> +  - '#clock-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>> +
>> +    pcs0: ethernet-pcs@7a00000 {
> 
> Drop unused labels here and further.
> 

OK, will drop the unused labels "pcs0" and "pcs0_miiX".

>> +        compatible = "qcom,ipq9574-pcs";
>> +        reg = <0x7a00000 0x10000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        clocks = <&gcc GCC_UNIPHY0_SYS_CLK>,
>> +                 <&gcc GCC_UNIPHY0_AHB_CLK>;
>> +        clock-names = "sys",
>> +                      "ahb";
>> +        #clock-cells = <1>;
>> +
>> +        pcs0_mii0: pcs-mii@0 {
>> +            reg = <0>;
>> +            clocks = <&nsscc 116>,
>> +                     <&nsscc 117>;
>> +            clock-names = "mii_rx",
>> +                          "mii_tx";
>> +        };
>> +
>> +        pcs0_mii1: pcs-mii@1 {
>> +            reg = <1>;
>> +            clocks = <&nsscc 118>,
>> +                     <&nsscc 119>;
>> +            clock-names = "mii_rx",
>> +                          "mii_tx";
>> +        };
>> +
>> +        pcs0_mii2: pcs-mii@2 {
>> +            reg = <2>;
>> +            clocks = <&nsscc 120>,
>> +                     <&nsscc 121>;
>> +            clock-names = "mii_rx",
>> +                          "mii_tx";
>> +        };
>> +
>> +        pcs0_mii3: pcs-mii@3 {
>> +            reg = <3>;
>> +            clocks = <&nsscc 122>,
>> +                     <&nsscc 123>;
>> +            clock-names = "mii_rx",
>> +                          "mii_tx";
>> +        };
>> +    };
>> +
>> +    pcs1: ethernet-pcs@7a10000 {
> 
> One example is enough, drop the rest.
> 

OK.

>> +        compatible = "qcom,ipq9574-pcs";
>> +        reg = <0x7a10000 0x10000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        clocks = <&gcc GCC_UNIPHY1_SYS_CLK>,
>> +                 <&gcc GCC_UNIPHY1_AHB_CLK>;
>> +        clock-names = "sys",
>> +                      "ahb";
>> +        #clock-cells = <1>;
>> +
>> +        pcs1_mii0: pcs-mii@0 {
>> +            reg = <0>;
>> +            clocks = <&nsscc 124>,
>> +                     <&nsscc 125>;
>> +            clock-names = "mii_rx",
>> +                          "mii_tx";
>> +        };
>> +    };
>> +
>> +    pcs2: ethernet-pcs@7a20000 {
>> +        compatible = "qcom,ipq9574-pcs";
>> +        reg = <0x7a20000 0x10000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        clocks = <&gcc GCC_UNIPHY2_SYS_CLK>,
>> +                 <&gcc GCC_UNIPHY2_AHB_CLK>;
>> +        clock-names = "sys",
>> +                      "ahb";
>> +        #clock-cells = <1>;
>> +
>> +        pcs2_mii0: pcs-mii@0 {
>> +            reg = <0>;
>> +            clocks = <&nsscc 126>,
>> +                     <&nsscc 127>;
>> +            clock-names = "mii_rx",
>> +                          "mii_tx";
>> +        };
>> +    };
>> diff --git a/include/dt-bindings/net/pcs-qcom-ipq.h b/include/dt-bindings/net/pcs-qcom-ipq.h
>> new file mode 100644
>> index 000000000000..8d9124ffd75d
>> --- /dev/null
>> +++ b/include/dt-bindings/net/pcs-qcom-ipq.h
> 
> Filename matching exactly binding filename.
> 

OK.

> Best regards,
> Krzysztof
> 


