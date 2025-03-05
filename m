Return-Path: <netdev+bounces-171908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AA9A4F4CB
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 03:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BD1188F54A
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F55A15CD4A;
	Wed,  5 Mar 2025 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhfcHWHx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3068C17588;
	Wed,  5 Mar 2025 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741142401; cv=none; b=FgGhK4NK6/XDwuW8vY6W8VlWLMkeejhImaD7Km6YB3nQoXhwcFmlvynCRIsAN35uWwHRNHZX1NrkIchzpg8NvioaqfiRw/SH75B3v4+IRGDBCyI0rPc3wYtDMuhYxPUgta7nR1dfq8kF1y5U3oPfXDYMFpDreDkkekXtHzrAb1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741142401; c=relaxed/simple;
	bh=x/otOXX3/PTZDGX1QqbpHudKWYHSUBeNnYt2ewCOZTE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RTSy0cf+9Q9Efh9Nvre8WM6p4F2fDVvhd/iOeil6/TrtqGtDgM805oUjHRLSq2jTaexFDQd40RqUwnnsUcp8cT9fE1LxFrtL94v0spu5Zw8IwQS0vujkd9fQzyhyigd8kuKd5SNxsG4KQTVuHJnIr+A48nCazX6FTo2sGX42E+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhfcHWHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B479C4CEE5;
	Wed,  5 Mar 2025 02:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741142400;
	bh=x/otOXX3/PTZDGX1QqbpHudKWYHSUBeNnYt2ewCOZTE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KhfcHWHx1u09Ekjf2FAaWZoc3MfL2FZWpJb+svW5R/DXh9kCOcT1E5BELzOWt0vIU
	 OW8vzXglnuEu2SK1mptA5cAICEYvkL4J+5VT79GYe2RzG9MB+3M2Q/lVM/U6A2Xarb
	 3rtGAQUpCEqpACyQA/msE98QIcJk/RYYvXQvjMJd1TrxNWRXcZveP+uSmRblZUJOLK
	 6pyU2A8R2GbDwr3k19m1CGAiCucwb+Aa/wScB+IFdoUrUeJbNCCVC4CqLGKLrsv6HI
	 /RmtLmLKMYLkQXAqKhghpIPUpw2EoUDwSjS1AbxSDCG6jb/lQXjI+WgtoqHaZG4UnO
	 oYSD46YuVV74A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE03A380CFEB;
	Wed,  5 Mar 2025 02:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Prevent use after free in
 netif_napi_set_irq_locked()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174114243351.377491.13624948013005852967.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 02:40:33 +0000
References: <5a9c53a4-5487-4b8c-9ffa-d8e5343aaaaf@stanley.mountain>
In-Reply-To: <5a9c53a4-5487-4b8c-9ffa-d8e5343aaaaf@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: ahmed.zaki@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com,
 bigeasy@linutronix.de, aleksander.lobakin@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Mar 2025 15:02:12 +0300 you wrote:
> The cpu_rmap_put() will call kfree() when the last reference is dropped
> so it could result in a use after free when we dereference the same
> pointer the next line.  Move the cpu_rmap_put() after the dereference.
> 
> Fixes: bd7c00605ee0 ("net: move aRFS rmap management and CPU affinity to core")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: Prevent use after free in netif_napi_set_irq_locked()
    https://git.kernel.org/netdev/net-next/c/f252f23ab657

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



