Return-Path: <netdev+bounces-219760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50774B42E3B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A188717E325
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0901A1B21BD;
	Thu,  4 Sep 2025 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFK127CX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84091A83FB
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945805; cv=none; b=vE+wHjneNAR+28sRS/SIkbmF+YcVekWFhC4XAIf9RWs8F7jYJbQKI2UGRsKUryZi7hr/kGda3p22JCA03V7AUYKiCDWF8Kboad8NEw5voX+yy6qR/HevXk/DxpQoIByiCFvddybK6NhA2vDwtfbdaAE4Erg2Uh8d4p1aF0UxzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945805; c=relaxed/simple;
	bh=q4Q8OmbtTo6/Zs7fSvk5Rf7z9OKc0Y/34vp5LouNu10=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ch7u1+9M0sztxAKOts7ZHgPW/m+ZDaoebj9a+sXI/jXNPNqhdO0TetYygV1rT9NNZhyOxt4CAoNWvDyGI32xcYFDB6lLkSTo3uwXXt0PJmbDj9b5lR68MCpVKAF/sIimR8JHlm7n+wMyZELpy72aJ2FNdnIdG76O3qijN5GhWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFK127CX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8287C4CEE7;
	Thu,  4 Sep 2025 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756945805;
	bh=q4Q8OmbtTo6/Zs7fSvk5Rf7z9OKc0Y/34vp5LouNu10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OFK127CXdtibx7BqHLMAt//bS8h9dd/WHyEGI8eyaXK8OUeBcpdwzLm49lHRSW3jc
	 13WQnKx/jGHG/HQXzAX2u3uJqRhx6bvLdMuQzzYZb4qvzEiOIOH3OpAzrMLWy9GlyG
	 KfCFYLN97ldXQkPvdnlfEQJMY53IiVf8K7duGhPtVlqiahNq7r206jrswS7YLc84EC
	 l8n2JGpoyveWiwcpFItWK49R7Gq73CKx9QWabYBrECGpO6zyTtDuaMjr27ltTRAnhm
	 I9IqsHVMdYO0Pjx4VhjK7A3ZykhDjurnPA5m0GhoIZ/R4jCF/M7EoU738pqtKc/ks6
	 50pX2khdgfyzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB37A383C259;
	Thu,  4 Sep 2025 00:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mctp: return -ENOPROTOOPT for unknown getsockopt
 options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175694581074.1248581.9134254396647097878.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 00:30:10 +0000
References: <20250902102059.1370008-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250902102059.1370008-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Sep 2025 03:20:55 -0700 you wrote:
> In mctp_getsockopt(), unrecognized options currently return -EINVAL.
> In contrast, mctp_setsockopt() returns -ENOPROTOOPT for unknown
> options.
> 
> Update mctp_getsockopt() to also return -ENOPROTOOPT for unknown
> options. This aligns the behavior of getsockopt() and setsockopt(),
> and matches the standard kernel socket API convention for handling
> unsupported options.
> 
> [...]

Here is the summary with links:
  - [net] mctp: return -ENOPROTOOPT for unknown getsockopt options
    https://git.kernel.org/netdev/net/c/a125c8fb9ddb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



