Return-Path: <netdev+bounces-246795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8E9CF130B
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 19:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5385A3037501
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 18:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29842D7810;
	Sun,  4 Jan 2026 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y18UDyaV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0002D781E
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767551167; cv=none; b=n80rggOE0n/fjrVk5lecQ9Wv3rXMZNZM/eD5cFkvaJ1pRDGs7aVvDp2HAbcBSddEYNWabj+TcwY/rTXp6gIOCuJVmd3FRgdITvlQWbzANrDqNt7iFhqs0lwKLyqDQRqoOCaLDlAz/mmVo0jbq4FoxrxMxqKFvSy2+eedZSsKnRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767551167; c=relaxed/simple;
	bh=HIXb1ad2CCUJ43kMt8AJA/ococOBYxO+d8ZeScFhWfc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p5SwS1rb4x9iqLRZHUp8xr9/m+NXrEQOSVUQhxlAsMlZ6vM0fa4R3bqZzTN4YQYesgDVFOglNqVhEjfWnyRrF+ZfTxxyqy8aCKKhYoW0QcZYU/1YV3cY5tjeuV7rQCg/kPetLxtTo/u7PtcMvoDCqwHEr7kYvixxTEk5BmOlt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y18UDyaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F0FC4CEF7;
	Sun,  4 Jan 2026 18:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767551167;
	bh=HIXb1ad2CCUJ43kMt8AJA/ococOBYxO+d8ZeScFhWfc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y18UDyaVxsCKPPKcVOUvL/x7AMLervvQAOtDPr4EdXFUx//tmq4HllSQkIf6upK08
	 /YRG3FDvHqPPSlpFW1JGTiXDbhn7xj4QE2/2hBeuxnKZnadOS+Uk1sP37a9IHO+lEN
	 09VnnqI6+rErafqwt2fgPvAejiBw93/BMAW7U7QFg2MUGJ2zOymYe9ulLeXNeEe4pT
	 Z6MsOw/rfZ4ZrRgR7j3F4yUA2giNu7E+1cAnnfd396sU4qeybVM5+4AReZ/Py8ENpn
	 HtmUDGMEK0rN36mM3WwMs5VvkdHy1NqeSy7w+cOzqjSVitmpHsv3+ahcuD+Sncu/Bc
	 2T2Yfa3+d5anQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8AD380AA4F;
	Sun,  4 Jan 2026 18:22:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] inet: ping: Fix icmp out counting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176755096577.142863.15109109995613331415.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 18:22:45 +0000
References: <20251224063145.3615282-1-yuan.gao@ucloud.cn>
In-Reply-To: <20251224063145.3615282-1-yuan.gao@ucloud.cn>
To: yuan.gao <yuan.gao@ucloud.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, segoon@openwall.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Dec 2025 14:31:45 +0800 you wrote:
> From: "yuan.gao" <yuan.gao@ucloud.cn>
> 
> When the ping program uses an IPPROTO_ICMP socket to send ICMP_ECHO
> messages, ICMP_MIB_OUTMSGS is counted twice.
> 
>     ping_v4_sendmsg
>       ping_v4_push_pending_frames
>         ip_push_pending_frames
>           ip_finish_skb
>             __ip_make_skb
>               icmp_out_count(net, icmp_type); // first count
>       icmp_out_count(sock_net(sk), user_icmph.type); // second count
> 
> [...]

Here is the summary with links:
  - inet: ping: Fix icmp out counting
    https://git.kernel.org/netdev/net/c/4c0856c225b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



