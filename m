Return-Path: <netdev+bounces-297438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 79XBHQ3zKGpiOAMAu9opvQ
	(envelope-from <netdev+bounces-297438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:15:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D9A665E69
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:15:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ehUx2dJl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297438-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297438-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A030C30709C3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013BD371878;
	Wed, 10 Jun 2026 05:13:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C526370D6E
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 05:13:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068432; cv=none; b=PSJ2kXmAKkFnndv2Hq3ykWnyos+reTP6c+2cfssK8OjlffOKf66pyNlldhTtECYntLXrFDvBVztSW1Mmj8ZKwywSte+gAFN1yVMLsraxp1OGEh9UNQGTuOY1MK97o3ZWGQlaMZ1LbeA4iHHRpSd372MpfBMAgis4Z4IY8r/ES2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068432; c=relaxed/simple;
	bh=Jw44zc0riFpioKES9tU7Vrfr4BhP+D4LBHxN6e1YyZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gepVXdeQto6I5V3o0+/v/YhPPQRFAb0FOzrXXHMXDz0SwUy+aM0LU4F0qJo33rzdzvEqORXguxon+HC1o/z3NJ4lpPb7/SfE/HXoslMdJRf+uf1Hu8yKgyFeVgI7CgfOazj+n7CtIXlrJaK9sYxXX6wYfERI9rwqQL0864WYm8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ehUx2dJl; arc=none smtp.client-ip=95.215.58.174
Message-ID: <b35a2395-0e15-4390-ba7a-b48748e7e3f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781068419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAopxE9EczGUg3PSk7OujdIhtgCxg1HVADKqStzgMSs=;
	b=ehUx2dJl+Ti4rMEszXvyVtRZEkTLbQmKkfKl36MgKtj/ym3Fx467HOftJa+95Axc/hYFES
	t9Gl1XeKVVmZ9gEnf2GWwA13SX6apaZed7qWD1tfsJxR03wwM05hmV81wstCJtC5xycPOG
	GbHUWw5jNe5ZBjkC7GBI3g50NaMnR20=
Date: Wed, 10 Jun 2026 13:13:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Unshare cloned skb before devmap egress XDP program
To: sun jian <sun.jian.kdev@gmail.com>,
 Menglong Dong <menglong.dong@linux.dev>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 shuah@kernel.org, liuhangbin@gmail.com
References: <20260609100214.337538-1-sun.jian.kdev@gmail.com>
 <L0cwr1-KRSKR7-dJdjDmJA@linux.dev>
 <DJ4XIOT2RVMT.28I5LA2UOZVUI@etsalapatis.com>
 <AgOg1pJHQN-gpKhYUz3SMw@linux.dev>
 <CABFUUZH9F+tiitstSBy2-M=WC84jg28CVMXU+Lu-va6jm71fDw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CABFUUZH9F+tiitstSBy2-M=WC84jg28CVMXU+Lu-va6jm71fDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:liuhangbin@gmail.com,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297438-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[etsalapatis.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,etsalapatis.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5D9A665E69


On 6/10/26 9:58 AM, sun jian wrote:
> On Wed, Jun 10, 2026 at 9:21 AM Menglong Dong <menglong.dong@linux.dev> wrote:
>> On 2026/6/10 08:06 Emil Tsalapatis <emil@etsalapatis.com> write:
>>> On Tue Jun 9, 2026 at 7:06 AM EDT, Menglong Dong wrote:
>>>> On 2026/6/9 18:02 Sun Jian <sun.jian.kdev@gmail.com> write:
[...]
>>>> Hi, Jian.
>>>>
>>>> This sounds like a good idea in this case. When I have a look at bpf_clone_redirect(),
>>>> I found that it use skb_clone() too, which means it has the same problem. The
>>>> data can be modified by other xdp prog in the destination NIC if we use
>>>> bpf_clone_redirect().
>>>>
>>>> So maybe this is the default logic, and I'm not sure if this patch can break the
>>>> existing users :/
>>> I think for use cases where we are using bpf_clone_redirect() to use
>>> one clone for inspection this would add an unnecessary copy. Maybe
>>> adding *_copy() variants instead of changing the *_clone() would be
>>> better? That way we wouldn't be changing the behavior for existing
>>> consumers and the naming would be consistent with the skb_* methods.
>> Agree. It's not a good idea to change the logic of the existing API. Or
>> maybe we can add a BPF_F_CLONE flag for the existing API.
>>
>>> But more importantly, is there an actual use case for the kind of API
>>> that the modified selftest requires? Nobody until now has considered
>>> the existing behavior to be a problem.
>> Agree too. Obviously, this is not a bug. For the use case in the commit
>> log, it's something that can be fixed by the user themself. If we need
>> modify the MAC, we'd better attach a BPF program for all the egress
>> device in the devmap.
>>
[...]
>>>>
> Thanks for all the comments.
>
> I agree this should not be treated as a generic skb_clone() issue, and I
> understand the concern about changing existing clone/shared-data semantics.
>
> The case I was trying to address is narrower: generic XDP devmap
> broadcast/multi redirect with per-devmap-entry egress programs. The use case is
> not newly introduced by this patch. The existing xdp_veth_egress test already
> attaches xdp_devmap_prog to all egress devmap entries, and that program rewrites
> eth->h_source based on ctx->egress_ifindex. My change only strengthens the test
> from checking that the observed MAC is not equal to a single magic MAC to
> checking that each destination observes the MAC selected for its own egress
> ifindex.
>
> So attaching an egress program to all devmap entries is already what this test
> does. The SKB_MODE failure happens because the cloned skbs can still share the
> packet data, and a later per-egress rewrite can be observed by another
> destination.
>
> That said, I see the concern that this may need a clearer semantic boundary
> between clone and copy behavior. I will also check the last_dst path pointed out
> by Sashiko before deciding whether this should be handled as a bug fix, or
> whether it needs a separate explicit copy/isolated redirect semantic instead.


I agree there's a real concern here. For context, native XDP already 
makes a full copy
of the frame for every broadcast destination:

   dev_map_enqueue_multi -> dev_map_enqueue_clone -> xdpf_clone

so on the native path each destination gets its own independent buffer.

The generic path is the odd one out, because skb_clone() shares the 
underlying data.
I think this rationale should be spelled out in the commit message.

Regarding performance: generic XDP is already a slow path — the ingress 
side already
linearizes / expands the skb (pskb_expand_head() in 
netif_receive_generic_xdp())
so the extra copy here is not a concern.


However, there is one problem with the patch as it stands.

The last destination is transmitted using the original skb directly, 
without unsharing it.
So with two destinations where the first one has no egress XDP program 
and the second (i.e. the last one) does,
the egress modification on the second destination will corrupt the 
packet sent to the first.

This could be addressed by doing the skb_unshare() inside 
dev_map_generic_redirect() instead ?

For the non-broadcast (existing) path the skb is not cloned, so 
skb_unshare() simply returns it unchanged.




