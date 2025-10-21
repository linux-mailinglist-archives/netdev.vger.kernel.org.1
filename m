Return-Path: <netdev+bounces-231166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A07BF5EE6
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D03418C7BD7
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E902E6CBE;
	Tue, 21 Oct 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1RuJlce"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5823A9AD;
	Tue, 21 Oct 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044425; cv=none; b=ty13RhHVYLuAkp4Nql0mB3qwQuiGEODcBbSrumVAjgvyHNFWp7IqeIaEh3VOVfS/q+PeVYSzDfZTAG0StYFps9zewS1Bi60to6nBXdMTrOPWH+Titfl/BiBY+UVWZmJily5GNmZiuyOQGPEswZXpAqEj2kQLQ+Ycy/SIpy10rYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044425; c=relaxed/simple;
	bh=E40pDycN9c1n5k4vstf/G5bJm+GhzdWRH5+oryKYsv8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i6NHRf38fnaW5GTFb0zCV1Haxj0mQSoH0rWyQ82cTUvExF2R1mKHhaijJzHSLjs3OHhNtGvX67bljzfLiH+57URQrt7yHhiBok0+/0x6hfUGrBxfHezX02RMbrBEOpLTFHHFpYskLWnoByrZEx9SFeTKFFYxtNtwybvYivEFq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1RuJlce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAA6C4CEF1;
	Tue, 21 Oct 2025 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761044424;
	bh=E40pDycN9c1n5k4vstf/G5bJm+GhzdWRH5+oryKYsv8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k1RuJlceXigmNTRC9YsGSTy0x5z+IUVuy9nXu4HMJEYubc8J7XAczu/0GsJ6kERNP
	 YLZzGPypKalYJR/4XvddvK34zmkp3B+Bz3NUgFyOlvpM5YK0vCSYrJkL0z+CNHqjrX
	 SgUn1j8MkGw4dxTgJ1sjEM7nsdjuHxxAf8lG5nLZ1v+Z4iXC2zLjEN55l4ZvDXZ/Jn
	 ubf9XpDEKojaHbz6uGUax4NF8kf5GAh2z+Bir7Keikg1lk9jlki3i0kI+y53jRqSNJ
	 2Y0g254Xh6bPrcl8x6VKnbnfFFAzdsUNSKEQDrsR1df/uOPkgGKPHy1jb81waB+93Z
	 rfnPtcpy00hKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F423A55ECC;
	Tue, 21 Oct 2025 11:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpts: fix timestamp loss
 due
 to race conditions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176104440629.1025140.2694526170701445525.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 11:00:06 +0000
References: <20251016115755.1123646-1-a-garg7@ti.com>
In-Reply-To: <20251016115755.1123646-1-a-garg7@ti.com>
To: Aksh Garg <a-garg7@ti.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com,
 linux-kernel@vger.kernel.org, c-vankar@ti.com, s-vadapalli@ti.com,
 danishanwar@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 16 Oct 2025 17:27:55 +0530 you wrote:
> Resolve race conditions in timestamp events list handling between TX
> and RX paths causing missed timestamps.
> 
> The current implementation uses a single events list for both TX and RX
> timestamps. The am65_cpts_find_ts() function acquires the lock,
> splices all events (TX as well as RX events) to a temporary list,
> and releases the lock. This function performs matching of timestamps
> for TX packets only. Before it acquires the lock again to put the
> non-TX events back to the main events list, a concurrent RX
> processing thread could acquire the lock (as observed in practice),
> find an empty events list, and fail to attach timestamp to it,
> even though a relevant event exists in the spliced list which is yet to
> be restored to the main list.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: ti: am65-cpts: fix timestamp loss due to race conditions
    https://git.kernel.org/netdev/net/c/49d34f3dd851

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



