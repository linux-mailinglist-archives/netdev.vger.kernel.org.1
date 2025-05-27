Return-Path: <netdev+bounces-193639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A685EAC4E8E
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 14:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F463B72C6
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 12:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E2E267B9B;
	Tue, 27 May 2025 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xobZlwPX"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F63026983B;
	Tue, 27 May 2025 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748348031; cv=none; b=rRr5EMZY0N5wLAIl+NsPd88Tox1HkUqxPQURlSitffHoJoy9G98tThv/3CaF3C0pKYoH+NxTy7gqXRVtXoY9MJKCjLf7LgeNN+yX9RMGQlIZMFUpfqcQ6vqKjO96I1R6zxY/uQh84rBu6ATMRuhvH3IMXXgZK/VivQjxuSe424w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748348031; c=relaxed/simple;
	bh=QaLbeXBPflKCWtj6t7OTS4ckObOJsis6ob4F9IJ2vYM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tRbd8s4fJyCFQ0Ow8m4iNTnRVs1oH6tyTOFv1d2gFL1Nb99GFZuLhin0PYgJQyK1VoXBcSdpyJMzq00FcJkpI+1wT4z/361o0NlCDTiUztWrsWAuiV7el3SN/Gfo88cniLeBd461Pvk+ZaxUHf4eciif16NUBa2rk7ftwZceJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xobZlwPX; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54RCDVTr1817415;
	Tue, 27 May 2025 07:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748348011;
	bh=RwoB/vlUsHP1ZLM3IDcLtLPVLnnKHq3/34iyg4x96t0=;
	h=From:To:CC:Subject:Date;
	b=xobZlwPXiyqJzvN0BooFv9JGwCl9JkSKVob0a0KopxHTELra3rC+b4klVKkUyOVHG
	 GVmBA7hLyBzQ1WNU82DKk92b23uHU8P+6jIGh3H6EgM5AIr2pIhnNO9Pa37cluywc2
	 EUGqkjqWVmqfNZLrTfz+Suw79QFfcQdj9JiJayT0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54RCDUjm2853093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 27 May 2025 07:13:30 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 May 2025 07:13:30 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 May 2025 07:13:30 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54RCDUtW046812;
	Tue, 27 May 2025 07:13:30 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 54RCDSsB020084;
	Tue, 27 May 2025 07:13:29 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <m-malladi@ti.com>, <saikrishnag@marvell.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net] net: ti: icssg-prueth: Fix swapped TX stats for MII interfaces.
Date: Tue, 27 May 2025 17:43:25 +0530
Message-ID: <20250527121325.479334-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

In MII mode, Tx lines are swapped for port0 and port1, which means
Tx port0 receives data from PRU1 and the Tx port1 receives data from
PRU0. This is an expected hardware behavior and reading the Tx stats
needs to be handled accordingly in the driver. Update the driver to
read Tx stats from the PRU1 for port0 and PRU0 for port1.

Fixes: c1e10d5dc7a1 ("net: ti: icssg-prueth: Add ICSSG Stats")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_stats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 6f0edae38ea2..0b77930b2f08 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -29,6 +29,10 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 	spin_lock(&prueth->stats_lock);
 
 	for (i = 0; i < ARRAY_SIZE(icssg_all_miig_stats); i++) {
+		if (emac->phy_if == PHY_INTERFACE_MODE_MII &&
+		    icssg_all_miig_stats[i].offset >= ICSSG_TX_PACKET_OFFSET &&
+		    icssg_all_miig_stats[i].offset <= ICSSG_TX_BYTE_OFFSET)
+			base = stats_base[slice ^ 1];
 		regmap_read(prueth->miig_rt,
 			    base + icssg_all_miig_stats[i].offset,
 			    &val);

base-commit: 32374234ab0101881e7d0c6a8ef7ebce566c46c9
-- 
2.43.0


