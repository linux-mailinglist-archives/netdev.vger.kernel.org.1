Return-Path: <netdev+bounces-28986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24A178156C
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22731C20B96
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2602D174DA;
	Fri, 18 Aug 2023 22:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1021C28D
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 22:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86FBFC433C9;
	Fri, 18 Aug 2023 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692397823;
	bh=hOQvzHe0FXjb200W+nCzgOuxZ3QOCM0T3oXZmxOklDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S69oYjOYsAa1s0UQe4Pg7XKQx/xzu9x+3qPIBgt/3f1RxmQR9gPWsBmgUREfZ60ft
	 4j0BJ8d80BDnJXVZFA/GOafBUOWNHI/yIpFsRgYO8bZHNGlssm7p8dHCfoDBwiJ5IH
	 i2MIB4mPilbRiDj9qsZWrHjAO9c8O5jhi3NBG3FzC+TRpOBsgdk2bgs2VLy972TY9l
	 c5F45PKT/Y00IvI2oJFIMpVxouXu0X6YBiecCytvCxOH4qa332JZkVt+byQ5v37JFy
	 ZW8di8fv2ct/adgiMIyE3ic+SScETPLYTC6DbPYAMwNxr7wSXxLJ/jsDIv1DVpmOs7
	 MjUjykP3/niKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69B88E26D32;
	Fri, 18 Aug 2023 22:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3][pull request] virtchnl: fix fake 1-elem arrays
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169239782342.29271.2971755724203806921.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 22:30:23 +0000
References: <20230816210657.1326772-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230816210657.1326772-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, aleksander.lobakin@intel.com,
 andriy.shevchenko@linux.intel.com, larysa.zaremba@intel.com,
 keescook@chromium.org, gustavoars@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 16 Aug 2023 14:06:54 -0700 you wrote:
> Alexander Lobakin says:
> 
> 6.5-rc1 started spitting warning splats when composing virtchnl
> messages, precisely on virtchnl_rss_key and virtchnl_lut:
> 
> [   84.167709] memcpy: detected field-spanning write (size 52) of single
> field "vrk->key" at drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1095
> (size 1)
> [   84.169915] WARNING: CPU: 3 PID: 11 at drivers/net/ethernet/intel/
> iavf/iavf_virtchnl.c:1095 iavf_set_rss_key+0x123/0x140 [iavf]
> ...
> [   84.191982] Call Trace:
> [   84.192439]  <TASK>
> [   84.192900]  ? __warn+0xc9/0x1a0
> [   84.193353]  ? iavf_set_rss_key+0x123/0x140 [iavf]
> [   84.193818]  ? report_bug+0x12c/0x1b0
> [   84.194266]  ? handle_bug+0x42/0x70
> [   84.194714]  ? exc_invalid_op+0x1a/0x50
> [   84.195149]  ? asm_exc_invalid_op+0x1a/0x20
> [   84.195592]  ? iavf_set_rss_key+0x123/0x140 [iavf]
> [   84.196033]  iavf_watchdog_task+0xb0c/0xe00 [iavf]
> ...
> [   84.225476] memcpy: detected field-spanning write (size 64) of single
> field "vrl->lut" at drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1127
> (size 1)
> [   84.227190] WARNING: CPU: 27 PID: 1044 at drivers/net/ethernet/intel/
> iavf/iavf_virtchnl.c:1127 iavf_set_rss_lut+0x123/0x140 [iavf]
> ...
> [   84.246601] Call Trace:
> [   84.247228]  <TASK>
> [   84.247840]  ? __warn+0xc9/0x1a0
> [   84.248263]  ? iavf_set_rss_lut+0x123/0x140 [iavf]
> [   84.248698]  ? report_bug+0x12c/0x1b0
> [   84.249122]  ? handle_bug+0x42/0x70
> [   84.249549]  ? exc_invalid_op+0x1a/0x50
> [   84.249970]  ? asm_exc_invalid_op+0x1a/0x20
> [   84.250390]  ? iavf_set_rss_lut+0x123/0x140 [iavf]
> [   84.250820]  iavf_watchdog_task+0xb16/0xe00 [iavf]
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] virtchnl: fix fake 1-elem arrays in structs allocated as `nents + 1` - 1
    https://git.kernel.org/netdev/net-next/c/dd2e84bb3804
  - [net-next,2/3] virtchnl: fix fake 1-elem arrays in structures allocated as `nents + 1`
    https://git.kernel.org/netdev/net-next/c/5e7f59fa07f8
  - [net-next,3/3] virtchnl: fix fake 1-elem arrays for structures allocated as `nents`
    https://git.kernel.org/netdev/net-next/c/b0654e64dbaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



