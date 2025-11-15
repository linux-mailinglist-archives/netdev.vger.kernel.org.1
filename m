Return-Path: <netdev+bounces-238824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA794C5FDFB
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B4BD4E0F15
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836E2199230;
	Sat, 15 Nov 2025 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrC86Z21"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96C2A1BB
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173241; cv=none; b=MH+1W2yCdxWrzp63w8u/460WeaIpsP+MPTn96rj5ft31jTkq3BWnib0iSo0OGyCNfLJhzSG1ygpg3w20WTKwduhOYwa6PQmt0Bs2TdKimWfVXVX3WJBjK69gBZ4TZJ9Va2ch1Jz5T+3iG51QPcPsFiBkfxpGvUP2vRkC0FAFY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173241; c=relaxed/simple;
	bh=EZdgVBu5kBbW9srrpkJ06/A+kS4jcUVxpR1vAGzvd6Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S2Fw3dDA2YCB1Rxvgm6vY7P6HMiEvkuZcDJCeiMnW42l2Je8PH4OoEuDH2KA4sbRbWJhIABIFzDCk7iciLoKIasBZz8SE9F3B3j7p/HkSO1koAcr7yvgC2TODdQJhCXXY/jiqwiBdQ+Kd55UZK91Y9W6YhRWiwwRvXDlTxZidRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrC86Z21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1FAC4CEFB;
	Sat, 15 Nov 2025 02:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763173240;
	bh=EZdgVBu5kBbW9srrpkJ06/A+kS4jcUVxpR1vAGzvd6Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lrC86Z21b5xVapR+dYJu1gBw06nTwNFoQmyQ9CUfSlONq+k2yw3QX0TMB0SD7B+it
	 DgvrOq+2aufhV5y6iRr/4eN2HwBGJkpSmTPMOQE7sXbWMQCBNPTZxCm8qNn7KJthyO
	 eOh0qLOGtordTpfTEiwU6dWajTDQQ/qojLb5Qr6WigY5d7I7jlc7Mf628vu4NW2xvb
	 qC1H4IHTT6gv45V02pIfOl6oytj76rEk4PxxTO4WLW8HtBU3EHNZZD48LeLf0cc84h
	 T+ST0x2x54jhWzE/BE6jnhcimkZhVoxDUnOtInzfCpMRci8BP+GNSrQWf4RC9G3+zZ
	 4lWBs8xk1CeOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E0A3A78A62;
	Sat, 15 Nov 2025 02:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: fix race condition in mptcp_schedule_work()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317320926.1911668.347846021009894983.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:20:09 +0000
References: <20251113103924.3737425-1-edumazet@google.com>
In-Reply-To: <20251113103924.3737425-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 matttbe@kernel.org, martineau@kernel.org, geliang.tang@linux.dev,
 fw@strlen.de, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+355158e7e301548a1424@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 10:39:24 +0000 you wrote:
> syzbot reported use-after-free in mptcp_schedule_work() [1]
> 
> Issue here is that mptcp_schedule_work() schedules a work,
> then gets a refcount on sk->sk_refcnt if the work was scheduled.
> This refcount will be released by mptcp_worker().
> 
> [A] if (schedule_work(...)) {
> [B]     sock_hold(sk);
>         return true;
>     }
> 
> [...]

Here is the summary with links:
  - [net] mptcp: fix race condition in mptcp_schedule_work()
    https://git.kernel.org/netdev/net/c/035bca3f017e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



