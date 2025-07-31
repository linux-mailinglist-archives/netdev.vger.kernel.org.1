Return-Path: <netdev+bounces-211122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E30B16A62
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 04:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336A05A86CB
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 02:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA84023B610;
	Thu, 31 Jul 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSE37Wlw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA023B602
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753928396; cv=none; b=bs8u76RgvqPJSHFqKDQfaRuRtU0G2Rr69S6TWBAz3EcGn/TTYqZPyKlZ+6jxQ06dxl9IUu0g7h+5F/RZy6+Q/+4271hrhc+haMPBh6o0ecPqycQ/Y952/c10O1UPQGkZ0Gt38tKI/rseDyj7qkiT3ilcQpaIBfjHQNMozPKvrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753928396; c=relaxed/simple;
	bh=5AevClLMxbHu5jL/wpGskHwIU2MUdCxn1dc9ag1YR7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PIr3ALCVe9pJHe6NLMIPWVgMDSufootAl2de1OoxblemgtAGz2cb2LAenBjHf1HLbFYD6Kj7ZG2YVDsegMF4vEFp5GUrmYjLnigm8p2e80mTWexb7bsXBtdMUOKBxPuTgZSz2+PgbsKyOj2GzcI78aYWEUX83ROlQzuGSuEsxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSE37Wlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBE9C4CEF6;
	Thu, 31 Jul 2025 02:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753928395;
	bh=5AevClLMxbHu5jL/wpGskHwIU2MUdCxn1dc9ag1YR7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LSE37Wlw4nJTOGxqho7dM/J1CNSgIsuoeJ9KCRhoyBvOcHYiQLD1u7lQWZ9tNWue+
	 0pmyU2DhGK6PVUad0URtFIWMB+iti4ufL0cqZLpTm4dNrgJYdEpPh/4H6UcsrZeTRq
	 6SF8dFAd4jP8FexwdpDCQFgyWn903B9f4IfU6YLjGoxtsvfc6nzxIWvh8PNTdJjCTJ
	 dyqVlkn9jDDtux2Efyk6ke1hvRU+1ejTQykg/4I/AbK+SjsuKTf1KKTL52MG9uKVnu
	 awdSQ6Xbt86fEPmvTFwpXpERlJ5gkQeC5SZxHRfBAIIML2A7vs7xXo9/tvy/0FF3rV
	 XMTHhflyo9CuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E05383BF5F;
	Thu, 31 Jul 2025 02:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pptp: ensure minimal skb length in pptp_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175392841099.2582155.5911871664061177064.git-patchwork-notify@kernel.org>
Date: Thu, 31 Jul 2025 02:20:10 +0000
References: <20250729080207.1863408-1-edumazet@google.com>
In-Reply-To: <20250729080207.1863408-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+afad90ffc8645324afe5@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Jul 2025 08:02:07 +0000 you wrote:
> Commit aabc6596ffb3 ("net: ppp: Add bound checking for skb data
> on ppp_sync_txmung") fixed ppp_sync_txmunge()
> 
> We need a similar fix in pptp_xmit(), otherwise we might
> read uninit data as reported by syzbot.
> 
> BUG: KMSAN: uninit-value in pptp_xmit+0xc34/0x2720 drivers/net/ppp/pptp.c:193
>   pptp_xmit+0xc34/0x2720 drivers/net/ppp/pptp.c:193
>   ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2290 [inline]
>   ppp_input+0x1d6/0xe60 drivers/net/ppp/ppp_generic.c:2314
>   pppoe_rcv_core+0x1e8/0x760 drivers/net/ppp/pppoe.c:379
>   sk_backlog_rcv+0x142/0x420 include/net/sock.h:1148
>   __release_sock+0x1d3/0x330 net/core/sock.c:3213
>   release_sock+0x6b/0x270 net/core/sock.c:3767
>   pppoe_sendmsg+0x15d/0xcb0 drivers/net/ppp/pppoe.c:904
>   sock_sendmsg_nosec net/socket.c:712 [inline]
>   __sock_sendmsg+0x330/0x3d0 net/socket.c:727
>   ____sys_sendmsg+0x893/0xd80 net/socket.c:2566
>   ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
>   __sys_sendmmsg+0x2d9/0x7c0 net/socket.c:2709
> 
> [...]

Here is the summary with links:
  - [net] pptp: ensure minimal skb length in pptp_xmit()
    https://git.kernel.org/netdev/net/c/de9c4861fb42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



