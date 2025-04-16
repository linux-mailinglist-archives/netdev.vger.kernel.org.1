Return-Path: <netdev+bounces-183057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4AEA8AC99
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3CD17E0B9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3901A0730;
	Wed, 16 Apr 2025 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuX9ns0E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723C1917FB
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744762805; cv=none; b=q/U8M68BwyYqmZ656LJy9TSJjGdqsn6GUWEKswZvliBrH4WFjHzea1SjYFTMWn7Zz0VYatE0CFdZto73yK34fLDM2WeELBQKwH9kCbbtqKDfxgvNkFs0resSRk7P11KJH5cz9g7XwU8kpifKWIIFAj3zbe96v17pB3M+TvwxcV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744762805; c=relaxed/simple;
	bh=P9qhN+I0G9dBkBbQxoaswmA7CMa03Zf13kChZCSiFxQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XYjKoepVQEAn/IGusV7AvzvOUWKGJA5+xg3edljuOPAgoJFH4YrnYmECA5urm1Te8hWNUAv5CyIfKp3AzuDJxZkIGmmWKvH6CMwSAaXE5snnJLME15SN8lL430Blly7eqUPALOX89RrQ/NHD6j+oTXXeUaimp5xWQz7sOFLGgyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuX9ns0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83945C4CEEB;
	Wed, 16 Apr 2025 00:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744762804;
	bh=P9qhN+I0G9dBkBbQxoaswmA7CMa03Zf13kChZCSiFxQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AuX9ns0E7jmgwjQ6MWL9AIH6ZxHotb8JBjRCxK5XmiloKLMZkEuGFb/EgtrnW1JUz
	 tnuLtdSwAyNYZBx/p/bx9He67s06z0KYwrbj7f5s7uxjWl2JBQZV6ICgd+9uqZbGNh
	 0AI0fcpuYlZghKNU1s7hVZ9cijAB8Ob5pAUaU+bHXbf4XIk/7HdQxgPAd2ErYK/Sj8
	 vsPlkgbhxxkuN0iVYraPBcMT3b+yvGBQTUMxfXr6FGYY5iqBsJ6Ve62xBo9az9yx4a
	 +qO1riz08gP2yFFfi+rGQSg4nz6kiGvHUKWJw/MUCJGtt3qjRkgwY/lB1XiEr9TMT+
	 1uYzo4qpUUh4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE063822D55;
	Wed, 16 Apr 2025 00:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tc: Return an error if filters try to attach too
 many actions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174476284248.2824794.8083252026507275747.git-patchwork-notify@kernel.org>
Date: Wed, 16 Apr 2025 00:20:42 +0000
References: <20250409145523.164506-1-toke@redhat.com>
In-Reply-To: <20250409145523.164506-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Apr 2025 16:55:23 +0200 you wrote:
> While developing the fix for the buffer sizing issue in [0], I noticed
> that the kernel will happily accept a long list of actions for a filter,
> and then just silently truncate that list down to a maximum of 32
> actions.
> 
> That seems less than ideal, so this patch changes the action parsing to
> return an error message and refuse to create the filter in this case.
> This results in an error like:
> 
> [...]

Here is the summary with links:
  - [net-next] tc: Return an error if filters try to attach too many actions
    https://git.kernel.org/netdev/net-next/c/5f5f92912b43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



