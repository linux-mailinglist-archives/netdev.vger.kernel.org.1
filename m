Return-Path: <netdev+bounces-193129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DAFAC295B
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 20:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D58757AC758
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 18:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72A29993E;
	Fri, 23 May 2025 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IMUOR2y9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23822541F
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024029; cv=none; b=P0UP9MduRjL2SqhUFcOJDeTZ8S7LCz3iTfyiiPGe9KVm2DIWjg3guqBXp5HjSNlgu/OeiEJIE3Dq/3yHT0HWKDyRxFAokC+ajB8pJEXeHA/am1A/GsbTNPfGIXrXvF0Gz1gXsP43gpml73Sl8oMUfhvwJrkAhF2kp8d0vDW03XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024029; c=relaxed/simple;
	bh=4Paog+YoKvP2+bQwGVWBOgtwOdz6A7hOVN1mgB+zfiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mN9m4mg5QTs5Y0yWMbay7jSU6iYMFx9dYi3pRu8eH8RsHAHT1fqplZmDNTt34LRU7Rv1+pron61ai2vq44GTmoprMkeimF6TxW+AbqgkF54UGlBl9s94UXAhSEtyLRVo+hDG90DoOWqzOi/n3cP3wZ9gwAg3yFFqPskfyQmBJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IMUOR2y9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NC29d8024826
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 18:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GxYGuWGE7teroSpXw9B8EXIpMo9GtkoYzPs+37tNI9I=; b=IMUOR2y9gMKhgXS6
	SlruDTVk9FfgokmM6AAGRhYO7FkmpGIDOKOiJCs1/cfuFrQ7b946pDPP1GbpxTzO
	nLA85WYwUlwJwWBEbHtqG5Lzb9ifzAb//7jYmi7nA60HXuUqUytc7BhcIs+/K8Xl
	a4VLjimqZiwNFY+okLh4oStNNtbzAkzRwfJjN8hiKH9F+iyQfQnMQP6AchO8qls6
	mUQQxlDc7iGaGEW+YGkz1WMW7FAiqagH1Or0WXhHkYeIq2k1P73o1qDmDmMpX6lW
	HMKT8Z4PX4mv77UMXNKMssUUkNEihsvrs1Ok1khkPX9ujeQMk53pZc9aCmDpobva
	T4P8Ng==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf52sby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 18:13:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6f2c8929757so204986d6.3
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 11:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748024019; x=1748628819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxYGuWGE7teroSpXw9B8EXIpMo9GtkoYzPs+37tNI9I=;
        b=pHqmdlS49+axZh6q/y2ThBC4nwBLkSfgDFmSBnFjjqe1/0ovyBbp+S0FmTQaqlXbMh
         pHaV1oEI2YuyRarfPtt4XOP3oGXkO0IFnwg+faLgAddG+7Uo0QcaWlPohM4xUi8tm6X7
         6yzi+h2sMEN97DjvHZY62QBr8wh1kx9EMSjDShrVoV05otqVeX/pifALS3Dzq0zmz2TV
         dbkTrpIxCIhhg6JaU3ZfGRSqJwYpgzzriUmAWgDZY037JYhd5qBzGvqsQ1GiLfnIcPvj
         u1qSQL35EZRFm0kwKUVy73MqUhi6Fe6TdBfArFA/mojtrmQGqsZK+YDs8x+QrKdYMa0f
         SIJA==
X-Forwarded-Encrypted: i=1; AJvYcCXDZWf6GdBxrWW9aNGXjeOFGZU1+glzER4xOr5tMjiyD0vMPzcjnrvvJyA2dVg3UrQ+VOK88VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlM3+hh09CkYwBhQw9l73xoTYobUxprZkp6tEn4rLtiCvAElr
	n5ebs2R8SMvCqdsMlvLx6vps/2U0+NsCiTVu8Ra24mPR0pf2vOVBM57EQht1rvfvAWZgrOdd8ul
	Aq39pRoZGLSOajKYfCsPMyyoeiRCum4/gSS6USCCrvo29deCraWVJHxshOfg=
X-Gm-Gg: ASbGnctZfszPxvpnht4ehbkyVmM1mrVvtiXzYUx4PMYcHYiJagyNrwDEuvUAkoZ1VwC
	KiKWVY5S1rotQMJqlffgn+VgKBWxUMZNPljCVhbQnTjU0auKnnOHnvS7jS7B/vYxqItobiaIGle
	7LCMDRgUw4YgcCteGy6KXjw+eb6h24cem793QG9fGosvuYSsoJbvJ43vGDOMFwRo5JIPitOGKxE
	oz6UrDQm2PqRS2fNySP1hTWElXwfU8HSA4GGQUi/fh3B45ebR6ZYWh7v04dSdAZzS/BGJ0YQAVt
	99fiSeFe4USR3bzAu/0siQwsn/1hUKyNZyqxxGSaNhWHF+ls9t7Xcd9JUt7Y8XkLhg==
X-Received: by 2002:a05:6214:5192:b0:6f8:e1d8:fa9c with SMTP id 6a1803df08f44-6fa9d2a6a1amr2331716d6.9.1748024019491;
        Fri, 23 May 2025 11:13:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv7GPWwXXj2LlrS9GHOVViHjRzQLINpDyj6uWz8zl7Oz/ZeHI6Gl4oFnbSRXMtGdcwoHLU9g==
X-Received: by 2002:a05:6214:5192:b0:6f8:e1d8:fa9c with SMTP id 6a1803df08f44-6fa9d2a6a1amr2331556d6.9.1748024019160;
        Fri, 23 May 2025 11:13:39 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-602c2080534sm391575a12.63.2025.05.23.11.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 11:13:38 -0700 (PDT)
Message-ID: <81093c19-a6f7-4653-9688-ca891fd2548b@oss.qualcomm.com>
Date: Fri, 23 May 2025 20:13:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: sram: qcom,imem: Allow modem-tables
To: Alex Elder <elder@ieee.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250523-topic-ipa_imem-v1-0-b5d536291c7f@oss.qualcomm.com>
 <20250523-topic-ipa_imem-v1-1-b5d536291c7f@oss.qualcomm.com>
 <7707b574-6fcf-487d-909a-d24874f9d686@ieee.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7707b574-6fcf-487d-909a-d24874f9d686@ieee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OkPN_nOjP6UGPqTTIdQhwqcZ1QTnGJTI
X-Proofpoint-ORIG-GUID: OkPN_nOjP6UGPqTTIdQhwqcZ1QTnGJTI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE2NiBTYWx0ZWRfX+elV904ZeFUp
 Zooj4k1/5JJuuTVZEmFjlWxxlzLsGXn1vkN/YqX+cQg68VurD1uKXvOZ/yGfc+saR1Fn6Wibds2
 aV6Jf4mfuuYdGIL8iCrG57H40zHE+AokbYxk6Glg7JXzxxuPkuJ0/H66dQC7XmxG4ZmaAFNUBwF
 93EbmkdiQht9K7jgAP4TRJayS57qRGUNZmQDOBCFo4COQyXfXWrHiHsScpFaxTO7NSAh9Po6OGm
 Bk1TX/pJ2RB6/CU2rHRBFv4mA48Tp78f3RyMAF6UqBkiuUz0/E4ZeuDtUB5fYrTMH57aQdKHIsj
 3a01PGfzD6AnSoTPpZiCgEL47WDeXdHFiNlPWrAVc9VgJN+z78iHdY4tDFdChQP+aPDuPxtzQkv
 eXL7fjufDTtKQz0AabERkXfRLMaEk3EjIlVgn8f5qPb6izddJ0snOlQ9hogt5ijonVOHfbsZ
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=6830bada cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=JUd7tuONK7MPmK3lb4kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=921 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230166

On 5/23/25 7:59 PM, Alex Elder wrote:
> On 5/22/25 6:08 PM, Konrad Dybcio wrote:
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
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> So this will just show up as a subnode of an sram@... node,
> the way "qcom,pil-reloc-info" does.  This is great.
> 
> Is it called "modem-tables" in internal documentation?  Or
> did you choose this ominous name?

Downstream. It's hard to find accurate information on this.

Konrad

