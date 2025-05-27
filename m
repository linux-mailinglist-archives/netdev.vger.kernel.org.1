Return-Path: <netdev+bounces-193659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D420AC5034
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF759189682F
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE042701DC;
	Tue, 27 May 2025 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtyhFOCL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8F134AB;
	Tue, 27 May 2025 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353794; cv=none; b=g3cyv6H9GbUr1CWYLTK28dLH/WhlQ80/Re2MrXaJpFVwkf7vqWaoo9UFdZPgokRHGkYFaVbaduJxOaK+vni4Jkdafw+ULKEMp4zxP0qzjCmTgZIXi6bZU8991aMaXGPRyRVo04HExUYPsCS/zIVB7wQoGo5/vCF1GgLMLup5288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353794; c=relaxed/simple;
	bh=uH0uz40juE5V9Ge8tLOFlAbLYizJ/RQQk47dwWh3YnU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X3P0xmhNR+ae/5zvq2GAqUxok1U/Ft5aGU9W6KpGQzyiQB2LBLcIr1k/h95kaQxA2UKKfBfu10uiYsoQ2uSby9WAnlhRqhdetMzVmMyam0sfkhbI8RjGoaA474j0XmgxBYjZJ0Rc8W60rC+/G4Ct8rrjmgM2WK7nEdnCxjGFmQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtyhFOCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDC2C4CEEB;
	Tue, 27 May 2025 13:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748353794;
	bh=uH0uz40juE5V9Ge8tLOFlAbLYizJ/RQQk47dwWh3YnU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UtyhFOCLtHlywTIBuiFUEFbfO2zf/CcQ2oFV41vd9SA0Y1LlnFiCYqZlqJsOYYiC0
	 pykplu2fUtvFv7K7j1wM8ADjaW5op0w26j0VC9RPuV6stfCkukrYGme9lLkPrRffYx
	 Bj56pjYrMCMQHOLp98cYT7bHf6gyFK5kJ3mIN7/sBu5Nw2Hhqkp1WM6KChl+cFnPw5
	 I0Uc6GcG8r6qdMw+/pGJq3wdp612k9ffbJNGWhVJ8+3MraGPZOSHhi+aLsFnSQt2m1
	 IMEzoIhf3LaOjMKkttIGnc+agl+6dC4ON47vozAJY1MlisPxNIYVbCuMyeuFmxceTu
	 Tlqix/J64upyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9C380AAE2;
	Tue, 27 May 2025 13:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] af_packet: move notifier's packet_dev_mc out of rcu
 critical section
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174835382850.1645024.12860246850484744014.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 13:50:28 +0000
References: <20250522031129.3247266-1-stfomichev@gmail.com>
In-Reply-To: <20250522031129.3247266-1-stfomichev@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
 horms@kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 May 2025 20:11:28 -0700 you wrote:
> Syzkaller reports the following issue:
> 
>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:578
>  __mutex_lock+0x106/0xe80 kernel/locking/mutex.c:746
>  team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
>  dev_change_rx_flags net/core/dev.c:9145 [inline]
>  __dev_set_promiscuity+0x3f8/0x590 net/core/dev.c:9189
>  netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
>  dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286 packet_dev_mc net/packet/af_packet.c:3698 [inline]
>  packet_dev_mclist_delete net/packet/af_packet.c:3722 [inline]
>  packet_notifier+0x292/0xa60 net/packet/af_packet.c:4247
>  notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
>  call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
>  call_netdevice_notifiers net/core/dev.c:2228 [inline]
>  unregister_netdevice_many_notify+0x15d8/0x2330 net/core/dev.c:11972
>  rtnl_delete_link net/core/rtnetlink.c:3522 [inline]
>  rtnl_dellink+0x488/0x710 net/core/rtnetlink.c:3564
>  rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6955
>  netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
> 
> [...]

Here is the summary with links:
  - [net,v2] af_packet: move notifier's packet_dev_mc out of rcu critical section
    https://git.kernel.org/netdev/net/c/d8d85ef0a631

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



