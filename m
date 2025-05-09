Return-Path: <netdev+bounces-189223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472F3AB12CF
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D913A786F
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E4128ECE9;
	Fri,  9 May 2025 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="HcS9NxBI"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9422129F;
	Fri,  9 May 2025 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792095; cv=none; b=OGlCdXAf2yx1uiKcIf3lyseAK1plPoTiH+g/rcOCXewgrw2ZUs6LmQetnBeAt4s9+pbDC0MEhatzseJvTyynvwoTZuNNGSjkLepBoOuKAe81nZ068yIggjL7FjTyr3Ib9PdA6L5MOa77TMSO3cOJ7nZYBtv6o+Ui9Qx362faPDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792095; c=relaxed/simple;
	bh=szttWa0JPEC+JvhU8cBYMvI//h7+JuD+0EvoFmpegX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tzb+tWlNVWTf+CYdQaMf0Myuj5Cjo97ZSjoZXhumF8wM7S5+ToUlq3J+9Pa3bJvEx+sLcX/mEZ/g0GLAJgefr0A01MMFJtSe4YOtDgq0wKr6T7OPwdoloszJo19aP/ZKkd7BRPzrHPtju1YLvmj9/92d9PDmTlp+7ZQKyj2lcww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=HcS9NxBI; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746792091; x=1747396891; i=wahrenst@gmx.net;
	bh=r8QbWdy35aMAZoLD6+7Ut+Lr+Nax9SROXt4VZiabsgI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HcS9NxBILA65f4jTQYU7m29DNSLtTXt6Cm42MjwxLvDaTyPBGxKsgayhWigQczAr
	 ynMMF1KWcZRr/B1rBVz1ZQ3n4JfOrzS4W/YeSt1WYrRcr/j9HtFcrfxhuuFoVs2GS
	 /NYgbUE+aoSYsjK0IF18WCe1DqmP4KNLl+jzKL9MMQ0LYDrb/EYgjMoU9U2M3rpr1
	 rKXnpY5c2+RptSk6p8vZvPCizL/qteW/mVQGaxPNkxI1RDxocjSoaf5Kt+LuENp6M
	 23jev6+1wTZQawAMOpG08xi5xHOA6KCipW07kiCHXTi4XE7ufqf5ExSallu0rFKYg
	 Wl0CnbXWMYjHbaOTPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJZO-1uhTu02bP4-00qNhU; Fri, 09
 May 2025 14:01:30 +0200
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
Subject: [PATCH net-next V2 5/6] net: vertexcom: mse102x: Return code for mse102x_rx_pkt_spi
Date: Fri,  9 May 2025 14:01:16 +0200
Message-Id: <20250509120117.43318-6-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509120117.43318-1-wahrenst@gmx.net>
References: <20250509120117.43318-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FOEqY1ScwkYx/a/OJHymdUA/IRmwABt6lWHtPNSucubxI+gq5qT
 0MWnw1nxnBQxUQI7lihXn8eZPal6/JfrQpHN+0ldFbaNgWBImgJgk+cEyOL0EDKkYDt9oLf
 J2oaflvu3ctodVyjEoiMXwyz5PLTDuhjQxt1yeYWVKAMXu7ZyH3JgtPBGeTBitQRbkKf3vh
 vGpWQN3yCncJkTJeuAdKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XJxSL87oAYk=;EyODfAD7uHm/+O53xjD5OeDhHc+
 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
 zspeejd3jmUfvZDMj7ZM1/YWA

The MSE102x doesn't provide any interrupt register, so the only way
to handle the level interrupt is to fetch the whole packet from
the MSE102x internal buffer via SPI. So in cases the interrupt
handler fails to do this, it should return IRQ_NONE. This allows
the core to disable the interrupt in case the issue persists
and prevent an interrupt storm.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index c2b8df604238..62219fd818f5 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -310,7 +310,7 @@ static void mse102x_dump_packet(const char *msg, int l=
en, const char *data)
 		       data, len, true);
 }
=20
-static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
+static irqreturn_t mse102x_rx_pkt_spi(struct mse102x_net *mse)
 {
 	struct sk_buff *skb;
 	unsigned int rxalign;
@@ -331,7 +331,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse=
)
 		mse102x_tx_cmd_spi(mse, CMD_CTR);
 		ret =3D mse102x_rx_cmd_spi(mse, (u8 *)&rx);
 		if (ret)
-			return;
+			return IRQ_NONE;
=20
 		cmd_resp =3D be16_to_cpu(rx);
 		if ((cmd_resp & CMD_MASK) !=3D CMD_RTS) {
@@ -364,7 +364,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse=
)
 	rxalign =3D ALIGN(rxlen + DET_SOF_LEN + DET_DFT_LEN, 4);
 	skb =3D netdev_alloc_skb_ip_align(mse->ndev, rxalign);
 	if (!skb)
-		return;
+		return IRQ_NONE;
=20
 	/* 2 bytes Start of frame (before ethernet header)
 	 * 2 bytes Data frame tail (after ethernet frame)
@@ -374,7 +374,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse=
)
 	if (mse102x_rx_frame_spi(mse, rxpkt, rxlen, drop)) {
 		mse->ndev->stats.rx_errors++;
 		dev_kfree_skb(skb);
-		return;
+		return IRQ_HANDLED;
 	}
=20
 	if (netif_msg_pktdata(mse))
@@ -385,6 +385,8 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse=
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
@@ -516,12 +518,13 @@ static irqreturn_t mse102x_irq(int irq, void *_mse)
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


