Return-Path: <netdev+bounces-149795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAF29E785C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3BD16D469
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63D8207658;
	Fri,  6 Dec 2024 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ewkl42Ot"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DB81FFC57;
	Fri,  6 Dec 2024 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510827; cv=none; b=n1pA4xwRfnArREuUmHiEMxpRjPc7KXqavTcfGvhMs2ex2XtIUkQ48emFrXOQXapNpOm9pKOrwxg09WUSA7DtjEp77tiYz8vtoFgjgFjgv71LHfciNhXHsJzQ1dTrsnBpmGUStQ/5IOlG1EGjy8JLjx4ox3npgEGaGlidUrvZz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510827; c=relaxed/simple;
	bh=mT/7swdeuZHAQJy54hnIBi1b3QhMyhOPSsXb1YTf91s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xj8vD8n4ZDSIzxbt5kC5ixHYtoA2iapyLsHdAnmE4VNGtGphF0epsgTeAtWfTWpL/nEqperqH/sy/0Z386ql1k1rytZk2wuXjxWCC66AbZBgfjJVGP8/sOakLciBUn0c1ySknP+jD3OGsYgGeE5iP8E65MOekCYemYPQ6AHpjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ewkl42Ot; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1733510813; x=1734115613; i=wahrenst@gmx.net;
	bh=mT/7swdeuZHAQJy54hnIBi1b3QhMyhOPSsXb1YTf91s=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ewkl42OtKyiOOPVLyjs/UpSuVf+nSMEsUdaSKE3w+naDkfOsZAM4ZFxfckEU+IFp
	 kE2Yr0bwkBV/gxD9QL/b5yrsWuWaSrplYFQCkQnIAh4RU5OBQz5ZUXuDDpdZnMdom
	 laJ93Yw4LNzLH/9fTEe8Mqs42ruNTUh6xdtPNf44QGHwi0hJOCo0Cl/J2bEYMMltX
	 8HBA/1GQrImPBzTKr5kIlSAzeaL1cYUCUEVfF/bktNOSGr7CXkSKfho09nMUqco80
	 2O/HYIbUPIMsSG0qivWCSL6IkqfNxEWniUMxkYO5ERPUmw0GwKwGllm7S5f3QsqGZ
	 0H9mwVYyAUG90lhwPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MORAa-1t0KsF0N8I-00XdNw; Fri, 06
 Dec 2024 19:46:53 +0100
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
Subject: [PATCH V2 net 2/2] qca_spi: Make driver probing reliable
Date: Fri,  6 Dec 2024 19:46:43 +0100
Message-Id: <20241206184643.123399-3-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:m1k4RaEn7bn/j+NRRVgE0JZb91KuhUvlWmWj9L9VkVRkUwyv5ww
 JdNwtlPJULoMV9sVcRlOsNcc8o3eUfcve7YYhqIn0oYjkF+Tt+ZTfydfGU798FRwMb+LR19
 ZLdq62r2qQh+h2DU74dPQ8zDazXRzfuJaANgjEMHFJ4az4iTwdE7QxVk8qAQONLHj5hM+Bw
 R6EDRQn067MReUUUEb+Ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EuADY5HvDlk=;TFRlf9w6Nr/kJla5GM1N/2B2xr4
 U1/PgwA4VurPxnpb+/NXDtF1egDKBNUCBHOYX56aMCISWtpqhy9o6jVAckr2ilDUYpNZzrhnA
 ikB/EYEN8TaRApVt04kb8fjzdgvz8aaBuEgo5HQjF7QxgBJL2g9E5fxqAc5hphVLvIuyrgzA9
 BTq66/6ErdYPmgke5D9UcCirnAaxG7+HhCcYbH+8ADRxUZW5738tuZY5g2QYeKvr2ENpB+7Pv
 5U8gOvny42yIZPxqvknLNQ8f+ZEsbIJ8zwT2RmTVB7HgzkTsWG23BaP1/uGEW68a02zWhzlIc
 RLJCs25WBiugn4Ax3Ma3Mta2nqezcPCwnrA2E4Rh+3lvH4l44jnTKSC/gJ7C9AaXaCyXQ1AuI
 SE2swvsB5OKQnc5WNGHcLiHRNprNM6sPmv7N4bXj3U5nw5XJOfK8nbtjq51DFN16vY6VRG3lw
 ggH+QGnvCfb1BH8TpNKQqLP18ghr17CJNLaKNrarXaiZlPH1HC4M+SQ80W4JMZ9VE2S3fdSDo
 AUSgvFadTvxRZgZ+VryCxYA1REyZezG+1PD+g8jd4WoEOeVwMC/QxBMIBXuiozG2E3PlAsrmV
 oSS50qtycermeIH/Bs6ntOqGmtRNPK1lNg81bFI0+GR2b6/WXpn1DkWIRyaM3uXzmmRrRq+5U
 JreZ+gPT88o9B0TxBHkARPpf9CKBaZw/QaWbfx1RLY/zq3DwEKkyuITcJtmWvCM3QuhvQ+fwb
 R7vGXj3+K1ZdL3aVKYmtwkWhjCyzlZLFLB46FpukbhRK3wo912o2EOdCmzj01f1IrbNOh8Ev/
 cJtHBoisGeij193V7oFGz6cLkBHJAVB5ZWSHPxWJaRoVCJEQ0956klis1GIqwDycoplAA8R5p
 uG99V61tdtQrEZYdFF3weOGrlYJCPMvBDQRhGH+q+l9+XFp5rvNwc5867RmBAV1xEd+qoNmRS
 /hU3Cc0j8jWe0DqsA6f4ATr+HqoVNWTZwWxiJJUj5PnUVh8Y/2gOMkdNHvik/xqV0lo24qOCw
 esKgvggDjB0Vkwaxx7OrH+YVIZZYC3sjyvfwmxwMr8nxOvmCSvyMEWvZ1rp3FqBP6dYh6FL4J
 XJeThoxpiRcicGWwaWZVabPp6jv89z

The module parameter qcaspi_pluggable controls if QCA7000 signature
should be checked at driver probe (current default) or not. Unfortunately
this could fail in case the chip is temporary in reset, which isn't under
total control by the Linux host. So disable this check per default
in order to avoid unexpected probe failures.

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index d328e770bcbe..38a779f4b866 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -54,7 +54,7 @@ MODULE_PARM_DESC(qcaspi_burst_len, "Number of data bytes=
 per burst. Use 1-5000."

 #define QCASPI_PLUGGABLE_MIN 0
 #define QCASPI_PLUGGABLE_MAX 1
-static int qcaspi_pluggable =3D QCASPI_PLUGGABLE_MIN;
+static int qcaspi_pluggable =3D QCASPI_PLUGGABLE_MAX;
 module_param(qcaspi_pluggable, int, 0);
 MODULE_PARM_DESC(qcaspi_pluggable, "Pluggable SPI connection (yes/no).");

=2D-
2.34.1


