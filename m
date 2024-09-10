Return-Path: <netdev+bounces-126777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38602972731
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 04:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6517B1C237D0
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694D13A242;
	Tue, 10 Sep 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZN7IvtR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEC1EF01
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935427; cv=none; b=ITizueVa+NnG6oNAixafsR1SiPKPIcbZGCAgKFTl901usB5SlcdWoMqmuOc8tzLg97s6ZxpDYTWrMgqwsa4KM7rDzbmcHHprkMBDN0LnPmFmRpyCCTGyzDfHeMrKPVZ+TCtT3w1ps411mT8jFpus0Wj+v1OMw7Up9GSfFXZbGUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935427; c=relaxed/simple;
	bh=ZNLTUYy6gTOPnJ/YbDNdq/4XyP/exHDtGTkQxokwOTo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gXYhciigDGuBp3pL53ovjiAFLvlG6BcNy5zWDrbXVXcXJrBhTUQQyiyeKDW9yxArcp+GNBR66QHV622fOfRpYqAHjIrzgpRS/d1xY8uQqScFA7pHASStASzbmYEVy2oMh9bk8FTA/iA0Buxx0YL6uxizt3ZouzMHJlqddov1tog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZN7IvtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E363C4CEC5;
	Tue, 10 Sep 2024 02:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725935427;
	bh=ZNLTUYy6gTOPnJ/YbDNdq/4XyP/exHDtGTkQxokwOTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sZN7IvtRDoUZ7w0gnAe+gt/+hWpABZDZvIqfdZtJE/T0595vdjZk/ThXYPSR49P72
	 Zh/uyKtNqnKf5+igUkXIL6NRVy0x2Hgj5vuzb6Kqr7ZUX6HN5Rrazl0EP8OlYwr3Hy
	 1l9oASiMFuVU412TgEeDGzFeefwlEu9S8LZ86GkflxSAocdmkenMQghXFh5Gla6Deb
	 yXnL4IcXYT78NRTDJ2XNIxprBD0Vz3/3pVa7xfKYIJO4oX8SHGL+V+P1mRczzokj7S
	 wlZ3+omFmbjFa6BvhJWHebe80I1gBoN+iWEI/+NLzAZ4oxKz8iUaj3V7FovVGFvtr5
	 ObSzW/begVO4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710EE3806654;
	Tue, 10 Sep 2024 02:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/7] ionic: convert Rx queue buffers to use
 page_pool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172593542827.3991832.6700093214534269837.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 02:30:28 +0000
References: <20240906232623.39651-1-brett.creeley@amd.com>
In-Reply-To: <20240906232623.39651-1-brett.creeley@amd.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, shannon.nelson@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 6 Sep 2024 16:26:16 -0700 you wrote:
> Our home-grown buffer management needs to go away and we need to play
> nicely with the page_pool infrastructure.  This patchset cleans up some
> of our API use and converts the Rx traffic queues to use page_pool.
> The first few patches are for tidying up things, then a small XDP
> configuration refactor, adding page_pool support, and finally adding
> support to hot swap an XDP program without having to reconfigure
> anything.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/7] ionic: debug line for Tx completion errors
    https://git.kernel.org/netdev/net-next/c/4a0ec34870a2
  - [v3,net-next,2/7] ionic: rename ionic_xdp_rx_put_bufs
    https://git.kernel.org/netdev/net-next/c/7639a6e05815
  - [v3,net-next,3/7] ionic: use per-queue xdp_prog
    https://git.kernel.org/netdev/net-next/c/7b4ec51f165f
  - [v3,net-next,4/7] ionic: always use rxq_info
    https://git.kernel.org/netdev/net-next/c/668e423920de
  - [v3,net-next,5/7] ionic: Fully reconfigure queues when going to/from a NULL XDP program
    https://git.kernel.org/netdev/net-next/c/a7f3f635f07a
  - [v3,net-next,6/7] ionic: convert Rx queue buffers to use page_pool
    https://git.kernel.org/netdev/net-next/c/ac8813c0ab7d
  - [v3,net-next,7/7] ionic: Allow XDP program to be hot swapped
    https://git.kernel.org/netdev/net-next/c/3c0bf13f5d5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



