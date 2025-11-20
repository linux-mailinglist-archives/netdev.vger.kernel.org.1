Return-Path: <netdev+bounces-240351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DCFC73B79
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DCE64E82AD
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 11:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5692337BB2;
	Thu, 20 Nov 2025 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k914ASyh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335BB337B90;
	Thu, 20 Nov 2025 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637641; cv=none; b=U9+dHyzrgfXg6YtsvwlQkoJisF/Y0FndU3yYI6SORhxhTw4leGZlPVQVDZj0A7zjiioawDclA659nOHLbszW75On1hMwf7eOrCq8ggJrdqY46LniC0ozH1cUaQzh/m2l0mjyspk7R+4YPTn7TY3J+hLjjgjdDFxkjp+1L/dwuEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637641; c=relaxed/simple;
	bh=NPis4lGIzRENwNC8RL+waJhQBAh3ydR+JSiZg+5KEmQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KfATtevQVwxdIPHAUSTcvk1M+jr8St4YnKRUZ38qupQney1tkR7Jn4rtO4N4Dyuf22qWTitj5GSZlupcGOjYEPLsMZNW5bmZJcT4Tu2atZ2Q2Xs/aHPhUdjBm8F/SrB2rzRcIVk6Qr1wZXWvwQ8gJXt1RYfSyPnM1orfZVONRfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k914ASyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D605DC4CEF1;
	Thu, 20 Nov 2025 11:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763637640;
	bh=NPis4lGIzRENwNC8RL+waJhQBAh3ydR+JSiZg+5KEmQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k914ASyhSFRSziz3mXQUxMBbObOSp4Gn4fZjLPNy2Sh91HYEDRmZMbeDpebR0JYnF
	 Ooar61W0RXVXrMRPS3phcO+tZJzbGWK/bMKIwaF36G3kgqFh1pHD/kECWANX+I7o4Y
	 I04pV34lpEBzxWllaVv+cMTRIv+gXXjT8wwcvo7Md9s/4oTU7iNTeNM+FScibo2RAb
	 ImJbmQxaZoBHWsmRgyg/E3VYkqmQ5JzhcZYvX1Ip76fWcbErsswQO0wMcluzxIbg0B
	 VMnulOLWXRuHJ4XlUK+5f49XSdqxisygq6VOYQrd04vD2/gLXKJf0MrlX0G6UF8r1Q
	 b81jZEVZ3p0hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B2E39EFA6F;
	Thu, 20 Nov 2025 11:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] l2tp: reset skb control buffer on xmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176363760630.1581289.683888947957322970.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 11:20:06 +0000
References: <20251118001619.242107-1-mail@david-bauer.net>
In-Reply-To: <20251118001619.242107-1-mail@david-bauer.net>
To: David Bauer <mail@david-bauer.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kaber@trash.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 18 Nov 2025 01:16:18 +0100 you wrote:
> The L2TP stack did not reset the skb control buffer before sending the
> encapsulated package.
> 
> In a setup with an ath10k radio and batman-adv over an L2TP tunnel
> massive fragmentations happen sporadically if the L2TP tunnel is
> established over IPv4.
> 
> [...]

Here is the summary with links:
  - [net] l2tp: reset skb control buffer on xmit
    https://git.kernel.org/netdev/net/c/d70b592551ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



