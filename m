Return-Path: <netdev+bounces-125760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E8996E79A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 04:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A0E1F23EA2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 02:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB671C69C;
	Fri,  6 Sep 2024 02:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="BFfxdtMC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129FD8F5C
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 02:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725589083; cv=none; b=tegvR1Ld29uJaTHmfMvI3p5aSjkF6ZV61kfNNtIoFRQvtmuYWZxHVlDIwY0ldwtm5gwFOaH6hBGl0xcVUR3pjG89RIZhrj+0bzZbeGDcB59MXCMFPWZnhkHoFo3pzmaUqI+GLbUMt8X6H0jCb2YyFJ8u8lpezlwBAeqtniZ7a14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725589083; c=relaxed/simple;
	bh=ekpufTpfNAE5F6HT9OVpWZviHFbgx0oSysdS/T6IeQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uNdzTbG5g9syp5LZ04QRjOO/Dw2uf6H0EO4M0nm7npidz3CVjq6LhG/hjiY+PT0c5Qg6oTqmKlgIX6uLqz+NvCkY3IsDfhbw/+6Si4UnWMWmtx19GfCJAYI1R0nK3s8bf6LU/AIBT4HHy/BZub3TypVutg2iLz4HuPbX789ntUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b=BFfxdtMC; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1725589082; x=1757125082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5TT8xdsCmk+8IqEfUImoDN2/EEbxvgsTV+2khwPLNfo=;
  b=BFfxdtMCiHXr/7XI4PhMfevayNV2tWWqrmoq/Hqj1Y+CB0R+YUPuDkol
   oGS4jryLPr2i04rjZAirhvxFvrmFzTPhhAxxN8du21kKCfjxqctgeihdu
   iRSlDrONU1e2K47c4MKFJs4Qmpy3sq3S8aEG4tpTnpHbQgRuS5IRwZoVy
   Q=;
X-IronPort-AV: E=Sophos;i="6.10,206,1719878400"; 
   d="scan'208";a="366478080"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 02:18:00 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:37237]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.84:2525] with esmtp (Farcaster)
 id 993dfbd4-fd5b-473d-beb9-0afd4cb6a4fb; Fri, 6 Sep 2024 02:17:58 +0000 (UTC)
X-Farcaster-Flow-ID: 993dfbd4-fd5b-473d-beb9-0afd4cb6a4fb
Received: from EX19D005ANA004.ant.amazon.com (10.37.240.178) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Sep 2024 02:17:58 +0000
Received: from 682f678c4465.ant.amazon.com (10.118.248.64) by
 EX19D005ANA004.ant.amazon.com (10.37.240.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Sep 2024 02:17:54 +0000
From: Takamitsu Iwai <takamitz@amazon.co.jp>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>
CC: Takamitsu Iwai <takamitz@amazon.co.jp>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH v2 net-next] e1000e: Remove duplicated writel() in e1000_configure_tx/rx()
Date: Fri, 6 Sep 2024 11:17:19 +0900
Message-ID: <20240906021719.37754-1-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D005ANA004.ant.amazon.com (10.37.240.178)

Duplicated register initialization codes exist in e1000_configure_tx()
and e1000_configure_rx().

For example, writel(0, tx_ring->head) writes 0 to tx_ring->head, which
is adapter->hw.hw_addr + E1000_TDH(0).

This initialization is already done in ew32(TDH(0), 0).

ew32(TDH(0), 0) is equivalent to __ew32(hw, E1000_TDH(0), 0). It
executes writel(0, hw->hw_addr + E1000_TDH(0)). Since variable hw is
set to &adapter->hw, it is equal to writel(0, tx_ring->head).

We can remove similar four writel() in e1000_configure_tx() and
e1000_configure_rx().

commit 0845d45e900c ("e1000e: Modify Tx/Rx configurations to avoid
null pointer dereferences in e1000_open") has introduced these
writel(). This commit moved register writing to
e1000_configure_tx/rx(), and as result, it caused duplication in
e1000_configure_tx/rx().

This patch modifies the sequence of register writing, but removing
these writes is safe because the same writes were already there before
the commit.

I also have checked the datasheets [0] [1] and have not found any
description that we need to write RDH, RDT, TDH and TDT registers
twice at initialization. Furthermore, we have tested this patch on an
I219-V device physically.

Link: https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/82577-gbe-phy-datasheet.pdf [0]
Link: https://www.intel.com/content/www/us/en/content-details/613460/intel-82583v-gbe-controller-datasheet.html [1]
Tested-by: Kohei Enju <enjuk@amazon.com>
Signed-off-by: Takamitsu Iwai <takamitz@amazon.co.jp>
---

v1->v2
modify commit message to explain the reason why we can remove these writes safely.

v1 link
https://lore.kernel.org/netdev/20240902061454.85744-1-takamitz@amazon.co.jp/

 drivers/net/ethernet/intel/e1000e/netdev.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index da5c59daf8ba..89c57be89c88 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2928,11 +2928,8 @@ static void e1000_configure_tx(struct e1000_adapter *adapter)
 	tx_ring->head = adapter->hw.hw_addr + E1000_TDH(0);
 	tx_ring->tail = adapter->hw.hw_addr + E1000_TDT(0);
 
-	writel(0, tx_ring->head);
 	if (adapter->flags2 & FLAG2_PCIM2PCI_ARBITER_WA)
 		e1000e_update_tdt_wa(tx_ring, 0);
-	else
-		writel(0, tx_ring->tail);
 
 	/* Set the Tx Interrupt Delay register */
 	ew32(TIDV, adapter->tx_int_delay);
@@ -3253,11 +3250,8 @@ static void e1000_configure_rx(struct e1000_adapter *adapter)
 	rx_ring->head = adapter->hw.hw_addr + E1000_RDH(0);
 	rx_ring->tail = adapter->hw.hw_addr + E1000_RDT(0);
 
-	writel(0, rx_ring->head);
 	if (adapter->flags2 & FLAG2_PCIM2PCI_ARBITER_WA)
 		e1000e_update_rdt_wa(rx_ring, 0);
-	else
-		writel(0, rx_ring->tail);
 
 	/* Enable Receive Checksum Offload for TCP and UDP */
 	rxcsum = er32(RXCSUM);
-- 
2.40.1


