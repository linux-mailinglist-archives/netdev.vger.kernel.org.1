Return-Path: <netdev+bounces-194701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB43ACBF92
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 07:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717763A3518
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 05:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F771EF38E;
	Tue,  3 Jun 2025 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fi+a92lH"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E702C326F;
	Tue,  3 Jun 2025 05:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748928582; cv=none; b=E2b7zriryq3dXwbkz1gY/D8xqSExuQauMtfPQ8+KwdQYcyzdG3XNWoY9IeKokwtkDcJUq/c9OPbDfwxeUqJWRbs8/0mn+O7LwhPTVrPMWKFBAoK6uowAQ1fCSgJqJi4jBndzE1uV73DVBnMZT3tSWLYHWmgigXeIUZnCTOt9utg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748928582; c=relaxed/simple;
	bh=FVvPK8h0pt4OOCYiVjpauZS/S4Aq6B9t4g5/nw1c0dw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i9l7vt3z9r89roHs+3mc9wrfqMiZZrVkYehWovuW9j5tpRYaftdjTvwSTC0VFJMOLerxl932/lcs6lFpWx6PponBUiiEwOos7ChTe0eGDxIcVLoN+eThg2OXUr+uiHLJy+qZ9MlejNbXIjPIkHgzx/aaevlDcCx61RbCAUnQk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fi+a92lH; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5535TIIL430371;
	Tue, 3 Jun 2025 00:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748928559;
	bh=oCpKJYDKyOh9iO5kBO1NfGGB6dheG+z5/VPdxwXJobc=;
	h=From:To:CC:Subject:Date;
	b=fi+a92lHbLVrq2YnaqNviHppEFf/eISIPHL6ZdS/CfAB1PnI2L7lmka7xATXPZpgZ
	 cBWOoVW/ZyBDLUsDtuTW6iATxfn9YNe6Md8sB/2mEqfTqKLj8hCWDxZcK9cq0ld2ze
	 YJ2Ch+2TIwt/lOfUSxHl1OTjYawRqVuhH2BCfZHw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5535TIhW3504182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 3 Jun 2025 00:29:18 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Jun 2025 00:29:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Jun 2025 00:29:18 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5535TIOG4130382;
	Tue, 3 Jun 2025 00:29:18 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 5535TG0o020130;
	Tue, 3 Jun 2025 00:29:17 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <m-malladi@ti.com>, <horms@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v2] net: ti: icssg-prueth: Fix swapped TX stats for MII interfaces.
Date: Tue, 3 Jun 2025 10:59:04 +0530
Message-ID: <20250603052904.431203-1-m-malladi@ti.com>
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

v2-v1:
- Include a comment along with the bug fix as suggested by Simon Horman <horms@kernel.org>

v1: https://lore.kernel.org/all/20250527121325.479334-1-m-malladi@ti.com/

 drivers/net/ethernet/ti/icssg/icssg_stats.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index e8241e998aa9..7159baa0155c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -28,6 +28,14 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 	spin_lock(&prueth->stats_lock);
 
 	for (i = 0; i < ARRAY_SIZE(icssg_all_miig_stats); i++) {
+		/* In MII mode TX lines are swapped inside ICSSG, so read Tx stats
+		 * from slice1 for port0 and slice0 for port1 to get accurate Tx
+		 * stats for a given port
+		 */
+		if (emac->phy_if == PHY_INTERFACE_MODE_MII &&
+		    icssg_all_miig_stats[i].offset >= ICSSG_TX_PACKET_OFFSET &&
+		    icssg_all_miig_stats[i].offset <= ICSSG_TX_BYTE_OFFSET)
+			base = stats_base[slice ^ 1];
 		regmap_read(prueth->miig_rt,
 			    base + icssg_all_miig_stats[i].offset,
 			    &val);

base-commit: 558428921eddbd5083fe8116e31b8af460712f44
-- 
2.43.0


