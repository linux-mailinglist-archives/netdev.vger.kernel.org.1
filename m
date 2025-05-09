Return-Path: <netdev+bounces-189225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB572AB12D2
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19C37B24F28
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDB02900BE;
	Fri,  9 May 2025 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="oABagOuj"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E322129F;
	Fri,  9 May 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792098; cv=none; b=Yis0Hn0cs/CMw1HND/rqexGezD2q/K/50wmwGZok6mb1zA0f+nccHSinRRW6mXLln3fZTwwE20zvb7AFKR9Stp/yFeLsDpAF4CKUVB/0TjgN5MqtRARoJGEVEkz3cNfx1JF6qj9/4AsAkwFmyLXcCWnQETSWupOvsnio9hEbHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792098; c=relaxed/simple;
	bh=RCzYpOSOm3P4uj017x38pJsarOVoBUB5ZLnKNvSzP+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bGiA482JnwhMv013AOqWxC0Pxh961ZASCPy4tqpf60mSJEUN4gnhfR2c9pGGkbb76TSHhqyYRP+0cfUweYtcxF42Nhg35J8nKAjyqhsoRT0iweCGJEkikoZUYhqrdjaN6506qjZEfWmD4/GN+gSAeKltOeME06nE8DO/0izthww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=oABagOuj; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746792091; x=1747396891; i=wahrenst@gmx.net;
	bh=rHAj/pKMFTIgfjx9y/7rawKMeW4UkOy9QjmmIK9vroE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oABagOuj3SAeUiK0kiuRbkYpeXlfhtoNkUh2nILljSqbKgQxaFXXP3yW2iOSs7s6
	 Piw8pji9N4hyLHmZasUF6Ai36jC+SnT3jn8ngCMcH89w+p9SOaHvGKF5yzhzWZk/D
	 JcQ1oieYZJS2uMT3Qat2Dx3ulj33sJ/nRZCPam3c00dsVdANPIoL2VUd5lVqSmtRt
	 wSrKJJ1lJzDLsBf0AQWT0mJyWU35sLF5HtCDledRfp14TDKd1iOy7fs0BeEAJ7hbj
	 mGts6Eh3blZbf5Tfh9yvOsHJzJZRrvZ0PojKxRC5amlZY0KisqXAntpTe6A3OglM2
	 QYD1UxWB+DJRUz66KQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbVu-1uEyiS44sw-006HO8; Fri, 09
 May 2025 14:01:31 +0200
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
Subject: [PATCH net-next V2 6/6] net: vertexcom: mse102x: Simplify mse102x_rx_pkt_spi
Date: Fri,  9 May 2025 14:01:17 +0200
Message-Id: <20250509120117.43318-7-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:oirQZNQW9Ij5GKnNZR8QEUX8jiWE1kg9RvYOqHNLNh0EylNTuTF
 VomE+BehiXbqnvUzlIpQpdahUDg9CrzU9w8TAe6lQFdeefytVxYsgvYF11XoaQsfD81jG/g
 LWcTdzeV11LH87fC0M1z4KNQCe+t2yjYF/39Q2GJJah9hDI1oaZcM3uAPutKqAgR6zCQrYI
 uG/KET5si5faYrLfY0f2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xxq6qlOb+xg=;W/Oq05AryYNnChS8/OSYjErs1id
 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
 JoMd60sIHMUT5YRBf/TGA2IQe

The function mse102x_rx_pkt_spi is used in two cases:
* initial polling to re-arm RX interrupt
* level based RX interrupt handler

Both of them doesn't need an open-coded retry mechanism.
In the first case the function can be called again, if the return code
is IRQ_NONE. This keeps the error behavior during netdev open.

In the second case the proper retry would be handled implicit by
the SPI interrupt. So drop the retry code and simplify the receive path.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 34 +++++++++---------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 62219fd818f5..873da57a1d6b 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -319,31 +319,20 @@ static irqreturn_t mse102x_rx_pkt_spi(struct mse102x=
_net *mse)
 	__be16 rx =3D 0;
 	u16 cmd_resp;
 	u8 *rxpkt;
-	int ret;
=20
 	mse102x_tx_cmd_spi(mse, CMD_CTR);
-	ret =3D mse102x_rx_cmd_spi(mse, (u8 *)&rx);
-	cmd_resp =3D be16_to_cpu(rx);
-
-	if (ret || ((cmd_resp & CMD_MASK) !=3D CMD_RTS)) {
+	if (mse102x_rx_cmd_spi(mse, (u8 *)&rx)) {
 		usleep_range(50, 100);
+		return IRQ_NONE;
+	}
=20
-		mse102x_tx_cmd_spi(mse, CMD_CTR);
-		ret =3D mse102x_rx_cmd_spi(mse, (u8 *)&rx);
-		if (ret)
-			return IRQ_NONE;
-
-		cmd_resp =3D be16_to_cpu(rx);
-		if ((cmd_resp & CMD_MASK) !=3D CMD_RTS) {
-			net_dbg_ratelimited("%s: Unexpected response (0x%04x)\n",
-					    __func__, cmd_resp);
-			mse->stats.invalid_rts++;
-			drop =3D true;
-			goto drop;
-		}
-
-		net_dbg_ratelimited("%s: Unexpected response to first CMD\n",
-				    __func__);
+	cmd_resp =3D be16_to_cpu(rx);
+	if ((cmd_resp & CMD_MASK) !=3D CMD_RTS) {
+		net_dbg_ratelimited("%s: Unexpected response (0x%04x)\n",
+				    __func__, cmd_resp);
+		mse->stats.invalid_rts++;
+		drop =3D true;
+		goto drop;
 	}
=20
 	rxlen =3D cmd_resp & LEN_MASK;
@@ -565,7 +554,8 @@ static int mse102x_net_open(struct net_device *ndev)
 	 * So poll for possible packet(s) to re-arm the interrupt.
 	 */
 	mutex_lock(&mses->lock);
-	mse102x_rx_pkt_spi(mse);
+	if (mse102x_rx_pkt_spi(mse) =3D=3D IRQ_NONE)
+		mse102x_rx_pkt_spi(mse);
 	mutex_unlock(&mses->lock);
=20
 	netif_dbg(mse, ifup, ndev, "network device up\n");
=2D-=20
2.34.1


