Return-Path: <netdev+bounces-285797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AICGKzW/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:27:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3F34F65E9
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 192B63090DB7
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AFD35C184;
	Fri,  8 May 2026 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j8aD0fHs"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2830FF21
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242822; cv=none; b=D3Jx8wLWQiDzrDMJF3U8iGvX0j3OdtFYLB/qwDTMFFtQug4JDhR274pflakYZv8wcr5G+3wkb6O7bF0LilKAXzo6jYBHzltITLUn0GmuMlzDXqt9hCPhoz+9p97AvtPZbijLC/P690Wf56JRNy58+Fu4CJ5AbAg2Gpifi8NUnsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242822; c=relaxed/simple;
	bh=4vEE2/b1oZRMCPG+2K+JAtmDvlJBK0+IzvqatGl5v/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUo8z5zYrh0y+y2wavyzwGCGApwDNRz5EfQA8KIZNhrniCjW4Fshkngoor4X2UBzo039g0uTKmHYAkYD0Hb7te9KnYwDuYMT8NXYXOHMl2IUy1O8v+pyve0xmL/xR1GOs4K05o5EOZv4olee+z5t8W20S+j0bFsY22Nt25C/YPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j8aD0fHs; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9362bf10-9ede-4005-8e63-a18dafd7fab0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778242808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y75SKeSevL3Yn/NaSSjIxUWA5aj0urOj6ugd6tGsN1Q=;
	b=j8aD0fHs1OVoX/takMidKE59xaxURNObENZhacZCXt3DCqF1w+KCL77TsyXeY1xQ4xWjqg
	bgxQ5xpcsDD8o6XI5Ly9NCE0vkkLRTYL83TbSipcwQ75Qo0zanyHuZe9Kw0YrKV/K6lxA8
	5akbLqq1cuf6Q0EC9ZTZnPgfHWApK1A=
Date: Fri, 8 May 2026 20:19:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 7/8] bpf: tcp: Add SOCK_OPS rcvlowat hook.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20260508073355.3916746-1-kuniyu@google.com>
 <20260508073355.3916746-8-kuniyu@google.com>
 <21ee2d5d-fc8c-497e-aa98-e5e4e3fbecf8@linux.dev>
 <CAAVpQUBv0Uc4Xi-4wK2S63FqtXHHkLqJTotOxxDyhqFknoZG_Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAAVpQUBv0Uc4Xi-4wK2S63FqtXHHkLqJTotOxxDyhqFknoZG_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: AA3F34F65E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285797-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bpf_sock_ops.data:url]
X-Rspamd-Action: no action


On 5/8/26 7:30 PM, Kuniyuki Iwashima wrote:
> On Fri, May 8, 2026 at 3:37 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>
>> On 5/8/26 3:33 PM, Kuniyuki Iwashima wrote:
>>> Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVLOWAT_CB.
>>>
>>> Let's invoke the BPF SOCK_OPS prog when
>>>
>>>     1. TCP stack enqueues skb to sk->sk_receive_queue
>>>        -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb()
>>>
>>>     2. TCP recvmsg() completes
>>>        -> __tcp_cleanup_rbuf()
>>>
>>> This will allow the BPF prog to parse each skb and dynamically
>>> adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN wakeups
>>> until sufficient data (e.g., a full RPC frame) is available
>>> in the receive queue.
>>>
>>> Note that the direct access to bpf_sock_ops.data is intentionally
>>> disabled by passing 0 as end_offset.
>>>
>>> Instead, the BPF prog is supposed to use bpf_skb_load_bytes()
>>> with bpf_sock_ops because payload is not in the linear area
>>> with TCP header/data split on and skb may contain a RPC
>>> descriptor in skb frag.  This also simplifies the BPF prog.
>>>
>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>>> ---
>>>    include/net/tcp.h       | 14 ++++++++++++++
>>>    net/ipv4/tcp.c          |  2 ++
>>>    net/ipv4/tcp_fastopen.c |  2 ++
>>>    net/ipv4/tcp_input.c    | 10 ++++++++++
>>>    4 files changed, 28 insertions(+)
>>>
>>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>>> index 4e9e634e276b..003e46c9b500 100644
>>> --- a/include/net/tcp.h
>>> +++ b/include/net/tcp.h
>>> @@ -737,6 +737,20 @@ static inline struct request_sock *cookie_bpf_check(struct net *net, struct sock
>>>    }
>>>    #endif
>>>
>>> +#ifdef CONFIG_CGROUP_BPF
>>> +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
>>> +
>>> +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
>>> +{
>>> +     if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVLOWAT_CB_FLAG))
>>> +             bpf_skops_rcvlowat(sk, skb);
>>> +}
>>> +#else
>>> +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
>>> +{
>>> +}
>>> +#endif
>>> +
>>>    /* From net/ipv6/syncookies.c */
>>>    int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th);
>>>    struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
>>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>>> index 1d9e52fc454f..80144b97a87a 100644
>>> --- a/net/ipv4/tcp.c
>>> +++ b/net/ipv4/tcp.c
>>> @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copied)
>>>                tcp_mstamp_refresh(tp);
>>>                tcp_send_ack(sk);
>>>        }
>>> +
>>> +     tcp_bpf_rcvlowat(sk, NULL);
>>>    }
>>>
>> tcp_read_skb (process frame 1 and __skb_unlink)
>> └─ sk_psock_verdict_recv
>>       └─ sk_psock_verdict_apply
>>           └─ tcp_eat_skb
>>               └─ tcp_cleanup_rbuf
>>                   └─ __tcp_cleanup_rbuf
>>                       └─ BPF RCVLOWAT_CB
>>                           └─ bpf_sock_ops_tcp_set_rcvlowat (wakeup=true)
>>                               └─ tcp_data_ready
>>                                   └─ sk_psock_verdict_data_ready
>>                                       └─ tcp_read_skb (frame 2)
>>                                           └─ ... → tcp_read_skb (frame 3) ...
>>
>> For strparser it use read_sock instead of read_skb and it will become
>> more complicated...
> To be clear, this feature is NOT to use strparser/sockmap.
>> I think this will cause stack overflow with amounts of skbs in receive
>> queue or infinite call(not tested) for sockmap/kTLS/strparser.
>>
> BPF user is responsible for not doing silly things.
>
> tcp_bpf_strp_read_sock() can have loop detection logic,
> but it's only if really needed.


Similar infinite recursion problems for reference:
  https://lore.kernel.org/r/20220929070407.965581-5-martin.lau@linux.dev
  https://lore.kernel.org/bpf/20260421155804.135786-1-kafai.wan@linux.dev/

They were not solved in TCP side but in ops side.


Can we try to handle it on the BPF/OPS side first and only
prevent it elsewhere if it's not feasible there ?


Thanks


