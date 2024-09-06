Return-Path: <netdev+bounces-125877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE68B96F176
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C3DB230B6
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90C4158862;
	Fri,  6 Sep 2024 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRY4rgFw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E491459FA
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618524; cv=none; b=I7fwve4ZvciQUEIFhdXXcFfh6Kjl6wPnvrctqGzMJEjEg4q4KrfI3lo77WUXgr5i0yj1h24bAUwQ5Ikr7AaE+THi1YYAd4UHe/lC9HolFAz20MfEEb/FGzPbD/X4dYu+znG/Y+I0qSrYEqW3xubc6FHCV6m+LNIcMQaE8aXzFA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618524; c=relaxed/simple;
	bh=5BaC5tCLM4cokqPfWLvVsqm1VrOzWOAlQptFMFimM6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDmPhO1axx9jJkXcXCW/793mBbuNekLnu8kAcR86DgpLUGGtcLDVHsnCZhgu9ptczupYC1pRg5sf/UdZQX2FuG9c+pbbIsGJE1VYAvxuz2SlO3bUESrKgD6TkP0UbKoCAAN9t5bwvTSSZ8lCbhOj0ECvGf2/vebi9g1deudUOIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRY4rgFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BC3C4CEC5;
	Fri,  6 Sep 2024 10:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725618524;
	bh=5BaC5tCLM4cokqPfWLvVsqm1VrOzWOAlQptFMFimM6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VRY4rgFwAaGeU+O2i3eNekIjwHhEv82vc0hJpdLKTbZEKw2Py8dNtjYbd8m+i8rGt
	 q+EcxuziyrxlyvXET2tCtFrn5aBY26Y6pS3oOHWk2xuPkVawRg/mnkuyaExxTvaJRB
	 DHDBf93Jlqccz124foEm630PTwPncEAQZPvWpSYVoQgtSy6FRqdwfWy84seckqNQkd
	 7c+eh3AftQqeVHOiCRH0iVGdH4CXSjz8X/QBBQihIO2hk19rCNgJE4YsNkXZkcWq+O
	 w5Ewa8tROis3p6jmCCCfKP6uXBO9WJ15SjhL1O73iDiwXFi9Qyd9xFY969cSmjy+Z4
	 UyPDAFTF5pg8Q==
Date: Fri, 6 Sep 2024 11:28:39 +0100
From: Simon Horman <horms@kernel.org>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Andrew Halaney <ahalaney@redhat.com>, kernel@quicinc.com
Subject: Re: [PATCH net-next v1] net: stmmac: Programming sequence for VLAN
 packets with split header
Message-ID: <20240906102839.GE2097826@kernel.org>
References: <20240904235456.2663335-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904235456.2663335-1-quic_abchauha@quicinc.com>

On Wed, Sep 04, 2024 at 04:54:56PM -0700, Abhishek Chauhan wrote:
> Currently reset state configuration of split header works fine for
> non-tagged packets and we see no corruption in payload of any size
> 
> We need additional programming sequence with reset configuration to
> handle VLAN tagged packets to avoid corruption in payload for packets
> of size greater than 256 bytes.
> 
> Without this change ping application complains about corruption
> in payload when the size of the VLAN packet exceeds 256 bytes.
> 
> With this change tagged and non-tagged packets of any size works fine
> and there is no corruption seen.
> 
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index e0165358c4ac..dbd1be4e4a92 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -526,6 +526,17 @@ static void dwmac4_enable_sph(struct stmmac_priv *priv, void __iomem *ioaddr,
>  	value |= GMAC_CONFIG_HDSMS_256; /* Segment max 256 bytes */
>  	writel(value, ioaddr + GMAC_EXT_CONFIG);
>  
> +	/* Additional configuration to handle VLAN tagged packets */
> +	value = readl(ioaddr + GMAC_EXT_CFG1);
> +	value &= ~GMAC_CONFIG1_SPLM;
> +	/* Enable Split mode for header and payload at L2  */
> +	value |= GMAC_CONFIG1_SPLM_L2OFST_EN << GMAC_CONFIG1_SPLM_SHIFT;
> +	value &= ~GMAC_CONFIG1_SAVO;
> +	/* Enables the MAC to distinguish between tagged vs untagged pkts */
> +	value |= 4 << GMAC_CONFIG1_SAVO_SHIFT;
> +	value |= GMAC_CONFIG1_SAVE_EN;
> +	writel(value, ioaddr + GMAC_EXT_CFG1);

Hi Abhishek,

Perhaps it is inconsistent with the code elsewhere in this file,
in which case I would suggest a follow-up clean-up, but I
expect that using FIELD_PREP would both lead to cleaner code here
and remove the need for *_SHIFT.

> +
>  	value = readl(ioaddr + DMA_CHAN_CONTROL(dwmac4_addrs, chan));
>  	if (en)
>  		value |= DMA_CONTROL_SPH;
> -- 
> 2.25.1
> 
> 

