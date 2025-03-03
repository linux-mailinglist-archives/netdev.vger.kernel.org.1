Return-Path: <netdev+bounces-171252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E701BA4C26E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 14:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303EC1890B4D
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4ED213244;
	Mon,  3 Mar 2025 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hNt0OAjW"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC7212D97;
	Mon,  3 Mar 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009957; cv=none; b=PXmzY5Vb0O6MMOrwuGIO6fDDzVoJMV3Qw5NyGDi4Dwb7JGst93ND3hFMhkpuc+8+5crbG/tC/9KROCAven3ELleWTQwqeI7jEH1gr/bgW9pawFUyYXi8QfPyvyhZYEK1NvaBsSf2asrFC4Mw6Wu6Oz73WxZPu5HbG3TD8XQ51x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009957; c=relaxed/simple;
	bh=xdYWwjL+CDWXGilizwTlyWiiyQq/uWLihWYcwAU05EQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEMr++KCBtqP0u4qwp5FsX5hyD3d9RnXVtg7PivlioQLlKxhSMzmw+gr6S2lza1sZPb2AcNtnUvc2/EV/cqD3se+B1WAUmbaRd2mk0nOvS4swzEaoOEdtr7GLvYZ9+r+ygpkrnhKGAjW0bsiDtd3UggeukZ6bJLp+1a15PtW9U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hNt0OAjW; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 523DqIoH2695917
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 07:52:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741009938;
	bh=xVFXwEHnmiutpUbmvWfualAABgQYgGxlamF2SY4e2Cw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hNt0OAjWoriKvelpAiX+03kpq6Xz1/1BkUaH/o9Hb7JCFYKDW3WNW8KVJC2TrKs9g
	 UY4RvXaAP3gxwK/GW//5W9EpBweYhkBQTX8v9cRY8VFyUITkaeIhbVwFVOvbIi7FQE
	 0Wqwf5uJI3R1e85VwtAxz1tpAcq0Qk/c1FhSVk88=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 523DqIJ7002485
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Mar 2025 07:52:18 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Mar 2025 07:52:18 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Mar 2025 07:52:18 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 523DqIWQ026987;
	Mon, 3 Mar 2025 07:52:18 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 523DqHdQ018094;
	Mon, 3 Mar 2025 07:52:17 -0600
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
Subject: [PATCH net-next v3 2/2] net: ti: icss-iep: Add phase offset configuration for perout signal
Date: Mon, 3 Mar 2025 19:21:24 +0530
Message-ID: <20250303135124.632845-3-m-malladi@ti.com>
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

In case the app passes a valid phase offset value, the signal should
start toggling after that phase offset, else start immediately or
as soon as possible. ICSS_IEP_SYNC_START_REG register take number of
clock cycles to wait before starting the signal after activation time.
Set appropriate value to this register to support phase offset.

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes from v2 (v3-v2):
- Posted patch to net-next as feature addition
- Collected RB tag from Jacob Keller <jacob.e.keller@intel.com>

 drivers/net/ethernet/ti/icssg/icss_iep.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 0411438a3b5d..598dfb963db6 100644
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
@@ -489,7 +501,8 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
 	mutex_lock(&iep->ptp_clk_mutex);
 
 	/* Reject requests with unsupported flags */
-	if (req->flags & ~PTP_PEROUT_DUTY_CYCLE) {
+	if (req->flags & ~(PTP_PEROUT_DUTY_CYCLE |
+			  PTP_PEROUT_PHASE)) {
 		ret = -EOPNOTSUPP;
 		goto exit;
 	}
@@ -590,6 +603,7 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 	if (on) {
 		ns = icss_iep_gettime(iep, NULL);
 		ts = ns_to_timespec64(ns);
+		rq.perout.flags = 0;
 		rq.perout.period.sec = 1;
 		rq.perout.period.nsec = 0;
 		rq.perout.start.sec = ts.tv_sec + 2;
-- 
2.43.0


