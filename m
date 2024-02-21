Return-Path: <netdev+bounces-73740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD5285E0FC
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A873B28587B
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A21811F9;
	Wed, 21 Feb 2024 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="LgWU64L4"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5A80C03
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529080; cv=none; b=qrkms0NiWPzzhNdodWfSpUNY1slD57gw1BO8EsRoP88JkxoWtvkhmPNHVw7uBDVM4M2CBcDJsrAGFSnCGTab96aP4Tg+GKLcqYWgRrNzUbAYcKodtLlgBv1sIyr23/maUIpAO7nCbXnGirfPT0xh5zs2hB2ir4/lPvyhkEFmAZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529080; c=relaxed/simple;
	bh=5Wj0Fg8XmK4o0VrjRK8K8GPY1q4c5Tr5T0udwXARsyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEQKzWvTf5tQXlsv51oA+7HyqtIgl7OeBvn/o8zXuFKCeE7CL1iLPJnnRwwjFbVePzrLE2vv8crGldssJhZCv+9GZ4WMWg4EnOKNDHT6h7QeHzwd1vUWfDR3QdDD6QqspqxWLDrjpZmKmaRTjfMFCP8Fcaka7MKO+tZ0WrvNqSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=LgWU64L4; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202402211524317f5ef8036fe790793a
        for <netdev@vger.kernel.org>;
        Wed, 21 Feb 2024 16:24:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FXKziFoTOJtYIGfb44L1UOkVBGYenDwVFISQu0Q4lAs=;
 b=LgWU64L4xOwuFVGtZG5gglaCHFTvtACAMlsG1TTCE1iMzEbuT0qWR9Fqx03DLg2TCN24p7
 TZqEPuA/aWdOOQq11zwPe/ssqlyhtoICTzKYr0Q4eebyQb58NzcR7ExKgdgaGndbNmPKW9Z+
 0KuNvC7cRji1s21TyqWDoTZ6iOoYI=;
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
Subject: [PATCH net-next v3 05/10] net: ti: icssg-prueth: Add SR1.0-specific description bits
Date: Wed, 21 Feb 2024 15:24:11 +0000
Message-ID: <20240221152421.112324-6-diogo.ivo@siemens.com>
In-Reply-To: <20240221152421.112324-1-diogo.ivo@siemens.com>
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
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
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 5d792e9bade0..a8192e408941 100644
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
2.43.2


