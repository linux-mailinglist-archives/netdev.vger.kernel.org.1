Return-Path: <netdev+bounces-170175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F19A47900
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F04F3A9338
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DD3227BAA;
	Thu, 27 Feb 2025 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qhirS1rO"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036522759C;
	Thu, 27 Feb 2025 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648311; cv=none; b=icLULDCcjPjRe6RXSZpQKR1f2ZCEPiINly3nvRvD0ghhCwjZPDJjwvqLe49XvNgmOoatBCZ1EFu0dIWqbrP63ETThqsVrAHiZSB4sbg1sUD5uLtM6E6SuJ3NuwkqwRl2MXc6MXAIH7SXN9HzYPOpccl7C5Z3XhD09Ngo5MAk8m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648311; c=relaxed/simple;
	bh=TXH1iDxMPBPOhdKgbVUchJa533iVq7dQDi9A8ARUcPc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QMJ8geiUnpiEOdWmy20hrl2mrSeV7JEn5mDxfxYz0Y7NlqvhZ9fDObhhg9WeSVCn4hrJ6Q/D/da+9MlqX0sJwzH4aXGVrU+6uI2/X3KqvbnSxmXVqRUsnLb2dC825LoCy7FodJAEM/AxrHaGuf9tgfIecmyA/hu2f7OI8V9awy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qhirS1rO; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51R9Ojp01812919
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 03:24:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740648285;
	bh=KCA7vGFgUuQ6upLklkqCE5dso0EBiAyQ0+h7Nfrm9ZA=;
	h=From:To:CC:Subject:Date;
	b=qhirS1rO4NBwn4fLqAR+jtMezepnp8TErgeDiH5TLSq6jcmlymYl2pP3aqabN5rc7
	 ZNsVnQ0BtUgpMdrEcDMlHIyShJs/nYVIT9pjksAltzkSLiwjp4j7rK9Lzoq8Hf6MHF
	 lTepNIkNIMaEdjEQ6jFJnDFjE2aMSPwtn1NTAO0M=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51R9Ojtd100312
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Feb 2025 03:24:45 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 03:24:44 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 03:24:45 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51R9Oigi120722;
	Thu, 27 Feb 2025 03:24:44 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 51R9OhMj005119;
	Thu, 27 Feb 2025 03:24:44 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vigneshr@ti.com>, <javier.carrasco.cruz@gmail.com>, <m-malladi@ti.com>,
        <jacob.e.keller@intel.com>, <diogo.ivo@siemens.com>,
        <horms@kernel.org>, <richardcochran@gmail.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net] net: ti: icss-iep: Reject perout generation request
Date: Thu, 27 Feb 2025 14:54:41 +0530
Message-ID: <20250227092441.1848419-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

IEP driver supports both perout and pps signal generation
but perout feature is faulty with half-cooked support
due to some missing configuration. Remove perout
support from the driver and reject perout requests with
"not supported" error code.

Fixes: c1e0230eeaab2 ("net: ti: icss-iep: Add IEP driver")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

This patch is a bug fix to disable/remove a faulty feature, which will be
enabled separately as a feature addition to net-next, as suggested by
Jakub Kicinski and Jacob Keller:
https://lore.kernel.org/all/20250220172410.025b96d6@kernel.org/

 drivers/net/ethernet/ti/icssg/icss_iep.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 768578c0d958..d59c1744840a 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -474,26 +474,7 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
 static int icss_iep_perout_enable(struct icss_iep *iep,
 				  struct ptp_perout_request *req, int on)
 {
-	int ret = 0;
-
-	mutex_lock(&iep->ptp_clk_mutex);
-
-	if (iep->pps_enabled) {
-		ret = -EBUSY;
-		goto exit;
-	}
-
-	if (iep->perout_enabled == !!on)
-		goto exit;
-
-	ret = icss_iep_perout_enable_hw(iep, req, on);
-	if (!ret)
-		iep->perout_enabled = !!on;
-
-exit:
-	mutex_unlock(&iep->ptp_clk_mutex);
-
-	return ret;
+	return -EOPNOTSUPP;
 }
 
 static void icss_iep_cap_cmp_work(struct work_struct *work)

base-commit: 29b036be1b0bfcfc958380d5931325997fddf08a
-- 
2.43.0


