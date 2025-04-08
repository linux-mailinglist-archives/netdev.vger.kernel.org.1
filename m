Return-Path: <netdev+bounces-180459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2971A8160B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 21:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CED9882FA7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFBA253331;
	Tue,  8 Apr 2025 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e018ZcLO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99EE23ED7B
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744141863; cv=none; b=fYH8fVIQeSlAW7obpgSF0FtprxVJdt/DhornMjp8jwWI7/tKj9jkBnGC2I79x9ISJg1s7zzYHpho59MxlS/5j8g7nJITQLJQXpsmZ6AG69GNLta/MkhzwJj5fbcF7Og4Qgj8H2oGUmgViYvJJf6yRipQYGXzyDTupidzKNwGJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744141863; c=relaxed/simple;
	bh=zxYCDal77Sx4ykYDMoMyE5oE155YDaaF/459lvY2b50=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q54m9A9RaE5SdidQBXMuWe/G69jOmqGM2VP7Yzc2J1vKyC1b4qdI6icaJwIRc8JGPPholYjhkwMd7Vk9nAN+5nFo1dcFP5ExNjVok1R0TXUPFlaQv0NlTeyxINEkXxEZ7A982NSl6FicGRGzLDEKD4rPYLIwcAcrmqcRQXmGgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e018ZcLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87448C4AF0D;
	Tue,  8 Apr 2025 19:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744141863;
	bh=zxYCDal77Sx4ykYDMoMyE5oE155YDaaF/459lvY2b50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e018ZcLOStwg4v+OWkOKQpRbxR71uB7cx2P+qTEryW5mEtUXwQApmt+GisuBREwFz
	 UJfhsRr4L70JPvIUP9PBJfqhWVotvOSirOD3NWKUJYBJD7S2bHY2kuR1/isAgYzDQi
	 tE/5xIs7oq38S8NH2MpgSgjpvBTT7erkFgdSCg4YYbAgiQXr3IZXR8mcjXKq/NpBqk
	 0L8F3ZV32ybOC4N32+1Zk06TEJNwDFjZhJHAO3KINt2nGaRxPkdNWXBySw+4dk6s+p
	 LO8FTYYev77EhJ11Fnj8CIP0EA0NyBnu0dnQhzSw4HPhqghsjWJ66aSE0Q6tnEBsT8
	 aNxU3ezuP8MgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8E38111D4;
	Tue,  8 Apr 2025 19:51:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] rtnetlink: Fix bad unlock balance in do_setlink().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174414190040.2109258.8169939556997104435.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 19:51:40 +0000
References: <20250407164229.24414-1-kuniyu@amazon.com>
In-Reply-To: <20250407164229.24414-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, kuni1840@gmail.com,
 netdev@vger.kernel.org, syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Apr 2025 09:42:22 -0700 you wrote:
> When validate_linkmsg() fails in do_setlink(), we jump to the errout
> label and calls netdev_unlock_ops() even though we have not called
> netdev_lock_ops() as reported by syzbot.  [0]
> 
> Let's return an error directly in such a case.
> 
> [0]
> WARNING: bad unlock balance detected!
> 6.14.0-syzkaller-12504-g8bc251e5d874 #0 Not tainted
> 
> [...]

Here is the summary with links:
  - [v1,net] rtnetlink: Fix bad unlock balance in do_setlink().
    https://git.kernel.org/netdev/net/c/445e99bdf68d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



