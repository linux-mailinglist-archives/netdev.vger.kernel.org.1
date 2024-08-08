Return-Path: <netdev+bounces-116791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1AF94BBF6
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5582828FF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869E718C342;
	Thu,  8 Aug 2024 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LXC753Oj"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579D145B25;
	Thu,  8 Aug 2024 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115309; cv=none; b=m5+o9lBCo8s7twxfHU362BT62jhSgFrnJedGFtZ4NZvdY+cnDAAdftAaO+pT9WyKj1h9Cb/jxA2Cej9OnYuuX0XmHOCivc9XrsD3MwKfqJEjs0rOzGd2mYk3XolA187t+b0kDDymvysj0lmTAe9v9LP9DBFc1AklB2fSIjRQ3UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115309; c=relaxed/simple;
	bh=+CrdIvK8T24OraHA00by/zaJymelJ7zF6SvEuzWpEQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/fn9R+05E0rT7bp7F2tqQdnYB5lmAqnHzVBnAQYj2bm7uIwDNIa5oC3GQW/snhFanelQF7QlRQAzI41rfIWAR36FLYwh3qSi5vVf3C6ZsFuJywrv79lJjTf5P0jZUrJ9V5YVKed2rhyAmFgZfyWG9DaM9PyZMK74WEUtqJqq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LXC753Oj; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478B8Brd053047;
	Thu, 8 Aug 2024 06:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723115291;
	bh=fwLk2uzzdwf9KT17kW8Vu72MmRxvrXhBgLNVmqPyznQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LXC753OjYepOY13MhSd7hndVF3Rqr9g0KlO6080UNott+Cn355kqGam62M/4inhv/
	 vj+XXT7QPbKHQXz1SRDTILepoHQxFoe11eW6tfun1td1p8HN5QpbrtGVTRgX8TvJTg
	 0RU2if02Ih5wcj1f26bA4i29Y18J80/2mjpoBInI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478B8BWe017918
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 06:08:11 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 06:08:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 06:08:10 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478B8ATs087638;
	Thu, 8 Aug 2024 06:08:10 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 478B8AkG012006;
	Thu, 8 Aug 2024 06:08:10 -0500
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
Subject: [PATCH net-next 4/6] net: ti: icssg-prueth: Add multicast filtering support in HSR mode
Date: Thu, 8 Aug 2024 16:37:58 +0530
Message-ID: <20240808110800.1281716-5-danishanwar@ti.com>
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

Add support for multicast filtering in HSR mode

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 38 +++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 657bf1b4e5ec..85c9797b6238 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -489,6 +489,36 @@ static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
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
@@ -650,6 +680,7 @@ static int emac_ndo_stop(struct net_device *ndev)
 	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
 
 	__dev_mc_unsync(ndev, icssg_prueth_del_mcast);
+	__dev_mc_unsync(ndev, icssg_prueth_hsr_del_mcast);
 
 	atomic_set(&emac->tdown_cnt, emac->tx_ch_num);
 	/* ensure new tdown_cnt value is visible */
@@ -727,7 +758,12 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
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


