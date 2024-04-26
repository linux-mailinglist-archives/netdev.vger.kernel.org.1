Return-Path: <netdev+bounces-91630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FB18B3407
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 11:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960292849DE
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FD213E8AE;
	Fri, 26 Apr 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6/ydt0k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CFC22338
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123828; cv=none; b=rp+XJ9z4mP6e7bA4gWbSQtX6NJ8FBdGv9RYOnOcsE5HzEBZrOjrj9pIJqXXWdNvGwvb4yxMfyKoXFbLiFJV8x8xPiP8D5LTfnJi2AUBBoUIaYcZT/Jmc1ZUNGUNoYGK/Psz0UFqwJXAHavpz2QCoceZfn0hurV63ZzbdgcOpkyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123828; c=relaxed/simple;
	bh=5l4cHxFPPHsJVqxn+VtaNyumDtc+qeAwBENLUCbEIJg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IU8drH9MG8+rAGMjw0IpmVi9Qd+ZbnsTscdqI6eSjZ1CESYT/nyWJCu5Lf+wLjJ4rfp0gsLQ9W6xLdTen0+eTKnPprC9aJqPUa6cstc50EJCWWeRMc97Zl/VjTFRkQ5oaOOTNuq8STKVL6W6VwZlhX9y7ttSWL0/3UnJp86I60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6/ydt0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 415F4C2BD10;
	Fri, 26 Apr 2024 09:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714123828;
	bh=5l4cHxFPPHsJVqxn+VtaNyumDtc+qeAwBENLUCbEIJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t6/ydt0kPo4GEq8dMcaLKnblgEqQPQHDQUSoxAcZrlolg4Ec4ihH0Vk2ag26uB3Cx
	 tDxfhVgV0L1RLtCmuwD2zfnXQbqMj3F/2H/j/lMfUQJX+pLydZqQioQ7y36uPTZk0d
	 2jis+FqonERNnk+OIh3vr4JQDKUcxcm9TjPknTnEjjE/+2Bz817g1HmI6abSGg38Z5
	 hSSgVSV0RG+tjqLwV53REF46YIaAhHUidQR+gG8HPxtMGbC8LHdHE+U6J4twad1NZ2
	 a10zHzeqw9lC0pcQ6qbOzbyUovedW7YjQTMxT7ezH57gmSN7DPPiSmaR/Klm1GFmpG
	 xKlUyW0tf3gZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35428C54BA9;
	Fri, 26 Apr 2024 09:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/sched: fix false lockdep warning on qdisc
 root lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171412382821.27484.12725253452336970436.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 09:30:28 +0000
References: <7dc06d6158f72053cf877a82e2a7a5bd23692faa.1713448007.git.dcaratti@redhat.com>
In-Reply-To: <7dc06d6158f72053cf877a82e2a7a5bd23692faa.1713448007.git.dcaratti@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: edumazet@google.com, jhs@mojatatu.com, maxim@isovalent.com,
 victor@mojatatu.com, netdev@vger.kernel.org, renmingshuai@huawei.com,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, xmu@redhat.com, cpaasch@apple.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 18 Apr 2024 15:50:11 +0200 you wrote:
> Xiumei and Christoph reported the following lockdep splat, complaining of
> the qdisc root lock being taken twice:
> 
>  ============================================
>  WARNING: possible recursive locking detected
>  6.7.0-rc3+ #598 Not tainted
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/sched: fix false lockdep warning on qdisc root lock
    https://git.kernel.org/netdev/net-next/c/af0cb3fa3f9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



