Return-Path: <netdev+bounces-185007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72353A98173
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A386917B9F1
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 07:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8CD26AABD;
	Wed, 23 Apr 2025 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="dwulbudq"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1183D1A2557;
	Wed, 23 Apr 2025 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394390; cv=none; b=XZzY1ydfN8wLKELI/8OeQsjNt5G4PTnfkuuRoMZ+Wj/70HGrZEf4FfNSDd2AUzvUlVrLVWeoZEPPMNMjjOLLlG33mA3TP1wymNRFfxzYn5h/py+LwPymd6sNmHtzkCm12GCOvyGfJllmnc92Yi98spmVGixhkqnfaLsXskKc85g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394390; c=relaxed/simple;
	bh=QwEV+u9FXS9n54L9RlduPFF8NSmQ57lB3GnXU59/KQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fgWgYtFyFm85hl6owpCn4iQw62EEGIHIQ8OuepTl9/QDVYU1EVzn7tcVQRuVuMc8XFmW11SAwEzEM7+NUGqGkW9cPEfKd5hJbR3+DoZXjk0CSDUP2sjW7k3m1eaDiYqQAHXNG6Zh1/JyxLCFGv5me6lhMzS0McptL8gVQLSWdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=dwulbudq; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1745394380; x=1745999180; i=wahrenst@gmx.net;
	bh=PYnlupRimACw2/kv0FtWV3dC3rRtzmfhKvztySLxGEc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dwulbudqUaAV97YFblv1xglJORwRJl+mxcWhA//+rMpZE7sghTt1wmuBGv5gXUV7
	 wDM+q4hQtGf5jrtfMcUtBxvShXPUIQfpjz7iD8uFAjr8nXi2zjN82jcErCoR+1zV5
	 8PygmO3TnAyuawQjuQGBId8loIQGe/+aX2nw9oMC+jFcC4EkXJbn5CcKuBHWByPvA
	 PIHEeGoe0+kNcL+hbdZDaCa9mqaYZy0dhlPkVtna3YR09QWlZjxtg8uo6yt6Pi+gU
	 M/hzX0jHUxbxpSG8lAU11+Ddp8nt3iqOB7FnFfH/jNdWqCeve3FXI/668GWmZbxBc
	 /JIDMpJULLymgc5jVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FjR-1uDo4Z1NRv-00D8oP; Wed, 23
 Apr 2025 09:46:20 +0200
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
Subject: [PATCH net 5/5] net: vertexcom: mse102x: Fix RX error handling
Date: Wed, 23 Apr 2025 09:45:53 +0200
Message-Id: <20250423074553.8585-6-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423074553.8585-1-wahrenst@gmx.net>
References: <20250423074553.8585-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mg5opcGbcbVJoDFt80kqBKyfhfS3MqDZF7qu6uiBHJSQ1GPrkv5
 NHGM+HSY6stA8RYrYD3W+WdFst0yMEH1mvlwVB5y8T+LRzQLr3wEig4ASQMdlCKXhtyeXVS
 adU5xFdKjiIPRXfxGtrfJyRfJOo65exfPdoopnuV/JsoxNE03FqzaiAQuEsfNlkZ6PLQ6Cy
 nySLABz4xLYT8++3YAPVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eTRAZuTxV/w=;miEO2RS0hwJ+7jIOja3N1mWRuZE
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


