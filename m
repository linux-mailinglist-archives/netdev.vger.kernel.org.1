Return-Path: <netdev+bounces-194174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 089D9AC7ABD
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 11:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C744D16B847
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727CE21C185;
	Thu, 29 May 2025 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf7gjIzl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968C21B9C0;
	Thu, 29 May 2025 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748509803; cv=none; b=N0JWxAmj7zcMu4MJXXF3A6nTxOJwKF8zKL9OQ75weqpAokDr0cQ3ZZ/UJuObe8fGzt7TVyYzih+drAMirH8Gv+MqUQaWl5dq8kwu6Btnz9+D1IoXCu4/fqsGzzKcYRJOtDb/nOfmJuH2SA7jYmcS+TpQped8zK9fP5UerAlViHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748509803; c=relaxed/simple;
	bh=DTj6uWiPsn8GtCJkZjxO8YPinv+prlpP7PTUsZf9rbg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PA7QKTyKkY7kwurih93xjqQiVKz9XZdiHUfLQqBEEb+nACqg3gxUwR2OCOR8uHnwGU54m9Vl2b7OZaepS5WtfacZxfcMEhTm0unDzpaK7x3KIxTebYOcAg+SPPkvqZh3swZVkgSBxAJoGGlNCAjHBJC7rhknjTdDbL1HLbJwBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yf7gjIzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1911C4CEE7;
	Thu, 29 May 2025 09:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748509802;
	bh=DTj6uWiPsn8GtCJkZjxO8YPinv+prlpP7PTUsZf9rbg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yf7gjIzlqyNjrc/oFfLHUsTnwe40lSNwMUUaHSHcSOiM+t+utyt1Mvl9N0dCLKNDF
	 2od5uWF5gZ92guCC1otYR30eLmAchIaV3pLCqs5N8UgdOpfee2g9+evRey06zlhHQG
	 pc3bhHN0oSjzx1SF6UPW4cbjcmOp1V3B/y5A3O+kFoqDuas3QE31rEbYGro/ryQLZs
	 nr/zAzRjeYfQWn38wriv/+QiJcVAnW+EZSxgbeG7lyZbrIXrSy5XR/AkKkKQ44ZgOc
	 yKGyygVt9ion3rFP5jg7DUBRE4u5rqMVsyLU8d9xqVYE+EddUkciXRxZFOQKJGE1ig
	 NqUd7CWxkQjYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC3139F1DEE;
	Thu, 29 May 2025 09:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] gve: Fix RX_BUFFERS_POSTED stat to report per-queue fill_cnt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174850983650.3198213.13925537483150249724.git-patchwork-notify@kernel.org>
Date: Thu, 29 May 2025 09:10:36 +0000
References: <20250527130830.1812903-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250527130830.1812903-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: ziweixiao@google.com, joshwash@google.com, willemb@google.com,
 pkaligineedi@google.com, pabeni@redhat.com, kuba@kernel.org,
 jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, darren.kenny@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 May 2025 06:08:16 -0700 you wrote:
> Previously, the RX_BUFFERS_POSTED stat incorrectly reported the
> fill_cnt from RX queue 0 for all queues, resulting in inaccurate
> per-queue statistics.
> Fix this by correctly indexing priv->rx[idx].fill_cnt for each RX queue.
> 
> Fixes: 24aeb56f2d38 ("gve: Add Gvnic stats AQ command and ethtool show/set-priv-flags.")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> 
> [...]

Here is the summary with links:
  - gve: Fix RX_BUFFERS_POSTED stat to report per-queue fill_cnt
    https://git.kernel.org/netdev/net/c/f41a94aade12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



