Return-Path: <netdev+bounces-117934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4FF94FF01
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD46F1C2251E
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 07:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B713170A03;
	Tue, 13 Aug 2024 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Du12wlz4"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABDB13AD16;
	Tue, 13 Aug 2024 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534996; cv=none; b=o+ciSzBWhO1bYu9RYz+tZuz7nZ+UwQP1/mxnCpj1tio+9TNVv1rxp6HpFsYPdkTJRTiqi5PY2tDGNdtJ0u/hMYLazA+uqPLgx4yHampM4mNAQVT3A9xnuW+tRi8PGCGiz/p8ELTFC4KQM/wDaSvQCFeLI2hsNBddwsw6OJZK/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534996; c=relaxed/simple;
	bh=9s+3xaJBbwHb9C+wu9VXfez3rks7CNhLZAuywepH7HY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdFQ7QHe7jwxrkfz6/NfaUTpEO9XOPjrXUDKqdKW/2YDsgtT651bZsaytrpO1YHYi136HMyL0umpVhGrxnt44rvs4wMrKl23ba8Dvv4sjoYVbWN+Qy0Y7ozk0OFo4RODlK5Bs30T4bRKmWp15OpU081IPaZwe1WRheV8nB0dpxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Du12wlz4; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47D7gcPe119101;
	Tue, 13 Aug 2024 02:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723534958;
	bh=NCPtPO0MqDaWJYgs7//uxS+xHxRG49uQMHSjCZMNdck=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Du12wlz49B3vDgpkjFzYoIFyuduRBmoodBtXrguyaorT6IKqYCAmj5TCudezwC6Al
	 DU6+IYdN0opg0sLWkGRAmvE6oJawgBeDHgt3sbr2RNxbxxrWoTP0j88IjzT4UqjZen
	 eXIdhLAUNtlVAprSy4AzO+bNRh6zxoYko4fpu9Sk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47D7gcQt031419
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 02:42:38 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 02:42:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 02:42:38 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47D7gcHv073015;
	Tue, 13 Aug 2024 02:42:38 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47D7gbZq008713;
	Tue, 13 Aug 2024 02:42:37 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v2 1/7] net: ti: icssg-prueth: Enable IEP1
Date: Tue, 13 Aug 2024 13:12:27 +0530
Message-ID: <20240813074233.2473876-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813074233.2473876-1-danishanwar@ti.com>
References: <20240813074233.2473876-1-danishanwar@ti.com>
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
index 53a3e44b99a2..613bd8de6eb8 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1256,12 +1256,8 @@ static int prueth_probe(struct platform_device *pdev)
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
@@ -1366,8 +1362,7 @@ static int prueth_probe(struct platform_device *pdev)
 	}
 
 exit_iep:
-	if (prueth->pdata.quirk_10m_link_issue)
-		icss_iep_exit_fw(prueth->iep1);
+	icss_iep_exit_fw(prueth->iep1);
 	icss_iep_put(prueth->iep1);
 
 put_iep0:
@@ -1424,8 +1419,7 @@ static void prueth_remove(struct platform_device *pdev)
 		prueth_netdev_exit(prueth, eth_node);
 	}
 
-	if (prueth->pdata.quirk_10m_link_issue)
-		icss_iep_exit_fw(prueth->iep1);
+	icss_iep_exit_fw(prueth->iep1);
 
 	icss_iep_put(prueth->iep1);
 	icss_iep_put(prueth->iep0);
-- 
2.34.1


