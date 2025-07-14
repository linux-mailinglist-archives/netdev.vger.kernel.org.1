Return-Path: <netdev+bounces-206675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9509B0404E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DF116B5B7
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EE724BBE4;
	Mon, 14 Jul 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9OMVAFa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3FE248F60;
	Mon, 14 Jul 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500417; cv=none; b=BU/elULybZho26T/CpYZzWke6zcfqbUrqYpkU3m+zWyaFDIDr9grWr+lQDhq/uqZYYGr9L5hhTv/tcKkGOdysJoujeLbK/TyMNesZ6tPUEnCSuzsgaVg2VHms2UuACdROzthZxjOCT3q7JTuloRrxlB/ae58zEiCfg0SrK49KRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500417; c=relaxed/simple;
	bh=ZbTnyFu2wdFpma2HJU3wztP0Nr+eewvviXPIjhzHS7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDTEaIbxYtM6fC3PZaP8pcRKPSEmGcpBp3apdv5zV6pls4xSwOBYaR6DsG8Iv0gMNCZClUUoMFTjguVOPvegPcO66VKrDxYBhDJblcHPqLKGJZtyTfAmrpeTOf5SGK4COSmsXsfa5S4NncSAn1tyq5Y0mYgV8s5W32rLKXcveJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9OMVAFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC30CC4CEED;
	Mon, 14 Jul 2025 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752500417;
	bh=ZbTnyFu2wdFpma2HJU3wztP0Nr+eewvviXPIjhzHS7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9OMVAFaYpKkEUo00VozeeMaavQOzwZLjAlgLt8ICUjTf1vDJGPmPiVM3dxUiQT8W
	 4VRwcoLQPJ6JrniWAoHeMOl0Y7I99B7kBMzoowssvE7vvbJD99wGH+WqyeduyxvpiE
	 LFyTzOvhFSUSJalcrHQy3+4qT/AwKsvDWEJMVZJ9ttMUJkd+Zn1hL7vUYIym4+A5lG
	 Nbg4PYgM5l/qXtq27N0m06xeSHOQnvTqco088zagti/MB+TNyP4Zi51PU8IHExyzn7
	 /cSLgh9xO92hCf5ggN+Sa9BM4yu/tdDtKQgIgmfTrwZUDTk//QGnPMaS3QdxcHdY74
	 WwgdJjslLUiQg==
Date: Mon, 14 Jul 2025 14:40:12 +0100
From: Simon Horman <horms@kernel.org>
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
Subject: Re: [PATCH net-next 3/3] net: stmmac: Set CIC bit only for TX queues
 with COE
Message-ID: <20250714134012.GN721198@horms.kernel.org>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-3-c34092a88a72@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-xgmac-minor-fixes-v1-3-c34092a88a72@altera.com>

On Mon, Jul 14, 2025 at 03:59:19PM +0800, Rohan G Thomas via B4 Relay wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> Currently, in the AF_XDP transmit paths, the CIC bit of
> TX Desc3 is set for all packets. Setting this bit for
> packets transmitting through queues that don't support
> checksum offloading causes the TX DMA to get stuck after
> transmitting some packets. This patch ensures the CIC bit
> of TX Desc3 is set only if the TX queue supports checksum
> offloading.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>

Hi Rohan,

I notice that stmmac_xmit() handles a few other cases where
checksum offload should not be requested via stmmac_prepare_tx_desc:

        csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
        /* DWMAC IPs can be synthesized to support tx coe only for a few tx
         * queues. In that case, checksum offloading for those queues that don't
         * support tx coe needs to fallback to software checksum calculation.
         *
         * Packets that won't trigger the COE e.g. most DSA-tagged packets will
         * also have to be checksummed in software.
         */
        if (csum_insertion &&
            (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
             !stmmac_has_ip_ethertype(skb))) {
                if (unlikely(skb_checksum_help(skb)))
                        goto dma_map_err;
                csum_insertion = !csum_insertion;
        }

Do we need to care about them in stmmac_xdp_xmit_zc()
and stmmac_xdp_xmit_xdpf() too?

...

