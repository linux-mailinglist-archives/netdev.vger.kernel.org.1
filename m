Return-Path: <netdev+bounces-211641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A38AB1ABC2
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 02:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C4E189EE0B
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 00:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9961F1DED49;
	Tue,  5 Aug 2025 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtSbEQMD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C0D1DE3DC
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754353812; cv=none; b=a1h6bjSYl+Y/LPJJuRS/rxxKjT7M8ZFzTchpPLtd/WG0unhx7OpVjQN0zd7TGOKSPna59Wmr+1d4gEyVnmPcOZxCqghHWdekBD0VLOHerOD96yLMsMQ/QgPgPPpdcWXnYFcuoKuR0+3+1+aR61BFmND3QjRKhlz8/KYbVjP6DSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754353812; c=relaxed/simple;
	bh=/hz+/ShMZPB9HEA0gZc1Q59ZDmBpLB9UxtC9IxTUw1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cM50WuWEq5b8CYrGToB7LI2iG6sZ54+wUb2gpAmPPXccxDCA1S1qRYYvcG61Yh3rvuWAUQPNAkJi+UK8er9oTNseMPAIe/2KR2niY74ITaDxVmfdvR1y0MPRDKYL7Sp74eUNisdKcnrUnCCnuQUfStmOenQFG/As5SOANxQjMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtSbEQMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABACC4CEE7;
	Tue,  5 Aug 2025 00:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754353811;
	bh=/hz+/ShMZPB9HEA0gZc1Q59ZDmBpLB9UxtC9IxTUw1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MtSbEQMDEn3TMugAgPZQakKDX38YhJzuOc62M0jLt60egnJ+baqx+z759QzZOPDiC
	 N3ZpWhRjyFzeWoUeqZbFRLftyr9VCrMdJ1NnmBN/y7XsmAjc4Zy9H9taAky/O8ILei
	 opzZWOzfCtt1VfFRZU//rOu23K9D5T7ttj5JlK71DyEHO/ltZn/ou3ilsoH0FJbe0c
	 umGf7D3303f32X+QxZbV9QQiAOiGgD9UE9ET4OtEY15t6moWgr0BnLwAIGZx4b2FRi
	 RTMky0PoakBcxV5NcwKfEhJxzEANkjSmT/jrb9lS4nS+kkgwD/47caDoLq1JE7EeWb
	 Wa+74dnGftDgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70A6C383BF62;
	Tue,  5 Aug 2025 00:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: unlink NAPIs from queues on error to open
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175435382599.1400451.2596068908242248533.git-patchwork-notify@kernel.org>
Date: Tue, 05 Aug 2025 00:30:25 +0000
References: <20250728163129.117360-1-kuba@kernel.org>
In-Reply-To: <20250728163129.117360-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 alexanderduyck@fb.com, mohsin.bashr@gmail.com, vadim.fedorenko@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Jul 2025 09:31:29 -0700 you wrote:
> CI hit a UaF in fbnic in the AF_XDP portion of the queues.py test.
> The UaF is in the __sk_mark_napi_id_once() call in xsk_bind(),
> NAPI has been freed. Looks like the device failed to open earlier,
> and we lack clearing the NAPI pointer from the queue.
> 
> Fixes: 557d02238e05 ("eth: fbnic: centralize the queue count and NAPI<>queue setting")
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: unlink NAPIs from queues on error to open
    https://git.kernel.org/netdev/net/c/4b31bcb025cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



