Return-Path: <netdev+bounces-200483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0347EAE594B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 03:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39D91B647F1
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B71618641;
	Tue, 24 Jun 2025 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbHG/0Z9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF73FE7;
	Tue, 24 Jun 2025 01:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750729179; cv=none; b=iH1OW4ddrAMZ2eQFMExlghdFQXctRAkssTCUjlV1eEthPrp276U54gYy3FAzninKlNe8mVrDCmI47kccl6TcVhzo+WIWuAgYPMrfgJ15QWRXatfIR7u4ewuAc9fb7X8/7HV1qPowJggnVA9Qs2fylu62qH9ndWdfhR+JVGgUTlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750729179; c=relaxed/simple;
	bh=joXFcEELb/Hp9GlSnig36MGwdaoUMzTPT4cuWEZnE8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ldFJSpjmUZXSLZp4Aho7ypNPdMcaaNVbqJlcFCfrpDt6f6ZuvsAZsvE2Km6cU9fkMT1NqWnDr7qeDrudo5sa6h4nk8H0LYgi/8Nr4cJUD88vt2onymopdsf8tOrzihaNNpyzm6LH51ahyGTIr6BmTZJiA4hJkhgNvYJPdcRaDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbHG/0Z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A77BC4CEEA;
	Tue, 24 Jun 2025 01:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750729178;
	bh=joXFcEELb/Hp9GlSnig36MGwdaoUMzTPT4cuWEZnE8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YbHG/0Z94e6NKEyukjIvoGii1RCF+d4hgdUZ7MWwK9h/hYNc9B/fLiloRU0f63HB8
	 zNc2ocke8/ZDs4Egy4ZgYA8aiExJ8N4fHF5qIjLYhnAOST32xG6Es1DNSqyuxtI44T
	 qQdaHnBO9ys2fnxTjWUL+xukZauZBSLVnd3onrPXyQPpfRLEW3gMnQFYDgWn8XHGX9
	 40slwAADzH6u8hNmjQt6OFAkmcCpIQ768KwGlSBwWBMlRjje4hAbBrWa2IolXt2wa7
	 9+fENuG3MujoK4ztDgR0Aaq7IHi/PtLlcSST66NiCstYcI6cjrVYsY6N8OL1uVOR4S
	 jpPOS3xKlNigg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6DB39FEB7D;
	Tue, 24 Jun 2025 01:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bridge: mcast: Fix use-after-free during router port
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175072920551.3360382.12478260241123330685.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 01:40:05 +0000
References: <20250619182228.1656906-1-idosch@nvidia.com>
In-Reply-To: <20250619182228.1656906-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, razor@blackwall.org,
 horms@kernel.org, petrm@nvidia.com, yongwang@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Jun 2025 21:22:28 +0300 you wrote:
> The bridge maintains a global list of ports behind which a multicast
> router resides. The list is consulted during forwarding to ensure
> multicast packets are forwarded to these ports even if the ports are not
> member in the matching MDB entry.
> 
> When per-VLAN multicast snooping is enabled, the per-port multicast
> context is disabled on each port and the port is removed from the global
> router port list:
> 
> [...]

Here is the summary with links:
  - [net] bridge: mcast: Fix use-after-free during router port configuration
    https://git.kernel.org/netdev/net/c/7544f3f5b0b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



