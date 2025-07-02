Return-Path: <netdev+bounces-203326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3482AF15D4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB9F4E27A3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B85C26A0EB;
	Wed,  2 Jul 2025 12:37:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A541E485;
	Wed,  2 Jul 2025 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459832; cv=none; b=XrqpIXoEEc3zeWniERg9KUxwsZebZdz5KnJY3L+tyW4sddc/hXog12xj1y/IhIuZ1RTpa2luvnldF/2yNEMj7BbdTd+UXSdGekv0p5rSr89LtyQ+BFIBWgOkDOFPwJJjCb6sikfny8vIPBoo3oa7blSlPxRmQwVnTPn7y7LBZes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459832; c=relaxed/simple;
	bh=lWLI6HXV2cYpLzKNcWtqiZCS7ZO47V+kUQ/8IC54N0U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=StBS+vkmaX3ZhaDQ0oavzRvqVfzGpDlOxFDuogMAwvz1TVvZZoq1pYen+qxC8sZnAqL6WMhT6xvtZP8ZYlWMwM3MniuSyqJkZyVdFjCqIOA7zMCTa4VGCGH0W8iaAFDi6c7dcYnmJEZcLBF80/NauUS42OrT+o88BIQuhExIJv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ae35f36da9dso882965266b.0;
        Wed, 02 Jul 2025 05:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751459829; x=1752064629;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ct5tfT8kQ+dHa7pStRVD22g5lfyZcmkc2Q9T100R85M=;
        b=THE4evdb3ot1J3udc0UegJMIovEj1fDkFWrzxNw6tbyCHKoyHYrkzUY4YUw4f2+5GI
         DO0zuNSTz74Qh80S8NvEGd15Hb3/w6w0a1j1ExTlGLLoGP16YRlh+/XZXzRBoglJNWl+
         w4MSUEk0vaNrwz+xnmMz9WuMnghn1/cJWAAmmkg6XmKauSbbn6BfM/6yrN3ihhGoSDDJ
         bH3tDkI8HhWOqeIlXttvc1yLQz8z5YAYUL2edO9YmPKm9PCrxeCw7JFOnu0SsGDU42zY
         8kGmx6cjx0+8XQiEYwKozz1HLHwxje4KLXAE6sJfmh6LeuZWpYLUBVGnRQDGpSHkgFTf
         fABg==
X-Forwarded-Encrypted: i=1; AJvYcCVLkxFLisHtOtMVwY8p++37nevzl4gQF3nAh3ngXclDoMyeP15c8tNGYRVYeGIj+++rVBviAB7t1qgAKcs=@vger.kernel.org, AJvYcCXJh/Gz/z+R0xRpszAK459SSDnnXTX+W+6K6cYGvUk8qnoIdRkGu8jb+uZ79IW8DQNPt+iAco+h@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx60QlBo5p4EqVd2jAQ93QLDscO6lAAVM3LpXx8shYAHsaWhOK
	LEf4xB651VMbS9J5qgzCHfuOCfK5tu4hGtGmLgOKlwmKOuCOprq8dcox
X-Gm-Gg: ASbGncu19tJ9tWErv6wkSmx2QYZ5pylGA77XjsKlh9elsmMEu6QnQrxVJYLM2dBifMc
	SXYtVbP/mbuXouBg+Cj3fmqNxy72KQbhHI6PTTChtokz5S3nJ+RDu8OGws46NtrGfY47huCpRSK
	eCha28KMxB5iqv3W1dEXd6ABmKUZszHZ5vDCaj6ZMjzvAmytxn5fyZ+iwl7VgsAjmiS52yJNuyt
	2TCyjK8OPxcY/nLghXM4D7fa1GKmhivU/N0UF8I8dz28R8ystU7z9+8lBB/rONCfGk0Shotr6BP
	2Vayvr5JATwAp8tPmu2rebYgfjQvubyOVByOIiYv39rU40WG71SHjBqg+LAFk+JEdmcXmFQTtwJ
	Dz5cXkz8TEKWUbruHsV9A
X-Google-Smtp-Source: AGHT+IFIDGNG/HnK3F3+zA+aGTdRZ0u8nShGdLhDUxXu8s/pDp1pJndJnFGHRZrIrTVIeyJ4YuKnCg==
X-Received: by 2002:a17:907:1ca7:b0:ae3:63b2:dfb4 with SMTP id a640c23a62f3a-ae3c2ca212emr278451266b.27.1751459828340;
        Wed, 02 Jul 2025 05:37:08 -0700 (PDT)
Received: from [192.168.88.252] (78-80-97-102.customers.tmcz.cz. [78.80.97.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3a36c4940sm452734166b.79.2025.07.02.05.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 05:37:07 -0700 (PDT)
Message-ID: <b450a7f2-cab4-4b71-aec8-ef867403663a@ovn.org>
Date: Wed, 2 Jul 2025 14:37:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, Eelco Chaudron <echaudro@redhat.com>
Subject: Re: [PATCH net-next] net: openvswitch: allow providing upcall pid for
 the 'execute' command
To: Aaron Conole <aconole@redhat.com>
References: <20250627220219.1504221-1-i.maximets@ovn.org>
 <f7tms9mssb0.fsf@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <f7tms9mssb0.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 2:14 PM, Aaron Conole wrote:
> Ilya Maximets <i.maximets@ovn.org> writes:
> 
>> When a packet enters OVS datapath and there is no flow to handle it,
>> packet goes to userspace through a MISS upcall.  With per-CPU upcall
>> dispatch mechanism, we're using the current CPU id to select the
>> Netlink PID on which to send this packet.  This allows us to send
>> packets from the same traffic flow through the same handler.
>>
>> The handler will process the packet, install required flow into the
>> kernel and re-inject the original packet via OVS_PACKET_CMD_EXECUTE.
>>
>> While handling OVS_PACKET_CMD_EXECUTE, however, we may hit a
>> recirculation action that will pass the (likely modified) packet
>> through the flow lookup again.  And if the flow is not found, the
>> packet will be sent to userspace again through another MISS upcall.
>>
>> However, the handler thread in userspace is likely running on a
>> different CPU core, and the OVS_PACKET_CMD_EXECUTE request is handled
>> in the syscall context of that thread.  So, when the time comes to
>> send the packet through another upcall, the per-CPU dispatch will
>> choose a different Netlink PID, and this packet will end up processed
>> by a different handler thread on a different CPU.
> 
> Just wondering but why can't we choose the existing core handler when
> running the packet_cmd_execute?  For example, when looking into the
> per-cpu table we know what the current core is, can we just queue to
> that one?  I actually thought that's what the PER_CPU dispatch mode was
> supposed to do.

This is exactly how it works today and it is the problem, because our
userspace handler is running on a different CPU and so the 'current CPU'
during the packet_cmd_execute is different from the one where kernel
was processing the original upcall.

> Or is it that we want to make sure we keep the
> association between the skbuff for re-injection always?

We want the same packet to be enqueued to the same upcall socket after
each recirculation, so it gets handled by the same userspace thread.

> 
>> The process continues as long as there are new recirculations, each
>> time the packet goes to a different handler thread before it is sent
>> out of the OVS datapath to the destination port.  In real setups the
>> number of recirculations can go up to 4 or 5, sometimes more.
> 
> Is it because the userspace handler threads are being rescheduled across
> CPUs?

Yes.  Userspace handlers are not pinned to a specific core in most cases,
so they will be running on different CPUs and will float around.

> Do we still see this behavior if we pinned each handler thread to
> a specific CPU rather than letting the scheduler make the decision?

If you pin each userspace thread to a core that is specified in the
PCPU_UPCALL_PIDS for the socket that it is listening on, then the
problem will go away, as the packet_cmd_execute syscall will be executed
on the same core where the kernel received the original packet.
However, that's not possible in many cases (reserved CPUs, different
CPU affinity for IRQs and userspace applications, etc.) and not desired
as may impact performance of the system, because the kernel and userspace
will compete for the same core.

> 
>> There is always a chance to re-order packets while processing upcalls,
>> because userspace will first install the flow and then re-inject the
>> original packet.  So, there is a race window when the flow is already
>> installed and the second packet can match it and be forwarded to the
>> destination before the first packet is re-injected.  But the fact that
>> packets are going through multiple upcalls handled by different
>> userspace threads makes the reordering noticeably more likely, because
>> we not only have a race between the kernel and a userspace handler
>> (which is hard to avoid), but also between multiple userspace handlers.
>>
>> For example, let's assume that 10 packets got enqueued through a MISS
>> upcall for handler-1, it will start processing them, will install the
>> flow into the kernel and start re-injecting packets back, from where
>> they will go through another MISS to handler-2.  Handler-2 will install
>> the flow into the kernel and start re-injecting the packets, while
>> handler-1 continues to re-inject the last of the 10 packets, they will
>> hit the flow installed by handler-2 and be forwarded without going to
>> the handler-2, while handler-2 still re-injects the first of these 10
>> packets.  Given multiple recirculations and misses, these 10 packets
>> may end up completely mixed up on the output from the datapath.
>>
>> Let's allow userspace to specify on which Netlink PID the packets
>> should be upcalled while processing OVS_PACKET_CMD_EXECUTE.
>> This makes it possible to ensure that all the packets are processed
>> by the same handler thread in the userspace even with them being
>> upcalled multiple times in the process.  Packets will remain in order
>> since they will be enqueued to the same socket and re-injected in the
>> same order.  This doesn't eliminate re-ordering as stated above, since
>> we still have a race between kernel and the userspace thread, but it
>> allows to eliminate races between multiple userspace threads.
>>
>> Userspace knows the PID of the socket on which the original upcall is
>> received, so there is no need to send it up from the kernel.
>>
>> Solution requires storing the value somewhere for the duration of the
>> packet processing.  There are two potential places for this: our skb
>> extension or the per-CPU storage.  It's not clear which is better,
>> so just following currently used scheme of storing this kind of things
>> along the skb.
> 
> With this change we're almost full on the OVS sk_buff control block.
> Might be good to mention it in the commit message if you're respinning.

Are we full?  The skb->cb size is 48 bytes and we're only using 24
with this change, unless I'm missing something.

Best regards, Ilya Maximets.

