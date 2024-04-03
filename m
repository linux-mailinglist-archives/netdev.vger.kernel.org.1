Return-Path: <netdev+bounces-84415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC77896D8B
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 13:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4621B2B07F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96FB142E8E;
	Wed,  3 Apr 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="Cuq0a9sf"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533211411DA
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141926; cv=none; b=Bjc7Hd30XDB8sYheBy2X1QknLLAmdqeTgvfo0MjG2WiQRhfEbSCdzVZLZvey8mHL0h2IxFT/63J2EMmY1ATOX5jZ5XtPlfDu4hOGw/hes2cZcg4cFQ3Zg1OEGU6AhUdFeDOsFx8cQ8/gVatC2Kfk3zoGt7Gxx2q2XkmAu+HR2HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141926; c=relaxed/simple;
	bh=sWnpZd63eZkt8JTWxBA0ZoQ5xlFgQ31NifH4QkifGzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClQktAGCkHwYvhHYD1brw152EbD4H/hynttpUPzpHeHo/8kXcCcSB1MXF0kGCe8UiDyGX8EWRQaCmcTnP6hOGljnkWSAVl5JGjGtkRvlcw+f4bHPST2YPiFmHq62C2FN1WfLJEvQy+6ysa6crewykoLAGq+++Tv8em3ZAaRlbVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=Cuq0a9sf; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202404031048312f64fbd8c8abca9c3a
        for <netdev@vger.kernel.org>;
        Wed, 03 Apr 2024 12:48:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DYzKmj6q9ZWVhSQofQIWNCMywiBc8c8e41SXkfRWaZU=;
 b=Cuq0a9sf1ScsXI2m1st3pSZh8No6+nfKIG8bhRS0k2Vx/W496Fpw4Zejw2tjhMayz0CT44
 m6ArZqe9YMNX12VIUsVWEMBK1Svegn3M9yV8hpMbHkyAQq9HAhlST7LCkJmM2jKgdidb3pmE
 iGR896URZ+WLDLDlJVYQsE+l4wloE=;
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
Subject: [PATCH net-next v6 05/10] net: ti: icssg-prueth: Add SR1.0-specific description bits
Date: Wed,  3 Apr 2024 11:48:15 +0100
Message-ID: <20240403104821.283832-6-diogo.ivo@siemens.com>
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

Add a field to distinguish between SR1.0 and SR2.0 in the driver
as well as the necessary structures to program SR1.0.

Based on the work of Roger Quadros in TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
---
Changes in v6:
 - Declare the fields in struct emac_tx_ts_response_sr1 as __le32
   to correctly interpret them from the hardware

Changes in v5: 
 - Added Reviewed-by tag from Danish 

Changes in v4:
 - Change cmd_data type to __le32 to eliminate sparse warnings
 - Add Reviewed-by from Roger (assuming the above change does not
   invalidate it)

 drivers/net/ethernet/ti/icssg/icssg_prueth.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 5d792e9bade0..4632d83d4732 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -129,6 +129,7 @@ struct prueth_rx_chn {
 
 /* data for each emac port */
 struct prueth_emac {
+	bool is_sr1;
 	bool fw_running;
 	struct prueth *prueth;
 	struct net_device *ndev;
@@ -157,6 +158,10 @@ struct prueth_emac {
 	int rx_flow_id_base;
 	int tx_ch_num;
 
+	/* SR1.0 Management channel */
+	struct prueth_rx_chn rx_mgm_chn;
+	int rx_mgm_flow_id_base;
+
 	spinlock_t lock;	/* serialize access */
 
 	/* TX HW Timestamping */
@@ -167,7 +172,7 @@ struct prueth_emac {
 
 	u8 cmd_seq;
 	/* shutdown related */
-	u32 cmd_data[4];
+	__le32 cmd_data[4];
 	struct completion cmd_complete;
 	/* Mutex to serialize access to firmware command interface */
 	struct mutex cmd_lock;
@@ -251,6 +256,13 @@ struct emac_tx_ts_response {
 	u32 hi_ts;
 };
 
+struct emac_tx_ts_response_sr1 {
+	__le32 lo_ts;
+	__le32 hi_ts;
+	__le32 reserved;
+	__le32 cookie;
+};
+
 /* get PRUSS SLICE number from prueth_emac */
 static inline int prueth_emac_slice(struct prueth_emac *emac)
 {
-- 
2.44.0


