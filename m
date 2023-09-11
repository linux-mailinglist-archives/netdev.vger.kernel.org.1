Return-Path: <netdev+bounces-32762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1548279A482
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 09:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72C228117D
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 07:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDD83D68;
	Mon, 11 Sep 2023 07:30:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82263188
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 07:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27872C433CD;
	Mon, 11 Sep 2023 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694417450;
	bh=xqylZiIr4EueJHXmCy/bcCuM6b4q9YlLmAfvHsEGUUg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H8Pwt0nKzwzxbOzTPN9EnbZB5h8P/PxuclnrkabRChxtnGyJKEdcHGSLK1wN5IF+z
	 Iu/e8c3nRh8wHS0V3QSdV/V5O7UCPtEica8l6WI8OV5aahMTsXp/yLr4qREbtFd5Nz
	 8Cw+lO0EhOf2i9ARbXRTSWAY/ht0Rc2ys2PMWYYlAzxoqtRFidamGIBihmAJ5QIO4F
	 0eAJcg95/GLmjQwn2t8py3ZE0FO7csZKnAMV2c7eNXExG+pqs3ckdZ39P+HFWCF+Uh
	 KYA49zuC038rL4X4Mpi4LwQcr1j/vBC3P4yzzKX32PK6ATxk0fSXUIfS6WUDkawNFw
	 KOC4h2pHNlrqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03ADCE1C280;
	Mon, 11 Sep 2023 07:30:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] hsr: Fix uninit-value access in fill_frame_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169441745001.31104.15757238539479991787.git-patchwork-notify@kernel.org>
Date: Mon, 11 Sep 2023 07:30:50 +0000
References: <20230908101752.1260288-1-william.xuanziyang@huawei.com>
In-Reply-To: <20230908101752.1260288-1-william.xuanziyang@huawei.com>
To: Ziyang Xuan (William) <william.xuanziyang@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bigeasy@linutronix.de, netdev@vger.kernel.org,
 m-karicheri2@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 8 Sep 2023 18:17:52 +0800 you wrote:
> Syzbot reports the following uninit-value access problem.
> 
> =====================================================
> BUG: KMSAN: uninit-value in fill_frame_info net/hsr/hsr_forward.c:601 [inline]
> BUG: KMSAN: uninit-value in hsr_forward_skb+0x9bd/0x30f0 net/hsr/hsr_forward.c:616
>  fill_frame_info net/hsr/hsr_forward.c:601 [inline]
>  hsr_forward_skb+0x9bd/0x30f0 net/hsr/hsr_forward.c:616
>  hsr_dev_xmit+0x192/0x330 net/hsr/hsr_device.c:223
>  __netdev_start_xmit include/linux/netdevice.h:4889 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4903 [inline]
>  xmit_one net/core/dev.c:3544 [inline]
>  dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3560
>  __dev_queue_xmit+0x34d0/0x52a0 net/core/dev.c:4340
>  dev_queue_xmit include/linux/netdevice.h:3082 [inline]
>  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3087 [inline]
>  packet_sendmsg+0x8b1d/0x9f30 net/packet/af_packet.c:3119
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  sock_sendmsg net/socket.c:753 [inline]
>  __sys_sendto+0x781/0xa30 net/socket.c:2176
>  __do_sys_sendto net/socket.c:2188 [inline]
>  __se_sys_sendto net/socket.c:2184 [inline]
>  __ia32_sys_sendto+0x11f/0x1c0 net/socket.c:2184
>  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>  __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
>  do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
>  do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
>  entry_SYSENTER_compat_after_hwframe+0x70/0x82
> 
> [...]

Here is the summary with links:
  - [net] hsr: Fix uninit-value access in fill_frame_info()
    https://git.kernel.org/netdev/net/c/484b4833c604

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



