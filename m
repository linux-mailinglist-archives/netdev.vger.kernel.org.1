Return-Path: <netdev+bounces-52453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DFD7FEC58
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA415B20D37
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E913AC0B;
	Thu, 30 Nov 2023 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6ogwTAN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A92B10D0
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701338139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Za4sJve0w/4uyVCmAF/v91nTDwdldnwMa4Hd6aawqsI=;
	b=d6ogwTANIMa63VjPbYf//XXz2CxtICjO4MA8ZVNqnMz4tOxTPSx9jGf/LuO5TIHOiKIBVm
	osPbUq0ERSQiiHeTqSaS6od3NISuJhHQKIxiu0323+Z3jOf/9aLlNpyUCO+looVTqlXX/D
	khHcawX5BCuQzCI/Kxq7Cd4l+oBMBiI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-SsrUbz_RM6m9gg3-PI9BzA-1; Thu, 30 Nov 2023 04:55:38 -0500
X-MC-Unique: SsrUbz_RM6m9gg3-PI9BzA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a15ce485c27so9307566b.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701338137; x=1701942937;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Za4sJve0w/4uyVCmAF/v91nTDwdldnwMa4Hd6aawqsI=;
        b=JXUBEc653rxdl4t8Ocvp3/bNNjh3uhufAQb9QGWjCOB0nDuMxeGQbbyIF0GGlwNBl8
         5UmABAhlSbe3xAgfJlI6muA/Rbok/Q0sJvz7CV2aFy/lxEUmD2WWtIi6sveGQD94EW6f
         jbz7Vzaq1iXHZL7PnQdYP3IIUsyAj0XPrRxCU9f6y7ovrJy4LGgzfWbBEcnsB0oRrcnQ
         4DzGfE1Sd8iWaiuX3yUf49hdF2kQ2Zqpae/kRucc+WnYVEufEYJbPxJUxJTaEen6MlMb
         hxoJO8xvNEsM+0IHimJDs7POoT8S3oxXHin9LEfSQ/CL8+Vyi/IgTTgMIA/IHonxev33
         P77w==
X-Gm-Message-State: AOJu0Ywi68PCC1PCK3U0eaU/mTxGkjtTqhbXDOAvyal4Iubwuez3TPbr
	meWfZaR5o0m5K2z36+/C/y6rmNqSGRkn/QZyp1I8aIQJAcbr9WMlFfwxc4WTo+d3dTpGo9LPCIY
	LxBkpDF/5esJkR0tZ
X-Received: by 2002:a17:906:3a50:b0:9e6:c282:5bd5 with SMTP id a16-20020a1709063a5000b009e6c2825bd5mr13208722ejf.3.1701338137063;
        Thu, 30 Nov 2023 01:55:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhfQ/rCbsijEdqj8NNrZdyThnnKJUi1IYycp9pCcdpcBskxx8OHIbdnAZXab11CUzP0ZDViQ==
X-Received: by 2002:a17:906:3a50:b0:9e6:c282:5bd5 with SMTP id a16-20020a1709063a5000b009e6c2825bd5mr13208709ejf.3.1701338136699;
        Thu, 30 Nov 2023 01:55:36 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-254-39.dyn.eolo.it. [146.241.254.39])
        by smtp.gmail.com with ESMTPSA id q20-20020a170906145400b009fc927023bcsm495253ejc.34.2023.11.30.01.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 01:55:36 -0800 (PST)
Message-ID: <1716792a3881338b1a416b1f4dd85a9437746ec2.camel@redhat.com>
Subject: Re: [PATCH v3] net: stmmac: fix FPE events losing
From: Paolo Abeni <pabeni@redhat.com>
To: Jianheng Zhang <Jianheng.Zhang@synopsys.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Simon Horman <horms@kernel.org>, Andrew
 Halaney <ahalaney@redhat.com>,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, Shenwei Wang <shenwei.wang@nxp.com>,
 Johannes Zink <j.zink@pengutronix.de>, "Russell King  (Oracle"
 <rmk+kernel@armlinux.org.uk>,  Jochen Henneberg
 <jh@henneberg-systemdesign.com>, Voon Weifeng <weifeng.voon@intel.com>,
 Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>, Ong Boon
 Leong <boon.leong.ong@intel.com>,  Tan Tee Min <tee.min.tan@intel.com>
Cc: "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,  "moderated
 list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, James Li <James.Li1@synopsys.com>, Martin
 McKenny <Martin.McKenny@synopsys.com>
Date: Thu, 30 Nov 2023 10:55:34 +0100
In-Reply-To: <CY5PR12MB6372BF02C49FC9E628D0EC02BFBCA@CY5PR12MB6372.namprd12.prod.outlook.com>
References: 
	<CY5PR12MB6372BF02C49FC9E628D0EC02BFBCA@CY5PR12MB6372.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-28 at 05:56 +0000, Jianheng Zhang wrote:
> The status bits of register MAC_FPE_CTRL_STS are clear on read. Using
> 32-bit read for MAC_FPE_CTRL_STS in dwmac5_fpe_configure() and
> dwmac5_fpe_send_mpacket() clear the status bits. Then the stmmac interrup=
t
> handler missing FPE event status and leads to FPE handshaking failure and
> retries.
> To avoid clear status bits of MAC_FPE_CTRL_STS in dwmac5_fpe_configure()
> and dwmac5_fpe_send_mpacket(), add fpe_csr to stmmac_fpe_cfg structure to
> cache the control bits of MAC_FPE_CTRL_STS and to avoid reading
> MAC_FPE_CTRL_STS in those methods.
>=20
> Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-shaking =
procedure")
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Jianheng Zhang <jianheng@synopsys.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.c       | 45 +++++++++-------=
------
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |  4 +-
>  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  3 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  8 +++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  1 +
>  include/linux/stmmac.h                             |  1 +
>  7 files changed, 36 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/e=
thernet/stmicro/stmmac/dwmac5.c
> index e95d35f..8fd1675 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> @@ -710,28 +710,22 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, st=
ruct net_device *dev,
>  	}
>  }
> =20
> -void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq=
,
> +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *c=
fg,
> +			  u32 num_txq, u32 num_rxq,
>  			  bool enable)
>  {
>  	u32 value;
> =20
> -	if (!enable) {
> -		value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> -
> -		value &=3D ~EFPE;
> -
> -		writel(value, ioaddr + MAC_FPE_CTRL_STS);
> -		return;
> +	if (enable) {
> +		cfg->fpe_csr =3D EFPE;
> +		value =3D readl(ioaddr + GMAC_RXQ_CTRL1);
> +		value &=3D ~GMAC_RXQCTRL_FPRQ;
> +		value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> +		writel(value, ioaddr + GMAC_RXQ_CTRL1);
> +	} else {
> +		cfg->fpe_csr =3D 0;
>  	}
> -
> -	value =3D readl(ioaddr + GMAC_RXQ_CTRL1);
> -	value &=3D ~GMAC_RXQCTRL_FPRQ;
> -	value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> -	writel(value, ioaddr + GMAC_RXQ_CTRL1);
> -
> -	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> -	value |=3D EFPE;
> -	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> +	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
>  }
> =20
>  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
> @@ -741,6 +735,9 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struc=
t net_device *dev)
> =20
>  	status =3D FPE_EVENT_UNKNOWN;
> =20
> +	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
> +	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
> +	 */
>  	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> =20
>  	if (value & TRSP) {
> @@ -766,19 +763,15 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, str=
uct net_device *dev)
>  	return status;
>  }
> =20
> -void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_t=
ype type)
> +void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg=
 *cfg,
> +			     enum stmmac_mpacket_type type)
>  {
> -	u32 value;
> +	u32 value =3D cfg->fpe_csr;
> =20
> -	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> -
> -	if (type =3D=3D MPACKET_VERIFY) {
> -		value &=3D ~SRSP;
> +	if (type =3D=3D MPACKET_VERIFY)
>  		value |=3D SVER;
> -	} else {
> -		value &=3D ~SVER;
> +	else if (type =3D=3D MPACKET_RESPONSE)
>  		value |=3D SRSP;
> -	}
> =20
>  	writel(value, ioaddr + MAC_FPE_CTRL_STS);
>  }

It's unclear to me why it's not necessary to preserve the SVER/SRSP
bits across MAC_FPE_CTRL_STS writes. I guess they are not part of the
status bits? perhaps an explicit comment somewhere will help?

Thanks

Paolo


