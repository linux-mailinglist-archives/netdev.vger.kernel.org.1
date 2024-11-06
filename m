Return-Path: <netdev+bounces-142180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7899BDB51
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27FADB22B26
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24E189915;
	Wed,  6 Nov 2024 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmrssPMT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F9188CC6
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857236; cv=none; b=A3shECSXW2IgC/ovKKxhPyVUdpnE+2ijIvk6dEpInj+Sdgyt8a4uRRSWB+N2xy4niUXRd8wJq4xUuLPEQ/s5U1aOaOtXYwWSjRkGSkVWnw/KX4dkGV0r8Z4MtWMMENjNwFmaqZ4y840snJlxwSseNtBTplsao3sM0PaU6zkvXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857236; c=relaxed/simple;
	bh=aP3eWi+I0q+4qf0bM4LEyuDasUxyQfBIurkp3gC0Oeo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gDpkIP94gifL4cRFw/aPhn9mCpDCYuruyAftvkTNmXoncFw+H+pWxungM9dPkfFofRq3W5VMiJdUarrwgef+qfrcrEdhOQY3ajVFXr9DVcKLtCh38IBOz1Y9r2PeWQg6Jp9V7BVB6qN0CQVX4X2WDLJGZ/1y+ZWtIdAyEuKi7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmrssPMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFC6C4CECF;
	Wed,  6 Nov 2024 01:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730857236;
	bh=aP3eWi+I0q+4qf0bM4LEyuDasUxyQfBIurkp3gC0Oeo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CmrssPMT+TOFcNpliOURRNyVGe3tXLbA+JUVQ8EvfsbWOzoRuAzkbFkGp3csyMJrO
	 Ol99pUkm+NlhxuUoVbi4lYGOPzFdqt5ew3kVuSqU58g7dDUV1Rbv27Zkyt+dYGIEmP
	 ki/ONBO2/UoMCqAJ2cG6Dw4ii0o4UcMmViGQEsUce8MpM+rS/O8axYGORKKHahIcsl
	 pQXGWY6JbNMGA4cApPrq9/OaksLYpSjq6aMiJA+fJZ/AhTs5LrcWtrLt2ApkhO2TnU
	 rBTrHMPr2nmjPBcOlcP5ObheI4iHrmCFG0O1FQ135qIij7DiyvwpTajwFeJLhV1046
	 /1jHyBrE+uohw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713413809A80;
	Wed,  6 Nov 2024 01:40:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 1/2] bnxt_en: cache only 24 bits of hw counter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085724509.759302.5040466179057445452.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 01:40:45 +0000
References: <20241103215108.557531-1-vadfed@meta.com>
In-Reply-To: <20241103215108.557531-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org,
 richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 3 Nov 2024 13:51:07 -0800 you wrote:
> This hardware can provide only 48 bits of cycle counter. We can leave
> only 24 bits in the cache to extend RX timestamps from 32 bits to 48
> bits. Lower 8 bits of the cached value will be used to check for
> roll-over while extending to full 48 bits.
> This change makes cache writes atomic even on 32 bit platforms and we
> can simply use READ_ONCE()/WRITE_ONCE() pair and remove spinlock. The
> configuration structure will be also reduced by 4 bytes.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] bnxt_en: cache only 24 bits of hw counter
    https://git.kernel.org/netdev/net-next/c/bb2ef9b92bdf
  - [net-next,v5,2/2] bnxt_en: replace PTP spinlock with seqlock
    https://git.kernel.org/netdev/net-next/c/6c0828d00f07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



