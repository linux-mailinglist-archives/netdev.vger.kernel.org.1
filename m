Return-Path: <netdev+bounces-50428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46677F5C39
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F751281885
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 10:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8B8224E8;
	Thu, 23 Nov 2023 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1w5lpwk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E16F92;
	Thu, 23 Nov 2023 02:24:17 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-da819902678so706064276.1;
        Thu, 23 Nov 2023 02:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700735056; x=1701339856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQufmsQMrPSkS7WJd7xjAFVYdq3ncbNsEnifCOHUlJ4=;
        b=c1w5lpwkBRCalQEcDHdI5znR7E4SfdUccIlrGeuryHTZ9ycpxEMi0dNR743VX7SkRI
         wsjm1Di/y+kdmxlyV5+mvfCFTajFb8GYpVcU/xvbpFQ5iFMC9xaiTZ6xnr14QuVrZ1hB
         cnHzD2XlKFASImIzChCPYDKS8aifhwBONlHYZOWOfG4Ph56FXk3TVDZ1EQbjKCgdzXct
         ufcp5rXl0Jhx+rBhkhyPSFZLry3tPwPyZmTL07UZu4ncO2cmWVkK6yzP+vR4ohaBcAoz
         Mf+SDCKIgu9PrFan10S/GM6YITkllDZQOhUKKBzr5+f2JqlWOoOom7OmagDIlH/bqC8V
         uk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700735056; x=1701339856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQufmsQMrPSkS7WJd7xjAFVYdq3ncbNsEnifCOHUlJ4=;
        b=LgSYqmBqQTOkQax1fnDpCSglxlCu7Std3n2vybwADUutF80yDnIrUCI3jPvkjZgslK
         xUNcoz7YISrA5VhdAtsqepQLbA9HKJ2Hr7eGSNxXhx9bs1t2nQrC+65iD93WreQf15iB
         f6bnDb0OL7wQck+1sAdnsLubXl8upcJzXJw4ckq7tF62uwZSiaFKnLjfmZmGs52hBOvf
         13tEK0U/3RlYY62yn4qVqXJqkuOJWTy7UHBrVA2RO6zzrBYvgkZGXcSyyfR9+oRY4PZ7
         cuI0R003Ykn0IRLhW9ObJYJZnCLeph70XSFYEm18PCAuovI6lkViJ+qfJAGBFZNpjuQ6
         joQA==
X-Gm-Message-State: AOJu0YzJpXUFdO97JKQbzxSqn+pKBanfVs56M1zoIdazOqQ9XLN2V5Iv
	JedOZmd75KYxEc9xqFHwuh0=
X-Google-Smtp-Source: AGHT+IENgIG/WZEXSmFCwcoG/xkUbrQpBfoOkPI+26QxfSOl6uNAZx8VFJ+tevbjUvS1yTo6nh0i8g==
X-Received: by 2002:a25:b309:0:b0:d91:c3fe:6144 with SMTP id l9-20020a25b309000000b00d91c3fe6144mr4983504ybj.3.1700735056068;
        Thu, 23 Nov 2023 02:24:16 -0800 (PST)
Received: from localhost ([74.48.130.204])
        by smtp.gmail.com with ESMTPSA id z6-20020a256646000000b00da0c63aa9f1sm237492ybm.20.2023.11.23.02.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:24:15 -0800 (PST)
Date: Thu, 23 Nov 2023 18:24:05 +0800
From: Furong Xu <0x1207@gmail.com>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <xfr@outlook.com>, <rock.xu@nio.com>
Subject: Re: [PATCH net v1] net: stmmac: xgmac: Disable FPE MMC interrupts
Message-ID: <20231123182405.00006454@gmail.com>
In-Reply-To: <2c2d0641-002c-4ce6-9df4-bc633e602721@intel.com>
References: <20231123093538.2216633-1-0x1207@gmail.com>
	<2c2d0641-002c-4ce6-9df4-bc633e602721@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 11:17:17 +0100
Wojciech Drewek <wojciech.drewek@intel.com> wrote:

> On 23.11.2023 10:35, Furong Xu wrote:
> > Commit aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts
> > by default") leaves the FPE(Frame Preemption) MMC interrupts enabled.
> > Now we disable FPE TX and RX interrupts too.  
> 
> Hi,
> Thanks for the patch, one question:
> Why do we have to disable them?
> 

The original commit aeb18dd07692 by Jose Abreu says:

    MMC interrupts were being enabled, which is not what we want because it
    will lead to a storm of interrupts that are not handled at all. Fix it
    by disabling all MMC interrupts for XGMAC.

> > 
> > Fixes: aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts by default")
> > Signed-off-by: Furong Xu <0x1207@gmail.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> > index ea4910ae0921..cdd7fbde2bfa 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> > @@ -177,8 +177,10 @@
> >  #define MMC_XGMAC_RX_DISCARD_OCT_GB	0x1b4
> >  #define MMC_XGMAC_RX_ALIGN_ERR_PKT	0x1bc
> >  
> > +#define MMC_XGMAC_FPE_TX_INTR_MASK	0x204
> >  #define MMC_XGMAC_TX_FPE_FRAG		0x208
> >  #define MMC_XGMAC_TX_HOLD_REQ		0x20c
> > +#define MMC_XGMAC_FPE_RX_INTR_MASK	0x224
> >  #define MMC_XGMAC_RX_PKT_ASSEMBLY_ERR	0x228
> >  #define MMC_XGMAC_RX_PKT_SMD_ERR	0x22c
> >  #define MMC_XGMAC_RX_PKT_ASSEMBLY_OK	0x230
> > @@ -352,6 +354,8 @@ static void dwxgmac_mmc_intr_all_mask(void __iomem *mmcaddr)
> >  {
> >  	writel(0x0, mmcaddr + MMC_RX_INTR_MASK);
> >  	writel(0x0, mmcaddr + MMC_TX_INTR_MASK);
> > +	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_FPE_TX_INTR_MASK);
> > +	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_FPE_RX_INTR_MASK);
> >  	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_IPC_INTR_MASK);
> >  }
> >    


