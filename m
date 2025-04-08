Return-Path: <netdev+bounces-180193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EC4A80400
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CB24650E2
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0D926982F;
	Tue,  8 Apr 2025 11:55:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1326A2690F9;
	Tue,  8 Apr 2025 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113357; cv=none; b=P5wov1G9dlwU6NEmE779szX4rDzSGGd9/Pp/qtW7mWq13wRqPQkeIdU3/qIGOFvKE1UuKM4CWzX18DWh0Skvq1sDdgDRO1g16oc6R6U+4pZnW9cnw45vG2r0SjJ9cS6DlpZoqCaFR4BM+7ttJL/szuNc0gWzV4ZukUV4ZNcobNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113357; c=relaxed/simple;
	bh=HpLk0jZqqH5VTLkGKGvNCpY6zRQPlyk4OlMUBrqmxBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aFFeLFHUXbY7Q0SeyXcFAG1ufmtrpqMJ4lA4RJzuqLQLnK6q/etj+zCNd2NkuCfB6QLgxxRDJE20T/M2PTbKW/ZodWRZup2KaCzeiGyxMaikFrzh8yvIxKbeKM5WhMXjmNVX3dV5mbuZPyaHHpTfMaCkp8IzQIAXYBVES/dk1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id DAEF3C408283;
	Tue,  8 Apr 2025 13:55:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl DAEF3C408283
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev <netdev@vger.kernel.org>,  Oliver Neukum <oneukum@suse.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  <linux-usb@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  Jose
 Ignacio Tornos Martinez <jtornosm@redhat.com>,  Ming Lei
 <ming.lei@redhat.com>
Subject: Re: [PATCH REPOST] usbnet: asix: leave the carrier control to phylink
In-Reply-To: <Z_PVOWDMzmLObRM6@pengutronix.de> (Oleksij Rempel's message of
	"Mon, 7 Apr 2025 15:38:01 +0200")
References: <m35xjgdvih.fsf@t19.piap.pl> <Z_PVOWDMzmLObRM6@pengutronix.de>
Sender: khalasa@piap.pl
Date: Tue, 08 Apr 2025 13:55:49 +0200
Message-ID: <m3tt6ydfzu.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Oleksij,

thanks for your fast response.

Oleksij Rempel <o.rempel@pengutronix.de> writes:

> Good point, this artifact should be partially removed, but not for all
> devices.  Only ax88772 are converted to PHYlink. ax88178 are not
> converted.

There is also AX88172. I assume the situation with 172 and 178 is
similar.

> The AX88772 portion of the driver, is not forwarding the interrupt to
> the PHY driver. It means, PHY is in polling mode. As long as PHY
> provides proper information, it will work.

It does, yes.

> On other hand, you seems to use AX88772B in 100BASE-FX mode. I'm sure,
> current PHY driver for this device do not know anything about FX mode:
> drivers/net/phy/ax88796b.c
>
> Which 100BASE-FX PHY  capable device do you use? Is it possible to buy
> it some where?

No, it's a part of custom hw, but the carrier problem seems to be
independent of the actual PHY type. The PHY code needs a bit of fixing
as well, though (one can't really enable autoneg with 100BASE-FX).

Will attach a version with 8817x parts removed.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

