Return-Path: <netdev+bounces-189231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9FAB12F2
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FAFA043E9
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B415290BB6;
	Fri,  9 May 2025 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="JjbPbZVH"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3F27A925;
	Fri,  9 May 2025 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792294; cv=none; b=VgfVwQSr1L4r0C0slTW0t4q9qJeoBxj7yUwLy+Qt1ZZ8us3h0P270uSVeujr1ofDXiIEvKK0hlt6pwzZHuSOcmE2H0eHPFO4Ip+vkAke054d8l35thzBtYmQOWYqAOIJpSdFpaFsdHZ/jFvsl1qE/cDosBvsLeWNmMLfZlGUR3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792294; c=relaxed/simple;
	bh=DXlb1yQTnHKRCntsXxDNHtVLAFrSWHcArFdBEY2pbIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TAAke3oq95kryj76ZCG50R3MZNHiZyfvxAUGnBIzE4IVLm4wHu2QeP+0Gk7q7Aut/GnPXyyKCsf1D8DYdhcizzTQwD62XLN5e2AwYB4G9iUUHBQxF56htaodpD6bCbN+ShcONBX5RjNhsgMZ4naU9dx0E2JTp0WgHIZyPyF9v58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=JjbPbZVH; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746792282; x=1747397082; i=wahrenst@gmx.net;
	bh=o2ClX6bqKoDyuncls4p4vcndsL4vRhh+9X4jhInKLKw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JjbPbZVHoGgwFO65+wxymSG5dXk63F9r792t/J+uM6fii+wEoZxUTqBq+owOIBEN
	 bSNZ9r1arbOxHC/ougPCY8lCZaL4Wz8rB0Zs8kklQF1G1teH2bxbfbph4+eg0/wkV
	 89lVW0EmDoQS3/XbHOS4e/GGHzzHhiY2Hb5EpEvB3KHXITyYiDiTNIC7oSKZWSsAP
	 9NTUPsmfpyg5OY0QMTaAXGBR+XgGdTu/qmaEgdw7MTqX3HnFZpkSk1vmBm3d6Wy1T
	 /MbhqwnqelxCzYletmGv8I03SUrWEj0UuYhgX+HjmBPIkDpDw/VQmIi5N3wwIlGtg
	 YKSaCykBfa9hFghexA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVNB1-1ucp9J14tD-00Yisf; Fri, 09
 May 2025 14:04:42 +0200
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
	Stefan Wahren <wahrenst@gmx.net>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next V3 2/6] net: vertexcom: mse102x: Add warning about IRQ trigger type
Date: Fri,  9 May 2025 14:04:31 +0200
Message-Id: <20250509120435.43646-3-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:3nvDcPMlwXE7an2IHdleuobfBQu8HLKOHbli5Z7js/B+2GwQflA
 4zWKpq4wS/9gNHPmdq7bwmrV5mxZYjnbfpy5nhKw0cd03sUVHtkYy3SATgDGat2AQ6rjJ1B
 9TAoHtXCncPP0qHRlq0fcELj5K7UlGiqHUjrWavMdo7zKly8vluhg3bI9wAbPZ8g1JVavIE
 kvUizEBgRHVhnRIZVT1YA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oGp3q0/WhjQ=;Hpv/UUzOwAj6OsYglevtCjhXTY2
 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
 W/w2vuXV7c0SOhxT

The example of the initial DT binding of the Vertexcom MSE 102x suggested
a IRQ_TYPE_EDGE_RISING, which is wrong. So warn everyone to fix their
device tree to level based IRQ.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index e4d993f31374..78a50a68c567 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -8,6 +8,7 @@
=20
 #include <linux/if_vlan.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
@@ -522,10 +523,25 @@ static irqreturn_t mse102x_irq(int irq, void *_mse)
=20
 static int mse102x_net_open(struct net_device *ndev)
 {
+	struct irq_data *irq_data =3D irq_get_irq_data(ndev->irq);
 	struct mse102x_net *mse =3D netdev_priv(ndev);
 	struct mse102x_net_spi *mses =3D to_mse102x_spi(mse);
 	int ret;
=20
+	if (!irq_data) {
+		netdev_err(ndev, "Invalid IRQ: %d\n", ndev->irq);
+		return -EINVAL;
+	}
+
+	switch (irqd_get_trigger_type(irq_data)) {
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_LEVEL_LOW:
+		break;
+	default:
+		netdev_warn_once(ndev, "Only IRQ type level recommended, please update =
your device tree firmware.\n");
+		break;
+	}
+
 	ret =3D request_threaded_irq(ndev->irq, NULL, mse102x_irq, IRQF_ONESHOT,
 				   ndev->name, mse);
 	if (ret < 0) {
=2D-=20
2.34.1


