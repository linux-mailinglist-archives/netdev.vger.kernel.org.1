Return-Path: <netdev+bounces-241437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA5C8401E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485793AFE8A
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5060E2FF150;
	Tue, 25 Nov 2025 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRxf9QBb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1C2FE07F;
	Tue, 25 Nov 2025 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059708; cv=none; b=d/EgYsCUsQ2jwrlQhkDjZqe0Fmjyjy7HpA4DN2d6p+Cm2GXO7hyjamWaZF3g9t+KGNkhqNsNlrFdPUEAba1DkE9fw52+dFWvD/q30leC9b1WhGT4Y0s1JBirMu9S/AlrcEXd6wCBiJrYrnqbEZ64g+3KWqCIw9MYFzPKb6TskpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059708; c=relaxed/simple;
	bh=xUpDawPFLzKaHHNYiJdKNStCKkCfTxKkZDCKX4yXwnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNONz6ZUvaYkIa85pBO1yXO0G3/W2KfPWQzZr5hPRNeb6ZcgsVGXjzSnc0/epJudIv/SpsrZ3i/dLF36CRrrdFNgbSZDQWO7LIjxPTXT/IAWdyHjw9SnABnSByTYEQqkvtiRkbnS06el3wGdaJEnWipRPkJfQNiwBp4Q7Lq2fi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRxf9QBb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764059706; x=1795595706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xUpDawPFLzKaHHNYiJdKNStCKkCfTxKkZDCKX4yXwnA=;
  b=PRxf9QBbUgq/Gd6DMBpeiiSeYramYnyPr9quU3r6L1uLnf8suPBY0lEv
   lx/loZABLSbG1m/Vw/+mo0hbOmGtM3Wq+LsOvEC2TvLIIZMfbMsZzlW9U
   Sfs4EjEvkhCL2+x4LYkQARKIL0sxN6Ciw4JMHVDIDgVFZhptEYx7LCwDx
   2gi/cFnWIAY2B2jMprFzJnxTBu3/Bx5Vegr+XrdsK7x9ccWD57zYtdaeK
   4BS5uAL5nNztIRFN8WQawXvi5ZvHSqvFZ0oehgL36CefpDGfetjLWhjF5
   J1R+OOMS9ennTOqG+djGt0tQna2DQkk/jXL5c0P6n90saMHWqtEPE4aww
   g==;
X-CSE-ConnectionGUID: fQ3RiYovSAq9VzQrqoHmHw==
X-CSE-MsgGUID: X/ZxKYkjSTK8aczCZPgw1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="76694443"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="76694443"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 00:35:06 -0800
X-CSE-ConnectionGUID: XUgbbGsWTuqMLHvT5UsbZw==
X-CSE-MsgGUID: Gy/QTL77R6CVUSZnlQnqHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="196749828"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2025 00:35:05 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v2 3/8] ice: do not check for zero mac when creating mac filters
Date: Tue, 25 Nov 2025 09:34:51 +0100
Message-ID: <20251125083456.28822-4-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125083456.28822-1-jakub.slepecki@intel.com>
References: <20251125083456.28822-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

A zero MAC address was considered a special case while creating a new
MAC filter.  There is no particular reason for that other than the fact
that the union containing it was assumed to be zeroed out.  Now, address
is pulled out of the union by ice_fltr_mac_address which checks all of
the previously assumed zero-address cases and returns an error if they
are hit.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>

---
No changes in v2.
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 0275e2910c6b..04e5d653efce 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3648,7 +3648,7 @@ int ice_add_mac(struct ice_hw *hw, struct list_head *m_list)
 		u16 hw_vsi_id;
 
 		err = ice_fltr_mac_address(addr, &m_list_itr->fltr_info);
-		if (err || is_zero_ether_addr(addr))
+		if (err)
 			return -EINVAL;
 		m_list_itr->fltr_info.flag = ICE_FLTR_TX;
 		vsi_handle = m_list_itr->fltr_info.vsi_handle;
-- 
2.43.0


