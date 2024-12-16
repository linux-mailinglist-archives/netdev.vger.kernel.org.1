Return-Path: <netdev+bounces-152141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0A59F2DAD
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0501889194
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9730D201110;
	Mon, 16 Dec 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yje4NHgs"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA11DDC21;
	Mon, 16 Dec 2024 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343300; cv=none; b=soa2aHMAiUkpSSEjfFN3q157jMxKJRatavnSe5sync75ebBbmKaYm5ZzJldKw5blJSmwVD+uFlBf7y3AaM6spxgLgzn8D3MMT4j6pTj2eTjUGZmJjG59KXENLR9tV0qvuulgXy2aPRQypcW+FVIPJ8LIWx2nZ0+fVWZpmiu8m4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343300; c=relaxed/simple;
	bh=/cMS1jvFoQnB2Sl4pS1kic8uPrck7SK8CfSo2KkXOpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akhnc1AM04TajJihZ9c3pI2G8wTLTxmqxNXjy5CrToi+VBLtSKt92zJnYlzXxGSej6jLzOFGAKEQ9qxXXQqudVVj7mEhu5XZkHWbsP8qsTcO5iVQJrcUH1AnXYO/YRBMitl9n1kIAr2JJ1KCVLLzK9j7kSHoBgogvfl8v+owvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Yje4NHgs; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BGA0vwO3794076
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 16 Dec 2024 04:00:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734343257;
	bh=PKFvxnaUtZIq4z8ojsgFldqznVIvmDuULSreEtH0U88=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Yje4NHgsYMA1gTeiRuI/Nsqp+OnhzgMLQRTiI40Lnp/lqlc3LBnJ8Y/GZ2daFKHIf
	 KPQ1Upl6ITcBr8t9WRtxRuxN4rMje4X8gZMB+OqqRloTtI5JEdRGuH7NTc4kUs+9nG
	 QbkEmbFfssCb435QzSnlLgdIf4VBYdm2PW8atypY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BGA0vBB095920;
	Mon, 16 Dec 2024 04:00:57 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Dec 2024 04:00:57 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Dec 2024 04:00:57 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BGA0vv1079571;
	Mon, 16 Dec 2024 04:00:57 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4BGA0uXF000622;
	Mon, 16 Dec 2024 04:00:56 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <aleksander.lobakin@intel.com>, <lukma@denx.de>, <m-malladi@ti.com>,
        <diogo.ivo@siemens.com>, <rdunlap@infradead.org>,
        <schnelle@linux.ibm.com>, <vladimir.oltean@nxp.com>,
        <horms@kernel.org>, <rogerq@kernel.org>, <danishanwar@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next 1/4] net: ti: Kconfig: Select HSR for ICSSG Driver
Date: Mon, 16 Dec 2024 15:30:41 +0530
Message-ID: <20241216100044.577489-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216100044.577489-1-danishanwar@ti.com>
References: <20241216100044.577489-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

HSR offloading is supported by ICSSG driver. Select the symbol HSR for
TI_ICSSG_PRUETH. Also select NET_SWITCHDEV instead of depending on it to
remove recursive dependency.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 0d5a862cd78a..ad366abfa746 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -187,8 +187,9 @@ config TI_ICSSG_PRUETH
 	select PHYLIB
 	select TI_ICSS_IEP
 	select TI_K3_CPPI_DESC_POOL
+	select NET_SWITCHDEV
+	select HSR
 	depends on PRU_REMOTEPROC
-	depends on NET_SWITCHDEV
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	depends on PTP_1588_CLOCK_OPTIONAL
 	help
-- 
2.34.1


