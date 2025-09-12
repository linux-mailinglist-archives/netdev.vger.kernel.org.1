Return-Path: <netdev+bounces-222617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B74FFB55058
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC815A74C8
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5815E3101AE;
	Fri, 12 Sep 2025 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="hXbKjK2m"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8684730FC0B
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685835; cv=none; b=Zo8WiYi7K9M3oMjFrQWwmnL9lLIJFI/yk0GH+5Z7e+imak8jynzLrfO9+AWCNwB0mlpdL8cv3BLqMx69aVn2upkAwXRyBD3mx7v7KLWenlh8l8iDD9TDBe8cNpv1p3Bxvb0HdDMH0oLDW0B4kU3eIGAlNFfhYUDuF+n5DnoJUCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685835; c=relaxed/simple;
	bh=6YYSeNw0Ulg3w3JXzHDRMUR4RznYiuWMjhWuQ8noyEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lLSzCXSNVJbTozoJhgdLkkdPJRk3hzp/NrsgAWA+qa3iLISeCkZadyXRk3xCjLXb+h1d57I/XOySzDqocm0po0j3USwBfpAWygVFY2PzoopJJUrD31pcprP5j4UzA9URBqmkeCauxBEXL93XBUUS7Zon8LblPSUKMJ0mzL9YX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=hXbKjK2m; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1757685826; x=1758290626; i=wahrenst@gmx.net;
	bh=+L4A91W+8LcHB/39j2x0xFp/dhtA/o5fknwCzhlkoeA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hXbKjK2mhjzRbILtbOVJHsDRBIqUVpi5LYebEktKQh5nT7yrcgOhm4JvHj1MbQAR
	 iMDT1rIn17fyxgkb1uQEKpt69VOzCLDXLrKL/vRnBFWyp9q/WkHXh2qhZE7SeW6OD
	 Uk8mpbFcpfHtclmD4uPENoLwBtKr/Ijg3P9kX43AxKqi+rzRnXE6vJZz3jmt1L3kY
	 0BnY55kUitho2YoKF2NBomnfQ6B0Eyh4Os+9idJUL6XccJgWHpMBGPlKhOKNg9JvN
	 DMVKXkAl49JE/uOq+m1otgF6yFW7EcFAsWh63Oc26b49TOccQ7n0IiZzaNfyV/zmz
	 fst11zwaoatMZ/pzcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1uxcbj13re-009qju; Fri, 12
 Sep 2025 16:03:45 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH V2 1/2 net-next] microchip: lan865x: Enable MAC address validation
Date: Fri, 12 Sep 2025 16:03:31 +0200
Message-Id: <20250912140332.35395-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912140332.35395-1-wahrenst@gmx.net>
References: <20250912140332.35395-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tkMfNlK6iKzHvK7ZQ4oXw0V3xg3bq54wx0fhQ7b8aU7yP8fHxQy
 88gSXdctEhF5K6P+PS9BEFENRBpQtJtpnoZEnAUcQqaA9psNqnKSEfxZdH/HFsw8LHAqJTQ
 mSvQ+RFIiD48dgJe6DnekvR231EdPqhH80LQ3nkUhAQ+eFg9D2zvU/z1LwyDoISt17N9zok
 BpRct/HLYrmpT2GeieAUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IyACUtW6mcQ=;8pMKyAy/YG8Ci1XeW/xUNvjmkp1
 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

Use the generic eth_validate_addr() function for MAC address validation.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
=2D--
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/ne=
t/ethernet/microchip/lan865x/lan865x.c
index b428ad6516c5..0277d9737369 100644
=2D-- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -326,6 +326,7 @@ static const struct net_device_ops lan865x_netdev_ops =
=3D {
 	.ndo_start_xmit		=3D lan865x_send_packet,
 	.ndo_set_rx_mode	=3D lan865x_set_multicast_list,
 	.ndo_set_mac_address	=3D lan865x_set_mac_address,
+	.ndo_validate_addr	=3D eth_validate_addr,
 	.ndo_eth_ioctl          =3D phy_do_ioctl_running,
 };
=20
=2D-=20
2.34.1


