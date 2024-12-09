Return-Path: <netdev+bounces-150137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCA89E91A3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF995165591
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D30D218AB1;
	Mon,  9 Dec 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EYTvUm7k"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF57217F4E
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742316; cv=none; b=aIOy9FYyFdNKMqwAzN7L6MuCSanT6g8tYjjnAvxt124zLY6hn105oGkSM5s+VBjARH40q2Xk9oXdY4xe86tW11tZCSXF7LrKvpyodUHMNGIztA4Hib1Ae8n2GTOsSJ1PDK7Q43EshaW05RLVlsnKkKsspwZ+BgQXTzUZzneWGm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742316; c=relaxed/simple;
	bh=3Nh7F+Cc99AMEjz5edt9LtqDula6+CANzryRGt50rXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lul2SJExeCZyPNl5jJ5eJ8vZTyFEjuAxfs4ZKsC5IzPAb8l8cd+25kV0UAxcfIc9O7Nobs+Zdhe3jRdh1LH/CHS3y9KrHCsvlitYTgE/iXV5aCaNG54yuUo7q0Dg2Wiw9PlTHSI3p7LY1iSTSj8B0mF0ATd56EIaZkENzL77eNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EYTvUm7k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9A6Bth006738;
	Mon, 9 Dec 2024 11:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=02+q0t
	bfSEqB/V3hPIYGw9SAlJcGLrxRs5Yi/d6zcW0=; b=EYTvUm7k5JQxo7eRHmmUxY
	FUYAPmqHfJHvNEzoIzbwdtc2LeZqeE97dvCPiTbtFtS1CZSrfaau+KXh9tk/+tdm
	b4FBqHpqfvrN6dg2QIdJUTuPd+MP4dTJmWp2JOOEwzmeJfp29zqZzy4n7/vMwSBH
	OuGPPCj4+ZSOZSTDaEZGomzDwLTJ9onXZLLXl22yEt9R5NC4XYDonzanZeWFhyUH
	S7qmznG5079gItCUI5ARD5qfVvgLNdctaf96kNMKb5mbabm06LC/bUovId3zyvtI
	l5QazdoARFPDw/ZZJeREJcImhFHGwk0mWnWcUVEXR7o+u9j1tGNCt+sGwnHYGsxQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38gv7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:05:08 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B9B219a022134;
	Mon, 9 Dec 2024 11:05:07 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38gv7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:05:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B987Bgx017376;
	Mon, 9 Dec 2024 11:05:06 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1dwyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:05:06 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9B55R224969976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 11:05:05 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D048A5812F;
	Mon,  9 Dec 2024 11:05:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 596665812D;
	Mon,  9 Dec 2024 11:05:04 +0000 (GMT)
Received: from [9.171.32.56] (unknown [9.171.32.56])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 11:05:04 +0000 (GMT)
Message-ID: <385f7646-7f87-43ca-9585-5ecdd59a4379@linux.ibm.com>
Date: Mon, 9 Dec 2024 12:05:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 03/15] smc: Pass kern to smc_sock_alloc().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20241206075504.24153-1-kuniyu@amazon.com>
 <20241206075504.24153-4-kuniyu@amazon.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241206075504.24153-4-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O0AaEyNoxA77-dI5rKWvsg-axt3b8FXZ
X-Proofpoint-ORIG-GUID: W3h8CuRaGABZaIauRlV_jyVvtV0_N7mH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=852
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090086



On 06.12.24 08:54, Kuniyuki Iwashima wrote:
> Since commit d7cd421da9da ("net/smc: Introduce TCP ULP support"),
> smc_ulp_init() calls __smc_create() with kern=1.
> 
> However, __smc_create() does not pass it to smc_sock_alloc(),
> which finally calls sk_alloc() with kern=0.
> 
> Let's pass kern down to smc_sock_alloc() and sk_alloc().
> 
> Note that we change kern from 1 to 0 in smc_ulp_init() not to
> introduce any functional change.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   net/smc/af_smc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
Sorry, I didn't see the need to add the **kern** parameter in 
smc_sock_alloc(). Because the **kern** parameter in sk_alloc is not used 
others than to decide the value of sk->sk_net_refcnt, which in SMC code 
is already set in smc_create_clcsk(). Thus, IMO removing the **kern** 
parameter from __smc_create() makes more sense, since this parameter is 
not used in the function.

Thanks,
Wenjia

