Return-Path: <netdev+bounces-200647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9096DAE67B4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA941920BF9
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C923C2D6603;
	Tue, 24 Jun 2025 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="owz/B+9X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2552E2C326D
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773499; cv=none; b=MOFXBlSLe/QI8U3VqBj8JBO+oWaOHSOd/E0ZJb0gCAH0Ty2Xgt3We4ydAmkh1i05UOz00WHxlab+29g8oubOu541nMFJgw7OAgX8cSnm5rZ+HrdM7DPzgMm9eKFj6eOdSbUtbD5DWiMhl2CeYR/IimvMVr9lpRF7/ZE+B+9fnvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773499; c=relaxed/simple;
	bh=v3sHrdRJzUwMRgAWLGjxNdvI5epcqUcGlCo6M8ar4VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfKIDNEoyNdxJzliCMHJr90xhkscltIYi+cLV48PJ5Cxzbtz4e/dmUh6OQSH4PLWB58ME1VV7LHlZDPuy16HGlqnp15JKthpIa8w12WT0Nr1Bc1hC36Lhr02T6/D105dkvG2gocnzZY6fUtDJxSRR/0kfPIIxREoTGl4IljwKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=owz/B+9X; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 55O7aeLX014809;
	Tue, 24 Jun 2025 14:57:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=cAuBwNbzWFd8wrr6x+eDzwTh0A5Fedb9J3dUEKcdnP0=; b=owz/B+9Xwu7h
	63rbN+In/INL+6anXZooWcX1B6CITZjskL/Ur89oz8eeBvid0H6SrQzgMQJdIsA/
	PwKGUPBpz6mX9sVhfRbrlBCOHkwf/6BVgmigM7AfP4qwXpQnnBWBtT+7dHByOknO
	LSj3cRU5eLz0IegXKKtog9g3l3OS8N4qggEIjbf02AnSW6xd3A3o06VgT204+Xkb
	81q4Z7vNLx2z1TXRwNKuNKlBsJtK/Qj03dD0JS3pa3agbDvRHfOYzjsVhDkGXDu8
	2wZE3Ww9s8iL7pBwCWBs9oJ4Zx/0fUO05D9kCjF7bQlMDOGvKXvftoEtbal19t3W
	GM0nSp5XAw==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 47fqjs4nwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 14:57:56 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 55ODjkaf021272;
	Tue, 24 Jun 2025 09:57:55 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 47fw17838x-1;
	Tue, 24 Jun 2025 09:57:55 -0400
Received: from [172.19.0.36] (unknown [172.19.0.36])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id D8E0833C92;
	Tue, 24 Jun 2025 13:57:54 +0000 (GMT)
Message-ID: <967c9d22-7709-4f9b-aea5-8ad35dd24311@akamai.com>
Date: Tue, 24 Jun 2025 09:57:54 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] netlink: Fix wraparound of
 sk->sk_rmem_alloc
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
        kuniyu@google.com, netdev@vger.kernel.org,
        Kuniyuki Iwashima <kuni1840@gmail.com>
References: <2ead6fd79411342e29710859db0f1f8520092f1f.1750285100.git.jbaron@akamai.com>
 <20250619061427.1202690-1-kuni1840@gmail.com>
 <20250623163551.7973e198@kernel.org>
 <93633df1-fa0c-49d8-b7e9-32ca2761e63f@redhat.com>
Content-Language: en-US
From: Jason Baron <jbaron@akamai.com>
In-Reply-To: <93633df1-fa0c-49d8-b7e9-32ca2761e63f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506240116
X-Proofpoint-ORIG-GUID: T2qP1fkvfezmZsVCwwM8AZVlAiAdA-My
X-Proofpoint-GUID: T2qP1fkvfezmZsVCwwM8AZVlAiAdA-My
X-Authority-Analysis: v=2.4 cv=X+hSKHTe c=1 sm=1 tr=0 ts=685aaee4 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=X7Ea-ya5AAAA:8 a=UVRBRyeysKqsWREIyUsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExNyBTYWx0ZWRfXyfp/BaY5iR3/
 En0jFJy649nPK0I4axNM/bbsnrsNnaio+k7ayXu4A4oCvfdgm8AZEJUnTuA7utet+0F1vtRwxEl
 eZSL5BGjvGgLgnA6QdpJd5jL0WQOuCDmkt6pG0PlWb35C2q0K0y1Q7Lbet1Avl3rA7cQZp02x4h
 HbdiJBL0dQLLQ6keZLUlo5pEGq1iEmGAMUeU89NXcE9v3jbcuDt5w9wVm8zEyC1KdbwUeC3zh6n
 B7J0yZiHxoHuOH9wmWEn6PHaF84/LiOOnWonE9GhpAH5O3UVgoXYwfmKDzkNC64hJoLEcCx6cmK
 LZLyuAejpM7ER7fURqRtYCJQwyNxHbOK5oQZ9T0no1FYZR0zbmC3S3Cy5oajgzpzTO3aLpm0P5d
 hURXRBXIDqN4tZPOTKQsvc50aGYaaE5NI0rP6wM80RqwjxjPOp5v1FCQEcxpFYU+4lo4qDlO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 priorityscore=1501 adultscore=0 mlxlogscore=853 malwarescore=0 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240117



On 6/24/25 3:55 AM, Paolo Abeni wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
> 
> On 6/24/25 1:35 AM, Jakub Kicinski wrote:
>> On Wed, 18 Jun 2025 23:13:02 -0700 Kuniyuki Iwashima wrote:
>>> From: Jason Baron <jbaron@akamai.com>
>>> Date: Wed, 18 Jun 2025 19:13:23 -0400
>>>> For netlink sockets, when comparing allocated rmem memory with the
>>>> rcvbuf limit, the comparison is done using signed values. This means
>>>> that if rcvbuf is near INT_MAX, then sk->sk_rmem_alloc may become
>>>> negative in the comparison with rcvbuf which will yield incorrect
>>>> results.
>>>>
>>>> This can be reproduced by using the program from SOCK_DIAG(7) with
>>>> some slight modifications. First, setting sk->sk_rcvbuf to INT_MAX
>>>> using SO_RCVBUFFORCE and then secondly running the "send_query()"
>>>> in a loop while not calling "receive_responses()". In this case,
>>>> the value of sk->sk_rmem_alloc will continuously wrap around
>>>> and thus more memory is allocated than the sk->sk_rcvbuf limit.
>>>> This will eventually fill all of memory leading to an out of memory
>>>> condition with skbs filling up the slab.
>>>>
>>>> Let's fix this in a similar manner to:
>>>> commit 5a465a0da13e ("udp: Fix multiple wraparounds of sk->sk_rmem_alloc.")
>>>>
>>>> As noted in that fix, if there are multiple threads writing to a
>>>> netlink socket it's possible to slightly exceed rcvbuf value. But as
>>>> noted this avoids an expensive 'atomic_add_return()' for the common
>>>> case.
>>>
>>> This was because UDP RX path is the fast path, but netlink isn't.
>>> Also, it's common for UDP that multiple packets for the same socket
>>> are processed concurrently, and 850cbaddb52d dropped lock_sock from
>>> the path.
>>
>> To be clear -- are you saying we should fix this differently?
>> Or perhaps that the problem doesn't exist? The change doesn't
>> seem very intrusive..
> 
> AFAICS the race is possible even with netlink as netlink_unicast() runs
> without the socket lock, too.
> 
> The point is that for UDP the scenario with multiple threads enqueuing a
> packet into the same socket is a critical path, optimizing for
> performances and allowing some memory accounting inaccuracy makes sense.
> 
> For netlink socket, that scenario looks a patological one and I think we
> should prefer accuracy instead of optimization.
> 
> Thanks,
> 
> Paolo
> 

Hi,

Since the current netlink code already allows memory allocation to 
slightly exceed rcvbuf even when there is no overflow, I didn't think we 
would want to change this especially for smaller buffers as it may cause 
a regression. I tried to preserve this behavior if you look at the 
__sock_rcvbuf_has_space() function in patch 1/3.

For larger buffers, I think accurate accounting could make sense, but I 
thought it made more sense to try and optimize this common case as 
Kuniyuki Iwashima did, consolidate code between multiple use-cases and 
not overly special case handling for large buffers.

Thanks,

-Jason



