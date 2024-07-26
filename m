Return-Path: <netdev+bounces-113291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA03293D8DB
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 21:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D82B235A7
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 19:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3DC36134;
	Fri, 26 Jul 2024 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A2P86hru"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B46024B29;
	Fri, 26 Jul 2024 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722020683; cv=none; b=NkpgnCy1QwXGN2AKB3ZZmerr8zdLR9wJHMpWnawJnBsmtcAwlNUsTjGRby/3m0SZY515aDzEmegAtq6UGbnmY1dEMoJWRFbWM7vG/Y8797YRgvDR/VMENxxDyAc29evAULPStnwRii13HI/VYWJM4jdwCyy//vIpnH4zQLdhPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722020683; c=relaxed/simple;
	bh=9aJvFjwGUsuHrwEO0EUiNoQjVM1etnRRAnje0PVOlXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqrgV8Y0Is8+q1nhvdxBkdDVBRna3c9eOU8CgKxhvtWK6JnrXv1f+7sn6os5HwEg1PsoDJB2Qljx3F/sMMvgBbDJ/C7bGl1sSu3H53B07ce4XmaWhNvNRU9GfdWlohmV2bYJwt+71KUV0J5zyhNNzdOBFecPhSybJ3Mg5cTg7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A2P86hru; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68D4140002;
	Fri, 26 Jul 2024 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722020672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQhD1Kldwv4wUD10x0w7aNE1h2WOcAEA34mUy+q4KL0=;
	b=A2P86hru4xFwYOW8KE7dhn85I6hV4BGnnJEeRkkZTMElBL0JTNcFx0DzYDSc45Ni5EUfXS
	micUIgAIXZ+NwviGS1g71E7ulqNwpIRiDQ34bSfDVLd4icBE/5nr8itczOX2gcA3J/7/4/
	tbOwHqHk8tL0kg9xme+deg8hLKdaI1AyRF4iSRBHsgujDywcpa+f1pnP+5JAslM+cwvyLt
	ZXfbCFBBTzDj1bNwRirmwJ2FWDsTi7zS1vEr7sLnfVfRcIG6nSbJxlTr88A+HWOcDFZUbK
	z2Jm1ho4d00Hd7vTVupf31vxdQAwii+4ihyl9ENueQ9ZK5fBjsWj7JlvovXVvA==
Date: Fri, 26 Jul 2024 21:04:27 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "Radu Pirea" <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 <UNGLinuxDriver@microchip.com>, Simon Horman <horms@kernel.org>, "Vladimir
 Oltean" <vladimir.oltean@nxp.com>, <donald.hunter@gmail.com>,
 <danieller@nvidia.com>, <ecree.xilinx@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v17 12/14] net: ethtool: tsinfo: Add support
 for reading tsinfo for a specific hwtstamp provider
Message-ID: <20240726210427.525c7abc@kmaincent-XPS-13-7390>
In-Reply-To: <667b3700-e529-4d2e-9aa1-a738a1d70f0f@intel.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
 <20240709-feature_ptp_netnext-v17-12-b5317f50df2a@bootlin.com>
 <667b3700-e529-4d2e-9aa1-a738a1d70f0f@intel.com>
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

Hello Jacob,

Thanks a lot for your full review!=20

On Wed, 17 Jul 2024 10:35:20 -0700
Jacob Keller <jacob.e.keller@intel.com> wrote:

> On 7/9/2024 6:53 AM, Kory Maincent wrote:
>  [...] =20
>=20
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>=20
> One thing which applies more broadly to the whole series, but I see the
> focus right now is on selecting between NETDEV and PHYLIB.
>=20
> For ice (E800 series) hardware, the timestamps are captured by the PHY,
> but its not managed by phylib, its managed by firmware. In our case we
> would obviously report NETDEV in this case. The hardware only has one
> timestamp point and the fact that it happens at the PHY layer is not
> relevant since you can't select or change it.
>=20
> There are some future plans in the work for hardware based on the ixgbe
> driver which could timestamp at either the MAC or PHY (with varying
> trade-offs in precision vs what can be timestamped), and (perhaps
> unfortunately), the PHY would likely not manageable by phylib.
>=20
> There is also the possibility of something like DMA or completion
> timestamps which are distinct from MAC timestamps. But again can have
> varying trade offs.

As we already discussed in older version of this patch series the
hwtstamp qualifier will be used to select between IEEE 1588 timestamp or DMA
timestamp. See patch 8 :
+/*
+ * Possible type of htstamp provider. Mainly "precise" the default one
+ * is for IEEE 1588 quality and "approx" is for NICs DMA point.
+ */

We could add other enumeration values in the future if needed, to manage new
cases.

Just figured out there is a NIT in the doc. h*w*tstamp.

> I'm hopeful this work can be extended somehow to enable selection
> between the different mechanisms, even when the kernel device being
> represented is the same netdev.

Another nice features would be the support for simultaneous hardware timest=
amp
but I sadly won't be able to work on this.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

