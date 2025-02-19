Return-Path: <netdev+bounces-167625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1AFA3B19C
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 07:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BF33A1CF1
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 06:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A26B1B4153;
	Wed, 19 Feb 2025 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vpt1RadO"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686391AE01B;
	Wed, 19 Feb 2025 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946450; cv=none; b=GYoiwHyW9+aHn5MU/pFd0JRWsP6S6pl7ycLehQZ9RLu3o0It8msBGXTSNOYWHtFjGvQz09ZDr+rjAdr3ze0rjlGA1RTlXdRIGRuUyG5BvAUiYqaejQyzTNcpBGbHjeN0hkFXnfPrjMtKATxm+UUwgRLr+DbQyfRQ2uDhNdBCgQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946450; c=relaxed/simple;
	bh=r+iedKeiScb1dqX8mW7k4+xymZTfeRwsvVEqpB7LYZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4y0tBiS5JmNH+rgOL0MhW5OGjIKWo7yDCnoGmoBPTvkjgaajDWj4sN/dRSB3NbU/KbBQou6bTD+wB8fBsGZz6i1vti8G2tZ7FsC7dffIlC9F7MWPlEfpjyaPutLR86iHbS80JZ0O96KNdiYfaae5yDi2Gkkbn54M6j8XxEa70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vpt1RadO; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51J6RCdh1884773
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 00:27:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739946432;
	bh=VlVNFZBgMTyta3Sdh9B7e+RlAhPD+wCm7u6IJUX4tKw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vpt1RadOOI4UXChW99+KmrwJg1Vu0Rv7W6apbG70QUAtIPbQbbOrl5Jpu1CdNhnPt
	 AjTXIuMWwLGg2R6gPlWLvhnwVlCvDCxROHR1oU4OWviYlheUKwEc/tB7RETPKKTgZo
	 pu41hULr7V9iREBaoo3imXJTrVOLVoRKbLZis/rk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51J6RC2s002407
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Feb 2025 00:27:12 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Feb 2025 00:27:11 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Feb 2025 00:27:11 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51J6RBUp080308;
	Wed, 19 Feb 2025 00:27:11 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 51J6RBWG009531;
	Wed, 19 Feb 2025 00:27:11 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <lokeshvutla@ti.com>, <vigneshr@ti.com>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <m-malladi@ti.com>, <horms@kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v2 1/2] net: ti: icss-iep: Fix pwidth configuration for perout signal
Date: Wed, 19 Feb 2025 11:57:00 +0530
Message-ID: <20250219062701.995955-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219062701.995955-1-m-malladi@ti.com>
References: <20250219062701.995955-1-m-malladi@ti.com>
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

But icss_iep_perout_enable_hw() function is missing to hook the
configuration params passed by the app, causing perout to behave
same a pps (except being able to configure the period). As duty cycle
is also one feature which can configured for perout, incorporate this
in the function to get the expected signal.

Fixes: c1e0230eeaab2 ("net: ti: icss-iep: Add IEP driver")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
Changes from v1 (v2-v1):
- replace u32 typecast with div_u64()

 drivers/net/ethernet/ti/icssg/icss_iep.c | 28 ++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 768578c0d958..0411438a3b5d 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -406,9 +406,16 @@ static void icss_iep_update_to_next_boundary(struct icss_iep *iep, u64 start_ns)
 static int icss_iep_perout_enable_hw(struct icss_iep *iep,
 				     struct ptp_perout_request *req, int on)
 {
+	struct timespec64 ts;
+	u64 ns_width;
 	int ret;
 	u64 cmp;
 
+	/* Calculate width of the signal for PPS/PEROUT handling */
+	ts.tv_sec = req->on.sec;
+	ts.tv_nsec = req->on.nsec;
+	ns_width = timespec64_to_ns(&ts);
+
 	if (iep->ops && iep->ops->perout_enable) {
 		ret = iep->ops->perout_enable(iep->clockops_data, req, on, &cmp);
 		if (ret)
@@ -419,8 +426,9 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
 			regmap_write(iep->map, ICSS_IEP_CMP1_REG0, lower_32_bits(cmp));
 			if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
 				regmap_write(iep->map, ICSS_IEP_CMP1_REG1, upper_32_bits(cmp));
-			/* Configure SYNC, 1ms pulse width */
-			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG, 1000000);
+			/* Configure SYNC, based on req on width */
+			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
+				     div_u64(ns_width, iep->def_inc));
 			regmap_write(iep->map, ICSS_IEP_SYNC0_PERIOD_REG, 0);
 			regmap_write(iep->map, ICSS_IEP_SYNC_START_REG, 0);
 			regmap_write(iep->map, ICSS_IEP_SYNC_CTRL_REG, 0); /* one-shot mode */
@@ -447,6 +455,8 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
 				   + req->period.nsec;
 			icss_iep_update_to_next_boundary(iep, start_ns);
 
+			regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG,
+				     div_u64(ns_width, iep->def_inc));
 			/* Enable Sync in single shot mode  */
 			regmap_write(iep->map, ICSS_IEP_SYNC_CTRL_REG,
 				     IEP_SYNC_CTRL_SYNC_N_EN(0) | IEP_SYNC_CTRL_SYNC_EN);
@@ -478,6 +488,12 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
 
 	mutex_lock(&iep->ptp_clk_mutex);
 
+	/* Reject requests with unsupported flags */
+	if (req->flags & ~PTP_PEROUT_DUTY_CYCLE) {
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
 	if (iep->pps_enabled) {
 		ret = -EBUSY;
 		goto exit;
@@ -486,6 +502,12 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
 	if (iep->perout_enabled == !!on)
 		goto exit;
 
+	/* Set default "on" time (1ms) for the signal if not passed by the app */
+	if (!(req->flags & PTP_PEROUT_DUTY_CYCLE)) {
+		req->on.sec = 0;
+		req->on.nsec = NSEC_PER_MSEC;
+	}
+
 	ret = icss_iep_perout_enable_hw(iep, req, on);
 	if (!ret)
 		iep->perout_enabled = !!on;
@@ -572,6 +594,8 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 		rq.perout.period.nsec = 0;
 		rq.perout.start.sec = ts.tv_sec + 2;
 		rq.perout.start.nsec = 0;
+		rq.perout.on.sec = 0;
+		rq.perout.on.nsec = NSEC_PER_MSEC;
 		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
 	} else {
 		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
-- 
2.43.0


