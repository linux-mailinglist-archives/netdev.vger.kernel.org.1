Return-Path: <netdev+bounces-189232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E526AB12F4
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31635B25AAE
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDF7290BCA;
	Fri,  9 May 2025 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="C7MGWXLg"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C628FFF0;
	Fri,  9 May 2025 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792294; cv=none; b=OZSq48hfscV1kmr8Ru7/LXid9y+nAdY0U3e+2KU5gFix8hkutPbpj4jEoyhf+JCbOBh8NYxdB/zclmNHIlhdlBtny2zvl1e6Ol0APjCUt+7a6LpX+5RRsQyBrVeQdJgeHoKH+S9ICbIavGB5KjWYlgtG5Xqvk9MdJXa08ERtftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792294; c=relaxed/simple;
	bh=RCzYpOSOm3P4uj017x38pJsarOVoBUB5ZLnKNvSzP+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BmJkLOSrlEPx3GVtij7aYbP1OL1FkKPl8UV1BC49ifnR3UvV4SPMavWFVUEkfL5gwAETfYglJdD0dQ2wGsX1Adbf9VVY935qqRHtXaty2ZuLNWTE28hveJC2h0ISM8xrPwcXntWpsJlTDHWe9ae25To+EyuXq3/pJ8AaVA76jI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=C7MGWXLg; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746792284; x=1747397084; i=wahrenst@gmx.net;
	bh=rHAj/pKMFTIgfjx9y/7rawKMeW4UkOy9QjmmIK9vroE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=C7MGWXLg6C8aWWQInENBa/pjSXbDEGvKYfLLh0BTkYqfElC/e86Gl1Al8puHw8Ai
	 YWhAqGYpn5h+JeWyxkzkNPH3X1sYGFigboiT3ydBQX6C/7nxZDxkwmyub/tNVP0XR
	 Gx9SMzzKlflzROa77o0bdaV3Qw26XQLD+dp7zcnhRU8p8NlYp9GcLnwqxlD8y2yIc
	 lwDVEeKK5/zt41F8wdFGir0EJ7KXGKjcYalrGJ7zjmrOiNHJdx9hrHfcXjvXaqz9f
	 U4yIt3tI13ytY+P0J6p+W8niF7AJQKJrNEi5eISzWdT17LmfuC6mXP8SsOIpufL9F
	 A7E29cXqvSy0ZUV26Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCtj-1ulacm3Ad5-00hcnV; Fri, 09
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
Subject: [PATCH net-next V3 6/6] net: vertexcom: mse102x: Simplify mse102x_rx_pkt_spi
Date: Fri,  9 May 2025 14:04:35 +0200
Message-Id: <20250509120435.43646-7-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:Ib3YE4K3nD77XeeOei2/uX25RE2Tn6WbyuMTGibDeS84ah9CSYu
 YoS5z69ZAKI61IL7S3EUgHCjpsGTmsJrFLg7mc6O9gR51UZ86QsX5KxnkvFR5xMOJt6GgLE
 QtOrOIhcZOkeXe/HJVyBHB205zkVmP+EEa4oz9kFn3xNathngXaPqR2fJ9TAdpsCq8bGD1N
 vTAJxm8C/XeBKXSQvoXBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qo2mRtbOZLI=;lHpPw9zOtNmPJlo5wQYqY2u71By
 modAqbGSUehwF/oVa/4cbymXwIdM4ETUY3ehL8tGtOgcbNw9NNQ7Qop/im0aZsE4HzCU4QW5V
 M/30wrBLStpSSdKBuHK693PxS6BO5FH3azfXC2MKMcrvkiv1t5EpzbLHAm9qM/V9rH4PkpTTL
 KwruywsxMr4w39m7JgWblomRGCXzBpvbGhtsodjgV/p9bETdL7BI9mlIxPLEZFmJ0oO5npuIK
 fIADGoDBSEn8JdJVdIsehrck/KKDKBYUS2fY2pftYWGfF0GoJKS+UBVWjwAYdevqne/5DKWhH
 VxQfBfhGlJuHf5YcV4o9EkDaNiPpIoGr2DkPKbkdZiDKwgifX8pqJZMTmwui6BUwf3pudj757
 esmzJagzkg5coJ7Ku20GM1pw0FKsgZFzD6RfvEp86ek1BMXTrIL8oW5yCbb+p8OMsdfg1r8nr
 ZgNsEZn8m9NcSJ7qeVUgy+tItR/P2vXtO/9xyIXFvnLM7m++a5vYVCgw4Ejqhuugqu8CwMcZt
 0/4SNooLNRtdm0jXQmsAPDW1Bh2ba6SK385byaTNykVLQpyp/6KBXlYwjsbk+sDdgFjJDDmkK
 kh2Gk4RFX1uD+K4DgNvNRh7pcsM291iQ1EWD578Zv80rvcTy8VpAnAYsnrNKM4bonwQX7kT55
 t3TUsK2fFiUz0OTJytWJ63ebdIsufdwEmHbkoZb1h378uUmQQ/vy2ycRUp4/U3GYlQ40z7ggP
 V0/ZVUtJCAajDE80iRuuiyxTaogCh+EDFl3w/iB2YUsGxPJn1DKZm88xxuPObX1Rjf1ChavFI
 BIE/PcphcVGaYkAL3pxSQTLYzygh1/cjBVcPdnpbboLT+Yy5KXVJVmYQruNuM8omGIQwJDSGQ
 YEXpYsIHoVBvnWgShZj3Qv2iIRGT7hadWLQ82Kwnb+SxW2+88Lgmm1r8sQlwRDiw9JFpP8LAR
 fqOB02o+wlVLNOTVC2lMvrEIP0NLlfnNGXtnDOngy3PXtMd53ZbsVWJ6IoqTd43Q5XmQo8z/I
 Nb6B6AqP38rPO7DE1ABUkxFonqY4zcE8caH+/yiEoqBEVcjvScPSMDvAtUfxeWl4TslA1p9Xt
 VLzsuhZh76T+l7K7YrdMcML8gnNbffSqCgVaqwARx0FHbpgri6As8NRbc3tZmNBTchgx9vvfG
 Zy4FYpGIc6qdxzGmbOp38u0ZDaV3anqPFlTLMf6/icMz7fal/rzaaOa16dBfY+qd4XC9G5+xG
 7ItFaPgF3GFZPyjn8na62+1TPXvyvTp7XAd2G0Kt16MSGa07QEESsETuyjB7sWxRbcs+RIXuM
 UQZtyszOUKzoKeZncv5gmQo4B2rM+ORzDzXvWTQko7fO6Js6A2BdgVCJzcMVgGF/YKRjpockJ
 sVVqcQ2Bw9meFtbvLhbTG7YDqLKkVrCZmfNjv1twUlDacHidkMLNzClkgvr+MFMETF8uxlESj
 zZCGAcccqCJPK7/O6ApKYhrxYgys+48xj3Eb9oeooRpL2lfZ0zr4Y/wFRLn0lRb0LnaR3kLT3
 ZtMNu+Q1G5pZAZYE8C/9Tbx4Z2HZjosbrZuvdNMwxfHFxrhMpJKo/1X2OEQ9iLo6QGWiDMewZ
 YodOs0Fwe+9R4fBjjwAJ7hH8v6yo6q22jSa1qbKQpWJDj+IuSXtn1oUz+jxI6GPXyMTe+wkAX
 h3ME+Ny9XAm8QptsSMf3mOAc0M5BNpKZc0IiLeMzEm6t+93sjN+9QPSy+Bbv6YmVL6/sYa5iP
 tLabhz2hksxqy44pCNNd7Jk5kQ+iAVjrogfJfFMoQw5RAlDWkLC+eBY3qhglwRaJvm1oKWpKP
 ItvkbBdzeYOefvMzT3RG2raiOpntLvURlz0etPAn7WPYnRa+fY6+f//QrjWSdNNhitQ0ttmE0
 25DfLXNvLEj+GjvrJHaB6MDBIpSQpC/h58VOPiSNRecYdeZGWjbb7yXhfZNmNw6AfATMVrq3E
 7F/EXR6zl+p/mb5kzhOtX8T+NySc3aUPPqoQRy1NqwB+WQcqPY1d+483y3pb0lO3YibbIxLyi
 oSeW+umqpzCsyMqcevbnFsZAA0ZHgb0pBM1m4B953otExErfQNBsSJyiumekQ4Aa25EC4GG1m
 tucdA9N3K+9DFXbkIAVXe/UoadNUNQAlKaOlHUXqG/SHPmGPAywh7dbYXIamozYDJEf8eZDtP
 EBjWrr7fJAM96CSHuQTy5GAIrLQqC2IkOHEjmv8kQvQemV6hT7yIleDwBy4c+/GFFfMXWSNuf
 9Ebhpmih0r+/0PPTtwVJvDQjkYw2kPiG90W8yrfaHujf98x4uYA3gpjDz+jLbSRlFi5E4olM2
 puk1zNhcBuvKVV4FhMzljgCiMriNmox39E11mHnGHHqfZf1a+uRt7VPzFah780h+Fx5eBYmnk
 bpWreVSt/9hq3q41Hrgp3DIEYa7qiwjCeiSHaSxc0PUgX7jcaIKzMd3UEhasgLh7XJY9Q/8Av
 ERHHLr2jgsY0+flNV2ndqkVSipxEG2CPqvalXdVh73I8E9zBfj8TzBNPx4HRvg/y4MI3Lq3kv
 Xlov17FPNW9ZYVS+TG1sxUvj3g/orbI0tCDwGcADKH4LnvZTZ6kManxC3uPDfrYY449XWVhXM
 M+HpT1286IZnuOIDd+6rjAR+dU+Yy0vWIg0OBqx5XIJo/HXoO7QAu3WYb6wORLRLd84HO1iDf
 fxgVKdm1S5gywrMBVg/iwefJhGE7DgFhcoxsm+qxTBc/mXx3eqp6j295EkrsnMjG2OhpO6sZB
 dWTgvyQJQAg1e0q13yCWJElnSQPrBPaYdLKPko3Y6YHQE4LCnu+fMcVi2h9nhho070/wY9MQv
 97USurKsy626L+fTf/2WudDYW7j2yqxK668WjCvg2t/2k9QAG0rODVluLlhWdwgPOciGq4AFz
 RKEme7Mf4yrPn+DuJCdOWcPaYGytyU4iJlyJjIovsFKN/wuLF+5qHmL4M5d23JcOe7h0rKrRT
 0LG4EZbb/RvwfRCC8GpbKBPQzNK3BeQ5t8har9KM3JsNgY4ufMahnTN5x0mavlQajOvTbUviv
 Chx1hCDyimsy6l8ajjVFtlrfDfHZQy6S+yefJuOKqYYbAtXzFcmxvzNBvqEj4BTylQBsJOSla
 jgysfjyq9IizA8rBE4kNiex1eHBZcoNLi0x0SAxVNHL1A5NrkYDbFuLngOBa/xVRQTK43oPlb
 kwolo3QYZg5BZiL0mkNsiWlpE

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


