Return-Path: <netdev+bounces-96221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142DA8C4AB2
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 03:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86968B22485
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35F315A8;
	Tue, 14 May 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUHaHtSP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142FEDC;
	Tue, 14 May 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715648429; cv=none; b=GWn+sfoZMr08Wvlf1RG8bO/C7JyBtOaYm7rvEbh3y5oxU63D+EYe2iq7j1UMvO0mbIZ7JsNXm9nSS2dX2d0O/P1QmHb2R7Tgnbn8drAn8WIIlm3hqXfEsEzo7UD9EagrYboknW0lBaa9rXSuUUVfYwiDdh8xO+cLP/z49ZJP2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715648429; c=relaxed/simple;
	bh=E5AY8dfKlOU1rOU80YnyA0n26lpjKt6Wld2wUg4Wwas=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kkk7+CHzFh2sRL8TrdSjgv4dzyJK4YjEVSXl/+6pFHWyzuDT8VFNkXA8eRNDuyFixbEi/AwU5X9zRJZnh+mY0sj54XGEDHSDBEc837FHIn1LR9SPi8v3e0jI5YmQpJX2W3ZmYjNGJ0rTGc4viLhpG7O8hASDFWGKLU3+v8ZxXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUHaHtSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 418A7C32782;
	Tue, 14 May 2024 01:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715648429;
	bh=E5AY8dfKlOU1rOU80YnyA0n26lpjKt6Wld2wUg4Wwas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pUHaHtSP4HIltHGM0u7E5/7IB0rDPt9DB7zWnDsiPUOiloWFJjzDjw5Sq9yZgRI8f
	 QhMDzt+exPKpDYWomMTPxAvPiEpj7+hp5Y8NrhP0x0JwqRfq/uE5DcMespnkKbCTDx
	 GegOLB4s2AUzT90BHqyprF8bOWHjZv0cWHi4t9NrVz4T5w2jhz0mWDri9J2kkMq+kC
	 OWc11fTAxIhi+CmEbkFH1NULrbzV0TQtWKDEGrWmoKvLr0AcH5x1hvBS+lbv6q+izx
	 S96ea2deDI+Ua1w1PnsjvESR7DxcJwpfj4EQ2kgEQBAh0AXilo0Fgy1fWlE3/+Dj07
	 bUIDNtDLQKjaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 298C6C433F2;
	Tue, 14 May 2024 01:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fec: remove .ndo_poll_controller to avoid deadlocks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564842916.4255.8652669521897481692.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 01:00:29 +0000
References: <20240511062009.652918-1-wei.fang@nxp.com>
In-Reply-To: <20240511062009.652918-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 May 2024 14:20:09 +0800 you wrote:
> There is a deadlock issue found in sungem driver, please refer to the
> commit ac0a230f719b ("eth: sungem: remove .ndo_poll_controller to avoid
> deadlocks"). The root cause of the issue is that netpoll is in atomic
> context and disable_irq() is called by .ndo_poll_controller interface
> of sungem driver, however, disable_irq() might sleep. After analyzing
> the implementation of fec_poll_controller(), the fec driver should have
> the same issue. Due to the fec driver uses NAPI for TX completions, the
> .ndo_poll_controller is unnecessary to be implemented in the fec driver,
> so fec_poll_controller() can be safely removed.
> 
> [...]

Here is the summary with links:
  - [net] net: fec: remove .ndo_poll_controller to avoid deadlocks
    https://git.kernel.org/netdev/net/c/c2e0c58b25a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



