Return-Path: <netdev+bounces-187079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59441AA4D83
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F1F16ED76
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 13:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B06525CC48;
	Wed, 30 Apr 2025 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="XivsB4Zq"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41327462;
	Wed, 30 Apr 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019858; cv=none; b=LMraKIAoE7bpo8pIxXJtlauU65Xy8Lj9TEClGFYm6jppROlc0TdsbPMqjAY7rzCfniS51eZuI80JJ1DAh3U4Q0mgDu32HH+cpJETaH8EFGa8c1RR+UAfoIeykMKzQIoIeloX+LDezdeXQdIPI6NZj+zfTHP1TDAW7Pgy1Rubt/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019858; c=relaxed/simple;
	bh=QwEV+u9FXS9n54L9RlduPFF8NSmQ57lB3GnXU59/KQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q4RNPQ0NDFrQbW+YPgdOx43iHKdhjLtThUQzO2BNavkOAZkpbDoso0+0GlpS/GyBBUihh4NEt+1Bo8ozRfLJSS9nKlmG8OM1BFozVu88LOBrAQeMx+wIBGXvPqSkeSx4vzYDZXhK2yPQngYy5iTPZ5bL1fGcIYG5D8DXdJytImg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=XivsB4Zq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746019853; x=1746624653; i=wahrenst@gmx.net;
	bh=PYnlupRimACw2/kv0FtWV3dC3rRtzmfhKvztySLxGEc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XivsB4ZqC3BMB1TQWcs1P7A1+OU9u9cwcs7uTc2zK9eb08LgHPS7zn+PcCZxz7f5
	 aBFwJ6za8Sc6RlE7CBTQdvbkBN+ZlUgrgDO5u/2SnqVI9ZHVbBXnqWz6fM9fJdu22
	 bvzi7D6rlk95VX19rp5HhWrvYkj7+HDEWHbwdqgCr9G5XhaZXK5iOUBZfHEmkhAKi
	 5fRSlJHxBt7BRVxIz7+LYDrEUlTtTNSA5A0qI4ovGo9lkUgFyI/E/CAMVvMaI5gUV
	 Sh3Nz7KltkvKBYsGaJgk/k4jIQJibCHARUew9vrPwfSrMaXvkhZFrS3Vxi8TM6t4F
	 1Dpb+J4OO28dzpT03Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXtY-1uaYNJ2JwO-00Jwli; Wed, 30
 Apr 2025 15:30:53 +0200
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
Subject: [PATCH net V2 4/4] net: vertexcom: mse102x: Fix RX error handling
Date: Wed, 30 Apr 2025 15:30:43 +0200
Message-Id: <20250430133043.7722-5-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430133043.7722-1-wahrenst@gmx.net>
References: <20250430133043.7722-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t8DV6d/nz46CSEymPixL9syFiDUsMhHpnLn1PfrvRRX5yyDSlAV
 3N8+8yFAF+m3fGa/9zse3nJcpQYMW1e5SPOC/OJSMr5RSsdxK0/3Zfb50LNaI9XuhZTTWaa
 b7/Cn3U4IOAuFxtBXJUtQ+Ltcd/7zUm3V1pfA11Z1Uxnhli8iONcJxSxmTpJmK67k1SfV1z
 Ok/Dqj1tKVvcyxHjjpTRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2UGKZ4RsNQc=;ObLmbBSt28qhsnTysH8/VSIqGeI
 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

In case the CMD_RTS got corrupted by interferences, the MSE102x
doesn't allow a retransmission of the command. Instead the Ethernet
frame must be shifted out of the SPI FIFO. Since the actual length is
unknown, assume the maximum possible value.

Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 2c06d1d05164..e4d993f31374 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -263,7 +263,7 @@ static int mse102x_tx_frame_spi(struct mse102x_net *ms=
e, struct sk_buff *txp,
 }
=20
 static int mse102x_rx_frame_spi(struct mse102x_net *mse, u8 *buff,
-				unsigned int frame_len)
+				unsigned int frame_len, bool drop)
 {
 	struct mse102x_net_spi *mses =3D to_mse102x_spi(mse);
 	struct spi_transfer *xfer =3D &mses->spi_xfer;
@@ -281,6 +281,9 @@ static int mse102x_rx_frame_spi(struct mse102x_net *ms=
e, u8 *buff,
 		netdev_err(mse->ndev, "%s: spi_sync() failed: %d\n",
 			   __func__, ret);
 		mse->stats.xfer_err++;
+	} else if (drop) {
+		netdev_dbg(mse->ndev, "%s: Drop frame\n", __func__);
+		ret =3D -EINVAL;
 	} else if (*sof !=3D cpu_to_be16(DET_SOF)) {
 		netdev_dbg(mse->ndev, "%s: SPI start of frame is invalid (0x%04x)\n",
 			   __func__, *sof);
@@ -308,6 +311,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse=
)
 	struct sk_buff *skb;
 	unsigned int rxalign;
 	unsigned int rxlen;
+	bool drop =3D false;
 	__be16 rx =3D 0;
 	u16 cmd_resp;
 	u8 *rxpkt;
@@ -330,7 +334,8 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse=
)
 			net_dbg_ratelimited("%s: Unexpected response (0x%04x)\n",
 					    __func__, cmd_resp);
 			mse->stats.invalid_rts++;
-			return;
+			drop =3D true;
+			goto drop;
 		}
=20
 		net_dbg_ratelimited("%s: Unexpected response to first CMD\n",
@@ -342,9 +347,16 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *ms=
e)
 		net_dbg_ratelimited("%s: Invalid frame length: %d\n", __func__,
 				    rxlen);
 		mse->stats.invalid_len++;
-		return;
+		drop =3D true;
 	}
=20
+	/* In case of a invalid CMD_RTS, the frame must be consumed anyway.
+	 * So assume the maximum possible frame length.
+	 */
+drop:
+	if (drop)
+		rxlen =3D VLAN_ETH_FRAME_LEN;
+
 	rxalign =3D ALIGN(rxlen + DET_SOF_LEN + DET_DFT_LEN, 4);
 	skb =3D netdev_alloc_skb_ip_align(mse->ndev, rxalign);
 	if (!skb)
@@ -355,7 +367,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse=
)
 	 * They are copied, but ignored.
 	 */
 	rxpkt =3D skb_put(skb, rxlen) - DET_SOF_LEN;
-	if (mse102x_rx_frame_spi(mse, rxpkt, rxlen)) {
+	if (mse102x_rx_frame_spi(mse, rxpkt, rxlen, drop)) {
 		mse->ndev->stats.rx_errors++;
 		dev_kfree_skb(skb);
 		return;
=2D-=20
2.34.1


