Return-Path: <netdev+bounces-171589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CA1A4DBB7
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984713B265E
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DC21FFC48;
	Tue,  4 Mar 2025 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UkKqzxOk"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B09820468F;
	Tue,  4 Mar 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085919; cv=none; b=hSaPfwj810Hj8OSKPINL+YOpmJ4YY+oY0uqKGUNNxVfu2eJ7g5vv61xoAk9HwuvRH3KnNx2Z/KuxGpNV3POcMWCkqPRSv1gHUGZVJYyn/UwOlv+U8bdz8Jeq5LSuT0mNt3sDqI7cv7DvT5MSk0yUvPChcfwvVyWgiHGj7BnagFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085919; c=relaxed/simple;
	bh=nchUryzcicM8roedQgtIOnXzJ+bqicXSPLLzX1Zrd88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b98UBtKGJYMA92gVCZwaoRq/+lUDPZAsYistX+2FBwj/+6XoYlL1Pmt/0P/L/59+nZZ/twXiw86AUpyoqb1WjLTtm+exIl3Drqks95rI6WR3vW7L9gQCicJVfDiqsIqvYV63p32GyehItuwcKNNDcM7UEJsyImi1/Gmg9ZBzMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UkKqzxOk; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 524AwJw13576389
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 04:58:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741085899;
	bh=wRUzk5bTqm01beKg6HwXEmAMeVCJrPaBDA9inMAHOZs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UkKqzxOkPYEOwVCJelWNuGrtv5f8xbjxAg5TamFF7mw8ItEHQ1+F0Gn10w5E7lWSY
	 O+K8U7FGC/8f0JpAMc5sVcMMNGwXmxpqLyyDMGfrAmrUoxtf/+eaSWuZJr4lIP/rwd
	 vZRt3rFrF3kt6yMz4EJDXoulbUjCrKYH91wGsMQE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 524AwJkX036192
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Mar 2025 04:58:19 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Mar 2025 04:58:18 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Mar 2025 04:58:18 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 524AwIdP097457;
	Tue, 4 Mar 2025 04:58:18 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 524AwHAQ017609;
	Tue, 4 Mar 2025 04:58:18 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
        <m-malladi@ti.com>, <horms@kernel.org>, <richardcochran@gmail.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Kory Maincent
	<kory.maincent@bootlin.com>
Subject: [PATCH net-next v4 2/2] net: ti: icss-iep: Add phase offset configuration for perout signal
Date: Tue, 4 Mar 2025 16:27:53 +0530
Message-ID: <20250304105753.1552159-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304105753.1552159-1-m-malladi@ti.com>
References: <20250304105753.1552159-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

icss_iep_perout_enable_hw() is a common function for generating
both pps and perout signals. When enabling pps, the application needs
to only pass enable/disable argument, whereas for perout it supports
different flags to configure the signal.

In case the app passes a valid phase offset value, the signal should
start toggling after that phase offset, else start immediately or
as soon as possible. ICSS_IEP_SYNC_START_REG register take number of
clock cycles to wait before starting the signal after activation time.
Set appropriate value to this register to support phase offset.

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes from v3 (v4-v3):
- Move flag checks out of mutex lock as suggested by Kory Maincent <kory.maincent@bootlin.com>
- Collected RB tag from Kory Maincent <kory.maincent@bootlin.com>

 drivers/net/ethernet/ti/icssg/icss_iep.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 2981c19c48b1..b4a34c57b7b4 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -407,6 +407,7 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
 				     struct ptp_perout_request *req, int on)
 {
 	struct timespec64 ts;
+	u64 ns_start;
 	u64 ns_width;
 	int ret;
 	u64 cmp;
@@ -416,6 +417,14 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
 	ts.tv_nsec = req->on.nsec;
 	ns_width = timespec64_to_ns(&ts);
 
+	if (req->flags & PTP_PEROUT_PHASE) {
+		ts.tv_sec = req->phase.sec;
+		ts.tv_nsec = req->phase.nsec;
+		ns_start = timespec64_to_ns(&ts);
+	} else {
+		ns_start = 0;
+	}
+
 	if (iep->ops && iep->ops->perout_enable) {
 		ret = iep->ops->perout_enable(iep->clockops_data, req, on, &cmp);
 		if (ret)
@@ -430,7 +439,8 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
 			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
 				     div_u64(ns_width, iep->def_inc));
 			regmap_write(iep->map, ICSS_IEP_SYNC0_PERIOD_REG, 0);
-			regmap_write(iep->map, ICSS_IEP_SYNC_START_REG, 0);
+			regmap_write(iep->map, ICSS_IEP_SYNC_START_REG,
+				     div_u64(ns_start, iep->def_inc));
 			regmap_write(iep->map, ICSS_IEP_SYNC_CTRL_REG, 0); /* one-shot mode */
 			/* Enable CMP 1 */
 			regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
@@ -457,6 +467,8 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
 
 			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
 				     div_u64(ns_width, iep->def_inc));
+			regmap_write(iep->map, ICSS_IEP_SYNC_START_REG,
+				     div_u64(ns_start, iep->def_inc));
 			/* Enable Sync in single shot mode  */
 			regmap_write(iep->map, ICSS_IEP_SYNC_CTRL_REG,
 				     IEP_SYNC_CTRL_SYNC_N_EN(0) | IEP_SYNC_CTRL_SYNC_EN);
@@ -487,7 +499,8 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
 	int ret = 0;
 
 	/* Reject requests with unsupported flags */
-	if (req->flags & ~PTP_PEROUT_DUTY_CYCLE)
+	if (req->flags & ~(PTP_PEROUT_DUTY_CYCLE |
+			  PTP_PEROUT_PHASE))
 		return -EOPNOTSUPP;
 
 	mutex_lock(&iep->ptp_clk_mutex);
@@ -588,6 +601,7 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 	if (on) {
 		ns = icss_iep_gettime(iep, NULL);
 		ts = ns_to_timespec64(ns);
+		rq.perout.flags = 0;
 		rq.perout.period.sec = 1;
 		rq.perout.period.nsec = 0;
 		rq.perout.start.sec = ts.tv_sec + 2;
-- 
2.43.0


