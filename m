Return-Path: <netdev+bounces-149882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B2E9E7E0B
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 03:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0AD16C1BA
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 02:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF22A1A270;
	Sat,  7 Dec 2024 02:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ycIfWRwO"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1F22C6E3
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733538853; cv=none; b=ijUr3/76oH59UdmIoVxKqGJl+EbKn7c3vIZ5bYgtbjG+az6c9ETVAjbtHNYOeObOoKK4hmF74Ye1W77joBDN0ME2g6xAJ3Yw9XqU8HB+8iRJo78AoA2IytTRULvbIGq75is0+5oBo2NrVYrBrHxxjnHoESv8nzZgLYz6xk2MVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733538853; c=relaxed/simple;
	bh=rZtXF6nUeqVJDOtQKYYUn2T0JzhI2741vdapq8Y4rTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7dwXN8HCpPsAO5Za8TXT1MkMVkgRUVDYoTRtFfrDXwPEDz7CdmbU2fnUBzDO99bGnYr82G+ykE4MYOWjGqHm6E/gzJPUkTZtxodakftXpjxkS2BPgCU226th1gOuMMuDqaAb7H0RU4hlwjBryFGCytEQzMUMyliMm8dYqGq1jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ycIfWRwO; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733538847; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sixjUPmOZQmsNBTPuQA9NxMZgBY1d55YbSGZ5qTrSEw=;
	b=ycIfWRwOl2m9CwA93wKjWmIFu4cfg4UkH/eQLxMHnYCLMeoSX5SykiU3s7/fjdvfYnXY6D7Om71IS3OVIxgTR8z67NZzEGlwrl6um7DcDSwbgMh7vv9j0ItFAeJme76qhBtOo28rIOFyAg+xa76+Dd75Rx7AAyINTjJb7x7llbM=
Received: from 30.251.119.164(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WKy9VVZ_1733538845 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 07 Dec 2024 10:34:07 +0800
Message-ID: <a4085013-daaf-4141-af56-cd438bf8b4c9@linux.alibaba.com>
Date: Sat, 7 Dec 2024 10:34:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: fix l4 hash after reconnect
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Fred Chen <fred.cc@alibaba-inc.com>,
 Cambda Zhu <cambda@linux.alibaba.com>, Willem de Bruijn
 <willemb@google.com>, Stefano Brivio <sbrivio@redhat.com>
References: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
 <CANn89i+aKNhzYKo3H3gx5Uhy4iPQ4p=6WDDF-0brGyR=PzJqjQ@mail.gmail.com>
 <CANn89i+k11E9XeJZwvgZ7VO0yr1nWge8+U-ESw2GLYDq7-sdBw@mail.gmail.com>
 <b46a7757-f311-4656-a114-68381d9856e3@redhat.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <b46a7757-f311-4656-a114-68381d9856e3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/7 00:23, Paolo Abeni wrote:
> On 12/6/24 17:01, Eric Dumazet wrote:
>> On Fri, Dec 6, 2024 at 4:57 PM Eric Dumazet <edumazet@google.com> wrote:
>>> On Fri, Dec 6, 2024 at 4:50 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>
>>>> After the blamed commit below, udp_rehash() is supposed to be called
>>>> with both local and remote addresses set.
>>>>
>>>> Currently that is already the case for IPv6 sockets, but for IPv4 the
>>>> destination address is updated after rehashing.
>>>>
>>>> Address the issue moving the destination address and port initialization
>>>> before rehashing.
>>>>
>>>> Fixes: 1b29a730ef8b ("ipv6/udp: Add 4-tuple hash for connected socket")
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for this fix :)

>>>
>>> Nice catch, thanks !
>>>
>>> Reviewed-by: Eric Dumazet <edumazet@google.com>
>>
>> BTW, it seems that udp_lib_rehash() does the udp_rehash4()
>> only if the hash2 has changed.
> 
> Oh, you are right, that requires a separate fix.
> 
> @Philo: could you please have a look at that? basically you need to
> check separately for hash2 and hash4 changes.

This is a good question. IIUC, the only affected case is when trying to 
re-connect another remote address with the same local address (i.e., 
hash2 unchanged). And this will be handled by udp_lib_hash4(). So in 
udp_lib_rehash() I put rehash4() inside hash2 checking, which means a 
passive rehash4 following rehash2.

So I think it's more about the convention for rehash. We can choose the 
better one.

Thanks.
-- 
Philo


