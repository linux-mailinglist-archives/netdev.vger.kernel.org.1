Return-Path: <netdev+bounces-51257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F8A7F9D90
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 11:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA6128135E
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6A916404;
	Mon, 27 Nov 2023 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJTg5lcN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2951BE1;
	Mon, 27 Nov 2023 02:32:15 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5094727fa67so5764256e87.3;
        Mon, 27 Nov 2023 02:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701081133; x=1701685933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6EkO/+jvJxUqXrykI1sSA6OiaE4jGEfZVrMxpcuLqiw=;
        b=gJTg5lcNRAiqs8jB4UvZOC3yjOZkOKEXnV3HXuvAnY65VgfXev0x9/KH5QNFIhJ3SE
         Fp834eeQfgl+96UomKXnABD/i7fId8vII7Gyt6Gi+LiT7lkpO8IEfxAZ7vJFU3HOitzK
         667j1hYtNi8WAIAHrmlWlMX7MQ/wrjCsl8IP8PZIFTsfu+g9aXkR/rdtuJkQPcRHrwmv
         xzUDpGnxi532Fr6paKteeXAHmUsmRL+w5lwFmGeLy8LGQ+JY1QwoGMVcs3prIrxwt+e/
         CKPmwM6KczLoAM2JGweDA4meoZjy7/S++m5bb9jyCMtrtZ4vpScYU2mYztPwzjau2/xo
         LEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081133; x=1701685933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EkO/+jvJxUqXrykI1sSA6OiaE4jGEfZVrMxpcuLqiw=;
        b=AtpUFy1VsDNj07uwNLQ6hTAGK6dCr2tOfZBCZMbJvAC6/CuJ7Cy5dxi5PPXbmtNK3Q
         K4wLCwM8OjDOhvvcYxarCmxUmzo/8wgs5/ffoII82jezB4vbX7lydHJaXji9URXLZyFt
         D8k/oJerMAQhNp4lwGJvEwgDFd5IXwlfghAUEoYBZaD02pbbtPGH77nPSnAi+gV7AO4C
         El0vCyz176IPQZ+cJ/ssTbz8imKnfrnRw9K1VOCOGjiOnBEjH/4NYzghDZFdzeMi0yKj
         udU++L9V36jP9N+x3q6+vxyuckwpFaaHxfA024K0WIuIGuGOf0J+4hwoU4Fa4wca/PfJ
         CGbA==
X-Gm-Message-State: AOJu0YwN3+qn0shQZQRFwl2QFMTBy37lj3O5NTdOVknHFbgaKjJHjBM6
	7VEHVs+nQd8GHnk+5o7CjJRYII7T3n6Tmw==
X-Google-Smtp-Source: AGHT+IE3b9c6E7V+MSu9Q2L64S7DO8nOwRZHa34LOV/mGICVyRrnTHJnOY2V9EscGgi3JRfPWtGEdw==
X-Received: by 2002:a05:6512:2343:b0:509:455c:9e3d with SMTP id p3-20020a056512234300b00509455c9e3dmr5108404lfu.18.1701081133118;
        Mon, 27 Nov 2023 02:32:13 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id z20-20020a056512309400b0050aa9cfc238sm1438739lfd.89.2023.11.27.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 02:32:12 -0800 (PST)
Date: Mon, 27 Nov 2023 13:32:10 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xfr@outlook.com, rock.xu@nio.com, 
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: Re: [PATCH net v3] net: stmmac: xgmac: Disable FPE MMC interrupts
Message-ID: <4zucnqqunr6rb6k2g4737ksma4r6q5eizopvmvnmeyrhd4pio2@cism5prdsxmq>
References: <20231125060126.2328690-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125060126.2328690-1-0x1207@gmail.com>

On Sat, Nov 25, 2023 at 02:01:26PM +0800, Furong Xu wrote:
> Commit aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts
> by default") tries to disable MMC interrupts to avoid a storm of
> unhandled interrupts, but leaves the FPE(Frame Preemption) MMC
> interrupts enabled, FPE MMC interrupts can cause the same problem.
> Now we mask FPE TX and RX interrupts to disable all MMC interrupts.
> 
> Fixes: aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts by default")
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v3:
>   - Update commit message, thanks Larysa.
>   - Rename register defines, thanks Serge.

The fix looking good now. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Changes in v2:
>   - Update commit message, thanks Wojciech and Andrew.
> ---
>  drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> index ea4910ae0921..6a7c1d325c46 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> @@ -177,8 +177,10 @@
>  #define MMC_XGMAC_RX_DISCARD_OCT_GB	0x1b4
>  #define MMC_XGMAC_RX_ALIGN_ERR_PKT	0x1bc
>  
> +#define MMC_XGMAC_TX_FPE_INTR_MASK	0x204
>  #define MMC_XGMAC_TX_FPE_FRAG		0x208
>  #define MMC_XGMAC_TX_HOLD_REQ		0x20c
> +#define MMC_XGMAC_RX_FPE_INTR_MASK	0x224
>  #define MMC_XGMAC_RX_PKT_ASSEMBLY_ERR	0x228
>  #define MMC_XGMAC_RX_PKT_SMD_ERR	0x22c
>  #define MMC_XGMAC_RX_PKT_ASSEMBLY_OK	0x230
> @@ -352,6 +354,8 @@ static void dwxgmac_mmc_intr_all_mask(void __iomem *mmcaddr)
>  {
>  	writel(0x0, mmcaddr + MMC_RX_INTR_MASK);
>  	writel(0x0, mmcaddr + MMC_TX_INTR_MASK);
> +	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_TX_FPE_INTR_MASK);
> +	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_FPE_INTR_MASK);
>  	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_IPC_INTR_MASK);
>  }
>  
> -- 
> 2.34.1
> 
> 

