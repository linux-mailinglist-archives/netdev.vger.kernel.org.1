Return-Path: <netdev+bounces-146254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB4D9D2769
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DBB1F23041
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05991CCEC6;
	Tue, 19 Nov 2024 13:55:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4851154670;
	Tue, 19 Nov 2024 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024516; cv=none; b=q4bxsV/fTr02O3l/yjUD7yQgFbeuBtBX9IhP27T6wbQD/TsgtTLYsDY/Ffu5ta2S7M7qtbrp4pCqjCJfO28/FfD5Lyh9pBOKbDON7q4BI9HS6r+3S3FEWTC+9OVeJTyVzi4FsJvr4vWRnwj0EMxEG+qdlgrx2FlGsAa5EiFywkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024516; c=relaxed/simple;
	bh=SLr8wLJHObtcmee23pr+3IM8O4qo1N6BBgQ9Io8vn78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GPTdByZIiUwrIYk1wjJIjERQP05tesQn7ea1H05cPYppD4gCNwycHzJQCOVYVexwpakDafhrS90+I5OX5YtpvrYBqx/jS4P33N40HMeTXMoBFTxCrVOvgg3MPfIkUoAHcEQyzXjEIxSdb0n0U9AMIDLQ2t6yTpI6u4bjoMhSzC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id C067BC3EEAC5;
	Tue, 19 Nov 2024 14:47:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl C067BC3EEAC5
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: netdev <netdev@vger.kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jose Ignacio Tornos Martinez
 <jtornosm@redhat.com>, Ming Lei <ming.lei@canonical.com>
Subject: [PATCH] usbnet_link_change() fails to call netif_carrier_on()
Sender: khalasa@piap.pl
Date: Tue, 19 Nov 2024 14:46:59 +0100
Message-ID: <m34j43gwto.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

ASIX AX88772B based USB 10/100 Ethernet adapter doesn't come
up ("carrier off"), despite the built-in 100BASE-FX PHY positive link
indication.

The problem appears to be in usbnet.c framework:

void usbnet_link_change(struct usbnet *dev, bool link, bool need_reset)
{
	/* update link after link is reseted */
	if (link && !need_reset)
		netif_carrier_on(dev->net);
	else
		netif_carrier_off(dev->net);

	if (need_reset && link)
		usbnet_defer_kevent(dev, EVENT_LINK_RESET);
	else
		usbnet_defer_kevent(dev, EVENT_LINK_CHANGE);
}

I think the author's idea was a bit different than what the code really
ended doing. Especially when called with link =3D 1 and need_reset =3D 1.

It seems it may have already caused problems - possible workarounds:
- commit 7be4cb7189f7 ("net: usb: ax88179_178a: improve reset check")
- commit ecf848eb934b ("net: usb: ax88179_178a: fix link status when
  link is set to down/up")
Can't check those due to -ENOHW but ax88179_link_reset() adds
a netif_carrier_on() call on link ups.

Not sure about the "reset" name, though (and the comment in
usbnet_link_change()). It seems it's when the link goes up.

Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
Fixes: ac64995da872 ("usbnet: introduce usbnet_link_change API")
Fixes: 4b49f58fff00 ("usbnet: handle link change")

--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1978,16 +1978,18 @@ EXPORT_SYMBOL(usbnet_manage_power);
=20
 void usbnet_link_change(struct usbnet *dev, bool link, bool need_reset)
 {
-	/* update link after link is reseted */
-	if (link && !need_reset)
+	if (link)
 		netif_carrier_on(dev->net);
 	else
 		netif_carrier_off(dev->net);
=20
-	if (need_reset && link)
-		usbnet_defer_kevent(dev, EVENT_LINK_RESET);
-	else
-		usbnet_defer_kevent(dev, EVENT_LINK_CHANGE);
+	if (need_reset) {
+		/* update link after link is reset */
+		if (link)
+			usbnet_defer_kevent(dev, EVENT_LINK_RESET);
+		else
+			usbnet_defer_kevent(dev, EVENT_LINK_CHANGE);
+	}
 }
 EXPORT_SYMBOL(usbnet_link_change);
=20

The code has been introduced in 2013, by 4b49f58fff00 and a bunch of
related commits. Perhaps it visibly affects only AXIS and dm9601
adapters, though.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

