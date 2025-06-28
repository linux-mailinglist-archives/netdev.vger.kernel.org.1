Return-Path: <netdev+bounces-202095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67706AEC369
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 02:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D62E442F7D
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BC0192D68;
	Sat, 28 Jun 2025 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMr51dMz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB8B12B94;
	Sat, 28 Jun 2025 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751069391; cv=none; b=lbIIUVGK5iTHEC1BvGe8EmclO484918ME6+oHL723JLcOjev9/9njpdTDjQsuA+YkccJsHdj4cGRj7gx9hvO3BAlnlchQfKCb1UXkPtL3To1ckX3a4BZufvW76KGNCiujG0rfgHqEpAyHQkvapO2cREtvl7hT03c1WbE3sNrASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751069391; c=relaxed/simple;
	bh=Raq8WG+fKhjAsuiPjCUHGJ2TewWyNK5S4XFvncAZ0Nc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n4XZCmIYQFYbvPqiUX6IKOPmI+rCDGowmSKugOWEGQf7whjeJLBoiaw4se/5P+Amd63n2gFV5wsJz+3wOb93PMI6Qkj/Zc+2MkyAbTNPZrpW11b4KppVMUQYVwig2AUl7ig41L7wwZJVMCdhUIhpeHZs6wR0Y5Yh0xZNj10B2wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMr51dMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF02C4CEE3;
	Sat, 28 Jun 2025 00:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751069390;
	bh=Raq8WG+fKhjAsuiPjCUHGJ2TewWyNK5S4XFvncAZ0Nc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PMr51dMzYB3bZTFbKQHxfx7Nt19WRvTeovOhe8YKQQf37uGwviHIq1C0EtHouk1ZQ
	 CQe5UOd9y6FLnvY38fonaBNhMvUhcMyxXORlRbp9GdqVET9a32KiSFFJigK7OiSYav
	 qDbU7fS2H8SUAd0BMQhDcLtExr7KINr1bXfm5DIj36XRsSzRjUC5ReLFoFfnK5ZR/F
	 5f+Fo4YpJuCwtz9l6cO/gxAwhBUqMzEXOv9SU5FelfQOqtPtA9Ufhkke4SYyn461ma
	 WU9QwDdBdD59fTb+QmuCCVebvTNjV/UhDNgioJYPVe5/IcoeABgUxYJrAtmo4xvvZ3
	 ij/WFWt9lwKzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8538111CE;
	Sat, 28 Jun 2025 00:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] ethernet: atl1: Add missing DMA mapping error
 checks
 and count errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175106941651.2094888.2849777716496718594.git-patchwork-notify@kernel.org>
Date: Sat, 28 Jun 2025 00:10:16 +0000
References: <20250625141629.114984-2-fourier.thomas@gmail.com>
In-Reply-To: <20250625141629.114984-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: chris.snook@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, tglx@linutronix.de,
 mingo@kernel.org, jeff@garzik.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Jun 2025 16:16:24 +0200 you wrote:
> The `dma_map_XXX()` functions can fail and must be checked using
> `dma_mapping_error()`.  This patch adds proper error handling for all
> DMA mapping calls.
> 
> In `atl1_alloc_rx_buffers()`, if DMA mapping fails, the buffer is
> deallocated and marked accordingly.
> 
> [...]

Here is the summary with links:
  - [net,v5] ethernet: atl1: Add missing DMA mapping error checks and count errors
    https://git.kernel.org/netdev/net/c/d72411d20905

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



