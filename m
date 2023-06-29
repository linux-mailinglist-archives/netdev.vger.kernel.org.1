Return-Path: <netdev+bounces-14515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370D742391
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79989280CF1
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD4CBA20;
	Thu, 29 Jun 2023 10:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA553FEA
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E0E1C433C9;
	Thu, 29 Jun 2023 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688032821;
	bh=6BSYODeXAvBc1bYzqyJYg+UUhE64/mpp9Tu40F5CwoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oDHVOrr/5JM70o8y0DmxBWIVGGiaWWXfzS94TATG7gX18UJiEXtcnfnbjgS14itYd
	 RjDupaiQALNLc4zEyV9ElOhba0fYXYHoDfJ8tZlsfgOg1DJaaeZZK48ThBknPuQxOc
	 /7gEQdxojynYXj5ZWNDMbsuGzHRw6KBoX5a+8Wna1pZuuPXLPuKXxMndlqBCyoRav7
	 mGuQVJGE6lMiPKEWQdF9qjiHgVRjXoivbJ/ASo3o5t76qKE40VFbLNBe5mw9QHMw4u
	 5oN9H5Ihhy4pdzSmD/s49gZuNXWuInDrpEWATZHph7ul1/wK8ZNnhRUc3KEzn2s27h
	 gp9+ZfzIrhcnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40A04C395D8;
	Thu, 29 Jun 2023 10:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sctp: fix potential deadlock on &net->sctp.addr_wq_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168803282125.4865.3870530612120862542.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jun 2023 10:00:21 +0000
References: <20230627120340.19432-1-dg573847474@gmail.com>
In-Reply-To: <20230627120340.19432-1-dg573847474@gmail.com>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Jun 2023 12:03:40 +0000 you wrote:
> As &net->sctp.addr_wq_lock is also acquired by the timer
> sctp_addr_wq_timeout_handler() in protocal.c, the same lock acquisition
> at sctp_auto_asconf_init() seems should disable irq since it is called
> from sctp_accept() under process context.
> 
> Possible deadlock scenario:
> sctp_accept()
>     -> sctp_sock_migrate()
>     -> sctp_auto_asconf_init()
>     -> spin_lock(&net->sctp.addr_wq_lock)
>         <timer interrupt>
>         -> sctp_addr_wq_timeout_handler()
>         -> spin_lock_bh(&net->sctp.addr_wq_lock); (deadlock here)
> 
> [...]

Here is the summary with links:
  - sctp: fix potential deadlock on &net->sctp.addr_wq_lock
    https://git.kernel.org/netdev/net/c/6feb37b3b06e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



