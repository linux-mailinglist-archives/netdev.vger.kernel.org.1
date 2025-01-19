Return-Path: <netdev+bounces-159588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA844A15FD0
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD6777A1FC8
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA7CDDA8;
	Sun, 19 Jan 2025 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/hRtGTy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7688F101F2
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737251409; cv=none; b=kIZK9auQ5DP+wm3jFYRyEWYNNgd2X5uVAy18gh2a91Z5vKPwWDmOSvACPjaPNtldS87P990ITFkj1HZZNwIT7enq/GDu2M3igy7kMSpOQSZAKRT6Xg9vpi7ZfmzXsb4EqBKT2Htve4AbCPH/PTdrSuwvH/iSp0qUUkyFsNtWSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737251409; c=relaxed/simple;
	bh=r0gEHFLKdieF2aDmoFVGqfXoKujbpZgsl6OQJOfLQ0A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ir5MXUuDNKLenr2kyqS8NDs1Egwkv++9EPR4lPo9ISc2UCzymAi64O6clWRfinWXUgvoqyYxewghWiwZ8qGVhC7bh4TT2L7iRzPSLUt0xlFGJlt6j2Vq6xoo2z+oPyNez2edwNRwA4ywEfftgnUsxOjtV7R5+WorndcYl+8ikD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/hRtGTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB893C4CED1;
	Sun, 19 Jan 2025 01:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737251408;
	bh=r0gEHFLKdieF2aDmoFVGqfXoKujbpZgsl6OQJOfLQ0A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l/hRtGTyHx3qiqNJJuBVQPjS2IPX4fwzCVifhKYXPw9aJVgVr7iZg0Z78Smt+h4R6
	 UgNZZDGCQIVFAxV9U89ikgyO54VV19EdDKHuSigC3vYkxP4SqHyLPgHYvtcq8JIePY
	 IZh6LqAbki+PASj8SbwNNdUXCSbEsKsYNMWA6omedUdhvUSNuG461ipKIo5EMrQ/Ii
	 KaKPmlWSG0LsGdZMJUUdDbuuqLyNTgbp5P250DH2TVA35Sc96QGzxRD51TqqoOuMn7
	 2EzHu0k4rE3Sb139c2CZliFyiNSzAS8WJUu6U/GTNGQqUMc+6IdysMzzVPssu68kSg
	 5NkbXB6Q6D4kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDCC380AA62;
	Sun, 19 Jan 2025 01:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: destroy dev->lock later in free_netdev()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725143250.2533015.16650413043132840679.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 01:50:32 +0000
References: <20250117224626.1427577-1-edumazet@google.com>
In-Reply-To: <20250117224626.1427577-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, kuniyu@amazon.com,
 eric.dumazet@gmail.com, syzbot+85ff1051228a04613a32@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jan 2025 22:46:26 +0000 you wrote:
> syzbot complained that free_netdev() was calling netif_napi_del()
> after dev->lock mutex has been destroyed.
> 
> This fires a warning for CONFIG_DEBUG_MUTEXES=y builds.
> 
> Move mutex_destroy(&dev->lock) near the end of free_netdev().
> 
> [...]

Here is the summary with links:
  - [net-next] net: destroy dev->lock later in free_netdev()
    https://git.kernel.org/netdev/net-next/c/bff406bc0424

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



