Return-Path: <netdev+bounces-236430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55356C3C268
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA833B4F6E
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A059030E836;
	Thu,  6 Nov 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROv2tQx6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8430DEAC;
	Thu,  6 Nov 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443649; cv=none; b=o9SwnjftPe8h2vgdtZsa3PXvRom+yfCC06102GGuZN5n2WDJRd30XGE4Lenhg4l+Q3nEHMuQTuq+1aFjBTXJKMVWaWHbV9Llpgr+fkwpvrW+QFVAWxKxYZDAwO/l7dOGAgRSAOlOP68P0wX+7vuni98eB+9GZEyPhvJ6IS5Uii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443649; c=relaxed/simple;
	bh=YGE4EOLmfH7vfh1pwP2cTRQBwZGH0RMMN2pj1n78lgw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IQyAZ580XqLJ9N0hXEoREEKeeNPbT9sWEOgKs7YWVsc/vl4ZK2drfuovA3krnY5dQvqZpW9AjT1K57KMH8ISVmP/13qP7p8Qain9GDWvMS+hMfRcRtAV0F4i51VG2nJMzeg5m9F5CpruVPHiOMrMaBOfcJqXFFyJMz5u7bcXdVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROv2tQx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20C7C16AAE;
	Thu,  6 Nov 2025 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762443648;
	bh=YGE4EOLmfH7vfh1pwP2cTRQBwZGH0RMMN2pj1n78lgw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ROv2tQx6Mlt4YnSeY34+q161YAdyCgPtadrzp/mGyI8WzQ/+6QlTGQMeuEdPZ7orN
	 bFPxVX7usEIOkz1XQUvM+lESJKwkvNesEvo3EMOTof8dCnwytt0onXnKIy7q5CviGu
	 sHNYqg7+g7vZ8YegRCW9r/dVp5FI31m4jbashwss3McQFkjrUKEjN5pUWuqke1gYyZ
	 Txl3LkyQLG3nrLVKc2Llr2TuqmuPZxUNZAuwbe3TlQk1tS71Ar9gOfU3bNSiB7NjVz
	 1YGqIkKH7+o2Ffokr0sHtgHKxrTo+iWX88JTkQFAUApr3fVab71dxYVc3eNQwwHusx
	 VkXeC/m+QmPbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE3B39EF947;
	Thu,  6 Nov 2025 15:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] lan966x: Fix sleeping in atomic context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176244362174.255671.6125982381201101043.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 15:40:21 +0000
References: <20251105074955.1766792-1-horatiu.vultur@microchip.com>
In-Reply-To: <20251105074955.1766792-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 5 Nov 2025 08:49:55 +0100 you wrote:
> The following warning was seen when we try to connect using ssh to the device.
> 
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:575
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 104, name: dropbear
> preempt_count: 1, expected: 0
> INFO: lockdep is turned off.
> CPU: 0 UID: 0 PID: 104 Comm: dropbear Tainted: G        W           6.18.0-rc2-00399-g6f1ab1b109b9-dirty #530 NONE
> Tainted: [W]=WARN
> Hardware name: Generic DT based system
> Call trace:
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x7c/0xac
>  dump_stack_lvl from __might_resched+0x16c/0x2b0
>  __might_resched from __mutex_lock+0x64/0xd34
>  __mutex_lock from mutex_lock_nested+0x1c/0x24
>  mutex_lock_nested from lan966x_stats_get+0x5c/0x558
>  lan966x_stats_get from dev_get_stats+0x40/0x43c
>  dev_get_stats from dev_seq_printf_stats+0x3c/0x184
>  dev_seq_printf_stats from dev_seq_show+0x10/0x30
>  dev_seq_show from seq_read_iter+0x350/0x4ec
>  seq_read_iter from seq_read+0xfc/0x194
>  seq_read from proc_reg_read+0xac/0x100
>  proc_reg_read from vfs_read+0xb0/0x2b0
>  vfs_read from ksys_read+0x6c/0xec
>  ksys_read from ret_fast_syscall+0x0/0x1c
> Exception stack(0xf0b11fa8 to 0xf0b11ff0)
> 1fa0:                   00000001 00001000 00000008 be9048d8 00001000 00000001
> 1fc0: 00000001 00001000 00000008 00000003 be905920 0000001e 00000000 00000001
> 1fe0: 0005404c be9048c0 00018684 b6ec2cd8
> 
> [...]

Here is the summary with links:
  - [net] lan966x: Fix sleeping in atomic context
    https://git.kernel.org/netdev/net/c/0216721ce712

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



