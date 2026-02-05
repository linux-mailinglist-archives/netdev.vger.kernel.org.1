Return-Path: <netdev+bounces-256891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGGNLBnlg2mbvQMAu9opvQ
	(envelope-from <netdev+bounces-256891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 01:32:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19294ED701
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 01:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED060300F9F2
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 00:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E98613A244;
	Thu,  5 Feb 2026 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JI7mvZkY"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4367D2AD32
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770251517; cv=none; b=fALmljiwuoyjTYsuZ95A318dIb0aYxlEvbHR5OUgOLTci5Gzyzj7Nz5lO6T+jJcFePeCvBxnYh5e0UGIttdFB/u5RCjP6aMUag/QoVh1ljRneu3OumSbNgfjXG6gP4rdTgIgylOcgfej3Kh5Nsrbi3j6pqNJexS7J7Ws2AXQLAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770251517; c=relaxed/simple;
	bh=n9fHcu8iZOUYTF8e/Bf3Uxj0xVdGkFnoJ1+rpmRkZYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpBBNE74i8pNGkgzcxlBQBnPaxcJRDrcWxJWe4V5kFrq6z/ypH7A87gZUbWV2jBsDf48f7LQQ9C1yaxKEhCMl37PFmKa92Uh9FzhNLgWctbm0VTwLjcyJoOgjsxt5QStAqfQvSSKQohLJcZRZqsF3I1Rk92/A60QWFu+UGRK7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JI7mvZkY; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c4b5aba5-ec48-4329-9549-b5c96de40c69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770251505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lM/MzMow83GadW34Ofqq1msI3+/k3/l0eZ4j44zqwbk=;
	b=JI7mvZkYjHQAx3QYwclZ4I/BOWiSc7IXVIScGIBAv4EgPh1dwaXxNw5OWCYQbg7GamihBN
	84V5V6BvlXyff9SEr8tcFkzsvvGWB763XjHxp+kGCsK2mL8GSWT8/eiBVLFR3ga/JrpapC
	/X7PcxIiE5kDK2kcNHpacqeKbQfn6Jg=
Date: Wed, 4 Feb 2026 16:31:32 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
To: Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jakub@cloudflare.com,
 john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co>
 <20260203200242.404131-1-kuniyu@google.com>
 <80865b12-7786-4787-81c8-08b754716a5d@linux.dev>
 <CAAVpQUCshzAAHZQQ7sVE+3UdKmBV42bKudcdDR0KtaTcTqn5gA@mail.gmail.com>
 <408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co>
 <0f8ec4c7-5de4-4e0b-a50e-cf4f8d59709b@linux.dev>
 <37a594f4-a951-4283-80eb-67b6acecf61f@rbox.co>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <37a594f4-a951-4283-80eb-67b6acecf61f@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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
	TAGGED_FROM(0.00)[bounces-256891-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,iogearbox.net,davemloft.net,google.com,kernel.org,cloudflare.com,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 19294ED701
X-Rspamd-Action: no action



On 2/4/26 3:25 PM, Michal Luczaj wrote:
> On 2/4/26 20:34, Martin KaFai Lau wrote:
>>> But then there's SOCK_DGRAM where you can drop unix_peer(sk) without
>>> releasing sk; see AF_UNSPEC in unix_dgram_connect(). I think Martin is
>>> right, we can crash at many fentries.
>>>
>>> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
>>> Read of size 2 at addr ffff888147d38890 by task test_progs/2495
>>> Call Trace:
>>>    dump_stack_lvl+0x5d/0x80
>>>    print_report+0x170/0x4f3
>>>    kasan_report+0xe1/0x180
>>>    bpf_skc_to_unix_sock+0xa4/0xb0
>>>    bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
>>>    bpf_trampoline_6442564662+0x47/0xab
>>>    unix_shutdown+0x9/0x880
>>>    __sys_shutdown+0xe1/0x160
>>>    __x64_sys_shutdown+0x52/0x90
>>>    do_syscall_64+0x6b/0x3a0
>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> This probably is the first case where reading a sk pointer requires a
>> lock. I think it will need to be marked as PTR_UNTRUSTED in the verifier
>> for the unix->peer access, so that it cannot be passed to a helper.
>> There is a BTF_TYPE_SAFE_TRUSTED list. afaik, there is no untrusted one now.
> 
> What about 'fexit/sk_common_release' that does 'bpf_skc_to_unix_sock(sk)'.
> Is this something the verifies is supposed to handle?

fexit is an obvious one if the bpf prog wants to shoot itself on the 
foot by using things at the fexit of a free/release function. There are 
other things can break also if a tracing-capable user wants to exploit 
at fexit. I don't have good idea how to solve it.

Going back to the bpf_skc_to_* helper. The bigger hammer may be, we 
should properly depreciate the bpf_skc_to_* usage from tracing instead 
of fixing it and ask the user to stay with the bpf_core_cast.


