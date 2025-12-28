Return-Path: <netdev+bounces-246175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C61A9CE4A8B
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 10:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0DE430274EB
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489AA2C11F0;
	Sun, 28 Dec 2025 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPEfwnda"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231D22C11DD
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766914466; cv=none; b=eLClqe4A3OilhD/5QuGybcoktay2kIWjkpkZ32c6oC0tc0efI5lYJXJgzoqOOeZr4SKInqbg6iBlCNF/k7ehw4Z371NBUgxf3M5IqLscRJ/SdDaXJ3Mr32uDxFdYCnojTExbu9U0FLKHT+9Ljy3X2fmEZTDUGKSAi3fNyGEIFVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766914466; c=relaxed/simple;
	bh=X2pDooHxT3Zrx9P7EkxFZzanad2iaPyPKZA5k/3wILI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A8MMfZq+gh3lA/Imj6aoQDcZ1WMukeGvT+pjbyUa+TYemkMPgZjPbVflmI0JwHzjkfIEIBZX4Z4RQUGGkGV11pJ1nWVgj7Aployqxk9JmlscQA2l+TqlR3Ngw1oiZvz+hqNmisfODJMSalNwRlYMcR2X4BZWaRmUflMyHTx4WJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPEfwnda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF8CC4CEFB;
	Sun, 28 Dec 2025 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766914465;
	bh=X2pDooHxT3Zrx9P7EkxFZzanad2iaPyPKZA5k/3wILI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tPEfwnda/tCLqaQ+fA3Zkd6+oZB/xCIlWm5FdJzqm3KuHimdy1wmtDWuZbYoDN5tu
	 fay2SxtegsdizWK5giTEHkHVeM1vtHP7xUA5vh5UXWhycgoMnh2l/yhqMR6oH7e0OF
	 ulMQLKjso35TpdzrMUSfxH9R4yeuvmB5O3GhoZqTqrfZq0YhLdpJDhXbCjloLj7pb9
	 IqIgeRHh/Y9FaJftf2YzRL8cKOyJ7QxpTYNAQhkLTHwtF3iMilm76X1Dl1OZafuPLB
	 zKJGz9XMPvykBKl43l0NGJOIALQQuAic6Ddn6uhZoZZHW3T8Z82IijFbKMiRxEjSAT
	 i+cNjwmZeFbng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B57E3AB0926;
	Sun, 28 Dec 2025 09:31:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: avoid prefetching NULL pointers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176691426882.2294622.13126225594434049290.git-patchwork-notify@kernel.org>
Date: Sun, 28 Dec 2025 09:31:08 +0000
References: <20251218081844.809008-1-edumazet@google.com>
In-Reply-To: <20251218081844.809008-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, adityag@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 18 Dec 2025 08:18:44 +0000 you wrote:
> Aditya Gupta reported PowerPC crashes bisected to the blamed commit.
> 
> Apparently some platforms do not allow prefetch() on arbitrary pointers.
> 
>   prefetch(next);
>   prefetch(&next->priority); // CRASH when next == NULL
> 
> [...]

Here is the summary with links:
  - [net] net: avoid prefetching NULL pointers
    https://git.kernel.org/netdev/net/c/c04de0c79534

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



