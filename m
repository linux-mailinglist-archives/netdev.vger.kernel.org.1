Return-Path: <netdev+bounces-15000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CC0744E32
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 16:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046EB2807BC
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8DA210D;
	Sun,  2 Jul 2023 14:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8F17C9
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 14:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5681FC433CA;
	Sun,  2 Jul 2023 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688309422;
	bh=Wc0RhP4G/pv3DHMY2yfgseffeJ8g3oRRMSXqSu0WTd8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m/iVoT4b9DimYe1pRUw+So14f/kTqawakGnautvzHUMASOV6nrkKhHIWj5rxi/vOg
	 MZB+pAM6RyENU1+xrJluqfYWa6nMQu7um7oKGmzoDYgFhmfootIHuZzJBe2+ssOwQt
	 cxfoCG4R9yQ4mTKy87m/zFP8HJXEZJOvvXTc4a7+pkk1WTFrlNIlTF4TdVoztuYfEU
	 KQeSHHGOWbAYAYcCwHRvPoiBDNTcECjk7sDVFVCUWzDip0mcPry4kWS6W6z3MnQqZ6
	 f/5j0OMT/l4gyCqDcSy0Tg7+A/O393AfUQLPkuHcSed9KYAgvlDLnk1oEXd2fBRfkX
	 XdAhR/ruT8pag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D4A2C691F0;
	Sun,  2 Jul 2023 14:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nvme-tcp: Fix comma-related oops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168830942217.27441.11517289068592385502.git-patchwork-notify@kernel.org>
Date: Sun, 02 Jul 2023 14:50:22 +0000
References: <59062.1688075273@warthog.procyon.org.uk>
In-Reply-To: <59062.1688075273@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, aaptel@nvidia.com, sagi@grimberg.me,
 willemb@google.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 kch@nvidia.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, axboe@kernel.dk, willy@infradead.org,
 linux-nvme@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Jun 2023 22:47:53 +0100 you wrote:
> Fix a comma that should be a semicolon.  The comma is at the end of an
> if-body and thus makes the statement after (a bvec_set_page()) conditional
> too, resulting in an oops because we didn't fill out the bio_vec[]:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000008
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     ...
>     Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
>     RIP: 0010:skb_splice_from_iter+0xf1/0x370
>     ...
>     Call Trace:
>      tcp_sendmsg_locked+0x3a6/0xdd0
>      tcp_sendmsg+0x31/0x50
>      inet_sendmsg+0x47/0x80
>      sock_sendmsg+0x99/0xb0
>      nvme_tcp_try_send_data+0x149/0x490 [nvme_tcp]
>      nvme_tcp_try_send+0x1b7/0x300 [nvme_tcp]
>      nvme_tcp_io_work+0x40/0xc0 [nvme_tcp]
>      process_one_work+0x21c/0x430
>      worker_thread+0x54/0x3e0
>      kthread+0xf8/0x130
> 
> [...]

Here is the summary with links:
  - [net] nvme-tcp: Fix comma-related oops
    https://git.kernel.org/netdev/net/c/c97d3fb9e0e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



