Return-Path: <netdev+bounces-65010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B316E838CB4
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 12:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5EAF1C23968
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0085C908;
	Tue, 23 Jan 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB7Qq36E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB5B5C8E0
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007626; cv=none; b=IoXG6FK3ozdcLFzDLj/y6xWaiXTZ7TnPMJakFLhwlfsnTv0ismNMIpxX/eoBYmMAwSO2SUAkf1/A2nRynnyop3nSTKfEvU98syYblZbmXuOEx8eZK4Ny2421RXLSwcc5HKTQZQDbFG/OreU5BtznpldaX4pxDX9ckHZ1/eoAXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007626; c=relaxed/simple;
	bh=16b8d0H7HmAuhyISYaWE7W3pJNSxiXUO8ElNjGdCx4g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TTewlN4O9xce+QXwvxiPZCJBQhgFcY4AztHgOFrlI0YTQRB1fSxuMa493R7WBKoRo9ZXYGXQsfPP3S81oZZqmxN+9vJqDRBaDF9/cz5tgS/kRwZxjnGZuvrf24/lM2HKjcdsYTdowZukjP99uwi0RINr0XJ1QjRG1MqHx9hAd0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB7Qq36E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 848DDC43390;
	Tue, 23 Jan 2024 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706007625;
	bh=16b8d0H7HmAuhyISYaWE7W3pJNSxiXUO8ElNjGdCx4g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gB7Qq36ESaXt9EyfOUZpH+W1g4ZS7BtD08UfWivZPYRuYjrRkH41XfPchjDcKtOrv
	 ldIZPE8Zsg1MiH6bAD2lypf4sLEbZvqjfJNuzBV2axyvKb3zZvcCiqsBm065W/VQhg
	 e7MLo3aX6Rumpf62OXbaFts/Ld2vLfko48QUOB1PA/XuPMvOPnTKejmTEsOqDo9qvR
	 AEPS9uZq5ipqabL8InV72ih2dtU7HhcP9D75TMEJ97tHHPT5XsJm5YezI55yiyehAf
	 wa5f0+PiLsopsF1keStH0wSRlwuEUMxbt3hI2+MCDVuBtFNaE6FvCa2kgF4FmS1F+T
	 tPUglDgYqF3LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65B49DFF762;
	Tue, 23 Jan 2024 11:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v4] netlink: fix potential sleeping issue in
 mqueue_flush_file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170600762541.5739.6199621237191541052.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 11:00:25 +0000
References: <20240122011807.2110357-1-shaozhengchao@huawei.com>
In-Reply-To: <20240122011807.2110357-1-shaozhengchao@huawei.com>
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 anjali.k.kulkarni@oracle.com, kuniyu@amazon.com, fw@strlen.de,
 pablo@netfilter.org, weiyongjun1@huawei.com, yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 22 Jan 2024 09:18:07 +0800 you wrote:
> I analyze the potential sleeping issue of the following processes:
> Thread A                                Thread B
> ...                                     netlink_create  //ref = 1
> do_mq_notify                            ...
>   sock = netlink_getsockbyfilp          ...     //ref = 2
>   info->notify_sock = sock;             ...
> ...                                     netlink_sendmsg
> ...                                       skb = netlink_alloc_large_skb  //skb->head is vmalloced
> ...                                       netlink_unicast
> ...                                         sk = netlink_getsockbyportid //ref = 3
> ...                                         netlink_sendskb
> ...                                           __netlink_sendskb
> ...                                             skb_queue_tail //put skb to sk_receive_queue
> ...                                         sock_put //ref = 2
> ...                                     ...
> ...                                     netlink_release
> ...                                       deferred_put_nlk_sk //ref = 1
> mqueue_flush_file
>   spin_lock
>   remove_notification
>     netlink_sendskb
>       sock_put  //ref = 0
>         sk_free
>           ...
>           __sk_destruct
>             netlink_sock_destruct
>               skb_queue_purge  //get skb from sk_receive_queue
>                 ...
>                 __skb_queue_purge_reason
>                   kfree_skb_reason
>                     __kfree_skb
>                     ...
>                     skb_release_all
>                       skb_release_head_state
>                         netlink_skb_destructor
>                           vfree(skb->head)  //sleeping while holding spinlock
> 
> [...]

Here is the summary with links:
  - [net,v4] netlink: fix potential sleeping issue in mqueue_flush_file
    https://git.kernel.org/netdev/net/c/234ec0b6034b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



