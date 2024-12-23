Return-Path: <netdev+bounces-154012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EC99FABF2
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 10:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682C21885C48
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 09:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A669F192D86;
	Mon, 23 Dec 2024 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ggFw+YUH"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3270192D7C;
	Mon, 23 Dec 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734945998; cv=none; b=EOkymD9FKeE2hxK4ABLz0UvwI5cVqMiu4yKWeGdH9Xkus3uOrHH+gjcytBZJVOFaIHrp2R1jrdmNdweByuSz1DkS5x+9FOFHKuxZNGy9lKZ+YxvfxLAuGigf2svY0oDiBI01+QPaQK5guCacB10El5YQU4neNyy7DJIPGHgWFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734945998; c=relaxed/simple;
	bh=3UzWjtIaAwa2DD6rZO7+eEEVfPTpZkalqepZqNVboEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDlGJhh3px90A+ahLj5Z9lUOcW3Ma9PDD5tDTlrqqpu9n6ZOBF4FE0xSnOshAwLuboO8AfmLXrg0+f7yGWkeZzgLdPSCEMPbtL590MKCp/bZADcxYaUN1ftRKC5gyY7NtAVBojj4wLDSpGPoWcAkLYUCWR3gCcT5kQpZf+YeONE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ggFw+YUH; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BN9Q3JU856692
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 03:26:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734945963;
	bh=dBhfzVNPoQY702/fU5BRMtzSyvCNkOs9LmubC0XHVK4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ggFw+YUHA4/1UqxcqEz4De3AINXPz9ThEZQiJIZ10a7RgZ47cebK/S+YX/718L32V
	 BXrrKpzEhVwSk39NjfS2299vZvC4Xi7YhyKXKFZ969X7QjoRy97x7LU2WcIZ3i/C8c
	 r22MA//4mTmY3LdzmzEzQ0BZ9CQM4Ccge1fE2A54=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BN9Q3Yn013531
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Dec 2024 03:26:03 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Dec 2024 03:26:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Dec 2024 03:26:02 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BN9Q2vB127941;
	Mon, 23 Dec 2024 03:26:02 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4BN9Q1Jq006694;
	Mon, 23 Dec 2024 03:26:02 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <wojciech.drewek@intel.com>, <n.zhandarovich@fintech.ru>,
        <aleksander.lobakin@intel.com>, <lukma@denx.de>, <m-malladi@ti.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: [PATCH net-next v2 1/3] net: ti: icssg-prueth: Add VLAN support in EMAC mode
Date: Mon, 23 Dec 2024 14:55:55 +0530
Message-ID: <20241223092557.2077526-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223092557.2077526-1-danishanwar@ti.com>
References: <20241223092557.2077526-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add support for vlan filtering in dual EMAC mode.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 29 +++++++++-----------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index c568c84a032b..1663941e59e3 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -822,19 +822,18 @@ static int emac_ndo_vlan_rx_add_vid(struct net_device *ndev,
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 	struct prueth *prueth = emac->prueth;
+	int port_mask = BIT(emac->port_id);
 	int untag_mask = 0;
-	int port_mask;
 
-	if (prueth->is_hsr_offload_mode) {
-		port_mask = BIT(PRUETH_PORT_HOST) | BIT(emac->port_id);
-		untag_mask = 0;
+	if (prueth->is_hsr_offload_mode)
+		port_mask |= BIT(PRUETH_PORT_HOST);
 
-		netdev_dbg(emac->ndev, "VID add vid:%u port_mask:%X untag_mask %X\n",
-			   vid, port_mask, untag_mask);
+	netdev_dbg(emac->ndev, "VID add vid:%u port_mask:%X untag_mask %X\n",
+		   vid, port_mask, untag_mask);
+
+	icssg_vtbl_modify(emac, vid, port_mask, untag_mask, true);
+	icssg_set_pvid(emac->prueth, vid, emac->port_id);
 
-		icssg_vtbl_modify(emac, vid, port_mask, untag_mask, true);
-		icssg_set_pvid(emac->prueth, vid, emac->port_id);
-	}
 	return 0;
 }
 
@@ -843,18 +842,16 @@ static int emac_ndo_vlan_rx_del_vid(struct net_device *ndev,
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 	struct prueth *prueth = emac->prueth;
+	int port_mask = BIT(emac->port_id);
 	int untag_mask = 0;
-	int port_mask;
 
-	if (prueth->is_hsr_offload_mode) {
+	if (prueth->is_hsr_offload_mode)
 		port_mask = BIT(PRUETH_PORT_HOST);
-		untag_mask = 0;
 
-		netdev_dbg(emac->ndev, "VID del vid:%u port_mask:%X untag_mask  %X\n",
-			   vid, port_mask, untag_mask);
+	netdev_dbg(emac->ndev, "VID del vid:%u port_mask:%X untag_mask  %X\n",
+		   vid, port_mask, untag_mask);
+	icssg_vtbl_modify(emac, vid, port_mask, untag_mask, false);
 
-		icssg_vtbl_modify(emac, vid, port_mask, untag_mask, false);
-	}
 	return 0;
 }
 
-- 
2.34.1


