Return-Path: <netdev+bounces-189233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC36AB12EE
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D2B4E0E4E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1DC290D89;
	Fri,  9 May 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="g4ISw/gw"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8C328FFED;
	Fri,  9 May 2025 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792295; cv=none; b=mdW8nNp455RXETrON71bDFacvxbj0uQZVyAkXWMDkQSUXCwis/GvvNEJENYkNOTsfVlT5P2waFx/BOSgNaJ/M2e279nqgRvMzrrjN+/xYHzdDqqtRW5MXcWpaQL9E5+7QMJYthZnXtwqubSOajZLEzBUlp9BhL7JTKst8cC/1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792295; c=relaxed/simple;
	bh=szttWa0JPEC+JvhU8cBYMvI//h7+JuD+0EvoFmpegX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cxe60EnVmBSkUd5Oqsi+/WO+W3NyXxByv7uc/vrogjm43KT5UJITQq0hgOckFKFGf3knebw2QISNyWU4gs1NaEF/lFG5HzVrrI8eskyHGeeKTc1GiyKcO/yd2wDYAVmFPSTdCpzQHjTE1EtrEYfN/Sf0IVcnEnMSRdYU+Bd3ugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=g4ISw/gw; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746792283; x=1747397083; i=wahrenst@gmx.net;
	bh=r8QbWdy35aMAZoLD6+7Ut+Lr+Nax9SROXt4VZiabsgI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g4ISw/gwBTPpoGSbaSnFG/WvzGZ7gNTHTkFM2a7hsEFGvyXHovcUIE1TvRyD/FZg
	 zEiJtWACVo8AFxTe1j3w2WCXatjPqdpOqSsCeHq3i8NIiRU1FclfiidgzS7DUa7tW
	 k0sNf/68DjdQwJNPdHkXeyn/NVRinY9k2jbd3pBBP8gw5HvMy01dKeIW5jHbXABHt
	 8fURGHPoclN4h7zhg1QNDZgfOAf1A4dyE+0GYG5xXRiulvvzF9BtTy7dmYRozJk2O
	 daui+JuhZPx7aP6tFROBkuEr8ZMbiRfaA46xwJ4YmXCeggDXOjPW9cDOQUovwXYiJ
	 oLg7+FE5TCXFyycqpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1po0-1uB9Xf1V6W-004ibi; Fri, 09
 May 2025 14:04:43 +0200
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
Subject: [PATCH net-next V3 5/6] net: vertexcom: mse102x: Return code for mse102x_rx_pkt_spi
Date: Fri,  9 May 2025 14:04:34 +0200
Message-Id: <20250509120435.43646-6-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509120435.43646-1-wahrenst@gmx.net>
References: <20250509120435.43646-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lb5J0EIxQlseo6zBGKuABoB1jiI8Hy7xsqstIqbRMix+NQRdyCO
 RdwJ/jKS8at3aB9qYnpHNu4Q/WAwpiM7YITrcbLcRfexgjke29oJDTx/HCS28oMxbY8uf4z
 Tt+pXe7WAdza6znRiTXu5vXyh3cjIfDdEKNJCK/1wKvBTYhpXsbLXYG6+CEqnP1MMysu78O
 pPip2tin8NPkiJ43gdZzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yiTRsPEGlDk=;7flghkuaIp1uZmsLs+AR8fnMKNl
 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
 V8h+Ip7Z3b1RJSTOpB7OJWbFq

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


