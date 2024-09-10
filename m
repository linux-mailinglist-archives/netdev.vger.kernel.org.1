Return-Path: <netdev+bounces-126752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9669B972620
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C52851B5
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BF31EB26;
	Tue, 10 Sep 2024 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx0CAF2x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042401EA84
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 00:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725927643; cv=none; b=RlYdcu1iHjC+3gCiJ66E7K+07yp4UzkhQLm7N27IeeRZ8oBHUCSUTS6PTY/XfTTyATgMJH8Y3TnsFVJQLJiCZwCkByrTvd8lufmetBOH9K0Ka+Fv4rpEVeIk6Dj7mPBm9FS51aXefolyV2P2cIdzNuIkq+HUTmYsClfUmn2ppKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725927643; c=relaxed/simple;
	bh=vRLdNklmBXhodgdCLflO4P/dwnOZ1uHDvLxVtPPDJ5U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KzBJLeWF/B7ksgCCq+XWS9/6WU8QLBAZHuy2hUrvtX/XMjPT9rSv8JEVBY8AyAscboYjyyU/dwZoxv+49rh1vTwhmsd+lWhq0D5TJf4mrX8YoAOFNGjKigVghnk8zgMzAOXJle01h+FMUYjV+9Z1pcSivSRt+a07ligol288Rlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx0CAF2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7942FC4CEC5;
	Tue, 10 Sep 2024 00:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725927642;
	bh=vRLdNklmBXhodgdCLflO4P/dwnOZ1uHDvLxVtPPDJ5U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jx0CAF2xLz/sYnRRjdKjyaftQ2udeLaXbe3lmCr3hnhsVT9K5hgjQBjXLjzAdwQSU
	 KMKv9dNJFyBwproTXzONTRieCuu3mYJz4YZxRPFMjAV7V9sG1FUzkax/w+WWayJeQE
	 u8i8qn+10hSm/6L6+DADauJ/wiVRLpJ7YIOhfcgI6qBsIVgulDS3ijyIhsyUmZ9XF9
	 J6GHQ7WgSjTyfa+tu1MFh8JEJ4f6T2o9EglwhBYEReBOoTDmKUZitQ74Ie2Ga6x+eT
	 WbaSpRSgIZs9N5eZNIFrV1zYiVhU9hWPfII8rSwNwE4iC/Y7mBaZZimSTCk+kg2Xn9
	 Qs602gZMfw+AA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD9F3806654;
	Tue, 10 Sep 2024 00:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/4] af_unix: Correct manage_oob() when OOB
 follows a consumed OOB.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592764315.3964840.16480083161244716649.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 00:20:43 +0000
References: <20240905193240.17565-1-kuniyu@amazon.com>
In-Reply-To: <20240905193240.17565-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Sep 2024 12:32:36 -0700 you wrote:
> Recently syzkaller reported UAF of OOB skb.
> 
> The bug was introduced by commit 93c99f21db36 ("af_unix: Don't stop
> recv(MSG_DONTWAIT) if consumed OOB skb is at the head.") but uncovered
> by another recent commit 8594d9b85c07 ("af_unix: Don't call skb_get()
> for OOB skb.").
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/4] af_unix: Remove single nest in manage_oob().
    https://git.kernel.org/netdev/net-next/c/579770dd8985
  - [v1,net-next,2/4] af_unix: Rename unlinked_skb in manage_oob().
    https://git.kernel.org/netdev/net-next/c/beb2c5f19b6a
  - [v1,net-next,3/4] af_unix: Move spin_lock() in manage_oob().
    https://git.kernel.org/netdev/net-next/c/a0264a9f51fe
  - [v1,net-next,4/4] af_unix: Don't return OOB skb in manage_oob().
    https://git.kernel.org/netdev/net-next/c/5aa57d9f2d53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



