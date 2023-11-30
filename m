Return-Path: <netdev+bounces-52544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A7F7FF174
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91CB3B20E84
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB8D495D0;
	Thu, 30 Nov 2023 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4ck698J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBCD85
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 06:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701353631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PQtdjjvyLcduv0PEtDZLVtj4NN0MkNsPP5YsdIq81g=;
	b=N4ck698J1g+MO3X+B6ZLRP0CfqqEgPQoWxh2e0GRglpnD+h6f4si1LtbQbQB/AIguWt6Yt
	7IunDSHOeHQW2RXIO4X3v0MS6raw77R43BXUwkWHSp0MSMXtXvJtu6RAdjz8QAkWxamwWd
	t559NuMCKJKAqMGZseeUd5/tdcH3xmY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-XKWEGXceNNGxGiDPaRDxDA-1; Thu, 30 Nov 2023 09:13:50 -0500
X-MC-Unique: XKWEGXceNNGxGiDPaRDxDA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a15ce485c27so13392666b.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 06:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353628; x=1701958428;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+PQtdjjvyLcduv0PEtDZLVtj4NN0MkNsPP5YsdIq81g=;
        b=ESnFAEOu2r9ehI0EUtCYRRkFANfi701ZiqonMs+585RJYpuheUo8ADBTZyncJ13YMs
         VLoL4B4MYgRz0UDYPNwnMLZL1ZZACyxWl7aNwjf4nWrt75t/9657ee0HhlFMSc6BCW5L
         q5Szmyi8PtdgTP3u7fvZIQ3GlN8l+atlkXtMQpBPW7HSKxBJwIYZCUxie2oGkCKbIcPQ
         yal6Da9lVnXXbYsgd4byP4feHiaJkSIPKCVZ7+8JfCOeo4MuPYpWivK0Kh5NsZ0dTNEa
         Cx8E4qSr0IRicY4oQZCqRWW2fyGAN6L9EblO79d9HHyp/MdgopUgs7pNk/P2FR7qMkYP
         Z6tA==
X-Gm-Message-State: AOJu0YyT7aBEpDcbpl9acgnO94K2uMzyQXWTKqWXzFb1wmYRMLEDZt1t
	he5lg9CPOT+EoacvQ5n+UvgWeuE8yVtTAH+W+iHoH8h4GaqvqvPkEIunA1TRCJXSbhJbQQF3qj2
	dsGghWPl6+CiqtRJp
X-Received: by 2002:a17:906:3a50:b0:9e6:c282:5bd5 with SMTP id a16-20020a1709063a5000b009e6c2825bd5mr13695269ejf.3.1701353628663;
        Thu, 30 Nov 2023 06:13:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+1W+Wun7VROUBW2eagR+Spq3ZRe+h6X4L4Px5xpmgPHCCC3D1b0DrYSWcS/G0SNY7Brk0Sw==
X-Received: by 2002:a17:906:3a50:b0:9e6:c282:5bd5 with SMTP id a16-20020a1709063a5000b009e6c2825bd5mr13695252ejf.3.1701353628188;
        Thu, 30 Nov 2023 06:13:48 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-254-32.dyn.eolo.it. [146.241.254.32])
        by smtp.gmail.com with ESMTPSA id ox11-20020a170907100b00b009920a690cd9sm718454ejb.59.2023.11.30.06.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:13:47 -0800 (PST)
Message-ID: <1a47789d8b56370989f469aa5508738eabb1f798.camel@redhat.com>
Subject: Re: [PATCH v3] net: stmmac: fix FPE events losing
From: Paolo Abeni <pabeni@redhat.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jianheng Zhang <Jianheng.Zhang@synopsys.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Simon Horman <horms@kernel.org>, Andrew
 Halaney <ahalaney@redhat.com>,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, Shenwei Wang <shenwei.wang@nxp.com>,
 Johannes Zink <j.zink@pengutronix.de>, "Russell King (Oracle"
 <rmk+kernel@armlinux.org.uk>,  Jochen Henneberg
 <jh@henneberg-systemdesign.com>, Voon Weifeng <weifeng.voon@intel.com>,
 Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>, Ong Boon
 Leong <boon.leong.ong@intel.com>,  Tan Tee Min <tee.min.tan@intel.com>,
 "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,  "moderated
 list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, James Li <James.Li1@synopsys.com>, Martin
 McKenny <Martin.McKenny@synopsys.com>
Date: Thu, 30 Nov 2023 15:13:45 +0100
In-Reply-To: <081b3aab0c9350a42fdb69149b563c7aef4af0d5.camel@redhat.com>
References: 
	<CY5PR12MB6372BF02C49FC9E628D0EC02BFBCA@CY5PR12MB6372.namprd12.prod.outlook.com>
	 <1716792a3881338b1a416b1f4dd85a9437746ec2.camel@redhat.com>
	 <5djt72m664jtskz4i7vu63cqpb67o4qeu2roqb6322slsypwos@vmf4n2emdazd>
	 <081b3aab0c9350a42fdb69149b563c7aef4af0d5.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-30 at 15:09 +0100, Paolo Abeni wrote:
> On Thu, 2023-11-30 at 16:09 +0300, Serge Semin wrote:
> > Hi Paolo
> >=20
> > On Thu, Nov 30, 2023 at 10:55:34AM +0100, Paolo Abeni wrote:
> > > On Tue, 2023-11-28 at 05:56 +0000, Jianheng Zhang wrote:
> > > > The status bits of register MAC_FPE_CTRL_STS are clear on read. Usi=
ng
> > > > 32-bit read for MAC_FPE_CTRL_STS in dwmac5_fpe_configure() and
> > > > dwmac5_fpe_send_mpacket() clear the status bits. Then the stmmac in=
terrupt
> > > > handler missing FPE event status and leads to FPE handshaking failu=
re and
> > > > retries.
> > > > To avoid clear status bits of MAC_FPE_CTRL_STS in dwmac5_fpe_config=
ure()
> > > > and dwmac5_fpe_send_mpacket(), add fpe_csr to stmmac_fpe_cfg struct=
ure to
> > > > cache the control bits of MAC_FPE_CTRL_STS and to avoid reading
> > > > MAC_FPE_CTRL_STS in those methods.
> > > >=20
> > > > Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-sh=
aking procedure")
> > > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > > Signed-off-by: Jianheng Zhang <jianheng@synopsys.com>
> > > > ---
> > > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c       | 45 +++++++++-=
------------
> > > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |  4 +-
> > > >  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  3 +-
> > > >  drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 +-
> > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  8 +++-
> > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  1 +
> > > >  include/linux/stmmac.h                             |  1 +
> > > >  7 files changed, 36 insertions(+), 30 deletions(-)
> > > >=20
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers=
/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > index e95d35f..8fd1675 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > @@ -710,28 +710,22 @@ void dwmac5_est_irq_status(void __iomem *ioad=
dr, struct net_device *dev,
> > > >  	}
> > > >  }
> > > > =20
> > > > -void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 n=
um_rxq,
> > > > +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_=
cfg *cfg,
> > > > +			  u32 num_txq, u32 num_rxq,
> > > >  			  bool enable)
> > > >  {
> > > >  	u32 value;
> > > > =20
> > > > -	if (!enable) {
> > > > -		value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > -
> > > > -		value &=3D ~EFPE;
> > > > -
> > > > -		writel(value, ioaddr + MAC_FPE_CTRL_STS);
> > > > -		return;
> > > > +	if (enable) {
> > > > +		cfg->fpe_csr =3D EFPE;
> > > > +		value =3D readl(ioaddr + GMAC_RXQ_CTRL1);
> > > > +		value &=3D ~GMAC_RXQCTRL_FPRQ;
> > > > +		value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> > > > +		writel(value, ioaddr + GMAC_RXQ_CTRL1);
> > > > +	} else {
> > > > +		cfg->fpe_csr =3D 0;
> > > >  	}
> > > > -
> > > > -	value =3D readl(ioaddr + GMAC_RXQ_CTRL1);
> > > > -	value &=3D ~GMAC_RXQCTRL_FPRQ;
> > > > -	value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> > > > -	writel(value, ioaddr + GMAC_RXQ_CTRL1);
> > > > -
> > > > -	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > -	value |=3D EFPE;
> > > > -	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> > > > +	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
> > > >  }
> > > > =20
> > > >  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device =
*dev)
> > > > @@ -741,6 +735,9 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr,=
 struct net_device *dev)
> > > > =20
> > > >  	status =3D FPE_EVENT_UNKNOWN;
> > > > =20
> > > > +	/* Reads from the MAC_FPE_CTRL_STS register should only be perfor=
med
> > > > +	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on=
 read"
> > > > +	 */
> > > >  	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > =20
> > > >  	if (value & TRSP) {
> > > > @@ -766,19 +763,15 @@ int dwmac5_fpe_irq_status(void __iomem *ioadd=
r, struct net_device *dev)
> > > >  	return status;
> > > >  }
> > > > =20
> > > > -void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpa=
cket_type type)
> > > > +void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_f=
pe_cfg *cfg,
> > > > +			     enum stmmac_mpacket_type type)
> > > >  {
> > > > -	u32 value;
> > > > +	u32 value =3D cfg->fpe_csr;
> > > > =20
> > > > -	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > -
> > > > -	if (type =3D=3D MPACKET_VERIFY) {
> > > > -		value &=3D ~SRSP;
> > > > +	if (type =3D=3D MPACKET_VERIFY)
> > > >  		value |=3D SVER;
> > > > -	} else {
> > > > -		value &=3D ~SVER;
> > > > +	else if (type =3D=3D MPACKET_RESPONSE)
> > > >  		value |=3D SRSP;
> > > > -	}
> > > > =20
> > > >  	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> > > >  }
> > >=20
> >=20
> > > It's unclear to me why it's not necessary to preserve the SVER/SRSP
> > > bits across MAC_FPE_CTRL_STS writes. I guess they are not part of the
> > > status bits? perhaps an explicit comment somewhere will help?
> >=20
> > The SRSP and SVER are self-cleared flags with no effect on zero
> > writing. Their responsibility is to emit the Respond and Verify
> > mPackets respectively. As soon as the packets are sent, the flags will
> > be reset by hardware automatically. So no, they aren't a part of the
> > status bits.
> >=20
> > Note since 'value' now isn't read from the MAC_FPE_CTRL_STS register,
> > there is no point in clearing up these flags in the local variable
> > because 'value' has now them cleared by default.
> >=20
> > Not sure whether a comment about that is required, since the described
> > behavior is well documented in the Synopsys HW-manual.
>=20
> Thanks for the explanation, it clarifies the things to me. I agree
> there is no need for a patch change.

I'm sorry, I have to take back the last sentence: the submitter and SoB
email address still don't match. @Jianheng: please fix it for good at
the next iteration.

Cheers,

Paolo


