Return-Path: <netdev+bounces-99220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C5D8D4262
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC9C28683D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D3F8465;
	Thu, 30 May 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfOdzaRV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A396AB8
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717029033; cv=none; b=CyNwuE30kHc6mLQRlFdwUJOz26f3t7I7W1clVe+UpcIPcbIRjveqpuv4DNRHEFu1ak0sJ2h68u+/bXxFgN5Oi8/QJcM9fuLa9sAwptfwUrGLoy/MuM7ViSjgXn/3iy9LdaRp6O0n/wP0VGyjcjPMquIoKYKBbnZFxv8fiSPt4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717029033; c=relaxed/simple;
	bh=jbY6kPTOWiY3QNQmc2zKELSLwprEdsHMoP85XJ01ngI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JnV6e5XjdNWDPqupOf/Pst0E/sCu3r+tp7eqSQC15IDHtr3X9xlAegjetS7ykIn8FY7nU9u3wcLf3IipT5b7S66BSQk+G+1/cQc6LuecGlf5eimfVnqtV6KnU9XoHPtms87UjspIdMQVnDI/fAL28r2Heulg4wCxNOgXFwOZPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfOdzaRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20747C32781;
	Thu, 30 May 2024 00:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717029033;
	bh=jbY6kPTOWiY3QNQmc2zKELSLwprEdsHMoP85XJ01ngI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZfOdzaRV+0tnunc8B2FV3B9u1e0MSNZZqEZ0/3H1HeMwyuqmH6SGGuvas/chqbG7g
	 sWU0iKH7HUaSj9yENKAIwQKsSprrDF6qp9mE6sw7SfVZDD3heGQnmGMHKr7/q1BN0X
	 MWQ4/UPnjp2UV50sqzlZOWfnAQfYZ9f4lvn5tLLoD7mzJWC00cFVs+mWSnyOD9VtaH
	 LetaYthv/WYo7qWiDiQR+KrGR86dVHLafZvrN7xCWdJZz/BJDDvU8aZeCTqfPcJdVZ
	 S6O6J7XBjCmXpL6QzM9W5JdxE6+BceijzFv21MsP6ETw2ucax3SZAdTFhCGVa5xw0/
	 EmhQPYVQfY3PA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B5D3D84BCF;
	Thu, 30 May 2024 00:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] tcp: fix tcp_poll() races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171702903304.18765.3851256551010590517.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 00:30:33 +0000
References: <20240528125253.1966136-1-edumazet@google.com>
In-Reply-To: <20240528125253.1966136-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, David.Laight@aculab.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 12:52:49 +0000 you wrote:
> Flakes in packetdrill tests stressing epoll_wait()
> were root caused to bad ordering in tcp_write_err()
> 
> Precisely, we have to call sk_error_report() after
> tcp_done().
> 
> When fixing this issue, we discovered tcp_abort(),
> tcp_v4_err() and tcp_v6_err() had similar issues.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/4] tcp: add tcp_done_with_error() helper
    https://git.kernel.org/netdev/net-next/c/5e514f1cba09
  - [v2,net-next,2/4] tcp: fix race in tcp_write_err()
    https://git.kernel.org/netdev/net-next/c/853c3bd7b791
  - [v2,net-next,3/4] tcp: fix races in tcp_abort()
    https://git.kernel.org/netdev/net-next/c/5ce4645c23cf
  - [v2,net-next,4/4] tcp: fix races in tcp_v[46]_err()
    https://git.kernel.org/netdev/net-next/c/fde6f897f2a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



