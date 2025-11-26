Return-Path: <netdev+bounces-241943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A81EAC8AD20
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 124204EC3A7
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8191433C507;
	Wed, 26 Nov 2025 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jotzCgPC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23F233C510
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173182; cv=none; b=XHP0+Sm+PrzfUll+IlGUC/g3UIgx/NlIGU5RuVl0k9oIJD15pdwLfUiJW8Vwha9J/MgXVYUkcVtUeiKjTT2/0xyP1JeBUF3qbzgGpiTmg5VpMdaXp02ufbZBqPCbfvAf4TlZCsB6ZUQNbku/FWwuyKmbHL3EHkPBhSJ6tuAaRLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173182; c=relaxed/simple;
	bh=10bzpMZMvTW7yxN9qSUlrL93zN3yrW90Fvfb1YjRYwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTsQ7gjkArL4vK8hY3hVEawzhAUFGzNeZHQe9+JVxGdVq6jjRW4UvGKhvdjiaMhZpK1ng2ycMwZekaqGFNgN+I+hKsO+REW4KRAdVOvgSCm7vWSAXNXjvDFA5vk/V9ZWqq/YeGlXaw1MB2Eq0tSDR//XSqmq5KAzsZA2TBxlKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jotzCgPC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ8CYqB000693;
	Wed, 26 Nov 2025 16:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tvUeRy
	trOTPCYFrglZcpTDK6whtFLE5MLiFKVcaj45g=; b=jotzCgPCGHRQWgxRZWNhIw
	AqQW3g3P/tO5ny9c1Pcnm9Ef1MELAetOX6e0zZKmQCZshB/LPRg+2jefzYH3Ceqt
	hGggB7D1Q1ESvomQPJ5i8PcP+CfumFBDnHYP9Ro8/cXvjF9+YkqPVmvWt9qmUoLy
	wea/3+167agvDW2HxrgC6Qr7lGJDLF6snrozssZOkIEsZVg8qqQKh9c3TJz4k8y8
	u1zDLDdDlaCmtR31pCRXWwG3qDsoKbJKNGhB5VpQTA84eYLb7Gg0isCKTHFmEms9
	MGkygnAyHVUK8lYvPGDVHJYGjRG5RGhqsndH8kL1NsevNsCNRjGw89fit12VKKbw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9n5ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:06:14 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AQG39w5014552;
	Wed, 26 Nov 2025 16:06:13 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9n5ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:06:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQFEoaW025097;
	Wed, 26 Nov 2025 16:06:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akt71k7eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:06:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQG6ADt41943544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 16:06:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4FBD20043;
	Wed, 26 Nov 2025 16:06:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88DFD20040;
	Wed, 26 Nov 2025 16:06:10 +0000 (GMT)
Received: from [9.111.219.99] (unknown [9.111.219.99])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Nov 2025 16:06:10 +0000 (GMT)
Message-ID: <811ab9a1-e548-4965-9188-4b30d41a757a@linux.ibm.com>
Date: Wed, 26 Nov 2025 17:06:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dibs: Remove KMSG_COMPONENT macro
To: Heiko Carstens <hca@linux.ibm.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20251126142242.2124317-1-hca@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20251126142242.2124317-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX1ANBGyP5+lwk
 sc1mriEd9+3oqqjeKidJNPzjtTsh6iJg5+kjRtnNRNKYuDHn5OihrMXIdevkpz2G1CaRhibAiks
 YlrBNTNF/Mk7vs+c4n2sFO2u6RpYuIDrKxcNMWitHlZzy67gyycIpeRcjLtV1qB+eU/OQuZZXkP
 0R/LERy4Lb0JcgwWX9whNTqUgJrLq0evVZJ1Agce/2NgKz+j7h3M+VtoSWlP9Myy3qs43RngNH/
 J6MklfPeDKL4WOAmkGedpbGNphyP1paPe02W46bfZ/JDRmc0ON/c4V0hCnzJdDbz32mRSmR41Vy
 XhL2VwM3OJBOByc4Hiqc4SkPQfM+0fgmiaBsyHPwl49pbfBsJ56Es+IP1gBjJ4fFh4mzFJeHkVf
 tiBSjruqWpyOPkDpKtBePh3LtINNsg==
X-Proofpoint-ORIG-GUID: QrvJLzVQTKTfXlpc7jwzXhZ6NoAsgLvZ
X-Proofpoint-GUID: gt4FxA6Rlq7uI8AN0IhKrx3aYvb6RR7Q
X-Authority-Analysis: v=2.4 cv=TMJIilla c=1 sm=1 tr=0 ts=69272576 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=07d9gI8wAAAA:8 a=VnNF1IyMAAAA:8 a=x88RXcAXjFUQASv6bUcA:9 a=QEXdDO2ut3YA:10
 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021



On 26.11.25 15:22, Heiko Carstens wrote:
> The KMSG_COMPONENT macro is a leftover of the s390 specific "kernel message
> catalog" from 2008 [1] which never made it upstream.
> 
> The macro was added to s390 code to allow for an out-of-tree patch which
> used this to generate unique message ids. Also this out-of-tree doesn't
> exist anymore.
> 
> The pattern of how the KMSG_COMPONENT is used was partially also used for
> non s390 specific code, for whatever reasons.
> 
> Remove the macro in order to get rid of a pointless indirection.
> 
> [1] https://lwn.net/Articles/292650/
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  drivers/dibs/dibs_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
> index dac14d843af7..b8c16586706c 100644
> --- a/drivers/dibs/dibs_main.c
> +++ b/drivers/dibs/dibs_main.c
> @@ -6,8 +6,7 @@
>   *
>   *  Copyright IBM Corp. 2025
>   */
> -#define KMSG_COMPONENT "dibs"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "dibs: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/types.h>

Acked-by: Alexandra Winter <wintera@linux.ibm.com>

