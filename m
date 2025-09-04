Return-Path: <netdev+bounces-219855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCC0B43807
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874775880F9
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D612FC88E;
	Thu,  4 Sep 2025 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LU09ThmR"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC022FC02A
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980573; cv=none; b=iSeM7WpXMgDPEpEsaAa+ynvsZGB+dpzVio57de3NXEgPerTYW+qWuuapPtLmB3m4FX9RYgjg/Q4/0W2OCfnABp2YMivswn4NZr8rMDxPv9SmovUFZLhROOl/Wa0u62Tvvx/nYpA6qZMjOTwcCf+fhiKz4QXxte33h93SCSXJcbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980573; c=relaxed/simple;
	bh=a/DHv3ICwoepU5ueos728F8r/vYhDBM/W2wXMuCj/rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QVLdduP+27fleoEuC3I1denqCCGRjJ67pAip9iYtQJ73fjjRceRwi7S40eqKEYonWXQtfbJUhUQE4JI5C9FqJReFv2Tzm8doGThCn8dcXidZ4jRneeH4I1tto6eAucphxmULn5KfoJz48vyF1MC8kfgyzh/H9olCG8lhiiyLQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=LU09ThmR; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1756980559; x=1757585359; i=wahrenst@gmx.net;
	bh=HlLWkl7pTcXFtwF85okSVGSpS8+2FRGpSfDS8UKcuRA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LU09ThmRuMKSwi6atebS5/Q6P6RhGSai6lswcyc8S6brgulUyx/orSkhuiwJWijn
	 i97S/fJDOhW4kL8RGbQMwu4TfSjvDlusMEjeNc8fyntBDtXB/b5CDxyt+2eqOhdQC
	 QHsXRJA42Yefhin1x9/oF7UmhADYy2fTYSFBWlGf1ioQ0JDaG7kU8ELtM7NuyWoDB
	 mb9Jx/jHluqJdIQPgkmuMjQb2LDdymNaXwhATbrD4NlRYCZZmNCUcAP1f9FVNfo1X
	 3zdQ1r+ZfAn0Pnbhdc3xSQT2kPnfzprrs0i3TDJ9mPWmbA9k5dNrs/eMg0ZPahHPr
	 zAt1v4xivfZTjMI/6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1ut0yJ2p9Y-00BLVx; Thu, 04
 Sep 2025 12:09:19 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 1/2 next] microchip: lan865x: Enable MAC address validation
Date: Thu,  4 Sep 2025 12:09:15 +0200
Message-Id: <20250904100916.126571-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904100916.126571-1-wahrenst@gmx.net>
References: <20250904100916.126571-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4HLkebQkDPiUk/sWurOkHyHq9dYNEk1qhqXh9di2Vxsp+4W7FCF
 i+IvZ2y5zBcW789PXDTTOoynglJAbCJKp1ejfuVtgxELGATeNc6Mbrjp91AAfJl+tU/GWvF
 Tk4zIj46woeARKrIWnYKMTZkS4SlRu2n4Ws2Z3eXms1/FafV/rGVvpbmZE9hSZTriXPMBQd
 l+tdJP1rfOOaoeFutCBOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9fqyLwodr/E=;LfSO9lQFCvk2vfCFqcG5BpKFjWd
 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
 +KUcAEBY/wPLImr7Fuv

Use the generic eth_validate_addr() function for MAC address validation.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
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


