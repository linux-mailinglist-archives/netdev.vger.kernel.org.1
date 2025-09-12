Return-Path: <netdev+bounces-222475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E9DB54692
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD851BC1A6B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3D22765EA;
	Fri, 12 Sep 2025 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BKeLjFtb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8196275AFF
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668407; cv=none; b=shlzRg9YZHiLsP+2aL4u179Nlb6K0sU4/egCQS2rHSq+/4GLmqGFA8qrW6h5G4E30euN6zK1jyZd2Inr1cfyiZuEGurTPZe2IHMtFEMlZLm6J0hmGkUZNMzgnLqjI5luUYcz4Y2RmMHS2PxBirNXFJ3PjH5MpD9TOwWAhLwbKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668407; c=relaxed/simple;
	bh=Rds/Qy6B10X8PbjBsAn4at189CR6n8GputyaSbIHvLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbYc+IMt2+1cvNM60vXMengNA7uLWdWRSVWX+OyPaRbfy1r1+y5YbAZBVToEx8NBztHyt0sD5CzOo6RcXppnN/HHifPQ7wPp1HkDB6KoxHoDR9OHyFxcgwZ6PzPUsrIooeXT9npvHrKiLAzQG/bhIgVPGOg7rift4anGEwzgwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BKeLjFtb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C7Uhxb027351
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MDiPEDL++Yv4djZtWlpbz56GxaADR2O4WCwvyOpamYU=; b=BKeLjFtbduWu7Ive
	CbrRzBEaoBA1le6BT4DOqVACa8hsMxH9wluEwDjN9Ly9hefgGvqHBCnIAaG92Pbv
	ynWdyWss2Lb4K4dFfNk6lBGIA2q08QjPBbY7oqG2jJFMhRYqvB6/14MVSiVbOzIj
	YJCpAOZD59dMc26aS4cnR+X/p9WtoMw1TWPO6GAU3mLYd1iEGYCX0pDp2eVzdR2X
	WSHZaJkzXmtvh6dzFjYkZffQpgWxSVWzUnOzskDcFwrVIFNDACr9xgidnfVEJAma
	WYi5L2CdKJDhn7ysnaMC1qY8lCXwsvNB59bNfAj1bhRO+EOVBAI02NRbA9RPjjnd
	uxLnWA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493f6h5y67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:13:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b613a54072so6367021cf.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 02:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668404; x=1758273204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDiPEDL++Yv4djZtWlpbz56GxaADR2O4WCwvyOpamYU=;
        b=g1qhsk9vevLaMji0YGeL1/VA5y4CExxohvqzI/ijrri2vSB1Q0eWb/itbQsqigttwO
         RaQnp2X/EsL0xFYEsvaGUwfGCoXvx2eP6e/UwKNbMEKqM8mk77CF6QMxvGgY1xzMv6Wb
         V99j5tMztabzeGuMwSvU8aO/RABLmqRfbItPyZCZAu8WtlcyyPAatt/U9tQK2jjjphDh
         Rt/riMBbzBM9MikRW2wGiHjLq3AS0zMs43UHo//aRq2z598M+S290PGnRiD/shcS06UJ
         QU2+BKcP33P0zSO/Juury88wyMK0vHw4Xw9rLxEeLEbSyTpTzEnbZ9B66iTRYgZnd1Th
         77hw==
X-Forwarded-Encrypted: i=1; AJvYcCWzFXffzniaz/0IMxe6szssrmqekVqCsXR0AaVwD/Ejsrt3cQ1DSJoHLXfS/fmp50/B9OfShf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3AdRdQxa7Gn08IZQW79Dvf7s06gavJS5iwcmeoOGm5I6vtdAg
	Iaj5RPk1mK4+axLbBbKQ5LqwaspefB+5sDmPwiftILXlTuDOr4UQMRIhdzq8z2OloejqmRgiRs9
	HH0A0LV5Vgny7Rr2Z7UESy/8alcAzdYvzJkwzeaUlENkHoPj7TIhkbwHpMzY=
X-Gm-Gg: ASbGncufzvyTwclZJu5dNaXFfAJ+7mrmcWZZx/W8B/w6vKwjc4jpPNJIDnJkxkuEyrA
	/CsRnOIv+jcZK9j6dlvFtSESRcZnyqoqw4yhLX+arxAYIihrf3esga37aE/gbuZwnFjilGgMTXr
	84EjMzI/rjwymNyvZw0SkbXvRGoBpeAKhhWtXc+VKBmh9vQJ3oz1YO5aFoaDOqzTAlutLaGYA8b
	d6DE5uAfpAyMok327kPLjCI+7bhxBTHlazjUkzbSuxyojfhCu7v8KV9z5zJ4vW/3J6fK1OvX2A1
	5jhRniGA75G7CIRh8t+lvtUoHZ+BleHjR94CEWwUB8i542M5wSkyjyf1cthiEzZsfrTXnEO2BJN
	3pjmnFOt+BNDuQTckIkTuhw==
X-Received: by 2002:a05:622a:60f:b0:4b7:7be4:177f with SMTP id d75a77b69052e-4b77d117d96mr18898541cf.9.1757668403479;
        Fri, 12 Sep 2025 02:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLYpKy55N9vEYWMRWrsZVRaWYcZIKuUasFnYD9vP/tGHxW/XvgJ003K96eFQ0cx+Ci2827tA==
X-Received: by 2002:a05:622a:60f:b0:4b7:7be4:177f with SMTP id d75a77b69052e-4b77d117d96mr18898091cf.9.1757668402925;
        Fri, 12 Sep 2025 02:13:22 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c28f190fsm159416366b.39.2025.09.12.02.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:13:22 -0700 (PDT)
Message-ID: <b7487ab1-1abd-40ca-8392-fdf63fddaafc@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 11:13:18 +0200
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250912-nocturnal-horse-of-acumen-5b2cbd@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RjAWuJSFo_qoKKiVIhG_bnkocQsESTxR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDE3NyBTYWx0ZWRfX92wkND9uDn4c
 rZCyc42KgROeBxs/kVEDnlZSZVBe1XSwWDC8B/mQNElRFgi0m1fs9FQe+OqDB7Tbyu1OhtvyHQs
 C0fj1/92x4Cd93mC9kxPLaAYzSoMfNGH++jGMDhAnUMArNQwKiHrU3Q0RniXuAz3ouXTODIxSAQ
 1tFCjg5evttlYUoC7vX3IYaXCEtdWPGOghVAzyJlCGyJHmgiWIMlxcrUKPlZ5E+To7Fg7LfvpBU
 Jcnm3FDq414+c96iaH+0TNd/sM+Em57Psewndu8UR8YShbYm/1A4+sdhuW/puSC2zIPTnNxVWyj
 9YTMD08ouf6gFPCyP5oSMDTDD91nKy/HPYMFG7DnKhv7i30MusXwz7dnetkKf1MlzDZx2xkidyD
 +pjMj1cF
X-Authority-Analysis: v=2.4 cv=WPB/XmsR c=1 sm=1 tr=0 ts=68c3e435 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Q-zjNaZJJLQrxVh-NlMA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: RjAWuJSFo_qoKKiVIhG_bnkocQsESTxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100177

On 9/12/25 9:04 AM, Krzysztof Kozlowski wrote:
> On Tue, Sep 09, 2025 at 09:39:11PM +0800, Luo Jie wrote:
>> The Networking Subsystem (NSS) clock controller acts as both a clock
>> provider and an interconnect provider. The #interconnect-cells property
>> is mandatory in the Device Tree Source (DTS) to ensure that client
>> drivers, such as the PPE driver, can correctly acquire ICC clocks from
>> the NSS ICC provider.
>>
>> Although this property is already present in the NSS CC node of the DTS
>> for CMN PLL for IPQ9574 SoC which is currently supported, it was previously
>> omitted from the list of required properties in the bindings documentation.
>> Adding this as a required property is not expected to break the ABI for
>> currently supported SoC.
>>
>> Marking #interconnect-cells as required to comply with Device Tree (DT)
>> binding requirements for interconnect providers.
> 
> DT bindings do not require interconnect-cells, so that's not a correct
> reason. Drop them from required properties.

"Mark #interconnect-cells as required to allow consuming the provided
interconnect endpoints"?

Konrad

