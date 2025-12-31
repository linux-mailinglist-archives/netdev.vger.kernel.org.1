Return-Path: <netdev+bounces-246440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0B3CEC2C7
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 16:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2CC830012E6
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE58238C16;
	Wed, 31 Dec 2025 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x8OwmftH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B01C84A2
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767195045; cv=none; b=dJctmtHtvWtJsD1WGLj437fqsBri5xJxl6AOF/3Q3R+vgQ3m7sLjWzWTK4IOzmyrLaiC7TYG5vOG/grvt+vdADZw2OzyXYXY/ySwggeDmAXvQViR1jJvI2G+v4CtvLL+U/gaoERFwRi+FIUjMtkPEDsDAU8v0jFIf/hNJDeE7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767195045; c=relaxed/simple;
	bh=KWWp0xZSY8+36QmbdtqFRXm7XYgM59788IrwS+osbBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akU2MRXGxxXB51BdlNzdRF+DR915Nd7rWR9EQlkDrzHK9GX0wKwgfp+d9R91yKJiNfrE9Q2izfzZHOI/JdB9uWQSe16CLrmZUD4VMkWgN2cqa+E5RjEL0YyIFTqNe+tv38oMR72x97cZRuGl0ZaOreddipNVmPYBHJoM24rx9Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x8OwmftH; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3f5aaa0c8d7so7763468fac.3
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 07:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767195042; x=1767799842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QzVSYweQj11hd6fs/gbMsc1XDMFllelUQ/hmQuDpYw=;
        b=x8OwmftHU/+vIzflRkIlBL9PBd4FFU4oN4oaPJLiejCcBHDi6ET0ImTG96EFKG980P
         xxDU9YOYcEnywTVXKtLZdO6O8k4Ag/M/VU7CuHiA4YHqfu/CJuL7a+8X5v3n234NEcid
         3e8MSlNiQE2dMTnyyZ6OwdfOcODlsFD+GFtkD0UXv2Iw5139MuQAYSbjHnI8p5b652Ui
         Mgmll7eOLrEEiW2RuEOWjS5uUqHuOrdFG2c7UOpx6XIxKxGjxy+uO3fIGwxhkbwUfCwm
         cqSsdijxt2Q/EhQcbcFkEHPsKGbt+lG3kfSZ0+WYdEioIxZQhi0MFpCmnHzO18aRQ1o3
         Mhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767195042; x=1767799842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QzVSYweQj11hd6fs/gbMsc1XDMFllelUQ/hmQuDpYw=;
        b=FP6TWEOiF/tM/CirX/NIUjyS3OapwheSc0bon7K1QYD5q2s8qMZx91q3ZKq/B8T5jc
         o8jAKSR2zTDjLDHjXcVVIih1PBQ7oO/S5gTh6wPLYrL+w+dSjw0m3h58Zz581ZNBJQyd
         95HbnR5zRyxyepsWka7jpjeBkbjLw/PT0j45ugw/OSAOqdjCy3ktbN5jHbM7lVzmsxSm
         c07ragShkkzRmT4hvIi52Oem+1lNpgwI14+JD5sKAcy7wUnI9JDgZp2nKukKKbrEvRwf
         JOAF3iLb9g0cwGA25x6cXYZ2ZpjWGouT12YgX4ULocDNpsMBLyz8A2Gt4+GQbFsnULBz
         oUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8DjfSGKgaWz5VOceQRRf9RNZ0xFBlH877bDqJJS0mnnkvp6OWui6xdJSxJA4h0l/jrA9V1W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsqhIVf41zLq9v1LwgKlJ/CVtaQBkeTco8am6VvL+G6RnGmx7g
	fQyoDll3JKo12zQvrrBcSaaALbJC+7/6rEbQOCygS9DpzZt2pohh8Vr7tQUhRUEdsmk=
X-Gm-Gg: AY/fxX5OPqVn0zn9gWRgDndj+nDCkSCsmtxYaonHRvIOUqdJPXDMvw9ESKILQBrI9bw
	k0QvqO2bydhvLF4+B5NT34dnuYeLHHwLQOYLyxv5ZUNmPQM3vweHGLQ7qfz/raDwK6Va6eyIO4Z
	0lHVYw226bDOEeVBbRdSUVPv76mlbrMzYkWZ4sUYITIeZvHFY1xW+lJAHqe3fluUcqPTW1R7DQO
	uIT5ozH85Fll8tyUQ7nLX5Vs+Zef3tE+R2UOTPLzWMh9LevMvErL98nb4HD5asVUjx64vg2ZJOd
	K0ZzFnhuC0UmhoRVVFFgiH/9QrKGtjCxhGfUZS5G3XIMEstqImVta8ldSq5Y580R9kHcT6W8bDt
	Hxwq1CDUBIATCEUH522ArU3M00As1Pv988/C7zjQ1MtJBefxBUYZzoacQlQQWvpz0BzjDU0laFJ
	P7SeWG1Lso
X-Google-Smtp-Source: AGHT+IFQ7Da3Vy7sb0sZ+gCFV6iNdLzjxsj+GHoPQqPF4ECDqs6GBYGgCjzmLYkOn7cGzscuabT/Ag==
X-Received: by 2002:a4a:e252:0:b0:659:9a49:8fcc with SMTP id 006d021491bc7-65d0ebdd6e8mr11816060eaf.69.1767195042368;
        Wed, 31 Dec 2025 07:30:42 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f4cd66csm20954575eaf.7.2025.12.31.07.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 07:30:41 -0800 (PST)
Message-ID: <4156bbde-754b-470e-9dfb-a1e45bee81fb@kernel.dk>
Date: Wed, 31 Dec 2025 08:30:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/33] block: Protect against concurrent isolated cpuset
 change
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-10-frederic@kernel.org>
 <0f65c4fe-8b10-403d-b5b6-ed33fc4eb69c@kernel.dk>
 <aVUs-mFYCO2qGmqT@localhost.localdomain>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aVUs-mFYCO2qGmqT@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/31/25 7:02 AM, Frederic Weisbecker wrote:
> Le Mon, Dec 29, 2025 at 05:37:29PM -0700, Jens Axboe a ?crit :
>> On 12/24/25 6:44 AM, Frederic Weisbecker wrote:
>>> The block subsystem prevents running the workqueue to isolated CPUs,
>>> including those defined by cpuset isolated partitions. Since
>>> HK_TYPE_DOMAIN will soon contain both and be subject to runtime
>>> modifications, synchronize against housekeeping using the relevant lock.
>>>
>>> For full support of cpuset changes, the block subsystem may need to
>>> propagate changes to isolated cpumask through the workqueue in the
>>> future.
>>>
>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>> ---
>>>  block/blk-mq.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 1978eef95dca..0037af1216f3 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -4257,12 +4257,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>>>  
>>>  		/*
>>>  		 * Rule out isolated CPUs from hctx->cpumask to avoid
>>> -		 * running block kworker on isolated CPUs
>>> +		 * running block kworker on isolated CPUs.
>>> +		 * FIXME: cpuset should propagate further changes to isolated CPUs
>>> +		 * here.
>>>  		 */
>>> +		rcu_read_lock();
>>>  		for_each_cpu(cpu, hctx->cpumask) {
>>>  			if (cpu_is_isolated(cpu))
>>>  				cpumask_clear_cpu(cpu, hctx->cpumask);
>>>  		}
>>> +		rcu_read_unlock();
>>
>> Want me to just take this one separately and get it out of your hair?
>> Doesn't seem to have any dependencies.
> 
> The patch could be applied alone but the rest of the patchset needs it,
> otherwise it may dereference freed memory. So I fear it needs to stay
> within the lot.
> 
> I appreciate the offer though. But an ack would help, even if I must admit
> this single patch (which doesn't change current behaviour) leaves a
> bitter taste because complete handling of cpuset isolated partition change
> will require more work.

That's fine too:

Acked-by: Jens Axboe <axboe@kernel.dk>

> Speaking of, is there a way that I missed to define/overwrite the above
> hctx->cpumask on runtime?

Only spot where it's set/manipulated right now is as part of setting up
the hctx <-> ctx queue mappings, when the queue is configured (or
reconfigured).

-- 
Jens Axboe

