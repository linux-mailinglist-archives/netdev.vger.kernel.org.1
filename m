Return-Path: <netdev+bounces-226580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2C5BA24B3
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 05:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCDA16598F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 03:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF9E261393;
	Fri, 26 Sep 2025 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zpm5Rpoh"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9090B2472BB
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 03:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857028; cv=none; b=PtzavR0kZz0h0iSRcVm5XEih7f1isgVOj2HGL2lbKRUsvD46VEN80GPiBiRZK5vx+aQn8z7CrXw8fJR3VOhcuN4F3RQxqbf6c5SwRx0AwqpcN4zQ0ZZUfkFrWjY4B/SvqkDdJppKtXbGHbX/h0lBNb2UShbBe2JLf7L0u7pwKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857028; c=relaxed/simple;
	bh=r/re+tLu9QoexP4hij7b/mWnQppcIqtrPGWNgPLcRm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ehr4py6pyzBbkus14YSHDAqxCoW1pv9zyofJWFw9OD4J01rshUmjtGV6ivGXGxgRjeskUaFHjSfJ+74gOYLjJWIq+oqm1nStZx4hWz6w2n2aFmelAqcMU3IVFsWXWc4cnq9gdcy0MpM3X5FxG6VB4Rv6l4J87a24Nc8SX38wtb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zpm5Rpoh; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d7904e8-977e-499c-b877-901facac5dea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758857023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9ZpWAXCOpje0ckd48jmEPyNBT6W15BRdmzJEt9Sy9Q=;
	b=Zpm5RpohAr1xLOTDrz20H6pVZJaEU7YMcgHdSoggSX+v0Bkr1cFVtjU2qWqqreC2BxzOAU
	DiW8SzhRuZyhUIFosfCN48WjdmxksygvXkG5OvzUEvJ6QaQh2eDLVRe1EPC7P5vE5e19CV
	EtE3Y6oBskowCMqyasrshyohm18Al98=
Date: Fri, 26 Sep 2025 11:23:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, "Paul E. McKenney" <paulmck@kernel.org>,
 kerneljasonxing@gmail.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
References: <20250925021628.886203-1-xuanqiang.luo@linux.dev>
 <20250925021628.886203-2-xuanqiang.luo@linux.dev>
 <CAAVpQUDNiOyfUz5nwW+v7oZ-EvR0Pf82yD0S2Wsq+LEO2Y2hhA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUDNiOyfUz5nwW+v7oZ-EvR0Pf82yD0S2Wsq+LEO2Y2hhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/26 01:56, Kuniyuki Iwashima 写道:
> On Wed, Sep 24, 2025 at 7:18 PM <xuanqiang.luo@linux.dev> wrote:
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
>>   include/linux/rculist_nulls.h | 52 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
>> index 89186c499dd4..c3ba74b1890d 100644
>> --- a/include/linux/rculist_nulls.h
>> +++ b/include/linux/rculist_nulls.h
>> @@ -152,6 +152,58 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
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
>> +                                            struct hlist_nulls_node *new)
> nit: checkpatch complains here..
> https://patchwork.kernel.org/project/netdevbpf/patch/20250925021628.886203-2-xuanqiang.luo@linux.dev/
>
> CHECK: Alignment should match open parenthesis
> #46: FILE: include/linux/rculist_nulls.h:171:
> +static inline void hlist_nulls_replace_rcu(struct hlist_nulls_node *old,
> +     struct hlist_nulls_node *new)

Thanks for pointing it out, I'll fix it in the next version.

Appreciate it!

>
>> +{
>> +       struct hlist_nulls_node *next = old->next;
>> +
>> +       WRITE_ONCE(new->next, next);
>> +       WRITE_ONCE(new->pprev, old->pprev);
>> +       rcu_assign_pointer(*(struct hlist_nulls_node __rcu **)new->pprev, new);
> nit: define hlist_nulls_prev_rcu() like hlist_nulls_next_rcu().

I'm wondering if defining a macro called hlist_nulls_prev_rcu() might
be controversial, since it should actually be getting the prev->next
rather than the prev itself.

Would it be more appropriate to rename it to hlist_nulls_prev_next_rcu()
instead?

Like this:

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index c3ba74b1890d..9399ec9dc82d 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -52,6 +52,14 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
  #define hlist_nulls_next_rcu(node) \
         (*((struct hlist_nulls_node __rcu __force **)&(node)->next))
+/**
+ * hlist_nulls_prev_next_rcu - returns the next pointer of the previous
+ * element.
+ * @node: element of the list.
+ */
+#define hlist_nulls_prev_next_rcu(node) \
+       (*((struct hlist_nulls_node __rcu __force **)(node)->pprev))
+
  /**
   * hlist_nulls_del_rcu - deletes entry from hash list without re-initialization
   * @n: the element to delete from the hash list.

However, I noticed that in the definition of hlist_pprev_rcu(), it directly
uses pprev:

#define hlist_pprev_rcu(node)    (*((struct hlist_node __rcu **)((node)->pprev)))

This part seems a bit confusing to me. It's possible I'm missing some
historical context here. If so, please feel free to point it out.

Thanks!

>
>> +       if (!is_a_nulls(next))
>> +               WRITE_ONCE(new->next->pprev, &new->next);
> nit: s/new->next->pprev/next->pprev/

I'll update it in the next version.

Thank you!

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

