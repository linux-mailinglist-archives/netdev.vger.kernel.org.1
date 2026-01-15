Return-Path: <netdev+bounces-250238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57965D258F9
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F73230E234C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF07F3B8BC5;
	Thu, 15 Jan 2026 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H5NjE90j"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98963B8BC2;
	Thu, 15 Jan 2026 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492645; cv=none; b=q4rMmnmXAxQhAv1d4gd/v61B7e8wOeIff5OcGaTDK502s+ltz43SJxoMW7nRLZ44fCW7yKYAXAfWO6tck3hWhYWy6uG0+iyi0oMKUzm4qk2lNrJ7WqG5bmWeKBuhXk15Z0rwcMSVAuxF8kehbmUIFGWR7JhqTTPVCkdtTmxbh3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492645; c=relaxed/simple;
	bh=BIijEftzm8tqAfHFDR9frriPj9CLtv4pJAHgkUQlbdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qd2AojGLzRwo8Rhy1YVEFCR+j5sOOq5ndZYdyDTb8q4hIouV9utmeqRojCcVoIWsehI+R+v+73h7Gj/4YwpiyF8vQijiUltEfnHGiUipLpQ37HnSs3VokSnpcGDUxJqXnpLI1g1hw//RbqENnIb3D/LLJO7oojh3bRIMPDtCLYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H5NjE90j; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CEFCB1A2888;
	Thu, 15 Jan 2026 15:57:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A5469606E0;
	Thu, 15 Jan 2026 15:57:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9ED8610B6862C;
	Thu, 15 Jan 2026 16:57:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768492640; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=djGfwvmrTmNc0irErrvCNhFoMsaGmfcYs58l7bW923c=;
	b=H5NjE90jwGBNUkkDtxR8hdluGsFMXkWqdbOp8CU9dG9O4FFiJ4Z2RqG3ECLXZpjHziPaZT
	/NAGVzxkkZujZgI2qMIA1Qwmd8A9MAXBpG35+/ok8DHSjvjl+euW8Ej3n8SuI32hStCwPM
	TV1Zy5jGP/Ry658bFK24OhCmUyaeDY75dGLGAFI2Hd6Vsjv6uGUqIayGtx94TGswhnjIwK
	d968miOhzl96vnkTs8Eh3+eRmYNawEfLKBlKj0ge25mjhDp9/ajXi7YL2aWDMZyYaPbCFk
	ZviW+DQxWVYl12wCYzMnIhQ1kq/pL76RF91qSE1nU2RX9QIJDoy1pTFjTaJszg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 15 Jan 2026 16:57:05 +0100
Subject: [PATCH net-next 6/8] net: dsa: microchip: Enable Ethernet PTP
 detection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-ksz8463-ptp-v1-6-bcfe2830cf50@bootlin.com>
References: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
In-Reply-To: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

KSZ8463 needs to enable the Ethernet PTP detection to fire the
interrupts when a timestamp is captured.

Enable Ethernet PTP detection.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index cafb64785ef4c7eb9c05900a87148e8b7b4678e5..fcc2a7d50909c4e6a8cf87a3013c3c311c1714b0 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -947,8 +947,8 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
 	/* Currently only P2P mode is supported. When 802_1AS bit is set, it
 	 * forwards all PTP packets to host port and none to other ports.
 	 */
-	ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_TC_P2P | PTP_802_1AS,
-			PTP_TC_P2P | PTP_802_1AS);
+	ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_TC_P2P | PTP_802_1AS | PTP_ETH_ENABLE,
+			PTP_TC_P2P | PTP_802_1AS | PTP_ETH_ENABLE);
 	if (ret)
 		return ret;
 

-- 
2.52.0


