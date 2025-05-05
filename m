Return-Path: <netdev+bounces-187742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E961AA95B5
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF30189C0B5
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDBC25D203;
	Mon,  5 May 2025 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="FYqpXsNj"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BB125C82C;
	Mon,  5 May 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455097; cv=none; b=LvQjWvJk4yGWCmhQijcQiT0K9xyzIdhYsTWGLnSa2mdqeq787cUBAAkzKmlejQL3n2m3QXS7iNZocKKFXwJ110PonvogQe3fnTWqet+JzSnVvg6wdZYrFOEE1huOeV774oROp4RTpZNsDX4ITgeDZhRTawsFjkwyQ2vW4KLzT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455097; c=relaxed/simple;
	bh=9zy7OUEsoVYG3MG9QPNjumu9een9lFhINWFcNcrlPKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afkjD5oLxBN47sAP62fVaWP9imdf43BLaCfdkgL7vNw/4s9ZrgFNBk5fA7mtmlocnFHIT9jiYxTCHBwjoi1mz9P0odKEg4zXCzx22ukqdAVI936UECDsHj5mkRIqQZY9/qgZkDyD/opVFgXxSgd99niko4YHC2mvUUvhC7fPPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=FYqpXsNj; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746455088; x=1747059888; i=wahrenst@gmx.net;
	bh=ROKh8FkBBdJl0N2w5ZfOvMO8awupDF8fxxtOyC0vDTc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FYqpXsNj9nhK+Y9XTeKzhBv1v0tPjses7ywWzyvXnQK0qLDWD+OY0aNOslxz8mEx
	 /ou7VAPG9DvJawPfcZvSXjhAADJ5U+2/O9xQOiO4h+M9KF/zqCJV+2SGmt9/P5Ww4
	 neQFfzQqucBGRYfkPB+BS5vVEXUZXs0xhyyQpH+j4hVbXbWmZUkTGTE0AvMJTRSBt
	 OfXc8kUICyoaol5AGiFlSdn/KV9n6FDXzCGK39z4IHokpp/KPgUL3h98vYhSoWwf4
	 JYX2HFk1KEvZKNy6XfVxs/CS7izA5VvnvaIy7eFfZMfIWmaV8j+y3KPr/nKoslgmN
	 Evrq4hDWi3NEw/2RBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17YY-1v9i8I0IJ8-00rLbw; Mon, 05
 May 2025 16:24:48 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH net-next 4/5] net: vertexcom: mse102x: Return code for mse102x_rx_pkt_spi
Date: Mon,  5 May 2025 16:24:26 +0200
Message-Id: <20250505142427.9601-5-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505142427.9601-1-wahrenst@gmx.net>
References: <20250505142427.9601-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hkN6ga5f2i/dI8DcD0mRxsoTQp4w6NIF0ha6GN1CkY+womyqvvb
 VzkdVODiJCBQWyHB8PRiQ7H2kTxmH4ntFGmRLzD5NK9YZF+wDO+PdwCTcKlJeU9ZNFGUWKt
 3MkLBoyTU60LcNzZNUx4YO1HWDmGPMHH02lEK1yYKnffdO8ZmMnmgf2eim06fL+HNI93xhw
 5bZCxe2PFlqq5OCXVssUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oUC9Vugsvt0=;sjZV6HY1z8iz64f3U20MJNsFq90
 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
 ISRvbBdGL5ZiMYKoORnTuU=

The interrupt handler mse102x_irq always returns IRQ_HANDLED even
in case the SPI interrupt is not handled. In order to solve this,
let mse102x_rx_pkt_spi return the proper return code.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 204ce8bdbaf8..aeef144d0051 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -303,7 +303,7 @@ static void mse102x_dump_packet(const char *msg, int l=
en, const char *data)
 		       data, len, true);
 }
=20
-static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
+static irqreturn_t mse102x_rx_pkt_spi(struct mse102x_net *mse)
 {
 	struct sk_buff *skb;
 	unsigned int rxalign;
@@ -324,7 +324,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse=
)
 		mse102x_tx_cmd_spi(mse, CMD_CTR);
 		ret =3D mse102x_rx_cmd_spi(mse, (u8 *)&rx);
 		if (ret)
-			return;
+			return IRQ_NONE;
=20
 		cmd_resp =3D be16_to_cpu(rx);
 		if ((cmd_resp & CMD_MASK) !=3D CMD_RTS) {
@@ -357,7 +357,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse=
)
 	rxalign =3D ALIGN(rxlen + DET_SOF_LEN + DET_DFT_LEN, 4);
 	skb =3D netdev_alloc_skb_ip_align(mse->ndev, rxalign);
 	if (!skb)
-		return;
+		return IRQ_NONE;
=20
 	/* 2 bytes Start of frame (before ethernet header)
 	 * 2 bytes Data frame tail (after ethernet frame)
@@ -367,7 +367,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse=
)
 	if (mse102x_rx_frame_spi(mse, rxpkt, rxlen, drop)) {
 		mse->ndev->stats.rx_errors++;
 		dev_kfree_skb(skb);
-		return;
+		return IRQ_HANDLED;
 	}
=20
 	if (netif_msg_pktdata(mse))
@@ -378,6 +378,8 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse=
)
=20
 	mse->ndev->stats.rx_packets++;
 	mse->ndev->stats.rx_bytes +=3D rxlen;
+
+	return IRQ_HANDLED;
 }
=20
 static int mse102x_tx_pkt_spi(struct mse102x_net *mse, struct sk_buff *tx=
b,
@@ -509,12 +511,13 @@ static irqreturn_t mse102x_irq(int irq, void *_mse)
 {
 	struct mse102x_net *mse =3D _mse;
 	struct mse102x_net_spi *mses =3D to_mse102x_spi(mse);
+	irqreturn_t ret;
=20
 	mutex_lock(&mses->lock);
-	mse102x_rx_pkt_spi(mse);
+	ret =3D mse102x_rx_pkt_spi(mse);
 	mutex_unlock(&mses->lock);
=20
-	return IRQ_HANDLED;
+	return ret;
 }
=20
 static int mse102x_net_open(struct net_device *ndev)
=2D-=20
2.34.1


