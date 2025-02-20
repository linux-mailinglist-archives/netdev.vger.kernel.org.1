Return-Path: <netdev+bounces-168290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D2FA3E6A2
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 22:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A034217D3
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 21:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBE5265605;
	Thu, 20 Feb 2025 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgzAJUsS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785B26460A;
	Thu, 20 Feb 2025 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087013; cv=none; b=R2FOzcoUcQlFwIp0+Roh8ze5DSxcmgN6+T+ppXBrxuy2qKfohl4yYbGZo1UW11EUygVdz2L9m/EneBTd3G4+GQb+1N7WEV/wp/b1GWxsyjFmpWa3Wi9TrCsOQkTe+mUswKg+ldXZaWCOCbZZqSV5PTFS/yv5kmndPluzyFzCGs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087013; c=relaxed/simple;
	bh=WXvCg1noA6SS0QvPbxdn8mDxkp7CEpuox/wjHtbc1CA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bWFSLuCv2rlpzDX+cZG5huhd9G1gME/wuRFbjK7jZnYYh9KHCNz3qxwzpVdEwwk9mq7b06EDJaMYH2rA9jX30jWMHmeMvURG2fy5jHDl2CqVFh/qa5MZ4B01hajP9CmBu+RAvouRuvkgRTlD/sXhxolpn8Hp6ILv0oogyCDXixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgzAJUsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3962CC4CED1;
	Thu, 20 Feb 2025 21:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740087012;
	bh=WXvCg1noA6SS0QvPbxdn8mDxkp7CEpuox/wjHtbc1CA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WgzAJUsSG+UpTP9HAD0k7ISbFk57ECWGrKplL89yjvvVIogl1aNQdHeRfslwlf3Pp
	 1mUdd0Ney4kVc5UUYyyZLBFz22pyvBK1ojdYaU6Py2lvwsjqLSA3rUnPldrp8v2tXZ
	 /EeOaUCYGlr0y/6IH0yT2VhXh4cWrUyq2fbYKPlg95V16JUkETPUEDp3SATnmWKCIp
	 hkwv4Y+XDttkr+Vo2cZcy0apCgNZR9aVJEihk4knI9TVhUL0txWp5LWnv883C1XfaX
	 32hjKrwQxsQ7E8UI/AuaUQDaXnvGSPKecGHtfhzHE1bzhwp5DKlSF8Aq6ZIdQ1ORhk
	 n+Hrx5x8lvpeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34AB9380CEE2;
	Thu, 20 Feb 2025 21:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] netdevsim: call napi_schedule from a timer
 context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174008704275.1463107.17187316402427485663.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 21:30:42 +0000
References: <20250219-netdevsim-v3-1-811e2b8abc4c@debian.org>
In-Reply-To: <20250219-netdevsim-v3-1-811e2b8abc4c@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, dw@davidwei.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 08:41:20 -0800 you wrote:
> The netdevsim driver was experiencing NOHZ tick-stop errors during packet
> transmission due to pending softirq work when calling napi_schedule().
> This issue was observed when running the netconsole selftest, which
> triggered the following error message:
> 
>   NOHZ tick-stop error: local softirq work is pending, handler #08!!!
> 
> [...]

Here is the summary with links:
  - [net-next,v3] netdevsim: call napi_schedule from a timer context
    https://git.kernel.org/netdev/net-next/c/bf3624cf1c37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



