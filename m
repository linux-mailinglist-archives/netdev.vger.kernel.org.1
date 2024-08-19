Return-Path: <netdev+bounces-119786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C65956F42
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B232819F8
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6F4139D04;
	Mon, 19 Aug 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDQ8zKTz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069AE1386B3
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082630; cv=none; b=mLdE98XBKXbpUbs1+39B2c+0DjnX8Fed0gNqlWvlNiDzjCRrho9QnNpbLDoya/AAaQHIwouILBnms5N5AegWo/hOHTNXkGXAcBeozen54JPdYdXgDWRjfDBYNkBcUNuqzX5w1/A8+hb/t/zWTm8hgjzrc6N02kWyE/EV23/cdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082630; c=relaxed/simple;
	bh=jX47WnUBvD4QWf4im+oybgMos8JXpV99aByVy1ZETgg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XR9zZSCbauk7RfIaxL9+s3LRkff6xFLV6azcjq2TZabBqJp3QDQe8A5DFVK+ETVh3k8vY0eQvCvdofxDLOrFQCkQ92EUUizndF/GWSCDA4F9UYQ6Tlb3zCCg9yK5l3SAWq1GRQi3SYeyRq2KqIFZ/e+odQD+RDmdcUw2oaDKHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDQ8zKTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81633C4AF11;
	Mon, 19 Aug 2024 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724082629;
	bh=jX47WnUBvD4QWf4im+oybgMos8JXpV99aByVy1ZETgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DDQ8zKTza7pfSkTnFEkeCzv41deHK+0Y1Wfg1iAoguW6sV1rV6sEQNiZK+tk7V9hp
	 1MleRYdSEzQtCe1p4yJDbsHJndsPgMr9kWv1XE57MTTB7n98zMmHsoEyPCnx0ENIrB
	 tI+3SuoCHfF6ymw10dzmB6YKjJnMX2IXUJyF9YXtOCERvO5CmVRHA3j3v6eeZbiln8
	 scCjm5krH+7g7Bv8RQUqAKFuYYtSc/h7MOWHdjCzA8SmbDiISFZi9+hdT8BLzzRoQP
	 8KPsmR9AbFSI/KTVdjM4/rG6ih407sr773OAaN8s4quBu2YssoEyDAJuZhzQ57zBeN
	 R5Hz4zTK3OmJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F553823097;
	Mon, 19 Aug 2024 15:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: prevent concurrent execution of tcp_sk_exit_batch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172408262901.574380.11397321828378391687.git-patchwork-notify@kernel.org>
Date: Mon, 19 Aug 2024 15:50:29 +0000
References: <20240812222857.29837-1-fw@strlen.de>
In-Reply-To: <20240812222857.29837-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, kuniyu@amazon.com,
 kerneljasonxing@gmail.com,
 syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Aug 2024 00:28:25 +0200 you wrote:
> Its possible that two threads call tcp_sk_exit_batch() concurrently,
> once from the cleanup_net workqueue, once from a task that failed to clone
> a new netns.  In the latter case, error unwinding calls the exit handlers
> in reverse order for the 'failed' netns.
> 
> tcp_sk_exit_batch() calls tcp_twsk_purge().
> Problem is that since commit b099ce2602d8 ("net: Batch inet_twsk_purge"),
> this function picks up twsk in any dying netns, not just the one passed
> in via exit_batch list.
> 
> [...]

Here is the summary with links:
  - [net] tcp: prevent concurrent execution of tcp_sk_exit_batch
    https://git.kernel.org/netdev/net/c/565d121b6998

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



