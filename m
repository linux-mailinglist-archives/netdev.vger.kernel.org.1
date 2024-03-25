Return-Path: <netdev+bounces-81757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A958088B0E0
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1881C3F631
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C1F46430;
	Mon, 25 Mar 2024 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYsqNnxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB046444
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397231; cv=none; b=alJXRfL3uskE+SFTKNaRl6jqyiniWhsQOixTC1mQIvrKq13Fy6HMlsq7sFypfz+cDt4/8XGL2cNk3bxnOG4mK4jfDNa4qguW5IP0RRusnsLBuQyWrEPER4Zo6DU0HqVLzU93zsVS1c7RIbmL51bJbc6uF1YZ7FdaLcPGILLwtxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397231; c=relaxed/simple;
	bh=7mdEEhGhs9FkjBQ7nEZvaUHWMyUw67/IaXf1QetROdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGvKsg5gZelPCC39W63SNxsq4FaLxLzTgtgDDhRjVYdVOvrB9UN0/dVb5sKz8pgqYGFNkkwdGBY4jwNgIeQ1ny6p2LuLlftydzkPesknAVCY4dnkyyILtkMSUO4UeCREJ26J3wjlHMwi9tMH3+sQX523rJO7Wn8UOqrNMcSh3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYsqNnxZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711397230; x=1742933230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7mdEEhGhs9FkjBQ7nEZvaUHWMyUw67/IaXf1QetROdw=;
  b=cYsqNnxZs2OcEa4gdJlgoRNm9q28dNJeIYa1iZvwNWpKEDiyNRKpxfPk
   zzD5dnhj10zmaQT3FV8L7C7YzRPVQPkpl6UfWIJlePyyvlQqg1pCklI1B
   Ge01RaTdICHkscWEWbYtrRZMo1U1+3HprNH97+iCx93TesSX2yRr5+YA9
   xDAubt0F3R8Q5V7xqZ3BT2rpBWq00B7zKElGriNvwUnMxlP6C6nYjWCJz
   9XA1H46BLfy1FtTchPa9BFWKUoHOCYxysTlbAo/ToJIjFHFJlkEGWwL2I
   H3CP/PCP7oY8/A8IDxb3oCt6QUgjnGcVg8vIR76SRh5zB19KyWD/GXzGT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17855113"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="17855113"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 13:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20459302"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 25 Mar 2024 13:07:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	anthony.l.nguyen@intel.com,
	vladimir.oltean@nxp.com,
	bigeasy@linutronix.de,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 4/4] igc: Remove stale comment about Tx timestamping
Date: Mon, 25 Mar 2024 13:06:48 -0700
Message-ID: <20240325200659.993749-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325200659.993749-1-anthony.l.nguyen@intel.com>
References: <20240325200659.993749-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kurt Kanzenbach <kurt@linutronix.de>

The initial igc Tx timestamping implementation used only one register for
retrieving Tx timestamps. Commit 3ed247e78911 ("igc: Add support for
multiple in-flight TX timestamps") added support for utilizing all four of
them e.g., for multiple domain support. Remove the stale comment/FIXME.

Fixes: 3ed247e78911 ("igc: Add support for multiple in-flight TX timestamps")
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2e1cfbd82f4f..35ad40a803cb 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1642,10 +1642,6 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 
 	if (unlikely(test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags) &&
 		     skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
-		/* FIXME: add support for retrieving timestamps from
-		 * the other timer registers before skipping the
-		 * timestamping request.
-		 */
 		unsigned long flags;
 		u32 tstamp_flags;
 
-- 
2.41.0


