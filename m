Return-Path: <netdev+bounces-199248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D72EADF8C1
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCE15601B4
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394AA27E1B1;
	Wed, 18 Jun 2025 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKhik2ib"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07327E069;
	Wed, 18 Jun 2025 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282180; cv=none; b=W4sKV+93ITSxTVC6v9Jb+lydD+1iOGJrdgMaQNepaP/2lT19rFCSL9ch2DckB59IlXR5zOcafgowN4Z552vjzT2Htfq7tuSyPhCYrs9iEniWjXg0MGWnWBGBLsQIDaWHYFkYoVzofmbtaduu+C5X4l6zm4GUrai3VRgocsQfsS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282180; c=relaxed/simple;
	bh=xhs7MTW33JCkEZr7vVn8yERLej8cPivMXeX6c7w9jxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U75qLe/7W1Fg6lG0zNH/a6zguH+Wf6nZ8ieGk1R+npjcWQcNJPIVl8RtATY9itOLkA1KBB9gHq/JIhkFIJDuJgGVVL1MsrE2kE9INBTgW+J4EYqqWrtFiH4QkLntRslu5FiGP2QTLRRgzhP9OSOrv/lqxhucqbKOGXQPwktCHII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKhik2ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959CAC4CEE7;
	Wed, 18 Jun 2025 21:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750282179;
	bh=xhs7MTW33JCkEZr7vVn8yERLej8cPivMXeX6c7w9jxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pKhik2ibkJj0A9493k6dUP/AC1DuG+JBU/QEztO9kI0T8Itu8bWkubxV5w/RCneR+
	 lcDBxGWdJxwX7UOm1AkyH3fbmB+Q9ntmD1cZfz3sdoK22w6npC17paeB28IeVk8NPq
	 2++FH62wXlqR8O9YcUVBbcjNUoKjRFi60+nbEZA0fZkSMMTMDNoxxotflRj9dL4tWF
	 FVY6R0anckQFd8+/8ofVcVXhZKDXhy9s2UDrWLTh3LE6MtgTGEspWwYOU0Jto8qXxK
	 +xqegOdrdIU0zWaykkxKfpbogj4vuY9lN8NIk7vwNtL0ShUpeee2jUbcuGNLNfYTi4
	 zT4GYpgPgx56g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1AFDE3806649;
	Wed, 18 Jun 2025 21:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net] Octeontx2-pf: Fix Backpresure configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175028220799.262925.2720863706360822624.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 21:30:07 +0000
References: <20250617063403.3582210-1-hkelam@marvell.com>
In-Reply-To: <20250617063403.3582210-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 12:04:02 +0530 you wrote:
> NIX block can receive packets from multiple links such as
> MAC (RPM), LBK and CPT.
> 
>        -----------------
>  RPM --|     NIX       |
>        -----------------
>              |
>              |
>             LBK
> 
> [...]

Here is the summary with links:
  - [net] Octeontx2-pf: Fix Backpresure configuration
    https://git.kernel.org/netdev/net/c/9ac8d0c640a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



