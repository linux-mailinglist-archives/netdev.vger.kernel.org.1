Return-Path: <netdev+bounces-52540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845DA7FF156
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB032B20C4F
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A2B48CC1;
	Thu, 30 Nov 2023 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KH7GPrKR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F4FD46
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 06:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701353383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFXhoPIrurlMt3oKt+gDBltjR7LpaWy++S3Ynsr1OGg=;
	b=KH7GPrKRhOSV92954fQE4nQRB1h75gfAfYezbQRUjpqSvDRyElFH6nbN+CGpmj16SB8aCh
	UZHku07VbStwuXH7UxQ5uk2e/5l5W+j8ubJYyw2eaOkDdnzj5j+cG3/WEqvSbkGceYWeWU
	OaQkSjHRmXPaRYH8GDag1fZnXNeN4UM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-Qr2nVJ43OgmfOR_tfwrqLg-1; Thu, 30 Nov 2023 09:09:41 -0500
X-MC-Unique: Qr2nVJ43OgmfOR_tfwrqLg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a18a4b745b2so8106266b.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 06:09:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353380; x=1701958180;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hFXhoPIrurlMt3oKt+gDBltjR7LpaWy++S3Ynsr1OGg=;
        b=MeKhnKMFGbOdlgyuyFHhBcPTY4aBxM98GEO72IGU+yvf+XbNGxGPm52S5P0Hobf8c9
         7erOXe+EcYUX7UrEk6rIZLwFlEFw52GiEcsE6EBAMoGjg0H2ZNdbtrTqYFDrqZLivSYF
         1dEWU1RF2zhuZwPeR/Ya6+3/vqDcRR442bu5pzqn+LKoY5A87Mofk21rOPuE+Gi0rcgk
         tQoKqSBoBYnglzaXr7ieLSFh2Othhqb/npaykM97O/E1WIl4RGLh6CGHP3RX90H8lGDL
         uehclammt80rSVVtfp+FL5XLys0klF90qlGjvn5Us+uPgLtxsbAT+nYvGrQsxLrlkLlg
         0CYQ==
X-Gm-Message-State: AOJu0YwT9b9a60Lg4c3FBX6YnzyeVaBCyW6F2Usi8HuuPTyMRXaN/Oud
	SqiFFHVJfW/eMMOCbtIOt72qB3EM4M0EwFiM9hVrdgv0cT6uZjV5Zj1ALgrHKjvvCyyWNBIOmGX
	8PDOuIzTx7GOe5gCe
X-Received: by 2002:a17:906:2310:b0:a0d:e174:a260 with SMTP id l16-20020a170906231000b00a0de174a260mr1205449eja.4.1701353379876;
        Thu, 30 Nov 2023 06:09:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/J/NuOCQelNz5Fr0Nz9nH3QUKpBRv6CAYTulMHr2IPlT5kd5bgYdAG/A3DMoeVDVhEzKCww==
X-Received: by 2002:a17:906:2310:b0:a0d:e174:a260 with SMTP id l16-20020a170906231000b00a0de174a260mr1205422eja.4.1701353379466;
        Thu, 30 Nov 2023 06:09:39 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-254-32.dyn.eolo.it. [146.241.254.32])
        by smtp.gmail.com with ESMTPSA id pk8-20020a170906d7a800b009fe3e9dee25sm714337ejb.61.2023.11.30.06.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:09:39 -0800 (PST)
Message-ID: <081b3aab0c9350a42fdb69149b563c7aef4af0d5.camel@redhat.com>
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
Date: Thu, 30 Nov 2023 15:09:36 +0100
In-Reply-To: <5djt72m664jtskz4i7vu63cqpb67o4qeu2roqb6322slsypwos@vmf4n2emdazd>
References: 
	<CY5PR12MB6372BF02C49FC9E628D0EC02BFBCA@CY5PR12MB6372.namprd12.prod.outlook.com>
	 <1716792a3881338b1a416b1f4dd85a9437746ec2.camel@redhat.com>
	 <5djt72m664jtskz4i7vu63cqpb67o4qeu2roqb6322slsypwos@vmf4n2emdazd>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-30 at 16:09 +0300, Serge Semin wrote:
> Hi Paolo
>=20
> On Thu, Nov 30, 2023 at 10:55:34AM +0100, Paolo Abeni wrote:
> > On Tue, 2023-11-28 at 05:56 +0000, Jianheng Zhang wrote:
> > > The status bits of register MAC_FPE_CTRL_STS are clear on read. Using
> > > 32-bit read for MAC_FPE_CTRL_STS in dwmac5_fpe_configure() and
> > > dwmac5_fpe_send_mpacket() clear the status bits. Then the stmmac inte=
rrupt
> > > handler missing FPE event status and leads to FPE handshaking failure=
 and
> > > retries.
> > > To avoid clear status bits of MAC_FPE_CTRL_STS in dwmac5_fpe_configur=
e()
> > > and dwmac5_fpe_send_mpacket(), add fpe_csr to stmmac_fpe_cfg structur=
e to
> > > cache the control bits of MAC_FPE_CTRL_STS and to avoid reading
> > > MAC_FPE_CTRL_STS in those methods.
> > >=20
> > > Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-shak=
ing procedure")
> > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > Signed-off-by: Jianheng Zhang <jianheng@synopsys.com>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c       | 45 +++++++++---=
----------
> > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |  4 +-
> > >  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  3 +-
> > >  drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 +-
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  8 +++-
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  1 +
> > >  include/linux/stmmac.h                             |  1 +
> > >  7 files changed, 36 insertions(+), 30 deletions(-)
> > >=20
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/n=
et/ethernet/stmicro/stmmac/dwmac5.c
> > > index e95d35f..8fd1675 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > @@ -710,28 +710,22 @@ void dwmac5_est_irq_status(void __iomem *ioaddr=
, struct net_device *dev,
> > >  	}
> > >  }
> > > =20
> > > -void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num=
_rxq,
> > > +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cf=
g *cfg,
> > > +			  u32 num_txq, u32 num_rxq,
> > >  			  bool enable)
> > >  {
> > >  	u32 value;
> > > =20
> > > -	if (!enable) {
> > > -		value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > -
> > > -		value &=3D ~EFPE;
> > > -
> > > -		writel(value, ioaddr + MAC_FPE_CTRL_STS);
> > > -		return;
> > > +	if (enable) {
> > > +		cfg->fpe_csr =3D EFPE;
> > > +		value =3D readl(ioaddr + GMAC_RXQ_CTRL1);
> > > +		value &=3D ~GMAC_RXQCTRL_FPRQ;
> > > +		value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> > > +		writel(value, ioaddr + GMAC_RXQ_CTRL1);
> > > +	} else {
> > > +		cfg->fpe_csr =3D 0;
> > >  	}
> > > -
> > > -	value =3D readl(ioaddr + GMAC_RXQ_CTRL1);
> > > -	value &=3D ~GMAC_RXQCTRL_FPRQ;
> > > -	value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> > > -	writel(value, ioaddr + GMAC_RXQ_CTRL1);
> > > -
> > > -	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > -	value |=3D EFPE;
> > > -	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> > > +	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
> > >  }
> > > =20
> > >  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *d=
ev)
> > > @@ -741,6 +735,9 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, s=
truct net_device *dev)
> > > =20
> > >  	status =3D FPE_EVENT_UNKNOWN;
> > > =20
> > > +	/* Reads from the MAC_FPE_CTRL_STS register should only be performe=
d
> > > +	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on r=
ead"
> > > +	 */
> > >  	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > =20
> > >  	if (value & TRSP) {
> > > @@ -766,19 +763,15 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr,=
 struct net_device *dev)
> > >  	return status;
> > >  }
> > > =20
> > > -void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpack=
et_type type)
> > > +void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe=
_cfg *cfg,
> > > +			     enum stmmac_mpacket_type type)
> > >  {
> > > -	u32 value;
> > > +	u32 value =3D cfg->fpe_csr;
> > > =20
> > > -	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > -
> > > -	if (type =3D=3D MPACKET_VERIFY) {
> > > -		value &=3D ~SRSP;
> > > +	if (type =3D=3D MPACKET_VERIFY)
> > >  		value |=3D SVER;
> > > -	} else {
> > > -		value &=3D ~SVER;
> > > +	else if (type =3D=3D MPACKET_RESPONSE)
> > >  		value |=3D SRSP;
> > > -	}
> > > =20
> > >  	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> > >  }
> >=20
>=20
> > It's unclear to me why it's not necessary to preserve the SVER/SRSP
> > bits across MAC_FPE_CTRL_STS writes. I guess they are not part of the
> > status bits? perhaps an explicit comment somewhere will help?
>=20
> The SRSP and SVER are self-cleared flags with no effect on zero
> writing. Their responsibility is to emit the Respond and Verify
> mPackets respectively. As soon as the packets are sent, the flags will
> be reset by hardware automatically. So no, they aren't a part of the
> status bits.
>=20
> Note since 'value' now isn't read from the MAC_FPE_CTRL_STS register,
> there is no point in clearing up these flags in the local variable
> because 'value' has now them cleared by default.
>=20
> Not sure whether a comment about that is required, since the described
> behavior is well documented in the Synopsys HW-manual.

Thanks for the explanation, it clarifies the things to me. I agree
there is no need for a patch change.

Cheers,

Paolo


