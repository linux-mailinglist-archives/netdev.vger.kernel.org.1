Return-Path: <netdev+bounces-146593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBFC9D47F4
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 07:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13C3B224F1
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 06:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1469A1ABEB4;
	Thu, 21 Nov 2024 06:51:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3EB1AC8A2;
	Thu, 21 Nov 2024 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732171896; cv=none; b=bz7sszpmOq7HW+hwpnZsVUCWs+JfX9/CDKTKDdphULwJDs+GdYjmZOQtL8gSX9SmGhdXyjq4CrKVOO1N01PxQkA+OIP1YETePIDPePQ49UIAaa/pdgl5OSA+G3JTOKIwv6nirEdFTHycMsUEmQf+m7M8mzPNEKyIydx2sKNUjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732171896; c=relaxed/simple;
	bh=WJIdoe0ZU3QvNR5tZoSQf3L46qRt/MN+rIPPxriDbIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WLp9vV2+vpnxT5v6D39uursEw+25i7bYqe2FNIlLow2V8vT0PqgX8Plza2RUb1+1kulDfbibtdzsFpNilCdueXkeZ9oZA5tN8yvg/idIWGgbe+zeaM0jPgm+WTXMOgsTof7xsje9Zr4JSwv2LwEn9JtTUlB92cRCzAXZVHfzTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id 4C2EBC3EEAC5;
	Thu, 21 Nov 2024 07:51:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 4C2EBC3EEAC5
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>,  Oliver Neukum <oneukum@suse.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-usb@vger.kernel.org,  linux-kernel@vger.kernel.org,  Jose Ignacio
 Tornos Martinez <jtornosm@redhat.com>,  Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] usbnet_link_change() fails to call netif_carrier_on()
In-Reply-To: <9baf4f17-bae6-4f5c-b9a1-92dc48fd7a8d@lunn.ch> (Andrew Lunn's
	message of "Tue, 19 Nov 2024 17:20:34 +0100")
References: <m34j43gwto.fsf@t19.piap.pl>
	<9baf4f17-bae6-4f5c-b9a1-92dc48fd7a8d@lunn.ch>
Sender: khalasa@piap.pl
Date: Thu, 21 Nov 2024 07:51:24 +0100
Message-ID: <m3plmpf5ar.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andrew,
thanks for a looking at this.

Andrew Lunn <andrew@lunn.ch> writes:

>> void usbnet_link_change(struct usbnet *dev, bool link, bool need_reset)
>> {
>>       /* update link after link is reseted */
>>       if (link && !need_reset)
>>               netif_carrier_on(dev->net);
>>       else
>>               netif_carrier_off(dev->net);
>>
>>       if (need_reset && link)
>>               usbnet_defer_kevent(dev, EVENT_LINK_RESET);
>>       else
>>               usbnet_defer_kevent(dev, EVENT_LINK_CHANGE);
>> }
>
> This device is using phylink to manage the PHY. phylink will than
> manage the carrier. It assumes it is solely responsible for the
> carrier. So i think your fix is wrong. You probably should be removing
> all code in this driver which touches the carrier.

Ok, I wasn't aware that phylink manages netdev's carrier state.

Then, is the patch wrong just because the asix driver shouldn't use the
function, or is it wrong because the function should work differently
(i.e., the semantics are different)?

Surely the function is broken, isn't it? Calling netif_carrier_off()
on link up event can't be right?


Now the ASIX driver, I'm looking at it for some time now. It consists
of two parts linked together. The ax88172a.c part doesn't use phylink,
while the main asix_devices.c does. So I'm leaving ax88172a.c alone for
now (while it could probably be better ported to the same framework,
i.e., phylink).

The main part uses usbnet.c, which does netif_carrier_{on,off}() in the
above usbnet_link_change(). I guess I can make it use directly
usbnet_defer_kevent() only so it won't be a problem.

Also, usbnet.c calls usbnet_defer_kevent() and thus netif_carrier_off()
in usbnet_probe, removing FLAG_LINK_INTR from asix_devices.c will stop
that.

The last place interacting with carrier status is asix_status(), called
about 8 times a second by usbnet.c intr_complete(). This is independent
of any MDIO traffic. Should I now remove this as well? I guess removing
asix_status would suffice.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

