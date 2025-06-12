Return-Path: <netdev+bounces-197022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37380AD761F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B7C7AECDC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202662DECBA;
	Thu, 12 Jun 2025 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3IdJkjv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019E2DECB5
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741623; cv=none; b=ONblm5EKioIJte9raOZD+C34747zNViGGJTUnoIhKdyk0s9+QFEEjlIezN8falXbadmo76SqLHm2efrOGO7V8xUz4NrIjmS8ot+5BeL4kCshA0TgdscVOS7k79rLkBsmIc/2SWTunSO3V0o7SBTVK8X+kHqGIewJpEums2TNy8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741623; c=relaxed/simple;
	bh=OuAvKp+yterYQINCOo46JCDi1c/X/1E32tiOsmh1SwA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ji6zNsn82YJY/iE75ZHL65tWQXW27KKzUlVMSKN30fuOUTEizbP9i0KrANikbY5d+ZAQTJFBxSdJjzzgHzwyf+atEkCIMI5A7NLaKVk8BsCjjFBaxV1laEqdR5eF7MaDdMm6laAZZmYOSLT36S8amjvnG/jhxwpKDhmiQBcJ8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3IdJkjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA120C4CEEE;
	Thu, 12 Jun 2025 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741622;
	bh=OuAvKp+yterYQINCOo46JCDi1c/X/1E32tiOsmh1SwA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y3IdJkjvPp3bAdA2y0u6lakZvRL4ZH4NLEk0PpGF7dqnCAQDR/BC7GMKd+pcxLS13
	 zW/8lDCbVEgKgTjo0OhhUzsKwiZgapPXZ43Cyt1PE+Joi5zg5T82gktRNu9vGLpsZi
	 +/bsxYbId7qRQ7/eX+19dOQZOyuAjjBJTtg0VHyPg0iYgkNjGhbnp2CiqOZ8jbR8IP
	 53OOYFZ8cWuUFRPP/mQWn/vwK6Qy4159LBq+ekxwbSw/UqrsVOYUmZ1LVuNjBYteAY
	 QDN+8sOqeVAZ9KGwfXXDPgdHwDAesYhrLE48ugMQAIVdy0U959yxs/7BM22r9Th5M4
	 5CjolzF+xI98g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC9639EFFCF;
	Thu, 12 Jun 2025 15:20:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] af_unix: Allow passing cred for embryo without
 SO_PASSCRED/SO_PASSPIDFD.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174974165249.4177214.18197645182658669219.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 15:20:52 +0000
References: <20250611202758.3075858-1-kuni1840@gmail.com>
In-Reply-To: <20250611202758.3075858-1-kuni1840@gmail.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, christian@heusel.eu,
 andrealmeid@igalia.com, netdev@vger.kernel.org, difrost.kernel@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 13:27:35 -0700 you wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> Before the cited commit, the kernel unconditionally embedded SCM
> credentials to skb for embryo sockets even when both the sender
> and listener disabled SO_PASSCRED and SO_PASSPIDFD.
> 
> Now, the credentials are added to skb only when configured by the
> sender or the listener.
> 
> [...]

Here is the summary with links:
  - [v1,net] af_unix: Allow passing cred for embryo without SO_PASSCRED/SO_PASSPIDFD.
    https://git.kernel.org/netdev/net/c/43fb2b30eea7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



