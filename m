Return-Path: <netdev+bounces-154023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 443969FADEA
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 12:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5151882091
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 11:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CA5198A25;
	Mon, 23 Dec 2024 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qb1VS5ES"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9D192D73
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734954611; cv=none; b=cu3vaH/mC4Si6jH1pC594T/rdfa+x8y1AXzEXQYzuPqSYTkS7B3jyUzMixFGc8atTNuYgkfgypa3Y9x6flNdTFB4AyS7aJ18WS/bla2QzTdGfMh5zDnVfxt2arPRuu5dYo7rGoPX125NTAq4+9UnZ022Hrq1QL67zCfq89RscJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734954611; c=relaxed/simple;
	bh=pXwf2S1yobXRawjiw7iBv4KfqzammN330ksWSvQbjJs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iqedcYpYy8phmcXP2yB/hLwMXoPUoFsRpN2k5LpETli/DSNS2siNgGcLPl6cCYKIFzK/nwQo4+4SN2T2/70cB1gALj305I2t4N7VVGcLdoZk9ORF5FldWpD6kvtdUjeISY4aTJdbLZzS0Yp/iW+3kzqQbovnJljnT6MBxSHumf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qb1VS5ES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B13C4CED3;
	Mon, 23 Dec 2024 11:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734954611;
	bh=pXwf2S1yobXRawjiw7iBv4KfqzammN330ksWSvQbjJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qb1VS5ESoDF8FQy2mX3YdoX7idJilUkI+ckXE28oGiajMgqIeCw3nEN4JqivKQXi8
	 pIpnDIn6UND8x80Ks5UDkIsohoi5S4dk2pL4At7RW+tWm8jpJggvD2qC9WgjBvG69I
	 kFp2VbFbSE31NXofHdDNexe+GGp+pfEE7NrpqpzTSu6+NGNZ5SWCGqTjaunIZF4Mim
	 dmitYObTEpFPKMDe2UeR0DnnGhPlun8NWaLBU8TfVS13ZdMSJly+Iv/DfsFwJ6KGK6
	 wsGAQkkH7SKK2+onZ97gS6UR1WPlKjlj/dWUJt6DaKginxLyefEynNsvDyWiT6GS11
	 MW0/LZX0DASkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD3F3806656;
	Mon, 23 Dec 2024 11:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] udp: Deal with race between UDP socket address
 change and rehash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173495462976.3848117.16494580835823319856.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 11:50:29 +0000
References: <20241218162116.681734-1-sbrivio@redhat.com>
In-Reply-To: <20241218162116.681734-1-sbrivio@redhat.com>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, kuniyu@amazon.com, mvrmanning@gmail.com,
 david@gibson.dropbear.id.au, pholzing@redhat.com, lulie@linux.alibaba.com,
 cambda@linux.alibaba.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com, posk@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 18 Dec 2024 17:21:16 +0100 you wrote:
> If a UDP socket changes its local address while it's receiving
> datagrams, as a result of connect(), there is a period during which
> a lookup operation might fail to find it, after the address is changed
> but before the secondary hash (port and address) and the four-tuple
> hash (local and remote ports and addresses) are updated.
> 
> Secondary hash chains were introduced by commit 30fff9231fad ("udp:
> bind() optimisation") and, as a result, a rehash operation became
> needed to make a bound socket reachable again after a connect().
> 
> [...]

Here is the summary with links:
  - [net-next,v2] udp: Deal with race between UDP socket address change and rehash
    https://git.kernel.org/netdev/net-next/c/a502ea6fa94b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



