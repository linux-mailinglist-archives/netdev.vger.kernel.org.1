Return-Path: <netdev+bounces-94762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAC58C0980
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839BF1C21051
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C6913C8FF;
	Thu,  9 May 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdZc4rLz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A189113C80E
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220029; cv=none; b=XxD+VQVvNoSKUdiPgpjH+ba+Z+LFGnnDrmILLODlWte1j4Etn7/lzFozO56/S03CITCxU7vxGLSrVfY+gL8qXgtDt0ZaKEBa/hNz7Zc26EXXqeHHq5t3mzlzlNMTyGPAOlbEdtozPW2bZHTRoajG87nKHiN1yIEwblTeudnP6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220029; c=relaxed/simple;
	bh=nEaHl6oze0uAUcggo3IjhlcbwOlHmIhSSOBSwbz/3TU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PaaPFi6LnyWJ93EU1h7WHBZnF+/IkDpMAbA2bLkPjBqWgMufWD7+EhQVDbN7A/hHgvQAQKLL89QZS34bk1Bayudw5MAs61LBKrt045cxAlHiLJ8TenM+4X/rl4dqyYNd6a6jeDvSzmqGxbP9skSiyAVAtZAInuLEsIkRb+kt+PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdZc4rLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34765C2BD10;
	Thu,  9 May 2024 02:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715220029;
	bh=nEaHl6oze0uAUcggo3IjhlcbwOlHmIhSSOBSwbz/3TU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TdZc4rLznHCfCPKeW2lNCQXXqiTONy/4bmjm4dXaKk5KFosm6i5Q2LoLBjzCws5Ra
	 wzFoxdA3vzngBqsImtxKAeMR1pOBroBni5P+iKfryNrsd3OE5e8MTgg7V15wRQBuku
	 TK65jfDr0sycfm2T0vUudoar0pobVrpZOYLJyg83MkGKi0tM6O7ljXJSV98sIfx314
	 yQPr6TFguPAq61ebzXoWSjyD0uBjJwMAuhxMZ10L/KasZRqB2AD1mz+xTuWdpW4LAo
	 dG9lbyT0hcPNoBPND1ejVSaA8nFiBvYGQ4qpCAcUe0M4FjA/RK8F+3tWMM7OYnRtxF
	 VRuYfnEFO11Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17560C43330;
	Thu,  9 May 2024 02:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: fib6_rules: avoid possible NULL dereference in
 fib6_rule_action()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171522002909.32544.13436478403974145062.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 02:00:29 +0000
References: <20240507163145.835254-1-edumazet@google.com>
In-Reply-To: <20240507163145.835254-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 May 2024 16:31:45 +0000 you wrote:
> syzbot is able to trigger the following crash [1],
> caused by unsafe ip6_dst_idev() use.
> 
> Indeed ip6_dst_idev() can return NULL, and must always be checked.
> 
> [1]
> 
> [...]

Here is the summary with links:
  - [net] ipv6: fib6_rules: avoid possible NULL dereference in fib6_rule_action()
    https://git.kernel.org/netdev/net/c/d101291b2681

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



