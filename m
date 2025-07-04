Return-Path: <netdev+bounces-204246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57001AF9ACC
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 20:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABA55A2B6B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13986210F4A;
	Fri,  4 Jul 2025 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGzz2/Y8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41031386B4
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751654141; cv=none; b=GkxZouyNzPeVjjR64yxtjtup2dTQJqV/9nDaDaUVNmM88xISZzb/VJ9Mnsagk8ZXy7OHGGkta1zbr45eOZNVFNLSIt7zKFjELbqxq9vccokLdJkiu1ywDhjYv9/uCkcgqcGA8shMOHjO1DTng5WVzSO3LbmwFAUE7eTFLVd1hh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751654141; c=relaxed/simple;
	bh=U9geYByHsf8enlHJPpCq7QpmK+9AHfjGM5nRLkE02tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KX7Ok4mjz+T962LQST7XGCPUc7bpe7BwASJYvNVL2hWmRJWlxHg0P1rYE/g70X5wKhrdZRMgHyUD/wXC6CyJC+xoJe++ejL+cbpDPD7Pjarc7aqUBr/WyNUb96Qhh1maf4XF5+J5cNRHiNn7ar7RlmpFNTc5PaJfuxERjVjvITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGzz2/Y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB0EC4CEE3;
	Fri,  4 Jul 2025 18:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751654140;
	bh=U9geYByHsf8enlHJPpCq7QpmK+9AHfjGM5nRLkE02tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGzz2/Y8p6yKxIIBQzuSGWV8tUC8IUNJPRS2gz/LHrY9js/7JdC8k4glofIqp77h+
	 YSDivQepATF5uokXAGpsaPrQMQNYRAg2Ff43bRvt0fx666/2Cc2yY1d9XNbUp1ll66
	 R/DA0QcoAqY9AeVIAm3TAA3NI/JmmMAR1cbhlWScjaM3ayyYBAg6R8tPI+D2vgYDVY
	 LvOoAyF2FnzxKMD0Qb08KGndQVSSKUxAt89fhqlWLyEChOwaUAecHeByOuy+Fbhx4t
	 tpBkrHRSB2vyQf5abCd+iQYhpUcXDUVmvhX0Eg71Dc9Kf22Gh6+GyCxyBhhPZp0vyi
	 YTtWjjNLcqUCw==
Date: Fri, 4 Jul 2025 19:35:34 +0100
From: Simon Horman <horms@kernel.org>
To: EricChan <chenchuangyu@xiaomi.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	xiaojianfeng <xiaojianfeng1@xiaomi.com>,
	xiongliang <xiongliang@xiaomi.com>
Subject: Re: [PATCH v2] net: stmmac: Fix interrupt handling for
 level-triggered mode in DWC_XGMAC2
Message-ID: <20250704183534.GA356576@horms.kernel.org>
References: <20250703020449.105730-1-chenchuangyu@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703020449.105730-1-chenchuangyu@xiaomi.com>

On Thu, Jul 03, 2025 at 10:04:49AM +0800, EricChan wrote:
> According to the Synopsys Controller IP XGMAC-10G Ethernet MAC Databook
> v3.30a (section 2.7.2), when the INTM bit in the DMA_Mode register is set
> to 2, the sbd_perch_tx_intr_o[] and sbd_perch_rx_intr_o[] signals operate
> in level-triggered mode. However, in this configuration, the DMA does not
> assert the XGMAC_NIS status bit for Rx or Tx interrupt events.
> 
> This creates a functional regression where the condition
> if (likely(intr_status & XGMAC_NIS)) in dwxgmac2_dma_interrupt() will
> never evaluate to true, preventing proper interrupt handling for
> level-triggered mode. The hardware specification explicitly states that
> "The DMA does not assert the NIS status bit for the Rx or Tx interrupt
> events" (Synopsys DWC_XGMAC2 Databook v3.30a, sec. 2.7.2).
> 
> The fix ensures correct handling of both edge and level-triggered
> interrupts while maintaining backward compatibility with existing
> configurations. It has been tested on the hardware device (not publicly
> available), and it can properly trigger the RX and TX interrupt handling
> in both the INTM=0 and INTM=2 configurations.
> 
> Fixes: d6ddfacd95c7 ("net: stmmac: Add DMA related callbacks for XGMAC2")
> Tested-by: EricChan <chenchuangyu@xiaomi.com>
> Signed-off-by: EricChan <chenchuangyu@xiaomi.com>
> ---
> Changes from v1:
> - Add a Fixes tag pointing to the commit in which the problem was introduced
> - Add the testing results of this patch
> 
> [v1] https://lore.kernel.org/all/20250625025134.97056-1-chenchuangyu@xiaomi.com/

Thanks,

I note that this addresses the review by Jakub of v1.

Reviewed-by: Simon Horman <horms@kernel.org>


