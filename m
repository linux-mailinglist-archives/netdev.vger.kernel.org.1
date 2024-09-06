Return-Path: <netdev+bounces-125848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AA896EEFA
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F581C21F32
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CBA1581EE;
	Fri,  6 Sep 2024 09:16:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33159B71;
	Fri,  6 Sep 2024 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614184; cv=none; b=BvOWpgAFm/XQ/g2Kmn6km81PFai9ke4xvhneBDqWxIZ0fgHBjOHrU2QMVNblgiaVusnJYGQm4TwtQdbl0dLc1SZQ8dRRYoW2xVwYyJmFUhRzcXae/j65mTRVcqP9f0McDIdPYlcVpiAhwbWEclvHILgxJXrOSTS7W5zMi17asZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614184; c=relaxed/simple;
	bh=NB8dXfjkOd81Ya9XnGiaAE0RPFLChNFtR3CKBjUUFSo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WB72n0kEPki/OBjcos0kByKmDn0QNdZWYeNFeb1Xbcn/O7fEYivSRZNfFNtvcZ44JMxjtsKZhlV+b6tVqe/xIKQCr81mr2Em0h52JnGCNDu9wLNHRHY/ZNuA+B3dlmOzFbJqPLVdu6PUVrRQ2W/2SifXQSHV2GUjMLt+0pCuxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E4DDB1A15E5;
	Fri,  6 Sep 2024 11:16:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AB7B61A1909;
	Fri,  6 Sep 2024 11:16:14 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DD8A4183AC0A;
	Fri,  6 Sep 2024 17:16:12 +0800 (+08)
From: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	michael@walle.cc,
	linux-kernel@vger.kernel.org,
	xiaoliang.yang_1@nxp.com
Subject: [PATCH v2 net] net: dsa: felix: ignore pending status of TAS module when it's disabled
Date: Fri,  6 Sep 2024 17:35:50 +0800
Message-Id: <20240906093550.29985-1-xiaoliang.yang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The TAS module could not be configured when it's running in pending
status. We need disable the module and configure it again. However, the
pending status is not cleared after the module disabled. TC taprio set
will always return busy even it's disabled.

For example, a user uses tc-taprio to configure Qbv and a future
basetime. The TAS module will run in a pending status. There is no way
to reconfigure Qbv, it always returns busy.

Actually the TAS module can be reconfigured when it's disabled. So it
doesn't need to check the pending status if the TAS module is disabled.

After the patch, user can delete the tc taprio configuration to disable
Qbv and reconfigure it again.

Fixes: de143c0e274b ("net: dsa: felix: Configure Time-Aware Scheduler via taprio offload")
Signed-off-by: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index ba37a566da39..ecfa73725d25 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1474,10 +1474,13 @@ static int vsc9959_qos_port_tas_set(struct ocelot *ocelot, int port,
 	/* Hardware errata -  Admin config could not be overwritten if
 	 * config is pending, need reset the TAS module
 	 */
-	val = ocelot_read(ocelot, QSYS_PARAM_STATUS_REG_8);
-	if (val & QSYS_PARAM_STATUS_REG_8_CONFIG_PENDING) {
-		ret = -EBUSY;
-		goto err_reset_tc;
+	val = ocelot_read_rix(ocelot, QSYS_TAG_CONFIG, port);
+	if (val & QSYS_TAG_CONFIG_ENABLE) {
+		val = ocelot_read(ocelot, QSYS_PARAM_STATUS_REG_8);
+		if (val & QSYS_PARAM_STATUS_REG_8_CONFIG_PENDING) {
+			ret = -EBUSY;
+			goto err_reset_tc;
+		}
 	}
 
 	ocelot_rmw_rix(ocelot,
-- 
2.17.1


