Return-Path: <netdev+bounces-151298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E8E9EDE8F
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C93282B7B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C0216DEA9;
	Thu, 12 Dec 2024 04:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh+rxtdq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3AE16C854;
	Thu, 12 Dec 2024 04:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733978417; cv=none; b=AE9y3LNPzR1+EUVw8JR4IM0ri34R3f9lRb3jRlQhstXznIIopKGO1GTm8pev3mlVQF3RkS0IqyCIrGaFDAimFXd+XF307W1HNQqgzgLckSbTNDuCwvPCANb8gBxov/nxFwCc/i6p8xyf5IGLjIGWLZ2zPKP3RMax1ZOazOdhPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733978417; c=relaxed/simple;
	bh=Hc0wN8Q/gypva6mW0cYS2akiWzqWxnMUsylM/ukbUyg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QiKX5imoZQIwZgDfBNe/mhLsOi1stn2IasEsW+JgGOsszUagamtHSu03+jVMKJk7q+ldHEIfdqiXNbOHJD1dY5S6Vtoss7d9qEgyjpondEX83WTDiu54cjQCABJdiNCDaMDBxvQEjIv4wn4TiON4tSFQd/W1FfZivYiFCYMDFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh+rxtdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E935C4CECE;
	Thu, 12 Dec 2024 04:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733978417;
	bh=Hc0wN8Q/gypva6mW0cYS2akiWzqWxnMUsylM/ukbUyg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kh+rxtdqJLXWAESQQVxwCnMFW5k/zP+ENvGKH5VFOHRj9KEwT3GAuBwAoBSlMnCwM
	 m+GP8oZAhelL/yfB8uYS0CDXQaDLwYTrSjqzbZSyTXx6S9UFvOONtk0v0Tf3FTACSR
	 FaneMVsMswM407tWR5U1dxn+1tjXyEOesYp98r+WDp2nD5/VkxIrHdHn8zckoEpTLT
	 FiOB4bUvduregxyTciy8IobDY0RetawyKLHBpohV+Q3EfmQSb27c60O+c9WWgVuDgu
	 EN2IylB33WsA22+TeTuiEdBXebVX+5j/bkarkCuKr5CQWECrSzTBYcP6SLJTCbRwdZ
	 HH8pX4L8qo3kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7135E380A959;
	Thu, 12 Dec 2024 04:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/sched: netem: account for backlog updates from child
 qdisc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397843308.1849456.7219786231098375481.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:40:33 +0000
References: <20241210131412.1837202-1-martin.ottens@fau.de>
In-Reply-To: <20241210131412.1837202-1-martin.ottens@fau.de>
To: Martin Ottens <martin.ottens@fau.de>
Cc: jhs@mojatatu.com, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Dec 2024 14:14:11 +0100 you wrote:
> In general, 'qlen' of any classful qdisc should keep track of the
> number of packets that the qdisc itself and all of its children holds.
> In case of netem, 'qlen' only accounts for the packets in its internal
> tfifo. When netem is used with a child qdisc, the child qdisc can use
> 'qdisc_tree_reduce_backlog' to inform its parent, netem, about created
> or dropped SKBs. This function updates 'qlen' and the backlog statistics
> of netem, but netem does not account for changes made by a child qdisc.
> 'qlen' then indicates the wrong number of packets in the tfifo.
> If a child qdisc creates new SKBs during enqueue and informs its parent
> about this, netem's 'qlen' value is increased. When netem dequeues the
> newly created SKBs from the child, the 'qlen' in netem is not updated.
> If 'qlen' reaches the configured sch->limit, the enqueue function stops
> working, even though the tfifo is not full.
> 
> [...]

Here is the summary with links:
  - [v3] net/sched: netem: account for backlog updates from child qdisc
    https://git.kernel.org/netdev/net/c/f8d4bc455047

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



