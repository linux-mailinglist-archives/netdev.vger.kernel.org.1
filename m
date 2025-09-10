Return-Path: <netdev+bounces-221501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB96CB50A5B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 03:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FAC1C611A8
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94EE2153ED;
	Wed, 10 Sep 2025 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONpkC8pg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9527F20487E
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468407; cv=none; b=oxE0crEZHrJxYht7wIeIm0TCoYeeIE0mlBuOBff2+TGvhDSa3Q9kSIJ57DfR67FSRZIyK4WcoZWLx1nSLezU1AU8SzOXe8UreyzQemaEEjucKskIhfYDcUYQAbd6Fo1r1jvz/iMoixExaAc5wysoAqMug97YMqssrvFz0cLr718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468407; c=relaxed/simple;
	bh=EapRHSwA2No09NDUz/C4Ukpub1nQYSAq/dCmBH8RBBk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uxt378tqad+kKHwdi7/7U/AhOwQo2AFLOdGjM1nRkbirKAIj2SWCVb555UyUfBzeaN4ag6fx9KNME5vDKaB6K4yK0XkIeKiNaqMjEkM7nbs+mqVVxn94tv2/77Zk8Dl8ZuFsQR6ME+uuEJnYpHb5A77TyVYnErmKL/FTjwhNkC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONpkC8pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC59C4CEF4;
	Wed, 10 Sep 2025 01:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757468407;
	bh=EapRHSwA2No09NDUz/C4Ukpub1nQYSAq/dCmBH8RBBk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ONpkC8pgX+RXMcNPyH0KCQAZj52dfGvtc2zTq3H4S7uL5o/Dl6XiLK6MrcMRxfAyT
	 judbiFMrmEPYctl6HRlBo4N8cYtUZ5nBxucy2x9EgQygbp8wDSQTFLYKwweb6Dvs6l
	 mcrlQBnZfa5zGSJLoblD30nY4iUezfJlu1+Idc54UhSB3sc0cBvMaP66PDCGYBcrc0
	 YYgx1HePDpGbDYsG9yWMQ/reRKkEqCk+ZybQgTdy4EAzM5E5xwgpx4YGdtFGwNZLsd
	 6n/TircFj2WAIeX8YJ8tWaWSKMlmECYMilErhar9j914uhsj8CwNKX16x01FJ0QI1l
	 fqBtRTXCbmnlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71095383BF69;
	Wed, 10 Sep 2025 01:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vxlan: Make vxlan_fdb_find_uc() more robust
 against
 NPDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175746840999.869185.14082698529020620120.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 01:40:09 +0000
References: <20250908075141.125087-1-idosch@nvidia.com>
In-Reply-To: <20250908075141.125087-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 razor@blackwall.org, petrm@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 8 Sep 2025 10:51:41 +0300 you wrote:
> first_remote_rcu() can return NULL if the FDB entry points to an FDB
> nexthop group instead of a remote destination. However, unlike other
> users of first_remote_rcu(), NPD cannot currently happen in
> vxlan_fdb_find_uc() as it is only invoked by one driver which vetoes the
> creation of FDB nexthops.
> 
> Make the function more robust by making sure the remote destination is
> only dereferenced if it is not NULL.
> 
> [...]

Here is the summary with links:
  - [net-next] vxlan: Make vxlan_fdb_find_uc() more robust against NPDs
    https://git.kernel.org/netdev/net-next/c/ce6adea19ad9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



