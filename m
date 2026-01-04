Return-Path: <netdev+bounces-246815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCB3CF1479
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 21:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A929530115D7
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 20:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2732EBB89;
	Sun,  4 Jan 2026 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8JTyoDS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26D2EB860;
	Sun,  4 Jan 2026 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767557833; cv=none; b=LDiIktcIzOAOJn66d9x0Dz36+Y1Uh8b6mmKDbf7w1F2Jx3bbo6VFv55pNHKA4K9gZ5mTcSM/DEj/eJU4mhGXrcBdsyTvdl6ajhZv2tx+7TjvbxYbTHew7U59/lR2eviPeDSCf6lkUqFNPUEvTqQov2dP8G6tSnxs5ScaRJhqFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767557833; c=relaxed/simple;
	bh=7mz8v9z0BM17jMr+gaKdu0d01aFsVsqad712bUC+gBQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MsxJXCLVFCXVPph9ouA+9UkThZCa1nnrtlfl+ruH6a1lOw2QP7NrdUeeV7TkNWeYFI10QMzMDrpXaXvFpuqsCjcpGDl4ePBFQN/I+sfHH1SN0ySe3RuPjKMB/JYworDJyGv3iioTVJu/gT44jR2/hwQ9T8ImDEMWnacQImvXyYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8JTyoDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB7FC19422;
	Sun,  4 Jan 2026 20:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767557833;
	bh=7mz8v9z0BM17jMr+gaKdu0d01aFsVsqad712bUC+gBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t8JTyoDS4f1raQ9MoKpd9lJm4y/z5Ir+MMLd+ATZY5kc4k15XlXikK7V+3QNnV7YW
	 BjdGnPgTv36jjn5Gtu1UWfPFA5haJUgXWBm4+TRhCOL+kqJYbanmaHIqeoD14cxCR8
	 e0/RVULzdg7E7376SUdw8YZ4CnmmidObgtTVdSbaFVR08F3JvKm7l2QtKGRVJ2tNEK
	 jgHmG/nVAXnobV03yRzPpdOINhIlXNGGemYLTdbUGjS9g+Q6WWL3YzM5Ak16vjwho5
	 iK4DOUeeyk8TzG/bgfw9yT6d2UsFFb3rD5mA+fEdyQwjvJoBDRlHGGM6WrKV01a6bl
	 /UeZdQFyt0jUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B884380AA58;
	Sun,  4 Jan 2026 20:13:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] virtio_net: fix device mismatch in
 devm_kzalloc/devm_kfree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176755763202.155813.4198468083332935652.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 20:13:52 +0000
References: <20260102101900.692770-1-kshankar@marvell.com>
In-Reply-To: <20260102101900.692770-1-kshankar@marvell.com>
To: Shiva Shankar Kommula <kshankar@marvell.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jerinj@marvell.com, ndabilpuram@marvell.com, schalla@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 2 Jan 2026 15:49:00 +0530 you wrote:
> Initial rss_hdr allocation uses virtio_device->device,
> but virtnet_set_queues() frees using net_device->device.
> This device mismatch causing below devres warning
> 
> [ 3788.514041] ------------[ cut here ]------------
> [ 3788.514044] WARNING: drivers/base/devres.c:1095 at devm_kfree+0x84/0x98, CPU#16: vdpa/1463
> [ 3788.514054] Modules linked in: octep_vdpa virtio_net virtio_vdpa [last unloaded: virtio_vdpa]
> [ 3788.514064] CPU: 16 UID: 0 PID: 1463 Comm: vdpa Tainted: G        W           6.18.0 #10 PREEMPT
> [ 3788.514067] Tainted: [W]=WARN
> [ 3788.514069] Hardware name: Marvell CN106XX board (DT)
> [ 3788.514071] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> [ 3788.514074] pc : devm_kfree+0x84/0x98
> [ 3788.514076] lr : devm_kfree+0x54/0x98
> [ 3788.514079] sp : ffff800084e2f220
> [ 3788.514080] x29: ffff800084e2f220 x28: ffff0003b2366000 x27: 000000000000003f
> [ 3788.514085] x26: 000000000000003f x25: ffff000106f17c10 x24: 0000000000000080
> [ 3788.514089] x23: ffff00045bb8ab08 x22: ffff00045bb8a000 x21: 0000000000000018
> [ 3788.514093] x20: ffff0004355c3080 x19: ffff00045bb8aa00 x18: 0000000000080000
> [ 3788.514098] x17: 0000000000000040 x16: 000000000000001f x15: 000000000007ffff
> [ 3788.514102] x14: 0000000000000488 x13: 0000000000000005 x12: 00000000000fffff
> [ 3788.514106] x11: ffffffffffffffff x10: 0000000000000005 x9 : ffff800080c8c05c
> [ 3788.514110] x8 : ffff800084e2eeb8 x7 : 0000000000000000 x6 : 000000000000003f
> [ 3788.514115] x5 : ffff8000831bafe0 x4 : ffff800080c8b010 x3 : ffff0004355c3080
> [ 3788.514119] x2 : ffff0004355c3080 x1 : 0000000000000000 x0 : 0000000000000000
> [ 3788.514123] Call trace:
> [ 3788.514125]  devm_kfree+0x84/0x98 (P)
> [ 3788.514129]  virtnet_set_queues+0x134/0x2e8 [virtio_net]
> [ 3788.514135]  virtnet_probe+0x9c0/0xe00 [virtio_net]
> [ 3788.514139]  virtio_dev_probe+0x1e0/0x338
> [ 3788.514144]  really_probe+0xc8/0x3a0
> [ 3788.514149]  __driver_probe_device+0x84/0x170
> [ 3788.514152]  driver_probe_device+0x44/0x120
> [ 3788.514155]  __device_attach_driver+0xc4/0x168
> [ 3788.514158]  bus_for_each_drv+0x8c/0xf0
> [ 3788.514161]  __device_attach+0xa4/0x1c0
> [ 3788.514164]  device_initial_probe+0x1c/0x30
> [ 3788.514168]  bus_probe_device+0xb4/0xc0
> [ 3788.514170]  device_add+0x614/0x828
> [ 3788.514173]  register_virtio_device+0x214/0x258
> [ 3788.514175]  virtio_vdpa_probe+0xa0/0x110 [virtio_vdpa]
> [ 3788.514179]  vdpa_dev_probe+0xa8/0xd8
> [ 3788.514183]  really_probe+0xc8/0x3a0
> [ 3788.514186]  __driver_probe_device+0x84/0x170
> [ 3788.514189]  driver_probe_device+0x44/0x120
> [ 3788.514192]  __device_attach_driver+0xc4/0x168
> [ 3788.514195]  bus_for_each_drv+0x8c/0xf0
> [ 3788.514197]  __device_attach+0xa4/0x1c0
> [ 3788.514200]  device_initial_probe+0x1c/0x30
> [ 3788.514203]  bus_probe_device+0xb4/0xc0
> [ 3788.514206]  device_add+0x614/0x828
> [ 3788.514209]  _vdpa_register_device+0x58/0x88
> [ 3788.514211]  octep_vdpa_dev_add+0x104/0x228 [octep_vdpa]
> [ 3788.514215]  vdpa_nl_cmd_dev_add_set_doit+0x2d0/0x3c0
> [ 3788.514218]  genl_family_rcv_msg_doit+0xe4/0x158
> [ 3788.514222]  genl_rcv_msg+0x218/0x298
> [ 3788.514225]  netlink_rcv_skb+0x64/0x138
> [ 3788.514229]  genl_rcv+0x40/0x60
> [ 3788.514233]  netlink_unicast+0x32c/0x3b0
> [ 3788.514237]  netlink_sendmsg+0x170/0x3b8
> [ 3788.514241]  __sys_sendto+0x12c/0x1c0
> [ 3788.514246]  __arm64_sys_sendto+0x30/0x48
> [ 3788.514249]  invoke_syscall.constprop.0+0x58/0xf8
> [ 3788.514255]  do_el0_svc+0x48/0xd0
> [ 3788.514259]  el0_svc+0x48/0x210
> [ 3788.514264]  el0t_64_sync_handler+0xa0/0xe8
> [ 3788.514268]  el0t_64_sync+0x198/0x1a0
> [ 3788.514271] ---[ end trace 0000000000000000 ]---
> 
> [...]

Here is the summary with links:
  - [net] virtio_net: fix device mismatch in devm_kzalloc/devm_kfree
    https://git.kernel.org/netdev/net/c/acb4bc6e1ba3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



