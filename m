Return-Path: <netdev+bounces-148144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 038209E07C6
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD315280FA2
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC9F13A265;
	Mon,  2 Dec 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ERjEn8hM"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C32136352;
	Mon,  2 Dec 2024 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155160; cv=none; b=QiwF1FSc0LpCV8Do+rdggRU2YtyYSEi0PQFq6fTKlKdBbVNQnb27UspvbppoQpalPlj047xa5pca4aHTnOz8xglRt299KpnsMMyd7OxzuGBhIQpSX6RmxiCnyqzr7Q82s2WDcEtRvZgrvjaRQX+PLleV81Fj+fNgYVnfoT474e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155160; c=relaxed/simple;
	bh=WaaoFsJl5CaUoadN0kBxGfgIoSYisHkAnX818rLnxho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T4b9VUa1f9WChc4qqt1/ITLWLUm3TVk5ek0bzz+vR9oFLMyuUrD7Nzgw613+2fUFfTo/cHRJLJc2V/5WcVueEGjjDkFCY3T7i4vHf+TlIHTem3gBzyuRJcT7ITJNWbvlkB0RzrXOFZTcymaOpn9iEsPixAPG10DRhDzgjxif2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ERjEn8hM; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1733155144; x=1733759944; i=wahrenst@gmx.net;
	bh=H4JLr3SrVxTDzBPpr7Wwo9dixYFhN95i0//rZi7egss=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ERjEn8hMLOoYVrmsOv3gmExeyNc9LrgN8ALCC4uD5ITaaZNhw9A3A8EnP3Kn1mbC
	 gF/PL2PKYyV19Ck5+GIejlC9DBdg13nqWSRH6GBjIm2hACOWaJFbxHCdxCmyzP+CK
	 cYgXUW95ZDO7LILLuIaZ4Aiq43yYQ5ex++NclVRGeb/aVFB7j8EvkoH4tF+k6l+Lk
	 X0kEU61549x6KggiWEBVQEQNO6zVidYk8hCmLiLwlsdrvWH7G2vNhy+n3kBTR0npf
	 8nFgK0xucsDmM83eO3uuymKj6q33jIE/7lt85DKQJIIm/M94Yra5WqAg1W9SFxArA
	 MLcVoayWl++0I0e0oA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK4f-1tZG4P33uz-013UdK; Mon, 02
 Dec 2024 16:59:04 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH net] qca_spi: Fix clock speed for multiple QCA7000
Date: Mon,  2 Dec 2024 16:58:53 +0100
Message-Id: <20241202155853.5813-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MWFUgtkNVvcJnJL76qJz6ZjTP7OH7g3wsA62/sTYamIZIH887KH
 N9HSrBa3ylT5tlUkM/Fe3dlHUldYVMi7qjBPftTughaJCU743DA6AwOsez7gvZaa04jXpjM
 gLhagrcWTRfICnCsYUtz2ft2IFd+arUu4zejiWB3VST1wML7n6pJy383kbf/JH1WFi57aOU
 c5fkR9kbCh0ivRfEnMVBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DbTM6zPP5Fk=;HD//Hop1KWSsq09EpLvleG51+i+
 /kns981u1a9kpzPNPsRU2vKBVNnGS5BxhZ6N8fRRNnGEn7N/B4AgmgWWqZ+e7wH2O59TV0uZx
 3BewKX6ue1EfRCNlC5XzoC3oExuDq2cQHfzchMYe/JVH04LkLMu/ckqegAWPr3ZmmXwwOl92x
 z1HEd4WRrN+8XePZFKsbp5jo7Crl/J2toGAoLU/Teoiw/VrStyaRZSCnM1ezYZzQ9cEK+c3KZ
 r9j4vtDm9FZHKwbPfltTqOL0vmcWYgnbG7HBz22cdCuFqVkiYlqRFkcVDdkwl6JA7IYq4ntv9
 +OQKDDTILvPUlg0iPThUc9bym3amTUXVL37DnZ4dsU18bQWxmFg0l20KIwTB04eAGUUo7DTF5
 DBvWdErlK3RKNyd5PKM/S41UwzPUC7btSM3oBscjk0IwtghrpBkMZa0P8ZtguHHO7JcB+o+Wy
 cQZp7YcD2LuYTk5Hd52gqMAMOugvf/btzbUNN7JSVASRcp1Dgjtsz2l7osatGeny37Qu3exec
 JGK0cOe68FJ3jb0yYGolppiwRJITmP+LJ8YbExzJSBVqaM0MLzYmUU5hKM8SXir0AGk2Mvx9W
 aEXo7PF4laRl0T2scNK/MGSYrnR+6G2ZdqOS1QzCJRYXUT+vZ8lEGB0MWTTIopJ9b5kii26Ai
 eZZvyriHqBnRYMboK2AdjXVzYFF9srkjhNfzsZzGddR+LH1cE11Kjvt3NQzz/BXUuiVm3pG83
 aTTPOaRiE7lacFJRp/NWgYA/WLa3g0egcSGQJ70HmhlkpTQGr86VFz5bh1MGlPl5yoLblIXS7
 TEbgRicPYc4Zs2UhLGiPUfrGIqUGfDLVXOzZ6NF1ExYKeQl575B7W8Ddgxehsf8pf89GcPEaN
 PtgNw2oHu4SoYRcAg5RUzNCxTSLRt8exyW9FBi+4e8d7pZoiXTgYxIv31vOyq1rKYTxTdFpX0
 GFc7sumZ6TZq268U/Q7FVOuRc09zuNKnSYSlLyiGMDLYZK9o9R04g9N4YkaQwTWeoYctXj0eP
 UnM6npVz2YVjbRfSCYd9Y4DQlO+buRg0sY/CCK/FhlIGxKzjruOM86mhs8I4Sn8tJXUMaC8Ez
 nMnAqGX15Dc1xKFDPvy+qog03GmGFA

Storing the maximum clock speed in module parameter qcaspi_clkspeed
has the unintended side effect that the first probed instance
defines the value for all other instances. Fix this issue by storing
it in max_speed_hz of the relevant SPI device.

This fix keeps the priority of the speed parameter (module parameter,
device tree property, driver default).

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index ef9c02b000e4..a79fd2d66534 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -909,17 +909,15 @@ qca_spi_probe(struct spi_device *spi)
 	legacy_mode =3D of_property_read_bool(spi->dev.of_node,
 					    "qca,legacy-mode");

-	if (qcaspi_clkspeed =3D=3D 0) {
-		if (spi->max_speed_hz)
-			qcaspi_clkspeed =3D spi->max_speed_hz;
-		else
-			qcaspi_clkspeed =3D QCASPI_CLK_SPEED;
-	}
-
-	if ((qcaspi_clkspeed < QCASPI_CLK_SPEED_MIN) ||
-	    (qcaspi_clkspeed > QCASPI_CLK_SPEED_MAX)) {
-		dev_err(&spi->dev, "Invalid clkspeed: %d\n",
-			qcaspi_clkspeed);
+	if (qcaspi_clkspeed)
+		spi->max_speed_hz =3D qcaspi_clkspeed;
+	else if (!spi->max_speed_hz)
+		spi->max_speed_hz =3D QCASPI_CLK_SPEED;
+
+	if (spi->max_speed_hz < QCASPI_CLK_SPEED_MIN ||
+	    spi->max_speed_hz > QCASPI_CLK_SPEED_MAX) {
+		dev_err(&spi->dev, "Invalid clkspeed: %u\n",
+			spi->max_speed_hz);
 		return -EINVAL;
 	}

@@ -944,14 +942,13 @@ qca_spi_probe(struct spi_device *spi)
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
=2D-
2.34.1


