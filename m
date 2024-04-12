Return-Path: <netdev+bounces-87236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B94A8A23DE
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 04:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEFA1C21FEE
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 02:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942E314006;
	Fri, 12 Apr 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t97wcuWK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA3134B6
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890231; cv=none; b=QAjbikjeLWj6ff3Yi2EjZXjrqX+sBEc2cQBHJ5mXdH8YyR37Kt5VIUXQ5GEW3mOWbMWcnXDU91Tzhx0uqGBMiQXHZnilN4cdq/bAc+2Jgu+uf3asJ1OOWDCDbUUK1HoFzMxvHPNlrxDbMFnFqgLJ9sqzTyWLMPZIgGrrtDidHEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890231; c=relaxed/simple;
	bh=EAuFEjXf5dNYv5WrwYA5rr39KXJofN2Le4hqggF2Dm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UL+vGyir6LW6rPqEAF7gGqXnvB/pAav1LzWZUMsqSPKOXrN+3PvJmVzNxRL23ekUXjH9kJqZ+TrTGBptj7D8WiLBzjNEFyDYCVXAAy74937+871S1iyK5ipT7bfL0mD1ZyClx7TdeY0movgPUItnMUH0ieJv4al/yuZ3eJ9QhP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t97wcuWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE7D5C2BD11;
	Fri, 12 Apr 2024 02:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890230;
	bh=EAuFEjXf5dNYv5WrwYA5rr39KXJofN2Le4hqggF2Dm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t97wcuWK/R1pgpRHwBfk1gstMDBuUY7N+K6mZ5nHZmQ8+aQF7BjIvIUL5bmjdL7et
	 hJAqlaKwpZ10o1HswbNtkaTqAnEwXsQL26bXy95s6p/nMLKfnjGet5BgqCWoFTStWF
	 wzBieFpFU7VvIvu7CYks6DCJIvidyv6k0SMPinfeZZ7IcTqoI6/+FCSPLfeibQU0yz
	 TV+f+rQSnah+I3MZiZkzZsUEr4lx0ePiGKcz0AiIfIUAxrrMGP+37spSvro/5d/Fhh
	 +1JgJk4xLRZ7xXbXRJ50HC4fEdm3WGP0J49ecsnNlraYsMmC7iJ85fml8Sxsz/tI8s
	 Yg0Ob2udYjoPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC3DAC4339F;
	Fri, 12 Apr 2024 02:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mpls: no longer hold RTNL in
 mpls_netconf_dump_devconf()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171289023083.15367.14083081896314123722.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 02:50:30 +0000
References: <20240410111951.2673193-1-edumazet@google.com>
In-Reply-To: <20240410111951.2673193-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Apr 2024 11:19:50 +0000 you wrote:
> - Use for_each_netdev_dump() to no longer rely
>   on net->dev_index_head hash table.
> 
> - No longer care of net->dev_base_seq
> 
> - Fix return value at the end of a dump,
>   so that NLMSG_DONE can be appended to current skb,
>   saving one recvmsg() system call.
> 
> [...]

Here is the summary with links:
  - [net-next] mpls: no longer hold RTNL in mpls_netconf_dump_devconf()
    https://git.kernel.org/netdev/net-next/c/e0f89d2864b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



