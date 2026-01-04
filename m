Return-Path: <netdev+bounces-246793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 871F0CF12FC
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 19:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C271F30056C1
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 18:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7392D7DDB;
	Sun,  4 Jan 2026 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+5L9hrr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761C72D7DC4;
	Sun,  4 Jan 2026 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767551164; cv=none; b=Qvr8R8kU9/bSzfUMQITjp1W2iiQWhGQ6Dk1Tyu+YgCqnR43/jpcx4Hy2rreruLYrYD8udo776G6u4w9jW4dqxZhkMqm0MUsZqme6FMxfCP6ot0l4AstDtuskQSaOqavA0Q+cuWVBlSw2Oq5mJrtBwFtGIYcrBS3M4db64oGMHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767551164; c=relaxed/simple;
	bh=CO2S7t9L6KKi/q5HQ9TVGnJjFJjVGfggW1WPU+Bh+q8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bhm4+T+ZVT0HiX7p4tpBxM9hhW1BUQw9eaqlehvWV4fWWs2OebPUoYodwMBHJyLmmfi9iN9BLImBG5chqbpAx/06Ge4rnBt/xNaa2VjcvfzMArRQl2QnI235KSHJF6/KaNw1h4AuKvnCEm+Tpnnago39pdLeymPKLFBJIXtXozQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+5L9hrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C5EC19421;
	Sun,  4 Jan 2026 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767551162;
	bh=CO2S7t9L6KKi/q5HQ9TVGnJjFJjVGfggW1WPU+Bh+q8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f+5L9hrrufJQZwG2rxtZp7xVC4dXelU9FarhzyMvI0YYH5AHy2ppLtl39PxgHuRmC
	 XKqdpQPKQCOqtGxxy4Es73vNf+s5KSnnvDpl8uHH7PjKs2uICElGGFMBz+cLcthAhM
	 P096DUo6Mzs2l1l0oiiLCTmOPoTdG9nEbs75n9uGrcDaciNeGOw7aXyPHVAojoEVah
	 gYathni/45kq8pH8kiQRrb/oUMHNR61n531Ieix+nBUPTOej/9hpWCMnGjTV/l8mWH
	 tZ6dL9iB+PY1J3YnPeurosnd1aeYXUAC1OLARfSgyHPVZ1q+9O9fpENAzDPJkThf4L
	 iUXuH6F5HShQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2ABF380AA4F;
	Sun,  4 Jan 2026 18:22:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: mscc: ocelot: Fix crash when adding interface
 under a lag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176755096153.142863.971381899802476876.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 18:22:41 +0000
References: <tencent_75EF812B305E26B0869C673DD1160866C90A@qq.com>
In-Reply-To: <tencent_75EF812B305E26B0869C673DD1160866C90A@qq.com>
To: Jerry Wu <w.7erry@foxmail.com>
Cc: vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
 alexandre.belloni@bootlin.com, andrew+netdev@lunn.ch,
 christophe.jaillet@wanadoo.fr, claudiu.manoil@nxp.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Dec 2025 20:36:17 +0000 you wrote:
> Commit 15faa1f67ab4 ("lan966x: Fix crash when adding interface under a lag")
> fixed a similar issue in the lan966x driver caused by a NULL pointer dereference.
> The ocelot_set_aggr_pgids() function in the ocelot driver has similar logic
> and is susceptible to the same crash.
> 
> This issue specifically affects the ocelot_vsc7514.c frontend, which leaves
> unused ports as NULL pointers. The felix_vsc9959.c frontend is unaffected as
> it uses the DSA framework which registers all ports.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: mscc: ocelot: Fix crash when adding interface under a lag
    https://git.kernel.org/netdev/net/c/34f3ff52cb9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



