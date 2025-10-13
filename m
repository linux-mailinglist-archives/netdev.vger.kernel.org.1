Return-Path: <netdev+bounces-228681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CCEBD20C4
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 10:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D4A3C1423
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 08:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FE12E7F2F;
	Mon, 13 Oct 2025 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PX6vUgyU"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7707C2F3C2B
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343991; cv=none; b=fkTTblYuL6UyStkJlKADNA+HOaoSLw2G5jKymLXGIWXF8tcbmS/w4PktPVytwpCt2o+1j58vzSE6jCLYuXh1o78cGL+/Y34gvqtesXJJxhwoQrr/pLDuwec83QsOvLUh7YzYZtOfuos5PZz249fVKpS8AzVu98zMMT2HP6PGrsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343991; c=relaxed/simple;
	bh=8Di6RmvMVBX6UKr7C9RsFJsMYdOptVnUpeyEgXBDX30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5q3uu77hve3VolXNBUiwOhXmzECukSZBDD43TYqPQJokE/MJFaipPKjfbxJJc3W93l8nszZVgSfUVSl1eyQFwMg/f3nb6rV6eutwUf0iD9400fdeM8AbdMGOjUZPUo8oXdiZQbN2GH29HtrJl3DUCc0y1Lj5Q8Ez6ZICWaHnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PX6vUgyU; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d6a43fe1-2e00-4df4-b4a8-04facd8f05d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760343987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2x24+Ru0v8QnYj9tz/Et7AyGhyuwGOuCIi1S8FoGdpY=;
	b=PX6vUgyU7O4Kh9AjbSxGAhqgTYFCCBHOI+4DHFqW8C1FCsZeBFQFXTKOzXfg7LpVf9YxM7
	pCwE3qF54GgX4B5dYiLijtelC9ilJnTQTofazOEERshhY1NYNTIur951nlwerBy4M17fLC
	bnW0R3mCFiMQJdKgCwzN7n8HSw14S98=
Date: Mon, 13 Oct 2025 16:25:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: Eric Dumazet <edumazet@google.com>
Cc: kuniyu@google.com, "Paul E. McKenney" <paulmck@kernel.org>,
 kerneljasonxing@gmail.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
 <20250926074033.1548675-2-xuanqiang.luo@linux.dev>
 <CANn89iJ15RFYq65t57sW=F1jZigbr5xTbPNLVY53cKtpMKLotA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CANn89iJ15RFYq65t57sW=F1jZigbr5xTbPNLVY53cKtpMKLotA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/10/13 15:31, Eric Dumazet 写道:
> On Fri, Sep 26, 2025 at 12:41 AM <xuanqiang.luo@linux.dev> wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> Add two functions to atomically replace RCU-protected hlist_nulls entries.
>>
>> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
>> mentioned in the patch below:
>> commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
>> rculist_nulls")
>> commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for
>> hlist_nulls")
>>
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>>   include/linux/rculist_nulls.h | 59 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
>> index 89186c499dd4..c26cb83ca071 100644
>> --- a/include/linux/rculist_nulls.h
>> +++ b/include/linux/rculist_nulls.h
>> @@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
>>   #define hlist_nulls_next_rcu(node) \
>>          (*((struct hlist_nulls_node __rcu __force **)&(node)->next))
>>
>> +/**
>> + * hlist_nulls_pprev_rcu - returns the dereferenced pprev of @node.
>> + * @node: element of the list.
>> + */
>> +#define hlist_nulls_pprev_rcu(node) \
>> +       (*((struct hlist_nulls_node __rcu __force **)(node)->pprev))
>> +
>>   /**
>>    * hlist_nulls_del_rcu - deletes entry from hash list without re-initialization
>>    * @n: the element to delete from the hash list.
>> @@ -152,6 +159,58 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
>>          n->next = (struct hlist_nulls_node *)NULLS_MARKER(NULL);
>>   }
>>
>> +/**
>> + * hlist_nulls_replace_rcu - replace an old entry by a new one
>> + * @old: the element to be replaced
>> + * @new: the new element to insert
>> + *
>> + * Description:
>> + * Replace the old entry with the new one in a RCU-protected hlist_nulls, while
>> + * permitting racing traversals.
>> + *
>> + * The caller must take whatever precautions are necessary (such as holding
>> + * appropriate locks) to avoid racing with another list-mutation primitive, such
>> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
>> + * list.  However, it is perfectly legal to run concurrently with the _rcu
>> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
>> + */
>> +static inline void hlist_nulls_replace_rcu(struct hlist_nulls_node *old,
>> +                                          struct hlist_nulls_node *new)
>> +{
>> +       struct hlist_nulls_node *next = old->next;
>> +
>> +       WRITE_ONCE(new->next, next);
>> +       WRITE_ONCE(new->pprev, old->pprev);
> I do not think these two WRITE_ONCE() are needed.
>
> At this point new is not yet visible.
>
> The following  rcu_assign_pointer() is enough to make sure prior
> writes are committed to memory.

Dear Eric,

I’m quoting your more detailed explanation from the other patch [0], thank
you for that!

However, regarding new->next, if the new object is allocated with
SLAB_TYPESAFE_BY_RCU, would we still encounter the same issue as in commit
efd04f8a8b45 (“rcu: Use WRITE_ONCE() for assignments to ->next for
rculist_nulls”)?

Also, for the WRITE_ONCE() assignments to ->pprev introduced in commit
860c8802ace1 (“rcu: Use WRITE_ONCE() for assignments to ->pprev for
hlist_nulls”) within hlist_nulls_add_head_rcu(), is that also unnecessary?

[0]: https://lore.kernel.org/all/CANn89iKQM=4wjCLxpg-m3jYoUm=rsSk68xVLN2902di2+FkSFg@mail.gmail.com/

Thanks!

>> +       rcu_assign_pointer(hlist_nulls_pprev_rcu(new), new);
>> +       if (!is_a_nulls(next))
>> +               WRITE_ONCE(next->pprev, &new->next);
>> +}
>> +
>> +/**
>> + * hlist_nulls_replace_init_rcu - replace an old entry by a new one and
>> + * initialize the old
>> + * @old: the element to be replaced
>> + * @new: the new element to insert
>> + *
>> + * Description:
>> + * Replace the old entry with the new one in a RCU-protected hlist_nulls, while
>> + * permitting racing traversals, and reinitialize the old entry.
>> + *
>> + * Note: @old must be hashed.
>> + *
>> + * The caller must take whatever precautions are necessary (such as holding
>> + * appropriate locks) to avoid racing with another list-mutation primitive, such
>> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
>> + * list. However, it is perfectly legal to run concurrently with the _rcu
>> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
>> + */
>> +static inline void hlist_nulls_replace_init_rcu(struct hlist_nulls_node *old,
>> +                                               struct hlist_nulls_node *new)
>> +{
>> +       hlist_nulls_replace_rcu(old, new);
>> +       WRITE_ONCE(old->pprev, NULL);
>> +}
>> +
>>   /**
>>    * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
>>    * @tpos:      the type * to use as a loop cursor.
>> --
>> 2.25.1
>>

