Return-Path: <netdev+bounces-120370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313329590D0
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BBF1F21273
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE7414A4EA;
	Tue, 20 Aug 2024 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzkMH5z2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870045BEC
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194838; cv=none; b=GKGl4LceiudtYIrLxbmRLw0p7V43QNKva9b3qgRF8O5yWRLZIlTuKX88Q1XqoyAjIyuNvfnLgyAxYEG8sE7NvGnMDvZHqsML9zl1MCYP6zQ0SYDYj1hMj2AYNlcc/+AZZlIGLB16ZTTFr5ViHhf1oFyZ2rt5iG81pYzE9wpejwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194838; c=relaxed/simple;
	bh=AKPNV5T/U+m62G2ESWUlKhF4uD/Z7Rfyc3evKWygdeQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kgKHzwQYrvmvsnLxi+2pw/3CfvOaXUB7I6NIkCOyPtBLZ6S37Knbq4nxFhmC/2cFdYXCg/KSAI9jCnu3oPXwGf1ONDE6UIwvwBqW0k1aMdS1LloNouZTtgFY8FiNcpol5J5MXe+yNjBtWNTuWTUCEdtrpqnT7aQRRJmAyJIg9Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzkMH5z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724C7C4AF0B;
	Tue, 20 Aug 2024 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724194837;
	bh=AKPNV5T/U+m62G2ESWUlKhF4uD/Z7Rfyc3evKWygdeQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gzkMH5z2RFPkXaHxifHML3s438TJyh8vexpsljpqGBJiAdTvp4cR12UUuy8X1ijxP
	 XiY0Rm7HwRePO1Y6hPUKi08DH1cGEnXV72H/V1bURv8tUEfXPv+hHgGHq7lQzaFxGb
	 +DoFtNn8WK+Ra5JBA23rVZyPZWcstfCeAcv9ysw7h3N63saH5JrBP8IOfHqrTvaO3y
	 ntSZa2ET5QjKDZSZ+Uq3df4l5kPSsSxWskfjC6BrN5VAY82QVOcwGBkysrTWo5Mn1/
	 cZQvyULU5GHgFhv5yByjYXZswxkuAK7KtUCfDIGSoffvPpkioXUMkhtKUWzwtwSkFl
	 XquIXgpRM4SkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CBD3804CB5;
	Tue, 20 Aug 2024 23:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] af_unix: Don't call skb_get() for OOB skb.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172419483700.1261673.12420210983904938531.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 23:00:37 +0000
References: <20240816233921.57800-1-kuniyu@amazon.com>
In-Reply-To: <20240816233921.57800-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Aug 2024 16:39:21 -0700 you wrote:
> Since introduced, OOB skb holds an additional reference count with no
> special reason and caused many issues.
> 
> Also, kfree_skb() and consume_skb() are used to decrement the count,
> which is confusing.
> 
> Let's drop the unnecessary skb_get() in queue_oob() and corresponding
> kfree_skb(), consume_skb(), and skb_unref().
> 
> [...]

Here is the summary with links:
  - [v1,net-next] af_unix: Don't call skb_get() for OOB skb.
    https://git.kernel.org/netdev/net-next/c/8594d9b85c07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



