Return-Path: <netdev+bounces-256598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCzdATzygmmWfQMAu9opvQ
	(envelope-from <netdev+bounces-256598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:16:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9419EE295C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F105430199DD
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 07:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C418F34D3B1;
	Wed,  4 Feb 2026 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FhdEUhiM"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F04A325727
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189369; cv=none; b=g8EaKULmjoIvO0d772iWQPexw+5Zmi9ykcJo9JnCPDVs9Ck1yaP+e445NZPiCczZifVu3OI8nDwhPjIlE4VXGBu4aJDBn3KZ31/vCOo4C3tBHxISMofxdIOO07ypbSfYzQuYyICbREYzHNL2qM0G9C/ammEurojE7H8WT5M7hPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189369; c=relaxed/simple;
	bh=Fb1JguzNlrjEL6SazegIH4xSNcYGMvK/YOd9uZglxjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DS/Ek+IyPga1+QdS/jRzhRt614s8noV0lJnMAj1WXn/4UMfCb0u0VFyN44KtYWXgprciScMJMlUy+xh2uxUAFMN/dHEraAj9KC68/f1Z5XFTEtVE7IWLrWbdAWi7sf8nFd+XTS3oRPDAgQ4hwO6bo4SFJLuXowm62jyEcFaWEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FhdEUhiM; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <80865b12-7786-4787-81c8-08b754716a5d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770189357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIzahF4fKiLYiAsLF0Jwew4BLtV36PrwNYbnuxLSg1w=;
	b=FhdEUhiMa8LB4K5xC9Df0p8ff3q2uin4eJhHxBVqPKGEUlIZqLNRWeR93cjKgzVvWgaUaX
	5L4sABf7CboDTUh8OXj9Rtih9VRPFX/c8jiiOf7ht7SX4Y9FzQyVPEZgj/IlFX30k0Xwho
	wppfl3xQijscSEuL85HJKAgntZP0eh0=
Date: Tue, 3 Feb 2026 23:15:51 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
To: Kuniyuki Iwashima <kuniyu@google.com>, mhal@rbox.co
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jakub@cloudflare.com,
 john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co>
 <20260203200242.404131-1-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260203200242.404131-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256598-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rbox.co:email]
X-Rspamd-Queue-Id: 9419EE295C
X-Rspamd-Action: no action

On 2/3/26 11:47 AM, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Tue, 3 Feb 2026 10:57:46 +0100
>> On 2/3/26 04:53, Martin KaFai Lau wrote:
>>> On 2/2/26 7:10 AM, Michal Luczaj wrote:
>>>> In related news, looks like bpf_iter_unix_seq_show() is missing
>>>> unix_state_lock(): lock_sock_fast() won't stop unix_release_sock(). E.g.
>>>> bpf iterator can grab unix_sock::peer as it is being released.
>>>
>>> If the concern is the bpf iterator prog may use a released unix_peer(sk)
>>> pointer, it should be fine. The unix_peer(sk) pointer is not a trusted
>>> pointer to the bpf prog, so nothing bad will happen other than
>>> potentially reading incorrect values.
>>
>> But if the prog passes a released peer pointer to a bpf helper:
>>
>> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
>> Read of size 1 at addr ffff888110654c92 by task test_progs/1936

hmm... bpf_skc_to_unix_sock is exposed to tracing. bpf_iter is a tracing 
bpf prog.

> 
> Can you cook a patch for this ? probably like below

This can help the bpf_iter but not the other tracing prog such as fentry.

> 
> ---8<---
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 02ebad6afac7..9c7e9fbde362 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -3740,8 +3740,9 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
>   		return 0;
>   
>   	slow = lock_sock_fast(sk);
> +	unix_state_lock(sk);
>   
> -	if (unlikely(sk_unhashed(sk))) {
> +	if (unlikely(sock_flag(other, SOCK_DEAD))) {
>   		ret = SEQ_SKIP;
>   		goto unlock;
>   	}
> @@ -3751,6 +3752,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
>   	prog = bpf_iter_get_info(&meta, false);
>   	ret = unix_prog_seq_show(prog, &meta, v, uid);
>   unlock:
> +	unix_staet_unlock(sk);
>   	unlock_sock_fast(sk, slow);
>   	return ret;
>   }
> ---8<---
> 
> Thanks!


