Return-Path: <netdev+bounces-234215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B5FC1DEF5
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A569218979CE
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05361F8AC8;
	Thu, 30 Oct 2025 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTa5D6su"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90A21F3FED;
	Thu, 30 Oct 2025 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784852; cv=none; b=PL1ghOD4JcAN9TBTyeKIRxmXXevkBAEqXdbj0EK5rI5mVl3Wh2FY9U15P2PAfCn0GhZIHRv+UgJVb2qQtv+QLqqtUQIoqQw9R7Jcrront7kabtvXYO6xMjINOxdWFfV05rSX1DYizoSOu+bVpxJ1q6fhxQrE4I10R4cHtPnRSRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784852; c=relaxed/simple;
	bh=+yxQXZN6cadN8Rk+gu/i7BpuiNv0tj6KuVk5oI7cWJ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bIalRa+SGoaZijGfJxYSxqSqSa2yuEn9FN0RaZdL8w2ZXBNRFQomr9nu8T24YPIg585kWGp/MjSRSYB4VBzR56Xmpe64+Rcqq5Pkp680gBV5WzE4llpznO+GsN6gKWjriHOaOUeKsUeBNC4xgEIZ0xUFNy3mtLsfA+UbKPZwXFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTa5D6su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A993C4CEFF;
	Thu, 30 Oct 2025 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761784852;
	bh=+yxQXZN6cadN8Rk+gu/i7BpuiNv0tj6KuVk5oI7cWJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UTa5D6suNMQyAwR0WoGIFpVXxAA2m51fogeG3mK5+68f/SjsEuvflGOiLdG6S9nZl
	 HNVwsi+amIbmnAGPZSqB8yGkye3CFpAsxrcXlYRFkAgFDXVrMLrloq+7kR15ReetF9
	 xkJm+xVnFnRg0fEX7/hUKjLEIG81MDgf63REYIt6bm1wzMWWnPzX12nZ0O8CjHE2lG
	 liTPzEFgYxUA7itMgIx+6Rt9P5ogXL8Tu78QukNM36qAQ+JNywxEF/GAbiR6BvXQz5
	 pNP+ugZLFNIh8kfKBj943rQiNgFCrO87bjnk0rkjqibdts+paOjeCahes8Eo+Uad99
	 fyfXSieKJvnsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD793A55EC7;
	Thu, 30 Oct 2025 00:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] nfp: xsk: fix memory leak in nfp_net_alloc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178482924.3264893.15514212203966183854.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 00:40:29 +0000
References: <20251028160845.126919-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20251028160845.126919-1-nihaal@cse.iitm.ac.in>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: kuba@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 oss-drivers@corigine.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Oct 2025 21:38:41 +0530 you wrote:
> In nfp_net_alloc(), the memory allocated for xsk_pools is not freed in
> the subsequent error paths, leading to a memory leak. Fix that by
> freeing it in the error path.
> 
> Fixes: 6402528b7a0b ("nfp: xsk: add AF_XDP zero-copy Rx and Tx support")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> 
> [...]

Here is the summary with links:
  - [net,v2] nfp: xsk: fix memory leak in nfp_net_alloc()
    https://git.kernel.org/netdev/net/c/a4384d786e38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



