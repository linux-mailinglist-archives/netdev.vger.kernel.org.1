Return-Path: <netdev+bounces-46234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C31527E2AD9
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 18:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E657B20EFB
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABD829CF0;
	Mon,  6 Nov 2023 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ect+N6Nh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6912941E
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 17:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4BD0C433CA;
	Mon,  6 Nov 2023 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699291225;
	bh=0Y41t+A8YImz/2ZSKmKP3b9XBDxUmJyRiQu7FUKAwpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ect+N6NhwDV3K/SR60icyLlHJq3BPD2no1mcsG4SqE97jUiGInHzd1oRN7tdtP6MR
	 IOAxRVymbtR43OPqB2Q6LXfggjQwUbGjIIjQtZtRNriyoI4R5ZTWRiVDCa4A9WxvK7
	 M7FId9pDb3jETBkNSqSMFsM2skyFFD28sVS93WhvytHzSv7WiRCCl2fQtJH5CeXiE4
	 K8PC4lUG1+6B1rxNqPwqMW4k2GGQevvv1Z7sXg0X1UoX6SeSp7mKfVbCIygeP1mPCf
	 f+dT+RvJ9/aeckaGv8mkhC35bC4BZtIeDHRlZ/KMT+h+FvaChoYzXhPDQriEnIEifs
	 hou8mNXA4SqZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B9DDC00446;
	Mon,  6 Nov 2023 17:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2] bridge: mdb: Add get support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169929122563.9490.9075171205269038926.git-patchwork-notify@kernel.org>
Date: Mon, 06 Nov 2023 17:20:25 +0000
References: <20231101074510.1471018-1-idosch@nvidia.com>
In-Reply-To: <20231101074510.1471018-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 razor@blackwall.org, mlxsw@nvidia.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 1 Nov 2023 09:45:10 +0200 you wrote:
> Implement MDB get functionality, allowing user space to query a single
> MDB entry from the kernel instead of dumping all the entries. Example
> usage:
> 
>  # bridge mdb add dev br0 port swp1 grp 239.1.1.1 vid 10
>  # bridge mdb add dev br0 port swp2 grp 239.1.1.1 vid 10
>  # bridge mdb add dev br0 port swp2 grp 239.1.1.5 vid 10
>  # bridge mdb get dev br0 grp 239.1.1.1 vid 10
>  dev br0 port swp1 grp 239.1.1.1 temp vid 10
>  dev br0 port swp2 grp 239.1.1.1 temp vid 10
>  # bridge -j -p mdb get dev br0 grp 239.1.1.1 vid 10
>  [ {
>          "index": 10,
>          "dev": "br0",
>          "port": "swp1",
>          "grp": "239.1.1.1",
>          "state": "temp",
>          "flags": [ ],
>          "vid": 10
>      },{
>          "index": 10,
>          "dev": "br0",
>          "port": "swp2",
>          "grp": "239.1.1.1",
>          "state": "temp",
>          "flags": [ ],
>          "vid": 10
>      } ]
>  # bridge mdb get dev br0 grp 239.1.1.1 vid 20
>  Error: bridge: MDB entry not found.
>  # bridge mdb get dev br0 grp 239.1.1.2 vid 10
>  Error: bridge: MDB entry not found.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2] bridge: mdb: Add get support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=77138a2f9477

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



