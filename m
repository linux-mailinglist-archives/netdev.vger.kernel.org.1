Return-Path: <netdev+bounces-225735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0078B97D73
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632553B196E
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81D715C0;
	Wed, 24 Sep 2025 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUstK6m4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E227442
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758672031; cv=none; b=DVuFTZJMZSYwN3FX2rWGzYrU3UomB4HkRp/8iFMXM6FU54kvWLzgA9Zjy8sWfVvIaRbYHDFEb4Wbqt+RK0wMTPNtbpxTel4g06wn6ZbOFgcqRrWIql5Or2i/U5awVmxJeIqFAJKGL+KATyOanuE2umc7p1J3ZkAvU5ght0J3hOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758672031; c=relaxed/simple;
	bh=Bh1elcRkaH5gwMvLpSFSPt8sA+2L4oMwoU03xmeUem4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qiZLAoz6Z19LmTPRLW5/ahm24Tm65w3SD0pmZBf/HUjjux7slskSeU4Rfn6zWTD0coQDKqAKNOiIDlwhr8xpPVYG4fHffidMYf522NF2oZG9ywiUL9iWtc9nExRnctSyYBHwkvABsiIF0ffASqA62yD0YFjGckt2BcH6BKjH5aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUstK6m4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D6CC116B1;
	Wed, 24 Sep 2025 00:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758672031;
	bh=Bh1elcRkaH5gwMvLpSFSPt8sA+2L4oMwoU03xmeUem4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GUstK6m4aUoMHW1dCjPRrXIyw6iiTS5sibHUC1q4BenzIyWCFqpdqkcPkB7OB+Q2N
	 Ljpoe8eLhjH92Ygmd8fcO6IbyKp2O1qnbKAGr23TT4bgdT4QfodetGvetSOn/rcfon
	 q5tbCPcPZPcoYlFgIbkoYfeRJ67EFVgmIy+NG0LYFl0nlOzmC306cg9CmHOnGSm0o9
	 YwnkiA78Ibvf+t10VUDhKHSwB8RKEkJNNHZD1XufVHuK6tGqHXJ6r1W98cBfpZZUHs
	 ayNnBEAfGsFplz7GGNVZi6o7lYwreJBLFa0tPPfMuV4fbiiWvjGq6Dn3YHgcHtXFNS
	 sE/5oNXzskzMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FE739D0C20;
	Wed, 24 Sep 2025 00:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] udp: remove busylock and add per NUMA queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175867202799.1967235.12420154239647070766.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 00:00:27 +0000
References: <20250922104240.2182559-1-edumazet@google.com>
In-Reply-To: <20250922104240.2182559-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Sep 2025 10:42:40 +0000 you wrote:
> busylock was protecting UDP sockets against packet floods,
> but unfortunately was not protecting the host itself.
> 
> Under stress, many cpus could spin while acquiring the busylock,
> and NIC had to drop packets. Or packets would be dropped
> in cpu backlog if RPS/RFS were in place.
> 
> [...]

Here is the summary with links:
  - [v4,net-next] udp: remove busylock and add per NUMA queues
    https://git.kernel.org/netdev/net-next/c/b650bf0977d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



