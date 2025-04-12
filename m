Return-Path: <netdev+bounces-181861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D44FA86A57
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 04:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66168904BF6
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 02:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FB925634;
	Sat, 12 Apr 2025 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGo1XNkq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA16CA64;
	Sat, 12 Apr 2025 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744423254; cv=none; b=mzDvjR2RUtE/DBN+jz3eANxu864VzL8yau82Eaf+SfRzyGTWG5LviwK6mCx+ZCBzuS9fCg1f3TVd7IWmSZCool1wPykRukycBkgv7ikIYTZ68o/pAJfhmphzQKlYCFJkuUb5Ukw7XWWJK6dwi4wtqAJxG+/tmydcss4RYPabfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744423254; c=relaxed/simple;
	bh=KXH/4K4qRNQyU/Cg1faELZrylmvK5qSWBJUVziTplCE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O6gSLVkwXucfCt7SJM2tzWRtQ8Y/uEh6YB8glKrrhnvXW1v0dwCyAW07mvV8C4stAC+TmHPVcJzc6pmXaWLAlZ0Z2hdxm/6pRITvSHhNrmzyvgpjU6YBLDXTsE4vDTu8U3uH5YTbOegXwACIOU2YdCO21zNDjSrnqX98wxDqXGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGo1XNkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586A5C4CEE2;
	Sat, 12 Apr 2025 02:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744423253;
	bh=KXH/4K4qRNQyU/Cg1faELZrylmvK5qSWBJUVziTplCE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jGo1XNkqqH1ALATqrjr6IFdPLUtmJIneQiBz6vUaTD3S5AX6MuMuYvX8nuJYCRb7y
	 U8tqi7poLG7W7zWUsq0NnBZ6GfaSm1xONyRai0s7j5nqsP+ykZB0DPmca5t1evTS1+
	 GkOEb3e95PVzRb4HI38OWbpjyrIK3bBl4z6PFLracpJfDbF3FdoUbDRPsCBdJQ+I9a
	 +vGx6maeahFRA0p/1qJD957vK7IwfAfJ6HLPMQvF5a1xVCoKoLMGMyHS7aD5Nm4g25
	 XPjqgQuYfs3pfX/kx4vM/4B/hHq2Tl96g5Ct0iSk1uKE2x/MwSGX1hKMKr/x8MO3tc
	 9zaAVKEL44nnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E0738111DD;
	Sat, 12 Apr 2025 02:01:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bonding: hold ops lock around get_link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174442329101.549857.7851201366120153854.git-patchwork-notify@kernel.org>
Date: Sat, 12 Apr 2025 02:01:31 +0000
References: <20250410161117.3519250-1-sdf@fomichev.me>
In-Reply-To: <20250410161117.3519250-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
 syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Apr 2025 09:11:17 -0700 you wrote:
> syzbot reports a case of ethtool_ops->get_link being called without
> ops lock:
> 
>  ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:63
>  bond_check_dev_link+0x1fb/0x4b0 drivers/net/bonding/bond_main.c:864
>  bond_miimon_inspect drivers/net/bonding/bond_main.c:2734 [inline]
>  bond_mii_monitor+0x49d/0x3170 drivers/net/bonding/bond_main.c:2956
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
>  worker_thread+0x870/0xd50 kernel/workqueue.c:3400
>  kthread+0x7b7/0x940 kernel/kthread.c:464
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> [...]

Here is the summary with links:
  - [net,v2] bonding: hold ops lock around get_link
    https://git.kernel.org/netdev/net/c/f7a11cba0ed7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



