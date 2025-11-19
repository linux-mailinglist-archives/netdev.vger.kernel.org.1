Return-Path: <netdev+bounces-240049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9851FC6FA51
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8738C2F07D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D74338584;
	Wed, 19 Nov 2025 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S6inHp1k"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320532ED2E
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566009; cv=none; b=axQGFzN8qSDbXnNtKEoN2MADgrGG/2jkw6DCyECVFmmp6A7oECetE6seJjUpYXYdmuoVx65rooQszN0xgPdFRYZNG0zCP6C2WQu5WrksWH+dgLhn/pQG6rEnV5d32cBncDYAQbCuOIaKMJycjEPTMeVMdXEUfoUb+hoQCY3c+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566009; c=relaxed/simple;
	bh=2u4FRhhzh/61+8zqP60pZunYXus3IYH6TCZDZcjuxuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MII61+5WfTXkz1x0cYYgoPt9ZOetRlUaSrv3Qhd/1HAI+w/DfS4zQolCZa/MlF1DD848TLtY9yavxcnnH1KKqdQXIM3Q4mvBhyyiRFkOWIs6TCKvpIgwlMYDbGh2pGpuI9wXLmjJdV1+WJH1V4a8kanioSkd8eFnH/ZRt13UKKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S6inHp1k; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D151E1A1BC9;
	Wed, 19 Nov 2025 15:26:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 99D7E60699;
	Wed, 19 Nov 2025 15:26:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F06271037143B;
	Wed, 19 Nov 2025 16:26:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763566003; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nsrwE/JN6CN3A/A5IHf1oLWct2QusTf6CqHhgyQNfQI=;
	b=S6inHp1k0atZEGbp/xYVSl7HJPzINCSvvi2bHEs+k4v8GI9TKJRhiC16fwjSr6vy726Ily
	/DCkduufe/06Cfdrf3JQdTnd6xpACv0foONlzaa7953i8jE4AX8304ABsw4kDHnBzIauMF
	PJYuJgA+Sf8VyKol8PuRPwSCXUvuHbISY7S5KLQEI/R23bQke5itrEYdPt8RJz5x0eIOoY
	h4jIbX3yRiFsxPpXhDf4VfsVwa9w+XyvienvpGwNlRjybWB1/Ld2ymcws3RyWuh122W5T/
	Y1Mfmm8rWY4MJ9R5UYRfpTwWX7TEW3HOn4xd8I6CpOksLfLwdoXL7aRYvx20lQ==
Date: Wed, 19 Nov 2025 16:26:36 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrei Botila
 <andrei.botila@oss.nxp.com>, Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Jacob Keller <jacob.e.keller@intel.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/9] net: phy: micrel: add HW timestamp
 configuration reporting
Message-ID: <20251119162636.1a518f2f@kmaincent-XPS-13-7390>
In-Reply-To: <5a1cab05-bc20-43ae-b5e7-3fd22b7feed6@linux.dev>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
	<20251119124725.3935509-6-vadim.fedorenko@linux.dev>
	<20251119154448.2ca40ac9@kmaincent-XPS-13-7390>
	<5a1cab05-bc20-43ae-b5e7-3fd22b7feed6@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 19 Nov 2025 15:10:27 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> On 19/11/2025 14:44, Kory Maincent wrote:
> > On Wed, 19 Nov 2025 12:47:21 +0000
> > Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> >  =20
> >> The driver stores HW timestamping configuration and can technically
> >> report it. Add callback to do it.
> >>
> >> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> >> ---
> >>   drivers/net/phy/micrel.c | 27 +++++++++++++++++++++++++++
> >>   1 file changed, 27 insertions(+)
> >>
> >> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> >> index 05de68b9f719..b149d539aec3 100644
> >> --- a/drivers/net/phy/micrel.c
> >> +++ b/drivers/net/phy/micrel.c
> >> @@ -3147,6 +3147,18 @@ static void lan8814_flush_fifo(struct phy_device
> >> *phydev, bool egress) lanphy_read_page_reg(phydev, LAN8814_PAGE_PORT_R=
EGS,
> >> PTP_TSU_INT_STS); }
> >>  =20
> >> +static int lan8814_hwtstamp_get(struct mii_timestamper *mii_ts,
> >> +				struct kernel_hwtstamp_config *config)
> >> +{
> >> +	struct kszphy_ptp_priv *ptp_priv =3D
> >> +			  container_of(mii_ts, struct kszphy_ptp_priv,
> >> mii_ts); +
> >> +	config->tx_type =3D ptp_priv->hwts_tx_type;
> >> +	config->rx_filter =3D ptp_priv->rx_filter;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>   static int lan8814_hwtstamp_set(struct mii_timestamper *mii_ts,
> >>   				struct kernel_hwtstamp_config *config,
> >>   				struct netlink_ext_ack *extack)
> >> @@ -4390,6 +4402,7 @@ static void lan8814_ptp_init(struct phy_device
> >> *phydev) ptp_priv->mii_ts.rxtstamp =3D lan8814_rxtstamp;
> >>   	ptp_priv->mii_ts.txtstamp =3D lan8814_txtstamp;
> >>   	ptp_priv->mii_ts.hwtstamp_set =3D lan8814_hwtstamp_set;
> >> +	ptp_priv->mii_ts.hwtstamp_get =3D lan8814_hwtstamp_get;
> >>   	ptp_priv->mii_ts.ts_info  =3D lan8814_ts_info;
> >>  =20
> >>   	phydev->mii_ts =3D &ptp_priv->mii_ts;
> >> @@ -5042,6 +5055,19 @@ static void lan8841_ptp_enable_processing(struct
> >> kszphy_ptp_priv *ptp_priv, #define LAN8841_PTP_TX_TIMESTAMP_EN
> >> 443 #define LAN8841_PTP_TX_MOD			445
> >>  =20
> >> +static int lan8841_hwtstamp_get(struct mii_timestamper *mii_ts,
> >> +				struct kernel_hwtstamp_config *config)
> >> +{
> >> +	struct kszphy_ptp_priv *ptp_priv;
> >> +
> >> +	ptp_priv =3D container_of(mii_ts, struct kszphy_ptp_priv, mii_ts);
> >> +
> >> +	config->tx_type =3D ptp_priv->hwts_tx_type;
> >> +	config->rx_filter =3D ptp_priv->rx_filter; =20
> >=20
> > Something related to this patch, it seems there is an issue in the set
> > callback:
> > https://elixir.bootlin.com/linux/v6.18-rc6/source/drivers/net/phy/micre=
l.c#L3056
> >=20
> > The priv->rx_filter and priv->hwts_tx_type are set before the switch
> > condition. The hwtstamp_get can then report something that is not suppo=
rted.
> > Also HWTSTAMP_TX_ONESTEP_P2P is not managed by the driver but not retur=
ning
> > -ERANGE either so if we set this config the hwtstamp_get will report
> > something wrong as not supported.
> > I think you will need to add a new patch here to fix the hwtstamp_set o=
ps. =20
>=20
> I agree, that there is a problem in the flow, but such change is out of
> scope of this patch set. I'm going to provide some logic improvements on
> per-driver basis as follow up work.

As you want but patch 5 and 6 won't be accepted without these change.

> > Maybe we should update net_hwtstamp_validate to check on the capabiliti=
es
> > reported by ts_info but that is a bigger change. =20
>=20
> In this case we have to introduce validation callback and implement it
> in drivers. Some drivers do downgrade filter values if provided value is
> not in the list of what was provided in ethtool::ts_info. And we have to
> keep this logic as otherwise it may be considered as API breakage.

Indeed so lets keep the current design.
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

