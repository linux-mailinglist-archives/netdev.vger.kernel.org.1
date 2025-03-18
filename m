Return-Path: <netdev+bounces-175719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54B9A673E9
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5783AE3C6
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0570320C03C;
	Tue, 18 Mar 2025 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5AWgMCF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D620AF7D
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301000; cv=none; b=C/zKhVmJlaobtylk9TzXmIdO7u/Wnpoz8K3qCpHUFBDYeVggfyvbU1hSeMTdHSH6zCW+JKqBggCId6SLRD3881FUIq8iPsvQuYGnOTuMfeUJsQIyuhJhj6cbMYouAgsJmiIXnLk/UVBpIbWNFV1vWplBps81Wik+pdnNgYSJnn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301000; c=relaxed/simple;
	bh=QnsRi0UmpjCDlH5gXFeFkbN7N5Y9QX1ZCTxSSVLJObM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lBPBDpvjRc63grg1aN1rnUyLwc4kull3s0TtFu73qMXkzeR2suPQn5Oyg9PO05cVoD994fGJgRnhJOqgToW05ZPGGQOn9GOnWrUQI+Z6RBYtRB2JbRbM5QNEZhYlabcwuG54rs3YOgqpNSCtzTYERHxmgBxEDlUGrbe7M0Wu5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5AWgMCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49070C4CEDD;
	Tue, 18 Mar 2025 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742301000;
	bh=QnsRi0UmpjCDlH5gXFeFkbN7N5Y9QX1ZCTxSSVLJObM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z5AWgMCFczlij8I3gckPSfvHhn10jSteyQrw+LxZyg5o2wTql7nRiONw1l2b0s2fA
	 92fp30FwT2mOLj0zbOOZ0SDKyPq4xYxW4VQHHjXeLF/jEuq40bXj/sO0TaL8nyyeAX
	 vUXegA+qq0XrsgvmXKrhkgVvTZuq/MXxEAbOuDY9LBvAZ21dLDD9m10WY4o70Ysi+C
	 U6DVKbP0ZjaDsFvgmdFG7aP0rx9mL0ySOb6r99RNpowInnw5BxHQ2hh3uMwONfXYOa
	 0TDwU5bchH2cDuni5mzEQguw6DFrElaSssf/FoMH70mqjTObF6trkZzyLPop4tj3ek
	 VzssDktxQqauw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBD66380DBE8;
	Tue, 18 Mar 2025 12:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] inet: frags: fully use RCU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174230103577.292821.1648279516797618665.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 12:30:35 +0000
References: <20250312082250.1803501-1-edumazet@google.com>
In-Reply-To: <20250312082250.1803501-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 08:22:46 +0000 you wrote:
> While inet reassembly uses RCU, it is acquiring/releasing
> a refcount on struct inet_frag_queue in fast path,
> for no good reason.
> 
> This was mentioned in one patch changelog seven years ago :/
> 
> This series is removing these refcount changes, by extending
> RCU sections.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/4] inet: frags: add inet_frag_putn() helper
    https://git.kernel.org/netdev/net-next/c/ae2d90355aa5
  - [v2,net-next,2/4] ipv4: frags: remove ipq_put()
    https://git.kernel.org/netdev/net-next/c/a2fb987c0ecf
  - [v2,net-next,3/4] inet: frags: change inet_frag_kill() to defer refcount updates
    https://git.kernel.org/netdev/net-next/c/eb0dfc0ef195
  - [v2,net-next,4/4] inet: frags: save a pair of atomic operations in reassembly
    https://git.kernel.org/netdev/net-next/c/ca0359df45a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



