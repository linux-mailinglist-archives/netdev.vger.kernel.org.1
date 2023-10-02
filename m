Return-Path: <netdev+bounces-37378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7AF7B51C1
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0B23A283C26
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 11:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9528314F6B;
	Mon,  2 Oct 2023 11:54:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508338488
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 11:54:07 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7164194
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 04:54:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AEB52000A;
	Mon,  2 Oct 2023 11:54:02 +0000 (UTC)
Message-ID: <21f2a427-ad07-ee73-30f5-d9a8f1ed4f85@ovn.org>
Date: Mon, 2 Oct 2023 13:54:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: i.maximets@ovn.org, dev@openvswitch.org, Aaron Conole
 <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Simon Horman <horms@ovn.org>
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, netdev@vger.kernel.org
References: <20230927001308.749910-1-npiggin@gmail.com>
 <a018e82f-5cce-fb81-b52c-901e106c16eb@ovn.org>
 <CVU6AV9T8CVH.GCHC8KB7QZ28@wheely>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [ovs-dev] [RFC PATCH 0/7] net: openvswitch: Reduce stack usage
In-Reply-To: <CVU6AV9T8CVH.GCHC8KB7QZ28@wheely>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/28/23 03:52, Nicholas Piggin wrote:
> On Wed Sep 27, 2023 at 6:36 PM AEST, Ilya Maximets wrote:
>> On 9/27/23 02:13, Nicholas Piggin wrote:
>>> Hi,
>>>
>>> We've got a report of a stack overflow on ppc64le with a 16kB kernel
>>> stack. Openvswitch is just one of many things in the stack, but it
>>> does cause recursion and contributes to some usage.
>>>
>>> Here are a few patches for reducing stack overhead. I don't know the
>>> code well so consider them just ideas. GFP_ATOMIC allocations
>>> introduced in a couple of places might be controversial, but there
>>> is still some savings to be had if you skip those.
>>>
>>> Here is one place detected where the stack reaches >14kB before
>>> overflowing a little later. I massaged the output so it just shows
>>> the stack frame address on the left.
>>
>> Hi, Nicholas.  Thanks for the patches!
> 
> Hey, sorry your mail didn't come through for me (though it's on the
> list)... Anyway thanks for the feedback.
> 
> And the important thing I forgot to mention: this was reproduced on a
> RHEL9 kernel and that's where the traces are from. Upstream is quite
> similar though so the code and call chains and stack use should be
> pretty close.
> 
> It's a complicated configuration we're having difficulty with testing
> upstream kernel. People are working to test things on the RHEL kernel
> but I wanted to bring this upstream before we get too far down that
> road.
> 
> Unfortunately that means I don't have performance or exact stack
> use savings yet. But I will let you know if/when I get results.
> 
>> Though it looks like OVS is not really playing a huge role in the
>> stack trace below.  How much of the stack does the patch set save
>> in total?  How much patches 2-7 contribute (I posted a patch similar
>> to the first one last week, so we may not count it)?
> 
> ovs functions themselves are maybe 30% of stack use, so significant.  I
> did find they are the ones with some of the biggest structures in local
> variables though, so low hanging fruit. This series should save about
> 2kB of stack, by eyeball. Should be enough to get us out of trouble for
> this scenario, at least.

Unfortunately, the only low handing fruit in this set is patch #1,
the rest needs a serious performance evaluation.

> 
> I don't suggest ovs is the only problem, I'm just trying to trim things
> where possible. I have been trying to find other savings too, e.g.,
> https://lore.kernel.org/linux-nfs/20230927001624.750031-1-npiggin@gmail.com/
> 
> Recursion is a difficulty. I think we recursed 3 times in ovs, and it
> looks like there's either 1 or 2 more recursions possible before the
> limit (depending on how the accounting works, not sure if it stops at
> 4 or 5), so we're a long way off. ppc64le doesn't use an unusually large
> amount of stack, probably more than x86-64, but shouldn't be by a big
> factor. So it could be risky for any arch with 16kB stack.

The stack trace looks like a very standard trace for something like
an ovn-kubernetes setup.  And I haven't seen such issues on x86 or
aarch64 systems.  What architectures beside ppc64le use 16kB stack?

> 
> I wonder if we should have an arch function that can be called by
> significant recursion points such as this, which signals free stack is
> low and you should bail out ASAP. I don't think it's reasonable to
> expect ovs to know about all arch size and usage of stack. You could
> keep your hard limit for consistency, but if that goes wrong the
> low free stack indication could save you.

Every part of the code will need to react somehow to such a signal,
so I'm not sure how the implementations would look like.

> 
>>
>> Also, most of the changes introduced here has a real chance to
>> noticeably impact performance.  Did you run any performance tests
>> with this to assess the impact?
> 
> Will see if we can do that, but I doubt this setup would be too
> sensitive to small changes so it might be something upstream would have
> to help evaluate. Function calls and even small kmalloc/free on the same
> CPU shouldn't be too costly I hope, but I don't know how hot these paths
> can get.

This code path unfortunately is as hot as it gets as it needs to be able
to process millions of packets per second.  Even small changes may cause
significant performance impact. 

> 
>>
>> One last thing is that at least some of the patches seem to change
>> non-inlined non-recursive functions.  Seems unnecessary.
> 
> I was concentrating on functions in the recursive path, but there
> were one or two big ones just off the side that still can be called
> when you're deep into stack. In general it's just a good idea to
> be frugal as reasonably possible with kernel stack always so I
> wouldn't say unnecessary, but yes arguably less important. I defer
> to your judgement about cost and benefit of all these changes
> though.
> 
> Thanks,
> Nick


