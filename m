Return-Path: <netdev+bounces-116792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 724BE94BBF8
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B21B21A1F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0645918C34D;
	Thu,  8 Aug 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wDObhFiC"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBD418C32B;
	Thu,  8 Aug 2024 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115309; cv=none; b=OqX0HfwSXjUVsgXdHRL0JhXuzaFCWBr5aJsvjhHMvpWyqm0NR76faUGR2Kp9AtpeF+VeLZNU12wONafNF86LZPVHWRo7CMk2OpVLABJPMyS0avtfKat+4MMxt0wdRaO3rCqwsFFiLBoVDEXS4ptisweAomhJHfBbI68LVXnQWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115309; c=relaxed/simple;
	bh=dkHrlZ8cnZIRu6+k/09dceV4xJqjMLZ57uoKcrIjH0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGnWP0DN4ObpM+6Z5gfgPG49cIgnoRFRf75qpYOwAepRINN0D46MzhjGExfl98nWlwVmn4OO7h1VfFGi1XvX6gvU2BjEHKqBUnUA263JkYnsviiNAVhOKKhyqYVyfZtITPtK1xbjl4Z0R7ak9zjUHugDt6fkM43b5Ozk2Eh/Ir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wDObhFiC; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478B85hD121883;
	Thu, 8 Aug 2024 06:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723115285;
	bh=unFGtIaLV852e7NhQ88rKDTvf4aXBnMYM/ojLpB9pCg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wDObhFiC9wTvQcNl86pIimGk2BZ6Dce6A9GldXrb2vxo9T0O1gp3EyOs0gvlrmWIa
	 OE9/LYPCsZohWCS+hHALn5Z/RKbEAPLgytgZuuL4vftnvo8krD+lh3s+VQG0147anb
	 RBH1ZiIkX4qH2de91Td1Ut36aCEvMmMrK9wzfzWw=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478B85Qa017878
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 06:08:05 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 06:08:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 06:08:05 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478B85vu087519;
	Thu, 8 Aug 2024 06:08:05 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 478B84Kw011988;
	Thu, 8 Aug 2024 06:08:04 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Diogo
 Ivo <diogo.ivo@siemens.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon
 Horman <horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
Subject: [PATCH net-next 1/6] net: ti: icssg-prueth: Enable IEP1
Date: Thu, 8 Aug 2024 16:37:55 +0530
Message-ID: <20240808110800.1281716-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808110800.1281716-1-danishanwar@ti.com>
References: <20240808110800.1281716-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

IEP1 is needed by firmware to enable FDB learning and FDB ageing.
Always enable IEP1

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 9dc9de39bb8f..c61423118319 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1255,12 +1255,8 @@ static int prueth_probe(struct platform_device *pdev)
 		goto put_iep0;
 	}
 
-	if (prueth->pdata.quirk_10m_link_issue) {
-		/* Enable IEP1 for FW in 64bit mode as W/A for 10M FD link detect issue under TX
-		 * traffic.
-		 */
-		icss_iep_init_fw(prueth->iep1);
-	}
+	/* Enable IEP1 for FW as it's needed by FW for FDB Learning and FDB ageing */
+	icss_iep_init_fw(prueth->iep1);
 
 	/* setup netdev interfaces */
 	if (eth0_node) {
@@ -1365,8 +1361,7 @@ static int prueth_probe(struct platform_device *pdev)
 	}
 
 exit_iep:
-	if (prueth->pdata.quirk_10m_link_issue)
-		icss_iep_exit_fw(prueth->iep1);
+	icss_iep_exit_fw(prueth->iep1);
 	icss_iep_put(prueth->iep1);
 
 put_iep0:
@@ -1423,8 +1418,7 @@ static void prueth_remove(struct platform_device *pdev)
 		prueth_netdev_exit(prueth, eth_node);
 	}
 
-	if (prueth->pdata.quirk_10m_link_issue)
-		icss_iep_exit_fw(prueth->iep1);
+	icss_iep_exit_fw(prueth->iep1);
 
 	icss_iep_put(prueth->iep1);
 	icss_iep_put(prueth->iep0);
-- 
2.34.1


