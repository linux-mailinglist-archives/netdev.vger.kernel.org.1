Return-Path: <netdev+bounces-230534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7D8BEAE03
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA1894276C
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715E627A477;
	Fri, 17 Oct 2025 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="j0kfcSXG"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EB922FE0E;
	Fri, 17 Oct 2025 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717424; cv=none; b=OT8fSHRkZ969ZPfh8ABurA3Qe/X9VdRMpbtsZowDI7CqU5bkOCgWM30bvo1bTgNKwTQkqr4Bd81tYobjNKw1C3KG0GmS7jbX7cEosxLrNpURWCsGoKxC4nfKnU6tEkvAY124a6LZzTBdskZcYbBZBjiSNp67jS63Y9YhK9fj0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717424; c=relaxed/simple;
	bh=KVqa/PFGYmekcnwV/90RWGTpdgdm2rij1l5slU3qP48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5vT0EwnQeaRkg0hESRuZcdI6LzkXgHedoUQjDoz2p9aG/WL0YPLlPHe2KieKWkddRPOcfuhGy1Db8lkLcsvpHtY5mlI7itqM4PwNGufjKvGUEKXznlFLPkrmKPdxTiWwcQxLPh82doKYEy7f9/g1pDMbNO0sMjPEwp2C66uR5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=j0kfcSXG; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 83AEDA0D06;
	Fri, 17 Oct 2025 18:10:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=4NcY+aTFoRxO6/dGokU9
	2XJTVNbCE5Phu+eGQdO1K9w=; b=j0kfcSXGI50mpT2KaAVdgXOSs0y6ZgsA0RcP
	pcb2svuffnTT1xDbK12CAhDeRGZWs9Y5uSyJf6ZS6f9xoDuw/t+twtGRBkFiFjsN
	V4JhjIZDl3K/YiVLnxjoNfZYhIEClGs92fbmUPU8gZWxK/OZL5hDRANdbbUyQl19
	vZu6p8Rb5Cuc0uRIJfPF78MbGnNC2wwEt5jWX4JY2TvE/e+xVPnzCp15ic9smnQo
	Q97thxN4z0vddJtmHphfWZBObOUClxYmQszkjRlgXNUJJ+DgnT6u+YSBYrvOYBTh
	hBe2t4k2UM3MHOkCpj3meRkL1p4QPMHX8txBkF7nZdU8mAT6tWS3OMmALURe3cWy
	Do4ZyRA8zxMCXTkfvjZnUpIoPVO6cpeUT8Jis+HyAuGEozXb9/HmJbi1V/5DOnRh
	tWRNn2RuOfTlBAKONtXPLz8VbA23HX/egp4FlHCbrtxA36rsWapsJ5IqKUu/apgk
	o5MwTWlSr3d7W1zfSaLgBJRG1LEzhUSvfiNhwgkl4g8Rx0SQmSZ2BOKkjW4aaZIq
	fxamQSYN2Mpmc0H1yznFHkUPUa5AR0mrQecCFGz3K+KvjKev+OKajk3WV9Nn5QKa
	Du4CmHcmitdJBcyXFgmV/u0nFCYGYtobWiLetWjwBkmphCqXml9ZLCHZqIrpDZYe
	SwvaeaA=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Florian
 Fainelli" <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v3 2/4] net: mdio: change property read from fwnode_property_read_u32() to device_property_read_u32()
Date: Fri, 17 Oct 2025 18:10:09 +0200
Message-ID: <2fea0c340e7ac9aa10c03c46a2d3169ee45c7f68.1760620093.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1760620093.git.buday.csaba@prolan.hu>
References: <cover.1760620093.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1760717418;VERSION=8000;MC=4080044216;ID=38908;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F647660

Changed fwnode_property_read_u32() in mdio_device_register_reset()
to device_property_read_u32(), which is more appropriate here.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V2 -> V3: unmodified
V1 -> V2: added new patch based on maintainer request
---
 drivers/net/phy/mdio_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index fb1cb7a26..5d39b25b7 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -86,9 +86,9 @@ int mdio_device_register_reset(struct mdio_device *mdiodev)
 	struct reset_control *reset;
 
 	/* Read optional firmware properties */
-	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-assert-us",
+	device_property_read_u32(&mdiodev->dev, "reset-assert-us",
 				 &mdiodev->reset_assert_delay);
-	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-deassert-us",
+	device_property_read_u32(&mdiodev->dev, "reset-deassert-us",
 				 &mdiodev->reset_deassert_delay);
 
 	/* reset-gpio, bring up deasserted */
-- 
2.39.5



