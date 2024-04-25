Return-Path: <netdev+bounces-91370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284BF8B2560
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DB51C22FB4
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F55F14C5A9;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f62C9s2D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E614C59C
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059630; cv=none; b=C5oTiqZy3aYwksJV/A9Qkvo9sNR0uyvLGUqgHepJT7xKoowKL6dcX527zhy1L1W3wTPwnRYIWh6VMS+9Xomc8GOCW/mMwu2pN17Yj7T84YNMOk/Yh7vbUjLWq427fLSpF+GZ1JoU8HPYJ2/M9u6yRz6ol0nNeLMJdiQFUOuAEa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059630; c=relaxed/simple;
	bh=EzGKPy2St3dfFz8dVbWEjC4xNtRIUAyWGJXbDIimF4I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cwPJwFxWdoM8x1+QeY/u/i7Su3uYqwNoND/xJoa4ZPISpZ9QQBA/1o/0abllCG/asxJqf1c70x8oNTa8bWODseBfFTzbmRMvNbZwTaOiGNxUAMCYw7yp/tgl1RrJAyU9iz+ZnVy0wCMVYudu+1o3cOINHrya1yzMXQc4tBmjEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f62C9s2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AC24C113CC;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714059630;
	bh=EzGKPy2St3dfFz8dVbWEjC4xNtRIUAyWGJXbDIimF4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f62C9s2DvzeNPgm7d7V3wgShqynr6sb3rAxqY1oCsixCCEf9o18U9VtDy8lPSpuz3
	 eeDe+tNS4UFjUDz3SIxV4tBKF8XG+cTCdfzGjCdphlCPdmzxAhH5yfuyxcDUitsrW3
	 zqHCwKRl2qxXFYNRFErAExhOAf5vejwq2ZaSjROQr26rthVuyVEBoqVbR0igZIZOh1
	 CdjxDuZwa9V++vIx1S5pbVgghdDfnhhHYxnvL3UJhNzKRoX6eYsT6PR+xjF34gr3hJ
	 qUByHFEqkVdgjtGDYhiK3M83cVyGuvlqj1le4lHWCw6pDWjRuO+D8Ipzb58KvtIrcT
	 mbY9OLbN3UGow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3859C595C5;
	Thu, 25 Apr 2024 15:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tls: fix lockless read of strp->msg_ready in ->poll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171405962999.10966.471620243473812058.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 15:40:29 +0000
References: <0b7ee062319037cf86af6b317b3d72f7bfcd2e97.1713797701.git.sd@queasysnail.net>
In-Reply-To: <0b7ee062319037cf86af6b317b3d72f7bfcd2e97.1713797701.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 borisp@nvidia.com, john.fastabend@gmail.com, davem@davemloft.net,
 edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 12:25:47 +0200 you wrote:
> tls_sk_poll is called without locking the socket, and needs to read
> strp->msg_ready (via tls_strp_msg_ready). Convert msg_ready to a bool
> and use READ_ONCE/WRITE_ONCE where needed. The remaining reads are
> only performed when the socket is locked.
> 
> Fixes: 121dca784fc0 ("tls: suppress wakeups unless we have a full record")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> [...]

Here is the summary with links:
  - [net] tls: fix lockless read of strp->msg_ready in ->poll
    https://git.kernel.org/netdev/net/c/0844370f8945

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



