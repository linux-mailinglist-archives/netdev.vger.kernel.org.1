Return-Path: <netdev+bounces-43072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CC37D1486
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3D3B21300
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A927200BC;
	Fri, 20 Oct 2023 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ide65ezk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FA31A73F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 17:04:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C4EA3
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697821456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fY/+7D/WwSGP0A+iL/7hmdI+NWxLC5hyOEm5LxOpZX8=;
	b=ide65ezkTYWzAUNlMeuxGpJZbrb8YVHBxXGnPMsQ6J5k70JxWkVGgXEbLShcqKvwSuUTqV
	GngP1dmBah2Y8mghBC7DB7WUZ9zXyQE1sO5rBVC2+qW6Q+Cu4/PTWfG2J9YKFH7GQEws4z
	/HSSUwXE5XgOnVdDsbtDGHMkRESbML0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-1CqoROwjOm-LHURhRFPsOA-1; Fri, 20 Oct 2023 13:04:15 -0400
X-MC-Unique: 1CqoROwjOm-LHURhRFPsOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73F5210201F1;
	Fri, 20 Oct 2023 17:04:14 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.9.53])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C7F8111D794;
	Fri, 20 Oct 2023 17:04:13 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: "Nicholas Piggin" <npiggin@gmail.com>
Cc: <netdev@vger.kernel.org>,  <dev@openvswitch.org>,  "Pravin B Shelar"
 <pshelar@ovn.org>,  "Eelco Chaudron" <echaudro@redhat.com>,  "Ilya
 Maximets" <imaximet@redhat.com>,  "Flavio Leitner" <fbl@redhat.com>,
  "Paolo Abeni" <pabeni@redhat.com>,  "Jakub Kicinski" <kuba@kernel.org>,
  "David S. Miller" <davem@davemloft.net>,  "Eric Dumazet"
 <edumazet@google.com>
Subject: Re: [PATCH 0/7] net: openvswitch: Reduce stack usage
References: <20231011034344.104398-1-npiggin@gmail.com>
	<f7ta5spe1ix.fsf@redhat.com> <CW62DEF1LEWB.3KK4CQJNGIRYO@wheely>
Date: Fri, 20 Oct 2023 13:04:13 -0400
In-Reply-To: <CW62DEF1LEWB.3KK4CQJNGIRYO@wheely> (Nicholas Piggin's message of
	"Thu, 12 Oct 2023 11:19:28 +1000")
Message-ID: <f7til71dy42.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

"Nicholas Piggin" <npiggin@gmail.com> writes:

> On Wed Oct 11, 2023 at 11:23 PM AEST, Aaron Conole wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>>
>> > Hi,
>> >
>> > I'll post this out again to keep discussion going. Thanks all for the
>> > testing and comments so far.
>>
>> Thanks for the update - did you mean for this to be tagged RFC as well?
>
> Yeah, it wasn't intended for merge with no RB or tests of course.
> I intended to tag it RFC v2.

I only did a basic test with this because of some other stuff, and I
only tested 1, 2, and 3.  I didn't see any real performance changes, but
that is only with a simple port-port test.  I plan to do some additional
testing with some recursive calls.  That will also help to understand
the limits a bit.

That said, I'm very nervous about the key allocator, especially if it is
possible that it runs out.  We probably will need the limit to be
bigger, but I want to get a worst-case flow from OVN side to understand.

>>
>> I don't see any performance data with the deployments on x86_64 and
>> ppc64le that cause these stack overflows.  Are you able to provide the
>> impact on ppc64le and x86_64?
>
> Don't think it'll be easy but they are not be pushing such rates
> so it wouldn't say much.  If you want to show the worst case, those
> tput and latency microbenchmarks should do it.
>
> It's the same tradeoff and reasons the per-cpu key allocator was
> added in the first place, presumably. Probably more expensive than
> stack, but similar order of magnitude O(cycles) vs slab which is
> probably O(100s cycles).
>
>> I guess the change probably should be tagged as -next since it doesn't
>> really have a specific set of commits it is "fixing."  It's really like
>> a major change and shouldn't really go through stable trees, but I'll
>> let the maintainers tell me off if I got it wrong.
>
> It should go upstream first if anything. I thought it was relatively
> simple and elegant to reuse the per-cpu key allocator though :(
>
> It is a kernel crash, so we need something for stable. But In a case
> like this there's not one single problem. Linux kernel stack use has
> always been pretty dumb - "don't use too much", for some values of
> too much, and just cross fingers config and compiler and worlkoad
> doesn't hit some overflow case.
>
> And powerpc has always used more stack x86, so probably it should stay
> one power-of-two larger to be safe. And that may be the best fix for
> -stable.

Given the reply from David (with msg-id:
<ff6cd12e28894f158d9a6c9f7157487f@AcuMS.aculab.com>), are there other
things we can look at with respect to the compiler as well?

> But also, ovs uses too much stack. Look at the stack sizes in the first
> RFC patch, and ovs takes the 5 largest. That's because it has always
> been the practice to not put large variables on stack, and when you're
> introducing significant recursion that puts extra onus on you to be
> lean. Even if it costs a percent. There are probably lots of places in
> the kernel that could get a few cycles by sticking large structures on
> stack, but unfortunately we can't all do that.

Well, OVS operated this way for at least 6 years, so it isn't a recent
thing.  But we should look at it.

I also wonder if we need to recurse in the internal devices, or if we
shouldn't just push the skb into the packet queue.  That will cut out
1/3 of the stack frame that you reported originally, and then when doing
the xmit, will cut out 2/3rds. I have no idea what the performance
impact hit there might be.  Maybe it looks more like a latency hit
rather than a throughput hit, but just speculating.

> Thanks,
> Nick


