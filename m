Return-Path: <netdev+bounces-124223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D424F968A0E
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785C81F22B25
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE1D21019E;
	Mon,  2 Sep 2024 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="p84FOO6X"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4A21A2657;
	Mon,  2 Sep 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287741; cv=none; b=Lq4dXXXYdhMP1k4KCB1PBMIvrr8UPUGb9s2YBjnxY4eziDQYxxH0tWhEKhueeIk0s+VLTwFoscEO25Ie78HCQ6nh2EaAGb4qbPwTBBK1rYxfLFPaEmbd/t2n1VlIwWFMulSu9r8uGww1GEl4e/d+pOxDJbOkh+ApSAKCvw1qAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287741; c=relaxed/simple;
	bh=qgHHczzReW4YtKM/U6ZQiVI8kdQQUQOaxRhP4Uahqtk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzU/vkIYZMHCuNN5r6FZGnzjroCWl07fqYSq29AHsGa3yfdMvlPuJU8Fl8kBx5yp9SL06eftWrUq3kX4w9IL9mCcIwBPfLM0Ll5ejqzJ8KyPNKBJcUyVt4LoNg5KEb1uIfKUnS2+JMlkH8zJ4SGjX957XfwDHd8z/MjiQq6EMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=p84FOO6X; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725287739; x=1756823739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qgHHczzReW4YtKM/U6ZQiVI8kdQQUQOaxRhP4Uahqtk=;
  b=p84FOO6XG6Tf0W6yYFRXh+hugkjH2lrk9TkpN5MTmo9MSInZIlrWcHSd
   d8eqdijIyZJv00L8ERnRbEblkEGyVfeWpZmj33XIt5IJD0yM+RGLNyLi8
   XcXtA4GqdCESDsJaXBYTmr3/BZwOuXTwwhIUjT8Br/0sultoUZA5bL5Oc
   rNemZkRQH17Dv8C6lh69EXXpStTVYM7xhG9LGtgtLnByIqnqNrMN78m7V
   GpYNmgg24CEjhjF379YPHUTq84k8Doqzf2AmqW3HTe+8QzfvSdm6CWSng
   iAaJu9W7y1ZyZmSE8B/qWBtYHTa4wtLohPROJDXsmOYH2++yV3MRMud0d
   Q==;
X-CSE-ConnectionGUID: ocGO3RCOTkuOSmOfjK4K+g==
X-CSE-MsgGUID: AW+Z8mxnSIStTB/GGAKa7A==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34270504"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 07:35:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 07:35:25 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 07:35:21 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 4/7] net: phy: microchip_t1s: move LAN867X reset handling to a new function
Date: Mon, 2 Sep 2024 20:04:55 +0530
Message-ID: <20240902143458.601578-5-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
References: <20240902143458.601578-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch moves LAN867X reset handling code to a new function called
lan867x_check_reset_complete() which will be useful for the next patch
which also uses the same code to handle the reset functionality.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 58483a0fa324..5d133261dd69 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -265,7 +265,7 @@ static int lan865x_revb_config_init(struct phy_device *phydev)
 	return 0;
 }
 
-static int lan867x_revb1_config_init(struct phy_device *phydev)
+static int lan867x_check_reset_complete(struct phy_device *phydev)
 {
 	int err;
 
@@ -287,6 +287,17 @@ static int lan867x_revb1_config_init(struct phy_device *phydev)
 		}
 	}
 
+	return 0;
+}
+
+static int lan867x_revb1_config_init(struct phy_device *phydev)
+{
+	int err;
+
+	err = lan867x_check_reset_complete(phydev);
+	if (err)
+		return err;
+
 	/* Reference to AN1699
 	 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/SupportingCollateral/AN-LAN8670-1-2-config-60001699.pdf
 	 * AN1699 says Read, Modify, Write, but the Write is not required if the
-- 
2.34.1


