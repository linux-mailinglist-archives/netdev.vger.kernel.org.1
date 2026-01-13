Return-Path: <netdev+bounces-249318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA39D16974
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 05:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A192A3019BEB
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E2034F479;
	Tue, 13 Jan 2026 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKoF02//"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0F34F261;
	Tue, 13 Jan 2026 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768277152; cv=none; b=EZSsWlw7a+omHom0nwh55iZdXhhY7AFdOtB30Ix9w2OdAHhwzupq5NmCrYbXk6l9A0TjBbNc4aLC82qw93Icc3xjpuUrTBkKnrSKb7s+RUTee+K9orXeUqnlQcME+oMz7H/WbbwzeHvxZpm/WYsrCcfTPXLJQy/K+OD/Sv/VuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768277152; c=relaxed/simple;
	bh=N+V/6jE0o/Rh1n8Myluhlkyg6Nia1OUChko2tFtsP1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SM71IFlX55XwBcSuSoZU7H4slbpyWm3V+49pOI6+pImPOfbIc/Hr5Sqfv6LO2brfV0+mZHjKw4FfdrLcgIk9MDYFUcCabOnwA4X9IrxobBAF0KJlrgdKVMSuLF52nD7gblIHY6O0BwQPjx4APmTa9yQDAR4Mdv/NZrjBErOw4fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKoF02//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4564BC116C6;
	Tue, 13 Jan 2026 04:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768277152;
	bh=N+V/6jE0o/Rh1n8Myluhlkyg6Nia1OUChko2tFtsP1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DKoF02//OxV/UtfTqrNw2sH36fPt2tA47uyju1x1Ie1tHi7MAkfemX0hnnVCSIlOy
	 nPA0D3iUbjGRDyosc2zsEZpQIWsMHjc6nltYtehMl559fy5+glN88L+MhIeHFNGvlt
	 h/46VkgqL7oO2E/oZjwO1eMhwxVB+DPdHmJuyady666g6t5uiNtTEBf7G5NWIi0yqq
	 Vnop5SoTW3VR4BNCB91VTkMPWd/7PtzesfzWrmLA/gaklOIVftWDmOARmQqCagoEGV
	 M8btLTxHQUweN+Eg9N7L3O2e2Ey/S/OopF0iCmjrT6YBafapvlfveRUUx3t1HjBs6u
	 N6FZ21CxVXTEw==
Date: Mon, 12 Jan 2026 20:05:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tao Wang <tao03.wang@horizon.auto>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <andrew+netdev@lunn.ch>,
 <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
 <rmk+kernel@armlinux.org.uk>, <maxime.chevallier@bootlin.com>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net Resend] net: stmmac: fix transmit queue timed out
 after resume
Message-ID: <20260112200550.2cd3c212@kernel.org>
In-Reply-To: <20260109070211.101076-1-tao03.wang@horizon.auto>
References: <20260109070211.101076-1-tao03.wang@horizon.auto>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 15:02:11 +0800 Tao Wang wrote:
> after resume dev_watchdog() message:
> "NETDEV WATCHDOG: CPU: x: transmit queue x timed out xx ms"
> 
> The trigging scenario is as follows:
> 
> When the TSO function sets tx_skbuff_dma[tx_q->cur_tx].last_segment = true
> 
> , and the last_segment value is not cleared in stmmac_free_tx_buffer after
> 
>  resume, restarting TSO transmission may incorrectly use
> 
> tx_q->tx_skbuff_dma[first_entry].last_segment = true for a new TSO packet.
> 
> When the tx queue has timed out, and the emac TX descriptor is as follows:
> eth0: 221 [0x0000000876d10dd0]: 0x73660cbe 0x8 0x42 0xb04416a0
> eth0: 222 [0x0000000876d10de0]: 0x77731d40 0x8 0x16a0 0x90000000
> 
> Descriptor 221 is the TSO header, and descriptor 222 is the TSO payload.
> 
> In the tdes3 (0xb04416a0), bit 29 (first descriptor) and bit 28
> 
> (last descriptor) of the TSO packet 221 DMA descriptor cannot both be
> 
> set to 1 simultaneously. Since descriptor 222 is the actual last
> 
> descriptor, failing to set it properly will cause the EMAC DMA to stop
> 
> and hang.

For some reason the reposted version of the patch has unnecessary empty
lines separating each line of this paragraph.

> To solve the issue, set last_segment to false in stmmac_free_tx_buffer:
> tx_q->tx_skbuff_dma[i].last_segment = false;
> Set last_segment to false in stmmac_tso_xmit, and do not use the default
>  value: tx_q->tx_skbuff_dma[first_entry].last_segment = false;
> This will prevent similar issues from occurring in the future.

Please add a suitable Fixes tag, pointing at the commit which
introduced this incorrect behavior (either the commit which broke it or
the commit which added this code if it was always broken).
-- 
pw-bot: cr

