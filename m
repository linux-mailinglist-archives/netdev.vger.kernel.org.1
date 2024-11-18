Return-Path: <netdev+bounces-145909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC6C9D14CA
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CD82840F4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E331A0718;
	Mon, 18 Nov 2024 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qQ7Lv+2L"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1B12EBE7;
	Mon, 18 Nov 2024 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945254; cv=none; b=Ozh6gBy2Ap0IDJEHQfCgZrSSx2Zn88aYKUXeR35iWg/kkm+qhDwDWo2OsyLn0OM6CQ3E+gxtC4/uLqzB6BuF2/tZ0Bsb9aSF+Z7gxKlIxxRM86FeMLqTZdThbiGzKO/d02moEw/jnJYXwRuCWEtkceaTnPR2D3g1QsdaI6paAPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945254; c=relaxed/simple;
	bh=4lpYUs5Dbj0T8zn97A2VEybvGIFft2BYYoXxSpx3bHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Go+z/PEQgADuXhuJMc8D8SE/fBNR/eBsSA8hpFCXuqpiR1uEUDaFqTrqla7BSl0iI+mqRNzL/ffxR2tVsxGZYuf6Zy9s12rL3h5tfw7j57d56uIms16/+hFP8VwyhZ50KMMKe7ZSQq946KR7CXO1a0V6xPQ02d1zBIXzo0fl8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qQ7Lv+2L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIB4gaS022969;
	Mon, 18 Nov 2024 15:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SaDWlb
	2kKaad3gP5OleofzMuysniJvB4P5iWE1Qjlb8=; b=qQ7Lv+2LJ5CnumzBzjAqxr
	GunvUxdms9jNHeolIbO6z6aKh067VjHkVP3ahBhYvHTsC0FoTbCVPuVbDo0jQPws
	uFOg+wTrZJuIOxe37ARIo74U1IvBaH65//fUuTGz+znTfWZl2XKRZqE7cIrL9n2G
	rtP/32HvBwIWlMKNXR7H5c1ccTH9aVMc0tD0ATvlNh1AMH6lEFwHdHtbwdwm5gUZ
	i2bgjKhbSq+M3CqZMjB4vPqUu/7xqLxo2tQ+rMDiGrUHO94/V19ez/Z0+mDj/aTC
	iOZWlgetz8eejMwzRGRSBDbAmWJu8jlfW1ckA5c3h1VwotX2cvs+VBWWp9Z3JLBw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu1gpwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 15:54:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIEogGR021983;
	Mon, 18 Nov 2024 15:54:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y6qmtv09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 15:54:06 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AIFs55p47972750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 15:54:05 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4345F58050;
	Mon, 18 Nov 2024 15:54:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E27F158045;
	Mon, 18 Nov 2024 15:54:04 +0000 (GMT)
Received: from [9.61.240.76] (unknown [9.61.240.76])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Nov 2024 15:54:04 +0000 (GMT)
Message-ID: <542cb6ed-8e2b-407e-9f9d-037144740b93@linux.ibm.com>
Date: Mon, 18 Nov 2024 09:54:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] vsock/test: verify socket options after setting
 them
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
References: <20241113143557.1000843-1-kshk@linux.ibm.com>
 <20241113143557.1000843-4-kshk@linux.ibm.com>
 <yo2qj7psn3sqtyqgsfn6y2qtwcmyb4j7gwuffg34gwqwkrsyox@4aff3wvdrdgu>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <yo2qj7psn3sqtyqgsfn6y2qtwcmyb4j7gwuffg34gwqwkrsyox@4aff3wvdrdgu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KY8lgYHVVl13F8Rj2DQbSA6JJs9h1IRC
X-Proofpoint-ORIG-GUID: KY8lgYHVVl13F8Rj2DQbSA6JJs9h1IRC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180128

On 11/14/2024 04:28, Stefano Garzarella wrote:
> On Wed, Nov 13, 2024 at 08:35:57AM -0600, Konstantin Shkolnyy wrote:
[...]
>> diff --git a/tools/testing/vsock/msg_zerocopy_common.c b/tools/ 
>> testing/vsock/msg_zerocopy_common.c
>> index 5a4bdf7b5132..8622e5a0f8b7 100644
>> --- a/tools/testing/vsock/msg_zerocopy_common.c
>> +++ b/tools/testing/vsock/msg_zerocopy_common.c
>> @@ -14,16 +14,6 @@
>>
>> #include "msg_zerocopy_common.h"
>>
>> -void enable_so_zerocopy(int fd)
>> -{
>> -    int val = 1;
>> -
>> -    if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
>> -        perror("setsockopt");
>> -        exit(EXIT_FAILURE);
>> -    }
>> -}
>> -
> 
> Since the new API has a different name (i.e.
> `enable_so_zerocopy_check()`), this `enable_so_zerocopy()` could stay
> here, anyway I don't want to be too picky, I'm totally fine with this
> change since it's now only used by vsock_perf ;-)
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 

Ok, let's keep it static then - it's simpler :-)

