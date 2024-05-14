Return-Path: <netdev+bounces-96391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EE68C593F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 18:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E07282F89
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB3B1802B6;
	Tue, 14 May 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aVIJFg/9"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AAB17EBB9;
	Tue, 14 May 2024 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702639; cv=none; b=m/HO1SCESvm6O5p3uQPRRm+jX2OQfJdO/K8OQWODLgCwWwLbydXM3PqRkFQRcemUcNjBIy2NVSU84xiCHUUp0OrFLPhBHlRAMJ4I/lYwYem+UvMVRXj98yxF+IbTs3gbbRS82C50y3SnxBJPFmQd7Rtd/rPPXfcKrJeT/Dl5gs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702639; c=relaxed/simple;
	bh=8p9dxDDyCdgF3n+rmt/g4MC0o+LN7zUSTO4kYJz433g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddP0CWX4UIFqBEY2XZiZSFOcTjrFkaE/QOR7oA59bsr8iDg0KZ8nbC1B6maij4m0oq6R6xbKR2y37f9KQL9g7zhISWDAQ+vhaImM+XwlBELFJJod+fYpM9H3fQ6zvcP+z+GXpz92+jaQwNEkN+kXmjw3kWlNAr/XUfE6LAXL/us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aVIJFg/9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715702638; x=1747238638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8p9dxDDyCdgF3n+rmt/g4MC0o+LN7zUSTO4kYJz433g=;
  b=aVIJFg/9KcA1zQBAmzZNTmIfFvsmEr606JHducPjt7GjEd3B7tJzxMzZ
   1QyzVBB5/LOBPkRsp2DJUAeJ+MnMOe5D/Ras94dfo9kOCCh49ysPCA1zd
   Buu8F5YF/Yh3NJ+nQn4p3Q7ZqA3DtQTCojtNAXvzhnIfoqwwQfcWyDRt4
   6s0DsgSDT5KF4KMQRaA4Ip1cmuX09iW8nKHz699T++Oeb9KRDZYjpng6t
   +O1IClDgmx/SLW3kxFzTh7fFevA6wh7G8SrIvWzAjsm4Azqz5VCN02pz6
   K5H2r2fnQ5N8bkFofh9Gl8k/42nF56iTttNNWJ8gVmlpyXqgF06jOIwnE
   g==;
X-CSE-ConnectionGUID: fa/uIrenSP6Bi4ynGM2+AQ==
X-CSE-MsgGUID: EMuXM7xYQ5ajWp0sIOj5MQ==
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="192034030"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 09:03:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 09:03:36 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 09:03:32 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH net-next v2 2/2] lan78xx: Enable Auto Speed and Auto Duplex configuration for LAN7801 if NO EEPROM is detected
Date: Tue, 14 May 2024 21:32:01 +0530
Message-ID: <20240514160201.1651627-3-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514160201.1651627-1-rengarajan.s@microchip.com>
References: <20240514160201.1651627-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enabled ASD/ADD configuration for LAN7801 in the absence of EEPROM.
After the lite reset these contents go back to defaults where ASD/
ADD is disabled. The check is already available for LAN7800.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/net/usb/lan78xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 7ac540cc3686..62dbfff8dad4 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3034,8 +3034,11 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		return ret;
 
 	/* LAN7801 only has RGMII mode */
-	if (dev->chipid == ID_REV_CHIP_ID_7801_)
+	if (dev->chipid == ID_REV_CHIP_ID_7801_) {
 		buf &= ~MAC_CR_GMII_EN_;
+		/* Enable Auto Duplex and Auto speed */
+		buf |= MAC_CR_AUTO_DUPLEX_ | MAC_CR_AUTO_SPEED_;
+	}
 
 	if (dev->chipid == ID_REV_CHIP_ID_7800_ ||
 	    dev->chipid == ID_REV_CHIP_ID_7850_) {
-- 
2.25.1


