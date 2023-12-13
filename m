Return-Path: <netdev+bounces-56814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2E1810E9E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD4F281C5C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9786822EF0;
	Wed, 13 Dec 2023 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcDpcYhR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94EFBED
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 10:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07B33C433C8;
	Wed, 13 Dec 2023 10:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702464026;
	bh=WCV1i53lTXPKTwUIVIpnMXuTzaxxWkJ2u3EbQ9flqQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gcDpcYhRWdZ0YmaDklKvlpfO7NH4luUvLpObF5DRfbG0SU/jtVXL3mXdMTaug6PY8
	 JcSFXZL1r5vsBmJCrb+vZWR0cZyqlhmpB47LghxfCMu9HT2YQM8yTJD31xXkJYA0F/
	 uGZbc/oadXhsRNZgBluGvwjj/k16f+VIXosJs1kXnH9j1uWsFkS95jtky0k2apP+ZX
	 6Xwq4K3+EYMTbc36MioeuWGRdgZGumQHOi7io77yxPVqEdZxb0fSmXlyev2vi3fkCu
	 qebM9W4OUclAWjexMOG0/JTH6iWHGYuG/CWDJdaeIGINbjr3yqJzKhThwMkiz5s0BC
	 A4nzaZXmZBrBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E22C8DD4EFD;
	Wed, 13 Dec 2023 10:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tcp: disable tcp_autocorking for socket when TCP_NODELAY flag
 is set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170246402592.27343.16161766477481368647.git-patchwork-notify@kernel.org>
Date: Wed, 13 Dec 2023 10:40:25 +0000
References: <20231208182049.33775-1-dipiets@amazon.com>
In-Reply-To: <20231208182049.33775-1-dipiets@amazon.com>
To: Salvatore Dipietro <dipiets@amazon.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 blakgeof@amazon.com, alisaidi@amazon.com, benh@amazon.com,
 dipietro.salvatore@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 8 Dec 2023 10:20:49 -0800 you wrote:
> Based on the tcp man page, if TCP_NODELAY is set, it disables Nagle's algorithm
> and packets are sent as soon as possible. However in the `tcp_push` function
> where autocorking is evaluated the `nonagle` value set by TCP_NODELAY is not
> considered which can trigger unexpected corking of packets and induce delays.
> 
> For example, if two packets are generated as part of a server's reply, if the
> first one is not transmitted on the wire quickly enough, the second packet can
> trigger the autocorking in `tcp_push` and be delayed instead of sent as soon as
> possible. It will either wait for additional packets to be coalesced or an ACK
> from the client before transmitting the corked packet. This can interact badly
> if the receiver has tcp delayed acks enabled, introducing 40ms extra delay in
> completion times. It is not always possible to control who has delayed acks
> set, but it is possible to adjust when and how autocorking is triggered.
> Patch prevents autocorking if the TCP_NODELAY flag is set on the socket.
> 
> [...]

Here is the summary with links:
  - tcp: disable tcp_autocorking for socket when TCP_NODELAY flag is set
    https://git.kernel.org/netdev/net/c/f3f32a356c0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



