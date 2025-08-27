Return-Path: <netdev+bounces-217338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25551B385C1
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96A5206EFE
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1EF24A046;
	Wed, 27 Aug 2025 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1sbG5+5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0502D7BF
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307226; cv=none; b=VR+IxxejqrJRL7dkwOJVA5NS3uD0PQH6ir5M9crdVShhobcbsAEZVI/czb6SuBDxFteKeMXcAh8/hBUIllAb6FNn4apQsMBOMmUd70YRbP9rCIp1R19ue3zd4bSWAbTmdrAoxkriw8o6H+HrZHiHfOPW2la4+gMGbogJbwyrjvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307226; c=relaxed/simple;
	bh=w+osgCjM+K0Nby+dea+urEvfhmOniFlhzFbofUF9giI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcXOM6UYD+DMTy1Xu3JA3X1FgS+PoV7jnBKUDJzLtLsXxgXUVlJ1mFU23/Y0lWcQdrgOZdQfBR+Y4DLiC5YqJ8IRxt160R+YjPcgnzkPyuYEAk/BA0u7p/z0PH6BEoGlNAy2AkHA9tG3F78HK8L4UFgvg9fjVzOhgC1RWu17jOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1sbG5+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53CEC4CEEB;
	Wed, 27 Aug 2025 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756307226;
	bh=w+osgCjM+K0Nby+dea+urEvfhmOniFlhzFbofUF9giI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L1sbG5+5BFvgeLYmDYPdV40yuvejVw6N1uYb0k4nAp46KeEaa5EOF8t60ymeSEt2W
	 Fq+wuNNiKQvwq2CSmsdF0qKH4qDpWLev5k6VVLbw+gqItTD/NxUCV1l8EjqBuek4XV
	 B1ul2WKmjxtrW5euYYcN/ENPqTsn7P4ebwsQ7+CAxvfSdBMAtpWO0zcyqasBkVoYjQ
	 E5Rur/nPju/103iBL72o7dq9EKORyxeOOg5fMt3iotgRDB+3Fvks2+B1gKWem0Djkp
	 MzaWVR4ZP5QC7HPIzj35b37Eu4PA5wAtPEY02/1zpBh8pK1VxoWlAF51WfeGJdVvtB
	 GfqDEkDL5tADg==
Message-ID: <d2739db2-74bd-4c1f-8f8a-ffaa70f227dd@kernel.org>
Date: Wed, 27 Aug 2025 09:07:05 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] inet: ping: make ping_port_rover per netns
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250827120503.3299990-1-edumazet@google.com>
 <20250827120503.3299990-4-edumazet@google.com>
 <8f2d8a47-4531-4d3b-9a64-cf9477b7b41f@kernel.org>
 <CANn89iKdv2OfNm2=iRW6vGqOUsxZbDf9vZ5DdagkFTZzXoPQQQ@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iKdv2OfNm2=iRW6vGqOUsxZbDf9vZ5DdagkFTZzXoPQQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/27/25 9:00 AM, Eric Dumazet wrote:
> On Wed, Aug 27, 2025 at 7:57 AM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 8/27/25 6:05 AM, Eric Dumazet wrote:
>>> @@ -84,12 +82,12 @@ int ping_get_port(struct sock *sk, unsigned short ident)
>>>       isk = inet_sk(sk);
>>>       spin_lock(&ping_table.lock);
>>>       if (ident == 0) {
>>> +             u16 result = net->ipv4.ping_port_rover + 1;
>>>               u32 i;
>>> -             u16 result = ping_port_rover + 1;
>>>
>>>               for (i = 0; i < (1L << 16); i++, result++) {
>>>                       if (!result)
>>> -                             result++; /* avoid zero */
>>> +                             continue; /* avoid zero */
>>>                       hlist = ping_hashslot(&ping_table, net, result);
>>>                       sk_for_each(sk2, hlist) {
>>>                               if (!net_eq(sock_net(sk2), net))
>>> @@ -101,7 +99,7 @@ int ping_get_port(struct sock *sk, unsigned short ident)
>>>                       }
>>>
>>>                       /* found */
>>> -                     ping_port_rover = ident = result;
>>> +                     net->ipv4.ping_port_rover = ident = result;
>>
>> READ_ONCE above and WRITE_ONCE here?
> 
> Note we hold ping_table.lock for both the read and write,
> so there is no need for READ_ONCE() or WRITE_ONCE() here.
> 
> Thank you !

missed that.

Reviewed-by: David Ahern <dsahern@kernel.org>


