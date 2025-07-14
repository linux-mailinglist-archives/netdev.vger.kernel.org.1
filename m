Return-Path: <netdev+bounces-206676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5C2B0407D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02EB188E353
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DD02512F1;
	Mon, 14 Jul 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o9snk7CR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26449251791;
	Mon, 14 Jul 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500576; cv=none; b=r8nxdQVfcq+5OOIqPmh9O2FH61P9DOO32ud7zIn2BdK4kYDTHOBfHLhSKq9ziiYNTweDonWQh+EFmSd4ar4xHPlToGWFcwk+4AOBJEdsU3PLuM9zw07ZSBAGP66WgYkCvzLNQiu9pjclrwe10uLqICwK84TUPuH5DQuDtFZ+5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500576; c=relaxed/simple;
	bh=ZY1mEcbA788gFY1MJ/lv1DNRtgW1ZN3tMmWQwl/jZKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cn/+q7aYJWNBgsWVAjetZFPdtNPJSzzX8Slo2+S89X+lUhS2HZ0DjvjgDnI8ujmp3CjZnCCNhU8KA9B4A64IizmtkLqyozKHB+0Ugdre1rKJODRdMmsuDXfnSxmp7ziEeWkqJmen80KpFtJ20pviDe2y+vYHynqQrjrcZT94J7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o9snk7CR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t0N+ZrcA6krV10K6bTfQdk8wc9i24Hjdh5v0wcjrSLs=; b=o9snk7CRkLQssnn3PEHd9K4Sh+
	C07WQDruJICyhgeokACJ7umEuGahIpsER59n8X89FmzJ7DvTg6BqwjoAzsMGZm6A9TDL9sOdzJSB0
	PvvNXEcbejJlHGLoMcDY7U3mO67GAl1ORZXmeXJ/i9Ss6/4Ki/Qf8D2UUJ3loUBMmftE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubJS7-001Sne-Q2; Mon, 14 Jul 2025 15:42:43 +0200
Date: Mon, 14 Jul 2025 15:42:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: rohan.g.thomas@altera.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next 2/3] net: stmmac: xgmac: Correct supported speed
 modes
Message-ID: <b192c96a-2989-4bdf-ba4f-8b7bcfd09cfa@lunn.ch>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-2-c34092a88a72@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-xgmac-minor-fixes-v1-2-c34092a88a72@altera.com>

On Mon, Jul 14, 2025 at 03:59:18PM +0800, Rohan G Thomas via B4 Relay wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> Correct supported speed modes as per the XGMAC databook.
> Commit 9cb54af214a7 ("net: stmmac: Fix IP-cores specific
> MAC capabilities") removes support for 10M, 100M and
> 1000HD. 1000HD is not supported by XGMAC IP, but it does
> support 10M and 100M FD mode, and it also supports 10M and
> 100M HD mode if the HDSEL bit is set in the MAC_HW_FEATURE0
> reg. This commit adds support for 10M and 100M speed modes
> for XGMAC IP.

> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -405,6 +405,7 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
>  	dma_cap->sma_mdio = (hw_cap & XGMAC_HWFEAT_SMASEL) >> 5;
>  	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
>  	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
> +	dma_cap->mbps_10_100 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;

The commit message does not mention this change.

What does XGMAC_HWFEAT_GMIISEL mean? That a SERDES style interface is
not being used? Could that be why Serge removed these speeds? He was
looking at systems with a SERDES, and they don't support slower
speeds?

	Andrew

