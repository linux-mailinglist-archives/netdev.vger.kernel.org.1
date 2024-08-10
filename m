Return-Path: <netdev+bounces-117328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A074494D963
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 02:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358161F222DE
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 00:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1C101C4;
	Sat, 10 Aug 2024 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="em7NVESY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390E5DF53;
	Sat, 10 Aug 2024 00:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723249414; cv=none; b=Ksft/Rkdjmhp+ep21NM7022PYV4faYg/E/o6hWeNBSFamp262pIuFiNgHjTfOK+HQpxVZNhQ3ZaV1Hv6GmrRLQ7Z/9509RjvRWVzGe0NyeeRLJnMFoiH22Ojpr9q9ILs0XRi2jE1qCqSN8aaQfpJmX6Y8yo4qjhtlbyG7DhEgBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723249414; c=relaxed/simple;
	bh=gg/rzxEcE/ehEA57zkHvot1+t3aUc/Rg58im3h2dnrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=puVGkjEL2pMa5O5uAYFf6FYa9PL93vz1CMp709xt8e/tLQrkCNn1EgbMsoHWcXOSy4d4Or9Ez7SkkIK+lhSNQUzWbGtPPEJamZDp7I/AqBg9N3woDMaq0GFcRObLxGjK5M2bX4oOKB4y6ewMSzkke0zhsVBxxDb7HSRHfMznh6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=em7NVESY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723249412; x=1754785412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gg/rzxEcE/ehEA57zkHvot1+t3aUc/Rg58im3h2dnrw=;
  b=em7NVESYrsdkQ26h9EOMyU0DuWII1kQTPWjRpLzxeoJbH+BwJdXLnI0T
   Fa+zlWAjNy3DfQcsAQNpg4lUJETXEQaR+zSc3WHOBkRaQVE0ILOO/E1XH
   VX0qVl8RT+BuC+1lNKK3DX0dmg3EXq5+RaBym/wk5m8ZWo/c8JRywXScL
   7bcmLhZjQ/fGpVyMPIlEc7lOC0/kG02yL8k5hLzqhW7HMQcfG8A5Q0r6q
   VR1MRMuMNKM093tXxOIPCdrDHMJTGhYIHS27ngtudK7jFcOtG5bPvnkax
   XBwvxrkW8hbvIOw39h0AY3aDQMm6nXqwJLfqF4vHQuHI+AzWtb2FHxRea
   Q==;
X-CSE-ConnectionGUID: jKKKI3hNS5KuVPyn67siPw==
X-CSE-MsgGUID: f761vCkVQh2IhOpA80zAaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21415452"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="21415452"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 17:23:30 -0700
X-CSE-ConnectionGUID: hALeNo2MS9y6BvYa6G1oUw==
X-CSE-MsgGUID: QsjymVP3RR2lopvpXQjOwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="57383188"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO vcostago-mobl3.lan) ([10.124.221.140])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 17:23:30 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: daiweili@gmail.com,
	sasha.neftin@intel.com,
	richardcochran@gmail.com,
	kurt@linutronix.de,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v1] igb: Fix not clearing TimeSync interrupts for 82580
Date: Fri,  9 Aug 2024 17:23:02 -0700
Message-ID: <20240810002302.2054816-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was reported that 82580 NICs have a hardware bug that makes it
necessary to write into the TSICR (TimeSync Interrupt Cause) register
to clear it.

Add a conditional so only for 82580 we write into the TSICR register,
so we don't risk losing events for other models.

This (partially) reverts commit ee14cc9ea19b ("igb: Fix missing time sync events").

Fixes: ee14cc9ea19b ("igb: Fix missing time sync events")
Reported-by: Daiwei Li <daiweili@gmail.com>
Closes: https://lore.kernel.org/intel-wired-lan/CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com/
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---

@Daiwei Li, I don't have a 82580 handy, please confirm that the patch
fixes the issue you are having.

 drivers/net/ethernet/intel/igb/igb_main.c | 27 ++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 11be39f435f3..edb34f67ae03 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6960,31 +6960,48 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 static void igb_tsync_interrupt(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
-	u32 tsicr = rd32(E1000_TSICR);
+	u32 ack = 0, tsicr = rd32(E1000_TSICR);
 	struct ptp_clock_event event;
 
 	if (tsicr & TSINTR_SYS_WRAP) {
 		event.type = PTP_CLOCK_PPS;
 		if (adapter->ptp_caps.pps)
 			ptp_clock_event(adapter->ptp_clock, &event);
+		ack |= TSINTR_SYS_WRAP;
 	}
 
 	if (tsicr & E1000_TSICR_TXTS) {
 		/* retrieve hardware timestamp */
 		schedule_work(&adapter->ptp_tx_work);
+		ack |= E1000_TSICR_TXTS;
 	}
 
-	if (tsicr & TSINTR_TT0)
+	if (tsicr & TSINTR_TT0) {
 		igb_perout(adapter, 0);
+		ack |= TSINTR_TT0;
+	}
 
-	if (tsicr & TSINTR_TT1)
+	if (tsicr & TSINTR_TT1) {
 		igb_perout(adapter, 1);
+		ack |= TSINTR_TT1;
+	}
 
-	if (tsicr & TSINTR_AUTT0)
+	if (tsicr & TSINTR_AUTT0) {
 		igb_extts(adapter, 0);
+		ack |= TSINTR_AUTT0;
+	}
 
-	if (tsicr & TSINTR_AUTT1)
+	if (tsicr & TSINTR_AUTT1) {
 		igb_extts(adapter, 1);
+		ack |= TSINTR_AUTT1;
+	}
+
+	if (hw->mac.type == e1000_82580) {
+		/* 82580 has a hardware bug that requires a explicit
+		 * write to clear the TimeSync interrupt cause.
+		 */
+		wr32(E1000_TSICR, ack);
+	}
 }
 
 static irqreturn_t igb_msix_other(int irq, void *data)
-- 
2.45.2


