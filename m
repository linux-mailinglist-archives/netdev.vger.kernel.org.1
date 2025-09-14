Return-Path: <netdev+bounces-222869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929C7B56B74
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 21:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C887F189CFD7
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 19:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A152E0406;
	Sun, 14 Sep 2025 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDJGkzHs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC43230BE9
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757876421; cv=none; b=sShQh6p7WXtu/bbgT1zMKdSIm9uz+BNnAnEJ2y3f9NxqH8EbAvynIiRlr9HReGD8wUEuMiXofYZdJt8KGK3IdwatWrk8m0SdXNUUrtXXQ6hPv/ZfrcYNDoDnOdESWZIxWTtr1BzDOS3p2oA/iUI3em4UDlm7LRLY2iGrnGQWJ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757876421; c=relaxed/simple;
	bh=Bj3ZYrMHHPqh4jKXqmiaHt7y0LMaPjkAejSpnRuNXuU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bkyZRPTjFgcg6wnFIW/qxNL9fGkHbvdpwvb/o1JKW/TjdsTNnOA6do5uF3yOQtjpXrV0KshAw5bdApOCNz1IsGbX08xde4hm1zG1nEtRuhLJy/GP8iS+5QjNAht4MpcpdF34a2mnaampiiotbyuld5o9fc0hEPKa8B+eqNY0ilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDJGkzHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49903C4CEF0;
	Sun, 14 Sep 2025 19:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757876420;
	bh=Bj3ZYrMHHPqh4jKXqmiaHt7y0LMaPjkAejSpnRuNXuU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rDJGkzHsjhYZ3wg2Tw00OBeCmtV/65Rha78pUOR8LQ0FOeDPdvl2L35eYxDw/dmuM
	 sWAs8uMGLg+YGfHgIne6cd0zE+V48LESBRHw7bfQONx8QqH+Kqtlb3XJrbp/LeFCSF
	 W1Ye6+QTrSrc8QMtibxnkuGw1OhtdaEOjRMd4AxgxWaFffqHqUiO6NPrR3U8SweBEo
	 aY9S5AB+r5QbhAvGWkDgD3qhbjxoD2nyOYMwPa653wLR/QToS0ieSAn4vWG87Ramuj
	 81HMMCNJrydKDKuh+FO2HTW+pw7+5bAi+2pQ8LnqKdr6x1oq5wcVnPAdklJ0wPlNn8
	 tFZCsk4Xr9hGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C8539B167D;
	Sun, 14 Sep 2025 19:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: use NUMA drop counters for
 softnet_data.dropped
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175787642178.3528285.12955350723496612407.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 19:00:21 +0000
References: <20250909121942.1202585-1-edumazet@google.com>
In-Reply-To: <20250909121942.1202585-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, willemb@google.com, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Sep 2025 12:19:42 +0000 you wrote:
> Hosts under DOS attack can suffer from false sharing
> in enqueue_to_backlog() : atomic_inc(&sd->dropped).
> 
> This is because sd->dropped can be touched from many cpus,
> possibly residing on different NUMA nodes.
> 
> Generalize the sk_drop_counters infrastucture
> added in commit c51613fa276f ("net: add sk->sk_drop_counters")
> and use it to replace softnet_data.dropped
> with NUMA friendly softnet_data.drop_counters.
> 
> [...]

Here is the summary with links:
  - [net-next] net: use NUMA drop counters for softnet_data.dropped
    https://git.kernel.org/netdev/net-next/c/fdae0ab67d57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



