Return-Path: <netdev+bounces-174602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA7EA5F759
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9448819C0560
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0975D5FB95;
	Thu, 13 Mar 2025 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6sPVp96"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333ED26773D
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875120; cv=none; b=KXTWFAQ/34OqIDWk1etcOmO0B8Gxnwr3rBrNlG54lziZL+axUtkcrsonmAjRzbwLfetDn7bXw1ODf7tuUkQfIX55zIUQTcJO6wqmz4T/jBmZu4SFkFbpy4fEoym36qfRxoH02+Co9mx3mQ+6s31L3bcYQJ8JLQinE10gMta48TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875120; c=relaxed/simple;
	bh=1+tGM9STlURNBVfNcvYkR8R2UkJtarVZNLHL1vu5Mjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nNwBwUqEDGXQ1IFs3W7hTW5GQCE2ql5AOnfaj8RskF2wGwLBtUiLnjwToAG8hC9Z3wPwNzME/bc3I5JfYO20BBJY43Vb4wHSmme+IGMVooEUCazN793jPG+39Lhou+VTgNUWnxZ/t7mwPaLlxpUTQH6PxnIBCj+ktkQmo9pHsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6sPVp96; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741875118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P7fDVX9bYZe4FjU2pZWpobi2yyE0MOuDXNhddbnjJeE=;
	b=O6sPVp96Ph82cXz/pCxFxRSdRSqo+sBR7nhHS81RytukyBxCybp++RpwGZP/DIDbAcNooG
	3Bl502AWVEGHpp3eDlWGW98okRBrBRl6J7gmYLeaNezT7zc2uOZ+7d6MHlF0PnatJu0r3+
	3a7PzSyBdIbdkmenNvVuz7lQImSUnTA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-YBB-PzRfN0a42674CCcUdA-1; Thu,
 13 Mar 2025 10:11:52 -0400
X-MC-Unique: YBB-PzRfN0a42674CCcUdA-1
X-Mimecast-MFC-AGG-ID: YBB-PzRfN0a42674CCcUdA_1741875111
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E60D19560BB;
	Thu, 13 Mar 2025 14:11:51 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.90.92])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 999F019373D7;
	Thu, 13 Mar 2025 14:11:47 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
  netdev@vger.kernel.org,  linux-rt-devel@lists.linux.dev,
  dev@openvswitch.org,  Eric Dumazet <edumazet@google.com>,  Simon Horman
 <horms@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,  Thomas Gleixner
 <tglx@linutronix.de>,  Paolo Abeni <pabeni@redhat.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eelco Chaudron <echaudro@redhat.com>
Subject: Re: [ovs-dev] [PATCH net-next 11/18] openvswitch: Use nested-BH
 locking for ovs_actions.
In-Reply-To: <1d72e5df-921b-4027-bf9c-ca374c3a09d1@ovn.org> (Ilya Maximets's
	message of "Thu, 13 Mar 2025 14:23:16 +0100")
References: <20250309144653.825351-1-bigeasy@linutronix.de>
	<20250309144653.825351-12-bigeasy@linutronix.de>
	<9a1ededa-8b1f-4118-94b4-d69df766c61e@ovn.org>
	<20250310144459.wjPdPtUo@linutronix.de>
	<fd4c8167-0c2d-4f5f-bf70-1efcdf3de2fb@ovn.org>
	<20250313115018.7xe77nJ-@linutronix.de>
	<1d72e5df-921b-4027-bf9c-ca374c3a09d1@ovn.org>
Date: Thu, 13 Mar 2025 10:11:45 -0400
Message-ID: <f7tzfhpxboe.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Ilya Maximets <i.maximets@ovn.org> writes:

> On 3/13/25 12:50, Sebastian Andrzej Siewior wrote:
>> On 2025-03-10 17:56:09 [+0100], Ilya Maximets wrote:
>>>>>> +		local_lock_nested_bh(&ovs_actions.bh_lock);
>>>>>
>>>>> Wouldn't this cause a warning when we're in a syscall/process context?
>>>>
>>>> My understanding is that is only invoked in softirq context. Did I
>>>> misunderstood it?
>>>
>>> It can be called from the syscall/process context while processing
>>> OVS_PACKET_CMD_EXECUTE request.
>>>
>>>> Otherwise that this_cpu_ptr() above should complain
>>>> that preemption is not disabled and if preemption is indeed not disabled
>>>> how do you ensure that you don't get preempted after the
>>>> __this_cpu_inc_return() in several tasks (at the same time) leading to
>>>> exceeding the OVS_RECURSION_LIMIT?
>>>
>>> We disable BH in this case, so it should be safe (on non-RT).  See the
>>> ovs_packet_cmd_execute() for more details.
>> 
>> Yes, exactly. So if BH is disabled then local_lock_nested_bh() can
>> safely acquire a per-CPU spinlock on PREEMPT_RT here. This basically
>> mimics the local_bh_disable() behaviour in terms of exclusive data
>> structures on a smaller scope.
>
> OK.  I missed that is_softirq() returns true when BH is disabled manually.
>
>> 
>>>>>> +		ovs_act->owner = current;
>>>>>> +	}
>>>>>> +
>>>>>>  	level = __this_cpu_inc_return(ovs_actions.exec_level);
>>>>>>  	if (unlikely(level > OVS_RECURSION_LIMIT)) {
>>>>>>  		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
>>>>>> @@ -1710,5 +1718,10 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
>>>>>>  
>>>>>>  out:
>>>>>>  	__this_cpu_dec(ovs_actions.exec_level);
>>>>>> +
>>>>>> +	if (level == 1) {
>>>>>> +		ovs_act->owner = NULL;
>>>>>> +		local_unlock_nested_bh(&ovs_actions.bh_lock);
>>>>>> +	}
>>>>>
>>>>> Seems dangerous to lock every time the owner changes but unlock only
>>>>> once on level 1.  Even if this works fine, it seems unnecessarily
>>>>> complicated.  Maybe it's better to just lock once before calling
>>>>> ovs_execute_actions() instead?
>>>>
>>>> My understanding is this can be invoked recursively. That means on first
>>>> invocation owner == NULL and then you acquire the lock at which point
>>>> exec_level goes 0->1. On the recursive invocation owner == current and
>>>> you skip the lock but exec_level goes 1 -> 2.
>>>> On your return path once level becomes 1, then it means that dec made it
>>>> go 1 -> 0, you unlock the lock.
>>>
>>> My point is: why locking here with some extra non-obvious logic of owner
>>> tracking if we can lock (unconditionally?) in ovs_packet_cmd_execute() and
>>> ovs_dp_process_packet() instead?  We already disable BH in one of those
>>> and take appropriate RCU locks in both.  So, feels like a better place
>>> for the extra locking if necessary.  We will also not need to move around
>>> any code in actions.c if the code there is guaranteed to be safe by holding
>>> locks outside of it.
>> 
>> I think I was considering it but dropped it because it looks like one
>> can call the other.
>> ovs_packet_cmd_execute() is an unique entry to ovs_execute_actions().
>> This could the lock unconditionally.
>> Then we have ovs_dp_process_packet() as the second entry point towards
>> ovs_execute_actions() and is the tricky one. One originates from
>> netdev_frame_hook() which the "normal" packet receiving.
>> Then within ovs_execute_actions() there is ovs_vport_send() which could
>> use internal_dev_recv() for forwarding. This one throws the packet into
>> the networking stack so it could come back via netdev_frame_hook().
>> Then there is this internal forwarding via internal_dev_xmit() which
>> also ends up in ovs_execute_actions(). Here I don't know if this can
>> originate from within the recursion.

Just a note that it still needs to go through `ovs_dp_process_packet()`
before it will enter the `ovs_execute_actions()` call by way of the
`ovs_vport_receive()` call.  So keeping the locking in datapath.c should
not be a complex task.

> It's true that ovs_packet_cmd_execute() can not be re-intered, while
> ovs_dp_process_packet() can be re-entered if the packet leaves OVS and
> then comes back from another port.  It's still better to handle all the
> locking within datapath.c and not lock for RT in actions.c and for non-RT
> in datapath.c.

+1

>> 
>> After looking at this and seeing the internal_dev_recv() I decided to
>> move it to within ovs_execute_actions() where the recursion check itself
>> is.
>> 
>>>> The locking part happens only on PREEMPT_RT because !PREEMPT_RT has
>>>> softirqs disabled which guarantee that there will be no preemption.
>>>>
>>>> tools/testing/selftests/net/openvswitch should cover this?
>>>
>>> It's not a comprehensive test suite, it covers some cases, but it
>>> doesn't test anything related to preemptions specifically.

Yes, this would be good to enhance, and the plan is to improve it as we
can.  If during the course of this work you identify a nice test case,
please do feel empowered to add it.

>> From looking at the traces, everything originates from
>> netdev_frame_hook() and there is sometimes one recursion from within
>> ovs_execute_actions(). I haven't seen anything else.
>> 
>>>>> Also, the name of the struct ovs_action doesn't make a lot of sense,
>>>>> I'd suggest to call it pcpu_storage or something like that instead.
>>>>> I.e. have a more generic name as the fields inside are not directly
>>>>> related to each other.
>>>>
>>>> Understood. ovs_pcpu_storage maybe?
>>>
>>> It's OK, I guess, but see also a point about locking inside datapath.c
>>> instead and probably not needing to change anything in actions.c.
>> 
>> If you say that adding a lock to ovs_dp_process_packet() and another to
>> ovs_packet_cmd_execute() then I can certainly update. However based on
>> what I wrote above, I am not sure.
>
> I think, it's better if we keep all the locks in datapath.c and let
> actions.c assume that all the operations are always safe as it was
> originally intended.

Agreed - reading through actions code can be complex enough without need
to remember to do recursions checks there.

> Cc: Aaron and Eelco, in case they have some thoughts on this as well.

Thanks Ilya - I think you covered the major points.

> Best regards, Ilya Maximets.


