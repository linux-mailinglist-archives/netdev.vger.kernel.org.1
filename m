Return-Path: <netdev+bounces-122545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D875961A75
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 01:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D69B2231F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BDF1D54EF;
	Tue, 27 Aug 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8BlfoCx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501CD1D54E7;
	Tue, 27 Aug 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800836; cv=none; b=DO6gO8dj4cMv352tLMDLjZYXtIYlTk5mbUoUMox6OJL7m8t5MzPSo3phZwMXf4QBUsMoeSlMdMvypYLrVA2tWgHqJPrj1zS+Rzw7ZtqMmuOS6bvbZdxVtQ0TmGJ72KrI3aqpiVlEKPKBDvKByUB+IkTffjna+5+/ay1QHOfTLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800836; c=relaxed/simple;
	bh=OGBt1uR9aeT5syXteav4Z5kDT6GN3DjkcwzMBSkCFUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YIjLkAIpkWePJEIBk8s4jsGV7SVn14WlnZwcTthY5e7gyd0LDZ2bdTagpfd+QvlLWl+jTWMWeMBp7LLaBByD13I0kt/aS1ZqRVsy9BQn+L2WcSI+Hd1sO2Tq+lFiJHXWsLlYY7l0zgcNq5/iMX50oo3zU8022XeY305+zzJfTgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8BlfoCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CCEC4AF61;
	Tue, 27 Aug 2024 23:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724800835;
	bh=OGBt1uR9aeT5syXteav4Z5kDT6GN3DjkcwzMBSkCFUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B8BlfoCxC5eBYus/dzFht92b08u2zN7nNBneYjxFw6dnol05H6dYA7LXQxGY0yaEP
	 DCMi55FczAQ/cQgfEMjOJzLgb70Lvc8p0BYbcZruocEjEK7hZWeNvCUz6DnwTMM+zA
	 mhb9hPtZ58MfRq4+ULRNZ7SYhBGsl5GFMtyX5ahzzHx65U6hTfQUzYty2rtSivs9S6
	 1VzsTP05UmAVKgMDnbjNFYH/3xbfxExgPljmok1r4a7Xe5BG/WJg87F42LiTeMRR2s
	 /DKzrjWexM/Abok3sqJWJA+DM0dex2I2z6iCHbUnJHJAKztSwtIJufkaMe16uTI8Qa
	 hYI3JAdBKlABw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B023822D6D;
	Tue, 27 Aug 2024 23:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net-next] net/handshake: use sockfd_put() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172480083576.787068.15891636613175801877.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 23:20:35 +0000
References: <20240826182652.2449359-1-a.mehrab@bytedance.com>
In-Reply-To: <20240826182652.2449359-1-a.mehrab@bytedance.com>
To: A K M Fazla Mehrab . <a.mehrab@bytedance.com>
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 chuck.lever@oracle.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Aug 2024 18:26:52 +0000 you wrote:
> Replace fput() with sockfd_put() in handshake_nl_done_doit().
> 
> Signed-off-by: A K M Fazla Mehrab <a.mehrab@bytedance.com>
> ---
>  net/handshake/netlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net/handshake: use sockfd_put() helper
    https://git.kernel.org/netdev/net-next/c/85d4cf56e95a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



