Return-Path: <netdev+bounces-112003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A9A9347A1
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 07:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D866A1C215EC
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 05:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2044C7C;
	Thu, 18 Jul 2024 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1CXisFb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FCD3C08A
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721280632; cv=none; b=bdZYlGqFixHIh+8I8QSz4UuxLmiE8nZM6xREvM5jBFWZAnpU8HIax5cImK98F+KCgPWE00IG3alsJcgmkjHC5fkc9RuY5bOocXnXskKSZRDGQ9e/ODEjqXG5mt6hXMAqzdfvNJpQiQeNOy18pG2pS/gO9YqrlqHJE71zbGLAF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721280632; c=relaxed/simple;
	bh=dJIPwqlL/N82JHszX417sGKv6W+koheLRSFLxgzWMYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=edgIsv7fAX/QL09RoFqqWWSAUtSVtxwlkiB9PNpGDw0kLi3eL75usvejlWJjXnkcjYH7tIHGZzrMphIF8JAyRmu0kCdv07fuy+p0fwRtdnx8tBw7I63QpgEoGwTjO/QNNWy4yFV3IXtyq23Eb4fCVHkIro8JY8nTOeUpYIJF+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1CXisFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71C4AC4AF12;
	Thu, 18 Jul 2024 05:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721280632;
	bh=dJIPwqlL/N82JHszX417sGKv6W+koheLRSFLxgzWMYY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E1CXisFbpnBi8gyQLCwlcxlQ5yb2JkNH57/Fv/bmWEAxcCq+0jmWa/pk4bbII5/wP
	 0YVLm7N3ShY6EGNj4wgHC23C6Tv87N6kfhfmZmIcAvuNdt/r6syENpiW6LDHdJdgjz
	 Fln6921ZXT1OEfQXXznhQtcPRAD4BhclinqirzzoHxAbd7zK6qJlKds/jJ8AuTalyU
	 72ujzbdppisQ8/UM9oUChtoohwqFUt48HnpijByJa/Yki8g1eKN/CP7Ii3BjLUTodx
	 qnL3nyYGLmZi0mCKJBsPmnUJTL30SrGDiomE7V3uixn4oX9cYRO4Ge5qCh+bUvoFaT
	 huk5d5uiIqcgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EF1EC43613;
	Thu, 18 Jul 2024 05:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: Fix XDP TX completion handling when counters
 overflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172128063231.29494.5815351155130581713.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jul 2024 05:30:32 +0000
References: <20240716171041.1561142-1-pkaligineedi@google.com>
In-Reply-To: <20240716171041.1561142-1-pkaligineedi@google.com>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, stable@kernel.org, hramamurthy@google.com,
 jfraker@google.com, jeroendb@google.com, shailend@google.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, ziweixiao@google.com, willemb@google.com,
 joshwash@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jul 2024 10:10:41 -0700 you wrote:
> From: Joshua Washington <joshwash@google.com>
> 
> In gve_clean_xdp_done, the driver processes the TX completions based on
> a 32-bit NIC counter and a 32-bit completion counter stored in the tx
> queue.
> 
> Fix the for loop so that the counter wraparound is handled correctly.
> 
> [...]

Here is the summary with links:
  - [net] gve: Fix XDP TX completion handling when counters overflow
    https://git.kernel.org/netdev/net/c/03b54bad26f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



