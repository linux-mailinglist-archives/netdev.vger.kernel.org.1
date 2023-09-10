Return-Path: <netdev+bounces-32739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9379799F40
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 20:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0159281139
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 18:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5308486;
	Sun, 10 Sep 2023 18:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04B8482
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 18:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAB7AC433CA;
	Sun, 10 Sep 2023 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694368821;
	bh=/Cuxjxh/BmObzyB1b26imUgPTVyoaQcCmOXUTNAGD1k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CnmfNVsfdOLSQS2jep9Dgn/fbLz03DN5Nxi/QOz/BVTeh03go28WygaKO/Av6TjzH
	 9AY9kNz1BVtuF5+VGrS33oKFwCYmS0SC6VbxnYUl7cNPefrAuCKhZ95yjc8M/MuImE
	 lgCI9XYVl8+TplW5MW+dbAH06HJJoZtXN0atrc54ymwCttLz9kS7zJSCZWjox7XSK0
	 buZgDUOmW18nP2D9QkmtqOYMhQQs16Oe6WPE15JcdUli+Aw5h6zy0BFRj9ovJ/nxTZ
	 Gy3BC8xSD3LJWw23E7eNpzFTlCC5sxVCLABfFDxs1XYWITkd1HvHWZyqhmYkBAZoxw
	 zbYerMBfBHg5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C325AE50D61;
	Sun, 10 Sep 2023 18:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: microchip: vcap api: Fix possible memory leak for
 vcap_dup_rule()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169436882179.20878.3372919952724343997.git-patchwork-notify@kernel.org>
Date: Sun, 10 Sep 2023 18:00:21 +0000
References: <20230907140359.2399646-1-ruanjinjie@huawei.com>
In-Reply-To: <20230907140359.2399646-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horatiu.vultur@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 7 Sep 2023 22:03:58 +0800 you wrote:
> Inject fault When select CONFIG_VCAP_KUNIT_TEST, the below memory leak
> occurs. If kzalloc() for duprule succeeds, but the following
> kmemdup() fails, the duprule, ckf and caf memory will be leaked. So kfree
> them in the error path.
> 
> unreferenced object 0xffff122744c50600 (size 192):
>   comm "kunit_try_catch", pid 346, jiffies 4294896122 (age 911.812s)
>   hex dump (first 32 bytes):
>     10 27 00 00 04 00 00 00 1e 00 00 00 2c 01 00 00  .'..........,...
>     00 00 00 00 00 00 00 00 18 06 c5 44 27 12 ff ff  ...........D'...
>   backtrace:
>     [<00000000394b0db8>] __kmem_cache_alloc_node+0x274/0x2f8
>     [<0000000001bedc67>] kmalloc_trace+0x38/0x88
>     [<00000000b0612f98>] vcap_dup_rule+0x50/0x460
>     [<000000005d2d3aca>] vcap_add_rule+0x8cc/0x1038
>     [<00000000eef9d0f8>] test_vcap_xn_rule_creator.constprop.0.isra.0+0x238/0x494
>     [<00000000cbda607b>] vcap_api_rule_remove_in_front_test+0x1ac/0x698
>     [<00000000c8766299>] kunit_try_run_case+0xe0/0x20c
>     [<00000000c4fe9186>] kunit_generic_run_threadfn_adapter+0x50/0x94
>     [<00000000f6864acf>] kthread+0x2e8/0x374
>     [<0000000022e639b3>] ret_from_fork+0x10/0x20
> 
> [...]

Here is the summary with links:
  - [net] net: microchip: vcap api: Fix possible memory leak for vcap_dup_rule()
    https://git.kernel.org/netdev/net/c/281f65d29d6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



