Return-Path: <netdev+bounces-193620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95475AC4D67
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37587A3005
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 11:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5446D23ED75;
	Tue, 27 May 2025 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B1715I01"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7308488
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748345521; cv=none; b=AXB4UgpFnId5XRhjtiL2l6cqLVbT2dCDNS3rl7ftf8g4PjmkcsFNFba8zQ/E5t8uL3KL06bWUSyq5GwsAd3z8ZBODfMkzvRpJ+WaD1Q7xj+UTcNNqYEsiq+2BB5uoVNEEdB2kYMH6KSYsb6acBFmWDqPvxW2zuls+PYFWhYxEMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748345521; c=relaxed/simple;
	bh=XCIdrdZzFWi7msDgsBaY0djiaHb+xsYdQKwWFJFFFno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qc73qEM1NhgZHmbzLTOaEQPFqVoRSii/tz5rhchJHYgDXUghoDZEoEb1tSe2O2+YftI4jPX6WPF7+G8drSEiJsfX6uufxEGAnwDfPA2SNc2FqqOLOaDgBHzPrrPohuFhdZm4/fZtZbU3qXk3sHXX30YLr9RO6hYQ7/yiibpQfNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B1715I01; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R9Zbrt003397
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wr4bynBdw+PjRhghTsUSTdSd32On/wQ2FmoyVdHbVwI=; b=B1715I01l9j2HcEy
	3T9UHHvz2QTrUMgaBfOGulglVek8v6wSYzC6j8Yvrqnpi8oLPd2YD18kYQnM45UG
	g+/bo0B4YhnhOeTQmT0md5mZY17TZ53Fb8MLmTJFD2uaw8+ay8lLBp1uw6GZmlhv
	HUfMAgl6c+ks33umROR/2tkVZxz34cQhoEg0l8bRTlVi4H4iLtq1njrpRlDyrVqB
	Xt3VZN5VVlEHZ8XdwXnagl8uCSH45oR9ey6YD34MedZrSUpprDJznpKq11kvlol1
	KjPbp6SG0s9zsraOkeZWlVoTEo/5LaBpjFT+zxCD8pH9rfntXEwt7k5Ood8HvA9E
	NCyx5Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46wavkraws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 11:31:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6faa016252bso11366076d6.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 04:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748345517; x=1748950317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr4bynBdw+PjRhghTsUSTdSd32On/wQ2FmoyVdHbVwI=;
        b=wZkWu+WlYqCxU1OHc6hdpOUGuNKb4OdC3X5VTYScFmAiDSSGQvnfykgI+vEa8t5hmz
         BWWjMdxiRjnLlXzAaKhRZqcrHJ01rn36QBmtWJBoFkYyDjoe8t0DjU8jETpouNTj+ajm
         d56S0XNEbe+kGUtmbt0ok4JlQmKVlqYP4R8xnI0VU5QBFi0rbVhnkvkQ6Xhutlmf4VX4
         HLMQXfvmG5HIDbbNr4Ifb7lcX1kqzb+km3a/39ApjbtTDrdbP1u0avAHd/cqzWbSsiWR
         r0Z5KJ3GmZfPluikt5JiYEcZ2483xZLnOdPPOjUGXVwBuzipbN3HY0qIrQe+hhiXjALS
         /Oyw==
X-Gm-Message-State: AOJu0Yzt3+KOQJszY1vJZuMG7XPuos/vG96g5kcHU1mYhJ3JIaLKPLWg
	ARX98i5Rf5s0t+Irkx6CEcYfTz1vccynDqUV3ymEQlIvnGBogP9e0TlY2D3jvWCMJ8J6UVrwFT0
	a3uCGwTKAWjlwB7k6wHrOmFhi6HN0yx0Qf5Udu/iNg9KzG3U9yHgF/CEfey8=
X-Gm-Gg: ASbGncuBpKWH0SqNygyo+5CaWcEvWrHzoHmeAvKg+ZhphUNe+S6kCpBXQ4q5pO0fkM2
	J8WOtI7mrk7VQqJNNb5+oHazW5JOf88Rbnc3fw0dB3Lt8yWCTsMAZfks3cLKczkPvwnh4p1qzuf
	wFF2S/wDUgnRDOS00CLzaWJZyPXelefxHTVa+KzbnD9qrfjiEZC/krOSbLXmEO8ee3vS/dWK0en
	yC4OoL/yrqorxZaf9+vzJ+vbcB0Ri1x/WQotc7ZoplvmSu0p/BwcK4IY3ckfOR02G+rJlrIL7kf
	LK3ifkV7NfjNCIME4QvDlGKRsObuObcSLH971Go+GGYHUpq9uULUYwAfvZSZJ0HI2A==
X-Received: by 2002:a05:6214:764:b0:6e8:9351:77f8 with SMTP id 6a1803df08f44-6fa9d16ff1cmr75912006d6.7.1748345517489;
        Tue, 27 May 2025 04:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErCTbBKgoT2MX71KELY5FtJ0xIj3X7orP1TK2iTy3xBDcaJHppmSxcImPiEugk7wg0yFmcsQ==
X-Received: by 2002:a05:6214:764:b0:6e8:9351:77f8 with SMTP id 6a1803df08f44-6fa9d16ff1cmr75911886d6.7.1748345517158;
        Tue, 27 May 2025 04:31:57 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d047be1sm1821279566b.26.2025.05.27.04.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 04:31:56 -0700 (PDT)
Message-ID: <82484d59-df1c-4d0a-b626-2320d4f63c7e@oss.qualcomm.com>
Date: Tue, 27 May 2025 13:31:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: net: qca,ar803x: Add IPQ5018 Internal GE
 PHY support
To: George Moussalem <george.moussalem@outlook.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20250525-ipq5018-ge-phy-v1-0-ddab8854e253@outlook.com>
 <20250525-ipq5018-ge-phy-v1-1-ddab8854e253@outlook.com>
 <aa3b2d08-f2aa-4349-9d22-905bbe12f673@kernel.org>
 <DS7PR19MB888328937A1954DF856C150B9D65A@DS7PR19MB8883.namprd19.prod.outlook.com>
 <9e00f85e-c000-40c8-b1b3-4ac085e5b9d1@kernel.org>
 <df414979-bdd2-41dc-b78b-b76395d5aa35@oss.qualcomm.com>
 <DS7PR19MB88834D9D5ADB9351E40EBE5A9D64A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DS7PR19MB88834D9D5ADB9351E40EBE5A9D64A@DS7PR19MB8883.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mfP_XhUd0SnHX9cuPjCYw2MPGOaqOvXA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5NCBTYWx0ZWRfX+MmKGKJLq9hT
 fdgGa3CiusQYBY8hmz/sgbQEPTgtmQdYvPzk7NPvqcpTmUaq+EofYUBiq+wgLUHU9LtDvfVJn3r
 09o+GzodudHi4qjVSHg3zA9TKIZUeomd7nYHjiu0cyuOeDEwZd3SwTmDGuwlSliUpDtX8J82jWl
 DWA/zFzHVGYRwEHSHo/4d2ubYC9S1NytAdr+VJQ3CFCPI68Ba24edeD43dqSODkaiALegkRT4mo
 QZxeESQ3WBkpjQaxhp8BBMxZaUgfuc5yECUMwTPGhPNQN3laJ1qcBYiekJaQXwFJOWonpwk+U84
 LZz2FD7+aTtZXHrvfc5lmFQV5jrb4MDBG8quTvGtDUET1rnjVaL071ZLXd4ZwgbNcmzQ0BxAHNh
 RiGJ5kNxESQm7IicvtkHqdFJZDm6GDiS5CBaDUCmHQM02xlbFTQ69OiaDQEw4PE8GZPcRpKh
X-Authority-Analysis: v=2.4 cv=fMk53Yae c=1 sm=1 tr=0 ts=6835a2ae cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=wWch0s3tv6xjeYHlD58A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: mfP_XhUd0SnHX9cuPjCYw2MPGOaqOvXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=974 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270094

On 5/27/25 1:28 PM, George Moussalem wrote:
> Hi Konrad,
> 
> On 5/27/25 14:59, Konrad Dybcio wrote:
>> On 5/26/25 2:55 PM, Krzysztof Kozlowski wrote:
>>> On 26/05/2025 08:43, George Moussalem wrote:
>>>>>> +  qca,dac:
>>>>>> +    description:
>>>>>> +      Values for MDAC and EDAC to adjust amplitude, bias current settings,
>>>>>> +      and error detection and correction algorithm. Only set in a PHY to PHY
>>>>>> +      link architecture to accommodate for short cable length.
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>>>> +    items:
>>>>>> +      - items:
>>>>>> +          - description: value for MDAC. Expected 0x10, if set
>>>>>> +          - description: value for EDAC. Expected 0x10, if set
>>>>>
>>>>> If this is fixed to 0x10, then this is fully deducible from compatible.
>>>>> Drop entire property.
>>>>
>>>> as mentioned to Andrew, I can move the required values to the driver
>>>> itself, but a property would still be required to indicate that this PHY
>>>> is connected to an external PHY (ex. qca8337 switch). In that case, the
>>>> values need to be set. Otherwise, not..
>>>>
>>>> Would qcom,phy-to-phy-dac (boolean) do?
>>>
>>> Seems fine to me.
>>
>> Can the driver instead check for a phy reference?
> 
> Do you mean using the existing phy-handle DT property or create a new DT property called 'qcom,phy-reference'? Either way, can add it for v2.

I'm not sure how this is all wired up. Do you have an example of a DT
with both configurations you described in your reply to Andrew?

Konrad

