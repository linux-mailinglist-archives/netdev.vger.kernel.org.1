Return-Path: <netdev+bounces-127256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DF5974C57
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFEEEB25A6A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09A617BEB2;
	Wed, 11 Sep 2024 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sM3br0HH"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07976176AB7;
	Wed, 11 Sep 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042600; cv=none; b=XwdAtKSq/uuo5d6jZYCpRT2+r9OCm9/BBiVldRi0yv9svFhdCPjC+13oKx5F26S8Yc/Ew63iKv1x4K+RW7+jAFooCPm2JYu9LM6AgVNsa0GwHPzQWIgsP7BFgchmlZTJFNA9jHYFfyhIfNFlOnCKSK7H1XqTIIEuiWx2AcqCY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042600; c=relaxed/simple;
	bh=+EhiXfjekpgT0VLHAzj7N5j48j2+DAxRBt8As2/Zq68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqnAHPGLgpkhPwjXleaZGcJ3kLU7sOWED1C/G4yqGju26qeQlxFeb5yQp7cLFMMTmdqdffL5uUTMwlETr45hOtNFqjgvNgfrmTQlzxIg9kt1ON2j+fku0mS8N5Bc7Us3mZGYU+yH8Q4azKlA6i4gr6YWMONnkWOr6b+YDfPNx5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sM3br0HH; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48B8GFZv118258;
	Wed, 11 Sep 2024 03:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726042575;
	bh=yscrjvl685iBwaRaUT3rrUeddgprbh3eZUg/cMYniFs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sM3br0HHo9IoRoN6XV5Ai7JJTIFqAuO9giSjcSQ3n5YSp7RkleCP0+26B34XBuA4U
	 S3yxsfaNbiSLdFQicxFRCzd/i5qcbIRvZgwALpaMCxkteYvkGA9LGjnm9LAYFP0jdf
	 TNKvUlbxPwxv+JtwzC9KSa0c0EH/3gMINTlLq10A=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48B8GFhl021374
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Sep 2024 03:16:15 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Sep 2024 03:16:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Sep 2024 03:16:15 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48B8GF61043561;
	Wed, 11 Sep 2024 03:16:15 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 48B8GEul032153;
	Wed, 11 Sep 2024 03:16:14 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <robh@kernel.org>, <jan.kiszka@siemens.com>, <dan.carpenter@linaro.org>,
        <r-gunasekaran@ti.com>, <saikrishnag@marvell.com>, <andrew@lunn.ch>,
        <javier.carrasco.cruz@gmail.com>, <jacob.e.keller@intel.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <richardcochran@gmail.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v6 5/5] net: ti: icssg-prueth: Add multicast filtering support in HSR mode
Date: Wed, 11 Sep 2024 13:46:03 +0530
Message-ID: <20240911081603.2521729-6-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911081603.2521729-1-danishanwar@ti.com>
References: <20240911081603.2521729-1-danishanwar@ti.com>
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
index d128764982ae..5fd9902ab181 100644
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


