Return-Path: <netdev+bounces-13252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B1E73AEDC
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 05:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0247E1C20EC1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 03:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A86E649;
	Fri, 23 Jun 2023 03:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2F81A
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79289C4339A;
	Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687489222;
	bh=aSBATZg0UXsyGME4rZYuXYh5QWb8vTov79GbLcQiyjY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=djTiEa3fQ0uSJER9iQKMsgWOVtOWKNpWeIWnkW57LH/O4usFj46mM1STYESkbVCug
	 5bzG4oDreTLJ3zTfor3QLn2x/GVoafQNzWWTNk4ghqylx4ilW1oYF5BEMNtZzft14T
	 RLjzsy43uFIW5vRvFsvZR8pvC1JAhlUQNEjVsJ8SKSKhfuExRTwu9Oxq02Fc+Frmcl
	 kyzdB+/xJ+fc9ALooQ5acj0PsUOBTiA+kCWjEVhtj/FHv7xrGmc4dM2W5uZmfRSczi
	 TV3z8G7C0ss5fEy+IT3t2JDyrae1m2D8UUnabZf6+BvoB3uSRLcE6EkKLg9qzhJIMW
	 7viep2Ncq1J1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51767C73FE4;
	Fri, 23 Jun 2023 03:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] igb: Fix igb_down hung on surprise removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748922233.4682.6082609033984138363.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 03:00:22 +0000
References: <20230620174732.4145155-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230620174732.4145155-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, yinghsu@chromium.org,
 aleksandr.loktionov@intel.com, himasekharx.reddy.pucha@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jun 2023 10:47:32 -0700 you wrote:
> From: Ying Hsu <yinghsu@chromium.org>
> 
> In a setup where a Thunderbolt hub connects to Ethernet and a display
> through USB Type-C, users may experience a hung task timeout when they
> remove the cable between the PC and the Thunderbolt hub.
> This is because the igb_down function is called multiple times when
> the Thunderbolt hub is unplugged. For example, the igb_io_error_detected
> triggers the first call, and the igb_remove triggers the second call.
> The second call to igb_down will block at napi_synchronize.
> Here's the call trace:
>     __schedule+0x3b0/0xddb
>     ? __mod_timer+0x164/0x5d3
>     schedule+0x44/0xa8
>     schedule_timeout+0xb2/0x2a4
>     ? run_local_timers+0x4e/0x4e
>     msleep+0x31/0x38
>     igb_down+0x12c/0x22a [igb 6615058754948bfde0bf01429257eb59f13030d4]
>     __igb_close+0x6f/0x9c [igb 6615058754948bfde0bf01429257eb59f13030d4]
>     igb_close+0x23/0x2b [igb 6615058754948bfde0bf01429257eb59f13030d4]
>     __dev_close_many+0x95/0xec
>     dev_close_many+0x6e/0x103
>     unregister_netdevice_many+0x105/0x5b1
>     unregister_netdevice_queue+0xc2/0x10d
>     unregister_netdev+0x1c/0x23
>     igb_remove+0xa7/0x11c [igb 6615058754948bfde0bf01429257eb59f13030d4]
>     pci_device_remove+0x3f/0x9c
>     device_release_driver_internal+0xfe/0x1b4
>     pci_stop_bus_device+0x5b/0x7f
>     pci_stop_bus_device+0x30/0x7f
>     pci_stop_bus_device+0x30/0x7f
>     pci_stop_and_remove_bus_device+0x12/0x19
>     pciehp_unconfigure_device+0x76/0xe9
>     pciehp_disable_slot+0x6e/0x131
>     pciehp_handle_presence_or_link_change+0x7a/0x3f7
>     pciehp_ist+0xbe/0x194
>     irq_thread_fn+0x22/0x4d
>     ? irq_thread+0x1fd/0x1fd
>     irq_thread+0x17b/0x1fd
>     ? irq_forced_thread_fn+0x5f/0x5f
>     kthread+0x142/0x153
>     ? __irq_get_irqchip_state+0x46/0x46
>     ? kthread_associate_blkcg+0x71/0x71
>     ret_from_fork+0x1f/0x30
> 
> [...]

Here is the summary with links:
  - [net-next] igb: Fix igb_down hung on surprise removal
    https://git.kernel.org/netdev/net-next/c/004d25060c78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



