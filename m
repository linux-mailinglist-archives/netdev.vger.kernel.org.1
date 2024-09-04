Return-Path: <netdev+bounces-124981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1415696B7CE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E90B25A3E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705C01D0164;
	Wed,  4 Sep 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RDaIuZk0"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36F41D0148;
	Wed,  4 Sep 2024 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444347; cv=none; b=EUzw5TaUl5MMMBlhz6nEoEjhZe16p90JpXvXISqewGJaZvAsnKfNF5aJSUJ+NvFcbSl/FhfrI9Eg9fvjipC06B3zMI5A5C8k839j8iLrXNEEhh1cyVEK8RMge8uQUXFQmJQ0Zn4L2e+Un55LsHwI1+Ox+Yb6BH/mKq5FcIiPn10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444347; c=relaxed/simple;
	bh=tr5e5PtP7qsxD5kCFOheL+VA55HsD6EksiPhYw4urdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZ5waSVrPnbCnH0LWrmVpRXzJeawpLVSxC3Uza5Yh515mWKos/OJNk5sVUux28bbYxEI8xuD8EgJ0/7ud9wA3E7hbaY+PrGf+Upo7M7aebIgahzE59gK04UP+OV5xBY4ZFjel/LJuwDca3foGX5d0ULtHtyQBiAZ8f6PBJ8fVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RDaIuZk0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 484A5ICo092784;
	Wed, 4 Sep 2024 05:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725444318;
	bh=SLGSSWdm0/NpuMM7l2G8hjHi9lfVBKZfDv2c9sdtF3E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RDaIuZk0kkHpilOj7e8QsjKFJdEIuQSnpdJf4G7l+OR2aSsRClN/1x3pdHn+ydE9N
	 CwsfuSsHmb6gZRqraNKWLaltSFLRLh5OFxeUnztPLUcimdKT5Aca7T1rk7gUcAObfl
	 5Wb5oKj/BO6U9zfbUwGZGmy3UJ1aOrgMwycI4nZk=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 484A5ImM059692
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Sep 2024 05:05:18 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Sep 2024 05:05:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Sep 2024 05:05:17 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 484A5HpM029548;
	Wed, 4 Sep 2024 05:05:17 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 484A5GdW015390;
	Wed, 4 Sep 2024 05:05:17 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Sai Krishna <saikrishnag@marvell.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Javier Carrasco
	<javier.carrasco.cruz@gmail.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon
 Horman <horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v4 5/5] net: ti: icssg-prueth: Add multicast filtering support in HSR mode
Date: Wed, 4 Sep 2024 15:35:06 +0530
Message-ID: <20240904100506.3665892-6-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904100506.3665892-1-danishanwar@ti.com>
References: <20240904100506.3665892-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add support for multicast filtering in HSR mode

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 42 +++++++++++++++++++-
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 49b855ae62a4..76ccfd79f45f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -492,6 +492,36 @@ static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
 	return 0;
 }
 
+static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+
+	icssg_fdb_add_del(emac, addr, prueth->default_vlan,
+			  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
+			  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
+			  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
+			  ICSSG_FDB_ENTRY_BLOCK, true);
+
+	icssg_vtbl_modify(emac, emac->port_vlan, BIT(emac->port_id),
+			  BIT(emac->port_id), true);
+	return 0;
+}
+
+static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+
+	icssg_fdb_add_del(emac, addr, prueth->default_vlan,
+			  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
+			  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
+			  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
+			  ICSSG_FDB_ENTRY_BLOCK, false);
+
+	return 0;
+}
+
 /**
  * emac_ndo_open - EMAC device open
  * @ndev: network adapter device
@@ -652,7 +682,10 @@ static int emac_ndo_stop(struct net_device *ndev)
 
 	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
 
-	__dev_mc_unsync(ndev, icssg_prueth_del_mcast);
+	if (emac->prueth->is_hsr_offload_mode)
+		__dev_mc_unsync(ndev, icssg_prueth_hsr_del_mcast);
+	else
+		__dev_mc_unsync(ndev, icssg_prueth_del_mcast);
 
 	atomic_set(&emac->tdown_cnt, emac->tx_ch_num);
 	/* ensure new tdown_cnt value is visible */
@@ -730,7 +763,12 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
 		return;
 	}
 
-	__dev_mc_sync(ndev, icssg_prueth_add_mcast, icssg_prueth_del_mcast);
+	if (emac->prueth->is_hsr_offload_mode)
+		__dev_mc_sync(ndev, icssg_prueth_hsr_add_mcast,
+			      icssg_prueth_hsr_del_mcast);
+	else
+		__dev_mc_sync(ndev, icssg_prueth_add_mcast,
+			      icssg_prueth_del_mcast);
 }
 
 /**
-- 
2.34.1


