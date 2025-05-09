Return-Path: <netdev+bounces-189224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F4211AB12D1
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75A61883917
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C89290098;
	Fri,  9 May 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="WJnAz4OR"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B735233735;
	Fri,  9 May 2025 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792096; cv=none; b=nmjkS9AwlckDUXkkKlRT2HS/VxyVzpVg1TGNukg+o/Nsr9V8iYEKShJ6bxXnT2lMy+h1Q6icThdxOxX7jsZzTE77e3j29P8t36hI0T+dYnavF337Ld4xugrwdreRJuO9DAfO2RcyFyAIRCanU7W1CR47CJnz56BYV/a5py++hUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792096; c=relaxed/simple;
	bh=DXlb1yQTnHKRCntsXxDNHtVLAFrSWHcArFdBEY2pbIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aF2AsRUlXTeXRfqlAIoenwby/MWQlTG8rEX7W3hL/NZtRb5HDLWODQpu45UQvYpEmUWwVqgRhmDXRlGWewLGkjzdoaUAxHi3rDvxuH1sdX1p4aZn8XV1tqSfnAdp4QyVnSVTh63+FPL9FQrVI9pviaCmQKRBl/ytd7eFNQgVKhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=WJnAz4OR; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746792089; x=1747396889; i=wahrenst@gmx.net;
	bh=o2ClX6bqKoDyuncls4p4vcndsL4vRhh+9X4jhInKLKw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WJnAz4ORpjWAIiGNqJOFmOEcejDOtm0UFV/Ayp8W1SLaY8wuSbicL4DzZpXbpFTu
	 9rg+j6IBcMnWfnCSXKM6b6TgrC/ZPHCuNwe9IzhW4Vf5EVGPeG+KwrFqBwP5mWh4t
	 hl2s268oo90f3zzobRL7SF985VcCycvsHc0uAm//Nom3qcNkUaK1CphF1iz8Kh6fo
	 k8DtetCkg18aHbLhrg6+pJm5X1q/O4PK/pFzdF/h5/anWKgKw/YdA0q33GJKUtWLN
	 efQaSumRlxdG7kZmh+1mzxWwal+PZ85NzxYrhJXAlhKgewDbWE7q9v0lmD/KAx95b
	 aJmMPq6jSdwv6vD9fA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1v6xHY1vbZ-00ynkV; Fri, 09
 May 2025 14:01:29 +0200
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
Subject: [PATCH net-next V2 2/6] net: vertexcom: mse102x: Add warning about IRQ trigger type
Date: Fri,  9 May 2025 14:01:13 +0200
Message-Id: <20250509120117.43318-3-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:a6X3IKbrH5dj+GDVsBC4lT9InV1s0NeH7zXFSIQvvFgbkarKiua
 MplGSKwCNUkNnJEvn7bOy4tQl8lbT7APY4J7UljoCKeU1T6jjUrWS2b5kLp/cAmrIEfM5GC
 9fGuP2LHdoX+f2cQSZicrNQLZjsNgsygePQefyXOyi1F5C8RWY5QMx/OTWs2zFoyyNQjtGw
 dxNM1woBRSc3KkS4pnGFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ECUdX7TK9g4=;sYXIj8hetzGvSFWakUNxGTa2m4h
 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

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


