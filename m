Return-Path: <netdev+bounces-96498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BFD8C63A7
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 11:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E8B1C21E53
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7333C57C9A;
	Wed, 15 May 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="lAwdQfxw"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ECD27456
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765371; cv=none; b=Iip8LCSB9RolN2yqvbUuyJj2ngDort0VPvQ9hAKpH3HZPDQgqctI3bMoVm1m8ohOJfAWAu7x2eVGEgGfs2XCi78zR278VqiqRL74EVtvFwCdsM10T1KxCqwM+oRKRQBGcQ23pjRGUpTk7cWbK9yzXm2o9AF34KaSaUBDh+uBu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765371; c=relaxed/simple;
	bh=Vkg2HJQmKkxZ1uqyBR7XBs/HttrfBvc/NnuI7OU8RuA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=u+zwj8KgebuaVoHBdUggqXHlnrBJUcNZza13P7G4LABqnacsGnW+jZ0GKRmv22uQpQKdkZqnsQixunIM9iJN7zGs4PEzkcA5DxyUPvXUzTbMBC4QdVrvWh27NQ4I9jIX/nU8lPBQVFLWUKCBRV0KxLKy2hKjHzN+scWMnW3ZKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=lAwdQfxw; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s7Awg-00Gz7u-EK; Wed, 15 May 2024 11:29:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=EaD4UZjtWmc3wkeuA96LysRD3d8E0xxC64QiP5pyaf0=; b=lAwdQfxw9lXKhvcCCqmmWhfBvB
	Tl8vQd8a3IugSMarZ7vhV8TlHQGRsJPqsfFiwEULa4IV88EBU4bnx6qw05B9wJEDvjyuPclNdk9uG
	8rAK57u7sO7cHIa7yiNr7jBK7U/xI4YSeu1ttmvg8Bo/BLq7Ib8yXKBVeQG3VDSxsP+C9T4dCC9bE
	DoboHSCSPEVlUVA//dXO73sMF+o0TU+VO3nA7BteM/8BXHXSE/45gSDZs0K12OuipYFW+zbHHFDhr
	HmHMLRZKGOF1ED7ab0FKOjxL2OAV3Gg0bYhsNPfkcVA3D12on6zGULVZ03fV3g2lA6O1VrCK7RBj2
	r7TDqb3Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s7Awf-0002pX-FT; Wed, 15 May 2024 11:29:09 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s7AwN-00Enkn-7X; Wed, 15 May 2024 11:28:51 +0200
Message-ID: <b11c0bdf-a7ea-4fdf-b07c-3034229aaa5f@rbox.co>
Date: Wed, 15 May 2024 11:28:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH v4 net] af_unix: Update unix_sk(sk)->oob_skb under
 sk_receive_queue lock.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: billy@starlabs.sg, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <6915a10c-cc57-4a68-9f91-a5efdf42091d@rbox.co>
 <20240515000709.41004-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20240515000709.41004-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/24 02:07, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Tue, 14 May 2024 12:13:36 +0200
>> On 5/14/24 04:52, Kuniyuki Iwashima wrote:
>>> ...
>>> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
>>> index 0104be9d4704..b87e48e2b51b 100644
>>> --- a/net/unix/garbage.c
>>> +++ b/net/unix/garbage.c
>>> @@ -342,10 +342,12 @@ static void __unix_gc(struct work_struct *work)
>>>  		scan_children(&u->sk, inc_inflight, &hitlist);
>>>  
>>>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>>> +		spin_lock(&u->sk.sk_receive_queue.lock);
>>>  		if (u->oob_skb) {
>>> -			kfree_skb(u->oob_skb);
>>> +			WARN_ON_ONCE(skb_unref(u->oob_skb));
>>>  			u->oob_skb = NULL;
>>>  		}
>>> +		spin_unlock(&u->sk.sk_receive_queue.lock);
>>>  #endif
>>>  	}
>>
>> I've realised this part of GC is broken for embryos. And adding a rq lock
>> here turns a warning into a possible deadlock, so below is my attempt at
>> fixing the underlying problem.
> 
> Exactly, I missed that case.  It's memleak rather than deadlock.
>
> We need to traverse embryos from listener to drop OOB skb refcount
> in embroy recvq to drop listener fd's refcount.

In a way, yeah. See below.

>> It's based it on top of your patch, so should I post it now or wait until
>> your patch lands in net?
> 
> I'll post your patch within v5 that will minimise the delay given
> we are in rush for the merge window.

Awesome!

>> Subject: [PATCH] af_unix: Fix garbage collection of embryos carrying
>>  OOB/SCM_RIGHTS
>>
>> GC attempts to explicitly drop oob_skb before purging the hit list. The
> 
> s/oob_skb/oob_skb's refcount/

Ah, yeah, you're right.

>> problem is with embryos: instead of trying to kfree_skb(u->oob_skb) of an
>> embryo socket, GC goes for its parent-listener socket, which never carries
>> u->oob_skb. Effectively oob_skb is removed from the receive queue, but
>> remains reachable via u->oob_skb.
> 
> The last sentence is not correct as the listener does not have oob_skb and
> kfree_skb() is not called.

I was referring to embryo's oob_skb. Anyway, I took a look at your v5
series and I see you've changed my commit message in ways I disagree
with, so I'll comment there.

> I'll post this patch with some modification of commit message.
> 
> Thanks!

