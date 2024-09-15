Return-Path: <netdev+bounces-128417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724229797AE
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 18:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA2D281DE8
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C971C9EB8;
	Sun, 15 Sep 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdHJwMl2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB5E1C7B83;
	Sun, 15 Sep 2024 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726416087; cv=none; b=CFeMn9rqi0y0I3JrYkXEVVkSWbjh4dWOhXbB6UspXTxBWjFp8KyuiGI033TeRmEe+RH+bz7hhU7dU0oXGiBl53bOZFRlBwwQayKJwNkw7sN1WoDlEl7pmZhNxOnGuTlUHSiOqiR13rvPMOZaR27eEgWH0baGYI+hTSUcQd3EjOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726416087; c=relaxed/simple;
	bh=wg67dmBzddHpQPxvcLlIi8uEkqvPL4DE0pY2JU1FlyU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gOGwFuewtXAgfFknKRlexHCe9e97VgFA9JC1tzJCpPBhKpeZ4OS/kT+daBW9xOB7aIMY0YlcBS+teszmtzu3dF0ttqbgvVPiYjzUodnFaZyEXh9BH/mpnOjSGN3HFCCc4AG8w6gQbftd1EfLlC93+uS8tJuWyCr6cY/C8mqrXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdHJwMl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0594CC4CEC3;
	Sun, 15 Sep 2024 16:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726416086;
	bh=wg67dmBzddHpQPxvcLlIi8uEkqvPL4DE0pY2JU1FlyU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PdHJwMl2rlZwyweitrslhQR1bgmMMCd9GKy6swSfrdveoaiv0O01ttPvoIYF6F1m8
	 nmiq2PSzkDTZWk9izo/1mDPOl+AM5XgBM+X2oG6AawBljEDxXDdx9Iita8VkTEDTuX
	 HLAsPFNcFJn0faDrdT4Hss3tVGhfjtygN5o+fbeDlYsP1RHuuruIyCvq0MigdG/UQa
	 pPs4z6JE33iEf59zjbZd5ijIQqQ4Mbh6C6R/0oHTIQE6jMGvMuewlI8FVGYoS0Rh+B
	 30lGbvH8RS5pRSK4RTom9A9QsnngnGy95K9h9VL3a5QRetuwKFzjn7szzoTOr4C9yg
	 YP7LJZNEeiOng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB03804C85;
	Sun, 15 Sep 2024 16:01:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ice: Fix a couple NULL vs IS_ERR() bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172641608750.3111582.11116274512992021166.git-patchwork-notify@kernel.org>
Date: Sun, 15 Sep 2024 16:01:27 +0000
References: <7f7aeb91-8771-47b8-9275-9d9f64f947dd@stanley.mountain>
In-Reply-To: <7f7aeb91-8771-47b8-9275-9d9f64f947dd@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: michal.swiatkowski@linux.intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 wojciech.drewek@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Sep 2024 12:57:28 +0300 you wrote:
> The ice_repr_create() function returns error pointers.  It never returns
> NULL.  Fix the callers to check for IS_ERR().
> 
> Fixes: 977514fb0fa8 ("ice: create port representor for SF")
> Fixes: 415db8399d06 ("ice: make representor code generic")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] ice: Fix a couple NULL vs IS_ERR() bugs
    https://git.kernel.org/netdev/net-next/c/75834577c087

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



