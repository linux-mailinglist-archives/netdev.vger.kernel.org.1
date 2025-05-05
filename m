Return-Path: <netdev+bounces-187739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0BBAA95AD
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8A816A84D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 14:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576A425C836;
	Mon,  5 May 2025 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="OG+fLVjr"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376BF25C713;
	Mon,  5 May 2025 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455095; cv=none; b=eHefv4u72BLpgQ8IhHiUw7EqTqDP2dB73fAcZAvA291A8xlOe6wLf36qKpfVCJETcbSQ1wg/HgGFnbwZgpMbxLd9GPNW3a027yuGdkXBqNhF6eVC5xlRPF4LDFknjSZF83WemATsU3kL/DtE4LTCdKMr3nBp1P9Q5pRX2IfbzkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455095; c=relaxed/simple;
	bh=htqO1Run8pY7RltG3aOurOQe8uNjb32JudFR5O5BdX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MtQGeYHKG/Lbn7rFnYDx4gF2SD4pCkxzimY1f28xwz6t3a9Uovhl9SO/fgHLyItZSvlt+/pfPul4zS0AWWrsfan9wqyf3Rw9z4BqzHss1sXaQcZBTgbYTdWDfLSlqZTNnk8rlxyX7s9Hu17IaFSsnY3TLckZyibLvHwfvaKVuHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=OG+fLVjr; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746455088; x=1747059888; i=wahrenst@gmx.net;
	bh=FnJr2wI1hn/yDB2M9hi2HWCOyB2w21rn33+r9rXVn/8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OG+fLVjrf4ige8dk878CnykaecLzWyysnTIe9/ageSGV0p9wCV7uoYa0/0zsbMD+
	 30vVzxHlh+8KWblupRzc/wa2dhk2PHyIBRqyUgP3F8WuB9M+2I1Z46Iu4mrPcvybc
	 jKZMcrp7eTA6j/CytYJTM81W/i8hSwSDq60TX2sE5ugFk+73NO2mCF/Jji2mPsBwg
	 bOARStFTnGE3ynN5nvORLEWDjI0B7ejovXglqmTdif8c0rUcghiC6FwCS66a6Oczv
	 aHFUTPcP0GQvRrdRTiB5HSxMOMiPUI/gl5Zx1uH0TYcvooBvMVR+6/UUY41Zio/ci
	 J26FKc+ub1zHBcDoTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjS9C-1usBFS1sSI-00Zoj6; Mon, 05
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
Subject: [PATCH net-next 5/5] net: vertexcom: mse102x: Simplify mse102x_rx_pkt_spi
Date: Mon,  5 May 2025 16:24:27 +0200
Message-Id: <20250505142427.9601-6-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:zjyDOn2Fu1hIWG5ryUyFBSuUbfWDrD8H7XPAcqIjE5/e+QY/DH/
 R1jAh1V/WZf4On8cUkwvduhmgKCDOAoDLQmMr2clYJc9juDNYTLWo2Nq2o/gVcXC8+4pxZa
 zOcANEOctgUzAdxFVLVWhuJrfSVYl9I1oB+WeqlY+E+Js+XQM4QTDSUVfAftqo73bhbd/Gd
 06qK12JzVW2THb6FoHXiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZKSDHO9A30M=;2tO8DSvFHnJbzQ9YumRQ4d6NivD
 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
 srH2gQ1eIkkDY=

The function mse102x_rx_pkt_spi is used in two cases:
* initial polling to re-arm interrupt
* level based interrupt handler

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
index aeef144d0051..a474ceb77ece 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -312,31 +312,20 @@ static irqreturn_t mse102x_rx_pkt_spi(struct mse102x=
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
@@ -558,7 +547,8 @@ static int mse102x_net_open(struct net_device *ndev)
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


