Return-Path: <netdev+bounces-241688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8642AC875A5
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E028A3A6F1F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FF233CE91;
	Tue, 25 Nov 2025 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ew8/y06W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91FA33C194
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110204; cv=none; b=F25y5F9Sd8cjpYpE9uQnrnXuUGSOIRtYedet5UcRrW+cM7UXrWr7EbwCkZi6cGe4Ex+Hh1Y3CWd+FJCr4nX3CmSSkEG0G1jQccfiQXAqz/yTpkpMp31CxBHAZjMxlxm2uEFomJmLgCfMPJg6Af+MixpwW6Nbh4J6T5yGN2Jv+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110204; c=relaxed/simple;
	bh=Wu0ZewOkXcT63Rb+LsFN/zHZYowvHiWVmqoX2VEhf0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLpQL/RAQP+09/iiVfZRh8rvkiuffJ5m/MPUuiGKCq1k6UQF/Jr/ujIiXTIqv/30T8us/YDw/5xK7bvIJUd01cILXbKR5pbrm+VwKoKy+uwxJIvyza/1MWTGEO+7pXb63Y1uKxwdZJ2/1fPkRzhbssHgQMWAbKqkuX0DZcgvoco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ew8/y06W; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764110203; x=1795646203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wu0ZewOkXcT63Rb+LsFN/zHZYowvHiWVmqoX2VEhf0w=;
  b=ew8/y06WMgOCxkBLWA68DkvF/0SEBXk40ju1FjYxh3bZvruzeSD9JL5e
   nZcYn7Ec3ejv7bCYFFzRqC81yiLXYM1DmK98fDz8Ht5mHZowljw4AAipr
   6+nmC1gYYqekWWUroBy1LrSAsdoAzNY68Na19tph/Aa3A9rhQe2LiaIkC
   5Yw6mlxLTuh9GrzZpMv7OK/A0gnxGtJAHUHPjj1hj1TpMjEFij0DMOCMl
   eLHV7OllQ2ARBH73thPWepGvbSWTL6aZLU3n++6aekrVFkmOcoClg5o3A
   avZlrFFdo3BuK7rn3vu9TrRY+Wy0aa33VpicPBeJCX1vy9L6gqo69L+w0
   A==;
X-CSE-ConnectionGUID: 5fsyoTw5R3a1LxH+PXmWoQ==
X-CSE-MsgGUID: D+sn1bwJTfa0SR+/bO7jww==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="68729912"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="68729912"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 14:36:42 -0800
X-CSE-ConnectionGUID: kbkFAS3YQsmdlXzZsxo4Mg==
X-CSE-MsgGUID: PZ43PF0dTZaLPW/HhFRM3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="193209567"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 25 Nov 2025 14:36:41 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	anthony.l.nguyen@intel.com,
	alok.a.tiwarilinux@gmail.com,
	aleksander.lobakin@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 08/11] idpf: use desc_ring when checking completion queue DMA allocation
Date: Tue, 25 Nov 2025 14:36:27 -0800
Message-ID: <20251125223632.1857532-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alok Tiwari <alok.a.tiwari@oracle.com>

idpf_compl_queue uses a union for comp, comp_4b, and desc_ring. The
release path should check complq->desc_ring to determine whether the DMA
descriptor ring is allocated. The current check against comp works but is
leftover from a previous commit and is misleading in this context.

Switching the check to desc_ring improves readability and more directly
reflects the intended meaning, since desc_ring is the field representing
the allocated DMA-backed descriptor ring.

No functional change.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 1993a3b0da59..e2b6b9e26102 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -134,7 +134,7 @@ static void idpf_compl_desc_rel(struct idpf_compl_queue *complq)
 {
 	idpf_xsk_clear_queue(complq, VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION);
 
-	if (!complq->comp)
+	if (!complq->desc_ring)
 		return;
 
 	dma_free_coherent(complq->netdev->dev.parent, complq->size,
-- 
2.47.1


