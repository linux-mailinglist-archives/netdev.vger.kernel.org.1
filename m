Return-Path: <netdev+bounces-84414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C01E896D91
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 13:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1BFB2B001
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 10:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136AC142E78;
	Wed,  3 Apr 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="INDHXsRh"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF013AA35
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141926; cv=none; b=l5bwA1C6XIpE1oJutqQPDMZHEzKksqyVpC1INUSPU67dlhD84ZmG+/gJ+13nfLO9mePc7lWlAquHFz7RW3E9KeF00wx1M7auAwRvWAj7YYeE6rrByZi7tQ2c+AbdGRooXGonsNq3dmxRFYSCRZrMvTd3Yw5xPKJPzDio8ETAZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141926; c=relaxed/simple;
	bh=2GBBminJ15j4gdQ6lviuIzg3GH+xtjdJE7NnGYqf5+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSWmf12vnVZM136OwfPyLrrNXwlg11BcNinV696Y/Mq2VUw77mq9XNxt2yhJe6AELZvIdfs+YlIiAXT6S1WYBYRYcjnr1VNyf2Gms8xaFs4ZlaB2rmwlSwNqQtmAqCVi9Wc5k8tpDm3aomlnelrI1XjWU0V/+Tf8sEDDvI/aYv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=INDHXsRh; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240403104832fb2cd02fc1d668f3d2
        for <netdev@vger.kernel.org>;
        Wed, 03 Apr 2024 12:48:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3VmQm0kIt8wV3QA830woUaB7ryp/dIwdRhZGmq2NEEA=;
 b=INDHXsRhtCkG/pb+jE8E1mvrFRZNgFg0lr6GGWigW07uk0iHaStYAh6otafVGA5s8fMMKC
 4158d3C0QJ/g5Fxd3dWdy/cv1PWBmlbxKWNkb8Y4wAK21uXmakGDxq965qmSgS7uVVRKfzUU
 cpwr+A/ZuUvP3xLN0lBImxFiw+WCc=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	jan.kiszka@siemens.com
Subject: [PATCH net-next v6 06/10] net: ti: icssg-prueth: Adjust IPG configuration for SR1.0
Date: Wed,  3 Apr 2024 11:48:16 +0100
Message-ID: <20240403104821.283832-7-diogo.ivo@siemens.com>
In-Reply-To: <20240403104821.283832-1-diogo.ivo@siemens.com>
References: <20240403104821.283832-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Correctly adjust the IPG based on the Silicon Revision.

Based on the work of Roger Quadros, Vignesh Raghavendra
and Grygorii Strashko in TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
---
Changes in v5: 
 - Added Reviewed-by tag from Danish 

Changes in v4:
 - Add Reviewed-by from Roger

 drivers/net/ethernet/ti/icssg/icssg_config.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 99de8a40ed60..15f2235bf90f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -20,6 +20,8 @@
 /* IPG is in core_clk cycles */
 #define MII_RT_TX_IPG_100M	0x17
 #define MII_RT_TX_IPG_1G	0xb
+#define MII_RT_TX_IPG_100M_SR1	0x166
+#define MII_RT_TX_IPG_1G_SR1	0x1a
 
 #define	ICSSG_QUEUES_MAX		64
 #define	ICSSG_QUEUE_OFFSET		0xd00
@@ -202,23 +204,29 @@ void icssg_config_ipg(struct prueth_emac *emac)
 {
 	struct prueth *prueth = emac->prueth;
 	int slice = prueth_emac_slice(emac);
+	u32 ipg;
 
 	switch (emac->speed) {
 	case SPEED_1000:
-		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_1G);
+		ipg = emac->is_sr1 ? MII_RT_TX_IPG_1G_SR1 : MII_RT_TX_IPG_1G;
 		break;
 	case SPEED_100:
-		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_100M);
+		ipg = emac->is_sr1 ? MII_RT_TX_IPG_100M_SR1 : MII_RT_TX_IPG_100M;
 		break;
 	case SPEED_10:
+		/* Firmware hardcodes IPG for SR1.0 */
+		if (emac->is_sr1)
+			return;
 		/* IPG for 10M is same as 100M */
-		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_100M);
+		ipg = MII_RT_TX_IPG_100M;
 		break;
 	default:
 		/* Other links speeds not supported */
 		netdev_err(emac->ndev, "Unsupported link speed\n");
 		return;
 	}
+
+	icssg_mii_update_ipg(prueth->mii_rt, slice, ipg);
 }
 
 static void emac_r30_cmd_init(struct prueth_emac *emac)
-- 
2.44.0


