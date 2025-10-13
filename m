Return-Path: <netdev+bounces-228684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C776ABD22F1
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 10:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADBED4EEDE4
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 08:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287D52DF139;
	Mon, 13 Oct 2025 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PBlOQTQI"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E622157B;
	Mon, 13 Oct 2025 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345991; cv=none; b=gPdyS8us/GVIIygOsiKARnx6Z1sjwXfPWNvZCxAsEJk1tFPMdgXzaDQUg1yDSqVM3BMilYEE7NC9Lm+v/SANuxLmS+bP2C3UR0taGD1T+tRPRbV99733V9Vdjl0ki1wiAMeIec/SyZPAgaIg4/UYYzqt9FLqJaS24WyuAeujdBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345991; c=relaxed/simple;
	bh=dQCX89rdgPzg4jBUl3wrvYTOH2c6sohap5lRrNoxgu0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=umPnuY9Tkhu7B/SoNpDlzc6+8Pg6jIHxblVgHRtczhdrfOQsqXsl2q0PnUpKg84SAlXvAwwiTv1+ZUtFNRjz+qoCHCMXa0y5yKtE4HcalSD9MDsgfeWj/Esw7h8O+Ui/5zCs/FrJmzr9rr2xqacktQbKHBBP3keZ6e7urkOD7WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PBlOQTQI; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59D8xVmL1225224;
	Mon, 13 Oct 2025 03:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760345971;
	bh=03eLz1BO3ywqvR4VvhSI4Ov3l5NVQWBbzVASFhLKhgU=;
	h=From:To:CC:Subject:Date;
	b=PBlOQTQIGCtbTnoUi7ay58pugJ67F5ZxNZdaE+TaWraiKo1Wjh1yIOkebBQqO5l6N
	 lBQ+ZrS4JjV/0F4+bxYseMqAZeZnepIpZW53jtzAYC/vloOdkbVJljD3Gi9Cvy6P64
	 WZ/ua5uSWE8DXDA2Kz0w9sr8uVlUQDIvvyZvfTfE=
Received: from DFLE207.ent.ti.com (dfle207.ent.ti.com [10.64.6.65])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59D8xV1X3693355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Oct 2025 03:59:31 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Oct
 2025 03:59:31 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 03:59:31 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59D8xVoX1669656;
	Mon, 13 Oct 2025 03:59:31 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 59D8xTUB024754;
	Mon, 13 Oct 2025 03:59:30 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <horms@kernel.org>, <m-malladi@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net] net: ti: icssg-prueth: Fix fdb hash size configuration
Date: Mon, 13 Oct 2025 14:29:25 +0530
Message-ID: <20251013085925.1391999-1-m-malladi@ti.com>
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

The ICSSG driver does the initial FDB configuration which
includes setting the control registers. Other run time
management like learning is managed by the PRU's. The default
FDB hash size used by the firmware is 512 slots which is not
aligned with the driver's configuration. Update the driver
FDB config to fix it.

Fixes: abd5576b9c57f ("net: ti: icssg-prueth: Add support for ICSSG switch firmware")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

Please refer trm [1] 6.4.14.12.17 section
on how the FDB config register gets configured.

[1]: https://www.ti.com/lit/pdf/spruim2

 drivers/net/ethernet/ti/icssg/icssg_config.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index da53eb04b0a4..3f8237c17d09 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -66,6 +66,9 @@
 #define FDB_GEN_CFG1		0x60
 #define SMEM_VLAN_OFFSET	8
 #define SMEM_VLAN_OFFSET_MASK	GENMASK(25, 8)
+#define FDB_HASH_SIZE_MASK	GENMASK(6, 3)
+#define FDB_HASH_SIZE_SHIFT	3
+#define FDB_HASH_SIZE		3
 
 #define FDB_GEN_CFG2		0x64
 #define FDB_VLAN_EN		BIT(6)
@@ -463,6 +466,8 @@ void icssg_init_emac_mode(struct prueth *prueth)
 	/* Set VLAN TABLE address base */
 	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
 			   addr <<  SMEM_VLAN_OFFSET);
+	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, FDB_HASH_SIZE_MASK,
+			   FDB_HASH_SIZE << FDB_HASH_SIZE_SHIFT);
 	/* Set enable VLAN aware mode, and FDBs for all PRUs */
 	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, (FDB_PRU0_EN | FDB_PRU1_EN | FDB_HOST_EN));
 	prueth->vlan_tbl = (struct prueth_vlan_tbl __force *)(prueth->shram.va +
@@ -484,6 +489,8 @@ void icssg_init_fw_offload_mode(struct prueth *prueth)
 	/* Set VLAN TABLE address base */
 	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
 			   addr <<  SMEM_VLAN_OFFSET);
+	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, FDB_HASH_SIZE_MASK,
+			   FDB_HASH_SIZE << FDB_HASH_SIZE_SHIFT);
 	/* Set enable VLAN aware mode, and FDBs for all PRUs */
 	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, FDB_EN_ALL);
 	prueth->vlan_tbl = (struct prueth_vlan_tbl __force *)(prueth->shram.va +

base-commit: 68a052239fc4b351e961f698b824f7654a346091
-- 
2.43.0


