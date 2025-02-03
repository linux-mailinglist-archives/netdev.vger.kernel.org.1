Return-Path: <netdev+bounces-162019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570DFA25586
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D397A12D3
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 09:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D733D1FECDD;
	Mon,  3 Feb 2025 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTnsfBxe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467A288B1
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573930; cv=none; b=rlNIdPhmZiS1PAviHC645/fCR2hLTAyf6dIyJqiuEUYaUR4ylUUyIwZ3KFCjGoZW+eGuBGJUDYKN+w0/cj9nYtmANCnaIbLlh13QbVJaL2JopzWPRSr6pGLgNWdiqRE9xt+bPBVncSX0VpnG4CQVBYGIqjhioYBod7TZ17uaQk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573930; c=relaxed/simple;
	bh=r8prXXVyLvWuKjfpnlTmVQLIYqZReVfW8PicL2ih+qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxpbggvqQGTxJF+x/Gy5/isvTq46JItxVuZXp/FGQQjNUKlhrd+viAzLBGptnXCK6WASIuyUTy/mtZ+CftbZ15QN+eUBnv1dfpkXTTFGIHUVEm2UN62SrUVIwoEdPyILymK/hrnoOurzz++12E4dXQv11xmpkZ3iEnLK5TBtuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTnsfBxe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738573927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66ULsrdTeYPPhKIF1yc6wCRd85YZ13nxZXU5NntNsHo=;
	b=KTnsfBxeju3A5BnVpmVQK+yyoUJbiIqn32qLig+LLMAkZDVYL0PujN20WD7nQ4ntlxIjxO
	41wvsJPiYsleY3aYbgkgXWeq+LVEd98KGBQDiT6mdQG/H8/Q/St/nE6ArujhRU/+D1sblR
	cHgkjxpWTPTPzHUyQ2rmmn8EUhTwyK0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-DIVI4sJCNf6ypO9rKmK-kg-1; Mon, 03 Feb 2025 04:12:06 -0500
X-MC-Unique: DIVI4sJCNf6ypO9rKmK-kg-1
X-Mimecast-MFC-AGG-ID: DIVI4sJCNf6ypO9rKmK-kg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38c5dcb33a5so2575984f8f.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 01:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738573925; x=1739178725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66ULsrdTeYPPhKIF1yc6wCRd85YZ13nxZXU5NntNsHo=;
        b=ShlxEDJbzcJ7Q1tbb8k2rq9nN2ykYSWNuXFrpJAYLJ5H2/SP7K1swfl8pdwm9EqLtd
         OOpDD+4dINdMzSMI/ssvoYOdolQ+k4k91LIJpp0ta7S1il+Gr5Ma3GV8PpUC0efcHdt/
         wB6UyYVaoxPcA4RMMu2PAxTek7Cb6gA6Ku/WzBJO9l0+pwEoiymTSQYv76DFx/H+6M4p
         aTvL9luIcCesrb2ckA/dGxu7V1RSdqBgbHh0j2oUvAMePxFuGcb4itVZ4vPjLs1dmIIa
         AS4gv1xF8MxAjvn0iXOP7x1lfqTwVpq42G+SZp/Rnne1CYP9zUJrV8k+d8W9bWh4/MlZ
         63hA==
X-Gm-Message-State: AOJu0YyhdV770Rp9Cg72uYeE1AGi3h6YtojRjAZqIa4vUanVKHkX4syp
	ZH2RnF6qtYQ6dywvzALtdZlzZsf5FB4cJ9QQoFz6VwUvipuVpLxK3XG12fAJLm3aH1Kzpy5ZyBX
	cdbffU0/xkLkt55eWAITe+Xl90x3UNvNzxsOO95EcKpNw0ac+qznd6w==
X-Gm-Gg: ASbGnctN96GrV+X6uXMJmzyY4yzFQ19nJmVky+VbiJdXXIECEtB2QTxlgOktRMkynsL
	IqaXC1BpKS0o5inLmqIlPSLuDeyRNCMdPm2ChHZGDIzhyfm8v58tRsu0mmCf1BU+DDvBMRqtNiQ
	CoFcTXK6hAGPJ1gzBRgkupusQabjYIJ0RCpku7tymNqnZkCwOcsMY1QDuUmNhLJ58hpGb2q8Yd7
	Wo9Pdv4ILrXwj739HVDmD4O39k+22IFA2DOYO/uoen5znOzzyW5wgMiecF6aZDg06rSQsHoAcBm
	Cyp6dv8OKErPZYvN6cmHSX1MqZ8ip2Swva0=
X-Received: by 2002:a5d:59a3:0:b0:38c:5d42:152a with SMTP id ffacd0b85a97d-38c5d42185bmr13955130f8f.35.1738573924856;
        Mon, 03 Feb 2025 01:12:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgkXrnQ2F+4Qww7aL8GPV8Ak+0gbX9gv6kYKrI6ZSl5y4J3DawRw58Qu2DO3jqSWPvQUe50w==
X-Received: by 2002:a5d:59a3:0:b0:38c:5d42:152a with SMTP id ffacd0b85a97d-38c5d42185bmr13955061f8f.35.1738573924327;
        Mon, 03 Feb 2025 01:12:04 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c11fadbsm11959776f8f.44.2025.02.03.01.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 01:12:03 -0800 (PST)
Message-ID: <7b05dc31-e00f-497e-945f-2964ff00969f@redhat.com>
Date: Mon, 3 Feb 2025 10:12:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Netdev <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-9-ouster@cs.stanford.edu>
 <530c3a8c-fa5b-4fbe-9200-6e62353ebeaf@redhat.com>
 <CAGXJAmya3xU69ghKO10SZz4sh48CyBgBsF7AaV1OOCRyVPr0Nw@mail.gmail.com>
 <991b5ad9-57cf-4e1d-8e01-9d0639fa4e49@redhat.com>
 <CAGXJAmxfkmKg4NqHd9eU94Y2hCd4F9WJ2sOyCU1pPnppVhju=A@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmxfkmKg4NqHd9eU94Y2hCd4F9WJ2sOyCU1pPnppVhju=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/31/25 11:48 PM, John Ousterhout wrote:
> On Thu, Jan 30, 2025 at 1:39 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 1/30/25 1:41 AM, John Ousterhout wrote:
>>> On Fri, Jan 24, 2025 at 12:31 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>
>>>> OoO will cause additional allocation? this feels like DoS prone.
>>>>
>>>>> +             }
>>>>> +             rpc->msgin.recv_end = end;
>>>>> +             goto keep;
>>>>> +     }
>>>>> +
>>>>> +     /* Must now check to see if the packet fills in part or all of
>>>>> +      * an existing gap.
>>>>> +      */
>>>>> +     list_for_each_entry_safe(gap, dummy, &rpc->msgin.gaps, links) {
>>>>
>>>> Linear search for OoO has proven to be subject to serious dos issue. You
>>>> should instead use a (rb-)tree to handle OoO packets.
>>>
>>> I have been assuming that DoS won't be a major issue for Homa because
>>> it's intended for use only in datacenters (if there are antagonistic
>>> parties, they will be isolated from each other by networking
>>> hardware). Is this a bad assumption?
>>
>> I think assuming that the peer will always behave is dangerous. The peer
>> could be buggy or compromised, transient network condition may arise.
>> Even un-malicious users tend to do the most crazy and unexpected things
>> given enough time.
>>
>> Also the disclaimer "please don't use this in on an internet facing
>> host" sounds quite bad for a networking protocol ;)
> 
> I don't see why this disclaimer would be needed: as long as the Homa
> hosts are inside the firewall, the firewall will prevent any external
> Homa packets from reaching them. And, if your host is compromised, DoS
> is the least of your worries.
> 
> It seems to me that this is mostly about helping people debug. I agree
> that that could be useful. However, it's hard for me to imagine this
> particular situation (lots of gaps in the packet stream) happening by
> accident. Applications won't be generating Homa packets themselves,
> they will be using Homa, and Homa won't generate lots of gaps. There
> are other kinds of bad application behavior that are much more likely
> to occur, such as an app that gets into an infinite loop sending
> requests without ever receiving responses.
> 
> And, an rb-tree will add complexity and slow down the common case
> (trees have better O(...) behavior than lists but worse constant
> factors).

My point is that a service (and the host running it) is supposed to
survive any kind of unexpected conditions, as they will happen for sure
in any internet-facing host, and will likely happen also in the most
controlled environment due to bugs or unexpected events somewhere(else).

>>>> Also it looks like there is no memory accounting at all, and SO_RCVBUF
>>>> setting are just ignored.
>>>
>>> Homa doesn't yet have comprehensive memory accounting, but there is a
>>> limit on buffer space for incoming messages. Instead of SO_RCVBUF,
>>> applications control the amount of receive buffer space by controlling
>>> the size of the buffer pool they provide to Homa with the
>>> SO_HOMA_RCVBUF socket option.
>>
>> Ignoring SO_RCVBUF (and net.core.rmem_* sysctls) is both unexpected and
>> dangerous (a single application may consume unbounded amount of system
>> memory). Also what about the TX side? I don't see any limit at all there.
> 
> An application cannot consume unbounded system memory on the RX side
> (in fact it consumes almost none). When packets arrive, their data is
> immediately transferred to a buffer region in user memory provided by
> the application (using the facilities in homa_pool.c). Skb's are
> occupied only long enough to make this transfer, and it happens even
> if there is no pending recv* kernel call. The size of the buffer
> region is limited by the application, and the application must provide
> a region via SO_HOMA_RCVBUF. 

I don't see where/how the SO_HOMA_RCVBUF max value is somehow bounded?!?
It looks like the user-space could pick an arbitrary large value for it.

> Given this, there's no need for SO_RCVBUF
> (and I don't see why a different limit would be specified via
> SO_RCVBUF than the one already provided via SO_HOMA_RCVBUF). 
> I agree that this is different from TCP, but Homa is different from TCP in
> lots of ways.
> 
> There is currently no accounting or control on the TX side. I agree
> that this needs to be implemented at some point, but if possible I'd
> prefer to defer this until more of Homa has been upstreamed. For
> example, this current patch doesn't include any sysctl support, which
> would be needed as part of accounting/control (the support is part of
> the GitHub repo, it's just not in this patch series).

SO_RCVBUF and SO_SNDBUF are expected to apply to any kind of socket,
see man 7 sockets. Exceptions should be at least documented, but we need
some way to limit memory usage in both directions.

Fine tuning controls and sysctls could land later, but the basic
constraints should IMHO be there from the beginning.

>>>>> +/**
>>>>> + * homa_dispatch_pkts() - Top-level function that processes a batch of packets,
>>>>> + * all related to the same RPC.
>>>>> + * @skb:       First packet in the batch, linked through skb->next.
>>>>> + * @homa:      Overall information about the Homa transport.
>>>>> + */
>>>>> +void homa_dispatch_pkts(struct sk_buff *skb, struct homa *homa)
>>>>
>>>> I see I haven't mentioned the following so far, but you should move the
>>>> struct homa to a pernet subsystem.
>>>
>>> Sorry for my ignorance, but I'm not familiar with the concept of "a
>>> pernet subsystem". What's the best way for me to learn more about
>>> this?
>>
>> Have a look at register_pernet_subsys(), struct pernet_operations and
>> some basic usage example, i.e. in net/8021q/vlan.c.
>>
>> register_pernet_subsys() allow registering/allocating a per network
>> namespace structure of specified size (pernet_operations.size) that that
>> subsystem can use according to its own need fetching it from the netns
>> via the `id` obtained at registration time.
> 
> I will take a look.
> 
>>>>> +             /* Find and lock the RPC if we haven't already done so. */
>>>>> +             if (!rpc) {
>>>>> +                     if (!homa_is_client(id)) {
>>>>> +                             /* We are the server for this RPC. */
>>>>> +                             if (h->common.type == DATA) {
>>>>> +                                     int created;
>>>>> +
>>>>> +                                     /* Create a new RPC if one doesn't
>>>>> +                                      * already exist.
>>>>> +                                      */
>>>>> +                                     rpc = homa_rpc_new_server(hsk, &saddr,
>>>>> +                                                               h, &created);
>>>>
>>>> It looks like a buggy or malicious client could force server RPC
>>>> allocation to any _client_ ?!?
>>>
>>> I'm not sure what you mean by "force server RPC allocation to any
>>> _client_"; can you give a bit more detail?
>>
>> AFAICS the home protocol uses only the `id` provided by the sender to
>> discriminate the incoming packet as a client requests and thus
>> allocating resources (RPC new server) on the receiver.
>>
>> Suppose an host creates a client socket, and a port is assigned to it.
>>
>> A malicious or buggy peer starts sending an (unlimited amount of)
>> uncompleted homa RPC request to it.
>>
>> AFAICS the host A will allocate server RPCs in response to such incoming
>> packets, which is unexpected to me.
> 
> Now I see what you're getting at. Homa sockets are symmetric: any
> socket can be used for both the client and server sides of RPCs.  Thus
> it's possible to send requests even to sockets that haven't been
> "bound". I think of this as a feature, not a bug (it can potentially
> reduce the need to allocate "known" port numbers). At the same time, I
> see your point that some applications might not expect to receive
> requests. Would you like a mechanism to disable this? For example,
> sockets could be configured by default to reject incoming requests;
> invoking the "bind" system call would enable incoming requests (I
> would also add a setsockopt mechanism for enabling requests even on
> "unbound" sockets).

I think that an explicit setsockopt() to enable incoming requests should
be fine.

>> Additionally AFAICS each RPC is identified only by dport/id and both
>> port and id allocation is sequential it looks like it's quite easy to
>> spoof/inject data in a different RPC - even "by mistake". I guess this
>> is a protocol limit.
> 
> On the server side an RPC is identified by <client address, dport,
> id>, but on the client side only by <dport, id> (the sender address
> isn't needed to lookup the correct RPC). However, it would be easy to
> check incoming packets to make sure that the sender address matches
> the sender in the RPC. I will do that.

I somewhat missed the src address matching for the server side. I think
it would be good if the lookup could be symmetric for both the client
and the server.

>>> The new methods also provide a consistent and simple solution to
>>> several other problems that had been solved in an ad hoc way.
>>>
>>> It would be even better if a function never had to release a lock
>>> internally, but so far I haven't figured out how to do that. If you
>>> have ideas I'd like to hear them.
>>
>> In some cases it could be possible to move the unlock in the caller,
>> eventually breaking the relevant function in smaller helpers.
>>
>>>>> +
>>>>> +     if (id != 0) {
>>>>> +             if ((atomic_read(&rpc->flags) & RPC_PKTS_READY) || rpc->error)
>>>>> +                     goto claim_rpc;
>>>>> +             rpc->interest = interest;
>>>>> +             interest->reg_rpc = rpc;
>>>>> +             homa_rpc_unlock(rpc);
>>>>
>>>> With the current schema you should release the hsh socket lock before
>>>> releasing the rpc one.
>>>
>>> Normally I would agree, but that won't work here: the RPC is no longer
>>> of interest, so it needs to be unlocked,
>>
>> Is that unlock strictly necessary (would cause a deadlock if omitted) or
>> just an optimization?
> 
> That RPC definitely needs to be unlocked (another RPC gets locked
> later in the function). 

Side note: if you use per RPC lock, and you know that the later one is a
_different_ RPC, there will be no need for unlocking (and LOCKDEP will
be happy with a "_nested" annotation).

> It would be possible to defer its unlocking
> until after the socket is unlocked, but that would be awkward: that
> RPC is never used again, and there would need to be an extra variable
> to remember the RPC for later unlocking; the later unlocking would
> drop in "out of the blue" (readers would wonder "why is this RPC being
> unlocked here?"). And it would keep an RPC locked unnecessarily.

I guess it's a matter of taste and personal preferences. IMHO
inconsistent unlock chain is harder to follow. I also think a comment is
due in either cases.

Cheers,

Paolo


