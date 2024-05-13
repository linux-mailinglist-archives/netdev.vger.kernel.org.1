Return-Path: <netdev+bounces-95962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A468C8C3EB6
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD13F1F224B5
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD0A149E10;
	Mon, 13 May 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="EczDoF69"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E11487EC
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595391; cv=none; b=d8rfaKx9Zw2616noFQ6a5/JK60ECuaun3krNRlaW9zScpuggiIDXG4Aw3DYKtqbIG1hfRo5URuDJ1SWEbCAnW0qf35q71pTjFK4e5GAiWlCQUrqqO/5NYeorRbdwogM4GulGKOUpYtRP9v/Mku14RG+6X8dm8VUHqe0x/LFIre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595391; c=relaxed/simple;
	bh=3YxdM5aqGhCgeCgDlg1RXuR0BDGDgoeo1GTxksBh85Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n3zjipopWGqFKfnvrSPVaGdBou4YYTe9Bv+SdXmoCK6r3SfoSEO+laRTVvKk5ghMA0tcBQuDGIbrIqodiskZ5FVdGQEo0RNsrXi0UIWiY0tUbj0GFOph0aNVymL1GseOLSNpKAgJw/nHaekTlgifCxs+loNbkAkGBrZnNHsIBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=EczDoF69; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s6SjE-00Bc2i-Ba; Mon, 13 May 2024 12:16:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=a8osHBdpEHe8VaYYEDJvMcVxEvdIpZ/M2bv/VFp/ru0=; b=EczDoF69A4eBEqLOLDh57VXji9
	p9jMBS76RpJboi7TPpJC48T6BQtdNwxkpdbe8x58NoX/EZ8i97wJJ1FBbYfnzWZwHGCihKn09WJIb
	EH5nejdy/4AGqZjJtljnrgSbY4E02zuY7T8YcBUdsah16/19bQiqvPtvpfU0vQLp5SzgRmJ42jNOG
	8KM+mMZNB/eEnVQReq513CRZj98dydcT2dv9svw06M7QJGXXQlD+UDIZKq85E9HmL0KTqda4iXciO
	g3b+AmNPMsPz1QJS51R1eF2TClhS+ygrknpxtNm86F1/jeqb9ShhF80cFhbxdpNDO59lcl0Ir6evU
	klYEUFcw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s6SjD-00019h-8X; Mon, 13 May 2024 12:16:19 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s6Sit-0079pu-Jc; Mon, 13 May 2024 12:15:59 +0200
Message-ID: <30bb2dd9-f84e-4615-9217-fea3e656fa49@rbox.co>
Date: Mon, 13 May 2024 12:15:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH v2 net] af_unix: Update unix_sk(sk)->oob_skb under
 sk_receive_queue lock.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: billy@starlabs.sg, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <3bbea91b-5b2b-4695-bb5d-793482f05e9f@rbox.co>
 <20240513092426.12297-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20240513092426.12297-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/24 11:24, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Mon, 13 May 2024 11:14:39 +0200
>> On 5/13/24 09:44, Kuniyuki Iwashima wrote:
>>> From: Michal Luczaj <mhal@rbox.co>
>>> Date: Mon, 13 May 2024 08:40:34 +0200
>>>> What I'm talking about is the quoted above (unchanged) part in manage_oob():
>>>>
>>>> 	if (!WARN_ON_ONCE(skb_unref(skb)))
>>>>   		kfree_skb(skb);
>>>
>>> Ah, I got your point, good catch!
>>>
>>> Somehow I was thinking of new GC where alive recvq is not touched
>>> and lockdep would end up with false-positive.
>>>
>>> We need to delay freeing oob_skb in that case like below.
>>> ...
>>
>> So this not a lockdep false positive after all?
>>
>> Here's my understanding: the only way manage_oob() can lead to an inverted locking
>> order is when the receiver socket is _not_ in gc_candidates. And when it's not
>> there, no risk of deadlock. What do you think?
> 
> For the new GC, it's false positive, but for the old GC, it's not.
>
> The old GC locks unix_gc_lock and could iterate alive sockets if
> they are linked to gc_inflight_list, and then recvq is locked.
> ...

The recvq is locked not for all sockets in gc_inflight_list, but only its
subset, gc_candidates, i.e. sockets that fulfil the 'total_refs == u->inflight'
condition, right? So doesn't this imply that our receiver is not user-reachable
and manage_oob() cannot be called/raced?

I wouldn't be surprised if I was missing something important, but it's not like
I didn't try deadlocking this code :)

