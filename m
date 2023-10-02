Return-Path: <netdev+bounces-37380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFDA7B51C7
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 13:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C903D283F5C
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A299B1548A;
	Mon,  2 Oct 2023 11:55:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EAE15E99
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 11:55:18 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D782A6
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 04:55:15 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63BE724000B;
	Mon,  2 Oct 2023 11:55:12 +0000 (UTC)
Message-ID: <2c01d102-3c84-3edc-a92a-a0b9a889d70d@ovn.org>
Date: Mon, 2 Oct 2023 13:56:02 +0200
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
 <CVV7MBT9C7JY.5PYBOXU9NUDR@wheely>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [ovs-dev] [RFC PATCH 0/7] net: openvswitch: Reduce stack usage
In-Reply-To: <CVV7MBT9C7JY.5PYBOXU9NUDR@wheely>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/29/23 09:06, Nicholas Piggin wrote:
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
>>
>> Though it looks like OVS is not really playing a huge role in the
>> stack trace below.  How much of the stack does the patch set save
>> in total?  How much patches 2-7 contribute (I posted a patch similar
>> to the first one last week, so we may not count it)?
> 
> Stack usage was tested for the same path (this is backported to
> RHEL9 kernel), and saving was 2080 bytes for that. It's enough
> to get us out of trouble. But if it was a config that caused more
> recursions then it might still be a problem.

The 2K total value likely means that only patches 1 and 4 actually
contribute much into the savings.  And I agree that running at
85%+ stack utilization seems risky.  It can likely be overflowed
by just a few more recirculations in OVS pipeline or traversing
one more network namespace on a way out.  And it's possible that
some of the traffic will take such a route in your system even if
you didn't see it yet.

>> Also, most of the changes introduced here has a real chance to
>> noticeably impact performance.  Did you run any performance tests
>> with this to assess the impact?
> 
> Some numbers were posted by Aaron as you would see. 2-4% for that
> patch, but I suspect the rest should have much smaller impact.

They also seem to have a very small impact on the stack usage,
so may be not worth touching at all, since performance evaluation
for them will be necessary before they can be accepted.

> 
> Maybe patch 2 if you were doing a lot of push_nsh operations, but
> that might be less important since it's out of the recursive path.

It's also unlikely that you have NHS pipeline configured in OVS.

> 
>>
>> One last thing is that at least some of the patches seem to change
>> non-inlined non-recursive functions.  Seems unnecessary.
>>
>> Best regards, Ilya Maximets.
>>
> 
> One thing I do notice in the trace:
> 
> 
> clone_execute is an action which can be deferred AFAIKS, but it is
> not deferred until several recursions deep.
> 
> If we deferred always when possible, then might avoid such a big
> stack (at least for this config). Is it very costly to defer? Would
> it help here, or is it just going to process it right away and
> cause basically the same call chain?

It may save at most two stack frames maybe, because deferred actions
will be called just one function above in ovs_execute_actions(), and
it will not save us from packets exiting openvswitch module and
re-entering from a different port, which is a case in the provided
trace.

Also, I'd vote against deferring, because then we'll start hitting
the limit of deferred actions much faster causing packet drops, which
is already a problem for some OVN deployments.  And deferring involves
copying a lot of memory, which will hit performance once again.

Best regards, Ilya Maximets.

