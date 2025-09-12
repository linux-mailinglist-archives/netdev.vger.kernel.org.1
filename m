Return-Path: <netdev+bounces-222500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6288B5481E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6695D17BD73
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F228002B;
	Fri, 12 Sep 2025 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="frl1N9yB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE927E7F0
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670118; cv=none; b=TfbE0hgP+u/GbmOpkACexBtag4IQCNw7BuO7TBAqssTkQnIJDSU3XTowH3VS6WLCaavKS7dIjLyWh6xHsom7AqbI0KzL6V3UjVXIqsoI6LR6mKpTsYe+WYpJIKB8pnA4NhiZtImCYEk4JxoKcsFpKRxgJkSdYXCMys98+Fzquyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670118; c=relaxed/simple;
	bh=aHZH4YS5dVoOj6kl4jXgDRDoWhg+l0J0dv5TXRxoBzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPBq+9387PsAGyeni6kJYzIh/Djsmd14CB2Li6EKhPWEJuG+OGACAsrMtC+955Ee0xzd+tf2vPylYcsBxmTYPq2HVcEzjWaXOg7HYzmeBKp1UUIbeY72aSCoUXDqG6LMUypzZROCivgdaYsjJwvl4TGIBqqIAggX/n5ecp2q8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=frl1N9yB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fPlN012880
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ubdZE+2MGy4tFDpQKrzviatnp7P+PiPFBJ3kNogasGs=; b=frl1N9yBvDBrBz+g
	vYpk/y637iCILK5KDEzRuFB1WIT4wlp3iA7Ak3xcVXtckYYSF94Zme5MDaBuQXn2
	91njJBp2xEcqFGcBQUSHSCBnCBuYDkDiHbsoiQ8yGQmexU7bb7Ntfmp0WyCqOTE2
	uGBhM20XnimXZfWw4fPpeDIuzI/fN9Fzes9TkxsPQT4QCeCepqUAKEdHfQ9GoQe4
	yyubFKuDfYboEzIEUsyPMdiDwshIPMZ43ycg4ycI1BYoYRnv3T+sAr8dN6p5Ydok
	7pBYoiTgxjeMZhxFiYq4EkyTupvgEh5gDNuWZbvNu3+AaZD0zNVjIQzDOtn6lQYg
	w+PA8g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqgat69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:41:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-820357763f6so59224685a.2
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 02:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757670115; x=1758274915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubdZE+2MGy4tFDpQKrzviatnp7P+PiPFBJ3kNogasGs=;
        b=CgkQkyiw+6pOgkvBD8A66rCX1zzYIP2d9TxyPMBgbtrUBQD+psY/SGeeVKDQU+7RZc
         RRVe8WhkiyXECNTechSbxLBggpzcDVk88ZOM6/2ANUfSrInpleBU2mBClYFpHDu6K96D
         0odRzT7cCSbFm68wMJBOy+zukEpNNpnjJVEcoTqZqyRlhxnqW/S6dG29boNMsmgy+kun
         njCSjlP7ArEKUHMvev6MQRhfjMZHDIUda9EjWmjA8HQumNh495VsWR+Ecj2XC2lXg12Q
         d2t1+lhVKRj9dZrm4t2ELpx/rFPVfNp0ldnkBWNpQLp0HFPFwxtHNG3auY1exbfCZKHg
         z2iA==
X-Forwarded-Encrypted: i=1; AJvYcCXyqDyhfS0xruhDnvdDwgTNZdLwgxmRNOimmnYVto4LMkk9WVsGCnr82QkiYi5Fj94ehlzBEf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWNbR1uqDLGnZSeXJYuilheXzzGneqDj3O7znuoxe5hfsLBvoM
	3vGJRZBprMryDxWmIdkCsevARULKr4rx1Kub+9GjvvT+WVbwEP+ACbUhBJkRswjffMskvdHzt2q
	ke+wJUa8pigN15P6ET4JM/PV6ptX8IrmdPy1IAf0oOJN3rE7+ObAgPPdi7b8=
X-Gm-Gg: ASbGncvg386tEYpG8bCzUezMm5kgrGMQh+J+922MruStcQ73HZGfwTkor2lo8YK/Fwa
	HCJrTUTirmgh1HzaPXBFBYryh9HIZdyIQMLaM/qBGSv9PiaSzU/cVC5yCVRpF5OKlIsjGucby5k
	vUa7yi1vJwcreN3iMrMSZbpCTapEyDh2pb00UnPd+vLCAbWjh5PEvW6jZOAEeGboJqZCCzBn0zU
	PHTdEWAQhLnMeqhFvNRHcXp6BOgWt8oKWKGXrGkmrSQwKnEMCXH1TTshoRQAamuaCcu7e9iAtcB
	JQQWicswLdqDkgkWsN7q3tpiJqWkW4x8OR8V+00Fgqlu4wfMRsNN+ryUKdG1dP8jRsIx3i4gpQv
	QJXdubXMHW3k2d+lDq9k/RA==
X-Received: by 2002:a05:6214:f05:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-767c1c8fd01mr17754026d6.3.1757670114619;
        Fri, 12 Sep 2025 02:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW19WjSadyXUxnUE5X6AqSmTHftlhz5SicnK4cbK2PU6jUKPiXVwSAYDJJeeQH+UMau1p6vw==
X-Received: by 2002:a05:6214:f05:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-767c1c8fd01mr17753866d6.3.1757670114134;
        Fri, 12 Sep 2025 02:41:54 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62eed9aec1asm131613a12.3.2025.09.12.02.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:41:53 -0700 (PDT)
Message-ID: <0f9d55a4-83a1-48f6-aa19-e3117192bebb@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 11:41:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] dt-bindings: clock: Add required
 "interconnect-cells" property
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
        quic_suruchia@quicinc.com
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
 <20250909-qcom_ipq5424_nsscc-v5-2-332c49a8512b@quicinc.com>
 <20250912-nocturnal-horse-of-acumen-5b2cbd@kuoka>
 <b7487ab1-1abd-40ca-8392-fdf63fddaafc@oss.qualcomm.com>
 <2951b362-c3c1-4608-8534-4d25b089f927@oss.qualcomm.com>
 <52714c33-5bd7-4ca5-bf1d-c89318c77746@linaro.org>
 <d293a11b-155d-45d3-bafc-00c2f90e8c43@oss.qualcomm.com>
 <1cd6a0f9-2955-4189-8d1e-85fa8ad8dddd@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1cd6a0f9-2955-4189-8d1e-85fa8ad8dddd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZBTgv4EfyjyaikZRhxFahvjuwokzgGZS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX1smqRcDwgDzU
 b7cTKQFxbj/Fp4Bpf/zWqo2db3KkYq/LcVcSNGVS5GQrbv/j76JrEC3LUE1bZ8VoisgClU+mEC+
 bxuUUsDzho4m3RPZ/+dwRceUD+1kkE9SKU4oqN/uLV8AVRU83zrs8WrDbssz2AHCX8lYgflD8QN
 uhdIwDpfltgb5i2VXzpuUa0QojLPk1ecFrBM6/gYBGXCAjn3dX0xkHMUIt9W6NhEq9y9BKOsVQo
 KYGvAlRg2Q3Da+wCYPQU9mOjpX/aWvuQOK1wIu7VWLsv0jdn9TAtyzejv2eilux3bGwZG6ZO38A
 NQB4ZruLuFT5ttXJlPMlp7d1vS2iucBIF//se3EMk/tRPM0FUjVuZ7oKwjV3afDrBYuTInYsFGk
 QiJ0dm0o
X-Proofpoint-GUID: ZBTgv4EfyjyaikZRhxFahvjuwokzgGZS
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c3eae4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=r2WM0BnHFFIPBb0dDCkA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On 9/12/25 11:27 AM, Krzysztof Kozlowski wrote:
> On 12/09/2025 11:21, Konrad Dybcio wrote:
>> On 9/12/25 11:17 AM, Krzysztof Kozlowski wrote:
>>> On 12/09/2025 11:13, Konrad Dybcio wrote:
>>>> On 9/12/25 11:13 AM, Konrad Dybcio wrote:
>>>>> On 9/12/25 9:04 AM, Krzysztof Kozlowski wrote:
>>>>>> On Tue, Sep 09, 2025 at 09:39:11PM +0800, Luo Jie wrote:
>>>>>>> The Networking Subsystem (NSS) clock controller acts as both a clock
>>>>>>> provider and an interconnect provider. The #interconnect-cells property
>>>>>>> is mandatory in the Device Tree Source (DTS) to ensure that client
>>>>>>> drivers, such as the PPE driver, can correctly acquire ICC clocks from
>>>>>>> the NSS ICC provider.
>>>>>>>
>>>>>>> Although this property is already present in the NSS CC node of the DTS
>>>>>>> for CMN PLL for IPQ9574 SoC which is currently supported, it was previously
>>>>>>> omitted from the list of required properties in the bindings documentation.
>>>>>>> Adding this as a required property is not expected to break the ABI for
>>>>>>> currently supported SoC.
>>>>>>>
>>>>>>> Marking #interconnect-cells as required to comply with Device Tree (DT)
>>>>>>> binding requirements for interconnect providers.
>>>>>>
>>>>>> DT bindings do not require interconnect-cells, so that's not a correct
>>>>>> reason. Drop them from required properties.
>>>>>
>>>>> "Mark #interconnect-cells as required to allow consuming the provided
>>>>> interconnect endpoints"?
>>>>
>>>> "which are in turn necessary for the SoC to function"
>>>
>>> If this never worked and code was buggy, never booted, was sent
>>> incomplete and in junk state, then sure. Say like that. :)
>>>
>>> But I have a feeling code was working okayish...
>>
>> If Linux is unaware of resources, it can't turn them off/on, so it was
>> only working courtesy of the previous boot stages messing with them.
> 
> 
> Which is fine and present in all other cases/drivers/devices. Entire
> Linux in many places relies on bootloader and that is not a "work by
> coincidence".
> 
> Another thing is if you keep backwards compatibility in the driver but
> want to enforce DTS to care about these resources, but that is not
> explained here, I think.

I don't feel like arguing axiology today ;) But I see your point and I
won't object to either outcome, so long as the property is *allowed*

As a sidenote the IPQ SoCs have a rather thin layer of fw

Konrad

