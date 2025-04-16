Return-Path: <netdev+bounces-183417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEF4A909C7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9562717A176
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDE4218AA2;
	Wed, 16 Apr 2025 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iOeyzVlD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46321578E
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823751; cv=none; b=N5NK5fRHFnqMV+eMyJZfTdpMeSAFo4ouJ40TdoFexIG0Kf2TgvZ/jbX5IRz0KiSz6rvLeHe51nFPhCnyw5J8EfAxw6TpNm97R9LOfvootQl79umMvRcvX7SRpAWWFSLR7AHrnmMIlgydgqjji9X5JdyBfSOFqd9ND5EPuNq3438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823751; c=relaxed/simple;
	bh=5n9q+jDVXeVFEdEbJ0tXuTTyfEjCGO9UYQmYYl4r9+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BL8jLwPx9XG1wC7rL4oVHkA0R4dkaU0+7j0MYzJXUrY9fGuSgwOOt5bk5f+/6FUblYps/J34AGY8hQm4TkMl84ZkXBiZfVThbo3I4JUQcdhXN6IKd5QMBiycrARphhcYhkpa3FGHdsHZ8qQA1GX4UWVrgv5l7h0hlFkRGH1jTrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iOeyzVlD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9mVTN030729
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 17:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e0HDqWKSEaSVFzLNJpEAQuoZw2add1iIeKNzjgvvBAA=; b=iOeyzVlDP04Cxpqi
	di4DNlmHXbgQmTtHECTzG2j601OFNgneEjrEt2QnGSb375GSXmP8Ct/ODYty6y+B
	i8UYUlxvjcz+AtKp1J8lhsY3LEUS8cnUeZ5jl8694s3wgh6r3eRczwjcdf34TRDc
	+QsqMfePYty1CNh5teJZloChUAXli3tmQDsKDBnZaVBqVLF3nZ6FnfylbQy3CWGs
	kWWsRf58Fbe1EReEjsWpQQT+odfC0hKMng3M2Q0bl1f409Nu5Y/szwCMQNicrFWy
	yFAAZcPojByN/DtouH9lmDic9I2qSgYcOVMCGhCcArtYZTw7bY7GhbW755GrTJN1
	gaN0lQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxk45d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 17:15:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso9408131a91.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744823746; x=1745428546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e0HDqWKSEaSVFzLNJpEAQuoZw2add1iIeKNzjgvvBAA=;
        b=lIvSQR8mvqexjNrtOTOGDC0xCsDximSkFUHxEE9sBqDnLDbmAwzBQtU50Yk+7yqPAg
         tGZhdzTX0+MvNzr4GeGBB1FHFoL4ACGSYbhh1OaoB1GYKFJqhZQVOED7SGgckHeip0om
         hwEJJTHARAC466DBelNnWN7QFvtbDu7tEHaYEuUFdoMrQiNz5RFVcLuSb/1lU1qiv3bY
         y7amI51/vUb7uUCifyFWncbbdXNfIrpus8lcoWTzY3phKYOJsbPWnRjo+NmFZFazc1aq
         HBIqGkBwEmS/1E2/9weZYOmGXFDXSHjLJ145N13n4S2MlIAj7cCnsGgAN8nJZjouofqV
         Wa+g==
X-Forwarded-Encrypted: i=1; AJvYcCX3p9iwJbP8sRnYoF0+CJtwCb5+9ePwWm7WWLgCEVL6+JnBSu7XmrPAUPooEIDlB94AN9swEGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6pmx0soB5z1+Hb4veqQhdxC7oeR21OVgykyu9uaUm+WkSPe43
	h+5bPSMUbgHpxBcK9UPyyLaNo2EuMCl/6vDLtepQF17USyCMKfs43jhH85oYG5hsU8YKIS1TS+U
	ZvDAy2Aw3V4nOoZxJY5lV8nxgTrKQUVtuN9XoABa61cZ0v0wi6pysDEA=
X-Gm-Gg: ASbGncs1pj/p/zAXGxz8QpkVEHbZoKD6b0aPGuk0bj1pSaqYyZdEAz0dOV2ut/Aj9gZ
	bXMa5kYDysXCiH/vL/7Pqiw+sE6JK1+oVHEPOFcU+XZtj9Rj4t2MUPOhBJcr4eSqBamG3L2JcAM
	dAOr+ztrFFJbPjVb9EEiNm2BwvLta4mntyZcR6aCSUDI3u5keuYVgv3hMjwWQEgKICksbMoZGgN
	FKNq3Xus1yhDCsqziy4ebgOohBhnM70HDtdImazrz2KC7aT2PItY8km1QwfWesuI5CBwocmS3Jx
	ZlAiY+xzb5JQJKQxCLB41eWj+DwlmBpOpFSR+/N1yX4=
X-Received: by 2002:a17:90b:2e10:b0:2ee:e945:5355 with SMTP id 98e67ed59e1d1-30863f30453mr3629941a91.19.1744823746225;
        Wed, 16 Apr 2025 10:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ+oEhRMigExapjc73NYBT0NIMgakTHtHCyVDLkQQFdNp46iFChZdyFGAahl4V/g/xcRH7gw==
X-Received: by 2002:a17:90b:2e10:b0:2ee:e945:5355 with SMTP id 98e67ed59e1d1-30863f30453mr3629906a91.19.1744823745816;
        Wed, 16 Apr 2025 10:15:45 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.231.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308612131dcsm1873067a91.26.2025.04.16.10.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 10:15:45 -0700 (PDT)
Message-ID: <1ad8986b-8e71-7b3a-83d2-1e95f41a5505@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 22:45:39 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] r8169: do not call rtl8169_down() twice on shutdown
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        netdev@vger.kernel.org
References: <20250415095335.506266-2-cassel@kernel.org>
 <4f8d3018-d7e5-47e5-b99d-550f8a4011ee@gmail.com> <Z_-7I26WVApG98Ej@ryzen>
 <276986c2-7dbe-33e5-3c11-ba8b2b2083a2@oss.qualcomm.com>
 <Z__U2O2xetryAK_E@ryzen>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <Z__U2O2xetryAK_E@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=67ffe5c4 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=ozAjUsZc/ya1UnB0O6+iCQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=MmT8YIna37DTTOXv-cAA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: PDr-wPNNPUOHtUBHhK08ektId9laBB3e
X-Proofpoint-ORIG-GUID: PDr-wPNNPUOHtUBHhK08ektId9laBB3e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=603 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160141



On 4/16/2025 9:33 PM, Niklas Cassel wrote:
> Hello Krishna Chaitanya,
> 
> On Wed, Apr 16, 2025 at 09:15:19PM +0530, Krishna Chaitanya Chundru wrote:
>> On 4/16/2025 7:43 PM, Niklas Cassel wrote:
>>>
>>> So perhaps we should hold off with this patch.
>>>
>> I disagree on this, it might be causing issue with net driver, but we
>> might face some other issues as explained above if we don't call
>> pci_stop_root_bus().
> 
> When I wrote hold off with this patch, I meant the patch in $subject,
> not your patch.
> 
oh sorry, I misunderstood it.
> 
> When it comes to your patch, I think that the commit log needs to explain
> why it is so special.
> 
> Because AFAICT, all other PCIe controller drivers call pci_stop_root_bus()
> in the .remove() callback, not in the .shutdown() callback.
> 
> Doing things differently from all other PCIe controller drivers is usually
> a red flag.
> 
I will update all the required details in the next version of that
patch.

- Krishna Chaitanya.
> 
> Kind regards,
> Niklas

