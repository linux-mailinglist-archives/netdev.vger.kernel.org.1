Return-Path: <netdev+bounces-224257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19989B83169
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4400F62051D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 06:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A1E2D781B;
	Thu, 18 Sep 2025 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N/SpAUxT"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C5D25A353
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175801; cv=none; b=gV4JcWumiI6GKPRcUEEbvyFQzdVtnN/A7ZWqdI9aYc4rltnvELmy55SALlpY6827K1E2nqlNoSZdIrpGrSFn5gHwudJxr5kkdqAgHZYAZy+ojTJaYPnUnRFgs+uY0/D8CNGyMuyKN27gQn4lD6Tr0tN4cq+IopdF/9PwJuxxDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175801; c=relaxed/simple;
	bh=2R63T+2k/FNcQYi1u8KGH1o70FpuXAzMY7Hd1qBbZy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPd5eQU7bjp0qUR5JRANf8STcOThPTi8cPpK+ncdqJddklUY0zp9an/My1IHHknxS8T0yOh+EZQQw0AQQXifMHgDlJjoMgTjjlTirD87lVRKMm5s4KLN50rXN/PQZAQM9JRZX/FU7WBVLo//5j4BPiAuUGZwKZZTjgc/MxLg/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N/SpAUxT; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7ece5d34-aa1c-4251-9650-756de3b3dc18@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758175797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDidndW1mVBSX5cjv++iAf8jM5x7lLlrTg5oOX5e9I8=;
	b=N/SpAUxT6SG4l7mGo4VouR3Q0v4PpL/CkTxEobPV1+d7H4r0elZM2o5ku7t5cxUfm49+1H
	5+LOiKz/iQZlBI4Zv4n5wqXOlmPPvg19w1bGs2PzSi+Vlk2ZXdaurG2l3yutzWJBdq1EZj
	b3kkP9Z14MJXz7jjW87qICcVmObc5kI=
Date: Thu, 18 Sep 2025 14:09:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 1/3] rculist: Add __hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250916103054.719584-1-xuanqiang.luo@linux.dev>
 <20250916103054.719584-2-xuanqiang.luo@linux.dev>
 <CAAVpQUDYG1p+2o90+HTSXe1aFsR4-KWZtSPC7YXKDuge+JOjjg@mail.gmail.com>
 <bdc27331-e1a3-4e49-ba58-d5b41171be3e@linux.dev>
 <CAAVpQUCoCizxTm6wRs0+n6_kPK+kgxwszsYKNds3YvuBfBvrhg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUCoCizxTm6wRs0+n6_kPK+kgxwszsYKNds3YvuBfBvrhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/17 12:27, Kuniyuki Iwashima 写道:
> On Tue, Sep 16, 2025 at 8:27 PM luoxuanqiang <xuanqiang.luo@linux.dev> wrote:
>>
>> 在 2025/9/17 02:58, Kuniyuki Iwashima 写道:
>>> On Tue, Sep 16, 2025 at 3:31 AM <xuanqiang.luo@linux.dev> wrote:
>>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>>
>>>> Add two functions to atomically replace RCU-protected hlist_nulls entries.
>>>>
>>>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>> ---
>>>>    include/linux/rculist_nulls.h | 61 +++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 61 insertions(+)
>>>>
>>>> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
>>>> index 89186c499dd4..8ed604f65a3e 100644
>>>> --- a/include/linux/rculist_nulls.h
>>>> +++ b/include/linux/rculist_nulls.h
>>>> @@ -152,6 +152,67 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
>>>>           n->next = (struct hlist_nulls_node *)NULLS_MARKER(NULL);
>>>>    }
>>>>
>>>> +/**
>>>> + * __hlist_nulls_replace_rcu - replace an old entry by a new one
>>>> + * @old: the element to be replaced
>>>> + * @new: the new element to insert
>>>> + *
>>>> + * Description:
>>>> + * Replace the old entry with the new one in a RCU-protected hlist_nulls, while
>>>> + * permitting racing traversals.
>>>> + *
>>>> + * The caller must take whatever precautions are necessary (such as holding
>>>> + * appropriate locks) to avoid racing with another list-mutation primitive, such
>>>> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
>>>> + * list.  However, it is perfectly legal to run concurrently with the _rcu
>>>> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
>>>> + */
>>>> +static inline void __hlist_nulls_replace_rcu(struct hlist_nulls_node *old,
>>>> +                                            struct hlist_nulls_node *new)
>>>> +{
>>>> +       struct hlist_nulls_node *next = old->next;
>>>> +
>>>> +       new->next = next;
>> Do we need to use WRITE_ONCE() here, as mentioned in efd04f8a8b45
>> ("rcu: Use WRITE_ONCE() for assignments to ->next for rculist_nulls")?
>> I am more inclined to think that it is necessary.
> Good point, then WRITE_ONCE() makes sense.
>
>>>> +       WRITE_ONCE(new->pprev, old->pprev);
>>> As you don't use WRITE_ONCE() for ->next, the new node must
>>> not be published yet, so WRITE_ONCE() is unnecessary for ->pprev
>>> too.
>> I noticed that point. My understanding is that using WRITE_ONCE()
>> for new->pprev follows the approach in hlist_replace_rcu() to
>> match the READ_ONCE() in hlist_nulls_unhashed_lockless() and
>> hlist_unhashed_lockless().
> Using WRITE_ONCE() or READ_ONCE() implies lockless readers
> or writers elsewhere.
>
> sk_hashed() does not use the lockless version, and I think it's
> always called under lock_sock() or bh_.  Perhaps run kernel
> w/ KCSAN and see if it complains.
>
> [ It seems hlist_nulls_unhashed_lockless is not used at all and
>    hlist_unhashed_lockless() is only used by bpf and timer code. ]
>
> That said, it might be fair to use WRITE_ONCE() here to make
> future users less error-prone.
>
>
>>>> +       rcu_assign_pointer(*(struct hlist_nulls_node __rcu **)new->pprev, new);
>>>> +       if (!is_a_nulls(next))
>>>> +               WRITE_ONCE(new->next->pprev, &new->next);
>>>> +}
>>>> +
>>>> +/**
>>>> + * hlist_nulls_replace_init_rcu - replace an old entry by a new one and
>>>> + * initialize the old
>>>> + * @old: the element to be replaced
>>>> + * @new: the new element to insert
>>>> + *
>>>> + * Description:
>>>> + * Replace the old entry with the new one in a RCU-protected hlist_nulls, while
>>>> + * permitting racing traversals, and reinitialize the old entry.
>>>> + *
>>>> + * Return: true if the old entry was hashed and was replaced successfully, false
>>>> + * otherwise.
>>>> + *
>>>> + * Note: hlist_nulls_unhashed() on the old node returns true after this.
>>>> + * It is useful for RCU based read lockfree traversal if the writer side must
>>>> + * know if the list entry is still hashed or already unhashed.
>>>> + *
>>>> + * The caller must take whatever precautions are necessary (such as holding
>>>> + * appropriate locks) to avoid racing with another list-mutation primitive, such
>>>> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
>>>> + * list. However, it is perfectly legal to run concurrently with the _rcu
>>>> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
>>>> + */
>>>> +static inline bool hlist_nulls_replace_init_rcu(struct hlist_nulls_node *old,
>>>> +                                               struct hlist_nulls_node *new)
>>>> +{
>>>> +       if (!hlist_nulls_unhashed(old)) {
>>> As mentioned in v1, this check is redundant.
>> Apologies for bringing this up again. My understanding is that
>> replacing a node requires checking if the old node is unhashed.
> Only if the caller does not check it.
>
> __sk_nulls_replace_node_init_rcu() has already checked
> sk_hashed(old), which is !hlist_nulls_unhashed(old), no ?
>
> __sk_nulls_replace_node_init_rcu(struct sock *old, ...)
>    if (sk_hashed(old))
>      hlist_nulls_replace_init_rcu(&old->sk_nulls_node, ...)
>        if (!hlist_nulls_unhashed(old))
>
I understand that sk_hashed(old) is equivalent to
!hlist_nulls_unhashed(old). However,
hlist_nulls_replace_init_rcu() is also used in
inet_twsk_hashdance_schedule().

If it's confirmed that the unhashed check is
unnecessary in inet_twsk_hashdance_schedule()
(as discussed in https://lore.kernel.org/all/CAAVpQUBY=h3gDfaX=J9vbSuhYTn8cfCsBGhPLqoer0OSYdihDg@mail.gmail.com/),
then for this specific patchset, this redundant check
can indeed be removed.

But I'm concerned that others might later use
hlist_nulls_replace_init_rcu() standalone, similar to
how hlist_nulls_del_init_rcu() is used. This could cause
confusion since replace might not always succeed. Given
this, might retaining the hlist_nulls_unhashed(old)
check be safer?

Really appreciate your patient review and suggestions!

Thanks
Xuanqiang.

>> If so, we need a return value to inform the caller that the
>> replace operation would fail.
>>
>>>> +               __hlist_nulls_replace_rcu(old, new);
>>>> +               WRITE_ONCE(old->pprev, NULL);
>>>> +               return true;
>>>> +       }
>>>> +       return false;
>>>> +}
>>>> +
>>>>    /**
>>>>     * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
>>>>     * @tpos:      the type * to use as a loop cursor.
>>>> --
>>>> 2.25.1
>>>>

