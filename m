Return-Path: <netdev+bounces-246816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68703CF1473
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 21:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38B1B3001803
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 20:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EA62ECEBB;
	Sun,  4 Jan 2026 20:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu2Bz+qB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9982ECD14
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767557835; cv=none; b=sVzEKHahztBfDFzMoP5kU+zrIzZPhqT51pQmGSF2MQQoHhGDomHYuVGZ5ZzTC/r/KFJF5ceQ9cwMOAQfFfR5q2YVs3c22sG21k4BPhXTQ7phWPTv5KIf2TA3QRA2YmhhTA6Ky34eU72NR1nfigjrrjcg9kbJJRCBYNcwr10oN9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767557835; c=relaxed/simple;
	bh=jadTXbktdqe3KyhJ1418idK20m+8APHll/1lU3eCcqw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qj/EPPBwA0/HRBJ+0QLE0lshw2W2ERLPyr8duJc95W6sn7ZV3agkGbp/aq5yvcEbVPuKU/AVZLailNAchECekmn/EKrNfMET8JyDU+STN95Q5maenVhUG38oTTF6fykUcz0+QS+JHt9hddMf7/MUxJ4xG7aQS8UoOXxFJFQpk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu2Bz+qB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E0BC4CEF7;
	Sun,  4 Jan 2026 20:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767557834;
	bh=jadTXbktdqe3KyhJ1418idK20m+8APHll/1lU3eCcqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xu2Bz+qBh2gPPNdG7LU4M3RQolyp8MY6Y4gwf2gJ29f2aHs2BoDc/VlFsx18Zq5dk
	 uJNqi7Eo+pgm161z0E/aU70mYCs7mqO8EbG3oaW8kke1D+5bNo5y/eAvyBOtk3ZsBy
	 v6CUBA556z1tCFVLq2zUDOwaAD8TNZnOaUYRKvBHcZgD9NHcmmqMAPVxSm/DGM47Q1
	 ND471/RkCDstTB5dWIy1iJpsioknxmj0clNslxfQYBsNTly5FkPx/bmhRHc7uEPvKd
	 LY6cuub0XU7J9fUjapBgoCahNtjV2jLIA8DI0+KxQaGsA0IpuiLUIaUoeoRxcgZilw
	 VXoqhIok5NNyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B57AB380AA58;
	Sun,  4 Jan 2026 20:13:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] inet: frags: drop fraglist conntrack references
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176755763327.155813.10510428245279091715.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 20:13:53 +0000
References: <20260102140030.32367-1-fw@strlen.de>
In-Reply-To: <20260102140030.32367-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 syzbot+4393c47753b7808dac7d@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Jan 2026 15:00:07 +0100 you wrote:
> Jakub added a warning in nf_conntrack_cleanup_net_list() to make debugging
> leaked skbs/conntrack references more obvious.
> 
> syzbot reports this as triggering, and I can also reproduce this via
> ip_defrag.sh selftest:
> 
>  conntrack cleanup blocked for 60s
>  WARNING: net/netfilter/nf_conntrack_core.c:2512
>  [..]
> 
> [...]

Here is the summary with links:
  - [net] inet: frags: drop fraglist conntrack references
    https://git.kernel.org/netdev/net/c/2ef02ac38d3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



