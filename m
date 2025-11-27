Return-Path: <netdev+bounces-242139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BFDC8CBAE
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 754994E1200
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3252BDC00;
	Thu, 27 Nov 2025 03:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/AwBFd4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E2329B78D
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 03:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213224; cv=none; b=HH5qtqwLz9DVvXS2JEB9BITnToZIwWnwnaFBA+KPQSIwd5wJq0Cy2PqBYRtanaThBQwOg5Qpmo2v82oARmf0mtqUtRNQOvWU21XlcTrql9e+odv8cTQ6dR4a3JFQ28OH7mA9F+qVhWy/nO4cRPxVrAnz9c3lEnR6iTlq1XdXEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213224; c=relaxed/simple;
	bh=PzAd4GGO3BzkDsRMbJD5ipPqLCKWlCAPDcfDlqn7+yw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6dy63NqaQ3+fEkaWuKx6o6oS+jDCYjEugHeclPus6CNrrKtoNtzAiexK7ddjjNe4i61IwLLFLSXQncmtAnWlRulgbJDjxtT9S8+Lo4MGAXMBPaIZRaiKcDkekSRVjgnAbOuIC+B0tJ5Y45e78pMHVZ9zkUqlf7XWNekOQwWcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/AwBFd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F847C4CEF7;
	Thu, 27 Nov 2025 03:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764213223;
	bh=PzAd4GGO3BzkDsRMbJD5ipPqLCKWlCAPDcfDlqn7+yw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g/AwBFd4/KQyOLkUIU4AZSaE+1QanYVfnxOJKqGsfNBkA1gyRtSoXpKpw6wTfNOkK
	 EAPyI2X3RdzXyDjBOCwcgBc10x6vXprjWmsXYSvNDTMVADuOFyPESfFZwzua0NdhVB
	 3H4FrGUQxAMzf0VRXVV4MH/d/nWwx0LTuaqUaEzqpDFCQZXQcRcsEZlfMtU7KJkZlA
	 XV/YCvo6o2vDZmDix2KobddldmRV4BO9QjEHPtiQX9lm9v57Mld2iBOPn+lXJ4War9
	 gAnt+T6WyUhiSCOmzAZpf1Ox9Z6BMbQhhKHDQPC7YeKkuqShRqhji2xr1Bag9zVwk1
	 b4PZxihOLAcIg==
Date: Wed, 26 Nov 2025 19:13:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH net-next] amd-xgbe: schedule NAPI on Rx Buffer
 Unavailable to prevent RX stalls
Message-ID: <20251126191342.6728250d@kernel.org>
In-Reply-To: <20251124101111.1268731-1-Raju.Rangoju@amd.com>
References: <20251124101111.1268731-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 15:41:11 +0530 Raju Rangoju wrote:
> When Rx Buffer Unavailable (RBU) interrupt is asserted, the device can
> stall under load and suffer prolonged receive starvation if polling is
> not initiated. Treat RBU as a wakeup source and schedule the appropriate
> NAPI instance (per-channel or global) to promptly recover from buffer
> shortages and refill descriptors.

You need to say more.. Under heavy load network devices will routinely
run out of Rx buffers, it's expected if Rx processing is slower than
the network. What hw condition and scenario exactly are you describing
here?

>  		dma_ch_isr = XGMAC_DMA_IOREAD(channel, DMA_CH_SR);
> +		/* Precompute flags once */
> +		ti  = !!XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, TI);
> +		ri  = !!XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, RI);
> +		rbu = !!XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, RBU);
> +		fbe = !!XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, FBE);

Please split this into two patches, one pure refactoring with no
functional changes and second one changing RBU handling.

> +		if (rbu) {
> +			schedule_napi = true;
> +			pdata->ext_stats.rx_buffer_unavailable++;
> +			netif_dbg(pdata, intr, pdata->netdev,
> +				  "RBU on DMA_CH %u, scheduling %s NAPI\n",
> +				  i, per_ch_irq ? "per-channel" : "global");

I guess it's just _dbg() but as a general rule when the system is under
overload printing stuff (potentially over UART) is the last thing you
should be doing. How is this print useful to you?
-- 
pw-bot: cr

