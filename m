Return-Path: <netdev+bounces-227259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26749BAAE4B
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FA01923436
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D71EE02F;
	Tue, 30 Sep 2025 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1gzQPr5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D301EA7CC
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195824; cv=none; b=QtJFiYVUKWXiFsPw1hNP15y4WnxLjTLp/2dJEvjqE1jPYef376l9rgATD9vaeJHvHju77nAtNK1tGoUkXEMYsH0DcaRcjKT5MhuLc3/kdSbkgjXwDhLuR3SM/yecNVYBgHnNrfMkPK+NjTqJWRMcfzDX9HQ5SqrUXPlEbi6Jehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195824; c=relaxed/simple;
	bh=VtvyU0ixMqi/qruYisc1vzq7y3t1EmWZwXUfpU35u5E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q0cOZDNzReeg90BKFYPoOWSOcHQEwUulp60N0AmOJ2J5AEk6ZI8yL6wUp+9QSQvMsvL6JpEzOS49lQ8NIXPXdxjEkCUYsiPZJT/L1N5e6GcFFZyoJAcZz7VnYKy+K3GrThF0gRm8/gDihmtm8oprG8fqD13Gdj5qDEKr2lUBP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1gzQPr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A29C4CEF4;
	Tue, 30 Sep 2025 01:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759195824;
	bh=VtvyU0ixMqi/qruYisc1vzq7y3t1EmWZwXUfpU35u5E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M1gzQPr5zxvy9RmC0yNkQpcpjyNYMypFzME4F+6FPjDFguY+LPBlaMTYBHem9wqEP
	 +dFXl40zvwsVD0+JiOIdlL+JYtfFpLRMAiFNHhACeCNTMa7yacaPQz+A/r/rfXRoVW
	 s3JJfPVfuv7FhM0h6SAAslgw1aqcrzilF7nqsfhxalwwE18cFfXlGyKkB02ByPqt2E
	 JJPdHCCZKxC4lkuFxNuhM34BksxfeEvu2OsNbV+7CLG2lj/Dw93+tCHZ+FiUWHaTkb
	 5ZAPD7VzRjn0xBZW4Ao3vR/yCfp5+rN4ICYntLaOi09rUdilXWve95bSoRIAHgw8E1
	 Ouk72NQy8Y2AA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE01539D0C1A;
	Tue, 30 Sep 2025 01:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: use skb->len instead of skb->truesize in
 tcp_can_ingest()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919581725.1779167.8436912665882904953.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:30:17 +0000
References: <20250927092827.2707901-1-edumazet@google.com>
In-Reply-To: <20250927092827.2707901-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, willemb@google.com, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 27 Sep 2025 09:28:27 +0000 you wrote:
> Some applications are stuck to the 20th century and still use
> small SO_RCVBUF values.
> 
> After the blamed commit, we can drop packets especially
> when using LRO/hw-gro enabled NIC and small MSS (1500) values.
> 
> LRO/hw-gro NIC pack multiple segments into pages, allowing
> tp->scaling_ratio to be set to a high value.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: use skb->len instead of skb->truesize in tcp_can_ingest()
    https://git.kernel.org/netdev/net-next/c/f017c1f768b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



