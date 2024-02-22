Return-Path: <netdev+bounces-73858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD9385EE91
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 02:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AF11F227D7
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 01:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F41211CBE;
	Thu, 22 Feb 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TASPkLKo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBFD10A05
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564829; cv=none; b=dfnIGBbNvjK7JHyGkfJ2mF4V6VBd19eGb67b5qFoz5VHBU0OfLneEc75NjwZZ+w6XNc/ZuR8y1Y5RBYhsSMN0MI9lMkmnKSrkteSmXK2ovwPuwPl5Ys42drXKsi0EsBXFTadY8ajaUmsK4qk/6Vwt8hM0FXv4rnfqhHwpcqseLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564829; c=relaxed/simple;
	bh=iKIummIVfums74c+mA3bsT5kTRUCzNaXHMRANDledTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q49HysubpRsSuVERnGac+r6CyPQYDraf/f4l0OWMiBR8SGJf4az26zC/vzAISzvHvzwaFhbkBLYm4ItnxwP+Im1q7YsXtXyd65CQd8pqrJYt52t/KUFzkVfPfc9DNNLo153i0Hm40PuSBH8ZpIGuvQXk2C8UqDsGgZZ/3HcZsUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TASPkLKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9603C433B2;
	Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708564828;
	bh=iKIummIVfums74c+mA3bsT5kTRUCzNaXHMRANDledTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TASPkLKoThJ/3MdgkqNkkN/2YZnkk+ATLN0/NO37T58pahDNsPKIIASoK6shuXMjP
	 OdFSuDqvLzxkRm050ssWLKr/Yi01v1iqZAUUzxjCEg4U4iKO/Ka+YZcoaqx4skvtKX
	 Susy2FmPw7LkR2TpTL6V4HqwamCNwLAwHv2MpMUbtuCQHOE4Rz+91TCu6Ga4j8NyLz
	 Urm43uKvdGRRdd5eedoIzItL9jcjpDKZbZw4eHD0ocL8V8YK0EeNHuHkvQgCCtf1T/
	 Bth8ehnOG7CJacgPoyhYk2XAfyXA7tv9syKGi7trlr41cXkeHoNeI3XHpemZWbQ0LL
	 Xdx1WUIBSZrgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8322D84BD4;
	Thu, 22 Feb 2024 01:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: flower: Add lock protection when remove filter
 handle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170856482868.21333.11594654293458701798.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 01:20:28 +0000
References: <20240220085928.9161-1-jianbol@nvidia.com>
In-Reply-To: <20240220085928.9161-1-jianbol@nvidia.com>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, cratiu@nvidia.com,
 gal@nvidia.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 paulb@nvidia.com, marcelo.leitner@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Feb 2024 08:59:28 +0000 you wrote:
> As IDR can't protect itself from the concurrent modification, place
> idr_remove() under the protection of tp->lock.
> 
> Fixes: 08a0063df3ae ("net/sched: flower: Move filter handle initialization earlier")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net] net/sched: flower: Add lock protection when remove filter handle
    https://git.kernel.org/netdev/net/c/1fde0ca3a0de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



