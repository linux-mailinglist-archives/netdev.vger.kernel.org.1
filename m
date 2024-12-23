Return-Path: <netdev+bounces-154099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1749FB417
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC1318857BC
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61F41C5F31;
	Mon, 23 Dec 2024 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQzRl/XK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC91C5F25
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979232; cv=none; b=Y5dlyRV05k7SwUF9LXfo1hXNnM1ZDVw8+zQ9778VRzEqe6JeJTbU2D0tOtuR/kQpTtX4818rduiX52a9FWz0UEwPZRE98FALyNGr2muWCT/8zu0mioTO5S3OIKC7QVQ5rlc1V0hUizEdRL9LYkdAbltvoogq5zwlaHwoy7oXwGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979232; c=relaxed/simple;
	bh=w2CBG10p9Axfz9TmweiIUr6NUP2vF7/Rxc1GoNZwF8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IIwhJzuDgs95plCohknwxrR3CCctpDIdlGKvBPSDEu4jMHsrLyE9DMwBwD35/5tyZVWQK6litJvDzs32t8OKQbDDeSKWkoiGADNItRYNcGqX8IosZMRHMz+3Mx4oMVzgn4ofBxDnPWBzZG2/UaW7Fp1BwBHbM96v7oa6xdW/94Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQzRl/XK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892E5C4CED3;
	Mon, 23 Dec 2024 18:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734979232;
	bh=w2CBG10p9Axfz9TmweiIUr6NUP2vF7/Rxc1GoNZwF8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SQzRl/XKm34EGJPy1dC2SutuYSIyPXLlZ05ez/IXAccD1uIx2aZoyuJ90y1fdvBX1
	 djKUslCfj8cuHTBKPcXyhIBob4nWRisAkrPmb3tPj+O6KLfowaLtJdJtsMuNtqyEA5
	 cRsguyK94imBjwsAz4QCdE+zmErD+rnrcT2GiaI5yfRxxskNlikWlmEbwkaxp6IICx
	 /Cwtwc3nmHFoxxOQXyJH19M92RwjQFixrm2utgZg+e7u92Ca+xzuozd+BIKepOrIC4
	 mueM7PdfeWFhPCI2iHDDCxif32ltkgd4jdR/EZus1Pf40QslpEtAmUkNBk5hID3Apl
	 V0Uvo9l8fwYAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 345B93805DB2;
	Mon, 23 Dec 2024 18:40:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] sfc: Use netdev refcount tracking in struct
 efx_async_filter_insertion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497925075.3927205.1078565374481365464.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:40:50 +0000
References: <20241219173004.2615655-1-zhuyifei@google.com>
In-Reply-To: <20241219173004.2615655-1-zhuyifei@google.com>
To: YiFei Zhu <zhuyifei@google.com>
Cc: ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-net-drivers@amd.com,
 willemb@google.com, almasrymina@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 17:30:04 +0000 you wrote:
> I was debugging some netdev refcount issues in OpenOnload, and one
> of the places I was looking at was in the sfc driver. Only
> struct efx_async_filter_insertion was not using netdev refcount tracker,
> so add it here. GFP_ATOMIC because this code path is called by
> ndo_rx_flow_steer which holds RCU.
> 
> This patch should be a no-op if !CONFIG_NET_DEV_REFCNT_TRACKER
> 
> [...]

Here is the summary with links:
  - [v3,net-next] sfc: Use netdev refcount tracking in struct efx_async_filter_insertion
    https://git.kernel.org/netdev/net-next/c/85101bda1387

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



