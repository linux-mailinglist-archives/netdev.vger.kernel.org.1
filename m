Return-Path: <netdev+bounces-224256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0549DB83163
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACE41C2010C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEC027B4F7;
	Thu, 18 Sep 2025 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IUONQkMG"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4826AE4
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175799; cv=none; b=jp50wRDklv9JKMcgIauMuOK+paa8vhYqmvaZVTfoSGWUjR1hTCCDNY7R2IEgoqYd4PMjKYf4p+1dMRtoiXZdSwVU0qufZbVs9PFsHsNB+IM8wV95HfOQNGIwX2a08mB5FhDZGgEwEkVpjhSTtfAlvw/tJvzITZIFFp1dAs3si/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175799; c=relaxed/simple;
	bh=NIMy5R5nf6DdV1ze7QsimyipASntB/qjfHYgCld51pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWoFtJH8VhUU7pWx77VlF89Sx1WUS1CQh92yGGDQlEG1cToY8LsIBDUyVCJZQSPhXGasGP4zus//2ooDPl2SgpZUf0Kmnf1yWUDEwoA77b6lGbGNlqNfr0KSwf6fu6Ef+zMx81DtmuQOBmK8ROzYhxlBBXM/4ksyt4P+9/T6qgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IUONQkMG; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce3d224d-0d17-4510-9bad-494832dbce8b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758175794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eD/67DPnwyKX2mcMSIG5+0/Vo6T967tR+VuwRVClzo8=;
	b=IUONQkMGOOhs30d9Bkveol1Z+vg7FaxoIzsBm/KSn72kXjD98ghgIjMRzdfaPkigzox263
	yCcFkdDTtTHLHqBSzqzrWCXDAafLq2yZlvBuHDj9lRLhfL2Et3WMkGKDfnFPT3KuZt7EZl
	P9o2lo11O6cQHKK/TBb51OhZaQT3Pd0=
Date: Thu, 18 Sep 2025 14:09:08 +0800
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
 <CAAVpQUAWijPEtD=1pp-u8tbqWUkJxn94+A12yfdVC0QwAiuTSA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CAAVpQUAWijPEtD=1pp-u8tbqWUkJxn94+A12yfdVC0QwAiuTSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/17 12:43, Kuniyuki Iwashima 写道:
> On Tue, Sep 16, 2025 at 9:27 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>> On Tue, Sep 16, 2025 at 8:27 PM luoxuanqiang <xuanqiang.luo@linux.dev> wrote:
>>>
>>> 在 2025/9/17 02:58, Kuniyuki Iwashima 写道:
>>>> On Tue, Sep 16, 2025 at 3:31 AM <xuanqiang.luo@linux.dev> wrote:
>>>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>>>
>>>>> Add two functions to atomically replace RCU-protected hlist_nulls entries.
>>>>>
>>>>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>>> ---
>>>>>    include/linux/rculist_nulls.h | 61 +++++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 61 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
>>>>> index 89186c499dd4..8ed604f65a3e 100644
>>>>> --- a/include/linux/rculist_nulls.h
>>>>> +++ b/include/linux/rculist_nulls.h
>>>>> @@ -152,6 +152,67 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
>>>>>           n->next = (struct hlist_nulls_node *)NULLS_MARKER(NULL);
>>>>>    }
>>>>>
>>>>> +/**
>>>>> + * __hlist_nulls_replace_rcu - replace an old entry by a new one
>>>>> + * @old: the element to be replaced
>>>>> + * @new: the new element to insert
>>>>> + *
>>>>> + * Description:
>>>>> + * Replace the old entry with the new one in a RCU-protected hlist_nulls, while
>>>>> + * permitting racing traversals.
>>>>> + *
>>>>> + * The caller must take whatever precautions are necessary (such as holding
>>>>> + * appropriate locks) to avoid racing with another list-mutation primitive, such
>>>>> + * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
>>>>> + * list.  However, it is perfectly legal to run concurrently with the _rcu
>>>>> + * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
>>>>> + */
>>>>> +static inline void __hlist_nulls_replace_rcu(struct hlist_nulls_node *old,
>>>>> +                                            struct hlist_nulls_node *new)
>>>>> +{
>>>>> +       struct hlist_nulls_node *next = old->next;
>>>>> +
>>>>> +       new->next = next;
>>> Do we need to use WRITE_ONCE() here, as mentioned in efd04f8a8b45
>>> ("rcu: Use WRITE_ONCE() for assignments to ->next for rculist_nulls")?
>>> I am more inclined to think that it is necessary.
>> Good point, then WRITE_ONCE() makes sense.
> and it would be nice to have such reasoning in the commit
> message as we were able to learn from efd04f8a8b45.

Okay, I'll add an explanation in the next version. Really
appreciate you confirming this!


