Return-Path: <netdev+bounces-122695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A60962342
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E502845B7
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685F616BE1B;
	Wed, 28 Aug 2024 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kkSNvDsh"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC501607B4;
	Wed, 28 Aug 2024 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836784; cv=none; b=g8sduJeNq6zv4n538TO1UcIHJHGKpngY2hRXP/OuIPpLjTg8h5UfhHWJpfLFrDduOxshur8IWm6z5UO+Rica5deKNNRW23xaU9BcKyF5rEHgDqLxuP86+eFQ4dYsuhFTwGKQfpaV+yuDUmuXWiKQd3cqg0HArTw2dUMfnCznoBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836784; c=relaxed/simple;
	bh=rTQKd76fVdc+eaqO723X1opEkEIT9N/7ew3yHbfBXgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgZizDK4vbIR/YX4RxqHJOAisWY55SwfFCV7Ig8eh+7waJVIWlYLIsOTu1i2iFBD8CyZp6zd3QfbXIaiLtXquLLz/LDksXCfjpiCrIuq5BusukFUNm1wpE6HdDJR7/B9qCEVQ7u5+ybFYKkFZCGYQT2eTz2fsy2AoCGv/ZjzvrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kkSNvDsh; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47S9JEOG030814;
	Wed, 28 Aug 2024 04:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724836754;
	bh=MMM/RwPCyeUW4nnmo8JvztFlXiC7x900C/43CTkfogk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kkSNvDshpTxc8Jf2mccWTwkyKr6YCc9ClDFPeleQsEQlqBc4jITrRaW4niODiDlz4
	 /kc8y0B0RgXxJbEjFfZvyWpuCMLBej0VdL9ClSHPGEDwMH+GLbNZgmgwFvJKgXFLRj
	 27CYIDp3++RilGKOWfrCxmFwDbZs5Y8Vi2ZNsto4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47S9JE4G117814
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 04:19:14 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 04:19:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 04:19:13 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47S9JEJe127058;
	Wed, 28 Aug 2024 04:19:14 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47S9JDMp007487;
	Wed, 28 Aug 2024 04:19:13 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew@lunn.ch>, Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Javier Carrasco
	<javier.carrasco.cruz@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v3 5/6] net: ti: icssg-prueth: Add multicast filtering support in HSR mode
Date: Wed, 28 Aug 2024 14:49:00 +0530
Message-ID: <20240828091901.3120935-6-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828091901.3120935-1-danishanwar@ti.com>
References: <20240828091901.3120935-1-danishanwar@ti.com>
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
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 42 +++++++++++++++++++-
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index b60efe7bd7a7..ecc342bcc1b5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -490,6 +490,36 @@ static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
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
@@ -650,7 +680,10 @@ static int emac_ndo_stop(struct net_device *ndev)
 
 	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
 
-	__dev_mc_unsync(ndev, icssg_prueth_del_mcast);
+	if (emac->prueth->is_hsr_offload_mode)
+		__dev_mc_unsync(ndev, icssg_prueth_hsr_del_mcast);
+	else
+		__dev_mc_unsync(ndev, icssg_prueth_del_mcast);
 
 	atomic_set(&emac->tdown_cnt, emac->tx_ch_num);
 	/* ensure new tdown_cnt value is visible */
@@ -728,7 +761,12 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
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


