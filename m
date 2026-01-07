Return-Path: <netdev+bounces-247539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9EBCFB8EC
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8360B301E157
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1964283C82;
	Wed,  7 Jan 2026 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyHNLP4T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1982206AC
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767748412; cv=none; b=YFv8/jXt2a30LX2w9DBWH9ZON0pGzTi0SjdAsWhVyrISP1TLH48WixPkQV1fPgkjMZj+ahI4k2CjLDN/Em3mq8zz0S16Km5ujX3L885IIq3QIdurjyctSwXI1BqyRj/nHIBCaNYYkKzsj/3+YpRqgZAcCwUkdoc2cWJ6ZludENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767748412; c=relaxed/simple;
	bh=Po5vpKm2oem8BjoeTVMU0Alf3yXq5yiqk+KFU3fVfZk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IFCyXAD8nJjckPIKkqzFeeIQ+/0vEzIJ1mqib21vO6NcNYLCrrcGtxmIdpm3Lj0lOBs1FQ+dF3lBrc6i9xGJLpEd0HfKrp8JL+MXSsTZy6/Xrd6lKdNJqYKZ5jBNtDAqpW1214U7x3XBMc48PZGy3q9bNn4DlAaxKyfGrDtRhWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyHNLP4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67798C116C6;
	Wed,  7 Jan 2026 01:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767748411;
	bh=Po5vpKm2oem8BjoeTVMU0Alf3yXq5yiqk+KFU3fVfZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kyHNLP4TnVMaemjNdkhZIya2X+y2WXxwWcRTS+guuSN9UrVjGroE/ZNt7pG08Zo11
	 o/6kult258r1ZF96icTH+RTtVcYn6su8jJVJ9R6ykZqbpoJlnHjrjkWoySLIHS5ZQO
	 T0RntoU7PocwUpWHA2iQ6oD80cKXCGLDnDgmE6Y0IqKAIyakFWdcx62ffiYLQIxVOk
	 c9ZTH+TxTzJYVl7xMr9q7RUl2iWKzQKzeQELhBobb8NRwRDoJcI1jD+PbM0ozemsLB
	 ZWfHDrC7hAU0SIvVa46pQ6s4ACZqfYChHOAcUsFdI+l7dI0bJBZ9ymeGKQRmPHtBWZ
	 xcH63sI57/t9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2173B380CEF5;
	Wed,  7 Jan 2026 01:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] udp: call skb_orphan() before
 skb_attempt_defer_free()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774820902.2186142.4753547750542309482.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:10:09 +0000
References: <20260105093630.1976085-1-edumazet@google.com>
In-Reply-To: <20260105093630.1976085-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+3e68572cf2286ce5ebe9@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jan 2026 09:36:30 +0000 you wrote:
> Standard UDP receive path does not use skb->destructor.
> 
> But skmsg layer does use it, since it calls skb_set_owner_sk_safe()
> from udp_read_skb().
> 
> This then triggers this warning in skb_attempt_defer_free():
> 
> [...]

Here is the summary with links:
  - [net] udp: call skb_orphan() before skb_attempt_defer_free()
    https://git.kernel.org/netdev/net/c/e5c8eda39a9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



