Return-Path: <netdev+bounces-142248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9499BDF9D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D00284AD5
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BAF1D2709;
	Wed,  6 Nov 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hwqcRC9H"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC336190470;
	Wed,  6 Nov 2024 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878903; cv=none; b=b0rTY4Zh/Yv78ycBFHgPt3Zy8fKp6HsXj8LWJXvYQmlTvDovay/mV7LW1GLHxbr139ZaadaWkN35HfSjfMjxxYB6FPudb3vKYvZx0oZZ3cgwal1FnzqM54fVumAYUYSSs//B9Xkj+kq4kECJzBz6Nq69CyrG38d6hOy2SDtI8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878903; c=relaxed/simple;
	bh=FauuGZr/25wEWX1/MTNvKW0A20/su50USz7BG9Hd2gU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLg4d4xqyLsM+goS4DiEtseOBoLCusqpTcqx4i+CIXCoGJov4jKwXeMBOtz7iujYuLgPWZfXQPxwFj0RqCT6VrUms3snHuYMcNq1WSOsfOR5LPnVOjbwRNc+r9MX6fBXd0PQiqeVcN72vLFnt8HWGJ0Vwt/FtzkLIbx3lLO+qXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hwqcRC9H; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A67fRg1018043;
	Wed, 6 Nov 2024 01:41:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730878887;
	bh=SEQBMpZUNFN1GW+nwD1YAozhMyyk0AV9Osd490Zj6Zo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hwqcRC9HUMJLbqtyzj+WAftG0w9BGPaCK7I47LdY83xYPXtqOGsh+JStMX5UvsWmQ
	 CEhU93NQiS1/gcyuxlcNIF86NeuKT0JCibukP5fjM5nAFOpxl64iOBpPk2gy7wOLQZ
	 FCj8cT0RXdJUN8Puv4zip7PF9yQZF9QLlD8iZd04=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A67fRRb111576;
	Wed, 6 Nov 2024 01:41:27 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 01:41:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 01:41:26 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A67fQht024993;
	Wed, 6 Nov 2024 01:41:26 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4A67fPV2014472;
	Wed, 6 Nov 2024 01:41:26 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vigneshr@ti.com>, <m-karicheri2@ti.com>, <m-malladi@ti.com>,
        <jan.kiszka@siemens.com>, <javier.carrasco.cruz@gmail.com>,
        <jacob.e.keller@intel.com>, <horms@kernel.org>,
        <diogo.ivo@siemens.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net 2/2] net: ti: icssg-prueth: Fix clearing of IEP_CMP_CFG registers during iep_init
Date: Wed, 6 Nov 2024 13:10:40 +0530
Message-ID: <20241106074040.3361730-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106074040.3361730-1-m-malladi@ti.com>
References: <20241106074040.3361730-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

When ICSSG interfaces are brought down and brought up again, the
pru cores are shut down and booted again, flushing out all the memories
and start again in a clean state. Hence it is expected that the
IEP_CMP_CFG register needs to be flushed during iep_init() to ensure
that the existing residual configuration doesn't cause any unusual
behavior. If the register is not cleared, existing IEP_CMP_CFG set for
CMP1 will result in SYNC0_OUT signal based on the SYNC_OUT register values.

After bringing the interface up, calling PPS enable doesn't work as
the driver believes PPS is already enabled, (iep->pps_enabled is not
cleared during interface bring down) and driver  will just return true
even though there is no signal. Fix this by setting the iep->pps_enable
and iep->perout_enable flags to false during the link down.

Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 5d6d1cf78e93..03abc25ced12 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -195,6 +195,12 @@ static void icss_iep_enable_shadow_mode(struct icss_iep *iep)
 
 	icss_iep_disable(iep);
 
+	/* clear compare config */
+	for (cmp = IEP_MIN_CMP; cmp < IEP_MAX_CMP; cmp++) {
+		regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
+				   IEP_CMP_CFG_CMP_EN(cmp), 0);
+	}
+
 	/* disable shadow mode */
 	regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
 			   IEP_CMP_CFG_SHADOW_EN, 0);
@@ -778,6 +784,10 @@ int icss_iep_exit(struct icss_iep *iep)
 		ptp_clock_unregister(iep->ptp_clock);
 		iep->ptp_clock = NULL;
 	}
+
+	iep->pps_enabled = false;
+	iep->perout_enabled = false;
+
 	icss_iep_disable(iep);
 
 	return 0;
-- 
2.25.1


