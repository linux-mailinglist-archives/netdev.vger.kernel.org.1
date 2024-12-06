Return-Path: <netdev+bounces-149794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DF89E7859
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5517B18871F8
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F241FFC70;
	Fri,  6 Dec 2024 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="somnvfRz"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01FE1FFC4F;
	Fri,  6 Dec 2024 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510826; cv=none; b=gBNZ8+Ion6dlbLeBxB73T/4ccteOjUwjawy0Ca+L0TdYIs9e6G2/u5d+kByA22whTXvAH9cswqn98DHC3wrfBFLDWwv2FjopP5OUxtrv5G7j5A6js8yxnT44XxwcMAW7kcvEVTy6Qaw5m8iWYo4JJsxhc8FdvEm25TiK/njNyt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510826; c=relaxed/simple;
	bh=QMuPzGK9YExDlACs3muxs2Mz+0m78aWQnsclt2cayKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VComPg1vRgyXHdaOOCI0jx72TAVy/yO5nhXaRnZKBip+C5cs7hYoW3usatbTJZVa+vdAb9FDdF+eLH2beE4tI7zxtwZO8MhMVS2NcpYYwLhzoVNak28CaLa15oZ7t91EK0B1Iju/n4/84ZJFprRjNUmQRg2iOoxW2U8gTVa7qGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=somnvfRz; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1733510812; x=1734115612; i=wahrenst@gmx.net;
	bh=W+hee7KHS4URN2Q+zcbMHoSxo6UBpLV5sRgoPxbXdBo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=somnvfRz3wrH6NpflaEDUJksxcdy/Au2QBv+J8PYyGYVytSSp06vgMSMnl+0rm7e
	 v1qGEIfvGwqKpeES3/Gy5Slz+M/8obwps2GiWnL/beE7Iyp/NLT2HSkCKYrzLg0rg
	 sJOH2sXKQAXfUuYq8X3l9NYX65QUytapVzYCWfK16DFF7lTvNdoQyvtOMss4eUnxR
	 ogXoQhHLLcCD6bbtzQOEVmYSfwQvy75+8Q1dxMlaTXiOXx1V8tKraPo4u0wjL47Ga
	 vOxB3MRKXGDcgLETu2V8Ketf1j5veeixteXDg/04mqez0c1SccrjmlwuiyCEsMfQZ
	 saAjuK1YaNFz+xTewg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1tzM1d35uj-00hMpj; Fri, 06
 Dec 2024 19:46:52 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: chf.fritz@googlemail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 net 1/2] qca_spi: Fix clock speed for multiple QCA7000
Date: Fri,  6 Dec 2024 19:46:42 +0100
Message-Id: <20241206184643.123399-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206184643.123399-1-wahrenst@gmx.net>
References: <20241206184643.123399-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ub2z9OJ97+Vkxc28S6wrRw+nfuKm38f/y6UC896IlZ3oxRExaFq
 RNLMXqSOfx5RDeFUOBDwKnzMjSLL1g4+z/sVcEZkk7ZNc1enKT3xWXH/BtxyHabOVKxaAqZ
 39mnOkR+x52oqbKSKanBZhTm73enB9zbXC42SRB7K9X0BkQfC4XOl6VzCZtD1Hmb1ZzqZ79
 xMu/3IZO7sBEBmx32tm8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/P4RU2UhKT8=;jOw7uCKoClTNmPS0Y54XSUvQGkH
 27aAPOWpuPB3GetIBgWdZEa0rLvFLOUBQkjrTcOY5hrlgHDcVg94izY52umcC7F7jmJo8BKNn
 f0pjOT5Vv3x1xsf2ukj13204q/vlp0l8SpI+bFPQXNQg72as+Pencfpp25Njs0fuVfmPpkd4V
 MCiuRkHG9lGKnc4xdOoEyxiIFP+9DTTZPmG5/QyxuWROWs8QCTedDh55Z6D2/WhVloRkbzG6f
 BJfeZTDu1XO/wbzHUqYKMetVk4+iMHt2LxSVyfrJxarB1gysvTqOJm73JQNGORhDiXLeE1dr0
 QV/ZsIuaIffbAtAfrg9HOVrFvTCNPj6dd6RRcy+onOFkVdKkyLhGFxbSfSG1XBs+SSiH37VAx
 wneOY0VzNev1BeCPVmYyA1T0uv/8rcw6rXH90FXEwq4g6cExs2pq5xj8XxeLwrV3JZoaykdmj
 Z5Bbv68AGnxehhgfQeDMA6ey1ygoqj8WOk55d1G1bsDaY6Jti0O85y/Qn1+6moU+H2qgSno4B
 80mqV/Cy4oZbTxMLQQ05WtpJaoEq6vcPnChSx6BsWnayrUcwbNLRuuk5s6ntKOaknGPERqb5R
 coOiTGo5g82wqMKXfG4GBYZYUEpk6seDnom813fYFR2Af/2licoO5ytq5XgpPlV48wFuitey4
 UhaL5lwaKHVKWdij/CAQnMx37UN8yxFW3Kef6OnsXIzK+g693/Eyoo4zecsuel0DSLd3Tn1XS
 90OnWmpnqudHK/DZ+coXtPQS/XviLikpcYC9MgiO/DkIFNuLU7N0q2df69+UiqB9rHFWRjtaD
 WQ1glrcOBTyiNAHqqmbGxDk5a+vFYpXyGgKd1CUXOooJ2fJtjo65y2fl8MdKkGMq4nQGyjbYl
 NCS2YVCFQ8kzkignWmz6R00x3UaMo9isOImOcfEoTCL+rAwlhl6QwVgOog8zZWQn8xFXSLMPs
 dVqr0J+xtgIOR8zUNGh4qS+s6CF3fagj0KsXjejvS6MIUXgzkJPuicMM1NedzOwkSqJRMMN5A
 Ml+hr84w+4P4A32NPtzHPkPg7BqUdpLA/YI6J6ByIM4F+tZmHpAnU7T9oZ43yp/jz8gyKXyRa
 g6Fu5aPVwlTVrVrSbMtrWbOwL+ufLG

Storing the maximum clock speed in module parameter qcaspi_clkspeed
has the unintended side effect that the first probed instance
defines the value for all other instances. Fix this issue by storing
it in max_speed_hz of the relevant SPI device.

This fix keeps the priority of the speed parameter (module parameter,
device tree property, driver default). Btw this uses the opportunity
to get the rid of the unused member clkspeed.

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 24 ++++++++++--------------
 drivers/net/ethernet/qualcomm/qca_spi.h |  1 -
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index ef9c02b000e4..d328e770bcbe 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -818,7 +818,6 @@ qcaspi_netdev_init(struct net_device *dev)

 	dev->mtu =3D QCAFRM_MAX_MTU;
 	dev->type =3D ARPHRD_ETHER;
-	qca->clkspeed =3D qcaspi_clkspeed;
 	qca->burst_len =3D qcaspi_burst_len;
 	qca->spi_thread =3D NULL;
 	qca->buffer_size =3D (QCAFRM_MAX_MTU + VLAN_ETH_HLEN + QCAFRM_HEADER_LEN=
 +
@@ -909,17 +908,15 @@ qca_spi_probe(struct spi_device *spi)
 	legacy_mode =3D of_property_read_bool(spi->dev.of_node,
 					    "qca,legacy-mode");

-	if (qcaspi_clkspeed =3D=3D 0) {
-		if (spi->max_speed_hz)
-			qcaspi_clkspeed =3D spi->max_speed_hz;
-		else
-			qcaspi_clkspeed =3D QCASPI_CLK_SPEED;
-	}
+	if (qcaspi_clkspeed)
+		spi->max_speed_hz =3D qcaspi_clkspeed;
+	else if (!spi->max_speed_hz)
+		spi->max_speed_hz =3D QCASPI_CLK_SPEED;

-	if ((qcaspi_clkspeed < QCASPI_CLK_SPEED_MIN) ||
-	    (qcaspi_clkspeed > QCASPI_CLK_SPEED_MAX)) {
-		dev_err(&spi->dev, "Invalid clkspeed: %d\n",
-			qcaspi_clkspeed);
+	if (spi->max_speed_hz < QCASPI_CLK_SPEED_MIN ||
+	    spi->max_speed_hz > QCASPI_CLK_SPEED_MAX) {
+		dev_err(&spi->dev, "Invalid clkspeed: %u\n",
+			spi->max_speed_hz);
 		return -EINVAL;
 	}

@@ -944,14 +941,13 @@ qca_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}

-	dev_info(&spi->dev, "ver=3D%s, clkspeed=3D%d, burst_len=3D%d, pluggable=
=3D%d\n",
+	dev_info(&spi->dev, "ver=3D%s, clkspeed=3D%u, burst_len=3D%d, pluggable=
=3D%d\n",
 		 QCASPI_DRV_VERSION,
-		 qcaspi_clkspeed,
+		 spi->max_speed_hz,
 		 qcaspi_burst_len,
 		 qcaspi_pluggable);

 	spi->mode =3D SPI_MODE_3;
-	spi->max_speed_hz =3D qcaspi_clkspeed;
 	if (spi_setup(spi) < 0) {
 		dev_err(&spi->dev, "Unable to setup SPI device\n");
 		return -EFAULT;
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/etherne=
t/qualcomm/qca_spi.h
index 7ba5c9e2f61c..90b290f94c27 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -89,7 +89,6 @@ struct qcaspi {
 #endif

 	/* user configurable options */
-	u32 clkspeed;
 	u8 legacy_mode;
 	u16 burst_len;
 };
=2D-
2.34.1


