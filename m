Return-Path: <netdev+bounces-204892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFD5AFC6B4
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5547C3A3E72
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278C31E376E;
	Tue,  8 Jul 2025 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="/ES0fewb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972FD1D5150;
	Tue,  8 Jul 2025 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965691; cv=none; b=frkk4NpZUlLxAcRw2ZA1cDWd2O1XidBUcNxbwhuiQQDuv252mq73/26v4FMWxd2aBY6p24XFH1FkbZyZXUjuio5WHdfaxN2JiaTwD/z3tCkZr1H6YwbdcgtyrxqboRAFuMYsGV+yMVHrecvqHadRnP4OgUVabfyKA8kWnRz2EXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965691; c=relaxed/simple;
	bh=3bRyRlRrZR9k8NH7omLwxN/7e8n86lC7Jh/MTrOJTT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IV/kj0VWbcwXxoqGFZvtTSoBnBf4qQsyqLwqxEpulL43HbQb+GQh/8/KQLKQu5kEph2SNrGZHBtA0azVE55B5rdaKJKqYNVXN64fb4X5383aaguE2P8T7jXgOGfjbKcw4ignaOpVLrC6QrYSxNYnanyZgOv+SjDESzGbSrlxh9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=/ES0fewb; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1751965686; x=1752570486; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=qmx/ei4aNZgcLguOQ4boGu+NqIav7okmG1X2YMA4xeI=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=/ES0fewbTc8qvZvKGOBlApOS/TQ48g8rL56YC8P5YmBnrmrZFFzZ9piECRwsa81NC5z6RsOEL8s82DTs5RyHV1BYqmi04tMl9ZVZ38VfUCifQ8JghdnVYJN3M9pK6amhDa5Lugi/ZO7ozK+O2jDsdrp9w3lKUFdFQ4hz88sr71w=
Received: from [10.0.5.28] ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202507081108055862;
        Tue, 08 Jul 2025 11:08:05 +0200
Message-ID: <4a8ce60d-fd28-4df9-b568-99964fed837c@cdn77.com>
Date: Tue, 8 Jul 2025 11:08:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: account for memory pressure signaled by
 cgroup
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Christian Hopps <chopps@labn.net>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 Matyas Hurtik <matyas.hurtik@cdn77.com>
References: <20250707105205.222558-1-daniel.sedlak@cdn77.com>
 <CANn89i+=haaDGHcG=5etnNcftKM4+YKwdiP6aJfMqrWpDgyhvg@mail.gmail.com>
 <825c60bd-33cf-443f-a737-daa2b34e6bea@cdn77.com>
 <CANn89iKQQ4TFx9Ch9pyDJro=tchVtySQfJTygCxjRP+zPkZfgg@mail.gmail.com>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <CANn89iKQQ4TFx9Ch9pyDJro=tchVtySQfJTygCxjRP+zPkZfgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A00639A.686CE009.001B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

On 7/8/25 9:01 AM, Eric Dumazet wrote:
> On Mon, Jul 7, 2025 at 11:45 PM Daniel Sedlak <daniel.sedlak@cdn77.com> wrote:
>>
>> Hi Eric,
>> Thank you for your feedback.
>>
>> On 7/7/25 2:48 PM, Eric Dumazet wrote:
>>> On Mon, Jul 7, 2025 at 3:55 AM Daniel Sedlak <daniel.sedlak@cdn77.com> wrote:
>>>>
>>>> Currently, we have two memory pressure counters for TCP sockets [1],
>>>> which we manipulate only when the memory pressure is signalled through
>>>> the proto struct [2].
>>>>
>>>> However, the memory pressure can also be signaled through the cgroup
>>>> memory subsystem, which we do not reflect in the netstat counters.
>>>>
>>>> This patch adds a new counter to account for memory pressure signaled by
>>>> the memory cgroup.
>>>
>>> OK, but please amend the changelog to describe how to look at the
>>> per-cgroup information.
>>
>> Sure, I will explain it more in v2. I was not sure how much of a
>> "storytelling" is appropriate in the commit message.
>>
>>
>>> I am sure that having some details on how to find the faulty cgroup
>>> would also help.
>>
>> Right now, we have a rather fragile bpftrace script for that, but we
>> have a WIP patch for memory management, which will expose which cgroup
>> is having "difficulties", but that is still ongoing work.
>>
>> Or do you have any suggestions on how we can incorporate this
>> information about "this particular cgroup is under pressure" into the
>> net subsystem? Maybe a log line?
> 
> Perhaps an additional trace point ?

Sounds good to me, we will incorporate that and send v2.
> 
> Ideally we could trace the cgroup path, or at least the pid.

Will try to do both, we will see.

Thanks!
Daniel

