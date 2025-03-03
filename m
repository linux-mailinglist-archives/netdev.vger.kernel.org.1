Return-Path: <netdev+bounces-171251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA7FA4C26C
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 14:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E66F188F044
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E373211A0B;
	Mon,  3 Mar 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CiOyJp6K"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7F186347;
	Mon,  3 Mar 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009954; cv=none; b=bdmacFf8OjkgSnPDxm97dQILBCgpFVDLiDvFvTiSxckoa/ZDUJae+8LPLjfQ+qF2p8T8lhz209GXhKt3OPe5OhReAQ557ICQj+DT0aCJ0XY9Hzlfm/5aRMjI8y6WFO/wbIZhelV6MwtptUCh/jGXeJb7ZfxwECdh4DFlAvgEZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009954; c=relaxed/simple;
	bh=o8VoAt5dL3GJqO4ZL7G+9SXofDr7fMM3zttZuWylbZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYOmv5o/m2q/Bn01GtePilZmFRhqkAyvbWjmiyJaV6G1VwJxWiJFhOSNnVBazSx0NOOeKDs0XjezAyU+jg5Jr41Dv/wUxl3Ev7qxsBMJXcfrGntWOKpEhmYVw1ZPJ3aHE7TXm2kKCauTqnD1h/Z7zrvnqw/wLzxfJv17BHfQ8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CiOyJp6K; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 523DqFDJ3287675
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 3 Mar 2025 07:52:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741009935;
	bh=Lz8EOBn9FUAA9PUMl7yDcfKigTwB7zLIEjA+CKP0ZPA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CiOyJp6KRusPBdfZ7/h7j/VSlAOKo5ujK0iDwmb49mxCcMuBHL0SnSC/5PS1Dn9Kk
	 wh7yeSTnFm4SwApy5PyypIn07tbNn0ZK4PmswvulqjnfiWXD9xWeQvVxk5CRmpp6O5
	 qGthWuDvMINi7GC0q6nCFPK/LbOEiZMQIlzr+9/U=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 523DqF79095313;
	Mon, 3 Mar 2025 07:52:15 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Mar 2025 07:52:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Mar 2025 07:52:14 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 523DqEhA092412;
	Mon, 3 Mar 2025 07:52:14 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 523DqDP2018084;
	Mon, 3 Mar 2025 07:52:14 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
        <horms@kernel.org>, <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <richardcochran@gmail.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v3 1/2] net: ti: icss-iep: Add pwidth configuration for perout signal
Date: Mon, 3 Mar 2025 19:21:23 +0530
Message-ID: <20250303135124.632845-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303135124.632845-1-m-malladi@ti.com>
References: <20250303135124.632845-1-m-malladi@ti.com>
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

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes from v2 (v3-v2):
- Posted patch to net-next as feature addition
- Collected RB tag from Jacob Keller <jacob.e.keller@intel.com>

 drivers/net/ethernet/ti/icssg/icss_iep.c | 49 ++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index d59c1744840a..0411438a3b5d 100644
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
@@ -474,7 +484,38 @@ static int icss_iep_perout_enable_hw(struct icss_iep *iep,
 static int icss_iep_perout_enable(struct icss_iep *iep,
 				  struct ptp_perout_request *req, int on)
 {
-	return -EOPNOTSUPP;
+	int ret = 0;
+
+	mutex_lock(&iep->ptp_clk_mutex);
+
+	/* Reject requests with unsupported flags */
+	if (req->flags & ~PTP_PEROUT_DUTY_CYCLE) {
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	if (iep->pps_enabled) {
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	if (iep->perout_enabled == !!on)
+		goto exit;
+
+	/* Set default "on" time (1ms) for the signal if not passed by the app */
+	if (!(req->flags & PTP_PEROUT_DUTY_CYCLE)) {
+		req->on.sec = 0;
+		req->on.nsec = NSEC_PER_MSEC;
+	}
+
+	ret = icss_iep_perout_enable_hw(iep, req, on);
+	if (!ret)
+		iep->perout_enabled = !!on;
+
+exit:
+	mutex_unlock(&iep->ptp_clk_mutex);
+
+	return ret;
 }
 
 static void icss_iep_cap_cmp_work(struct work_struct *work)
@@ -553,6 +594,8 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
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


