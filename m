Return-Path: <netdev+bounces-189411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE864AB205E
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C8AB21874
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 23:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC31267736;
	Fri,  9 May 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT4PhtEX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A3267728
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746834607; cv=none; b=AsBky8tznY8dYPXjyN306Cdcugy7qx2hWmqpkTtSK/ncpf449nWchHzSEoAOTswrCu1c7l9gFK4B09pngvrY3jS+KrQEdx7qriEi1JAy3ct2MMewNAEaxCbOKFqIqBht8juwU6qPzlJaWwaC23Ax9WAvR7tdYa9KIe4W3gsz1Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746834607; c=relaxed/simple;
	bh=kP4AsxQa5haOUwla+8nEJOkjvrvjmPyrTLAVL8UXmmE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qDcu8LqxQ4FiNsHLZYbk962HEVm95gsR7Z5cp5duVwt9VMMRIEHLFMaGRPc+R3eSVn178iZ6lt3xCd3/PWyRZLM74pVXd0sNTyLC6rvFh1B2v9ZAA4QU7asDBwJFmoSb03vNBa7vRR0kRoEIigC+WUmdTFTuiqhz6M81YXGv2F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT4PhtEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554D6C4CEEE;
	Fri,  9 May 2025 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746834607;
	bh=kP4AsxQa5haOUwla+8nEJOkjvrvjmPyrTLAVL8UXmmE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sT4PhtEXMQRJxIKVGxlNuQ8j0RTwV7Qpzm//cTicwQewL6HCmQxvmGdIlGh1GyCdj
	 EW2tdEHZTJwjY+UKmDikCEbC2kVY3my01ASWCU2LgUJodiQgDM+C7sGmTMAotYpBBK
	 nXeBKlpV/VUPP1ygGik6MaiiCj8olyl9zvOnPvOVvyoj1pp22FYelSWHGUf4OhFPOd
	 MdYuttlgIAgkjZ9LB+0E2+9pDOkqO1fGnLSCfz0tqWFltmwt1/i7/FlrBzlTaFpwZp
	 g56PEa1cDA7rERK02qThSsyKou2hPXFFZ6gGJacYJaD0mLDSmUl2b6HEWjm1xSNCxd
	 9v1B+T16cnjSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADC0381091A;
	Fri,  9 May 2025 23:50:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] tools: ynl: handle broken pipe gracefully in CLI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174683464575.3845363.2215498873352428279.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 23:50:45 +0000
References: <20250508112102.63539-1-donald.hunter@gmail.com>
In-Reply-To: <20250508112102.63539-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 jstancek@redhat.com, donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 May 2025 12:21:02 +0100 you wrote:
> When sending YNL CLI output into a pipe, closing the pipe causes a
> BrokenPipeError. E.g. running the following and quitting less:
> 
> ./tools/net/ynl/pyynl/cli.py --family rt-link --dump getlink | less
> Traceback (most recent call last):
>   File "/home/donaldh/net-next/./tools/net/ynl/pyynl/cli.py", line 160, in <module>
>     main()
>     ~~~~^^
>   File "/home/donaldh/net-next/./tools/net/ynl/pyynl/cli.py", line 142, in main
>     output(reply)
>     ~~~~~~^^^^^^^
>   File "/home/donaldh/net-next/./tools/net/ynl/pyynl/cli.py", line 97, in output
>     pprint.PrettyPrinter().pprint(msg)
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^
> [...]
> BrokenPipeError: [Errno 32] Broken pipe
> 
> [...]

Here is the summary with links:
  - [net-next,v1] tools: ynl: handle broken pipe gracefully in CLI
    https://git.kernel.org/netdev/net-next/c/0df6932485a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



