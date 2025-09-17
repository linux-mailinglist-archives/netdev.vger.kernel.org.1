Return-Path: <netdev+bounces-223839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E203FB7EB6C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436111C01CC7
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 03:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAA5258ED7;
	Wed, 17 Sep 2025 03:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pcf+jLaC"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEAB149E17
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 03:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079660; cv=none; b=TyzJi/c4OBREQvRmAlNS+r8j663c9AHXuhKH5JxufxSDKbOZM/5Ke6ggzBmr3SJ+sWH9n2RvDICGndanQ9EaxaJmmXris6A5EUbCjuOXThvAhTKwBSnjrxM/fLiAZeY/qiIlX329bxMSEVkV8rOkM57LRosvImiJ9nleDCvV9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079660; c=relaxed/simple;
	bh=BjOB9OTEOaJg8z1GF4WL0cjEzqgJDbA4mOw2Xod+D2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHTAgnG3thhq0pg4bMYRRKH4k4aL0D6pIFJ6m4DGRlrqM3XO+Xj1kuyCzriwx6jg+GGDW7ihfUKKmXZcyCUgbWHhk4sxbIWgEFnz66bkDcDJ5j/XaQT9YGCh5GycCxpofozXRxfX6x6cVri+SR/LlQLfBbZv76YPCH0H6p4rBEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pcf+jLaC; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bdc27331-e1a3-4e49-ba58-d5b41171be3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758079655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4r1/YY5rtUoZT85csUT78Q834I/tkilYaiEqzCsfLH4=;
	b=pcf+jLaC9f1hRNvb+tgR5FnCxFOoBRymlecRGAe6A2W7K3IkeE+xL2AycPuE6M4Q3vpd97
	aC06NglDQ9u5GnmkN6z8jhz6bhomLe+aG2WsXhVANvWC6aX8iXlLMqvR1fJHfTXEjpH8L/
	MCB1r3zCb7FZ9V5Nt76Epq5Ek5pgPVg=
Date: Wed, 17 Sep 2025 11:26:55 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUDYG1p+2o90+HTSXe1aFsR4-KWZtSPC7YXKDuge+JOjjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/17 02:58, Kuniyuki Iwashima 写道:
> On Tue, Sep 16, 2025 at 3:31 AM <xuanqiang.luo@linux.dev> wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> Add two functions to atomically replace RCU-protected hlist_nulls entries.
>>
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>>   include/linux/rculist_nulls.h | 61 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
>> index 89186c499dd4..8ed604f65a3e 100644
>> --- a/include/linux/rculist_nulls.h
>> +++ b/include/linux/rculist_nulls.h
>> @@ -152,6 +152,67 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
>>          n->next = (struct hlist_nulls_node *)NULLS_MARKER(NULL);
>>   }
>>
>> +/**
>> + * __hlist_nulls_replace_rcu - replace an old entry by a new one
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
>> +       new->next = next;

Do we need to use WRITE_ONCE() here, as mentioned in efd04f8a8b45
("rcu: Use WRITE_ONCE() for assignments to ->next for rculist_nulls")?
I am more inclined to think that it is necessary.

>> +       WRITE_ONCE(new->pprev, old->pprev);
> As you don't use WRITE_ONCE() for ->next, the new node must
> not be published yet, so WRITE_ONCE() is unnecessary for ->pprev
> too.

I noticed that point. My understanding is that using WRITE_ONCE()
for new->pprev follows the approach in hlist_replace_rcu() to
match the READ_ONCE() in hlist_nulls_unhashed_lockless() and
hlist_unhashed_lockless().

>
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
>> + * Return: true if the old entry was hashed and was replaced successfully, false
>> + * otherwise.
>> + *
>> + * Note: hlist_nulls_unhashed() on the old node returns true after this.
>> + * It is useful for RCU based read lockfree traversal if the writer side must
>> + * know if the list entry is still hashed or already unhashed.
>> + *
>> + * The caller must take whatever precautions are necessary (such as holding
>> + * appropriate locks) to avoid racing with another list-mutation primitive, such
>> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
>> + * list. However, it is perfectly legal to run concurrently with the _rcu
>> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
>> + */
>> +static inline bool hlist_nulls_replace_init_rcu(struct hlist_nulls_node *old,
>> +                                               struct hlist_nulls_node *new)
>> +{
>> +       if (!hlist_nulls_unhashed(old)) {
> As mentioned in v1, this check is redundant.

Apologies for bringing this up again. My understanding is that
replacing a node requires checking if the old node is unhashed.

If so, we need a return value to inform the caller that the
replace operation would fail.

>
>> +               __hlist_nulls_replace_rcu(old, new);
>> +               WRITE_ONCE(old->pprev, NULL);
>> +               return true;
>> +       }
>> +       return false;
>> +}
>> +
>>   /**
>>    * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
>>    * @tpos:      the type * to use as a loop cursor.
>> --
>> 2.25.1
>>

