Return-Path: <netdev+bounces-124983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC6096B7D8
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4125C1C241E4
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF9F1CF2B5;
	Wed,  4 Sep 2024 10:07:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEFC146A76;
	Wed,  4 Sep 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444472; cv=none; b=mu3r0abbSdTfYZIsq3TcgHNDCWofxrkKP1bPy/eWo6fiwmvXt+qvWjjX3qNqVdTZEeeJ2nWXfByb99Ne3yjL+QB+64sbmE5ATqibEQLPMMC5PpfwYgAuKJ0n3f1d9u2yu4JMQE0JRlR48unmttmEMSRSmSgm58sf8W4T/TFKQCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444472; c=relaxed/simple;
	bh=qg2vjkfvhNsyAsHhdCnouJ/48D9iVMAdD3YN4VsK8lY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Jnr9QajJxgZ71TWIi0EjA0LHw5iBCy3yF2A0lBBnWyhlPQtSPB2IhzQ4alx45aRHfrtr5iQ2h7r4v7qKDXorRXXE1fz3CmKKflOjJSVFitrog8Sp+u85u5KPmL1njg5WPYfI3p/bXfEqGWOcN2yHKZ9HqNSbgSkgSfDwGw8Cn3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 95260200749;
	Wed,  4 Sep 2024 12:07:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 52397200278;
	Wed,  4 Sep 2024 12:07:43 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6800B1834890;
	Wed,  4 Sep 2024 18:07:41 +0800 (+08)
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
Subject: [PATCH net] net: dsa: felix: ignore pending status of TAS module when it's disabled
Date: Wed,  4 Sep 2024 18:27:22 +0800
Message-Id: <20240904102722.45427-1-xiaoliang.yang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The TAS module could not be configured when it's running in pending
status. We need disable the module and configure it again. However, the
pending status is not cleared after the module disabled. So we don't
need to check the pending status if TAS module is disabled.

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


