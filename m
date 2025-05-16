Return-Path: <netdev+bounces-191033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F75AB9C01
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 14:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC887AAC75
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 12:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A2023D29C;
	Fri, 16 May 2025 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dizg8vMt"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386023BCFD;
	Fri, 16 May 2025 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398439; cv=none; b=VZVQPWEXRsjm/aF/PYZpvBgxIe1muKPbvU97CttXbyYMWMR7/e1O+Gz4yTv28lFvQNJ5rR5unYrAfdUv4a0NufwxeibYRO2xql3i5OsdmDwta8MLJaUnRH/rSKAoLhTNmLmil118Q7Hv6NH5o8OLyuyDbZcJb3gBGKwCX0HjBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398439; c=relaxed/simple;
	bh=2rdGqXw7AfrRRaOQP+na8kTQVMdvqlpLUB82mSFCUGQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qBxmvwnCcwOmcnn6dnr4wB+GItozk6bigI60pmWFPaBmh9zXjqBOrS3mNPIQ0Pk9MSSDEZCLNc9AfWxxeIVswv++q02JUYG1Wh909HKLFC4FEn5rTG67CEzoXMGVHSLtudtKm4FoqTo1eg7kEMKRcBOsNdd4VNiWTDcxugXYf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Dizg8vMt; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54GCQuQE304622;
	Fri, 16 May 2025 07:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747398416;
	bh=TbvbuPGxlecn7wtqGTgeAXKNkgtiSVnlsBSL6kZYvN8=;
	h=From:To:CC:Subject:Date;
	b=Dizg8vMt1vpw2wm3cGLAykypSOUdcDSHIBCRwtC1OoQiRLazosCHDmSsZs+GKJrec
	 pIDTE1b3SgJntcXSy1LhVsRSu4IpDp99zfEUDVAc+Rlv78zuaHbjMyJCOAgEehHwpz
	 H6k4fHXQF8vq9L/GNlnBSG4yfvkeAQG4pDXNKfqs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54GCQu9w3280508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 16 May 2025 07:26:56 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 May 2025 07:26:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 May 2025 07:26:55 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54GCQtPa105204;
	Fri, 16 May 2025 07:26:55 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] net: ethernet: ti: am65-cpsw: Lower random mac address error print to info
Date: Fri, 16 May 2025 07:26:55 -0500
Message-ID: <20250516122655.442808-1-nm@ti.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Using random mac address is not an error since the driver continues to
function, it should be informative that the system has not assigned
a MAC address. This is inline with other drivers such as ax88796c,
dm9051 etc. Drop the error level to info level.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

This is esp irritating on platforms such as J721E-IDK-GW which has a
bunch of ethernet interfaces, and not all of them have MAC address
assigned from Efuse.
Example log (next-20250515):
https://gist.github.com/nmenon/8edbc1773c150a5be69f5b700d907ceb#file-j721e-idk-gw-L1588

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 1e6d2335293d..30665ffe78cf 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2685,7 +2685,7 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 							port->slave.mac_addr);
 			if (!is_valid_ether_addr(port->slave.mac_addr)) {
 				eth_random_addr(port->slave.mac_addr);
-				dev_err(dev, "Use random MAC address\n");
+				dev_info(dev, "Use random MAC address\n");
 			}
 		}
 
-- 
2.47.0


