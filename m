Return-Path: <netdev+bounces-199547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7399AE0AB7
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA0E4A1124
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B38C2853E6;
	Thu, 19 Jun 2025 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsGs4rCK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50F27FB0D
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347591; cv=none; b=b8aj1+aodjql7qL9v1vaeIjR1eNfQ6XLJi5Tv+h5zgg/cADfJ8ZRIS7c9xqCGZwLgdIwOQZIgwmVhDjrElY7vvhbRvp3L7wojDZc0OCjvj5Muqkw8S+OKGpyO/PMboqmEQJSlHVrX3IH3y9i+DPOexyPdbM91rCrZ1oSc3DeB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347591; c=relaxed/simple;
	bh=vfLCja3u6DOWHQZ9OKUix2J43PYwaua6Zoew+E6djBo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uuszwOyAET750Ak18b3EoX4/UUtNG/c3f1mz5QQ/uu4h7bH8X/VlYTnZ1VphZC2W0gqVyk9QYUjPcP6XivoPuyT+u3n7s7Oe6Bvea1L3MTVPa10mMGlYKUcM8xxpx2ARFzC933YAxsTcmarE15rC4Du2uCtkmHGGS+9sabo/KbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsGs4rCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D41C4CEEF;
	Thu, 19 Jun 2025 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750347590;
	bh=vfLCja3u6DOWHQZ9OKUix2J43PYwaua6Zoew+E6djBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gsGs4rCKlhnTXzHeycGvhaHQRQXIcRLc5eNZ6JKJvSQc6ywJ+q4MUTLIRtPF5Z9Wu
	 Wp3QN9sil2DKyz8evaQhCDTjjAVByxWKuZ8NKeqpSYFvcU/da6MIbQ5BAQkL9Z1xlS
	 B0OF/gyY10fvozVjisn/hNg6kgMtSw3AisD4Yor9WMLglGULqyheaYC9fkbaqc9Myq
	 fVspW4xsKvpkSXb5wcy4T+lXVv0g/5tneJHAL4bnCd6PdKXLpHVJzGgFOGlo3G+7HI
	 8DrlsK0DLdg2jK5Ap5N6OpTcr2QbAwmGTkc80aIVz9tsXKEPe+ZFkhB9JrexW8uJx/
	 emQ3awGuMOV2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B5A38111DD;
	Thu, 19 Jun 2025 15:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: atm: protect dev_lec[] with a mutex
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175034761899.906129.12488340697198687590.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 15:40:18 +0000
References: <20250618140844.1686882-1-edumazet@google.com>
In-Reply-To: <20250618140844.1686882-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 14:08:42 +0000 you wrote:
> Based on an initial syzbot report.
> 
> First patch is adding lec_mutex to address the report.
> 
> Second patch protects /proc/net/atm/lec operations.
> 
> We probably should delete this driver, it seems quite broken.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: atm: add lec_mutex
    https://git.kernel.org/netdev/net/c/d13a3824bfd2
  - [net,2/2] net: atm: fix /proc/net/atm/lec handling
    https://git.kernel.org/netdev/net/c/d03b79f459c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



