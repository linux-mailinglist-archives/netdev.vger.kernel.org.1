Return-Path: <netdev+bounces-202395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7EFAEDB89
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12F418872A0
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2969925EFB7;
	Mon, 30 Jun 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="SEJupScf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181323ABAE
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284031; cv=none; b=i+84kw/UaYGAZlHpZwlJ1uSBEPZfPuNj0P35VMR8vqtEcQrNPwsN0ijOeYkdy71tZRC0F55TauwGR70iiUUBUUWlUNgSwL8LOccQa3fHEF9aS4DbMCywAKQ+sZbDJs6HYeNKjmJtSD9Wms/LzUneimJmBFqa1H/uJPMmES6ghoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284031; c=relaxed/simple;
	bh=rqbrjCNKn3KHG3+9t9zpO3ksRTyhZgf9+T0RREv3SNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpJB4UAqAWd2S2AZZBmdMYCTN2/+GuXt3EgCOGsPMwq0c3jqUitK5PxZuI0/hmt5pWp7xN8XVKvUON8AkNyp95awG6h1OZ0odnnJsYxkv+8PiHObZHSdidUqAxPgfW/oGAVZT9+kMnh9kRdp7dkKbxzB3C5+Mlk8kq6llNlFQ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=SEJupScf; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d45b80368dso105250585a.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751284028; x=1751888828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=onG20wvAwyBwrMa/g5Ijmo4hq2IkwUJh2CUNeZM4HqQ=;
        b=SEJupScfXn8P9H8ODLHtR/vbx12EEecx2eOylXtAy53J9txgNtB1keQLTdeCvFlxm1
         IQhMpi9JjyDHZMOOucuE8ObJ0jhs58sYAW4ohNvQNDTSe58GLieaz7swYJJ0dqfP1YFl
         qpFbfherE8CbE25Y5LbOwWNrC/NJDfEhxY1SsxuiBa/UFPyl80XH5bg1bi1sp+rZ9BQq
         MoltnryhAraDm8Uy14+5DlokjzqYZ4ISY9kCNdMThOz6iMANGkeyqLVl7BTYjpHA40pr
         tzKZH63rEBAq/5ZZmfsjK0OwqUG4ELqKLLGFqrXScE6OLCxrhw3qmVKd4slsjPVb4PKp
         HvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751284028; x=1751888828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onG20wvAwyBwrMa/g5Ijmo4hq2IkwUJh2CUNeZM4HqQ=;
        b=jsRD3gfIEwL33DY68eNrfQtup1NfGh2x/cE7i71fxc75W9/IHuYF8TAMzKI9p3M3Vm
         pjl1tBkS7zHr37T0F+9h3LpM/ILombNnxGdM073BQPdR03ppMJtodU+iiyiXaLru6hEd
         s2GGESDw8nIXx1KCs+qw8cvANnliDwveYuzDvpR6KXrD4ns5Y6Vy3tUxrY2claX1jtJd
         odET/apDO2ff+R6BHD4e2Qdz2mXPcH7A0Rn978vNdn772ajHGeYmxh+dlPbwnlKeDK0a
         bC0gK9EbnPSw4KaYMkhqhUpGZxXWO0Z+sBShcclcIJOLTACGsYduumaBmoofsRTraFgG
         agdw==
X-Forwarded-Encrypted: i=1; AJvYcCUm9IrS0lph96ZXz3vJwcwU3+P17PgG2B8/D2e2KlJVo1lEzFkDYegpkez9IFXrWIqEA6BhsRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmD+lVpEKssq+Ut3PMK+zgxTBbbLZMP/UkPjQuRfju0cbM0XiL
	71pSfPZXNnepVXf7ZWELNAmjuKRg8Bq+ZjLhJDTlcWXNP1Ol2JU4CIeASdM9maleYVEC0A2RnL0
	jDwI=
X-Gm-Gg: ASbGncssuVgNhYshzrl4O0Iwuq1NT72X69KkqMA46Gjo4frA7Q0tttmbM8fiRDrpT6s
	zf4qyF+hQRZiZQ0xcsjQGdWhOGhMQAx20uiRwqGR6F3Vh1zG3MvJGH/gDquPQ9HQzGKeuhx5c/S
	BKEQ+jz0g6/ab9C2BvBPwFXEW8183zePR4FF8Ynx4U9SejuU+pIQubFiyFW0soyBxGsY9qTomGj
	MQNYvSkcOlaT1V7759UnbO0RDLDfiwP45j9B/BbpnsRwvd8IS6PAE/aIaXRSKH6Ys3JefVS6Bn+
	hqrd42BY8geadkTbBBYiwQJBWvpEU+Rmzfy9N95+bM3VpZoGwIYfVKyfZKad2klnnZzecbXNBQm
	4Yhue/56blqKnpLS19pLSb3TNXEpeZA==
X-Google-Smtp-Source: AGHT+IHTXRCMOdaSKxmlyjmh23Hmlc0rE+6X26SqPbJRMex6OajxVDRbg9AnsMmJiLyEiJLtyhijgA==
X-Received: by 2002:a05:620a:7016:b0:7d2:27b0:370d with SMTP id af79cd13be357-7d44398a220mr1604388785a.42.1751284027536;
        Mon, 30 Jun 2025 04:47:07 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c1:ca4a:289:b941:38b9:cf01? ([2804:7f1:e2c1:ca4a:289:b941:38b9:cf01])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44323be1fsm580086285a.105.2025.06.30.04.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 04:47:06 -0700 (PDT)
Message-ID: <13f558f2-3c0d-4ec7-8a73-c36d8962fecc@mojatatu.com>
Date: Mon, 30 Jun 2025 08:47:03 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incomplete fix for recent bug in tc / hfsc
To: Jamal Hadi Salim <jhs@mojatatu.com>, Lion Ackermann <nnamrec@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, Mingi Cho <mincho@theori.io>
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain>
 <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com>
 <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com>
 <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
 <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/29/25 11:29, Jamal Hadi Salim wrote:
> On Sat, Jun 28, 2025 at 5:43 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>>
>> On Thu, Jun 26, 2025 at 4:08 AM Lion Ackermann <nnamrec@gmail.com> wrote:
>>>
>>> Hi,
>>>
>>> On 6/25/25 4:22 PM, Jamal Hadi Salim wrote:
>>>> On Tue, Jun 24, 2025 at 6:43 AM Lion Ackermann <nnamrec@gmail.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 6/24/25 11:24 AM, Lion Ackermann wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 6/24/25 6:41 AM, Cong Wang wrote:
>>>>>>> On Mon, Jun 23, 2025 at 12:41:08PM +0200, Lion Ackermann wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> I noticed the fix for a recent bug in sch_hfsc in the tc subsystem is
>>>>>>>> incomplete:
>>>>>>>>      sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
>>>>>>>>      https://lore.kernel.org/all/20250518222038.58538-2-xiyou.wangcong@gmail.com/
>>>>>>>>
>>>>>>>> This patch also included a test which landed:
>>>>>>>>      selftests/tc-testing: Add an HFSC qlen accounting test
>>>>>>>>
>>>>>>>> Basically running the included test case on a sanitizer kernel or with
>>>>>>>> slub_debug=P will directly reveal the UAF:
>>>>>>>
>>>>>>> Interesting, I have SLUB debugging enabled in my kernel config too:
>>>>>>>
>>>>>>> CONFIG_SLUB_DEBUG=y
>>>>>>> CONFIG_SLUB_DEBUG_ON=y
>>>>>>> CONFIG_SLUB_RCU_DEBUG=y
>>>>>>>
>>>>>>> But I didn't catch this bug.
>>>>>>>
>>>>>>
>>>>>> Technically the class deletion step which triggered the sanitizer was not
>>>>>> present in your testcase. The testcase only left the stale pointer which was
>>>>>> never accessed though.
>>>>>>
>>>>>>>> To be completely honest I do not quite understand the rationale behind the
>>>>>>>> original patch. The problem is that the backlog corruption propagates to
>>>>>>>> the parent _before_ parent is even expecting any backlog updates.
>>>>>>>> Looking at f.e. DRR: Child is only made active _after_ the enqueue completes.
>>>>>>>> Because HFSC is messing with the backlog before the enqueue completed,
>>>>>>>> DRR will simply make the class active even though it should have already
>>>>>>>> removed the class from the active list due to qdisc_tree_backlog_flush.
>>>>>>>> This leaves the stale class in the active list and causes the UAF.
>>>>>>>>
>>>>>>>> Looking at other qdiscs the way DRR handles child enqueues seems to resemble
>>>>>>>> the common case. HFSC calling dequeue in the enqueue handler violates
>>>>>>>> expectations. In order to fix this either HFSC has to stop using dequeue or
>>>>>>>> all classful qdiscs have to be updated to catch this corner case where
>>>>>>>> child qlen was zero even though the enqueue succeeded. Alternatively HFSC
>>>>>>>> could signal enqueue failure if it sees child dequeue dropping packets to
>>>>>>>> zero? I am not sure how this all plays out with the re-entrant case of
>>>>>>>> netem though.
>>>>>>>
>>>>>>> I think this may be the same bug report from Mingi in the security
>>>>>>> mailing list. I will take a deep look after I go back from Open Source
>>>>>>> Summit this week. (But you are still very welcome to work on it by
>>>>>>> yourself, just let me know.)
>>>>>>>
>>>>>>> Thanks!
>>>>>>
>>>>>>> My suggestion is we go back to a proposal i made a few moons back (was
>>>>>>> this in a discussion with you? i dont remember): create a mechanism to
>>>>>>> disallow certain hierarchies of qdiscs based on certain attributes,
>>>>>>> example in this case disallow hfsc from being the ancestor of "qdiscs that may
>>>>>>> drop during peek" (such as netem). Then we can just keep adding more
>>>>>>> "disallowed configs" that will be rejected via netlink. Similar idea
>>>>>>> is being added to netem to disallow double duplication, see:
>>>>>>> https://lore.kernel.org/netdev/20250622190344.446090-1-will@willsroot.io/
>>>>>>>
>>>>>>> cheers,
>>>>>>> jamal
>>>>>>
>>>>>> I vaguely remember Jamal's proposal from a while back, and I believe there was
>>>>>> some example code for this approach already?
>>>>>> Since there is another report you have a better overview, so it is probably
>>>>>> best you look at it first. In the meantime I can think about the solution a
>>>>>> bit more and possibly draft something if you wish.
>>>>>>
>>>>>> Thanks,
>>>>>> Lion
>>>>>
>>>>> Actually I was intrigued, what do you think about addressing the root of the
>>>>> use-after-free only and ignore the backlog corruption (kind of). After the
>>>>> recent patches where qlen_notify may get called multiple times, we could simply
>>>>> loosen qdisc_tree_reduce_backlog to always notify when the qdisc is empty.
>>>>> Since deletion of all qdiscs will run qdisc_reset / qdisc_purge_queue at one
>>>>> point or another, this should always catch left-overs. And we need not care
>>>>> about all the complexities involved of keeping the backlog right and / or
>>>>> prevent certain hierarchies which seems rather tedious.
>>>>> This requires some more testing, but I was imagining something like this:
>>>>>
>>>>> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>>>>> --- a/net/sched/sch_api.c
>>>>> +++ b/net/sched/sch_api.c
>>>>> @@ -780,15 +780,12 @@ static u32 qdisc_alloc_handle(struct net_device *dev)
>>>>>
>>>>>   void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
>>>>>   {
>>>>> -       bool qdisc_is_offloaded = sch->flags & TCQ_F_OFFLOADED;
>>>>>          const struct Qdisc_class_ops *cops;
>>>>>          unsigned long cl;
>>>>>          u32 parentid;
>>>>>          bool notify;
>>>>>          int drops;
>>>>>
>>>>> -       if (n == 0 && len == 0)
>>>>> -               return;
>>>>>          drops = max_t(int, n, 0);
>>>>>          rcu_read_lock();
>>>>>          while ((parentid = sch->parent)) {
>>>>> @@ -797,17 +794,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
>>>>>
>>>>>                  if (sch->flags & TCQ_F_NOPARENT)
>>>>>                          break;
>>>>> -               /* Notify parent qdisc only if child qdisc becomes empty.
>>>>> -                *
>>>>> -                * If child was empty even before update then backlog
>>>>> -                * counter is screwed and we skip notification because
>>>>> -                * parent class is already passive.
>>>>> -                *
>>>>> -                * If the original child was offloaded then it is allowed
>>>>> -                * to be seem as empty, so the parent is notified anyway.
>>>>> -                */
>>>>> -               notify = !sch->q.qlen && !WARN_ON_ONCE(!n &&
>>>>> -                                                      !qdisc_is_offloaded);
>>>>> +               /* Notify parent qdisc only if child qdisc becomes empty. */
>>>>> +               notify = !sch->q.qlen;
>>>>>                  /* TODO: perform the search on a per txq basis */
>>>>>                  sch = qdisc_lookup(qdisc_dev(sch), TC_H_MAJ(parentid));
>>>>>                  if (sch == NULL) {
>>>>> @@ -816,6 +804,9 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
>>>>>                  }
>>>>>                  cops = sch->ops->cl_ops;
>>>>>                  if (notify && cops->qlen_notify) {
>>>>> +                       /* Note that qlen_notify must be idempotent as it may get called
>>>>> +                        * multiple times.
>>>>> +                        */
>>>>>                          cl = cops->find(sch, parentid);
>>>>>                          cops->qlen_notify(sch, cl);
>>>>>                  }
>>>>>
>>>>
>>>> I believe this will fix the issue. My concern is we are not solving
>>>> the root cause. I also posted a bunch of fixes on related issues for
>>>> something Mingi Cho (on Cc) found - see attachments, i am not in favor
>>>> of these either.
>>>> Most of these setups are nonsensical. After seeing so many of these my
>>>> view is we start disallowing such hierarchies.
>>>>
>>>> cheers,
>>>> jamal
>>>
>>> I would also disagree with the attached patches for various reasons:
>>> - The QFQ patch relies on packet size backlog, which is not to be
>>>    trusted because of several sources that may make this unreliable
>>>    (netem, size tables, GSO, etc.)
>>> - In the TBF variant the ret may get overwritten during the loop,
>>>    so it only relies on the final packet status. I would not trust
>>>    this always working either.
>>> - DRR fix seems fine, but it still requires all other qdiscs to
>>>    be correct (and something similar needs to be applied to all
>>>    classfull qdiscs?)
>>> - The changes to qdisc_tree_reduce_backlog do not really make sense
>>>    to me I must be missing something here..
>>>
>>> What do you think the root cause is here? AFAIK what all the issues
>>> have in common is that eventually qlen_notify is _not_ called,
>>> thus leaving stale class pointers. Naturally the consequence
>>> could be to simply always call qlen_notify on class deletion and
>>> make classfull qdiscs aware that it may get called on inactive
>>> classes. And this is what I tried with my proposal.
>>> This does not solve the backlog issues though. But the pressing
>>> issue seems to be the uaf and not the statistic counters?
>>>
>>> My concern with preventing certain hierarchies is that we would
>>> hide the backlog issues and we would be chasing bad hierarchies.
>>> Still it would also solve all the problems eventually I guess.
>>>
>>
>> On "What do you think the root cause is here?"
>>
>> I believe the root cause is that qdiscs like hfsc and qfq are dropping
>> all packets in enqueue (mostly in relation to peek()) and that result
>> is not being reflected in the return code returned to its parent
>> qdisc.
>> So, in the example you described in this thread, drr is oblivious to
>> the fact that the child qdisc dropped its packet because the call to
>> its child enqueue returned NET_XMIT_SUCCESS. This causes drr to
>> activate a class that shouldn't have been activated at all.
>>
>> You can argue that drr (and other similar qdiscs) may detect this by
>> checking the call to qlen_notify (as the drr patch was
>> doing), but that seems really counter-intuitive. Imagine writing a new
>> qdisc and having to check for that every time you call a child's
>> enqueue. Sure  your patch solves this, but it also seems like it's not
>> fixing the underlying issue (which is drr activating the class in the
>> first place). Your patch is simply removing all the classes from their
>> active lists when you delete them. And your patch may seem ok for now,
>> but I am worried it might break something else in the future that we
>> are not seeing.
>>
>> And do note: All of the examples of the hierarchy I have seen so far,
>> that put us in this situation, are nonsensical
>>
> 
> At this point my thinking is to apply your patch and then we discuss a
> longer term solution. Cong?

I tested Lion's patch quickly with the reproducers:

https://lore.kernel.org/netdev/CAM0EoMnv6YAUJVEFx2mGrP75G8wzRiN+Z=hSfRAz8ia0Fe4vBw@mail.gmail.com/
https://lore.kernel.org/netdev/45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com/
https://lore.kernel.org/netdev/CAM0EoMmA1WLUtamjYNFVZ75NYKznL3K2h8HSv=2z4D3=ZDS83Q@mail.gmail.com/#r

The patch seems to fix the repros.
Also ran tdc on it and the tests passed.

cheers,
Victor

