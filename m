Return-Path: <netdev+bounces-64502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F17D83573C
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 19:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015891F21504
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C99D381DA;
	Sun, 21 Jan 2024 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJKi79lp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920B38380
	for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705861281; cv=none; b=OFH1E814SX//bovu1RBQVTd7sYII4MTude5XqHGIdYWuvi4eGblbEd/dB7F4l4F82Y6qexQfv26HDXAvXKIuUFZ7+RqxTCHF0TGglgbnctQfQXxYNOSM7jv/CaajlvTcfgMf1tp50qDtuyRdh51oU6FmIIGlDMnV44POirGP5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705861281; c=relaxed/simple;
	bh=CZJeid/ERACScUJhcXusaeijXLmvi6Ui+EZmAiq1T3E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AWuaEwS05FaPmT+hJ9NCGsnX/VveyxDVF5IC6RRQKN7q4rB2xa0QW68TA3hQP0rQ7sSfmuMxSx9jT5QO5OD07p1ST858eoI3sBLl039W4JtjrQ8uhvC6WVrK8G0ZBL2X3PhspXk7YX57+hcIE35gXHH0TAOn3WDhMTxuTioGuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJKi79lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF5FFC433F1;
	Sun, 21 Jan 2024 18:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705861280;
	bh=CZJeid/ERACScUJhcXusaeijXLmvi6Ui+EZmAiq1T3E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sJKi79lpHtUouniL+DY4ofzUlus3HqLffxNBZ2Kif2WUL3npOlCZSHn5B8qe0R2hB
	 sqeXFrB/Oodlq+ABQPZfjCjXWWJ30xvS1XB3gTK1fpAlQGefAy0jfER7Dae/KXAirM
	 aiZOzP9cWSZrPwYKdH/HVolpF0FjNB7ti91rKM8rz37+VM/tGz44ph4Z1IHxO1RybL
	 VQiYt8Q+c44phgC0K8Cmdyj0U65yPzJHqOPHY70Eo1nCuQ4FLu5ksMIEo1TOzDzD2B
	 A12Xst1qsBVe+WPl/ebYIrSnXld2P6eDSnGl556Vu/B6TrEfSv8irbVHkkHLkT2/Nr
	 cyMewP94k/Knw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC036D8C970;
	Sun, 21 Jan 2024 18:21:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] udp: fix busy polling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170586128083.13193.4887848149587793890.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jan 2024 18:21:20 +0000
References: <20240118201749.4148681-1-edumazet@google.com>
In-Reply-To: <20240118201749.4148681-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Jan 2024 20:17:49 +0000 you wrote:
> Generic sk_busy_loop_end() only looks at sk->sk_receive_queue
> for presence of packets.
> 
> Problem is that for UDP sockets after blamed commit, some packets
> could be present in another queue: udp_sk(sk)->reader_queue
> 
> In some cases, a busy poller could spin until timeout expiration,
> even if some packets are available in udp_sk(sk)->reader_queue.
> 
> [...]

Here is the summary with links:
  - [v3,net] udp: fix busy polling
    https://git.kernel.org/netdev/net/c/a54d51fb2dfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



