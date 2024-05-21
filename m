Return-Path: <netdev+bounces-97330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE688CAD3F
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 13:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAC11C21EB0
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 11:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A8C55E43;
	Tue, 21 May 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyacIQFN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B578C6E
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716290429; cv=none; b=bHDzAffwzBlmmpZ4LAlWhF6Uh+4USg2QccrNkv3iDttnzWqIPvTgJrFKs9Ioa9SRok377DzgthGkJwWlkuB6cP9NQH4C4xz6mzflRHi7vq0So/qnNUhjHspJY4i9MKk0CxnuXB4wQDYCxsSk5EPxCcmtIFUKqwTUHq+XyzVLx+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716290429; c=relaxed/simple;
	bh=GUpe3WciaNyosjz+0jv7MN9l6XZbD/gxWm5idx9ha0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=grERv8EaFWW+Ndi2jFaKCRWaFbohSqQbg9pZQRkzqYsG5+UyHjKEtjsxMD/42A3l9Jd6axx7zVvtdq48mum89F46Y3W7bWbjX6vv8RZxhmB8NOsSszx9zE0iUDYmp700LKgUZ2IaGY6uCe8wI677U5ZggL6IlIT499HhEprHipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyacIQFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F088AC4AF0B;
	Tue, 21 May 2024 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716290429;
	bh=GUpe3WciaNyosjz+0jv7MN9l6XZbD/gxWm5idx9ha0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iyacIQFNAI0vpc+oUsz1auV/uCQsPTMQ1gYhfyFQ6e/jxAmDJkrEKAq8lzmH3C+Np
	 e4I6z71tcsH7P+kG4CkSpZ3mWrL5EfsHQ/EJ9caTPx+YCnFJTpNeKEh/XY7XSjwsyo
	 ZmGA3uvO6gMfuZiYjSiQKLqP1ArrdtbfiJXuyjMF8JokIb6uuyO+iWtBj2D0Zov8BX
	 gWbtSaEEz8n+fA+6nA93EgcZZD5G8ulcGhscpFrS/ydfAiYosjntv80lRXQ74nDZfL
	 LKia1KsXmYcnbcZMjpVKo14KGBc0enco6broYToK6zA7yAklqoS3mH51+9lCM+jEJq
	 zRgHhE2wkDLmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E05AEC54BD4;
	Tue, 21 May 2024 11:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: sr: fix memleak in seg6_hmac_init_algo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171629042891.23392.7832624426433712079.git-patchwork-notify@kernel.org>
Date: Tue, 21 May 2024 11:20:28 +0000
References: <20240517005435.2600277-1-liuhangbin@gmail.com>
In-Reply-To: <20240517005435.2600277-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 david.lebrun@uclouvain.be, sd@queasysnail.net

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 17 May 2024 08:54:35 +0800 you wrote:
> seg6_hmac_init_algo returns without cleaning up the previous allocations
> if one fails, so it's going to leak all that memory and the crypto tfms.
> 
> Update seg6_hmac_exit to only free the memory when allocated, so we can
> reuse the code directly.
> 
> Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Closes: https://lore.kernel.org/netdev/Zj3bh-gE7eT6V6aH@hog/
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] ipv6: sr: fix memleak in seg6_hmac_init_algo
    https://git.kernel.org/netdev/net/c/efb9f4f19f8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



