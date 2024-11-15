Return-Path: <netdev+bounces-145195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB179CDA80
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DDC1F23708
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65281189919;
	Fri, 15 Nov 2024 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="GvOBUsev"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E24317C;
	Fri, 15 Nov 2024 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659529; cv=none; b=TJQH2CYMl+me2lsvpsZavCT9TShbTSse9mkF5iD4+78JWKjB9scu1NOvd0LZEo0HoUcLvVmYGD3DrlaYZIwgK7OW5lkkt8chBo+mkKM7Fovn/9JVVcwE1+itYGftvEh445gSUnXy8JiYXDsboVKOa1Ew8xbyrzMH0kc5v7DGnmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659529; c=relaxed/simple;
	bh=Ft9o+8IN3dR7zbe+yx515zUiuduyfuQwiMP4dzTo3io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPjOe9gqz0tlzEkp+CH1q7VijHdf5FdR6N0NNUwSoe6muTlaZDtc0sSFmmUj+8vdDk9if84Qs6SGNLYwE8pU9rC+Er6QnbHGvBh6qm3amldRtdq9MkZYSnzBzMmKkHo6EMmEKEiGxvqmtO4qGm5og0/gTdJRquo66O+TAq1iAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=GvOBUsev; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tBrkD-0077UP-P2; Fri, 15 Nov 2024 09:31:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=yqG1zxisn2LWsL+t6aF9uz0Ph7aK0bj7aXBWlAlzRag=; b=GvOBUsevAtuNwWJLpWYNk68lL4
	EnEbylUdWFK8pvtoofV+DW2e0g5qGMM4h0wdq0xa8vWyg+ZNTEyaUB1xJ7+K5mTnlx2ki9OOm1F4S
	RH1gv+d+xw7CA2ImPjL2Djcqd7jqskE6gTjTwqySSv8oqV1B7AGYO/IxAnexJHqgbs2+GgDtxKgKS
	EuCoBXrg+cK/pdIKCdrUwhPLKNoOCcWBjlchBIg291UqoP96BBvtyVOr1UmQvmc0mBT+YfL20lPtw
	8nHPnykyWXXqNWHyPk/CRlpMIC8U9wEm2W2UEcgEo6aAHH2Q+V6I5m7HcxHTkFgVXHkfmk1r7V62V
	jDF+kJ+w==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tBrkC-0004eG-8g; Fri, 15 Nov 2024 09:31:56 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tBrju-00AATW-SW; Fri, 15 Nov 2024 09:31:38 +0100
Message-ID: <02c01b54-ad82-4ae0-b4fd-db1b7687efa0@rbox.co>
Date: Fri, 15 Nov 2024 09:31:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] bluetooth: Improve setsockopt() handling of
 malformed user input
To: David Wei <dw@davidwei.uk>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
 <20241115-sockptr-copy-fixes-v1-1-d183c87fcbd5@rbox.co>
 <156ce25b-4344-40cd-9c72-1a45e8f77b38@davidwei.uk>
 <CABBYNZLbR22cWaXA4YNwtE8=+VfdGYR5oN6TSJ-MwXCuP3=6hw@mail.gmail.com>
 <970c7945-3dc4-4f07-94d5-19080efb2f21@davidwei.uk>
 <CABBYNZL_awaZOKpsAyOaAbtnJLobJ1bQpF_9JNxpiyQg5P5q1Q@mail.gmail.com>
 <4292b59f-7956-4c37-8909-ecb2261687b1@davidwei.uk>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <4292b59f-7956-4c37-8909-ecb2261687b1@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/15/24 04:04, David Wei wrote:
> On 2024-11-14 18:50, Luiz Augusto von Dentz wrote:
>> Hi David,
>> On Thu, Nov 14, 2024 at 9:30 PM David Wei <dw@davidwei.uk> wrote:
>>> On 2024-11-14 18:15, Luiz Augusto von Dentz wrote:
>>>> Hi David,
>>>> On Thu, Nov 14, 2024 at 7:42 PM David Wei <dw@davidwei.uk> wrote:
>>>>> On 2024-11-14 15:27, Michal Luczaj wrote:
>>>>> ...
>>>>>> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
>>>>>> index f48250e3f2e103c75d5937e1608e43c123aa3297..1001fb4cc21c0ecc7bcdd3ea9041770ede4f27b8 100644
>>>>>> --- a/net/bluetooth/rfcomm/sock.c
>>>>>> +++ b/net/bluetooth/rfcomm/sock.c
>>>>>> @@ -629,10 +629,9 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
>>>>>>
>>>>>>       switch (optname) {
>>>>>>       case RFCOMM_LM:
>>>>>> -             if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
>>>>>> -                     err = -EFAULT;
>>>>>> +             err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
>>>>>> +             if (err)
>>>>>>                       break;
>>>>>> -             }
>>>>>
>>>>> This will return a positive integer if copy_safe_from_sockptr() fails.
>>>>
>>>> What are you talking about copy_safe_from_sockptr never returns a
>>>> positive value:
>>>>
>>>>  * Returns:
>>>>  *  * -EINVAL: @optlen < @ksize
>>>>  *  * -EFAULT: access to userspace failed.
>>>>  *  * 0 : @ksize bytes were copied
>>>
>>> Isn't this what this series is about? copy_from_sockptr() returns 0 on
>>> success, or a positive integer for number of bytes NOT copied on error.
>>> Patch 4 even updates the docs for copy_from_sockptr().
>>>
>>> copy_safe_from_sockptr()
>>>         -> copy_from_sockptr()
>>>         -> copy_from_sockptr_offset()
>>>         -> memcpy() for kernel to kernel OR
>>>         -> copy_from_user() otherwise
>>
>> Well except the safe version does check what would otherwise cause a
>> positive return by the likes of copy_from_user and returns -EINVAL
>> instead, otherwise the documentation of copy_safe_from_sockptr is just
>> wrong and shall state that it could return positive as well but I
>> guess that would just make it as inconvenient so we might as well
>> detect when a positive value would be returned just return -EFAULT
>> instead.
> 
> Yes it checks and returns EINVAL, but not EFAULT which is what my
> comment on the original patch is about. Most of the calls to
> bt_copy_from_sockptr() that Michal replaced with
> copy_safe_from_sockptr() remain incorrect because it is assumed that
> EFAULT is returned. Only rfcomm_sock_setsockopt_old() was vaguely doing
> the right thing and the patch changed it back to the incorrect pattern:
> 
> err = copy_safe_from_sockptr(...);
> if (err)
> 	break;
> 
> But I do agree that making copy_safe_from_sockptr() do the right thing
> and EFAULT will be easier and prevent future problems given that
> copy_from_sockptr() is meant to be deprecated anyhow.

Just to be clear: copy_safe_from_sockptr() was recently fixed to return
EFAULT:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=eb94b7bb1010
Sorry, I should have mentioned this series is a follow up to that patch.

Thanks,
Michal


