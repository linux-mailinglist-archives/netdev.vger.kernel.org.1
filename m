Return-Path: <netdev+bounces-114872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7541294485A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0691F21A04
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB4183CD8;
	Thu,  1 Aug 2024 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B96nh9xm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF2183CD2;
	Thu,  1 Aug 2024 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504637; cv=none; b=aH4lbKCsWHDwc56wecrcRO+4z3DEJwo9XFj+zkvAHaKOc7WH7e8tO/7SWX3keabp+5i0Bze3LV54f3VqwuFBfWJf1LgGxOGKc8lDkUR18+IVn6xu/U5oRWNIwvo8cX4MvdMttatMrBccwd2W57rD33htKxWeXr01waxlAFecWy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504637; c=relaxed/simple;
	bh=t4BlZTp9icLPRavCGvy75nldy+Rj2++WE0ADEzle0nY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dvux/JXdrQjcBxjJvzjjqsu0Je57DDJusoNdLRasUkiLL/cSj4NBKxnrh8fSwhv4d/EDdAh0kfyW4G5a6FOc0GOZcY9T01VtELorA+q5JX1Rus3l+i8UirEPRfpQBm5l0YIBcXKSmzeEWD5zUCYIuYKj6eYPQWPREEjpiOZQ0YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B96nh9xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23E65C4AF10;
	Thu,  1 Aug 2024 09:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722504637;
	bh=t4BlZTp9icLPRavCGvy75nldy+Rj2++WE0ADEzle0nY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B96nh9xmbqCwx8Y6G4+hIrAUyQqRo3adUGvZP+ZU7WzUlyBn5tLEWpzjt3htiWbW1
	 8zHRQjzpcQN36MGOTL7me70/LlBEta/3C0zrFalxLuxPG7biBJatMEnrFjQ0NsSvvp
	 KvkbU+vfXxxFHwodKlnkscSrs1yU4O0uGsKDkW/ADXxirPnBMb8sOA3GLeut/gD4/b
	 Y8byrgBKq1wHCftIQ8qp9SjexuZJAh8IZsYl+NLU2lMOP9L2l3TEFg1G2SIfEl1ZJm
	 +cdS/v4/lVk0kS5Wj6iijByRP9wOLl0K8YT2mZx9pGZnUdtSJciyRQZAu4f6lSdwE4
	 +dxkt2tCykeRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11A6AC43445;
	Thu,  1 Aug 2024 09:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: skbuff: Skip early return in skb_unref when
 debugging
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172250463706.8059.2016437225391729013.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 09:30:37 +0000
References: <20240729104741.370327-1-leitao@debian.org>
In-Reply-To: <20240729104741.370327-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, leit@meta.com, clm@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 29 Jul 2024 03:47:40 -0700 you wrote:
> This patch modifies the skb_unref function to skip the early return
> optimization when CONFIG_DEBUG_NET is enabled. The change ensures that
> the reference count decrement always occurs in debug builds, allowing
> for more thorough checking of SKB reference counting.
> 
> Previously, when the SKB's reference count was 1 and CONFIG_DEBUG_NET
> was not set, the function would return early after a memory barrier
> (smp_rmb()) without decrementing the reference count. This optimization
> assumes it's safe to proceed with freeing the SKB without the overhead
> of an atomic decrement from 1 to 0.
> 
> [...]

Here is the summary with links:
  - [net-next] net: skbuff: Skip early return in skb_unref when debugging
    https://git.kernel.org/netdev/net-next/c/c9c0ee5f20c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



