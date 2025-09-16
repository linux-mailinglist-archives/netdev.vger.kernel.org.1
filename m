Return-Path: <netdev+bounces-223314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE33B58B46
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8C83AC9E5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E511AF0C8;
	Tue, 16 Sep 2025 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oiUNdyEQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34D2DC763
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986478; cv=none; b=ReOc3PunITJcZVeht0arUAg4MHhF0wzUfibJswU2GxjUnSbLDq/yLCyWI+wozC4qUYnD4jpKrNIYYArAn/H6E6zPqzE5sHLp+ObxaitgnFk+DbD7aCpQdql775dLYEOGHmq+Ta/5C7nYF3l/GJKdnV/JDEcZkSQ30LMxFVhASzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986478; c=relaxed/simple;
	bh=/lQ504ZrYn7m+j2mobFcmPkr6ADpKI1SVUGF+0G3F5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KI4bLxcC5SlbenKLqiUpnGiVDwFAoSXg97/lI/cK7PHIWekTA0Lq99/hhU949ss5bnQlsh9m3HhYBIpUHZyo2HsrmKGY5OiOyqyZks1d/Yxp5vmo76K9DLl50RxCF0PwTrlVm9ZH84eo9NS0kdpcO0owQ6UUkD9j3YPrCvEztIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oiUNdyEQ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <91b6398c-70fb-440a-a654-a3e618338134@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757986473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDXPAsuDgTbQZNmGKDc3AXRua/2/wTL33HLJDbdMkWM=;
	b=oiUNdyEQSwigNjTBUu81X3S0zBfyerhLV4v+/WCpLBPYbGaS5n6j2oNOfscXPU7Td9b1cP
	pz0IgxNPBHrMOV5K88aeFy/auQ8px/pLoNlPDbbiBHnsri7b0VeMBQ4Ap3Z6iq4sIMzpo9
	VtJ5AogHnkU55wdUTkXBWY0y2ESJfhw=
Date: Tue, 16 Sep 2025 09:33:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1 1/3] rculist: Add __hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, kerneljasonxing@gmail.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250915070308.111816-1-xuanqiang.luo@linux.dev>
 <20250915070308.111816-2-xuanqiang.luo@linux.dev>
 <CAAVpQUBuV9ixMheieH137YNxZsKAZhQekjudpiw-=7DsvxV7BA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUBuV9ixMheieH137YNxZsKAZhQekjudpiw-=7DsvxV7BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/16 06:50, Kuniyuki Iwashima 写道:
> On Mon, Sep 15, 2025 at 12:04 AM <xuanqiang.luo@linux.dev> wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> Add two functions to atomically replace RCU-protected hlist_nulls entries.
>>
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>>   include/linux/rculist_nulls.h | 62 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>
>> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
>> index 89186c499dd4..eaa3a0d2f206 100644
>> --- a/include/linux/rculist_nulls.h
>> +++ b/include/linux/rculist_nulls.h
>> @@ -152,6 +152,68 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
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
> This is already checked by __sk_nulls_replace_node_init_rcu().
>
It seems to me that hlist_nulls_replace_init_rcu() checks whether the
sk_nulls_node is unhashed, while __sk_nulls_replace_node_init_rcu() checks the
sk_node's unhashed status. Perhaps these serve different purposes?
This would maintain parity with how hlist_nulls_del_init_rcu verifies
sk_nulls_node and __sk_nulls_del_node_init_rcu() checks sk_node.


Thanks
Xuanqiang

>> +               __hlist_nulls_replace_rcu(old, new);
>> +               old->pprev = NULL;
>> +               return true;
>> +       }
>> +
>> +       return false;
>> +}
>> +
>>   /**
>>    * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
>>    * @tpos:      the type * to use as a loop cursor.
>> --
>> 2.27.0
>>

