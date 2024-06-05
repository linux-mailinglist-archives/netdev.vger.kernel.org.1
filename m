Return-Path: <netdev+bounces-100916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4608FC873
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8931F217F2
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AFD190485;
	Wed,  5 Jun 2024 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="J+wKxVzL"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE5190069;
	Wed,  5 Jun 2024 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581491; cv=none; b=PVX7hztzqmHfR99Ss/P2AhgZg3gsZ9f2ns6X6AGAptVRhT99Bp0/FEOBCV3Yqhy8j6Gl4zgbYTBNM9/ccIZQ31cm8Jw6qKAxYDsGfZAFSdr1157jnHGqnZ7Zbo/jUJNHcDBLFO6371kMj4u6R5vslFJ+QWg3FM04hbXT1SHkKn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581491; c=relaxed/simple;
	bh=xZQz7fJmDvWNQhqSTZkcIXCIAoM0eFHSuZHUQfg57Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZYCbS9pkALFIgTQmOYuojp4xM0xp9Oys9kr6WlABJQzWPY38GIAd/dDbZU0JxNRizjQAtYb85eJ5o78KVBvzBz35mUn8Nj1Z81H/wNx6KsrCMr6DgVGn79XlS0jHmNkChiBRog9MamiXwKcizecyszH0z/XPExK+XUMbcZO5lrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=J+wKxVzL; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4557cvlj013276;
	Wed, 5 Jun 2024 11:57:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Yl2/1DvIUCdB1SM68YD06QoDvfl+b4umSa+Pr8mxF0I=; b=J+wKxVzLNClyM69E
	gk71rArZ3dSR5WmkoQd7MZ+Nvn1ZWNMZ/SJm5io0n+Oj8HGLwsvCuMKf7nqnNx5g
	lz6SpMVUuI9sZ6bc2Y7XHnBLMYWzvcfPNjkmGnS5GSEa18LgBSIimYZttnaMgwaN
	xiDedlp7ZRxXq1s0rUFqVpEjQDIH5+20m6vjdHwMn5hqAmDBbQcdT1AqFYlu0y2Y
	an+GGTuGiUKjJgHa9tM83eFJtvVeD54ZnQPobyLu5Q3Q2YFEwkIpokYSsI0sVvtx
	3pl4hwNmOU/Ii81M9GlEKRV85jpZwChNGnzf4KmM9+C3wf90CsxoJQxXVJuX5DVW
	+LEWOw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw30fyq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 11:57:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 78A3540047;
	Wed,  5 Jun 2024 11:57:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B05D1214D37;
	Wed,  5 Jun 2024 11:55:48 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 11:55:47 +0200
Message-ID: <70b66190-2c55-4228-8c31-f58a05829d8b@foss.st.com>
Date: Wed, 5 Jun 2024 11:55:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] dt-bindings: net: add STM32MP13 compatible in
 documentation for stm32
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
 <20240604143502.154463-2-christophe.roullier@foss.st.com>
 <067d41e5-89cf-45eb-8cfa-b6c3cd434f76@linaro.org>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <067d41e5-89cf-45eb-8cfa-b6c3cd434f76@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-05_02,2024-05-17_01


On 6/5/24 10:14, Krzysztof Kozlowski wrote:
> On 04/06/2024 16:34, Christophe Roullier wrote:
>> New STM32 SOC have 2 GMACs instances.
>> GMAC IP version is SNPS 4.20.
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>> ---
>>   .../devicetree/bindings/net/stm32-dwmac.yaml  | 41 +++++++++++++++----
>>   1 file changed, 34 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> index 7ccf75676b6d5..ecbed9a7aaf6d 100644
>> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>> @@ -22,18 +22,17 @@ select:
>>           enum:
>>             - st,stm32-dwmac
>>             - st,stm32mp1-dwmac
>> +          - st,stm32mp13-dwmac
>>     required:
>>       - compatible
>>   
>> -allOf:
>> -  - $ref: snps,dwmac.yaml#
>> -
>>   properties:
>>     compatible:
>>       oneOf:
>>         - items:
>>             - enum:
>>                 - st,stm32mp1-dwmac
>> +              - st,stm32mp13-dwmac
>>             - const: snps,dwmac-4.20a
>>         - items:
>>             - enum:
>> @@ -75,12 +74,15 @@ properties:
>>     st,syscon:
>>       $ref: /schemas/types.yaml#/definitions/phandle-array
>>       items:
>> -      - items:
>> +      - minItems: 2
>> +        items:
>>             - description: phandle to the syscon node which encompases the glue register
>>             - description: offset of the control register
>> +          - description: field to set mask in register
>>       description:
>>         Should be phandle/offset pair. The phandle to the syscon node which
>> -      encompases the glue register, and the offset of the control register
>> +      encompases the glue register, the offset of the control register and
>> +      the mask to set bitfield in control register
>>   
>>     st,ext-phyclk:
>>       description:
>> @@ -112,12 +114,37 @@ required:
>>   
>>   unevaluatedProperties: false
>>   
>> +allOf:
>> +  - $ref: snps,dwmac.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - st,stm32mp1-dwmac
>> +              - st,stm32-dwmac
>> +    then:
>> +      properties:
>> +        st,syscon:
>> +          items:
>> +            maxItems: 2
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - st,stm32mp13-dwmac
>> +    then:
>> +      properties:
>> +        st,syscon:
>> +          items:
>> +            minItems: 3
> I don't think this works. You now constrain the first dimension which
> had only one item before.
>
> Make your example complete and test it.
>
> Best regards,
> Krzysztof

Hi Krzysztof,

"Official" bindings for MP15: st,syscon = <&syscfg 0x4>;
"Official" bindings for MP13: st,syscon = <&syscfg 0x4 0xff0000>; or 
st,syscon = <&syscfg 0x4 0xff000000>;

If I execute make dt_binding_check 
DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/stm32-dwmac.yaml with:

    For MP15: st,syscon = <&syscfg>; 
=>bindings/net/stm32-dwmac.example.dtb: ethernet@40027000: st,syscon:0: 
[4294967295] is too short

    For MP15: st,syscon = <&syscfg 0x4 0xff0000>; 
=>devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@40027000: 
st,syscon:0: [4294967295, 4, 16711680] is too long

    For MP13: st,syscon = <&syscfg 0x4>; => 
devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000: 
st,syscon:0: [4294967295, 4] is too short

    For MP13: st,syscon = <&syscfg 0x4 0xff0000 0xff>; => 
devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000: 
st,syscon:0: [4294967295, 4, 16711680, 255] is too long

So it is seems good :-)

>

