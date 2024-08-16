Return-Path: <netdev+bounces-119076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B416D953F77
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498652860F9
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61285450FA;
	Fri, 16 Aug 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0gc/212"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388641EA91;
	Fri, 16 Aug 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774830; cv=none; b=hHA8O1IWNKWS7k58YAEmaxBL1oA4JiaczO4SGSAlCyFhCHuoVe2aMAdseiaE/XGXEwc4lccaoV7BepCU3P7D0URX4cy/nVKZmLYJ9898Tjrui6nqZ1asuMRrvPcXn1z2ND5TWDnbPP/vsHNQHPNgDHPrYexVBtQXBVFfKKGfg8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774830; c=relaxed/simple;
	bh=mFVPqb21byqrHgJkjCb+cbaG/UwSUHy6pmKS6rYkF7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RiSy13pPr1/1aKMZLeGZVh5Tq21dk6gFKQQl9fPxk0FTDiQakhq3ThnqQLJGz7ZbOyDOb2EyuAQutpyZCJuNtS6qLVnTEuSS+n2pyaKluupyMD+qVu8UqfXdBEUgTPS/1+6+4tlPxmX3Rb3Omx+UrWwVUdvA0rzphlD2lsqgsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0gc/212; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1602C32786;
	Fri, 16 Aug 2024 02:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723774829;
	bh=mFVPqb21byqrHgJkjCb+cbaG/UwSUHy6pmKS6rYkF7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q0gc/21288zlhbBGw9Vts1CN1SAuk1pah1dsPEgImpOab/zjhIZHImP7DczDGiAL7
	 dlf+gD4WYQB8XrDG0KPjL8TGUq4QF5K6nBdw1EffIFwDSYU+J3xVn7krUHkzPVk/5U
	 yhhKbV8w8H5BB16U+3gTwuHW0gNvtA5uPERHyIkTNohxnb1i1sFY5Ouachwwb4jK37
	 v2AHwv+QZQvyoggT+yEDdaKgMNR/bASs+j/i53bcc15Jvb0TBPVkqi+Z71cl/Kokdq
	 i3L8zShLo05WVI9M1O0SFicwGiCXasHZ2chZANQawdGA4GfjMakhWFdmjpwVLFUbyi
	 q3jvbbkcbU+xQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B3F382327A;
	Fri, 16 Aug 2024 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] virtio_net: move netdev_tx_reset_queue() call before RX
 napi enable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172377482899.3093813.12644069367447309895.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 02:20:28 +0000
References: <20240814122500.1710279-1-jiri@resnulli.us>
In-Reply-To: <20240814122500.1710279-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, m.szyprowski@samsung.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Aug 2024 14:25:00 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> During suspend/resume the following BUG was hit:
> ------------[ cut here ]------------
> kernel BUG at lib/dynamic_queue_limits.c:99!
> Internal error: Oops - BUG: 0 [#1] SMP ARM
> Modules linked in: bluetooth ecdh_generic ecc libaes
> CPU: 1 PID: 1282 Comm: rtcwake Not tainted
> 6.10.0-rc3-00732-gc8bd1f7f3e61 #15240
> Hardware name: Generic DT based system
> PC is at dql_completed+0x270/0x2cc
> LR is at __free_old_xmit+0x120/0x198
> pc : [<c07ffa54>]    lr : [<c0c42bf4>]    psr: 80000013
> ...
> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 43a4406a  DAC: 00000051
> ...
> Process rtcwake (pid: 1282, stack limit = 0xfbc21278)
> Stack: (0xe0805e80 to 0xe0806000)
> ...
> Call trace:
>   dql_completed from __free_old_xmit+0x120/0x198
>   __free_old_xmit from free_old_xmit+0x44/0xe4
>   free_old_xmit from virtnet_poll_tx+0x88/0x1b4
>   virtnet_poll_tx from __napi_poll+0x2c/0x1d4
>   __napi_poll from net_rx_action+0x140/0x2b4
>   net_rx_action from handle_softirqs+0x11c/0x350
>   handle_softirqs from call_with_stack+0x18/0x20
>   call_with_stack from do_softirq+0x48/0x50
>   do_softirq from __local_bh_enable_ip+0xa0/0xa4
>   __local_bh_enable_ip from virtnet_open+0xd4/0x21c
>   virtnet_open from virtnet_restore+0x94/0x120
>   virtnet_restore from virtio_device_restore+0x110/0x1f4
>   virtio_device_restore from dpm_run_callback+0x3c/0x100
>   dpm_run_callback from device_resume+0x12c/0x2a8
>   device_resume from dpm_resume+0x12c/0x1e0
>   dpm_resume from dpm_resume_end+0xc/0x18
>   dpm_resume_end from suspend_devices_and_enter+0x1f0/0x72c
>   suspend_devices_and_enter from pm_suspend+0x270/0x2a0
>   pm_suspend from state_store+0x68/0xc8
>   state_store from kernfs_fop_write_iter+0x10c/0x1cc
>   kernfs_fop_write_iter from vfs_write+0x2b0/0x3dc
>   vfs_write from ksys_write+0x5c/0xd4
>   ksys_write from ret_fast_syscall+0x0/0x54
> Exception stack(0xe8bf1fa8 to 0xe8bf1ff0)
> ...
> 
> [...]

Here is the summary with links:
  - [net] virtio_net: move netdev_tx_reset_queue() call before RX napi enable
    https://git.kernel.org/netdev/net/c/b96ed2c97c79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



