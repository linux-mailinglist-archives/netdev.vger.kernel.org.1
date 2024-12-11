Return-Path: <netdev+bounces-150936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BAE9EC221
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142A628398A
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7A41FCFF3;
	Wed, 11 Dec 2024 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9BzzJJe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C53E1FCFE6;
	Wed, 11 Dec 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884224; cv=none; b=IPkasvXwPu3xz7SwH0miv2Nu5ukR2Yp8d8rcjj8GSuvsFMkx8F+0ZAHP4Dc5d6IHeoEnD0Hzezcp1KSZiAXOgv+bgXz8vR9vKv5WxLvJ0j6fqdwbVLaoD/uSrLpq2/aIB3vNXQobDphmcg9oikPioSdfcK/VQaeyy1kPz5F5ytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884224; c=relaxed/simple;
	bh=IZC6m5zf9hXxF6klKhoyzxvWGC7O8TTUhbr90rq5VqU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gSVl8cmAugf6XiQq4p/7jRtxg2CqaKQnphgYFv85E/kXisqNS6pQZ4oMGAWJ5Z6bLZKFSuCb3Hbfz3aeZjU1qLaDqBYdN4OXSAq0Vz4lbEmUgQ/PU4dsAVXVTiRlmsgAM96GH0KcpWLGRLClisl7lRXzlo66RKDWXQ4sLZ/ytDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9BzzJJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8BAC4CEE0;
	Wed, 11 Dec 2024 02:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733884223;
	bh=IZC6m5zf9hXxF6klKhoyzxvWGC7O8TTUhbr90rq5VqU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S9BzzJJe4wWNrOiBlGIo9TF2Av9Khm2FfAZrjKnXxLrksrG8a+t2/YxOw9jT2PB9u
	 dynYeSAlu26rFx2zkk8nmYK5yEzqR2L0Lzqb8ltxDTlHm1laR620jNYksXqDaSmh9x
	 Ec1hrUzofpItVrJNJJ1PHfTyTCwLLynL2EtzaKTQmw4OVWHj+NjUgwOWK3ZWK74/5x
	 AHunlVQME3hJqH+L6l0vqVzw1U0TAxjQ+P9ARJruy26ygDH3fXTpDe7og4fa2uVJhW
	 bBUPs3fghlmixoCij5niBLs5C6MLmrQo81ktganh6b6SoQgk+s+aPOVIlderjzQoAO
	 disvcIiet58EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB242380A954;
	Wed, 11 Dec 2024 02:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: pktgen: Use kthread_create_on_cpu()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173388423950.1090195.11688101236904327584.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 02:30:39 +0000
References: <20241208234955.31910-1-frederic@kernel.org>
In-Reply-To: <20241208234955.31910-1-frederic@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Dec 2024 00:49:55 +0100 you wrote:
> Use the proper API instead of open coding it.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/pktgen.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Here is the summary with links:
  - net: pktgen: Use kthread_create_on_cpu()
    https://git.kernel.org/netdev/net-next/c/33035977b464

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



