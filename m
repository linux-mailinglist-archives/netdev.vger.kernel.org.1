Return-Path: <netdev+bounces-91441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31A08B290C
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 21:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A68285207
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55DF14C5BE;
	Thu, 25 Apr 2024 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvhsHEjH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084A2135A
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714073450; cv=none; b=PxDL972+ntAv14IazyYmeYzh1e/0ey1djDnCleaBPs+I1u6kWFJGuo2Gv9+tFFDyNypnq4lfAiy+28GOyGZC4gdXEaBwBt62PrcZwnEW/vcxcKHgxXavJeDu4GemfO5hEWnUs4PWBosGlvWKPAIbGAgVJZthJ7Zc5b6QmE/foTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714073450; c=relaxed/simple;
	bh=Apgu2a+vwxtbLdqdEPKI//4aFbDJiZhcg1POLLvktL0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=svXSdPCsuhJbxGI5eNriRCEDFmyv3wKEEWmbqJYBoNRYXUhm0bGb2LHyhqNoUlZSzXNAjwcQn4NvVnOTOg+88iSTCHuyDbZo7wWGnvZ02unwhdXByuRs9zpIRvpbA2sTLkUOG52HM4HQjGFrauv8Xdt9FrPQGN1I+aS3/hTH3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvhsHEjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C208C113CE;
	Thu, 25 Apr 2024 19:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714073450;
	bh=Apgu2a+vwxtbLdqdEPKI//4aFbDJiZhcg1POLLvktL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YvhsHEjHHQ2jb2Ts4VNBlmb0am2ZtbniEgLdS79WnnbOKXMgs20X5b/U32sjxbDRy
	 hSNbLLVGNv6BSzsY7sByngO/65A98bG4DiS8nqpqhfVZ0zS557txPbQ/1WIJVSDGNz
	 o+TUBdFHG+RJzLrt3tBxdFYe2QAOK0890LXGk7BKY0GptWjyerf+1HEvH5HADqS5Bc
	 pTH0rGa2VFVEU73deQGeWqZ73X1WadomZCmUhirHMLlcmOUIA38SD8gErLbh0yeBbX
	 4r3dtPQIs8orRVSizUl8QLKIpZW1q98cZNEiQO8NwMf12Y3b8MGWPtVP6JB2HJDe2u
	 N+eFRi6nz03XA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1490CC43614;
	Thu, 25 Apr 2024 19:30:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: avoid premature drops in tcp_add_backlog()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171407345007.17723.14518698133512359324.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 19:30:50 +0000
References: <20240423125620.3309458-1-edumazet@google.com>
In-Reply-To: <20240423125620.3309458-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 soheil@google.com, ncardwell@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Apr 2024 12:56:20 +0000 you wrote:
> While testing TCP performance with latest trees,
> I saw suspect SOCKET_BACKLOG drops.
> 
> tcp_add_backlog() computes its limit with :
> 
>     limit = (u32)READ_ONCE(sk->sk_rcvbuf) +
>             (u32)(READ_ONCE(sk->sk_sndbuf) >> 1);
>     limit += 64 * 1024;
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: avoid premature drops in tcp_add_backlog()
    https://git.kernel.org/netdev/net-next/c/ec00ed472bdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



