Return-Path: <netdev+bounces-151299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E86B9EDE91
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E3D1632E3
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925A617CA0B;
	Thu, 12 Dec 2024 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbpim2f6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6BE17C230
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733978419; cv=none; b=co81zrs87Y44K2SlVFAjqEsRnI6Avd1+IMpbjA5ZcvNDTXzlKVepS50hDvsjIGEHP81+WoZI0JCZ3PGTPDQ988v8DGROQe+XSP3ZophSyX/TQ+jVa8fs2vCfrYVWl1d4HeMVO4LoRgmie+g8eL4V5Ky7vwIb+A/y7y14lNUOc0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733978419; c=relaxed/simple;
	bh=S0JkvsaRuxaDyi1rKwuqdhCsry5TNd59yyrFiU28LLU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ukDryTz+nLNVKLLzL62CNVvRoOmb+5iTcn0IakwNXiKSfDacr1T1dNYIsztCRMjIT2SChdx8Tqx0a/kZzQ5DndiEY4ouBgCn4AQa+j6JhRD1QFEqOveJfgABTIys/A3u3qlHHQNLm1zrNtaqc2XcOaOA7oVVXJariF6lKCScG/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbpim2f6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DA2C4CECE;
	Thu, 12 Dec 2024 04:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733978418;
	bh=S0JkvsaRuxaDyi1rKwuqdhCsry5TNd59yyrFiU28LLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gbpim2f6pHF/09HxHKxQmH7sFTpNUCq1vxgS/SGgmMHQHM1gjErRKeiDreRawBiGo
	 df+AQW8/fze2nx6045hGV72WGweREGHlMaqjFSPXqNVMxNKdV4LPDLZGJ6cd72yfNw
	 3b08MP9yqjZDXPVVFDmyqiQu5DyTY2shNYaysvji53yvWo+E9okXXybRtfCE5/NaGG
	 SbyLTixftREZm5MBypZyJaoMnmb25F10HzxuMICIn98TYi1P4xbmdZCpPBCsIv1F2o
	 dv8D6EfeWfggpB59YrmMuzcqUzR3bCHIerY9pvrFEqC5O8vumOWQxv42Wj9pjyn+py
	 xLqz3/j1RlJlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C31380A959;
	Thu, 12 Dec 2024 04:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: felix: fix stuck CPU-injected packets with
 short taprio windows
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397843484.1849456.1533448940359562730.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:40:34 +0000
References: <20241210132640.3426788-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241210132640.3426788-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
 xiaoliang.yang_1@nxp.com, yangbo.lu@nxp.com, radu-andrei.bulie@nxp.com,
 michael@walle.cc

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Dec 2024 15:26:40 +0200 you wrote:
> With this port schedule:
> 
> tc qdisc replace dev $send_if parent root handle 100 taprio \
> 	num_tc 8 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
> 	map 0 1 2 3 4 5 6 7 \
> 	base-time 0 cycle-time 10000 \
> 	sched-entry S 01 1250 \
> 	sched-entry S 02 1250 \
> 	sched-entry S 04 1250 \
> 	sched-entry S 08 1250 \
> 	sched-entry S 10 1250 \
> 	sched-entry S 20 1250 \
> 	sched-entry S 40 1250 \
> 	sched-entry S 80 1250 \
> 	flags 2
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: felix: fix stuck CPU-injected packets with short taprio windows
    https://git.kernel.org/netdev/net/c/acfcdb78d5d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



