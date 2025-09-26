Return-Path: <netdev+bounces-226710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332F5BA45BC
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A023B11F5
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB861EF38C;
	Fri, 26 Sep 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jpc8VGYY"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1E1DF261;
	Fri, 26 Sep 2025 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899355; cv=none; b=qfS9HEuvzYujjwcwOaEcyLHW0gea60zaJZh9fY2b/iEyXFWXD9AbDanulezE++92KoTpvgqswAKkt4WJUEriYbcCEiHVMWcsoVj/YcJN9csfb8SbXhoN6JUJzHhNXe3AskmHlq3hBfiAentRmMuhBLiR+/ye5rEPMbWchoHyShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899355; c=relaxed/simple;
	bh=EddEQNtZYsvdfN0wMF4uGacpfsZuoen5xDeUYtuXVCs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nGEPLHlsQWAgR2H6gFkcsqsipVWh1VeUQP+SfHgRqa2k1etSqwdcy+ldYx5lUV3ni/SHJ3lZVsse3pvd6TlEJ5sErFJEIJmkuCf5DQMMo9OasNkEZbfcT5vl4SeLtAZ4RK+RxnTJJlHJlsDOamnkRpyYpbS7FZ+ORsBLHyXeT8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jpc8VGYY; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58QF8wXq2174478;
	Fri, 26 Sep 2025 10:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758899338;
	bh=BnS4tWuclq6kbZYpj/5rxx3vsQ9QDA9NdfNiGmMWrfs=;
	h=From:To:CC:Subject:Date;
	b=jpc8VGYY3+ngzOSK6Qq4ITkweLhkK6qurijdte+7VPwdqyxsuHneDd1m6c0Mr+lSp
	 dUZKOFpg9SNK7h0fZYvnbu2C4STbf2o2rW5/4f0zgFpzFKDI1I/dbeLQJmt3ilja8s
	 WmTUOHBnTXTHykjMaSHSRPOeccETLwMmTbKqqyk0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58QF8wHx4068579
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 26 Sep 2025 10:08:58 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 26
 Sep 2025 10:08:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 26 Sep 2025 10:08:58 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58QF8wW41232041;
	Fri, 26 Sep 2025 10:08:58 -0500
From: Nishanth Menon <nm@ti.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        "Vadapalli,
 Siddharth" <s-vadapalli@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH] net: netcp: Fix crash in error path when DMA channel open fails
Date: Fri, 26 Sep 2025 10:08:53 -0500
Message-ID: <20250926150853.2907028-1-nm@ti.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

When knav_dma_open_channel() fails in netcp_setup_navigator_resources(),
the rx_channel field is set to an ERR_PTR value. Later, when
netcp_free_navigator_resources() is called in the error path, it attempts
to close this invalid channel pointer, causing a crash.

Add a check for ERR values to handle the failure scenario.

Fixes: 84640e27f230 ("net: netcp: Add Keystone NetCP core driver")
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Seen on kci log for k2hk: https://dashboard.kernelci.org/log-viewer?itemId=ti%3A2eb55ed935eb42c292e02f59&org=ti&type=test&url=http%3A%2F%2Ffiles.kernelci.org%2F%2Fti%2Fmainline%2Fmaster%2Fv6.17-rc7-59-gbf40f4b87761%2Farm%2Fmulti_v7_defconfig%2BCONFIG_EFI%3Dy%2BCONFIG_ARM_LPAE%3Dy%2Bdebug%2Bkselftest%2Btinyconfig%2Fgcc-12%2Fbaseline-nfs-boot.nfs-k2hk-evm.txt.gz

 drivers/net/ethernet/ti/netcp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 857820657bac..4ff17fd6caae 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -1549,7 +1549,7 @@ static void netcp_free_navigator_resources(struct netcp_intf *netcp)
 {
 	int i;
 
-	if (netcp->rx_channel) {
+	if (!IS_ERR(netcp->rx_channel)) {
 		knav_dma_close_channel(netcp->rx_channel);
 		netcp->rx_channel = NULL;
 	}
-- 
2.47.0


