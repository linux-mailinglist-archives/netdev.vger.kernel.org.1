Return-Path: <netdev+bounces-189235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C6AB12F8
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41A9A07535
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCF129116B;
	Fri,  9 May 2025 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="NtvJ3NUF"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E4528FFD8;
	Fri,  9 May 2025 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792298; cv=none; b=nOU5xhzI+JRswJpAB7H7QBM2N9yNuIswRKEHG6O+qrWTapl6aFZ3BxZWv8pvh++gPB/gEBg9Akjo4TNIevcYK0CdSPSoTzca5WUE9RwLR9xktUYnmwwYUEdSEdbyWXFep1uLwBh2DG2qRgP9Z6UDCfIv1z/A7umHUdaKfPSwHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792298; c=relaxed/simple;
	bh=jRz2MZz4EtIr46xsk/4rDF4LuDMDl9lS8vu188fYGKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cK0MxhQS5Ao85NUn3+3Fh2sDLBCinglShn63I0drOjEK8pDW7g1busRAUC+o2SBAARmNCPXDi9E1jPAPkLCoz99O6AiU1/iMtUYgb3j1hbyTOUa1rdPSUkzeGW52K3fUEdp67+OCDyBbLMg5ztac74AsvuLo8kp6h7qWGghQAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=NtvJ3NUF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746792283; x=1747397083; i=wahrenst@gmx.net;
	bh=LFXqYk180vc4BWrbIG8j8Csao+70h4RA417Ern7Ps/8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NtvJ3NUFtGDzsny6soyw0mgQJJfnsihZJuGRPBDUqwXaWuQ4G5OtTCbvhrO9IOob
	 Ucz2ydzD277oPJOZJztvM7uGXwwKlVkpYzW/roXPh0l+T+z99A03SlTkNVbj6cn8W
	 m7PJeRGb2D+INQf2j+MPbkCrkExeXlymIhZYkyoOvBB05T43Z6MJwsg3fKh1cadTC
	 jcoEnQijUuIULfz3MrlWDGtjRF9elfAkcRlMn7oSRNbkyYaRaHTvM/8M2G2sk/4Xn
	 DAyUwYSsF2aW6M6wXIxII31gqDEKaVPY6ETIOrrXoO7pgv8EthB5GbD+gsn/J9J/2
	 UfWJOMC31fSn140Wtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1uxdI1493T-00rcA5; Fri, 09
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
Subject: [PATCH net-next V3 4/6] net: vertexcom: mse102x: Implement flag for valid CMD
Date: Fri,  9 May 2025 14:04:33 +0200
Message-Id: <20250509120435.43646-5-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:+APkAQfeMvu0LcVqLo9J+9x8EaXn1LkJDpt7vWf23Bm7wm3xTlY
 sen+oDlixkxwxdY3LtfAY6+OosiZ2RH2F9ai2CwOSaIRcf8TQ6cnXeAbHlOkJkvs3erPyUs
 IcIq/eccv3oObGv0bj4ax+bcxcKQa450KRV9+K/Jh+93ePetEb24aqu2kQGbYf6es39YjAw
 b/HPHPOVUXxVw8/NbCGog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JB/H2SOmYso=;YoCCjtGJF5t0gsCJGAnzpPTGwVH
 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

After removal of the invalid command counter only a relevant debug
message is left, which can be cumbersome. So add a new flag to debugfs,
which indicates whether the driver has ever received a valid CMD.
This helps to differentiate between general and temporary receive
issues.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 954256fddd7c..c2b8df604238 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -17,6 +17,7 @@
 #include <linux/cache.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/string_choices.h>
=20
 #include <linux/spi/spi.h>
 #include <linux/of_net.h>
@@ -84,6 +85,8 @@ struct mse102x_net_spi {
 	struct spi_message	spi_msg;
 	struct spi_transfer	spi_xfer;
=20
+	bool			valid_cmd_received;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry		*device_root;
 #endif
@@ -97,16 +100,18 @@ static int mse102x_info_show(struct seq_file *s, void=
 *what)
 {
 	struct mse102x_net_spi *mses =3D s->private;
=20
-	seq_printf(s, "TX ring size        : %u\n",
+	seq_printf(s, "TX ring size            : %u\n",
 		   skb_queue_len(&mses->mse102x.txq));
=20
-	seq_printf(s, "IRQ                 : %d\n",
+	seq_printf(s, "IRQ                     : %d\n",
 		   mses->spidev->irq);
=20
-	seq_printf(s, "SPI effective speed : %lu\n",
+	seq_printf(s, "SPI effective speed     : %lu\n",
 		   (unsigned long)mses->spi_xfer.effective_speed_hz);
-	seq_printf(s, "SPI mode            : %x\n",
+	seq_printf(s, "SPI mode                : %x\n",
 		   mses->spidev->mode);
+	seq_printf(s, "Received valid CMD once : %s\n",
+		   str_yes_no(mses->valid_cmd_received));
=20
 	return 0;
 }
@@ -196,6 +201,7 @@ static int mse102x_rx_cmd_spi(struct mse102x_net *mse,=
 u8 *rxb)
 		ret =3D -EIO;
 	} else {
 		memcpy(rxb, trx + 2, 2);
+		mses->valid_cmd_received =3D true;
 	}
=20
 	return ret;
=2D-=20
2.34.1


