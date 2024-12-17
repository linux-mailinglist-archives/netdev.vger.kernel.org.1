Return-Path: <netdev+bounces-152472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DE79F40C2
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68491639F0
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEC31465BD;
	Tue, 17 Dec 2024 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrMJyYbz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3F9145FE0;
	Tue, 17 Dec 2024 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402613; cv=none; b=XvYuEp9gLGPTKUwd2d2wDkbaOtEah6Rt6rUsu9JlabZt9NyCJe2yu3Jv8y0dbjP55jGlOnoCmxMxix7UfT8ZsvrzQVBB/O6rGuTnczm63dK3J8aKMGhLA3At/PGheqGPmESp9OY7P483mwMu0j3KAFZIWp/uDO0Gc6V/HwaavO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402613; c=relaxed/simple;
	bh=YFVs1GSeMboi50d9wwhk1qZytEoVY03tfo4cZz3xYv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mx3VkTIlj33aZixRShue4J6RcY+0ITkhyxgNbMXjJufEWf8Y5B2xgHOgVypWdAb4gne4pPOux/NhCDF/gtMhMlUiiwI1/DYL1as39VMT4WrJ8vBFT/vehU3Uh9D/Hte/3yucVXwvhULrFqcztspUv8m+Pxlx7Jd4rFPGwFmmt/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrMJyYbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9283C4CED7;
	Tue, 17 Dec 2024 02:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734402612;
	bh=YFVs1GSeMboi50d9wwhk1qZytEoVY03tfo4cZz3xYv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PrMJyYbz5ueWHY9srQaOXCnR1jWeOMjv7t3sw8QqyEP8hwba8XUqyha1Z39HqTu1s
	 bCAFjfZX4Omr9aydAEMnw2ewGz6mxq+3ZNc4shp+r9Symrej3PaztVodXypf7ZjQzc
	 Wae2sQrhC/m1jPRyTMKkeJhNtlOJCPgWC3XwScA3DcJuscxpkoOufJO3tGCt6IQ4Ri
	 g1e7vBLpOYmpnBwHEszF5jqmbFej8jVZ4EK2S5wBL+i+XjqNVNNZOZVutxTq2tEETp
	 NhkvmvkFEmttJlr9+bmuxvzsGPaMSba6R9ZuXPocX6cH4hzyKNF3KMqsZU9RVrrW6Z
	 SD8whiwO8EJRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343EF3806656;
	Tue, 17 Dec 2024 02:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hinic: Fix cleanup in create_rxqs/txqs()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173440263001.420431.12522081889821148366.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 02:30:30 +0000
References: <0cc98faf-a0ed-4565-a55b-0fa2734bc205@stanley.mountain>
In-Reply-To: <0cc98faf-a0ed-4565-a55b-0fa2734bc205@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: aviad.krawczyk@huawei.com, cai.huoqing@linux.dev, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zhaochen6@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Dec 2024 17:28:11 +0300 you wrote:
> There is a check for NULL at the start of create_txqs() and
> create_rxqs() which tess if "nic_dev->txqs" is non-NULL.  The
> intention is that if the device is already open and the queues
> are already created then we don't create them a second time.
> 
> However, the bug is that if we have an error in the create_txqs()
> then the pointer doesn't get set back to NULL.  The NULL check
> at the start of the function will say that it's already open when
> it's not and the device can't be used.
> 
> [...]

Here is the summary with links:
  - [net] net: hinic: Fix cleanup in create_rxqs/txqs()
    https://git.kernel.org/netdev/net/c/7203d10e93b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



