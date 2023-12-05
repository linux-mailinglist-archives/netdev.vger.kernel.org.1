Return-Path: <netdev+bounces-53706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B438043C7
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A98C2812F5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED09910F4;
	Tue,  5 Dec 2023 01:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPgdtvmc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE99310E8
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 01:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A21C433C8;
	Tue,  5 Dec 2023 01:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701738520;
	bh=UgcL2R9C0bhYJdJ2rSepl0vFYdW6GWqKcBPVUBMjf20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aPgdtvmcipZ5lh98Nr929Of0FRtC+TqZqj5ZKTO9Wrj4sME5iA/e0tWB9+5JqAy+0
	 rUh1kJiOrQDngq6i0pFM3fMZobyCYxKsTNziDR0tJFlueNKw9cz4xUBSZpvaDsxorF
	 6xGAamazrJs9Ao5bv/+pF/jTxxXLT4pDiLC8nO8b/5dt/7u4grf41OzhjP4oSKWUsZ
	 +1ZHh6zriZW+zFLUw921wy1FtdOulgrhfcWFb+LWgzYfIu6zVmxmHlRgsrw8rPspHG
	 4O0wRM0b/HsV2Y4IJshcHuOAunhv+Gtn6Ld0BrlJp6Ft70AjDmcYr0/SHZrNhu3wIk
	 G/OQODMgc+A/w==
Message-ID: <4b095b1c-9fa8-4df9-846b-c33c01e15d97@kernel.org>
Date: Mon, 4 Dec 2023 18:08:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
Content-Language: en-US
To: Doug Anderson <dianders@chromium.org>, Eric Dumazet <edumazet@google.com>
Cc: Judy Hsiao <judyhsiao@chromium.org>, Simon Horman <horms@kernel.org>,
 Brian Haley <haleyb.dev@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Joel Granados <joel.granados@gmail.com>,
 Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20231201083926.1817394-1-judyhsiao@chromium.org>
 <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
 <CAD=FV=VqmkydL2XXMWNZ7+89F_6nzGZiGfkknaBgf4Zncng1SQ@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAD=FV=VqmkydL2XXMWNZ7+89F_6nzGZiGfkknaBgf4Zncng1SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/4/23 4:40 PM, Doug Anderson wrote:
> Hi,
> 
> On Fri, Dec 1, 2023 at 1:10 AM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Fri, Dec 1, 2023 at 9:39 AM Judy Hsiao <judyhsiao@chromium.org> wrote:
>>>
>>> We are seeing cases where neigh_cleanup_and_release() is called by
>>> neigh_forced_gc() many times in a row with preemption turned off.
>>> When running on a low powered CPU at a low CPU frequency, this has
>>> been measured to keep preemption off for ~10 ms. That's not great on a
>>> system with HZ=1000 which expects tasks to be able to schedule in
>>> with ~1ms latency.
>>
>> This will not work in general, because this code runs with BH blocked.
>>
>> jiffies will stay untouched for many more ms on systems with only one CPU.
>>
>> I would rather not rely on jiffies here but ktime_get_ns() [1]
>>
>> Also if we break the loop based on time, we might be unable to purge
>> the last elements in gc_list.
>> We might need to use a second list to make sure to cycle over all
>> elements eventually.
>>
>>
>> [1]
>> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
>> index df81c1f0a57047e176b7c7e4809d2dae59ba6be5..e2340e6b07735db8cf6e75d23ef09bb4b0db53b4
>> 100644
>> --- a/net/core/neighbour.c
>> +++ b/net/core/neighbour.c
>> @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>>  {
>>         int max_clean = atomic_read(&tbl->gc_entries) -
>>                         READ_ONCE(tbl->gc_thresh2);
>> +       u64 tmax = ktime_get_ns() + NSEC_PER_MSEC;
>>         unsigned long tref = jiffies - 5 * HZ;
>>         struct neighbour *n, *tmp;
>>         int shrunk = 0;
>> +       int loop = 0;
>>
>>         NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
>>
>> @@ -279,10 +281,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>>                         if (shrunk >= max_clean)
>>                                 break;
>>                 }
>> +               if (++loop == 16) {
>> +                       if (ktime_get_ns() > tmax)
>> +                               goto unlock;
>> +                       loop = 0;
>> +               }
>>         }
>>
>>         WRITE_ONCE(tbl->last_flush, jiffies);
>>
>> +unlock:
>>         write_unlock_bh(&tbl->lock);
> 
> I'm curious what the plan here is. Your patch looks OK to me and I
> could give it a weak Reviewed-by, but I don't know the code well
> enough to know if we also need to address your second comment that we
> need to "use a second list to make sure to cycle over all elements
> eventually". Is that something you'd expect to get resolved before
> landing?
> 
> Thanks! :-)

entries are added to the gc_list at the tail, so it should be ok to take
a break. It will pickup at the head on the next trip through.


