Return-Path: <netdev+bounces-141447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0433E9BAF1F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193631C22A6A
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F311ADFE0;
	Mon,  4 Nov 2024 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ygEgyCIR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090651AC887;
	Mon,  4 Nov 2024 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711315; cv=none; b=WgkFcK83GR6IzX6uShfodWEhUhLuSP3vSkCY7yOWQxZd9oitr/gpsr7IFIP1NWgypb15yH6DFmzJ7cABG+lYxfYg99BXXyr8dHwLgXM0lzqfMPJhakGJJOox02N4a4gfPu6S8GhdtLs4cGUxnCDMWrx2dcTr9FX6crvJVRDicjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711315; c=relaxed/simple;
	bh=c7UGDTVYocMuGG6wwYaf9tAxdwwrKceus5N9V+s4RFo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Af2FSt0j+FY2Ueri5IxJ9rutEUbaULf+ofR8aUhgAu/bKxSnP1nxDfPlkxBgvtLCl3BZ7p/Mn0M+j3CfjIU3iD43bx1CzJHPFn+0FxCClnYOPb6YG95WiziaCvY2BtB8ht/ODar3fIewr9IM9yN/Qt2G426EFCAWNbqRgUOHnmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ygEgyCIR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730711314; x=1762247314;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=c7UGDTVYocMuGG6wwYaf9tAxdwwrKceus5N9V+s4RFo=;
  b=ygEgyCIRaQJpvxRkWKjGpa7aEesTpo3v5efH7/B/XX2WXtL1fVGN23bT
   olTwDOvOoTzkdhvlHonlShQadQZhCb0XaPz4YRQqba1o7kZ4yD6pVnv5D
   vLLVoctXAVkdqrn14Z0s12OYnFJMq99CaWZ5oq9R6wLt1BM6d7WXqdIGZ
   mVXL7cr1MK+n11HVPMZARkb5i6Ms6HcphTqv8N21wgDxWT9YYL5eDIEKq
   sytr88x/4psXwzVGfWfWMZL1O0vUXA5XHH2WxBvOf9trlw5do9wdMb8EZ
   ASgWdWhs3ymD6PdEbipPAq/WvUS5Dia7j23HZp5dkaZAGyVU5k+Ss1RUG
   g==;
X-CSE-ConnectionGUID: C3Qhg4IRR+O+O4w6DPDpdQ==
X-CSE-MsgGUID: Xt0CKTsIQBKWbxBayWktJQ==
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="33830825"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2024 02:08:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Nov 2024 02:08:10 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 4 Nov 2024 02:08:06 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>
Subject: [PATCH net-next 3/5] net: phy: Kconfig: Add ptp library support and 1588 optional flag in Microchip phys
Date: Mon, 4 Nov 2024 14:37:48 +0530
Message-ID: <20241104090750.12942-4-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241104090750.12942-1-divya.koppera@microchip.com>
References: <20241104090750.12942-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add ptp library support in Kconfig
As some of Microchip T1 phys support ptp, add dependency
of 1588 optional flag in Kconfig

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
 drivers/net/phy/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index ee3ea0b56d48..22c274b42784 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -302,8 +302,15 @@ config MICROCHIP_PHY
 
 config MICROCHIP_T1_PHY
 	tristate "Microchip T1 PHYs"
+	select MICROCHIP_PHYPTP if NETWORK_PHY_TIMESTAMPING
+	depends on PTP_1588_CLOCK_OPTIONAL
+	help
+	  Supports the LAN8XXX PHYs.
+
+config MICROCHIP_PHYPTP
+        tristate "Microchip PHY PTP"
 	help
-	  Supports the LAN87XX PHYs.
+	  Currently supports LAN887X T1 PHY
 
 config MICROSEMI_PHY
 	tristate "Microsemi PHYs"
-- 
2.17.1


