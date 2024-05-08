Return-Path: <netdev+bounces-94518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025148BFC08
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5741F22AB3
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6373481ABF;
	Wed,  8 May 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqRA0NGS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6994C61F;
	Wed,  8 May 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167828; cv=none; b=NkMX3NDzp33kDAc+B1MVaxZRNi+GPS7TdMcBHJiOOTwj5hp2qLSUGMDX7RaBlZiYb8auj1Kx4CiIeMbQm5kTh4ZJ01McOBlallzlOKqZmjJt+q7JSV6dias1tCsp6KEVJy+hF4JuOJz+ncA1pbkmxkk8AElLYcZPpnFDeqmOtpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167828; c=relaxed/simple;
	bh=bQZKNvjZf5us9sxQt4200Dii2HdUlVFuP7rD3ndAJLw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aN6O7x7WgWPdwFoSVobt9jJLa1SiQgq0D7rqibf1MfF3eh2IZnIoTF7XU8OrzdGSzh6nV0huKN9XN+wK9oHsELnbJ4FgnkFc9V+PR8uiAY94xbjUwiC70VjLzH/GNLfJI4He7lyQuvPMyL8zd5oZK268seqF4DJ+jTrbTOLaDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqRA0NGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD612C4AF18;
	Wed,  8 May 2024 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715167827;
	bh=bQZKNvjZf5us9sxQt4200Dii2HdUlVFuP7rD3ndAJLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MqRA0NGSCtx/EymXl9zc1TBo0q+RI8DHN1yWQ4bEBWHVUcrK6W+O2DkCQ0j82Ulyv
	 S1XgXFa9MLjQqjd7Gfur+hlFqyD9iLIm8Ye3ta60lUYudgoZWaPczxnFjvMyllIyWt
	 Ye/h7j0ZEyyG2FgkIokjteEbAkN3UqsN55mtmBiEYTb0gqZptFsqUXKxs1yM/DQkiX
	 IBgodnmNxexYUO7rVtcMwssWJa5ViUyyQ11p7Jz7R/RMZYGfKg8qVXZmo34i/TCU7K
	 239T/a7vaIo4wogoXa7oOQrkOw6CdBm0bPU/cppP55uVZe71O73B9CKydOq7ckUzH2
	 4O/B1tWtm7s6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD679C3275C;
	Wed,  8 May 2024 11:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: Fix potential uninit-value access in
 __ip6_make_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171516782770.10113.114314269958250190.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 11:30:27 +0000
References: <20240506141129.2434319-1-syoshida@redhat.com>
In-Reply-To: <20240506141129.2434319-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  6 May 2024 23:11:29 +0900 you wrote:
> As it was done in commit fc1092f51567 ("ipv4: Fix uninit-value access in
> __ip_make_skb()") for IPv4, check FLOWI_FLAG_KNOWN_NH on fl6->flowi6_flags
> instead of testing HDRINCL on the socket to avoid a race condition which
> causes uninit-value access.
> 
> Fixes: ea30388baebc ("ipv6: Fix an uninit variable access bug in __ip6_make_skb()")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net] ipv6: Fix potential uninit-value access in __ip6_make_skb()
    https://git.kernel.org/netdev/net/c/4e13d3a9c25b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



