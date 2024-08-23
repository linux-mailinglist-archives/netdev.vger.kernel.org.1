Return-Path: <netdev+bounces-121328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DA895CBFB
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB88C1C2124A
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ADD18452A;
	Fri, 23 Aug 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ko2ANyWU"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD2469D;
	Fri, 23 Aug 2024 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414675; cv=none; b=MVblu1MdLFGNZmnnHEbaYu2JeoxMATt+jL4gHNuQOM/EYDKv19vV2Iii6WnAPMHFLY3pnijpdVTEqBxTww8XseEStN3q6Gr6+ZZTaYVCLhY5pmZiMYBVcdiLMDinJutC2GKY8zQFR/8f0BJkP35GtRwVP4BCPN5wW1QsByKPSdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414675; c=relaxed/simple;
	bh=uOYF9IBbjq6Df6OslTPVFxo8b9jkQGoqj13knP5UrIk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nis9QVR7N8UGNO34fvkWYChWXJGGT2Vm7dZQshTPAajp0SmqDBDhjaHwqN4zFlq/xh6Ft/M/NEHA2o+qt/YKiUr8Yqr44z/SOUb2h15iz/1desf0fdgMam1kQXQoG6o/MOQEujtd/AXazucaa1UvtXiR+yRoSpGZPres6vvvmxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ko2ANyWU; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47NC4FtF077941;
	Fri, 23 Aug 2024 07:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724414655;
	bh=de03RW750H29gr36+zzX9jDRdtr7DE8b+i4kfXYLC4g=;
	h=From:To:CC:Subject:Date;
	b=Ko2ANyWUcWPSdcUqNKlPcVZ/3wZohcI7Er4DNpb3ZCfP5cv/uCz53P6ICkcwrjCtj
	 EQFInw9+FqPfBpvvJeXC1fAie+I0/yfUiAZt+AZ0szOe3Hdhdsjw7j7GYnWbNgdImi
	 BWqq69mckiQs3SOZK0aAJqtmwcii6naL1uImyABE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47NC4FnV058122
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Aug 2024 07:04:15 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Aug 2024 07:04:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Aug 2024 07:04:15 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47NC4FsB023971;
	Fri, 23 Aug 2024 07:04:15 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47NC4ETt021895;
	Fri, 23 Aug 2024 07:04:15 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew@lunn.ch>, Dan Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo <diogo.ivo@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net] net: ti: icssg-prueth: Fix 10M Link issue on AM64x
Date: Fri, 23 Aug 2024 17:34:12 +0530
Message-ID: <20240823120412.1262536-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Crash is seen on AM64x 10M link when connecting / disconnecting multiple
times.

The fix for this is to enable quirk_10m_link_issue for AM64x.

Fixes: b256e13378a9 ("net: ti: icssg-prueth: Add AM64x icssg support")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
NOTE: If quirk_10m_link_issue is set, the ICSSG driver enables IEP1 which
fixes the 10M link issue.

As per Roger Quadros <rogerq@kernel.org> 's suggestion [1], posting this
as a separate patch.

[1] https://lore.kernel.org/all/cde0064d-83dd-4a7f-8921-053c25aae08b@kernel.org/

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 3e51b3a9b0a5..e3451beed323 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1452,6 +1452,7 @@ static const struct prueth_pdata am654_icssg_pdata = {
 
 static const struct prueth_pdata am64x_icssg_pdata = {
 	.fdqring_mode = K3_RINGACC_RING_MODE_RING,
+	.quirk_10m_link_issue = 1,
 	.switch_mode = 1,
 };
 

base-commit: 82b8000c28b56b014ce52a1f1581bef4af148681
-- 
2.34.1


