Return-Path: <netdev+bounces-77478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E9B871E4B
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8461F24049
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ECB58123;
	Tue,  5 Mar 2024 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="o18mOHR1"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4FB5676D
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639542; cv=none; b=F5gW2UOWkrNNPa//J2HdwbRJ7B+xcoHIisQGUepoE+rLvtkSzNXo+Q18fZePY4N5LsBL6z982ERs2SIxGhWetsW+zUQ3Y1fMq0yt3+1KbUGheu7O/WdqV5AVqXZAcOqcBzP+TJvId9hgZV4ifW49Qkcl0VR3GxGXhZzQw3qowNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639542; c=relaxed/simple;
	bh=ZXkZCxy2ryW+fkb7EusDrQGzEq9I614lCyPnR6b+B0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/2VhjBEXnJJi3RxHZWskL1KTpKlqTLaKgpWLlFfT/dDY5XDP4NefOfrPBknU++sQ8yCMurV8/ot4j37Ra7H0y6miGaOEh9W4s+ZLXu/Q3ej/J8ciLHqGvWNHZwcncmAw4d+tBtXZCyGWZZAtW3XSEf82jGhcdi5dHUuTBpnsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=o18mOHR1; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202403051141088622610efcec8eed19
        for <netdev@vger.kernel.org>;
        Tue, 05 Mar 2024 12:41:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ptD2dLutRxUnJaepSeqWoe0hX2xcdxTnigGW82YsIzo=;
 b=o18mOHR1tZVIbFY7Y3afuI2WhQA8r+U0N4BgjDRQxRRJAGee3NMjAoxw3gSlMvwGqRTfDg
 QEXoJ33LeaLyof/x4zWEaLR7LVczxf34Z1EKu+r3YqeBhmZ9BE7znpcEfA2UiQO4mPJOVgmo
 FzpbiAuNlLDTvgmqqCMLRHLG8tfoM=;
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
Subject: [PATCH net-next v4 06/10] net: ti: icssg-prueth: Adjust IPG configuration for SR1.0
Date: Tue,  5 Mar 2024 11:40:26 +0000
Message-ID: <20240305114045.388893-7-diogo.ivo@siemens.com>
In-Reply-To: <20240305114045.388893-1-diogo.ivo@siemens.com>
References: <20240305114045.388893-1-diogo.ivo@siemens.com>
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
---
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


