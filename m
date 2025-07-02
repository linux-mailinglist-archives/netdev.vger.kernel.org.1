Return-Path: <netdev+bounces-203328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F707AF1606
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1464E631B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10E0272816;
	Wed,  2 Jul 2025 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBqEvrAs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA62727E2
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751460403; cv=none; b=MOFhRDzeaR5FvZ6fNpyo7rTh+ni/oN7keieNwKyWW0uYsR5nCsggGxM5x0Ph1crXHNiL/xsV1ZxZbbGFpfkYvhIqAbwom3BkpjugOEzDn2NfQyDWq4piICeYzY2Y2AJG1kqz2UU+iTP1iE+hgCRr84AtxZYwwwujEey1ezh1wqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751460403; c=relaxed/simple;
	bh=Vnm8i+8d7xQD+aN4CxboT/B1vBfsPCcMdkRsSsbXzIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I1vF6Fqlc+R4Bbrop3cl/0bduz+rLtw7pjOHEb4vQ4B8QGhIp+5GO9JFOkC9/vcj2hImOkxsPM4R5txUGnc5hFkeQnaynzK79x1Rjq9Z1btqdXQTIj3N3c/eYyjGaF/xl9/YumDl8bXk5aEcRC2gJxjwKhngACdUipe474tlQmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBqEvrAs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751460401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dayIu0cR4lV3Z0pfruMI7uRbjrFkXUE4pSNwlQFvgnc=;
	b=WBqEvrAsd/j6aBikxdeThCPr3LEObx+hFlQHzJCEZ3iVwr7DxkP0m+72pVws7+/FNTcVxH
	dDidhBDDuhX3yBIrzW7nAByihqhQlZml2WF3Mo4B1+SSoPpZ0p/g5+yx0WQACDsKoMxyVK
	9lG3afLqoCH5g9oJCr8Yvyr2XbdjnPs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-iLhXe5m7PdeBi0Rg7dU-cA-1; Wed,
 02 Jul 2025 08:46:38 -0400
X-MC-Unique: iLhXe5m7PdeBi0Rg7dU-cA-1
X-Mimecast-MFC-AGG-ID: iLhXe5m7PdeBi0Rg7dU-cA_1751460396
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5127B193F048;
	Wed,  2 Jul 2025 12:46:36 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.59])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA33B180045B;
	Wed,  2 Jul 2025 12:46:33 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  dev@openvswitch.org,  linux-kernel@vger.kernel.org,  Eelco Chaudron
 <echaudro@redhat.com>
Subject: Re: [PATCH net-next] net: openvswitch: allow providing upcall pid
 for the 'execute' command
In-Reply-To: <b450a7f2-cab4-4b71-aec8-ef867403663a@ovn.org> (Ilya Maximets's
	message of "Wed, 2 Jul 2025 14:37:05 +0200")
References: <20250627220219.1504221-1-i.maximets@ovn.org>
	<f7tms9mssb0.fsf@redhat.com>
	<b450a7f2-cab4-4b71-aec8-ef867403663a@ovn.org>
Date: Wed, 02 Jul 2025 08:46:26 -0400
Message-ID: <f7tcyaisqu5.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Ilya Maximets <i.maximets@ovn.org> writes:

> On 7/2/25 2:14 PM, Aaron Conole wrote:
>> Ilya Maximets <i.maximets@ovn.org> writes:
>> 
>>> When a packet enters OVS datapath and there is no flow to handle it,
>>> packet goes to userspace through a MISS upcall.  With per-CPU upcall
>>> dispatch mechanism, we're using the current CPU id to select the
>>> Netlink PID on which to send this packet.  This allows us to send
>>> packets from the same traffic flow through the same handler.
>>>
>>> The handler will process the packet, install required flow into the
>>> kernel and re-inject the original packet via OVS_PACKET_CMD_EXECUTE.
>>>
>>> While handling OVS_PACKET_CMD_EXECUTE, however, we may hit a
>>> recirculation action that will pass the (likely modified) packet
>>> through the flow lookup again.  And if the flow is not found, the
>>> packet will be sent to userspace again through another MISS upcall.
>>>
>>> However, the handler thread in userspace is likely running on a
>>> different CPU core, and the OVS_PACKET_CMD_EXECUTE request is handled
>>> in the syscall context of that thread.  So, when the time comes to
>>> send the packet through another upcall, the per-CPU dispatch will
>>> choose a different Netlink PID, and this packet will end up processed
>>> by a different handler thread on a different CPU.
>> 
>> Just wondering but why can't we choose the existing core handler when
>> running the packet_cmd_execute?  For example, when looking into the
>> per-cpu table we know what the current core is, can we just queue to
>> that one?  I actually thought that's what the PER_CPU dispatch mode was
>> supposed to do.
>
> This is exactly how it works today and it is the problem, because our
> userspace handler is running on a different CPU and so the 'current CPU'
> during the packet_cmd_execute is different from the one where kernel
> was processing the original upcall.
>
>> Or is it that we want to make sure we keep the
>> association between the skbuff for re-injection always?
>
> We want the same packet to be enqueued to the same upcall socket after
> each recirculation, so it gets handled by the same userspace thread.
>
>> 
>>> The process continues as long as there are new recirculations, each
>>> time the packet goes to a different handler thread before it is sent
>>> out of the OVS datapath to the destination port.  In real setups the
>>> number of recirculations can go up to 4 or 5, sometimes more.
>> 
>> Is it because the userspace handler threads are being rescheduled across
>> CPUs?
>
> Yes.  Userspace handlers are not pinned to a specific core in most cases,
> so they will be running on different CPUs and will float around.
>
>> Do we still see this behavior if we pinned each handler thread to
>> a specific CPU rather than letting the scheduler make the decision?
>
> If you pin each userspace thread to a core that is specified in the
> PCPU_UPCALL_PIDS for the socket that it is listening on, then the
> problem will go away, as the packet_cmd_execute syscall will be executed
> on the same core where the kernel received the original packet.
> However, that's not possible in many cases (reserved CPUs, different
> CPU affinity for IRQs and userspace applications, etc.) and not desired
> as may impact performance of the system, because the kernel and userspace
> will compete for the same core.

Just wanted to make sure I was understanding the problem.  Okay, this
makes sense.

>> 
>>> There is always a chance to re-order packets while processing upcalls,
>>> because userspace will first install the flow and then re-inject the
>>> original packet.  So, there is a race window when the flow is already
>>> installed and the second packet can match it and be forwarded to the
>>> destination before the first packet is re-injected.  But the fact that
>>> packets are going through multiple upcalls handled by different
>>> userspace threads makes the reordering noticeably more likely, because
>>> we not only have a race between the kernel and a userspace handler
>>> (which is hard to avoid), but also between multiple userspace handlers.
>>>
>>> For example, let's assume that 10 packets got enqueued through a MISS
>>> upcall for handler-1, it will start processing them, will install the
>>> flow into the kernel and start re-injecting packets back, from where
>>> they will go through another MISS to handler-2.  Handler-2 will install
>>> the flow into the kernel and start re-injecting the packets, while
>>> handler-1 continues to re-inject the last of the 10 packets, they will
>>> hit the flow installed by handler-2 and be forwarded without going to
>>> the handler-2, while handler-2 still re-injects the first of these 10
>>> packets.  Given multiple recirculations and misses, these 10 packets
>>> may end up completely mixed up on the output from the datapath.
>>>
>>> Let's allow userspace to specify on which Netlink PID the packets
>>> should be upcalled while processing OVS_PACKET_CMD_EXECUTE.
>>> This makes it possible to ensure that all the packets are processed
>>> by the same handler thread in the userspace even with them being
>>> upcalled multiple times in the process.  Packets will remain in order
>>> since they will be enqueued to the same socket and re-injected in the
>>> same order.  This doesn't eliminate re-ordering as stated above, since
>>> we still have a race between kernel and the userspace thread, but it
>>> allows to eliminate races between multiple userspace threads.
>>>
>>> Userspace knows the PID of the socket on which the original upcall is
>>> received, so there is no need to send it up from the kernel.
>>>
>>> Solution requires storing the value somewhere for the duration of the
>>> packet processing.  There are two potential places for this: our skb
>>> extension or the per-CPU storage.  It's not clear which is better,
>>> so just following currently used scheme of storing this kind of things
>>> along the skb.
>> 
>> With this change we're almost full on the OVS sk_buff control block.
>> Might be good to mention it in the commit message if you're respinning.
>
> Are we full?  The skb->cb size is 48 bytes and we're only using 24
> with this change, unless I'm missing something.

Hrrm... I guess I miscounted.  Yes I agree, with this change we're at 24
bytes in-use on 64-bit platform.  Okay no worries.

> Best regards, Ilya Maximets.


