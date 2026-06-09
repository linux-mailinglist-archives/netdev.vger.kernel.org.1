Return-Path: <netdev+bounces-297058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4/XpEfkcKGrP+AIAu9opvQ
	(envelope-from <netdev+bounces-297058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:02:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED50660D0E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:02:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=htAaPuM4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297058-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297058-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A04453031334
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4425E41361D;
	Tue,  9 Jun 2026 13:55:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68DB3839BA;
	Tue,  9 Jun 2026 13:55:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013324; cv=none; b=cHaZnnLU+a0KVAgTOSrovtFogvDps5PrRop5Hzydyfeu/SPtRkvZ6IJWqnScNmw74Nr4OG6AEGqdo1bTMHFhnmzrg7DonWp+001vZLucNviQM86+etuobwVaeFCWCheviLCKT4RyA0XvnbgozyJqEAo17iZWka4nd+VToA2OVMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013324; c=relaxed/simple;
	bh=7B0VErhoO4IBLdB2pAQxOtd59aX4STChOKYtOvn3Bos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=To04pHX6fC7x0bc1xquG/ywnrxwgge1gAfNfayosFOwGrSJnN8t94EKXhs7KxbqyUgx2gy+2V/ns6a7BRdp7FmzKvlYFizcM6bKvl7o/9jJYuoEtiQ7Sur8Z9mCelrWb2fzLUUW2HnKKu7LaI3j6DFbDuzJXgFDQtjudzX+/NTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=htAaPuM4; arc=none smtp.client-ip=91.218.175.183
Message-ID: <f0468cb2-1b52-4216-9592-ceb204f6ea41@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781013310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBshCEsRUNVy8WU5f/Zn3mDRm2/wce9vXr1J5RuHeR4=;
	b=htAaPuM4fnOFbMYZaI1pGxilzz4ejjV1WNh/zLiXjozIaHA7pqxaYOrEVTUAvTsDuKisbl
	YHSQsCs6VThLtTH3fgNdDtV0MZpILgQvNTaN150sa1mexygstjuzMdA3Q5zPIaIAc6EOge
	5NWO7RzaD7l1+TdJxBm7fV77NN3rSGk=
Date: Tue, 9 Jun 2026 21:54:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Joe Stringer <joe@wand.net.nz>, Network Development
 <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
 <20260608125846.157004-2-jiayuan.chen@linux.dev>
 <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
 <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com>
 <CAAVpQUATP7S7OEZw4P_7fp5zmQO-T5jByxAfp0+YsjRENeWscg@mail.gmail.com>
 <CAADnVQKa2Z2HKKZMhyD1HrurQ4LTcCS0Mm0YPxtisGKwVfcxmg@mail.gmail.com>
 <CAAVpQUCJH3iknHSfNwMqvHVc_V09zNDK-YbXbqa-=K159PTqiw@mail.gmail.com>
 <DJ40JYME18U1.3RA3TUXB3MH3M@gmail.com>
 <CAAVpQUC1Ot9vr09gNoe+vxgLoqU8Wwn2DV+CQZYYpAJUATJiWg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAAVpQUC1Ot9vr09gNoe+vxgLoqU8Wwn2DV+CQZYYpAJUATJiWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-297058-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:alexei.starovoitov@gmail.com,m:ast@kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:joe@wand.net.nz,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:alexeistarovoitov@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,iogearbox.net,linux.dev,wand.net.nz];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8ED50660D0E


On 6/9/26 6:34 AM, Kuniyuki Iwashima wrote:
> On Mon, Jun 8, 2026 at 3:16 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Mon Jun 8, 2026 at 2:35 PM PDT, Kuniyuki Iwashima wrote:
>>>> btw is earlier sashiko TOCTOU concern real?
>>> Yes, the selftest in patch 2 should reproduce null-ptr-deref.
>>> (I tested one in a prior version)
>>>
>>>
>>>> iph->protocol = IPPROTO_TCP;
>>>> bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
>>>> iph->protocol = IPPROTO_UDP;
>>>>
>>>> as far as I can tell past bpf_sk_assign_tcp_reqsk()
>>>> the networking stack only looks at skb->protocol,
>>>> so modifying iph->protocol will only mess up
>>>> things on the wire (if this packet goes out).
>>> ip_rcv_finish_core() uses iph->protocol for early demux
>>> and ip_local_deliver_finish() also uses it for demux.
>> ok. Another idea... we can keep the checks on bpf side and
>> teach the verifier to invalidate packet pointers at bpf_sk_assign_tcp_reqsk()
>> and introduce new concept of "readonly skb".
>> So after invalidation the reloaded sbk->data will be read only.
> Yes, this is exactly what I had in mind in the other thread :)
>
> ---8<---
> On top of L4 validation in bpf_sk_assign() and bpf_sk_assign_tcp_reqsk(),
> can't we mark such an skb immutable after the helpers and catch
> subsequent writes to skb->data on the verifier ?
> ---8<---
>
>
>> There is no such thing today. The verifier only understands PTR_TO_PACKET
>> as read/write. So it's not easy, but probably good thing to have
>> for this and other cases where bpf prog shouldn't touch the packet
>> once it called some kfunc/helper.
> This would be useful and we could (re)move some validations from
> the fast path.


Hi Kuniyuki and Alexei,


Thanks both for the discussion, it makes sense to me.

I'll go back to fixing this in the helper itself, like the previous 
version did.


Then, as a longer-term and more general solution, I'll try look into 
marking the
skb as immutable after these helpers so the verifier can reject any 
later writes
to the packet.


