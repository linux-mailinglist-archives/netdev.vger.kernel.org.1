Return-Path: <netdev+bounces-149873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBE39E7DEE
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 03:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829BF16E17D
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 02:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63217C7C;
	Sat,  7 Dec 2024 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H41QMKYT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B02AD2C
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536815; cv=none; b=bJhPr4YX03pMXwoUirUoRe+rTGpWMOEf2Gd0JAf7fjPgSDb1tFdiS/ArcCjVXg0xGx+eKM3/aVrhaTOwQ6x4dOIp+BkdM5Z/uzVO5a8omsk8oinhLp4d4iOGjqwiRG3Yf2eMzw6LYtQV1/yGA4BjQFUBqDhZrOHibGFOsaNqmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536815; c=relaxed/simple;
	bh=I0lcSTdHy7zATEukLjmy3SZSZCANnuXTg58hJW2Mv4k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gT1NWnhNNmC8LIqzVtwDk3mDHPPmnKeJBk7aZuQiHBW8hIQ2YDXU4qFh2M57nu5cr14TZF7RxlVXw7TVdryQSWLotIWbJ+7Vv6SXRe1iCkdLI3a4AoJEandh0/zKDcm+uaiu3U8oYXIAxqIw5njbRnFLah08h6IzAqwPqt8G0pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H41QMKYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07986C4CED1;
	Sat,  7 Dec 2024 02:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733536815;
	bh=I0lcSTdHy7zATEukLjmy3SZSZCANnuXTg58hJW2Mv4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H41QMKYTs4+g6eKKF2S7ptzfEgXwnzQrQ/42Tz4hcFAFnVig50dpraaUN5WjrmIaZ
	 U69NFh5oaFjdcQtv4SWeVs5/W4e5tyX8kcyMcUA6yqy3s/9FPcL2QCF7Pyd/Spctkj
	 oRtZg9NKpZTJ2pxbxdZxo57vueWxwZh0TMFYwAwXFyZAWc25c9r742R0DO5HfVKMdW
	 gEJJHZElnWDid8Zfs4JPg5f/AGP3iTRsxRuQHO+4wR18LvzK1feUh2hYrdlbYGckQ8
	 gDQagupkPb5bgvwhBN3Lla+DFy4SmbAKy8I/xYas9LXowc73bDwFoulntpO3OGBoMK
	 H4YwrB1FMSjzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DFC380A95C;
	Sat,  7 Dec 2024 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: defer final 'struct net' free in netns dismantle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173353683001.2872036.8357639444032683736.git-patchwork-notify@kernel.org>
Date: Sat, 07 Dec 2024 02:00:30 +0000
References: <20241204125455.3871859-1-edumazet@google.com>
In-Reply-To: <20241204125455.3871859-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, i.maximets@ovn.org,
 dan.streetman@canonical.com, steffen.klassert@secunet.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Dec 2024 12:54:55 +0000 you wrote:
> Ilya reported a slab-use-after-free in dst_destroy [1]
> 
> Issue is in xfrm6_net_init() and xfrm4_net_init() :
> 
> They copy xfrm[46]_dst_ops_template into net->xfrm.xfrm[46]_dst_ops.
> 
> But net structure might be freed before all the dst callbacks are
> called. So when dst_destroy() calls later :
> 
> [...]

Here is the summary with links:
  - [v2,net] net: defer final 'struct net' free in netns dismantle
    https://git.kernel.org/netdev/net/c/0f6ede9fbc74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



