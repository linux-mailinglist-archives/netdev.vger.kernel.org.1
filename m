Return-Path: <netdev+bounces-197104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F1AD77DC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE877B27F4
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E554D29C321;
	Thu, 12 Jun 2025 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ao77tH7i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC5E2F4328
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744841; cv=none; b=DsxwYW8UHaNIY9L+xTKPe6RDTGx0YQBCyq/pTfPz4+jxKDpro6C4taaQG+aKDfIbKXo4BmRg9yAPh/RY4tO+we8pyXTm0fpaFaS7zSLzvPaLoRklUl1UdrU2Pw0+wPZsDHR6tVPv9hXeCGCVS8odQ/v3K5LQ6/xK4n1bJ5krVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744841; c=relaxed/simple;
	bh=GudavV7V/tmRCw9VRdQAoiKzqyVCsDJM/4AnuzY1wrY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b8Z3aWiGDCMN+vgCW0NRM08fhchxBjHHChE44/dd1Abk7HhpXNPR4N/XaBObWCa3u2AV7rMrMm3QmyNI3Hm7NQJMj/LJ5i5gRNc6+11+pX2vO5+SFYvQBHSbGHya8Kvln6x6uQZmfF6AV0COB7YgyfNuXMmdUxr+e+XC5wD4gZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ao77tH7i; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749744840; x=1781280840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ihkZgVUzQqGvvmt/oKfsiY5SM+COVVcX+bS+R4pesBQ=;
  b=Ao77tH7ic5k5iEOb+DSCfXndVJaS6DO2F4c1D6XTJgwQui+Ves4Bi95B
   NLqgOJIi5iHTrl3QQrN/7IfE4Y0aBE2TFqEQ1P/SFPo1qzbx8eYHSyDuR
   GhmGGUXyPhqLN6s23r7CDmCYsOxdQ4YgoggmOdYka4jOMx2JBOn/jVvPk
   +7UhhHrNdAzKIU461hufsCIgBb7VbPSAmLhMB9dLLclsqelgjyXvL1Tli
   vXasrW9AAJ9xgAlzZRdi4kNeVk7QhegPEsBxeYquWiB6fA4Xp0S2r5ya1
   kpsp7FodXLckg8J7hfopyCPZqisYlbPoxWmgT55tqxO8ubnV7C4MhuNba
   g==;
X-IronPort-AV: E=Sophos;i="6.16,231,1744070400"; 
   d="scan'208";a="210882419"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 16:13:59 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:58684]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.22:2525] with esmtp (Farcaster)
 id 95d2bb70-4aa7-4273-81da-24e1eb19dfa0; Thu, 12 Jun 2025 16:13:59 +0000 (UTC)
X-Farcaster-Flow-ID: 95d2bb70-4aa7-4273-81da-24e1eb19dfa0
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 12 Jun 2025 16:13:59 +0000
Received: from b0be8375a521.amazon.com (10.37.245.11) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 12 Jun 2025 16:13:55 +0000
From: Kohei Enju <enjuk@amazon.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kohei Enju <kohei.enju@gmail.com>, Kohei Enju
	<enjuk@amazon.com>
Subject: [PATCH iwl-next v1] igbvf: remove unused interrupt counter fields from struct igbvf_adapter
Date: Fri, 13 Jun 2025 01:13:40 +0900
Message-ID: <20250612161343.66065-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

Remove `int_counter0` and `int_counter1` from struct igbvf_adapter since
they are only incremented in interrupt handlers igbvf_intr_msix_rx() and
igbvf_msix_other(), but never read or used anywhere in the driver.

Note that igbvf_intr_msix_tx() does not have similar counter increments,
suggesting that these were likely overlooked during development.

Eliminate the fields and their unnecessary accesses in interrupt
handlers.

Tested-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 drivers/net/ethernet/intel/igbvf/igbvf.h  | 2 --
 drivers/net/ethernet/intel/igbvf/netdev.c | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/igbvf.h b/drivers/net/ethernet/intel/igbvf/igbvf.h
index ca6e44245a7b..ba9c3fee6da7 100644
--- a/drivers/net/ethernet/intel/igbvf/igbvf.h
+++ b/drivers/net/ethernet/intel/igbvf/igbvf.h
@@ -238,8 +238,6 @@ struct igbvf_adapter {
 	int int_mode;
 	u32 eims_enable_mask;
 	u32 eims_other;
-	u32 int_counter0;
-	u32 int_counter1;
 
 	u32 eeprom_wol;
 	u32 wol;
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index beb01248600f..33104408007a 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -855,8 +855,6 @@ static irqreturn_t igbvf_msix_other(int irq, void *data)
 	struct igbvf_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 
-	adapter->int_counter1++;
-
 	hw->mac.get_link_status = 1;
 	if (!test_bit(__IGBVF_DOWN, &adapter->state))
 		mod_timer(&adapter->watchdog_timer, jiffies + 1);
@@ -899,8 +897,6 @@ static irqreturn_t igbvf_intr_msix_rx(int irq, void *data)
 	struct net_device *netdev = data;
 	struct igbvf_adapter *adapter = netdev_priv(netdev);
 
-	adapter->int_counter0++;
-
 	/* Write the ITR value calculated at the end of the
 	 * previous interrupt.
 	 */
-- 
2.49.0


