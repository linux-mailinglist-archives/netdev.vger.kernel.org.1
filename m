Return-Path: <netdev+bounces-144359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FC49C6D0B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 454F5B23F27
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB901FE0E9;
	Wed, 13 Nov 2024 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D4ZHu/6S"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44E91FE0E7;
	Wed, 13 Nov 2024 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494296; cv=none; b=QvWNfUo8G8G74qKowAQv42LlrzxBTzhqWZDQGvDpxrhmz8EnH9/wQDbBaXrKFL9N5O6jYYYE+uWQ6Xp+Mv08/hRtK2xRd1cvjfetOCdQ8Jh1JKMMQdpnfxN46LPqnorBUCB/3UL5LNZFnqxkyXpjQTxruBdMxs1kS/INXVwl7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494296; c=relaxed/simple;
	bh=GgRgVOMEvS/S1I8Js/v8S2ZAzUUwA0y/X9w1hFwpWzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJKqOWj0GwlUlO2VJE6s3XL8YbPWSa8U3eq8fF21CecKYN5ciH5dc1WYNMoGoJFOI82deUkdyHbWS6O3VgHzffH9sNoJT0NTpmPX7YhLJykNvFoBh3EKvf7G15IbEplpKt0jRhxiSOgrhx2W0ggYOntjpw58TMaHOndB3kVVnE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D4ZHu/6S; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55DBEE0009;
	Wed, 13 Nov 2024 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731494292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PnMiCNy2+Hy5BXlvmadwE+/GEldkxKYZcnFTEDBSHpA=;
	b=D4ZHu/6S7DPFEzLUIg3ULjis4u2iaoRZcHNbwfGs0VTCInpPe/PP6cP9wWsRD18iflvAVu
	6l3cZTrYIz++rNaV1bAiw+gMuaqmMnhSe28yGNadX9wka83/IbO+LoIJFtX1AIxfQkssKZ
	AMtRHlUaAzD/av+a8TFSY/SxEle5WCFWBux7RP406jc0BO9HRVbPomK3IWNdUMxC+YoCAR
	0gfmXkG16LZiIFgTqQqHHxdkLRV3ZeJeLx4Fx7KtXA5dJHakKTPhTZ+9q/xBG+GteEYjuG
	tdAjLyr7O3r9Io/cxWrC3qjkA/muJrm9NoNa+6QEbcp/9gCFNGMMYKGrrgS9lQ==
Date: Wed, 13 Nov 2024 11:38:08 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, donald.hunter@gmail.com,
 danieller@nvidia.com, ecree.xilinx@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>, Jacob
 Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v19 03/10] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Message-ID: <20241113113808.4f8c5a0b@kmaincent-XPS-13-7390>
In-Reply-To: <20241112182226.2a6c8bab@kernel.org>
References: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
	<20241030-feature_ptp_netnext-v19-3-94f8aadc9d5c@bootlin.com>
	<20241111150609.2b0425f6@kernel.org>
	<20241112111232.1637f814@kmaincent-XPS-13-7390>
	<20241112182226.2a6c8bab@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 12 Nov 2024 18:22:26 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 12 Nov 2024 11:12:32 +0100 Kory Maincent wrote:
> > > Storing the info about the "user" (netdev, phydev) in the "provider"
> > > (PHC) feels too much like a layering violation. Why do you need this?=
   =20
> >=20
> > The things is that, the way to manage the phc depends on the "user".
> > ndo_hwtstamp_set for netdev and phy_hwtstamp_set for phydev.
> > https://elixir.bootlin.com/linux/v6.11.6/source/net/core/dev_ioctl.c#L3=
23
> >=20
> > Before PHC was managed by the driver "user" so there was no need for th=
is
> > information as the core only gives the task to the single "user". This
> > didn't really works when there is more than one user possible on the net
> > topology. =20
>=20
> I don't understand. I'm complaining storing netdev state in=20
> struct ptp_clock. It's perfectly fine to add the extra info to netdev
> and PHY topology maintained by the core.

Oh okay. Didn't get it the first time. I could move the PHC source with the
phydev pointer in netdev core to avoid this.

> > > In general I can't shake the feeling that we're trying to configure=20
> > > the "default" PHC for a narrow use case, while the goal should be=20
> > > to let the user pick the PHC per socket.   =20
> >=20
> > Indeed PHC per socket would be neat but it would need a lot more work a=
nd I
> > am even not sure how it should be done. Maybe with a new cmsg structure
> > containing the information of the PHC provider?
> > In any case the new ETHTOOL UAPI is ready to support multiple PHC at the
> > same time when it will be supported.
> > This patch series is something in the middle, being able to enable all =
the
> > PHC on a net topology but only one at a time. =20
>=20
> I understand, I don't want to push you towards implementing all that.
> But if we keep that in mind as the north star we should try to align
> this default / temporary solution. If the socket API takes a PHC ID
> as an input, the configuration we take in should also be maintained
> as "int default_phc", not pointers to things.

In fact I could remove the hwtstamp pointer from netdevice and add only the
hwtstamp source with the phydev rcu pointer.
We will need the phydev pointer as we don't know to which phy device belong=
 the
PTP. Or we could also use the phyindex instead of the phydev pointer and use
phy_link_topo_get_phy() in the hot path.

> IOW I'm struggling to connect the dots how the code you're adding now
> will be built _upon_ rather than _on the side_ of when socket PHC
> selection is in place.

I see what you mean! It is not something easy to think of as I don't really
know how it would be implemented.
Do you think adding simply the PHC source and the phydev pointer or index w=
ould
fit?=20

This could be removed from netdev core when we move to socket PHC as it
won't be necessary to save the current PHC.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

