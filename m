Return-Path: <netdev+bounces-218252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30509B3BAEC
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF47170BEF
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 12:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1F7310630;
	Fri, 29 Aug 2025 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zg7ByeUR"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069B2D739F;
	Fri, 29 Aug 2025 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756469468; cv=none; b=ClUlA+0EutklsUI3RTTDNmwsZ2NF/1A1bE9QZ5lSYcJ/ZBIsxm4rpsIckoh+qg4sUkKZbUF3Y7yBjTpj/uLFBDqWiF5KmajMON3IO6TtRpAUs67tnkZHXALLJPY6RmTIauzqChTluhTo5ZnUuJWfv1+Kw05bPdFHtqI5aTgD61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756469468; c=relaxed/simple;
	bh=iJlXLAh/Cq8Ehz0a6jVPQ/WpSBBR2VKHdv3finz+WcA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l6eC2MwsBLCJ/xdkrbFyPxCLs6x5DSROhSQw1tkCWnw9tjEa19339ahxvujmnAs1zsC0/aerJFp/sj9Oy16ubLDVa3LFtX11pklxyUUPYzyWeIyMXpbue1Gnb3OG6CCrlLET7NsRojzrjRoo2lPrywwsI+c+jNG28cOxVQfpNIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Zg7ByeUR; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57TCAt6Q1799616;
	Fri, 29 Aug 2025 07:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756469455;
	bh=lanWemLgTewjisr1au66Z82yIZduuEspAqHlYzzfJ3A=;
	h=From:To:CC:Subject:Date;
	b=Zg7ByeURT+AMd9UrkkV1lm9kmqmIAhMWr7lYYiVCXR2XOs6eRRVNvry1qmHUJTD05
	 +yApTAO9LEi0Ouc8GerM2Fuf5TXv/Ws+QfzUwu5Iti+duqLAJDu4rtoPhFdzLFbRFF
	 /IUzEc9ZxYZr90Nn++Dpa1Ge49wdn5/6SHEInYGc=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57TCAshr534034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 29 Aug 2025 07:10:54 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 07:10:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 07:10:54 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.231.164])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57TCArJV2315227;
	Fri, 29 Aug 2025 07:10:53 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michael Walle <mwalle@kernel.org>, Simon Horman <horms@kernel.org>,
        Roger
 Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <nm@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH net] net: ethernet: ti: am65-cpsw-nuss: Fix null pointer dereference for ndev
Date: Fri, 29 Aug 2025 17:40:51 +0530
Message-ID: <20250829121051.2031832-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Nishanth Menon <nm@ti.com>

In the TX completion packet stage of TI SoCs with CPSW2G instance, which
has single external ethernet port, ndev is accessed without being
initialized if no TX packets have been processed. It results into null
pointer dereference, causing kernel to crash. Fix this by having a check
on the number of TX packets which have been processed.

Fixes: 9a369ae3d143 ("net: ethernet: ti: am65-cpsw: remove am65_cpsw_nuss_tx_compl_packets_2g()")
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Hello All,

This patch is based on the commit '5189446ba995' of
origin/main branch of Linux-net repository.

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index ecd6ecac87bb..8b2364f5f731 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1522,7 +1522,7 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 		}
 	}
 
-	if (single_port) {
+	if (single_port && num_tx) {
 		netif_txq = netdev_get_tx_queue(ndev, chn);
 		netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
 		am65_cpsw_nuss_tx_wake(tx_chn, ndev, netif_txq);
-- 
2.34.1


