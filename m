Return-Path: <netdev+bounces-248632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41862D0C64C
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 22:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 628CC301EC4E
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 21:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEB733E35F;
	Fri,  9 Jan 2026 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K0NhceFr"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30533D6E1
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767995620; cv=none; b=ENmt/8uzCKcIDHZCTC95nzjb6UBrYIazy3yFYxHUvMdtXU8zkhIRogcMTokqFY3nwxgi+beG/a0s82zVgCLBe+8WJ0w9oBMWBvG+P/uzltT/E6NvJZn3UXPaxL9xwFjb5dZrx425A2SOQZhuVT88AvsWwbUvUmAmAei9msRJi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767995620; c=relaxed/simple;
	bh=gkxei1XV+7jup5mq3CbS6/u/Lk1Gm3xGtyjrSAmN83U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnp2n3W3xweVhtN3l7F4/aY4y3u3UnMHARGrElFSnjsTSdatn4PKoy+lyfIHnrki5zrliXareIErxJL4afPaGCvgQev9yvPd3VW6hZxrBinAiAvMQzEpsAgbMHmnvgW87inBLdE+ymOA/TugPJGKy6Aeu6mJ0oP4sIDTL9unbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K0NhceFr; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f3e041d4-c65a-4c16-99ff-37caceebb54a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767995615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=513Ls91pZJUmzplWGcunk0nQa90ZGydxvckD4eQkbpI=;
	b=K0NhceFr24pkhGGDbk9t7ZAZzu8znxijquW618kMieD3a6l6LM5bExNk1DbCU9wsoEIRX2
	TjFkLr/BQbdLI6ett5AHQRUEs/jw/Sy0m1Hv3J7I3oids0hDHMuZTfvE4x3vpl1YbScJas
	2M03mGMFHehLTqaqvjmgqPXaL8zlkRQ=
Date: Fri, 9 Jan 2026 13:53:28 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 01/16] bpf: Convert bpf_selem_unlink_map to
 failable
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, kpsingh@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, haoluo@google.com,
 kernel-team@meta.com
References: <20251218175628.1460321-1-ameryhung@gmail.com>
 <20251218175628.1460321-2-ameryhung@gmail.com>
 <74fa8337-b0cb-42fb-af8a-fdf6877e558d@linux.dev>
 <CAMB2axP5OvZKhHDnW9UD95S+2nTYaR4xLRHdg+oeXtpRJOfKrA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axP5OvZKhHDnW9UD95S+2nTYaR4xLRHdg+oeXtpRJOfKrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/9/26 10:39 AM, Amery Hung wrote:
>>> @@ -574,20 +603,37 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>>>                goto unlock;
>>>        }
>>>
>>> +     b = select_bucket(smap, selem);
>>> +
>>> +     if (old_sdata) {
>>> +             old_b = select_bucket(smap, SELEM(old_sdata));
>>> +             old_b = old_b == b ? NULL : old_b;
>>> +     }
>>> +
>>> +     raw_spin_lock_irqsave(&b->lock, b_flags);
>>> +
>>> +     if (old_b)
>>> +             raw_spin_lock_irqsave(&old_b->lock, old_b_flags);
>> This will deadlock because of the lock ordering of b and old_b.
>> Replacing it with res_spin_lock in the later patch can detect it and
>> break it more gracefully. imo, we should not introduce a known deadlock
>> logic in the kernel code in the syscall code path and ask the current
>> user to retry the map_update_elem syscall.
>>
>> What happened to the patch in the earlier revision that uses the
>> local_storage (or owner) for select_bucket?
> Thanks for reviewing!
> 
> I decided to revert it because this introduces the dependency of selem
> to local_storage when unlinking. bpf_selem_unlink_lockless() cannot
> assume map or local_storage associated with a selem to be alive. In
> the case where local_storage is already destroyed, we won't be able to
> figure out the bucket if select_bucket() uses local_storage for
> hashing.
> 
> A middle ground is to use local_storage for hashing, but save the
> bucket index in selem so that local_storage pointer won't be needed
> later. WDYT?

I would try not to add another "const"-like value to selem if it does 
not have to. imo, it is quite wasteful considering the number of 
selem(s) that can live in the system. Yes, there is one final 8-byte 
hole in selem, but it still should not be used lightly unless nothing 
else can be shared. The atomic/u16/bool added in this set can be 
discussed later once patch 10 is concluded.

For select_bucket in bpf_selem_unlink_lockless, map_free should know the 
bucket. destroy() should have the local_storage, no?


