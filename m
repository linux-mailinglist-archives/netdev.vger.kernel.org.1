Return-Path: <netdev+bounces-86038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B119989D542
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 11:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF22283562
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A302E7E78B;
	Tue,  9 Apr 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Q2+Juaxl"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A95339A
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654219; cv=none; b=iiIr2Vi5wiKI6Xa4vFQ8h3n9sdviFn+SskhmTjddyvm/fM7dRVZFJqtViu3XVKNCWBX6QdUTegMAnmkOv4s+C+jbJiKvQ7lSn53ivfyrBsCSkTuQMFgIWW7r5dcebt2NMjt84T3N7XbDqE0YZoEBJD/Q7XHcb690x69lSGNHpFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654219; c=relaxed/simple;
	bh=HlcA6licBxnHC/e/XV8kw5JnC26HiSTYCUdVDAx/TE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCHUo6a0bqaOSxmQiHdQlJXagnIS9UD3WZ3Dj+WSWRA2tKmkw9m/iuAyley6tElpjkESHFuzfoSr4QnQM3Lr1qvMkiyJZjMf8hszmijwFMbKeNXa4zYnRS2i/8fL5cVkwVjAI19AzjW2zF5qfGMKvdL+ZfH/oqR9zpkS0I5G3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Q2+Juaxl; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1ru7ay-00DKFj-Q6; Tue, 09 Apr 2024 11:16:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=EHxIhLvjV4YX22Qn85bM/nQI0szi3H4/QjeUolwuVgc=; b=Q2+JuaxlO8wqCHX6pNkWpfnS9t
	OOIMuMPhC2L30r7thEpshrm/so+Xyt9NKG9D79Xb4+pCRx6dk1jAmU6utw2ZYkoUKNcjwE8cvS3ES
	ZVL3fZ+2mx+avNbEiA4asUZO95t5/IcUEGVPVFE8sO65XuU98WYxc64WwHIaUyXy5rRlqgQJrsl/D
	i69mbePO/N8MutWLhHaXeGmAQ6T/wEQRaZu/1d3jDaoIs1XHiVzteHDgfEZOjqrrODA+1X3MC9NEo
	5CJsI0sd/pp1lrZMdME1XYTj//Jg6o8vEe3gMnUIhmyUTlif3M3kzWlmV4wWSoADViyT11HnztK/m
	9uh0fTbQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1ru7ax-0002iW-Tg; Tue, 09 Apr 2024 11:16:48 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1ru7an-0027Wc-6v; Tue, 09 Apr 2024 11:16:37 +0200
Message-ID: <30c3f9d4-bcc8-471e-b8d4-4dc2c044925a@rbox.co>
Date: Tue, 9 Apr 2024 11:16:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] af_unix: Fix garbage collector racing against
 connect()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <c3f212f8-01a5-4037-af76-39170aa6a6ce@rbox.co>
 <20240409002231.17900-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240409002231.17900-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/24 02:22, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Tue, 9 Apr 2024 01:25:23 +0200
>> On 4/8/24 23:18, Kuniyuki Iwashima wrote:
>>> From: Michal Luczaj <mhal@rbox.co>
>>> Date: Mon,  8 Apr 2024 17:58:45 +0200
>> ...
>>>>  	list_for_each_entry_safe(u, next, &gc_inflight_list, link) {
> 
> Please move sk declaration here and
> 
>>>> -		long total_refs;
>>>> -
>>>> -		total_refs = file_count(u->sk.sk_socket->file);
> 
> keep these 3 lines for reverse xmax tree order.

Tricky to have them all 3 in reverse xmax. Did you mean

	struct sock *sk = &u->sk;
	long total_refs;

	total_refs = file_count(sk->sk_socket->file);

?

>>> connect(S, addr)	sendmsg(S, [V]); close(V)	__unix_gc()
>>> ----------------	-------------------------	-----------
>>> NS = unix_create1()
>>> skb1 = sock_wmalloc(NS)
>>> L = unix_find_other(addr)
>>> 						for u in gc_inflight_list:
>>> 						  if (total_refs == inflight_refs)
>>> 						    add u to gc_candidates
>>> 						    // L was already traversed
>>> 						    // in a previous iteration.
>>> unix_state_lock(L)
>>> unix_peer(S) = NS
>>>
>>> 						// gc_candidates={L, V}
>>>
>>> 						for u in gc_candidates:
>>> 						  scan_children(u, dec_inflight)
>>>
>>> 						// embryo (skb1) was not
>>> 						// reachable from L yet, so V's
>>> 						// inflight remains unchanged
>>> __skb_queue_tail(L, skb1)
>>> unix_state_unlock(L)
>>> 						for u in gc_candidates:
>>> 						  if (u.inflight)
>>> 						    scan_children(u, inc_inflight_move_tail)
>>>
>>> 						// V count=1 inflight=2 (!)
>>
>> If I understand your question, in this case L's queue technically does change
>> between scan_children()s: embryo appears, but that's meaningless. __unix_gc()
>> already holds unix_gc_lock, so the enqueued embryo can not carry any SCM_RIGHTS
>> (i.e. it doesn't affect the inflight graph). Note that unix_inflight() takes the
>> same unix_gc_lock.
>>
>> Is there something I'm missing?
> 
> Ah exactly, you are right.
> 
> Could you repost this patch only with my comment above addressed ?

Yeah, sure. One question though: what I wrote above is basically a rephrasing of
the commit message:

    (...) After flipping the lock, a possibly SCM-laden embryo is already
    enqueued. And if there is another connect() coming, its embryo won't
    carry SCM_RIGHTS as we already took the unix_gc_lock.

As I understand, the important missing part was the clarification that embryo,
even though enqueued after the lock flipping, won't affect the inflight graph,
right? So how about:

    (...) After flipping the lock, a possibly SCM-laden embryo is already
    enqueued. And if there is another embryo coming, it can not possibly carry
    SCM_RIGHTS. At this point, unix_inflight() can not happen because
    unix_gc_lock is already taken. Inflight graph remains unaffected.

Thanks!


