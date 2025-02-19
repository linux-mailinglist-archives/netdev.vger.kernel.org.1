Return-Path: <netdev+bounces-167627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277CA3B1A2
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 07:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D83D3B45BB
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 06:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A514A1BEF70;
	Wed, 19 Feb 2025 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PiWrcOJr"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86AE19D882;
	Wed, 19 Feb 2025 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946456; cv=none; b=nKtiqD83YMbngJ5KIu99DH8TvhQi1kMMLlHILcA6ZG9/inppfRMYk3HwKrTaqBD3KL+HvwyApf2HUmO3pTHAQ0eB1KeVqJf+WHztYUWxx8wUL64VXPj08AyxPwJYc2COruL/39i9OuOf9rsw4tfTHhp5BpnIXr/hpOr6oqL7Ezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946456; c=relaxed/simple;
	bh=ndFEb8qxOXCrnEPcP25fpqsU2r59yQD4mwacOYw9Mt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APCcO6QpuTat/4tkdc7sSYAjCBOCgsUNPSBydbNhhGShHj7f6GkpNc0BQyTPVYtXGvaQU6nq1JjqQ0QXqqCf44KiZLdCqbAGhmbfZUV0n2K2jJewLEq+xjpWb6GUFM1TueiD896YlCCOel591mbZlQqcuNT6P5iCmhjRr10TpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PiWrcOJr; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51J6RFCE186669
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 00:27:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739946435;
	bh=CwC0+pvP8i5Znhnwf7v/1fgvzA/Zx30Ryv+wCWvFehw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PiWrcOJr0lrQzMngtNn21D3OmRxbTAmVM3ugsC3jpPs8MgMA+qPy0RDQJ7Bb9opuF
	 TYwp59UlRDTEzpMxJrYWJ99cgIWkiAKlC6WEkbNEPAxV6kK+LrN5c/+gNL3jRcXKCO
	 cRgIWwZhUsDsF06TEFArDTEyONRnLl9/jq0kDqRU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51J6RFBU103430
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Feb 2025 00:27:15 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Feb 2025 00:27:15 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Feb 2025 00:27:14 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51J6REM6033484;
	Wed, 19 Feb 2025 00:27:14 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 51J6RErV009538;
	Wed, 19 Feb 2025 00:27:14 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <lokeshvutla@ti.com>, <vigneshr@ti.com>, <javier.carrasco.cruz@gmail.com>,
        <diogo.ivo@siemens.com>, <m-malladi@ti.com>, <horms@kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v2 2/2] net: ti: icss-iep: Fix phase offset configuration for perout signal
Date: Wed, 19 Feb 2025 11:57:01 +0530
Message-ID: <20250219062701.995955-3-m-malladi@ti.com>
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

In case the app passes a valid phase offset value, the signal should
start toggling after that phase offset, else start immediately or
as soon as possible. ICSS_IEP_SYNC_START_REG register take number of
clock cycles to wait before starting the signal after activation time.
Set appropriate value to this register to support phase offset.

Fixes: c1e0230eeaab2 ("net: ti: icss-iep: Add IEP driver")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
Changes from v1 (v2-v1):
- replace u32 typecast with div_u64()

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


