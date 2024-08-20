Return-Path: <netdev+bounces-119971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 421AA957B5E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 04:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3449B22E79
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A568224D6;
	Tue, 20 Aug 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9LLoVWm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600217FE
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724120429; cv=none; b=tOSxR4fQ/c8s2xAPdQKOZSWXIxXu1TNhW/5ybKtj+XW2+U/33HQscIHZADkLQiiFVZmGGsIDXQJ+Sf3GrI8TuATqTd0TXFqvxWsAhrxXhy6NRE77cYTwl2aeThNZSfEV49hS7IL2vvT4MNwkl0Ta01wNSM27iuXdP95trQ9Y9lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724120429; c=relaxed/simple;
	bh=7M3V9fh5n1XK8+YQAMaiXimwhj4EEYS/+cfokGhiq0M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TJbr3GZBbBqtsIi+r1UKpxfE7+4o4/lLs7yzP4sARNEPg65LUOqu0vQ8hmlq4QK1uD+GCpjfAlsHpQnigHLhbjGsoTM6+xExGcSgfGX3pvJPCHoVORKk+JKN5vNxhaeZGGO3JQJItwtY+VSgG4rhXArYpGdGdH6ZDAy1iGi+XA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9LLoVWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736D8C32782;
	Tue, 20 Aug 2024 02:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724120429;
	bh=7M3V9fh5n1XK8+YQAMaiXimwhj4EEYS/+cfokGhiq0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o9LLoVWmR/8ZyLE9iKBLMnF6YZCzSpQ6qmWm3BBzMTsfF9A6SnSfOULfOOHQT9ZeQ
	 ajVx2y36xfGPitp9Qfop7n4CshzsYPvsVu0zSrTTFrljj9j43u/kd//ZjsrqXZ5+MZ
	 gd1rbPJC1oLudnqwY49Vwmz4IP7pl8jycop9ck15ydDCuf4Oly4kDE1VHyWTkTfpca
	 A9yr9cLM8fANrHL9G0bbHggiVZ6jASCwf0tXGQoxKgA+gb2n0+I7M+NIgSJwQjl1/p
	 JNFaLW1PwtfGzPGcb3iYfc3VGkhrwL3tXqDelG39+1l7g/NoWG+Aol8rUhxi1HBqjT
	 Hbb1oUES7hO2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C0E3823271;
	Tue, 20 Aug 2024 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] kcm: Serialise kcm_sendmsg() for the same socket.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172412042902.711456.5002721309460516473.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 02:20:29 +0000
References: <20240815220437.69511-1-kuniyu@amazon.com>
In-Reply-To: <20240815220437.69511-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, tom@herbertland.com, kuni1840@gmail.com,
 netdev@vger.kernel.org, syzbot+b72d86aa5df17ce74c60@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Aug 2024 15:04:37 -0700 you wrote:
> syzkaller reported UAF in kcm_release(). [0]
> 
> The scenario is
> 
>   1. Thread A builds a skb with MSG_MORE and sets kcm->seq_skb.
> 
>   2. Thread A resumes building skb from kcm->seq_skb but is blocked
>      by sk_stream_wait_memory()
> 
> [...]

Here is the summary with links:
  - [v1,net] kcm: Serialise kcm_sendmsg() for the same socket.
    https://git.kernel.org/netdev/net/c/807067bf014d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



