Return-Path: <netdev+bounces-81981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F022C88C033
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72101B236B0
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF374E1C6;
	Tue, 26 Mar 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="QAIy8vps"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703847A6F
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451244; cv=none; b=ZgmyH8rYD67S0/DgIuo9RoKVw6MNWxa5AwR0U29FRIZGgXea52ToyCpsMM5BIJaYmMGnZW7RDUzIt1HUM4vbxtXN5meLG3j4jVSyMNTyzjzORk7mdJyEulK9OLMeOga97obNPRDjKmk2i70gz0Q/9U9jwGRLUUngrVIYVvW7YP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451244; c=relaxed/simple;
	bh=2GBBminJ15j4gdQ6lviuIzg3GH+xtjdJE7NnGYqf5+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpEEyrsmBmFsYaa/JphpCQnUottLPWDMzlUQSenK1dyTo8z3Xs/fGd3sBSFoUF/AqTNTILYD5w0mgaHAgBcKbyW/+Jvmub32KIpQI9ikRq5Al2ROU+xcFSg64la3BKmdjIPI2JlzZJWwpRMARQZLa+S8YQ6L5BbnGVoJ6HYddDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=QAIy8vps; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240326110720147e215d60c7ab12d5
        for <netdev@vger.kernel.org>;
        Tue, 26 Mar 2024 12:07:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3VmQm0kIt8wV3QA830woUaB7ryp/dIwdRhZGmq2NEEA=;
 b=QAIy8vpsj4PRGgWC+9n9H1g4cT5ISwtb/AahL4u0ONnyXB9VefgNwdoV7D7YLhCu6QVZoi
 e1Drn4ByvpVA9w0kZbd3JvFVM1XZOQSnX4aUcrIQloutYHjq9z106cInffpz6FCLUIvTiE9D
 6C/KG+7od/jYYAxVXa5BZKWAMGxdc=;
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
Subject: [PATCH net-next v5 06/10] net: ti: icssg-prueth: Adjust IPG configuration for SR1.0
Date: Tue, 26 Mar 2024 11:06:56 +0000
Message-ID: <20240326110709.26165-7-diogo.ivo@siemens.com>
In-Reply-To: <20240326110709.26165-1-diogo.ivo@siemens.com>
References: <20240326110709.26165-1-diogo.ivo@siemens.com>
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


