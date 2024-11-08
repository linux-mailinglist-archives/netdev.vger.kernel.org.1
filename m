Return-Path: <netdev+bounces-143239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A002D9C1879
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 09:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F70E287098
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D001DEFEA;
	Fri,  8 Nov 2024 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Kmng3OZF"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A91494D4;
	Fri,  8 Nov 2024 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056030; cv=none; b=fgA7Z2cxMqZUjEnEZfWAQQI6vjPg/wRSfkYQhm6ueJxkXwjzbD/F9nTfjSoo0Br62GAaT+hHcmDz+JGMYtHQ1SfvOEtV2nMRiVpyEwpEA07gC963UE2Wrkkt4qlMEsh8ElYDB3rbCVLl5IYNDt5Znd/uzwt7PRH+fFVE5U7l2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056030; c=relaxed/simple;
	bh=AcVXvw+r6ZLlMrJuixd3Dp/DLv/ioDFxkx3vejkhmOA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiJWbdqx9ad3muKw16s64Ul4vGJ4Q3ysUvFKkKyD4acRRH1+xobzukOy97hdsBE9SFEJ68O3YtCWnbPeYodwqDLOk+W5/SQcHzBtdDKz3/qgw+6LxYbBY699r6CZkxIZ6o+WFsa0lEPSgtv0YPZ4T+PacfV3vThnegpd3xJ/Hto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Kmng3OZF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731056027; x=1762592027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AcVXvw+r6ZLlMrJuixd3Dp/DLv/ioDFxkx3vejkhmOA=;
  b=Kmng3OZFb8XSd3dz3o/H+jFkRjNvkocstp8mMEnIXwMZa45WaxXZlOpS
   EZm55sLm8RA4f4RH1roqA4/Pmn0uQ1rjRmahDdxwzmkRzw/HjFJ5UsOQY
   2uWtl53OTbFUXuCCH6ngyU+92kQSjNuZBlDEcthqUHRSaEQnHW1nMQG9T
   oJZqkVbiuHMaU5dHQV3zngh2pdU96nYlr1NIOB2feBdt7CFw22sIEbtqI
   Pka7ReHS3hS/Uk1IxKkpD5qT+wHfQUs9ouAoVcoTpHtPFQ5SML2br9fhQ
   /Tb6Qn1UPK3bT/9Lnzl5zEBLqhVdMcTT+Y9fZ7PVhd73TpF64DvzDe6g8
   g==;
X-CSE-ConnectionGUID: /fgcW3NtTnSPHHSCigru4g==
X-CSE-MsgGUID: vj1XepvpRP2CPB/h/uuGDw==
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="34564781"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2024 01:53:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Nov 2024 01:53:23 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Nov 2024 01:53:21 -0700
Date: Fri, 8 Nov 2024 08:53:20 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next 7/7] net: lan969x: add function for configuring
 RGMII port devices
Message-ID: <20241108085320.fqbell5bfx3roey4@DEN-DL-M70577>
References: <20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com>
 <20241106-sparx5-lan969x-switch-driver-4-v1-7-f7f7316436bd@microchip.com>
 <6fee4db6-0085-4ce8-a6b5-050fddd0bc5a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6fee4db6-0085-4ce8-a6b5-050fddd0bc5a@lunn.ch>

Hi Andrew,

> > The lan969x switch device includes two RGMII interfaces (port 28 and 29)
> > supporting data speeds of 1 Gbps, 100 Mbps and 10 Mbps.
> >
> > Add new function: rgmii_config() to the match data ops, and use it to
> > configure RGMII port devices when doing a port config.  On Sparx5, the
> > RGMII configuration will always be skipped, as the is_port_rgmii() will
> > return false.
> >
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> > ---
> >  drivers/net/ethernet/microchip/lan969x/lan969x.c   | 105 +++++++++++++++++++++
> >  .../net/ethernet/microchip/sparx5/sparx5_main.h    |   2 +
> >  .../net/ethernet/microchip/sparx5/sparx5_port.c    |   3 +
> >  3 files changed, 110 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.c b/drivers/net/ethernet/microchip/lan969x/lan969x.c
> > index cfd57eb42c04..0681913a05d4 100644
> > --- a/drivers/net/ethernet/microchip/lan969x/lan969x.c
> > +++ b/drivers/net/ethernet/microchip/lan969x/lan969x.c
> > @@ -9,6 +9,17 @@
> >  #define LAN969X_SDLB_GRP_CNT 5
> >  #define LAN969X_HSCH_LEAK_GRP_CNT 4
> >
> > +#define LAN969X_RGMII_TX_CLK_DISABLE 0  /* Disable TX clock generation*/
> > +#define LAN969X_RGMII_TX_CLK_125MHZ 1   /* 1000Mbps */
> > +#define LAN969X_RGMII_TX_CLK_25MHZ  2   /* 100Mbps */
> > +#define LAN969X_RGMII_TX_CLK_2M5MHZ 3   /* 10Mbps */
> > +#define LAN969X_RGMII_PORT_START_IDX 28 /* Index of the first RGMII port */
> > +#define LAN969X_RGMII_PORT_RATE 2       /* 1000Mbps  */
> > +#define LAN969X_RGMII_SHIFT_90DEG 3     /* Phase shift 90deg. (2 ns @ 125MHz) */
> > +#define LAN969X_RGMII_IFG_TX 4          /* TX Inter Frame Gap value */
> > +#define LAN969X_RGMII_IFG_RX1 5         /* RX1 Inter Frame Gap value */
> > +#define LAN969X_RGMII_IFG_RX2 1         /* RX2 Inter Frame Gap value */
> > +
> >  static const struct sparx5_main_io_resource lan969x_main_iomap[] =  {
> >       { TARGET_CPU,                   0xc0000, 0 }, /* 0xe00c0000 */
> >       { TARGET_FDMA,                  0xc0400, 0 }, /* 0xe00c0400 */
> > @@ -293,6 +304,99 @@ static irqreturn_t lan969x_ptp_irq_handler(int irq, void *args)
> >       return IRQ_HANDLED;
> >  }
> >
> > +static int lan969x_port_config_rgmii(struct sparx5 *sparx5,
> > +                                  struct sparx5_port *port,
> > +                                  struct sparx5_port_config *conf)
> > +{
> > +     int tx_clk_freq, idx = port->portno - LAN969X_RGMII_PORT_START_IDX;
> > +     enum sparx5_port_max_tags max_tags = port->max_vlan_tags;
> > +     enum sparx5_vlan_port_type vlan_type = port->vlan_type;
> > +     bool dtag, dotag, tx_delay = false, rx_delay = false;
> > +     u32 etype;
> > +
> > +     tx_clk_freq = (conf->speed == SPEED_10  ? LAN969X_RGMII_TX_CLK_2M5MHZ :
> > +                    conf->speed == SPEED_100 ? LAN969X_RGMII_TX_CLK_25MHZ :
> > +                                               LAN969X_RGMII_TX_CLK_125MHZ);
> 
> https://www.spinics.net/lists/netdev/msg1040925.html
> 
> Once it is merged, i think this does what you want.
>

Nice! Thanks for letting me know.

> > +     if (conf->phy_mode == PHY_INTERFACE_MODE_RGMII ||
> > +         conf->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID)
> > +             rx_delay = true;
> > +
> > +     if (conf->phy_mode == PHY_INTERFACE_MODE_RGMII ||
> > +         conf->phy_mode == PHY_INTERFACE_MODE_RGMII_RXID)
> > +             tx_delay = true;
> 
> O.K, now warning bells are ringing in this reviews head.
> 
> What i don't see is the value you pass to the PHY? You obviously need
> to mask out what the MAC is doing when talking to the PHY, otherwise
> both ends will add delays.
> 

What value should be passed to the PHY?

We (the MAC) add the delays based on the PHY modes - so does the PHY.

RGMII, we add both delays.
RGMII_ID, the PHY adds both delays.
RGMII_TXID, we add the rx delay, the PHY adds the tx delay.
RGMII_RXID, we add the tx delay, the PHY adds the rx delay.

Am I missing something here? :-)

> And in general in Linux, we have the PHY add the delays, not the
> MAC. It is somewhat arbitrary, but the vast majority of systems do
> that. The exception is systems where the PHY is too dumb/cheap to add
> the delays and so the MAC has to do it. I'm don't know of any
> Microchip PHYs which don't support RGMII delays.

Ack.

> 
>         Andrew

/Daniel

