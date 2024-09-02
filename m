Return-Path: <netdev+bounces-124088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A9967F37
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 08:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3464228249C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 06:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5999C155A47;
	Mon,  2 Sep 2024 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="oRNh32kr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD26155739
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257742; cv=none; b=Q6FXqgk6gDtNrvZiQ4jSIw9goD7g9jv4jNFqQu0pWN4/zFaEH8S8qomBVGnoADdaesxjvkFwXlZiAqSayAYUk4gakpBm/5hFsg6OQU70uGhEGNwooiVG3uJr2EERHnCoQ/YWQRwae9Q0OLsbgvVVl2CLbcFKcuE/ZfTayt8Z8xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257742; c=relaxed/simple;
	bh=zdtqRov4ldARAeT6+pdRvlWvnPz8Nrvxo32h4N7oGMw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fPXMzzZyRKFcyQeyjhBRBRafL+xKXjyzKGBfWwjlM3NTgHD77EEckVCygYiE2SPP95AHe9CoHNwT8TF7fr8aFL0mIg7Cl88GUDXERNtUlXVg8orwc+VnhJ9E91Qe+jwMvFsq7rX6S9gF2Btk8U20Z4Z0fhu3wuEWzsZzxOmayi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b=oRNh32kr; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1725257741; x=1756793741;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SWdOw87/+51iqg586AVxL9Z/wKo8wamb0wgkXwwaRE0=;
  b=oRNh32krKN36oWobEo1OnZ2TVzsrmRkxOBjQ4+SaMWWRD7Szo8L3/7xP
   t2s6z2i3TBxrpNO/HIZgNvvsxY1O3g0aV3NYswz6bMVx2BL32kwfkGuOv
   TmVBkU1C5zA28Hm+VwvQfACnC0jaC7MrN2ltumma71nCcvbXAPauCAfQM
   8=;
X-IronPort-AV: E=Sophos;i="6.10,195,1719878400"; 
   d="scan'208";a="22718195"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 06:15:39 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:51579]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.120:2525] with esmtp (Farcaster)
 id f0cf710c-b7a4-4e55-bfa9-c836fc843b9b; Mon, 2 Sep 2024 06:15:38 +0000 (UTC)
X-Farcaster-Flow-ID: f0cf710c-b7a4-4e55-bfa9-c836fc843b9b
Received: from EX19D005ANA004.ant.amazon.com (10.37.240.178) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 2 Sep 2024 06:15:37 +0000
Received: from 682f678c4465.ant.amazon.com (10.37.244.7) by
 EX19D005ANA004.ant.amazon.com (10.37.240.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 2 Sep 2024 06:15:33 +0000
From: Takamitsu Iwai <takamitz@amazon.co.jp>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>
CC: Takamitsu Iwai <takamitz@amazon.co.jp>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>
Subject: [PATCH v1 net-next] e1000e: Remove duplicated writel() in e1000_configure_tx/rx()
Date: Mon, 2 Sep 2024 15:14:54 +0900
Message-ID: <20240902061454.85744-1-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
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

Signed-off-by: Takamitsu Iwai <takamitz@amazon.co.jp>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 360ee26557f7..cf352befaeb9 100644
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
2.39.3 (Apple Git-145)


