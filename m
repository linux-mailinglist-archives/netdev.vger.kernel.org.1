Return-Path: <netdev+bounces-248648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F33A0D0CBDF
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 02:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C081A300F30A
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 01:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D6F1DF273;
	Sat, 10 Jan 2026 01:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC6V55cW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF972A1CF
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768009411; cv=none; b=dElOUCC+DYmpVHSOs+Bdy6VUZYhNAdo3CMA+KG4WmMs174N7Yhh2qu0XdfsvaBRiBodM/KZbhkfZdermg4Ng0oAFXmnc45iZDN+zAcerzTo6cydo4NRAHtqFYw7DrXIi+zmgEpKhwLmDCBeNUy4EXfmJbmIw90JYOqoY6J4GMoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768009411; c=relaxed/simple;
	bh=zbTuvh60RYa+x7sVZLNV0CzP5Fl2z8l5uEUjbH2vLbg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B86re63OJC0dq9stRPG4pI5UG4UkrY9bJ92FcJTI8YBhDvRLxoH550cxr0jZ1WytTE+dJJwNBLsxxt02UglBXQIny0aiAYEWZEpXfA/VVQM78AEQgwEhpr/lqjJlSSBaHl3MubecasjMrazTwWYRjlgmV1YwKaYGsQERR1Lvr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gC6V55cW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9726C4CEF1;
	Sat, 10 Jan 2026 01:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768009410;
	bh=zbTuvh60RYa+x7sVZLNV0CzP5Fl2z8l5uEUjbH2vLbg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gC6V55cWmZQuEuoTikDyUUSQ0HZJ//nDTpkd6tiboyOj/ipPVacPedwS9c/Fgo9cE
	 znFnqDQJgl/aoNdTe2NnUUmIujRaNJbEVV39rAkXUpxzEujYyQ38lrf1hq4bcnJ8UT
	 165o2TMcyrlMBT5GdXL2C0TMb06Xt7AKWbdqZ6G/jyUEZg+/qjDOSW/uMNTcr5UieQ
	 xTXvhMp6ZYny72GX5DTSfuiWfD3rjSRkljiI0oHurWLMPGsresPtSVb2Pyi3tnu/J9
	 qeH4JiaHxApBLZ7lJrI2b1ngfRwiqY8FoqZqkwnhhZmIBL/uXW1rtcGEcRBSRn9pXI
	 z1OGBTpeYV2yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78A943AA9F46;
	Sat, 10 Jan 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: bridge: annotate data-races around
 fdb->{updated,used}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176800920629.446502.13134188823510819845.git-patchwork-notify@kernel.org>
Date: Sat, 10 Jan 2026 01:40:06 +0000
References: <20260108093806.834459-1-edumazet@google.com>
In-Reply-To: <20260108093806.834459-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+bfab43087ad57222ce96@syzkaller.appspotmail.com, razor@blackwall.org,
 idosch@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Jan 2026 09:38:06 +0000 you wrote:
> fdb->updated and fdb->used are read and written locklessly.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> Fixes: 31cbc39b6344 ("net: bridge: add option to allow activity notifications for any fdb entries")
> Reported-by: syzbot+bfab43087ad57222ce96@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/695e3d74.050a0220.1c677c.035f.GAE@google.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [v3,net] net: bridge: annotate data-races around fdb->{updated,used}
    https://git.kernel.org/netdev/net/c/b25a0b4a2193

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



