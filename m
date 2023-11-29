Return-Path: <netdev+bounces-52071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD85D7FD346
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099491C21149
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 09:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E3E18E2D;
	Wed, 29 Nov 2023 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="rmofMkO4"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324C79D;
	Wed, 29 Nov 2023 01:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1701251579; x=1701856379; i=wahrenst@gmx.net;
	bh=CAfQ6z6CnJM474hEi1aalNvFeonVgV0OpFBez2lL1H4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=rmofMkO4p0wzNk0fWkURIwZWGRsf/gHHLy6+V5kG7pwvi88rffTNq8PdEuLNOzkl
	 aLzT1DX3Nw+tnIOY8kxE9rDD5lOicyQxNKNAlwatep8qSQe88uphFvIxhzG//0mBC
	 Vr1QGA7qZsVL/WWgQPZv6F+AN3iwC+/3eg3jsXBDrsLTfQw19zzhnxVuux0CD4DLy
	 O2d0ATEuH7sYN6wptosoAhLmii597/6s4b1wG8qN19MpmxtuWefcgvtCQPUB9yP/J
	 otFV3JmSZHOWjMbZ9hVt8xt7oLXxnAHTN1HPcsy3xstSKnca9JQ9stkKUPWKqJS9e
	 IOWJOgH86AcU9UTrwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1qyPsd0F7s-009zU6; Wed, 29
 Nov 2023 10:52:59 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 2/3] qca_debug: Fix ethtool -G iface tx behavior
Date: Wed, 29 Nov 2023 10:52:40 +0100
Message-Id: <20231129095241.31302-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129095241.31302-1-wahrenst@gmx.net>
References: <20231129095241.31302-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GQI267fAT2PuVVzt7gfEUhpw+qz5zCsYdHETtuuHnDCcooy3Saz
 C1tG+VZZrLv/CszX6rBXQePyguAUCfOm4Q2OJS76Zy8qaNqKVbEUvA1pA/0UdC4H1u6ohF6
 VEuH5+hPvF12MTVWMpE8EKBUYrLVlLfjq7wKD9xEgYTuI/5CIaPl+hCaPFCJG/pgVZnJ9EU
 TqpR1dRdnVzmRFhTgN8Ng==
UI-OutboundReport: notjunk:1;M01:P0:Si+6HpenhpA=;qbObQ8smblnE9ryU95oJ1c2VNxz
 DDrTCODZABrdzOGiVtXFzz+INes1IJBTFBX6Y0P9jGq/fcv6Q55WtlaTJtXxhXWRO015pCDc4
 QevX3NZWCV88cz1KXQhmvvXflQLqWzZJ6W0lSM57gmnrUhIQFapl8vk+OK6CR7OJVVhjZ5Fji
 dYXkFnQFGzbtHkywlqr+F5BKSJWm771Eaq/wibPQvejSpsK99wfTKRK2plDGWkK96tA0GLp9S
 8J7G4a/MJmDiA80RUqECBiEZzgK+KSbn0Dvwl2XRqPi1mKZm5z8wwV9NiBARzsfrJHYvIyhUX
 HX0RmceKL3Yc/WNuc5btK9zzVpC4Oyc+cKTVF0wS7brIT1aBKtdVcgSPgTyI03nwvncpMls5S
 dVzFd8mPZjXlCL2D3ghhhuLOa7BD/pT3ey1U8a7RC3+8Z95qoy6S9NqdlbUBRM8hcCZU56a5S
 xOGhXThqWlBLV52cp78Udu0yCti7v14NmPPP7qiz6wVibtpHA6++NBqRDgzbwTAhEdkSxfrnS
 nEp1eyKkwfP0FzNZdD8Eygq6MO8a8ij87k6VTNGsOyLgkVqSm0AkSZHkoNN/C3OddwH2XDvs5
 zUFPiqXHfF8odpRjfGra5jGKw5eE8TOOTJWYp66xkakznjW3HQxpqK1bfOL5VDvN12jQR6g2r
 CqQ6hDSn2UhzX36wvu0ZqhFOhG8/xC+2oUCBfskYgSrFMm0LgQzJRk1woB1lNouyE30uLMQdS
 064q9y2hq/6ag3WNZAOIb+HDSfZ6dplQGQwnseuLu/VwHkeBHoxREOzqvs60p0m35cgVJjW9U
 92LTHprZyj2Ho8GoFUqyxeVIuClYyTQ+X5HU6Wg6nBH88qsKmwqiT6pQj5FW4sTzEFnTXhctO
 cLk8+db9QwL4wIUdztpe/uKYGEsEFqzMrqxtchiOd+z0vRmwVZz1QU/MpLC3ZG+Bm/+tpl9Jq
 Foou7w==

After calling ethtool -g it was not possible to adjust the TX ring
size again:

  # ethtool -g eth1
  Ring parameters for eth1:
  Pre-set maximums:
  RX:		4
  RX Mini:	n/a
  RX Jumbo:	n/a
  TX:		10
  Current hardware settings:
  RX:		4
  RX Mini:	n/a
  RX Jumbo:	n/a
  TX:		10
  # ethtool -G eth1 tx 8
  netlink error: Invalid argument

The reason for this is that the readonly setting rx_pending get
initialized and after that the range check in qcaspi_set_ringparam()
fails regardless of the provided parameter. So fix this by accepting
the exposed RX defaults. Instead of adding another magic number
better use a new define here.

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_debug.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ether=
net/qualcomm/qca_debug.c
index 9777dbb17ac2..c84a1271857e 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -30,6 +30,8 @@

 #define QCASPI_MAX_REGS 0x20

+#define QCASPI_RX_MAX_FRAMES 4
+
 static const u16 qcaspi_spi_regs[] =3D {
 	SPI_REG_BFR_SIZE,
 	SPI_REG_WRBUF_SPC_AVA,
@@ -252,9 +254,9 @@ qcaspi_get_ringparam(struct net_device *dev, struct et=
htool_ringparam *ring,
 {
 	struct qcaspi *qca =3D netdev_priv(dev);

-	ring->rx_max_pending =3D 4;
+	ring->rx_max_pending =3D QCASPI_RX_MAX_FRAMES;
 	ring->tx_max_pending =3D TX_RING_MAX_LEN;
-	ring->rx_pending =3D 4;
+	ring->rx_pending =3D QCASPI_RX_MAX_FRAMES;
 	ring->tx_pending =3D qca->txr.count;
 }

@@ -266,7 +268,7 @@ qcaspi_set_ringparam(struct net_device *dev, struct et=
htool_ringparam *ring,
 	struct qcaspi *qca =3D netdev_priv(dev);
 	bool queue_active =3D !netif_queue_stopped(dev);

-	if ((ring->rx_pending) ||
+	if (ring->rx_pending !=3D QCASPI_RX_MAX_FRAMES ||
 	    (ring->rx_mini_pending) ||
 	    (ring->rx_jumbo_pending))
 		return -EINVAL;
=2D-
2.34.1


