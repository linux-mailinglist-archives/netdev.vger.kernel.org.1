Return-Path: <netdev+bounces-96717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0602E8C74AD
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 12:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24F81F21385
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C13143C4B;
	Thu, 16 May 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="tYiGWRT4"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F25143887
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715855647; cv=none; b=XCKzkw9ai8qNmo5VZHGmkKq7ZmhVeUWPMYd0dcBuRojQ9y8baoNfelHpVin52WRGPMiuTVLtcFHyCn/lEBsjudsOMlt1BsS63ouc/QPe11TImPOon8lFC4U706qXask5+p3lTnUSKi5KASJSfKj+pFNkr4JgR/nJVo5y42xbadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715855647; c=relaxed/simple;
	bh=961T/RanQUtQoII4AewyFJK2GnDQIgd+QTQQEmJEsvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p21O6Pxj30imHOYfqsHZKVUuffQaJabEM9NO2xOWZnIAPmXr1fsjPM+9ciQLR1ejSwJE/sLFChItmTsP/LDN0ml6gKJpuoLfOPIqAAWcDQ3qNdOkHgvblf4phvYcl6kzoIEehPVUm2Khj9zNCWs1KkgAFvQidEXI5FHiYY3MSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=tYiGWRT4; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s7YQx-002SbY-0f; Thu, 16 May 2024 12:33:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=UBiCkpCK3e4RKmgLrw+DLJQBeEQ5nOKn7TotazOpKS8=; b=tYiGWRT4pr4R0zdw+Z+o7mjwOH
	mCao8R6qo/HoI/upDntZYdsbYC5QW+HnPxvT1edqyP+XVq94VExHQ0AGZWbkSYP+6awroGs2tJOEX
	sUVQgWQN0evbwCMOpQiIrrHlaLCvvBSTlU8UEeCdZ4AD0lnH/oZkABHB0QfgAGSzDvTGseC8RQ335
	AB/kfPOiJWlrdwgUV1tVPOLJQqdnfQIXa1IYkj2/fMtIhF/+YgO3Jbh8KFSAH8rt65BXzOoBx1Kwd
	siEc/ixLPw1WMJMGkV8BivnKZ1Tu5foGh3Xr3c4zWbHnzDmswFhRB5ygsfjN/fD3/jvkzPZotmKyg
	ZMi9M8gw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s7YQv-0007JM-UL; Thu, 16 May 2024 12:33:58 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s7YQb-000EzL-4W; Thu, 16 May 2024 12:33:37 +0200
Message-ID: <0828c5fb-1e56-4bdf-b7dd-7ec4d7310c72@rbox.co>
Date: Thu, 16 May 2024 12:33:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net 1/2] af_unix: Fix garbage collection of embryos
 carrying OOB/SCM_RIGHTS.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
References: <c6eb5987-4ffa-47cf-a0c7-dcc7b969d2ca@rbox.co>
 <20240515133547.47276-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240515133547.47276-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/24 15:35, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Wed, 15 May 2024 11:34:51 +0200
>> On 5/15/24 02:32, Kuniyuki Iwashima wrote:
>>> ...
>>> The python script below [0] sends a listener's fd to its embryo as OOB
>>> data.  Then, GC does not iterates the embryo from the listener to drop
>>> the OOB skb's refcount, and the skb in embryo's receive queue keeps the
>>> listener's refcount.  As a result, the listener is leaked and the warning
>>> [1] is hit.
>>> ...
>>
>> Sorry, this does not convey what I wrote. And I think your edit is
>> incorrect.
>>
>> GC starts from the in-flight listener and *does* iterate the embryo; see
>> scan_children() where scan_inflight() is called for all the embryos.
> 
> I meant the current code does not call skb_unref() for embryos's OOB skb
> because it's done _after_ scan_inflight(), not in scan_inflight().

Right, I think I see what you mean.

>> The skb in embryo's RQ *does not* keep the listener's refcount; skb from RQ
>> ends up in the hit list and is purged.
> 
> unix_sk(sk)->oob_skb is a pointer to skb in recvq.  Perhaps I should
> have written "the skb which was in embryo's receive queue stays as
> unix_sk(sk)->oob_skb and keeps the listener's refcount".

I wholeheartedly concur with you!

>> It is embryo's oob_skb that holds the refcount; see how __unix_gc() goes
>> over gc_candidates attempting to kfree_skb(u->oob_skb), notice that `u`
>> here is a listener, not an embryo.
>>
>> I understand you're "in rush for the merge window", but would it be okay if
>> I ask you not to edit my commit messages so heavily?
> 
> I noticed the new gc code was merged in Linus' tree.  It's still not
> synced with net.git, but I guess it will be done soon and your patch
> will not apply on net.git.  Then, I cannot include your patch as a
> series, so please feel free to send it to each stable tree.

All right, no problem. Does it mean you'll be posting PATCH 2/2 ("af_unix:
Update unix_sk(sk)->oob_skb under sk_receive_queue lock") to stable(s)?

Moving on to the New GC: Python test from this patch shows that the New GC
is memleaking in pretty much the same fashion.

$ grep splat /proc/net/unix
$ ./unix-oob-splat.py
$ rm unix-oob-splat
$ ./unix-oob-splat.py
$ grep splat /proc/net/unix
0000000000000000: 00000002 00000000 00000000 0001 02     0 unix-oob-splat
0000000000000000: 00000002 00000000 00000000 0001 02     0 unix-oob-splat
0000000000000000: 00000002 00000000 00010000 0001 01  6643 unix-oob-splat
0000000000000000: 00000002 00000000 00010000 0001 01  2920 unix-oob-splat

I've posted a patch:
https://lore.kernel.org/netdev/20240516103049.1132040-1-mhal@rbox.co/

I tried to align with your version of the commit message, but feel free to
chime in. Also, I took the liberty to introduce a small sanity check. Would
you prefer if I dropped this hunk or possibly made it a separate patch?

Thanks!


