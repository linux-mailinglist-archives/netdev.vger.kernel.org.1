Return-Path: <netdev+bounces-127847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32AA976DE5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA081C23BCA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E6E1B9B33;
	Thu, 12 Sep 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbS1dzrJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395311B9833;
	Thu, 12 Sep 2024 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155456; cv=none; b=igp7ThVUlZUc+9GgJAucX0Y/s9MMe4JFFARpeIjC4o9tmye6uSzdco0vdOd331jGzOcx793lRROBZlDL8slLSB6Pox/WpM8aE9MsI9uN2c0e+78qyk2RJe79ME7cRvzocT5C6vbZeRSXf7PerDV4+bt5MooVuGr6JSAJB5RVeik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155456; c=relaxed/simple;
	bh=N/+WNeF+RDLG1ngsWQ16huQXqFJqMaiTBQhwf09Ovlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo1SHcjtKmijYgguDdiPL7QDVIqTJaQe0GTlv8pn/FgxZxco7z/7ifKMDyTTgIxRxU7nYaPAeLFwiqQKTrcszKQamdByteURANoSmJuBoCQWhlG8uB3fqpnlxbE6L0srAI7Fa3nz1yyzLLoMEiI6cSGqqsYwmp/FjmjaUo/RtHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbS1dzrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB574C4CEC3;
	Thu, 12 Sep 2024 15:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726155455;
	bh=N/+WNeF+RDLG1ngsWQ16huQXqFJqMaiTBQhwf09Ovlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbS1dzrJOj5tds7MBnce/FTebHyPXH1Re3Wsx5wcDhTHcThsHGJGnISRw4fyJwaNi
	 1xSnsYtZ11ng94GVqnlMpyfivdkC3dOl+sIekye8vD7H14dk/RTmMajsIBR140jGKn
	 C9Mols8RTbIXlGeipygGOAb7oQy3DSpLwGGBeeN4XhNw5mtvEB2AksUHNLWOdBQy0u
	 oJv8k+/EPQrshEpB7GTL0Fs5+nC9H+4A2beRcsajAL+5j6Crr7wbWYHoWaEEAD16eK
	 qIHNYWrefsyKEQFZNgxWQMaIv2qEnUkeJKsXg23ratJRIjvDXnsoW/VXj9B8DlQ0kC
	 gvais+ESwUuZA==
Date: Thu, 12 Sep 2024 16:37:30 +0100
From: Simon Horman <horms@kernel.org>
To: KhaiWenTan <khai.wen.tan@linux.intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Tan Khai Wen <khai.wen.tan@intel.com>
Subject: Re: [PATCH net 1/1] net: stmmac: Fix zero-division error when
 disabling tc cbs
Message-ID: <20240912153730.GN572255@kernel.org>
References: <20240912015541.363600-1-khai.wen.tan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912015541.363600-1-khai.wen.tan@linux.intel.com>

On Thu, Sep 12, 2024 at 09:55:41AM +0800, KhaiWenTan wrote:
> The commit b8c43360f6e4 ("net: stmmac: No need to calculate speed divider
> when offload is disabled") allows the "port_transmit_rate_kbps" to be
> set to a value of 0, which is then passed to the "div_s64" function when
> tc-cbs is disabled. This leads to a zero-division error.
> 
> When tc-cbs is disabled, the idleslope, sendslope, and credit values the
> credit values are not required to be configured. Therefore, adding a return
> statement after setting the txQ mode to DCB when tc-cbs is disabled would
> prevent a zero-division error.
> 
> Fixes: b8c43360f6e4 ("net: stmmac: No need to calculate speed divider when offload is disabled")
> Cc: <stable@vger.kernel.org>
> Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 996f2bcd07a2..2c3fd9c66d14 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -392,10 +392,10 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  	} else if (!qopt->enable) {
>  		ret = stmmac_dma_qmode(priv, priv->ioaddr, queue,
>  				       MTL_QUEUE_DCB);
> -		if (ret)
> -			return ret;
> +		if (!ret)
> +			priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
>  
> -		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
> +		return ret;
>  	}

Thanks,

I agree with your analysis. But I think it would
be more idomatic to write it such that the main thread
of execution is the non-error path (in any case,
it makes it easier for me to understand the intent of the code.

What I am suggesting is this (extra context provided for clarity):

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 996f2bcd07a2..308ef4241768 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -392,14 +392,15 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 	} else if (!qopt->enable) {
 		ret = stmmac_dma_qmode(priv, priv->ioaddr, queue,
 				       MTL_QUEUE_DCB);
 		if (ret)
 			return ret;
 
 		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
+		return 0;
 	}
 
 	/* Final adjustments for HW */
 	value = div_s64(qopt->idleslope * 1024ll * ptr, port_transmit_rate_kbps);
 	priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
 
 	value = div_s64(-qopt->sendslope * 1024ll * ptr, port_transmit_rate_kbps);

