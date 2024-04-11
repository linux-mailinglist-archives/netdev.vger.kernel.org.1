Return-Path: <netdev+bounces-86853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3478A0788
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 07:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8E71C22A6A
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 05:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D4A13C687;
	Thu, 11 Apr 2024 05:17:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ACE13C676
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 05:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712812670; cv=none; b=BZ4osdCDt0I7Th+GrGuQGBzSzLtDWRHesP59hk5sgGw/Sxj0LqDwowl+eetAf1z2nq6/y9Qqk6F+j2ex5KiUT8Zus9aVUMpDlDgISUXKFN5u2J07uQhG/3u0OpKDyolLd3VfQsbEM+eSa2w4XJpYT7FKnbWM1UD1/vMP10I+PLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712812670; c=relaxed/simple;
	bh=O8cNffn1F0GkrSIOlZErxFbrd6pL1SqVq3VeCR3fAD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDE6d/twrxnhgIgxwZeoLVfry9AqBQpvt+J0re2xy6FcveEyvQEz/s5Ukvwt/bQJPWoye32vjqj5BcJXeAIiqMTpkFf3/IepIgpGuCFGAF41UCUeqPYaRWhYqiwVSHRKLspO45ZdTGI6S+nAK8JPuyIeJSfh78p6No2PilO0B/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rumod-00011d-ET; Thu, 11 Apr 2024 07:17:39 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rumob-00Bcta-2P; Thu, 11 Apr 2024 07:17:37 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rumoa-007bwP-3B;
	Thu, 11 Apr 2024 07:17:36 +0200
Date: Thu, 11 Apr 2024 07:17:36 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: genet: Fixup EEE
Message-ID: <ZhdycHAooDITV1a3@pengutronix.de>
References: <20240408-stmmac-eee-v1-1-3d65d671c06b@lunn.ch>
 <4826747e-0dd5-4ab9-af02-9d17a1ab7358@broadcom.com>
 <67c0777f-f66e-4293-af8b-08e0c4ab0acc@lunn.ch>
 <c2a16e3c-374c-4fd1-9ca7-bf0aeb5ed941@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c2a16e3c-374c-4fd1-9ca7-bf0aeb5ed941@broadcom.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Florian,

On Wed, Apr 10, 2024 at 10:48:26AM -0700, Florian Fainelli wrote:

> I am seeing a functional difference with and without your patch however, =
and
> also, there appears to be something wrong within the bcmgenet driver after
> PHYLIB having absorbed the EEE configuration. Both cases we start on boot
> with:
>=20
> # ethtool --show-eee eth0
> EEE settings for eth0:
>         EEE status: disabled
>         Tx LPI: disabled
>         Supported EEE link modes:  100baseT/Full
>                                    1000baseT/Full
>         Advertised EEE link modes:  100baseT/Full
>                                     1000baseT/Full
>         Link partner advertised EEE link modes:  100baseT/Full
>                                                  1000baseT/Full
>=20
> I would expect the EEE status to be enabled, that's how I remember it
> before.

Yes, current default kernel implementation is to use EEE if available.

> Now, with your patch, once I turn on EEE with:
>=20
> # ethtool --set-eee eth0 eee on
> # ethtool --show-eee eth0
> EEE settings for eth0:
>         EEE status: enabled - active
>         Tx LPI: disabled
>         Supported EEE link modes:  100baseT/Full
>                                    1000baseT/Full
>         Advertised EEE link modes:  100baseT/Full
>                                     1000baseT/Full
>         Link partner advertised EEE link modes:  100baseT/Full
>                                                  1000baseT/Full
> #
>=20
> there is no change to the EEE_CTRL register to set the EEE_EN, this only
> happens when doing:
>=20
> # ethtool --set-eee eth0 eee on tx-lpi on
>=20
> which is consistent with the patch, but I don't think this is quite corre=
ct
> as I remembered that "eee on" meant enable EEE for the RX path, and "tx-l=
pi
> on" meant enable EEE for the TX path?

Yes. More precisely, with "eee on" we allow the PHY to advertise EEE
link modes. On link_up, if both sides are agreed to use EEE, MAC is
configured to process LPI opcodes from the PHY and send LPI opcodes to
the PHY if "tx-lpi on" was configured too. tx-lpi will not be enabled in
case of "eee off".

What is exact meaning of EEE_EN on this chip?

Regards,
Oleksij
--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

