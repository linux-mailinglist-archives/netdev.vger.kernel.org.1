Return-Path: <netdev+bounces-201441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A3CAE9785
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035E11C25178
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFDE25B675;
	Thu, 26 Jun 2025 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSt0AeYx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ABF23B61E
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925317; cv=none; b=XEqhFWkOHCiHSFWyZdGVlbzC/VOhOBJoya9Be5LNS3Uf8NCejXE/jk5YO5v8KqfWpeq0W1JDWeqdp4goHAN6Afb3908Jz0jAo/Kl6PTitpTpAjhyhqBH90r+MjDK/yRCvtGOm/R90AHcM30xnXo208JQ5ZvV8Ab8XVcb5OlGrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925317; c=relaxed/simple;
	bh=+6OmgxIjwfCj3tIrnH5h2dd9dL4trP5vG6RyUO0Iwtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KL7g01j/qhmtHSxGjq8u7RVOUAG5hsGaAzkLcm2o//XYL15/nP79+ghBmNzHYu/OpAacKcfeATPI6EfkO7GXyq+Aun39ezmdCCMSbdtL0UFvvwReeKGXxnefnA9sJTZ2I/DIRiPNgEjMvh3TJXb7XqbXDHdZq5V5+ryOX7hhPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSt0AeYx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-adb2bb25105so105849666b.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 01:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750925314; x=1751530114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6KiaR6bRe5IV4oK7xiPyHvsPrEAatHqawqwtb3htWM=;
        b=DSt0AeYxyJTJEAL+nIr1XSuhHh3gbEwOtcbcKWuhgt+GV0GJpyvhVE+VFO92VZqQt2
         pd9lgZkf1y4qLTwnEM07zMrQQIMJwcyVS65cjErsEjEN+TQ714dWnyi88l1OSN6HOXbH
         /jMUsNxwviqLsFVEkW6C7cPH59IPFWvxRL99DqOMHA4qh0GS+V7kjXRmRxhbR4c/W8sZ
         H1Yn49ORpsqUNr9S/gL2rbznXLmllwosTqMq3BNeGuOne9YlCE8K8xjjbbXcTXJITCSa
         Xq2EhZhrrgFnHgWMg5H0b4KUVohnS2OkswWgvRlEvV6XYmTw/lj6dUKCBSsokYOpJxW1
         DQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750925314; x=1751530114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6KiaR6bRe5IV4oK7xiPyHvsPrEAatHqawqwtb3htWM=;
        b=qUY/doWJASF/KQ6fYN69N1q8PfTHEks2J5hcvZDGFCNCiWpyGe7ozfvyo55l+T8zNL
         9boMwydOQ1qni68jh9JScpS/mjtiKgF4awuAMCwmg5UnMPBBYSBeWkISfCz42Ld4DMcC
         AlYSDDAccOzUOuow1urCLtXC0/nnfvodRW8VAlYGbGTTrqVyOwF1c/VNB/HOBvAsyL6D
         skjzfXvQvvK80lACzEhNvvdH7iaEX1M1XGST9GCYXj/BstnR+85cL2hpbjktVew2td7e
         IuQ7WD2WSubGD2YeNUVBVaFy3AvuABPbhBSOWX+c4FXdkdv/zd0htY/6hPha0OOAizQ1
         QNRA==
X-Forwarded-Encrypted: i=1; AJvYcCWGM1g5U5996nTT4i+j2DAZl/8FDURJ7QrIvYQ57Ibf2aE5i9aMCdjg/n4XRpwMZYNARFzUbA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaxFfko93lNSQOTcala7ZAm3hwgffD4F2sr0vjZfiuDjK40bGC
	Ht3Hkpu3a6jLv6CIpiDdvsykmnwWmDXghDCANZWWUjZ31mpFYWWbSQDNXtAIBNc8wPY=
X-Gm-Gg: ASbGnctimnOx0UdHI4Z5JgGSl+YvK7pFUeitVStg4WwobiJo5d76rXo0Zrao39WZUfb
	Uj8OBX2qXZd5uNUlfO/Wf5iGapw9tHNSHqh026gegd1UD694T1yz9C/xOLD1qpbVtOxSW1E/sux
	Uv1cJoHFhPoanQz4ZIFgtc9k1DDUcXBSuRZAaVZ8ulP7kAsHui1Uieah1T/4biJ/vR3N1bma/iR
	TPTwY9BpusVUBiZJ+z9vM5xnvdUnhXoRhReiUg7DHxjmnW76MOrSl8IO9UITySd1W/9tsQB9VLz
	XHk1i4DkwnJ80zDSeDxM+yy6GMwSYmv8PYcITTF3viAc+7v23wHZbfe0cgpkkXtMQLT+rG0GC/4
	Z/dHjnIKB0GIQC2iyoWVjBJuCENXrBxrO55UxT1tUG1+XQIW7vSb5zEkhDTrt8vDHC/G/7a4Yvl
	u5AQ5qBjEbd/QV2Jc=
X-Google-Smtp-Source: AGHT+IGIfW6yUUOOR2JrubE/GLgqzWX/r1FG5jxsXSe+Lr4F+1WxQ5QS95/getYNRlssktgV+L2aLg==
X-Received: by 2002:a17:907:3ea3:b0:ae0:180b:bb54 with SMTP id a640c23a62f3a-ae0be9afa78mr629305566b.26.1750925313184;
        Thu, 26 Jun 2025 01:08:33 -0700 (PDT)
Received: from ?IPV6:2003:ed:774b:fc77:a1c1:39b8:98a6:45a9? (p200300ed774bfc77a1c139b898a645a9.dip0.t-ipconnect.de. [2003:ed:774b:fc77:a1c1:39b8:98a6:45a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0d7ea4478sm78021866b.7.2025.06.26.01.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 01:08:32 -0700 (PDT)
Message-ID: <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com>
Date: Thu, 26 Jun 2025 10:08:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incomplete fix for recent bug in tc / hfsc
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, Mingi Cho <mincho@theori.io>
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain>
 <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com>
 <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
Content-Language: en-US
From: Lion Ackermann <nnamrec@gmail.com>
In-Reply-To: <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 6/25/25 4:22 PM, Jamal Hadi Salim wrote:
> On Tue, Jun 24, 2025 at 6:43 AM Lion Ackermann <nnamrec@gmail.com> wrote:
>>
>> Hi,
>>
>> On 6/24/25 11:24 AM, Lion Ackermann wrote:
>>> Hi,
>>>
>>> On 6/24/25 6:41 AM, Cong Wang wrote:
>>>> On Mon, Jun 23, 2025 at 12:41:08PM +0200, Lion Ackermann wrote:
>>>>> Hello,
>>>>>
>>>>> I noticed the fix for a recent bug in sch_hfsc in the tc subsystem is
>>>>> incomplete:
>>>>>     sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
>>>>>     https://lore.kernel.org/all/20250518222038.58538-2-xiyou.wangcong@gmail.com/
>>>>>
>>>>> This patch also included a test which landed:
>>>>>     selftests/tc-testing: Add an HFSC qlen accounting test
>>>>>
>>>>> Basically running the included test case on a sanitizer kernel or with
>>>>> slub_debug=P will directly reveal the UAF:
>>>>
>>>> Interesting, I have SLUB debugging enabled in my kernel config too:
>>>>
>>>> CONFIG_SLUB_DEBUG=y
>>>> CONFIG_SLUB_DEBUG_ON=y
>>>> CONFIG_SLUB_RCU_DEBUG=y
>>>>
>>>> But I didn't catch this bug.
>>>>
>>>
>>> Technically the class deletion step which triggered the sanitizer was not
>>> present in your testcase. The testcase only left the stale pointer which was
>>> never accessed though.
>>>
>>>>> To be completely honest I do not quite understand the rationale behind the
>>>>> original patch. The problem is that the backlog corruption propagates to
>>>>> the parent _before_ parent is even expecting any backlog updates.
>>>>> Looking at f.e. DRR: Child is only made active _after_ the enqueue completes.
>>>>> Because HFSC is messing with the backlog before the enqueue completed,
>>>>> DRR will simply make the class active even though it should have already
>>>>> removed the class from the active list due to qdisc_tree_backlog_flush.
>>>>> This leaves the stale class in the active list and causes the UAF.
>>>>>
>>>>> Looking at other qdiscs the way DRR handles child enqueues seems to resemble
>>>>> the common case. HFSC calling dequeue in the enqueue handler violates
>>>>> expectations. In order to fix this either HFSC has to stop using dequeue or
>>>>> all classful qdiscs have to be updated to catch this corner case where
>>>>> child qlen was zero even though the enqueue succeeded. Alternatively HFSC
>>>>> could signal enqueue failure if it sees child dequeue dropping packets to
>>>>> zero? I am not sure how this all plays out with the re-entrant case of
>>>>> netem though.
>>>>
>>>> I think this may be the same bug report from Mingi in the security
>>>> mailing list. I will take a deep look after I go back from Open Source
>>>> Summit this week. (But you are still very welcome to work on it by
>>>> yourself, just let me know.)
>>>>
>>>> Thanks!
>>>
>>>> My suggestion is we go back to a proposal i made a few moons back (was
>>>> this in a discussion with you? i dont remember): create a mechanism to
>>>> disallow certain hierarchies of qdiscs based on certain attributes,
>>>> example in this case disallow hfsc from being the ancestor of "qdiscs that may
>>>> drop during peek" (such as netem). Then we can just keep adding more
>>>> "disallowed configs" that will be rejected via netlink. Similar idea
>>>> is being added to netem to disallow double duplication, see:
>>>> https://lore.kernel.org/netdev/20250622190344.446090-1-will@willsroot.io/
>>>>
>>>> cheers,
>>>> jamal
>>>
>>> I vaguely remember Jamal's proposal from a while back, and I believe there was
>>> some example code for this approach already?
>>> Since there is another report you have a better overview, so it is probably
>>> best you look at it first. In the meantime I can think about the solution a
>>> bit more and possibly draft something if you wish.
>>>
>>> Thanks,
>>> Lion
>>
>> Actually I was intrigued, what do you think about addressing the root of the
>> use-after-free only and ignore the backlog corruption (kind of). After the
>> recent patches where qlen_notify may get called multiple times, we could simply
>> loosen qdisc_tree_reduce_backlog to always notify when the qdisc is empty.
>> Since deletion of all qdiscs will run qdisc_reset / qdisc_purge_queue at one
>> point or another, this should always catch left-overs. And we need not care
>> about all the complexities involved of keeping the backlog right and / or
>> prevent certain hierarchies which seems rather tedious.
>> This requires some more testing, but I was imagining something like this:
>>
>> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>> --- a/net/sched/sch_api.c
>> +++ b/net/sched/sch_api.c
>> @@ -780,15 +780,12 @@ static u32 qdisc_alloc_handle(struct net_device *dev)
>>
>>  void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
>>  {
>> -       bool qdisc_is_offloaded = sch->flags & TCQ_F_OFFLOADED;
>>         const struct Qdisc_class_ops *cops;
>>         unsigned long cl;
>>         u32 parentid;
>>         bool notify;
>>         int drops;
>>
>> -       if (n == 0 && len == 0)
>> -               return;
>>         drops = max_t(int, n, 0);
>>         rcu_read_lock();
>>         while ((parentid = sch->parent)) {
>> @@ -797,17 +794,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
>>
>>                 if (sch->flags & TCQ_F_NOPARENT)
>>                         break;
>> -               /* Notify parent qdisc only if child qdisc becomes empty.
>> -                *
>> -                * If child was empty even before update then backlog
>> -                * counter is screwed and we skip notification because
>> -                * parent class is already passive.
>> -                *
>> -                * If the original child was offloaded then it is allowed
>> -                * to be seem as empty, so the parent is notified anyway.
>> -                */
>> -               notify = !sch->q.qlen && !WARN_ON_ONCE(!n &&
>> -                                                      !qdisc_is_offloaded);
>> +               /* Notify parent qdisc only if child qdisc becomes empty. */
>> +               notify = !sch->q.qlen;
>>                 /* TODO: perform the search on a per txq basis */
>>                 sch = qdisc_lookup(qdisc_dev(sch), TC_H_MAJ(parentid));
>>                 if (sch == NULL) {
>> @@ -816,6 +804,9 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
>>                 }
>>                 cops = sch->ops->cl_ops;
>>                 if (notify && cops->qlen_notify) {
>> +                       /* Note that qlen_notify must be idempotent as it may get called
>> +                        * multiple times.
>> +                        */
>>                         cl = cops->find(sch, parentid);
>>                         cops->qlen_notify(sch, cl);
>>                 }
>>
> 
> I believe this will fix the issue. My concern is we are not solving
> the root cause. I also posted a bunch of fixes on related issues for
> something Mingi Cho (on Cc) found - see attachments, i am not in favor
> of these either.
> Most of these setups are nonsensical. After seeing so many of these my
> view is we start disallowing such hierarchies.
> 
> cheers,
> jamal

I would also disagree with the attached patches for various reasons:
- The QFQ patch relies on packet size backlog, which is not to be
  trusted because of several sources that may make this unreliable
  (netem, size tables, GSO, etc.)
- In the TBF variant the ret may get overwritten during the loop,
  so it only relies on the final packet status. I would not trust
  this always working either.
- DRR fix seems fine, but it still requires all other qdiscs to 
  be correct (and something similar needs to be applied to all
  classfull qdiscs?)
- The changes to qdisc_tree_reduce_backlog do not really make sense
  to me I must be missing something here..

What do you think the root cause is here? AFAIK what all the issues 
have in common is that eventually qlen_notify is _not_ called, 
thus leaving stale class pointers. Naturally the consequence 
could be to simply always call qlen_notify on class deletion and 
make classfull qdiscs aware that it may get called on inactive 
classes. And this is what I tried with my proposal.
This does not solve the backlog issues though. But the pressing 
issue seems to be the uaf and not the statistic counters?

My concern with preventing certain hierarchies is that we would 
hide the backlog issues and we would be chasing bad hierarchies.
Still it would also solve all the problems eventually I guess.

Thanks,
Lion



