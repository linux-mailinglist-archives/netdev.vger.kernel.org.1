Return-Path: <netdev+bounces-159600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94253A15FE3
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 03:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3333A6472
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D5B3CF58;
	Sun, 19 Jan 2025 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRd6gPRb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717FB38FB0
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737252011; cv=none; b=YbEgMcrJo9Gsc1KJ3aMby52tklj8PTgBolNBlZMop4g+nYiJD8Lsnb8d080+RBn/wxajGO7i1ylDYj9Y2D4pR7Kjz8FkSsPXWkQw0dWa+5wnjLwy5MG2tbWZnP7PfB6LzMz6MLKa6r9WZ1f0yRo7NmqIv2miwgWfKzULjyXmUSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737252011; c=relaxed/simple;
	bh=QGDzs9EKTI1zbjPI7ITWcZo3bYES7/j7+QzjVgYBj18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LHUPeiNKvLn6vw8N65vdOKifeNTOQO/wTi5Kj9eyMpaSsQe+KjSR7UF+NU0KcqMfFxxtMxqEf703nF0eghYVhULUspi6qVxPD1/Fb+VO9t/1WZXhOj5BqHPbvZx3U3bsY74t3mi3ZEWWOAjKKVlgMVjHsKSncO8zEsxqeLZQPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRd6gPRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D731CC4CED1;
	Sun, 19 Jan 2025 02:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737252010;
	bh=QGDzs9EKTI1zbjPI7ITWcZo3bYES7/j7+QzjVgYBj18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iRd6gPRbfrxJpiRZsINjuSTckTNE/WawXaXKbphYfUrNvnTUhQ+dotnMS/JmOyWbd
	 AQAzH1tY2CrSUX7Xq71A2y5CHJCGo8AY55QedQpfS66uG3xMoSHwa38z4AZCIup1iU
	 xXkZl5JbVd+bPQAfg4+cC5GIEX8wNw3oJ32QUHP1Hzns8QwKEB4hMAVWnRO9c5jHn6
	 qGZGBmC4NAW0b6OknuMbC5C1H2Z9fHwVC2IzwTCd8+D4RmfoBmbiBVNrsIMPdXHrjI
	 7JL61sRP9fqOQsum8nwkdZT8jxCnpTNGeezbCxpzFHcBMSCIzbU+hdzkwh5+36i6Ws
	 cdNkoKcfFxyNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCAC380AA62;
	Sun, 19 Jan 2025 02:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: avoid race between device unregistration and
 ethnl ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725203448.2534672.1226229383765943394.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 02:00:34 +0000
References: <20250116092159.50890-1-atenart@kernel.org>
In-Reply-To: <20250116092159.50890-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 10:21:57 +0100 you wrote:
> The following trace can be seen if a device is being unregistered while
> its number of channels are being modified.
> 
>   DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>   WARNING: CPU: 3 PID: 3754 at kernel/locking/mutex.c:564 __mutex_lock+0xc8a/0x1120
>   CPU: 3 UID: 0 PID: 3754 Comm: ethtool Not tainted 6.13.0-rc6+ #771
>   RIP: 0010:__mutex_lock+0xc8a/0x1120
>   Call Trace:
>    <TASK>
>    ethtool_check_max_channel+0x1ea/0x880
>    ethnl_set_channels+0x3c3/0xb10
>    ethnl_default_set_doit+0x306/0x650
>    genl_family_rcv_msg_doit+0x1e3/0x2c0
>    genl_rcv_msg+0x432/0x6f0
>    netlink_rcv_skb+0x13d/0x3b0
>    genl_rcv+0x28/0x40
>    netlink_unicast+0x42e/0x720
>    netlink_sendmsg+0x765/0xc20
>    __sys_sendto+0x3ac/0x420
>    __x64_sys_sendto+0xe0/0x1c0
>    do_syscall_64+0x95/0x180
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Here is the summary with links:
  - [net,v2] net: avoid race between device unregistration and ethnl ops
    https://git.kernel.org/netdev/net/c/12e070eb6964

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



