Return-Path: <netdev+bounces-181783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F5BA86780
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAB71B8203A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E129CB28;
	Fri, 11 Apr 2025 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nj7K/Yf1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E329B226
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404256; cv=none; b=Jqqv76e3mLmLO6+eWemxzveG5vbmp+MLDbM3MiD+Att8SZ3CCMy9jHXBnDmwIdc+FuLRUfSowP3XAjs0dV4KMppPrUQY/mLhavjUiWMwG5wyx4zcy7RXSeSq8FB76NS8A2fbhrlu4SeFu1/Q8cl2npDPvQfbzDU80F49Z0Qg4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404256; c=relaxed/simple;
	bh=txZwzmaoyvvpQhVrPD8qVuIBiOGaPxHqolod6NEpn1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLDB8BwZnt5yU638xl4q1Rm7nHJXM8Ux9ObtRs3kAIgyHFlGV0ORlV9OHvTJdHXxP8qxxMmqUuE8FvW2Qt53jzO0vyrYerj1NQw/8EJINi9onR9YCaFA5ZdzB2q+8jX4JXf4hxlNlJ9U0xF+o3DY+xxCMTpdBygVs72YLN2YXtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nj7K/Yf1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744404255; x=1775940255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=txZwzmaoyvvpQhVrPD8qVuIBiOGaPxHqolod6NEpn1o=;
  b=nj7K/Yf1rAl4oAZRc+0wg9C2Mdz+T+gymtvjaBV/GWf4/bx03tECsOFF
   BSw0KZaaRzjWItvVpRpf5wYHNvRwNMMp81lMTapxvVP83H45PzjZ1fvnF
   fvPO3kocJah0c9szoNgK6YU0NqRiCXZSQkjMaY9+yOWbt/sRkBId7Xeyg
   wiCnKKzwZy3n9c3Uj96TADe44TcuReD/fkEaueXXCzr8f5Doc7xuz/UZZ
   m3nFMffNNTPQj1z0maJ7ObM7p+vr7CFGYPC2vTQFDZLVYU+ubSqOpgcYc
   f9VMDfFoTgKszHYUqYO4mGn9bShws/Oqj8xUgI1h34DduePTx/bvAuf7X
   g==;
X-CSE-ConnectionGUID: WC2ReF2cQHyjatfYbBYuNQ==
X-CSE-MsgGUID: 4XqPDBWjSS+wxuJGyxsHOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45103915"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45103915"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:44:08 -0700
X-CSE-ConnectionGUID: RJ3P0NYcQG+spvVh24Wopw==
X-CSE-MsgGUID: 7kJYigXASGKpW6N0Xg0IWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129241829"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 11 Apr 2025 13:44:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kyungwook Boo <bookyungwook@gmail.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 12/15] i40e: fix MMIO write access to an invalid page in i40e_clear_hw
Date: Fri, 11 Apr 2025 13:43:53 -0700
Message-ID: <20250411204401.3271306-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
References: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyungwook Boo <bookyungwook@gmail.com>

When the device sends a specific input, an integer underflow can occur, leading
to MMIO write access to an invalid page.

Prevent the integer underflow by changing the type of related variables.

Signed-off-by: Kyungwook Boo <bookyungwook@gmail.com>
Link: https://lore.kernel.org/lkml/ffc91764-1142-4ba2-91b6-8c773f6f7095@gmail.com/T/
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 370b4bddee44..b11c35e307ca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -817,10 +817,11 @@ int i40e_pf_reset(struct i40e_hw *hw)
 void i40e_clear_hw(struct i40e_hw *hw)
 {
 	u32 num_queues, base_queue;
-	u32 num_pf_int;
-	u32 num_vf_int;
+	s32 num_pf_int;
+	s32 num_vf_int;
 	u32 num_vfs;
-	u32 i, j;
+	s32 i;
+	u32 j;
 	u32 val;
 	u32 eol = 0x7ff;
 
-- 
2.47.1


