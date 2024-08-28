Return-Path: <netdev+bounces-122973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B4B963511
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4CD1F24AD3
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB9D1AD9E2;
	Wed, 28 Aug 2024 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wen/oEFr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63321AB51F
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885693; cv=none; b=Oa3OIM1NANrHQoNqz/RDH7chPPnVu1PpL6YxisBHERsea6ECdH2n1Cz5SkQeMdzb2uED8JeKc0pUHbJRonQAlNLoSKHQ9OdotfGKqV+IpgsOHhiKT4CETe1w7chwp4ujeV/ZegQg104IFFCnJ0bF5nglqWz3e2vqTuZNKr/Ow4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885693; c=relaxed/simple;
	bh=v011Rq7J3nzGMn2HaEtQilllAQFzR0lZbL3gIU1/6q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCoAwQTYwTkBU1H5LDUfsOzg99hku1lBwSIp4llJbJfBCpdidrALJgu/tiBYY46E5tK5W/3QChFZi4B4ASMcGuGMgkHCfD43z2vR4yVUy501/PQ1cBnH/L/c/gmzpMqJVH8kDtutzeFEKnESjrTd+xlHdcqHd5OdA9UgbcRKhT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wen/oEFr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724885692; x=1756421692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v011Rq7J3nzGMn2HaEtQilllAQFzR0lZbL3gIU1/6q0=;
  b=Wen/oEFr7quIh33qai5gHctZgTdB26mMrNuBwkxwwFgCtDqXGNDD6MIK
   N6OpcKuwSpz92k0V+RJ3gJpIhD6nKy8RitKvYUfXFRPH3K5tCsxKTNOes
   IWHODJAsLlWOR3MPb9AmrLXkWHo7J66pS8QyT/tIR6Mr2f2RuWobpPoX1
   T4bua2Hsvcq66+oetyYSS1jepXNXGd8++Ji5/x9ABT0QRWVg3UuZOnV4+
   k11qN4G2O0h0qXzv46vH6VCCjumVco11mRqVZWsWdXELBuAc9bcp1wPQ0
   jyc9y0+XVCYs03hDH0/oPV5HQUCIx4Pwano+9d4qCCvFWdMc5Il9+gf0b
   g==;
X-CSE-ConnectionGUID: FjziRUm5QQWB2LyqNDXnBw==
X-CSE-MsgGUID: ckKsIIIXST6kNjJ7kQpLTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23408512"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23408512"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:54:49 -0700
X-CSE-ConnectionGUID: F3SMv3kxRGyVvMFD4bHSKg==
X-CSE-MsgGUID: PN+ZSi/CS5qBNmwJmzsCoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63022900"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 28 Aug 2024 15:54:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Daiwei Li <daiweili@google.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 1/2] igb: Fix not clearing TimeSync interrupts for 82580
Date: Wed, 28 Aug 2024 15:54:41 -0700
Message-ID: <20240828225444.645154-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240828225444.645154-1-anthony.l.nguyen@intel.com>
References: <20240828225444.645154-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daiwei Li <daiweili@google.com>

82580 NICs have a hardware bug that makes it
necessary to write into the TSICR (TimeSync Interrupt Cause) register
to clear it:
https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@intel.com/

Add a conditional so only for 82580 we write into the TSICR register,
so we don't risk losing events for other models.

Without this change, when running ptp4l with an Intel 82580 card,
I get the following output:

> timed out while polling for tx timestamp increasing tx_timestamp_timeout or
> increasing kworker priority may correct this issue, but a driver bug likely
> causes it

This goes away with this change.

This (partially) reverts commit ee14cc9ea19b ("igb: Fix missing time sync events").

Fixes: ee14cc9ea19b ("igb: Fix missing time sync events")
Closes: https://lore.kernel.org/intel-wired-lan/CAN0jFd1kO0MMtOh8N2Ztxn6f7vvDKp2h507sMryobkBKe=xk=w@mail.gmail.com/
Tested-by: Daiwei Li <daiweili@google.com>
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Daiwei Li <daiweili@google.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 33a42b4c21e0..9dc7c60838ed 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6960,10 +6960,20 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 
 static void igb_tsync_interrupt(struct igb_adapter *adapter)
 {
+	const u32 mask = (TSINTR_SYS_WRAP | E1000_TSICR_TXTS |
+			  TSINTR_TT0 | TSINTR_TT1 |
+			  TSINTR_AUTT0 | TSINTR_AUTT1);
 	struct e1000_hw *hw = &adapter->hw;
 	u32 tsicr = rd32(E1000_TSICR);
 	struct ptp_clock_event event;
 
+	if (hw->mac.type == e1000_82580) {
+		/* 82580 has a hardware bug that requires an explicit
+		 * write to clear the TimeSync interrupt cause.
+		 */
+		wr32(E1000_TSICR, tsicr & mask);
+	}
+
 	if (tsicr & TSINTR_SYS_WRAP) {
 		event.type = PTP_CLOCK_PPS;
 		if (adapter->ptp_caps.pps)
-- 
2.42.0


