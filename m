Return-Path: <netdev+bounces-80837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D4A88139A
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 15:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86462830E8
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E0B524B7;
	Wed, 20 Mar 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="OsMHOQyv"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64D4DA12
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945779; cv=none; b=BpfurmefT4u3ovXByzclJdNPelnTPWbch9RIoNUYUFNLRQUG2YfUrfkRii/QGGaK7qyUmUMz5di2+by7YXiI+eFYVo9QNqB1HVbvkJgdFwKSBvtOrtI0MOe+iJHLRLOBnN0E5IKrf9R3GIFKrwT/yJRbtDIBcF3Gcta4Rbn8FIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945779; c=relaxed/simple;
	bh=fZhlyuxqVjXMSDmanTdyjkJjnF24BId3QTE44sycCFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jxu1rsXNIFs08Gbx9lbmNzcvCiAKP5bvHWREaV45ptcOPsBf76jdAToekCDEK0/lS3/LcGFU9uvC6TggXX5qHZD6haS731fe54/ySsNvQstEGd2tHeCNXtdepo82filqK1ZhkWQs/huxjN9clk2SFzvo6F8Zp2kkLmU42Mzvg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=OsMHOQyv; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202403201442545e151e6b80b781e1e7
        for <netdev@vger.kernel.org>;
        Wed, 20 Mar 2024 15:42:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=i9EuIKJ+Vnn+Q5+e2Ldg3hHmhPjZ55BBwH6LBJTz9Mk=;
 b=OsMHOQyv4bZM/MfwccSE8tE9OyrI3z1QLl5wzJmjTa33khJIOhFX8TGfRBwISvwTWJsw61
 Q8Z2L+osEY8SIFdaPy/mJK9VY1c4msZ8nDi2LCq/z73Zj5dcW80CPuBoJpVm1ttUzdOilTNC
 8aQ7FGEq/6tpJpWZuclV1SXO6cCXE=;
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
Subject: [PATCH net-next v5 05/10] net: ti: icssg-prueth: Add SR1.0-specific description bits
Date: Wed, 20 Mar 2024 14:42:27 +0000
Message-ID: <20240320144234.313672-6-diogo.ivo@siemens.com>
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
Changes in v5: 
 - Added Reviewed-by tag from Danish 

Changes in v4:
 - Change cmd_data type to __le32 to eliminate sparse warnings
 - Add Reviewed-by from Roger (assuming the above change does not
   invalidate it)

 drivers/net/ethernet/ti/icssg/icssg_prueth.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 5d792e9bade0..c5632a2388a1 100644
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
+	u32 lo_ts;
+	u32 hi_ts;
+	u32 reserved;
+	u32 cookie;
+};
+
 /* get PRUSS SLICE number from prueth_emac */
 static inline int prueth_emac_slice(struct prueth_emac *emac)
 {
-- 
2.44.0


