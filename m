Return-Path: <netdev+bounces-211985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D107B1CEA4
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 23:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282C918C597B
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 21:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939EB221286;
	Wed,  6 Aug 2025 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="TR2mvOlj"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5671721ABC8
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517103; cv=none; b=bgFjjDIPMbX7QejMkNNXBGiuSZUhyiYyHMFPe/xXpp+n1wM26MNwpKCerVPsUKIwiSemQPXm8d2+tKrg+uPWmKzx9KaqdyWaqsNFBjDQlNJ+YLtVrtxuHPms36oSLIKVzrLzvFBiE1gdGBhtD145jT3nNCbh6eK/bAuaLXI2WjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517103; c=relaxed/simple;
	bh=XG2iaiadFFnq9XwRGdlA5z9IM93Tsw6Fk02sG4YudNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0/6HikyD/BdPY/IhtoO+cu2pzRZpfgeHXPJLW5ugs5uyOP1g88QsQ9ICdYat7fS0v7ZOKra9TH7bV7sYU1eUKzblU6fSuDuZQvYcd7kGWgxbrygwy6reXlG/pwfiIoLQtyGAQd9CrAX9wy00E3MPhzWAQA1blf7FWslR/lnCJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=TR2mvOlj; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1ujlTy-00EXbe-Nw; Wed, 06 Aug 2025 23:15:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=JEAvvLpXo03U5nTOjudQP/w82ZK7J9xTsTdVQJuUPT4=; b=TR2mvOlj/ssM041N+Pq0I/2VhP
	ZYKARAxo1LGGfMByB7Xg5O/GSN6ltAq2BPKvnxsFNp9DUuSV9TVlK+Dank/E/2ZY+cBgG47o4KdUF
	tEnMOueLFj2AXzcjMQUHyYHYDhJ386E37KECg3w91t5YP8McSQi+LXzH/tAJvH9kGNstTpScwigzX
	rkP6pkmG+IcqQFRdGi7JpGFtvoyQdMj3xUHjXFT1cC0zEltgcKQZ8HZXgkndNXoOAU583mqNNAn47
	/K99dHNuyrUSpZzMU0pzEkA6fjuiEbjmNic7KNFqloTwQ4LIFpzL3Umz69HYaSl4x4DePmsoaX3pO
	Nx4ZbeDw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1ujlTx-0000al-Fo; Wed, 06 Aug 2025 23:15:33 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1ujlTn-00BdRi-Ua; Wed, 06 Aug 2025 23:15:24 +0200
Message-ID: <54f5b076-4648-4d2b-b50b-e775c4ddb4bf@rbox.co>
Date: Wed, 6 Aug 2025 23:15:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] kcm: Fix splice support
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>,
 Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250725-kcm-splice-v1-1-9a725ad2ee71@rbox.co>
 <20250730180215.2ad7df72@kernel.org>
 <b6a2219b-32dd-4bb6-b848-45325e4e4ab9@rbox.co>
 <20250804165155.44a32242@kernel.org>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20250804165155.44a32242@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/25 01:51, Jakub Kicinski wrote:
> On Sun, 3 Aug 2025 12:00:38 +0200 Michal Luczaj wrote:
>> On 7/31/25 03:02, Jakub Kicinski wrote:
>>> On Fri, 25 Jul 2025 12:33:04 +0200 Michal Luczaj wrote:  
>>>> Flags passed in for splice() syscall should not end up in
>>>> skb_recv_datagram(). As SPLICE_F_NONBLOCK == MSG_PEEK, kernel gets
>>>> confused: skb isn't unlinked from a receive queue, while strp_msg::offset
>>>> and strp_msg::full_len are updated.
>>>>
>>>> Unbreak the logic a bit more by mapping both O_NONBLOCK and
>>>> SPLICE_F_NONBLOCK to MSG_DONTWAIT. This way we align with man splice(2) in
>>>> regard to errno EAGAIN:
>>>>
>>>>    SPLICE_F_NONBLOCK was specified in flags or one of the file descriptors
>>>>    had been marked as nonblocking (O_NONBLOCK), and the operation would
>>>>    block.  
>>>
>>> Coincidentally looks like we're not honoring
>>>
>>> 	sock->file->f_flags & O_NONBLOCK 
>>>
>>> in TLS..  
>>
>> I'm a bit confused.
>>
>> Comparing AF_UNIX and pure (non-TLS) TCP, I see two non-blocking-splice
>> interpretations. Unix socket doesn't block on `f_flags & O_NONBLOCK ||
>> flags & SPLICE_F_NONBLOCK` (which this patch follows), while TCP, after
>> commit 42324c627043 ("net: splice() from tcp to pipe should take into
>> account O_NONBLOCK"), honours O_NONBLOCK and ignores SPLICE_F_NONBLOCK.
>>
>> Should KCM (and TLS) follow TCP behaviour instead?
> 
> I didn't look closely, but FWIW - yes, in principle KCM and TLS should
> copy TCP.

Ugh, so this KCM patch is incorrect. Sorry, I'll submit a follow up
tweaking KCM and TLS, as suggested.

Note about SPLICE_F_NONBLOCK: besides AF_UNIX, it is also honoured in
AF_SMC and tracefs.


