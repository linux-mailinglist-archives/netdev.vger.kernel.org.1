Return-Path: <netdev+bounces-225473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AFBB93EC7
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 04:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566AE188C43C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE7674420;
	Tue, 23 Sep 2025 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j9rnxSnN"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75797CA5A
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592842; cv=none; b=fOJgjChZAeV93KxvCvK8MZzniKUBvIdimQsbSTMeafwp155bZ/G6mN6SQvfQMrDf5VOTdNpuxVucSX9O+nMN0FXzKQBCIjqI+gemtauhkf5957Q8Yu8WPm34w2LLbAdd/dIwJdALmb2MzzPfDSTybr+DeyCdqt23FHbaONyMT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592842; c=relaxed/simple;
	bh=cwMYcUz1TyoCrTTOZjYBgWQOQ08ML5noRxzzTxbzEpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFLKC6uVGGJIvsHvVcDYA0s4VxL7jYFcdQVsdIHbX2CfwsNIMt0pOD7S4nes4mKxfNnwgiAVUX31xbMVAGDP8RcWnpgQzLj5nus5HqENnPPxwYjUAh6jBj0GKnW63k/cVI457DvEoS4t6BCXmSs2nzc3+6nSZYr1z3B5UseGZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j9rnxSnN; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6715c8c6-f252-42d3-b9b2-3032cd38c65f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758592836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6feZAtpw2aGJxDoWvjqgD/I/qe8QQtN5aZV8q99sfs=;
	b=j9rnxSnNnqbi/0y3iNYMiSTKCixa46Eeg+Y1Y3EIUXxs1tvW8BgfALi7zVFgWpWGByECXT
	HrJKJyUNFc7cG93rEzTuD0qp2wBpRPFTo02/F8xk3Pcu2UONqY1HAt8E3Uz2Irv8IjDuJA
	fYTj8EjZI9u0DDrNhEI+8iapl3VbZ7w=
Date: Tue, 23 Sep 2025 09:59:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 1/3] rculist: Add __hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250920105945.538042-1-xuanqiang.luo@linux.dev>
 <20250920105945.538042-2-xuanqiang.luo@linux.dev>
 <CAAVpQUD5LrDvt2ow_uGYvwqu4U+v0dOgTKZWAVfhf4eo7594bQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUD5LrDvt2ow_uGYvwqu4U+v0dOgTKZWAVfhf4eo7594bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/23 08:19, Kuniyuki Iwashima 写道:
> On Sat, Sep 20, 2025 at 4:00 AM <xuanqiang.luo@linux.dev> wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> Add two functions to atomically replace RCU-protected hlist_nulls entries.
>>
>> Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as mentioned in
>> the patch below:
>> efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for rculist_nulls")
>> 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for hlist_nulls")
>>
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>>   include/linux/rculist_nulls.h | 52 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
>> index 89186c499dd4..d86331ce22c4 100644
>> --- a/include/linux/rculist_nulls.h
>> +++ b/include/linux/rculist_nulls.h
>> @@ -152,6 +152,58 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
>>          n->next = (struct hlist_nulls_node *)NULLS_MARKER(NULL);
>>   }
>>
>> +/**
>> + * __hlist_nulls_replace_rcu - replace an old entry by a new one
> nit: '__' is not needed as there is not no-'__' version.
>
>
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
>> +static inline void __hlist_nulls_replace_rcu(struct hlist_nulls_node *old,
>> +                                            struct hlist_nulls_node *new)
>> +{
>> +       struct hlist_nulls_node *next = old->next;
>> +
>> +       WRITE_ONCE(new->next, next);
>> +       WRITE_ONCE(new->pprev, old->pprev);
>> +       rcu_assign_pointer(*(struct hlist_nulls_node __rcu **)new->pprev, new);
>> +       if (!is_a_nulls(next))
>> +               WRITE_ONCE(new->next->pprev, &new->next);
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
>> + * Note: @old should be hashed.
> nit: s/should/must/

Will fix them in the next version!

Thanks, Kuniyuki!

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
>> +       __hlist_nulls_replace_rcu(old, new);
>> +       WRITE_ONCE(old->pprev, NULL);
>> +}
>> +
>>   /**
>>    * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
>>    * @tpos:      the type * to use as a loop cursor.
>> --
>> 2.25.1
>>

