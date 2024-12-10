Return-Path: <netdev+bounces-150430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFAA9EA38D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 01:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EEA1884475
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ADD10E5;
	Tue, 10 Dec 2024 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WQpVg4rx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B456B4A0C
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789930; cv=none; b=qSJIM6mlkVT0v/nR464fZk9kl6Erz7rokwL9ZfZ9tgHZJl64w3B4YTrZa3OyE83tRZKrTYjDViBjl/KP6Bsp+nFslnWkx6EYf+vwPneXL75TmZkMM1CFNC6eu1KMc15Z1fyfBmHxnnnRLxNtFBYxKig13GUnijCPOdb0lQ+2BcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789930; c=relaxed/simple;
	bh=1H2phImFTyW9ISDQ746penG8aAsZISWZcNw0B+ZFMCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLMw4zoltEbxjsLNv3khtMhjMuQsYm0mV3etFYZvrPYdF4VXpUf//ptH3wQKkxOo7Ydxw+bUP820jgi5N3Nrq5U98gnSNxGPhi+lm2+yO4tpnSlMO4S3u8WXDwQ+2ks6Tm+Hkkygxpr73V9p4lRncQmSe7I46wlj3Sfq40D7Q9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WQpVg4rx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HspJi023050
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YG/xDcjs51mxFp/VNvvbxUBGMceOCzz2LiPxmVK8L9g=; b=WQpVg4rxXOKH4Z3a
	tC/b1MEWPkP2OGs0taueYPB6bkoCnArrSAlxawEi/aZkTEnnWuGlSevpgooTiRjb
	raEXzIo51EJ8x5ZG4MXnjyfYoZdwD6Rhf1IU0TAeQyrDdzfm78aSkx+Hns0NRFbu
	fU7Zka7xoqfboNxb4rLt4majxKtXAFvb+8HC4BSBq5MLrh6MIVB1U3S2hksTcTlT
	AP//mscImvp5oFVfETsBgh3P84hDROPUnkMvKsLK0nFPNaD0NPFGBO5sJVLD34CO
	CO0ksZDcCP0QmFYQna99UkDJWWRRS7Kc0/YL02wj02ZfGCRHIcCdYzR9O8WjOC1e
	809KyA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43e5c7rswr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:18:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7289afa200aso433379b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 16:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733789926; x=1734394726;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YG/xDcjs51mxFp/VNvvbxUBGMceOCzz2LiPxmVK8L9g=;
        b=HP4exJ/Sc+/2XWAXt/S87Lpn3nSa3c+jqEiw5/UKfa4EX/dfwtsFalJzPUBZrlSdfq
         tUz+rCtWwym3g3k/BlKjbuItImZCebVDbrTfRLcMJxpFgMsO6zlrw4Ami8LAriNStftr
         k+ooeYO1CAkGHCCVXeP22UMKHuVgNhLnizibewB1vvwrUO6gF3+w6BjKJKN0GTL8ZQ/3
         6s/y1G02nAF7qp1eR9+vzNPPJokzPCsjtViLsXJhhZyGysqkcFCviZwxgbMYS/dWknmO
         xkD1Woj9jQDJmdJ1coq3gHTLPIZHOuO+JubB91h0HGGOiTMAHQW3gpm9Igr5i+MLkRDH
         HIgg==
X-Forwarded-Encrypted: i=1; AJvYcCX2E0TqiBRTus1X64xSS081LbOBJ6h1AR5JD0dbpAMoMRI7BlEAxMMrlIEYXl6MhVHpnPig69I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6D0KBfmy6G7SNv/nyKZyQ6oU7usaK/T8xT6IGFC25F0Eg5ln1
	/SZlIErAAiQaKuO897jsw+b+xoR/+VDXTcH0s+ih0oDV6uSwH4r09tj+gFaC0adTgIx3KY1At8r
	xVawZFHt0SpI92h9brIJXZ/XiC/xzrw55gCzZ6upBZgoBcOnTbgW279c=
X-Gm-Gg: ASbGnctlvgLvOtnAA8qTPNkmuroWp3piWTzlgHYshJdTQsyVK9qSQTaObzKqRyQYCG7
	yttAfRgrbZr8OUYkoYkBX4fPEtGAfB75YLXC1M1+B0LnlIIemFcOgzqkgT0GmfeiXeiGZqYXpGo
	gciHPDfarbvLCGVq+dKT9pAfxb7IdEZeGsDZvTbCwbxIsH973rCBKBkez5eQWTiRnxHuyXwfLFt
	aF1nhw6M/VY/iZyqtoEYr0eqWjyHwlx7Xe/bIrUKBPpg6UmD58WQLGWgpVY56ItF5JyUSu4KDKF
	81hd4lPXaCC2a8Q=
X-Received: by 2002:a05:6a21:8cc7:b0:1e0:d19c:c950 with SMTP id adf61e73a8af0-1e1870bb354mr21625324637.16.1733789926153;
        Mon, 09 Dec 2024 16:18:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOTSpACxIke+xvd+/dx9F62i7OCMaFCLAnp6k/c9y495pu/36YQqEeBFrZuNKVlnnVLGuSZg==
X-Received: by 2002:a05:6a21:8cc7:b0:1e0:d19c:c950 with SMTP id adf61e73a8af0-1e1870bb354mr21625286637.16.1733789925693;
        Mon, 09 Dec 2024 16:18:45 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5af9sm8161965b3a.19.2024.12.09.16.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 16:18:45 -0800 (PST)
Message-ID: <3cd0f6da-6075-404a-a38d-71ee41846031@oss.qualcomm.com>
Date: Mon, 9 Dec 2024 16:18:44 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] net-next/yunsilicon: Init net device
To: Tian Xin <tianx@yunsilicon.com>, netdev@vger.kernel.org,
        davem@davemloft.net
Cc: weihg@yunsilicon.com
References: <20241209071101.3392590-10-tianx@yunsilicon.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241209071101.3392590-10-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yNlNSSIecfIto-GhTV012FPaQ9j8iJuW
X-Proofpoint-ORIG-GUID: yNlNSSIecfIto-GhTV012FPaQ9j8iJuW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100000

On 12/8/24 23:10, Tian Xin wrote:
...
> @@ -133,3 +462,6 @@ static __exit void xsc_net_driver_exit(void)
>  
>  module_init(xsc_net_driver_init);
>  module_exit(xsc_net_driver_exit);
> +
> +MODULE_LICENSE("GPL");

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning with make W=1. Please add a MODULE_DESCRIPTION()
to avoid this warning.

My mechanism to flag these looks for patches with a MODULE_LICENSE()
but not a MODULE_DESCRIPTION(). Since this is patching existing code,
if there is already a MODULE_DESCRIPTION() present, please ignore this
advice.

/jeff



