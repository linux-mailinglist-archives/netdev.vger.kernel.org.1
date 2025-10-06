Return-Path: <netdev+bounces-228028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC97BBF2CD
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 22:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F0A3BF945
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C31ADC7E;
	Mon,  6 Oct 2025 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ovlTV1jW"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0566B1DB12E
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781994; cv=none; b=fST26ajP0FzR5QBoEtB7KRX1ab4i28X0526gelTNI9ogJQ3JE4Dl+t82Kq47u4Rc+6LSvkR50wg/Das1lXAvXeq2pCFzzqDtJuSsR0ztO3qd5+e9mTwuYS3LHQeB1L0zKJQ0NdZ+Xp4O7taH84prtAzwxY3Jzvz96e+kYVOSB+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781994; c=relaxed/simple;
	bh=SQlc/yrGAX9hmo3SfLH4AECETZDXLCtokCVF3sm4WK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvJtv+mRitrP6xKOcf38nxDKo4iN5W0ez2yZdQO8jmlyoTZLP7wHC/eQMJpvX/BHYs9Es8VG66zqQGp7oYxsAmoT/BsmBjMQKu7ZtUHyYwLaAWSbrbnkte75616FTgEEaIWw+MGmfRyHYsrQxSwS2DLrsovm08SYcbnNM2DOsL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ovlTV1jW; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d88addc3-bd10-4923-9ded-10fd999f39e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759781989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H25UD2zYRPwdqIMTTOsqvjFnpku+oOdMSbrffDJoc1A=;
	b=ovlTV1jWZkWhWZ8BCHisF3RGMbpfyerSfxz8CaeBcPS1duwE4XR8S+bTbNXwyB/erwovXS
	MWV/HcFMHp5ilBoq+y79eifeYvIokCZH/y1iezjTv23PtYDlCAt/goF/IOqvLLBKjyhwju
	CjrSAyT1Q9v2X7Es8Jy3nByqJZJZdf0=
Date: Mon, 6 Oct 2025 13:19:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v2 06/12] bpf: Change local_storage->lock and
 b->lock to rqspinlock
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Kernel Team <kernel-team@meta.com>
References: <20251002225356.1505480-1-ameryhung@gmail.com>
 <20251002225356.1505480-7-ameryhung@gmail.com>
 <CAADnVQ+X1Otu+hrBeCq6Zr9vAaH5vGU42s6jLdBiDiLQcwpj4Q@mail.gmail.com>
 <CAMB2axOUU5J4Ec=tuBDYePzucw1QQLciFWC01=eVQdPOhT1BGQ@mail.gmail.com>
 <CAADnVQ+=F5SkoRA4LU+JE+u87TLFp-mTS4bv+u9MUST2+CX8AA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQ+=F5SkoRA4LU+JE+u87TLFp-mTS4bv+u9MUST2+CX8AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/6/25 10:58 AM, Alexei Starovoitov wrote:
> On Fri, Oct 3, 2025 at 3:03 PM Amery Hung <ameryhung@gmail.com> wrote:
>>
>> On Thu, Oct 2, 2025 at 4:37 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Thu, Oct 2, 2025 at 3:54 PM Amery Hung <ameryhung@gmail.com> wrote:
>>>>
>>>>          bpf_selem_free_list(&old_selem_free_list, false);
>>>>          if (alloc_selem) {
>>>>                  mem_uncharge(smap, owner, smap->elem_size);
>>>> @@ -791,7 +812,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
>>>>           * when unlinking elem from the local_storage->list and
>>>>           * the map's bucket->list.
>>>>           */
>>>> -       raw_spin_lock_irqsave(&local_storage->lock, flags);
>>>> +       while (raw_res_spin_lock_irqsave(&local_storage->lock, flags));
>>>
>>> This pattern and other while(foo) doesn't make sense to me.
>>> res_spin_lock will fail only on deadlock or timeout.
>>> We should not spin, since retry will likely produce the same
>>> result. So the above pattern just enters into infinite spin.
>>
>> I only spin in destroy() and map_free(), which cannot deadlock with
>> itself or each other. However, IIUC, a head waiter that detects
>> deadlock will cause other queued waiters to also return -DEADLOCK. I
>> think they should be able to make progress with a retry.
> 
> If it's in map_free() path then why are we taking the lock at all?
> There are supposed to be no active users of it.

There is no user from the syscall or from the bpf prog.

There are still kernel users, bpf_cgrp_storage_free() and bpf_sk_storage_free(), 
that can race with map_free().

> If there are users and we actually need that lock then the deadlock
> is possible and retrying will deadlock the same way.
> I feel AI explained it better:
> "
> raw_res_spin_lock_irqsave() can return -ETIMEDOUT (after 250ms) or
> -EDEADLK. Both are non-zero, so the while() loop continues. The commit
> message says "it cannot deadlock with itself or
> bpf_local_storage_map_free", but:
> 
> 1. If -ETIMEDOUT is returned because the lock holder is taking too long,
>     retrying immediately won't help. The timeout means progress isn't
>     being made, and spinning in a retry loop without any backoff or
>     limit will prevent other work from proceeding.
> 
> 2. If -EDEADLK is returned, it means the deadlock detector found a
>     cycle. Retrying immediately without any state change won't break the
>     deadlock cycle.
> "
> 
>> Or better if
>> rqspinlock does not force queued waiters to exit the queue if it is
>> deadlock not timeout.
> 
> If a deadlock is detected, it's the same issue for all waiters.
> I don't see the difference between timeout and deadlock.
> Both are in the "do-not-retry" category.
> Both mean that there is a bug somewhere.

Both bpf_cgrp_storage_free() and map_free() are the only remaining kernel users 
of the locks, so no deadlock is expected unless there is a bug. The busy percpu 
counter is currently not used in both of them also. Theoretically, the 
res_spin_lock (and the current regular spin_lock) should never fail here in 
bpf_cgrp_storage_free() and map_free(). If res_spin_lock returns error, there is 
a bug somewhere.

> 
>>>
>>> If it should never fail in practice then pr_warn_once and goto out
>>> leaking memory. Better yet defer to irq_work and cleanup there.>>

Not sure how to handle the bug. yeah, maybe just leak it and then splat.
I think deferring it still need to take the lock.

>> Hmm, both functions are already called in some deferred callbacks.
>> Even if we defer the cleanup again, they still need to grab locks and
>> still might fail, no?
> 
> If it's a map destroy path and we waited for RCU GP, there shouldn't be
> a need to take a lock.
> The css_free_rwork_fn() -> bpf_cgrp_storage_free() path
> is currently implemented like it's similar to:
> bpf_cgrp_storage_delete() which needs a lock.
> But bpf_cgrp_storage_free() doesn't have to.
> In css_free_rwork_fn() no prog or user space
> should see 'cgrp' pointer, since we're about to kfree(cgrp); it.
> I could be certainly missing something.


