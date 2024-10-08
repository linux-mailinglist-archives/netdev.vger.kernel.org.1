Return-Path: <netdev+bounces-133369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864FF995BC4
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80BA1C21921
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C482219494;
	Tue,  8 Oct 2024 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cvzh42x2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACEE2194B8
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430498; cv=none; b=qduEIniTfBAmVqRv9o3jhr2wovAP1xv/jc2kn6fZUNCFlC+JnH8XDZH4zN9gL8m6yGRLnG7wd7FWEp82XT3PY7bZwepRlq1hWdy4NFTaH85uPAFYvpkgr5G3eKyoA1zX9ppb8WkPBdetJDFxr/t5z5zjwY+FUM3cHGRaO0NhzqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430498; c=relaxed/simple;
	bh=0pLD0W2uiRVaynJVwkI2CACBXZFRwjX6N9xtOcV5yqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibwDWA4dClVjPJrT/nksb02nUX19QB23jJXlDjbMBmUdok9pOlf/gtKIpyLRNl1HipJAijnRFwCVowDxamRfgTHL1dXUyHtH6tg6OSlQrqutOOO2pYZoBqvubiEv5xHMARGJrWHKhArBtXLRGvWYim3aQREcp1BbEu2bWzKQfg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cvzh42x2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728430497; x=1759966497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0pLD0W2uiRVaynJVwkI2CACBXZFRwjX6N9xtOcV5yqk=;
  b=Cvzh42x2qFH6ULhoGblkmpC7SIZflMhSoNmKBxZlU7Mth1fQrii1lx+2
   CNCrW2ghzWFVJ2wt0z/2Qnil4w4BAfxW54I+hqqDU7Iv9uUnNJ0ELcCEc
   jPPCp2qHDrWA4kA7h/1+B0cBZPeXS5voCkD3uu4OT68maopIheWzF7ZR1
   Q4f2mb78fawEWfvm+aXUteK+EoSn5LCmPy6KlM+YRWBAQL9bFpufStW50
   JpxRiJ9w4NuWciHows06txzB1C9xB31rEthms0wX8X6Xr4Xey7PcKsMid
   pd1yxIM76HaiT2FUJ9Qn894tX8cDI7a5JCOjdcgIUHM0IUbJTCb4ltCBg
   g==;
X-CSE-ConnectionGUID: XR4uAC9mRbOzXC+ZnAXjvg==
X-CSE-MsgGUID: reqk7UaQRAGaSSqmIcOJcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27779919"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27779919"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:34:50 -0700
X-CSE-ConnectionGUID: /BbD8l2LTZ2bv38DHuaOrQ==
X-CSE-MsgGUID: DpEoax27QRCewWuYZ1iDzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106794208"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:34:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Takamitsu Iwai <takamitz@amazon.co.jp>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	andrew@lunn.ch,
	Kohei Enju <enjuk@amazon.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 10/12] e1000e: Remove duplicated writel() in e1000_configure_tx/rx()
Date: Tue,  8 Oct 2024 16:34:36 -0700
Message-ID: <20241008233441.928802-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
References: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takamitsu Iwai <takamitz@amazon.co.jp>

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
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index f103249b12fa..9c9d4cb7c735 100644
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
2.42.0


