Return-Path: <netdev+bounces-149045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072CB9E3D90
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC17E280D1D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8385720B1E0;
	Wed,  4 Dec 2024 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WV0AXjzA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4696433C4
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324571; cv=none; b=cmK9kLMghaGEf9IAAYCefBMpTQ5DoXmjSTckpSvqs5+YGrMvI5q3yCACRi+2NrJ0/iN/wPAko0GeQldm8t6sBAFq2wYA+rOERqOpFFNQgJjbT4a8q1mfZOtFzefyG2HYadNV7MaMgtSJVbNJeK75bxSPi456WbNACIWV1ixgLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324571; c=relaxed/simple;
	bh=En4Y/eXJHek4wbV9HkyLZxuRmozrYukh92bXSpkWI1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YI9cDGA2qS9iYLKn2U7qOva+0Fzy+PuaOuHUysDt0wEds2hUPvouGayqcS75FNTEXbS1mhQHkrA5zvEuyDjnfX5XFGaldz7rVWWDcx/aydtYpqt7JLuk7nq+l9xrOKP4WUuDj/1QmtFHehOB8NgXPlroJZ7WqR2IjEDtUw4pZdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WV0AXjzA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733324570; x=1764860570;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=En4Y/eXJHek4wbV9HkyLZxuRmozrYukh92bXSpkWI1Q=;
  b=WV0AXjzA8AbQrG3IXvuLbyzHf/Fd06JepkunVT4JqRLg15JhpkC0fWtk
   caEEacsBIfRZb8aKc+dxTh0OSez65scENIma2rE50xKJUi+9Q5G/PUuCd
   0Nb0UZpvoGc97/8NzDtsBObW4biFSTEOEkUNFonOXAGg4aj9GWgRk/oQp
   apOp7rCielddn6A94v10G0ppNO1iExo3shWyVRq0CgkP6ulHHfObzbLmw
   CM9IL42oYfipgiMec8NhxWBGMPYlBIncQjR0CYe+h6+WdsX3Guo46eZgr
   2fi0qF2g+axF0WmTjs7AG7/LCNVX0y/S5ahifUZEvP+cLMVohYn8PDRhk
   g==;
X-CSE-ConnectionGUID: p5LMH7TMQzy0apmAtHfZIg==
X-CSE-MsgGUID: J/bK6haWTKG+3VCNzKCyJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33744989"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="33744989"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 07:02:49 -0800
X-CSE-ConnectionGUID: 49Oq1a6dQ4SC7Fuo0L+eSw==
X-CSE-MsgGUID: Xh+pDiX4RuClpW/yC/3wwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="117037570"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 04 Dec 2024 07:02:40 -0800
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 96D8E32C80;
	Wed,  4 Dec 2024 15:02:39 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-net v1] ice: move static_assert to declaration section
Date: Wed,  4 Dec 2024 16:02:24 +0100
Message-Id: <20241204150224.346606-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

static_assert() needs to be placed in the declaration section,
so move it there in ice_cfg_tx_topo() function.

Current code causes following warnings on some gcc versions:
error: ISO C90 forbids mixed declarations and code
[-Werror=declaration-after-statement]

Fixes: c188afdc3611 ("ice: fix memleak in ice_init_tx_topology()")
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 69d5b1a28491..e885f84520ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -2388,6 +2388,8 @@ int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
 	int status;
 	u8 flags;
 
+	static_assert(ICE_PKG_BUF_SIZE == ICE_AQ_MAX_BUF_LEN);
+
 	if (!buf || !len)
 		return -EINVAL;
 
@@ -2482,7 +2484,6 @@ int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
 	}
 
 	/* Get the new topology buffer, reuse current topo copy mem */
-	static_assert(ICE_PKG_BUF_SIZE == ICE_AQ_MAX_BUF_LEN);
 	new_topo = topo;
 	memcpy(new_topo, (u8 *)section + offset, size);
 
-- 
2.38.1


