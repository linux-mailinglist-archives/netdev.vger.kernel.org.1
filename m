Return-Path: <netdev+bounces-211344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D4B18197
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 14:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFEA563603
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4687247283;
	Fri,  1 Aug 2025 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="REiPAhwZ"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC53246765;
	Fri,  1 Aug 2025 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754050809; cv=none; b=VxTZjjQq0xfr3V5UGWT4GUO0lMc6AhOlIDwXlZyReMeLIowWdsnzvxDW1T7BExW8CWYKLvsacNZnMPY/8wI8TNTW6zEADtWD5TCPBfT9Ujto03UychqyizM7HV9aqEvwJcy8MotXEQqBe6K3KgXR0A3aokPvdLsR3IGe+TZa2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754050809; c=relaxed/simple;
	bh=iROPkrsXYZXrNDsn7b1cjF9839szWqzNnNNDV+KxiG0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b/pIkF0ZHHFHZoRJd0T0NuZGtnj8X4r7JG23rpNP91fSDoFozFmB3vPUbc0TLNq2DnBkqkkzj4d65As5xh2lnCo2Egnf2yPinCmmD2Y4fhtFAeA/2O2WhhqrHRi/8dYtuee8hR4w3q2rMZy6sJLUxcPHsX5ntVVYaxgf5ldsbA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=REiPAhwZ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 571CJqg83727254;
	Fri, 1 Aug 2025 07:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754050793;
	bh=PgHY7KIZFZ8t2DI4sOYMaRrOgbk3f1xCaugWWVlTH9w=;
	h=From:To:CC:Subject:Date;
	b=REiPAhwZVjGAKHweiYdMd99mLDJ/RwRnRvUk5V67EBBDYpIiR8uKkOz+Y1K/dJlWm
	 9bMn9PA+pV64TLBB8RVyfG3ReeYN5w/I0mp+i/Nmm5IyDfFccm1HHEWNqlXsPQapCa
	 v01q0Sd0flg1BdJ8BJbFryHFv9Gi7FCB8/28Kpto=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 571CJqRp4083325
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 1 Aug 2025 07:19:52 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 1
 Aug 2025 07:19:52 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 1 Aug 2025 07:19:52 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 571CJqKV251872;
	Fri, 1 Aug 2025 07:19:52 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 571CJooZ009995;
	Fri, 1 Aug 2025 07:19:51 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Meghana Malladi
	<m-malladi@ti.com>,
        Himanshu Mittal <h-mittal1@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v2] net: ti: icssg-prueth: Fix emac link speed handling
Date: Fri, 1 Aug 2025 17:49:48 +0530
Message-ID: <20250801121948.1492261-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

When link settings are changed emac->speed is populated by
emac_adjust_link(). The link speed and other settings are then written into
the DRAM. However if both ports are brought down after this and brought up
again or if the operating mode is changed and a firmware reload is needed,
the DRAM is cleared by icssg_config(). As a result the link settings are
lost.

Fix this by calling emac_adjust_link() after icssg_config(). This re
populates the settings in the DRAM after a new firmware load.

Fixes: 9facce84f406 ("net: ti: icssg-prueth: Fix firmware load sequence.")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
v1 - v2: Added phydev lock before calling emac_adjust_link() as suggested
by Andrew Lunn <andrew@lunn.ch>
v1 https://lore.kernel.org/all/20250731120812.1606839-1-danishanwar@ti.com/

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 2b973d6e2341..58aec94b7771 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -50,6 +50,8 @@
 /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
 #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
 
+static void emac_adjust_link(struct net_device *ndev);
+
 static int emac_get_tx_ts(struct prueth_emac *emac,
 			  struct emac_tx_ts_response *rsp)
 {
@@ -229,6 +231,12 @@ static int prueth_emac_common_start(struct prueth *prueth)
 		ret = icssg_config(prueth, emac, slice);
 		if (ret)
 			goto disable_class;
+
+		if (emac->ndev->phydev) {
+			mutex_lock(&emac->ndev->phydev->lock);
+			emac_adjust_link(emac->ndev);
+			mutex_unlock(&emac->ndev->phydev->lock);
+		}
 	}
 
 	ret = prueth_emac_start(prueth);

base-commit: 01051012887329ea78eaca19b1d2eac4c9f601b5
-- 
2.34.1


