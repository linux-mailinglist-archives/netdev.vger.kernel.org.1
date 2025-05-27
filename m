Return-Path: <netdev+bounces-193657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4254AC5018
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4561888B16
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E08A2749E5;
	Tue, 27 May 2025 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oz/1jUbP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126925C71D
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353291; cv=none; b=QSiwcrtbu9YFQqr1+kv5yeg53CxY5Wm8E6XTSUyrk2X1Bw0hCRj/YVGHmiSIlP8v/ju3AFrka1ZUf3Hf2tc2kTC03n4WUc59u1lP/Wsbzfp/Xv5/btK1uZQ3P3Q5SJQFENpJnIeqKByFnf2q6zhH/g5eKwFvLh1qTJh+D8DV3Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353291; c=relaxed/simple;
	bh=eqrnG1lZLmsW/y+K5POXZAg471BAsSXO8VWTa+x9WEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEOPDlKd0KIx8i6T6EJo7F5tpaJcxWprFSpwNs0Y3gMhhN8ON3AOQfHHX2xwneP5OtlyMj7rUN4Zf2Ns1GRM+198nKILBTGRwifgRV8z/HSRfve3gfFMLUzWAu/QJ6do8448VXBt09X0LyQSJPROvSgEdUKaAw6K5/n9ZPXXZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oz/1jUbP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RB0TQZ010930
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ERfDT1p+bjimwu7UE0keI/XkAbZ8gsveAmakce5jzjU=; b=oz/1jUbPk71hvr8K
	SFvCeOgzjdmvLzpWF5DGRXrCI1Wkf1QkebuvBPown1H0wI+2+Z5vwPCtDRKgODh1
	ZDLNmWMe4rLs73oNP0yjjNtXe2tHECwOkY4Xhv2RqKfQY1drp7LDeyBYatYjrx/U
	UOJwmJBz+iPqAK62OARQnW8VgLTuamI/Hc0UcgusEKB08yGbZ9fPBZ/QBZ+yjRLY
	IFc7SCPJjoHY0ibauyYXqvlMuubxE1jYgOQjv2MZcdilvYyXCfKnEDU1T6104lqF
	PEBte9UI/YyLHAftW17MAmMHXA4PBQlFcQL7Gj2Ir9I42yW1hl4HLWmTtHk7IOvt
	Ms45hQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u549f1a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:41:28 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6faa8342503so3621796d6.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 06:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353287; x=1748958087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERfDT1p+bjimwu7UE0keI/XkAbZ8gsveAmakce5jzjU=;
        b=AaGISiWHslBO3yw44m49YS4glS84YN7hHTFHPRrNazqkUvLQS4zoFPsvh/aP7B8gyk
         0F7aub5juqs+GUVp3wdmU3hQCGSQlQ2wM9ESK7YRGP0P6emug9D7VGurhG2NeDg+WPXE
         bLVpfJxhHdDR6/62Q0rrvXAgYUKumv8xi00ry132/oM5VIXDYB1FGQTYTpU5ByfjH7Dt
         WF8/JIlYJPnMU9H3Xci110hyygszr1CSWzQ3g8pT/0Aoc7mpELizSNDfvErP3sbY1Ten
         CXjNVQ1YlavyGFh6d+A88aIeAl/EaqjJ5arRXCGMV6FZ1JhK88tKj58XhbrZ+YcNRFMr
         CJ/w==
X-Forwarded-Encrypted: i=1; AJvYcCUvjydqMFmoQPSlp1TwWyaPpX2RZ2IDOFwTCs1yU6knJX6ZdelC7ht28wwCJwtFOPCYrFMWP6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5zxKO10LkCh9ka0OZu3Hyb3WaUOOri6c6m/iawsO3E6Xqy+w
	X1uA9maCJWekL2hw64JYxb0zu5MMiAvsNuCbBHOITa72aaqzzuVhByYHaxDZAf5966MctMQJjv9
	t/dCFef7UK77w2IBF0dCHGgc0f9fE7VoFSvGSy6KfRDTeSAkEsuJ8NLbkyT3Vt3V++f0=
X-Gm-Gg: ASbGncvxbfrXL2pNes4qPGrJzTq7yfkVTxKtIB+OoNtdHqUn1Gwofh6FBRl0Uu35Qvr
	jit3zanvcI/kt5IqJ9yuTEDmpgRFHRtzZWNNnbgdWqR45akOH1JBHeyb8SrY7EIhDLTAwDo+iCS
	Dlz7SFZuzF7LzjeKaUJwoDkEInA3KTQVznB37RTSaFfXi6BykdSiHd3v+mhw1AjXhnjU6vZhdoC
	KCu0sR6iO5U4Iyo2gtZtRxpff+OGI/VLGmtVl+Sp9y0sku13VWwfxIgviF/aTeRFGJz7usEdewg
	8nXXVWTf/tFQ7EYYQIUlOjW6dkgtouyrBoxZaXBrw2mE0E10wzv081g7gxcVzNxdpw==
X-Received: by 2002:a05:6214:f2c:b0:6f5:4259:297c with SMTP id 6a1803df08f44-6fa9d322aadmr73791416d6.7.1748353287154;
        Tue, 27 May 2025 06:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjqXPi+7vAd88Ft7f9PnA4rmMxmVtVhyeYRYjMeWxtVj3a4v2wV20uTm0Pohz8zd9qMGjP5Q==
X-Received: by 2002:a05:6214:f2c:b0:6f5:4259:297c with SMTP id 6a1803df08f44-6fa9d322aadmr73791086d6.7.1748353286612;
        Tue, 27 May 2025 06:41:26 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60306f0e39esm4940959a12.33.2025.05.27.06.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 06:41:26 -0700 (PDT)
Message-ID: <62380db5-5f01-4652-85a3-4dd213deba5c@oss.qualcomm.com>
Date: Tue, 27 May 2025 15:41:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: qcom,ipa: document qcm2290
 compatible
To: =?UTF-8?Q?Wojciech_Sle=C5=84ska?= <wojciech.slenska@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20241220073540.37631-1-wojciech.slenska@gmail.com>
 <20241220073540.37631-2-wojciech.slenska@gmail.com>
 <5bba973b-73fd-4e54-a7c9-6166ab7ed1f0@kernel.org>
 <939f55e9-3626-4643-ab3b-53557d1dc5a9@oss.qualcomm.com>
 <CAMYPSMr2JCQCX69PGUk1=7=-YfBcyFDpqQ6tMQzFP040srBA7w@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMYPSMr2JCQCX69PGUk1=7=-YfBcyFDpqQ6tMQzFP040srBA7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: u73acR6ZJEr3yCpXpb_Eq2Czqp5JCMPq
X-Authority-Analysis: v=2.4 cv=E9nNpbdl c=1 sm=1 tr=0 ts=6835c108 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=Mi87qWPe0p8fJGbmGX4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDExMSBTYWx0ZWRfXzzsSP+AGbh6i
 v097vL8GnGi46+05yBAEF5tgz16/RrqGQ0G6+BT+hq3NQEoqdwKh2lR46iHHEshqKib3noM0Utd
 Z60xgyn2+YBx22hX9b7OZZ4ngEvs00NWcS3n2UxURDw8ZUXPo0OEEvlKETOdxP7H8PXCWxxpSl/
 7xtcsCbWrfIeiOxlPR7rGh7wABdKcrLeMHC1FvFNtjUBBjXxZrhKEdo2mfFY0bMrHFRJIZHNjJX
 AiMm6tC4ZfvU2dxtnjlX3r5uuRoudJauCbIXqKZTgUslRpTvIQNb1bJLsbdsCuPGdqPZxlQD8iF
 K0P20dtknohLCqaQc+iFyOajmI8RSHGT+uMGalJEwNJlI4YL2HkdrO8h00y8uiaGmWNJueF23bN
 TMQpbISsEjqrnK4KMRraZdTrEKmLbAcmF/DZ0mj3kxLRdl03GqKsjuIOrSXS/w/1q3GZ3V2a
X-Proofpoint-ORIG-GUID: u73acR6ZJEr3yCpXpb_Eq2Czqp5JCMPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270111

On 5/26/25 9:39 PM, Wojciech Sleńska wrote:
> pt., 23 maj 2025 o 01:30 Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> napisał(a):
>>
>> On 12/21/24 9:44 PM, Krzysztof Kozlowski wrote:
>>> On 20/12/2024 08:35, Wojciech Slenska wrote:
>>>> Document that ipa on qcm2290 uses version 4.2, the same
>>>> as sc7180.
>>>>
>>>> Signed-off-by: Wojciech Slenska <wojciech.slenska@gmail.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/net/qcom,ipa.yaml | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
>>>> index 53cae71d9957..ea44d02d1e5c 100644
>>>> --- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
>>>> @@ -58,6 +58,10 @@ properties:
>>>>            - enum:
>>>>                - qcom,sm8650-ipa
>>>>            - const: qcom,sm8550-ipa
>>>> +      - items:
>>>> +          - enum:
>>>> +              - qcom,qcm2290-ipa
>>>> +          - const: qcom,sc7180-ipa
>>>>
>>> We usually keep such lists between each other ordered by fallback, so
>>> this should go before sm8550-fallback-list.
>>>
>>> With that change:
>>>
>>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> (half a year later)
>>
>> I've now sent a series that resolves the issue described in the
>> other branch of this thread. Feel free to pick up this binding
>> Krzysztof/Rob/Kuba.
>>
>>
>>
>> Patch 2 will need an update and some prerequisite changes.
>> Wojciech, you'll need:
>>
>> https://lore.kernel.org/linux-arm-msm/20250523-topic-ipa_imem-v1-0-b5d536291c7f@oss.qualcomm.com
>> https://lore.kernel.org/linux-arm-msm/20250523-topic-ipa_mem_dts-v1-0-f7aa94fac1ab@oss.qualcomm.com
>> https://github.com/quic-kdybcio/linux/commits/topic/ipa_qcm2290
>>
>> and a snippet like
>>
>> -----------o<-----------------------------------
>>                         qcom,smem-state-names = "ipa-clock-enabled-valid",
>>                                                 "ipa-clock-enabled";
>>
>> +                       sram = <&ipa_modem_tables>;
>> +
>>                         status = "disabled";
>> -----------o<-----------------------------------
>>
>> added to your DT change
>>
>> please let me know if it works with the above
>>
>> if you're not interested anymore or don't have the board on hand,
>> I can take up your patch, preserving your authorship ofc
>>
>> Konrad
> 
> Hello Konrad,
> 
> I have applied your patches on top of the 6.15 kernel.
> I used the following:
> Konrad Dybcio: arm64: dts: qcom: qcm2290: Explicitly describe the IPA IMEM slice
> Konrad Dybcio: dt-bindings: sram: qcom,imem: Document QCM2290 IMEM
> Konrad Dybcio: net: ipa: Grab IMEM slice base/size from DTS
> Konrad Dybcio: dt-bindings: net: qcom,ipa: Add sram property for
> describing IMEM slice
> Konrad Dybcio: dt-bindings: sram: qcom,imem: Allow modem-tables
> Konrad Dybcio: net: ipa: Make the SMEM item ID constant
> 
> Two corrections were needed:
> 1. A small change in the DTS:
> -                       reg = <0x0c100000 0x2a000>;
> -                       ranges = <0x0 0x0c100000 0x2a000>;
> +                       reg = <0 0x0c100000 0 0x2a000>;
> +                       ranges = <0 0 0x0c100000 0x2a000>;
> 
> This was necessary because, in the original version, the following line:
> ret = of_address_to_resource(ipa_slice_np, 0, res);
> returns -22

Ouch! thanks for noticing this and for all the testing

Konrad

