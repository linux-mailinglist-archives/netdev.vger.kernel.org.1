Return-Path: <netdev+bounces-211642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D8FB1ABC3
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 02:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA157A7F6D
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 00:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D2E1E1E16;
	Tue,  5 Aug 2025 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDizL/gq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05182C187;
	Tue,  5 Aug 2025 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754353813; cv=none; b=f97iFe+REkU1wPqL17y4MZtZRm55PkFAztd82cFQiu8XrE9vRNWD92FVXoZxyY0XcZeiJXyARDVul7GCGu2M7BjGtffwFVsJKQKYeeMMf9TI0xd4/vU31ffXjzwzFsnJfpFXLJsnEWJmwBs8f28cwicfdEbDxziorhp322PbAz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754353813; c=relaxed/simple;
	bh=8UvVcFFBjVIE1CsFt63PPhXCU26O2Zb9/5uNe4y1SNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G62baLlMmp0knKuuro1AI1nOILyGX/gpE1TSKzHjo95VRTq9Hz7en/4uDnKPWsjMjI7a3GYJL1CY/TTNWw+LEMTEc6jjrjBCrBjDv4N5BHjxxkJwpEnJs+fEKAiA8p6yi5PkpcdrkzI5mh9g9WtBC58/vzgn0lqNdRQvyK1gcCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDizL/gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63062C4CEE7;
	Tue,  5 Aug 2025 00:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754353813;
	bh=8UvVcFFBjVIE1CsFt63PPhXCU26O2Zb9/5uNe4y1SNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cDizL/gq1TSUt34tNIldUWwYgS51iNynejqfHjIsT+i3TwjEdObFLH9SqzCzgF2kF
	 kou2+0pv5zrsQl96cn4LhDhT7PC96mx98JFW3WKbTENHFImKYdEaAGg+4c7C8mB8GY
	 nohdX+ilRkstZGCGX1OdZIDxnZxheO+OEVnMissxpZi9KXnk9oyhGT9rHtHEkofKIg
	 m2iEhoa4oHmUSB/D/EIKDvJZhcBkb+tjzSM7rBs9aiCPVMgwCjwyld8h403OxQ5/WR
	 SSWXxx6g9cSou86Ripn8CXDPEcvXitKWykeTq2jBBZULyycDD3lNtYgZbJObJTZ+6i
	 liTWAfZGeQS3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB212383BF62;
	Tue,  5 Aug 2025 00:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] benet: fix BUG when creating VFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175435382749.1400451.18307396008220746943.git-patchwork-notify@kernel.org>
Date: Tue, 05 Aug 2025 00:30:27 +0000
References: <20250801101338.72502-1-mschmidt@redhat.com>
In-Reply-To: <20250801101338.72502-1-mschmidt@redhat.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, razor@blackwall.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Aug 2025 12:13:37 +0200 you wrote:
> benet crashes as soon as SRIOV VFs are created:
> 
>  kernel BUG at mm/vmalloc.c:3457!
>  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>  CPU: 4 UID: 0 PID: 7408 Comm: test.sh Kdump: loaded Not tainted 6.16.0+ #1 PREEMPT(voluntary)
>  [...]
>  RIP: 0010:vunmap+0x5f/0x70
>  [...]
>  Call Trace:
>   <TASK>
>   __iommu_dma_free+0xe8/0x1c0
>   be_cmd_set_mac_list+0x3fe/0x640 [be2net]
>   be_cmd_set_mac+0xaf/0x110 [be2net]
>   be_vf_eth_addr_config+0x19f/0x330 [be2net]
>   be_vf_setup+0x4f7/0x990 [be2net]
>   be_pci_sriov_configure+0x3a1/0x470 [be2net]
>   sriov_numvfs_store+0x20b/0x380
>   kernfs_fop_write_iter+0x354/0x530
>   vfs_write+0x9b9/0xf60
>   ksys_write+0xf3/0x1d0
>   do_syscall_64+0x8c/0x3d0
> 
> [...]

Here is the summary with links:
  - [net] benet: fix BUG when creating VFs
    https://git.kernel.org/netdev/net/c/5a40f8af2ba1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



