Return-Path: <netdev+bounces-157168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4438DA09227
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728FA16867B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D912120B80D;
	Fri, 10 Jan 2025 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="YmVwjpPz"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D078C91
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516055; cv=none; b=n4h+jrtjUvcBAhvWVx5IrMI9tiU/LzdQlszZLXKzTxrAi5WOSkTXVmX0Qw/z3Q8AD38tNnYOPnhZvitDgNkxqpeo41vCnBDQaBiPThQOrdgO0uIsv2xOQKP7XPRHb93De+8UpBnYCitQ+jH6S5a21g4yfrz9cy/W7h3TZsWKvtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516055; c=relaxed/simple;
	bh=z7gz+i2HhxebmfFhhX9sC4FJ/071pLo7SmBEwtibi68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVbrMy+jvNRopkSzKPeZitksNZLpqDLTfhb1jLoHXpbN/dUVoirhjT+mZ6cgoDdYYvaQe/lFppwd28z2yH5UVE1zjregYEHM2WYIMeu4Vc/81kAijOhBnZB7JM1M41MEmg9wbF7JGz3aJjwoZdBnP3DTuf1EGpcjYNrxoGxMFhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=YmVwjpPz; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1736515547;
	bh=z7gz+i2HhxebmfFhhX9sC4FJ/071pLo7SmBEwtibi68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YmVwjpPzj8rpkUIiGhoYTLSt5AnghPaJGqzuPfN/uovxMB3X8lBP4PQkASyZ6oVR8
	 7krVtXa1Kd7152Ve9jVEEXzeweBoNpCDhcGRLikBcZmzuzlFs7A1ZgZbtxlxcl3STd
	 9iSGVvSaQxR4ZLrsITqIZeMRWyIgJPQofwy52kK60w6Dl8b2HWYbw69MJmVo1kv59Q
	 MayV/a4Y+LRu7Rut55jaaF5bH/uFiQ8I7hrY69hTzVFzZYwmVk63RxE+qKSFlqdVNd
	 gTwXdTdbbhJqsG2EUkXYj1HZemUT5VlDjbj7nuz6IrHq+0iAZVuKzjFzvZ9n8ELbUR
	 S3oDYzDih/Qbw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id D39816000C;
	Fri, 10 Jan 2025 13:25:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 983D9200473;
	Fri, 10 Jan 2025 13:25:18 +0000 (UTC)
Message-ID: <48e9bf0a-3275-4d2c-84ae-9bc1163ab8cb@fiberby.net>
Date: Fri, 10 Jan 2025 13:25:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: sched: refine software bypass handling in tc_run
To: Xin Long <lucien.xin@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Shuang Li <shuali@redhat.com>, network dev <netdev@vger.kernel.org>
References: <b9e81aa97ab8ca62e979b7d55c2ee398790b935b.1736176112.git.lucien.xin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <b9e81aa97ab8ca62e979b7d55c2ee398790b935b.1736176112.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for the late response, it has been a busy first week back, too many
operational issues with devices in our network running crappy vendor images.

On 1/6/25 3:08 PM, Xin Long wrote:
> This patch addresses issues with filter counting in block (tcf_block),
> particularly for software bypass scenarios, by introducing a more
> accurate mechanism using useswcnt.
> 
> Previously, filtercnt and skipswcnt were introduced by:
> 
>    Commit 2081fd3445fe ("net: sched: cls_api: add filter counter") and
>    Commit f631ef39d819 ("net: sched: cls_api: add skip_sw counter")
> 
>    filtercnt tracked all tp (tcf_proto) objects added to a block, and
>    skipswcnt counted tp objects with the skipsw attribute set.
> 
> The problem is: a single tp can contain multiple filters, some with skipsw
> and others without. The current implementation fails in the case:
> 
>    When the first filter in a tp has skipsw, both skipswcnt and filtercnt
>    are incremented, then adding a second filter without skipsw to the same
>    tp does not modify these counters because tp->counted is already set.
> 
>    This results in bypass software behavior based solely on skipswcnt
>    equaling filtercnt, even when the block includes filters without
>    skipsw. Consequently, filters without skipsw are inadvertently bypassed.

Thank you for tracking it down. I wasn't aware that a tp, could be used by multiple
filters, and didn't encounter it during my testing.

> To address this, the patch introduces useswcnt in block to explicitly count
> tp objects containing at least one filter without skipsw. Key changes
> include:
> 
>    Whenever a filter without skipsw is added, its tp is marked with usesw
>    and counted in useswcnt. tc_run() now uses useswcnt to determine software
>    bypass, eliminating reliance on filtercnt and skipswcnt.
> 
>    This refined approach prevents software bypass for blocks containing
>    mixed filters, ensuring correct behavior in tc_run().
> 
> Additionally, as atomic operations on useswcnt ensure thread safety and
> tp->lock guards access to tp->usesw and tp->counted, the broader lock
> down_write(&block->cb_lock) is no longer required in tc_new_tfilter(),
> and this resolves a performance regression caused by the filter counting
> mechanism during parallel filter insertions.

You are trying to do two things:
A) Fix functional defect when filters share a single tp
B) Improve filter updates performance

If you do part A in a minimalistic way, then IMHO it might be suitable
for net (+ stable), but for part B I agree with Paolo, that it would
properly be better suited for net-next.

I focused my testing on routing performance, not filter update performance,
I also didn't test it in any multi-CPU setups (as I don't have any).

The static key was added to mitigate concerns, about the impact that the
bypass check would have for non-offloaded workloads in multi-CPU systems.

https://lore.kernel.org/netdev/28bf1467-b7ce-4e36-a4ef-5445f65edd97@fiberby.net/
https://lore.kernel.org/netdev/CAM0EoMngVoBcbX7cqTdbW8dG1v_ysc1SZK+4y-9j-5Tbq6gaYw@mail.gmail.com/

