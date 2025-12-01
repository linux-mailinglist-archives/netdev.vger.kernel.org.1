Return-Path: <netdev+bounces-243092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DABC99723
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 23:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76993A5230
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 22:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877E5296BD0;
	Mon,  1 Dec 2025 22:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPBowHuO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F5296BC0
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 22:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629601; cv=none; b=QAH0RYgfQBSrDZya3t4jDlDkmUrGa8+MZczW+RmfD4MDtecmw+RhYL+uzUoOIJnbpKJhRtdgqzzADHNS3NOtrdWdiVKjRuSOMvPk514dBDQCGWHCyZgv6KFhgrTZ76TOEWT0Ro/STQPXIkGdtZpsUE0jGO5oVtwrRyV4SfiemaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629601; c=relaxed/simple;
	bh=uSaXdCzOw4C89HyjFWixVaz6S91mwzzmY8yJRuYo5oM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BBvK7S9gBPa1jjpcNkTrTGrhIPdtT6zp8VP9wo1j7OtcyoPj3Zc7nBopv/H10g+rpFnlOHbdWcEKMvQArqKGHFJUn/h24gbhu0namIu13QbA9KYcoS855l+uM3MB57BGB6q2yBbCbYVGAglHZ/wEA7cATmCpqD0srE3daj7Dmsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPBowHuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D370BC4CEF1;
	Mon,  1 Dec 2025 22:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629600;
	bh=uSaXdCzOw4C89HyjFWixVaz6S91mwzzmY8yJRuYo5oM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vPBowHuOJkPj4oY6eAB+IrYPy8sC8Mny8nK/pQwUTU3peRpnIE1l3TqiD8ifX8jnS
	 VW74utYkVNzC4gk1VXic4iB75qJyzSwADpRNl91oVIUx06YlB9Bzu3mUm8sRm6UGHg
	 bXLXAXtbS6qG6NAbd08Ia0URa6WBJr/1T59Wh0MKc7tYMWYuEpMS0w4jsMOvBy2vjm
	 bgHjlmGAwvHP1mw55OC95QbwyP8rxzY4lCdUe/8kWaGuGBlrclf6AaYhTpdHjs/yVM
	 y4zQ/XuUHaIViHob2Z1Ka2KyJkY5cLkpjfOxABPs1ML49OCjjvM+gl31+2NbY4+Pgx
	 ZcaN7jNTxTQxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F27FF381196A;
	Mon,  1 Dec 2025 22:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] amd-xgbe: schedule NAPI on RBU event
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176462942052.2581992.4351008241083058392.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 22:50:20 +0000
References: <20251129175016.3034185-1-Raju.Rangoju@amd.com>
In-Reply-To: <20251129175016.3034185-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 Shyam-sundar.S-k@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 29 Nov 2025 23:20:14 +0530 you wrote:
> During the RX overload the Rx buffers may not be refilled, trying to
> schedule the NAPI when an Rx Buffer Unavailable is signaled may help in
> improving the such situation, in case we missed an IRQ.
> 
> Raju Rangoju (2):
>   amd-xgbe: refactor the dma IRQ handling code path
>   amd-xgbe: schedule NAPI on Rx Buffer Unavailable (RBU)
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] amd-xgbe: refactor the dma IRQ handling code path
    https://git.kernel.org/netdev/net-next/c/c3b744fd2019
  - [net-next,v2,2/2] amd-xgbe: schedule NAPI on Rx Buffer Unavailable (RBU)
    https://git.kernel.org/netdev/net-next/c/ab96af7004c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



