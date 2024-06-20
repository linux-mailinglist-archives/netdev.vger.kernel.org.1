Return-Path: <netdev+bounces-105468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 353E89114D8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89EE8B21DBF
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFDD80605;
	Thu, 20 Jun 2024 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Gokl7aVG"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA67B3FE
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919690; cv=none; b=sB9bLnVVViEzO4wawI6J/KwF1qLk8O15Ugi4AYfJgmkcIQd5aej9WBdYMXCYMcmMb9g4Fz+suIiebjMiUn0lzjls7pdIGWFcu9LePRswkjLYYizn+RBPYmBl0jA3Zxqqg1w6ewfh2tAcXxhCMwyiJ5lJ9Tak4Ny0UMO8fdY5J/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919690; c=relaxed/simple;
	bh=QnnL26dOUAqeQf9zptzGTmYg/Rb9IZnVj7E1rjhJZz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubfd+YWSb42KBtGH1WNOKI9uQtsyrdffOH0tAYt4SMKYC1LJ3v06u2UG+vhjxCTI1dyHzPQqcvuRmik/DsTJbjJcv+vMdA+sCq9BxNEn4LDfJdAoJNVL9Engyd8fBnQmtcpDzV0OvXReNoq8kXiuTThb1Yc9z37N8xViOtRdTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Gokl7aVG; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sKOVn-003C5E-Dk; Thu, 20 Jun 2024 22:36:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=59TvHWSFE50VsiuZO6ZXvmcCceoNEBExf2TcKujTM1A=; b=Gokl7aVGfGoKva+RRjqlf+5yER
	XZadCePxg7ynaHBak0oJVywWPqcmJEKFMenkas4qcPlLnC8hAulbKL5G0+kE2q74PvluCcuRXu+I/
	K8k2mLG64xttKicz0mm8rpmZsIbvuUA5wZOrC6odp7rYomGo9UzaannU5+lr1kasAwnUoDiqfN+7K
	pdDRfJJF2nKI36fIdZJaoOf8MFJLehlcGSAQyrwxENgSlNuEiYeKGXiQ+D32gssVEOJUMTQ3NvScw
	q7mOoaL4em+nhKTlX1yDvthA2OF9LT6uWUBEWvi0sWcmdEWaLcZerC63Ps1cj+h95/D54o5TBDl+c
	66JE5b+A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sKOVm-0008TL-Ir; Thu, 20 Jun 2024 22:36:02 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sKOVh-000skJ-7k; Thu, 20 Jun 2024 22:35:57 +0200
Message-ID: <b29d7ead-6e2c-4a52-9a0a-56892e0015b6@rbox.co>
Date: Thu, 20 Jun 2024 22:35:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under
 unix_state_lock() for truly disconencted peer.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: cong.wang@bytedance.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <17997c8f-bba1-4597-85c7-5d76de63a7a7@rbox.co>
 <20240619191930.99009-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240619191930.99009-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 21:19, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Wed, 19 Jun 2024 20:14:48 +0200
>> On 6/17/24 20:21, Kuniyuki Iwashima wrote:
>>> From: Michal Luczaj <mhal@rbox.co>
>>> Date: Mon, 17 Jun 2024 01:28:52 +0200
>>>> (...)
>>>> Another AF_UNIX sockmap issue is with OOB. When OOB packet is sent, skb is
>>>> added to recv queue, but also u->oob_skb is set. Here's the problem: when
>>>> this skb goes through bpf_sk_redirect_map() and is moved between socks,
>>>> oob_skb remains set on the original sock.
>>>
>>> Good catch!
>>>
>>>>
>>>> [   23.688994] WARNING: CPU: 2 PID: 993 at net/unix/garbage.c:351 unix_collect_queue+0x6c/0xb0
>>>> [   23.689019] CPU: 2 PID: 993 Comm: kworker/u32:13 Not tainted 6.10.0-rc2+ #137
>>>> [   23.689021] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
>>>> [   23.689024] Workqueue: events_unbound __unix_gc
>>>> [   23.689027] RIP: 0010:unix_collect_queue+0x6c/0xb0
>>>>
>>>> I wanted to write a patch, but then I realized I'm not sure what's the
>>>> expected behaviour. Should the oob_skb setting follow to the skb's new sock
>>>> or should it be dropped (similarly to what is happening today with
>>>> scm_fp_list, i.e. redirect strips inflights)?
>>>
>>> The former will require large refactoring as we need to check if the
>>> redirect happens for BPF_F_INGRESS and if the redirected sk is also
>>> SOCK_STREAM etc.
>>>
>>> So, I'd go with the latter.  Probably we can check if skb is u->oob_skb
>>> and drop OOB data and retry next in unix_stream_read_skb(), and forbid
>>> MSG_OOB in unix_bpf_recvmsg().
>>> (...)
>>
>> Yeah, sounds reasonable. I'm just not sure I understand the retry part. For
>> each skb_queue_tail() there's one ->sk_data_ready() (which does
>> ->read_skb()). Why bother with a retry?
> 
> Exactly.
> 
> 
>>
>> This is what I was thinking:
>>
> 
> When you post it, please make sure to CC bpf@ and sockmap maintainers too.

Done: https://lore.kernel.org/netdev/20240620203009.2610301-1-mhal@rbox.co/
Thanks!

In fact, should I try to document those not-so-obvious OOB/sockmap
interaction? And speaking of documentation, an astute reader noted that
`man unix` is lying:

  Sockets API
       ...
       UNIX domain sockets do not support the transmission of out-of-band
       data (the MSG_OOB flag for send(2) and recv(2)).

  NOTES
       ...
       UNIX domain stream sockets do not support the notion of out-of-band
       data.


