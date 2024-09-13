Return-Path: <netdev+bounces-128170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A091978598
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1DB1F245C9
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1B5644E;
	Fri, 13 Sep 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t1VDzhqY"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9F4A21
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244255; cv=none; b=FpCzyx5Ya71BWRa3gePnT612eRtsuzMwBxl1js1Tpjb0hD2Y6oZVp8QOsgRtZIooB7hyVL5FWxWuKcgzp0U6/+xnD+/mdbYRSh5xl/z1Yk1DnoOtMvwF6P1m5widBwB2wGGFLhjrfCz8Kx46E6hzwmSoI/Dyn8KR1fOtfKpzp4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244255; c=relaxed/simple;
	bh=28q8xbfY7qmXvZ5AdJG3JOz/LrZu1iEyRQgo03T+o7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgPHA9FLPwGbqfVI2cH6ZoNZXxgy6AOW9ujyaLmZlUnNSEmoJQ1hVx1m0PbxmR21fAQkgaf8S7WEONp0y3LiFMJfrJMmsJRWMFGjTOmaD0SHj9YiPOxORJEdKaNYBQIY35Vy4wJTjiyCSy0J254zjFJP+1QVXH1BbbyO71Ik1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t1VDzhqY; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8ee26af-3bd0-48d6-a130-65ceb56f23e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726244250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/yudrrTMbvFtpJWf16FJrES92TDLTd9teFau1I1jpI=;
	b=t1VDzhqYKv1FqGEgbgpvPbtdVUipZEJAgOtlkdIfXb1guM1oeGlBnyiBDcwyoIOqvUQfP0
	ML7A5++KK/9+o9EbI9xb4/JpAcUfrhX1+wQWDuAnzNNA5lVHUOidBnISTbDLxLHAd+4duM
	hvLVO/glueOiDaE2vjzk4OODAYGiILQ=
Date: Fri, 13 Sep 2024 12:17:26 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: Handle threadirqs in __napi_schedule_irqoff
To: Brett Creeley <bcreeley@amd.com>, Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
References: <20240913150954.2287196-1-sean.anderson@linux.dev>
 <CANn89iL-fgyZo=NbyDFA5ebSn4nqvNASFyXq2GVGpCpH049+Lg@mail.gmail.com>
 <e127f072-e034-4d21-a71f-4b140102118f@linux.dev>
 <53a6c904-161b-4665-a0c5-fda1cf838654@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <53a6c904-161b-4665-a0c5-fda1cf838654@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/13/24 12:08, Brett Creeley wrote:
> 
> 
> On 9/13/2024 8:23 AM, Sean Anderson wrote:
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> On 9/13/24 11:16, Eric Dumazet wrote:
>>> On Fri, Sep 13, 2024 at 5:10 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>>>>
>>>> The threadirqs kernel parameter can be used to force threaded IRQs even
>>>> on non-PREEMPT_RT kernels. Use force_irqthreads to determine if we can
>>>> skip disabling local interrupts. This defaults to false on regular
>>>> kernels, and is always true on PREEMPT_RT kernels.
>>>>
>>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>>> ---
>>>>
>>>>   net/core/dev.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>> index 1e740faf9e78..112e871bc2b0 100644
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -6202,7 +6202,7 @@ EXPORT_SYMBOL(napi_schedule_prep);
>>>>    */
>>>>   void __napi_schedule_irqoff(struct napi_struct *n)
>>>>   {
>>>> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>>>> +       if (!force_irqthreads())
>>>>                  ____napi_schedule(this_cpu_ptr(&softnet_data), n);
>>>>          else
>>>>                  __napi_schedule(n);
>>>> -- 
>>>> 2.35.1.1320.gc452695387.dirty
>>>>
>>>
>>> Seems reasonable, can you update the comment (kdoc) as well ?
>>>
>>> It says :
>>>
>>>   * On PREEMPT_RT enabled kernels this maps to __napi_schedule()
>>>   * because the interrupt disabled assumption might not be true
>>>   * due to force-threaded interrupts and spinlock substitution.
>>
>> OK
>>
>>> Also always specify net or net-next for networking patches.
>>
>> Ah, sorry. Should be net-next.
> 
> Is this worthy for a fixes/net tag?

Maybe? Commit 8380c81d5c4f ("net: Treat __napi_schedule_irqoff() as
__napi_schedule() on PREEMPT_RT") originally introduced the condition on
PREEMPT_RT but didn't include any fixes. And that's probably because
there's nothing wrong with the original behavior as long as you add
IRQF_NO_THREAD to your interrupt. Although at the time threadirqs had
existed for a while, so maybe this commit should fix that one.

--Sean

