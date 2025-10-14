Return-Path: <netdev+bounces-229157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1255BD8B00
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C0C3A1D7F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC7B2EC0AB;
	Tue, 14 Oct 2025 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFHMhZ54"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3EA2EB5A1
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436621; cv=none; b=XOoGDALgu/JOPbZQTPyX3/gOFBoNrPQLsuzKR76PX2kP8Z3Xejvae5g9vRI0YiYPuF+8lCcJJI3JZI1x1SlpsXXf4pG/8vkKgkAW0UEG7MREoDt+BaaVwRTJs68JKPthrTFBJWbn+6ziVyr7rBnyd+8LHy/wQ+84y1H7wTh0sTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436621; c=relaxed/simple;
	bh=XOYmWAEme5Aa4DxDs3EvRlSU3wT27D0p5PDY/LuEdPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SqYmRQAh3fQKqeKJnQTVFqM3KJ7y6vWQNYB/218yqTI54CwiGwFX7oJ47GoCZCBvjiKzpXspInZlR2TKh1wF00GkEfAAOxM/Ja+DsqKKMEUKnJaAbzkZcETWa1jGDQlY/ow8ZctoV/4cATTmmfpP5J1bdtGVJsgmILwPjHJKJCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFHMhZ54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2DDC113D0;
	Tue, 14 Oct 2025 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760436620;
	bh=XOYmWAEme5Aa4DxDs3EvRlSU3wT27D0p5PDY/LuEdPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mFHMhZ54yb5ZchzIgwJZGdtHRzLRAurk0nZWjgnmQ7XjdMTA4hJP4E2otsT0hY9Qf
	 fHnngbqUGv/KKsZv2lECZ98w2NKnqyfmCP0u16ylmsWXOauCtjLGXo29hyfO/3mjus
	 kZRdkeQRSmrTtW0n58ZGevymPbJglizgDpQTuwwo7LL0Fnq7+ma/yVnJ5agplM1AJm
	 KHvyWNHb4JnBZ71ToUyVhTrfqi00Ce15WiJEU1tRuLM1/+4zNO09j+LWVsjlvSc3G4
	 ZkAf+FK288q8VlWFpJetbAvYdR7k726QvP6BpWQJANSnLDxGpZEUV2bFvtY/g43YUH
	 lEl2xwa7o7eTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D20380A97F;
	Tue, 14 Oct 2025 10:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] usbnet: Fix using smp_processor_id() in preemptible
 code
 warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176043660626.3630052.547487952463753685.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 10:10:06 +0000
References: <20251011070518.7095-1-qiang.zhang@linux.dev>
In-Reply-To: <20251011070518.7095-1-qiang.zhang@linux.dev>
To: Zqiang <qiang.zhang@linux.dev>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 11 Oct 2025 15:05:18 +0800 you wrote:
> Syzbot reported the following warning:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: dhcpcd/2879
> caller is usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
> CPU: 1 UID: 0 PID: 2879 Comm: dhcpcd Not tainted 6.15.0-rc4-syzkaller-00098-g615dca38c2ea #0 PREEMPT(voluntary)
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
>  check_preemption_disabled+0xd0/0xe0 lib/smp_processor_id.c:49
>  usbnet_skb_return+0x74/0x490 drivers/net/usb/usbnet.c:331
>  usbnet_resume_rx+0x4b/0x170 drivers/net/usb/usbnet.c:708
>  usbnet_change_mtu+0x1be/0x220 drivers/net/usb/usbnet.c:417
>  __dev_set_mtu net/core/dev.c:9443 [inline]
>  netif_set_mtu_ext+0x369/0x5c0 net/core/dev.c:9496
>  netif_set_mtu+0xb0/0x160 net/core/dev.c:9520
>  dev_set_mtu+0xae/0x170 net/core/dev_api.c:247
>  dev_ifsioc+0xa31/0x18d0 net/core/dev_ioctl.c:572
>  dev_ioctl+0x223/0x10e0 net/core/dev_ioctl.c:821
>  sock_do_ioctl+0x19d/0x280 net/socket.c:1204
>  sock_ioctl+0x42f/0x6a0 net/socket.c:1311
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:906 [inline]
>  __se_sys_ioctl fs/ioctl.c:892 [inline]
>  __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [v2] usbnet: Fix using smp_processor_id() in preemptible code warnings
    https://git.kernel.org/netdev/net/c/327cd4b68b43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



