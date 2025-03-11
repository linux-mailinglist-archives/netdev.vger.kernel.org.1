Return-Path: <netdev+bounces-173804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E569BA5BBE5
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323081708B8
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735E52236E9;
	Tue, 11 Mar 2025 09:19:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from shell.v3.sk (mail.v3.sk [167.172.186.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A91BDCF;
	Tue, 11 Mar 2025 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.186.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684762; cv=none; b=cHCpht1tqNjXfcOrDt1siw6z913jWAnk7QiSreEwnyBOeTGWFD2kEOHnzldLkbcEYOVcaSAKPk7LnrFjUtAi4HYXEQFmCgS5HLB6D3BcCO1y7QME0vUvxhn/Av5swpKTRDdC5DRUP5f2aotPUsTIKzht/KF01YlOosFlWc5mZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684762; c=relaxed/simple;
	bh=aLnNnVYd8qwdahT9fPWWAMzvcIEAF1CIYMOZPUuqAW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lainTpK3FlOIGF2af4843bQHxLVJnnOFJcvImRe4EszkjwxV1OR/iYSUj5ilA6WXwjjsssYGbMPu7NT7iLMMamOZGaEil8IduSA+wCkoi//PWtYIzaGofC1po/FbpUiYpn/sq8U7DNh0VBMxsZis/JnSbRSZEaW7+kAcP7E6DZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk; spf=pass smtp.mailfrom=v3.sk; arc=none smtp.client-ip=167.172.186.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v3.sk
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.v3.sk (Postfix) with ESMTP id 56EB6DFE32;
	Tue, 11 Mar 2025 09:04:48 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
	by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id iXLQUw6eGoAh; Tue, 11 Mar 2025 09:04:47 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.v3.sk (Postfix) with ESMTP id 048FEDFE33;
	Tue, 11 Mar 2025 09:04:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
	by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rKAX3WYt8V26; Tue, 11 Mar 2025 09:04:46 +0000 (UTC)
Received: from demiurge.local (unknown [109.183.109.54])
	by zimbra.v3.sk (Postfix) with ESMTPSA id D9A81DFE32;
	Tue, 11 Mar 2025 09:04:45 +0000 (UTC)
From: Lubomir Rintel <lkundrak@v3.sk>
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] rndis_host: Flag RNDIS modems as WWAN devices
Date: Tue, 11 Mar 2025 10:10:35 +0100
Message-ID: <20250311091035.2523903-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Set FLAG_WWAN instead of FLAG_ETHERNET for RNDIS interfaces on Mobile
Broadband Modems, as opposed to regular Ethernet adapters.

Otherwise NetworkManager gets confused, misjudges the device type,
and wouldn't know it should connect a modem to get the device to work.
What would be the result depends on ModemManager version -- older
ModemManager would end up disconnecting a device after an unsuccessful
probe attempt (if it connected without needing to unlock a SIM), while
a newer one might spawn a separate PPP connection over a tty interface
instead, resulting in a general confusion and no end of chaos.

The only way to get this work reliably is to fix the device type
and have good enough version ModemManager (or equivalent).

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/net/usb/rndis_host.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index 7b3739b29c8f..bb0bf1415872 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -630,6 +630,16 @@ static const struct driver_info	zte_rndis_info =3D {
 	.tx_fixup =3D	rndis_tx_fixup,
 };
=20
+static const struct driver_info	wwan_rndis_info =3D {
+	.description =3D	"Mobile Broadband RNDIS device",
+	.flags =3D	FLAG_WWAN | FLAG_POINTTOPOINT | FLAG_FRAMING_RN | FLAG_NO_SE=
TINT,
+	.bind =3D		rndis_bind,
+	.unbind =3D	rndis_unbind,
+	.status =3D	rndis_status,
+	.rx_fixup =3D	rndis_rx_fixup,
+	.tx_fixup =3D	rndis_tx_fixup,
+};
+
 /*----------------------------------------------------------------------=
---*/
=20
 static const struct usb_device_id	products [] =3D {
@@ -666,9 +676,11 @@ static const struct usb_device_id	products [] =3D {
 	USB_INTERFACE_INFO(USB_CLASS_WIRELESS_CONTROLLER, 1, 3),
 	.driver_info =3D (unsigned long) &rndis_info,
 }, {
-	/* Novatel Verizon USB730L */
+	/* Mobile Broadband Modem, seen in Novatel Verizon USB730L and
+	 * Telit FN990A (RNDIS)
+	 */
 	USB_INTERFACE_INFO(USB_CLASS_MISC, 4, 1),
-	.driver_info =3D (unsigned long) &rndis_info,
+	.driver_info =3D (unsigned long)&wwan_rndis_info,
 },
 	{ },		// END
 };
--=20
2.48.1


