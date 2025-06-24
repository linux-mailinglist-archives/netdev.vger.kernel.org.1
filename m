Return-Path: <netdev+bounces-200582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E8AE62C2
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D85189265E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8DD280318;
	Tue, 24 Jun 2025 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw0zfxMO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5D4223704
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761812; cv=none; b=IcgPQRI0TocT3/ttWxEoiQ2HZciNVC+A7qvWToNV8vEyP9QCEdFaP+IjgpgLeacbmtLsucRarlBn6VXMDi7LECZXxnSSVjfKc14w4Qxniy86/HRAt2CyK8s6aSJG0wDyGfoOENcE9xC60RZMuIyRA5JFdR+xosXyEZX/02zp8/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761812; c=relaxed/simple;
	bh=nvxDDaNKnUcqS7Nr7/FLXUQ88t1Gs6tXSp9Ula6h3j8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kUpcALfImmMPcGvWriR9sQ0YiAVVuhIoChKSVCpCRNd29vezE4+V7imIszFO8+dMmVYKCvoTvVvt78wjED7317KslwggHTFcSJYeFLg5l3W6P3u8aTEhNw7oxwGGXC04peI1lNgDmmCPA9qA01x28xiAUL23Cu6YgwvB6eexp7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw0zfxMO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-453749af004so1567855e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 03:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750761809; x=1751366609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z07Ji83ZlzY12zaV+p5K5uMNt1HkV84FmlbN+zKstPI=;
        b=Hw0zfxMONXztDv3h9avEITV4aednyz4KjCZBZWGgU3rrf0bc954bEKJpiMJbvEKVK/
         ND5T5cQsdMVqf4l1l2LN2B6ZDWBwyddxvRwVQnulUpF3d4NQsQNsB8ilEwqleigIdpfc
         SGXtY9CGVRr6VWPdq56faaYMTVJnRCHtyT1VWGlyuA+QgbUs9QubjHGc3tTjf3mf05Mf
         dAmgHSLi5vEuofEmEFAX9CTCKDr0gFepO4pgj8EvRKuOxTMZSU6iB0XM/X66ICgGAhWs
         UQuxH4WUtTwrnXhGHCZf5NHwB2LzfrMZ/AUnBc60sK7R//jBWnouByv3DrKRCQYQONam
         +oYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750761809; x=1751366609;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z07Ji83ZlzY12zaV+p5K5uMNt1HkV84FmlbN+zKstPI=;
        b=LvvQDoQ4l/PWXI2LTxYdzkDbNpJcXHCgDSO1/Ord3lsvg0Nd1NfyYWHbBCpbDc1J85
         2ZVCgsi5B8uSRlrYjMc3g/51cS3Rnj+Dj+s/DIGkO5Zu5VNUdkMxw00XAwvxVidrXG9s
         osJC7yyqDzPAjmJdSKUEQix1TCxsbaxgM94AVeo0F4CHHeU0sPVgbizpR/ofRByFXky6
         8XbinwRUk/K4cONHyZ8niHqN9lOZEFaMqgYQYT7IKpTDj3Vo9/G+s4kU2dO0CqK5QLBE
         4G9Atze0NkGk2rA8yj2I1pDfVGVUIw2f8+2K3RAOilbgkX6muOyRJpJgBc0fz2z+3KuE
         eFUQ==
X-Gm-Message-State: AOJu0YyGnHr6SQqg1H/7SPtQ3QJwp4HRrhV5zcdYRUOEg0x39plhV5ZW
	At/8kiiFtItGLxMzJ7U7UI+OFJ2PdgcElhW92ERSSHEF6oPmD902bvz0VOpyrL2U6o0=
X-Gm-Gg: ASbGncueg9UYYge0/Y2pxRO8iv/9JXxsTPHx9ZESzdODDYpT/nfr6/L1wdmPJFpho2J
	lVZV0oPh7oocijL9ZPTJ0QLv92iiNuOn1SKoZvBu08AlJFeF5MR0CRwgtVbneuJKj08MnHHrwx6
	UZG8juVgtVr5g1fJLrApe9LU2xb1HFF4ipszauYZZGcfzEvtuXk7aTYo2/ekYel6wB86r4nKZqp
	BtMchvD7szypNtMvHWolNpX7Liv8Z59v7xzEK8pFTaEyCyXgSmrCA07wDVYLWfJ5BThKvxEJn5t
	BUb8rRqnaJxLWDPG2W+GBF71mgV4jcAViBuqdsO+KBGIBJcQYHg6ehqJLrWAOW1uZGwp1oimT9+
	uR0/VUNj8p6zCfN53AhdmAwnCSUQKPE3V7QzZnGtawZuAHYXRTQnK0rgvFCXrVHMPS+6oY/WY1N
	uOWd/AIpK9MLyvjbU=
X-Google-Smtp-Source: AGHT+IH4uEWorpOr8pZ/OAj+8RFuJTH3V4ZMjPwh+VX7PTXmfN5bFwJ2I20APc5fCglEFBiid0eEWg==
X-Received: by 2002:a05:600c:4e8b:b0:453:608:a18b with SMTP id 5b1f17b1804b1-453654cb7dfmr177077465e9.9.1750761808892;
        Tue, 24 Jun 2025 03:43:28 -0700 (PDT)
Received: from ?IPV6:2003:ed:774b:fc38:d9ac:77b7:ed46:71db? (p200300ed774bfc38d9ac77b7ed4671db.dip0.t-ipconnect.de. [2003:ed:774b:fc38:d9ac:77b7:ed46:71db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646d14f3sm137426565e9.13.2025.06.24.03.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 03:43:28 -0700 (PDT)
Message-ID: <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com>
Date: Tue, 24 Jun 2025 12:43:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incomplete fix for recent bug in tc / hfsc
From: Lion Ackermann <nnamrec@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain>
 <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
Content-Language: en-US
In-Reply-To: <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/24/25 11:24 AM, Lion Ackermann wrote:
> Hi,
> 
> On 6/24/25 6:41 AM, Cong Wang wrote:
>> On Mon, Jun 23, 2025 at 12:41:08PM +0200, Lion Ackermann wrote:
>>> Hello,
>>>
>>> I noticed the fix for a recent bug in sch_hfsc in the tc subsystem is
>>> incomplete:
>>>     sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
>>>     https://lore.kernel.org/all/20250518222038.58538-2-xiyou.wangcong@gmail.com/
>>>
>>> This patch also included a test which landed:
>>>     selftests/tc-testing: Add an HFSC qlen accounting test
>>>
>>> Basically running the included test case on a sanitizer kernel or with
>>> slub_debug=P will directly reveal the UAF:
>>
>> Interesting, I have SLUB debugging enabled in my kernel config too:
>>
>> CONFIG_SLUB_DEBUG=y
>> CONFIG_SLUB_DEBUG_ON=y
>> CONFIG_SLUB_RCU_DEBUG=y
>>
>> But I didn't catch this bug.
>>  
> 
> Technically the class deletion step which triggered the sanitizer was not
> present in your testcase. The testcase only left the stale pointer which was
> never accessed though.
> 
>>> To be completely honest I do not quite understand the rationale behind the
>>> original patch. The problem is that the backlog corruption propagates to
>>> the parent _before_ parent is even expecting any backlog updates.
>>> Looking at f.e. DRR: Child is only made active _after_ the enqueue completes.
>>> Because HFSC is messing with the backlog before the enqueue completed, 
>>> DRR will simply make the class active even though it should have already
>>> removed the class from the active list due to qdisc_tree_backlog_flush.
>>> This leaves the stale class in the active list and causes the UAF.
>>>
>>> Looking at other qdiscs the way DRR handles child enqueues seems to resemble
>>> the common case. HFSC calling dequeue in the enqueue handler violates
>>> expectations. In order to fix this either HFSC has to stop using dequeue or
>>> all classful qdiscs have to be updated to catch this corner case where
>>> child qlen was zero even though the enqueue succeeded. Alternatively HFSC
>>> could signal enqueue failure if it sees child dequeue dropping packets to
>>> zero? I am not sure how this all plays out with the re-entrant case of
>>> netem though.
>>
>> I think this may be the same bug report from Mingi in the security
>> mailing list. I will take a deep look after I go back from Open Source
>> Summit this week. (But you are still very welcome to work on it by
>> yourself, just let me know.)
>>
>> Thanks!
> 
>> My suggestion is we go back to a proposal i made a few moons back (was
>> this in a discussion with you? i dont remember): create a mechanism to
>> disallow certain hierarchies of qdiscs based on certain attributes,
>> example in this case disallow hfsc from being the ancestor of "qdiscs that may
>> drop during peek" (such as netem). Then we can just keep adding more
>> "disallowed configs" that will be rejected via netlink. Similar idea
>> is being added to netem to disallow double duplication, see:
>> https://lore.kernel.org/netdev/20250622190344.446090-1-will@willsroot.io/
>>
>> cheers,
>> jamal
> 
> I vaguely remember Jamal's proposal from a while back, and I believe there was 
> some example code for this approach already? 
> Since there is another report you have a better overview, so it is probably 
> best you look at it first. In the meantime I can think about the solution a 
> bit more and possibly draft something if you wish.
> 
> Thanks,
> Lion

Actually I was intrigued, what do you think about addressing the root of the
use-after-free only and ignore the backlog corruption (kind of). After the 
recent patches where qlen_notify may get called multiple times, we could simply
loosen qdisc_tree_reduce_backlog to always notify when the qdisc is empty.
Since deletion of all qdiscs will run qdisc_reset / qdisc_purge_queue at one
point or another, this should always catch left-overs. And we need not care
about all the complexities involved of keeping the backlog right and / or
prevent certain hierarchies which seems rather tedious.
This requires some more testing, but I was imagining something like this:

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -780,15 +780,12 @@ static u32 qdisc_alloc_handle(struct net_device *dev)
 
 void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 {
-	bool qdisc_is_offloaded = sch->flags & TCQ_F_OFFLOADED;
 	const struct Qdisc_class_ops *cops;
 	unsigned long cl;
 	u32 parentid;
 	bool notify;
 	int drops;
 
-	if (n == 0 && len == 0)
-		return;
 	drops = max_t(int, n, 0);
 	rcu_read_lock();
 	while ((parentid = sch->parent)) {
@@ -797,17 +794,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 
 		if (sch->flags & TCQ_F_NOPARENT)
 			break;
-		/* Notify parent qdisc only if child qdisc becomes empty.
-		 *
-		 * If child was empty even before update then backlog
-		 * counter is screwed and we skip notification because
-		 * parent class is already passive.
-		 *
-		 * If the original child was offloaded then it is allowed
-		 * to be seem as empty, so the parent is notified anyway.
-		 */
-		notify = !sch->q.qlen && !WARN_ON_ONCE(!n &&
-						       !qdisc_is_offloaded);
+		/* Notify parent qdisc only if child qdisc becomes empty. */
+		notify = !sch->q.qlen;
 		/* TODO: perform the search on a per txq basis */
 		sch = qdisc_lookup(qdisc_dev(sch), TC_H_MAJ(parentid));
 		if (sch == NULL) {
@@ -816,6 +804,9 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 		}
 		cops = sch->ops->cl_ops;
 		if (notify && cops->qlen_notify) {
+			/* Note that qlen_notify must be idempotent as it may get called
+			 * multiple times.
+			 */
 			cl = cops->find(sch, parentid);
 			cops->qlen_notify(sch, cl);
 		}

Thanks,
Lion

