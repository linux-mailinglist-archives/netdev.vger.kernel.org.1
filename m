Return-Path: <netdev+bounces-76021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CDB86BFEE
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 05:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5BB1C2386A
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EC23A8FA;
	Thu, 29 Feb 2024 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVGtQwWu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9AF3A8F9
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709181627; cv=none; b=auBQzJJwHnebgTWfm2K/eTLyXw7WGkUYjHxPWOjPD9m39a39F0Fdoc/7RpSR/1MniVBME+Mgr/53erOIPnNvkZTTIsAfmLNdhVf3MUGLinLoEaSUZqNXFLuTzoeijbxHrvX6BTJTVYJv4fUXHDqFXMlKUU3G7qIG4L5qwCitQw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709181627; c=relaxed/simple;
	bh=bhtmdwy7GuQ437l7xCc5ML5eMQiucv1IWvlRKix1n24=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O3e1Zu5bMtNB9w2pjuJkIuM/a+TCN9Kv4rv3jm6DaDjqDsjc5WynAabC/JDhnnHubVxL/z9GR74FtVT2I9+Sks6Sy8EnkyNleRByIRYDZU/zmBJkAXMJPIWydlQR6iA5KHIYix5GhK5XXUvMrVqSHLSPBmxdgyX1t7QloIYgI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVGtQwWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2423EC433F1;
	Thu, 29 Feb 2024 04:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709181627;
	bh=bhtmdwy7GuQ437l7xCc5ML5eMQiucv1IWvlRKix1n24=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GVGtQwWuAdl1pDMLRToJy5pxjH6kcXSEFqBpbBnWdfHYXTlrFh6vVcATt2fzuS9ua
	 8Txu9wqfJfcptCxzznWd/ugRw/A25cYmR8IArU/9YYC2gEkf3g/Gbrn5jkw/lVPYrC
	 76A5uxJNbageEKeeJ18DMYkzNOvjpOy+ghAKD9vC7Xkg0iVv6wNnz5iIRulxttg6cC
	 NEHLZbKKKqChW8vqOw5u7pg2XEkBgoRNHOR2/e+z5sTeAFCoyJeTGFz/i5Mod0ljii
	 NbtJzyTR4/g04W97DtuxYBQOnEEAoSl/xAvM6LJYXg1JJQY7N3mr26pYXdE3afSb7+
	 TamZFU8QU1UoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09CFBD88FAF;
	Thu, 29 Feb 2024 04:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] inet6: expand rcu_read_lock() scope in
 inet6_dump_addr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170918162703.21906.7688062355944676412.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 04:40:27 +0000
References: <20240227222259.4081489-1-edumazet@google.com>
In-Reply-To: <20240227222259.4081489-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 jiri@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Feb 2024 22:22:59 +0000 you wrote:
> I missed that inet6_dump_addr() is calling in6_dump_addrs()
> from two points.
> 
> First one under RTNL protection, and second one under rcu_read_lock().
> 
> Since we want to remove RTNL use from inet6_dump_addr() very soon,
> no longer assume in6_dump_addrs() is protected by RTNL (even
> if this is still the case).
> 
> [...]

Here is the summary with links:
  - [net-next] inet6: expand rcu_read_lock() scope in inet6_dump_addr()
    https://git.kernel.org/netdev/net-next/c/67ea41d19d2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



