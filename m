Return-Path: <netdev+bounces-184567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD13AA963B5
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA851888421
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E653253F1B;
	Tue, 22 Apr 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep8keecx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A045253947
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312968; cv=none; b=Zh8q9VTi3iFKYHnD6wiN1BosPN2fTkA1wsvOjOX4WCLGHNlrnOlrFH76ixY+a6a9DDD3kGjsgFHRjueyiniOCWxKiyRFYDIEuxuaGu2bgNs3KSBhJFmCcHjKdwB5rwDzCoGHZilrWnyukhACP6wUD7BwDDMXXesR7roXeYATaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312968; c=relaxed/simple;
	bh=sUEAWHCQA+dOg/EDk5/UP7oO24mVup92Rfh3+Pui2tg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uKREwpdl2Fyh9+yavkRyejQKnvnOd+NOXUE5aezeh473gblIEqwN8HmExO+l+xadVM+oGPy0S89U03wHHa3J4g/XGD0HU5Ek/LV3Jz73F6lDHBfsGtJvKKHF3rC85dhUQAwJHkH59hwLOs2thkrY2Cw8Qzk+gBlGbg7FQEsPw4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep8keecx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F48C4CEE9;
	Tue, 22 Apr 2025 09:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745312968;
	bh=sUEAWHCQA+dOg/EDk5/UP7oO24mVup92Rfh3+Pui2tg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ep8keecxfVCsbBwZicDUrVppig2hrDJr5eejofH7JNNn7CghFR5MK0Kvv67gRMnN8
	 6gOLaFvkiAMGiXeBQOWdLjdC/24YHQ5PVjTzy/q4XSbq/DmjOkP027pZoot3IqSIbn
	 Ywhut6ISS4dRKAvsd6d1EPh0mk1Kaq8OJZpl9tK4m1/LRV7pWU1fEFLbMEV2XPg/pX
	 7fNwx/1smiHGD6W+dQo4BPpVo5pJadl316pmK/Gwd6lONfGWisk/KdU6Fa5urhMIYx
	 8VfmOAYKZwR62/t6EDvosJN4r7xQlkVt7e2gTUtfEVeajRO9MqGx8RkQBOU8z/rVcZ
	 vYjckoVO4u1Cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEBD439D6546;
	Tue, 22 Apr 2025 09:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix the missing unlock for detached devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531300624.1477965.9431180923272525735.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:10:06 +0000
References: <20250418015317.1954107-1-kuba@kernel.org>
In-Reply-To: <20250418015317.1954107-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jdamato@fastly.com, almasrymina@google.com, sdf@fomichev.me,
 ap420073@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Apr 2025 18:53:17 -0700 you wrote:
> The combined condition was left as is when we converted
> from __dev_get_by_index() to netdev_get_by_index_lock().
> There was no need to undo anything with the former, for
> the latter we need an unlock.
> 
> Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: fix the missing unlock for detached devices
    https://git.kernel.org/netdev/net/c/d3153c3b4270

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



