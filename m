Return-Path: <netdev+bounces-152580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C59F4ACB
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F74167E1E
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ED71E3DF7;
	Tue, 17 Dec 2024 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WB8zxPL6"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B81D5CCC
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437827; cv=none; b=WlkvSs8Un5YRHOTOYnLYEfonhuX5N4nNQrvD+klxix5cqh8qe3tUpfRZF38qi8ShZ4pkrv07wEYjEiwxAyMNsm4nO4mZto+c3kaLndItD+LISDD3QmH3LXFdpr3RlsLgiEoDtoJaKwqMlZrfUW6+QNtDtwEYTb9uJlznhA2qz7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437827; c=relaxed/simple;
	bh=pjSqrFL3WwXD6XVXQCRhlupEztYsDI/gFU6vfcMSDHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2oikgKkk8Xikx7tBEYIo/gRidcQgFKNsnBWHYlfpB+MNWZWDyQuRvN2UwZ3wv5eKPsjD7CwmMr6WueLDsB4vi+c8Fywn519CFVCCNSP0rxqLjhOl5ChOopIJ09qOMtmHueVhPeDir40tlGiVivZxN55wyKi4WYLP/Cfsf1ojnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WB8zxPL6; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734437821; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+PIQh1CXo+0E6rdeHPy6/gIbDP7BREpZG9obuVRqPj0=;
	b=WB8zxPL6+wvskHhEP3kdM4wxw5kO9M8J9KokWhJb1nPo4jJhH+jt+dgyRmhUPyN0OwTO/lkUFgFPfAkwvH1olmS+QZ5LjvVJxfkaEmwI2qQJJCIvYRuXEhTt2MtkOAZQL8kE//3NUkN41gs6JfvMKktwU4/Tp7/g5pvJ+5zBeSM=
Received: from 30.221.128.118(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WLjC7oN_1734437820 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Dec 2024 20:17:01 +0800
Message-ID: <1b6c15ec-64ce-4d7f-8b36-6faacc038b55@linux.alibaba.com>
Date: Tue, 17 Dec 2024 20:16:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: fix l4 hash after reconnect
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Fred Chen <fred.cc@alibaba-inc.com>,
 Cambda Zhu <cambda@linux.alibaba.com>, Willem de Bruijn
 <willemb@google.com>, Stefano Brivio <sbrivio@redhat.com>
References: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
 <20241210165928.6934188e@kernel.org>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <20241210165928.6934188e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/11 08:59, Jakub Kicinski wrote:
> On Fri,  6 Dec 2024 16:49:14 +0100 Paolo Abeni wrote:
>> After the blamed commit below, udp_rehash() is supposed to be called
>> with both local and remote addresses set.
>>
>> Currently that is already the case for IPv6 sockets, but for IPv4 the
>> destination address is updated after rehashing.
>>
>> Address the issue moving the destination address and port initialization
>> before rehashing.
>>
>> Fixes: 1b29a730ef8b ("ipv6/udp: Add 4-tuple hash for connected socket")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> I feel obliged to point out a lack of selftest both here and the series
> under Fixes :(

Sorry for the late reply.

Though I'm glad to add selftests, I don't have a good idea how to do it 
decently. Because the series (say uhash4) will take effect silently for 
connected udp sockets without any api change.

Maybe it's better to add KUnit tests for it? or any other suggestions?

Thanks.
-- 
Philo


