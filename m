Return-Path: <netdev+bounces-204810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A329FAFC2A1
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8788B18888D5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 06:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFB12206BF;
	Tue,  8 Jul 2025 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="buEhenlq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36221A447;
	Tue,  8 Jul 2025 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751955886; cv=none; b=bRNvySGryg5IjMzsExAWPoQXT1255NTO0vjCYrRxAPvx3o2CiOMAxDsrAddJALNDtemhLtlDeK1C6kWeWzuUNXz1tPujdEfRBGV6Hy8EddE7RQWN8cZWDz/YdvrYBEfaNzUJl2Nk02fCC2rNEeTrN+RnlqOKu+hq9b9O3lNEr+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751955886; c=relaxed/simple;
	bh=Nf3+6NTHNIN0tRpAL8M0KgHJQsnyO7yJZZXYEt7ioKw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=dmsAPWIcYUxqKE2cUs70ywOSGWGJHQw7i3/U/P7poz87DPkXtPqdHcU0c4YPJbcfI0O/+Wa1n1IvE73Dqo5o0yos/2E3VwSp2syslHeQsOWA3zrz3uam6JpgirQ4vrKic6RNZJjR6BksfqvypMCx7KkmMDgHuK1nP6LtwUr7MiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=buEhenlq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567JxZ8l032551;
	Tue, 8 Jul 2025 06:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JrqkEG
	QNWicN6z7I9Dn4pCP0FUXIKVd67WcnJYSb1UA=; b=buEhenlqN+VQLFHqmpmM8I
	MC4YRw+E+96K2fSFaD3WUwP55sZfskieqyWJVJV82/0CElbnUtTNPhNS6CIiYGUN
	kP6KcIPSzP266MhPv6gjCxKLOIHEdA99RRkAIOEH+nDaG/zEw37ZuAh7ebYT9M1f
	7HZLr3KeUCXvuTJQv/3QoyBLBRSaH0KTdDpXvGN0iFizISKQJnvBg1nAE3eUlJ7I
	RA4ODSj3WsOx40td8KmIRmfk2rKjZmFMyAxqH6wi+UdVTeLytpj45P+IUTbvpQoa
	N7Lnvma8rMGh3ovPT33t7+mIQO7OD4+d0SwwUoZR/xoam/PjKAe22HH20+UlPohQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjqwh5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 06:24:38 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5686OcTX011214;
	Tue, 8 Jul 2025 06:24:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjqwh5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 06:24:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5682K312002888;
	Tue, 8 Jul 2025 06:24:37 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvm9he6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 06:24:37 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5686OURk23986708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Jul 2025 06:24:30 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D1AA58059;
	Tue,  8 Jul 2025 06:24:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 185F358053;
	Tue,  8 Jul 2025 06:24:35 +0000 (GMT)
Received: from li-4910aacc-2eed-11b2-a85c-d93b702d4d28.ibm.com (unknown [9.61.17.45])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Jul 2025 06:24:34 +0000 (GMT)
Message-ID: <a5c6173f3109dac14e43c30f6483afe19573870f.camel@linux.ibm.com>
Subject: Re: [PATCH RESEND 3/3] Documentation: ioctl-number: Correct full
 path to papr-physical-attestation.h
From: Haren Myneni <haren@linux.ibm.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,
        Linux Documentation
 <linux-doc@vger.kernel.org>,
        Linux PowerPC
 <linuxppc-dev@lists.ozlabs.org>,
        Linux Networking <netdev@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran
 <richardcochran@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Donnellan
 <ajd@linux.ibm.com>
Date: Mon, 07 Jul 2025 23:24:34 -0700
In-Reply-To: <20250708004334.15861-4-bagasdotme@gmail.com>
References: <20250708004334.15861-1-bagasdotme@gmail.com>
	 <20250708004334.15861-4-bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686cb9a6 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8
 a=kidChhKsLFQF8T2tou0A:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: t9WIYJFgt4RV27TIljZyJXv5Pk9JUO7_
X-Proofpoint-GUID: uqEOUAgq8dakJ3CcwbrDoRHfx64MqKjM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA0OSBTYWx0ZWRfX8+eS8LAgOL/l +r0z332481+fayHUujf9JfUgcSI/OWojgHaViMh0Kl5QMtJDti66rumAb4OUgS2Epr+wgKsLmBJ U8nQSZ59C409hWJWcvW5k0UL60oAithLBI/qVaffgdWPlIe8nKUamjyy2EeP24AsVCNFp6XlPbY
 Yk2kk/UaHvMvbREPhQ7F71227bYKaQSm8BaC7u2ne3h+1O7zwUNZmXknpH8eEU43XtPN0e4r1N2 xvNCy5T7avGODHgiB4cmlyrAOUIMIfwrGBKWxViowvWz7CHhXcA79DbarXL0j23AAhlYlg2FUXd yODDabiygZ0S2jJmsZrwos62Ut4b832XqlLBNMHjowBrs3nrsaBQPqfZC1ESYrpWdJiYYhOq/Q9
 ZfrvrUUQlWLjwOU1WN7CuSAzvdDY2R0iRNh8D289yF/VyAiJQ+RC8JkY81bdk1DO5C8OvpRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_02,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=873
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080049

On Tue, 2025-07-08 at 07:43 +0700, Bagas Sanjaya wrote:
> Commit 03c9d1a5a30d93 ("Documentation: Fix description format for
> powerpc RTAS ioctls") fixes Sphinx warning by chopping arch/ path
> component of papr-physical-attestation.h to fit existing "Include
> File"
> column. Now that the column has been widened just enough for that
> header file, add back its arch/ path component.
> 
> Fixes: 03c9d1a5a30d ("Documentation: Fix description format for
> powerpc RTAS ioctls")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks for fixing.

Reviewed-by: Haren Myneni <haren@linux.ibm.com>

> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
> b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index b45f5d857a00b6..5aa09865b3aa0f 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -369,7 +369,7 @@ Code  Seq#    Include
> File                                             Comments
>                                                                      
>    <mailto:linuxppc-dev@lists.ozlabs.org>
>  0xB2  06-07  arch/powerpc/include/uapi/asm/papr-platform-
> dump.h        powerpc/pseries Platform Dump API
>                                                                      
>    <mailto:linuxppc-dev@lists.ozlabs.org>
> -0xB2  08     powerpc/include/uapi/asm/papr-physical-
> attestation.h      powerpc/pseries Physical Attestation API
> +0xB2  08     arch/powerpc/include/uapi/asm/papr-physical-
> attestation.h powerpc/pseries Physical Attestation API
>                                                                      
>    <mailto:linuxppc-dev@lists.ozlabs.org>
>  0xB3  00     linux/mmc/ioctl.h
>  0xB4  00-
> 0F  linux/gpio.h                                              <mailto
> :linux-gpio@vger.kernel.org>


