Return-Path: <netdev+bounces-160523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E088DA1A0D7
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E33F16D4DC
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74E920CCE4;
	Thu, 23 Jan 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGEVshvf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2D20C03B;
	Thu, 23 Jan 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737624609; cv=none; b=LYTRwlLM5Jo1hEI1hQSf/nULCNpv4WOkcAGvoRWW8adasoga58+fvmwd5ZWJqAomDaYj4xL94tlNv4m7rwVYK42mTrQLToAmwDQm61ndj5GZUgTQUmS+5Y8aIn4d3BJNDnPNaeDtq1e7otR5UjAcWuwyRFgC8etOJTEtVVW/Pww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737624609; c=relaxed/simple;
	bh=jZN9jLDJvmyVut4U17jzLZHkmU1soT4xWLsz8Po2LLM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sC2SSgP+PK9A2fx7/XIlmOrVaP8Whh64ZvXp2S19S/iHD4MCaRPvMqtMgmWj+gZI9ZdZE+fmnvgaQJ8lq1A6MtW4CuDFvEjhMQkCLI/wVy7N92xn6flkdbWXlRyg69i133SWoXnX5fNO9xQcF1NBKUlYf5LA1FSzFktw97pdis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGEVshvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7683C4CED3;
	Thu, 23 Jan 2025 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737624608;
	bh=jZN9jLDJvmyVut4U17jzLZHkmU1soT4xWLsz8Po2LLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iGEVshvfanj0r6qBrF7wC21dHMJl4qPSXbcKp5LPC3y7x2X1TcSvdply27XffJwIr
	 mRa+KI7DXkgrw8IhKPtBekgk3UtOag/h9lTeiglFYTn6NacDlIujk16NuH266n/wZh
	 khO3zAIiVqGaq1uIRi6+ZAPZl9sO7bQpfg389eW0JwCKitrBx4wpTjN+n+38cubnP0
	 onZJ5d1+6tendPpn/g/ChbXKWew0IH55r/VNpbH+F2UuG5d6xxfVrrWY2ZPW89UAvQ
	 Ndgoc7cz8jY8uzYzCZgBGItYnADvyyNWKJQFMdZS7Z2Ws5nlJ9I5DTgYp86eNj2/22
	 roWe927dYmTSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFAC380AA78;
	Thu, 23 Jan 2025 09:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net] net: fec: implement TSO descriptor cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173762463352.1296391.18044327523641569587.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jan 2025 09:30:33 +0000
References: <20250120085430.99318-1-dheeraj.linuxdev@gmail.com>
In-Reply-To: <20250120085430.99318-1-dheeraj.linuxdev@gmail.com>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 20 Jan 2025 14:24:30 +0530 you wrote:
> Implement cleanup of descriptors in the TSO error path of
> fec_enet_txq_submit_tso(). The cleanup
> 
> - Unmaps DMA buffers for data descriptors skipping TSO header
> - Clears all buffer descriptors
> - Handles extended descriptors by clearing cbd_esc when enabled
> 
> [...]

Here is the summary with links:
  - [v4,net] net: fec: implement TSO descriptor cleanup
    https://git.kernel.org/netdev/net/c/61dc1fd9205b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



