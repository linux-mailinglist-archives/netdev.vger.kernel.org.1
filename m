Return-Path: <netdev+bounces-222492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFDEB54777
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A861CC5379
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574A92D0C6F;
	Fri, 12 Sep 2025 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="psmAV4uh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C552D0C8B
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668923; cv=none; b=biMmgxEDUWvipJ8ZHsNKRYukfqNqv+X4IS2VU1jEkqhKJsY1osArQ+D68rbnX83AXFe8NTmCVhdMZcU+ef5RQAYLG+aJgj7BjQXy657lMddPh6KYybINcgqr2k9ptW84vjFX4zbk8OFfqEoCsnbgXmcVhWbSh+tWtUdKhXLN5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668923; c=relaxed/simple;
	bh=A1c0vcXgcruE0vFqM/raPLs69yF0uaISuMGxTvyDAyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntvzNWVRL/dKyCZFQJsPhYa/6ejw2RqITUz33a0vdI27T+wjXIGZ1Hu0Kb6+dk1n+h68YNZ/UvleZ4CibG+Tp4cskp0dJCGQT/NQic7g9doUGhCs01qZ0LA2ktO1wXfRlxSdxgvG6QLjS7KAzUCyGM8qRyI9li02Vaxocfc21Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=psmAV4uh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C7TQdu009306
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	211TaafuVdmwmFpTWX2T7r+JSbXlFt0Mtw+hMPa5lqU=; b=psmAV4uhJDui1mD2
	TpCjvU8MQQJRkxDuw3yqKkng4nptAa5x/7xUSHj6EX1X6oUbpT8FF28zsrmre7yu
	6p/Fp2rav/iYRUYCqDi++eNdmU0cYLSY3LSWJ+tX3FS0MmKDSL8p4IePtThsrg/z
	Ac7+4k4XpROaSNMzt9ybKtn3X8B783KyfS5kAUKtMZPEDpMpPdotPDoiRuFREgPa
	pg9//ykOut1X5Rjq7PwNqZFRjrYipChc66NfW+GoX/UZm+8We35j13Jt+hH62Gtl
	F6u0m5V5mD8j29L+7+62Pb1B5wvt2owSxXuoK0JQQiSo9icMMzJ7VUQ0QyT0iZD5
	YEREwA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapu82d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:22:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b77ed74e90so847171cf.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 02:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668919; x=1758273719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=211TaafuVdmwmFpTWX2T7r+JSbXlFt0Mtw+hMPa5lqU=;
        b=VO3a6BvHppN2PzIgd1abzUxc41WBlNHI6fH/ZJrkWsDyjcOrh3YX3Ai2QfNPa5rsWw
         16Snf+RicmgzVhe9cqvQqnHqrfk0jqAmmiWxdFrQEuO4rBFduK013JcFG3jkWKBfD15q
         X+cTdNYi5Pw5JFlJcmHUikRR7Y+ga4g7Nt5YQSr5Abwh0lTd8JZqLJ0FW5Ls3czEyC82
         QwR0iH19/dXYwSz5hftun127SPRAAebhpdw1MOkqW27jb6Xc6lbbQaljs71RHOS9yZ8X
         8fCcXe1qf97/AVCD/sC2wln/Gdd9MDWh/5WPHyVPudijB7i3aYAR9ifYerh4lEzieThN
         z8rQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3SmCideLFI3RW0L5OTlfrWP1rei6au9AHB0PgQbBqiGNBZu5sFErN8KseTmMkoM9E9F0Sems=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54vE9my5ZlS90RCNGnplC/Hi9H24AGStAyHm4jgkpSQMKqiQ9
	U6suUDH2si2mQEtoDT7nPsR48Ol8hUd+NTto1jbeArCGaKYyqAkgbi5IuWbfHggraMUnSQd5WdU
	8iQY9fcqJkH0/CBLvSHiJDGH8xDFnHMcYkSMuNPVJtlTeJsxBzsayJh+pQFw=
X-Gm-Gg: ASbGnctW4Uy6jskR9SIgeNfXILwO4aTRlPVdJXl4PiX75Fok8Iwe1uXvGXO8fBxNYUw
	pet13eP/Bbcj6WghL9W9FXOfrCnFCKHMHm9RDA2i7VPcZFjDNOJqKnSA8fNPOfeyOpBvIE0CrcY
	jTwTKdpRniAQP5Q8NRKn084Pu2CadI59b5jrouaDKEv4/AeZRgGW85n6nQ7OsgnpXfl7OmjcSsg
	qMNL8NvM2xTJVgCxfwQQQpzbexzReZEJQ3qYjoDdAyXugAwaU+ItSPbpbEvOaDez2U29UAmI2Mp
	WIbjfjBi/55UXiOXVCuqn+Hqyp/pxa4vBjXFDdFf/YUeqRo6qW7mB1IQF6bEPrcoT0j+hQ6W2Ae
	LnxNRWk7tBcTJ0fj8FYBesg==
X-Received: by 2002:a05:622a:91:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b77cfcdec6mr20253941cf.2.1757668919113;
        Fri, 12 Sep 2025 02:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt3j5cbbw2xXdC7Iuoclxovs03WKjCh8mVblR4EhINwYFg0atoGoM3n750wMhgvxAjL7lHSQ==
X-Received: by 2002:a05:622a:91:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b77cfcdec6mr20253621cf.2.1757668918594;
        Fri, 12 Sep 2025 02:21:58 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f2098sm337290866b.74.2025.09.12.02.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:21:58 -0700 (PDT)
Message-ID: <d293a11b-155d-45d3-bafc-00c2f90e8c43@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 11:21:55 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <52714c33-5bd7-4ca5-bf1d-c89318c77746@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c3e638 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=UDPjpuflI1CVcGcpNKsA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 1dO0M9b6QF9X0suYpVQUEppnZdvJNry4
X-Proofpoint-ORIG-GUID: 1dO0M9b6QF9X0suYpVQUEppnZdvJNry4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX3bsUNusuF8Jn
 5idiBKokMwKbgvd+mtSXVtZlUO3CyHDso2ZvkbRwXyu2hLgM2Vb77tSV9LrFnf1ZoUvOFUmc8lH
 ujXrcjsMIxiyxlOy8rOhoYgpGjMa3Oe6xC/tyfcFi7HrMghjhsoR8e/IzFXAuEZcATEPpojTqLT
 4WvMGJINN3bqeLeQ2hi13PX81ajPXn59DyEz93PEPQaRYEql3QynunNBB//81guHMiwCBN1zDtN
 aOaOjimQ6szFQ/AoszWmgSsdeHyF8c39+4tbuN34A1AdlQGT5/lSdp9YxcMBFGFvVPiykDK3fu5
 Yr9vtCYKHZtKBv6Z+L5HjiggfaPTVNY5oDqotAL4gwoCSjmwMB8rfYEk19WqOuXy74RxiQYy651
 XEo8pwiv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

On 9/12/25 11:17 AM, Krzysztof Kozlowski wrote:
> On 12/09/2025 11:13, Konrad Dybcio wrote:
>> On 9/12/25 11:13 AM, Konrad Dybcio wrote:
>>> On 9/12/25 9:04 AM, Krzysztof Kozlowski wrote:
>>>> On Tue, Sep 09, 2025 at 09:39:11PM +0800, Luo Jie wrote:
>>>>> The Networking Subsystem (NSS) clock controller acts as both a clock
>>>>> provider and an interconnect provider. The #interconnect-cells property
>>>>> is mandatory in the Device Tree Source (DTS) to ensure that client
>>>>> drivers, such as the PPE driver, can correctly acquire ICC clocks from
>>>>> the NSS ICC provider.
>>>>>
>>>>> Although this property is already present in the NSS CC node of the DTS
>>>>> for CMN PLL for IPQ9574 SoC which is currently supported, it was previously
>>>>> omitted from the list of required properties in the bindings documentation.
>>>>> Adding this as a required property is not expected to break the ABI for
>>>>> currently supported SoC.
>>>>>
>>>>> Marking #interconnect-cells as required to comply with Device Tree (DT)
>>>>> binding requirements for interconnect providers.
>>>>
>>>> DT bindings do not require interconnect-cells, so that's not a correct
>>>> reason. Drop them from required properties.
>>>
>>> "Mark #interconnect-cells as required to allow consuming the provided
>>> interconnect endpoints"?
>>
>> "which are in turn necessary for the SoC to function"
> 
> If this never worked and code was buggy, never booted, was sent
> incomplete and in junk state, then sure. Say like that. :)
> 
> But I have a feeling code was working okayish...

If Linux is unaware of resources, it can't turn them off/on, so it was
only working courtesy of the previous boot stages messing with them.

Konrad

