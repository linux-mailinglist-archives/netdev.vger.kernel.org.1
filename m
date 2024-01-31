Return-Path: <netdev+bounces-67704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 194D6844A37
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 22:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553C91C22FF3
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 21:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E366F39AD5;
	Wed, 31 Jan 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLdP+kvm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFEF39AC8
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737227; cv=none; b=abFvXRF5aPHKPdM67tQJjCoXA+uuliS/l1A1EIFFGtAjUGiwdbwDE2RnJ9czPxs4fiGot91mAWJStUlX/YAcodYkIxhQeMW6J3hPa4v+pIJREZ2FLW6G47s4aq8Djv/uQVhY86JlVAhQCtqiB5s7HQdf0dT66xePf1RVdRwTcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737227; c=relaxed/simple;
	bh=QXMJvjCVlD6jGXh/gw71j8VC5cCZP2oIuoCSL1nZDM8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eqs+WkvpgpvnKMF5MbhyUWXfNhR4blwK34jkeuIdL+l2htrZEMxF2tGgtNpxHOTrdsqXDnhanpXQ9pN9Fj+HoybvBdO8t3YcXhZl1D0/r1waZzAravcowkBHAgKiliyKM5IQNSTFjZbB8fg6nKQcGbUyWsEmojr87H8CtEbAK5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLdP+kvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E55CC43390;
	Wed, 31 Jan 2024 21:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706737227;
	bh=QXMJvjCVlD6jGXh/gw71j8VC5cCZP2oIuoCSL1nZDM8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cLdP+kvmvR4YVM+hQIG7UFLsu6phrtCcmiLy4/pPS7PYij5m9/smQ/o4OhoEIUhZB
	 WzvvdwtbT8RCOTPLKX2JKy6wQy9+v4CjnMz+xxq2I2+D7Pg8hlLIeYV5SsPz5TiKeb
	 xbmgyjfNsgXoyLdpLWTLdC6fPgOTLSHBxBT63I4kQCdn4hdfJgXU7R4RCdA7/ow0bA
	 Ru/42v3qF3uHhFNyd+yfDACITRu+YdF9fSJF8qD3eg9hXaltCbmGgDM8zYjUJaM6BT
	 JgMDrka4Lmi3gNPrSpkQRM376nLs98auMRqhnVa68/X66n6G8r0tPVYJMIcNpRBUTX
	 FhYI2V4TCW0Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2461DDC99E5;
	Wed, 31 Jan 2024 21:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next] dpll: move xa_erase() call in to match
 dpll_pin_alloc() error path order
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170673722714.16853.12615402702946684558.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 21:40:27 +0000
References: <20240130155814.268622-1-jiri@resnulli.us>
In-Reply-To: <20240130155814.268622-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jan 2024 16:58:14 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This is cosmetics. Move the call of xa_erase() in dpll_pin_put()
> so the order of cleanup calls matches the error path of
> dpll_pin_alloc().
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] dpll: move xa_erase() call in to match dpll_pin_alloc() error path order
    https://git.kernel.org/netdev/net-next/c/e7f8df0e81bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



