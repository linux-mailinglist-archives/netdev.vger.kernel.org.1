Return-Path: <netdev+bounces-151790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E23A9F0DA0
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9871881543
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1F41E00B4;
	Fri, 13 Dec 2024 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hcqB2esK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC0186607
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097622; cv=none; b=h+FRKLaLAqBxcoZ7wG/00Dg/A/qx7BCviMRsxdaORdDEHJCqagx8ycHZ+spnazs1up8tDIqquOlb//3zvnhsxSfTP6WSfQjlkn0JmX4sPTQwzBUtFboy6Tvbq+VwP5eMcwdB2Flh2Aq5HyfDUei+fU/NhlXmEfp5OYTgQ/+sviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097622; c=relaxed/simple;
	bh=EgT0aAewxHWB3My/CjyJePOV1E4XOccRh8bzO7RGeDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaYWdzD+kKGbQ3GViFVg6KepSGuqQw5hkrugzFVXnrB8dOv78JADddjYPbF0mxWEj9DuMl36kuImxhoZw2r8YeKx0ZSsnhXReHGyQc/cO4tE0fE8UfjtYse9KuthL97ELLnvcaus6Lnuk5tbZP5Xzd/Y/RUY3Zdvdh417ETIQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hcqB2esK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDPeco009456;
	Fri, 13 Dec 2024 13:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wZa6yL
	oqHly+RDDXXp6VJLToE6Rl8LQtpoHxXwOIdqs=; b=hcqB2esKTeJLSyo5+Ms6bb
	R8VH4rH48wZrTxWXnoQcWu0aZYDgwmzirOAZnaUlthspNmCIZQK5HwdQMbD8ZtDm
	Vg8cfqedFIxZSfou+zsnQj0pRMaWLi6tGh45aGDoje+DQy/gIqTS/EgME2vO7+Wx
	d9R7stkUSQYmKg/X28BQxxO3bvbXyYZea5IRpBhvY5GnJXqLi2TmD+BgZgU+bm13
	BkPU0bHVnps/pGClj6Bon5GAu9KP8ozAd2+Pn8RRLxHKwcqlDl9mYxOKnMa5Sdhj
	y7Pf0a9P/FS5s+oFIhKiqcDVA/XFCXOJBmCMcK/MmeFvAvTtJXyTkaidhsj4XatA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddbthb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 13:46:56 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BDDe5HK030703;
	Fri, 13 Dec 2024 13:46:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddbthax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 13:46:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBaKhO007796;
	Fri, 13 Dec 2024 13:46:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ft11yg90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 13:46:54 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDDksuW31851080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 13:46:54 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CE1F58055;
	Fri, 13 Dec 2024 13:46:54 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D39C058043;
	Fri, 13 Dec 2024 13:46:52 +0000 (GMT)
Received: from [9.171.74.77] (unknown [9.171.74.77])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 13:46:52 +0000 (GMT)
Message-ID: <2c765b30-3006-448e-8782-e01161d049f9@linux.ibm.com>
Date: Fri, 13 Dec 2024 14:46:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 03/15] smc: Pass kern to smc_sock_alloc().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20241213092152.14057-1-kuniyu@amazon.com>
 <20241213092152.14057-4-kuniyu@amazon.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241213092152.14057-4-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wb_OkCBxK7aGCeRnhPPNe6YbMl7VO5UX
X-Proofpoint-GUID: zMVWzcv_M9ClH1zIiDvub5WeY40hBerf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=833 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130095



On 13.12.24 10:21, Kuniyuki Iwashima wrote:
> AF_SMC was introduced in commit ac7138746e14 ("smc: establish
> new socket family").
> 
> Since then, smc_create() ignores the kern argument and calls
> smc_sock_alloc(), which calls sk_alloc() with hard-coded arguments.
> 
>    sk = sk_alloc(net, PF_SMC, GFP_KERNEL, prot, 0);
> 
> This means sock_create_kern(AF_SMC) always creates a userspace
> socket.
> 
> Later, commit d7cd421da9da ("net/smc: Introduce TCP ULP support")
> added another confusing call site.
> 
> smc_ulp_init() calls __smc_create() with kern=1, but again,
> smc_sock_alloc() allocates a userspace socket by calling
> sk_alloc() with kern=0.
> 
> To fix up the weird paths, let's pass kern down to smc_sock_alloc()
> and sk_alloc().
> 
> This commit does not introduce functional change because we have
> no in-tree users calling sock_create_kern(AF_SMC) and we change
> kern from 1 to 0 in smc_ulp_init().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   net/smc/af_smc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 

Ok, thank you for the detailed description, LGTM!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>


