Return-Path: <netdev+bounces-151119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4A99ECDD8
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD8C2862FA
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B6223695E;
	Wed, 11 Dec 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tgt6S5PF"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C142368E8;
	Wed, 11 Dec 2024 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925621; cv=none; b=RK51Vtx5S4iepxDTcyiAeprmBbcxkMMT+/9wQTjZ8Zrj9s1vjHgW2wgi0CHs/ffpIQVPzxaSZsmfl18w7dcV0Kj7nY/jTOaoNa94i4PayFe3sIdZUWIJw7Xq2P9GdROU+5AJY7Mruf+gXrHBJXsYO5zC8VccgqbCBH775dBEEUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925621; c=relaxed/simple;
	bh=T/X5tC4YRmjnSz5fvPEnR2sT1EoUgsfdtiyG+9BEIzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFuApJSqnXq5qSIED9XOxt1jK13gBfNSEBPObru9QSrqeUKCJfSgBAl1ev5QxozHd1JHAWOqBosa9A+59oCntqJWgZXT+h/KjrnlevwUENO3QSHfuGWTGgSoKt/kQ1LAbq4uDF+6lpKZi3wtpug97jYDLRPeFhTs+0N2boI/vY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tgt6S5PF; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BBDxq3Y2788143
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 07:59:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733925592;
	bh=dFvPAMlPD0jUs1WPueYqDUADf4OM8BpzjiQjwYfCUg4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tgt6S5PFvo9I7xpyBfASF///aYRaNRxatOC0T115STABmOFAd6IKcs6w/QvHj3kai
	 5H4YnwdarKQENb5cADwGYberjQKC7BI4Q/wV2+I+qXDuCq6KxrgEMuAI05IEWP+eUU
	 5qsRQk1r0nif3e6Yun4iRWLw7vWt0Fp4Gcca4L1Q=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BBDxpHa020763
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Dec 2024 07:59:51 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Dec 2024 07:59:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Dec 2024 07:59:51 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BBDxpd1074222;
	Wed, 11 Dec 2024 07:59:51 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4BBDxoaZ023901;
	Wed, 11 Dec 2024 07:59:51 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vigneshr@ti.com>, <matthias.schiffer@ew.tq-group.com>, <robh@kernel.org>,
        <u.kleine-koenig@baylibre.com>, <dan.carpenter@linaro.org>,
        <javier.carrasco.cruz@gmail.com>, <m-malladi@ti.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v4 2/2] net: ti: icssg-prueth: Fix clearing of IEP_CMP_CFG registers during iep_init
Date: Wed, 11 Dec 2024 19:29:41 +0530
Message-ID: <20241211135941.1800240-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211135941.1800240-1-m-malladi@ti.com>
References: <20241211135941.1800240-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

When ICSSG interfaces are brought down and brought up again, the
pru cores are shut down and booted again, flushing out all the memories
and start again in a clean state. Hence it is expected that the
IEP_CMP_CFG register needs to be flushed during iep_init() to ensure
that the existing residual configuration doesn't cause any unusual
behavior. If the register is not cleared, existing IEP_CMP_CFG set for
CMP1 will result in SYNC0_OUT signal based on the SYNC_OUT register values.

After bringing the interface up, calling PPS enable doesn't work as
the driver believes PPS is already enabled, (iep->pps_enabled is not
cleared during interface bring down) and driver will just return true
even though there is no signal. Fix this by disabling pps and perout.

Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---

Hi all,

This patch is based on net-next tagged next-20241205
v3: https://lore.kernel.org/all/20241205082831.777868-3-m-malladi@ti.com/

* Changes since v2 (v4-v2):
- Collected Reviewed-by tag from Roger Quadros <rogerq@kernel.org>

 drivers/net/ethernet/ti/icssg/icss_iep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 5d6d1cf78e93..a96861debbe3 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -215,6 +215,10 @@ static void icss_iep_enable_shadow_mode(struct icss_iep *iep)
 	for (cmp = IEP_MIN_CMP; cmp < IEP_MAX_CMP; cmp++) {
 		regmap_update_bits(iep->map, ICSS_IEP_CMP_STAT_REG,
 				   IEP_CMP_STATUS(cmp), IEP_CMP_STATUS(cmp));
+
+		regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
+				   IEP_CMP_CFG_CMP_EN(cmp), 0);
+
 	}
 
 	/* enable reset counter on CMP0 event */
@@ -780,6 +784,11 @@ int icss_iep_exit(struct icss_iep *iep)
 	}
 	icss_iep_disable(iep);
 
+	if (iep->pps_enabled)
+		icss_iep_pps_enable(iep, false);
+	else if (iep->perout_enabled)
+		icss_iep_perout_enable(iep, NULL, false);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(icss_iep_exit);
-- 
2.25.1


