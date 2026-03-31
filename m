Return-Path: <netdev+bounces-273447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJUiHjo9y2kFFAYAu9opvQ
	(envelope-from <netdev+bounces-273447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:19:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E350C363A7D
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F74830465ED
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E46266581;
	Tue, 31 Mar 2026 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QUtmu283"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DFA1E9919
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 03:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774927143; cv=none; b=Qszk5ulDe+zZ4sazBRhMkl6KZaEgWZHH12GLJFFaiOJiUyR94kiY8NBPQVs07aZ7K3wAcgYLEg8aZwME7FI2qftf2MOL69XoKZmSLNJcWbWSt+1npTi8TuwfehyhXAfnud8D7lqzaUNorcEEHB5AfWcHYyFTzeIunljTKxUOZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774927143; c=relaxed/simple;
	bh=Z7lW49Bjo8TiedKHPp1+w/stGzyGL2KI5EW5Cqvh/LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvA+pNKuEJuOp5Ql4/RwvNo/Ls7Qq2Hujv493vHYiJhFjRoZVQHlCQhWX4K0h7yuVruw0kP8b1z5kLYwe7urPVlZeG3CObt0rl9YLYEVc5wWR+xOOiMdOoDrzwsiuTsGecvMjp1BiIWWagJPpKKqV8Ix3tHMxWXPxiPbnrgThK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QUtmu283; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <79805496-9996-40b6-8cbf-0beaf7dd5473@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774927129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F51B4RKJm1crpeWlG2F4ZvuF8sUulbOmrWGId7sfBqo=;
	b=QUtmu283nK3yW4rIZldw9qbVYQ2MPdfxU7l1FlPCoxhAji0KPxiOtbh68BwutO2DPtRNmU
	4KsJMcz6Lszbfr8i+rWBpsGZn5x51L9Tj+zJ51w9c+eEVzLJTyX9Lcnj/bIVB8KPXA/F7O
	AXynNVz/094JlHs6fv9uyR52AlHFgME=
Date: Mon, 30 Mar 2026 20:18:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 1/2] bpf: tcp: Reject non-TCP skb in
 bpf_sk_assign_tcp_reqsk()
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, clm@meta.com,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org,
 ihor.solodrai@linux.dev
References: <20260330080746.319680-2-jiayuan.chen@linux.dev>
 <6ee24770a2b014219d86839b2243e1b7bad4dc4f520457269d5e8ca2b21c2cb8@mail.kernel.org>
 <d1a739d2-c4ea-4fae-aeaf-f49e75dac0f3@linux.dev>
 <CAAVpQUD1n7L6LkP32H_Ct71RLNpJ2RQWFc8w08+c8h=U_tDjpQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAAVpQUD1n7L6LkP32H_Ct71RLNpJ2RQWFc8w08+c8h=U_tDjpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273447-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,meta.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,google.com,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: E350C363A7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 6:35 PM, Kuniyuki Iwashima wrote:
> On Mon, Mar 30, 2026 at 2:26 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>
>>
>> On 3/30/26 5:00 PM, bot+bpf-ci@kernel.org wrote:
>>>> #if IS_BUILTIN(CONFIG_IPV6)
>>>>       case htons(ETH_P_IPV6):
>>>> +            if (ipv6_hdr(skb)->nexthdr != IPPROTO_TCP)
>>>> +                    return -EINVAL;
>>>> +
>>>>               ops = &tcp6_request_sock_ops;
>>> For IPv6, ipv6_hdr(skb)->nexthdr gives the type of the header
>>> immediately following the base IPv6 header. If extension headers
>>> are present (hop-by-hop options, routing, etc.), nexthdr would be
>>> the extension header type rather than IPPROTO_TCP, even when the
>>> packet is a valid TCP segment.
>>>
>>> Would it be worth using ipv6_find_hdr() here, similar to
>>> bpf_update_srh_state() in the same file, to walk past any extension
>>> headers? The IPv4 check above is fine since ip_hdr(skb)->protocol
>>> always identifies the transport protocol directly.
>>>
>>> In practice this is very unlikely to matter since TCP SYN packets
>>> with IPv6 extension headers are essentially non-existent, but the
>>> check as written would reject them.
>>>
>>>
>>> ---
>>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>>> See:https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>>
>>> CI run summary:https://github.com/kernel-patches/bpf/actions/runs/23735111188
>>
>>
>> Thanks for the analysis.
>>
>> There are many places in the kernel that check nexthdr directly without
>> walking extension headers.
>>
>> I'd prefer to keep it simple for now and leave ipv6_find_hdr() as a
>> potential future improvement if needed.
> 
> +1.
> 
> Given this feature is to create a reqsk to process on this running
> host, it does not make sense to support such ext options.

While at header reading, does it need a pskb_may_pull() before reading?

