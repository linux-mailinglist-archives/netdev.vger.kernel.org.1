Return-Path: <netdev+bounces-215176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4FB2D761
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD15583723
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F982D2383;
	Wed, 20 Aug 2025 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="epGuVVM3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F901FECA1
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680270; cv=none; b=mOwAQTGYq6vBDy39mu3yNNHh9fOEsG+SD7Z3VpR8iVYkiX4tms1+sI6FW8VQnlJdg88y8kDWlNc2PQjl94CK0qLn1qXyfgYotKk5FEmyZcAfIdRkKiiijYNCF9SEaDF6Ec0fUi0wQZ9KzTGi0IF9fZbNc3evnU4XFNaFmcOZBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680270; c=relaxed/simple;
	bh=qkYO27EQCIXsaD48NEJxduCJmgc4ju2NKyZ3rsjrJ5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdwNQIHFP/zs0ejba4GWWGuJZGmX7H5+07rHqFERZxr3Wmr6LtrJlHzpw87KaC9U19JwaiR+oj0Ne28ewOsG7nVz24pqOQRyn6hZ2bmtBSjM3OUCRKuGM/WnMCcADS/Qg9IYCqZs1szWaOihySkGUBaRd3Kcj93W6/P14MuQ624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=epGuVVM3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1oqZp025884
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 08:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LovUKZUetKjTNqClYAkifuYXcchuuq2HOA0oOrFjetc=; b=epGuVVM3UEI+lpZ/
	GC3Gd49RLBjAts2KljoWNXZv1cVr+p/JIiFOTIni5sidKUiq8KP1lK9EODITlCKG
	do4i2ykChgNg+ODHLRPgfw/2uxIGrXvNag/dnw8nYBPZuadkJTjWfKqS2dEimX90
	VRxYcJHdH05LPhJCJKGZO3UvNU1hSJuditpdj8qQ4KkvscAWFiu7us+ZcZXANkYR
	oz/G+N7ALaYxtAwMeJeLgaOiiCtCrS7HX5rVM8sqc0Ju79vTt55maIT7bY9nf4we
	UnO0zqkurPhJR05+67EV2d164UT/MeAXMSDTmXfLQXtwX6WQKJgaAL+ChW0EZFrk
	DMzOVA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a93gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 08:57:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445803f0cfso66355555ad.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 01:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755680267; x=1756285067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LovUKZUetKjTNqClYAkifuYXcchuuq2HOA0oOrFjetc=;
        b=DdAwpHrCkDt1ODuTLwewZvEDv52CWguTyF9aXwPjS2G9KMewlQ6TFidJLTtzArmgwc
         lGqNuOJohEOeGGNPVvSzCx/+Ooe8eErfd0f59jLcnZvVlhCYOr97SsAb6Zzp96Tw/dQ6
         sC0yJdnpEFVFQRnm/sMPuLDbKogIEWC5YjaiXxshioACSjf+bi+iZMZmFhzGU49HAYoK
         GwgMyOxG5XeRue/yIFxG0BYUB1vmOSyQ4MUatc8OAlFIlgj5xvpm8WeJ3NYzdG8dlhRq
         VcPjRVa/ygl+R9Uj3T6A67G9kTtVB+l6Ip/ZRjnRMpfiA5nIbBecnwSdfKjxtM0DYBwd
         h4JA==
X-Gm-Message-State: AOJu0YyWhQUT8em8/inCCXovdwNcDrLxavBi5DxcrgKPFnUOuQtpa8dZ
	bCSr6oPowX9gSid+zf/nHzBU4oGwsQ/NqVPd6KwDcRE9dfJAj3sM/n+DM5IqOiZ7b+VFkB/fSFV
	FG1kF3/bSNGpP9QER0Sbf7/ysDtyz3AopnVCWw7aqthZQWYcfJabrl/LGwNU=
X-Gm-Gg: ASbGncs7Eeo0MJgwTJ8Wa0L+Xi1z8d9SRtUvxavZlTPY9wzbQDWL/SQDcHyEWuCII7J
	jBvCSiHVbzq2SSdIXOYYBIy1vUrals3x/CI64JQSxTZm6SMSpFW/6RBY3yea4AVZUR8xSZ53Xb3
	wTFXDfe6hG/d6eVUo8mG8Wyz97vP7ZvxkNaBJ2paBlnfg+oBFUSnojlaRG74SKQaKjYgySZ+YIh
	HKRh5pkUcqhKuKMAAAY+z26fVueis227J7rO+K78074Yi5N88tPQDR01sOLhoWnUJPRh8oCSalm
	pwo3AuQikRmnSSB/GQWeAQmajY3SlRQ0W51sED2zyy2Xt9h5LkUP8bltiV6zWudsxoQ2U2xNSGV
	F2ua6n5jJQzPXxzKvXPwWKEgIM0i7LtTK
X-Received: by 2002:a17:902:e74a:b0:240:96a:b812 with SMTP id d9443c01a7336-245ef1728ddmr29790085ad.24.1755680267111;
        Wed, 20 Aug 2025 01:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5sQXiIDgpXrdgQJsAaziiWnOkOwfxl+Waxq3t4y+pSVqgHGK5588qw9DsrKpoU1yq0lXcog==
X-Received: by 2002:a17:902:e74a:b0:240:96a:b812 with SMTP id d9443c01a7336-245ef1728ddmr29789735ad.24.1755680266607;
        Wed, 20 Aug 2025 01:57:46 -0700 (PDT)
Received: from [10.133.33.88] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed379e92sm20242905ad.65.2025.08.20.01.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 01:57:46 -0700 (PDT)
Message-ID: <b1eb2ed6-9743-465e-9b2e-75d5a06c1497@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 16:57:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] arm64: dts: qcom: qcs615: add ethernet node
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable+noautosel@kernel.org,
        Yijie Yang <quic_yijiyang@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
 <20250819-qcs615_eth-v4-3-5050ed3402cb@oss.qualcomm.com>
 <c4cbd50e-82e3-410b-bec6-72b9db1bafca@kernel.org>
 <157c048d-0efd-458c-8a3f-dfc30d07edf8@oss.qualcomm.com>
 <0b53dc0b-a96f-49e1-a81e-3748fa908144@kernel.org>
 <1394aa43-3edc-4ed5-9662-43d98bf8d85f@oss.qualcomm.com>
 <7c072b63-f4ff-4d7f-b71e-01f239f6b465@kernel.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <7c072b63-f4ff-4d7f-b71e-01f239f6b465@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pKx6wfrlcCodhkVcSvAav-ye9mm2qLgv
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a58e0c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=DOxB7AakEuovRElI8tQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: pKx6wfrlcCodhkVcSvAav-ye9mm2qLgv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX0u8vzXQ2acjd
 wDx8Si/pkYWFkiqCZc9zoVvzsu2qXgYmDKYiA4g/oFLwpFtvXYha34Q1W9THsAJXIqlVXZoT17w
 nY9zc3tGRiH15Nv1iKgv4ec4ZzYN4MpMdZIlbpy3Sh4wte6wApOktInr7ptljJTTB6swK3lEyM2
 2uuBmlFwjuc+zweuILiscsguQQ6aygXS39kh73E5UUd+gMSaE+nwM4ZeemSHlFjwXdcbeOa/Jr2
 jCi52nURpcLZhrXLQGv4h9QmoQUwbinYFGSJB7Ixf4HKjulSLthaDRDpjHScew1vvRyKnxeWlrX
 RPBXpHgWHSY7eUROzr+nYAI3n6LMIhwEPdw8LO/R52ILhgdiGUh4Xev6rpQDLhJkmSzr+US4zhz
 917TWLN53joFKcrCqUK07JuXG4hj+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 2025-08-19 17:08, Krzysztof Kozlowski wrote:
> On 19/08/2025 11:04, Yijie Yang wrote:
>>
>>
>> On 2025-08-19 15:15, Krzysztof Kozlowski wrote:
>>> On 19/08/2025 08:51, Yijie Yang wrote:
>>>>
>>>>
>>>> On 2025-08-19 14:44, Krzysztof Kozlowski wrote:
>>>>> On 19/08/2025 08:35, YijieYang wrote:
>>>>>> From: Yijie Yang <quic_yijiyang@quicinc.com>
>>>>>>
>>>>>> Add an ethernet controller node for QCS615 SoC to enable ethernet
>>>>>> functionality.
>>>>>>
>>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
>>>>>> ---
>>>>>
>>>>>
>>>>> Why do you mix up DTS and net-next patches? This only makes difficult to
>>>>> apply it, for no benefits.
>>>>
>>>> The DTS changes and driver code modifications work together to achieve a
>>>> single purpose, so I included them in one patch series. Should I
>>>> consider splitting them into two separate series?
>>> Of course yes. You are just making difficult to apply this. Patches are
>>> completely independent and even your internal guideline asks to NOT
>>> combine independent patches.
>>
>> The challenge with splitting this series lies in the fact that it
>> attempts to reverse the incorrect semantics of phy-mode in both the
>> driver code and the device tree. Selecting only part of the series would
>> break Ethernet functionality on both boards.
> 
> And where did you explain that? Anyway, you did not achieve your goal,
> because you broke the boards still.
> 
> Your patchset is not bisectable and does not follow standard submission
> guidelines. DTS is always independent, please read carefully the docs.

The approach I'm taking will inevitably make the series non-bisectable, 
but I'll clearly note this in the cover letter in the next revision.

> 
>>
>> As you can see, I’ve CC’d noautosel to prevent this issue. Given the
>> circumstances, I’m wondering if it would be acceptable to leave the
>> series as-is?
> 
> NAK. Sneaking DTS into net-next is not acceptable.

Okay, I’ll split this series in the next revision.

> 
> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Yijie


