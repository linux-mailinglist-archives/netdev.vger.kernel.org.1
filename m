Return-Path: <netdev+bounces-79736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7A787B160
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 20:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2483128D074
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 19:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8599F762FB;
	Wed, 13 Mar 2024 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tgdjjBVW"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1D6024B
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355357; cv=none; b=p215xObFZILMT0tjxhRFI3KbIh60pQWhLLSusnd07khHoNFWDdTfB5ggFY3e9reF7pcWW5j94IgPVlxkI+xOHOq60bi6S3l3jEL+I+3/kDk3elIkag3DTm347BOp2G1klxwDgvHrN46KUs4Fk+q9vfSq9hsOf49lKgcvSu0wrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355357; c=relaxed/simple;
	bh=h2s/HeHGv2cjNU9NqXHxp66hRlwq9Ft3Pc/wOqKN1sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcdLJ/yLR7pDw0ZZHLRAld8OHgc1ndmvzyqcLLqy0vi1GQGJ4AeQaE+KXf6rOKfLliuSmFAqBmZLy5bJ8mmlEIVZmXcAIrtxOp5h0HJ0trj8G/OD8ioBAwiDB8iUhuvcFeXxQkmI7yZOsFTwRceNF3le3+eaKFCMBq+J2vcT8xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tgdjjBVW; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <28282905-065a-4233-a0a2-53aa9b85f381@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710355352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxQDoEE3/Fbbj9TMadguG+N8bpicfYLRU/3GYTYKZFs=;
	b=tgdjjBVWjrWjp3qvXPEIbMRp5/xMrXSwJYp0emYEWOK4qEUQocB3Zdd7/jzlyvyjW1Uelz
	KBEgQfwM4NUt9cdHJu/daDs2jW2/Ic5tsnVnIAXYP+o0+XuNgdLFSqD4sLKl5A6GAp6s3z
	8sXV7P05yxegPG63+chPkFQmAoNdFZI=
Date: Wed, 13 Mar 2024 11:42:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: kernel@quicinc.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
 <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/13/24 1:52 AM, Willem de Bruijn wrote:
> Martin KaFai Lau wrote:
>> On 3/1/24 12:13 PM, Abhishek Chauhan wrote:
>>> Bridge driver today has no support to forward the userspace timestamp
>>> packets and ends up resetting the timestamp. ETF qdisc checks the
>>> packet coming from userspace and encounters to be 0 thereby dropping
>>> time sensitive packets. These changes will allow userspace timestamps
>>> packets to be forwarded from the bridge to NIC drivers.
>>>
>>> Setting the same bit (mono_delivery_time) to avoid dropping of
>>> userspace tstamp packets in the forwarding path.
>>>
>>> Existing functionality of mono_delivery_time remains unaltered here,
>>> instead just extended with userspace tstamp support for bridge
>>> forwarding path.
>>
>> The patch currently broke the bpf selftest test_tc_dtime:
>> https://github.com/kernel-patches/bpf/actions/runs/8242487344/job/22541746675
>>
>> In particular, there is a uapi field __sk_buff->tstamp_type which currently has
>> BPF_SKB_TSTAMP_DELIVERY_MONO to mean skb->tstamp has the MONO "delivery" time.
>> BPF_SKB_TSTAMP_UNSPEC means everything else (this could be a rx timestamp at
>> ingress or a delivery time set by user space).
>>
>> __sk_buff->tstamp_type depends on skb->mono_delivery_time which does not
>> necessarily mean mono after this patch. I thought about fixing it on the bpf
>> side such that reading __sk_buff->tstamp_type only returns
>> BPF_SKB_TSTAMP_DELIVERY_MONO when the skb->mono_delivery_time is set and skb->sk
>> is IPPROTO_TCP. However, it won't work because of bpf_skb_set_tstamp().
>>
>> There is a bpf helper, bpf_skb_set_tstamp(skb, tstamp,
>> BPF_SKB_TSTAMP_DELIVERY_MONO). This helper changes both the skb->tstamp and the
>> skb->mono_delivery_time. The expectation is this could change skb->tstamp in the
>> ingress skb and redirect to egress sch_fq. It could also set a mono time to
>> skb->tstamp where the udp sk->sk_clockid may not be necessary in mono and then
>> bpf_redirect to egress sch_fq. When bpf_skb_set_tstamp(skb, tstamp,
>> BPF_SKB_TSTAMP_DELIVERY_MONO) succeeds, reading __sk_buff->tstamp_type expects
>> BPF_SKB_TSTAMP_DELIVERY_MONO also.
>>
>> I ran out of idea to solve this uapi breakage.
>>
>> I am afraid it may need to go back to v1 idea and use another bit
>> (user_delivery_time) in the skb.
> 
> Is the only conflict when bpf_skb_set_tstamp is called for an skb from
> a socket with sk_clockid set (and thus SO_TXTIME called)?

Right, because skb->mono_delivery_time does not mean skb->tstamp is mono now and 
its interpretation depends on skb->sk->sk_clockid.

> Interpreting skb->tstamp as mono if skb->mono_delivery_time is set and
> skb->sk is NULL is fine. This is the ingress to egress redirect case.

skb->sk == NULL is fine. I tried something like this in 
bpf_convert_tstamp_type_read() for reading __sk_buff->tstamp_type:

__sk_buff->tstamp_type is BPF_SKB_TSTAMP_DELIVERY_MONO when:

	skb->mono_delivery_time == 1 &&
	(!skb->sk ||
	 !sk_fullsock(skb->sk) /* tcp tw or req sk */ ||
	 skb->sk->sk_protocol == IPPROTO_TCP)

Not a small bpf instruction addition to bpf_convert_tstamp_type_read() but doable.

> 
> I don't see an immediate use for this BPF function on egress where it
> would overwrite an SO_TXTIME timestamp and now skb->tstamp is mono,
> but skb->sk != NULL and skb->sk->sk_clockid != CLOCK_MONOTONIC.

The bpf prog may act as a traffic shaper that limits the bandwidth usage of all 
outgoing packets (tcp/udp/...) by setting the mono EDT in skb->tstamp before 
sending to the sch_fq.

I currently also don't have a use case for skb->sk->sk_clockid != 
CLOCK_MONOTONIC. However, it is something that bpf_skb_set_tstamp() can do now 
before queuing to sch_fq.

The container (in netns + veth) may use other sk_clockid/qdisc (e.g. sch_etf) 
setup and the non mono skb->tstamp is not cleared now during dev_forward_skb() 
between the veth pair.

> 
> Perhaps bpf_skb_set_tstamp() can just fail if another delivery time is
> already explicitly programmed?

This will change the existing bpf_skb_set_tstamp() behavior, so probably not 
acceptable.

> 
>      skb->sk &&
>      sock_flag(sk, SOCK_TXTIME) &&
>      skb->sk->sk_clockid != CLOCK_MONOTONIC

> Either that, or unset SOCK_TXTIME to make sk_clockid undefined and
> fall back on interpreting as monotonic.

Change sk->sk_flags in tc bpf prog? hmm... I am not sure this will work well also.

sock_valbool_flag(SOCK_TXTIME) should require a lock_sock() to make changes. The 
tc bpf prog cannot take the lock_sock, so bpf_skb_set_tstamp() currently only 
changes skb and does not change skb->sk.

I think changing sock_valbool_flag(SOCK_TXTIME) will also have a new user space 
visible side effect. The sendmsg for cmsg with SCM_TXTIME will start failing 
from looking at __sock_cmsg_send().

There may be a short period of disconnect between what is in sk->sk_flags and 
what is set in skb->tstamp. e.g. what if user space does setsockopt(SO_TXTIME) 
again after skb->tstamp is set by bpf. This could be considered a small glitch 
for some amount of skb(s) until the user space settled on setsockopt(SO_TXTIME).

I think all this is crying for another bit in skb to mean user_delivery_time 
(skb->tstamp depends on skb->sk->sk_clockid) while mono_delivery_time is the 
mono time either set by kernel-tcp or bpf. If we need to revert the 
mono_delivery_time reuse patch later, we will need to revert the netdev patch 
and the (to-be-made) bpf patch.


