Return-Path: <netdev+bounces-219611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AACB424AB
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7DD7B96C1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BD131AF12;
	Wed,  3 Sep 2025 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e0kk9Cy1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1CE31A548
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912371; cv=none; b=RocBSCsAqgxlW9PbzvXJp6yS4NF6uJEuHCuZPi7S5OSeUQ7KiyV06YlO5blARo/ch2dsx1H1yIMBXTm0iS4LrEtXf+Vi8Xxq5GoI136LC5kV/qt2ICwalyIRkZgoZg7RAGTnlni/sYovPhXHfFuA0pX6zfhaAXYdzFCdj2devvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912371; c=relaxed/simple;
	bh=n1msrM78RrmCwzR/wFOD65VIQbeh+xShWMhrW5eoPaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJbmVDPBsq2fmN/clqH6BadX4j6kxeEH4jiYo0ajljZ/mk9YXk6zveylA0NKot5+9X4lAP1X/WN7jW4Af2WJ8iOBmEPm2uNtd7xlAzoF95VFuSHlN9zNNoYnhLcJWJkE+bHcb+7B2xYa0CSAkYDjNfUD3NHVfe6hHpUqYAMGFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e0kk9Cy1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DwsLu020921
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 15:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fDHXiLglUa/QyYoJPmDdpI/sOMRLT10GemiBFT4WmI8=; b=e0kk9Cy1Kgjy87OR
	CmQP4T7SJMlgWQEXa2WvhqBk8t4XDVEvFt/UNCU0eRR16gew04CdHOXQhJw4A23r
	qG+hiz5ab/fX1cLYGxDvzoKZ4rBSsdeDE0EKje45lko1JRtliLxU/RhwghByuff2
	p5CtJyvSQUt3Op5crij7TDrc8kZ55orTwLj2g3EszvL+z+SuFOsDGvO+9K4OVTWP
	0pdh5ySZ2uTmF5r4ZaJMn6RDJYLgNORl6C7a/6xz7Kp2Nlkvn8o6cxxSpPfXyxJ+
	djBtlQ0R/+rrlRKc6HvG1ape5SS26DKK+9iWdw6IIjdiG9QW/onof92OGSiQRmhX
	fZCisg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fm294-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 15:12:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b32dfb5c6fso36051cf.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 08:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912368; x=1757517168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDHXiLglUa/QyYoJPmDdpI/sOMRLT10GemiBFT4WmI8=;
        b=haVW70ExHvok1GTwrAx5OhJZZDaSdn6VVdDdG0HBEw/ofsfjFgRVJZRUbCHncLgmHy
         vPsiTQHUUpKk1tSJdXn5jx6yHX+rxsU7TUZiU+HubGJ+ca9+e5TUqFKz/RfYO/zb1I/r
         XMrKwF4qGWD2swx88Bc/UQ3xlmfi4Qa+XZC5cmGqNJAlyHhqm9NkCQqvF/ivrUbtdxdP
         ALH4BYEhaKkG4pPNsbZjicxcvXViAn19VXjcimEwfFDWnQVf7/nvUeUZLSj1OD2Zazgi
         p9zaAF2fYxxz1X0rW5oWbjXlDwvMmrt49ZMrtwurT85ipqwfqV7JoCIwgZAc2uJWnRsQ
         0mUw==
X-Forwarded-Encrypted: i=1; AJvYcCWxXYaXYcemZcanz7lezAJpN6u5z/C/dNfGSWQ8TPUeomApZ4J5jxz9YhSed8siZPVz4bIe3us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLHy7xiz09zZAUGG6gRrASDkUrMU4b4IEadGGlcO9e3J6BVccW
	J5wV8jmgYrN2h1kzvzF6qEsDObVpcfpvxmmfs4zhFGAreTCBt0U+ZMaChdG5SK7A0os3qC751ej
	KwF4UoxtciG5BziK/hJSWJGTj6hJGafoHL0UeeVde3Guseq/8JQ8vp7DLwi4=
X-Gm-Gg: ASbGncsL+RwEHddPqg+qcHNS20HfRBIaokVKhXVfGUAQRHoyIGO8AM64DbVExudp/fW
	ztkJYCFALPKd4rnhYbKPt7/k0e0p+XqcL+RoPK1+6k4jnuhBdd/whinbzpP3Bo7mO3Ic54kd6ax
	uatWYBti998CRgMaTwPHXll5bHI1m8uzo75e2LZxwJUBjm70fFbJ5XqU+rEu9gIfzmBAcn+bJUm
	ym4PNxMucusXcD75hhhoUyqIQDnp89HjQ6N1Gl7+9hZrTsoaLXgve7lojGVZURf+uMtmUKLbCXj
	9yjpduHL857bHQq9l7sk5Ut7FGTxASqNgGHFfFbPxsUaVPmGS8+4kzejh5S/+ms9rf5wQUljMw4
	oWEdHR85uC2FgLAcmvMOgHg==
X-Received: by 2002:a05:622a:15d4:b0:4b2:d8e5:b6e3 with SMTP id d75a77b69052e-4b313dfd74dmr148011781cf.1.1756912367508;
        Wed, 03 Sep 2025 08:12:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzte+bUX+mh/3ESDHWcOoXsvbBjuH86iwHqbD4v2SrOyFveDmmMuPlRhiIPoNeSHvIGkac6w==
X-Received: by 2002:a05:622a:15d4:b0:4b2:d8e5:b6e3 with SMTP id d75a77b69052e-4b313dfd74dmr148011451cf.1.1756912366819;
        Wed, 03 Sep 2025 08:12:46 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046af12536sm165557966b.100.2025.09.03.08.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 08:12:46 -0700 (PDT)
Message-ID: <c7b87a26-2529-4306-86b3-0b62805f0a2a@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 17:12:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] arm64: dts: qcom: lemans-evk: Add nvmem-layout
 for EEPROM
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
 <39c258b4-cd1f-4fc7-a871-7d2298389bf8@oss.qualcomm.com>
 <aLhMkp+QRIKlgYMx@hu-wasimn-hyd.qualcomm.com>
 <aLhZ8VpI4/fzo9h8@hu-wasimn-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aLhZ8VpI4/fzo9h8@hu-wasimn-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfXzW/w//buV6tO
 FWfC3nbC2cCKCPKhACtzBDMdE2z3I1ikE5nd46xfyT4dyt3cx8xBOlqc7a6JliVWXMDe/vX8GYk
 GkXJacngn3BxeFnyz9cEw6b+ouPbIpt2Y39YGoMeNRpVWZ7h19VIPx3DTSP7s8J5A5wFlING7A1
 ue4Q+i1UgM7KecNlMWvW30LQ3LlcANSiph7uJaVEgAGz6TG8nbUaptXUbc0mkhFIFRndnNUvJU+
 Yq3VsH5Dolqr37N4ylbLfGG1ApKxWpApMfbT3j5kUHyHcNJPKH3BkutvUR2ncy+FvkekfKx3Oa6
 dos3UZKElJcPDXRyhf/GpiljwpRue64jq6t6NAP2ENuOoclUGsh/Q3Rm6HmBwnQ92Yp+rj9/5MI
 K8IJbDbo
X-Proofpoint-ORIG-GUID: ZO_JtLKB9FYioz9h2qYejFBCJWaOyFuT
X-Proofpoint-GUID: ZO_JtLKB9FYioz9h2qYejFBCJWaOyFuT
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b85af1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=ur_XN-hxGOuNM8kuFtUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On 9/3/25 5:08 PM, Wasim Nazir wrote:
> On Wed, Sep 03, 2025 at 07:41:30PM +0530, Wasim Nazir wrote:
>> On Wed, Sep 03, 2025 at 02:29:11PM +0200, Konrad Dybcio wrote:
>>> On 9/3/25 1:47 PM, Wasim Nazir wrote:
>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
>>>>
>>>> Define the nvmem layout on the EEPROM connected via I2C to enable
>>>> structured storage and access to board-specific configuration data,
>>>> such as MAC addresses for Ethernet.
>>>
>>> The commit subject should emphasize the introduction of the EEPROM
>>> itself, with the layout being a minor detail, yet the description of
>>> its use which you provided is important and welcome
>>>
>>
>> Thanks, Konrad, for pointing this out. I’ll update it in the next
>> series.
> 
> Moreover, I notice that compatible definition is missing for this
> EEPROM. I will add it in next series.

I think the pattern match in at24.yaml should catch it

Konrad

