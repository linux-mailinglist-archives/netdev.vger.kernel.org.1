Return-Path: <netdev+bounces-193650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE9DAC4F71
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716A117D8C1
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052FF271453;
	Tue, 27 May 2025 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HucSr9AH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5019F26563B
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351758; cv=none; b=to/QgrUELs9H3BN9tbFeamCKvrM+qVbYpbaHWqzL7qYfIIqXR5eD6aJmed5aT/LZqvnP0FqqS2jqV4JUliM/9RQ3E8ikevI1gH43y0ucNhgR4EfEIzP4uHTeNqCxANnmKPfHFtqXTvlMfzt4EbnxKa0UxGSrQIzftfAaYLJFir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351758; c=relaxed/simple;
	bh=d5W3GX0X7g3UXissjAjd6tzKPlXKQx+avpna/bRC4og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHTSbWMOu9tlqL0zFVmPKp6jvyE0ivZDiXtbJ5LR0WRLEe2VYWFkIfCgUDlgNdl5PFIiy4gbHlQBfkGtGE2LyTFoDaSrPtUFmR3dOZ2J2iQ32cJRoWlpsd/H1NPryulDC3eEZ+KyKCly29hkHRktdw65ZaC58ndRwSC67HEWtgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HucSr9AH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCqNxg013982
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	haI88HCttPlaimE5g5HZVq6U+tyuHSX3H7yH1gCwk+c=; b=HucSr9AHQ0oqedkk
	WQfCGc46c6oUBBd4ZTTElr9y7QkAWdeLenxWA459TAr1ezvg0CRxm1wU4VsbXL3w
	fyOkOYUSOGQfQe6UWjn3orWikMe+fCYvA/2Zjazht51JDLRxS0g66/F99meK0i6g
	L9HeEzZu1i0SkFUytu7W4iGoPbnkzPfdnkZm5tiYBm0Mei6EQRcmkqsxN/BSEt4F
	loh0XFLXeCHyzTc50e5L0tZ2rk4IJk0D+2TdDq+PyYp4CrcV/WC/7sU6j0ekDkeF
	XaV9qqDAwat9eLeJzCHbo5VnSpPlQWNZYXwidZzGXypHevOSUdcpq+pJ1WowNtCn
	22XO3A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u5ejxx7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:15:56 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6faaa088820so5137926d6.1
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 06:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748351755; x=1748956555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=haI88HCttPlaimE5g5HZVq6U+tyuHSX3H7yH1gCwk+c=;
        b=iBuyX0jXWEXlp9QDPu54VNTPSk3gEuraCsz3lKSexjwDBZ6W+xXomM/KPaGTqmUV2e
         L+OuTDW49mVmPSZ9bPBeBEMm9iOSaXoJcCeDYCpR5FxddVU7+46co6tlgqq6h2WCZMm9
         xJZcHNjUX/AzS7M8CjWhlx20aZfUDUkkz3PFD4sIMN5ea1agBTCE3slhJVodxbp+rixZ
         K721arCFRpZzycL8TYjD80Keasacad9W871CHQf8ggpzTWTYm7ZbKZuRHyntcD2HGVfP
         AESVWwHyVo14xuwJxQlhFXuNqeysf7g4lH7ZJml8BYN2msorILps+kk9egUZZLTAxJ/7
         sEiw==
X-Forwarded-Encrypted: i=1; AJvYcCXKrtxTJ4EIVj1Pr7UhfOYNGvpLMHAAb+LIVK9ITHwhZqU3QYPCGLaBdAkuvZR0ZrpBxgqxwFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo3A0nWGmH5vuKnVjuxm5G0BcLV6N2ccmeUetAKzo6MSZBZDvh
	g43pTqIgCoM2Q4HFmplyq224TKAtADCV7TlnLgGf9c5IridO0xKusXrhIpxzS/I+Md5Y83j5aOk
	ESWpFc8r7gENDWlOPjka63entEzMpm1D1JShr0L062bJ7YPiXutYYFe2LnEM=
X-Gm-Gg: ASbGnct6rfuU/tCxS478jeEw54BhUN0+J2ThikcC7heTxo9yaBBrJ7GFzllj0CKv5h7
	hQ29U5nks+bRsamqwR1Ig3I47ycVrX9WAs6moN+jdG6bgUyfzUgnYWyRk/ynuO5Lh9sd0iJrDAW
	9ttokmH4OqZRBN9qY/koGvSiNmPCEtDLXjSleKA3EZshR9vO6ODdFs33JprNyxwqVRY0qtsY18l
	6QXx2tkr4FDVs7VFU+w7E5j8GYGUwFyTLu1RDSIhgcQVMh2MVEohbJ2cUdMx2JxLKfdG/T3DxLD
	x5+hu6/KN3rbjfuMs5SgIN9HIy+wJP8LASTKxUhp1izaFakyOCs6qXHBEgAht7OJ+Q==
X-Received: by 2002:ad4:5ecf:0:b0:6e8:fd2b:1801 with SMTP id 6a1803df08f44-6fa9cfea442mr81664886d6.2.1748351755260;
        Tue, 27 May 2025 06:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyBKkeXUxc/NTG8gSl5izgYWO1GVIxceH278WuDF/J5QwQZVTgHu/6Sllwpaohx59JNw9hoQ==
X-Received: by 2002:ad4:5ecf:0:b0:6e8:fd2b:1801 with SMTP id 6a1803df08f44-6fa9cfea442mr81664516d6.2.1748351754721;
        Tue, 27 May 2025 06:15:54 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8888dc22fsm155534966b.101.2025.05.27.06.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 06:15:54 -0700 (PDT)
Message-ID: <061032a4-5774-482e-ba2e-96c3c81c0e3a@oss.qualcomm.com>
Date: Tue, 27 May 2025 15:15:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: net: qca,ar803x: Add IPQ5018 Internal GE
 PHY support
To: Andrew Lunn <andrew@lunn.ch>,
        George Moussalem <george.moussalem@outlook.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Heiner Kallweit
 <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
References: <20250525-ipq5018-ge-phy-v1-0-ddab8854e253@outlook.com>
 <20250525-ipq5018-ge-phy-v1-1-ddab8854e253@outlook.com>
 <aa3b2d08-f2aa-4349-9d22-905bbe12f673@kernel.org>
 <DS7PR19MB888328937A1954DF856C150B9D65A@DS7PR19MB8883.namprd19.prod.outlook.com>
 <9e00f85e-c000-40c8-b1b3-4ac085e5b9d1@kernel.org>
 <df414979-bdd2-41dc-b78b-b76395d5aa35@oss.qualcomm.com>
 <DS7PR19MB88834D9D5ADB9351E40EBE5A9D64A@DS7PR19MB8883.namprd19.prod.outlook.com>
 <82484d59-df1c-4d0a-b626-2320d4f63c7e@oss.qualcomm.com>
 <DS7PR19MB88838F05ADDD3BDF9B08076C9D64A@DS7PR19MB8883.namprd19.prod.outlook.com>
 <0c57cff8-c730-49cd-b056-ce8fd17c5253@lunn.ch>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <0c57cff8-c730-49cd-b056-ce8fd17c5253@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GIgIEvNK c=1 sm=1 tr=0 ts=6835bb0c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=c7V_mG7Cw8Ydp4GSWmcA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: pI9ozFZWoVEkiyTyCflmo25rQ9oFCQq9
X-Proofpoint-GUID: pI9ozFZWoVEkiyTyCflmo25rQ9oFCQq9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwNyBTYWx0ZWRfX3VNJJIrvtVmN
 2hINH9dTg0/9x7deJGRPe1fnL3y874ev9ep5uBp/lZbHgwDTK78rdH5KsE8n9CGII1Nm9C0Y+yI
 x0HCaURTAmx85OBOlsEFYpgnMav2iQdnF+qsSV3Kia7dOjX3rU8u9DGjisj+NeQI76wxAb/kwTT
 uSx3b918EDEKBnFYGi/iO7JwSsDSRsB4aIZMoC/MQio5GGHqjgnPqcCSrWfzHgIn2cXt+Ilw3/+
 N1tJQhOqbbfuGenLbWxPjrApuKOWRCsGD1Cg0x5c+fEQ+TP5tdcElA1BmXoUvMKFFTBJOkZJH+5
 cAmLo1VOpnEU1WA+VHq0EYETYyLSgYeigWT9Oabh7mYUzloT7NznYll2zS4HF2Y6jW68sbHtzK7
 J/yesrt0gr0pOwFsqssoj7zmK2w7azSC/2nukeMXRkuYPwu/rsTJ7gU4DqHt88NVhyjsmdkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=915 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270107

On 5/27/25 3:08 PM, Andrew Lunn wrote:
>>>>>>> Would qcom,phy-to-phy-dac (boolean) do?
>>>>>>
>>>>>> Seems fine to me.
>>>>>
>>>>> Can the driver instead check for a phy reference?
>>>>
>>>> Do you mean using the existing phy-handle DT property or create a new DT property called 'qcom,phy-reference'? Either way, can add it for v2.
>>>
>>> I'm not sure how this is all wired up. Do you have an example of a DT
>>> with both configurations you described in your reply to Andrew?
> 
> When a SoC interface is connected to a switch, the SoC interface has
> no real knowledge it is actually connected to a switch. All it knows
> is it has a link peer, and it does not know if that peer is 1cm away
> or 100m. It does nothing different.
> 
> The switch has a phandle to the SoC interface, so it knows a bit more,
> but it would be a bit around about for the SoC interface to search the
> whole device tree to see if there is a switch with a phandle pointing
> to it. So for me, a bool property indicating a short 'cable' is the
> better solution.

OK

does this sound like a generic enough problem to contemplate something
common, or should we go with something like qcom,dac-preset-short-cable

Konrad

