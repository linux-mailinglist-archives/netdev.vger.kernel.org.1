Return-Path: <netdev+bounces-187082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 028D5AA4D89
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5751761BA
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 13:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C430525DCF8;
	Wed, 30 Apr 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="pwgRnB0v"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67725DB15;
	Wed, 30 Apr 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019866; cv=none; b=WPBUR+IOmGsLmEa4SuT8AS5ZFFnVj8JJyA94LQZ+BWaPqOyJo7M06rmlXF4pCjHFD/QipreYXm+rgRdCqu6HVmUhNmEGn7yVHLUHoVUZU5+xdXTYfFqQfPwyLLSje02Ucxes3/zRwyMuLeOBIXnk4/4csWvwHLF07BIInoFsnNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019866; c=relaxed/simple;
	bh=kz7wHMXYRg1i9SS/mmaQ4nhPd4z6LaNk28W6vthp96I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fRlDpTfpI6jcFRyhbxeFKiUzT1o5BQmoaLX0BgzIfEFF6oYuTRdi+rfjW2zGS0ZTFsSB637pSEdlBH/BbWHlTSyJd/eJboKd24f/lUCiaBJZBHe+BPsJ3aHmok4fX61KvCU/RCkp5xQu10ZrPtAO9OKlmq8VB23pc0wzirouwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=pwgRnB0v; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746019852; x=1746624652; i=wahrenst@gmx.net;
	bh=2MjoCdjWH9Ql48xPMUJwZU2qNDaBLPSbRterd/AZBy8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pwgRnB0vyEQ5b1VaobjYLkSv8BQfm1Yw2ItUJuzmTWm9j+4bs4EHvVNdbSTQ4drw
	 JZyR9HORwmb0pikWXYaBXmD/mKj2EtfamD3niB6tGAg5eIX9d2YjffBUO8QM/hIXa
	 KnU2uQ4oaD+WNjQRlendux2/kGaO6aORGlGKbZSH0APvW9kbA6eJreVzm5PQsBTxW
	 NqwkUrfT2IMtRVtrUEKsh+LdwWJMEYqUKa61/QkNjrGFtgFHiUrWjJwt17ACJ6pao
	 DU0FRDbOMBv8fM/fOBj/cZiD/OUVuhXhVfkik07B6PkrTZfdgqAbLDTzeBBPoQxLa
	 /LgXb6GwbZV68KtN5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyyk-1uxHje0f94-017uRc; Wed, 30
 Apr 2025 15:30:52 +0200
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
Subject: [PATCH net V2 1/4] net: vertexcom: mse102x: Fix possible stuck of SPI interrupt
Date: Wed, 30 Apr 2025 15:30:40 +0200
Message-Id: <20250430133043.7722-2-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:6kJKSml1gwUiGtHempJcLxd2UR5m24mppcQBXh8XL/DdTy7b8iL
 wQnhS8aL/ddwg7O04Rpr33jEewHprYtnwIzgCJ/KKgFmTe1HgqYI82TQu9Qz8UDRHl5VPsG
 r5agU5yN7LN3EpPOcTVrTterLI3aIP8jZaE6md0km3lmsJbKZE1laxWD1ojS8nTpFKqnJU0
 OHeZsj/LIhLaBqUSyF1aQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fELKi37Ac2M=;IH+TXyfSUitDVkPZBttdptEncWw
 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
 fJWd8AM+CAXqD8doPbg/UD4p7c4imrCf+D

The MSE102x doesn't provide any SPI commands for interrupt handling.
So in case the interrupt fired before the driver requests the IRQ,
the interrupt will never fire again. In order to fix this always poll
for pending packets after opening the interface.

Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

I'm aware that this might trigger increment of invalid_cmd. Since this
counter is pointless for other reasons, this will be dropped in the
second (upcoming) series which provide further improvements for this
driver.

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 89dc4c401a8d..92ebf1633159 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -509,6 +509,7 @@ static irqreturn_t mse102x_irq(int irq, void *_mse)
 static int mse102x_net_open(struct net_device *ndev)
 {
 	struct mse102x_net *mse =3D netdev_priv(ndev);
+	struct mse102x_net_spi *mses =3D to_mse102x_spi(mse);
 	int ret;
=20
 	ret =3D request_threaded_irq(ndev->irq, NULL, mse102x_irq, IRQF_ONESHOT,
@@ -524,6 +525,13 @@ static int mse102x_net_open(struct net_device *ndev)
=20
 	netif_carrier_on(ndev);
=20
+	/* The SPI interrupt can stuck in case of pending packet(s).
+	 * So poll for possible packet(s) to re-arm the interrupt.
+	 */
+	mutex_lock(&mses->lock);
+	mse102x_rx_pkt_spi(mse);
+	mutex_unlock(&mses->lock);
+
 	netif_dbg(mse, ifup, ndev, "network device up\n");
=20
 	return 0;
=2D-=20
2.34.1


