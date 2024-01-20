Return-Path: <netdev+bounces-64453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060578332DD
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 06:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92BEAB230A1
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 05:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AB815D5;
	Sat, 20 Jan 2024 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnUCRYnM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B7A1858
	for <netdev@vger.kernel.org>; Sat, 20 Jan 2024 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705729232; cv=none; b=ZxxnyNEr2vfbVvmcTUrZNFFt+QL1o8Hc8vD63eNBcluqVze7Iwlm7EnHH45DGpxXyXFLFoe1rBQ09sMM+OKldJth6Vlf1VhTKdPbxqHCAI+yjpYZgqEzqkQ0Pc9vLs3Gap0NWu66ZsKQ1bFm4SGlSO7oM9XmgGtrNjUV5uvN6M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705729232; c=relaxed/simple;
	bh=XjW0WSo22kiZZf7rcnzxnmI8nexvL1ZGy1t8q8lwruI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LU8REhPYomDdUFhiPwrV46Z4zWO9/N7Q5KsnAh9IdYAv0WJA5s+yHuTHsaEZ+Wvr11iWZiD/ztnxXDvr6lFanKgOiHN8buFNf+p6p6aSRa4oFAWRCCtPDJGTG6Sgp5FkoiQyXGDW8PAw2BiOb/thJ+n5qRQNnvyZG79FWfFxqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnUCRYnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D61BC433F1;
	Sat, 20 Jan 2024 05:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705729231;
	bh=XjW0WSo22kiZZf7rcnzxnmI8nexvL1ZGy1t8q8lwruI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OnUCRYnMgXdoylUyE/j32j5nH2mYUu4RtVXVu6xuok3qBBiFGwgMS+xpAWDIafYue
	 CKMJ9bvf1brWdkF6vsQxw4Dis0bGaZJvxLSKwqPyLVmOYux/ea6W+JtcCM+6QKlzck
	 +SAaaetTV04d/BSztaXNxucmX67BkE2w5237BwBL6YhAgsBcUdgyOxvXb16BlvaU/G
	 GQjYHFWNRr8ceWNm6UqJVpVz81Jyq1khEMKFjYkt+lrKfyWcaDT2lnMKL6gBAGnhBD
	 i2t/Fbxey/J9vrlZwukZFFd74Zouc/bdTS4NYUxf9OLDRhjUVY/3ZFt9G8IGp/jgI2
	 1hevwf7JVeY4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70772D8C985;
	Sat, 20 Jan 2024 05:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] llc: make llc_ui_sendmsg() more robust against bonding
 changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170572923145.12405.17596372197277847619.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 05:40:31 +0000
References: <20240118183625.4007013-1-edumazet@google.com>
In-Reply-To: <20240118183625.4007013-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+2a7024e9502df538e8ef@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jan 2024 18:36:25 +0000 you wrote:
> syzbot was able to trick llc_ui_sendmsg(), allocating an skb with no
> headroom, but subsequently trying to push 14 bytes of Ethernet header [1]
> 
> Like some others, llc_ui_sendmsg() releases the socket lock before
> calling sock_alloc_send_skb().
> Then it acquires it again, but does not redo all the sanity checks
> that were performed.
> 
> [...]

Here is the summary with links:
  - [net] llc: make llc_ui_sendmsg() more robust against bonding changes
    https://git.kernel.org/netdev/net/c/dad555c816a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



