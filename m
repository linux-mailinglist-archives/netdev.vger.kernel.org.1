Return-Path: <netdev+bounces-201708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C139EAEABAF
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C281C251A7
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 00:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7AB2A1B2;
	Fri, 27 Jun 2025 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPHakjTE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C00C224FA
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750983591; cv=none; b=MbHACWtNl3UPgN+ZIQI6PpjnHCVrtNbDcOqye9gpJYCQzh96dEDSf1N8z0svZtda9t/qL1exFvSVSjoIfYOWXW8MV2uVzbl18TWPX1DXvw2t8xs2ND12P8E9l/HoDg/Dp5fwOUytfgIpygSP/5MHzlVTj3LVAaB8ChJHAP5ioMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750983591; c=relaxed/simple;
	bh=A/GPq/k9Nay0IeBg/c26bLVz5zmhn+66UN35AjQ18KY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qyb8TLrB9BX/6WZ5+UGwEvtiEqMkgvsnbySgFxsZb4lqswPqJsg+U9QJ99datlI86YM7xSj28kqF6VXemI/JTYF2YR1B7wYoY6jRr8nzgoSzPtrfdc5G6JgcMysM++mpv6A+sConqsTswnbT++CsAJp3hoEMUBiFeunia6pOdiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPHakjTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE18CC4CEEB;
	Fri, 27 Jun 2025 00:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750983590;
	bh=A/GPq/k9Nay0IeBg/c26bLVz5zmhn+66UN35AjQ18KY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GPHakjTEzBgJZYFQzPu07aArQupswCEtrO40OOgknyCfhs7wzAbukHHOCtiIik1ra
	 anDHFJgX1j30s2e/PgCiC8BGB2i2C6gqwaeLyb7eDz3qb0ZnI+1i2VpG8BHruj2pvU
	 MIC+VrIUbmaqtochAcwS5svxt6d8nsOnn2wPflOpzvGQsOp35J+zZKWEV/GRsex5ma
	 lyJH0WM1TO837tJfisqPPN/HByu+mSvvs84Z5ef4b5nHB8sAbpRORG+VlF7UHiMcZt
	 rJ9EsWc1G/sbPPM5W0biLBCkucVokm/BFg6kbknpJ0xVr4QZeNFSSngYMRmela7uvl
	 0Unc7pcUINj/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE13A40FCB;
	Fri, 27 Jun 2025 00:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Get rid of dma_sync_single_for_device()
 in airoha_qdma_fill_rx_queue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175098361699.1380299.1821906889134866551.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 00:20:16 +0000
References: <20250625-airoha-sync-for-device-v1-1-923741deaabf@kernel.org>
In-Reply-To: <20250625-airoha-sync-for-device-v1-1-923741deaabf@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Jun 2025 16:43:15 +0200 you wrote:
> Since the page_pool for airoha_eth driver is created with
> PP_FLAG_DMA_SYNC_DEV flag, we do not need to sync_for_device each page
> received from the pool since it is already done by the page_pool codebase.
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Get rid of dma_sync_single_for_device() in airoha_qdma_fill_rx_queue()
    https://git.kernel.org/netdev/net-next/c/4cd9d227ab83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



