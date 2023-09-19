Return-Path: <netdev+bounces-35004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5C7A66E7
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 16:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8D71C20A00
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28892E63C;
	Tue, 19 Sep 2023 14:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985281862B
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 14:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17E00C433C9;
	Tue, 19 Sep 2023 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695134423;
	bh=kryayjI+DpBs8BqT5LH6EtjtpekinSXNyepf9NYHdUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rz3hiMSFAtBm9z66sWV9YjXmMklF1B9UwmGiJPV2kZX7bxcVGQdtOdTSsawb2BKPg
	 OLqkIjUIoRwLf/g6khHFq/fojRe2ZMZkKCM1IQbbhvMHQgG4cn96etGL7wNYKlRqF/
	 vNOsGxFztDx0X+I+oJOIrYloAqTvtHr4PbXAn579y/zmf0nQYvL2+RK+wgiA7hsR6p
	 ZS1gSeOhk4je/4RFwJcMt7Ush46Eh9cAOmsP/OPKUYMAcS//fiub8dBSXIoeroJH6p
	 PfQRd6sgod4/Pig8oZt47cJH4edPYKP/MEND/fRjgRl9yNJ8VMfEcElksLbxku63Nm
	 c5X/2YI3b34iA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1A9AE11F4C;
	Tue, 19 Sep 2023 14:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] team: fix null-ptr-deref when team device type is
 changed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169513442298.2241.9179797432803836099.git-patchwork-notify@kernel.org>
Date: Tue, 19 Sep 2023 14:40:22 +0000
References: <20230918123011.1884401-1-william.xuanziyang@huawei.com>
In-Reply-To: <20230918123011.1884401-1-william.xuanziyang@huawei.com>
To: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 liuhangbin@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Sep 2023 20:30:11 +0800 you wrote:
> Get a null-ptr-deref bug as follows with reproducer [1].
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000228
> ...
> RIP: 0010:vlan_dev_hard_header+0x35/0x140 [8021q]
> ...
> Call Trace:
>  <TASK>
>  ? __die+0x24/0x70
>  ? page_fault_oops+0x82/0x150
>  ? exc_page_fault+0x69/0x150
>  ? asm_exc_page_fault+0x26/0x30
>  ? vlan_dev_hard_header+0x35/0x140 [8021q]
>  ? vlan_dev_hard_header+0x8e/0x140 [8021q]
>  neigh_connected_output+0xb2/0x100
>  ip6_finish_output2+0x1cb/0x520
>  ? nf_hook_slow+0x43/0xc0
>  ? ip6_mtu+0x46/0x80
>  ip6_finish_output+0x2a/0xb0
>  mld_sendpack+0x18f/0x250
>  mld_ifc_work+0x39/0x160
>  process_one_work+0x1e6/0x3f0
>  worker_thread+0x4d/0x2f0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xe5/0x120
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x34/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
> 
> [...]

Here is the summary with links:
  - [net,v5] team: fix null-ptr-deref when team device type is changed
    https://git.kernel.org/netdev/net/c/492032760127

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



