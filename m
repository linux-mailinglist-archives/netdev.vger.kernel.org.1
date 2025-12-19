Return-Path: <netdev+bounces-245524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9816ECCFE22
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 13:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78CC730652EE
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 12:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BEC341653;
	Fri, 19 Dec 2025 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kxmvo9TW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D347340A5D
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147554; cv=none; b=kdDw0J7Rv3tB/SzqxyYgzUhnDsNlLM14YqWQ42jSxPjx23X2M64V5C8ZWXtTOgzjQibBtPNI15Gnsj8tJgvTouvS3ABXvGtynKa9gAUDdqLD6oPCJNrYMM4WzsCr658yZKH6g1+LpPoL4CIdlyU9F/4LMeLfgTkkf7qMgrykkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147554; c=relaxed/simple;
	bh=eFrMD5uL1nwy5cPpuvrAC+K/yLYWd5uHwlgN2sqPlEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPjfKtdb0W/+UYhOEMG+6mLKsodFTcuCNGy0UNujs7ftoqq5bVeQU8kTzYiBQdUr5iilkFLoPO2qhMGjhFLqjukfMJBn7oE4HvcbQSfiDwZTHTZKsZHqcTY0YFY/Byik4harfNDvdc5VG1k/z6dTEym3TJpLdKpWnmGtUzPaMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kxmvo9TW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJAXDL7013835;
	Fri, 19 Dec 2025 12:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f0Cfgy
	pdL61FWUkPe4uOGQ5apciECSLktzd/p+oLJLc=; b=kxmvo9TWme49qiHph+fIaT
	ifPHL1stae7VhutU83A1qHpz4wGPTmEXIZvsDOjZv60nLMp47MqRuFgRJy4hC/y8
	XRFTy8d7reYQluutvR39mtV+4HCYoA4HH055DM5z+D/piXSgTl9luuhVFRrKGk2G
	lV+J0JsCdo41YGMZvUFTQggryK3welkMg5mg9knhiALi9FjUGu8YFy9i3UaHKw/p
	h8GVOr3NNQatoYsqN1LsnL/igzVt+n1JBJwNcE+uZLraGMkV+7yon/1utITQhmP0
	+HMvVraveb37t2quRS0xyo8akxI6zH0POYBVYFCKCn5tl4hyNkeO9B77cu7fHBsA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3d3grr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 12:11:54 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BJCBsZL027834;
	Fri, 19 Dec 2025 12:11:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3d3grk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 12:11:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJBqneB003663;
	Fri, 19 Dec 2025 12:11:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b4qvukm8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 12:11:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BJCBoGc18940214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 12:11:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDFC220040;
	Fri, 19 Dec 2025 12:11:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B499A20049;
	Fri, 19 Dec 2025 12:11:47 +0000 (GMT)
Received: from [9.124.223.136] (unknown [9.124.223.136])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Dec 2025 12:11:47 +0000 (GMT)
Message-ID: <bd79936a-685a-4509-b01d-a40be0fd6f65@linux.ibm.com>
Date: Fri, 19 Dec 2025 17:41:46 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: avoid prefetching NULL pointers
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com
References: <20251218081844.809008-1-edumazet@google.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20251218081844.809008-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WYkBqkhX c=1 sm=1 tr=0 ts=6945410a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=-Q5EdLYdSmJ0yUwkDmcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xwlDh13q1OxwDX-9Rrzuh_NiibssqPFB
X-Proofpoint-ORIG-GUID: DsJQ3dR-FacbHuIOHGY-Q25vtcy0VAF-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA5NyBTYWx0ZWRfX16nmS2C3vnjT
 ep14h4V8i+4z0z3DhuWMA4RT3mK93Zo/KBPpt1vN9+i5deegFYmKeEtTqkROok3H2+UloYRQcAA
 flpX5VWb0AZzM+RwDd9veZbVGU6ZfR4iG0oTOr2elHKWaPPYU8MWTkGn/TJr2mSZ4FobXGQx9Xk
 ilFzY2cmmztmYFg20mjRLgP+8KXaP6QuZ3wsWi7VszgUwOdWrOfn1H8LC1SaBnmrVuJZdFAVdI/
 pGV2jkerN0wx7opgJSWo3y57g6RVl5/2BFfB2CCjeCT6q0K2Ma/Nk1dBS/KoZ8we9lZEsYQZfUJ
 +mu453Ovq/RyEjF0KmxWzmoey9NNImMn6+PMsNb4TWJg5BXN5c6WQ2kPIa7oh1Sp6nEW7twQMVD
 D5+AzV9b0vDFTOdoNQO0AM31/h21ZtH2cj8kfZEZmJGDTvNVD0MvvkcpAlurR0QeQK9Kq9e9IVl
 kWl2HH4TJ+oIpibOFFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1011
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512190097


On 18/12/25 13:48, Eric Dumazet wrote:
> Aditya Gupta reported PowerPC crashes bisected to the blamed commit.
>
> Apparently some platforms do not allow prefetch() on arbitrary pointers.
>
>    prefetch(next);
>    prefetch(&next->priority); // CRASH when next == NULL
>
> Only NULL seems to be supported, with specific handling in prefetch().
>
> Add a conditional to avoid the two prefetches and the skb->next clearing
> for the last skb in the list.
>
> Fixes: b2e9821cff6c ("net: prefech skb->priority in __dev_xmit_skb()")
> Reported-by: Aditya Gupta <adityag@linux.ibm.com>
> Closes: https://lore.kernel.org/netdev/e9f4abee-b132-440f-a50e-bced0868b5a7@linux.ibm.com/T/#mddc372b64ec5a3b181acc9ee3909110c391cc18a
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/core/dev.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)


Thanks for the quick fix Eric.

It fixes the reported kernel bug, hence:

Tested-by: Aditya Gupta <adityag@linux.ibm.com>


Thanks,

- Aditya G



