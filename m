Return-Path: <netdev+bounces-156666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A0AA07512
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDA516264D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09D12165FE;
	Thu,  9 Jan 2025 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCLwYL+L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE1B1FF1BF
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736423409; cv=none; b=uHowmsnRtGyUFepx3sHa7hKuMjpeXPVbfmwKyF/13TkDl3g5N0uDYcQZBKFXrA4HhKKN4MFZueletFc3NEDhQrE0KdpUIYW9UtmU1VkxBVxr+EpaswZkSf0Nr+qFVqurrHwbWQJ4+dL4z7+xCIkC6NxofdeNy8qJUyl0hsTtFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736423409; c=relaxed/simple;
	bh=9uJ7MGkb2v07jat0NPrWWChM01ojhEpKtmBEWz8i4YQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BJYbCSHPZCnqleXss0UlSv0yIeDVvN0YnSIwvjuboUF5DaTbywN265xmWWpZEfIUMhEXsLlUnw5PoMD4dJ8G8arhfr7kaTAy639f6mIregUoMl3alsudKcdCBrGhoI11Oo8SWn7XXtRZB5o4q3bUARGdGAqepVd68PdU1gNf+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCLwYL+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F326C4CED2;
	Thu,  9 Jan 2025 11:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736423409;
	bh=9uJ7MGkb2v07jat0NPrWWChM01ojhEpKtmBEWz8i4YQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KCLwYL+LPOmUYIVvbI+staWedg/crzcHQQhAfkLnPfjIdiyGGeJWRMqqRXu7kIxPI
	 Ayw+JKsBbEvutPFnJr/Zbuej0Lq7mbflxCtzd8P7Z62ByMDE3e6OjI92P9cNMjXvzl
	 2X/CNb92zrDpZJqMTbdkIfAa9axdsVwW4D+inrVIv+Cjw1bgOO3nZhFMWa1mq9tzdc
	 8cikRjdMGYv3KvDMx3H41nE9ct60MgQRnVihvvLyhHhWCt069mjWuCSvn8iQE1FYEV
	 H2KqmvLcRMm94PdBxL51uR9wnVIplpE4qZg7RF+TEdGkYNKLW4esYRLxSat6uPKXo4
	 3Fn7AHD/fFddw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D253805DB2;
	Thu,  9 Jan 2025 11:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/mlx5: use do_aux_work for PHC overflow checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173642343101.1295278.229713484353265105.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 11:50:31 +0000
References: <20250107104812.380225-1-vadfed@meta.com>
In-Reply-To: <20250107104812.380225-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, dtatulea@nvidia.com, tariqt@nvidia.com,
 gal@nvidia.com, kuba@kernel.org, cjubran@nvidia.com, bshapira@nvidia.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, pabeni@redhat.com,
 richardcochran@gmail.com, davem@davemloft.net, saeedm@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 7 Jan 2025 02:48:12 -0800 you wrote:
> The overflow_work is using system wq to do overflow checks and updates
> for PHC device timecounter, which might be overhelmed by other tasks.
> But there is dedicated kthread in PTP subsystem designed for such
> things. This patch changes the work queue to proper align with PTP
> subsystem and to avoid overloading system work queue.
> The adjfine() function acts the same way as overflow check worker,
> we can postpone ptp aux worker till the next overflow period after
> adjfine() was called.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/mlx5: use do_aux_work for PHC overflow checks
    https://git.kernel.org/netdev/net-next/c/e61e6c415ba9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



