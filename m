Return-Path: <netdev+bounces-172625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7373CA55912
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF967A9057
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69FD26FD9A;
	Thu,  6 Mar 2025 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQZufM30"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818FB20764E
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297821; cv=none; b=JLv7lvpkljWEziAjyJ/7mPSIqfiA6sK8ODdd3cX9IRARNifqTvUtEts7jApubdcdAXjDPrb5K7puxoPp/bAvTTqNp60I2u9EL/TpE4lNmVPwOCpPuu56PA7EaiVCLLuzyQCIrxBo0kLC6xicmWYB0v9FIBqyQolufZh4WYsOzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297821; c=relaxed/simple;
	bh=wEmmL+hhFDbjgw0/bq8DVgoZ99wj4lATLiWtnzra4t0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iFsVMAKNgeIHX5FTTwD3RNY4/45EuMtx3E9X7xN+MDyLSacuV8iS09Gy/oQ0djH1HxYxl1uquK0F3WeYTS70MVC4l48zuexuPopGnNhuuDUkADnl7Oypd97IMIO3NE2gOly0nz2NI1t6N4cfcw4TvS2qCOoSMsGU14WCS88IY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQZufM30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD972C4CEE0;
	Thu,  6 Mar 2025 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741297820;
	bh=wEmmL+hhFDbjgw0/bq8DVgoZ99wj4lATLiWtnzra4t0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vQZufM30fQW90ekfAs00gDwQJDidjkshmw6a80u2NKOiQ90FUUBKNAq/gT2cKm4Z2
	 jdd01eIX+mQjdGUfk4tDxYeKwn/IJn6m85+BfPlT46sV71RYFmYMJxJ06eZEHM+JkG
	 HoZql3aaaWefKh6EDNkQQ+FP9piX7dq0ncR0OKYoKBc8N9qhOsC0e+CaSaa2eUBiJ0
	 +EkWCdvDh0G1aqDgh0dYtAoeF12rDMvumYsGHhchMDJYDqZZ7U29hOS5CudiyCCseW
	 dM9MqF5XIEw0VYT1hr8ZHWYu+tYdW12Q9/+HIzdAPqmqNbNwmaoQBb10FPPArZ1GZt
	 3EUh9zYnI2bmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E8E380CEE6;
	Thu,  6 Mar 2025 21:50:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 00/14] net: Hold netdev instance lock during ndo
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174129785425.1790842.9872735858764773480.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 21:50:54 +0000
References: <20250305163732.2766420-1-sdf@fomichev.me>
In-Reply-To: <20250305163732.2766420-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, saeed@kernel.org, dw@davidwei.uk

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Mar 2025 08:37:18 -0800 you wrote:
> As the gradual purging of rtnl continues, start grabbing netdev
> instance lock in more places so we can get to the state where
> most paths are working without rtnl. Start with requiring the
> drivers that use shaper api (and later queue mgmt api) to work
> with both rtnl and netdev instance lock. Eventually we might
> attempt to drop rtnl. This mostly affects iavf, gve, bnxt and
> netdev sim (as the drivers that implement shaper/queue mgmt)
> so those drivers are converted in the process.
> 
> [...]

Here is the summary with links:
  - [net-next,v10,01/14] net: hold netdev instance lock during ndo_open/ndo_stop
    https://git.kernel.org/netdev/net-next/c/d4c22ec680c8
  - [net-next,v10,02/14] net: hold netdev instance lock during nft ndo_setup_tc
    https://git.kernel.org/netdev/net-next/c/c4f0f30b424e
  - [net-next,v10,03/14] net: sched: wrap doit/dumpit methods
    https://git.kernel.org/netdev/net-next/c/7c79cff95535
  - [net-next,v10,04/14] net: hold netdev instance lock during qdisc ndo_setup_tc
    https://git.kernel.org/netdev/net-next/c/a0527ee2df3f
  - [net-next,v10,05/14] net: hold netdev instance lock during queue operations
    https://git.kernel.org/netdev/net-next/c/cae03e5bdd9e
  - [net-next,v10,06/14] net: hold netdev instance lock during rtnetlink operations
    https://git.kernel.org/netdev/net-next/c/7e4d784f5810
  - [net-next,v10,07/14] net: hold netdev instance lock during ioctl operations
    https://git.kernel.org/netdev/net-next/c/ffb7ed19ac0a
  - [net-next,v10,08/14] net: hold netdev instance lock during sysfs operations
    https://git.kernel.org/netdev/net-next/c/ad7c7b2172c3
  - [net-next,v10,09/14] net: hold netdev instance lock during ndo_bpf
    https://git.kernel.org/netdev/net-next/c/97246d6d21c2
  - [net-next,v10,10/14] net: ethtool: try to protect all callback with netdev instance lock
    https://git.kernel.org/netdev/net-next/c/2bcf4772e45a
  - [net-next,v10,11/14] net: replace dev_addr_sem with netdev instance lock
    https://git.kernel.org/netdev/net-next/c/df43d8bf1031
  - [net-next,v10,12/14] net: add option to request netdev instance lock
    https://git.kernel.org/netdev/net-next/c/605ef7aec060
  - [net-next,v10,13/14] docs: net: document new locking reality
    https://git.kernel.org/netdev/net-next/c/cc34acd577f1
  - [net-next,v10,14/14] eth: bnxt: remove most dependencies on RTNL
    https://git.kernel.org/netdev/net-next/c/004b5008016a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



