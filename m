Return-Path: <netdev+bounces-52513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113CD7FEFC2
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8474281E67
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 13:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBEF3C695;
	Thu, 30 Nov 2023 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im/ArFDm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405CDD6C;
	Thu, 30 Nov 2023 05:09:44 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9bd3557cfso11929841fa.3;
        Thu, 30 Nov 2023 05:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701349782; x=1701954582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=da5ufd57tWXpSlzE4MME0kb6SHbAqME3sLaJIDhv8Ic=;
        b=Im/ArFDmlashnh2nGY5Pas2Jh2A+H02BvSG1THKpQ6YPT5lGkhe0u1QwA8kId/KdnT
         QwGsM+Le4By0z2U/CYkcvss52d/1nhScJYsa9WO4MuNT84qdRY6rBZKu1rJOQc69pfmb
         8ZsZfiho8J9SMGk5DGrxxR6vJIzaUBBnZkao6HQSMm58X6e7c6PeEoGU8DU9ILOjFnPb
         lkdvwzZsd7cPBh37amTLRsLGO9vw/4/W7SX5+MyUw4nbVmboXBmpaYH9qwo2tAw7NnwX
         mAEnU1229VqxOcV30rzAfDbZqckdUuGy9e4z0b0tqzKZHt5FpDbQcfgWssofgxtfqhZf
         e1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701349782; x=1701954582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=da5ufd57tWXpSlzE4MME0kb6SHbAqME3sLaJIDhv8Ic=;
        b=l0mvxam3MwkSlMHaaRdjPQtHp+K5w9iUdfiHJGAVtyuLlPkziV2xKS8vv5IH+4lVOB
         wfII4C0hNxFydHKX534KMtdbVKSSQvwlu1mY1dGgc65UiO3Ha8qHXG2I+AtZq8A8Ivko
         1bVprhfP8Zqy0jv2M55CqjE6BbjfaX8y7MgUkJbvl4np2VZN4fWTadQmyiwMzaVIwiOo
         iBjl/MnwjWrJoRB3w0w9qPKpgWmQiU/lhIL597z/+KbvFoayoJO47L+zvUzbxdN4DrbC
         QYfPZA3ZJImddcxkaiRX/B73SD8Uhk1ha13EACJn5s/GzRE+DX8Ecy7K3EPvh9QGl9bh
         m2Hw==
X-Gm-Message-State: AOJu0YyUriVqbNaWOPemfLVlHCHSEXdzeldK3kW98Dy1dinjmtfMdAB7
	uVMJO6f1n+BpZPpF8i6mwzQ=
X-Google-Smtp-Source: AGHT+IHZZq+mpon//KVX/ODG35QK/HioZ5belNK2yEIWQkeaf4mxbX52keAl41xu2O210pOw2AjMwQ==
X-Received: by 2002:a05:6512:284:b0:50b:bf57:7d6 with SMTP id j4-20020a056512028400b0050bbf5707d6mr4813341lfp.6.1701349782003;
        Thu, 30 Nov 2023 05:09:42 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id g15-20020a19e04f000000b0050bbd1feb5bsm165331lfj.199.2023.11.30.05.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:09:41 -0800 (PST)
Date: Thu, 30 Nov 2023 16:09:37 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jianheng Zhang <Jianheng.Zhang@synopsys.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Simon Horman <horms@kernel.org>, Andrew Halaney <ahalaney@redhat.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Johannes Zink <j.zink@pengutronix.de>, "Russell King (Oracle" <rmk+kernel@armlinux.org.uk>, 
	Jochen Henneberg <jh@henneberg-systemdesign.com>, Voon Weifeng <weifeng.voon@intel.com>, 
	Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>, Ong Boon Leong <boon.leong.ong@intel.com>, 
	Tan Tee Min <tee.min.tan@intel.com>, "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	James Li <James.Li1@synopsys.com>, Martin McKenny <Martin.McKenny@synopsys.com>
Subject: Re: [PATCH v3] net: stmmac: fix FPE events losing
Message-ID: <5djt72m664jtskz4i7vu63cqpb67o4qeu2roqb6322slsypwos@vmf4n2emdazd>
References: <CY5PR12MB6372BF02C49FC9E628D0EC02BFBCA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <1716792a3881338b1a416b1f4dd85a9437746ec2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716792a3881338b1a416b1f4dd85a9437746ec2.camel@redhat.com>

Hi Paolo

On Thu, Nov 30, 2023 at 10:55:34AM +0100, Paolo Abeni wrote:
> On Tue, 2023-11-28 at 05:56 +0000, Jianheng Zhang wrote:
> > The status bits of register MAC_FPE_CTRL_STS are clear on read. Using
> > 32-bit read for MAC_FPE_CTRL_STS in dwmac5_fpe_configure() and
> > dwmac5_fpe_send_mpacket() clear the status bits. Then the stmmac interrupt
> > handler missing FPE event status and leads to FPE handshaking failure and
> > retries.
> > To avoid clear status bits of MAC_FPE_CTRL_STS in dwmac5_fpe_configure()
> > and dwmac5_fpe_send_mpacket(), add fpe_csr to stmmac_fpe_cfg structure to
> > cache the control bits of MAC_FPE_CTRL_STS and to avoid reading
> > MAC_FPE_CTRL_STS in those methods.
> > 
> > Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-shaking procedure")
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > Signed-off-by: Jianheng Zhang <jianheng@synopsys.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c       | 45 +++++++++-------------
> >  drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |  4 +-
> >  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  3 +-
> >  drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 +-
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  8 +++-
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  1 +
> >  include/linux/stmmac.h                             |  1 +
> >  7 files changed, 36 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > index e95d35f..8fd1675 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > @@ -710,28 +710,22 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
> >  	}
> >  }
> >  
> > -void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> > +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> > +			  u32 num_txq, u32 num_rxq,
> >  			  bool enable)
> >  {
> >  	u32 value;
> >  
> > -	if (!enable) {
> > -		value = readl(ioaddr + MAC_FPE_CTRL_STS);
> > -
> > -		value &= ~EFPE;
> > -
> > -		writel(value, ioaddr + MAC_FPE_CTRL_STS);
> > -		return;
> > +	if (enable) {
> > +		cfg->fpe_csr = EFPE;
> > +		value = readl(ioaddr + GMAC_RXQ_CTRL1);
> > +		value &= ~GMAC_RXQCTRL_FPRQ;
> > +		value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> > +		writel(value, ioaddr + GMAC_RXQ_CTRL1);
> > +	} else {
> > +		cfg->fpe_csr = 0;
> >  	}
> > -
> > -	value = readl(ioaddr + GMAC_RXQ_CTRL1);
> > -	value &= ~GMAC_RXQCTRL_FPRQ;
> > -	value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> > -	writel(value, ioaddr + GMAC_RXQ_CTRL1);
> > -
> > -	value = readl(ioaddr + MAC_FPE_CTRL_STS);
> > -	value |= EFPE;
> > -	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> > +	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
> >  }
> >  
> >  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
> > @@ -741,6 +735,9 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
> >  
> >  	status = FPE_EVENT_UNKNOWN;
> >  
> > +	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
> > +	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
> > +	 */
> >  	value = readl(ioaddr + MAC_FPE_CTRL_STS);
> >  
> >  	if (value & TRSP) {
> > @@ -766,19 +763,15 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
> >  	return status;
> >  }
> >  
> > -void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_type type)
> > +void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> > +			     enum stmmac_mpacket_type type)
> >  {
> > -	u32 value;
> > +	u32 value = cfg->fpe_csr;
> >  
> > -	value = readl(ioaddr + MAC_FPE_CTRL_STS);
> > -
> > -	if (type == MPACKET_VERIFY) {
> > -		value &= ~SRSP;
> > +	if (type == MPACKET_VERIFY)
> >  		value |= SVER;
> > -	} else {
> > -		value &= ~SVER;
> > +	else if (type == MPACKET_RESPONSE)
> >  		value |= SRSP;
> > -	}
> >  
> >  	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> >  }
> 

> It's unclear to me why it's not necessary to preserve the SVER/SRSP
> bits across MAC_FPE_CTRL_STS writes. I guess they are not part of the
> status bits? perhaps an explicit comment somewhere will help?

The SRSP and SVER are self-cleared flags with no effect on zero
writing. Their responsibility is to emit the Respond and Verify
mPackets respectively. As soon as the packets are sent, the flags will
be reset by hardware automatically. So no, they aren't a part of the
status bits.

Note since 'value' now isn't read from the MAC_FPE_CTRL_STS register,
there is no point in clearing up these flags in the local variable
because 'value' has now them cleared by default.

Not sure whether a comment about that is required, since the described
behavior is well documented in the Synopsys HW-manual.

-Serge(y)

> 
> Thanks
> 
> Paolo
> 
> 

