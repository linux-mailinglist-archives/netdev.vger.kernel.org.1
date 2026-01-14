Return-Path: <netdev+bounces-249871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F10BD1FFA2
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45CA6301835A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5FA3A0B09;
	Wed, 14 Jan 2026 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AUXfQFux";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IjJ8TYB6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1A27EFFA
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405992; cv=none; b=B8UC6MGSVBAP4lO2QVMjJYdOfNhQoYQejh4fnRyHFsE3kNor1/E8EfK7+W4xaYQSby9tr/185yHj5sEV02NhJeZVm85oApWw70K8VxDPiYzELYeS21d+fz44RfhVViM6DjG9tIGnZ/q5fBn+xCi6wf2zFr9X5gA3PF4+mWZWcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405992; c=relaxed/simple;
	bh=MD3Q/eKA8Bg2nYkxvuGRiHO71JFcoHURut/25DxpxpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqfK0A0ygmJmCrQ+I/EvvlwZ1goqx6A0iQEO7GXNZNw5QfKCkACKIm1uVCxrRxQKWtAaZf82+2/11oyxS4EfQSZJmWseTnxX2MsBqI/4Eh4x7eKaeLl6+oO6z9p/frKX+8Whvl+iQvz9faRJsUGXIosvagRa6I8tmHop+IA4zC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AUXfQFux; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IjJ8TYB6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EChVqU3925436
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 15:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MzzHnWe4mjqtiAA9/E5M6TfbY0kOzCmUNRbO5q8s3ag=; b=AUXfQFuxzPsHLsEL
	+llFNA7pRNFgKGWQK2iJT0As7oIuZcM1DIIP8f9mmHrbO41ZvFGukzl730UK9D3x
	pwn/DsuD/bLYDsHsmiEcKyHLCeG38EPO8ACWdiy38G1+9i+t2JH+kZGGa1wFicfG
	BFp94Lm2Vz9TAlkflm6iHokYuXYgD5NIgyMyhueDHurFso3dPOnNK0J2Su28Lp5q
	3pZqItCiGgNSLyIIrFyruf3z5VVrvt8haaZMSuYPlTqS2U2V4zVmgcg++72z00xi
	XFA1bh3bmGmf+PtxhhDRlp8Izgvo+7qE1hXSBc6oXobLZkA+diV6MLJC+XoaGEJq
	pYXWeA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bpbdbrkkx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 15:53:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ae51ce0642so8280961eec.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 07:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768405989; x=1769010789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MzzHnWe4mjqtiAA9/E5M6TfbY0kOzCmUNRbO5q8s3ag=;
        b=IjJ8TYB6ndvX0edf+St4vQqb496HTKHGpx0rfqxcvo3w0KnW/4ZOzFfGzz2UaPZTzH
         j/KJwCr6Rf4roGMXNKOcwQhJPGIF0SUEvCMankJPMJ+chj75zBfuQ8FDUigDCxddFogF
         bemfiEcDSsP3i27iQuT2jw1dcL/Eu83VU1Ou4nRBIsRwJwfz5g+rE5dXzKukcuCicM+R
         GOQy7kuB89oHyZanGwS3+1iWFMFhduefrSYMX104AE9HNJSheLH1N6lu/GrNnxRiB5d0
         tEMbnVQGKhZY4K5mROTRUMx71MvznMGpiWlsHhVQPrbdz8NCyoPaaRdG8UFqdsfb7XaF
         vLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405989; x=1769010789;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzzHnWe4mjqtiAA9/E5M6TfbY0kOzCmUNRbO5q8s3ag=;
        b=BUpte0Z+xh2tMp0BXs+Br7A18XajxyjXASha+wABV+v+3St3q8YzBXLJeyyIfEqDGN
         r1ki6HKk0NEaW3dKopyf0chxYaTJhVeff4ipsRV9HeRZ/Eg1px3MJjd6AIH13mIc+jRk
         xLErimI6GO5VFXCX9AkA6b248tOopzGsEfCRehgTXUHHga+bYA/gFDVeacyFBbSsoVHO
         wokXwE9Fr5FDm5mJe4obz/NIHzfgNxE+RXqa3n/tuOdK93lrdLDlm2rCum4NxcYDO7zt
         tnHxGPbqfvkNgRhQRw3wA9JsxyBBpOUCQW4sKsA3he4y9Qv5ZkyyBFdiVwqxP+6s9yAv
         Pd5A==
X-Forwarded-Encrypted: i=1; AJvYcCVVJnngfm9yqkoQKx8JwN1e5NCsaJP5b2vlsMnoEUB25QYxF/O6wQV8eh0ivs6Te/PkPZQtse0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmB3wkKeyWRw3pCQ56B6ciy18Rt+QZPB+SamfnFcbyrrFs+DI/
	hpR2udY/myJnwWhQSrYFvyy0+aMTJcNDlsoTOxiZFCz12KjA5JKdsvkeIPSr3ECbwzCHQTVZ5RF
	8s4cAkQjpkbTH+cBrxkeQsV4FxrCTzdK9cnlH3eWsuLciR1fHqdxaKyVT3r0okTvs+sE=
X-Gm-Gg: AY/fxX5OD9vrYsuX30K4KZUmcyRdeEClls5pBQnYCzU+xemnlKJzOAEXlHMBlEvihu8
	Ncv9rJsJ+v8xCDfEm67QurEB3JQYcCw49+/lHghDbHVAE7/oEwUMV0t17YFBR1VU6X4nHCuF+3a
	uht4Nj1VLtYfsuzvsIt8fHEifNFkMMmwlOlKrlLeGeW7IYpOEUXiQXjprAxUIUgd9twlCbyB3iT
	XqPHHU7rrS8cwZY7gIKTJ2H6+A1qxvRWYRSiy7O+JJNowfOGGKPnDzPdgAKHy8BHORos27irg0H
	fMXbBkLZJhLPPwc9gLNv1/j2X9wBTvryASEBwjPVyziB4sCTcaNrTvacK7HrJNJIf1p8+BKthak
	WfL5d2hZNULaNoRLibTKX/9jjzNs4nbe/Dmdtnq2DWZ9Uu0yEzifPO2HBatGQjex4ercbDw==
X-Received: by 2002:a05:7300:372c:b0:2b0:4c5f:c05c with SMTP id 5a478bee46e88-2b486b7da27mr3799952eec.4.1768405989064;
        Wed, 14 Jan 2026 07:53:09 -0800 (PST)
X-Received: by 2002:a05:7300:372c:b0:2b0:4c5f:c05c with SMTP id 5a478bee46e88-2b486b7da27mr3799902eec.4.1768405988379;
        Wed, 14 Jan 2026 07:53:08 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078dd84sm19498688eec.17.2026.01.14.07.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 07:53:07 -0800 (PST)
Message-ID: <cf6b81ea-3ab2-420a-ac10-e847be54c9c3@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 07:53:06 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath9k: debug.h: fix kernel-doc bad lines and struct
 ath_tx_stats
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20251117020304.448687-1-rdunlap@infradead.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251117020304.448687-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NvncssdJ c=1 sm=1 tr=0 ts=6967bbe6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JfrnYn6hAAAA:8 a=stkexhm8AAAA:8 a=VwQbUJbxAAAA:8
 a=bN4pwD7rly7kb_o33PIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=1CNFftbPRP8L7MoqJWF3:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-ORIG-GUID: loRRae2ldN9cWoNDdw7U7jmEk0Smiebz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzMyBTYWx0ZWRfX6pKLgUB8r7ZV
 gNEntyDyd1+pBjwaR2QwrCIXwxKp+EhpLxHl8+Pau7jGh4X4PczqtExi9RCxBxs+gi56+4r6tkT
 I7Q6sRLqYAPjXzld3uVWHtNbN4FSqBlpqnUyeRt438cwyaiJ8DAMAj0+ibBltQ6voRSP8Z4ui3r
 599ZbshD+PInP2lxk6rHNiSQeqRHS8l5GVpTJJH81y7iaPwegQskqCi7HjkW/D9B2exrjIzJdPs
 vyr4ZvNVDCGnw0gTnXywExuifw6TOj8yoEXh5E2/UKlOGPojFKo0vlpmbk1do6P8pB8KBAa+zQ6
 KEnN6uXFN4RwuP2lg+qk9jBLkMnKaPs/GijV/igrQ+xH/h7jPh8yDgUIlFtmNgo6KD8C1wqsj0w
 QeWACa76baInoUi1z0SW07uCnDuNqZ7HkLat0T5ApyBTSarHdS4kiC+kNnSupApNlKTFyOgQ+CA
 bwWRw9UqjvT1CmWXUGA==
X-Proofpoint-GUID: loRRae2ldN9cWoNDdw7U7jmEk0Smiebz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140133

On 11/16/2025 6:03 PM, Randy Dunlap wrote:
> Repair "bad line" warnings by starting each line with " *".
> Add or correct kernel-doc entries for missing struct members in
> struct ath_tx_stats.
> 
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:144 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:146 bad line:
>   may have had errors.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:156 bad line:
>   Valid only for:
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:157 bad line:
>   - non-aggregate condition.
> Warning: ../drivers/net/wireless/ath/ath9k/debug.h:158 bad line:
>   - first packet of aggregate.
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'xretries' not described in 'ath_tx_stats'
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'data_underrun' not described in 'ath_tx_stats'
> Warning: drivers/net/wireless/ath/ath9k/debug.h:191 struct member
>  'delim_underrun' not described in 'ath_tx_stats'
> 
> Fixes: 99c15bf575b1 ("ath9k: Report total tx/rx bytes and packets in debugfs.")
> Fixes: fec247c0d5bf ("ath9k: Add debug counters for TX")
> Fixes: 5a6f78afdabe ("ath9k: show excessive-retry MPDUs in debugfs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Toke Høiland-Jørgensen <toke@toke.dk>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-wireless@vger.kernel.org

I'm picking this up, but my automation noticed there are still kdoc issues:
Warning: drivers/net/wireless/ath/ath9k/debug.h:138 struct member 'txeol' not described in 'ath_interrupt_stats'
...
Warning: drivers/net/wireless/ath/ath9k/debug.h:138 struct member 'mac_sleep_access' not described in 'ath_interrupt_stats'
19 warnings as errors

Are these handled elsewhere, or will they need to be handled later?

/jeff

