Return-Path: <netdev+bounces-101341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F938FE2FE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05091C254D3
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FE7153573;
	Thu,  6 Jun 2024 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lpEBkUbw"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D51534E4;
	Thu,  6 Jun 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666502; cv=none; b=ezVyZDydXMFSYHRvZooVagSyLmHTVoZZ/G6pi+WjUnlb0fG9cVPaurY9TzCJPZoQCtK15bZGxxwC10NVOBIDRDROKqTk3CaGW1dVs2mmx7HyQWI0S1UKBXjZMTPbmsyUczDYwNYFobiUbUGxc4XT7M/iTUN61Js/ovpRB6SY8yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666502; c=relaxed/simple;
	bh=AteQUiMN9mu0T8tkg+4d+kFHWiS7N/ANiSWeyPvJSGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xpv17e7LTOyh/bwryJQkgUd6WfaGJQNsR4P6PYAZU/HnnhgzyUU4zuFqfIZbuAMSd0OFcKPimzTucrFrvNbFYBmoW2KIay3fpik5z7WkXr1Q/2Sp6cyKpORt03ZBxtZTZXXgQV1v6FdQkF2LhTSSfJQQDXQsyhBCEh1uo5jTE7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lpEBkUbw; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA5BF4000A;
	Thu,  6 Jun 2024 09:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717666497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RS0s9L44RI2bohZZrpnBXbgm/qsCjn1tbXIkJCFMuX8=;
	b=lpEBkUbwH6HwdJRVgyaQVE9iH81VHMRt8U5Y0dwkSR7NAer3zyjr5MpO+tvb8U8rPBWHaU
	2tPH9q14mkbOYPB0+chmRbILHw3gQnuCbUNUt1No/2IJ/XLOm0ElK5yoqKHuriTN43E7Bn
	+KUJM/6oRXnk5PRYtGobsJsKs75osPy1NGxpFxhwL9Nwnrg9AZ+9gseSBxqGMAmn2Krwdz
	g4Ea88qrO6yFtwZukNgZP9MNDZiJmolIwnDgLjlqWHe5GzkmwppRsLkt5nl4OZlWvsn3zW
	BsZmFzBwGrUQ5ST7fyZCcZ7Kjd+kefi7x5p2qvI7RbfTyjI0q/hXbV8b0doXew==
Date: Thu, 6 Jun 2024 11:34:54 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v14 07/14] net: Add struct
 kernel_ethtool_ts_info
Message-ID: <20240606113454.209ca92a@kmaincent-XPS-13-7390>
In-Reply-To: <8b5e1ffe0bc5a9e03c622166f4d5d26c5c6ce9b5.camel@redhat.com>
References: <20240604-feature_ptp_netnext-v14-0-77b6f6efea40@bootlin.com>
	<20240604-feature_ptp_netnext-v14-7-77b6f6efea40@bootlin.com>
	<8b5e1ffe0bc5a9e03c622166f4d5d26c5c6ce9b5.camel@redhat.com>
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

On Thu, 06 Jun 2024 11:14:47 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On Tue, 2024-06-04 at 12:39 +0200, Kory Maincent wrote:
>  [...] =20
>=20
> It looks like 'info' is not zeroed anymore...
>=20
>  [...] =20
>=20
> ... so this risk exposing to user-space unintialized kernel memory

You are right, tx/rx_reserved fields are indeed not initialized anymore.
Thanks for spotting it!
=20
Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

