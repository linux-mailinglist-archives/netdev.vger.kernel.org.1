Return-Path: <netdev+bounces-193633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0151AC4DB6
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1C33B851F
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B06E26A0F4;
	Tue, 27 May 2025 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ozuEJlbG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B8253931
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748345817; cv=none; b=uv8h7mFy94dfP1HkhamGC/bqH86Hl+4sQZDqYLuhN5M0VfUDIFVkuktxlndnXqJF5vMl7DJ//jAatMt5t4k1PnC0TcrIaJ1/45a+UBKTTemoslbNOgRUIJONUs3qeOle8tV3fXEomdxafFsVcjZT3XDiSClvjYYTtN4LfGqyUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748345817; c=relaxed/simple;
	bh=fvEjZ/8XvmiIw/x1T49zRGL66s1CZIgvsgbv4p02D5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K87NY8Dc7ppqHuiwexWDIBItf/w2i88xbZFB9SD/G+Yo1yS4HhAgCuG0wcg77efyvimRAKS9vFwKC5oJ1EdE++OILrPln6DBbySE/tGoG8pHCCZXQNId7NJsE+ERRLW+HZ+np7h+DQTam3vKptTfITPwFPWkW9dRUfT7dBdLGCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ozuEJlbG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R9ZANv002357
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mLM+GWekrBtrawNMm2D4lJztX2o4sPffJMDli9j9kAM=; b=ozuEJlbG24ADssOl
	uWUZZ/KEib2FdpiwXYbHvI6ct2aj2WaVAfNQNrrcuB4F9JvzMbVuRCS+t7fCFJh2
	GZulqrY4WSSBlAnTpGT6aR2vBKuYcv2nR7StyUg7JZYfp3BFeLqzYo4MOECFuI2h
	LY9qEEm233lZYigL3v466Q+XhrM1eFCisGhBH+EjyGYduzBONiQj4BrxIIcMb6AI
	V5VNtQ5ra7K5bxylbN+xoORE/n6sm5VzCWl6NMXIL4wcP7RmBXzqfBJWp4Lbr96v
	PnjqiCQT0wdVod1YvDyjx+T4W9ErvpprGnAHV7rLi5qdQrFPuegfxgKfF3dFbr0U
	gvhgcw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46wavkrbay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:36:54 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fa9cc8eb70so1346246d6.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 04:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748345813; x=1748950613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLM+GWekrBtrawNMm2D4lJztX2o4sPffJMDli9j9kAM=;
        b=WrPdFCl00N/L9R0R6WjtvP7BjTE+bnALDypAeNYVv7uL+jNu4mh3lFa1GyWDTmr8cw
         S3b4cMMxndpnH8qus+ndXUItwbzEhXrYjJZI9D6btAE/+9DrnrosWmfshRiR6m4CFOWW
         Mp/i9WnykH0/EEshVK+r2dkciKvL0mv0eQBYTJq6otiCKSDE4k3x1MggEudNXb9K0mtO
         ksjv3Hb22u4ovwlng7qhhlqL43JDNFKTeaE+65KgpaP3eGRAwMQN0FeS+YdjyX3cPzE5
         x8s1ANtz3dJymlRLMPN+TFYDy3earIow/XzT5Ld/UFJWEsKjq1PhMbzRBhsFkLO7cRnU
         XyEg==
X-Forwarded-Encrypted: i=1; AJvYcCWZz4AFXg7r7GhexdOqyGK+J+MTe4+QOU821fEr8HAGuPJ3ZtBTT7bIUusfzrPlSGYO5fxrELo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOplKYinBRPoja+XcL9mWi2ZrqHCHGDxQdwm8K9m/AfmvSAKdH
	ADN/ppANiKzHHpA+sOeAa78VO0gDmjjbZ+adRarCCeVjTPKOOBe43XtZXT2wq9MdGxGnml7BloU
	Zly/qMOoKUnfko/0ptCwEKMGP2jPPTJscOyvms/0vC8SULV/vp/jb1J2Aq1U=
X-Gm-Gg: ASbGncsJkz8zrbn8MGlsCZNzCvk5oJfbF0SsL08jVdk60YZCWwlpQzdesZ70HphgyqG
	02xRMxEkj8WqfR6rJFlXs5FxXC/XznorHVUUsSbCidwi18JC+RelbInHg0RGT9Sz/ZN8fDQhfuo
	3U/iKhND50SU5jc5cA3idlKs46wndlrmB+1WkFpwVyXmdmOD2uh3Gr96Qd2VudhcmRsQLUXaqDR
	OiNRovvTUBgNyJ3Z+mIrpViCix7eZ0efph8/e8pVA4wzQrkWRcmdHrTxHo4lEFT18hFqn6aF4uQ
	D0N1SSSAT3aMlyBfaoTaUxagQslKBxNdfzNeTcM70IXEOQXy/B5tHisLb7IQZhQt1g==
X-Received: by 2002:a05:6214:2586:b0:6f7:d0b9:793b with SMTP id 6a1803df08f44-6fa9d34ba15mr66049926d6.8.1748345813621;
        Tue, 27 May 2025 04:36:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwP18XRKy8jlsk+tWNpk1oV00GPmvN6UNYhfqRCLVDbAvK7pSH3h1WanmxrHiy5RUbYnfabQ==
X-Received: by 2002:a05:6214:2586:b0:6f7:d0b9:793b with SMTP id 6a1803df08f44-6fa9d34ba15mr66049676d6.8.1748345813242;
        Tue, 27 May 2025 04:36:53 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d439655sm1854813666b.92.2025.05.27.04.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 04:36:52 -0700 (PDT)
Message-ID: <e7ee4653-194c-417a-9eda-2666e9f5244d@oss.qualcomm.com>
Date: Tue, 27 May 2025 13:36:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: sram: qcom,imem: Allow
 modem-tables
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alex Elder <elder@riscstar.com>
References: <20250527-topic-ipa_imem-v2-0-6d1aad91b841@oss.qualcomm.com>
 <20250527-topic-ipa_imem-v2-1-6d1aad91b841@oss.qualcomm.com>
 <97724a4d-fad5-4e98-b415-985e5f19f911@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <97724a4d-fad5-4e98-b415-985e5f19f911@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1VsB0cKPtQb8PShrGlYzD-JauXbPnjpk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5NCBTYWx0ZWRfXwtzumxVfDLjK
 KcrD07pZCfKSEHnlewM0WAUvDlrDNbJCsN2Ka1Y2JoZSfhQEDEitB9OGzutsEOlqWaq8SgNDO6S
 7f/1Ic4cICSerloOal1Gq58XrqcTKj5z/O7Z4qHeyk4uV9BIeUG7BhyoFegecTh4kjfSG5axIv7
 Uo0aXKSQMkSt/3GgHJBjVjluZxM7E2PRXclQfTuPkoOGfkEQRetRwLqyKRRr9SzxP6eB2XRvHVh
 Qqnlfith/SpOC3lDoe/z6K2LA4WZo68h8jJCzYha94m+3DuU2bR95Yyxpa2+xPJcw0gaVLOaYyO
 C4R4QRvW/9hlyVPcS/uDaTChNrl/5Mse0/MLzcLIJ36KPrYiwCIRVDTUGclpS1tzGqK7DkfBfFF
 P8uGjc3yXKEHKQ3AYbFQR25Ese74y4ngEpGDMK9u/eJrljRbNQ5nzgSCJExfKS832n4TB9KW
X-Authority-Analysis: v=2.4 cv=fMk53Yae c=1 sm=1 tr=0 ts=6835a3d6 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=ee_2aqc6AAAA:8
 a=zoJKnCTf_W_lU4eZxPEA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-ORIG-GUID: 1VsB0cKPtQb8PShrGlYzD-JauXbPnjpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270094

On 5/27/25 1:35 PM, Krzysztof Kozlowski wrote:
> On 27/05/2025 13:26, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> The IP Accelerator hardware/firmware owns a sizeable region within the
>> IMEM, ominously named 'modem-tables', presumably having to do with some
>> internal IPA-modem specifics.
>>
>> It's not actually accessed by the OS, although we have to IOMMU-map it
>> with the IPA device, so that presumably the firmware can act upon it.
>>
>> Allow it as a subnode of IMEM.
>>
>> Reviewed-by: Alex Elder <elder@riscstar.com>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> index 2711f90d9664b70fcd1e2f7e2dfd3386ed5c1952..7c882819222dc04190db357ac6f9a3a35137cc9e 100644
>> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
>> @@ -51,6 +51,9 @@ properties:
>>      $ref: /schemas/power/reset/syscon-reboot-mode.yaml#
>>  
>>  patternProperties:
>> +  "^modem-tables@[0-9a-f]+$":
>> +    description: Region reserved for the IP Accelerator
> 
> Missing additionalProperties: false, which would point you that this is
> incomplete (or useless because empty).

How do I describe a 'stupid' node that is just a reg?

Konrad

