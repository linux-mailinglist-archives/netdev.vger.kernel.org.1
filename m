Return-Path: <netdev+bounces-121486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B96595D62F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1C51C20F87
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF0F191F80;
	Fri, 23 Aug 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="KJ4JKBJF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4A5374F6;
	Fri, 23 Aug 2024 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724442233; cv=none; b=DOvXdVLv+uaKpu4LqNLCWpACyS9mLAsOC+Kyjb+KkUK9HenmlCG9qiK1LfW4Fl8VNrr05asZQAICx8RcRSSFBdvU6MYFhCgnv+jXmIgXVl0vy39PhbXVRskm8ZkVFCw/Xn/sbXNGpWnL2Xr1t9Aw+00KS3uaWwdUz+vlzeUDo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724442233; c=relaxed/simple;
	bh=Btaro2Qiai6A7CzeUMkggAooimXU1sAVfClzJf4PG5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aA7k4bGDesv45dMuq7TEGghLvlRP7OCJqwacIYmQ0pBKE+bvFV65WkdGPS36rt2kFJZo41dvwfBV289c1IATHTfSMaKeqci7J9F9CC4KPOKXXXr+FifuLJooLxUuxttWvUskEUgWxkFCX9BSSbgKZr87Cd3t0lgx3ONfgnktJAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=KJ4JKBJF; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
	by m0050096.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 47NIJIZM004354;
	Fri, 23 Aug 2024 20:43:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=XzG6HZ73bnZdBGfIo2FN4SLx9LhGptyboPpkY4yLGy0=; b=KJ4JKBJFdwJ2
	mlA3PrUGnn1vbj8nuMVX+9kf/rS//trVXZiJPTo4Igyl/pEd6XcWEmmRibhfz320
	3iGE9pho+z3kAWMXYT92FBeSbyW5rpsgtb8/7OJgcQvdyTi1nLzU9VidxlmxJ5oK
	lTy2QzB4c4lYhAf6ZSTEC0U/gGSnyJgpjEru0Ic2JgwUtZzJvAMlfFY9Dlv94g6f
	YEj1UViJzCUlOg8oQ/JLvTAVxDMtwECMaG8rkc1Qr1IXCY6kJrN2eyr9MViPtts6
	EMynbVpv8vJg9yixgKMLsSt2a6xQEFCATKREH8GO5Yj8ftSUZ4tFIE002liOFN1h
	XRxR8Dt9jA==
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
	by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4149pgkpw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 20:43:41 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
	by prod-mail-ppoint3.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 47NJcsLA014518;
	Fri, 23 Aug 2024 15:43:40 -0400
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
	by prod-mail-ppoint3.akamai.com (PPS) with ESMTP id 4138s0j8m5-1;
	Fri, 23 Aug 2024 15:43:40 -0400
Received: from [100.64.0.1] (unknown [172.27.166.123])
	by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id 21329389;
	Fri, 23 Aug 2024 19:43:37 +0000 (GMT)
Message-ID: <a76ac35a-9be2-4849-985c-2f3b2a922fa5@akamai.com>
Date: Fri, 23 Aug 2024 12:43:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240823033444.1257321-1-johunt@akamai.com>
 <20240823033444.1257321-2-johunt@akamai.com>
 <CANn89iJ7uOFshDP_VE=OSKqkw_2=9iuRpHNUV_kzHhP-Xh2icg@mail.gmail.com>
Content-Language: en-US
From: Josh Hunt <johunt@akamai.com>
In-Reply-To: <CANn89iJ7uOFshDP_VE=OSKqkw_2=9iuRpHNUV_kzHhP-Xh2icg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408230144
X-Proofpoint-ORIG-GUID: PdfIPermMux2ctHnFxdM7MvTKlUUrNhv
X-Proofpoint-GUID: PdfIPermMux2ctHnFxdM7MvTKlUUrNhv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=964 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230145



On 8/22/24 11:55 PM, Eric Dumazet wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
> 
> On Fri, Aug 23, 2024 at 5:34 AM Josh Hunt <johunt@akamai.com> wrote:
>>
>> There have been multiple occassions where we have crashed in this path
>> because packets_out suggested there were packets on the write or retransmit
>> queues, but in fact there weren't leading to a NULL skb being dereferenced.
>> While we should fix that root cause we should also just make sure the skb
>> is not NULL before dereferencing it. Also add a warn once here to capture
>> some information if/when the problem case is hit again.
>>
>> Signed-off-by: Josh Hunt <johunt@akamai.com>
> 
> Hi Josh
> 
> We do not want a patch series of one patch, with the stack trace in
> the cover letter.
> Please send a standalone patch, with all the information in its changelog.
> 
> 1) Add Neal Cardwell in the CC list.
> 
> 2) Are you using TCP_REPAIR by any chance ?
> 
> 3) Please double check your kernel has these fixes.
> 
> commit 1f85e6267caca44b30c54711652b0726fadbb131    tcp: do not send
> empty skb from tcp_write_xmit()
> commit 0c175da7b0378445f5ef53904247cfbfb87e0b78     tcp: prohibit
> TCP_REPAIR_OPTIONS if data was already sent
> 

Thanks Eric. I will resend and also check the commits you mentioned. I 
didn't include the writeup in the patch submission b/c it was rather 
long and detailed, but will include it in a v2.

Josh

