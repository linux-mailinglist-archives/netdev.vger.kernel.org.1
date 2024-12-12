Return-Path: <netdev+bounces-151297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3472B9EDE8E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048D9162311
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1E21632DA;
	Thu, 12 Dec 2024 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvfSK8BP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E7126BEE
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733978416; cv=none; b=gMOZrsdh33DCrGFx8Z8nvXqUh/buSZqPgyDmnlwD1oQwNiGBv2hfdsGwC+95nkumVPvrdhkgG5Q2n6DmFsXdIWVM6C0d17END7uhkBua6c/2rh+dMWOQJUQ8itDxGiXjZbprJOfYtGFdPK2X6Dwi62xoZa1I26usLKs+ksj0gDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733978416; c=relaxed/simple;
	bh=ZRjTd5l33pCCxwOixjMB1aMT5fgo66B6Y8yswTCODqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g63K98vK3pH6W8StVpWe8JCUFgse+P3l4AquVjaqTUZDn7ijugPt8/P/9wUbSkb8AaAvPcQ02VQcRRjqxfQ3sVnYpU719Fd0TOs3ydiGOsHHCXjjHB6TYhePC9zdcnNDBr82/BvMQESGgJxnBOH3GL2p2QVxHZ6/tyEqROlITQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvfSK8BP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06B3C4CECE;
	Thu, 12 Dec 2024 04:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733978415;
	bh=ZRjTd5l33pCCxwOixjMB1aMT5fgo66B6Y8yswTCODqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UvfSK8BPsogRainCffLv8M0TdfvAaRbHE4zNKZb8Ll5NZf/8dMObxL5Lhd4/a9TcE
	 VHxUDf/fBWdFyzvwE4YrM9u20Ivt2q338lkZZK+mfShQD3KrldHvxYVCcvbm769PuQ
	 0hLDoyTf5ovkvLy0ytVs6bTvbO5QLx50emAagTCVzAZOAaoSWPlEEbtJD2APHg6OoJ
	 W25/pzI5Y8BV82vDOM0p/54gbNSK9bQiD0q7guZiiESg7suoP3rk80Er3xhl+R/cuN
	 +ODPrObK1ZuzEJaGposXWNrZz8W5uRVHYwE4IhfaQdiebnRCeGTGKrPGD5v1eWsdro
	 mss5zKcK1HcmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF12380A959;
	Thu, 12 Dec 2024 04:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] batman-adv: Do not send uninitialized TT changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397843176.1849456.10690571665535440668.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:40:31 +0000
References: <20241210135024.39068-2-sw@simonwunderlich.de>
In-Reply-To: <20241210135024.39068-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, repk@triplefau.lt, sven@narfation.org

Hello:

This series was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Tue, 10 Dec 2024 14:50:22 +0100 you wrote:
> From: Remi Pommarel <repk@triplefau.lt>
> 
> The number of TT changes can be less than initially expected in
> batadv_tt_tvlv_container_update() (changes can be removed by
> batadv_tt_local_event() in ADD+DEL sequence between reading
> tt_diff_entries_num and actually iterating the change list under lock).
> 
> [...]

Here is the summary with links:
  - [1/3] batman-adv: Do not send uninitialized TT changes
    https://git.kernel.org/netdev/net/c/f2f7358c3890
  - [2/3] batman-adv: Remove uninitialized data in full table TT response
    https://git.kernel.org/netdev/net/c/8038806db64d
  - [3/3] batman-adv: Do not let TT changes list grows indefinitely
    https://git.kernel.org/netdev/net/c/fff8f17c1a6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



