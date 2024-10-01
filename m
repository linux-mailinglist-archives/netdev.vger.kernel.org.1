Return-Path: <netdev+bounces-130852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3F898BC3A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1661C21E24
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227771C2441;
	Tue,  1 Oct 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oMmvBxrG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA4E1C2307;
	Tue,  1 Oct 2024 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786290; cv=none; b=AhKEhM2Ix3gm+31zmQAq4f9XLDQg7X85J5gxaY03WYNweQUUSCOjUlii4RjAeMX2Kakn4FiVyMHldALc/lO3EGdISE0EhMV78b9SlQn2kwgE9A7zqjwLjkNZdBy1muHsLclKVxCRUJHL+yxn0V5dJf7gXPiKc1Ug47AtFIP/Sic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786290; c=relaxed/simple;
	bh=DXoE6qiqPtl4TmxWa9uMdGg7FMTHHFgGHKtVkx61Vfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4fs+Q5fovNzW5/uEG25ZEphgK49uYvgY72WNFXaeMxZGhZv1osKlwArAiTbm4yQ/8EF1RBiLcQiq8ZUIXDXDbRutxeBy98Kw3l5m7xFCv+lV/dHalaA80nxmmpUmjk+dUkXBPioXvfqPftqQdRt0fpwtcw8kjWQFQjGJG1dOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oMmvBxrG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727786288; x=1759322288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DXoE6qiqPtl4TmxWa9uMdGg7FMTHHFgGHKtVkx61Vfk=;
  b=oMmvBxrG3Q0/J4szOZS68pzdnSKjV3ULe9Nrid2kh9nRIIc6QB5Y8/it
   s/ndokCw/NFBfYtxovuF2XYWkRHihP2G6+XLofmr5WJf6ByrybN5QNrDZ
   OpbUcK8P/xlE7+R+jQbxiaEZHSuJuGuGcSSFrKTz5BkgQPF0QAMyRBjcz
   IsSvbIohp4FYR4tbHu+4+ju/0qlgCovC0zNPiW+8ABqP3xN6HORsochBu
   3VOneq+AU9Px90Xzon9c8SnY09ymAszh+IWZOh6N+arsmlQVNQU8P+S2c
   mkj9suXn1Kz/aGxe6rFxtUA+2u61U4S0gZ9/MXDnN4Xfqc4karvHC/Crt
   w==;
X-CSE-ConnectionGUID: dmyz0RvIQ6KcEeqoXpSHSw==
X-CSE-MsgGUID: j62A9CGYQo2oyZ00+jq+LQ==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="35717397"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 05:38:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 05:38:03 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 05:37:59 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ramon.nordin.rodriguez@ferroamp.se>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parthiban.veerasooran@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: [PATCH net-next v3 4/7] net: phy: microchip_t1s: move LAN867X reset handling to a new function
Date: Tue, 1 Oct 2024 18:07:31 +0530
Message-ID: <20241001123734.1667581-5-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001123734.1667581-1-parthiban.veerasooran@microchip.com>
References: <20241001123734.1667581-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Move LAN867X reset handling code to a new function called
lan867x_check_reset_complete() which will be useful for the next patch
which also uses the same code to handle the reset functionality.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 3dd09684692d..a874ac87ce10 100644
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


