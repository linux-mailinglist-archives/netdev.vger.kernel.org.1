Return-Path: <netdev+bounces-125896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 898D596F293
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D25B20CF8
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631F71CBE9F;
	Fri,  6 Sep 2024 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="do7CVmkc"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09F1CBE84;
	Fri,  6 Sep 2024 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621371; cv=none; b=spUlO/nUCN3BdrMCzJ0SHXVMXVvu4AmTQb4KAa/atpJUofA1VVqsKXBNQb5piOhpWCTDfmUDeEA+cpdt7/+g0ANjsJ6Fi3T6ap1KjH4vvyUHjxxzzA0xIDl+uryk1VYn+kKuIy+YeitCq8w2tIgsEMSp09ppeGFwTe3K6L0/pUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621371; c=relaxed/simple;
	bh=6aptd3NSunEtrKSEWFRzT8/8Z69iK4d+mAKKQUuJ2Kc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNvKLsecjZpkkFA4qpdLXeTtcuoGw9Gk2ow7iIDjSRu2LvFadp8zUR9TLH9bXW+nFJQ28oB1CTU0h8B5eOzyX8QPsuA5b3phWRwCh+S2EO0573OM98qAtFjiX4wz3b+VBUZIrkU3tXB2qpRlWFYeWoqJWJoZTA3RSxwDnqBg2vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=do7CVmkc; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 486BFpRG069148;
	Fri, 6 Sep 2024 06:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725621351;
	bh=F4n26HCPewH5Tbp604TeFPz7Neb+UpE9pxR8ZiIE8LY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=do7CVmkcTfia9diXv/8X3kT9Q4m06Ey4w8zwDZ2zc0/0pmDfRBuAnJqNqAr9mF0JU
	 WFJEw7Pu7CMypYJAfwE+rMfT6J6wr+cdKL2wjK+PbKLRBGMYLFtKNfGs5+BDiegKXD
	 71b2E9OgogbVP6WMgjO3jIS50v1o2MCZcmosdi4o=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 486BFpGM016857
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Sep 2024 06:15:51 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Sep 2024 06:15:51 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Sep 2024 06:15:51 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 486BFptA042829;
	Fri, 6 Sep 2024 06:15:51 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 486BFoco002333;
	Fri, 6 Sep 2024 06:15:51 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <robh@kernel.org>, <jan.kiszka@siemens.com>, <dan.carpenter@linaro.org>,
        <saikrishnag@marvell.com>, <andrew@lunn.ch>,
        <javier.carrasco.cruz@gmail.com>, <jacob.e.keller@intel.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <richardcochran@gmail.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v5 5/5] net: ti: icssg-prueth: Add multicast filtering support in HSR mode
Date: Fri, 6 Sep 2024 16:45:38 +0530
Message-ID: <20240906111538.1259418-6-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906111538.1259418-1-danishanwar@ti.com>
References: <20240906111538.1259418-1-danishanwar@ti.com>
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

Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 42 +++++++++++++++++++-
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 9af06454ba64..a8200ee79a89 100644
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


