Return-Path: <netdev+bounces-147126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D099D7986
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB0C28215E
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA36F748F;
	Mon, 25 Nov 2024 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYcZJypf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C496E376
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732495821; cv=none; b=n8RFa4D0xXoR8maefgTry0jNQwoCL2LubIXWp9YwKDqeMXc/tUxsw9SnCe7BezMe32o38RRnCf8Fo2fnE/fPkFUVZEZXrFXNpxdYngpVpKXMRVb+pF6hO5VQtj7PtfufzzxKgnLqzCqp/tZpoMp1E+CplA7a1SfEF20TOXRI0Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732495821; c=relaxed/simple;
	bh=KXFwcOQs5XxJ9BoR7kIo6VP2KX6RIo3xNIJzVlU+i+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=paqgCRAqitzLd5im2LiyIZpZSmGH5yxCNhxzpt77wqZ4AZMWcCIUwZdNfnOf4noAJ4Z9nkIrWe3CWRom8IrQWgvPIkv5lri4N1lq2JHYx31SHTyyJxKICx860KV9r51boV7b7XApAZxQjtC1G0euW+p8JnEkOQTrIWtAZ6peFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYcZJypf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C1DC4CECC;
	Mon, 25 Nov 2024 00:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732495819;
	bh=KXFwcOQs5XxJ9BoR7kIo6VP2KX6RIo3xNIJzVlU+i+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZYcZJypfrlJPcVC+wXK/WcL8xB/W275OBn7BoSwTorr3iQHKMqT5u7KeZnptjyQWR
	 9wZacSmdmKgQpQ8ol9uXqb4B/rmcEeSImsQ0zfgVNY9bvCy1DKwzRz2JAFi0nmsgJz
	 5fPUCodxz1o9w9WtHV69SWDpH8x4EcabLaFmQfjTfYWhUWOIW+wgOL4OGgtOUp5Hr0
	 8qfGZ0N5vPO+yz1bj8kZ6umISTA8/+SY1hXyIBDSK2I7wwfEhj5z3kvBJheykzIboy
	 0DtQaFFdd52scVt0veSrVJVjuF1klkaxMQ2NS1UNoJopKl8yiirkoF2Sc9Gw7p5hDF
	 MPmpWpmGvQmFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC24C3809A00;
	Mon, 25 Nov 2024 00:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rtnetlink: fix rtnl_dump_ifinfo() error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173249583150.3408383.17756861808285881357.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 00:50:31 +0000
References: <20241121194105.3632507-1-edumazet@google.com>
In-Reply-To: <20241121194105.3632507-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 kuniyu@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Nov 2024 19:41:05 +0000 you wrote:
> syzbot found that rtnl_dump_ifinfo() could return with a lock held [1]
> 
> Move code around so that rtnl_link_ops_put() and put_net()
> can be called at the end of this function.
> 
> [1]
> WARNING: lock held when returning to user space!
> 6.12.0-rc7-syzkaller-01681-g38f83a57aa8e #0 Not tainted
> syz-executor399/5841 is leaving the kernel with locks still held!
> 1 lock held by syz-executor399/5841:
>   #0: ffffffff8f46c2a0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>   #0: ffffffff8f46c2a0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>   #0: ffffffff8f46c2a0 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x22/0x250 net/core/rtnetlink.c:555
> 
> [...]

Here is the summary with links:
  - [net] rtnetlink: fix rtnl_dump_ifinfo() error path
    https://git.kernel.org/netdev/net/c/9b234a97b10c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



