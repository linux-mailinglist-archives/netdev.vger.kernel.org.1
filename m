Return-Path: <netdev+bounces-241942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7597AC8AD17
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07E974E48BD
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A07033BBA0;
	Wed, 26 Nov 2025 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ank3QQDV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE132DC776
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173180; cv=none; b=dCPp5zmzxfNOuqkQIe8iUMj5mDi2AV+/JXM9vMU9TM7DpduZJRH0YgVbQbxSIQueUMKwmQKEyefkR2OKUJfEHhOaH0l122XYHG2As2FDnRrAzHvBaQsdVupl9O/bIfCPJB64EILf4j/5mfSgWR7XQK4wevGyHMj3nRcaf6kiL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173180; c=relaxed/simple;
	bh=gDTCvlkiWM8Hu0hjCTlh1GHRH9W7TlpPUxMBBQhtyLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfIYvLdfk3OUB1VznUh9ILNPEwe4u6zkr0aaJz3NKDr/GukqJFsY2hyrUf48YlJmIYlD5+YdWfZsBSCvrHyyXNlezxOV9X9E3PxLHCTvvVVXBqnQLqqzMCpd8T4pME0bZB7bSbUJpUtOHcDYP4NgrfW2JZcSuEnpGCT5KfRx3I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ank3QQDV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQClEnn007900;
	Wed, 26 Nov 2025 16:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SUNn73
	q2ACcf0HouBO0F2hiVQqxEN3T8dpXZTX0+wao=; b=ank3QQDVY8/zreMdCe/j72
	89fnZoUlMHs/4at2QjComo+Rq3Ivi11l2iwHKoigqDa7RykWHRjZv/GYmWIcyIkQ
	8MzhQOYJtQ9ovqG82hF2lCMWBYQO53rNgDVrsN3VPwISmeL7SYwK5ElV/tt0zDcR
	idMaanW5XQQswRWhTufc5CWKG09YSRj24FaZzswiDVMacpoWUJTWIz755CVe11zU
	CswuQvvJMjyaaR3FlSP6QY740s8Q7KwD4FQ7Rlt/aMgYnIbDb7h4cAsV/UYx2csO
	+2Wu/1cao3dus2hNTD+ctZ2fU3ucSxhRctFrhrbEYpgaDGdQiT0Llth4lIcN4Gig
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kk44rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:05:53 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQFt6ro028454;
	Wed, 26 Nov 2025 16:05:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kk44ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:05:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQE8PFD013839;
	Wed, 26 Nov 2025 16:05:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akrgnbhg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:05:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQG5mHe28901736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 16:05:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F30A20043;
	Wed, 26 Nov 2025 16:05:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B506620040;
	Wed, 26 Nov 2025 16:05:47 +0000 (GMT)
Received: from [9.111.219.99] (unknown [9.111.219.99])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Nov 2025 16:05:47 +0000 (GMT)
Message-ID: <b1cece62-ee31-465c-8284-a8117e939bca@linux.ibm.com>
Date: Wed, 26 Nov 2025 17:05:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Remove KMSG_COMPONENT macro
To: Heiko Carstens <hca@linux.ibm.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Dust Li
 <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Cc: netdev@vger.kernel.org
References: <20251126140705.1944278-1-hca@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20251126140705.1944278-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MRqsKldd_qN4hiInrFUZru1DGqPuXOCH
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=69272561 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=07d9gI8wAAAA:8 a=VnNF1IyMAAAA:8 a=-IvAg4TNcT8KQeoxRckA:9 a=QEXdDO2ut3YA:10
 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-ORIG-GUID: b39S4ZUXixetB131zNhTylqMr7yEVFTv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfX0mAjWOY2rSKJ
 8qnuY3dT93QpfV2tOYqdCOSxNvaOEyQPF7d2EsLP7ovEAF799+vs1ZPqHMIAQVNLrPIZZp3euJ4
 7ZuvVHzD7NA//5SjsFDKaQZcGom6vZqAVzUh3k6ZXQc/zJEItoA/hxE8AMBa6opy2uS4+tAIvZW
 oe3A62+Avp0xp34f0Zv+MuS1/INenHhEcBiYtyvLA4NSwl/U0qFki36hY1eayqUiqco+bxZ+kQt
 Pjn9ML/OApfTu+JuffsxorldrD0XKgf/qHZwCni6KLQnsKCe+oVzkCQBHdk07OGCT7gKAXFIkM2
 pCyfyS8tmUEsdRzdNJoiFvLtWKmKiGq1c/rdG5OZOKnmB+kSZuBbSrZoOikwZbqSjCPrPuBVGdh
 HhyLvLODqlz0AS2yBi+e1K1doZSMgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220008



On 26.11.25 15:07, Heiko Carstens wrote:
> The KMSG_COMPONENT macro is a leftover of the s390 specific "kernel message
> catalog" from 2008 [1] which never made it upstream.
> 
> The macro was added to s390 code to allow for an out-of-tree patch which
> used this to generate unique message ids. Also this out-of-tree patch
> doesn't exist anymore.
> 
> The pattern of how the KMSG_COMPONENT macro is used can also be found at
> some non s390 specific code, for whatever reasons. Besides adding an
> indirection it is unused.
> 
> Remove the macro in order to get rid of a pointless indirection. Replace
> all users with the string it defines. In all cases this leads to a simple
> replacement like this:
> 
>  - #define KMSG_COMPONENT "af_iucv"
>  - #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
>  + #define pr_fmt(fmt) "af_iucv: " fmt
> 
> [1] https://lwn.net/Articles/292650/
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  net/iucv/af_iucv.c                      | 3 +--
>  net/iucv/iucv.c                         | 3 +--

For net/iucv:
Acked-by: Alexandra Winter <wintera@linux.ibm.com>


