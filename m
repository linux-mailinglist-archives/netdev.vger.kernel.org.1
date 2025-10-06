Return-Path: <netdev+bounces-228007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA69BBEF8B
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 20:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A19234F2E19
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 18:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192302DF129;
	Mon,  6 Oct 2025 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhpOJQ6C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F832DF126;
	Mon,  6 Oct 2025 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775427; cv=none; b=Acj0Y1nfPgpmL8Ox4fGOIfmfCo9CmzBdZ7fWZCtbH8V3F4RJTpXR0AyxUM5s/uFqOsl2hkj6k32SqXFTPISH1CHo6abk0Us33Kp/wSancFXOuVhlTbBe/rTN/TP8BBiix5da1WzWhsYc6EQnuTIzjZEjNBpA9z0H9EpuTcjIhrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775427; c=relaxed/simple;
	bh=mZ0XaT79G0QkL+0/drk+BoeqH74wESaS8ejqJLg1Ya4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NWHoY5UA1RohnSInvfFQwRiM/qpFrgBzXVwywEdMl5Q+1rJuszRW5WUdIyxGdoFf/s45WK23iDz+QX+oIA26x7SfSrF48a9DG8fJxweu1bVYLco3Jg8zWcTurH0wiVjsGPbrRGaI6QaUTD+xvwdTSGvYR29pQXQJ+rnH52Ytdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhpOJQ6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52EEC4CEF7;
	Mon,  6 Oct 2025 18:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759775426;
	bh=mZ0XaT79G0QkL+0/drk+BoeqH74wESaS8ejqJLg1Ya4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JhpOJQ6CUnP9DejYRQRLmcyz4jXvH90xuPqFtLBdF95IzvKmMM+Felqn2F6U6zsLa
	 8mzjjFzY8VJqZv+MY25FjkE4r9uw2jt12sfJDlmLLUNR50Fha8JYd/22WwIS1ETI4q
	 kE0SEs5PQnCm+CYwDtxdrorlCYQIq3Xj91wiQxCvMt0JKI/G5lVDMoYXzenYGbEQds
	 vfM937kEH0w1HipCKnxuwMNbPLsx5DUUFl85wju4jLWl8xYl4RnUmbXftHlBhu29+2
	 C7rTp3rJxslVn+s/wvRR8hyHNluMCk7rfiN4FBLsg+YNvau02KdPiEMwmu21PYedLj
	 DrHm42kYWUjmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE09D39D0C1A;
	Mon,  6 Oct 2025 18:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: mscc: ocelot: Fix use-after-free caused by
 cyclic
 delayed work
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175977541624.1511446.1704376269622300510.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 18:30:16 +0000
References: <20251001011149.55073-1-duoming@zju.edu.cn>
In-Reply-To: <20251001011149.55073-1-duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, UNGLinuxDriver@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Oct 2025 09:11:49 +0800 you wrote:
> The origin code calls cancel_delayed_work() in ocelot_stats_deinit()
> to cancel the cyclic delayed work item ocelot->stats_work. However,
> cancel_delayed_work() may fail to cancel the work item if it is already
> executing. While destroy_workqueue() does wait for all pending work items
> in the work queue to complete before destroying the work queue, it cannot
> prevent the delayed work item from being rescheduled within the
> ocelot_check_stats_work() function. This limitation exists because the
> delayed work item is only enqueued into the work queue after its timer
> expires. Before the timer expiration, destroy_workqueue() has no visibility
> of this pending work item. Once the work queue appears empty,
> destroy_workqueue() proceeds with destruction. When the timer eventually
> expires, the delayed work item gets queued again, leading to the following
> warning:
> 
> [...]

Here is the summary with links:
  - [v2,net] net: mscc: ocelot: Fix use-after-free caused by cyclic delayed work
    https://git.kernel.org/netdev/net/c/bc9ea7870796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



