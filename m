Return-Path: <netdev+bounces-85931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5294989CEED
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 01:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFFD287924
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4363E53807;
	Mon,  8 Apr 2024 23:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="jlcl9s2Z"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CB6171B0
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 23:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618750; cv=none; b=eSuBe93wms/l8JrDse/UOWGAdLZ9Hjwp8kYJ4uCyiYgbdwfh3hJtttsh6DjmTosNTC5DI+mZIWvocMBI7+lzuWhIAsqLpe6MD801f9tuFTMjmfIaM/VBgg/n0baTVStgtWyLEBovPN6hIGSRMV9wiJLOcpwImOXzHcavrBoW0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618750; c=relaxed/simple;
	bh=nY+yierZIh2aQyUM/eztxjd7nDccsTrYf0rXHbe9KKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYoOtFWgcHdaYy+b9aQUTu7sod7qWLaugHE8afMK42o9AkEThdhf1WrUw1y5QGpCgzfjA8ANZErHO8FhNP2GjG2wOozp/xmkElOqL0WNsD1pH4TcRNZLQgZiNCytlwpUql6Yxu3pkMHNKs/1kEtXB9buvfgIEMNOiCykhxFQjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=jlcl9s2Z; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1rtyMw-00CJYk-MC; Tue, 09 Apr 2024 01:25:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=t371Iy+FhYxhl7DOAG5fYy9u8vKqKRm49whvClVFQhQ=; b=jlcl9s2ZKl6uXldGBZ6SdGcclR
	jihCQ7saS62qPqnXe8zkorN35ZT4gLHFfYI9gA32oeUM8eh70/+xkju0QsEa0tRc04IW9ITNQJZ/M
	sVaWFWonuUOPb5s3ZWUszR9gjgAMzhFlg52royP2/RZrT753dN1NfJxGHVZwR3ATYezdABDGEsPA7
	IVsn2K2jlLYGJrlk7mRKTtchuxEyCsgg1glnIrPqL/fSBOkGhvHWrJ22hf0Kalw7n3797tTQEKAXR
	KoZfYUk+tDelJIKitftVTa7sxYmaARD91eDHyqtu9HGHLOf2u4lLs92vq7A7aeOTcEQ7kLdIoLJGI
	GzCfXQ0A==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1rtyMv-0000Kd-QT; Tue, 09 Apr 2024 01:25:41 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1rtyMe-000ExV-7z; Tue, 09 Apr 2024 01:25:24 +0200
Message-ID: <c3f212f8-01a5-4037-af76-39170aa6a6ce@rbox.co>
Date: Tue, 9 Apr 2024 01:25:23 +0200
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
References: <20240408161336.612064-2-mhal@rbox.co>
 <20240408211830.99829-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240408211830.99829-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/24 23:18, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Mon,  8 Apr 2024 17:58:45 +0200
...
>>  	list_for_each_entry_safe(u, next, &gc_inflight_list, link) {
>> -		long total_refs;
>> -
>> -		total_refs = file_count(u->sk.sk_socket->file);
>> +		struct sock *sk = &u->sk;
>> +		long total_refs = file_count(sk->sk_socket->file);
>>  
>>  		WARN_ON_ONCE(!u->inflight);
>>  		WARN_ON_ONCE(total_refs < u->inflight);
>> @@ -286,6 +295,11 @@ static void __unix_gc(struct work_struct *work)
>>  			list_move_tail(&u->link, &gc_candidates);
>>  			__set_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
>>  			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
>> +
>> +			if (sk->sk_state == TCP_LISTEN) {
>> +				unix_state_lock(sk);
>> +				unix_state_unlock(sk);
> 
> Less likely though, what if the same connect() happens after this ?
> 
> connect(S, addr)	sendmsg(S, [V]); close(V)	__unix_gc()
> ----------------	-------------------------	-----------
> NS = unix_create1()
> skb1 = sock_wmalloc(NS)
> L = unix_find_other(addr)
> 						for u in gc_inflight_list:
> 						  if (total_refs == inflight_refs)
> 						    add u to gc_candidates
> 						    // L was already traversed
> 						    // in a previous iteration.
> unix_state_lock(L)
> unix_peer(S) = NS
> 
> 						// gc_candidates={L, V}
> 
> 						for u in gc_candidates:
> 						  scan_children(u, dec_inflight)
> 
> 						// embryo (skb1) was not
> 						// reachable from L yet, so V's
> 						// inflight remains unchanged
> __skb_queue_tail(L, skb1)
> unix_state_unlock(L)
> 						for u in gc_candidates:
> 						  if (u.inflight)
> 						    scan_children(u, inc_inflight_move_tail)
> 
> 						// V count=1 inflight=2 (!)

If I understand your question, in this case L's queue technically does change
between scan_children()s: embryo appears, but that's meaningless. __unix_gc()
already holds unix_gc_lock, so the enqueued embryo can not carry any SCM_RIGHTS
(i.e. it doesn't affect the inflight graph). Note that unix_inflight() takes the
same unix_gc_lock.

Is there something I'm missing?

> As you pointed out, this GC's assumption is basically wrong; the GC
> works correctly only when the set of traversed sockets does not change
> over 3 scan_children() calls.
> 
> That's why I reworked the GC not to rely on receive queue.
> https://lore.kernel.org/netdev/20240325202425.60930-1-kuniyu@amazon.com/

Right, I'll try to get my head around your series :)

