Return-Path: <netdev+bounces-160586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0FBA1A6B9
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F363A0889
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 15:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AC8211A2F;
	Thu, 23 Jan 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffYEGhF2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573F20E711;
	Thu, 23 Jan 2025 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645016; cv=none; b=FIaa4Co9R0rHqnCI4GCnPM32H1tqWcQpTzZO7g+n4t3VwKNon2qJvLBBcCWU8jKdi3K6bpdYlj2oKLYindsa6es4pLkEGkHlq+bldR5lYpjaBH/Zn+KaaxtGpDkvFT/LPWJDvC8zXyI07I0f4c4wIDpIWKuL7WamffxAzUPXzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645016; c=relaxed/simple;
	bh=AlRnFWIgDwRc9Stn3NLmrSL6ZCM/0t/BwJ2cqR1q6W4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SAkca0kshQQlr2E1XayPUHG9iKqIiz0QSfUax51dxH6TY9ocwJXVh3ID6mojYdVGkqGhXykN2beTjE7kzEsdRyeQJ3ciiuuaBXOoetp+U1jSWqhKgvaOQi6rgqzV/s3/m1z0Sz4/iTh30uT3/kpjtEntf1fKEISRYge4BXSEfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffYEGhF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C647C4CED3;
	Thu, 23 Jan 2025 15:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737645014;
	bh=AlRnFWIgDwRc9Stn3NLmrSL6ZCM/0t/BwJ2cqR1q6W4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ffYEGhF25mbxOt1oNLo3S9GCZ6pmSpcXW+SVgi7G/RF6U0YlLXkR8ZHUZg6/xrmEr
	 sKtB56aMKTnD9FF7p1d8f3mnjcCDW+L1kbcAa6iU8qB8jTcjmWmWGwoD3gWGozCZEA
	 h2//qFWwDnH8OTYHs8uKukQh15GuP5p13rI4/6mC0y8+uknYmr8qMmoYwDEB05PkKN
	 /p1PpQ7VMMIUh19d/HXNoJ7g2n5wzjhfjy/2Z0XWxtZhXI2PhKNTsYlGsiceCyqK88
	 Wa4CrEsbOIwj/vwOLy6TeFmCjbuMokSEXLrYXgz9qpDJ8VURtgLkALLpbrsyn65sGS
	 cxSDp/1i2704Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF75380AA79;
	Thu, 23 Jan 2025 15:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mvneta: fix locking in mvneta_cpu_online()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173764503876.1387064.12950364925871878725.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jan 2025 15:10:38 +0000
References: <20250121005002.3938236-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250121005002.3938236-1-harshit.m.mogalapalli@oracle.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 romieu@fr.zoreil.com, kuniyu@amazon.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
 kernel-janitors@vger.kernel.org, error27@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Jan 2025 16:50:02 -0800 you wrote:
> When port is stopped, unlock before returning
> 
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis, only compile tested
> 
> [...]

Here is the summary with links:
  - net: mvneta: fix locking in mvneta_cpu_online()
    https://git.kernel.org/netdev/net/c/59e00e8ca242

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



