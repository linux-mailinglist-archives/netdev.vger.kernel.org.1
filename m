Return-Path: <netdev+bounces-37691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA767B6A92
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A1C94281637
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C60927704;
	Tue,  3 Oct 2023 13:32:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8A24218
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:32:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7467CA3
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 06:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696339923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dILqt0FeDR+xnLKwbQclkNETXwEe3D28PZMQGUeucQA=;
	b=EXIl55f9amV1ExBP2N8dUwm4g++Q77ADfSvd+A0UDj/zpOoLldbfiqOu1l3PMgH/ODa7X1
	+/cc21tNGqiPg4/I8K4+LSv32rug96Zk36KYaUe6MZTEPDQh+rmZQEIDLIXEEUchUiq+lH
	hPupDQa4WBZMEVv3Gu58kt70jnGKM6g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-38TiXHBNMru5pzhc6hWCdA-1; Tue, 03 Oct 2023 09:31:50 -0400
X-MC-Unique: 38TiXHBNMru5pzhc6hWCdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7B378893C0;
	Tue,  3 Oct 2023 13:31:48 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.10.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 70FC140C6EC0;
	Tue,  3 Oct 2023 13:31:48 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,  netdev@vger.kernel.org,
  dev@openvswitch.org,  Eelco Chaudron <echaudro@redhat.com>,  Simon Horman
 <horms@ovn.org>
Subject: Re: [ovs-dev] [RFC PATCH 0/7] net: openvswitch: Reduce stack usage
References: <20230927001308.749910-1-npiggin@gmail.com>
	<a018e82f-5cce-fb81-b52c-901e106c16eb@ovn.org>
	<CVV7MBT9C7JY.5PYBOXU9NUDR@wheely>
	<2c01d102-3c84-3edc-a92a-a0b9a889d70d@ovn.org>
Date: Tue, 03 Oct 2023 09:31:48 -0400
In-Reply-To: <2c01d102-3c84-3edc-a92a-a0b9a889d70d@ovn.org> (Ilya Maximets's
	message of "Mon, 2 Oct 2023 13:56:02 +0200")
Message-ID: <f7tcyxvj0hn.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ilya Maximets <i.maximets@ovn.org> writes:

> On 9/29/23 09:06, Nicholas Piggin wrote:
>> On Wed Sep 27, 2023 at 6:36 PM AEST, Ilya Maximets wrote:
>>> On 9/27/23 02:13, Nicholas Piggin wrote:
>>>> Hi,
>>>>
>>>> We've got a report of a stack overflow on ppc64le with a 16kB kernel
>>>> stack. Openvswitch is just one of many things in the stack, but it
>>>> does cause recursion and contributes to some usage.
>>>>
>>>> Here are a few patches for reducing stack overhead. I don't know the
>>>> code well so consider them just ideas. GFP_ATOMIC allocations
>>>> introduced in a couple of places might be controversial, but there
>>>> is still some savings to be had if you skip those.
>>>>
>>>> Here is one place detected where the stack reaches >14kB before
>>>> overflowing a little later. I massaged the output so it just shows
>>>> the stack frame address on the left.
>>>
>>> Hi, Nicholas.  Thanks for the patches!
>>>
>>> Though it looks like OVS is not really playing a huge role in the
>>> stack trace below.  How much of the stack does the patch set save
>>> in total?  How much patches 2-7 contribute (I posted a patch similar
>>> to the first one last week, so we may not count it)?
>> 
>> Stack usage was tested for the same path (this is backported to
>> RHEL9 kernel), and saving was 2080 bytes for that. It's enough
>> to get us out of trouble. But if it was a config that caused more
>> recursions then it might still be a problem.
>
> The 2K total value likely means that only patches 1 and 4 actually
> contribute much into the savings.  And I agree that running at
> 85%+ stack utilization seems risky.  It can likely be overflowed
> by just a few more recirculations in OVS pipeline or traversing
> one more network namespace on a way out.  And it's possible that
> some of the traffic will take such a route in your system even if
> you didn't see it yet.
>
>>> Also, most of the changes introduced here has a real chance to
>>> noticeably impact performance.  Did you run any performance tests
>>> with this to assess the impact?
>> 
>> Some numbers were posted by Aaron as you would see. 2-4% for that
>> patch, but I suspect the rest should have much smaller impact.
>
> They also seem to have a very small impact on the stack usage,
> so may be not worth touching at all, since performance evaluation
> for them will be necessary before they can be accepted.

Actually, it's also important to keep in mind that the vport_receive is
only happening once in my performance test.  I expect it gets worse when
running in the scenario (br-ex, br-int, br-tun setup).

>> 
>> Maybe patch 2 if you were doing a lot of push_nsh operations, but
>> that might be less important since it's out of the recursive path.
>
> It's also unlikely that you have NHS pipeline configured in OVS.
>
>> 
>>>
>>> One last thing is that at least some of the patches seem to change
>>> non-inlined non-recursive functions.  Seems unnecessary.
>>>
>>> Best regards, Ilya Maximets.
>>>
>> 
>> One thing I do notice in the trace:
>> 
>> 
>> clone_execute is an action which can be deferred AFAIKS, but it is
>> not deferred until several recursions deep.
>> 
>> If we deferred always when possible, then might avoid such a big
>> stack (at least for this config). Is it very costly to defer? Would
>> it help here, or is it just going to process it right away and
>> cause basically the same call chain?
>
> It may save at most two stack frames maybe, because deferred actions
> will be called just one function above in ovs_execute_actions(), and
> it will not save us from packets exiting openvswitch module and
> re-entering from a different port, which is a case in the provided
> trace.

It used to always be deferred but, IIUC we were hitting deferred actions
limit quite a bit so when the sample and clone actions were unified there
was a choice to recurse to avoid dropping packets.

> Also, I'd vote against deferring, because then we'll start hitting
> the limit of deferred actions much faster causing packet drops, which
> is already a problem for some OVN deployments.  And deferring involves
> copying a lot of memory, which will hit performance once again.
>
> Best regards, Ilya Maximets.


