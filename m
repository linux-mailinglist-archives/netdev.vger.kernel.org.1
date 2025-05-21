Return-Path: <netdev+bounces-192473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9A7AC0042
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D7E7A43FF
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 22:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9AF23D2B9;
	Wed, 21 May 2025 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6G6AXNB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C012523AE9A;
	Wed, 21 May 2025 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868408; cv=none; b=m3rcmYhmawZVys+vinpBnYKHq6HoFeC2BVOin7v36aMNZWn4ISEwal7D4qVMHiD33/zeWjksZfsz8GBUOmwrhKcc1x1eypWIyuDGTWvnftBo0VeeVGlSE63wojVYNI4z6kWuvFhP9uzD3apMj/L/jpzhBZnoWdXVtTtWA2kd7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868408; c=relaxed/simple;
	bh=0nOK1oRAv/ggcXskG50RWjy1eIjn7oET8fPUwVBz0+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DuAWHCsnqMTQDqIQVRRKxi5BxQK5unnXm4ryJBSVANR6w62c0W/x1pkLe5D2s3zSYhJQDPNdl1OVs5CHWebVNFmLPv1UMnIhuXumV7eRYZE/H2sSGKWiuXDddd+v0spgIXDmzw6ZRj7QITVpSU6aPXGWem04/nQjpe8PGqQdUUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6G6AXNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E44DC4CEE4;
	Wed, 21 May 2025 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747868408;
	bh=0nOK1oRAv/ggcXskG50RWjy1eIjn7oET8fPUwVBz0+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6G6AXNBiSObHkFiwh+ANl/zLjycsJ3c3SXKUPMRBxHQ3jDfkwXbVstCEcpXNjJA9
	 wrLVbFRAu1acaBoadv18JLuSN8xuWVr97A4gpYu03tFdCJUyOcEypw7yhSWIWaGcKg
	 uKXBwujHVD7G+tIOPpnOEt4nLK3Nqe6amt5AEGAjr54/igbJg9qzZ3609+LmcXRB7T
	 NihwSLxsZrKX5BX+Wn/7tpcw6F1anCs0N13lcHxoJyvykWEEs0OFk60GbkqnBwGrTg
	 gpuaVCikF2duoC6yZaiVbwPOMi4BTLzDuNFYXdHQi5mTeL4Pay6VGBnZxilXFwsWLT
	 6LXcHi67XddpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB779380CEEF;
	Wed, 21 May 2025 23:00:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] rtase: Use min() instead of min_t()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174786844349.2308458.114972773958195630.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 23:00:43 +0000
References: <20250520042031.9297-1-justinlai0215@realtek.com>
In-Reply-To: <20250520042031.9297-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, pkshih@realtek.com,
 larry.chiu@realtek.com, jdamato@fastly.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 May 2025 12:20:31 +0800 you wrote:
> Use min() instead of min_t() to avoid the possibility of casting to the
> wrong type.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> ---
> v1 -> v2:
> - Remove the Fixes tag.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] rtase: Use min() instead of min_t()
    https://git.kernel.org/netdev/net-next/c/f44092606a3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



