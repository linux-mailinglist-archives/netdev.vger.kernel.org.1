Return-Path: <netdev+bounces-219856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6548BB43811
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC455E0181
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9222E2FD1B5;
	Thu,  4 Sep 2025 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="sBi0gtqx"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0012FCBFC
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980577; cv=none; b=UnrcYxhPDmsSotqTMfhoju6ueRe1d+095epQqTQYTu/kFLS9l0eI61eDK/msNFEHeyztwcYwHfLMjHnc3qfobnedkN1Oqz/FNhjl4Sj8SejA3r6aQZEx6QiLF8ZTvHxQOTMCSJ+qYlUwKOQM7n5Ee2zQqRekxnt0waS8u7N8fWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980577; c=relaxed/simple;
	bh=dL3/F/LD/laKHbV+TQI604BxeKmC7dOV9l2ERRjwLCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cQn63XQMktsw1+XH+2jTbuNubJPuJ2WDTXPZ9eKhjr949wS3YLrlJkIM9Tvi46jKpQ1AUJCI4WP2Tjh0acmvNzdWnjAct4rURcS2uIklMuS3jwFp7WjEDhdlpN7VII3ZPzI1eGN+asPGkGjV6ondm6QNWisabOEZoGdjd7WIczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=sBi0gtqx; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1756980560; x=1757585360; i=wahrenst@gmx.net;
	bh=QrPY88SmlLlKLGMffaY5HuYZ7alfx/SoOkhJAj/RmwE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sBi0gtqxNNe4Q1Y6ZVFroxY7yij++HpGJ/TtXc8ZaoHzl+KuYkHK1poEZ+nd66P9
	 tdT7Fv5wu+vbWm8guDaBbfb3em/VaG9Y12BBNmAlPMBJ3/CybJrE8Tri5njf92Niy
	 C9KQCTVW/9PWjF6R13obdJKOmwo8IqFSk3X6j/iYLpWhD1Dyc7EsnZlt47087I8yM
	 OowDkKMnti2HtfFxUhMiMR/WEtCUfxVMpT7bHcR5VXLWD8HlCFyfdqz21t05H0yCK
	 eBKSX3zQQjPq4mwKWrrRaXJN+JIafla3vJ7EgxEMsaaXa5XLQ1rW5DKpG0aYguL69
	 1XXk1guP7gA+TOxj9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK0R-1ucIwD08yP-010qdY; Thu, 04
 Sep 2025 12:09:20 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH RFC 2/2 next] microchip: lan865x: Allow to fetch MAC from NVMEM
Date: Thu,  4 Sep 2025 12:09:16 +0200
Message-Id: <20250904100916.126571-3-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:LtMvS/aaJaCL0zjCvwzp3wjgnBXAYSqX6ieb59LdIXfwV3A0IPs
 gPrmZzZfqVUpSfJmSlKZOypTIlg5+K247gvsQt68nQzy4WzfTt3CdQ4q72k5ba2U963cVeV
 6+SDVu7WPdEM2wx5PsVpL6ccQEb1eOBQpLcqkktxcpTqCG4Apx08THS+v6DzbvvHnYfRmVs
 tJJu0Y/nwtp5oq3MtVaDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9H/v6mD1cY4=;AkBbKUaJtdiyaSdzZzSvMEPVn5P
 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
 0CZOPUyCZmNeKtBCvxs

A lot of modern SoC have the ability to store MAC addresses in
their NVMEM. The generic function device_get_ethdev_address()
doesn't provide this feature. So try to fetch the MAC from
NVMEM if the generic function fails.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D-
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/ne=
t/ethernet/microchip/lan865x/lan865x.c
index 0277d9737369..70e6b38da2e6 100644
=2D-- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -9,6 +9,8 @@
 #include <linux/kernel.h>
 #include <linux/phy.h>
 #include <linux/oa_tc6.h>
+#include <linux/of.h>
+#include <linux/of_net.h>
=20
 #define DRV_NAME			"lan8650"
=20
@@ -386,8 +388,11 @@ static int lan865x_probe(struct spi_device *spi)
 	}
=20
 	/* Get the MAC address from the SPI device tree node */
-	if (device_get_ethdev_address(&spi->dev, netdev))
-		eth_hw_addr_random(netdev);
+	if (device_get_ethdev_address(&spi->dev, netdev)) {
+		/* Get the MAC address from NVMEM */
+		if (of_get_ethdev_address(spi->dev.of_node, netdev))
+			eth_hw_addr_random(netdev);
+	}
=20
 	ret =3D lan865x_set_hw_macaddr(priv, netdev->dev_addr);
 	if (ret) {
=2D-=20
2.34.1


