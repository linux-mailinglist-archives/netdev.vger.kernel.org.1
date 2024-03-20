Return-Path: <netdev+bounces-80836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88509881397
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 15:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97821C218FB
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B574F8BD;
	Wed, 20 Mar 2024 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="NPMJSDFJ"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA904D9E6
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945778; cv=none; b=K0Wy6eRFCCdBgPiTGskhnk2FYPjpSEl95IYzhHOe0zPRVEqfARTsH1mZVs7AOqVAnv+NsWysHzyBt+kogx+ZM58MbO7IEwAIlu8JxeyPEuzfmK32Z+6pdIWTgdcvIvzdwAFeq03mN+dk1w/eHEbhWgYW/BMyjkAMhyOOZvX+4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945778; c=relaxed/simple;
	bh=2GBBminJ15j4gdQ6lviuIzg3GH+xtjdJE7NnGYqf5+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmJHPngZZ6YUzqsfq3qMvShMU2B0HDBzN7otFKEjZo18tBcoikCNhGvFhBafxTLmvxjYTZX2ZK1SVG33fTJkldEISeIoV/KZyMkR0Qg09aFmbXHGB9eKvtTt2Bs/F30AT1E2UEK5fzdDU1cvKjqtqM7FuVJUb3NZYoA74Jgqo58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=NPMJSDFJ; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202403201442561abde3fe8fa4f8ad67
        for <netdev@vger.kernel.org>;
        Wed, 20 Mar 2024 15:42:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3VmQm0kIt8wV3QA830woUaB7ryp/dIwdRhZGmq2NEEA=;
 b=NPMJSDFJWv5kRvN97GEUGQOhqHn3mBuUZR18VN1LvTEVJvETrVRaeE6AtJExtAW8nEheV1
 BTbV8dxkwImsb9Up84Uai4RFM4cUSLJnu9BKZeG+/+QMRsWTf/QAApvM5lERSKOdzRUB3LaB
 IM8LVst1n5hSZ6r/UARBFWhoXcdjY=;
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
Date: Wed, 20 Mar 2024 14:42:28 +0000
Message-ID: <20240320144234.313672-7-diogo.ivo@siemens.com>
In-Reply-To: <20240320144234.313672-1-diogo.ivo@siemens.com>
References: <20240320144234.313672-1-diogo.ivo@siemens.com>
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


